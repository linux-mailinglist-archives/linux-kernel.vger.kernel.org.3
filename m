Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9975D5917DA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 02:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbiHMAhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 20:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiHMAhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 20:37:46 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0185BA895A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 17:37:43 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id k12so3809885ybk.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 17:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uEJMlpNek7i3LOabGfVfDJzU9omVsDJB8WJ8KQU8dlQ=;
        b=Sve28P4PqhXjk4ce663qu3BvVMqDHjCi61dQeacdpv1MmyLZIemKSXmz1ouaidH+nD
         DCGdK5i4Ch7HgoQYu2+MuRZb1hdCO0/FPhd9qeDOqxjkVCHGg2R+Gnyeg0Iehbqrq3fI
         BhTdclcBc6ylCKogS/Xb+6Ruw4y4rGUEfX4OWrb5LgSN7uaBCCsL7CaIRVhf/yoCdZwY
         5yStn2+EnssoA4TZt9WEjTFainIwqSVJQcvvM/z7JPDA18RNrlU1B40NxbCV3SSxlaB9
         fAzavnCk0q+JcNw+3GICKmVdS44T263eRwHsX5a+YURPIwUo3W7ZuZzltZC4DnsAXB3j
         CY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uEJMlpNek7i3LOabGfVfDJzU9omVsDJB8WJ8KQU8dlQ=;
        b=Cy3Oaydv3FqLmrWRhoavvHXD7KNAPMmxrKzkHq9jrxHAT25PV+ua1QWj4PU46nuW0/
         I5i2VtfL8dirZZpYMIREhS09FwEXDx7SXReMtsRbOS16811W5BnkoBJD7vzBtO4SUF36
         2TM2Gv4J4iSwVxsMNGcW2FKH42Z/xn3ODmDFwqVF9hSPz0tV/EwzmwJqhssRS3+TSjLk
         RDRqhKa56kN/z/eOgPbkOsBrEtZVFf7MxT7NgzfQ6JUdsotRZNHficPEs+hfDr4698+1
         hrUNMqR45I9civWma6XYGdBrmQlbIPwoGgW+3o/WXMYdMWciXTN9xXfa+cuPNtDGCkJR
         9aiw==
X-Gm-Message-State: ACgBeo0avwBJWnvKFymqLdx+SLVluD4tss7jPIhtQxOZCCTPyNzEQsCh
        mZKgRCGReu3GpD2bHawKfIS4JE1yIl+Iqp5zFE4b8g==
X-Google-Smtp-Source: AA6agR60geMZ3H7nVfNHvTy7tQRFJxetMdVj0FGkYr3EoFl8eIXK86kZZzELtTaeP+s+WgwLZRZMnfoqUVBwXNCqVYY=
X-Received: by 2002:a05:6902:2cb:b0:684:aebe:49ab with SMTP id
 w11-20020a05690202cb00b00684aebe49abmr2097251ybh.242.1660351061876; Fri, 12
 Aug 2022 17:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220810060040.321697-1-saravanak@google.com> <20220810060040.321697-10-saravanak@google.com>
 <YvYhoGdemyKEx++d@atomide.com>
In-Reply-To: <YvYhoGdemyKEx++d@atomide.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 12 Aug 2022 17:37:05 -0700
Message-ID: <CAGETcx_SdxJKV56jGSx8GbmA4y_zaoP6z8n8xKZGZbCcmewvDQ@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] of: property: Simplify of_link_to_phandle()
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
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

On Fri, Aug 12, 2022 at 2:47 AM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Saravana Kannan <saravanak@google.com> [220810 05:54]:
> > The driver core now:
> > - Has the parent device of a supplier pick up the consumers if the
> >   supplier never has a device created for it.
> > - Ignores a supplier if the supplier has no parent device and will never
> >   be probed by a driver
> >
> > And already prevents creating a device link with the consumer as a
> > supplier of a parent.
> >
> > So, we no longer need to find the "compatible" node of the supplier or
> > do any other checks in of_link_to_phandle(). We simply need to make sure
> > that the supplier is available in DT.
>
> This patch fixes booting for me, so it should be applied as a fix and
> tagged with:
>
> Fixes: 5a46079a9645 ("PM: domains: Delete usage of driver_deferred_probe_check_state()")
>
> If there are dependencies to the other patches in this series, it might
> make sense to revert commit 5a46079a9645 instead.

Yes, there are dependencies on the rest of the patches in this series.
For linux-next, I think we should pick up this series once we get more
Tested-bys.

 So if 5a46079a9645 is causing any regression in stable branches, we
should pick up the revert series [1] instead of this series we are
replying to.

[1] - https://lore.kernel.org/all/20220727185012.3255200-1-saravanak@google.com/

> Anyways, thanks for fixing the issue, for this patch:
>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>

Thanks!

> For the process, looks like the earlier series got merged despite the
> issues reported.

If I'm not mistaken, the issues were reported after the series got
picked up. And the series got some tested-by s before it was picked
up. And once it's in git history, we obviously can't drop it.

> And we had non-booting Linux next for at least some SoCs
> for weeks. And now we are about to have a non-booting -rc1 unless things
> get fixed fast. Annoying glitches, sigh..

Sorry for breaking some boards -- so mean "creative" corner cases :)

This rewrite is way more flexible (removes a lot of limitations in
fw_devlink) and hopefully this handles all the corner cases. We'll
see.

-Saravana
