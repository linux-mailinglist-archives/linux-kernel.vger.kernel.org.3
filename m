Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD6856017F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiF2Ni4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Jun 2022 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiF2Nit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:38:49 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9895B219C;
        Wed, 29 Jun 2022 06:38:45 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3178acf2a92so148189147b3.6;
        Wed, 29 Jun 2022 06:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B/wOP5TkUKJr9Ua3F5xrOhp3YHBuachNRIARHLsgoOk=;
        b=YntU0pXbUqMMyj8GDe3gLL1YiaRbaaPieMtU6sqwyze7UeqQvF1LUpOt+kGnwPtedv
         rtNnMDte0qEEGHRaRZHzMRFSF6bd2nkbf7DOZZmmLlGyAmDUlB60X4IanrmKtymG0eiC
         mmxM9zOZ7EgfPOKDJa31Sk6sEoLhO5oc10vuzJdUVJcgxIXrrPuD8bi0c5Ok6gzvLd1C
         MJuL4UVwrW6QvUX3GrR+E6CRPaJNUBt/ybP35vaMubbQwJh2jGyyWWV9LXI6YnPvTYES
         4pYWETE/+dXmDt45hTDgF8VCGqEsk9Sc1xFthGgLHXQaoedhd1MuVL0GnIqQzoyuaR/H
         lPSA==
X-Gm-Message-State: AJIora8lm5ktAKDv31ndNS2NpTczDfhXWJ7hxrAjicOmcCTQQaMBHIgM
        9rBEi0jDbM/GxXRpL/9Xu9zwSnlth8F4pU/Kqdg=
X-Google-Smtp-Source: AGRyM1tMA5SCoYUWKJu0SCOIX9Zy6OoauoJk44ZiiZ5CnKO9ChlDYq0LkC/V13XvwEo8BNd8sQIiQ/OPVuK7qM1JYkE=
X-Received: by 2002:a81:68d7:0:b0:318:11df:a40d with SMTP id
 d206-20020a8168d7000000b0031811dfa40dmr3895805ywc.196.1656509924699; Wed, 29
 Jun 2022 06:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <12026357.O9o76ZdvQC@kreacher> <c57b353f-1325-4c90-f455-e53693ba585d@huawei.com>
In-Reply-To: <c57b353f-1325-4c90-f455-e53693ba585d@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 15:38:33 +0200
Message-ID: <CAJZ5v0jTz_-CKhX+W+ud5iVPprnx0Rp0YbEd4TOsZZ7i_psYnA@mail.gmail.com>
Subject: Re: [PATCH] hisi_lpc: Use acpi_dev_for_each_child()
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 3:34 PM John Garry <john.garry@huawei.com> wrote:
>
> On 29/06/2022 13:55, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of walking the list of children of an ACPI device directly,
> > use acpi_dev_for_each_child() to carry out an action for all of
> > the given ACPI device's children.
> >
> > This will help to eliminate the children list head from struct
> > acpi_device as it is redundant and it is used in questionable ways
> > in some places (in particular, locking is needed for walking the
> > list pointed to it safely, but it is often missing).
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Hi Rafael,
>
> > ---
> >   drivers/bus/hisi_lpc.c |   12 ++++++++----
> >   1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > Index: linux-pm/drivers/bus/hisi_lpc.c
> > ===================================================================
> > --- linux-pm.orig/drivers/bus/hisi_lpc.c
> > +++ linux-pm/drivers/bus/hisi_lpc.c
> > @@ -471,6 +471,12 @@ static int hisi_lpc_acpi_remove_subdev(s
> >       return 0;
> >   }
> >
> > +static int hisi_lpc_acpi_clear_enumerated(struct acpi_device *adev, void *not_used)
> > +{
> > +     acpi_device_clear_enumerated(adev);
> > +     return 0;
> > +}
> > +
> >   struct hisi_lpc_acpi_cell {
> >       const char *hid;
> >       const char *name;
> > @@ -480,13 +486,11 @@ struct hisi_lpc_acpi_cell {
> >
> >   static void hisi_lpc_acpi_remove(struct device *hostdev)
> >   {
> > -     struct acpi_device *adev = ACPI_COMPANION(hostdev);
> >       struct acpi_device *child;
> >
> I got this warn:
>
> drivers/bus/hisi_lpc.c: In function ‘hisi_lpc_acpi_remove’:
> drivers/bus/hisi_lpc.c:489:22: warning: unused variable ‘child’
> [-Wunused-variable]
>   489 |  struct acpi_device *child;
>       |                      ^~~~~
>   CC      drivers/bus/brcmstb_gisb.

I've overlooked that, sorry.  Will send a v2 fixing this shortly.

> With that fixed:
>
> Acked-by: John Garry <john.garry@huawei.com>

Thanks!

> Can you route this through one of your trees?

Yes, I will do that.
