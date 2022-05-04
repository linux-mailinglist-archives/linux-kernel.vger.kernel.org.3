Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC9651A126
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350720AbiEDNoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbiEDNog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:44:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FA124BCD;
        Wed,  4 May 2022 06:40:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g20so1739128edw.6;
        Wed, 04 May 2022 06:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=suVw3tSzbwyZSam3QbzRJHAkBAls+2hu9csRGskWjWw=;
        b=bk9kOJqOLJTxShNzNja788BQ2B6hxHftCjyH0aVxO0vJypv6yv1bMzkGh7Qu8+7ccE
         Y2XQdNv3VZEdvDWkWuimAcjeExlT3lFCmgTValt3KEPauGhwXBQkHqC2zZanUpv7heF7
         kb8xaW5XRYSzxtRbRl3jtjMBTHZj4JB+o0azkG6bN1VZbmUVp05G2SFu8BdSc4Ayu/3+
         cwV20fCW68AQh17TdOtQWun/2JxzAyXY00ENFuUquQYIcc0eLoQXSaTduF3/FHmJiNK9
         +hJK3W5lulfnGCf9T1CuZQcWCIWcroGoMGeAnqKk5DJzeABcTvx1JM/69AmyBog9jtlR
         1Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=suVw3tSzbwyZSam3QbzRJHAkBAls+2hu9csRGskWjWw=;
        b=Lllvft10z/2m/fEsNx4eQcEBHIYSUYlt1SiL3f9KSRzrHQvrjQ+cCmvMx1ths0mKps
         rLbp/oTtRO8QDEiDKr9C9v7GGRqFc85fJuc4m5GkkeXdBPRXuZRgeG4b5VVhUG9EyUJE
         zbWVR02XRDYirmWzsCfyhMlmXZYcws5iF1uqfqrruaDKR5Pmb4cwmKD0sUudyoBGsu9q
         3ymw4SGiDy26CabBUfmKjvkikmll90LhNPam08OVRBCmIWG3t79eq8YLgAxx8DreAbTh
         uQPJVbkoRDoVlnc4zSrE88/sy0DLxyUn35GNCcWIncxeJwgYv2oTgUerkoePrVEEkKEz
         hRMw==
X-Gm-Message-State: AOAM531Jr+UvLKLWvNi1d4khcINUTVh4F1pDvegxVN66f4X6mw4x+EzO
        rl8gXgbKXTxLDsZH33qe2e/p23Vx8ig=
X-Google-Smtp-Source: ABdhPJwV+5IUc2JZSq1pNUPzHy8aTwwTASBzecl/CgmJrjO0BveOXuEoDT+ZmXE7LkjGMGFzYy/nkA==
X-Received: by 2002:a05:6402:5108:b0:427:e323:4c67 with SMTP id m8-20020a056402510800b00427e3234c67mr8686804edd.326.1651671657228;
        Wed, 04 May 2022 06:40:57 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id t26-20020a05640203da00b0042617ba6383sm9088126edw.13.2022.05.04.06.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 06:40:56 -0700 (PDT)
Message-ID: <63cb6fe1-5abe-ebfe-7d94-34dff86f1a81@gmail.com>
Date:   Wed, 4 May 2022 15:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: Regression? [PATCH 1/2] mtd: call of_platform_populate() for MTD
 partitions
To:     Daniel Golle <daniel@makrotopia.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Rini <trini@konsulko.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220406143225.28107-1-zajec5@gmail.com>
 <20220411090032.10999-1-miquel.raynal@bootlin.com>
 <YmX3Yn9cS1YjWOjs@makrotopia.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <YmX3Yn9cS1YjWOjs@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.2022 03:20, Daniel Golle wrote:
> On Mon, Apr 11, 2022 at 11:00:32AM +0200, Miquel Raynal wrote:
>> On Wed, 2022-04-06 at 14:32:24 UTC, =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> Until this change MTD subsystem supported handling partitions only with
>>> MTD partitions parsers. That's a specific / limited API designed around
>>> partitions.
>>>
>>> Some MTD partitions may however require different handling. They may
>>> contain specific data that needs to be parsed and somehow extracted. For
>>> that purpose MTD subsystem should allow binding of standard platform
>>> drivers.
>>>
>>> An example can be U-Boot (sub)partition with environment variables.
>>> There exist a "u-boot,env" DT binding for MTD (sub)partition that
>>> requires an NVMEM driver.
>>>
>>> Ref: 5db1c2dbc04c ("dt-bindings: nvmem: add U-Boot environment variables binding")
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>
>> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.
> 
> I'm trying to use next-20220422 and noticed a few new oops'es.
> Turns out it could be a problem with this commit according to
> 
> [daniel@box linux.git]$ git bisect good
> 68471517e883902cdff6ea399d043b17f803b1a8 is the first bad commit
> commit 68471517e883902cdff6ea399d043b17f803b1a8
> Author: Rafał Miłecki <rafal@milecki.pl>
> Date:   Wed Apr 6 16:32:24 2022 +0200
> 
>      mtd: call of_platform_populate() for MTD partitions
> [...]
> ---
> 
> So when ever there is at least one 'compatible' node for any of the
> mtd partitions I get the oops messages below. It doesn't really matter
> what the compatible string is, "nvmem-cells" as well as "denx,fit"
> (used for OpenWrt mtdsplit not even present in linux-next, so just a
> dead hint in DTS) make the kernel to oops.
> 
> Despite the messages being shown, both accessing MTD partitions and
> also eth0 MAC address populated via NVMEM seem to work without
> problems (at least looks like it on first sight).
> 
> Find the full device tree here:
> 
> https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/mediatek/dts/mt7622-ubnt-unifi-6-lr-ubootmod.dts

I found it! It used to happen (before dropping patch) with:
# CONFIG_MTD_PARTITIONED_MASTER is not set

I'll work on V2 which doesn't require
CONFIG_MTD_PARTITIONED_MASTER=y
