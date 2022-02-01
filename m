Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75444A62BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbiBARm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiBARmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:42:23 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5379C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:42:22 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id z4so14942316ilz.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TbofYnmW7Q1DU8mxaNUiRYYGn47K1Mg8D9USFBKEYzg=;
        b=HbQ4SZuXJIAGjjXdI2Nk0AsZIgGG6Y+wRTfAykFdXQ5TMwUavntyG5R7XTRD1kIS7e
         cu2Iog9ZiVXuODYD0fP9FgdPM02q3gbdA0rrJWdVfvZZ3etGbvMnFRbiPPG1sNABMNHS
         vm1U1lEry6EZeE2JYOrI/OGMph9AX4LWPu2Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TbofYnmW7Q1DU8mxaNUiRYYGn47K1Mg8D9USFBKEYzg=;
        b=XNrPFW2wK1zgR57GQ6WXIcaXd+kUH6gCZXOgsL5408pqoVhmFS5zhfkr/y2qsLoO12
         24vuYzpL0ygBTAmKAcqYKVxwYRm2KZs3/6YvZd9b82hW5iMjgyd3PzuHuaQdj7isSmQW
         Wb8pA6WtqLt+97kAtCO7H7hnWTHkEBMnyL4HRkdN9py7dAD8QpCooCyUtZipqfVWEc7t
         2W6z+G/DIeyBk/1h95hg8ktzwePdhQUG0HgttpgHi3zhe1uSOtYjv3pe8O8ZAoKhgC1b
         o50U6rDgKauCdQGiHEkUIVfCqeMVTxEcIko2LVLeyqwU86amDTNeDG51tqd34WOY6o+P
         stSA==
X-Gm-Message-State: AOAM530y41kU3C4TMnxIdBzU4GLxQD/nOk8ZE2P6pX3MsleiJAiYP+2R
        PsN93PZp3McyG4CpLkqxovDEsw==
X-Google-Smtp-Source: ABdhPJzODd6mgGSdglYLa9tBLMw//6GUqSUDsD+eyHfUN/CEQ5ToyT/kwInBKZfa0luSerNjA2r8OQ==
X-Received: by 2002:a05:6e02:2184:: with SMTP id j4mr134502ila.304.1643737342067;
        Tue, 01 Feb 2022 09:42:22 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g19sm8710128ilk.30.2022.02.01.09.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 09:42:21 -0800 (PST)
Subject: Re: [PATCH] selftests/ir: fix build with ancient kernel headers
To:     Sean Young <sean@mess.org>, Matthew Wilcox <willy@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220128075346.GG8421@xsang-OptiPlex-9020>
 <YfO39Q3mNHMQOkd4@gofer.mess.org>
 <CAADnVQJ3RCPUQ0k9nu2urrRK=U7SUetuPmY0_b17M_PD=j4fkw@mail.gmail.com>
 <e5b72f09-a208-a579-3e51-10935ccee1ff@linuxfoundation.org>
 <YfQqI2ryOYEDuvON@gofer.mess.org>
 <347bae9f-f775-4976-3d27-b0c725211d78@linuxfoundation.org>
 <YflldzHZPVK3OQRJ@gofer.mess.org> <YflmyHrYg1xJlW0u@casper.infradead.org>
 <YflpnYECZE2Kxh+V@gofer.mess.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bb937121-64e4-ea34-e97b-a555ba283a5d@linuxfoundation.org>
Date:   Tue, 1 Feb 2022 10:42:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YflpnYECZE2Kxh+V@gofer.mess.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 10:10 AM, Sean Young wrote:
> On Tue, Feb 01, 2022 at 04:58:48PM +0000, Matthew Wilcox wrote:
>> On Tue, Feb 01, 2022 at 04:53:11PM +0000, Sean Young wrote:
>>> +/* Support ancient lirc.h which does not have these values */
>>
>> Can we have a little more information here, such as "Can be removed once
>> RHEL 8 is no longer a relevant testing platform"?  That will save people
>> doing archaology to find out when it's safe to remove.
> 
> That totally makes sense.
> 
> Having said that, I have no idea what platforms are being used for testing,
> so I don't know if RHEL 8 is the only one that needs this. Is there anyone
> who could shed some light on what platforms should be supported?
> 
> Thanks,
> 
> Sean
> 

Sean,

It isn't important on platforms that get tested. We really don't have much
control over the platforms these tests get run.

Let's add a FIXME to remove and also add link to the kbuild thread where with
the discussion.

I am assuming this has to go through bpf since it fixes the commit already
in that tree:

With the change Matthew requested,

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Or I can take this through my tree.

thanks,
-- SHuah

