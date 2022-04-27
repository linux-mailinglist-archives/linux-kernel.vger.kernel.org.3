Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074DF511E64
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244521AbiD0R7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244534AbiD0R7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:59:39 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CECD2FF8EB;
        Wed, 27 Apr 2022 10:56:27 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e656032735so2815607fac.0;
        Wed, 27 Apr 2022 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ay70JJfxgI4f1cvx3A4AnPQKdrRnK/Iw4p4S0x3nnCs=;
        b=OLHjF71WP1J3jvDhuaKlm3iXD/mcjC5RVhiKmJgBGUQ1xKFkLWbrl5AqL8s4exhYvF
         uUmQK6YlYPorVXyH4XbVv82Nr14izTfeAx4GBFBr0S4CdZF43X/2Bt9j5O8EJfPB7YZP
         FQxZejmUmpWq88LzHg0ytZLaL+P7UvOIiXvzRqQt6lpnbkRlGb9X2VlqRNMCQ4hl7Cxh
         /TKiFhg0mNb15LB+hLY00nZIIChJ41lGCrMMjxfrHTP/REPLbodSb2hpj+hx9+fDpJAr
         s4U0VhwRQTWtC14uh/VlnXAVWpxGfgkR+EYjaOsYp7NzYI5rfOzVC2ClmoacJNvG5RRW
         pzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ay70JJfxgI4f1cvx3A4AnPQKdrRnK/Iw4p4S0x3nnCs=;
        b=2Ev8OclgSmXad/NlvFho7wdEoILWvfmL4UZkhIKE52N8P2jPmC78zDkIrwN7LOHCYu
         dVWo6avWRTWWcOEbJ4rM+nOHO9Z3E+pAcUCmvP4q0I5WPfVtR9+FnX43fs1WlC2/AQ5J
         iTJSqVXw4sEW3pIXS9pAjtcKWxHlIDaQJO6GxzzW5q/vkyT9H5m/XRWF8sQre9RzKgIh
         xgTTLEFTBB1lo7xdk9qRlGW5Kz3NenfLizlKGgQo7xJIOLl1q92/MiBzxGPxq9I/zSAa
         w5n/8KhZRW3nVxbhaVs2Jl1rkf25mZZAMA2L60OkXhq9ALLrhGMHLJGbv+PWOVuCI5vq
         mLNg==
X-Gm-Message-State: AOAM530hBLW0ETmfZ0EqPk3F52Y0odJBWS9bZ7g1Rr1LeUavkwETUyTi
        bIVLDCYPfxchcLKsgpJg4VA=
X-Google-Smtp-Source: ABdhPJx74Us6sVSM3wgpFzy70DwQH/Athg2ooakdq3IzGXxabs5U5jeUwxfGbR+8CcSjOp3EALI+fg==
X-Received: by 2002:a05:6870:3112:b0:ce:c0c9:62b with SMTP id v18-20020a056870311200b000cec0c9062bmr16062307oaa.125.1651082186620;
        Wed, 27 Apr 2022 10:56:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dv2-20020a056870d88200b000e93d386d97sm915229oab.31.2022.04.27.10.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 10:56:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <588c401c-6b68-53b3-e2d9-542f40b5e4d3@roeck-us.net>
Date:   Wed, 27 Apr 2022 10:56:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] hwmon: (asus-ec-sensors) add PRIME X470-PRO board
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220427143001.1443605-1-eugene.shalygin@gmail.com>
 <20220427143001.1443605-5-eugene.shalygin@gmail.com>
 <CAB95QAQ0jwgQyV+PCVy1swN8hXC9U2oRbtbPqU13oW8_1v9zaw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAB95QAQ0jwgQyV+PCVy1swN8hXC9U2oRbtbPqU13oW8_1v9zaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 09:57, Eugene Shalygin wrote:
> Günter,
> 
> I forgot to add PRIME X470-PRO to the list of supported boards in
> Documentation/hwmon/asus_ec_sensors.rst. Could you, please, add that?
> It should be the first entry. Commit
> 8f8db4b5d10cc4a2a801514e677dd5205651b771. Or should I resend this
> patch?
> 

Just send a follow-up patch.

Guenter


