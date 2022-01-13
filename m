Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F39D48DE34
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 20:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbiAMTnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 14:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiAMTnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 14:43:11 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1484AC061574;
        Thu, 13 Jan 2022 11:43:11 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id t4-20020a05683022e400b00591aaf48277so7497202otc.13;
        Thu, 13 Jan 2022 11:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IXMwcl+QcM2wMaO7JbXzvSnZgamU5JCCsChOe3k8LsU=;
        b=HqBDq8MgHi+aHcHw5EnmS0wctN8WC3Ug+LS0ptPiiV2p+JCN0ya5G3igEmE8JkpJwc
         abkaLyddzfroejtxWFIj40Q4qD0Z0N4DPeegTDHHxZiURl4iQYV1mx5mstbPwbHQ3+8C
         SbMz17h9r7SIMO80iVipx/mFXk/1Gj9OauFhoFaG/2qyb6FAeNgm6BB4tr7eQiMsG9Ws
         FUc3LBoiDMKReqbhEKYf77TJof9YvH13UZx4Jr25I37VAomw/R3JLkoXfwrDiGaRShPH
         Owdu+Ya/VKSamOGtSuIMu1WEDl0BiQWqXCHDWIJTlMxQbpFPatBxi1lpVLar9yUuj2aY
         ba4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IXMwcl+QcM2wMaO7JbXzvSnZgamU5JCCsChOe3k8LsU=;
        b=oY3bFREllhPdr47w4OSTOHNt2ThQ0RGPOFE2Mjw3Uv95igp08fYjyZGqCm7y25rWbg
         HDBSxOmlpUvJcNfxRX8VJngvdOvJJtc4GmITNRyJHTEwe5eev8woailgJzzQDum2tdbk
         eurIjZaouFwuNz3XMFK+8wVIn1cb+iss23uswauF7ayXN9JzGeX1774esRL22J+jLW2V
         iKFu01GbG1+fTAqMWbHwsBp5QsqNbNY1VcmF1yagLtmXktXhKtfnkYcoisbuGG/mQJH5
         4YeeYXOTfSTOUujCChviSohn8rRajfZWIvFUgQlTZV1P4AbmOQxYiJXwFnXKQX2mEjcs
         MFVQ==
X-Gm-Message-State: AOAM531iK2095HSJHqzpTFRKVeQnYXpQJgBYLR9Av+EA4V+pTDEpD4P+
        QOIpGHgRvIGWnfWLGrGS4xiKlpgsQWo=
X-Google-Smtp-Source: ABdhPJwm6ycn6J6CmU/AA+/zA6a9vBO1J55W9HR9kD+Z0+OvmgJyENswgkGfhrSqBaPEHdlj1ADT7Q==
X-Received: by 2002:a05:6830:11d8:: with SMTP id v24mr4162005otq.123.1642102990376;
        Thu, 13 Jan 2022 11:43:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i7sm785287oot.17.2022.01.13.11.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 11:43:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/2] watchdog: imx2_wdg: Alow ping on suspend
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Alistair Francis <alistair@alistair23.me>,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org
Cc:     linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20220109114120.386013-1-alistair@alistair23.me>
 <20220109114120.386013-2-alistair@alistair23.me>
 <4c5df296-b930-f65f-1106-c00889f1cdc1@i2se.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4c3056df-2ae6-04d7-30cb-cd478f089266@roeck-us.net>
Date:   Thu, 13 Jan 2022 11:43:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4c5df296-b930-f65f-1106-c00889f1cdc1@i2se.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/22 10:55 AM, Stefan Wahren wrote:
> Hi,
> 
> Am 09.01.22 um 12:41 schrieb Alistair Francis:
>> The i.MX watchdog cannot be disabled by softwrae once it has been
> s/softwrae/software/
>> enabled. This means that it can't be stopped before suspend.
>>
>> For systems that enter low power mode this is fine, as the watchdog will
>> be automatically stopped by hardwrae in low power mode. Not all i.MX
> s/hardwrae/hardware/
>> platforms support low power mode in the mainline kernel. For example the
>> i.MX7D does not enter low power mode and so will be rebooted 2 minutes
>> after entering freeze or mem sleep states.
>>
>> This patch introduces a device tree property "fsl,ping-during-suspend"
>> that can be used to enable ping on suspend support for these systems.
> 
> Introducing vendor specific properties for Linux behavior should be
> avoided. The DT should describe just the hardware.
> 
> In case i.mx7d is affected, how about enabling this workaround for
> compatible fsl,imx7d-wdt? This has the advantage that in case low power
> mode will be implemented
> <https://elixir.bootlin.com/linux/latest/B/ident/fsl%2Cimx7d-wdt>, we
> don't have to care about DTB files.
> 

Agreed.

Guenter
