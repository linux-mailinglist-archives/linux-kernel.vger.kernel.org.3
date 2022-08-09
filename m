Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC2058D471
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiHIHVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiHIHUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:20:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEECBE24
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 00:20:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j15so13326101wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 00:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nDZGjC3d6RgPiYxCgLnPjqhoXy38nST01tp2NFMdLgY=;
        b=xN4KUUb5LpDRsXDr3lg6VqfiiGJiAKnuy4OZkG8jx1/2Heekel3ys6nLkYYNoK6MiQ
         tEBcu5S5opzm2fPc+3FFmoClgEfRYpsvPM2BKrPp6quT426U1LXghDTLf2eSzG8FKRPU
         7jkicc6XssGkFQRU3KtP4P4Gju3ebDqXaqouM/CCZPp07GXJTXx9b+mC0puznB4+DTqN
         Ld8RB/cqU2XQ/R78lAQg/0oZRszHYNaJEEtWvc5nF35NISlUXUEmC51qfir5OeO2srFJ
         m5FXiL/1kSfn+poFKNQHXg1kTunibiDTeqMn9+YsCithA3QLL4lyGOtIs6HdZryQCWP7
         NccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nDZGjC3d6RgPiYxCgLnPjqhoXy38nST01tp2NFMdLgY=;
        b=RdDdFsur8/nKlVPuUnYPcNXkU9eu80div55oTpxI2XNlFjYfWn0FaF+RB69tzSYb+i
         H7Q42f9rugDmaD29tzLRSgeOyRF3uLM/iVqlK7f9P1O4qrEBhEedHzi0TVFQq0/cAgML
         czVEXqpll5cyDAJLs05yFBZREIPQFec8REC9AAwQdMAokBXfxMIUV785pOAyCXxKGwK0
         Ue9EK70m6+oMU2eHaYWpnAKw//j1z5ju4Dc6uW9P6jJfS4/Hhj69sFhiAxedOF7BIqkr
         1b3UGUxr+wpPlP/t8hETTZ4FpCF4LKf0rk/6wbMPyUdL0Eqg+emwOXlg5+/TZu/0uSOo
         7m+w==
X-Gm-Message-State: ACgBeo1HFj5unqiKmea6Hr0a5FTvw1gkaCNh6qcei94i2xBHYC/RQUxI
        p8icM5tQp02a3EbdU874ukGBF7fZdFAlhA==
X-Google-Smtp-Source: AA6agR6QHnlDD3qjHO/gSC+OOdUtehf/UYh9OOQN8/22GLn0m55iV4WWOcGucEL0AAtwWiy4oMW0jw==
X-Received: by 2002:adf:d1c1:0:b0:220:5ec3:fb62 with SMTP id b1-20020adfd1c1000000b002205ec3fb62mr13237098wrd.69.1660029650688;
        Tue, 09 Aug 2022 00:20:50 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b003a2d47d3051sm17651203wmr.41.2022.08.09.00.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 00:20:50 -0700 (PDT)
Date:   Tue, 9 Aug 2022 08:20:48 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 1/1] iommu/virtio: Do not dereference fwnode in struct
 device
Message-ID: <YvIK0KMi1yECL9vc@myrica>
References: <20220801165142.20898-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801165142.20898-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 07:51:42PM +0300, Andy Shevchenko wrote:
> In order to make the underneath API easier to change in the future,
> prevent users from dereferencing fwnode from struct device.
> Instead, use the specific device_match_fwnode() API for that.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 08eeafc9529f..9fe723f55213 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -925,7 +925,7 @@ static struct virtio_driver virtio_iommu_drv;
>  
>  static int viommu_match_node(struct device *dev, const void *data)
>  {
> -	return dev->parent->fwnode == data;
> +	return device_match_fwnode(dev->parent, data);
>  }
>  
>  static struct viommu_dev *viommu_get_by_fwnode(struct fwnode_handle *fwnode)
> -- 
> 2.35.1
> 
