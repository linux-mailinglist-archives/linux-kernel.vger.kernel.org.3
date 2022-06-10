Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A6546738
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348365AbiFJNO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245512AbiFJNOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:14:51 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCFD366AF;
        Fri, 10 Jun 2022 06:14:46 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3135519f95fso101691387b3.6;
        Fri, 10 Jun 2022 06:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ui+ZlqvjfQ4kGZHjfzfTbsf4WxD0gXAASGAQvdxLTE4=;
        b=WnkfXbHlrjXUhu7KG+76UQVO3pEeljbjMVVMILJArZAi4lcTtVwmll20QF0hSsHWhO
         uvHTBK45y9utD8bsAx1KojmWVCUL+neR5hgxHc+oRMOK4Yr6r4n62BREj+HorZA0j4e5
         vOhFfQqaFLEpG1jA7pISfGuLm8u0/PUvOf97j4/aX1J+mo8z3uomC3F5OiaX6kdKyrRu
         P/qY8dl/Lk4G3RbZORQ96kMxcK4I3ewzXOrDOdzj6opPqPeQ274ztEJd1SI9pR6CbMZ0
         m5eaja4MxiNJludk16oz93cVSaWtAzTxI9xAng2oqXacKoG6obKCITh6moO14CxphCku
         ASaw==
X-Gm-Message-State: AOAM533uH+wr6PCbzHIi9XZJcjdfeg+vcy+Rxm7LzGjBdfRDdl9eg/s1
        K6rvtTRDHVaKQwG430pDOu/geBGMVu0ewfL++/E=
X-Google-Smtp-Source: ABdhPJyuHjFnt8ytasn5NVonoZhGYJm9UeC58xTHCEbcHnAEqznn/HVXg5u92OlyVXqsxxEFJaMWvIw2Oe96D+WIVqg=
X-Received: by 2002:a81:3dc6:0:b0:313:cc8a:e39e with SMTP id
 k189-20020a813dc6000000b00313cc8ae39emr560803ywa.196.1654866886071; Fri, 10
 Jun 2022 06:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <3459925.iIbC2pHGDl@kreacher> <YqLpBp0NYhOCCd2X@kuha.fi.intel.com>
In-Reply-To: <YqLpBp0NYhOCCd2X@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Jun 2022 15:14:34 +0200
Message-ID: <CAJZ5v0gPyxRpJ9PTsnBJcY7mf5K7uEoaU+rubc1SPJHwhFWgDQ@mail.gmail.com>
Subject: Re: [PATCH v1 05/16] USB: ACPI: Use acpi_find_child_by_adr()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
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

On Fri, Jun 10, 2022 at 8:47 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Thu, Jun 09, 2022 at 03:56:42PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of walking the list of children of an ACPI device directly
> > in order to find the child matching a given bus address, use
> > acpi_find_child_by_adr() for this purpose.
> >
> > Apart from simplifying the code, this will help to eliminate the
> > children list head from struct acpi_device as it is redundant and it
> > is used in questionable ways in some places (in particular, locking is
> > needed for walking the list pointed to it safely, but it is often
> > missing).
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/usb/core/usb-acpi.c |    9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> >
> > Index: linux-pm/drivers/usb/core/usb-acpi.c
> > ===================================================================
> > --- linux-pm.orig/drivers/usb/core/usb-acpi.c
> > +++ linux-pm/drivers/usb/core/usb-acpi.c
> > @@ -127,17 +127,10 @@ out:
> >  static struct acpi_device *usb_acpi_find_port(struct acpi_device *parent,
> >                                             int raw)
> >  {
> > -     struct acpi_device *adev;
> > -
> >       if (!parent)
> >               return NULL;
> >
> > -     list_for_each_entry(adev, &parent->children, node) {
> > -             if (acpi_device_adr(adev) == raw)
> > -                     return adev;
> > -     }
> > -
> > -     return acpi_find_child_device(parent, raw, false);
> > +     return acpi_find_child_by_adr(parent, raw);
> >  }
> >
> >  static struct acpi_device *
>
> I think usb_acpi_find_port() can also be dropped now.

Yes, it can.

I'm dropping it in the new version of the patch to be posted.
