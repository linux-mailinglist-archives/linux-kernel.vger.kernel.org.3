Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B504D529AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241436AbiEQHgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241783AbiEQHfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:35:38 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869D14992E;
        Tue, 17 May 2022 00:34:10 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id v14so12594346qtc.3;
        Tue, 17 May 2022 00:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TNMTs/nof9Veg9iAE0MH+wUHLc/qfyV0Zv09DHMPg6E=;
        b=IMH32/I/rWwFqegIRezHENdkaAXco04rJbAFYkawxyDmUlnEqRS8V8L6JbrxT60Bza
         1HsUcnQAc/nJNzw8NjUQCaz7xbHHFIjhrB03gTwA5YTcEFsV5EMmSjQEVla3XNI++Cib
         69PAoykNYKR3EC+63wmjK4eswteNbOnpzaTdOYiwHmrsWcExOfR4D3CFYeWtLJxoA20Z
         wi35siBYa5Lmm9ACWVB9DlfJf51r0qehYvEaf0hkBmg7ibtBrJE3G+zgDjRDewPr+4pM
         RvTuHivwfp8oEewmSdPNYPTB06nc1gLTN0pwbYFLON2t2VZ8n+jFQk8Or712yCffOOc7
         6h8g==
X-Gm-Message-State: AOAM531PkNf0KH3R8gyXwVjBXIqPGBEQRcpYJffDlqALDVR2Pa6y8LlK
        2Dnk4Kk6JXUYcs86Hf9ROgkU8cYCIhUx4g==
X-Google-Smtp-Source: ABdhPJy0H/bHBhdz84jGwlYYO4BdKs++9Jg1f08UthITQKI14YvMV3H1nNI0e5Bdd0rxiSfWq55T+g==
X-Received: by 2002:a05:622a:178f:b0:2f3:dd2e:6054 with SMTP id s15-20020a05622a178f00b002f3dd2e6054mr18662520qtk.554.1652772849540;
        Tue, 17 May 2022 00:34:09 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id n26-20020a05620a153a00b0069fc13ce22esm7262293qkk.95.2022.05.17.00.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 00:34:09 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2ec42eae76bso177730367b3.10;
        Tue, 17 May 2022 00:34:09 -0700 (PDT)
X-Received: by 2002:a81:ad11:0:b0:2fe:fb00:a759 with SMTP id
 l17-20020a81ad11000000b002fefb00a759mr9584801ywh.283.1652772848730; Tue, 17
 May 2022 00:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220513132500.32395-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220513132500.32395-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 May 2022 09:33:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXL7p9G2BHeOWV1T5Ehy6i9gtefn3DmKsiadtcxH9_HsQ@mail.gmail.com>
Message-ID: <CAMuHMdXL7p9G2BHeOWV1T5Ehy6i9gtefn3DmKsiadtcxH9_HsQ@mail.gmail.com>
Subject: Re: [PATCH] Input: gpio-keys - Cancel delayed work only in case of GPIO
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 6:44 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> gpio_keys module can either accept gpios or interrupts. The module
> initializes delayed work in case of gpios only and not for interrupts,
> so make sure cancel_delayed_work_sync() is called only when bdata->gpiod
> is true.
>
> This fixes the issue seen below when the gpio_keys module is unloaded and
> an interrupt pin is used instead of GPIO:
>
> [  360.297569] ------------[ cut here ]------------
> [  360.302303] WARNING: CPU: 0 PID: 237 at kernel/workqueue.c:3066 __flush_work+0x414/0x470
> [  360.310531] Modules linked in: gpio_keys(-)
> [  360.314797] CPU: 0 PID: 237 Comm: rmmod Not tainted 5.18.0-rc5-arm64-renesas-00116-g73636105874d-dirty #166
> [  360.324662] Hardware name: Renesas SMARC EVK based on r9a07g054l2 (DT)
> [  360.331270] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  360.338318] pc : __flush_work+0x414/0x470
> [  360.342385] lr : __cancel_work_timer+0x140/0x1b0
> [  360.347065] sp : ffff80000a7fba00
> [  360.350423] x29: ffff80000a7fba00 x28: ffff000012b9c5c0 x27: 0000000000000000
> [  360.357664] x26: ffff80000a7fbb80 x25: ffff80000954d0a8 x24: 0000000000000001
> [  360.364904] x23: ffff800009757000 x22: 0000000000000000 x21: ffff80000919b000
> [  360.372143] x20: ffff00000f5974e0 x19: ffff00000f5974e0 x18: ffff8000097fcf48
> [  360.379382] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000053f40
> [  360.386622] x14: ffff800009850e88 x13: 0000000000000002 x12: 000000000000a60c
> [  360.393861] x11: 000000000000a610 x10: 0000000000000000 x9 : 0000000000000008
> [  360.401100] x8 : 0101010101010101 x7 : 00000000a473c394 x6 : 0080808080808080
> [  360.408339] x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffff80000919b458
> [  360.415578] x2 : ffff8000097577f0 x1 : 0000000000000001 x0 : 0000000000000000
> [  360.422818] Call trace:
> [  360.425299]  __flush_work+0x414/0x470
> [  360.429012]  __cancel_work_timer+0x140/0x1b0
> [  360.433340]  cancel_delayed_work_sync+0x10/0x18
> [  360.437931]  gpio_keys_quiesce_key+0x28/0x58 [gpio_keys]
> [  360.443327]  devm_action_release+0x10/0x18
> [  360.447481]  release_nodes+0x8c/0x1a0
> [  360.451194]  devres_release_all+0x90/0x100
> [  360.455346]  device_unbind_cleanup+0x14/0x60
> [  360.459677]  device_release_driver_internal+0xe8/0x168
> [  360.464883]  driver_detach+0x4c/0x90
> [  360.468509]  bus_remove_driver+0x54/0xb0
> [  360.472485]  driver_unregister+0x2c/0x58
> [  360.476462]  platform_driver_unregister+0x10/0x18
> [  360.481230]  gpio_keys_exit+0x14/0x828 [gpio_keys]
> [  360.486088]  __arm64_sys_delete_module+0x1e0/0x270
> [  360.490945]  invoke_syscall+0x40/0xf8
> [  360.494661]  el0_svc_common.constprop.3+0xf0/0x110
> [  360.499515]  do_el0_svc+0x20/0x78
> [  360.502877]  el0_svc+0x48/0xf8
> [  360.505977]  el0t_64_sync_handler+0x88/0xb0
> [  360.510216]  el0t_64_sync+0x148/0x14c
> [  360.513930] irq event stamp: 4306
> [  360.517288] hardirqs last  enabled at (4305): [<ffff8000080b0300>] __cancel_work_timer+0x130/0x1b0
> [  360.526359] hardirqs last disabled at (4306): [<ffff800008d194fc>] el1_dbg+0x24/0x88
> [  360.534204] softirqs last  enabled at (4278): [<ffff8000080104a0>] _stext+0x4a0/0x5e0
> [  360.542133] softirqs last disabled at (4267): [<ffff8000080932ac>] irq_exit_rcu+0x18c/0x1b0
> [  360.550591] ---[ end trace 0000000000000000 ]---
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
