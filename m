Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EF054E8AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiFPRbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiFPRbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:31:34 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C4F2AE0E;
        Thu, 16 Jun 2022 10:31:33 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id t1so3330397ybd.2;
        Thu, 16 Jun 2022 10:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irnPXDDs9giqZixb3bVvb0MoUIRIDyuwHiNhzsO5+C4=;
        b=4hK5hLrqQ3HzQqlkrFWj7oCH/NdTeQ1ZX9JZ07dXs3AwQ/gW9hckpNmXOrva4I6M+h
         /WEC45HQdR8QFbgo9v/yqIGmkrVI6GCUH3mCsDK6X6myYVCKeMBhXWYqE92MFZ2o5b6i
         xwOBjO6yi5Ew0R6OEn35FKDRuE+HHMoUYUXJANQk7u2MLjPZvcu3uHK/cz+hxIAFimBh
         wZh/VJYQUSDCYaafxEI7+O3//WPwZyQFqb5nNVcY4r0KFW97ooT2DEsXAEf+WGLKo+s+
         sa7RnKoZOllMnKBS/uXgsBbjX9aEzj+lNCwGnDsmC8gMK0s6OzlNv+LGkifBDqt1JhNY
         skhw==
X-Gm-Message-State: AJIora+DimyjG8F+2rpWBxR99sArFv9vZWjwY3PhzXONS5qDTCD9o/+J
        SA6NNn8JY0Oi+R8KEHKVk1+NWADIdkTxs86atsU=
X-Google-Smtp-Source: AGRyM1vOEjiPb25k6E6zUt4jvZQIEK/MmQe5h6fqDF85t8MOVMtMD693ctQIewxPENLk6VF/02yz4vAev58TJ4Ji1qQ=
X-Received: by 2002:a25:84ca:0:b0:65c:b5a4:3d0a with SMTP id
 x10-20020a2584ca000000b0065cb5a43d0amr6539892ybm.137.1655400692553; Thu, 16
 Jun 2022 10:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <2653857.mvXUDI8C0e@kreacher>
 <2726954.BEx9A2HvPv@kreacher> <Yqpfj5sa3x/gmZmM@google.com>
In-Reply-To: <Yqpfj5sa3x/gmZmM@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Jun 2022 19:31:21 +0200
Message-ID: <CAJZ5v0gFjgWbxVLe63Xfc+kfmfPzRkZ+72eLqiKDm68agT-ugA@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] mfd: core: Use acpi_dev_for_each_child()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Thu, Jun 16, 2022 at 12:39 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 13 Jun 2022, Rafael J. Wysocki wrote:
>
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
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >
> > v1 -> v2:
> >    * Add R-by from Andy.
> >
> > ---
> >  drivers/mfd/mfd-core.c |   31 ++++++++++++++++++++++++-------
> >  1 file changed, 24 insertions(+), 7 deletions(-)
>
> Applied, thanks.

Thank you!

Can you please expose a branch containing it for integration?

The last patch in the series depends on this one.
