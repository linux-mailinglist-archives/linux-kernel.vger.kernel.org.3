Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E895757337E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbiGMJuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiGMJuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:50:04 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5AAF8944
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:50:03 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bp17so10339085lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T1kY0ST+/OZ6JUPh282LY+9WXk87b1CObSxnDhtdh60=;
        b=kDYFijXp9HZI/LwyQ5qFldstlQvx74xzJWFSzViDxarvndpgxDSlExGpsuGcef6o6E
         5sYG+U9u+iEhcm3O/aynHjAyRB99Ha0bPs+DxqMbCMDXClGTTsh42hbXb9b46RwMEBh6
         1CI5FeQHY9+helIqak2mtKj9Vdlil+msgjSGB80yPvHRq0CMRzL8ppfi0glvRxENHFwm
         uIws7o/5YYChfj+/kYnVNqyDDaBPLDjxnghAWpueRHBf1BshqqaglNxXadgvR9hH7v3E
         dMIsTM2cUhm9N8q42F5k+9msG0C1SyJoEf65J1OveLLJtpX9xPryA8xmE5qJ1zTh5JtC
         0YHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T1kY0ST+/OZ6JUPh282LY+9WXk87b1CObSxnDhtdh60=;
        b=Gfeppqs9RUs+a564GQXCzbZ2AnHSr2IDjesMhXiclY7EmU3htDwAlx4BrrdwePU6si
         ZP/yDAzLmc68SqdpvkSu3mipXsynzKB/nQjCj2MPPQm94jmL7n8C6Fp83WsG0M/jqcnC
         fhHnE1nRjXiHarRM/7Q0Vj59Ti/g71ArEJllD5T5JFtLyOmQDFsm5qpDrLgBFJ1in7Bb
         gbjHB8u9hfsLR0LSEhWEhykBEfxEv2X7KA+xdDnldGVP0jdAe4Ko5/FBoQGBMCCOutus
         XSz+NZziGBFAU1CVi9vh6OJNznevrsDJUvTMS7FG1Is6wuf2OQ1OuJBuuz2R3GVFiQFp
         pZ3g==
X-Gm-Message-State: AJIora8HsKXsfwUCI3TiaZ2YZVdc4DlsUDkqqdfM3Y27QMNYeoNUmA8I
        t6y375EeknMp/I0fXgBkaMw=
X-Google-Smtp-Source: AGRyM1s8sir4G6AV3gxRmM/qBD4NN6fiIO7omuEh6Cz7Bb1T2wc8hgCCVJlRMOBz8sURcixPlZTE2w==
X-Received: by 2002:a05:6512:3193:b0:489:e883:3c06 with SMTP id i19-20020a056512319300b00489e8833c06mr1532187lfe.211.1657705801345;
        Wed, 13 Jul 2022 02:50:01 -0700 (PDT)
Received: from [192.168.1.2] (broadband-188-32-106-30.ip.moscow.rt.ru. [188.32.106.30])
        by smtp.gmail.com with ESMTPSA id b7-20020a056512024700b004849077e2c6sm2724787lfo.82.2022.07.13.02.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:50:00 -0700 (PDT)
Message-ID: <5d14cf64-46b7-dc37-bbb8-dd6be82d06af@gmail.com>
Date:   Wed, 13 Jul 2022 12:49:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] lib/string.c: Optimize memchr()
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Yu-Jen Chang' <arthurchang09@gmail.com>
Cc:     "andy@kernel.org" <andy@kernel.org>,
        "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220710142822.52539-1-arthurchang09@gmail.com>
 <20220710142822.52539-3-arthurchang09@gmail.com>
 <3a1b50d2-a7aa-3e89-56fe-5d14ef9da22f@gmail.com>
 <CAD4RrFPihC+8LScC1RJ5GfOsLs4kze0QwALS1ykNH_m89Z1NGg@mail.gmail.com>
 <48db247e-f6fd-cb4b-7cc5-455bf26bb153@gmail.com>
 <CAD4RrFPfwu4Ascj5tdz8qq2Qgnu5GN2eHjVwMW5AqUa1H7JapA@mail.gmail.com>
 <49a8be9269ee47de9fc2d0d7f09eb0b1@AcuMS.aculab.com>
From:   Andrey Semashev <andrey.semashev@gmail.com>
In-Reply-To: <49a8be9269ee47de9fc2d0d7f09eb0b1@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 12:39, David Laight wrote:
> From: Yu-Jen Chang
>> Sent: 12 July 2022 15:59
> ...
>>> I think you're missing the point. Loads at unaligned addresses may not
>>> be allowed by hardware using conventional load instructions or may be
>>> inefficient. Given that this memchr implementation is used as a fallback
>>> when no hardware-specific version is available, you should be
>>> conservative wrt. hardware capabilities and behavior. You should
>>> probably have a pre-alignment loop.
>>
>> Got it. I add  pre-alignment loop. It aligns the address to 8 or 4bytes.
> 
> That should be predicated on !HAS_EFFICIENT_UNALIGNED_ACCESS.
> 
> ...
>>         for (; p <= end - 8; p += 8) {
>>             val = *(u64*)p ^ mask;
>>             if ((val + 0xfefefefefefefeffull)
>> & (~val & 0x8080808080808080ull))
>>                 break;
> 
> I would add a couple of comments, like:
> 	// Convert to check for zero byte.
> 	// Standard check for a zero byte in a word.
> (But not the big 4 line explanation you had.
> 
> It is also worth looking at how that code compiles
> on 32bit arch that don't have a carry flag.
> That is everything based on MIPS, including riscv.

It may be worth looking at how glibc does it:

https://sourceware.org/git/?p=glibc.git;a=blob;f=string/memchr.c;h=422bcd0cd646ea46711a57fa3cbdb8a3329fc302;hb=refs/heads/release/2.35/master#l46

They do use 32-bit words on 32-bit targets and 64-bit on 64-bit ones. I
think memchr in the kernel should follow this.
