Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EAA58DD04
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245147AbiHIRWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245085AbiHIRWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:22:15 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B5124093;
        Tue,  9 Aug 2022 10:22:14 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31f41584236so118814627b3.5;
        Tue, 09 Aug 2022 10:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Y+rfmgrM3WKjt3tFbvF/OiiVhtpO2vIhp7OOayCy0NQ=;
        b=EQyuEWw4zdOmypVrzhqeziyk4zGmJFA0vqJMRd+wK4MQVAWzrhwSWnqv+X6h3HExom
         xCQi2baY+11rhW9qw+5WsRtqEqxuJVWRaQDfxPrw05Rn901VoneLpPBSmPHIrQPgQazZ
         t5JzIRiXKeJI0FDbL79SeXkCKXWUQhsTfOtDCwYH9Lv2JGAnRMJiZyH5VH7iHyUU/L9l
         j/NllTmkwTRAUktACrGvPtQusz1B4fi3ODpkAk7Ws696Fx0VTxjlHX+kPStrKU7sQe91
         6l6LXR8cefhB/ZOkpuK8v7nu4arrLBTLQtCBR5K36jvDyc4kgdZHEMUkhcAVolalPJ9V
         FINQ==
X-Gm-Message-State: ACgBeo01E3UFkxFhu/93uoV/4S4PCXEtk3uLXtpO5e4FEo50quC30kUW
        Yyu+uSStF6M/Rpl9/mY4Y0VmQmYJqsp+eBKSInE=
X-Google-Smtp-Source: AA6agR7EvhuChVGND7jQBRVr6ST13Mv6+IHzyPAcnVAFMynFZUlXnKlPSF6zE+ouqbSkPJOjnLHyImtLXanQtwvymDw=
X-Received: by 2002:a81:ae0a:0:b0:324:59ab:feec with SMTP id
 m10-20020a81ae0a000000b0032459abfeecmr24920169ywh.7.1660065733506; Tue, 09
 Aug 2022 10:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220808211213.1055148-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20220808211213.1055148-1-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Aug 2022 19:22:02 +0200
Message-ID: <CAJZ5v0jS9M8N_dHMnL2vW9g844_0Z4crzRdQFOgjcPYu4-7uLw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: property: Fix error handling in acpi_init_properties()
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        kernel test robot <oliver.sang@intel.com>
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

On Mon, Aug 8, 2022 at 11:12 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> buf.pointer, memory for storing _DSD data and nodes, was released if either
> parsing properties or, as recently added, attaching data node tags failed.
> Alas, properties were still left pointing to this memory if parsing
> properties were successful but attaching data node tags failed.
>
> Fix this by separating error handling for the two, and leaving properties
> intact if data nodes cannot be tagged for a reason or another.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Fixes: 1d52f10917a7 ("ACPI: property: Tie data nodes to acpi handles")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> Hi Rafael,
>
> This should fix the immediate problem. It needs to be figured out why data
> node tagging doesn't work sometimes but that can wait.

Applied, but ->

>  drivers/acpi/property.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 9711482014a6..201a5a9b2671 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -566,13 +566,13 @@ void acpi_init_properties(struct acpi_device *adev)
>                                         &adev->data, acpi_fwnode_handle(adev)))
>                 adev->data.pointer = buf.pointer;
>
> -       if (!adev->data.pointer ||
> -           !acpi_tie_nondev_subnodes(&adev->data)) {
> -               acpi_untie_nondev_subnodes(&adev->data);
> +       if (!adev->data.pointer) {
>                 acpi_handle_debug(adev->handle, "Invalid _DSD data, skipping\n");
>                 ACPI_FREE(buf.pointer);
> +       } else {
> +               if (!acpi_tie_nondev_subnodes(&adev->data))
> +                       acpi_untie_nondev_subnodes(&adev->data);
>         }
> -

-> dropped this empty line removal which is unrelated to the fix (and
the empty line is there on purpose).

>   out:
>         if (acpi_of && !adev->flags.of_compatible_ok)
>                 acpi_handle_info(adev->handle,
> --

Please note that I will not be able to push things after Thursday this
week and throughout the next week, so either this goes in on Thursday
or it will miss 5.20, in which case sorry about that.  We'll see.

Thanks!
