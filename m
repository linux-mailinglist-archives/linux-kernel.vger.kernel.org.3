Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C5B4C84DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiCAHYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiCAHYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:24:10 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C066026105
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:23:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i8so1853331wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rIE4EFGbZL6WUGzIqVirpqO3d5o889rX0VfU2ArstBs=;
        b=DSMA/InOe8DCAy1FOXo5Q8hNYk7jctcE1mLmlLYJv5dAfQy31qvAqddYdd7rechXhB
         3Pc9dbphWXWCcJ5wC7I92H4YOW9zubI0SWOGYxiVP4zXH4v3VxYSD40owx8Jsnvv/DXX
         L148TZGUl4KY93X5CeCNHtb5VpbpsPMHMm+/l2bQ1Cf02gd1PrcM+8TgmfEHVo3jjNLW
         IYmGfptof/UBwShwv91RcKES1B4mNj/FsMVXVVBlYB0oQbZ07d6Dcqy3sHjU/XN/32jl
         6oNSrqQdRdySGEfapDN/9ZFCsi4MKpxiAd4Pz04BsB7Ldq8+eF9H/OesOI+7IgGj47SG
         ZNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rIE4EFGbZL6WUGzIqVirpqO3d5o889rX0VfU2ArstBs=;
        b=dxhppReW/14MmT5LDJQhLd2l6fTdxWdDluVBPlSD9rdVAlP2JV4SF5KWWBRq8UfqcW
         /gD0YVY7vqM0n+S9V3hfL4kCQ16CZ/iEBiCUwxfwSmCBKLGZgkhqdLYg7zO1sN0dF05j
         9PJmq9Q0snZNmyHnTadLfWlzUvYugt/tUOkd89JAZdGb0O0sTqUEJXDFBYe0Pcngvu9k
         ffTHgFwjk972MzcU3K/3L4QJV+oOQQWDdPZWnbYgRuhYX4lbjX8fBq+R5prK/E6MNIgt
         MsCFK+EyKQWb306JSB0ReBCtsy6idm5ae21J/8SPgbRYrF2su6C15RaUVdloPfF/Rxr+
         bXbA==
X-Gm-Message-State: AOAM533Ui4u9al6PqXGoXE2o/JW5Jwx0121OWR/VcDuBz00U/lEpBXmK
        +THELjmqrDB42LqiVwnsKw9Z2A==
X-Google-Smtp-Source: ABdhPJy+QZiDJNqpcz0wGmi44+WOjQ0ZF8WegPcQOAe5tKXgKNVBB/+c5PQ4y6VD8Lpv6d8js3NZLw==
X-Received: by 2002:a5d:4578:0:b0:1ed:bf30:40f3 with SMTP id a24-20020a5d4578000000b001edbf3040f3mr18812678wrc.669.1646119408164;
        Mon, 28 Feb 2022 23:23:28 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:f9e4:b6da:2b53:5858? ([2001:861:44c0:66c0:f9e4:b6da:2b53:5858])
        by smtp.gmail.com with ESMTPSA id i5-20020a1c3b05000000b00382871cf734sm186554wma.25.2022.02.28.23.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 23:23:27 -0800 (PST)
Message-ID: <8747c5c6-a129-3a26-8ebb-9e21a18236ec@baylibre.com>
Date:   Tue, 1 Mar 2022 08:23:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH V3] tty: serial: meson: Fix the compile link error
 reported by kernel test robot
Content-Language: fr
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220228135530.6918-1-yu.tu@amlogic.com>
 <29b34655-f820-39c9-4363-878481cd3f63@baylibre.com>
 <Yh087tJhakKHs88e@kroah.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
In-Reply-To: <Yh087tJhakKHs88e@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Le 28/02/2022 à 22:21, Greg Kroah-Hartman a écrit :
> On Mon, Feb 28, 2022 at 03:13:48PM +0100, Neil Armstrong wrote:
>> Hi,
>>
>> On 28/02/2022 14:55, Yu Tu wrote:
>>> Describes the calculation of the UART baud rate clock using a clock
>>> frame. Forgot to add in Kconfig kernel test Robot compilation error
>>> due to COMMON_CLK dependency.
>>>
>>> Fixes: ("tty: serial:meson: Describes the calculation of the UART baud rate clock using a clock frame“)
>>
>> As I already replied on V2 of this patch, you're invited to apply these fixes directly
>> on the next version of your "Use CCF to describe the UART baud rate clock" patchset
>> and not as a separate patch.
> 
> No, this is broken in linux-next now as the path listed here is in my
> tree right now.

Oh, I wasn't aware you took this patchset.

> 
> I need a fix for it, or I can revert the original.

Please revert the whole patchset, it's not ready yet, neither fully reviewed ands buggy
on old SoCs.

Thanks,
Neil

> 
> thanks,
> 
> greg k-h
