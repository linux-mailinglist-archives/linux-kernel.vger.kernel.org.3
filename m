Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE851BF2F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347851AbiEEMYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiEEMYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:24:40 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C4E1209B;
        Thu,  5 May 2022 05:21:01 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id i38so7256063ybj.13;
        Thu, 05 May 2022 05:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqzYqmtOukgWsbQu7Sm4paiPoURWMu6g5DfWZGiQmpI=;
        b=kw7u8Lvn2SdptagddSjnuM02rhozD33RnJNp9tcroJXDwHXbbhQqzcpVoolrYAVRg5
         OS3gMlCzxDy/qa/A/AtOCMFVTJ/F/kdV3mU8uTFZycc0ePSmWjQQ2FOI6QbDVhoQXCcy
         UfZP2WeXstmJQUa9ZJgp7/OyyAHZnvnKrCz5xhkH1V+zGkSrVIZuJSsgaFIDDobj1Upl
         CSiCSjRKH7uUT9UksmjsiVlGvUiOBG1E3fn3nP9T0tyiN2+m9gAmSq2ZQ5D9bBoZ720c
         4fEUcps+CD+bbErkmByuO9vSvMwxeESowcMjnZAyYls3gwi6Q09RRsr2Q5yo8DRhxqMI
         KDLw==
X-Gm-Message-State: AOAM53003QXcGYtt5jGNeAFqRgCpsFnF/7Feg5xrY6R/DV3HC6tM7lMT
        iYtgV64rP3a0IQFHnj5X8609XKgzmVggYMtLfsM=
X-Google-Smtp-Source: ABdhPJyG1iLik/vFtFS9S/zeuipmFl5Gpkix5aWcrJKW9hkV7rmqAdKIbPiRyp0qfbH/Xm9ONsG2JYip54XwJP1Ai5U=
X-Received: by 2002:a25:da84:0:b0:648:423e:57b0 with SMTP id
 n126-20020a25da84000000b00648423e57b0mr20879291ybf.137.1651753261048; Thu, 05
 May 2022 05:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220429164325.1.I2a3b980ea051e59140227999f0f0ca16f1125768@changeid>
 <CAHp75VdqbXCYoEwxMt7xG55QDu2mXHbnpwdnHb6ktm8NdVPJnQ@mail.gmail.com>
In-Reply-To: <CAHp75VdqbXCYoEwxMt7xG55QDu2mXHbnpwdnHb6ktm8NdVPJnQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 May 2022 14:20:50 +0200
Message-ID: <CAJZ5v0hKrnRznpTjTyb8ANGN=REaukAbqQNB_14i_NwAA84=uA@mail.gmail.com>
Subject: Re: [PATCH] device property: Fix recent breakage of fwnode_get_next_parent_dev()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 1, 2022 at 9:50 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Apr 30, 2022 at 3:00 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > Due to a subtle typo, instead of commit 87ffea09470d ("device
> > property: Introduce fwnode_for_each_parent_node()") being a no-op
> > change, it ended up causing the display on my sc7180-trogdor-lazor
> > device from coming up unless I added "fw_devlink=off" to my kernel
> > command line. Fix the typo.
>
> Sorry and merci pour la fix!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Applied, thanks!

> > Fixes: 87ffea09470d ("device property: Introduce fwnode_for_each_parent_node()")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/base/property.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 36401cfe432c..52e85dcb20b5 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -600,7 +600,7 @@ struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
> >         struct device *dev;
> >
> >         fwnode_for_each_parent_node(fwnode, parent) {
> > -               dev = get_dev_from_fwnode(fwnode);
> > +               dev = get_dev_from_fwnode(parent);
> >                 if (dev) {
> >                         fwnode_handle_put(parent);
> >                         return dev;
> > --
> > 2.36.0.464.gb9c8b46e94-goog
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko
