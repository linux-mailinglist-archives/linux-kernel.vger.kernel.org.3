Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6152081D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiEIXH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiEIXHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:07:54 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BB12BA987
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 16:03:59 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e93bbb54f9so16407271fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 16:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TwRG+JFhON5lLu3KLkH+RkE4aoR4GwpF0SJGcrPkzyY=;
        b=GaUBnzSymG2bC277lQirDdnIofVnOiKg59bWVuHjGiY8uhiH+k8q7VSwTdNCpicNnn
         FljsK+MAT1P/0QQ/xzrWsyhbf/M+PQTiRj/qAcVmJc5EZHoX9uPlyvwaPERrICUXidzY
         qtYmMmE2g65NpGUcmiUdS/BmjzZ5oAp1SqeRVr/FtmYMVXqI18tN5w3kFFfeGFtrvgsz
         h40H+GZd52rHUVkbWadP5NWxBCIiWSKo3kNJDokGzHLDaLlVomnq4Bpmhl+y0paz3ohA
         d4ghGCOWY+lkgXuDCV79yqnkiKav65pPKkpgH9iPUQnTrkLhHJjdhfAhTEQ/CdKJiyEL
         NldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TwRG+JFhON5lLu3KLkH+RkE4aoR4GwpF0SJGcrPkzyY=;
        b=FCEBHxcQWtFcDM4Nepc8XHtfU+cyPxR53xfi/2JQ+if2/+D9b5SacolSKH7Tm3FBB7
         syWFfX9lM2FuVYOqC33Jea+2cg6s7sEjahKH4wRPNPMZxfqtzoG8RdU2PoPmjm5M5ge5
         ht6v42RBtwLhHMfFLLe9EgbM1TwggDG3hFeol4vDvu8/FWD7jD0Tn7C7XdjPEeybBOAr
         uUD5QJpCMj6+NeYhlyJsYKa7PluFuY+a/l7v1CpNCHClFazCkE7OMkreQq5BjwDrTSCJ
         KA5SS0OPx3HwNBcm0J1YwYgfwxzL0OZQrGkGcPV0u07SNagW1lNe5om03e+yzqQhSK2B
         kLsQ==
X-Gm-Message-State: AOAM5303wkwAHiPskfPM/liIJf9GO1KhBfx1Y5OtxOtPPS6mkcwNZn/v
        igvwmxzcEIOVu+kf2uBZUhU=
X-Google-Smtp-Source: ABdhPJz0AUi/lSjzbJwldFJPTY+Tz8+srjQrApVXHeg0fpacOKanvnLx2DJs+jqbRrVakVSqOIimfw==
X-Received: by 2002:a05:6870:d69c:b0:de:9925:2baa with SMTP id z28-20020a056870d69c00b000de99252baamr8518578oap.279.1652137438887;
        Mon, 09 May 2022 16:03:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f13-20020a4a9d4d000000b0035eb4e5a6c6sm5451114ook.28.2022.05.09.16.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 16:03:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4b2a51ec-5643-3429-8271-6d44b9f002b6@roeck-us.net>
Date:   Mon, 9 May 2022 16:03:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: drivers/hwmon/ltq-cputemp.c:23:2: error: call to undeclared
 function 'ltq_cgu_w32'; ISO C99 and later do not support implicit function
 declarations
Content-Language: en-US
To:     Florian Eckert <fe@dev.tdt.de>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
References: <202205080416.vzIXy16B-lkp@intel.com>
 <65c92404-1d6f-6969-89bf-20b8eefaeff6@infradead.org>
 <81b9b2cd3f981b6206e9d8c52b3306b3@dev.tdt.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <81b9b2cd3f981b6206e9d8c52b3306b3@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/22 01:17, Florian Eckert wrote:
> 
>>>
>>> vim +/ltq_cgu_w32 +23 drivers/hwmon/ltq-cputemp.c
>>>
>>> 7074d0a9275860 Florian Eckert 2017-09-01  20
>>> 7074d0a9275860 Florian Eckert 2017-09-01  21  static void ltq_cputemp_enable(void)
>>> 7074d0a9275860 Florian Eckert 2017-09-01  22  {
>>> 7074d0a9275860 Florian Eckert 2017-09-01 @23     ltq_cgu_w32(ltq_cgu_r32(CGU_GPHY1_CR) | CGU_TEMP_PD, CGU_GPHY1_CR);
>>> 7074d0a9275860 Florian Eckert 2017-09-01  24  }
>>> 7074d0a9275860 Florian Eckert 2017-09-01  25
>>>
>>> :::::: The code at line 23 was first introduced by commit
>>> :::::: 7074d0a92758603369655ef5d4f49e6caaae0b4e hwmon: (ltq-cputemp) add cpu temp sensor driver
>>>
>>> :::::: TO: Florian Eckert <fe@dev.tdt.de>
>>> :::::: CC: Guenter Roeck <linux@roeck-us.net>
>>
>> This driver builds fine if I change it from SOC_FALCON to SOC_XWAY.
>> Maybe its Kconfig entry should be stronger?
>>
>> config SENSORS_LTQ_CPUTEMP
>>     bool "Lantiq cpu temperature sensor driver"
>> -    depends on LANTIQ
>> +    depends on SOC_XWAY
> 
> Fine with me. I think it's better to narrow it down.

I'll be happy to accept a patch doing that.

Guenter

