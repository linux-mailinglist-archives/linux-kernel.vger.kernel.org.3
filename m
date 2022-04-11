Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874924FC2C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348708AbiDKQzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243965AbiDKQzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:55:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C3035AA6;
        Mon, 11 Apr 2022 09:53:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id s18so9684342ejr.0;
        Mon, 11 Apr 2022 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hq9f5/RKeqFPfe01WxjMVIHowJsKBfJmwCx5QvdPw1A=;
        b=q7qbmDs1dVWdTOe6VYfzmW5Hff9GRPCexV+KafoUs4J4l8gBflhswSYlelDdbTETyC
         jZyxwSDKViY8H0/Wc6/IuTK70Hg52/z5gsdZyKfC7lcLdhTmX4n10VgiyNvzSQh/5LOT
         6Ct4gvmWALz/zr5I8uolBr4Iq+EqIChUhTIDJDgS7kSX8WG6hLW4ndHviGkI1/4UUc7o
         dd1Xu1dAGi4+vlddV531nJPW0oB4h2L/HyxaBt0D155u3YIujD0NJCqLNoevSG9va9Cw
         pDUnzccVhbWv0bJuvRw2XS8P0J8rL1cUIAMjbnUCRHuEQaSzsQ1/fgH+JQ8/8SHG4utm
         UcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hq9f5/RKeqFPfe01WxjMVIHowJsKBfJmwCx5QvdPw1A=;
        b=n5T3gOpEjXzdBMR7xKmaZDapyTeHPUKvB6vpZyIUh4SQX+Gfi5BtQUqr1CHxU1MxT0
         d2QuSC+qicgMxQjdmkj3C38RGxCXdePRqXDknjrPddHwlTudpgVDiROy2opL5ogm1I7Q
         cS8zxJ6urFgnhE02TVoVvQO0JCyX2CAJkSNOorOMRLsta1q8IBu8ibLDSBAwWEr7spaz
         GblZ3hs5ThMwsPP3f7cY6EwXZJLBuo8p8CP6IIWiqTf+F8bW8Foaakh9pN02wwYPGYfP
         R+BNH+7i/rW5OAjqSxlUGe1ZDuXnDHqO1kT/zwZdM7KRfb9bdTnmn3iE+NmLkEBKNBtl
         T8qw==
X-Gm-Message-State: AOAM532C7nXumIFB6zVYFYRn4OkqQ70SXH1O/RMFYbJJUYZzbyXF3il7
        EGZ2bhHvJAZvN3Vy4OYr9sBdWYdiMwy+SYNsZ3Y=
X-Google-Smtp-Source: ABdhPJwueRgvgtGfwQpcXyTVd2yIAAAw3b3k4eXgNiUE5AD52zIkqZMqXgsqUSYOOpQl2rVjarI5FqwQF/T6UBvKT78=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr30782381ejc.132.1649696013529; Mon, 11
 Apr 2022 09:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <1836398.tdWV9SEqCh@kreacher> <CAHp75Vc2Lci4ewdosqX4Thm6ME7pKjKw+C+wtUsq2esRM-eXjg@mail.gmail.com>
 <CAJZ5v0hCPG0_4MUW5bt+FLtPmnFZ9NUxsEiFpd-6+wOmYxPm5A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hCPG0_4MUW5bt+FLtPmnFZ9NUxsEiFpd-6+wOmYxPm5A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Apr 2022 19:49:20 +0300
Message-ID: <CAHp75VeS+3-N9rV3CfTLHKKD_pzTHrz4Lnv5XsEbd22CoCJeKw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Avoid device usage count underflows
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 6:17 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Apr 11, 2022 at 5:09 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Apr 6, 2022 at 11:49 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

...

> > > +               retval = rpm_drop_usage_count(dev);
> > > +               if (retval > 0) {
> > >                         trace_rpm_usage_rcuidle(dev, rpmflags);
> > >                         return 0;
> > > +               } else if (retval < 0) {
> > > +                       return retval;
> > >                 }
> >
> > Can be written in a form
> >
> >                if (retval < 0)
> >                        return retval;
> >                if (retval > 0) {
> >                        trace_rpm_usage_rcuidle(dev, rpmflags);
> >                        return 0;
> >                }
> >
>
> I know.
>
> And why would it be better?

Depends on the perception:
a) less characters to parse (no 'else');
b) checking for errors first, which seems more or less standard pattern.

-- 
With Best Regards,
Andy Shevchenko
