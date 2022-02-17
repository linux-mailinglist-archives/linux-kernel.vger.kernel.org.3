Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5064B9622
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 03:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiBQC4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 21:56:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiBQC43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 21:56:29 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752BA2A82F1;
        Wed, 16 Feb 2022 18:56:16 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m7so4309276pjk.0;
        Wed, 16 Feb 2022 18:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VCg3RHLInrgniOKILMGbojNoMCIaEL/WD2F2sir3AnY=;
        b=G6BPBHytOnGUDNYwcKVMuQZrwWXgLg0zrVx63/qTFaZNkPZetO0kgU0rajqYZYfLHX
         PRoUePZn1egnj5dsf/rFHbuUjNhrvfss0grV5F2egsoKP8Fprqoz9uaPnKSPY05rOhUS
         pKCUlnUYhBWa8NBoRghg9fqIdxm5GoukuzsODHQlKjibVxIIhQ1b7bZKbg3wqs5GAuwt
         laTOsPEr0ALYGfRL0HoPXTquFefDqanPyD6AjxvEV/rRuiPkaMhH93XWQxfZ1o2bD1RT
         ep0H9pZon3uc57t1iBuZbBXQda9Xev0x0W2qzYuxYCvicPxj317JlDX7PCsGBIsMGuBc
         wAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VCg3RHLInrgniOKILMGbojNoMCIaEL/WD2F2sir3AnY=;
        b=qaoOpOrchErJ7BJKHz41eNAN4sS+MjiL1CkmeipurpQCqEyhHmx9ou4w0RdL9iE2Ab
         osFB+1dQgEoGlP6inivPFSFKBu3TRnMOroqZszcfCFpGUpjYoYQBxWwTEzS/9ISA0rVu
         TMU1aNKYIH46WgSItAnR4QiqUnvSIRKO8byV3/DENNlhPy0MLEiLaqgYoPtoxkmUWfB6
         kXwnhXkfkLKNyC8ny3cecEPPDCykgMDZ+wDa5G0l1552gOWjdU9UGLtl67eKuQbD2LC8
         aMOz6dYSMzsO3NAY0yFhPT87ANabymFT4QGOK5JqMSPEP86FWVuHGKl3nT2u8h00AWk5
         SSQg==
X-Gm-Message-State: AOAM530MKo6plyQim4AlsRiBmJLUIFfr2gPHgpPF+PjoKyNb9GwWFP8R
        oDJx4HUMfHlGl2Tj7MCh9Bg=
X-Google-Smtp-Source: ABdhPJyrrssLYNNC6H1c42LMnZd0TAGyNf2ernvHSYQuWo/ZJNcxBjkTpUSzyNpZgKd5rEBB39yKJA==
X-Received: by 2002:a17:90b:b16:b0:1b9:eef:1690 with SMTP id bf22-20020a17090b0b1600b001b90eef1690mr907858pjb.9.1645066575993;
        Wed, 16 Feb 2022 18:56:15 -0800 (PST)
Received: from [172.20.119.15] ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id s5sm7042020pfd.66.2022.02.16.18.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 18:56:15 -0800 (PST)
Message-ID: <8b358115-67c6-c76a-b0ca-5c44c79218e7@gmail.com>
Date:   Thu, 17 Feb 2022 10:56:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [RFC V2 5/6] blk-ioprio: make ioprio pluggable and modular
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     hch@infradead.org, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220215123705.58968-1-jianchao.wan9@gmail.com>
 <20220215123705.58968-6-jianchao.wan9@gmail.com>
 <cb5677fc-01ac-f97f-ccf8-eb91505ad0e3@acm.org>
 <0608cd82-89c6-8fba-d06b-fdef9c53114f@gmail.com>
 <306b80f7-1185-17b8-fb85-7241823681d0@acm.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <306b80f7-1185-17b8-fb85-7241823681d0@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/17 2:01 上午, Bart Van Assche wrote:
> On 2/15/22 18:09, Wang Jianchao wrote:
>> On 2022/2/16 5:26 上午, Bart Van Assche wrote:
>>> On 2/15/22 04:37, Wang Jianchao (Kuaishou) wrote:
>>>> diff --git a/block/Makefile b/block/Makefile
>>>> index f38eaa612929..f6a3995af285 100644
>>>> --- a/block/Makefile
>>>> +++ b/block/Makefile
>>>> @@ -17,7 +17,8 @@ obj-$(CONFIG_BLK_DEV_BSGLIB)    += bsg-lib.o
>>>>    obj-$(CONFIG_BLK_CGROUP)    += blk-cgroup.o
>>>>    obj-$(CONFIG_BLK_CGROUP_RWSTAT)    += blk-cgroup-rwstat.o
>>>>    obj-$(CONFIG_BLK_DEV_THROTTLING)    += blk-throttle.o
>>>> -obj-$(CONFIG_BLK_CGROUP_IOPRIO)    += blk-ioprio.o
>>>> +io-prio-y             := blk-ioprio.o
>>>> +obj-$(CONFIG_BLK_CGROUP_IOPRIO)    += io-prio.o
>>>>    obj-$(CONFIG_BLK_CGROUP_IOLATENCY)    += blk-iolatency.o
>>>>    obj-$(CONFIG_BLK_CGROUP_IOCOST)    += blk-iocost.o
>>>>    obj-$(CONFIG_MQ_IOSCHED_DEADLINE)    += mq-deadline.o
>>>
>>> Is the above change really necessary?
>>
>> Except for making maintaining easier on a running system, removing a
>> rqos policy module with cgroup supporting can release a blk-cgroup
>> policy slots. As BLKCG_MAX_POLS, the max slots number is fixed now.
> 
> It seems like my question was not clear? What I meant is that I think that the above changes are not necessary to build blk-ioprio as a kernel module.
> 
Thanks so much for your kindly remind. I have changed it.

Regards
Jianchao

