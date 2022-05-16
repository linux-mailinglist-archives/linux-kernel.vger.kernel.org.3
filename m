Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2B9527D75
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbiEPGPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiEPGP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:15:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9131020F72
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:15:25 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j4so23966843lfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MbrhUEcuzEes1MO/m14edarYcpIuUGvSuSikQjaR1hE=;
        b=Sn1TX8yMxUDd9dFA7JN1VX/5hSF1sGO4sZJvAzgFrgMg1KXO5tIaUzIjFIZ9K2BPOB
         xAdm3v8nzF/lx8oqHsP5ByfhezClrPlVVlyFcGU/XexJ/7j/lMWCuSmdl84r8qbZ1Gsv
         d9I0ztX9ncvkuMuoKamGjK/HpjX2oklR6ZyuoJUkLK5+1SUKYJamnGJClMypAGH/qou/
         5Lvcdfx7GsGyi4TDqQ92OSF3jHdSB/GSGbu4K5qKMIYA7OWUXtkA+s/eQpVUgU1zepug
         fr85TEl+F00+3CxP7RNa9jKISw8ZB0zNbEXrAFxi47SQgc6UWXMkss91/96FCJr/9DxD
         9ssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MbrhUEcuzEes1MO/m14edarYcpIuUGvSuSikQjaR1hE=;
        b=STJphGoc2Sy/0+dJvF2hRNsbPKbcUoOK2Bgfx5sDgzFFVI5SYpj3h64ptONyH3Zk1d
         /HPzobC7SMkIYmz/Rkccp8GJ4CSfuIKPr9mCxQgL1AvPCUtOL8gbLQtkZnV5L0OFZD2B
         /2ZcnAKczrhu/RAvE47t2/S9WnAWC+3diBqMv86CrvbHUTfhSNxzSYhnyklwxrIaQdbz
         G/2e4n0qYoV0jlkkLdX1h52EQOGpk/vPva5wWrxBrRlKoTS98yoGQQWS57Kktk1zktZA
         uYvlwAd1A6CjQcYb04DuhTMzA9eAHUzfdhBZ+JOSGUwTY5StUulUTPqO77pEEHWRMf/P
         ijFg==
X-Gm-Message-State: AOAM532UB/CHfM9qKy4Dbdp7GWC/FOV6i6yeiaGDgAhmMSQQzXmajj0j
        wNhxnbky+DCpyAkF+speREE5zw==
X-Google-Smtp-Source: ABdhPJxWTtShK0m+i18kqeRDZwPku8a+AeCJwwbzUGTS9yC3+7/TdhrxlcYcBIMyy++49F3f2Rek/w==
X-Received: by 2002:a05:6512:3d06:b0:473:fe9a:25e9 with SMTP id d6-20020a0565123d0600b00473fe9a25e9mr12487447lfv.449.1652681723885;
        Sun, 15 May 2022 23:15:23 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e13-20020ac2546d000000b0047255d211fcsm1203927lfn.299.2022.05.15.23.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 23:15:23 -0700 (PDT)
Message-ID: <9a7514ab-4c01-6abf-68e2-5945d9415867@linaro.org>
Date:   Mon, 16 May 2022 08:15:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH net] NFC: nci: fix sleep in atomic context bugs caused by
 nci_skb_alloc
Content-Language: en-US
To:     Duoming Zhou <duoming@zju.edu.cn>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        gregkh@linuxfoundation.org, alexander.deucher@amd.com,
        broonie@kernel.org
References: <20220513133355.113222-1-duoming@zju.edu.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220513133355.113222-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 15:33, Duoming Zhou wrote:
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
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation ")
> Fixes: 11f54f228643 ("NFC: nci: Add HCI over NCI protocol support")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
