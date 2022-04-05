Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564B74F4A83
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1458067AbiDEWrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573229AbiDES3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:29:21 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA2025C2;
        Tue,  5 Apr 2022 11:27:22 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2eb680211d9so958947b3.9;
        Tue, 05 Apr 2022 11:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDSUXKUMUVWSTSAUnF2dex+MaWNmmjp5ImjClvPiSUM=;
        b=RGO6TAcERqiIMwGt7g6xpxeuTZ2jWgU0HTQAuY9uNfLVvqR1fv/f1cM9zOze2M2LRO
         94gistLEvC+1kHGKS27BtuIZgWhwBEyLX738r4ncDOZdDDpWKNvfiU4S50wPrigkMoa9
         TeYJ3w573rquZtEjNa5iuEhwybzjjv/xnnbE9afOoTSWMmsMAXfpYWJ0zm6tzVRjD1Gg
         WoYWylUY7Pl7sdFUtabxeHrK4lVtZ9lqc1hddhQqFDnEAq7dnWVPY3IJnB+KZPjqwPUj
         URlboPe26EaDAr3ONNBhO8YiXFpXX1XiVWryxek15FSRhwNRLQsir0an381xdTUUxMRZ
         YR5g==
X-Gm-Message-State: AOAM531nZmIE7Go6MGA+t6ku0ZiH/xaSsZWLReMZNWwI9dYKfU6cXOE4
        3UVA1a9+wLkk+bHMwNlQQ/GMh52gDfwz9fLdAt0=
X-Google-Smtp-Source: ABdhPJxvpzZoLalW9oAr6Uo4r58VCzGGEEAfBQWaV0XhBzVYnxUbdaEM7De5H1E6hh6DkbujzDLIdDHaxqNpOx3mbp0=
X-Received: by 2002:a81:bc5:0:b0:2e6:dcfe:bfcb with SMTP id
 188-20020a810bc5000000b002e6dcfebfcbmr4003320ywl.19.1649183241811; Tue, 05
 Apr 2022 11:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220324190950.70486-1-dave@stgolabs.net> <20220324190950.70486-2-dave@stgolabs.net>
In-Reply-To: <20220324190950.70486-2-dave@stgolabs.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Apr 2022 20:27:11 +0200
Message-ID: <CAJZ5v0ibz6R0cNzmLX0NLW7pyYH68XsxXjuZDoF=G4+L5ZB7rg@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal: int340x: Fix bogus acpi_buffer pointer freeing
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Mar 24, 2022 at 8:10 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> It is the caller's responsibility to free only upon ACPI_SUCCESS.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 4954800b9850..0e7931c286ec 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -186,11 +186,11 @@ static int int3400_thermal_run_osc(acpi_handle handle, char *uuid_str, int *enab
>                 ret = *((u32 *)(context.ret.pointer + 4));
>                 if (ret != *enable)
>                         result = -EPERM;
> +
> +               kfree(context.ret.pointer);
>         } else
>                 result = -EPERM;
>
> -       kfree(context.ret.pointer);
> -
>         return result;
>  }
>
> --

Because the code before the change is not incorrect, this is a cleanup
rather than a fix, so I've adjusted the subject a bit and applied this
along with the [2-3/3] as 5.19 material.

Thanks!
