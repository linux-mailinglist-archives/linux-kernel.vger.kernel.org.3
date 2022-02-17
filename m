Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552EF4BA1EE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbiBQNvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:51:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbiBQNvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:51:46 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C501F5C99
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:51:30 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id z4so5060156pgh.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0kr8dYO1AqVlag5MK+6evkHEcy2nXbV4DT4/fu7hw/4=;
        b=Kvq39B+ccBdYlKyENKVpOGTfQdtUIKL0wWDVBtxZte/cDqwK7APs5Lv7sTnV8fdjX+
         gRF5r2r+Y7Z2plRlEswKV5BQiKH86VRIYAbeKZdbJLNhOVGUj6YAyGYEbusVVUJdACh0
         2NTAFU0+/M826p7vBSAbhHX4uelQHZcJEi7PgNhSXP023lx+v0ASXlbZ+4qmZFdYy+I+
         b4gxk/JefTLd9n4QHT5jnYwrNQEVgbzGZTqf0i2YJ2Ct1MYk46PPfti/joJ37SD9QuWX
         YUl1AnBN/QHEIwVsglqyMwVnNeu7g29ZqDeXcHfunSb3eftATJG7bnbpR9JTgy+gwW5X
         Tlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0kr8dYO1AqVlag5MK+6evkHEcy2nXbV4DT4/fu7hw/4=;
        b=XvezWKmRK759iShn64ytK4NsW7WnCkVzT+VHrt0t7qUV2Sj/XeWyOtZzQ98PWQtydx
         doTKr2ZV20YGyLwIEOgKQO7XklUDNh1DiXZkKCcz8brhDve0MBDyXf0h4kaw2lyByeB/
         a4SaJZ1tTujm/xHaF97W++UzlxoPGuKL/vJnrEKcu0nhh3CXujO3+fzAz6E/l3T435Qt
         7SyXfVkthEtFiwnRS4FvrUtbeh9kEvwxFZXDlVBS8wias5AMccVNoHKoPVS9i2uv5FAf
         EUhyDOC347/s0bkhulaGzSvfMsmnwV4PT6gkQ/S1wfO/UkGKPxvlM6gCO5etAAlX4wOL
         OPvw==
X-Gm-Message-State: AOAM5310/6xr5rIlBFieIwOKpPoInE7SRgoTc8k4IGVQfg2XMiRdYA6m
        /BMyRWS3tLZ6+LKpXBrMNJ5AOjRB6ubT8g==
X-Google-Smtp-Source: ABdhPJwj8dzIfXUejV9MkeZMkKqNO0xeuopTqfpsWZ77olKhau/mQvMiNf8OQxR0n7/T/B2Z1KUnLA==
X-Received: by 2002:a05:6a00:1ad3:b0:4e1:5623:fdd with SMTP id f19-20020a056a001ad300b004e156230fddmr3044509pfv.26.1645105889597;
        Thu, 17 Feb 2022 05:51:29 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j7sm43990395pfa.36.2022.02.17.05.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 05:51:29 -0800 (PST)
Message-ID: <b6bf2ab5-031d-8be8-e9e7-ba04f39ef35e@kernel.dk>
Date:   Thu, 17 Feb 2022 06:51:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] tps6598x: clear int mask on probe failure
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sven Peter <sven@svenpeter.dev>
References: <e6b80669-20f3-06e7-9ed5-8951a9c6db6f@kernel.dk>
 <Yg4HwO2SKGDvOASz@kuha.fi.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yg4HwO2SKGDvOASz@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 1:30 AM, Heikki Krogerus wrote:
> On Tue, Feb 15, 2022 at 11:22:04AM -0700, Jens Axboe wrote:
>> The interrupt mask is enabled before any potential failure points in
>> the driver, which can leave a failure path where we exit with
>> interrupts enabled but the device not live. This causes an infinite
>> stream of interrupts on an Apple M1 Pro laptop on USB-C.
>>
>> Add a failure label that's used post enabling interrupts, where we
>> mask them again before returning an error.
>>
>> Suggested-by: Sven Peter <sven@svenpeter.dev>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Should this be marked as a fix?

Maybe, I can try and dig out the offending commit. From some quick
checking, it didn't come in with recent fixes, so it's probably been
there since support got added. Maybe we just mark it stable?

> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks! Greg, will you pick this up?

-- 
Jens Axboe

