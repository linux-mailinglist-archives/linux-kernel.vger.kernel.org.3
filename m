Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EE4585098
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbiG2NLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbiG2NKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA6B5222B7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659100242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8ig4hrCoGaeMWK4YPryecvGDibtJlBBHniW+VGCItM=;
        b=UJ0t4+w4jnygIVWgpFJ/75TxAvTkefrSWGPWkvWD1fOKBJzpZbjRWscXhDZ4zueNy5e3fG
        HYPOYpd2uZUfwuS7ck9uBi7pQ1HLexjbncG+0yHEtmQaU3uKM9gLT/36V/DEkKzO/FqXBe
        ZKaQEtjCLKDjv7JOnZZ5H9/WoQ/PS18=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-YXmB81xQPGiVlhmx5dj88w-1; Fri, 29 Jul 2022 09:10:40 -0400
X-MC-Unique: YXmB81xQPGiVlhmx5dj88w-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-10e46ccc8f9so2120268fac.18
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=v8ig4hrCoGaeMWK4YPryecvGDibtJlBBHniW+VGCItM=;
        b=cPDzywbYpTTHaczaB1sKo1UecCwd+j1H1uvlQOJKciDJUs49kJYWl6+tWo7cZFne5S
         3NRu+fUTJ3VOENZhotasZ8SGqESld/yQWE0ehhfIUbuhBEXlJMUZdF7Rle4mmYZxMomd
         K2L9sPhzpPs0CJJqXhOfKv6EW+JDSejcDli41KmICKatrfYHWAO39z2N2gRXi1QJ3UDu
         RcOC5DSJKiU1WwRy4mbp0zbOlrS9hfsM51YIQgtxhNMmTIIGE4AnJNZ5S9F4e7N71yi2
         oa83EPX9zrqWnCcsWv3vSwc+1MUlQ1ajIvfXozAoaQMP+e0kXvm0h46RGe5ItnyiRiD1
         GOwQ==
X-Gm-Message-State: AJIora/tO+GF8H3Uj8JTx0rjkHaK6EA8SXBTuTRDkCglh1/spHiGLTay
        +S1YXh8x4G/HrDxouvMfkgMrywENgG9M3nyQ5bE6OAqV+Cq+BLWZQjJ94XL4pvmIwgyZoY5EhLw
        B4dyP2HQvbAqF8cav/7Zocoyl
X-Received: by 2002:a05:6808:53:b0:33a:5992:9fed with SMTP id v19-20020a056808005300b0033a59929fedmr1628566oic.255.1659100240244;
        Fri, 29 Jul 2022 06:10:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sskkD2KSk/CCMvR3QauSQuWOM4R/zYnXyj+9pmberneLWu6xXbIbhYL8jvVPQtny3wNw7+/w==
X-Received: by 2002:a05:6808:53:b0:33a:5992:9fed with SMTP id v19-20020a056808005300b0033a59929fedmr1628551oic.255.1659100239811;
        Fri, 29 Jul 2022 06:10:39 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id bc31-20020a056820169f00b0042857cd4cb3sm1277353oob.17.2022.07.29.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 06:10:39 -0700 (PDT)
Date:   Fri, 29 Jul 2022 06:10:38 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: Fix compile warning in init code
Message-ID: <20220729131038.loximy7k3dl5ontj@cantor>
References: <20220729100432.22474-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220729100432.22474-1-joro@8bytes.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 12:04:32PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> A recent commit introduced these compile warnings:
> 
>   CC      drivers/iommu/amd/init.o
> drivers/iommu/amd/init.c:938:12: error: ‘iommu_init_ga_log’ defined but not used [-Werror=unused-function]
>   938 | static int iommu_init_ga_log(struct amd_iommu *iommu)
>       |            ^~~~~~~~~~~~~~~~~
> drivers/iommu/amd/init.c:902:12: error: ‘iommu_ga_log_enable’ defined but not used [-Werror=unused-function]
>   902 | static int iommu_ga_log_enable(struct amd_iommu *iommu)
>       |            ^~~~~~~~~~~~~~~~~~~
> 
> The warnings appear because both functions are defined when IRQ
> remapping is not enabled, but only used when IRQ remapping is enabled.
> 
> Fix it by only defining the functions when IRQ remapping is enabled.
> 
> Fixes: c5e1a1eb9279 ("iommu/amd: Simplify and Consolidate Virtual APIC (AVIC) Enablement")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

