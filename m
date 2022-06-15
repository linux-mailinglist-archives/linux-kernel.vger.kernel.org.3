Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2093B54C496
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbiFOJZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241256AbiFOJZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:25:24 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C5A1581E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:25:23 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e66so10845483pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QD1mf5DnBqcLEVOFoiWBRR1QBiCXzXfoEa1RUQMHEbg=;
        b=gmVSCn46TlF8cm8ao3weZQ1dQ+919xti8x+JNTqvEbhjNEFZdvPMGRwZbobjNM3xbf
         uC1/HxtqLlOGh00UA96fBXAz35WiunpTXGZzV5kQH/ocYMckFGEggHTjUPX+MI/pZmOc
         0Nyfs4DBuxMJLPDFXQUFccwTvxRzbEGEEK+TKSrcCe+eTJmjpPY47aruJ1kRn/cku3kK
         luPIiVacfBtMMAvwPdeNm4mBL5eFXYP++g0eRxmGW7FuPJI23ZPCpYI5ypPiJCZkOwWa
         9BR0ntAlHQ+6Q4rk86UEoZfkZ/Qds91d142Z3ertz6dMEcCU9As+k+oOuPVQSa+tI6ap
         YaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QD1mf5DnBqcLEVOFoiWBRR1QBiCXzXfoEa1RUQMHEbg=;
        b=B3vqCtO/tRKW9Tol8hyjxXXUXsSYT2SQyuPINrodu1b38gYha1OFocR7pW6ncoLSne
         dRVE/KR2AFZHx17aEEhmzCbRCkdn/XaizSO/eECFoeQ/hlXLih+Ji50ksIMDsXgIwSKy
         NmYztCV8Uq91w6hxj82XUghfOwu7qUPcLdKOA/293Cx8phNah8EbjXIc6Lyvm3G849Z4
         pPuS/e2HBcRvdKdXbXBDTk/+7J3XBVKbWixEBMyGu/HGpZT0EHebOGirAZSt5Zmf/XID
         7t9Xneq1N/8dVxoNLnQMO9OjJ1To2btEBOrO2zcyJrNdO3jFnDzf2hvdww68K9yz1LnU
         dO9g==
X-Gm-Message-State: AOAM530Ne06ONXFoRlKoCLk+V9Kc7hE7OrLsfyjkDOtPATNQQmXKu0AP
        Hlm2XKob46pTXnjkSrMcLAaQUNNj1m0o5Q==
X-Google-Smtp-Source: ABdhPJy/EMp63lY79wavrcwsuOIlryAFSfAtHCajQFGqGhcTul+yPCkHJc1P94NUfLJmE8bfCaxLrA==
X-Received: by 2002:a63:6c4a:0:b0:3fe:2813:b1d with SMTP id h71-20020a636c4a000000b003fe28130b1dmr8063133pgc.613.1655285122694;
        Wed, 15 Jun 2022 02:25:22 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090a778200b001ea90dada74sm1231965pjk.12.2022.06.15.02.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:25:21 -0700 (PDT)
Date:   Wed, 15 Jun 2022 14:55:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH] xen: don't require virtio with grants for non-PV guests
Message-ID: <20220615092519.5677clabobheziet@vireshk-i7>
References: <20220615084835.27113-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615084835.27113-1-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-06-22, 10:48, Juergen Gross wrote:
> Commit fa1f57421e0b ("xen/virtio: Enable restricted memory access using
> Xen grant mappings") introduced a new requirement for using virtio
> devices: the backend now needs to support the VIRTIO_F_ACCESS_PLATFORM
> feature.
> 
> This is an undue requirement for non-PV guests, as those can be operated
> with existing backends without any problem, as long as those backends
> are running in dom0.
> 
> Per default allow virtio devices without grant support for non-PV
> guests.
> 
> The setting can be overridden by using the new "xen_virtio_grant"
> command line parameter.
> 
> Add a new config item to always force use of grants for virtio.
> 
> Fixes: fa1f57421e0b ("xen/virtio: Enable restricted memory access using Xen grant mappings")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 +++++
>  drivers/xen/Kconfig                           |  9 ++++++++
>  drivers/xen/grant-dma-ops.c                   | 22 +++++++++++++++++++
>  include/xen/xen.h                             | 12 +++++-----
>  4 files changed, 42 insertions(+), 7 deletions(-)

Thanks for the quick fix.

With CONFIG_DEBUG_SECTION_MISMATCH=y, this generates a warning.

WARNING: modpost: vmlinux.o(.text+0x7a8270): Section mismatch in reference from the function xen_set_restricted_virtio_memory_access() to the variable .init.data:xen_virtio_grants
The function xen_set_restricted_virtio_memory_access() references
the variable __initdata xen_virtio_grants.
This is often because xen_set_restricted_virtio_memory_access lacks a __initdata
annotation or the annotation of xen_virtio_grants is wrong.

This can be fixed by:

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index d1fae789dfad..1099097b4515 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -42,7 +42,7 @@ static __init int parse_use_grants(char *arg)
 }
 early_param("xen_virtio_grant", parse_use_grants);

-void xen_set_restricted_virtio_memory_access(void)
+void __init xen_set_restricted_virtio_memory_access(void)
 {
        if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) || xen_virtio_grants ||
            (!xen_virtio_grants_set && xen_pv_domain()))

With that:

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
