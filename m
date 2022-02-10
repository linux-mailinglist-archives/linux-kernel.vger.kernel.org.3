Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618B44B1750
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344462AbiBJU64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:58:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbiBJU6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:58:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4226310C7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644526733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6HK/9k42GpK+Chu2BcWz3QlGtWwq6ZH1W+j7L7glwU4=;
        b=UxC3Pk10+X2GrwYaxu8unb+J4rVWf+icBLpvVz9OCk1R8u0ru6+VmEJL0n7zLax4Ov63O4
        gSYrQlWGIjSC5ABC1xq610vcgy0DW6nrro6oYStV+68a0FV0ru79OMf+d4Xvhr0wqDevrr
        66yqakzqR7rm4PSMgjqNo1gsn25VfII=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-0KpwEXuxNrOYWi9jW63S3Q-1; Thu, 10 Feb 2022 15:58:52 -0500
X-MC-Unique: 0KpwEXuxNrOYWi9jW63S3Q-1
Received: by mail-qv1-f69.google.com with SMTP id hu9-20020a056214234900b0042c4017aeb3so2104811qvb.14
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6HK/9k42GpK+Chu2BcWz3QlGtWwq6ZH1W+j7L7glwU4=;
        b=SWtwzJXQwNPAOdtOTawcIedRue98jLQBX9Umd2jQkJ/Y4fmcm3hVTRxXtuwssRYhks
         cnTiZJHMSVguiUugJ72hlMKbyRaxt5+k8cf2AnJAMjQAv3WQc30tieexhmah7eZPamW4
         ZocSQm5VVPBLJ4zdz8V+LdQ8pqzhe84oEAO14xUgBpnbamDFJ3FUQMkQL7L0oDf8LcFD
         hrr1PjUSoX8mjK9x7WZuCmQhklinnIrYXBOKM+g5m+vSx00Q5aaT6txc96LCGBF1PR8m
         NdQnLzfaeXfcwXSgSEq0pdYiSbtTlWBSao8qNJ9z3DWs4LgnbiskGUxtBbMBEt0iOJ9z
         kqww==
X-Gm-Message-State: AOAM5336eR4XjW3Ww4EcyjzKqo5V9va0Cvge0yLGb381hdO6O7ypiYLG
        hRMayQkfXUkYl85mPyRCoKqajOc3MIj8adqxu/4uEUNCjHg0etjOUyy5BgJOZH3oqm8ok4kzjYr
        gg9ULUFUAh/JX7HoTHHZsncuq
X-Received: by 2002:a05:6214:411a:: with SMTP id kc26mr6282778qvb.59.1644526731730;
        Thu, 10 Feb 2022 12:58:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3JxCUvNIl202KXU+WzC3uWG5SbUYl2jkfI6P2oqbnBorU95lsRyTfruoritxDsCxMTAJFhw==
X-Received: by 2002:a05:6214:411a:: with SMTP id kc26mr6282772qvb.59.1644526731439;
        Thu, 10 Feb 2022 12:58:51 -0800 (PST)
Received: from [192.168.1.9] (pool-68-163-101-245.bstnma.fios.verizon.net. [68.163.101.245])
        by smtp.gmail.com with ESMTPSA id m130sm10111786qke.55.2022.02.10.12.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 12:58:50 -0800 (PST)
To:     David Vernet <void@manifault.com>, Petr Mladek <pmladek@suse.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        corbet@lwn.net, kernel-team@fb.com
References: <20220203233205.1554034-1-void@manifault.com>
 <20220204205625.2628328-1-void@manifault.com>
 <20220209130233.GB8279@pathway.suse.cz>
 <20220209154934.5w5k5tqcqldbfjt3@dev0025.ash9.facebook.com>
 <YgUt4+XGLOB4+0H3@alley>
 <20220210162215.oupcqlcglfpeqkbp@dev0025.ash9.facebook.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2] livepatch: Skip livepatch tests if ftrace cannot be
 configured
Message-ID: <17674ab3-897d-3760-d86a-f89b5c0f1257@redhat.com>
Date:   Thu, 10 Feb 2022 15:58:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220210162215.oupcqlcglfpeqkbp@dev0025.ash9.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for not catching this in v2. I think Petr's approach is pretty
reasonable, a few comments below.

On 2/10/22 11:22 AM, David Vernet wrote:
> On Thu, Feb 10, 2022 at 04:23:15PM +0100, Petr Mladek wrote:
>> OK, what about the following change:
>>
>>    1. Store only the value (number) in $result
>>    2. Add optional --fail parameter
> 
> I'm fine with this approach. I agree that it's probably less confusing than
> "$2" == "$1". I don't think the elif check I proposed is strictly necessary
> either, and in any case the way you've rewired the patch address that.
> 
>>
>> Hmm, the 1st step is not needed after several iterations here ;-)
>> Anyway, it should be easier to maintain it in the long term when the
>> sysctl output might change. We should probably do it in a separate patch.
>>
>>
>> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
>> index 846c7ed71556..7b624d0fd7c0 100644
>> --- a/tools/testing/selftests/livepatch/functions.sh
>> +++ b/tools/testing/selftests/livepatch/functions.sh
>> @@ -75,9 +75,25 @@ function set_dynamic_debug() {
>>  }
>>  
>>  function set_ftrace_enabled() {
>> -	result=$(sysctl -q kernel.ftrace_enabled="$1" 2>&1 && \
>> -		 sysctl kernel.ftrace_enabled 2>&1)
>> -	echo "livepatch: $result" > /dev/kmsg
>> +	can_fail=0

nit: I don't think the script is entirely consistent w/local variables, but:

local can_fail=0

> 
> Can you make this variable a local?
> 
>> +	if [[ "$1" == "--fail" ]] ; then
>> +		can_fail=1
>> +		shift
>> +	fi
>> +
>> +	err=$(sysctl -q kernel.ftrace_enabled="$1" 2>&1)
>> +	result=$(sysctl --values kernel.ftrace_enabled)

nit: likewise, local err and result variables.

>> +
>> +	if [[ "$result" != "$1" ]] ; then
>> +		if [[ $can_fail -eq 1 ]] ; then
>> +			echo "livepatch: $err" > /dev/kmsg
>> +			return
>> +		fi
>> +
>> +		skip "failed to set kernel.ftrace_enabled = $1"

Unexpected failure: If the caller doesn't want this to fail but it does,
would it be helpful to report the original $err, too?  IIUC, the
original code captured that in $result.

>> +	fi
>> +

Unexpected success: Inversely, if the caller expects failure, but it
actually succeeds, I think this version only reports the new value, right?

In the case of the 2nd "set_ftrace_enabled 0" in test-ftrace.sh, that
turns out to be OK since it follows up with verifying that livepatch
redirection is still in effect.

Maybe this is too paranoid?  Just thought I'd mentioned it.

Thanks,

--
Joe

>> +	echo "livepatch: kernel.ftrace_enabled = $result" > /dev/kmsg
>>  }
>>  
>>  function cleanup() {
>> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
>> index 552e165512f4..825540a5194d 100755
>> --- a/tools/testing/selftests/livepatch/test-ftrace.sh
>> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
>> @@ -25,7 +25,8 @@ if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]]
>>  	die "livepatch kselftest(s) failed"
>>  fi
>>  
>> -set_ftrace_enabled 0
>> +# Check that ftrace could not get disabled when a livepatch is enabled
>> +set_ftrace_enabled --fail 0
>>  if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
>>  	echo -e "FAIL\n\n"
>>  	die "livepatch kselftest(s) failed"
> 
> Patch looks great otherwise and works fine after testing on my end. Do you
> want me to send it out as a v3? Or would you prefer to just apply it as is?
> Assuming it's the latter, then:
> 
> Reviewed-by: David Vernet <void@manifault.com>
> 

