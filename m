Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709AA5968AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbiHQFjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiHQFi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:38:58 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CAF4DF3E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:38:55 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l21so12572064ljj.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=hJQ+G2q+PJJ817bdNue0It6aaQL/wDQ9FFpmsAzXz+Q=;
        b=uZy1DBbbXN5ca20xZqyHR2gSmBrAxZIVSQ7csB8vRh27lanpLSsTLO/mUURLSIXyNY
         9UeZxHZ4UJUIA13jkjfMHxAPuN5TacXJHUEWCxFqzffVOEvxuoZnNO8jk3j70lifjLKW
         HHHpCwkK1E/ncIUJGib/X0NDr8oKhQl+JTnZ6/x18GHovyT6ROv7pMJGmFa3ejbunUud
         IMPmzRrDQNLxYoFySnCkMSF/x7eqsL02j+ncSUXkUwT2auKbFqD8VBqASbFNC+ROcI3g
         uCNkMrXXMEY3iLskRwJ7aGVAMzrbBourAt8gRJlzFcCq2dIMSqVDoZADbrJhA3C/jX5r
         BKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=hJQ+G2q+PJJ817bdNue0It6aaQL/wDQ9FFpmsAzXz+Q=;
        b=lJT3yywbaJiWVCd//ucoi0n1HRPcQKEc2WL1uh2CrxUei7OPmxy3B7Suflc87TPC0w
         4Au9dwWzdtovDGd1KCgT5n2bfnU65rwS9HiLuuy2J3L80Oo/5L58xvPGKzPfFWWvZxIW
         +3CiHmM9pSQnjy5xvTA/XDIzyI2EvDxX3SbRL/ilhQqvG71WDC/JYfemuHV997Ejtv3L
         8/dUFrqYAI8o3NCSWnJ9a5i2C4PQCZzAtxqL4pw6OF/s/+Xt7UeJBQbCk6fNf/4exT+u
         SPBmmmoe3AunAmhsShx3go37HKivoZEeYcBLAsSwlk8qWkioLAiUd0T/Q0b6iha09sgU
         NHQg==
X-Gm-Message-State: ACgBeo2hRuN/XU4fC8X67Z/ExP12km4+iQjJQaMXyIFZ5HdRXqRg/Soa
        q/TZXeko29Z9YDTyVjH+f5pJbA==
X-Google-Smtp-Source: AA6agR5kleeXG5u5qS+dHTDKcUqrs/ENiHZgNcFjVkFeGy1twEIyQXzvp6EXjBPPCOGBlEkn2Iue6g==
X-Received: by 2002:a2e:8181:0:b0:25f:e028:a67 with SMTP id e1-20020a2e8181000000b0025fe0280a67mr7713765ljg.89.1660714733871;
        Tue, 16 Aug 2022 22:38:53 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1b1c:14b7:109b:ed76? (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id v4-20020a05651203a400b0048b17ecee71sm1562918lfp.302.2022.08.16.22.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 22:38:53 -0700 (PDT)
Message-ID: <8d0c0326-c0df-efa4-5962-cd1282b33f43@linaro.org>
Date:   Wed, 17 Aug 2022 08:38:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 02/14] drm/qaic: Add uapi and core driver file
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, airlied@linux.ie,
        daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de
Cc:     quic_carlv@quicinc.com, quic_ajitpals@quicinc.com,
        quic_pkanojiy@quicinc.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1660588956-24027-1-git-send-email-quic_jhugo@quicinc.com>
 <1660588956-24027-3-git-send-email-quic_jhugo@quicinc.com>
 <10ad6023-703d-65cf-6b00-2caa658c49e9@linaro.org>
 <e9786447-edd4-90e0-25a9-b35e96adbfc2@quicinc.com>
 <3f755d24-969b-1804-7979-880a9fe10cba@linaro.org>
 <9eba0937-b4cb-4c62-e339-8ff33aebdbde@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9eba0937-b4cb-4c62-e339-8ff33aebdbde@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2022 21:22, Jeffrey Hugo wrote:
>>>>> +	if (datapath_polling) {
>>>>> +		poll_datapath = true;
>>>>> +		pr_info("qaic: driver initializing in datapath polling mode\n");
>>>>
>>>> No pr() in normal path of init/exit.
>>>
>>> This is not the normal path.  datapath_polling is a module parameter.
>>> This is something the user can enable, and so it would be good to have
>>> the user informed that the option took effect.
>>
>> No, not really. User always can check via sysfs and there is no point in
>> polluting dmesg on module load. It might be printed (if someone has such
>> modprobe setting) on every system, even without the actual device.
> 
> So, I guess this is limited to platform devices?
> I see GIC, IOMMU, and PCI doing the same
> I guess, will remove.

None of regular drivers should print anything during init/exit. If one
is printing, I think a patch removing it will be accepted.

However you mention platform devices, so a "device" implies probe, not
init. This is a different case.

Best regards,
Krzysztof
