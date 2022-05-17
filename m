Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6E0529981
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbiEQGZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiEQGZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:25:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DDB44A07
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:25:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j6so32622479ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3daWTLjDfemU4LkrKKjdRnCWKXpzBvPuFNd5zc6Jz5A=;
        b=vIJLb1XmiUQPDP9LOfnswgdPT30ag0zLABpNg2EIJgJs2dbD59ExZ9WUB7x+eYPK6X
         Jslp8ywU4Hv087437vHZZU9nXb9vKhQX/L14b3tlk+MDDLRf3cca5lcufwyhwljuTjnt
         s5GFG9HB0v5hkcwJZANsjt0QilC53+46snkcntiPjWX6KrA4GVm+qcBkm/38Vb7Us47v
         KNILJhRgUP1FPvNNz4itwGOK/GlNv1LeZesIqlaPqmsxoPA7ZMy8Ut5NgCbk5v3cS45M
         Hwn8YUKh4fYKptSijHt2fHmUN1daqd7kMu5XXbTE9P6N+LH9it5YDUH7nW3o2DQ1Cxdl
         ir4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3daWTLjDfemU4LkrKKjdRnCWKXpzBvPuFNd5zc6Jz5A=;
        b=S3zLboOOVI44TTo71rcEL4ydh8m8P1cZk5LJTuYvflpXWjgUWF6sQ64E4qqlQGXVQR
         OLqq7EDN2buLhtj9FYN87l6mgy/NS/GUSGj+ra2lAgHXiN24mbIdTKfat+c48wtp9MBz
         WX6moVrt15dyxSzB6s8GOQPg+0lW0VazBgFwHc8w25vIIJFN+aBVctYy21Mqr6VvuK8/
         ZDl/D8NxMFfJsBveUsLZsCt34+r3qRS18Lewzd2zUonfOhtrBXiTsWvBHuTkE2GuM/2B
         HCTeIIfjUL3nRDhRtFzcNKFIbwjBwz4MuvBXXD5FHx6wO44w3sGwfBNQNpP387LDR9K8
         7Clg==
X-Gm-Message-State: AOAM533q9tEgx+/j+eHgGt9f/TA2lS7jBy1lZB1Dznf/vnYmHh52ZrU7
        jKPI02ubPhuc2quUy2mC/80zBg==
X-Google-Smtp-Source: ABdhPJxgmYu5bIUVNvFE7VgPMR99LUdMU6vwmBGEWTqhqDIZd9L+Ct0KgypnuqluDaoO5/INba8bTg==
X-Received: by 2002:a17:907:1c06:b0:6df:b257:cbb3 with SMTP id nc6-20020a1709071c0600b006dfb257cbb3mr18607442ejc.631.1652768706063;
        Mon, 16 May 2022 23:25:06 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id hv6-20020a17090760c600b006f3ef214e4dsm628655ejc.179.2022.05.16.23.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 23:25:05 -0700 (PDT)
Message-ID: <4889a6cd-ef96-595e-a117-2965aab97a54@linaro.org>
Date:   Tue, 17 May 2022 08:25:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH net v2] NFC: nci: fix sleep in atomic context bugs caused
 by nci_skb_alloc
Content-Language: en-US
To:     Duoming Zhou <duoming@zju.edu.cn>, linux-kernel@vger.kernel.org,
        kuba@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        gregkh@linuxfoundation.org, alexander.deucher@amd.com,
        broonie@kernel.org, netdev@vger.kernel.org
References: <20220517012530.75714-1-duoming@zju.edu.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517012530.75714-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 03:25, Duoming Zhou wrote:
> There are sleep in atomic context bugs when the request to secure
> element of st-nci is timeout. The root cause is that nci_skb_alloc
> with GFP_KERNEL parameter is called in st_nci_se_wt_timeout which is
> a timer handler. The call paths that could trigger bugs are shown below:
> 
>     (interrupt context 1)
> st_nci_se_wt_timeout
>   nci_hci_send_event
>     nci_hci_send_data
>       nci_skb_alloc(..., GFP_KERNEL) //may sleep
> 
>    (interrupt context 2)
> st_nci_se_wt_timeout
>   nci_hci_send_event
>     nci_hci_send_data
>       nci_send_data
>         nci_queue_tx_data_frags
>           nci_skb_alloc(..., GFP_KERNEL) //may sleep
> 
> This patch changes allocation mode of nci_skb_alloc from GFP_KERNEL to
> GFP_ATOMIC in order to prevent atomic context sleeping. The GFP_ATOMIC
> flag makes memory allocation operation could be used in atomic context.
> 
> Fixes: ed06aeefdac3 ("nfc: st-nci: Rename st21nfcb to st-nci")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v2:
>   - Change the Fixes tag to commit st_nci_se_wt_timeout was added.

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.13/source/Documentation/process/submitting-patches.rst#L543

If a tag was not added on purpose, please state why and what changed.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
