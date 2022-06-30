Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A405616FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiF3J7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiF3J7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:59:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B8243ED7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:59:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e28so21319569wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1HMqmjT/Hl6eEoSqluU6kzXOVYJu96vbsB8yRH3pJM0=;
        b=b/EZPJfCnVquS1NkGq9KsRSBoCZWR7XOtN+NA+DS6Z90ExfXr1goihQkGLPJKgOpGD
         E41Z7SVhSHeZcyHhReeC5glNz/sMI+cacocAN+FidqgorPd7cmOUipobq8s3bUis9MnM
         qN2to17GprO8783SMo6neHc53795eruPe6diqQbC/ekLR3M7MhW1cfyEJ61Rna83MVqL
         6nlD9F4GRvs/uFvHk2Aa7rCsMyacwzeNcrwQP2n8ntFdc8CqWzQNfHv8NM6Zm86Kj1zY
         ZlVEd7Aoikx9hXwEINGCgvU2Uf2TgLEm2ZqLLW9EV0ImXR0vBTs6xYbWLT8QCxzhNWPs
         qFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1HMqmjT/Hl6eEoSqluU6kzXOVYJu96vbsB8yRH3pJM0=;
        b=z0Xjr9iw+LtkaCaPprDzjx+w5scfmHgledgi5/E/2KzV0a6bH9Lvsug00smiW7v5La
         bpv7yQ0CO/EZ/s91ITAMlytJbnVPb5J6ZpFQghzRaq8CqKTEON/Gb/XfVXFLn3CQXcPG
         h6AOqCsDT32+avBpF/E4GO9/+Ef5zXcrLdLRx0Wb5ebawLNlnnCGT4aXDZe19LwdW44r
         rmxLR9eJIo6NrV42/yejsdQbC9RJJ+NZc8QriMNOcN96G0uYZw19OOB7K7j693uV5rkT
         RPmS2C89UJhlAwP9HkTuB2RMo92dMbKFFtUvMCqOOc29OsZfU7/oPqR+aEUvKK1GvrEj
         M95A==
X-Gm-Message-State: AJIora/41BuPrsBLHBgdTlGy1OHBzg2Ep4ta+C/u84Pa2ZKVLRLAoAMM
        4zaKlszkCwucFNjgYANpxAK9vw==
X-Google-Smtp-Source: AGRyM1vfHfveCYpKUn92Ua/tYhN63FUv0q/bxKLp7QoY98RJ551Y0CyHmJgnGxT6j3AABaTfE3i9OA==
X-Received: by 2002:adf:d1ca:0:b0:21b:a81c:47f3 with SMTP id b10-20020adfd1ca000000b0021ba81c47f3mr7539642wrd.22.1656583155303;
        Thu, 30 Jun 2022 02:59:15 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b0039c4506bd25sm2572630wmb.14.2022.06.30.02.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 02:59:14 -0700 (PDT)
Date:   Thu, 30 Jun 2022 10:58:50 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, jroedel@suse.de,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, jinl@redhat.com
Subject: Re: [PATCH v2] ACPI: VIOT: Fix ACS setup
Message-ID: <Yr1z2gC0+8zbzpFf@myrica>
References: <20220630094059.1204283-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630094059.1204283-1-eric.auger@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 11:40:59AM +0200, Eric Auger wrote:
> Currently acpi_viot_init() gets called after the pci
> device has been scanned and pci_enable_acs() has been called.
> So pci_request_acs() fails to be taken into account leading
> to wrong single iommu group topologies when dealing with
> multi-function root ports for instance.
> 
> We cannot simply move the acpi_viot_init() earlier, similarly
> as the IORT init because the VIOT parsing relies on the pci
> scan. However we can detect VIOT is present earlier and in
> such a case, request ACS. Introduce a new acpi_viot_early_init()
> routine that allows to call pci_request_acs() before the scan.
> 
> While at it, guard the call to pci_request_acs() with #ifdef
> CONFIG_PCI.
> 
> Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Jin Liu <jinl@redhat.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

