Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB2C4F8C22
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiDHCUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 22:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiDHCUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:20:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670D9278C5F;
        Thu,  7 Apr 2022 19:18:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso10653865pju.1;
        Thu, 07 Apr 2022 19:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3zm5T0QfPFPheBJgjOFA6sW0BzyI//acXdPCPSvGRVw=;
        b=DqmhEpp/qGAb8x3ijWw7YndcBoes2nQUnvyuEhq/9gs4LSTKgI6ibRCcUxCNzgSu23
         8UGcwr3+Zo3k2PWBnG/wZJD9aFQ3ACQG/HhIhegoyzpeHkGcoHpABaV4q8DdZ47GuYv7
         CjO6qIm+SmnikDPOYkSdvcaZf90i9fgclUrtDXuRRw2+gnf2oVSQPu+ryds1cdE4jlc6
         PPN9JoVCp0LFZCx3feFGNSnsxClU76rWGx0PawnhfQSpI++ogsbA9C9aPki+Ivnqsswu
         +AHZqq8zFfQICnZQmMelH6iGG539lBhYMy6PjqLveGUw89PYSXMo08BXst/9pRqG2eUN
         7AsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3zm5T0QfPFPheBJgjOFA6sW0BzyI//acXdPCPSvGRVw=;
        b=zzzrIJZ3Az17HtC5eAQyA+puLWBLjDpmXV2qaSx4HzxHdG1W3ZHfmxKhWW3De+ac0A
         X863P3Gjk7Ae8aSwj3mXakPcvviutzYrncmg73E24K2c2mgSVVdz05BNLqaHpk79pwx9
         l2tY+iantuPnQvqHuDd/0A7utxn1AsqhGdoA6WGuKqesy1i6ZfkwzAcMBmAQHG98w0wr
         Cucz5ZpQ5DXddlDXth59Jc43g6aRU2obevQdtRFsaeK9rwcj272mR56VBfzS51IeRHvf
         5CO5SV5stR4rlk18Srb2/Ae49PN8LhBoaHwIFoZ2lkzDwKd/zQSJjrqUvbPJ12+oL8aM
         i/UA==
X-Gm-Message-State: AOAM532sKXHHT1xeUmwqzV/vFMk+zfBODu111auRUqTJo4gsyFVSmG1q
        aIdCeUn7XmUHd4i47067UmQ=
X-Google-Smtp-Source: ABdhPJwZkfBTl8jo+XOzjU6/+PMtkzZCAaMiKnENeZrNagp1UniVk3PZKxkSLhjBVV4vm2LFYXLJkA==
X-Received: by 2002:a17:902:f70c:b0:14e:f1a4:d894 with SMTP id h12-20020a170902f70c00b0014ef1a4d894mr17495220plo.65.1649384308932;
        Thu, 07 Apr 2022 19:18:28 -0700 (PDT)
Received: from [10.11.37.162] ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id pg14-20020a17090b1e0e00b001c75634df70sm9938774pjb.31.2022.04.07.19.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 19:18:28 -0700 (PDT)
Message-ID: <693c7823-9edb-f821-1573-3bb01948253f@gmail.com>
Date:   Fri, 8 Apr 2022 10:18:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: rga: fix possible memory leak in rga_probe
Content-Language: en-US
To:     jacob-chen@iotwrt.com, ezequiel@vanguardiasur.com.ar,
        mchehab@kernel.org, heiko@sntech.de
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220324083724.42654-1-hbh25y@gmail.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <20220324083724.42654-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping.

On 2022/3/24 16:37, Hangyu Hua wrote:
> rga->m2m_dev needs to be freed when rga_probe fails.
> 
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>   drivers/media/platform/rockchip/rga/rga.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
> index 4de5e8d2b261..c2ce4fdcdb7f 100644
> --- a/drivers/media/platform/rockchip/rga/rga.c
> +++ b/drivers/media/platform/rockchip/rga/rga.c
> @@ -865,7 +865,7 @@ static int rga_probe(struct platform_device *pdev)
>   
>   	ret = pm_runtime_resume_and_get(rga->dev);
>   	if (ret < 0)
> -		goto rel_vdev;
> +		goto rel_m2m;
>   
>   	rga->version.major = (rga_read(rga, RGA_VERSION_INFO) >> 24) & 0xFF;
>   	rga->version.minor = (rga_read(rga, RGA_VERSION_INFO) >> 20) & 0x0F;
> @@ -881,7 +881,7 @@ static int rga_probe(struct platform_device *pdev)
>   					   DMA_ATTR_WRITE_COMBINE);
>   	if (!rga->cmdbuf_virt) {
>   		ret = -ENOMEM;
> -		goto rel_vdev;
> +		goto rel_m2m;
>   	}
>   
>   	rga->src_mmu_pages =
> @@ -918,6 +918,8 @@ static int rga_probe(struct platform_device *pdev)
>   free_dma:
>   	dma_free_attrs(rga->dev, RGA_CMDBUF_SIZE, rga->cmdbuf_virt,
>   		       rga->cmdbuf_phy, DMA_ATTR_WRITE_COMBINE);
> +rel_m2m:
> +	v4l2_m2m_release(rga->m2m_dev);
>   rel_vdev:
>   	video_device_release(vfd);
>   unreg_v4l2_dev:
