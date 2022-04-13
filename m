Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325834FEF37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiDMGIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiDMGIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:08:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A379E35A80
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:05:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 3EE3C1F44C9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649829950;
        bh=h6yCUcAcN6iaR3DQkh+xpCyBQk8JfcLMxbGWf++mfDM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jMVQuRfWn5ob7ywAWnQ4xvadET+t9PxuKd4Yumb2zwEGZwGkefQlF4p+oKw8vT8gt
         AbQ0XoyYyRYvYxIUKG86ENbVE3riGczfeVt617sOMoKKc7uLvEaD1omvHHkkmCl1ra
         6vDBajXKYLJdG2wl0n08JIB4LohicDYP4LNMgYnvUhVAOZjIvWwhz+GbQ4N2AEizv5
         CdP3hDzqnBHbm1Yjg7WYACdDDSWcyp056qAACKATm+T2Hrsn6kjetJt2Np3/bRrxu9
         QCtJEuW1lz4wA0HV44Bw3KCC4gn3U85I1OqPaifplAgo3iZMFRVie0zpS7P6nCb9+p
         QRFaxCjhyxBIg==
Message-ID: <7f0d7ade-1d59-2c43-c1b2-1fa847eb741a@collabora.com>
Date:   Wed, 13 Apr 2022 09:05:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] drm/scheduler: Don't kill jobs in interrupt context
Content-Language: en-US
To:     Erico Nunes <nunes.erico@gmail.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Qiang Yu <yuq825@gmail.com>
References: <20220411221536.283312-1-dmitry.osipenko@collabora.com>
 <064d8958-a288-64e1-b2a4-c2302a456d5b@amd.com>
 <a04733af-5ff1-a1b4-527d-68b28a037231@collabora.com>
 <f6de2b9a-005f-d1f5-9818-cfbee2bdddc5@amd.com>
 <CAK4VdL3VOtVGi36SY0TEL4P2jW33dM4TOmFXYmewE7cGNhY4Zw@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAK4VdL3VOtVGi36SY0TEL4P2jW33dM4TOmFXYmewE7cGNhY4Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 01:59, Erico Nunes wrote:
> On Tue, Apr 12, 2022 at 9:41 PM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com> wrote:
>>
>>
>> On 2022-04-12 14:20, Dmitry Osipenko wrote:
>>> On 4/12/22 19:51, Andrey Grodzovsky wrote:
>>>> On 2022-04-11 18:15, Dmitry Osipenko wrote:
>>>>> Interrupt context can't sleep. Drivers like Panfrost and MSM are taking
>>>>> mutex when job is released, and thus, that code can sleep. This results
>>>>> into "BUG: scheduling while atomic" if locks are contented while job is
>>>>> freed. There is no good reason for releasing scheduler's jobs in IRQ
>>>>> context, hence use normal context to fix the trouble.
>>>>
>>>> I am not sure this is the beast Idea to leave job's sw fence signalling
>>>> to be
>>>> executed in system_wq context which is prone to delays of executing
>>>> various work items from around the system. Seems better to me to leave the
>>>> fence signaling within the IRQ context and offload only the job freeing or,
>>>> maybe handle rescheduling to thread context within drivers implemention
>>>> of .free_job cb. Not really sure which is the better.
>>> We're talking here about killing jobs when driver destroys context,
>>> which doesn't feel like it needs to be a fast path. I could move the
>>> signalling into drm_sched_entity_kill_jobs_cb() and use unbound wq, but
>>> do we really need this for a slow path?
>>
>>
>> You can't move the signaling back to drm_sched_entity_kill_jobs_cb
>> since this will bring back the lockdep splat that 'drm/sched: Avoid
>> lockdep spalt on killing a processes'
>> was fixing.
>>
>> I see your point and i guess we can go this way too. Another way would
>> be to add to
>> panfrost and msm job a  work_item and reschedule to thread context from
>> within their
>> .free_job callbacks but that probably to cumbersome to be justified here.
> 
> FWIW since this mentioned individual drivers, commit 'drm/sched: Avoid
> lockdep spalt on killing a processes' also introduced problems for
> lima.
> There were some occurrences in our CI
> https://gitlab.freedesktop.org/mesa/mesa/-/jobs/20980982/raw .
> Later I found it also reproducible on normal usage when just closing
> applications, so it may be affecting users too.
> 
> I tested this patch and looks like it fixes things for lima.

This patch indeed should fix that lima bug. Feel free to give yours
tested-by :)
