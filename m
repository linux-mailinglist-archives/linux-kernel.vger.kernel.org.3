Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C113B55FB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiF2JAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbiF2JAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:00:04 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F502559B;
        Wed, 29 Jun 2022 02:00:02 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:53108)
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jemarch@gnu.org>)
        id 1o6TYF-0005Kw-9z; Wed, 29 Jun 2022 04:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:In-Reply-To:Date:References:Subject:To:
        From; bh=yWORYvO8IZ9m60ZBZWENFQneFKxqNCr4t6RwBfhrer8=; b=ZLZ9KuZCd2SDqrpxJkqG
        +voaKIJHCJpC+q0cXtrUfhueCJsMy9b5IpuYNrBi1ZsisbdXzVeW8k198uXzUTQjRCqxtQApieX1R
        MlzEblWkgl7NvdGKemQ/k3Y6sIsQ8pXgH0L9I9kRNsI8ahjLP/kmoVm8rd5IiMo9w43cFOfIxCJ0N
        JrjZIw461zbNGHFQh2WX91YCN+NWzn5AuwvBzULSP6VED+1Z3PBxtWs+0U4riWxM4tdsFLXw6dpSx
        c+4JxUsfnnUyIHNe7vsb93q8jyjp/aWhivj7IAs6xF58Gs0w5hd+8goOCdCYnMDHgMhurqlqUAA4C
        t2mdmgcf0S2KPg==;
Received: from dynamic-077-182-178-150.77.182.pool.telefonica.de ([77.182.178.150]:54142 helo=termi.gnu.org)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jemarch@gnu.org>)
        id 1o6TYE-0002JL-IW; Wed, 29 Jun 2022 04:59:59 -0400
From:   "Jose E. Marchesi" <jemarch@gnu.org>
To:     Ruud van der Pas <ruud.vanderpas@oracle.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <morbo@google.com>,
        Vladimir Mezentsev <vladimir.mezentsev@oracle.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Wenlei He <wenlei@fb.com>, Hongtao Yu <hoy@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-toolchains@vger.kernel.org, elena.zannoni@oracle.com
Subject: Re: plumbers session on profiling?
References: <CAKwvOdkyY9rsH3eViMK-_4iz_W_usumz5nD+3AhbNCVQ3FRCjA@mail.gmail.com>
        <CAKwvOdnsZekEM77axBf67MDqQVP0n6PTKH=njSyPSWTNiWAOiA@mail.gmail.com>
        <87mtf7z0rt.fsf@gnu.org>
        <6F9E9D93-3913-4022-9384-D809C8EF7715@oracle.com>
        <CAKwvOdm=_YqBpuBzouqoWHYNe6MMUE10vqF0PUkU=hcOj+UqrQ@mail.gmail.com>
        <B0A01DE7-1B50-479A-92DF-DAFAB3F06E0F@oracle.com>
Date:   Tue, 28 Jun 2022 19:08:48 +0200
In-Reply-To: <B0A01DE7-1B50-479A-92DF-DAFAB3F06E0F@oracle.com> (Ruud van der
        Pas's message of "Thu, 23 Jun 2022 23:21:07 +0200")
Message-ID: <878rpgpvfj.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[Added linux-toolchains@vger in CC]

It would be interesting to have some discussion in the Toolchains track
on building the kernel with PGO/FDO.  I have seen a raise on interest on
the topic in several companies, but it would make very little sense if
no kernel hacker is interested in participating... anybody?

> Hi Nick,
>
> Apologies for the delay. It's been a busy week with gprofng related work.
>
>> If you're still considering attending Linux Plumbers conf, please
>> submit a proposal:
>> https://lpc.events/event/16/abstracts/
>> Please make sure to select "Toolchains Track" as the "Track" after
>> clicking on "Submit new abstract."
>
> Thanks for asking!
>
> Our presence largely depends on a discussion on kernel profiling and
> to see what we might be able to do with gprofng regarding this.
>
>>From our side, the main person will be Vladimir. He knows the code
> inside and out, but I will also try to attend such a session.
>
> Is there any news regarding such a session on kernel profiling?
>
> Kind regards, Ruud
>
>> 
>>> 
>>> Kind regards, Ruud
>>> 
>>>> On 24 May 2022, at 12:24, Jose E. Marchesi <jemarch@gnu.org> wrote:
>>>> 
>>>> 
>>>> I am adding Ruud van der Pas in CC. He works in gprofng and would be
>>>> willing to participate in a discussion on kernel profiling.
>>>> 
>>>>> (Re-sending with Vladamir's email addr fixed; sorry for the noise)
>>>>> 
>>>>> On Fri, Apr 15, 2022 at 10:54 AM Nick Desaulniers
>>>>> <ndesaulniers@google.com> wrote:
>>>>>> 
>>>>>> Hi Sami, Bill, Jose, and Vladamir,
>>>>>> Jose and I are currently in the planning process to put together a
>>>>>> Kernel+Toolchain microconference track at Linux Plumbers Conference
>>>>>> this year (Sept 12-14) in Dublin, Ireland.
>>>>>> 
>>>>>> Would you all be interested in leading a session discussing various
>>>>>> profiling related topics such as:
>>>>>> * gprofng
>>>>>> * PGO
>>>>>> * AutoFDO
>>>>>> 
>>>>>> Would others find such a discussion useful?
>>>>>> --
>>>>>> Thanks,
>>>>>> ~Nick Desaulniers
>>> 
>> 
>> 
>> -- 
>> Thanks,
>> ~Nick Desaulniers
