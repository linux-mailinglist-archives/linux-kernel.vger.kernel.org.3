Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEDF4C465F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241366AbiBYNbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241368AbiBYNbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:31:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0BA42255BF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645795840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tgR1hZTpp5aLcG8iM+BJVGQ/aPOCjlXRhgyoKS95aU0=;
        b=djth4ZUSLGr9ajNqYgLHPOo382rRHoQx/1CGRdOIWywFwj4rgnZtslrcySlIIY7n9DPRmf
        hppmx68MwxIfuv038g8obBtE+RvvVmVpgwDS5fD9wUO7UrbVvA0vGV9Ipgo9olWnD1birh
        Rfa/ewBhupxHLVN5lBJkb/04K0eztbU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-VEL4bOrqPECFRWHNbCFJJA-1; Fri, 25 Feb 2022 08:30:38 -0500
X-MC-Unique: VEL4bOrqPECFRWHNbCFJJA-1
Received: by mail-wr1-f69.google.com with SMTP id o9-20020adfca09000000b001ea79f7edf8so890965wrh.16
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=tgR1hZTpp5aLcG8iM+BJVGQ/aPOCjlXRhgyoKS95aU0=;
        b=m7U86tWR63DkczBWgNgo2RbDxin7KVSw9tQTbJhDEgxPosVVgwsTLP/62g55la0L3D
         Mhnl6qiRmjweoHiU6xRY7Dk2GErMmRMjCI3yU6JYX8kQgED9rihiilzqiEmqwpnIzzIj
         Apm1Fi58n4NAYosbxxYhBk+6mrshpQgpFVhMutJIL3LuixTqUYnu6qT7HSG63xdBMzF2
         rWuI9wLBTGlyGkvNn4LqUow7Lig/++naoxnW6HOM+1RoLaO4YjAnimyAAOo2lZMOqbMj
         dvIvSvMTvsw+rxmym4o9cFrpg/smW625nLxn9sFCwzeTTbPdEJnMfCKKFpCy0M5zqse+
         k/1A==
X-Gm-Message-State: AOAM5301ToQKEGNINf3puxbhndkZfcTZ46k5Bxu7PDFDlQ6GXH283arv
        2NI9DNX39bVMMrB6mn5PkOUedjANCmpaENkzFNyeRYzylr+y77nZRS5HZGyaMiGZPQMN+3bN9S8
        ZF8me3Ohz7sr6FqI/h3gby/I/
X-Received: by 2002:a05:600c:5028:b0:380:e4f4:7743 with SMTP id n40-20020a05600c502800b00380e4f47743mr2712783wmr.114.1645795836639;
        Fri, 25 Feb 2022 05:30:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxktPQsKtoT6b4UgB+rT37ddzU9CpROPcN405eOVwWCAiMBGmhGTic9fvRGGSeV5oOD4BtJyw==
X-Received: by 2002:a05:600c:5028:b0:380:e4f4:7743 with SMTP id n40-20020a05600c502800b00380e4f47743mr2712758wmr.114.1645795836321;
        Fri, 25 Feb 2022 05:30:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:1900:f2f7:d2ad:80d9:218f? (p200300cbc7061900f2f7d2ad80d9218f.dip0.t-ipconnect.de. [2003:cb:c706:1900:f2f7:d2ad:80d9:218f])
        by smtp.gmail.com with ESMTPSA id f21-20020a5d58f5000000b001ea99c3397dsm2383985wrd.21.2022.02.25.05.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 05:30:35 -0800 (PST)
Message-ID: <f87db49d-16f7-6607-35ce-9a2a9391c01f@redhat.com>
Date:   Fri, 25 Feb 2022 14:30:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] virtio: drop default for virtio-mem
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20220225114801.47348-1-mst@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220225114801.47348-1-mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.02.22 12:48, Michael S. Tsirkin wrote:
> There's no special reason why virtio-mem needs a default that's
> different from what kconfig provides, any more than e.g. virtio blk.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 34f80b7a8a64..492fc26f0b65 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -105,7 +105,6 @@ config VIRTIO_BALLOON
>  
>  config VIRTIO_MEM
>  	tristate "Virtio mem driver"
> -	default m
>  	depends on X86_64
>  	depends on VIRTIO
>  	depends on MEMORY_HOTPLUG

Yeah, why not

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

