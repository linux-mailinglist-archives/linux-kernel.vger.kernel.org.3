Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F174FB0D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 01:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiDJXcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 19:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244085AbiDJXbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 19:31:55 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBE52BD6;
        Sun, 10 Apr 2022 16:29:42 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c24-20020a9d6c98000000b005e6b7c0a8a8so6746433otr.2;
        Sun, 10 Apr 2022 16:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6tr6W2rgAx9VaAx9urZuPMOGGVt+QdZBgP3A9YL8kOA=;
        b=qFhCAFcdIfOxfv+48JZf+xmC4zS6WlGbPAbzQMXt2EamL1KSPOpEBMIn+mUadzt0f3
         n6q78g36XhWm53NuD4bF41ETESEI/ASNu6uacMXpcFUyf0BaD1Dy/DALvJWSock8EzAZ
         icRiQcLiQ34EUEdcVZ2ktU4U9z1y1bKtJI699RYJj/AkkFf8BC3bWlt7cLhXXM5K1Tf2
         PXScD3BSBB3IlUobw0HUgrqLVqH/C5Z9mpRCfJDSVCTk8z3kd0/STlTMS3d5PPL2SMqo
         LZGYvV9ktQ+vH0HnVN5f6ppYdi8PL3+WDPT/UYCv3vTXbRcc2wvXycCvCJJiulFL0E32
         Xmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6tr6W2rgAx9VaAx9urZuPMOGGVt+QdZBgP3A9YL8kOA=;
        b=PrXkA5aNjFjWBynUixti3W3scsfveK6cJDqP7caojtfN4YzZmhJkW8BHLTW6t2F79E
         Rs2XpL+a/nyPq95iPBPiuZkhYxkDGcmzWnjEWhcJvS1aQkLwSuRMWTSO4HYq8mzfu5Vo
         S0qejJhCSbAjRNkesf24groF+y6xadNsQ6/cZwyekJAH6JNK45FEJQ+pkzdyVokEpiik
         0ESMCvs35M9Mbn5eXYnt0eX7Co1aSniFx5QOWgRLr1++71qk9wvkmqACPP4UFdxD+l84
         gp2o9wbSe25UZjN7uW06ZuO30TqJBmzlmCzXgCkEGNBEVdwEx5kSMEYN5xTz5z3SgZYs
         nvOQ==
X-Gm-Message-State: AOAM533+Ltwvw9nD8sV1qglQDRyyOTEmQ9zaMtVNUG6sCaN+tod8Yv+8
        vlI2h6cyWU784XEWOIAxEx+4aKtYjpw=
X-Google-Smtp-Source: ABdhPJwC9tXw02KO9jVLel9VumsOi6P/pTcSBVZ+Jw+JDCxhQajWJCpXxrsTjEqG+9SAQgBgCG3RZg==
X-Received: by 2002:a05:6830:1185:b0:5b2:4c85:5ee9 with SMTP id u5-20020a056830118500b005b24c855ee9mr10327696otq.335.1649633381795;
        Sun, 10 Apr 2022 16:29:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bc35-20020a05682016a300b00324e9bf46adsm5047539oob.41.2022.04.10.16.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 16:29:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ae9f718d-e65b-9216-f90b-0bc463189834@roeck-us.net>
Date:   Sun, 10 Apr 2022 16:29:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] HWMON: Fixed comment error by checkpatch
Content-Language: en-US
To:     Ozgur <ozgur@linux.com>, Jean Delvare <jdelvare@suse.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <582321649631791@mail.yandex.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <582321649631791@mail.yandex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/22 16:07, Ozgur wrote:
>  From 3a50310ab617aecd5b86378f07d2500bc86935d4 Mon Sep 17 00:00:00 2001
> From: Ozgur <ozgur@linux.com>
> Date: Mon, 11 Apr 2022 02:55:47 +0400
> Subject: [PATCH] HWMON: Fixed comment error by checkpatch
> Fixed a coding style issue and checkpatch errors.
> Signed-off-by: Ozgur <ozgur@linux.com>

Please,
- Do not send corrupted patches.
- Follow patch submission guidelines when sending patches.
- Do not send patches fixing cosmetic issues like this one
   without making other relevant changes.

Guenter

> ---
>   drivers/hwmon/sch56xx-common.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
> index 3ece53adabd6..6ed0908c6037 100644
> --- a/drivers/hwmon/sch56xx-common.c
> +++ b/drivers/hwmon/sch56xx-common.c
> @@ -430,8 +430,9 @@ void sch56xx_watchdog_register(struct device *parent, u16 addr, u32 revision,
>                  set_bit(WDOG_HW_RUNNING, &data->wddev.status);
>          /* Since the watchdog uses a downcounter there is no register to read
> -          the BIOS set timeout from (if any was set at all) ->
> -          Choose a preset which will give us a 1 minute timeout */
> +        * the BIOS set timeout from (if any was set at all) ->
> +        * Choose a preset which will give us a 1 minute timeout
> +        */
>          if (control & SCH56XX_WDOG_TIME_BASE_SEC)
>                  data->watchdog_preset = 60; /* seconds */
>          else
> --
> 2.30.2

