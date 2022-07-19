Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2672157A042
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbiGSOAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238027AbiGSOAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:00:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD394B489;
        Tue, 19 Jul 2022 06:11:37 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E28C36601A83;
        Tue, 19 Jul 2022 14:11:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658236295;
        bh=8YDDjVdTJy5mlkoOKTkV47AAUAvRSJpwczvJ6O253Ug=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fFWWIHzE8lrYlDyV7WugJd5eGY+haNHF8l4lYALSoUHf5K5/hYSIijforx3Fg7zQX
         KbrJzMFDQ2sBB/8ptL4RB6Ky+ZasiSzJDCteKgKhPNHMvR4v5uCJrh3Rl916aOOoWJ
         tEHzbMgO53Yyz2k1jtZEh3tJRMq2C8wMmX2p4wMKgmhdBcEXQI4iFi57acSoD7l1eg
         PeEGnNK68FUro/zBlGtq5n23dF8MQZf29bZEjjCIt+UP++zxmqrPImKJsHRDJJYx3N
         7qQgaSNklFplRfHmE66mp0CvT7shUYfYPMlRMlHbD/aA14DN67MPz35Q4ZqYW3PXGz
         0XYYI2XkO/exA==
Message-ID: <07452438-f7e7-70d7-7a38-567f0f224fa1@collabora.com>
Date:   Tue, 19 Jul 2022 16:11:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 2/2] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>, lars@metafoo.de,
        robh+dt@kernel.org, Zhigang.Shi@liteon.com, krisman@collabora.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com, andy.shevchenko@gmail.com
References: <20220715111626.1066513-1-shreeya.patel@collabora.com>
 <20220715111626.1066513-3-shreeya.patel@collabora.com>
 <20220718182547.360e5cf2@jic23-huawei>
 <1e880d3f-758b-56a8-d468-dcb06f4cbc18@collabora.com>
 <20220719131808.7899acd4@jic23-huawei>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220719131808.7899acd4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 15:19, Jonathan Cameron wrote:
> On Tue, 19 Jul 2022 14:56:51 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> On 7/18/22 20:25, Jonathan Cameron wrote:
>>> What turns this off again?  I'd expect to see a devm_add_action_or_reset()
>>> to do that in the !CONFIG_PM case.
>>>
>>> This is also an unusual pattern. As far as I can tell it works.
>>> Normal trick for ensuring !CONFIG_PM works is to:
>>>
>>> 1) Unconditionally turn device on.
>>> 2) Register unconditional device off devm_callback. Very rarely harmful even if device already off
>>>    due to runtime pm.  
>>
>> If CONFIG_PM is disabled, do we really need to care about the power
>> management on removal?
>>
> 
> Best effort + in general if we do something probe(), we want to do the
> reverse in remove().  Sure it's not super important, but it's a nice
> to have.  This tends to get 'fixed' by people revisiting the driver
> after it has merged.
> 
>>> 3) Then call pm_runtime_set_active() so the state tracking matches.  
>>
>> We can add pm_runtime_set_active() before h/w is touched for more
>> consistency. On Steam Deck supplies are always enabled, but this may be
>> not true for other devices.
> 
> Generally set it wherever you 'enable' the device as you are indicating
> the state after that has happened. That might be really early though.
> 
>>
>>> 4) Call 	
>>>   pm_runtime_mark_last_busy(dev);
>>>   pm_runtime_put_autosuspend(dev);
>>>   (here you have a function to do this anyway)
>>>   to let runtime_pm use same path as normal to autosuspend
>>>
>>> the upshot of this is that if !CONFIG_PM 3 and 4 do nothing and device
>>> is left turned on.  Is there something I'm missing that makes that cycle
>>> inappropriate here?  The main reason to do this is it then looks exactly
>>> like any other runtime_pm calls elsewhere in the driver, so easier to review.  
>>
>> It's appropriate, although caring about PM when it's disabled in kernel
>> config could be unnecessary, IMO. It was my suggestion to keep the h/w
>> enabled on driver's removal with !CONFIG_PM, minimizing the code.
>>
> For the cost of about 4-8 lines of code, I think it's worth having, but can
> also see why you decided against.

Alright, thank you for the review. Shreeya will address it all and
prepare the v10.

-- 
Best regards,
Dmitry
