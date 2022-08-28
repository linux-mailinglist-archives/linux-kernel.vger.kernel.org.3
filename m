Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5D45A3FA9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 22:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiH1UoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 16:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1UoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 16:44:17 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C77729824
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 13:44:15 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-32a09b909f6so154433577b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GfepdS5O9XYynQjdDpQ2QWfx+aCRCfAcOwJTSIxj1oo=;
        b=nIoiZdYnTi54Z3ipGUCFn05Bm16+NE3zcN9Yo2UH9sySii3AIRL2YsknrpvYksVydT
         JaGB2YBYzOJwief0MBPuwPGb6mJL1a5khg12PGgO7/ZuZyD7N0HPMtVeC+mNnAS1UjM8
         SIovSMmigxmU115dT9ZD6/ky3DFhy9YOKm7EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GfepdS5O9XYynQjdDpQ2QWfx+aCRCfAcOwJTSIxj1oo=;
        b=tw9B3lIenXxCHbeg2QdpUZV84nFxE/SG+bfcJcO9c9D/OqRsF8YuiLVmdoeOawmdkE
         GIG20TU53qwQZEkc2IkyVW0Lg+mCtrqvvut5NhlUdgqIxXEO2ByXZfNBUhYgs0kC4J6k
         SPy40SQDJ4x80dJ8hII1INYjHWdEW80fz9I93t8Pw+9R6Z4mOj21+VqQu9/wy+3aWx7t
         pJWldYpnN1wAwZNbMrNzpYOSEWu4AI+HOxJFp71/hW4KNxDCGcPO0Te4d/KjiKoN5hbH
         8NI1djm0JyN7vtxz1LzcbRKF4O44kM5wZv/Qj5W4abLwXquJabMTajkeJb3vG3yb9Ph/
         ON3Q==
X-Gm-Message-State: ACgBeo0RoXo/MWpOQQoCoKWFeZxn+SZl/Aq3FeJN920XJEiOC2UdlZRA
        GvJS18ksQ9cOH2YsGCkA65i/1KmKBv7xjpHe5bpl3Q==
X-Google-Smtp-Source: AA6agR7El3Dd/ECGpH9gMqYL31M+P4NYZrktD7IPQCVdmKHkFSSnExGbXtGXARgfkDcQrw52XW/YAsBXO+Vc1q+Jetc=
X-Received: by 2002:a25:cf81:0:b0:695:d67e:bc44 with SMTP id
 f123-20020a25cf81000000b00695d67ebc44mr5926895ybg.561.1661719454563; Sun, 28
 Aug 2022 13:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220827104600.1813214-1-liushixin2@huawei.com> <20220827104600.1813214-2-liushixin2@huawei.com>
In-Reply-To: <20220827104600.1813214-2-liushixin2@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Sun, 28 Aug 2022 22:44:03 +0200
Message-ID: <CAM4kBB+z6jNKNOv9zK8qxku172abPmQ_XZ7YdyJyf=_NDjRVHA@mail.gmail.com>
Subject: Re: [PATCH -next v3 1/5] frontswap: skip frontswap_ops init if zswap
 init failed.
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 12:12 PM Liu Shixin <liushixin2@huawei.com> wrote:
>
> If zswap initial failed or has not been initial, frontswap_ops will be
> NULL. In such situation, swap device would enable failed with following
> stack trace:
>
>   Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000000000000000
>   Mem abort info:
>     ESR = 0x0000000096000004
>     EC = 0x25: DABT (current EL), IL = 32 bits
>     SET = 0, FnV = 0
>     EA = 0, S1PTW = 0
>     FSC = 0x04: level 0 translation fault
>   Data abort info:
>     ISV = 0, ISS = 0x00000004
>     CM = 0, WnR = 0
>   user pgtable: 4k pages, 48-bit VAs, pgdp=00000020a4fab000
>   [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
>   Internal error: Oops: 96000004 [#1] SMP
>   Modules linked in: zram fsl_dpaa2_eth pcs_lynx phylink ahci_qoriq crct10dif_ce ghash_ce sbsa_gwdt fsl_mc_dpio nvme lm90 nvme_core at803x xhci_plat_hcd rtc_fsl_ftm_alarm xgmac_mdio ahci_platform i2c_imx ip6_tables ip_tables fuse
>   Unloaded tainted modules: cppc_cpufreq():1
>   CPU: 10 PID: 761 Comm: swapon Not tainted 6.0.0-rc2-00454-g22100432cf14 #1
>   Hardware name: SolidRun Ltd. SolidRun CEX7 Platform, BIOS EDK II Jun 21 2022
>   pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : frontswap_init+0x38/0x60
>   lr : __do_sys_swapon+0x8a8/0x9f4
>   sp : ffff80000969bcf0
>   x29: ffff80000969bcf0 x28: ffff37bee0d8fc00 x27: ffff80000a7f5000
>   x26: fffffcdefb971e80 x25: ffffaba797453b90 x24: 0000000000000064
>   x23: ffff37c1f209d1a8 x22: ffff37bee880e000 x21: ffffaba797748560
>   x20: ffff37bee0d8fce4 x19: ffffaba797748488 x18: 0000000000000014
>   x17: 0000000030ec029a x16: ffffaba795a479b0 x15: 0000000000000000
>   x14: 0000000000000000 x13: 0000000000000030 x12: 0000000000000001
>   x11: ffff37c63c0aba18 x10: 0000000000000000 x9 : ffffaba7956b8c88
>   x8 : ffff80000969bcd0 x7 : 0000000000000000 x6 : 0000000000000000
>   x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffffaba79730f000
>   x2 : ffff37bee0d8fc00 x1 : 0000000000000000 x0 : 0000000000000000
>   Call trace:
>   frontswap_init+0x38/0x60
>   __do_sys_swapon+0x8a8/0x9f4
>   __arm64_sys_swapon+0x28/0x3c
>   invoke_syscall+0x78/0x100
>   el0_svc_common.constprop.0+0xd4/0xf4
>   do_el0_svc+0x38/0x4c
>   el0_svc+0x34/0x10c
>   el0t_64_sync_handler+0x11c/0x150
>   el0t_64_sync+0x190/0x194
>   Code: d000e283 910003fd f9006c41 f946d461 (f9400021)
>   ---[ end trace 0000000000000000 ]---
>

Well, this issue you are seeing is in fact introduced by the following patch:

author Christoph Hellwig <hch@lst.de> 2022-01-21 22:15:10 -0800
frontswap: remove support for multiple ops

So I would rather see that one reverted and fixed.

Thanks,
Vitaly

> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  mm/frontswap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/frontswap.c b/mm/frontswap.c
> index 1a97610308cb..620f95af81dd 100644
> --- a/mm/frontswap.c
> +++ b/mm/frontswap.c
> @@ -125,7 +125,8 @@ void frontswap_init(unsigned type, unsigned long *map)
>          * p->frontswap set to something valid to work properly.
>          */
>         frontswap_map_set(sis, map);
> -       frontswap_ops->init(type);
> +       if (frontswap_ops)
> +               frontswap_ops->init(type);
>  }
>
>  static bool __frontswap_test(struct swap_info_struct *sis,
> --
> 2.25.1
>
