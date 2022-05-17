Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F0A529D31
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243993AbiEQJDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiEQJDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:03:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF2F1D0FC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:03:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id E6B331F4439C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652778223;
        bh=UYubMcn9ZLqkxXynnDr3S5Ixi/XQwp/zcG8Jzl6yAGY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nsd51A3QHf00rG6Hi57mYXcMCohcrFDwfxP2vm41heblBqYqP8pdbTedoIPenjYQg
         mbQs94iUCp2qwefb47xG401nrdU2yt+Rl+winnnME+eFXM/JThc01Nnazdb30flLt5
         XBQJtCZRigSTDLWb0i8lZAU8dxwVCkcGHPpnnJWxpRXXH/CvT0e65pnL1AOhyyxbaV
         UGu92yeY7/xGcFT9j0CZtSm1lM9cXCpZebKiLCHAs+utdb0q4mWslt+1OPZaqRzDli
         qOPYmdS5+29ArJIlZ9xwgkIkD0IJdXpkSA2njVHjVL41vHJRs1tE2FhBs46O8X/XRL
         LHWsl9p/kuutA==
Message-ID: <ef88ec2c-77b5-fa0d-49d1-fdd2451713b7@collabora.com>
Date:   Tue, 17 May 2022 12:03:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1] drm/scheduler: Don't kill jobs in interrupt context
Content-Language: en-US
To:     Erico Nunes <nunes.erico@gmail.com>,
        Steven Price <steven.price@arm.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20220411221536.283312-1-dmitry.osipenko@collabora.com>
 <a78343c8-2a6d-b223-4219-6b6b0a4fcb1f@arm.com>
 <CAK4VdL2hCEoshWZbCh5mkHuS6wYMiPFR3v4MWTnrEKM9zyv6Mw@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAK4VdL2hCEoshWZbCh5mkHuS6wYMiPFR3v4MWTnrEKM9zyv6Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 10:40, Erico Nunes wrote:
> On Wed, Apr 13, 2022 at 12:05 PM Steven Price <steven.price@arm.com> wrote:
>>
>> On 11/04/2022 23:15, Dmitry Osipenko wrote:
>>> Interrupt context can't sleep. Drivers like Panfrost and MSM are taking
>>> mutex when job is released, and thus, that code can sleep. This results
>>> into "BUG: scheduling while atomic" if locks are contented while job is
>>> freed. There is no good reason for releasing scheduler's jobs in IRQ
>>> context, hence use normal context to fix the trouble.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 542cff7893a3 ("drm/sched: Avoid lockdep spalt on killing a processes")
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>
>> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> Is there something blocking this patch?
> Mesa CI is still hitting the issue and I have been waiting for it to
> be applied/backported to update CI with it.
> Thanks

If this patch won't be picked up anytime soon, then I'll include it into
my "memory shrinker" patchset together with the rest of the fixes, so it
won't get lost.

-- 
Best regards,
Dmitry
