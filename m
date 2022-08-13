Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781BE5919AE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 11:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbiHMJjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 05:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiHMJjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 05:39:22 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D78E43E7D;
        Sat, 13 Aug 2022 02:39:21 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id f14so2459766qkm.0;
        Sat, 13 Aug 2022 02:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc;
        bh=CrxjDuqE2UjjJ9WlFn43jgqWvWNKAxG2M8agFXX6Qi4=;
        b=nYk7+UMBZh+gPr21y7hILBqx/y7J2y2yrErkyKuKEgKsWaZYnbuQuWUrQxSrx8Oz4S
         8pzNh1QtE/NwkGl+lusv2oJ0+2aLByTGYjiZlmLW3NcQtecdtcR17ceKiMKDyr7654no
         2+aHhBB88RSRXqk2l7qSKtWSohnikYtQfhWLYLpLDJChh5WW/+8/s2bSvD1Mbm5CDAcE
         4IeSJfq8c0ajeY6pWWYSnMFyGqV3FZwVNP2Waz/4reaYpcVa74wXfv4xZqTs69UJO0iR
         KVFPbbYeDX88/anZmqjI/uAAWk9KgsX1ECz27vBGnkLlECKXqOwMrLedFdbXSAc7EcQf
         iOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=CrxjDuqE2UjjJ9WlFn43jgqWvWNKAxG2M8agFXX6Qi4=;
        b=dd3nebHG6PD5frUKMcqIwNuYbhLPhfgIJw57YJxtzjVVlu5FFZB95bBW8tQO0Ny0JX
         UhQ5iXk3YVAOc1hQ7kX2e97D6LOafGbzuOFBscop5RgYbpCRpcOYp9xVRLBNv+8oDNtz
         +qD9U3GD6HSzzkXx8sOtESMhjt1lLQXxpjC3Yp0eClp3EwEhm2pnunk+i/Hf1do4TIvu
         pvgr7IvvfWIF1643IxVxy5zWwEhHEijKF0AZ8sVu4rch/fSMaijRAOTFRgl7BI71jwda
         P0y6ta2qYp/z7E2PT+IMJpt9rL042Aa2aJ+FDy/fFZt1HcgZ/9UhuYlNyGz2DTFp9lP/
         mZIg==
X-Gm-Message-State: ACgBeo0t9CfzeLNFiK/uaxcIYAxFjaaphtq/9x/qGPaEHLr5blQr6Y4e
        fwYSE9Q4x5Ey1OtxEaUR7Ps=
X-Google-Smtp-Source: AA6agR4Inl4zGlgxZN1ZGSWrOWXQa8p0Y5ggQzUhmfsRnNB5ziyM/ek0ED9Hs93dqzLjW88YqXDWBg==
X-Received: by 2002:a05:620a:25d0:b0:6b8:9dec:6c12 with SMTP id y16-20020a05620a25d000b006b89dec6c12mr5584774qko.634.1660383560724;
        Sat, 13 Aug 2022 02:39:20 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id bm39-20020a05620a19a700b006b949afa980sm3789020qkb.56.2022.08.13.02.39.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Aug 2022 02:39:19 -0700 (PDT)
From:   Arend van Spriel <aspriel@gmail.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Manish Mandlik <mmandlik@google.com>
CC:     Johannes Berg <johannes@sipsolutions.net>, <marcel@holtmann.org>,
        <luiz.dentz@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        <linux-bluetooth@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Won Chung <wonchung@google.com>,
        "Abhishek Pandit-Subedi" <abhishekpandit@chromium.org>,
        <linux-kernel@vger.kernel.org>
Date:   Sat, 13 Aug 2022 11:39:15 +0200
Message-ID: <18296926db8.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
In-Reply-To: <YvXusxxBZ+cHvzqz@kroah.com>
References: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
 <bfc5f964d8dadd6378f2da5b3b6ef4bc9fb847c2.camel@sipsolutions.net>
 <YvPbGms7bzFuWTJg@kroah.com>
 <CAGPPCLAV=mnMcteCnqFT5zdbWdZuFQRv6-oxC3qAnLh8_8H61Q@mail.gmail.com>
 <YvXusxxBZ+cHvzqz@kroah.com>
User-Agent: AquaMail/1.38.0 (build: 103800177)
Subject: Re: [PATCH v5 1/5] sysfs: Add attribute info for /sys/devices/.../coredump_disabled
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 12, 2022 8:09:59 AM Greg Kroah-Hartman 
<gregkh@linuxfoundation.org> wrote:

> On Thu, Aug 11, 2022 at 04:21:54PM -0700, Manish Mandlik wrote:
>> On Wed, Aug 10, 2022 at 9:21 AM Greg Kroah-Hartman <
>> gregkh@linuxfoundation.org> wrote:
>>
>>> On Wed, Aug 10, 2022 at 06:03:37PM +0200, Johannes Berg wrote:
>>>> On Wed, 2022-08-10 at 09:00 -0700, Manish Mandlik wrote:
>>>>> This patch adds the specification for
>>> /sys/devices/.../coredump_disabled
>>>>> attribute which allows the userspace to enable/disable devcoredump for
>>> a
>>>>> particular device and drivers can use it to enable/disable
>>> functionality
>>>>> accordingly. It is available when the CONFIG_DEV_COREDUMP is enabled
>>> and
>>>>> driver has implemented the .coredump() callback.
>>>>
>>>> It would be nice to say _why_? What problem does this solve? You could
>>>> just create the dump and discard it, instead, for example?
>>>
>>> Agreed, I do not understand the need for this at all.
>>
>> The existing /sys/class/devcoredump/disabled (devcd) switch has two
>> limitations - it disables dev_coredump for everyone who's using it;
>
> Which is good and is the design of the thing.
>
>> and
>> drivers don't have visibility if devcd is disabled or not, so, the
>> dev_coredump API simply lets drivers collect the coredump from a device but
>> then later discards it if devcd is disabled.
>
> Why would a driver care?
>
>> Now that there are more subsystems using the base dev_coredump API, having
>> a granular control will make it easier to selectively disable dev_coredump
>> only for a particular device. For ChromeOS, this is useful to allow drivers
>> to develop coredump functionality and deploy it without affecting other
>> drivers with stable devcoredump implementations (example, we've had some
>> devcoredumps that take 12s to run and we only want to enable it on test
>> builds because it has lots of PII). The drivers can use this flag to
>> refrain from collecting or triggering coredump when undesirable.
>
> This feels odd.  You have various out-of-tree drivers that take too long
> when they crash to make a dump and it causes some unknown issue
> elsewhere?

If you have drivers taking 12s for coredump you could/should consider doing 
it asynchronous, eg. schedule a worker for it. The coredump callback has 
void return type so it would be fairly easy.

Regards,
Arend


