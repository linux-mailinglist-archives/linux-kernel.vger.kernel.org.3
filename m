Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636FC597ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242523AbiHRBKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbiHRBKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:10:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC4910B6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:10:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9080613FB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C8AC433C1;
        Thu, 18 Aug 2022 01:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660785048;
        bh=6KB9tpgcTIxFqPnh9VXpBIlNNMq96ADAauAYX3Ha3Ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BS8wPT+sFWVJrBo5vMWAQbbo9jn7ON0xwnvOD6fRye4Xticdh399W0jaQLTI2MZxE
         SuGcVFLVWVp8Bug9uKqnSNtkIeNVVSRIApS3SHykAs6ENdqNjIxT6FBfVR9+70mJDD
         z2x0AJryZnaOV3x+wADld0Bzbpx2ZnY4d32S9NNwbUblzs9loLArlvlmUyKOtoWP8c
         XNAew8W9wh4JlIXQcXUJTtgAY2WkX/LwPpaGNxEjh1xYcFo11Qz2iKIfIx10WZABvW
         X+APd44jqLv05/Rgd+DJNTMjUBJNKPniVtnD45Rdia0duRfkg2oTGPQP71hzg+6gI5
         GG/osR90KWpcQ==
Date:   Wed, 17 Aug 2022 18:10:45 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Su, Heng" <heng.su@intel.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, pbonzini@redhat.com,
        x86@kernel.org
Subject: Re: [PATCH] x86/kvm, objtool: Avoid fastop ENDBR from being sealed
Message-ID: <20220818011045.v4baekgxajylqxvh@treble>
References: <PH0PR11MB4839B4D2FB8B8D8D52A62C7F9A629@PH0PR11MB4839.namprd11.prod.outlook.com>
 <YvzJTxOwmikAlZ6j@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvzJTxOwmikAlZ6j@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:56:15PM +0200, Peter Zijlstra wrote:
> Add (yet another) annotation to inhibit objtool from sealing a specific
> ENDBR instance.

Nah, just add a throwaway reference to the function.  Then no objtool
change is needed:

diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 689880eca9ba..3ae795150374 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -31,6 +31,16 @@
 
 #define __noendbr	__attribute__((nocf_check))
 
+/*
+ * Create a dummy function pointer reference to prevent objtool from marking
+ * the function as needing to be "sealed" (i.e. ENDBR converted to NOP by
+ * apply_ibt_endbr()).
+ */
+#define IBT_NOSEAL(fname)				\
+	".pushsection .discard.endbr.noseal\n\t"	\
+	_ASM_PTR fname "\n\t"				\
+	".popsection\n\t"
+
 static inline __attribute_const__ u32 gen_endbr(void)
 {
 	u32 endbr;
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index f8382abe22ff..88623add0db4 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -316,7 +316,8 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	".align " __stringify(FASTOP_SIZE) " \n\t" \
 	".type " name ", @function \n\t" \
 	name ":\n\t" \
-	ASM_ENDBR
+	ASM_ENDBR \
+	IBT_NOSEAL(name)
 
 #define FOP_FUNC(name) \
 	__FOP_FUNC(#name)
