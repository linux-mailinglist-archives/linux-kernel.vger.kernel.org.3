Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C111054301D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbiFHMTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbiFHMT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:19:27 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BC06469;
        Wed,  8 Jun 2022 05:19:26 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id i39so8183684ybj.9;
        Wed, 08 Jun 2022 05:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXm6UqPG668jJu1pFGGo5zRe+EK73JQicvrFJX0PTO0=;
        b=E71zyIVoj6/65HzStDKJRaHdk5Cr3dPqS315xjIoCvGFS8VbsUgrAn/umhDPqXSF8P
         qbxmBiQMK4vBTJ+Mt6OZLpV2ySE5bRrO+HAu6RwkbRKSa3Dhz2DWvKgmGQ3nwBmnShHR
         V+pWZn+dN/DMlUyBMWr37ws3ihAESGBqTt+WA1mxcaRs32TE2XEYWF1L0BIVFXIub2FA
         a7uNT+NC7NZMwSMEdWsgGttEtqRcOyt1jXEsS8m3FJIfaEKJ/rtMJ8RG0OxXuU9ejfkr
         ZRE6t7qi/C4h/dRLY/lJ0G5GaG0+Hj0fXMgRWlcVib2cfnqcBGrJAWLNfqtPEIw/+DEG
         v4tA==
X-Gm-Message-State: AOAM533NTjN97V37M7qWFwbZ91SlTv8QAvgqmtr8iBldLS4co0uGEliL
        TDT7Ez2GZ/xu4A7wQuTvL8eKXpRNs2VlsSStmOQNCJEz
X-Google-Smtp-Source: ABdhPJxPfFnY/ZU87b3sgFiKeBcrKE7L6zAKeS0k/RkEDtOnldTiZ2qAoiqFQ4tpst/tI7cuAOfgtDADyZnnvnLA324=
X-Received: by 2002:a25:6b50:0:b0:64f:4b33:664 with SMTP id
 o16-20020a256b50000000b0064f4b330664mr36535414ybm.153.1654690765826; Wed, 08
 Jun 2022 05:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gmO-BDyurQtG4sU5KLfe2mjs7vm5kpJQoAaxYxF57t3g@mail.gmail.com> <YqCNuJ3RQX3jIy59@smile.fi.intel.com>
In-Reply-To: <YqCNuJ3RQX3jIy59@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Jun 2022 14:19:15 +0200
Message-ID: <CAJZ5v0ge=W+GZx2zzHBg4_su1OqSQ9DOovR4RmoU1KJocDqwOw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] driver core: Introduce device_find_first_child() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Wed, Jun 8, 2022 at 1:54 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 08, 2022 at 01:29:08PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Jun 7, 2022 at 10:22 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > I would define it as
> >
> > static int match_first(struct device *dev, void *)
> > {
> >        return 1;
> > }
> >
> > struct device *device_find_first_child(struct device *parent)
> > {
> >         return device_find_first_child(parent, NULL, match_first);
> > }
> > EXPORT_SYMBOL_GPL(device_find_first_child);
> >
> > which is not that much more overhead.
>
> With this we actually may simply provide a match function and it will make the
> clean ups (like patch 2 in the series) almost the same without introducing a
> device core call.

That works too, but IMO it would be a bit cleaner to have the wrapper
defined as a proper function.

>
> Something like
>
> int device_match_any_for_find(struct device *dev, void *unused)
> {
>         return 1;
> }
>
> As I replied to Greg it's pity we can't use device_match_any()...

Well, that only is a matter of adding one more variant of _match_any_ ...
