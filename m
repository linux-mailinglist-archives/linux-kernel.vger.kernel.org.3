Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5ADE4B167D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344066AbiBJTmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:42:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344057AbiBJTmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:42:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED1BE49;
        Thu, 10 Feb 2022 11:42:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46419616E1;
        Thu, 10 Feb 2022 19:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7248C340F1;
        Thu, 10 Feb 2022 19:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644522124;
        bh=9iDm8iCvWuilAbXRmz2oEmB2dKN7ZozSVkGI5kkC/TU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IiOD6I42zinpDWSxCJxj7HCw3czEC6JMhgaFJo2m/9nz91kx/vFm++0j28mfmR1uq
         LmeKIzclyMMkVVefp5mhxmv1xABPp3qPY3ZOV+3SMSUy+Daen221cXgD2j13rVE1Je
         YlyW2yCooe8x100cM7PGW+JIYjKtj6qUtTUEJ0TdawTm4WhSpZM0RZ1NOxXAiXTprs
         WemuF0Xjn5zNkiWnoI5w8RyoCJROCbEyMskQ7ZlJWFn+rxocyrx3HA+XvZSFVYQbin
         EoX1MwvqyfFawybXWsz4/pw1LKK2/9nOeb9YMBBhpXtXMSajFCxK8wm6b3cas0IVgP
         MCL0CexLbnaTw==
Received: by mail-wr1-f48.google.com with SMTP id q7so11338578wrc.13;
        Thu, 10 Feb 2022 11:42:04 -0800 (PST)
X-Gm-Message-State: AOAM5335w26+ZCp5KUiilkxnEMJx9rhF3YuC7nRNqf19TSgLOt23WR0J
        zPfU4zcWszEgsH68slSFK5pdY4LVAkOKWSToRpA=
X-Google-Smtp-Source: ABdhPJxqan/6gp2YHh4B2sfjfMPKM/eXNIPCEc6TskCJ4yng+5japaP+5jPB8UMaEVsnTtXI/hT7SexKjPEKaA1tvfc=
X-Received: by 2002:a05:6000:1b88:: with SMTP id r8mr7763785wru.447.1644522122979;
 Thu, 10 Feb 2022 11:42:02 -0800 (PST)
MIME-Version: 1.0
References: <1644518851-16847-1-git-send-email-victor.erminpour@oracle.com>
In-Reply-To: <1644518851-16847-1-git-send-email-victor.erminpour@oracle.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Feb 2022 20:41:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEbGWs74M2CZSm6TWpD11mReFsk8z-UUqJt6b6vDCvAEQ@mail.gmail.com>
Message-ID: <CAMj1kXEbGWs74M2CZSm6TWpD11mReFsk8z-UUqJt6b6vDCvAEQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI/IORT: Fix GCC 12 warning
To:     Victor Erminpour <victor.erminpour@oracle.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 at 19:48, Victor Erminpour
<victor.erminpour@oracle.com> wrote:
>
> When building with automatic stack variable initialization, GCC 12
> complains about variables defined outside of switch case statements.
> Move the variable into the case that uses it, which silences the warning:
>
> ./drivers/acpi/arm64/iort.c:1670:59: error: statement will never be executed [-Werror=switch-unreachable]
>   1670 |                         struct acpi_iort_named_component *ncomp;
>        |                                                           ^~~~~
>
> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>

Please cc people that commented on your v1 when you send a v2.

Still NAK, for the same reasons.


> ---
>  drivers/acpi/arm64/iort.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 3b23fb775ac4..65395f0decf9 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1645,7 +1645,7 @@ void __init acpi_iort_init(void)
>   */
>  phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
>  {
> -       phys_addr_t limit = PHYS_ADDR_MAX;
> +       phys_addr_t local_limit, limit = PHYS_ADDR_MAX;
>         struct acpi_iort_node *node, *end;
>         struct acpi_table_iort *iort;
>         acpi_status status;
> @@ -1667,17 +1667,16 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
>                         break;
>
>                 switch (node->type) {
> +               case ACPI_IORT_NODE_NAMED_COMPONENT: {
>                         struct acpi_iort_named_component *ncomp;
> -                       struct acpi_iort_root_complex *rc;
> -                       phys_addr_t local_limit;
> -
> -               case ACPI_IORT_NODE_NAMED_COMPONENT:
>                         ncomp = (struct acpi_iort_named_component *)node->node_data;
>                         local_limit = DMA_BIT_MASK(ncomp->memory_address_limit);
>                         limit = min_not_zero(limit, local_limit);
>                         break;
>
> -               case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
> +               }
> +               case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
> +                       struct acpi_iort_root_complex *rc;
>                         if (node->revision < 1)
>                                 break;
>
> @@ -1686,6 +1685,7 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
>                         limit = min_not_zero(limit, local_limit);
>                         break;
>                 }
> +               }
>                 node = ACPI_ADD_PTR(struct acpi_iort_node, node, node->length);
>         }
>         acpi_put_table(&iort->header);
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
