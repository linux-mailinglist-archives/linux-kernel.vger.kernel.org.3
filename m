Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157FB5573B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiFWHQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiFWHQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:16:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE4B45AC8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:16:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z7so27157709edm.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Cll48XQjSTk7Px9A3T9Ss8n7MDZa7XaBt+noA+sIkX0=;
        b=lfUMk/6WWkQfd1u6eIEAt5S6MO04bvoWQpmpBKEIaEYfIL1pY4UIBGPNPqOvjJ1v2a
         hqH4reyTh97v+KohVSS4u+dsf3AuqB87nyxyRevUaGammMtU6g+Xk4OJaDI46ItneMfX
         ikHeHDp/TzScw3BOUiq5KLaJKyrBBJNWaxa52jwTclMLPVZhaLBy7fpXHj6Q1kehPIXY
         +5wN/GMku84YN4yrYABNIGEgcvjmGKdFvXCeHVWKHwEt4qfZkoiqwbMUa6Aw/rhHIuZB
         EZQ5X+zmNWObZEKBCO7NrXe6EyDlYS0jVqyZEOX6nlkk854dtYc9YRbxK1jrZkEsuml3
         Ks9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cll48XQjSTk7Px9A3T9Ss8n7MDZa7XaBt+noA+sIkX0=;
        b=lmNvFeW0wpYTzu0aMirFbd+PCqgCsqsgoB/2uVpjL/IkVRi2ivsfAwb8kGmcLfxVO4
         siFupIYF/CpG+F3OlLno281LNqZD9yEq9eOKuImNTRmH/uo0lNhA/uBA+p3iuZ/GObC5
         Q4lCnEOlm+tSEMalvHf1vkjX1ZjFnlZgEDUsjImkgbwW4654yd+48tfT91dAi6SnzEhf
         +5yw6NtrFB5pS/QT/5Cv9YfPjL1om3wdxmWyQspiT5wFBQkvPR7B++5bojJlitHl7RE/
         UjZu8Sk0IT6tZioiCnz43c+bHGj1yd0HnhRWhqF60UUJXwDwZsSF73uUSjY1J3KjVwGA
         yKbQ==
X-Gm-Message-State: AJIora98fYIDSWy1ZXcRI5srSlIJSh8D7gFQCHWskQ3yDT2EvUqwjGEW
        IlgGMFgFagCP34piDs28ZoeueQ==
X-Google-Smtp-Source: AGRyM1tK/+zU1nkRE73+oAyAzR1niE0FCivKu9SrXPJ6oaNUJvOowbMlui+VsaW/AcUv17K0T2LlBg==
X-Received: by 2002:a05:6402:430a:b0:435:8ec9:31ec with SMTP id m10-20020a056402430a00b004358ec931ecmr8812330edc.248.1655968562421;
        Thu, 23 Jun 2022 00:16:02 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g5-20020a50d5c5000000b004356c0d7436sm13430643edj.42.2022.06.23.00.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 00:16:02 -0700 (PDT)
Message-ID: <c155d5ab-f765-e547-3d1d-62df54c615ac@linaro.org>
Date:   Thu, 23 Jun 2022 09:16:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/3] scsi: ufs: ufshcd: constify pointed data
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <20220613100655.105301-1-krzysztof.kozlowski@linaro.org>
 <20220613100655.105301-4-krzysztof.kozlowski@linaro.org>
 <08544601-3364-0352-415f-2e3576b84976@acm.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <08544601-3364-0352-415f-2e3576b84976@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 18:13, Bart Van Assche wrote:
> On 6/13/22 03:06, Krzysztof Kozlowski wrote:
>> Constify arrays and pointers to data which is not modified for code
>                                               ^^
>> safety.
> 
> is -> are?
> 
>> @@ -7848,7 +7850,7 @@ static int ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
>>   	u32 granularity, peer_granularity;
>>   	u32 pa_tactivate, peer_pa_tactivate;
>>   	u32 pa_tactivate_us, peer_pa_tactivate_us;
>> -	u8 gran_to_us_table[] = {1, 4, 8, 16, 32, 100};
>> +	const u8 gran_to_us_table[] = {1, 4, 8, 16, 32, 100};
> 
> Can this array be declared static? Anyway:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Could be, it's a kind of optimization, so a bit different problem. I'll
send v4 with language fix, static and your review.

Best regards,
Krzysztof
