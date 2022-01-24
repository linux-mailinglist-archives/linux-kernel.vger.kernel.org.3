Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26ABF497A15
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbiAXIQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:16:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37036 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242110AbiAXIQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:16:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3858B80ECB;
        Mon, 24 Jan 2022 08:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33CEC340E1;
        Mon, 24 Jan 2022 08:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643012202;
        bh=1p4Ei0VQKjl/EI+UbOBbtqk35AVMqncFK1+SkqXuzTA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=kEkJ8VYOppns4alKgHnJ3E9TEXtOhYfO7Fne4WuQX1e5Ife3PEZVNbE9PjCk52WpX
         WxK90Y6QSSz65mdN6/JcFvg6hztXVPnoeyuqXLJu12TPq0G7Eha/c1tCqgU4XF0ae8
         n/+qIWbMP1KHbNwrzkV/DxHteLKP0km6HP08UcVlcVZLQskw8MCHVFjwkRIyQwGZR+
         E0+NUwTM5mdtrcdaf/TOMqtbB+/JtVJpluN4lhJpYhVTE9zxA9s+tYWN7Ls+IS3pYB
         cBfov42qaIFPtQwkUbUh7vvvHbUkKf7TheTFuHGk7O2z8OaTZf2x55NWgz1UZlZpte
         xw4rPYYqvxnow==
Date:   Mon, 24 Jan 2022 09:16:38 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: amd_sfh: Remove useless DMA-32 fallback
 configuration
In-Reply-To: <a1ce59490a9a32f638a41fb80ff4b4598c33acec.1642260273.git.christophe.jaillet@wanadoo.fr>
Message-ID: <nycvar.YFH.7.76.2201240916280.28059@cbobk.fhfr.pm>
References: <a1ce59490a9a32f638a41fb80ff4b4598c33acec.1642260273.git.christophe.jaillet@wanadoo.fr>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022, Christophe JAILLET wrote:

> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index 2503be0253d3..673536d1d9ba 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -248,11 +248,8 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
>  	pci_set_master(pdev);
>  	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>  	if (rc) {
> -		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> -		if (rc) {
> -			dev_err(&pdev->dev, "failed to set DMA mask\n");
> -			return rc;
> -		}
> +		dev_err(&pdev->dev, "failed to set DMA mask\n");
> +		return rc;
>  	}

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

