Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179AE557A55
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiFWM34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiFWM3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:29:53 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D6A40E4A;
        Thu, 23 Jun 2022 05:29:52 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id v81so35593126ybe.0;
        Thu, 23 Jun 2022 05:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kzFX9uPlDUEYsAhV34ZtAjxOc+U6+JKZhTmu1w/6a+Y=;
        b=OcshZDIIsOlStcxW+OxcdhKdeTQNfAzbaDalVsQ8gfbDQ1YMlKhWR2IAFm5jzqMkuy
         jeNtsnTvpVN/qZODtV2z4y1cA5OTVsXkJrdF+PIYZ781No8tKJQsgMh86+Buqaq5p49E
         Es8S6fcWRZGH57KkakOqp5Z+Oq+ac+N1XfDNptbSgGZb369tALXPnKXD5eOXrky2AdqE
         h9ZG2Xr8s6RmGuni2Ra2RhE/E6uc9HA6FdVb3D3AJNWnutobWE1HUljv5g7N9VFkZISA
         4ELDcvJ4NnDm9jNwA5Kkp2coOggr16xbYzW2tX1rNVjAHlHS7YL3MspDIYAj6ad2rrbi
         2a2w==
X-Gm-Message-State: AJIora/HN4btXhGbjGstTQHodFa/82BtDRLxmLTXFT94Qa2DHOZHCTxz
        9FrVVLotNL6q9kIs7h0o997O2AsG/vaW6OeFBDM9g+dKWFY=
X-Google-Smtp-Source: AGRyM1tXGaLDWsFNRmpcUvDiQXcvKf5vbvGE0SYSdjd6pSKBEWMK4GtCcbw3Fr8yNYZofzzakRnR88Z81ekER5srYkw=
X-Received: by 2002:a25:d841:0:b0:668:ab2f:7b01 with SMTP id
 p62-20020a25d841000000b00668ab2f7b01mr9116719ybg.482.1655987391906; Thu, 23
 Jun 2022 05:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <2653857.mvXUDI8C0e@kreacher>
 <9017824.rMLUfLXkoz@kreacher> <YrQf/W/Kmo954hAm@matsya>
In-Reply-To: <YrQf/W/Kmo954hAm@matsya>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Jun 2022 14:29:41 +0200
Message-ID: <CAJZ5v0jY5M-L-XdgY+LT=iSbABzL6cLuSdLiuUEQ+mEjYYk=xA@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] soundwire: Use acpi_dev_for_each_child()
To:     Vinod Koul <vkoul@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Thu, Jun 23, 2022 at 10:10 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 13-06-22, 20:35, Rafael J. Wysocki wrote:
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
>
> Applied, thanks

Thanks, but the export of acpi_dev_for_each_child() is being added by
one of the previous patches in the series, so this one will not
compile without the rest of the series in the modular case.

Is this not a problem?
