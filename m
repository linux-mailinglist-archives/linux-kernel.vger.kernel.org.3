Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188E45733E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiGMKM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiGMKM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:12:56 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C5DF9904
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:12:54 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4LjYN20sPcz9sTd;
        Wed, 13 Jul 2022 12:12:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dragonslave.de;
        s=MBO0001; t=1657707170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tyfQXAbLSZRhOgYn3p6Tw2MA7BXyqthJCLX9F/a8m2k=;
        b=ryObA2+qN0oso3F9ewz7RfvEKgRXr2+0S2AQdjIkUYaFVUVhj0AIGMJg9/sqOEyfkkV+It
        wHzj3KHThgChvVt+GXr0Hh22AVrHHUxqYeptDbr30QMEGRVzPXqG/frbA760WTEvL39uqP
        VougWz6rh2+FKrI4LQO/aOoY9xYgcwd45g6ZVXhJia26CetfrJLI940InrJ+SCBgadno2k
        690ZF1cetXhzsU5loyrummj2iZB+99nv58rNKy4mtXFOAJpqF83f1mX4tLPAzJ5bpjWFOP
        BhtZt9NAxVzF14NZBad+AQP93vaVA9i5IDDpHOnY5N7K21rnbwIa6/4gwXZ/uQ==
Message-ID: <9ebfb3d5-ac2d-e664-8b71-dfc1fd6d6362@dragonslave.de>
Date:   Wed, 13 Jul 2022 12:12:48 +0200
MIME-Version: 1.0
Subject: Re: Regression in v5.19-rc4 Sound Distortion
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <46fd7a73-06fd-a8a0-8530-0ecf9b18c08d@dragonslave.de>
 <f8725aba-2cd1-c79c-eaf9-d272c140049e@collabora.com>
 <22805e12-7144-037f-c58c-4bc182d27919@leemhuis.info>
Content-Language: en-US
From:   Daniel Exner <dex@dragonslave.de>
In-Reply-To: <22805e12-7144-037f-c58c-4bc182d27919@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4LjYN20sPcz9sTd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

horsten Leemhuis wrote:
> On 12.07.22 18:35, Dmitry Osipenko wrote:
>> On 7/12/22 19:02, Daniel Exner wrote:
>>
>>> Since  v5.19-rc4 this box got some *loud* distorting sound on boot and
>>> after some time without any sound if something plays sound again from
>>> the integrated speakers in my monitor.
>>>
>>> I managed to bisect this down to:
>>>
>>>> commit 202773260023b56e868d09d13d3a417028f1ff5b
>>>> Author: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>> Date:   Fri Jun 17 15:24:02 2022 +0300
>>>>
>>>>     PM: hibernate: Use kernel_can_power_off()
>>> Reverting that commit on top of v5.19-rc6 does indeed fix the problem here.
>> You're saying that the problem is on boot, but this patch is about
>> suspension to disk, which has nothing to do neither with the boot nor
>> with power-off. I'm afraid your bisection is incorrect.
> After quickly looking at the code this looks appropriate, but why does
> reverting that commit help then? That's a bit odd. Daniel: are you maybe
> using suspend-to-disk and forgot to mention it?

No, I am not. But it seems Dmitry was right, at some point I bisected 
wrong by declaring some point good too early because I didn't have the 
bug on boot.

Perhaps I have two effects here: some bug resulting in sound distortion 
and some bug triggering that faster.


I will redo the bisection, but I fear it will take some time.


Greetings

Daniel

