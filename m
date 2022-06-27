Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D2855D52F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiF0IAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiF0IAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:00:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54C40265D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656316799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=neDuoz1MOtHdYazvjm1FUbU2R87/hGIYUVJGfUDk6wc=;
        b=Tq0fI8Z81LhXj4W6hkmgR8qZuRH4mDsyAHSCrX6yD6/d7NJSLyit3MuEWnzBwPz7+2MrJ2
        EkXDBTCruNTrY/IL/xEstiQRV7zw3lVMJu3MoI88Gd1XRAAsUNaAHfY3kYKunTUInIutK/
        ZgObbe5hmn5ZlY0eBUqcj4aDH1w9XJQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-DekaTuVuMPalRsodsWNszw-1; Mon, 27 Jun 2022 03:59:57 -0400
X-MC-Unique: DekaTuVuMPalRsodsWNszw-1
Received: by mail-wr1-f69.google.com with SMTP id l9-20020adfa389000000b0021b8b489336so960814wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=neDuoz1MOtHdYazvjm1FUbU2R87/hGIYUVJGfUDk6wc=;
        b=sNdeYzaaBDrB1YKHd6DzW8AEXguuMsYq5BIbDAyy5b5b8XxD5tPhAx5O26N3OFGvNv
         osPqsS0XCueIRHVnwwpej7YkCnHUSfSQ+pzXC1jJ9eusVCGdoWQCwFdJPnpFXid+vpjX
         mk4P3vSKBe/o8RxdrTjvb0L6MD1o5TrbtxYqR7CHJpiULXxIhNi8WrkolZulKwaGteoL
         98Fh7E0I20zcvZWRTg4rdFN52pOQ7dqa60XQWil8weGe9fpjlmQKrs+CntZ31fvDA5sr
         FVOTyW/0ohsSiPMp01BaWeUMXSTLZAceZcZl5j5qxwCeIuukKYYBcZtaeTWPw78hGFNl
         Qmvw==
X-Gm-Message-State: AJIora/0eoqxiXOsAc+6GhYO6tAWY/9D0AHzzg4p5eskQNYTd3zPX1ns
        Gdj2H2IqzO8XlI+oB4g8dT2tg41gnkEF+KcFXlhgABBOkdiDfWPQj/F5VHBNtNgBAjANdIEOhtT
        NH+d5ITaOrb1ZUWBl3rK8eW/p
X-Received: by 2002:a05:6000:1861:b0:21b:a8a2:858d with SMTP id d1-20020a056000186100b0021ba8a2858dmr11431727wri.53.1656316796780;
        Mon, 27 Jun 2022 00:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uZhohMBaEBV+0//iOOjqc+g4aHxkh0EgyHkXvONwHLsJYALvI32sqzcIOPdflOY7QLqVHb7A==
X-Received: by 2002:a05:6000:1861:b0:21b:a8a2:858d with SMTP id d1-20020a056000186100b0021ba8a2858dmr11431703wri.53.1656316796519;
        Mon, 27 Jun 2022 00:59:56 -0700 (PDT)
Received: from redhat.com ([2.54.45.90])
        by smtp.gmail.com with ESMTPSA id t18-20020a1c7712000000b0039749b01ea7sm14704114wmi.32.2022.06.27.00.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 00:59:56 -0700 (PDT)
Date:   Mon, 27 Jun 2022 03:59:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, pankaj.gupta@amd.com
Subject: Re: [PATCH V2 2/2] virtio_pmem: set device ready in probe()
Message-ID: <20220627035854-mutt-send-email-mst@kernel.org>
References: <20220627062941.52057-1-jasowang@redhat.com>
 <20220627062941.52057-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627062941.52057-2-jasowang@redhat.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 02:29:41PM +0800, Jason Wang wrote:
> The NVDIMM region could be available before the virtio_device_ready()
> that is called by virtio_dev_probe(). This means the driver tries to
> use device before DRIVER_OK which violates the spec, fixing this by

s/fixing this by/to fix this/

> set device ready before the nvdimm_pmem_region_create().
> 
> Note that this means the virtio_pmem_host_ack() could be triggered
> before the creation of the nd region, this is safe since the
> virtio_pmem_host_ack() since pmem_lock has been initialized and

can't parse this sentence, since repeated twice confuses me

> whether or not any available buffer is added before is validated.
> 
> Fixes 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> Acked-by: Pankaj Gupta <pankaj.gupta@amd.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since v1:
> - Remove some comments per Dan
> ---
>  drivers/nvdimm/virtio_pmem.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 48f8327d0431..20da455d2ef6 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -84,6 +84,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>  	ndr_desc.provider_data = vdev;
>  	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
>  	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> +	/*
> +	 * The NVDIMM region could be available before the
> +	 * virtio_device_ready() that is called by
> +	 * virtio_dev_probe(), so we set device ready here.
> +	 */
> +	virtio_device_ready(vdev);
>  	nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
>  	if (!nd_region) {
>  		dev_err(&vdev->dev, "failed to create nvdimm region\n");
> @@ -92,6 +98,7 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>  	}
>  	return 0;
>  out_nd:
> +	virtio_reset_device(vdev);
>  	nvdimm_bus_unregister(vpmem->nvdimm_bus);
>  out_vq:
>  	vdev->config->del_vqs(vdev);
> -- 
> 2.25.1

