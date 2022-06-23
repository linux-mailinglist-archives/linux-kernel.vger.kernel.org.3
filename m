Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024B8557CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiFWN1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiFWN1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:27:08 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CFD49CA4;
        Thu, 23 Jun 2022 06:27:07 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id q132so2277258ybg.10;
        Thu, 23 Jun 2022 06:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxTVkuTRwT7zaUdBEZjmRQEHWHA9MbFr7dx9PzbNS8w=;
        b=aumTZ1dYKWO6G3HKFPLkcGLIxORRpWlcYb4YSk99REeUE7MLb9DjLSTwSLzKIxRYKp
         f+e+yKjUPoyq+p+QvnCaZCW+ke//fNuSJMXiqYnK29BUSTa0B1tPsZYF8r7TTjAqiEFo
         rblK4QrzdC/1BClJ5cgjkHGdy1BWezfjg2rfPvv9RZMF3gQTDCGhtFB+BYVNWwqM+XD3
         47wh5WKvVE70ShI0+5BgXnfm5K7jioy0xe0scdfzAEjB6YrdtOzNlyg7tNdijltxXcBU
         XOhm+wbIe5Ql/OpDQSNKQPi9r74GjgGvJG/Ge/BXrtR3LhlUOlJMMsfYH7SLtFtg/q/x
         hgJw==
X-Gm-Message-State: AJIora/D2EZHiUrYRIKdWbVY4hzj2uRbQhghLfsF8V7k5b8vkHeCJq1e
        UkdU5WCW/rOcC8frXiVcXf2hshO5UP7ny5iPjU/ZQoWk
X-Google-Smtp-Source: AGRyM1tHqoIBXvJ/qKXGJAn7vF6/FjaDbr0XBkhwJ/ueBXNgIfPFWwxORM0OiHCx5aXQGGQ+VCKyt/V80YugRpmswUI=
X-Received: by 2002:a25:6b50:0:b0:64f:4b33:664 with SMTP id
 o16-20020a256b50000000b0064f4b330664mr9743130ybm.153.1655990826869; Thu, 23
 Jun 2022 06:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <2653857.mvXUDI8C0e@kreacher>
 <9017824.rMLUfLXkoz@kreacher> <YrQf/W/Kmo954hAm@matsya> <CAJZ5v0jY5M-L-XdgY+LT=iSbABzL6cLuSdLiuUEQ+mEjYYk=xA@mail.gmail.com>
 <YrRfd0AvYVn19wck@matsya>
In-Reply-To: <YrRfd0AvYVn19wck@matsya>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Jun 2022 15:26:56 +0200
Message-ID: <CAJZ5v0iRcpVZEGA0w6JaoHOFTM4hVAoUEoJ54n-AVE2StFgrgg@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] soundwire: Use acpi_dev_for_each_child()
To:     Vinod Koul <vkoul@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
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

On Thu, Jun 23, 2022 at 2:41 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 23-06-22, 14:29, Rafael J. Wysocki wrote:
> > On Thu, Jun 23, 2022 at 10:10 AM Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > On 13-06-22, 20:35, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Instead of walking the list of children of an ACPI device directly,
> > > > use acpi_dev_for_each_child() to carry out an action for all of
> > > > the given ACPI device's children.
> > > >
> > > > This will help to eliminate the children list head from struct
> > > > acpi_device as it is redundant and it is used in questionable ways
> > > > in some places (in particular, locking is needed for walking the
> > > > list pointed to it safely, but it is often missing).
> > >
> > > Applied, thanks
> >
> > Thanks, but the export of acpi_dev_for_each_child() is being added by
> > one of the previous patches in the series, so this one will not
> > compile without the rest of the series in the modular case.
>
> Aha, I checked the symbol exists and my test build passed!
> >
> > Is this not a problem?
>
> Yes indeed, so can you give a tag for that and or would you like to taje
> this thru ACPI tree, in that case

I'll take it.

> Acked-By: Vinod Koul <vkoul@kernel.org>

Thank you!
