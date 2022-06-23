Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F35557A83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiFWMlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiFWMlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:41:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C038A49F19;
        Thu, 23 Jun 2022 05:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5902A61C1A;
        Thu, 23 Jun 2022 12:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC524C3411B;
        Thu, 23 Jun 2022 12:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655988091;
        bh=VEKQqqv0GJJfssR5O+DbzVMdKUZxwolWDybsziOqZNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mP4e/YxZ8SvnRHgTYBotpx2q2gyxVmuP+Dj7EWGigubb6+JnPDxEUSwo4E7BK3lZo
         PPrzQlZ3R3kE+AWDrE+4ZzxOBWWqMqBEact1Pe21v5Kpj6hfICQSn4hK+CWKat3Zr3
         4xndA33E9xINreJ8aMNJamSjLFSPHEwJiGhpBYipFfIyJtqatN1jcbyl4mEj69QsOd
         Z/CvQWEZ1gpQF+B+YLMkYPS49aj5cnaVJ4aKeLjdEpOTKLsjE3CrXtVJ139RFmYGsb
         TaRkoyVZ3EN3AMgH41R/CxZrnMbHBJvSNh7g+WoHEyKXZCVxB2LSx2QknwEjQNVvY8
         PV2nSHSQblf5w==
Date:   Thu, 23 Jun 2022 18:11:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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
Subject: Re: [PATCH v2 14/16] soundwire: Use acpi_dev_for_each_child()
Message-ID: <YrRfd0AvYVn19wck@matsya>
References: <1843211.tdWV9SEqCh@kreacher>
 <2653857.mvXUDI8C0e@kreacher>
 <9017824.rMLUfLXkoz@kreacher>
 <YrQf/W/Kmo954hAm@matsya>
 <CAJZ5v0jY5M-L-XdgY+LT=iSbABzL6cLuSdLiuUEQ+mEjYYk=xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jY5M-L-XdgY+LT=iSbABzL6cLuSdLiuUEQ+mEjYYk=xA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-22, 14:29, Rafael J. Wysocki wrote:
> On Thu, Jun 23, 2022 at 10:10 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 13-06-22, 20:35, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Instead of walking the list of children of an ACPI device directly,
> > > use acpi_dev_for_each_child() to carry out an action for all of
> > > the given ACPI device's children.
> > >
> > > This will help to eliminate the children list head from struct
> > > acpi_device as it is redundant and it is used in questionable ways
> > > in some places (in particular, locking is needed for walking the
> > > list pointed to it safely, but it is often missing).
> >
> > Applied, thanks
> 
> Thanks, but the export of acpi_dev_for_each_child() is being added by
> one of the previous patches in the series, so this one will not
> compile without the rest of the series in the modular case.

Aha, I checked the symbol exists and my test build passed!
> 
> Is this not a problem?

Yes indeed, so can you give a tag for that and or would you like to taje
this thru ACPI tree, in that case

Acked-By: Vinod Koul <vkoul@kernel.org>

BR
-- 
~Vinod
