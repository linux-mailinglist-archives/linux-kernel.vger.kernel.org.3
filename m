Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B5E543164
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbiFHNcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239983AbiFHNcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:32:19 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D7B107888;
        Wed,  8 Jun 2022 06:32:18 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id r82so36471970ybc.13;
        Wed, 08 Jun 2022 06:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWIWc3m6UUGk2b7BAY4nGS39aLsojPRMihrhRIW4AJo=;
        b=hbTdXwT6k0wthOifIKiZx5PeBjAIW52j4owzzJe1uJDFpPDatWn6Rl/xDRBKWTof2z
         bWkq4IMEHIoNpDtgVqMBmVCsMp9/9RmhUSnBW4Ow4ikr5LK2LbMNRus/TGG8LiI6oG3L
         XTKfteyzBOaHwZYrqIx0RX8q3bibmdpWqkzhDfbtvWfxXAbvMn7XTTk6BO8VXhTujTU6
         MmtPoDFBnKgMmIxDbL3LSSyjJG95S4GRzj1SBasD+hePw00YNPqEYJrk9E+kLbypI8Rl
         FMdo267g0sL4cd9GJHQZX6NzGzt8SJWtKK8bhd7XdZqoZYOHOqgKcAEsKEmtCFkAUGat
         Y45A==
X-Gm-Message-State: AOAM530zV4OtVT14evoj0Abl97OhHBa8SMBcbyPBzDuEzX8iGUDmGYmb
        ofQHfMXuH13Iz6PPCmXyVd42/VkUyySpIIVZRkI=
X-Google-Smtp-Source: ABdhPJw7pXXVjlaRjA2c5QxH3V0hMYRnaWOK0tMFdRpH/3lbQ0V2ip2yikeCayTO+ohMUm98ATdMMmAVeWJp4Kh5B/Q=
X-Received: by 2002:a25:76d5:0:b0:663:ad77:8d48 with SMTP id
 r204-20020a2576d5000000b00663ad778d48mr12268953ybc.633.1654695137628; Wed, 08
 Jun 2022 06:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gmO-BDyurQtG4sU5KLfe2mjs7vm5kpJQoAaxYxF57t3g@mail.gmail.com>
 <YqCNuJ3RQX3jIy59@smile.fi.intel.com> <YqCQOAy64heA3GPM@kroah.com>
 <CAJZ5v0hxvqYaEXzEKYG++egKVgNk=KUNnMMKRT2pS2S9PN-ibw@mail.gmail.com> <YqCUv55XKmUfe1J5@kroah.com>
In-Reply-To: <YqCUv55XKmUfe1J5@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Jun 2022 15:32:06 +0200
Message-ID: <CAJZ5v0jqD-nwUXFeDMm8w122jonaKJ5y9oBwHh3f6khmKy6Hqg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] driver core: Introduce device_find_first_child() helper
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
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

On Wed, Jun 8, 2022 at 2:23 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 08, 2022 at 02:15:19PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 8, 2022 at 2:04 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jun 08, 2022 at 02:53:28PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Jun 08, 2022 at 01:29:08PM +0200, Rafael J. Wysocki wrote:
> > > > > On Tue, Jun 7, 2022 at 10:22 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > ...
> > > >
> > > > > I would define it as
> > > > >
> > > > > static int match_first(struct device *dev, void *)
> > > > > {
> > > > >        return 1;
> > > > > }
> > > > >
> > > > > struct device *device_find_first_child(struct device *parent)
> > > > > {
> > > > >         return device_find_first_child(parent, NULL, match_first);
> > > > > }
> > > > > EXPORT_SYMBOL_GPL(device_find_first_child);
> > > > >
> > > > > which is not that much more overhead.
> > > >
> > > > With this we actually may simply provide a match function and it will make the
> > > > clean ups (like patch 2 in the series) almost the same without introducing a
> > > > device core call.
> > > >
> > > > Something like
> > > >
> > > > int device_match_any_for_find(struct device *dev, void *unused)
> > > > {
> > > >       return 1;
> > > > }
> > > >
> > > > As I replied to Greg it's pity we can't use device_match_any()...
> > >
> > >         int device_match_any(struct device *dev, const void *unused)
> > >
> > > How is that not ok to use here?
> >
> > Because of the const that will be frowned upon by the compiler.
> >
> > We need to define another device_match_any_relaxed() taking (void *)
> > as the second argument for this.
>
> Or we could cast it away :)

I'm not sure what exactly you mean.  The function pointer signature
doesn't match here.
