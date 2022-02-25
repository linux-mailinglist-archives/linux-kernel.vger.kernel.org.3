Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B971C4C494C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiBYPkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240358AbiBYPkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:40:21 -0500
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A66C227597;
        Fri, 25 Feb 2022 07:39:49 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id j12so6616620ybh.8;
        Fri, 25 Feb 2022 07:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GR/V12DMRnmBhcnV69/MsoszncUmgemPWBCEqb7uAFo=;
        b=m10JZXzVRLIm4AZivXGdL5Y1yCdyaWQIHbLPypVEA93zDPifkLOZ+Rhaj7wuQ6+8K+
         qp5mW82ynzQWliptYAN5ghn56vFcafHZh7NEBzPwhrMXyR9KoUDJevx4r66bLWgaPJMA
         B+SZPaWA5iIUPoL4ymXbIRmYBEl0ZlV9si5Fzte4Mqj0yhtWqeSXspIkdZ4aYBtj1R0y
         AgkipalUVWD+RkXe1DEhSBoxvFpb8uagIRbp4itrRzAnG6qSUJSyavJia1rerkkovhnB
         XunqU9udnzKx8kuB3KfiJM4nXSxiqFvZ2rB7BWJrnw8zs7R8ZvVznL6FJDaGkEJUtKVm
         AhHg==
X-Gm-Message-State: AOAM530P7rgUjpfYkOxoCFSfCGYpmRy8S9hBfYN9zvikNpIQKB/yK/RX
        Sd+ZO626Pr6CNmD/jr30YD04lwJ8JWxkp7GvL7E=
X-Google-Smtp-Source: ABdhPJzrx7n2dUleHMsZHJQcp+57rEJCDv9wJM6JngPqQvdEjC+z5wBhZrLOBtGS3O9r22saq3TEeeT6l0ZYLqQQJhw=
X-Received: by 2002:a25:bbc1:0:b0:610:b4ce:31db with SMTP id
 c1-20020a25bbc1000000b00610b4ce31dbmr7698406ybk.482.1645803588829; Fri, 25
 Feb 2022 07:39:48 -0800 (PST)
MIME-Version: 1.0
References: <20220224113807.91771-1-pmenzel@molgen.mpg.de> <20220224113807.91771-3-pmenzel@molgen.mpg.de>
In-Reply-To: <20220224113807.91771-3-pmenzel@molgen.mpg.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Feb 2022 16:39:38 +0100
Message-ID: <CAJZ5v0gLn=EEsLLZBtFUKA9SkK88S1HQxj_Z11sPgnRE9T_RmQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] acpi: exsystem: Warn about sleeps greater than 50 ms
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
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

On Thu, Feb 24, 2022 at 12:38 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Quick boottime is important, so warn about sleeps greater than 50 ms in
> ACPI.
>
> 50 ms is still long compared to distribution Linux kernels reaching initrd
> in 350 ms, so should probably changed to 10 ms, so people are aware
> about this.
>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

First off, as ACPICA material, this should be submitted to the
upstream project via https://github.com/acpica/acpica/.

> ---
>  drivers/acpi/acpica/exsystem.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
> index 00f66af31ffa..bdffb8aac05c 100644
> --- a/drivers/acpi/acpica/exsystem.c
> +++ b/drivers/acpi/acpica/exsystem.c
> @@ -167,6 +167,11 @@ acpi_status acpi_ex_system_do_sleep(u64 how_long_ms)
>
>         acpi_ex_exit_interpreter();
>
> +       if (how_long_ms > 50) {
> +               ACPI_WARNING((AE_INFO,

Second, the log level is somewhat high for something like this.

> +                   "Time parameter %llu > 50 ms. Please contact firmware vendor for more responsive system.", how_long_ms));

Also, I would rephrase the warning message to something like "Firmware
issue: Excessive delay (%llu ms) in ACPI Control Method".

> +       }
> +
>         /*
>          * For compatibility with other ACPI implementations and to prevent
>          * accidental deep sleeps, limit the sleep time to something reasonable.
> --
> 2.35.1
>
