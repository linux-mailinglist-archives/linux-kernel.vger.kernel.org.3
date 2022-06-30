Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381E9561AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 14:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbiF3MsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 08:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiF3MsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:48:18 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ED8BC1D;
        Thu, 30 Jun 2022 05:48:14 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id o19so26993857ybg.2;
        Thu, 30 Jun 2022 05:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SwiP+hf2YNC8Lbe3gvH/02qMr4vvCVdAX/mAw68bS3Q=;
        b=5Mu5tKayaoCPxNCDIOf8k4X/TaA1Dj67t6we7+D0A/n+HwjoshPiJXCI1VrPIYVu5J
         2KlDGSYLQqbQzVoh/GCZWFEeyftn84f1WH7cdGgvE7H2/yqeF7+JsIXYTcuWU+O+CFEj
         nHF6+A+B6QpFVcg/Q/GpDDl31cRPtgJltK+CsW8+XbJhXPGsr89D9sPtGQoiZyr+yL0b
         Hh8QS9PczaHCtTyVBKg5Z7tfNLXDPUAt6DXX/IzVHF3Y5ZLM1ZcnLjTEILz8tBGRdsH0
         QXk5xgYNSNelBOoNKnMMGqjJrcYGEc2FyYlS1sk8QyCSLWwzkV6O66WsTk/sVRKECZXZ
         WZpA==
X-Gm-Message-State: AJIora8y8pkN6Wssp/5cJIGA6n8VCECc3iXHXTAPIQtJzYUEJhUV+iJs
        a6BcMxxPB1cEhNwpInBLKJODYApLG19azq90Lz0=
X-Google-Smtp-Source: AGRyM1vfen4G0QN1GhcTeZzI9a2qKM2TeKsnTGcHqsA97qz3JsW/rfsEJzpmBur3Sl5CwFJPTMLWVuFfIapQ1lj2+qk=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr8951994ybm.482.1656593293788; Thu, 30
 Jun 2022 05:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
In-Reply-To: <2657553.mvXUDI8C0e@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Jun 2022 14:48:02 +0200
Message-ID: <CAJZ5v0jNOsAXSuX9dw9N3w12Y_nq62Z=OL4QQTwH=OnReGpQvA@mail.gmail.com>
Subject: Re: [PATCH v2] hisi_lpc: Use acpi_dev_for_each_child()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Wed, Jun 29, 2022 at 3:47 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Instead of walking the list of children of an ACPI device directly,
> use acpi_dev_for_each_child() to carry out an action for all of
> the given ACPI device's children.
>
> This will help to eliminate the children list head from struct
> acpi_device as it is redundant and it is used in questionable ways
> in some places (in particular, locking is needed for walking the
> list pointed to it safely, but it is often missing).

I've overlooked another usage of the children list in hisi_lpc, in
hisi_lpc_acpi_probe(), and eliminating that one is a bit more
complicated.

So please scratch this one and I will send a v3 when 0-day tells me
that it builds.

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: John Garry <john.garry@huawei.com>
> ---
>
> -> v2:
>    * Drop unused local variable (John).
>    * Add ACK from John.
>
> ---
>  drivers/bus/hisi_lpc.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> Index: linux-pm/drivers/bus/hisi_lpc.c
> ===================================================================
> --- linux-pm.orig/drivers/bus/hisi_lpc.c
> +++ linux-pm/drivers/bus/hisi_lpc.c
> @@ -471,6 +471,12 @@ static int hisi_lpc_acpi_remove_subdev(s
>         return 0;
>  }
>
> +static int hisi_lpc_acpi_clear_enumerated(struct acpi_device *adev, void *not_used)
> +{
> +       acpi_device_clear_enumerated(adev);
> +       return 0;
> +}
> +
>  struct hisi_lpc_acpi_cell {
>         const char *hid;
>         const char *name;
> @@ -480,13 +486,9 @@ struct hisi_lpc_acpi_cell {
>
>  static void hisi_lpc_acpi_remove(struct device *hostdev)
>  {
> -       struct acpi_device *adev = ACPI_COMPANION(hostdev);
> -       struct acpi_device *child;
> -
>         device_for_each_child(hostdev, NULL, hisi_lpc_acpi_remove_subdev);
> -
> -       list_for_each_entry(child, &adev->children, node)
> -               acpi_device_clear_enumerated(child);
> +       acpi_dev_for_each_child(ACPI_COMPANION(hostdev),
> +                               hisi_lpc_acpi_clear_enumerated, NULL);
>  }
>
>  /*
>
>
>
