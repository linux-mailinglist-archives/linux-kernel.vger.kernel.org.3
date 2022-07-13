Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA0757339D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiGMJ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiGMJ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:57:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3A4F90CB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:57:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id o7so18192970lfq.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5yJHhqVPk2ZS/u5R/efMYnn4/6Ff7LLWCXjWXuOmA44=;
        b=KIdTsJJgOB+9snLwV677m/c3z4hhqQIkaFBF4oO6Xla3+z7OP3eSW062s/19GsAeyC
         HbxoIuT8Kl3Dz0UtJ6QTpITKSJ0qFKXazj4ZnJSz8j8xfqVC1oI/ArDFAxcUzi+aLXxL
         S/1S13TCOM6CVxxbgekoYa467td9h0u8IeaMxG1+4LtnqSLOsBojiC2accWglubsOPq7
         x31AWRgVoMettp3rH58vNkHWi+vG2vMGttZ02lGj5SeljvVFhUIesq9shjpfjGTLUJOu
         78SnhapNIoPadruEXeclkxywmrYDnbBLJMS0ASL1qSm3vBF3a1ugcuB6Wb1XXoFv67NK
         2rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5yJHhqVPk2ZS/u5R/efMYnn4/6Ff7LLWCXjWXuOmA44=;
        b=2r0Py10q3LTx12Ftz9AUBAN4Qz0GCjUn6nW0DypUukT4MHdmV+LdU294ts+Y+4XVx9
         ZGxuEfm0x9FKuaG+PCwEmsGJsA30WiycKIonzAYQ0VBtlcTeEs3qcoelWj0NGJ3qI5w0
         EzLgqxaZ4kLB9xngv7EF2jrE0rzfwcrk7wlHEfbDLk9RxaE5y2WZk90CTvlktaGf76rR
         o63mCCIbvz5qJ2lf3OhckBzOPcrBN5COdXx+yFy4Be96IhR5y3orFq84kDZn2QOsZtY3
         LAgBQdQcIlMZx1X8TyaTrQ+6z0P1VSJlJRGeDywQSTE3kFiJmG2m8DACXrKchOsIYTaD
         0C6Q==
X-Gm-Message-State: AJIora/zxABK3+4f1Bht7jdB4plzVoHHcJNI4NsTrvlPHREvVuRkj48J
        AZ2zOJZTQZndN2/BxOw4aZA=
X-Google-Smtp-Source: AGRyM1uHmrRyQOgBw36xgx7SvFrGhNZGwduPjYLZtzRtCrL8NLSzjnWpX3S8N5Lp+O46NN2AwEPpKQ==
X-Received: by 2002:a05:6512:1295:b0:481:1a61:8d21 with SMTP id u21-20020a056512129500b004811a618d21mr1455205lfs.500.1657706273830;
        Wed, 13 Jul 2022 02:57:53 -0700 (PDT)
Received: from [192.168.1.2] (broadband-188-32-106-30.ip.moscow.rt.ru. [188.32.106.30])
        by smtp.gmail.com with ESMTPSA id q16-20020a2eb4b0000000b002559299b0e7sm3032200ljm.86.2022.07.13.02.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:57:53 -0700 (PDT)
Message-ID: <a9106c37-51d3-be8e-c9c2-4ca279b4523e@gmail.com>
Date:   Wed, 13 Jul 2022 12:57:52 +0300
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

If there is a pre-alignment loop, there won't be unaligned loads, so
there shouldn't be the need for the HAS_EFFICIENT_UNALIGNED_ACCESS
check. Unless I misunderstand what HAS_EFFICIENT_UNALIGNED_ACCESS indicates.
