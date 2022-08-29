Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83165A4EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiH2N4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiH2N4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:56:45 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE4878BF3;
        Mon, 29 Aug 2022 06:56:43 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-324ec5a9e97so197085167b3.7;
        Mon, 29 Aug 2022 06:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3YIHAMs9pgw+Yp7yjbhjkMtpbycGfkcjXzGQS2DX2Vc=;
        b=iGqcCMc8KUwP/pwgKfiOZC3Ake3kAGVnaz1tL4u9r+WQPtHX1jwQp/2/58cXBOnMgn
         9IwBY0PRD8j3g8rVfkLuX16+kfTDi79KjvwOqomUhPFfGTYiwo7Asd4C7mCiTwM3YGtZ
         2KGhhPZDUULi21KwnieZlD4f3pKQ20CMvqYHBLIQ9phZU5UppbzL+DXHxwB4EeuAVHkK
         cQuivsR759FSTTe3dYWYC0dchVn61/alcFJrYOBDtJGP4h1g6WOzCCIIQg/vW6vNlWUW
         o8xCBdTyKLogKBeNN27G+XBwolm2qDayyR+JSY5SMaqBeFySPCUs3wVqBW7Rl1vJr3Wa
         Tigw==
X-Gm-Message-State: ACgBeo1wQgYNYz4fptoNwXupMzD3QOdiDmHJ5v1Q60TFTt0mGNSxLEyq
        MJoASz4uTSOMgxAEmQUiQ5uBndV0dP3hRm4Jm74=
X-Google-Smtp-Source: AA6agR5+EUb2uc+dTmziugS6p+AnBf6wM0lsn55c1khVjxysDdTqUR3/kWdFM/ukHARUYNz0ovAoxMVH54iia/dCzwI=
X-Received: by 2002:a25:b749:0:b0:68f:171f:96bd with SMTP id
 e9-20020a25b749000000b0068f171f96bdmr8962217ybm.137.1661781403216; Mon, 29
 Aug 2022 06:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220828205416.1957305-1-floridsleeves@gmail.com>
In-Reply-To: <20220828205416.1957305-1-floridsleeves@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Aug 2022 15:56:32 +0200
Message-ID: <CAJZ5v0jrQwBh3ToZc-7J69qDJEAZ8+wXPzqjZ+zpxB4a69W-Ng@mail.gmail.com>
Subject: Re: [PATCH v1] drivers/acpi/processor_idle: check the return value of acpi_fetch_acpi_dev()
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 10:54 PM Li Zhong <floridsleeves@gmail.com> wrote:
>
> The return value of acpi_fetch_acpi_dev() could be NULL, which will
> cause null pointer dereference if used in acpi_device_hid().

That's true.

> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  drivers/acpi/processor_idle.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 16a1663d02d4..519f8f741da3 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1117,6 +1117,8 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
>         status = acpi_get_parent(handle, &pr_ahandle);
>         while (ACPI_SUCCESS(status)) {
>                 d = acpi_fetch_acpi_dev(pr_ahandle);
> +               if (!d)
> +                       break;

But shouldn't this be continue?

>                 handle = pr_ahandle;
>
>                 if (strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
> --
> 2.25.1
>
