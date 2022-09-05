Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E7B5ACB1F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiIEGhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiIEGgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:36:52 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC34B33E04
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:36:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z25so11764207lfr.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 23:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gu2T/45m5AD+7ItmxlKKRXx6O6owwnqgWlgcp4TzOxE=;
        b=FUCDZ3a1HUvgGOt7gjfiseJAb6VttELEuPLL3CvfD3qlT1zVmdkdTqgWmqnuaZCY5g
         aQ6Qcj/RNWhm4/9YS/21JWaHd2W2/QTT2fPX8uwXLqobCClJuwILdqYrtaCJk/H3nqcS
         ePnmp6HpTJheFVvvbLoUV2OmoahbVswnuDMxzuAt/bEpYoJK9DNaF2iXZjH5XxjDHA9C
         +8GDLlIkOa1XCQExs1gkjuc0nctgb2HFqV0S+0Z3gklwA0HL329DcZQYwqPkVOFih8x5
         ZJtfas7R4Isz+DrzCFIArJem5ElOq2ips62CNpQxULttfblI3gEJ4bNq2Tq5BD5hiebs
         90Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gu2T/45m5AD+7ItmxlKKRXx6O6owwnqgWlgcp4TzOxE=;
        b=3UjLgOCQp21kIH3tW8Jf2M4OPgODGNbBgkxZ8DITvhSl1fHM+DpMukAg8JF2uVf596
         kDZcIQxSq8Gzq7CFYA2XPRo68wl17c6wPr2K/u/JibqS6INcL1QcDzzBS2fspyzJf+P5
         YOg2iyWl7/PIEpQZirCJZ0zXHJXtobf0LPCR1sKoIzEL+pIPW2ZJL8TvkauXlTyOzdnv
         6LQMYGuvfkUCFRnvy8u9lLEftRNre+676x5xdKAqmuNIGYnd8QUWu8b/6XxNVh57o5WJ
         /McY54L5AMHOPsOSicmKJlfpT4auEjmkha8wx+H927lLSpojEc6ytV5/qTm7gVkvrGaz
         10fA==
X-Gm-Message-State: ACgBeo195tyxYUCLOScEx74IqPgoUpmPdrsgEldLavH6xZxIyGuT8vpk
        vMCYYcIbiXSOqaiSi5A7jhRBmA==
X-Google-Smtp-Source: AA6agR6uBDAn3m2QSCCwuOANdeTxFvmrMQI0euRBNr/SmDs1GYiWcmBKpIylp+N+RTbpF+DxDohAqw==
X-Received: by 2002:a05:6512:128e:b0:491:4087:d853 with SMTP id u14-20020a056512128e00b004914087d853mr17592003lfs.537.1662359795997;
        Sun, 04 Sep 2022 23:36:35 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g13-20020a19ee0d000000b00494618889c0sm1091831lfb.42.2022.09.04.23.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 23:36:35 -0700 (PDT)
Message-ID: <f054845b-a1cc-88bc-59cf-14226eb4685f@linaro.org>
Date:   Mon, 5 Sep 2022 09:36:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] driver core: fix driver_set_override() issue with empty
 strings
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        stable <stable@kernel.org>, Huisong Li <lihuisong@huawei.com>
References: <20220901163734.3583106-1-gregkh@linuxfoundation.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901163734.3583106-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 19:37, Greg Kroah-Hartman wrote:
> Python likes to send an empty string for some sysfs files, including the
> driver_override field.  When commit 23d99baf9d72 ("PCI: Use
> driver_set_override() instead of open-coding") moved the PCI core to use
> the driver core function instead of hand-rolling their own handler, this
> showed up as a regression from some userspace tools, like DPDK.
> 
> Fix this up by actually looking at the length of the string first
> instead of trusting that userspace got it correct.
> 
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Fixes: 23d99baf9d72 ("PCI: Use driver_set_override() instead of open-coding")
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: stable <stable@kernel.org>
> Tested-by: Huisong Li <lihuisong@huawei.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
