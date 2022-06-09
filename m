Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B49545171
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344690AbiFIP6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbiFIP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:58:48 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576401D687D;
        Thu,  9 Jun 2022 08:58:47 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id x187so14946698ybe.2;
        Thu, 09 Jun 2022 08:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snkbXXdh1Awqy9vBJuh+GlPV3Fw82tGOyyClJidX3GY=;
        b=t6SxJxoaSi7zwAe1E1vHX54lDvXJ72Bimm+agokSLSgnO4fSkZbw26NLUGb65RSoDa
         6R8RqXBsrsTyU1NkEy5MP2MplZQdrJIznLONBxssrYAxnZhfXR4cnA7e1JBdojXPZDOS
         ldMcfsgXHE61h3z3FAbFzXInjI74PNk+baRqTMzcccBAEj01+1elil7OOLkCaMYKqkll
         9ioyJ3Z2eWr/jyTpyEleHr941JBTEyCyQc9QnIeSnuBL/7WsVRniZBT4EC/FOICKweU1
         5UHEri9D5z57PsU8hHk85W1VLGR/X8+agijw6sYTIF9Dk8M95Sa3w/8l3ZzdKxyO5ojL
         hlAw==
X-Gm-Message-State: AOAM533P3Dy9z90M/TIH7PetbRjbclW4YNQRUliHvM4XCObTXMJTg9bt
        s6nlJrT+NobK5sUygOebqIJ8jZ4K0pLEAP7P9P8=
X-Google-Smtp-Source: ABdhPJz7AvCNJQJGv0DMzJoDUnP/1zXBNgDlELj8b9KOGsRVncvEdxK81mITkd6fcJzYppH83lwZfu7dM4WEqwRlutU=
X-Received: by 2002:a5b:e92:0:b0:664:2bbb:98a9 with SMTP id
 z18-20020a5b0e92000000b006642bbb98a9mr4822186ybr.482.1654790326622; Thu, 09
 Jun 2022 08:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <3131424.5fSG56mABF@kreacher> <YqIRv8xnGciF2wBd@smile.fi.intel.com>
In-Reply-To: <YqIRv8xnGciF2wBd@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jun 2022 17:58:35 +0200
Message-ID: <CAJZ5v0gOHMezg3YP=g4JG98D-e3roHy7eh8kZwPszGpXZ+Yu4w@mail.gmail.com>
Subject: Re: [PATCH v1 06/16] ACPI: container: Use acpi_dev_for_each_child()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
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

On Thu, Jun 9, 2022 at 5:29 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jun 09, 2022 at 03:58:24PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of walking the list of children of an ACPI device directly,
> > use acpi_dev_for_each_child() to carry out an action for all of
> > the given ACPI device's children.
>
> ...
>
> > +     return acpi_dev_for_each_child(ACPI_COMPANION(&cdev->dev),
> > +                                    check_offline, NULL);
>
> I would find this on one line better and not missing important details after
> 80th character.

I see that you've made similar comments on a few other patches.

I'll change all of them to be one line (longer that 80 chars), but
OTOH there are people who still don't like that.
