Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7980055C8B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbiF0TrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240725AbiF0TrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:47:02 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815741ADBA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:47:00 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 73-20020a9d084f000000b00616b04c7656so6819083oty.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sEyIMurSbUDEtnO4sXJJJqiGT9VfNu9mH5Y+RF1zXpM=;
        b=Q/XU92EvXKhdUFHYTfxhesbhCz0S+IitCXqbWL1lwG8PNxG+l+4SrGA2WOvu8Hdddc
         hxNASREKZON99TgF7gAIPDYD0ndh2+wavjuNnWpuUEeMootx4hkqjxKrR9TgklvfT9DF
         NCYJjTEFsfdWM9OZUdQ8BfTDKs6pNJBV7n3tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sEyIMurSbUDEtnO4sXJJJqiGT9VfNu9mH5Y+RF1zXpM=;
        b=oYrlovojCwRe66S8Yep6fH1p8TS3tVAzUUwcwKayy+6oFnyeXtKWWuL9/RZ9wEsQ4R
         cnD3BOizqnmdYMBXL63txM88cY0CTfESEM3VkOUjZRXV1whKXCcIrbZTR6hXCoBp52MJ
         cF4qxoDIiiAY653ko4VCCojaI3TlcCCpTdBqniExtFklH1KyZ+OueVyamR5r3IEPuhUE
         xh4YPUVr6yCtl99ybM64gWkeEPA8ZaDHowgxwuQncNIRQyH1c7fr9G2ZL4qm4oZRume1
         IU3v1PbNJtXJUol5+gaJQbPgfr/IOLF9zHKv3ffdR/R4dWPI7k8A+nkKkStd0l1EZawA
         hJqg==
X-Gm-Message-State: AJIora/FlsNzZX1+9i/0CZYlV2IzQIuiMt6RW44VBwb/azYxi5X8Fieq
        dv2k0+tjMlbUGI2whsNvfFeLRA==
X-Google-Smtp-Source: AGRyM1te5Bj88UBGJhxBv7OUhUu6rYyaYCShv/RM1GHQuJnIgZVd2AIbqFEHx30R36IqvOP82OnZBg==
X-Received: by 2002:a9d:76d0:0:b0:60b:53e5:6640 with SMTP id p16-20020a9d76d0000000b0060b53e56640mr6833397otl.241.1656359219758;
        Mon, 27 Jun 2022 12:46:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h9-20020a056830400900b00616a19aac0bsm6693195ots.51.2022.06.27.12.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 12:46:59 -0700 (PDT)
Subject: Re: [PATCH v4] kselftests/damon: add support for cases where debugfs
 cannot be read
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Gautam <gautammenghani201@gmail.com>, shuah@kernel.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220627185704.58902-1-sj38.park@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5708a2f6-4555-7bb3-4664-c33fe5b411b1@linuxfoundation.org>
Date:   Mon, 27 Jun 2022 13:46:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220627185704.58902-1-sj38.park@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 12:57 PM, SeongJae Park wrote:
> From: SeongJae Park <sj@kernel.org>
> 
> Hi Shuah,
> 
> On Mon, 27 Jun 2022 11:00:18 -0600 Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
> [...]
>>>> --- a/tools/testing/selftests/damon/_chk_dependency.sh
>>>> +++ b/tools/testing/selftests/damon/_chk_dependency.sh
>>>> @@ -26,3 +26,13 @@ do
>>>>    		exit 1
>>>>    	fi
>>>>    done
>>>> +
>>>> +permission_error="Operation not permitted"
>>>> +for f in attrs target_ids monitor_on
>>>> +do
>>>> +	status=$( cat "$DBGFS/$f" 2>&1 )
>>>> +	if [ "${status#*$permission_error}" != "$status" ]; then
>>>> +		echo "Permission for reading $DBGFS/$f denied; maybe secureboot enabled?"
>>
>> btw - does this run as a regular user or does it need root privilege?
>> If so add a test for that and skip with a message.
> 
> It needs the root permission, and does the check at the beginning[1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/damon/_chk_dependency.sh?h=v5.19-rc4#n9
> 
> 

Great. Thank you. I will pull this one in for linux-kselftest next
for Linux 5.20-rc1

thanks,
-- Shuah
