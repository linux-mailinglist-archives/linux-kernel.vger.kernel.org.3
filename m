Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90CE4D05A3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244537AbiCGRsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237825AbiCGRsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:48:35 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB75DEF1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:47:39 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DF5CF3F613
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 17:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646675257;
        bh=gTUG1OTofQBqLGH5jr70EzskQgnPGihE88XHWWMxRM8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=lf8TRcSLhO+bS1ThPmie481JxgpdSEVXJiDI6lTpjuIF0BZHwn2S0E6h5tRpCVd9B
         9XgIBWHAb8WXOkP0UrtGs2SFNSHAwl/7P17hcnrBCV00WGg09IX73+P9C4Bp2bWL5L
         zbSIn0K7Zww/41f15iMMhWxHVdGKg2bqQmazfkfMLNpEfiiSOL0oZfp/+vLO6++SaC
         a/O+U5YCIWvM6UTy0ZLUrYf13mvMXPOHANGX8UmKP9xCOSVVBwRDNgH+G5KqJ3u7wr
         TLEwp8Wua6QZb35mt3yU9nJTVj9KZCxqHtjK9F9/qOONaHaPg8RrEm5fhVwDvuF2/T
         +8oYKsMO50P7A==
Received: by mail-ej1-f70.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso7358749ejs.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 09:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gTUG1OTofQBqLGH5jr70EzskQgnPGihE88XHWWMxRM8=;
        b=PQ3HLkCM08Bv8J//VTbSzuFgalPX7uzPdLUT1z8Y1NgGpVVR4f1N4guf59krFs+M9q
         W8NuviLVi3yyLFG+5sWvmG2fhIqXS0Dry8eRCXPFbePJwdz3LXf/0K9bLeSM61vOnYa6
         v29E7tC33vlsa9YCo0PUS1sdQmgVVN7fzA8DNA3pFWe4pTpFgkdQsuMMM9I3Bb/fn/oZ
         MsFzeonvFat33W5lPTOsd9QuMmLl37tRYwQKyyRhLHCBPgAM2r7uz/VoXey76WWHwz33
         F3q8XRfiGtB6bW+aqhYTeCpW3DTjwTyfbzhI0APuy2btmxlvMZl/PR8L5XwunhTTMij6
         aQTQ==
X-Gm-Message-State: AOAM533uJaw65za3SyYfZMSjXnTz2zeHaGaxeYGHWurh5tcsJ6iQecEk
        HVnCbMHcVTWjbm7I4iipJQ6SceCdLoLOh8XQeOdlW7Ysmv1aiPWtMncMCuHFV9+6VzqYAmlHvgB
        koLT2kC45S3gw/t/P1f2TSzNQJi+s22tF3zXnZw3UFg==
X-Received: by 2002:a17:907:6d0e:b0:6d7:c85:5bf5 with SMTP id sa14-20020a1709076d0e00b006d70c855bf5mr9948795ejc.31.1646675257525;
        Mon, 07 Mar 2022 09:47:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9M5dMPsi5MKepY8dS9wOPTh8x1ZtnMj54rZ1pD4rAdYCgeFDf0Br8WQjd2Pjp+ziQJ7gGaQ==
X-Received: by 2002:a17:907:6d0e:b0:6d7:c85:5bf5 with SMTP id sa14-20020a1709076d0e00b006d70c855bf5mr9948781ejc.31.1646675257319;
        Mon, 07 Mar 2022 09:47:37 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7cc8e000000b0040f13865fa9sm6544264edt.3.2022.03.07.09.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 09:47:36 -0800 (PST)
Message-ID: <8078e6af-034f-d705-c14d-49f86495f86b@canonical.com>
Date:   Mon, 7 Mar 2022 18:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH] memory: renesas-rpc-if: Correct QSPI data transfer in
 Manual mode
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
References: <20210922091007.5516-1-wsa+renesas@sang-engineering.com>
 <163282533892.34438.1878675609177525004.b4-ty@canonical.com>
 <CAMuHMdUqQLo7=NFaNEukqniTJbx-mSZv7eQNB9eCT=L28y3u=A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAMuHMdUqQLo7=NFaNEukqniTJbx-mSZv7eQNB9eCT=L28y3u=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 17:44, Geert Uytterhoeven wrote:
> Hi Krzysztof and Wolfram,
> 
> CC Sergey, Prabhakar, Andrew,
> 
> On Tue, Sep 28, 2021 at 12:36 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>> On Wed, 22 Sep 2021 11:10:06 +0200, Wolfram Sang wrote:
>>> This patch fixes 2 problems:
>>> [1] The output warning logs and data loss when performing
>>> mount/umount then remount the device with jffs2 format.
>>> [2] The access width of SMWDR[0:1]/SMRDR[0:1] register is wrong.
>>>
>>> This is the sample warning logs when performing mount/umount then
>>> remount the device with jffs2 format:
>>> jffs2: jffs2_scan_inode_node(): CRC failed on node at 0x031c51d4:
>>> Read 0x00034e00, calculated 0xadb272a7
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] memory: renesas-rpc-if: Correct QSPI data transfer in Manual mode
>>       commit: fff53a551db50f5edecaa0b29a64056ab8d2bbca
> 
> While trying to enable support for RPC on Salvator-X(S)[*], I
> discovered HyperFLASH detection is broken:
> 
>     rpc-if-hyperflash rpc-if-hyperflash: probing of hyperbus device failed
> 
> Reverting all commits to the RPC driver since Sergey's original
> commit 5de15b610f785f0e ("mtd: hyperbus: add Renesas RPC-IF driver")
> fixed probing:
> 
>     rpc-if-hyperflash: Found 1 x16 devices at 0x0 in 16-bit bank.
> Manufacturer ID 0x000001 Chip ID 0x007000
>     Amd/Fujitsu Extended Query Table at 0x0040
>       Amd/Fujitsu Extended Query version 1.5.
>     rpc-if-hyperflash: CFI contains unrecognised boot bank location
> (0). Assuming bottom.
>     number of CFI chips: 1
>     10 fixed-partitions partitions found on MTD device rpc-if-hyperflash
>     Creating 10 MTD partitions on "rpc-if-hyperflash":
>     0x000000000000-0x000000040000 : "bootparam"
>     [...]
> 
> However, there's still something wrong, as all HyperFLASH contents read
> back as zeros, while the FLASH contains the full boot loader stack.
> Bisecting the reverts pointed to this patch, and just reverting this
> patch (small whitespace conflict) fixes probing, too. Still, all zeros.
> 
> Summary: needs more investigation ;-)
> 
> Wolfram: which platform did you use for QSPI testing, so I don't
> break that again?
> 
> [*] Firmware compiled with RCAR_RPC_HYPERFLASH_LOCKED=0 of course.
>     Without that (e.g. old H3 R-Car ES1.0), it crashes with an
>     Asynchronous SError Interrupt during driver initialization.

Thanks for letting me know. This patch is already in mainline, so the
solution is either to revert it or fix it. I will wait for it from you
(as in plural "you" :) ).

Best regards,
Krzysztof
