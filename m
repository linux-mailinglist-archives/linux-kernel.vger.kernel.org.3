Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4D749B72D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359126AbiAYPDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351970AbiAYPBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:01:24 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50572C06177A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:01:21 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso2055617wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rtmp0dqKHGwJEKozu5JKnqXfvBDShJfZcOYDCM9O30s=;
        b=PLaIGp3oeEgbFGe60Jgv1mgImggG7+BEnaPTWFDFLpU8AB/c4Glw5Y1lfRQHX8syjw
         kCXCkXZSfBREnhzfQtBYYxSGsoa1xrg06P+2QdUcG3lIv2OQM4zSv2cCuSQsQ+vJg8nb
         M1uZO0EnbOpqzf+WTVDVGgxkcY0cVKEdgIfFDvKp1wmg6VyO2cXkpJ1kXbjF6D008eqf
         dVSKKinD9bRqD4UfVCGGgMVlxQbhvh2kE50XcLij98Kh1peJlXL6e1Ser0yKG/MEnU6N
         KECBjAdF3KXPD+KOkLxfkZv+u4LfxDOHP27LUtDnAqfg9K2tH7fGJlO8pLqVL3tSmYMr
         m+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Rtmp0dqKHGwJEKozu5JKnqXfvBDShJfZcOYDCM9O30s=;
        b=o8+2hD2I/xTapVXl+YzWi+0gHoyharASlIhNex4XXH5ETIgvTb1ZFoIFYzQEM72AGv
         44ZYiqhR9kB+Uc08qdwlmqd3Q87uK3xQXw4r/jD3ZOo+3MvCKJmSdeeQUyWYMRkL8hSe
         SOQ9xAJFG1asuzzAegOGGW+zdLEECNcAHGk8/+/G4TiMFu8iGt9XB2dA9dnfwHQjFM86
         uM/3HP+bf3HrPSMnD1MYPHUa9AZ2vyoQNk/UNHAYZSOghLIae6h4f5waDoj8K0AMY0gQ
         zXY19kze+FEBfoofOzM5mElsr1jbe+08fSSzoMLv7H9MGCJhT1O08AYXyKQpbfBb++Db
         3Wfw==
X-Gm-Message-State: AOAM530YQSTv8UmFzWrP7w2RhFEMbzuFY4TopvJJX+K6FZXbWRKKbb3A
        bEnLDJX1DvTTIr89CkTAVCFHBA==
X-Google-Smtp-Source: ABdhPJzc2KXsXyiQcSuN83qgJUqGoOMhhb0gIw+vQatj3F3MBeRiqOh2SqpwYmDMDPz75JiC07+TXQ==
X-Received: by 2002:a7b:ca55:: with SMTP id m21mr3424984wml.114.1643122879789;
        Tue, 25 Jan 2022 07:01:19 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:e03f:56c1:665f:b320? ([2001:861:44c0:66c0:e03f:56c1:665f:b320])
        by smtp.gmail.com with ESMTPSA id o14sm6444341wry.104.2022.01.25.07.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 07:01:18 -0800 (PST)
Subject: Re: [PATCH 0/3] arm64: dts: meson: add BL32 reserved region to
 Beelink g12b devices
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Furkan Kardame <furkan@fkardame.com>
References: <20220122073221.2398-1-christianshewitt@gmail.com>
 <7h7daoyka3.fsf@baylibre.com>
 <C8B4EA0E-6593-4C42-B116-F9C043D29452@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <4a8727f4-fbdd-33f7-1f1b-c4baf92ad986@baylibre.com>
Date:   Tue, 25 Jan 2022 16:01:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <C8B4EA0E-6593-4C42-B116-F9C043D29452@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/01/2022 05:02, Christian Hewitt wrote:
> 
>> On 25 Jan 2022, at 12:02 am, Kevin Hilman <khilman@baylibre.com <mailto:khilman@baylibre.com>> wrote:
>>
>> Christian Hewitt <christianshewitt@gmail.com <mailto:christianshewitt@gmail.com>> writes:
>>
>>> This resolves a long-running issue where Beelink GT-King/Pro and
>>> GS-King-X wedge on boot or shortly after when booting from vendor
>>> u-boot. In some distros the issue is often reported as triggered
>>> by large file transfers to/from USB or SD cards. Reserving the
>>> BL32 memory region prevents the issue.
>>
>> The BL32 is typically common for the SoC family, so this change should
>> probably go into the g12b.dtsi.  Or probably even
>> meson-g12-common.dtsi, which is where the BL31 reserved-memory is
>> described.
> 
> Hi Kevin,
> 
> Would you be okay with the same change applied to GX devices too? - I
> normally have these two catch-all patches in my tree to deal with random
> tv box hardware and it would be great to drop them:
> 
> https://github.com/chewitt/linux/commit/4315ea4612389fc08d0a008b562cafbda96374fc <https://github.com/chewitt/linux/commit/4315ea4612389fc08d0a008b562cafbda96374fc>
> https://github.com/chewitt/linux/commit/3c0df794baa7ea9d32d8ad54530b5a056c770ea9 <https://github.com/chewitt/linux/commit/3c0df794baa7ea9d32d8ad54530b5a056c770ea9>

Sure, it has been done in a similar way for bl31:
https://github.com/torvalds/linux/commit/48e21ded0432ee1e2359d4143d7a6925cefee1b5

in a perfect work we wouldn't need this since mainline U-Boot does the job by reserving these
memory zones, but vendor u-boot exists and isn't avoidable.

Neil

> 
> Christian

