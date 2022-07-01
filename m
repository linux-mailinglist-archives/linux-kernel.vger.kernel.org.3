Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE80756390A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 20:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiGASTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiGASTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:19:33 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D2115706;
        Fri,  1 Jul 2022 11:19:32 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id x184so5354970ybg.12;
        Fri, 01 Jul 2022 11:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8kR/eUTqvh3iNFusTLos2UD0LUnTcyRYTp4W2CCxSJE=;
        b=s3+073z7F52v7p2akPPKHAIhtS8Rhk+We7iDIlnRMu0xZLVovYUijjHhx+zzWsaF8h
         CeWoBNdipAxwuUeHQSJDqFae4MrEIuWQQA8Y3j4QltPxLn39QhoiGhkkkiy52+UMnA6z
         eNpSjpBJR+bTVtig/5dMLnOYpulPdG3WqSzRqqEA4K+QMRHFcQ4lwMtbwfGRmc6WncJs
         Zai369cYTUhCZkEOLF/Qaw4ZdNFuk2Za0/nbiNmg1fPA7TqOok3jIBFIJOWZya6NNSPN
         SC6pDeN0JYEF0zIlRnJaxbIDFId9TbipQYqQH7vTW3EPTBASLLh2ACnwEuKCXAwFCsxN
         HNOQ==
X-Gm-Message-State: AJIora89NDxkEqTfuEL0nXP1aas5vqbgTlT8c/VhfMMxPKDJBb0vU/gm
        n2qUgXx7kwaVJcetPrPlBUNVbRS/S2xVK9Iamqw=
X-Google-Smtp-Source: AGRyM1tM2DtxGMR94o7YZ1RzIQTJXRmJ1750je/AQJQoqKm4R8pVE0mv4VSutu4NZHOIlo7hqkAkcL/iuSnz9L91HsU=
X-Received: by 2002:a25:ae26:0:b0:66d:1fdc:263c with SMTP id
 a38-20020a25ae26000000b0066d1fdc263cmr17084720ybj.137.1656699571793; Fri, 01
 Jul 2022 11:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher> <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
In-Reply-To: <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Jul 2022 20:19:18 +0200
Message-ID: <CAJZ5v0j9Q1wXOvQbaZRqG4FvWVMwCymMZ4pEKxAu7BXwLof4EA@mail.gmail.com>
Subject: Re: [PATCH v3] hisi_lpc: Use acpi_dev_for_each_child()
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
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

On Fri, Jul 1, 2022 at 12:49 PM John Garry <john.garry@huawei.com> wrote:
>
> On 30/06/2022 19:13, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] hisi_lpc: Use acpi_dev_for_each_child()
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
> > While at it, simplify hisi_lpc_acpi_set_io_res() by making it accept
> > a struct acpi_device pointer from the caller, instead of going to
> > struct device and back to get the same result, and clean up confusion
> > regarding hostdev and its ACPI companion in that function.
> >
> > Also remove a redundant check from it.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> This change itself looks fine and I quickly tested, so:
> Reviewed-by: John Garry <john.garry@huawei.com>
>
> However Yang Yingliang spotted a pre-existing bug in the ACPI probe and
> sent a fix today (coincidence?):
>
> https://lore.kernel.org/lkml/20220701094352.2104998-1-yangyingliang@huawei.com/T/#u
>
> And they conflict. This code has been this way for years, so I just
> suggest Yang Yingliang resends the fix on top off Rafael's change.

Well, as I've just said, I can apply both patches just fine.
