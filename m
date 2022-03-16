Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000064DB857
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 20:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356983AbiCPTE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 15:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242117AbiCPTE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:04:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C15A1A398
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647457391; x=1678993391;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=uiI1BdGIvJQqFFC4nmqbwOsYrAoCLeSI1o2aaUGmriU=;
  b=THV2EdilG1hfbAAAAR+ATODepp+uP+zxZSxzYvfjI0rM/dFxgI91LhNu
   Q7H33GavRrowjYNEddOPmKyS66sgP90B/9R284vbj8iI6jvI6nepQfl/J
   cSoE3liSSZT+0lfUUF99bVeKg1z0wwtGE3APXNMMFUYiLk+9UIAaL+qaM
   rZeddYnBbXfb5zcePe5jiyvr3HDXyKBde7O6H0rBXjpE2U/tGdvvP2eYR
   62xnSUb06vOKsm42o3+s3Ebq2wZay35eaomanghDDXRKktcImKFH9X57b
   OWUTCbjzt2a1YaBjKwK0VrgmnLprXGBuJZCBgBt2qkxep/SVust/FSr2B
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256417068"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256417068"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:03:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="613751794"
Received: from jdwaldem-mobl.amr.corp.intel.com (HELO [10.255.228.230]) ([10.255.228.230])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:03:07 -0700
Message-ID: <dd8cdcfb-b92c-3279-5c9c-18ffce90a2e8@intel.com>
Date:   Wed, 16 Mar 2022 12:02:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <YjGzJwjrvxg5YZ0Z@audible.transient.net>
 <YjHYh3XRbHwrlLbR@zn.tnic> <YjIwRR5UsTd3W4Bj@audible.transient.net>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: system locks up with CONFIG_SLS=Y; 5.17.0-rc
In-Reply-To: <YjIwRR5UsTd3W4Bj@audible.transient.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/22 11:45, Jamie Heilman wrote:

> int3: 0000 [#1] PREEMPT SMP PTI
> CPU: 0 PID: 2435 Comm: qemu-system-x86 Not tainted 5.17.0-rc8-sls #1
> Hardware name: Dell Inc. Precision WorkStation T3400  /0TP412, BIOS A14 04/30/2012
> RIP: 0010:setc+0x5/0x8 [kvm]
> Code: 00 00 0f 1f 00 0f b6 05 43 24 06 00 c3 cc 0f 1f 80 00 00 00 00 0f 90 c0 c3 cc 0f 1f 00 0f 91 c0 c3 cc 0f 1f 00 0f 92 c0 c3 cc <0f> 1f 00 0f 93 c0 c3 cc 0f 1f 00 0f 94 c0 c3 cc 0f 1f 00 0f 95 c0
> RSP: 0018:ffffc90000a1fc68 EFLAGS: 00000283
> RAX: 0000000000000281 RBX: 0000000000000006 RCX: 0000000000000005
> RDX: ffffffffa01a4024 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff88810ef76900 R08: 0000000000000000 R09: 0000000000000000
> R10: ffff88810ee54000 R11: 0000000000000000 R12: ffffffffa01d5720
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810ef76900
> FS:  00007f23ecd79640(0000) GS:ffff888233c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000108df8000 CR4: 00000000000426f0
> Call Trace:
>  <TASK>
>  ? x86_emulate_insn+0x76b/0xe00 [kvm]

Ooh, fun!

This hit one of the new int3's in "ASM_RET" in "setc" in
arch/x86/kvm/emulate.c:

	FOP_SETCC(setc)

Did the extra 'int3' screw up some presumed jump offset or something?

