Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CB454515D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbiFIP4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiFIP4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:56:38 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929B249F14;
        Thu,  9 Jun 2022 08:56:37 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id r82so42435079ybc.13;
        Thu, 09 Jun 2022 08:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvtAx+cq822U1n+fiU6/l7+rvDRHb6xJ+jG+fs2wJOc=;
        b=2Of0x5SSXOoSTjaQucNrJdcx8eEEZnOX/FIr3bZ3q1T8XCj/mcqoXDspgOv9JB+oJV
         AKjhqCWvRt0DHc+c2bw7O/GeCRmyUibIcjgfOl9WBEZUW/VNa/J63XaDj8cHXHxQp5Zx
         vQO7G09YzaN3/S4AN8BHRpfsDymAvTHvdCcx/JKV+P5j1nkGgHIV0k9NlER3bAFYeZgH
         N4zKPfTDK7srXyanY0sbz0ibjPh4Bl5rci4gqSnWeA3BmXDiUFY6m27HjzmM640l137U
         bI86K2ljHv66yqAkLNduxpEQyYCI8ot6uFl4IfxhQrXAdiUKKjCRi4bZHba6FPyPzZKt
         84Rg==
X-Gm-Message-State: AOAM532sAv5ADLGf2TjK0I5gYjNSZbafRKMgJDPW67DUgQTcYpRxX6Mh
        PJgdcLKN8AHhyEDMwWMecpdBplVLQuTUoCicwxE=
X-Google-Smtp-Source: ABdhPJzd8/eT8mnbCY0ZFPYru4ILdn+tBvskGH0ryfRL7NGkvVJrG8nch90H84mRjyalwCUQJzVfJGZ3hzTNsR+Z/Nc=
X-Received: by 2002:a25:84ca:0:b0:65c:b5a4:3d0a with SMTP id
 x10-20020a2584ca000000b0065cb5a43d0amr40226725ybm.137.1654790196789; Thu, 09
 Jun 2022 08:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <44750652.fMDQidcC6G@kreacher> <YqIWRnwyqXZppuxN@smile.fi.intel.com>
In-Reply-To: <YqIWRnwyqXZppuxN@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jun 2022 17:56:25 +0200
Message-ID: <CAJZ5v0iDkvg0bK6ywfZCoBfam3hw1Qs3UarJ4MaKLK0rg++cag@mail.gmail.com>
Subject: Re: [PATCH v1 12/16] platform/x86/thinkpad_acpi: Use acpi_dev_for_each_child()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>
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

On Thu, Jun 9, 2022 at 5:49 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jun 09, 2022 at 04:09:45PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of walking the list of children of an ACPI device directly,
> > use acpi_dev_for_each_child() to carry out an action for all of
> > the given ACPI device's children.
>
> ...
>
> > +     rc = acpi_dev_for_each_child(device, tpacpi_evaluate_bcl, NULL);
> > +     if (rc > 0)
> > +             return rc;
> >
> > +     return 0;
>
> It can be simply 'return acpi_dev_for_each_child();', no?

It can.

> AFAICS the caller is prepared for negative returns.

It will not return negative though unless the ACPI tables are horribly broken.
