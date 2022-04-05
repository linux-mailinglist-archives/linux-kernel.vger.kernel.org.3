Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7CF4F498C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442613AbiDEWT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573395AbiDETGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:06:15 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A9D167F6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:04:14 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id t19so399932qtc.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p4sIUWeO6+P4zWNNUhdcwFoqQbff1GSzTj3PyXvmiEQ=;
        b=nmqu50EBRX36s361/cDtv8BTMjCMfqpX08sQhZFrt8sYSEBPwE1vgZ4nW0w4EdNOZv
         o+tA8EKhpRSdQR3Dv6ZeNplzb/6/d4P/pYo8hMuSFtnnHbT18NbIqrDKWGWRuzj0sX33
         NwkCKPzO9uzXxgwt6mzZTzUipt/2LtQXBV9/6/aCHm68I4zhTPhv8T6Xk7CqblW0d9at
         77T1IBaxtpT6vZINZsj5yY7V5fK3TqnoQBl+RnTQQqZTftcLpRRB8gnwvPgzdCfnGiPk
         34ATgiHVCSNNKC4vBPleRiNh9Mj27XotB+bI/48+eyL/b5gKJFVKWfht+KhNDWMMBTx/
         hSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p4sIUWeO6+P4zWNNUhdcwFoqQbff1GSzTj3PyXvmiEQ=;
        b=ObuRJkKPxDx8GUsUMaBGI/76uMN35F82t54CagK2wJy9ELkn1n9zg901JeDAUvuxNc
         FRCx6bb/E5HXBVR4ljICPC9IeT8v0C+Jw7qWrM5i0cDKIp2pseArOKaXWt1IScoL5EiB
         bdizHtoK+ckr0D3/DczBvNLQFG6KPoenEbJ8yhl/Bs36mwvR8we9/s8bKq/IFURMn3mt
         hXE9EB5m1FQiqAlbA2DZ5myl8YBGrZ/XbkU5o2lytylvgpuU8tbaeC2U0tdnCGe+fw3L
         F6dr8FT3/CxBKcnnC0ItDd6mfXpQ9iF0J8Kkhiig1gLEnd1zYxxG+7djbtfHtFLQFqGc
         nnJQ==
X-Gm-Message-State: AOAM533Z+4Qw3IsgmxEU52lI5nf0o3QVX6RvHXElPyA1LcGJ7nb4n+2V
        3G3uu2QM0MiyImzaNOG7xvlbEA==
X-Google-Smtp-Source: ABdhPJw89QndTutZv11VxczePEqDQB0+l7F3uU5v+rVSKfMzarjpMx65Se4MSU9B2AhnbihAOWRqBA==
X-Received: by 2002:a05:620a:2452:b0:699:9df2:665d with SMTP id h18-20020a05620a245200b006999df2665dmr3178998qkn.668.1649185453843;
        Tue, 05 Apr 2022 12:04:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a22b000b0067b7b158985sm8057701qkh.128.2022.04.05.12.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 12:04:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nboTL-00DBjA-Ix; Tue, 05 Apr 2022 16:04:11 -0300
Date:   Tue, 5 Apr 2022 16:04:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     alex.williamson@redhat.com, iommu@lists.linux-foundation.org,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] vfio: Stop using iommu_present()
Message-ID: <20220405190411.GT64706@ziepe.ca>
References: <537103bbd7246574f37f2c88704d7824a3a889f2.1649160714.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <537103bbd7246574f37f2c88704d7824a3a889f2.1649160714.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 01:11:54PM +0100, Robin Murphy wrote:
> IOMMU groups have been mandatory for some time now, so a device without
> one is necessarily a device without any usable IOMMU, therefore the
> iommu_present() check is redundant (or at best unhelpful).
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/vfio/vfio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
