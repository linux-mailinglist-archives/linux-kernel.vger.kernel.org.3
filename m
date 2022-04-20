Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C266B508C27
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380223AbiDTPep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380112AbiDTPel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:34:41 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1E13CA40;
        Wed, 20 Apr 2022 08:31:54 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2ef5380669cso22043487b3.9;
        Wed, 20 Apr 2022 08:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BX4DYIsh9shdL0wVWNesEbyhwwCB5uGYwoFJu/5ZDOA=;
        b=eFGAteg8FIXSzuyiBTJXzdufzug4fX/YNtM8ZJNm8qFZpXhKi3PLhxa8I7zDofBNM6
         JnsTve2hr3exZcuXUCAPSUHhqgKl2Lur/tmQql1ar4qH9llqq+iFJzpzOk2F9SCmtknm
         IcwYX28QsCCxQ+qSTCmmMnx4+/sDOX6eQP2XDXXppEm/3N1PetVrFBrjP8bNdhqeCPv8
         7synREt5+bc5YxAFHeVn8/Il0a+V1bImkmUC50WNw+kIFfwz8EOp+Il154jfIbMOgBvM
         rtvrwwItvfyhPeejOD3DcovFZxkVA66u+BW95Kv+zldTuXbhuZsjadDfdBKu2Uo9eOVj
         Uvig==
X-Gm-Message-State: AOAM533ywHNKIHEtndzy99qQImPUtS/iURzbKU1ADOpSrNwDbHLT3Wem
        SgNctbzQcir7gF4a+rDDuAHUb4dXRDHHkxZ+s6Hqz1X+zyg=
X-Google-Smtp-Source: ABdhPJx/esx+nly4Faz952uAqt/+ztWg0bemjimUpNFF9AVlh6yAb7iPTGu7hoW4PeNdbXsPUA7GPhieyCZyDrNQu/s=
X-Received: by 2002:a81:b89:0:b0:2eb:e9e6:470a with SMTP id
 131-20020a810b89000000b002ebe9e6470amr21757661ywl.7.1650468713921; Wed, 20
 Apr 2022 08:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220419205432.46021-1-bwicaksono@nvidia.com> <20220419205432.46021-2-bwicaksono@nvidia.com>
In-Reply-To: <20220419205432.46021-2-bwicaksono@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Apr 2022 17:31:43 +0200
Message-ID: <CAJZ5v0jUZSSvMGYhu44rSnEXmVve-wKXkUf-U_qy0ojn4v6kXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPICA: Add support for ARM Performance Monitoring
 Unit Table.
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:55 PM Besar Wicaksono <bwicaksono@nvidia.com> wrote:
>
> ACPICA commit 002165ecc0a3dc703bb24c789aaa02fdada01675
>
> The specification of this table is described in
> "ARM Performance Monitoring Unit Architecture 1.0 Platform Design Document"
> ARM DEN0117.
>
> This patch adds the necessary types and support for
> compiling/disassembling APMT.
>
> Link: https://github.com/acpica/acpica/commit/002165ec
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

It should be equivalent to this patch:

https://patchwork.kernel.org/project/linux-acpi/patch/3370028.QJadu78ljV@kreacher/

present in linux-next.

If the other patch in the series is ACKed by the ARM64 ACPi people, I
can take it too.

Thanks!

> ---
>  include/acpi/actbl2.h | 81 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 16847c8d9d5f..8fc5cf318c15 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -25,6 +25,7 @@
>   * the wrong signature.
>   */
>  #define ACPI_SIG_AGDI           "AGDI" /* Arm Generic Diagnostic Dump and Reset Device Interface */
> +#define ACPI_SIG_APMT           "APMT" /* Arm Performance Monitoring Unit table */
>  #define ACPI_SIG_BDAT           "BDAT" /* BIOS Data ACPI Table */
>  #define ACPI_SIG_IORT           "IORT" /* IO Remapping Table */
>  #define ACPI_SIG_IVRS           "IVRS" /* I/O Virtualization Reporting Structure */
> @@ -258,6 +259,86 @@ struct acpi_table_agdi {
>
>  #define ACPI_AGDI_SIGNALING_MODE (1)
>
> +/*******************************************************************************
> + *
> + * APMT - ARM Performance Monitoring Unit Table
> + *
> + * Conforms to:
> + * ARM Performance Monitoring Unit Architecture 1.0 Platform Design Document
> + * ARM DEN0117 v1.0 November 25, 2021
> + *
> + ******************************************************************************/
> +
> +struct acpi_table_apmt {
> +       struct acpi_table_header header;    /* Common ACPI table header */
> +};
> +
> +#define ACPI_APMT_NODE_ID_LENGTH                4
> +
> +/*
> + * APMT subtables
> + */
> +struct acpi_apmt_node {
> +       u16                                  length;
> +       u8                                   flags;
> +       u8                                   type;
> +       u32                                  id;
> +       u64                                  inst_primary;
> +       u32                                  inst_secondary;
> +       u64                                  base_address0;
> +       u64                                  base_address1;
> +       u32                                  ovflw_irq;
> +       u32                                  reserved;
> +       u32                                  ovflw_irq_flags;
> +       u32                                  proc_affinity;
> +       u32                                  impl_id;
> +};
> +
> +/* Masks for Flags field above */
> +
> +#define ACPI_APMT_FLAGS_DUAL_PAGE               (1<<0)
> +#define ACPI_APMT_FLAGS_AFFINITY                (1<<1)
> +#define ACPI_APMT_FLAGS_ATOMIC                  (1<<2)
> +
> +/* Values for Flags dual page field above */
> +
> +#define ACPI_APMT_FLAGS_DUAL_PAGE_NSUPP         (0<<0)
> +#define ACPI_APMT_FLAGS_DUAL_PAGE_SUPP          (1<<0)
> +
> +/* Values for Flags processor affinity field above */
> +#define ACPI_APMT_FLAGS_AFFINITY_PROC           (0<<1)
> +#define ACPI_APMT_FLAGS_AFFINITY_PROC_CONTAINER (1<<1)
> +
> +/* Values for Flags 64-bit atomic field above */
> +#define ACPI_APMT_FLAGS_ATOMIC_NSUPP            (0<<2)
> +#define ACPI_APMT_FLAGS_ATOMIC_SUPP             (1<<2)
> +
> +/* Values for Type field above */
> +
> +enum acpi_apmt_node_type {
> +       ACPI_APMT_NODE_TYPE_MC                      = 0x00,
> +       ACPI_APMT_NODE_TYPE_SMMU                    = 0x01,
> +       ACPI_APMT_NODE_TYPE_PCIE_ROOT               = 0x02,
> +       ACPI_APMT_NODE_TYPE_ACPI                    = 0x03,
> +       ACPI_APMT_NODE_TYPE_CACHE                   = 0x04,
> +       ACPI_APMT_NODE_TYPE_COUNT
> +};
> +
> +/* Masks for ovflw_irq_flags field above */
> +
> +#define ACPI_APMT_OVFLW_IRQ_FLAGS_MODE          (1<<0)
> +#define ACPI_APMT_OVFLW_IRQ_FLAGS_TYPE          (1<<1)
> +
> +/* Values for ovflw_irq_flags mode field above */
> +
> +#define ACPI_APMT_OVFLW_IRQ_FLAGS_MODE_LEVEL    (0<<0)
> +#define ACPI_APMT_OVFLW_IRQ_FLAGS_MODE_EDGE     (1<<0)
> +
> +/* Values for ovflw_irq_flags type field above */
> +
> +#define ACPI_APMT_OVFLW_IRQ_FLAGS_TYPE_WIRED    (0<<1)
> +
> +
>  /*******************************************************************************
>   *
>   * BDAT - BIOS Data ACPI Table
> --
> 2.17.1
>
