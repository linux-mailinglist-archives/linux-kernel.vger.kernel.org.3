Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0894A583E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbiG1L7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbiG1L7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:59:21 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857B568DFB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:59:20 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c24so1242559qkm.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=29OwqlQHILsVaDC4GK1f4lUMX8zl+6SGmVC3rD0Xxb8=;
        b=GGQ014kMSRqc0Es0etwHrSuCvnVUOZxZY3BdRaKIgbkKs5U/5NHk2ts5RJra66dDHO
         hjtbFrHsDLt/AqSnSFrUUOy+YisggHDWvIWBs58AC3J2MstDXhlXwYSAbfAqdrPa1btE
         QdzEiqtKQ0fd67X9tbCcEBNhQPfIQqQJpQLsjvmbkQJx28YlgGwcVMxiaNBvtTFRwysg
         5N1tAZtkM3lqMxscxNnVBkSXIP5ouu2Gz0LY68NdeVSaDlgGh/cMVitRb4CqVc4AAiQ8
         y7YNzGNI132HGWC63AlsBU9Knx/O54e6YpP/dAFm662cFmDMjW4GgaxHQ1h/aFK4J2Lo
         N+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=29OwqlQHILsVaDC4GK1f4lUMX8zl+6SGmVC3rD0Xxb8=;
        b=6OkOyYEFRbTT3sMVn/h/3VGe5N/nwYqjoebHYcF4KuN30SIEdn777js/3zKEb+aMVj
         0dI784f5QVriESYZlh/jeEtJY6Tw4RH81sjWowhsoU31KL8+smsAlKYTKfQ/A6U0k7Ss
         blUpQTwAj5LPlVwjsJdfmcCHNp+tWFyNRgtKrpWq61EGDhq6SH8c/5p1UJse9z/Rb4bF
         HJzEZ5s21emDs3Cc9+3FfPWuJPPdIY2K/HO270mRrzmZ470MXetdlUQ5aVKMGC3parZw
         AyHmyX3mAKd9eMWn9xFrjZPA7cUKGv39LdiqIgKixiujVfH2vZy/m/KO5MKcs4XRDGU9
         KpKg==
X-Gm-Message-State: AJIora/KUJ7lKcMm1CGtLu29nnEUEkoaYDWysmby0iS+Pxi1u8lADCw4
        yvFyTsF4Dke+m/ZCdjgoSnZCyA==
X-Google-Smtp-Source: AGRyM1vdHV0E3hl+iNCdeR4ZM2G7OdOtimqFrnDhOaVn1NiRef9VbKCb9IEIbt8EHTJN0uhyMaLmLg==
X-Received: by 2002:a05:620a:4046:b0:6b5:f68a:bb7f with SMTP id i6-20020a05620a404600b006b5f68abb7fmr20339680qko.62.1659009559657;
        Thu, 28 Jul 2022 04:59:19 -0700 (PDT)
Received: from [192.168.0.189] (modemcable134.222-177-173.mc.videotron.ca. [173.177.222.134])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a448a00b006b618e006ffsm422398qkp.2.2022.07.28.04.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 04:59:18 -0700 (PDT)
Subject: Re: [PATCH 0/2] arm64 defconfig: Get faddr2line working
To:     Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     John Garry <john.garry@huawei.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
References: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a0umWWic6LAzxXJ7BACYVE--m-wbynh7Z8F+pGoUBxGTA@mail.gmail.com>
 <25237c44-ebc4-fc9a-7c6f-3e990f968038@huawei.com>
 <CAK8P3a2+0EwSJ=fRBL2JCGypJRL-qE4rEiXYnJbqhZ=weethdQ@mail.gmail.com>
 <b39bf8c4-c702-8f49-12aa-d3ac05889b80@huawei.com>
 <CAK8P3a0w+_MLOjJAKMENe6MYvBcXWXSir47Hz34WbtdEeAmaBw@mail.gmail.com>
 <4d010f40-6c4c-32c7-2772-1bbfa02c03b7@linaro.org>
 <CAK8P3a38uGGGLA4b2bi=v8cV6-dH5yEcvBYcwr5ChzkwMTX9_Q@mail.gmail.com>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <966a62da-52b6-1789-13d6-5fe06b62c7fe@marek.ca>
Date:   Thu, 28 Jul 2022 07:57:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a38uGGGLA4b2bi=v8cV6-dH5yEcvBYcwr5ChzkwMTX9_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 5:09 AM, Arnd Bergmann wrote:

...

> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 22b706350ead..f65c7737c2db 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -1289,11 +1289,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>          data = of_device_get_match_data(dev);
>          ctrl->rows_index = sdw_find_row_index(data->default_rows);
>          ctrl->cols_index = sdw_find_col_index(data->default_cols);
> -#if IS_REACHABLE(CONFIG_SLIMBUS)
> -       if (dev->parent->bus == &slimbus_bus) {
> -#else
> -       if (false) {
> -#endif
> +       if (IS_ENABLED(CONFIG_SLIMBUS) && dev->parent->bus == &slimbus_bus) {
>                  ctrl->reg_read = qcom_swrm_ahb_reg_read;
>                  ctrl->reg_write = qcom_swrm_ahb_reg_write;
>                  ctrl->regmap = dev_get_regmap(dev->parent, NULL);
> 

This relies on the compiler optimizing out the reference to slimbus_bus, 
which doesn't exist in the CONFIG_SLIMBUS=n case (not tested, but I 
think this means an O0 build will fail?).
