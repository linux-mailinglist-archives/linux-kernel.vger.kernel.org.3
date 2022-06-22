Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926CA5546C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357756AbiFVLrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355742AbiFVLrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:47:19 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B7335256;
        Wed, 22 Jun 2022 04:47:17 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id u9so19580412ybq.3;
        Wed, 22 Jun 2022 04:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9G0m5h5tEL+v3rqcpmcGX0SX814uyxHrxPQmImDaRts=;
        b=WlJaD6vtA5MtJAwFtitGUPSzlmlJ1BS4V1u78iX5kPv5q0zLykM8eKVAKoem25tJAf
         syBh8O2kcXNVXNwY+51Dbe2vLwlhoXZOlvhlEgyrenNNyHMzRxWHT1bSxxnfYTze7x4q
         yMVh0iRZEwtiCbN/VqoOrfuyN15GDA4ikTGEngffnCnJQ+sQR3DwMrwTCOULf3BIVXb8
         cIu+w270nhKwbE+wqq0YxfEycDbM+FCj8nCAG10dVQvs8yhHVzu1kSg6EaZEuzJgyQqe
         403scAfyM1n0juBOKJxoH49wIgaD8AlCrNHBbFJJF35DTo+3I/QAUXHioMVw/73mQFdM
         tfmg==
X-Gm-Message-State: AJIora+vJXC0s1gBExVVWDx7oN9Qob775TrroKPH1kOkBk94RQxG6UEz
        osJQiO/RVBs1X2h7L+aZ6o51ui0ShKZg92MfiTM=
X-Google-Smtp-Source: AGRyM1uQpWaGytZj64Anw2lr4RSLcvw2joZ2mbIGJ5VWxqoBTAcGKfxy4p98mpKgqE/LwF+k96Tkcc5Whw/4hlteUGA=
X-Received: by 2002:a25:d841:0:b0:668:ab2f:7b01 with SMTP id
 p62-20020a25d841000000b00668ab2f7b01mr3256535ybg.482.1655898437141; Wed, 22
 Jun 2022 04:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220621192034.3332546-1-sudeep.holla@arm.com> <20220621192034.3332546-2-sudeep.holla@arm.com>
In-Reply-To: <20220621192034.3332546-2-sudeep.holla@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Jun 2022 13:47:06 +0200
Message-ID: <CAJZ5v0huqb1+RGD8De0EDM4xbjqin6wCBUsh6pcR=W9rXWw8JA@mail.gmail.com>
Subject: Re: [PATCH v4 01/20] ACPI: PPTT: Use table offset as fw_token instead
 of virtual address
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

On Tue, Jun 21, 2022 at 9:20 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> There is need to use the cache sharing information quite early during
> the boot before the secondary cores are up and running. The permanent
> memory map for all the ACPI tables(via acpi_permanent_mmap) is turned
> on in acpi_early_init() which is quite late for the above requirement.
>
> As a result there is possibility that the ACPI PPTT gets mapped to
> different virtual addresses. In such scenarios, using virtual address as
> fw_token before the acpi_permanent_mmap is enabled results in different
> fw_token for the same cache entity and hence wrong cache sharing
> information will be deduced based on the same.
>
> Instead of using virtual address, just use the table offset as the
> unique firmware token for the caches. The same offset is used as
> ACPI identifiers if the firmware has not set a valid one for other
> entries in the ACPI PPTT.
>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/pptt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Hi Rafael,
>
> If you are happy with this change, can you provide Ack, so that it can be
> merged together with other changes ?

No objections:

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 701f61c01359..763f021d45e6 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -437,7 +437,8 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>                 pr_debug("found = %p %p\n", found_cache, cpu_node);
>                 if (found_cache)
>                         update_cache_properties(this_leaf, found_cache,
> -                                               cpu_node, table->revision);
> +                                               ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node, table)),
> +                                               table->revision);
>
>                 index++;
>         }
> --
> 2.36.1
>
