Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B464BA901
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244849AbiBQS6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:58:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244739AbiBQS6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:58:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785287F6DF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=3c8gsxVyshN7DNqcUKV3eYIjofR6fuN2OJG+/j462X4=; b=O1RHzOSfz8BykUwE/Rt/ZP3lIN
        6yLuD4PdBfEcUjz+pW8l4/jT+mavv9XZ828Gt+wKExJgHae6q2ljeaxOfL3EiWKsqOUnPXNGHqLVh
        LNKCHSNTE2OzqsuQXkafaxWnCl5RwFvFeHVw2AtNEFxAL6/Sc5TU89P5T09QSEFsW9L5m5zuiyajM
        b2ITsYXS8kyXQAjaiUhxcZKy3TMsH1MYl3OaYF+Drobe5RQuwjr02j94tqn7ZkLAcJfkdiR1b/08p
        cu87MB2/VHNed3dRQERmAsJTGOhCVqc5KvLecCXECprc945u9wgBnQNeWuz565lDtTOkw3MBMW46+
        x5AbVtSA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKlyk-00FrsG-U5; Thu, 17 Feb 2022 18:58:12 +0000
Message-ID: <4f00105a-2f21-852f-d7c2-1aaf11fa3e74@infradead.org>
Date:   Thu, 17 Feb 2022 10:58:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] NDS32: perf_event_cpu: fix 2 build errors
Content-Language: en-US
To:     Greentime Hu <green.hu@gmail.com>, Alan Kao <alankao@andestech.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nickhu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>, kclin@andestech.com
References: <20210926055817.24352-1-rdunlap@infradead.org>
 <CAEbi=3dmw4nTkU1cF4atXDE6Go-tujqseRKjdX7rmPaid_3D3w@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAEbi=3dmw4nTkU1cF4atXDE6Go-tujqseRKjdX7rmPaid_3D3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 9/27/21 03:06, Greentime Hu wrote:
> Randy Dunlap <rdunlap@infradead.org> 於 2021年9月26日 週日 下午1:58寫道：
>>
>> ../arch/nds32/kernel/perf_event_cpu.c: In function 'unwind_frame_kernel':
>> ../arch/nds32/include/asm/current.h:10:13: error: '$r25' undeclared (first use in this function)
>>    10 | #define tsk $r25
>> ../arch/nds32/kernel/perf_event_cpu.c:1255:50: note: in expansion of macro 'tsk'
>>  1255 |                                                 (tsk, &graph, frame->lp, NULL);
>>
>> ../arch/nds32/kernel/perf_event_cpu.c:1257:27: error: assignment to 'long unsigned int' from 'long unsigned int *' makes integer from pointer without a cast [-Werror=int-conversion]
>>  1257 |                 frame->sp = ((unsigned long *)frame->sp) + 1;
>>
>> For $r25, use the register function for current() instead.
>>
>> Fixes: c8b34461705e ("nds32: Add perf call-graph support.")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Nickhu <nickhu@andestech.com>
>> Cc: Greentime Hu <green.hu@gmail.com>
>> Cc: Vincent Chen <deanbo422@gmail.com>
>> ---
>> Please check the frame->sp cast/arithmetic.
>>
>>  arch/nds32/kernel/perf_event_cpu.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- linux-next-20210917.orig/arch/nds32/kernel/perf_event_cpu.c
>> +++ linux-next-20210917/arch/nds32/kernel/perf_event_cpu.c
>> @@ -1252,9 +1252,9 @@ static int unwind_frame_kernel(struct st
>>                  */
>>                 if (__kernel_text_address(frame->lp))
>>                         frame->lp = ftrace_graph_ret_addr
>> -                                               (tsk, &graph, frame->lp, NULL);
>> +                                       (current, &graph, frame->lp, NULL);
>>
>> -               frame->sp = ((unsigned long *)frame->sp) + 1;
>> +               frame->sp = (unsigned long)(((unsigned long *)frame->sp)) + 1;
>>
>>                 return 0;
>>         } else {
> 
> Loop in Alan and KC.

Ping.  Does anybody care?

-- 
~Randy
