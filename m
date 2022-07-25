Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B9F5801C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbiGYPXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbiGYPXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:23:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C5D10B;
        Mon, 25 Jul 2022 08:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90AADB80EAF;
        Mon, 25 Jul 2022 15:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B70C341C6;
        Mon, 25 Jul 2022 15:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658762559;
        bh=LnsVxq5NLSX1iQ3ZqaZEdR1nH0pMz9DMkcibmIg8Am8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MfW+2Pdv+xv/8Z3kqWpr4cEwGJ8pzDPDQ+IVLAFz5fCSiw1LvTOL4I9ONq13qt5oL
         Ejfq9BQ+iYc+VB2XcNx6kEWdlRzGB3Chlw1HPczWO9RlZeuO6Fr5BLNM7LxkRF9azY
         KXSRDuwc8O1M6jPXzhM+DJufpHLveOSYMyPJyxYj1T/v8WC40feIFP5OOfDDAdc6ZW
         mPBb+TIAqa/2ZmqhnltaQd730SlBn4Zko1qE+RrdKlnKpPO4f8UBpnj7rKH4lBXMSt
         Q+D6aDBO94QST37SxYV/VWxbdtplHfT3oQjt3qtylQKHDkVB5KLCb5JCWwW+W2VXv3
         EEzws/6DCGqVw==
Message-ID: <3cf60868-fb3b-54cd-2177-09c4827e75e7@kernel.org>
Date:   Mon, 25 Jul 2022 17:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] rtla: fix double free
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Andreas Schwab <schwab@suse.de>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <mvmzggxl4n1.fsf@suse.de>
 <fd0888a4-099c-95fe-7e20-82be1489061f@kernel.org> <mvmv8rll2yn.fsf@suse.de>
 <20220725105639.295a7d7d@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220725105639.295a7d7d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/22 16:56, Steven Rostedt wrote:
> On Mon, 25 Jul 2022 15:46:40 +0200
> Andreas Schwab <schwab@suse.de> wrote:
> 
>> On Jul 25 2022, Daniel Bristot de Oliveira wrote:
>>
>>> Hi Andreas
>>>
>>> On 7/25/22 15:10, Andreas Schwab wrote:  
>>>> Don't call trace_instance_destroy in trace_instance_init when it fails,
>>>> this is done by the caller.  
>>>
>>> Regarding the Subject, are you seeing a double-free error, or it is just an
>>> optimization?  
>>
>> A double free nowadays is almost always an error, due to better malloc
>> checking.
>>
>>> AFAICS, trace_instance_destroy() checks the pointers before calling free().  
>>
>> That doesn't help when the pointer is not cleared afterwards.  Do you
>> prefer that?
>>
>>> Why am I asking? because if it is a double-free bug, we need to add the "Fixes:"
>>> tag,  
>>
>> It's the first time I tried running rtla, so I don't know whether it is
>> a regression, but from looking at the history it appears to have been
>> introduced already in commit 0605bf009f18 ("rtla: Add osnoise tool")
>>
> 
> I think the real fix is to make trace_instance_destroy() be able to be
> called more than once.
> 
> void trace_instance_destroy(struct trace_instance *trace)
> {
>         if (trace->inst) {
>                 disable_tracer(trace->inst);
>                 destroy_instance(trace->inst);
> 		trace->inst = NULL
ah! right, it was missing this... ^^^
-- Daniel
