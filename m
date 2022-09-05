Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582155AD231
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbiIEMOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbiIEMN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CF25E649
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662380033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ApsKCLSWRw7n5xOhYUZqNuEpvYDSkjS9vJhA2clL9Bk=;
        b=hAZw3uNfP6NPwR9DSDyAzzQjCW4OZDaYfrMSNvMmWUEejKhdezq7+/Mv3aQoVC0qv6lS7C
        S/1mGFCIgirchN6PfVEMqWYRpajwjYZ7xhcgJKmgQFq6GXqep7uElq/rb6gz8d8kl/f9/5
        Lm8FcIHXsqpQDZ+ItNXqprV92CUha5o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-626-Ah1niUYVMT22p8iUloah6w-1; Mon, 05 Sep 2022 08:13:52 -0400
X-MC-Unique: Ah1niUYVMT22p8iUloah6w-1
Received: by mail-wr1-f69.google.com with SMTP id d16-20020adfa350000000b00228628ff913so682553wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 05:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ApsKCLSWRw7n5xOhYUZqNuEpvYDSkjS9vJhA2clL9Bk=;
        b=IoKncf6RKO/F1aDcy0oRy/Baib65tJoIG/h8z66stapfhXq78BMz9uk6OYYSmd+7C1
         Bd+AJey+EFClFbMcLFF8niC/dUqGo8dZQNO3ukP2rWZp+K3eIHXJ3/47YsemBIia0n+X
         +QeW/kCticgLRXiThgMGiRi6iPU/qZMZ8KLwIFaCbw5+L1BbUCnBIXgVdxAkRL8/75QW
         8HE6ddNaoKmwLsac2j0dBvf4mVWes2zMdc5QY7S+FLygH0L0dSlTHv9mPcOYX4/RkUMc
         vElYzDBNnww49dkKqnsYuquclwq1mGp54bHYxgejoTGN9JmdmisZxdU2UAKBIEk0vjSt
         ZyLw==
X-Gm-Message-State: ACgBeo0H26sYefopG0Na9GOP+/Yi04q89tByDbfOefzPqK50fcUmDA0r
        IpHepjabvXQa9wpNA1Cb4MqyfGwiRTiNNcTSN7pXV+xOCq8hGpbnfQasRgcKyefn36Jn5EEuQyS
        OhdPKhxk4AnW9FuoLmSRYDYbd
X-Received: by 2002:a05:600c:657:b0:3a5:e4e6:ee24 with SMTP id p23-20020a05600c065700b003a5e4e6ee24mr10205902wmm.68.1662380029658;
        Mon, 05 Sep 2022 05:13:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7vnX2rI0NgJ8w4X349hOjDN9pmD9eSUcHD0aanGXcayy0Z/uUmik6EeMyzIU1rR8ux98emDg==
X-Received: by 2002:a05:600c:657:b0:3a5:e4e6:ee24 with SMTP id p23-20020a05600c065700b003a5e4e6ee24mr10205888wmm.68.1662380029262;
        Mon, 05 Sep 2022 05:13:49 -0700 (PDT)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id ck1-20020a5d5e81000000b00228552a2c3fsm7520645wrb.108.2022.09.05.05.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 05:13:48 -0700 (PDT)
Message-ID: <76f90f32-7265-3215-26db-4987e56a5e73@redhat.com>
Date:   Mon, 5 Sep 2022 15:13:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [kernelci-members] KernelCI working group: Web Dashboard
Content-Language: en-US
To:     kernelci@groups.io, gustavo.padovan@collabora.com,
        kernelci-members@groups.io
Cc:     automated-testing@lists.yoctoproject.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci-tsc@groups.io" <kernelci-tsc@groups.io>,
        Simon Xiao <sixiao@microsoft.com>,
        Carlos Cardenas <Carlos.Cardenas@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sharath George John <sgeorgejohn@microsoft.com>,
        "Alain Gefflaut (HE/HIM)" <agefflaut@microsoft.com>,
        Johnson George <Johnson.George@microsoft.com>
References: <f3874e7d-ccfe-4a2d-d054-9b7bf9e8b44d@collabora.com>
 <16F4479F76A8C807.11895@groups.io> <16F65ECD601264EC.15470@groups.io>
 <1706557437ACCB9C.25939@groups.io> <170FD91B51709B41.16609@groups.io>
 <1710D385D5C94519.1438@groups.io>
 <82a05396-2a72-278d-0a65-1b056a0111cc@collabora.com>
From:   Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <82a05396-2a72-278d-0a65-1b056a0111cc@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gustavo,

It probably won't work next week, as much of KernelCI (at least) will be at 
the Linux Plumbers conference.

Nick

On 9/5/22 14:04, Gustavo Padovan wrote:
> Hello,
> 
> I have learned that Today is holiday in the US and Canada. So I am moving this 
> invite to the same time next week. If it doesn't work for people, we can start 
> a new pool. Please let me know.
> 
> Regards,
> 
> Gustavo
> 
> Le 01/09/2022 à 15:32, Gustavo Padovan a écrit :
>> Hello,
>>
>> The next meeting is next Monday September 5th at 12:00pm EDT. Invite sent to 
>> those who answered the poll and the the members and tsc mailing list. In any 
>> invite ics is attached.
>>
>> Best regards,
>>
>> Gustavo
>>
>> Le 29/08/2022 à 11:04, Gustavo Padovan a écrit :
>>> Hello,
>>>
>>> The previous tentative below didn't work due to vacation season. Here's a 
>>> new pool with dates from 1st to 8th of September. Please answer it until 
>>> this Wednesday August 31th.
>>>
>>> https://doodle.com/meeting/participate/id/dG5v423a
>>>
>>> See the email below for meetings notes and current User Stories document.
>>>
>>> Regards,
>>>
>>> Gustavo
>>>
>>> On 7/18/22 10:17, Gustavo Padovan wrote:
>>>> Hi everyone,
>>>>
>>>> In our last Web Dashboard meeting[1] where we reviewed the User Stories 
>>>> document[2]. Then, after that we worked offline to incorporate the 
>>>> feedback on doc, so it is time for our next meeting to further discuss. 
>>>> Please answer the poll with your time availability on the link below. I 
>>>> added dates from 21th to 28th of July.
>>>>
>>>> https://doodle.com/meeting/participate/id/eX6vyY5b
>>>>
>>>> Thank you,
>>>>
>>>> Gus
>>>> —
>>>> [1]https://docs.google.com/document/d/1yp-2L54tnrwkZ--59t2GeXuq1gt5dDnsFy08odizl1Y/edit#bookmark=id.6ok0ufne9shj
>>>> [2]https://docs.google.com/document/d/1_rfMpas4n_gw2GvUTRU63vIXk95VotJuittalX7trP8/edit#heading=h.wjoxi4s5pxzl
>>>>
>>>> On 6/7/22 10:46, Gustavo Padovan wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> Our next meeting has been scheduled for this Thursday at 3pm UTC. Invite 
>>>>> was sent to the kernelci-members list, but here goes the instructions to 
>>>>> join as well:
>>>>>
>>>>> This event has a video call.
>>>>> Join: https://meet.google.com/yyz-jzjy-yfu
>>>>> (US) +1 254-227-6870 PIN: 188509910#
>>>>> View more phone numbers: 
>>>>> https://tel.meet/yyz-jzjy-yfu?pin=5882595078642&hs=7
>>>>>
>>>>> Regards,
>>>>>
>>>>> Gustavo
>>>>>
>>>>> Le 31/05/2022 à 15:34, Gustavo Padovan a écrit :
>>>>>>
>>>>>> Hello everyone,
>>>>>>
>>>>>> **
>>>>>>
>>>>>> *From our first meeting back in October[1], we took the action of 
>>>>>> organizing our user stories that you were spread as a comments in the 
>>>>>> the github issue{2} and, converting them into User Stories document[3].*
>>>>>>
>>>>>> *
>>>>>>
>>>>>> In the next meeting, we want to study the current User Stories and start 
>>>>>> discussions to progress on development. The proposed slots are for next 
>>>>>> week. Please answer the doodle by the end of this week:
>>>>>>
>>>>>> https://doodle.com/meeting/participate/id/egJ12A9d
>>>>>>
>>>>>> Best regards,
>>>>>>
>>>>>> Gustavo
>>>>>>
>>>>>> [1] 
>>>>>> https://docs.google.com/document/d/1yp-2L54tnrwkZ--59t2GeXuq1gt5dDnsFy08odizl1Y/edit# <https://docs.google.com/document/d/1yp-2L54tnrwkZ--59t2GeXuq1gt5dDnsFy08odizl1Y/edit#>
>>>>>>
>>>>>> [2] https://github.com/kernelci/kernelci-project/discussions/28 
>>>>>> <https://github.com/kernelci/kernelci-project/discussions/28>
>>>>>>
>>>>>> {3} 
>>>>>> https://docs.google.com/document/d/1_rfMpas4n_gw2GvUTRU63vIXk95VotJuittalX7trP8/edit <https://docs.google.com/document/d/1_rfMpas4n_gw2GvUTRU63vIXk95VotJuittalX7trP8/edit>*
>>>>>> Le 27/07/2021 à 11:54, Guillaume Tucker a écrit :
>>>>>>> Last year's KernelCI Community Survey[1] showed the importance of
>>>>>>> having a good web dashboard.  About 70% of respondents would use
>>>>>>> one if it provided the information they needed efficiently.
>>>>>>> While other things are arguably even more important, such as
>>>>>>> testing patches from mailing lists, replying to stable reviews
>>>>>>> and sending email reports directly to contributors in a "natural"
>>>>>>> workflow, the web dashboard has been a sticking point for a
>>>>>>> while.
>>>>>>>
>>>>>>> There have been several attempts at solving this problem, using
>>>>>>> Elastic Stack and Grafana among other things, but there isn't a
>>>>>>> single framework able to directly provide an off-the-shelf
>>>>>>> solution to the community's needs.  In fact, the first issue is
>>>>>>> the lack of understanding of these needs: who wants to use the
>>>>>>> web dashboard, and how?  Then, how does one translate those needs
>>>>>>> into a user interface?  Doing this requires skills that engineers
>>>>>>> who regularly contribute to KernelCI typically don't have. As
>>>>>>> such, a dedicated working group is being created in order to fill
>>>>>>> this gap.
>>>>>>>
>>>>>>> The aim is to coordinate efforts and try to follow best practices
>>>>>>> to make steady progress and avoid repeating the same mistakes.
>>>>>>> Most likely, we will need some help from proper web developers
>>>>>>> who aren't part of the usual KernelCI community.  This may be
>>>>>>> facilitated by the KernelCI LF project budget if approved by the
>>>>>>> governing board.
>>>>>>>
>>>>>>> In order to get started, we would need to have maybe 3 to 5
>>>>>>> people available to focus on this.  It doesn't necessarily mean a
>>>>>>> lot of hours spent but actions to be carried out on a daily or
>>>>>>> weekly basis.  So far we have Gustavo Padovan as our new KernelCI
>>>>>>> Project Manager and a few people have expressed interest but we
>>>>>>> still need formal confirmation.
>>>>>>>
>>>>>>>
>>>>>>> Here's a GitHub project dedicated to the new web dashboard:
>>>>>>>
>>>>>>>    https://github.com/orgs/kernelci/projects/4
>>>>>>>
>>>>>>> I've created a couple of issues to get started about user
>>>>>>> stories, and some initial milestones as a basic skeleton:
>>>>>>>
>>>>>>> https://github.com/kernelci/kernelci-project/milestones
>>>>>>>
>>>>>>>
>>>>>>> This is ultimately a community-driven effort to address the needs
>>>>>>> of the kernel community.  Please share any thoughts you may have
>>>>>>> on this, whether you want to add some user stories, share some
>>>>>>> expertise, be officially in the working group or take part in
>>>>>>> this effort in any other way.
>>>>>>>
>>>>>>> Best wishes,
>>>>>>> Guillaume
>>>>>>>
>>>>>>> [1]https://foundation.kernelci.org/blog/2020/07/09/kernelci-community-survey-report/
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>
>>>>
>>>
>>
>>
>>
>>
>>
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#1588): https://groups.io/g/kernelci/message/1588
> Mute This Topic: https://groups.io/mt/93476003/3616695
> Group Owner: kernelci+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci/unsub [Nikolai.Kondrashov@redhat.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

