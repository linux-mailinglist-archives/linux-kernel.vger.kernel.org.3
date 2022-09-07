Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E565B103F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiIGXNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIGXM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:12:59 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D297FA50F5;
        Wed,  7 Sep 2022 16:12:58 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so467623pjq.3;
        Wed, 07 Sep 2022 16:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+mAH+RQ3OE7PV+wLNUVMSP/CMxHD/ZzKpKBm8PFhiYw=;
        b=bvbQscssYgcGX0Mwdcemta8vHhr/rtY25iDICORTf1cV9mHND0YV+DjPxTU4+lUF95
         lrEKdU0zohIuq/0DKcf1I3DN03jdph/XuQ+aeW+q3z+CvpnSoLt0WoOIkC0Q7kzjQw/s
         H/JAOVWqL4kdgLQwyN/Wb0Q6OTIK0dJYdYnLI6wfGSe6KTwpMQMAgQCc343AGlSLQGgp
         Iutp54AYwazl9RAATMFt8F7ivudiy8IOjAgNqzetP0pBgxUzjren9df5PkycogMbErRn
         2W97USZEq1TvcZ9jIFs+EDLEyIdnmFAW2YElQkTj3ChsuFKo2vM6WJxtiRwz6Dk3mCSE
         lNAQ==
X-Gm-Message-State: ACgBeo28umxb+BsncK2IXWBvGF0CpBMghhxI1422CYTb7RNV02cAFAWf
        p6M2D4Q2DWwuVjHNaYRXxZc=
X-Google-Smtp-Source: AA6agR6Bl1mXUO2jFKiEOfk2ABAs7Bo70cNFHlgrwf+rv5PVWu0KSqwGfe39hPQ07RCwGHvOhQTuzg==
X-Received: by 2002:a17:902:8c93:b0:172:bb10:214c with SMTP id t19-20020a1709028c9300b00172bb10214cmr6354897plo.135.1662592378191;
        Wed, 07 Sep 2022 16:12:58 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:71db:3cdf:3590:2e95? ([2620:15c:211:201:71db:3cdf:3590:2e95])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b00172ad9674e5sm12825359plp.291.2022.09.07.16.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 16:12:57 -0700 (PDT)
Message-ID: <c3dc1171-a625-a84a-e2be-a71e5cbbe97a@acm.org>
Date:   Wed, 7 Sep 2022 16:12:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [EXT] Re: [PATCH v2 1/1] tracing: Fix compile error in
 trace_array calls when TRACING is disabled
Content-Language: en-US
To:     Arun Easi <aeasi@marvell.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com
References: <20220907185745.14382-1-aeasi@marvell.com>
 <20220907185745.14382-2-aeasi@marvell.com>
 <60870376-3518-896b-7a6b-a4b9ea05264f@acm.org>
 <32dee739-58fb-e371-2808-d40a2ee90ee0@marvell.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <32dee739-58fb-e371-2808-d40a2ee90ee0@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 15:52, Arun Easi wrote:
> On Wed, 7 Sep 2022, 12:27pm, Bart Van Assche wrote:
>>> +static inline int
>>> +trace_array_printk(struct trace_array *tr, unsigned long ip,
>>> +		       const char *fmt, ...)
>>
>> This is not the recommended way to format a function definition.
> 
> That was mostly a Y&P from the prototype earlier in the file. Is it the
> linebreak after "int" you are referring to, or are there more?

In allmost all kernel code I have seen the function name is on the same 
line as the return type. Additionally, a common style is to align the 
second line with arguments with the opening parenthesis. From 
Documentation/process/coding-style.rst: "A very commonly used style
is to align descendants to a function open parenthesis."

>> Consider running git clang-format HEAD^.
> 
> It is a bit cryptic to me what it is complaining about (sorry
> clang-format newbie here):
> 
> # git clang-format -v HEAD^
> Running clang-format on the following files:
>      include/linux/trace.h
> YAML:671:20: error: unknown enumerated scalar
> SpaceBeforeParens: ControlStatementsExceptForEachMacros
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Error reading /root/aeasi/src/mkp.git/.clang-format: Invalid argument
> error: `clang-format -lines=29:30 -lines=51:84 include/linux/trace.h` failed
> 
> Perhaps my clang-tools are not recent enough.
> 
> # clang-format --version
> clang-format version 10.0.1 (Red Hat 10.0.1-1.module+el8.3.0+7459+90c24896)
> 
> Still digging..

git clang-format HEAD^ reformats the topmost commit according to the 
rules in the .clang-format file in the top-level directory. Please 
review any changes made by that command before amending these to the 
original commit.

I think the error messages above indicate that your version of 
clang-format is too old.

Thanks,

Bart.
