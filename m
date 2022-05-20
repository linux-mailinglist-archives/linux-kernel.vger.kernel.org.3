Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFD852E135
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbiETAcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiETAcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:32:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0B6E27A0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:32:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n10so6650283pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2kyTK1Xzp0uleyHZa8Lbz5PJ7tb6T3DY9r1gkIE8nXo=;
        b=6Kjxdk2J2ZXQdrjJTe7zxtt8o6HbHEmbfdBfaF4TAir1GUIcjuKvGvzr3WpmLeVfD8
         1BApvbbdrHkkz1y3h+P9IGMMq5h6q4Ao1mfH/70DnfqmG7d5cz87m3G+5oN6SNHyiqNo
         wna9rIeOMHFyXGwJZfu7Z9b/yetdzr8lrs2j+//ufoLIp6c1Xmey5ywJW5ZbHuU1iy1O
         +8UuarOwcVdZdUqZjk09SaYeISCbex6R0UbNc38t8NH5QNIRuHE5MXa1AST3QO6Wiypp
         c7VYiupg5pwUFjd+7QYC4fd9Umg1pJ2bxw1wCWvaV+yZThjGdHZbLNwvSC1kF45SeC2R
         ZiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2kyTK1Xzp0uleyHZa8Lbz5PJ7tb6T3DY9r1gkIE8nXo=;
        b=HSUoH+o6DRKlVl//MQ3YWYOcOPDTNU4vKqbVGHLbCbtn/stSj4aD/ScgOvc6/0BD3j
         ruoA9XqQOpEcmXeS5aDguJ/xWhGn4HAevUBAPVvxejfmkUFkcrPiUT5nxqqqb8+D43Qb
         LKFogeGALwk3yk4gWS42+lFotfvS9CsN/4qSbL4SgKSbXm+Pzm2mkY+OHt+VT0wN9Zyg
         Y/GZBCvSCJuDvXQMvVvd+cZTUYpSZpsrOYYP/+ySLNOTJ4T+LJ4Wm0lMUpA7g3AUrJ8N
         qa7lI5z1RYPRxhexiu3F9Qqhvr5UIp+mu2gcd9cc/V+L6Zu7aEzwpa7ysJSY+iLGAYrd
         RUGQ==
X-Gm-Message-State: AOAM531OYNsI71/4hvTTi8BvJaseQiuAqrzVyF3nNhrALryX9zGTfcsL
        klPAAtBXTX66/+2Cfp+cRKoWI0PPx+ATQg==
X-Google-Smtp-Source: ABdhPJw4ycYNCt6JH3yOif0cW3FO0a77sTiht7INw0UnFdwmKNukiK/bK4eCxAs8RATyIzxgeXNSWA==
X-Received: by 2002:a17:90b:4c8f:b0:1de:b3b5:ea23 with SMTP id my15-20020a17090b4c8f00b001deb3b5ea23mr8497634pjb.133.1653006725595;
        Thu, 19 May 2022 17:32:05 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090a6b0400b001df17c83bbdsm393483pjj.45.2022.05.19.17.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 17:32:04 -0700 (PDT)
Message-ID: <607e3d8f-0216-127c-8f4f-6034b0d17c15@kernel.dk>
Date:   Thu, 19 May 2022 18:32:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] random: convert to using fops->write_iter()
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <f871a510-d262-bc98-757e-204976e1b82c@kernel.dk>
 <Yobb79PvIqRRNguV@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yobb79PvIqRRNguV@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 6:08 PM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Thu, May 19, 2022 at 05:43:15PM -0600, Jens Axboe wrote:
>> -static int write_pool(const char __user *ubuf, size_t len)
>> +static size_t write_pool(struct iov_iter *iter)
>>  {
>>  	size_t block_len;
>>  	int ret = 0;
> 
> Changing the return value to size_t isn't quite right, as this can
> return -EFAULT. So at the very minimum, it should return a ssize_t.

Good catch, yes let's make that a ssize_t instead. Can you do that while
testing/applying?

-- 
Jens Axboe

