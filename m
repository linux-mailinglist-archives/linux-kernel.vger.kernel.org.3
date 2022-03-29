Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08724EA994
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbiC2Is3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiC2Is1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:48:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FEC2414D4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:46:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a1so23709684wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jQ33q+El4vP9xa8HP+1IypLOEguzWKlg0rR13gHefXM=;
        b=bnZcVTZ8/z+uyqNRXDpoBn7IL1Z9zhWZReDMCUCxvMQlEiyc93jMex/JPN0NaabVMJ
         Cdab0IwtAG9MWcH0gYADARUQnU+arwQjg7YrnesWLI8rfsSBN9muoHH+nG2c7sKo3KbA
         xjp1Btt9afAFDg14ThTHN5NjXuoi19U+6AlRUzxZt01Yl0ejeH/69Eem/ID3YiPpanxA
         f4WcuL4kYJgDbQbtlVwxNur5alAyxEs/m4MWLOXCEWVL8kBVTRjpUyRxBdugA+dkcmw7
         rc3w4iOQV5VTIVLvKLSncRgAq6AV/CCl4DGKTIR4DWxYiGAPhxCsdt+vOAk6YVlvT4eT
         qNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jQ33q+El4vP9xa8HP+1IypLOEguzWKlg0rR13gHefXM=;
        b=mDvRKU+U0xBOSJILgTmNlLUMnXR3y1Q3WI8e/esItA1y/CbdPA1ajc98z8T1/NrFrc
         GT7zNx9yc8K0mkFRKn1CC86O9DwrzHhokSchpn3TsvdEV1nSFU5e3XoQpkLI0Ooff01R
         NPVxNQxFeYdm9yEGEzdUPKJKnGPb3de7uF8E842UqyfuisDiLQYJWs6JzizVF1ruxd2H
         PttwpJ0J0FXUrnNBBFDJ3hABWaXzs6Zt5pQvy6NjmeZIvRIPnUA4i55ANLD08O0ONtBB
         Ba/uVocDzWaQG44t5VOpxAFV802M+Lt7ysJnvjb95M8CNNygWNwi70glruGAaAFs64dj
         9sxw==
X-Gm-Message-State: AOAM533kkMVpTuOcp0gCYOwbspjGWwmVfpN7w8gQls9r60AE/MxvLIeO
        Y3VmRX7IpRWBBGfdfqofRldL7Q==
X-Google-Smtp-Source: ABdhPJwccLDc73wlfKds8vtzFoR0DRV4sYU6wpqFJ179P9MDXXUjln8NdtIk2qhjbii8d9mfelWlag==
X-Received: by 2002:a5d:510d:0:b0:203:f72e:ee24 with SMTP id s13-20020a5d510d000000b00203f72eee24mr29539618wrt.183.1648543603275;
        Tue, 29 Mar 2022 01:46:43 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d63c5000000b002040822b680sm20676780wrw.81.2022.03.29.01.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 01:46:42 -0700 (PDT)
Date:   Tue, 29 Mar 2022 08:46:38 +0000
From:   Keir Fraser <keirf@google.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel-team@android.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio: pci: check bar values read from virtio config
 space
Message-ID: <YkLHbkQ/JlNGwoTa@google.com>
References: <20220323140727.3499235-1-keirf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323140727.3499235-1-keirf@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ping.

If you prefer I could read the capability offset and length in
virtio_pci_find_capability() and communicate them to
vp_modern_map_capability(), perhaps via a new struct virtio_pci_cap
used for only this purpose?


On Wed, Mar 23, 2022 at 02:07:27PM +0000, Keir Fraser wrote:
> virtio pci config structures may in future have non-standard bar
> values in the bar field. We should anticipate this by skipping any
> structures containing such a reserved value.
> 
> The bar value should never change: check for harmful modified values
> we re-read it from the config space in vp_modern_map_capability().
> 
> Also clean up an existing check to consistently use PCI_STD_NUM_BARS.
> 
> Signed-off-by: Keir Fraser <keirf@google.com>
> ---
>  drivers/virtio/virtio_pci_modern.c     | 12 +++++++++---
>  drivers/virtio/virtio_pci_modern_dev.c |  9 ++++++++-
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 5455bc041fb6..6adfcd0297a7 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -293,7 +293,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
>  
>  	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
>  	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> -		u8 type, cap_len, id;
> +		u8 type, cap_len, id, res_bar;
>  		u32 tmp32;
>  		u64 res_offset, res_length;
>  
> @@ -315,9 +315,14 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
>  		if (id != required_id)
>  			continue;
>  
> -		/* Type, and ID match, looks good */
>  		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> -							 bar), bar);
> +							 bar), &res_bar);
> +		if (res_bar >= PCI_STD_NUM_BARS)
> +			continue;
> +
> +		/* Type and ID match, and the BAR value isn't reserved.
> +		 * Looks good.
> +		 */
>  
>  		/* Read the lower 32bit of length and offset */
>  		pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
> @@ -337,6 +342,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
>  						     length_hi), &tmp32);
>  		res_length |= ((u64)tmp32) << 32;
>  
> +		*bar = res_bar;
>  		*offset = res_offset;
>  		*len = res_length;
>  
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index e8b3ff2b9fbc..591738ad3d56 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -35,6 +35,13 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
>  	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
>  			      &length);
>  
> +	/* Check if the BAR may have changed since we requested the region. */
> +	if (bar >= PCI_STD_NUM_BARS || !(mdev->modern_bars & (1 << bar))) {
> +		dev_err(&dev->dev,
> +			"virtio_pci: bar unexpectedly changed to %u\n", bar);
> +		return NULL;
> +	}
> +
>  	if (length <= start) {
>  		dev_err(&dev->dev,
>  			"virtio_pci: bad capability len %u (>%u expected)\n",
> @@ -120,7 +127,7 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
>  				     &bar);
>  
>  		/* Ignore structures with reserved BAR values */
> -		if (bar > 0x5)
> +		if (bar >= PCI_STD_NUM_BARS)
>  			continue;
>  
>  		if (type == cfg_type) {
> -- 
> 2.35.1.894.gb6a874cedc-goog
> 
