Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CBC4E4594
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbiCVRzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbiCVRzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:55:32 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50166BCAF;
        Tue, 22 Mar 2022 10:54:04 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2e5e9025c20so116778447b3.7;
        Tue, 22 Mar 2022 10:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2A9hIX+HQzPzacEyBKyVneC9YjFuPVHNWbb21zj8QU=;
        b=b05m3w+QWGTaFatw0nRiHUlLxYUm9G1kS0aNRNiwzkWOG3UN+mN/fwfomC2iC8n2Jp
         mV8FAGp9r7HPL1mEz9O1++fR4iea9ltltwCQB/XxPzBdTy8A3s70nbkyxN21qNAnDvxf
         pIv4I7Tk20znguavNdbZlj6VAadSSdq1J4xPitSfYQL82PK+NNBrIsMvLyGlSNIwUkZS
         5IJNXn4cc0UXB0Rk2ZjPr9QedBQIpyIEPupYjPrwVsUKKVNHH8z/CvYqxygrw2kJL2Wg
         OpEZ25Q3bxtYJx0kj1qNnRbc6gM2IeQR8tOzIa55n49hjR6ECjUZxIcppxHsBkchfl6Q
         zLLw==
X-Gm-Message-State: AOAM531qDRrWiSXmAgk3wpSlU2/R3GxOo4GC3Xe0C03/19MVNNbLkBj4
        Xvws0QfC0/N1D9ULiA2iUlDId1MQSVb5FW7xS1I=
X-Google-Smtp-Source: ABdhPJxrrmq57Qy7p4jJcOHKeS9O/zECM/lR6yYz1AZZQ9XvxZuhAHrZPTrEfyA96QTfkVgNecz8KD//Av+Dz+158cA=
X-Received: by 2002:a81:508b:0:b0:2e5:9904:8655 with SMTP id
 e133-20020a81508b000000b002e599048655mr31543759ywb.196.1647971643562; Tue, 22
 Mar 2022 10:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220319215447.2625681-1-jakobkoschel@gmail.com>
In-Reply-To: <20220319215447.2625681-1-jakobkoschel@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Mar 2022 18:53:22 +0100
Message-ID: <CAJZ5v0iRvaRyWEZqBxgx5juXUc6Oec5tsiiXfFPd_JGBMKVvJQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI, APEI: fix using the correct variable for sizeof()
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
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

On Sat, Mar 19, 2022 at 10:55 PM Jakob Koschel <jakobkoschel@gmail.com> wrote:
>
> While the original code is valid, it is not the obvious choice for the
> sizeof() call and in preparation to limit the scope of the list iterator
> variable the sizeof should be changed to the size of the variable
> being allocated.
>
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/acpi/apei/apei-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index c7fdb12c3310..33b7fbbeda82 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -319,7 +319,7 @@ static int apei_res_add(struct list_head *res_list,
>         if (res_ins)
>                 list_add(&res_ins->list, res_list);
>         else {
> -               res_ins = kmalloc(sizeof(*res), GFP_KERNEL);
> +               res_ins = kmalloc(sizeof(*res_ins), GFP_KERNEL);
>                 if (!res_ins)
>                         return -ENOMEM;
>                 res_ins->start = start;
>
> base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
> --

Applied as 5.18-rc material, thanks!
