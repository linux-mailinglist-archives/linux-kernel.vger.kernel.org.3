Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D977357951F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbiGSISi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbiGSISh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:18:37 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3161B24F18
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:18:36 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id r14so1746067ljp.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ZztkaYJ91HFFvyieZIM0/ccJXZ2NznRp6zL6/ptE9sU=;
        b=RkwNhKuICO1vVn+vkXfHvITpgSUtS7RUfCn3yCBx1qOSXvQoUtzr1my7+UyMRnQu+2
         vkWKOTFTM/jYl+SXBPhAf5pwjoeMkXdC4/+59MF3HxNl44gn3jnc/jlK8glvGMR8NJ80
         xytqoxNsqu1xjQhQNNaFcN3f27VLNJj1ihibek4KKXLEP1SxpMQb3w2x3iwYStpvlH0u
         8Hf2uIwlcC4ZVNoCrxqPW/84aP3pYcaiLvmEh0qpKfifmIKoTdTQ/x3TWxVwNbr4zWUV
         6VSc1m1C6MXjzuZ135zO6dI3G4rm8OJl8UdJpdF4/wW+WoTB3+KvdN4p75nM85P2n5d6
         Lheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZztkaYJ91HFFvyieZIM0/ccJXZ2NznRp6zL6/ptE9sU=;
        b=0D7v57GMDPbzcqB9VfV4sbw4CxjOydX2QzWZpFFILLCJAxIFqKaBMObLBO5OfED3p7
         CSM5ta00TcYlwQrDpbCxuK3oeSAXiHcb0DA1mtEMgDvJIJCS6RE466aQfvGgWuBoNYA1
         XbTD/PiqeZxMEp9sMsY24fWdImeBr1tDa5w2RpMB9tKqUJaQKrGzIf3coBHWsR2934X4
         8tyOl8eHFAsjrhoeJghnaYGBi0e319P7wyOVgkm2gK05kPfUIWMOItddx1ZYqjJJ3WhC
         Lbj9uz6MIlTdMTI2Z4cfT3ZtTgRo0Kbk+yaWMTFf08EpCO1JY8eMfF/49LpvjCApg/8r
         KxpQ==
X-Gm-Message-State: AJIora+7/bRumJ/gcOlqqQ1H0itNzpsiyWbqHs8T3vdAjt+yM2mqCWGW
        0pbKS7i7OzVv/jS3grqOa1v2PKHmNWuxDYc2
X-Google-Smtp-Source: AGRyM1tQ52amhtXFZmmYq57YrL4gn5R1uOlPkHXvajitcKWIWCyDEMDr4mdNmV5BDkL33/Rixlugcw==
X-Received: by 2002:a2e:a303:0:b0:25d:644c:9d7a with SMTP id l3-20020a2ea303000000b0025d644c9d7amr13669029lje.426.1658218714501;
        Tue, 19 Jul 2022 01:18:34 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id k13-20020a05651239cd00b0047f9915aec0sm3059582lfu.293.2022.07.19.01.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 01:18:32 -0700 (PDT)
Message-ID: <4be14ed4-17de-a90b-e899-536552d6c3c7@linaro.org>
Date:   Tue, 19 Jul 2022 10:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] memory: of: Add of_node_put() when breaking out of
 for_each_child_of_node()
Content-Language: en-US
To:     Liang He <windhl@126.com>, linux-kernel@vger.kernel.org
References: <20220716025043.447036-1-windhl@126.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220716025043.447036-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2022 04:50, Liang He wrote:
> In of_get_ddr_timings() and of_lpddr3_get_ddr_timings(), we should
> add the of_node_put() when breaking out of for_each_child_of_node()
> as it will automatically increase and decrease the refcount.
> 

Thank you for your patch. There is something to discuss/improve.

> Fixes: 976897dd96db ("memory: Extend of_memory with LPDDR3 support")
> Fixes: e6b42eb6a66c ("memory: emif: add device tree support to emif driver")

Please split the patches into two separate fixes.

> Signed-off-by: Liang He <windhl@126.com>
> ---
>  drivers/memory/of_memory.c | 2 ++
>  1 file changed, 2 insertions(+)
Best regards,
Krzysztof
