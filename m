Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C721F4CFE12
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbiCGMVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiCGMVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:21:20 -0500
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AAC8020C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:20:25 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hao.xiang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V6VlVhH_1646655619;
Received: from 30.43.105.113(mailfrom:hao.xiang@linux.alibaba.com fp:SMTPD_---0V6VlVhH_1646655619)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 20:20:20 +0800
Message-ID: <98d5a389-6856-0cec-b730-65f609ff15db@linux.alibaba.com>
Date:   Mon, 7 Mar 2022 20:20:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
To:     chang.seok.bae@intel.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        ravi.v.shankar@intel.com, tglx@linutronix.de, x86@kernel.org,
        yang.zhong@intel.com
References: <20220129173647.27981-2-chang.seok.bae@intel.com>
Subject: Re: [PATCH v4 1/2] x86/arch_prctl: Fix the ARCH_REQ_XCOMP_PERM
 implementation
Content-Language: en-US
From:   Hao Xiang <hao.xiang@linux.alibaba.com>
In-Reply-To: <20220129173647.27981-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86/arch_prctl: Fix the ARCH_REQ_XCOMP_PERM implementation

If WRITE_ONCE(perm->__state_perm, requested) is modified to
WRITE_ONCE(perm->__state_perm, mask), When the qemu process does not 
request the XFEATURE_MASK_XTILE_DATA xsave state permission, there may 
be a gp error (kvm: kvm_set_xcr line 1091 inject gp fault with cpl 0) 
because __kvm_set_xcr return 1.

static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr){
     ...
     // xcr0 includes XFEATURE_MASK_XTILE_CFG by default.
     if ((xcr0 & XFEATURE_MASK_XTILE) &&
         ((xcr0 & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE))
         return 1;
     ...
}

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 02b3dda..2d4363e 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1636,7 +1636,7 @@ static int __xstate_request_perm(u64 permitted, 
u64 requested, bool guest)

         perm = guest ? &fpu->guest_perm : &fpu->perm;
         /* Pairs with the READ_ONCE() in xstate_get_group_perm() */
-       WRITE_ONCE(perm->__state_perm, requested);
+       WRITE_ONCE(perm->__state_perm, mask);
         /* Protected by sighand lock */
         perm->__state_size = ksize;
         perm->__user_state_size = usize;
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 494d4d3..e8704568 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -908,6 +908,9 @@ static inline int __do_cpuid_func(struct 
kvm_cpuid_array *array, u32 function)
                 break;
         case 0xd: {
                 u64 permitted_xcr0 = supported_xcr0 & 
xstate_get_guest_group_perm();
+               permitted_xcr0 = ((permitted_xcr0 & 
XFEATURES_MASK_XTILE) != XFEATURES_MASK_XTILE)
+                               ? permitted_xcr0
+                               : permitted_xcr0 & ~XFEATURES_MASK_XTILE;
                 u64 permitted_xss = supported_xss;

                 entry->eax &= permitted_xcr0;

