Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48344CBEFC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiCCNj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiCCNj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:39:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1C17149979
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 05:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646314720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kV1jPhpxz/H+Y6fQr0IfoEf/5nAIxaNBpjXk9EuheDE=;
        b=hsUqm8BHNqs6mowy+5LpX0H8XYI9uL+KXK3xq7zHY1I7Fzlgm7SDwm9CyRwvDXc5IazL+M
        hD+6yELcuOyNrtDoqbTwRFF3xH3ovJrWyfagBd9pbrJLP21ZcKQyD5j0j70jmjm6PyksjH
        kyYuXTVEs0AMQ4nsxsQplhd5GlOsMj0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-G24g7zAZMk61jt70EKgMPg-1; Thu, 03 Mar 2022 08:38:38 -0500
X-MC-Unique: G24g7zAZMk61jt70EKgMPg-1
Received: by mail-ej1-f70.google.com with SMTP id hr26-20020a1709073f9a00b006d6d1ee8cf8so2715063ejc.19
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 05:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kV1jPhpxz/H+Y6fQr0IfoEf/5nAIxaNBpjXk9EuheDE=;
        b=M4Bqiwt8Q9W2SOFe/rHsVjz+xPdw/eni8ZUBpvwQJ5T04PXv+HSnthwMnpT8DJauEg
         8/+TIE47dWv2JluYDiifHwkGQ6E15Hl8vWat86oMWOzsVHnym5OK/q5KeQMnwdt47blZ
         oulNuPiZ+0qELpg8rQ4JlGGNfK+kfVIwci8oK89j8/9A0nOvJmvpA99bkispLcYbepN+
         +K6VszkGIUgZFFx2Va/1QlOS4oel0HfjTdmjV73B+nSVn1Hv1WI48YDZFrcyx2ytTPl4
         2IiHlMfgAgYtsbqk8VBNSTJz2e5SxKM9btu+SloBOAKJL2Fo5sKHsdLc6jawmmy1cf8W
         wcLw==
X-Gm-Message-State: AOAM530+AYv12yvNEEW2Z9gfYkRZ0UrVZNgyORlaXpd0wHnYpbFjUk5Q
        ycQLtpl8VqqZIW0REAvoWgpFRaKDlbqRDwqtKt2aoX3BIw7pLfJDsjUqFznIkijz7UwLEiFCDcO
        4kj7mXA1oQ7BUlss1EwgHl++3
X-Received: by 2002:aa7:dc0c:0:b0:413:c9ab:381c with SMTP id b12-20020aa7dc0c000000b00413c9ab381cmr17212783edu.275.1646314717810;
        Thu, 03 Mar 2022 05:38:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2IvPU7oGxg9mGP/R4nr8JF4lCyy/f+OG79qmsf/DoCTolNSwqbYOrJAbboAYdKiGrjQpAbQ==
X-Received: by 2002:aa7:dc0c:0:b0:413:c9ab:381c with SMTP id b12-20020aa7dc0c000000b00413c9ab381cmr17212767edu.275.1646314717593;
        Thu, 03 Mar 2022 05:38:37 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id my16-20020a1709065a5000b006d6e1023b7bsm710889ejc.8.2022.03.03.05.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 05:38:37 -0800 (PST)
Message-ID: <43b0c275-e728-492b-c6a7-d054fae72117@redhat.com>
Date:   Thu, 3 Mar 2022 14:38:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] ACPI / x86: Work around broken XSDT on Advantech
 DAC-BJ01 board
Content-Language: en-US
To:     Mark Cilissen <mark@yotsuba.nl>
Cc:     linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kernel test robot <lkp@intel.com>
References: <20220302040800.10355-1-mark@yotsuba.nl>
 <832a5b2e-d70c-f1a6-e377-7697b1eb7049@redhat.com>
 <7BD8A71A-95C7-4A10-82FD-BEAAE0B0DDE9@yotsuba.nl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <7BD8A71A-95C7-4A10-82FD-BEAAE0B0DDE9@yotsuba.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 3/2/22 21:20, Mark Cilissen wrote:
>> On 2 Mar 4 Reiwa, at 10:02, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
> 
> Hi Hans,
> 
>>
>>> […]
>>
>> Heh, I should have noticed this new version before replying. I see that
>> you've dropped the BIOS-date match. But that actually is often more useful
>> then the BIOS_VERSION, sometimes vendors don't bump the version when
>> doing a new BIOS build.
>>
>> If you only want to match the exact BIOS you tested against I would
>> drop the BIOS_VENDOR check instead.
> 
> I am admittedly bit wary of dropping the BIOS_VENDOR check. As the cause of
> this issue seems to be specifically a BIOS compilation error, it feels 
> incomplete to leave this match out.
> 
> Since “CRB” in the DMI product name indicates the board design is derivative
> of a generic Intel reference design (“Customer Reference Board”),
> maybe it’s better to drop the SYS_VENDOR match instead?
> It seems to bear little relation to the actual vendor (Advantech)
> encountered in my testing hardware, anyway.
> 
> Let me know; if you still feel it’s better to drop the BIOS_VENDOR match,
> I will do that instead.

I think that there are a lot more boards that will have
DMI_BIOS_VENDOR == "Phoenix Technologies LTD"
then that there are boards that will have
DMI_PRODUCT_NAME == "Bearlake CRB Board"

So if you want to make the DMI match as specific as possible then
IMHO dropping the bios-vendor match is best.

Regards,

Hans


