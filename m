Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD6C4ADD41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381476AbiBHPpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbiBHPpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:45:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54823C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644335106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5c6BokZGpjxZJfiqo2/4IGY86UdM0DHCzeepgSZdBO4=;
        b=gmcMstuU52ZwnCV68nKfxM/TPV7A5LTxiBexqgoPJGBR2reUmzj+gRGEIMVdjusLn3TrOc
        DNFNxv9qYKcsr58o4vbWvcTpndXBi43KJxTisHHI27TIBynhmYIwXqvvfSur6FnsC2L2la
        w86SF5X6qKq1rBU23luRO4jSM0S0M54=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-4lDkcB_5NYykzZO5OFEJhQ-1; Tue, 08 Feb 2022 10:45:05 -0500
X-MC-Unique: 4lDkcB_5NYykzZO5OFEJhQ-1
Received: by mail-qk1-f199.google.com with SMTP id b204-20020a3767d5000000b004b2a0d2e930so11167264qkc.15
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 07:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5c6BokZGpjxZJfiqo2/4IGY86UdM0DHCzeepgSZdBO4=;
        b=J0tRp14j6EaxKybkvpku8UgN3lCL/Did8X4mrGey9HN5gpVIXCbAsR8YaQ3Q6BA7bw
         mQLMJbc9vJjQF4IK0o6FL8wjE5yqetBoL4dP/UqZlwJIinp5a6wo2RZm5KVrRD6uzgfK
         uOG6Vt12p7zqJZsk5IeB7fs+UOZ4wynjgY1gxX2CjAfZZ8wG7dWZX4X+gmFoiv7Hkwo8
         JC1yDt4LjE/sBpmsl07L2OnheAcccVhI9hs14OOiVNa7Hm//MuRGuwRA7bTA5Nvvxa6g
         kHZdT8dlyZ/pj8y/VuAB6y6NATr+UGsOFvE922xZ/HbGLxbvQeJ3xRa2wXL1ca0gvHcl
         othw==
X-Gm-Message-State: AOAM5320o/4vcDlMBZgQMZQKcpTQ63q+PzcwpPvmYLVdpTd9Rrrb+gtw
        vEZRwWkbbCv4UWGzYv95J0U7hMwRmO3VPigb49Ux5ePlKEEHyYlbnA9wsyA+5YIZEBEvxH2MI4y
        tzGmtDn348llHmIXjwLi/7keB
X-Received: by 2002:a05:620a:1a82:: with SMTP id bl2mr2924990qkb.360.1644335104014;
        Tue, 08 Feb 2022 07:45:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPdAD8h7XP4irSwKpgb8bE8kYshYN6EWQP1VYm2uzSHInxS6E2UNAok247/mFO4RH8j4wVOg==
X-Received: by 2002:a05:620a:1a82:: with SMTP id bl2mr2924977qkb.360.1644335103780;
        Tue, 08 Feb 2022 07:45:03 -0800 (PST)
Received: from [192.168.1.9] (pool-68-163-101-245.bstnma.fios.verizon.net. [68.163.101.245])
        by smtp.gmail.com with ESMTPSA id 5sm7649569qtp.81.2022.02.08.07.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 07:45:03 -0800 (PST)
Subject: Re: [PATCH v2] livepatch: Skip livepatch tests if ftrace cannot be
 configured
To:     David Vernet <void@manifault.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        pmladek@suse.com, jikos@kernel.org, mbenes@suse.cz, corbet@lwn.net
Cc:     kernel-team@fb.com
References: <20220203233205.1554034-1-void@manifault.com>
 <20220204205625.2628328-1-void@manifault.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <89a430e9-6da4-761a-68aa-187a3faa9c53@redhat.com>
Date:   Tue, 8 Feb 2022 10:45:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220204205625.2628328-1-void@manifault.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 3:56 PM, David Vernet wrote:
> livepatch has a set of selftests that are used to validate the behavior of
> the livepatching subsystem.  One of the testcases in the livepatch
> testsuite is test-ftrace.sh, which among other things, validates that
> livepatching gracefully fails when ftrace is disabled.  In the event that
> ftrace cannot be disabled using 'sysctl kernel.ftrace_enabled=0', the test
> will fail later due to it unexpectedly successfully loading the
> test_klp_livepatch module.
> 
> While the livepatch selftests are careful to remove any of the livepatch
> test modules between testcases to avoid this situation, ftrace may still
> fail to be disabled if another trace is active on the system that was
> enabled with FTRACE_OPS_FL_PERMANENT.  For example, any active BPF programs
> that use trampolines will cause this test to fail due to the trampoline
> being implemented with register_ftrace_direct().  The following is an
> example of such a trace:
> 
> tcp_drop (1) R I D      tramp: ftrace_regs_caller+0x0/0x58
> (call_direct_funcs+0x0/0x30)
>         direct-->bpf_trampoline_6442550536_0+0x0/0x1000
> 
> In order to make the test more resilient to system state that is out of its
> control, this patch adds a check to set_ftrace_enabled() to skip the tests
> if the sysctl invocation fails.
> 
> Signed-off-by: David Vernet <void@manifault.com>
> ---
> v2:
>   - Fix typo in newly added comment (s/permament/permanent).
>   - Adjust the location of the added newline to be before the new comment
>     rather than that the end of the function.
>   - Make the failure-path check a bit less brittle by checking for the
>     exact expected string, rather than specifically for "Device or resource
>     busy".
> 
>  tools/testing/selftests/livepatch/functions.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 846c7ed71556..32970324dd7e 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -78,6 +78,12 @@ function set_ftrace_enabled() {
>  	result=$(sysctl -q kernel.ftrace_enabled="$1" 2>&1 && \
>  		 sysctl kernel.ftrace_enabled 2>&1)
>  	echo "livepatch: $result" > /dev/kmsg
> +
> +	# Skip the test if ftrace is busy.  This can happen under normal system
> +	# conditions if a trace is marked as permanent.
> +	if [[ "$result" != "kernel.ftrace_enabled = $1" ]]; then
> +		skip "failed to set kernel.ftrace_enabled=$1"
> +	fi
>  }
>  
>  function cleanup() {
> 

Thanks for updating.

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- 
Joe

