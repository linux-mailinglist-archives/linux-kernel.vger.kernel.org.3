Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F549BD75
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiAYUux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiAYUuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:50:51 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFC4C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:50:51 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id h30so17886046ila.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wgQdS4IzPtcda4TTBz0E+m3BUhmDwULpA1MzE+UZAmI=;
        b=KGrZvjplA+rHiodvaOUX7qiXtIkmnP5JmlbG2VWghfiIQcdb4f3J86vThDH7DmXMs+
         UweNN5AbNj6Q/7jed8B/yQFEpTK4o7mgIk1+70zep8n6F51N0mZ7Ay26n2bq4OG9kuvG
         fR4QWkUeVTv9SeecePhAItem583GwX85GWSSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wgQdS4IzPtcda4TTBz0E+m3BUhmDwULpA1MzE+UZAmI=;
        b=EL2j8kJeYYyPrEx81DUv4HiUZOEbmR5jgCq7U/SB6ILGlgH4ksTJy9rqSlD1TzVh9f
         C10eATnSYXXBa1QSWV6YhkMF7gaPjWdImzlPxe4oInYmxzrqebaxoODM7BzlXN+LpMzn
         WiyUXbMtYeDa7Ea6wYFMszyQ7gBPK3M4lrqLJIk1kQRiVXGQYm942TFYRZ8KoBQXL6eB
         8XrYYJicOcLobwiWywe9SVDkWJeUjIAciiHIFkYwZlYigwR/wPPrAhOAVMJ2jxn+zeJm
         GGANo19xEb0ZHjdLxNqcvnCo/D/VTTvLgC2W3prlJqvanjpiUtv0C5i1TH74A5dtRt5h
         f+kQ==
X-Gm-Message-State: AOAM532+oUF+Reeku1O8tQ60LbELmV/+kD4S2BiXjwP6tWW9RWJ+3tsy
        giaWGxD1oTpqR679TpjNTOOZKQ==
X-Google-Smtp-Source: ABdhPJzfwgpSR/C3UaofMecMsZe5O6qh5sb1gGWvN6CE4EK2w8MHzy0VILcusNJvymELTClctMV89w==
X-Received: by 2002:a05:6e02:184a:: with SMTP id b10mr9730445ilv.185.1643143850867;
        Tue, 25 Jan 2022 12:50:50 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:4ef8:d404:554b:9671? ([2601:282:8200:4c:4ef8:d404:554b:9671])
        by smtp.gmail.com with ESMTPSA id j6sm9584239ils.33.2022.01.25.12.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 12:50:50 -0800 (PST)
Subject: Re: [PATCH v2] kselftest: signal all child processes
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "christian@brauner.io" <christian@brauner.io>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     "wad@chromium.org" <wad@chromium.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211217092955.9472-1-lizhijian@cn.fujitsu.com>
 <196e8de7-d295-5bc0-66e1-f5d6433edbd2@fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <66e4dfaf-d447-789f-d2d6-5e0ad4426e66@linuxfoundation.org>
Date:   Tue, 25 Jan 2022 13:50:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <196e8de7-d295-5bc0-66e1-f5d6433edbd2@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/22 10:48 PM, lizhijian@fujitsu.com wrote:
> kindly ping
> 
> 
> On 17/12/2021 17:29, Li Zhijian wrote:
>> We have some many cases that will create child process as well, such as
>> pidfd_wait. Previously, we will signal/kill the parent process when it
>> is time out, but this signal will not be sent to its child process. In
>> such case, if child process doesn't terminate itself, ksefltest framework
>> will hang forever.
>>

Thank you for the patch. Applied to linux-kselftest fixes for rc2/3

thanks,
-- Shuah
