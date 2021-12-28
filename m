Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7231D480A87
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhL1OuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhL1OuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:50:25 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE9CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 06:50:24 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id y18so14514709iob.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 06:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l9nM/caC7jqplBef01OjNObpmzs6O53UR3TuHU2t930=;
        b=UZinsWCZe0ig758ZYaZg6eSk8CKPxR3PgBVvDfPOd0kgcrjKqBQeoD/Rtf61ksbFxU
         KWnQTqobxvDG7SJHhkjT/zSks3ZJhcvhfSAGlKa9HUdASuJofy2z/xWSpk4QF/TIcJKH
         iDbn5fBKSN/te5FWgkWD3LVlybAet056CZ3uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l9nM/caC7jqplBef01OjNObpmzs6O53UR3TuHU2t930=;
        b=yv5Uu6z1BNNx4TEbzmgsuB0rKV3hhLkpqLkyFhosbNRDjTLZFmMs9pzVQxmMftKkwq
         /hNuPKtlwqSy5fRM9Z6e/N5/nQ0zLPCqpH6FSioUl09at5bNVlsCachAkjk5puHelXVj
         Td/B/vvIPVgNiGe5Ud2rR7lSHD8jGUXCzP0ov8O7RUAe1LcPLKurKz2eX9PnIyMUx9VJ
         kdPwr/xH0v27WzB2hkjRTUjhH9b/i7XtC3SsVj2L1oNw9yjKaHYRO/oAygY3G4/UJrK1
         WDuiHVyilg8uRFyHOWfjawa9sMMz/fYUGJo8lBgWTOCqts1vKQVenhrdEzt3HNOQa/UE
         Zi/Q==
X-Gm-Message-State: AOAM531FXuk7/CeWKFupxvkuFhA5urkoUTchBMgrj1QFcD1i2TBmN8x+
        u87aG6xXXuaYty/k4xYi3b6QDg==
X-Google-Smtp-Source: ABdhPJxw2e4B7IZMXTMBU/MguvgUyWMDdeJBwhgrgC7n+eBhfsdp+BFLVDXHmuv2wBeA6fO49CxqOw==
X-Received: by 2002:a5d:9f4c:: with SMTP id u12mr9371354iot.22.1640703023773;
        Tue, 28 Dec 2021 06:50:23 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id m2sm11776748iob.21.2021.12.28.06.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 06:50:23 -0800 (PST)
Message-ID: <2410da25-5f91-dd4c-77d0-b7226b56616d@ieee.org>
Date:   Tue, 28 Dec 2021 08:50:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] staging: greybus: audio: Check null pointer
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, vaibhav.sr@gmail.com,
        mgreer@animalcreek.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20211228020221.1635885-1-jiasheng@iscas.ac.cn>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20211228020221.1635885-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 8:02 PM, Jiasheng Jiang wrote:
> Sorry the previous email is forgetten to wrap line.
> This email is corrected and the content is the same.
> 
> On Mon, Dec 27, 2021 at 11:54:10PM +0800, Alex Elder wrote:
>> I think this is a good change, but I would like you to improve
>> the description, and fix some different bugs introduced by your
>> change.
>>
>> What you are specifically doing is checking for a null return
>> from devm_kcalloc() in gb_generate_enum_strings(), and are
>> returning the NULL pointer if that occurs.  That means you
>> need to update all the callers of gb_generate_enum_strings()
>> to also handle a possible null return value.
>>
>> The fix does a good thing, and your description is correct
>> about what you are fixing.  But it should supply more
>> complete context for the change.
> 
> Thanks for your advice, I will correct my description in next version.
> But I still have some question about the devm_kzalloc().
> 
>> You can't simply return here.  If you look a bit above this,
>> where the call to allocate a control structure is done, you
>> see that a NULL return there jumps to the "error" label, so
>> any already allocated and initialized control widgets get
>> cleaned up before returning.
> 
> Actually, I have already thought of whether it needs to free after the
> devm_kzalloc().
> As we can find in the gbaudio_tplg_create_widget(), the widget_kctls is
> allocated by devm_kzalloc(), but isn't released when
> gbaudio_tplg_create_wcontrol() fails and goto error.
> And I check of the comment of the devm_kmalloc() in `drivers/base/devres.c`,
> because devm_kzalloc() returns devm_kmalloc().
> And it says that "Memory allocated with this function is automatically
> freed on driver detach."
> So there is no need to free the memory manually.
> Is that right?

You are partially right, but you're missing something.  Yes, anything
allocated with devm_kzalloc() will be freed automatically when the
last reference to the device is dropped.

But the two places you're returning are in the middle of a loop (in 
gbaudio_tplg_create_widget() and gbaudio_tplg_process_kcontrols()).
Each is building up a sort of hierarchical data structure, and as
you can see, the existing code takes care to de-construct the partially
built structure in the event an error occurs before it completes.

There is a chance that your simple return would "work", but by
reading the surrounding code you should recognize that the proper
way to handle the error is to jump to the cleanup at the end.

The other alternative would be to fix those functions so they
don't do that controlled cleanup on error and simply return
early (as you were proposing).  But without digging deeper, I
would assume the original developers designed it this way
very intentionally, because it avoids a problem somewhere.

					-Alex

> And I am sorry again because of the lack of the above explanation in my
> commit message.
> I will also add to my new commit.
> 
> Thanks,
> Jiang
> 

