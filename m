Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1374FF434
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiDMJzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiDMJzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:55:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F774EA2C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:53:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id t11so2753666eju.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vp9K+8Hl4/NfsYzNXBDKIhozV5SgmyerqnOmyR+rh00=;
        b=e8xdp0/auxVF/syVgSVHQFmbTch2hhK5Xh9aaDtS6tDhKPK1XilTbW3hqYJFYQliOO
         sKqX23UAyha4hpBGY2LpsYt+HlAfRDDLaGpsP6epuDOtpeORPHO8IrS2iV5JhpJhpFFK
         6G2th66uz61Sv8h9MyeJF9ckVpHz1fzEquPa4BKlGenQQh8GEANtGBhsnpCo0bQYAMHt
         6qVWQbINvpuyUsPBq/Z4djh8JSGr2TFLgExlElb98KmPW35VckG/DBRSI+r/5Bnu3jvP
         d3iFwroziSyK1YquB0ypHxGtY17bKByqdcurS9oScVEowfimZJz+9ji2Qqph0qSvv1K7
         dB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vp9K+8Hl4/NfsYzNXBDKIhozV5SgmyerqnOmyR+rh00=;
        b=cdmAJXmsnBK4HV6ExyZVTfMKdAElGfP9ej7skJweOm0ExOboyII9GmJ0pWkbLMOXE5
         UYn2kRMvREma+ZnkNoS/lbeVADP107kjfGL0pUqR3JVX3wN1+eiqjWlbfRWVTcIeIa/q
         HqXgVTCOg2HoirilRRCALQGvfL5eXsHKpzIQbgP9AJhpTxNbJCJNatqvgHJeBt9a0ga2
         59bHAL1GOXbL0Uc1e5PKtvKGgJyqxPzGinHmqfwbctsfSX9BBJ3HwgN/YwMWFrKonzKS
         jQbdwP4KfKB+GR4Wv7nyHkfifdnbC1CL6W+SN39WHY8pCxhXvr531rI6uU/jmQVPqMZD
         zEuw==
X-Gm-Message-State: AOAM532zaBBgR0yqAlflvfaMBdHIDtwlBNJ0WaoYppoXcOp6a/CxgWuT
        HxS86u4MdQOIh9VuV85BwxYBTzV+sBX5H0Nf
X-Google-Smtp-Source: ABdhPJybwN+GXtG5z+gqsAv8zWtLVN850stkyxlqVGXwWhY95IkEqpMLUEB90jUjvfeLJXDp3vJKmg==
X-Received: by 2002:a17:907:3f25:b0:6b0:5e9a:83 with SMTP id hq37-20020a1709073f2500b006b05e9a0083mr40143493ejc.659.1649843600618;
        Wed, 13 Apr 2022 02:53:20 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id kv22-20020a17090778d600b006e8a072fb1dsm2539456ejc.172.2022.04.13.02.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 02:53:19 -0700 (PDT)
Message-ID: <5691451b-a2a7-9ac7-abf4-06e4ed804db9@linaro.org>
Date:   Wed, 13 Apr 2022 11:53:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4] memory: renesas-rpc-if: Fix HF/OSPI data transfer in
 Manual Mode
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, linux-mtd@lists.infradead.org,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>
References: <cde9bfacf704c81865f57b15d1b48a4793da4286.1649681476.git.geert+renesas@glider.be>
 <164984328891.36085.9849925261305937604.b4-ty@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <164984328891.36085.9849925261305937604.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 11:48, Krzysztof Kozlowski wrote:
> On Mon, 11 Apr 2022 14:53:45 +0200, Geert Uytterhoeven wrote:
>> HyperFlash devices fail to probe:
>>
>>     rpc-if-hyperflash rpc-if-hyperflash: probing of hyperbus device failed
>>
>> In HyperFlash or Octal-SPI Flash mode, the Transfer Data Enable bits
>> (SPIDE) in the Manual Mode Enable Setting Register (SMENR) are derived
>> from half of the transfer size, cfr. the rpcif_bits_set() helper
>> function.  However, rpcif_reg_{read,write}() does not take the bus size
>> into account, and does not double all Manual Mode Data Register access
>> sizes when communicating with a HyperFlash or Octal-SPI Flash device.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] memory: renesas-rpc-if: Fix HF/OSPI data transfer in Manual Mode
>       commit: 953d7e7cedb49fec97807166be6fa1ecec1cf0c4
> 


Amended. This is not a proper tag:

WARNING: Unexpected content after email: 'Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> [QSPI]', should be: 'Lad
Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> (QSPI)'
#30:
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> [QSPI]


Best regards,
Krzysztof
