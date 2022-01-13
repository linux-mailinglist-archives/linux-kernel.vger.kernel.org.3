Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21AC48DA23
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiAMOvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiAMOvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:51:14 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF440C06161C;
        Thu, 13 Jan 2022 06:51:13 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id x193so8017120oix.0;
        Thu, 13 Jan 2022 06:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7sV67dH8lYSZlUMNo3XxIsDoMzykXRyU8jCNficB5n0=;
        b=f+UoFtejQ6cXU+Cm+jx0z0eeHaaeh7Wy2q0Dj6iBzz4FWyfw1EEr/rb3qyaUhdW11U
         H+hdDKuStODnuik/VOpYIQYioSBSBW5n1GhPCDy6pP1KWLndLUEx3JwbVsBJA34fGaIw
         Gaa+HbZX92I0OV+4tMZalBn0sYXuXfSgaBA5B/NnWf/IFQxda5BFX0cDQyCHFZz5VR1n
         j+uLystFG6XsR6owqcEweOT6L3ZHt5j7peXOIris4ojy6qwUEc64RuQxDlxxJU//N4Oa
         iJX9MSsKPqN3TAHt+6RUINS0CHSvGen7ytUwpjp5kmGapZRwYSnIDQCV3F3Hn6B6HMfL
         +zcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7sV67dH8lYSZlUMNo3XxIsDoMzykXRyU8jCNficB5n0=;
        b=UaqfZR1AxTj+BAgNIZwz8jPEnancxeUSrM722VXZ79Zc5utZhgaApbtujsYp9hXaV3
         oMYqEYCWnIynhGyVmLar9EgL0XPEc7zaz59ohmj//yMGJm+RTf3dzjN54fNxbxzooBca
         gO3ECgdKBW7MR9KRo6j20lVjdQOYFRtcXcxtl3LhgEubl25Ddo3Zy708T9V7YfE0jsO6
         0kNwp33k3hPYHLNilX67OsfrWCnNOR/RGGrMwS/EkbLvXENS76qSeefCNZcoMM/jcpX2
         DM9RlPifBZMYExk3zwG17ovKM/mT6OdacS7M8lugwxg4rWZ0ix/w5jxj7XOm5fnYEliv
         S84A==
X-Gm-Message-State: AOAM532aigYdg/GxPHCLqpwldWiuqtUWcubyKAqcLNbFq07LFLajujIM
        1FBD35WHB61Atvm1zzg02M4LS8514rc=
X-Google-Smtp-Source: ABdhPJwd01mlwssk4KdmA9SR/UJpbLmBlWInO/N9BgL/fAYBKxawxtdD20QzpJxHY+CG9FwoA8Op1A==
X-Received: by 2002:aca:b984:: with SMTP id j126mr2338879oif.168.1642085473183;
        Thu, 13 Jan 2022 06:51:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n8sm580902oos.44.2022.01.13.06.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 06:51:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3] hwmon: (nct6775) add support for TSI temperature
 registers
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        linux-kernel@vger.kernel.org, Renze Nicolai <renze@rnplus.nl>
References: <20220112034824.3467-1-zev@bewilderbeest.net>
 <20220112164729.GA399472@roeck-us.net>
 <YeAKCos0hioMAiqi@hatter.bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <944f601b-2665-b7f0-f9af-5cc38f52bca9@roeck-us.net>
Date:   Thu, 13 Jan 2022 06:51:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YeAKCos0hioMAiqi@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/22 3:16 AM, Zev Weiss wrote:
> On Wed, Jan 12, 2022 at 08:47:29AM PST, Guenter Roeck wrote:
>> On Tue, Jan 11, 2022 at 07:48:24PM -0800, Zev Weiss wrote:
>>> These registers report CPU temperatures (and, depending on the system,
>>> sometimes chipset temperatures) via the TSI interface on AMD systems.
>>> They're distinct from most of the other Super-IO temperature readings
>>> (CPUTIN, SYSTIN, etc.) in that they're not a selectable source for
>>> monitoring and are in a different (higher resolution) format, but can
>>> still provide useful temperature data.
>>>
>>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>>> Tested-by: Renze Nicolai <renze@rnplus.nl>
>>> ---
>>>
>> [ ... ]
>>
>>> +        switch (data->kind) {
>>> +        case nct6791:
>>> +        case nct6792:
>>> +        case nct6793:
>>> +            data->REG_TSI_TEMP = NCT6776_REG_TSI_TEMP;
>>> +            num_reg_tsi_temp = ARRAY_SIZE(NCT6776_REG_TSI_TEMP);
>>> +            break;
>>> +        case nct6795:
>>> +        case nct6796:
>>> +        case nct6797:
>>> +        case nct6798:
>>> +            data->REG_TSI_TEMP = NCT6796_REG_TSI_TEMP;
>>> +            num_reg_tsi_temp = ARRAY_SIZE(NCT6796_REG_TSI_TEMP);
>>> +            break;
>>> +        default:
>>> +            dev_warn(dev, "unknown number of TSI temp registers for %s\n", data->name);
>>> +            num_reg_tsi_temp = 0;
>>> +            break;
>>
>> Please drop the message. This is new functionality which should not
>> suddenly produce a warning for chips which possibly do not support those
>> registers in the first place. For users with those chips the warning
>> is just confusing.
>>
> 
> Just to confirm, this switch currently covers all the enum cases handled by the surrounding switch case, so as it stands the default case should be unreachable and hence it should be guaranteed not to warn for any existing chip, only for a hypothetical newly-added one (the intent being that someone adding another chip in the future would be less likely to accidentally omit TSI support).  Unfortunately gcc doesn't seem to be quite smart enough to realize that and avoid warning about missing switch cases in the inner switch if I remove the default case entirely, so we can't just rely on the compiler to warn about it.
> 
> Shall I still remove it anyway?  (I could certainly also add a comment clarifying the above.)
> 

I didn't say remove the default: case statement. I asked to remove the message.
That is true even more so if it won't happen in practice - it just unnecessarily
increases code and data size for no useful reason, and it does create the
impression that it can happen.

Guenter
