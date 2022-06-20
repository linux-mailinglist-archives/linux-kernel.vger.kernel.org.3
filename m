Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476C555150B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbiFTKA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbiFTKAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C12A2199
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655719247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xxEIMgtnBWnY4q7XZSBtpk04nFr6wG+ehqi5b4PrIPY=;
        b=V8h8CoilxRgyylxpMwRlbO7kQXwCXowYa0q88Jn29gFFFCWpmjM1NtIZMNM+cHOwZeDDNr
        hJGhcr/gYObdF98E2NTC1/cwcTVxGaOR2FGgwxA8Yo0pd/a298r0DFLlbSS0gtNF8BLEHP
        a1PZNMnxUUHL9nwH59717WSXgaf8YJ8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-Srn9fJoJM3ORAwYTaICqIg-1; Mon, 20 Jun 2022 06:00:46 -0400
X-MC-Unique: Srn9fJoJM3ORAwYTaICqIg-1
Received: by mail-ed1-f69.google.com with SMTP id g8-20020a056402090800b00433940d207eso8401405edz.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xxEIMgtnBWnY4q7XZSBtpk04nFr6wG+ehqi5b4PrIPY=;
        b=6ApvCFh6e7dyKj20oQMQBkgHXJF+TntRjKDw0VXrdDzqu+A1LiDzpXYEkGp5mV3baf
         NKujIZsfZzQ2X84ZuXt4ehURUa8L1OG54v1P7joANpqfP7rYbsxmQOOlg7G1Fo1Xsz5R
         WBbOyet7Lf5iigODxGVyXH0u7x7wPogbpNqgxAvtEMnUQmE/RZ0RmeB66YlWyNCz6T5l
         /EEFRpPuPkGnrFk6t3I5mG5TSJ1jgCTzVGhxYxlrFO/sx5LqiYq/drvPijkeKy0RTJYD
         84MBmsh5SqGONSr+8IqWmLli60XsCqDkTrWVcZiPLzZOL4Zv+UU4E/FhCseEGlRtr6Wf
         ZN4A==
X-Gm-Message-State: AJIora/LpZ90zjRLc+djOZjna32v3UE3uOp2dj1OngvrM10JeoaWzLLe
        oISmi3SvnmedCU6x01FKUCuDht4EviWtMbYaMohNShQCN1mj+Jxu/M+6QH5Dm0QzL/O9HBMpfHr
        ES0Y7bTR0/3s1O/bW6ZhKX0GJ
X-Received: by 2002:a17:907:3e18:b0:722:be7e:302c with SMTP id hp24-20020a1709073e1800b00722be7e302cmr4594876ejc.437.1655719245239;
        Mon, 20 Jun 2022 03:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tj2K2nMNPmTUJoN7cU/mlzAL/+QSGYMg1e6yqbh+dbrmDpzKTbekJzrfXkowiBzBbKW2lCKA==
X-Received: by 2002:a17:907:3e18:b0:722:be7e:302c with SMTP id hp24-20020a1709073e1800b00722be7e302cmr4594862ejc.437.1655719245058;
        Mon, 20 Jun 2022 03:00:45 -0700 (PDT)
Received: from [10.87.1.19] ([145.15.244.207])
        by smtp.gmail.com with ESMTPSA id a12-20020a50858c000000b0042617ba638esm9880911edh.24.2022.06.20.03.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 03:00:44 -0700 (PDT)
Message-ID: <ff5ac808-fde9-57ee-7d47-a4999428210e@redhat.com>
Date:   Mon, 20 Jun 2022 12:00:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <f000cf13-5e73-3c76-700c-a087954d4050@redhat.com>
 <YrBA+XOzefxSfi72@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YrBA+XOzefxSfi72@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/20/22 11:42, Andy Shevchenko wrote:
> On Mon, Jun 20, 2022 at 10:51:33AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> Thank you for this series, cleaning this up is long overdue.
>>
>> The entire series looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> for the series.
> 
> Thanks!
> 
>> Maybe do a follow up renaming CONFIG_INTEL_SOC_PMIC to
>> CONFIG_INTEL_SOC_PMIC_CRC and also change the module name
>> from intel-soc-pmic to intel-soc-pmic-crc ?
> 
> I thought about that, but decided to leave it for later since it will take a
> lot of subsystems and better to be considered out of the scope of this series.
> 
> Do you agree?

Sure we can do this later. Note that there are not that much dependencies
on INTEL_SOC_PMIC though. The ones which I could find are:

drivers/usb/typec/tcpm/Kconfig: config TYPEC_WCOVE
-which is wrong regardless of the rename and should just be dropped
 in a separate/unrelated patch. can you submit a patch for this ?

drivers/gpio/Kconfig: config GPIO_CRYSTAL_COVE
drivers/pwm/Kconfig: config PWM_CRC
drivers/acpi/pmic/Kconfig: config BYTCRC_PMIC_OPREGION &&
                           config CHTCRC_PMIC_OPREGION

So not that much, but still 3 subystems, so yeah probably best
to do that cleanup later,

Regards,

Hans


> 
>> I don't expect any userspace dependencies on the module-name
>> (there are no module parameters) so this should be fine.
> 

