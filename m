Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0186560AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 22:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiF2UCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 16:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiF2UCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:02:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AAD3ED11;
        Wed, 29 Jun 2022 13:02:31 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 40BE7660194C;
        Wed, 29 Jun 2022 21:02:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656532949;
        bh=XZKTlLtT5IwYyJZvyMZi3Fm4hVnGjrmKXiDIiDRogfw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eqG4tpPX332aqBNR+tZzQwfABs4LYwFRTZb620NZoy6ztChHNeK88ZlYDRnpY3rCC
         t8PGjaWO3qC5XFDWeEdXMqJX4xGSJkBvGMF6dVZr0CmP+3j/fBh6elX+E5Q50fkVoJ
         dQ79vsb5eiS9SbTNBPwZpqJaALJeHEEPnp8NLcHlGkQ3dfUN7XPJUlRk+biLh0AGws
         qP6DNiyPwVwaOOKnrZvRZs1IMJpUWvKYPMVtWSt5T+yA08EvEyrXpQSoDtSGwolpCh
         reTsHexO4xB9PratqDcj5LKPhn4XbAp5FVm97Oiz0oOTHJC+i2fGu+nwv2ogYZlPrE
         e1nYqT/ioND+Q==
Message-ID: <ba43ed2c-0290-ca5b-ab4b-1f25dad9d882@collabora.com>
Date:   Wed, 29 Jun 2022 23:02:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] hwmon: (lm90) Use worker for alarm notifications
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
References: <20220629154210.2389765-1-linux@roeck-us.net>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220629154210.2389765-1-linux@roeck-us.net>
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

On 6/29/22 18:42, Guenter Roeck wrote:
> Reporting alarms using hwmon_notify_event() may result in a callback
> from the thermal subsystem. This means that such notifications must
> not hold the update lock to avoid a deadlock. To avoid this situation,
> use a worker to handle notifications.
> 
> Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Fixes: e182cf579f0f ("hwmon: (lm90) Rework alarm/status handling")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Dmitry,
> 
> can you give this patch a try in your system ?

It works, thanks!

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
