Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7124BFE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiBVQYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiBVQYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:24:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E846166A79;
        Tue, 22 Feb 2022 08:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=orNwPadLyZMf1dU28nfIOtIad1J0UPF7cu+kVS+SXB4=; b=qe4lpTnNgBZVySRtcKlpB9P4wS
        cwDoiJwxuZOdS+saabUOIkzYZUV41PPWWbuJqZLkcEoQjIGNYmgD2B6WmbScT1vwsjJLMRmZgU94M
        swkrlzZh/4Bdp4AunBMnVTj2jCeH5ARtT5329KjDjsnCVbaTIrlWEHKS9Re5hxdM+oOQpJtDCCoqL
        K6Ru76oCv7p+KFlznfV1lTS0ppH/XOCQx2CORBcwciP0VtZ1VGPdinUjpi+X27Aepz0xYeV2ep2lr
        4fWm2cB3R0eftyPwX7HofBbcan+KhKUiCFkXQ7012S0za5OCvDg7tziO8W79x8PsXT7Cn+RYkuFkd
        uJKXShew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMXxR-00AcJa-Rg; Tue, 22 Feb 2022 16:24:09 +0000
Date:   Tue, 22 Feb 2022 08:24:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/9] gpu: host1x: Add context device management code
Message-ID: <YhUOKaoCA7dyAZAh@infradead.org>
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-4-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218113952.3077606-4-mperttunen@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:39:46PM +0200, Mikko Perttunen wrote:
> +
> +/*
> + * Due to an issue with T194 NVENC, only 38 bits can be used.
> + * Anyway, 256GiB of IOVA ought to be enough for anyone.
> + */
> +static dma_addr_t context_device_dma_mask = DMA_BIT_MASK(38);

You need a mask per device.  Please don't share the same variable
for multiple masks.

> +EXPORT_SYMBOL(host1x_context_alloc);

All this low-level code really should be EXPORT_SYMBOL_GPL.
