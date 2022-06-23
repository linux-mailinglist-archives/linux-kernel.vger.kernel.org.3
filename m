Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD6C55784B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiFWK5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiFWK5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:57:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22A44B86D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:57:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u15so12561533ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nf7JKA/M5hd7+y5Fx5/MKHitVLR4oS80rdGDId3O2PQ=;
        b=hcRCXPr1PL9EdYdE8YW6VkNIYOmx8A0n6jxCCv1GliSW567qDw8TpOZxoxQ0XGyilE
         UbgksvsFqY09tB/52SRBghsQVOhQ6Q75CdNfCTtLKJkn9CYIQTzPfBqs+QcbPHvpWxSE
         jzIYJqVLXFe+vkKQoxnddhZasY3QDfCZhlR5nEp/sBXFAUJrfGvIJ5naVA2lwp1MwT5M
         JU66O1ZPeeEL/n9YpGefwSNvgRWQVOEKVKa3iSAo68gYVwjtOdxmxsHkj2FBfvu79f45
         QM6mq8WAdM1Qku7Y/hKWJ8S2qvwlrds/ha4G65dkv6uWkNUvkl+IFM0g+1ZltqnVCgrc
         6Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nf7JKA/M5hd7+y5Fx5/MKHitVLR4oS80rdGDId3O2PQ=;
        b=V4bmHZi39FMvx6jzoQgv9RjdEj2AszeUnNxqmPBepX3sbvNFnefc80wVQrVuFBGF6U
         0bdVXUhfLlKT0cIiaRUlN/lfSQI9ezVYSlRtIvSszyCHddVHq687VascLbwJflh0dswj
         E3PtjQj6+F13IPA2bpFYmSaxDTnrlMby/VqNmkky+tAijAOsNtLvk8iVYIFu0norgzgb
         BVn9oLPGqDeh/+0KAEK2tY38Ilmy/9T8gt7V1rLlyohocKWfqdkRav7wPhMFXeMfIpnX
         zLMKTzDlOMMaWmT3yYh2Dm+G0TWk1ftAAQpuiFFUSjYkcYI6S4LFgmuJ+njVsIblyr2W
         xzaw==
X-Gm-Message-State: AJIora+Y9xfL1jseBPYukf5koxtz5V5IchhwrsCL7WnrVfImyhguuxaG
        zUyNU2nWjcOJMX6xm2SUwpE21A==
X-Google-Smtp-Source: AGRyM1uU8adc6uem/rQKgHab2kKElresmanSHZHu8F2UtGAwBgD7PrQzc5GckXkqZ/T5YZ557Tg6lQ==
X-Received: by 2002:a17:907:7f04:b0:6ff:34ea:d824 with SMTP id qf4-20020a1709077f0400b006ff34ead824mr7867033ejc.526.1655981828430;
        Thu, 23 Jun 2022 03:57:08 -0700 (PDT)
Received: from [192.168.0.228] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lt20-20020a170906fa9400b00722e52d043dsm3978175ejb.114.2022.06.23.03.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 03:57:08 -0700 (PDT)
Message-ID: <42ff7e04-5e32-7fee-d874-a983dcede4a0@linaro.org>
Date:   Thu, 23 Jun 2022 12:57:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] rpmsg: fix possible refcount leak in
 rpmsg_register_device_override()
Content-Language: en-US
To:     Hangyu Hua <hbh25y@gmail.com>, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220623073605.27386-1-hbh25y@gmail.com>
 <050a390d-1ede-04ee-3870-9434ffd671b8@linaro.org>
 <2d7eaa45-2193-7fcb-5c9b-6394bab2ae95@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2d7eaa45-2193-7fcb-5c9b-6394bab2ae95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2022 12:53, Hangyu Hua wrote:
> On 2022/6/23 16:15, Krzysztof Kozlowski wrote:
>> On 23/06/2022 09:36, Hangyu Hua wrote:
>>> [1] commit 1680939e9ecf ("rpmsg: virtio: Fix possible double free in
>>> rpmsg_virtio_add_ctrl_dev()")
>>> [2] commit c2eecefec5df ("rpmsg: virtio: Fix possible double free in
>>> rpmsg_probe()")
>>> [3] commit bb17d110cbf2 ("rpmsg: Fix calling device_lock() on
>>> non-initialized device")
>>
>> I think only the last [3] introduced it, because it's the commit missing
>> put_device in first error path.
>>
> 
> I see. Do i need to change the commit log and then send a v2?

Yes, please. With my Reviewed-by tag.


Best regards,
Krzysztof
