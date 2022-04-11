Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48094FBE48
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346918AbiDKOHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346939AbiDKOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:07:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DDC1F60F;
        Mon, 11 Apr 2022 07:04:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so16943610pjk.4;
        Mon, 11 Apr 2022 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=HxOmBDd+ZffgklGgbHnwMBpdgHlZMicdAtEhFhUS5fk=;
        b=pLYN47u+ukYGU2o/HJwVjI4zbKTBrD7kfKOMeHrN21CWiwFzoR9lq6dEFG3C9n0oIU
         zfYlG86hF2Mdc9zcCIgVZtwhsUCVS0IN/M40TnJZAoMUeKKfEcbAG7ISYQp/JS8ThGbx
         B/EJ27qU2wcFHO3v6THnHNh1OT15tXN6X+A6U1qwaDm1Fll+MmzQQ4qJMIstWQEEf4r2
         DmB9+diRqjdsr4Q1grn7Ek72d65ker/J7HIpFOhqhAa80aPz3O7rS6Wmt234bi488j93
         1qK4krlGY8HU4SwGp7cGJdRcuWHeUGBoBx4eNo4W09jVCncTKK1hwvtZQ5j+I56OT7i0
         8dmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HxOmBDd+ZffgklGgbHnwMBpdgHlZMicdAtEhFhUS5fk=;
        b=ZPhsb3437KMsU1wFTIsalu39Hr915OPMByqcpSz2a+eZ3FF4k9emsUzPd+WPKYYwEW
         PmeKpeiEFbQTyPAojJ8dR8WFnbHBeKzBwMZrX73nhKgUYzCaw7it9Qw8OddoeT9C+PLz
         NBEMKe0NHyqxeIpvdzlxio1FG8HnwEAzuvL74J8rmHkSShRm5R7m/bg70VBSm3Is0VCU
         ev6NO9GcJogYVfWjB6j6HHcBdD/8a+GQWDWV3A9qjVS+UaaD4EhBacAzfbC5+0k+qUNS
         tflRRq9wfYcky3h+EgNCR9YkAnL5jXDhEq5A+pzPANTVL8bgGTQZN+GwCGynDHSppZuP
         oz2w==
X-Gm-Message-State: AOAM533ITNBn5j9z6t+SVj7UFXpycyxxGiJarOwrqbKnGSVu8kNeI+Bl
        kx+VrBX+mPOYP+xCGlcYzF8=
X-Google-Smtp-Source: ABdhPJxFhZsZJrc0CubOdHvN+RQXQffBGIwYtZ3PVdsfllhqaBrYZvH+6sdRZTjPlxTzjzZbEKOrZQ==
X-Received: by 2002:a17:903:248:b0:155:e660:b774 with SMTP id j8-20020a170903024800b00155e660b774mr32999779plh.174.1649685889726;
        Mon, 11 Apr 2022 07:04:49 -0700 (PDT)
Received: from [172.16.10.243] ([219.143.128.237])
        by smtp.gmail.com with ESMTPSA id h189-20020a636cc6000000b0039841f669bcsm30013312pgc.78.2022.04.11.07.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 07:04:49 -0700 (PDT)
Message-ID: <60e67c07-7e40-4187-a90a-1be9acdfe757@gmail.com>
Date:   Mon, 11 Apr 2022 22:04:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] iio: stmpe-adc: Fix wait_for_completion_timeout return
 value check
Content-Language: en-US
To:     Philippe Schenker <philippe.schenker@toradex.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220411103032.14038-1-linmq006@gmail.com>
 <8b40cdebc07ff7ca29aa9fc03b8d9c40754ab4bd.camel@toradex.com>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <8b40cdebc07ff7ca29aa9fc03b8d9c40754ab4bd.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/11 20:05, Philippe Schenker wrote:
> On Mon, 2022-04-11 at 10:30 +0000, Miaoqian Lin wrote:
>> wait_for_completion_timeout() returns unsigned long not long.
>> it returns 0 if timed out, and positive if completed.
>> The check for <= 0 is ambiguous and should be == 0 here
>> indicating timeout which is the only error case
> Hello and thanks for your fix. Any specific reason you didn't apply this
> also in function stmpe_read_temp?

Hi，sorry I just missed that. I will send v2 to fix this.


>> Fixes: e813dde6f833 ("iio: stmpe-adc: Use
>> wait_for_completion_timeout")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> ---
>>  drivers/iio/adc/stmpe-adc.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
>> index d2d405388499..d475d1c17bfc 100644
>> --- a/drivers/iio/adc/stmpe-adc.c
>> +++ b/drivers/iio/adc/stmpe-adc.c
>> @@ -61,7 +61,7 @@ struct stmpe_adc {
>>  static int stmpe_read_voltage(struct stmpe_adc *info,
>>                 struct iio_chan_spec const *chan, int *val)
>>  {
>> -       long ret;
>> +       unsigned long ret;
>>  
>>         mutex_lock(&info->lock);
>>  
>> @@ -79,7 +79,7 @@ static int stmpe_read_voltage(struct stmpe_adc
>> *info,
>>  
>>         ret = wait_for_completion_timeout(&info->completion,
>> STMPE_ADC_TIMEOUT);
>>  
>> -       if (ret <= 0) {
>> +       if (ret == 0) {
>>                 stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_STA,
>>                                 STMPE_ADC_CH(info->channel));
>>                 mutex_unlock(&info->lock);
