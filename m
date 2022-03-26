Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E0C4E8293
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 18:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiCZRIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 13:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbiCZRIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 13:08:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63D5545058
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 10:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648314382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AaqHgdk6/+I2GCVcGwBUnAdboIBBklK2pcJvQpSSU0c=;
        b=ZblK414Pm0iqVYh3Uw5+ICJhegxPEaTQc+0H3nH/0CVGXEPeAX6uxbqipeqe6XXngevoK2
        +Ix0lm+296NdfFyc0sfFjMj/3yH29YogR5Q5zFARGBmPSU8NMPoioquVpJcqM6czhaAjBz
        CTjZ2lEn64JXYje1no7v0eS5CQrghv0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-LI4hr7kvPuq2jRPZrxJnUA-1; Sat, 26 Mar 2022 13:06:20 -0400
X-MC-Unique: LI4hr7kvPuq2jRPZrxJnUA-1
Received: by mail-qk1-f199.google.com with SMTP id q5-20020a05620a0d8500b004738c1b48beso6966970qkl.7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 10:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AaqHgdk6/+I2GCVcGwBUnAdboIBBklK2pcJvQpSSU0c=;
        b=kA/3aibAZBgHoU7E78nRCeux8NSDB9ZbNRwKrR/IZVAXcwdzCUXukXMEbvQ1dgz4tj
         V3Ox9ZhhiS0Q82DxjCeMnWwzu73sP4an2mpLBFwaxh11T5MbgaS47vc73oa5/8HjLqzu
         PnL+Q0K3d0iyaCxSyIuS/Vr8ka9nvzuq95SP5LznZvjeFRlj+AVizWrQkKkSMLvpur1R
         o4iIcNY8a6rI/kAk7QFBRspuCLLybYK4ZgjQUz7U34iKJI+CY/uua/hQS8IV6JfbTu4M
         iDvbfrh7F7cbI99arRBLWeOYzj7nd1WzEQp03hQbjd7ICv/evKc4iuIQ8IAIpGmMDf9e
         PWnw==
X-Gm-Message-State: AOAM531GbUijWBD1BnJ7RrwvW5t6VvQp0C8IfgeQJ7UEB5i88bh0+hHk
        b/SSIFUruGSC7tsConRxccCwxznpaidcX4L+bo5+cJ981k+BjfYZNve6F+WgYZny6lwVvxEaEAP
        gWKHwl14SGWqGsvP0HBRMX4iO
X-Received: by 2002:a37:a497:0:b0:67d:4926:5c33 with SMTP id n145-20020a37a497000000b0067d49265c33mr10895847qke.566.1648314380017;
        Sat, 26 Mar 2022 10:06:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSLG2yKhm1xS1rxzbzA1dZGpHzbNBGO3vArUUIulTuM6OL+P0D9wROlLM3j+SKSdKt9/T2GA==
X-Received: by 2002:a37:a497:0:b0:67d:4926:5c33 with SMTP id n145-20020a37a497000000b0067d49265c33mr10895834qke.566.1648314379825;
        Sat, 26 Mar 2022 10:06:19 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id v5-20020a05622a144500b002e1c7d027b1sm7734557qtx.66.2022.03.26.10.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 10:06:19 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] fpga: fpga-mgr: Add missing kernel-doc description
To:     Nava kishore Manne <nava.manne@xilinx.com>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com
References: <20220322082202.2007321-1-nava.manne@xilinx.com>
 <20220322082202.2007321-4-nava.manne@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <1ae23c94-ff10-5033-b3aa-75ec5b755a97@redhat.com>
Date:   Sat, 26 Mar 2022 10:06:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220322082202.2007321-4-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/22 1:22 AM, Nava kishore Manne wrote:
> Fixed the warnings: Function parameter or member 'xxx' not
> described.

How were the warnings generated ?

Tom

>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
> 		-Replaced s/@return:/Return:/
>
>   drivers/fpga/fpga-mgr.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index a699cc8e2fa6..0f2b28538f17 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -730,6 +730,8 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
>    * @parent:	fpga manager device from pdev
>    * @info:	parameters for fpga manager
>    *
> + * Return:  fpga manager pointer on success, negative error code otherwise.
> + *
>    * This is the devres variant of fpga_mgr_register_full() for which the unregister
>    * function will be called automatically when the managing device is detached.
>    */
> @@ -763,6 +765,8 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
>    * @mops:	pointer to structure of fpga manager ops
>    * @priv:	fpga manager private data
>    *
> + * Return:  fpga manager pointer on success, negative error code otherwise.
> + *
>    * This is the devres variant of fpga_mgr_register() for which the
>    * unregister function will be called automatically when the managing
>    * device is detached.

