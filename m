Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89E84B712B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbiBOQKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:10:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241357AbiBOQKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:10:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72EC79AD9C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644941396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bcIcETvSlPf3OlzpU/yW8tdxkR8GvRw96tnUizl6xXs=;
        b=eAgw9IW8JeW70lVnxmdzeEDne4k9CJ6g7MM8DyV9mXRBAnbYQmv8US+UW6FPEsjjkbGLjq
        CuYFMYG1B1HLBLaQ2PzWdpcWVUZqO2ZaX49Bsr1ZVYCBedt4p3LK8qlPuAVd+BrGlw8TIO
        Kh2clmkztd+aTB113KeZwJi8gRHgG9k=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-ohLOyzyEMPCY72tsJodt6Q-1; Tue, 15 Feb 2022 11:09:53 -0500
X-MC-Unique: ohLOyzyEMPCY72tsJodt6Q-1
Received: by mail-oo1-f69.google.com with SMTP id t10-20020a4ad0aa000000b002fd44c52176so12857858oor.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bcIcETvSlPf3OlzpU/yW8tdxkR8GvRw96tnUizl6xXs=;
        b=e+Rq8a8HtwBGvc4R5Kzt9dOXMhO/RbZRGTBfFM/KD0iynPzR2B7LyPCMeRUj2G3KDL
         a/SDOkYC4vD4pYdAaomGgMiR70PK/EZZeu1Nqghzb202plFFV1ZQIV39xnk8Rgw88WxV
         TY9rMtlEz9kPRtRhwJG8JTX6aR5A5Y4lO9Qc5YAkjqk6FGDDvJzHpyEWz7IL5Qo/EnKY
         KDMYo9q0pDyhg/VGS6q7gSZi0wETvIPRxUxOCb+MuDz0NLnGKTGvNE91iWniXVtvfrkJ
         YSMC7tvgSN9zulnw7RQ/DXjvs52xtuVToTGcU33npSBAfbSxY3C+vQ5XTxdlgqLV8YDt
         42Rg==
X-Gm-Message-State: AOAM532mfabrLsg2scnAEnD4WpHnliKWA0zhub6FsgDU0cxaSaDDcxK2
        NPUkDofCMtxbVUExqhugGvMoSTvYhduJhXMuOPEhfKP31/5QhJyFjxxobXQRjDhlGTaBzt49a0T
        XrTW/KVAQ09tnIomvWk1n2H27
X-Received: by 2002:a05:6808:1647:: with SMTP id az7mr1864900oib.44.1644941391756;
        Tue, 15 Feb 2022 08:09:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwev/0bdfzhXzkz4NGi0esA4iqcPc0qa9laUz9bKob2D1v1DR8Wy/5YIceKRy1HZKCBLBb8Sw==
X-Received: by 2002:a05:6808:1647:: with SMTP id az7mr1864879oib.44.1644941391490;
        Tue, 15 Feb 2022 08:09:51 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m14sm15080864ooj.22.2022.02.15.08.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 08:09:50 -0800 (PST)
Subject: Re: [PATCH v1 6/7] fpga: dfl: Handle dfl's starting with AFU
To:     Tianfei zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-7-tianfei.zhang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <773f3851-f2d3-36e6-afab-a3cf73644b87@redhat.com>
Date:   Tue, 15 Feb 2022 08:09:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220214112619.219761-7-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/14/22 3:26 AM, Tianfei zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Allow for a Device Feature List (DFL) to start with
> a Device Feature Header (DFH) of type Accelerator Function Unit (AFU)
> by doing nothing.  This allows for PCIe VFs to be created.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>   drivers/fpga/dfl-pci.c |  7 ++++++-
>   drivers/fpga/dfl.c     | 23 ++++++++++++++---------
>   2 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 8abd9b408403..83b604d6dbe6 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -277,7 +277,12 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
>   
>   		dfl_fpga_enum_info_add_dfl(info, start, len);
>   	} else {
> -		ret = -ENODEV;
> +		v = readq(base + DFH);

This isn't likely to work on older cards.

Is there there a version to key off of ?

Tom

> +		if (FIELD_GET(DFH_TYPE, v) != DFH_TYPE_AFU) {
> +			dev_info(&pcidev->dev, "Unknown feature type 0x%llx id 0x%llx\n",
> +				 FIELD_GET(DFH_TYPE, v), FIELD_GET(DFH_ID, v));
> +			ret = -ENODEV;
> +		}
>   	}
>   
>   	/* release I/O mappings for next step enumeration */
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index a5263ac258c5..25bd24a4cca0 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -900,9 +900,11 @@ static void build_info_free(struct build_feature_devs_info *binfo)
>   		dfl_id_free(feature_dev_id_type(binfo->feature_dev),
>   			    binfo->feature_dev->id);
>   
> -		list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
> -			list_del(&finfo->node);
> -			kfree(finfo);
> +		if (!list_empty(&binfo->sub_features)) {
> +			list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
> +				list_del(&finfo->node);
> +				kfree(finfo);
> +			}
>   		}
>   	}
>   
> @@ -1437,6 +1439,7 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
>   
>   	binfo->dev = info->dev;
>   	binfo->cdev = cdev;
> +	INIT_LIST_HEAD(&binfo->sub_features);
>   
>   	binfo->nr_irqs = info->nr_irqs;
>   	if (info->nr_irqs)
> @@ -1446,12 +1449,14 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
>   	 * start enumeration for all feature devices based on Device Feature
>   	 * Lists.
>   	 */
> -	list_for_each_entry(dfl, &info->dfls, node) {
> -		ret = parse_feature_list(binfo, dfl->start, dfl->len);
> -		if (ret) {
> -			remove_feature_devs(cdev);
> -			build_info_free(binfo);
> -			goto unregister_region_exit;
> +	if (!list_empty(&info->dfls)) {
> +		list_for_each_entry(dfl, &info->dfls, node) {
> +			ret = parse_feature_list(binfo, dfl->start, dfl->len);
> +			if (ret) {
> +				remove_feature_devs(cdev);
> +				build_info_free(binfo);
> +				goto unregister_region_exit;
> +			}
>   		}
>   	}
>   

