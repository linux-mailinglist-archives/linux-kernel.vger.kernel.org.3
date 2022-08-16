Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B81594F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 06:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiHPEMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 00:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiHPELk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 00:11:40 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B952F192330
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 17:43:56 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-32a17d3bba2so113404867b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 17:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WKMPsfX2YY3EVd9RV9ksbRmKXR/EDca2WzQ8fdbr+uI=;
        b=YTcjl+UV4HsG12QrfaCzq/5R9TxJFIKVsOnSM30g08BZbVvNxx3wfPko9tQBz/wVsv
         XAkCs1qPuJ8zj3h0NcmMcMGAJCq/k2y/lYo7YHeiEiG0LdefAc5YcaN0dQxFgRpKvWTe
         C4M3Z2MPP8Y6V/zv3NI3OK+I23Y9T803dr7VKejNK0YVKaZ5OSxLOOyqb7iY6c6oNsXb
         6eNkS97Y3rIuZn7cEtNsHSD//ttHPU2Kp9vYB26T9xbk8lUA3SO0sT/k3YPOu52n493B
         x0deTuRo3lsfjN1irJo2ogYGWobwlXWa2eYQJtn40hlynOCZFqoNiScMjHA2tnutJsE8
         TVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WKMPsfX2YY3EVd9RV9ksbRmKXR/EDca2WzQ8fdbr+uI=;
        b=ms9A0iRF+cup7ssEBIse6lumFQTyAuxaqi7upLaTBG85KNY48cSFsEa2u4/8Yefsxh
         IjIOCvD9pkqw02SmwPxUUfxVxCBLWPAXPLxPYwM/8H1QIodOvZGix+F9NE7JL/p6lBDD
         7QBMkKUSxWauGmsUjxU/LfgQIRrL74OnIAlmnDYC/iKFOtw5ARPinlMIRaagR7HZUwUa
         F3cqB+G+7BCmg/hZ7b0ZRVAUK5s4tRn3iRieAqM2mHRcvK3ufaCfOL8zjZFc58JndULG
         uDKWegXkwadfsq1Rgb5Gk/LNh7V6YrRR1VBu7JPd0pVdx6bjYmQ6Z3z8Muwf01pPgJxu
         PYqg==
X-Gm-Message-State: ACgBeo0RyZdt9gyO+N2D6O3jdq6s4QCm5iqB9R2VktfuZ0Tu09vxrG+N
        m7TJFgVNOAS6JXXMADJUe3rj2SnZYCAW1/TJypt2Lw==
X-Google-Smtp-Source: AA6agR6zYGJECr1teU70klV5BLsgwAte+kRR0+Y+ZYnqGBPOt+ojfvhP3Magt7Y+1bNG9hR4JtHNjZkV95Tqb63jQPM=
X-Received: by 2002:a25:6612:0:b0:670:7c81:3aa6 with SMTP id
 a18-20020a256612000000b006707c813aa6mr13902592ybc.530.1660610635743; Mon, 15
 Aug 2022 17:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <Yvpd2pwUJGp7R+YE@euler> <20220815182307.GA4658@duo.ucw.cz> <YvrkjH6/FpIzyAv+@euler>
In-Reply-To: <YvrkjH6/FpIzyAv+@euler>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 15 Aug 2022 17:43:19 -0700
Message-ID: <CAGETcx_1dDrfrctWMb1rLhZS1Q_hiuQyKBh_1uujE+6S0Fhj2Q@mail.gmail.com>
Subject: Re: boot stuck at starting kernel, due to __genpd_dev_pm_attach?
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 5:28 PM Colin Foster
<colin.foster@in-advantage.com> wrote:
>
> On Mon, Aug 15, 2022 at 08:23:07PM +0200, Pavel Machek wrote:
> > Hi!
> >
> > > You might have already gotten this report, but I tried running v6.0-rc1
> > > on my BeagleBone Black and it gets stuck right after "Starting kernel
> > > ..." from U-Boot.
> > >
> > > A bisect pointed me to commit 5a46079a9645 ("PM: domains: Delete usage
> > > of driver_deferred_probe_check_state()").
> > >
> > > I don't have much more detail than that, other than I'm using the
> > > in-tree am335x-boneblack.dts device tree and I believe I had tested with
> > > the multi-v7-defconfig for this verification. I'm happy to test anything
> > > that might offer more information.
> >
> > Well, standart next step is reverting 5a46079a9645 on top of v6.0-rc1,
> > and if it starts working, either you get fix in your inbox, or you ask
> > Linus to revert :-).
>
> I was able to revert 5a46079a9645 and 9cbffc7a5956 and successfully boot
> v6.0-rc1 on the Beaglebone Black.
>
> I still don't know whether the root cause is the patch, or perhaps an
> invalid boneblack DTS. I'll try and dig to get more info about what
> might be failing. But I do think anyone using a Beaglebone will have
> this issue, and I also think I'm not the only using the BBB.
>

Hi Colin,

Thanks for the report. There have been other reports like this. This
commit in question is probably the cause. I have two series going.

One [1] is to revert these patches. Probably more suited for 5.19.xxx releases.

The other [2] is to actually fix the issues you are seeing without
reverting these patches (long term we do want to keep the patch that's
causing the issue for you -- not going into the details here). Can you
give this series[2] a shot and tell me if it fixes the issue? You
might need to pull in this additional diff on top of [2] (I'll roll it
into v2 of the series once I get some tests on this)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2f012e826986..866755d8ad95 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2068,7 +2068,11 @@ static int fw_devlink_create_devlink(struct device *con,
                device_links_write_unlock();
        }

-       sup_dev = get_dev_from_fwnode(sup_handle);
+       if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
+               sup_dev = fwnode_get_next_parent_dev(sup_handle);
+       else
+               sup_dev = get_dev_from_fwnode(sup_handle);
+
        if (sup_dev) {
                /*
                 * If it's one of those drivers that don't actually bind to

Thanks,
Saravana

[1] - https://lore.kernel.org/lkml/20220727185012.3255200-1-saravanak@google.com/
[2] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/
