Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ACA4FC3CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349034AbiDKSJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiDKSJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:09:52 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881CB26FF;
        Mon, 11 Apr 2022 11:07:37 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2ec05db3dfbso54020767b3.7;
        Mon, 11 Apr 2022 11:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UdFqlnyS6znWMBHrBHznevziGrO6hgWnoxAL9D9H1BY=;
        b=ZfxQtfuv/EMHqa1vjDU0OkLWr52lNFYIngBIdGjeUfyQyUqxor0NcS8m1JjkNUJRaG
         YsQsm9AgHGycVehWaBHS6p/eCrJOs/HrrUvjhCFKkUNbKnneu9p/2ilmhdhUtYtTklpH
         BItFJxGqKVwzY7yPrG4PyLPG78DwFS2DeoNJkp0oAmQCdzHciF510aDvv+BDq9Fr6wbH
         QShiTZ1Uc73uTs6V/C68TK4dsVNZuQTLrtVio3MzV09WOAGZ/QED14wsO5SCq4efwFsO
         LDnyyFI/5WVcka7q+rqBWXAPTy8WiVQo+7cg3repaG6+5dV9feb50vx0sqzHMemnoVk9
         MnPQ==
X-Gm-Message-State: AOAM533RFOFm1hOGUimTs1/8bbDeMHohzoIhwt0sbUxaLXCrqoxUWp3Z
        AA71hanQwx1VZQmPxR4fN9h164OMoM5S3m1ClPM=
X-Google-Smtp-Source: ABdhPJx81h6PmVq/sT/eLgk2/wfWI9xiNZCKOS3KYYmWH0UBz+3LrS91oBTVKXNo9iQ/lO56OkmE6SfaH+M3PjpKYGE=
X-Received: by 2002:a81:b89:0:b0:2eb:e9e6:470a with SMTP id
 131-20020a810b89000000b002ebe9e6470amr13058043ywl.7.1649700456794; Mon, 11
 Apr 2022 11:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <1836398.tdWV9SEqCh@kreacher> <CAHp75Vc2Lci4ewdosqX4Thm6ME7pKjKw+C+wtUsq2esRM-eXjg@mail.gmail.com>
 <CAJZ5v0hCPG0_4MUW5bt+FLtPmnFZ9NUxsEiFpd-6+wOmYxPm5A@mail.gmail.com> <CAHp75VeS+3-N9rV3CfTLHKKD_pzTHrz4Lnv5XsEbd22CoCJeKw@mail.gmail.com>
In-Reply-To: <CAHp75VeS+3-N9rV3CfTLHKKD_pzTHrz4Lnv5XsEbd22CoCJeKw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Apr 2022 20:07:25 +0200
Message-ID: <CAJZ5v0h-hB918OxUjHQCypyR8JKNEV8FxR7LRYaraoq+Mazfhw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Avoid device usage count underflows
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>
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

On Mon, Apr 11, 2022 at 6:53 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Apr 11, 2022 at 6:17 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Mon, Apr 11, 2022 at 5:09 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Wed, Apr 6, 2022 at 11:49 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> ...
>
> > > > +               retval = rpm_drop_usage_count(dev);
> > > > +               if (retval > 0) {
> > > >                         trace_rpm_usage_rcuidle(dev, rpmflags);
> > > >                         return 0;
> > > > +               } else if (retval < 0) {
> > > > +                       return retval;
> > > >                 }
> > >
> > > Can be written in a form
> > >
> > >                if (retval < 0)
> > >                        return retval;
> > >                if (retval > 0) {
> > >                        trace_rpm_usage_rcuidle(dev, rpmflags);
> > >                        return 0;
> > >                }
> > >
> >
> > I know.
> >
> > And why would it be better?
>
> Depends on the perception:

Well, exactly.

> a) less characters to parse (no 'else');

But to me, with the "else" it is clear that the conditionals are
related to each other which is not so clear otherwise at first sight.
YMMV

> b) checking for errors first, which seems more or less standard pattern.

So the checks can be reversed no problem, but this is such a minor point ,,,
