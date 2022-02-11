Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E524B2CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345562AbiBKSWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:22:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiBKSWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:22:16 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E7513A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:22:15 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id w7so12456394ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hkbmDwYDwx2wqLp1lGX+KUQy10/X+s3WGM8MSf5ON1w=;
        b=MLe3n7egkgK2wBrAtLEGr+Wt/ZL1sIg9SQf8aNVVGD+I/3hGFM0Hmnm6wNIGY6BHGq
         NVCJhAuxKp13uT3mMVtTQ+4dC1Hh8herpbZyURBx8NY+xgXvZ7FB52vB8hWXa36uF+1g
         miFXtya38GqrY7ZX73/kNGpaF6e8tPPnPLV6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hkbmDwYDwx2wqLp1lGX+KUQy10/X+s3WGM8MSf5ON1w=;
        b=476m0E35OqtMXqvBI5LhGUKUnSUgQfGETN19q2T7S59+KD16FgrWKXz/ZklMFpegzH
         KVBqBO1s2CjH+ZRU5ICspCueY6ulnkFxS3YxchDe3T+8BnBLmRYXtwvKhw4Vkd4ss+V1
         l0h/a+Pz7l5SMkk7tNG87bzbXHfmvTAOqhmVmV2QwnZIWyJYDUcuTfsCh/VOvDqSXTSc
         HQAJUT0ZF9rRq9aOBz1AUmTsShc4S/RswKLynPKXnRreY4ik28aFMI2TvLuzuG/74RZN
         J0izAjU5mq1NkGIpMTsc7SvOQtVqdlI/psQz6f76D1q2Tb5Bf3GivRP5wQJ+lyyrXOfs
         bMxA==
X-Gm-Message-State: AOAM533PvfIA79VFiSKhT5mWh3+2m1lhtH7KcFT0JHya9V7lWOhtQGsn
        9u4//SIzhjKEIdwH9Y7rHGHrxw==
X-Google-Smtp-Source: ABdhPJyrmNlin/hQGqjCfsJoBD/NlkAK2Gahcqev8CYFJuBbz2hz/GxVSZdf6flskKaJVxNoaCW58Q==
X-Received: by 2002:a05:6638:1908:: with SMTP id p8mr1550656jal.282.1644603734444;
        Fri, 11 Feb 2022 10:22:14 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id i20sm3669740iov.46.2022.02.11.10.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 10:22:14 -0800 (PST)
Subject: Re: [PATCH 0/8] ucounts: RLIMIT_NPROC fixes
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Cc:     Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Linux Containers <containers@lists.linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220207121800.5079-1-mkoutny@suse.com>
 <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f0d686aa-3fad-afac-d377-f5d63111704a@linuxfoundation.org>
Date:   Fri, 11 Feb 2022 11:22:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 7:01 PM, Eric W. Biederman wrote:
> 
> Michal Koutný recently found some bugs in the enforcement of
> RLIMIT_NPROC in the recent ucount rlimit implementation.
> 
> I saw some additional bugs and some cleaner ways to fix the problem so
> instead of starting with his fixes these are my own.
> 
> I am aiming to send the first 5 of these to Linus once they have been
> reviewed.  Two more are fixes in principle but I don't think do anything
> in practice.  The last one is just a cleanup to prevent future
> divergence of RLIMIT_NPROC logic.
> 
> Eric W. Biederman (8):
>        ucounts: Fix RLIMIT_NPROC regression
>        ucounts: Fix set_cred_ucounts
>        ucounts: Fix and simplify RLIMIT_NPROC handling during setuid()+execve
>        ucounts: Only except the root user in init_user_ns from RLIMIT_NPROC

Should this be "Only exempt"?
  
>        ucounts: Handle wrapping in is_ucounts_overlimit
>        ucounts: Handle inc_rlimit_ucounts wrapping in fork
>        rlimit: For RLIMIT_NPROC test the child not the parent for capabilites
>        ucounts: Use the same code to enforce RLIMIT_NPROC in fork and exec
> 
>   fs/exec.c                    | 12 +++++-------
>   include/linux/sched.h        |  2 +-
>   include/linux/sched/signal.h |  2 ++
>   kernel/cred.c                | 24 +++++++++++-------------
>   kernel/fork.c                | 32 ++++++++++++++++++++++++--------
>   kernel/sys.c                 | 14 --------------
>   kernel/ucount.c              |  3 ++-
>   kernel/user_namespace.c      |  2 ++
>   8 files changed, 47 insertions(+), 44 deletions(-)
> 
> Eric
> 

Do we need updates to selftests - Michal's patch series included changes to
selftests/exec

thanks,
-- Shuah
