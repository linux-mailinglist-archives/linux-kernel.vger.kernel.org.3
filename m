Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393D14BB42D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiBRIb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:31:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiBRIbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:31:25 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C192DD40
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:31:08 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EEF443F1C9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645173066;
        bh=aC92jWRvHNaEtip7jAthsvaXw1jFODzyJaRgUH70hKg=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=JQGqii9Y+OLTlvt3uYK2ftTRIb1gLHdPMvE4nulXsle+Piv4NSYYeETLPnu90r8zI
         RTi4TD9VnybdNufIkmP+YopHTjQC9U+BzZ/RukXpUkN05ImZiudM0WoFE1sEGAajR8
         JhLjLDqCUt7sOl/xn/QLZ6NPtYHY6U2izQhSs9ffKgpLbRUBp3jEa1wsFdR6jDncH2
         BA/Dx5Ye5vgVyWnrzs2e+fdD7y9XpfBnJqvGmaDS/5xlwCOCkZUlV7yU/zVFtTnG66
         MPbQ5b9sMkPCCPP2BLssiD6SW41zqcZk1olNXlv+Fa4fn2BrQk04MDm/uAgCUug3qE
         byKwpslM1gqSA==
Received: by mail-ed1-f70.google.com with SMTP id j9-20020a056402238900b004128085d906so4242889eda.19
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:31:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aC92jWRvHNaEtip7jAthsvaXw1jFODzyJaRgUH70hKg=;
        b=ctDX9w2kHQs8HgHJu7iUJEuQCR5MrwBCzoVZdARZ/XLpBxSbORl+OhrjuEOiHc/WyO
         LUXlqLmJD0djS8ZMz+yXJFL3/fG2l26XGVD2rYNHuO74GoT8uzyKs35dW2KRPrI8pr9e
         3ZJy+mL6kyGDZdw88qGwFM8Ms9j2qmXHFst3BDLk4nRqY8jxXd3skXTzRjE1gooV6qP7
         hsAtGsy27VhNcDEjjp1QNnk4emlHAHapQXu0VxVrZEi33NJZ9PhxhPlceCraXYBxusDD
         GOKgPZUZ+VSDKnZccEOLFB3lsuPokjGKxu1QGqvGz9bhy8uf6UHSB+b8UJopQrGQ2pWr
         YPlQ==
X-Gm-Message-State: AOAM530GZxMlX6Wv7MTrkUXt1wa/6P7uTre8llryXhfzIDVEkO3oKeuz
        eitWdg8DsiODBULyQ+K097dhd7X3u44a05CsLxrS38diDLh8hsmBSbP1rnDWZkQ97Pm3bG73w5f
        t49HcEfmCklZwGCEQK+lSMqjvsMeTtmjIfIoKZM6UTw==
X-Received: by 2002:a17:906:3bc9:b0:6d0:8d78:e7e6 with SMTP id v9-20020a1709063bc900b006d08d78e7e6mr3179438ejf.222.1645173066554;
        Fri, 18 Feb 2022 00:31:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2u2VXIpAPEoBoY6BaKwMBiqPxrXKm9ExJSW+/bbvgrbKe9h0BxRUSt2c0Lndc6uf8qMfd2g==
X-Received: by 2002:a17:906:3bc9:b0:6d0:8d78:e7e6 with SMTP id v9-20020a1709063bc900b006d08d78e7e6mr3179410ejf.222.1645173065998;
        Fri, 18 Feb 2022 00:31:05 -0800 (PST)
Received: from [192.168.0.114] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v16sm1985190ejo.156.2022.02.18.00.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 00:31:05 -0800 (PST)
Message-ID: <608800b4-2e56-d925-5db9-0ec40f98cbb5@canonical.com>
Date:   Fri, 18 Feb 2022 09:31:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Content-Language: en-US
To:     =?UTF-8?B?RWR3aW4gQ2hpdSDpgrHlnoLls7A=?= <edwin.chiu@sunplus.com>,
        Edwin Chiu <edwinchiu0505tw@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <cover.1644218105.git.edwinchiu0505tw@gmail.com>
 <957d882222d218b62fe3fb7a069e2f7952afc5be.1644218105.git.edwinchiu0505tw@gmail.com>
 <64f91b1a-93b9-941d-fdfa-271e198e1ab5@canonical.com>
 <0edae7bea1ae47cd9044cd223a989b81@sphcmbx02.sunplus.com.tw>
 <136f2087-10e7-c9e8-2292-3046711c8f68@canonical.com>
 <eca9b5a613c9417cacdcb90eef5b2235@sphcmbx02.sunplus.com.tw>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <eca9b5a613c9417cacdcb90eef5b2235@sphcmbx02.sunplus.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2022 09:10, Edwin Chiu 邱垂峰 wrote:
> 
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> Sent: Monday, February 14, 2022 2:45 PM
>> To: Edwin Chiu 邱垂峰 <edwin.chiu@sunplus.com>; Edwin Chiu <edwinchiu0505tw@gmail.com>;
>> robh+dt@kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; rafael@kernel.org;
>> daniel.lezcano@linaro.org; linux-pm@vger.kernel.org
>> Subject: Re: [PATCH v4] cpuidle: sunplus: Create cpuidle driver for sunplus sp7021
>>
>> On 14/02/2022 03:55, Edwin Chiu 邱垂峰 wrote:
>>> Hi Krzysztof:
>>>
>>> Please see below answer.
>>>
>>>>> +static struct cpuidle_driver sp7021_idle_driver = {
>>>>> +	.name = "sp7021_idle",
>>>>> +	.owner = THIS_MODULE,
>>>>> +	/*
>>>>> +	 * State at index 0 is standby wfi and considered standard
>>>>> +	 * on all ARM platforms. If in some platforms simple wfi
>>>>> +	 * can't be used as "state 0", DT bindings must be implemented
>>>>> +	 * to work around this issue and allow installing a special
>>>>> +	 * handler for idle state index 0.
>>>>> +	 */
>>>>> +	.states[0] = {
>>>>> +		.enter                  = sp7021_enter_idle_state,
>>>>> +		.exit_latency           = 1,
>>>>> +		.target_residency       = 1,
>>>>> +		.power_usage		= UINT_MAX,
>>>>> +		.name                   = "WFI",
>>>>> +		.desc                   = "ARM WFI",
>>>>
>>>> I have impression that there is no point in having custom driver with WFI...
>>>>
>>>> Still the main question from Daniel and Sudeep stays: why do you need
>>>> this? You copied exactly cpuildle-arm driver, there is nothing
>>>> different here. At least I could not spot differences. Maybe except that you use cpu_v7_do_idle
>> explicitly.
>>>>
>>>> Unfortunately I cannot understand the explanation here:
>>>> https://lore.kernel.org/all/0812c44f777d4026b79df2e3698294be@sphcmbx0
>>>> 2.sunplus.com.tw/ Why exactly cpuidle-arm does not work in your case?
>>>>
>>> Edwin=> I mean cpuidle-arm driver can't directly use with no modified.
>>>        If someone want to use cpuidle-arm driver, below modification seems necessary.
>>>
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>        Static int sp7021_cpuidle_suspend_enter(unsigned long index) {~}
>>>        Static int __init sp7021_cpuidle_init(struct device_node *cpu_node, int cpu) {~}
>>>        Static const struct cpuidle_ops sc_smp_ops __initconst = {
>>>             .suspend = sp7021_cpuidle_suspend_enter,
>>>             .init = sp7021_cpuidle_init,
>>>        };
>>>        CPUIDLE_METHOD_OF_DECLARE(sc_smp, "sunplus,sc-smp", &sc_smp_ops); //declare
>> enable method
>>>
>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> ~~~~~~~~~~
>>>
>>>        But change cpuilde-arm.c for sunplus driver seems not reasonable.
>>>        That is why I want to submit cpuidle-sunplus.c
>>>        Althought sunplus cpuidle only come in WFI, but it can complete the cpuidle framework.
>>
>> I don't think it is correct. You can use cpuidle-arm, because it is being always initialized with
>> device_initcall(). You either use appropriate compatible in DT or add your compatible to cpuidle-arm.
>>
>> Even if this did not work, then the solution is to use common parts, not to duplicate entire driver.
>> Duplicating is not acceptable.
>>
>> Best regards,
>> Krzysztof
> 
> 
> I do used compatible = "arm,idle-state" in DT and enable generic arm cpuidle driver in menuconfig.
> But there have mount driver fail message due to no cpuidle_ops functions.
> That is why I need added patch code to complete cpuidle driver.
> According your comment, I will try to use common parts and hook some custom code, later. 

I think I understood the motivation behind your driver. The cpuidle-arm
requires enable-method property which usually uses for ARMv7
CPU_METHOD_OF_DECLARE(). You don't have CPU_METHOD_OF_DECLARE().

Now the question: why can't you define CPU_METHOD_OF_DECLARE() just like
many other ARMv7 platforms do?

Best regards,
Krzysztof
