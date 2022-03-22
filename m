Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED604E3B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiCVI6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiCVI5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:57:52 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F49729C9C;
        Tue, 22 Mar 2022 01:56:25 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id b19so23899725wrh.11;
        Tue, 22 Mar 2022 01:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4IDTqc3vS0homRb5egEok1VAKstmLtnVq0FuLPeo1/I=;
        b=fI0YkxoYnWriJDzISwKrT/RUs0HreSjLl54+DnfaZU9yUYEj0At0eYTRKlYY6DBuON
         yW8138Vff/Q/YaHWa3a28iqMCFYbfqEHVDka6hSOCjA9qdY+f05BN0IVDMytta9619as
         qJE9KWOEWfLlr/jGCJHQYQDgHYNJuMD1w/WHPqlZe9x1Uw77G/AUBw97IybkTWnNS/pu
         y+IH2h1vTZZHXW1N1t9V0FpuJZgoT2bFymQgbNaRxPYJlMrgqQZD7YQ87TOx6hR90w5u
         fIOA/v8SAZaij4bxq+H+62F36G5+cD9UnAOdu9Y8sKN4t0X4/vFVhXaw2AmqdDsEye5H
         3KtQ==
X-Gm-Message-State: AOAM531qnKnc4cM4h+azfwENRI9Mo9nFm1XiFVdqiNds7I6Ro5uHPRaS
        hxW9DW6EB+Bkz7biM2AJHnY=
X-Google-Smtp-Source: ABdhPJw3LqEXSODpm7x6a7J1hW37RYctIUsVBlf4FNn9sxGpKqFJ02EMCbHoSiDm/MN0asiqrU6/hg==
X-Received: by 2002:a5d:588b:0:b0:204:1c1a:965d with SMTP id n11-20020a5d588b000000b002041c1a965dmr4922405wrf.669.1647939383900;
        Tue, 22 Mar 2022 01:56:23 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id l9-20020a5d6d89000000b00203d62072c4sm16804387wrs.43.2022.03.22.01.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 01:56:23 -0700 (PDT)
Message-ID: <870f8623-8a99-09b6-56c6-0f8c010af237@kernel.org>
Date:   Tue, 22 Mar 2022 09:56:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/2] thermal: Add thermal driver for Sunplus SP7021
Content-Language: en-US
To:     =?UTF-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
References: <cover.1647399369.git.lhjeff911@gmail.com>
 <a658d7513a62e067086d8e2a73920bb892293569.1647399369.git.lhjeff911@gmail.com>
 <9b263f80-15df-efd3-2682-0adda06f5b5f@canonical.com>
 <4c05e7767bfe401b8c139e159855fe77@sphcmbx02.sunplus.com.tw>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <4c05e7767bfe401b8c139e159855fe77@sphcmbx02.sunplus.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 03:55, Lh Kuo 郭力豪 wrote:
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	if (IS_ERR(res))
>>> +		return dev_err_probe(&pdev->dev, PTR_ERR(res), "resource get
>>> +fail\n");
>>> +
>>> +	sp_data->regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>>> +	if (IS_ERR(sp_data->regs))
>>> +		return dev_err_probe(&pdev->dev, PTR_ERR(sp_data->regs), "mas_base
>>> +get fail\n");
>>
>> Use devm_platform_ioremap_resource() instead.
>>
> 
> Other drivers must also access these registers.
> Warning when using devm_platform_ioremap_resource
> Can I keep the original settings?

You should not map one region twice. How do you guarantee
synchronization during for example updates of specific registers? In
such case you need to use regmap and share it via syscon (although this
does not solve synchronization on higher level - avoiding conflicting
changes to same registers)


Best regards,
Krzysztof
