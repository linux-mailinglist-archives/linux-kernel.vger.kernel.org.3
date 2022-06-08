Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07087543011
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbiFHMPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbiFHMPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:15:32 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2B512AE9;
        Wed,  8 Jun 2022 05:15:31 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id i39so8166494ybj.9;
        Wed, 08 Jun 2022 05:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1aZWEN82Z0cY56MtJ5ndwQ+W1emzo6CrCRXt1Oh8kYI=;
        b=ZC4+mYmW0U0rtUxvwUUMJyi1dagjsjzUKAR0ftc8vVsAKW2/j4bIrWgHz3b+gjhWSv
         yGt6Up8W6KNKQQv/XLIRrR1Lv8dgMsnimi9hznVpeSYWuLnkrPba1czv0RIAPuE/+QbZ
         FafwuOQdvQFbgA2IDeCCeQ4KdkDYPdJrpRcACZeB16ybXJCn+wCNOZ80iIqEDcI6lwo8
         b0K6eDLM6/KBSlVZNGbd5BRBxZya1WMxXXPwHANU6t1iZw5UMGQ6ZHUmz/M85jonJFyX
         Mo61ZX891QEaY0sbPLDd1n6MjAZ4Hdh7bp08d/8Y5+tsMKeMDsJOx9lUJYwHgtbAJvt6
         iMLA==
X-Gm-Message-State: AOAM531yqFgRu9PJ64k1YhyaXRUCuFU0NXD22baPaGPJrnBL0um25GjN
        znuVsWC/Pc/8Lf6cHyRIV7i5Wp8NfnytbRJQ8Ns=
X-Google-Smtp-Source: ABdhPJxrP9w6wAx7YCUFKQR8uJR+AUmdqNWjW40bRQlPlEIPZhimRS+TnIphjRvV3V+jfWdUW7B7UkaccookIUhOT9A=
X-Received: by 2002:a25:84ca:0:b0:65c:b5a4:3d0a with SMTP id
 x10-20020a2584ca000000b0065cb5a43d0amr34362425ybm.137.1654690530409; Wed, 08
 Jun 2022 05:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gmO-BDyurQtG4sU5KLfe2mjs7vm5kpJQoAaxYxF57t3g@mail.gmail.com>
 <YqCNuJ3RQX3jIy59@smile.fi.intel.com> <YqCQOAy64heA3GPM@kroah.com>
In-Reply-To: <YqCQOAy64heA3GPM@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Jun 2022 14:15:19 +0200
Message-ID: <CAJZ5v0hxvqYaEXzEKYG++egKVgNk=KUNnMMKRT2pS2S9PN-ibw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] driver core: Introduce device_find_first_child() helper
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Wed, Jun 8, 2022 at 2:04 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 08, 2022 at 02:53:28PM +0300, Andy Shevchenko wrote:
> > On Wed, Jun 08, 2022 at 01:29:08PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Jun 7, 2022 at 10:22 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > ...
> >
> > > I would define it as
> > >
> > > static int match_first(struct device *dev, void *)
> > > {
> > >        return 1;
> > > }
> > >
> > > struct device *device_find_first_child(struct device *parent)
> > > {
> > >         return device_find_first_child(parent, NULL, match_first);
> > > }
> > > EXPORT_SYMBOL_GPL(device_find_first_child);
> > >
> > > which is not that much more overhead.
> >
> > With this we actually may simply provide a match function and it will make the
> > clean ups (like patch 2 in the series) almost the same without introducing a
> > device core call.
> >
> > Something like
> >
> > int device_match_any_for_find(struct device *dev, void *unused)
> > {
> >       return 1;
> > }
> >
> > As I replied to Greg it's pity we can't use device_match_any()...
>
>         int device_match_any(struct device *dev, const void *unused)
>
> How is that not ok to use here?

Because of the const that will be frowned upon by the compiler.

We need to define another device_match_any_relaxed() taking (void *)
as the second argument for this.
