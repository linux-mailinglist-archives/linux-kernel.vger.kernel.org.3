Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF014EE205
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240951AbiCaTnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241156AbiCaTnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:43:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1CC127589;
        Thu, 31 Mar 2022 12:41:22 -0700 (PDT)
Received: from [IPV6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1] (unknown [IPv6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AD5941F46A5D;
        Thu, 31 Mar 2022 20:41:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648755680;
        bh=XyZcQg6pqR159jgtxwGtbmonYgk2JzV10bPGOcjl0Qc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DE4VWC1bnVsxalr1+sXEPphCLUZNPnQ1i5KR46hOq9wpUWFkfxPTdYNwayv5PeJMy
         x1usxrG78HxHgRkrg80QEw4tYf9RiS2VsRKfx4c//GaCzdwCB134eYNMsU1X/Am5PZ
         CHMG8SEJbZRSQozYR+iQMjJ5aTBptRVxwbuCqS+5WoiwEuHs+PYVimXUgW6hIIW+0q
         JTspnl+6ZAsyyUGvZJl4MEjp2Gdx7k35YQiEeqnhVlJ76iikG1BaLgGjDc5dRxQ8Fj
         JKaP1em6qv0X5Nh8PQwTuJymfxQiVRhRauJ1KZVi3CiwsRah4g89P4jCPW3xXpeBWe
         SDDqSfoz/jJSQ==
Message-ID: <22d9a9ff-1c44-ed41-6ae1-59a1f965ab6c@collabora.com>
Date:   Thu, 31 Mar 2022 22:41:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 10/10] drm/msm: Add a way for userspace to allocate GPU
 iova
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Emma Anholt <emma@anholt.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220330204804.660819-1-robdclark@gmail.com>
 <20220330204804.660819-11-robdclark@gmail.com>
 <ad97096f-cc90-4f20-0f73-f33e9b275f1a@collabora.com>
 <CAF6AEGvZqM1OT_n1C+x+C1GTd4PbFkH4c7P-BseDOUGj7yj3Eg@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAF6AEGvZqM1OT_n1C+x+C1GTd4PbFkH4c7P-BseDOUGj7yj3Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 22:02, Rob Clark wrote:
> On Thu, Mar 31, 2022 at 11:52 AM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> ...
>>> +/*
>>> + * Get the requested iova but don't pin it.  Fails if the requested iova is
>>> + * not available.  Doesn't need a put because iovas are currently valid for
>>> + * the life of the object.
>>> + *
>>> + * Setting an iova of zero will clear the vma.
>>> + */
>>> +int msm_gem_set_iova(struct drm_gem_object *obj,
>>> +                  struct msm_gem_address_space *aspace, uint64_t iova)
>>> +{
>>> +     int ret = 0;
>>
>> nit: No need to initialize the ret
> 
> actually, we do

Indeed, sorry :)

...
>>>  int msm_gem_get_and_pin_iova_range(struct drm_gem_object *obj,
>>>               struct msm_gem_address_space *aspace, uint64_t *iova,
>>>               u64 range_start, u64 range_end);
>> nit: There is an odd mix of uint64_t and u64 (and alike) in the MSM code
>> :) The uint64_t variant shouldn't be used by kernel code in general and
>> checkpatch should want about it.
> 
> one of many things that I disagree with checkpatch about ;-)
> 
> I prefer standard types to custom ones.  I _kinda_ get the argument in
> case of uapi (but IMHO that doesn't apply to how drm uapi headers are
> used)

I'd understand if it was all either uint64_t or u64, but the mix.. hm.
