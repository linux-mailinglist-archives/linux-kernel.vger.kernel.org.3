Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A2A57172A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiGLKVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiGLKVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:21:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F08AD874
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:21:14 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bf9so13120927lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNtCjratP+l3BClZAmUIuZ00I2hiouCwTK9IZPiwW4o=;
        b=Kvx3PVHa/xlR2Tt3c4VY8PyXDDI4+7mREGjJ+q/cC+2pl9RKC75e/mXhniSUZya3tQ
         BuVG+BvS1Qk1Zh/7SwGZDhCn2lmJLyOBAzgyF/usjW8ahyZdaKNP/UE0w2f1c2DUNkin
         LUXEO0ZXhDAaPn6vaNrGOZrIs4DjDxO1jaLzZAP5Uh6KodZLIuk/HY6YNSKPoUwWiqhF
         +cHVZjeDizTBHrzFwXlMEkz3FYIRqVaemvZgWH+dHrzEeGE/fTeQuowqok6CjQFSV4MN
         593LzQoaspz5sidVJg4zXLX1or+X+TxoIwNmQeyn4Otl4m9uetADx/25QxK+8DYQ88GZ
         rFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNtCjratP+l3BClZAmUIuZ00I2hiouCwTK9IZPiwW4o=;
        b=JffNMySHVFcpKyGugwxyQtyu5yuQtZ1t4O5MrajWmnW1vDMWm1BXG51NXUGv0rFpBI
         mpQ7PTyWVK3q+oOPKocCWj4Ec6TPCleWjjK5D//A2qXeDDUW1PBgYE/Uw59luOL/zzDC
         k2rBVvOfMF16gt5DZSZ1b/pyDgwAcTWB/gyh/dplnHfH0rQ/G9sMM9Sxp5jlNCAii6Ls
         9n0kp3is64D8sXWtyCscKK/Iei/FRduxcjbV8sgBuk6d1HDpWJhYCNJFfsx+n6hNFCle
         oge8+xb15111S6dtAn7Of5dbClxljvjMdmR3RwQb6xw/d/dy+DTevJDvPPqClB8iUln+
         CsRg==
X-Gm-Message-State: AJIora+T41nbN5+37c/ngikrGM8yesdWEo/l+wGx87JXZcvyZovj0exZ
        kGKl2V+9MAN+QbjMzb9VLryYdHjK4GMmXyRDoQxKRA==
X-Google-Smtp-Source: AGRyM1tOJi5dGdH6DXZvc3c1mCEFY53tJ61Bp+7rU+MJq+JriC110o4Fh9HL3dO6ysTIEF8ZqOw2WEUuAzHQ39bKltg=
X-Received: by 2002:a05:6512:ad6:b0:481:1a75:44c with SMTP id
 n22-20020a0565120ad600b004811a75044cmr15029169lfu.167.1657621272082; Tue, 12
 Jul 2022 03:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220623080009.1775574-1-vincent.whitchurch@axis.com>
 <CAPDyKFpg9Gs3qOeXWM2A1gSDEKA89i72NoTcF0M_a3jO-AC+dw@mail.gmail.com> <20220627100840.GA12705@axis.com>
In-Reply-To: <20220627100840.GA12705@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 12:20:35 +0200
Message-ID: <CAPDyKFr94KXVyazcC93Av0tc32cseR79GAxJ2vAFJa9abvDfjA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Allow speed modes to be adjusted via module param
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022 at 12:08, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> On Thu, Jun 23, 2022 at 03:53:41PM +0200, Ulf Hansson wrote:
> > On Thu, 23 Jun 2022 at 10:00, Vincent Whitchurch
> > <vincent.whitchurch@axis.com> wrote:
> > > During board verification, there is a need to test the various supported
> > > eMMC/SD speed modes.  However, since the framework chooses the best mode
> > > supported by the card and the host controller's caps, this currently
> > > necessitates changing the devicetree for every iteration.
> > >
> > > To make changing the modes easier, allow the various host controller
> > > capabilities to be cleared via a module parameter.  (A per-controller
> > > debugfs wouldn't work since the controller needs to be re-probed to
> > > trigger re-init of cards.  A module parameter is used instead of a
> >
> > I think we could make use of a per-controller debugfs thing, if used
> > in combination with MMC_CAP_AGGRESSIVE_PM and runtime PM.
> >
> > As runtime PM also has sysfs interface for each device, we can control
> > runtime PM for the card's device (to trigger re-initialization of the
> > card). In between runtime suspend/resume of the card's device, we
> > should be able to change the supported speed modes, through debug fs.
> >
> > Would this work for you?
>
> I got it to work with the below commands and the following patch.  Note
> that:
>
> (1) MMC_CAP_AGGRESSIVE_PM also needs to be turned on via debugfs to
>     avoid having to patch the kernel.  The cap is checked on every call
>     to runtime_suspend so it (currently) works to set it without
>     re-probing the host.
>
> (2) I had to call mmc_select_card_type() even if there is an old card
>     since currently it's only called from mmc_decode_ext_csd().
>
> Also, unlike the module parameter, this can't be set from bootargs, but
> that part is not important for my use case.
>
>  root@(none):/sys/kernel/debug/mmc0# grep timing ios
>  timing spec:   9 (mmc HS200)
>
>  // Turn on MMC_CAP_AGGRESSIVE_PM and re-trigger runtime suspend
>  root@(none):/sys/kernel/debug/mmc0# echo $(($(cat caps) | (1 << 7))) > caps
>  root@(none):/sys/kernel/debug/mmc0# echo on > /sys/bus/mmc/devices/mmc0\:0001/power/control
>  root@(none):/sys/kernel/debug/mmc0# echo auto > /sys/bus/mmc/devices/mmc0\:0001/power/control
>
>  // MMC_CAP2_HS200_1_8V_SDR
>  root@(none):/sys/kernel/debug/mmc0# echo $(($(cat caps2) & ~(1 << 5))) > caps2
>  root@(none):/sys/kernel/debug/mmc0# echo on > /sys/bus/mmc/devices/mmc0\:0001/power/control
>  root@(none):/sys/kernel/debug/mmc0# grep timing ios
>  timing spec:   8 (mmc DDR52)
>
> 8<----
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 3fdbc801e64a..721925300611 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -12,9 +12,12 @@
>  #include <linux/slab.h>
>  #include <linux/stat.h>
>  #include <linux/fault-inject.h>
> +#include <linux/time.h>
>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sd.h>
>
>  #include "core.h"
>  #include "card.h"
> @@ -223,6 +226,47 @@ static int mmc_clock_opt_set(void *data, u64 val)
>  DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
>         "%llu\n");
>
> +static int mmc_caps_get(void *data, u64 *val)
> +{
> +       *val = *(u32 *)data;
> +       return 0;
> +}
> +
> +static int mmc_caps_set(void *data, u64 val)
> +{
> +       u32 *caps = data;
> +       u32 diff = *caps ^ val;
> +       u32 allowed = MMC_CAP_AGGRESSIVE_PM |
> +               MMC_CAP_SD_HIGHSPEED |
> +               MMC_CAP_MMC_HIGHSPEED |
> +               MMC_CAP_UHS |
> +               MMC_CAP_DDR;
> +
> +       if (diff & ~allowed)
> +               return -EINVAL;
> +
> +       *caps = val;
> +
> +       return 0;
> +}
> +
> +static int mmc_caps2_set(void *data, u64 val)
> +{
> +       u32 *caps = data;
> +       u32 diff = *caps ^ val;
> +       u32 allowed = MMC_CAP2_HSX00_1_8V | MMC_CAP2_HSX00_1_2V;
> +
> +       if (diff & ~allowed)
> +               return -EINVAL;
> +
> +       *caps = val;
> +
> +       return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(mmc_caps_fops, mmc_caps_get, mmc_caps_set, "0x%08llx\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(mmc_caps2_fops, mmc_caps_get, mmc_caps2_set, "0x%08llx\n");
> +
>  void mmc_add_host_debugfs(struct mmc_host *host)
>  {
>         struct dentry *root;
> @@ -231,8 +275,10 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>         host->debugfs_root = root;
>
>         debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops);
> -       debugfs_create_x32("caps", S_IRUSR, root, &host->caps);
> -       debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2);
> +       debugfs_create_file("caps", S_IRUSR | S_IWUSR, root, &host->caps,
> +                       &mmc_caps_fops);
> +       debugfs_create_file("caps2", S_IRUSR | S_IWUSR, root, &host->caps2,
> +                       &mmc_caps2_fops);
>         debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
>                                    &mmc_clock_fops);
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 89cd48fcec79..c79c26add3da 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1730,7 +1730,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>
>                 /* Erase size depends on CSD and Extended CSD */
>                 mmc_set_erase_size(card);
> -       }
> +       } else
> +               mmc_select_card_type(card);
>
>         /* Enable ERASE_GRP_DEF. This bit is lost after a reset or power off. */
>         if (card->ext_csd.rev >= 3) {

Overall, the approach seems reasonable to me. Perhaps we can
reorganize the code so mmc_select_card_type() is always called from
mmc_init_card(), rather than from mmc_decode_ext_csd() too.

Kind regards
Uffe
