Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A6C5704F6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiGKOEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiGKOEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:04:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB34120A7;
        Mon, 11 Jul 2022 07:04:09 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B2FE066019FF;
        Mon, 11 Jul 2022 15:04:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657548248;
        bh=C0XN9RKnWDlXmYm+a6GfTq9/VWea2/+BxOU6oLr0iIA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a4UBbmV2mSyXG2UjvRpgZls25hVIKUBcPmATMmR75GesQqwEutstb/m8oaJVAWcLz
         3VXOto5qYeVOZXmP9jl8iIx0ZbfyiIVVU7ohty6MLy9P7G1CGjWKRWv9SVRooUz+mH
         vWkItc9ycf4O5giNdhKzfXIr8eXQTbhYmpFRd9oR+h4qe8kJQLztHfjsPpkK9bN5d6
         ZNTVS/33imlFuHGR0/O5V8O6SBPD64uYpWrannQ24htvd7YMomkP8dOaUAiTi2Oo36
         G2nsAaeFG9E2UBXNCuwxvflnBkf9Z2mZtDIPY2HSHAzt4srrWTO8HPCGh/yHinyi96
         d7ayb2gWNmqBw==
Message-ID: <68de450f-da22-02e3-e863-7e17582ee03f@collabora.com>
Date:   Mon, 11 Jul 2022 17:04:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 2/2] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        alvaro.soliverez@collabora.com
References: <20220711112900.61363-1-shreeya.patel@collabora.com>
 <20220711112900.61363-3-shreeya.patel@collabora.com>
 <CAHp75Vf3NDsep5_819=e8yrna_AGh5cew=fs+hHe1q8LCa-PyA@mail.gmail.com>
 <c90e7334-5921-886b-2f9c-869fb55216ca@collabora.com>
 <CAHp75Vf=FOt+N6azar5gifvig8FL4sS3LX1kO8CzNCh2yOk-DQ@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAHp75Vf=FOt+N6azar5gifvig8FL4sS3LX1kO8CzNCh2yOk-DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/22 16:41, Andy Shevchenko wrote:
> On Mon, Jul 11, 2022 at 3:39 PM Shreeya Patel
> <shreeya.patel@collabora.com> wrote:
>> On 11/07/22 18:36, Andy Shevchenko wrote:
>>> On Mon, Jul 11, 2022 at 1:30 PM Shreeya Patel
> 
> Please, remove unneeded context when replying!
> 
> ...
> 
>>>> +static const struct regmap_config ltrf216a_regmap_config = {
>>>> +       .name = LTRF216A_DRV_NAME,
>>>> +       .reg_bits = 8,
>>>> +       .val_bits = 8,
>>>> +       .max_register = LTRF216A_MAX_REG,
>>> Why do you use regmap locking? What for?
>>
>> Why do we want to skip the internal locking if it doesn't bring any
>> benefits?
> 
> Can you elaborate on the "no benefits" part, please?

Since the regmap's lock will never be contended, thus it's free to keep
using it. If later on we will need to change the driver's code such that
the lock will become needed, then we won't need to bother with
re-enabling it. The comment to the driver's mutex states clearly that
it's intended to protect the cached value.

Hence what is point in disabling the regmap's lock? There are very few
drivers that disable the regmap's lock and most of them do that for the
good reason.

-- 
Best regards,
Dmitry
