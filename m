Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7D346C860
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242675AbhLGXrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242668AbhLGXrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:47:43 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3BDC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:44:12 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id 15so664264ilq.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 15:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZVIAUOCqbGCNkkqxHzNddtZULMrSuZJINYUj3xGR98c=;
        b=YGpZcsgO2+Q7QT6Zvkx6nJIdeUihZ9kvVgD6BoFIN4Hx3AabhztUSB6Z5AdwgaPQXK
         +j9yzxNE8iBp6RtmOxz/sLW7C9jxjjYkJ707NZ+hTC+1PzPsdwuTTPFUt9poWTJTxwkl
         tKj/ojQsIMbzZR4SwXYcQ2OZLZo2JADna0id4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZVIAUOCqbGCNkkqxHzNddtZULMrSuZJINYUj3xGR98c=;
        b=hdV4mVtCiBeYXrIL1PYtFgO+kvvOVv1qyDKq4vx9a+jlGPqWZ/Aj15kPQtQ060WIFb
         kMGvmv8bY33g5sAtknu5uCvLfZYmMcv2uetFSF0jk199u2TykOBBRE/A20UbFYwRmyia
         Ta080IFQYFsfXtZ34STO4AFZsqzOzReEEao6nxtv6cqwwizwkY6H6WXrMj9ux1aZJbAR
         hVwfMhBXxjH9TH7aMRJ9qlBm7/LLxVdwgX07XEJTcGmD6y+Y/mNXt2tyEDC7nzcZ5vhZ
         maUZmFvA5rk/rrLgoTBfdGEVRDfT1TW/t/isvoEISOaKzEfMjom0U2KqpAIM2QIYs2cF
         fLIg==
X-Gm-Message-State: AOAM531lLvIJMIMyW/4ljyG9/AirxPBbhg+KdqPTOKC9DhNDiT1uDEnK
        flVzfTgXg52tCw5mkPORYcYISw==
X-Google-Smtp-Source: ABdhPJyOAGRG/113DT1qCsKGEE6vb7EGypJVHmr0LHZUxW6yyEJVm19ajveV9UD1s/v2fLUq6hgwSw==
X-Received: by 2002:a05:6e02:1c46:: with SMTP id d6mr2591932ilg.140.1638920652296;
        Tue, 07 Dec 2021 15:44:12 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b7sm727252iln.34.2021.12.07.15.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 15:44:11 -0800 (PST)
Subject: Re: [RFC PATCH v2] Documentation: dev-tools: Add KTAP specification
To:     Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>, Tim.Bird@sony.com,
        shuah@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211207190251.18426-1-davidgow@google.com>
 <202112071358.E8E6812D@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8c06e715-a83e-e8c6-74c3-836831b85cdf@linuxfoundation.org>
Date:   Tue, 7 Dec 2021 16:44:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202112071358.E8E6812D@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 3:02 PM, Kees Cook wrote:
> On Tue, Dec 07, 2021 at 11:02:51AM -0800, David Gow wrote:
>> From: Rae Moar <rmoar@google.com>
>>
>> It does not make any significant additions or changes other than those
>> already in use in the kernel: additional features can be added as they
>> become necessary and used.
>>
>> [1]: https://testanything.org/tap-version-13-specification.html
>>
>> Signed-off-by: Rae Moar <rmoar@google.com>
>> Co-developed-by: David Gow <davidgow@google.com>
>> Signed-off-by: David Gow <davidgow@google.com>
> 
> I like it! Thank you so much for suffering through my earlier reviews.
> :)
> 
> The only concern I have is wonder what'll be needed to kselftest to
> deal with indentation changes. As long as this can be implemented
> without a subtest knowing it is a subtest, we're good.
> 

A lot of this TAP output is in the wrappers - hopefully it will be okay.
Fingers crossed. :)

> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Looks good to me as well. Thanks for doing this work.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
