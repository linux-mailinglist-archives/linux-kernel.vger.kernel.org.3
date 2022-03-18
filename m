Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900044DDBD5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbiCROmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiCROmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:42:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454CC72E1B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:41:24 -0700 (PDT)
Received: from [IPV6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1] (unknown [IPv6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 457FD1F45FDD;
        Fri, 18 Mar 2022 14:41:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647614482;
        bh=aOAvZJ3YpqdRhOb0wcVTFtzo0hw/DL1k4YKv61CzQWg=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=nL2C0nfha3tkRVC9UrK2Io1Es+wUL38zxUmvE2qCswyWIVMp9aDcfqryJB7E+R6BP
         W2O6mv33ofUBPjpwz1la8ntw1Ll11p3AgQuuaQNtQPqd8I/tW29t7HQAPO9uDv5vHV
         Ws5kmo/FdVCIMxAtD+mBfJxDUZ3eO/7KN1CGFWKzGQWg5mnMPNQP6l60CzBv5HdRLG
         4M7isGiW/ALBPEGIz9tESa0dE6N35XF762XrsN1xWVFnKvLeeM8Aei0RQuBAwWHwt2
         nJTL3h27VK3tTNzuZ4eKjSyrMi+f3mJr2eZidsLJ9r/O0OBwKkhjFVg05iuy9z5V2H
         n40aiKPsUHX/A==
Message-ID: <b8d74d79-7d49-658f-5e0b-4a5da4fa2afc@collabora.com>
Date:   Fri, 18 Mar 2022 17:41:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 8/8] drm/panfrost: Switch to generic memory shrinker
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
 <20220314224253.236359-9-dmitry.osipenko@collabora.com>
 <4e6256d0-a3c6-ba01-c31f-a5757b79a9ce@arm.com>
 <3dda45b8-1f49-eefd-0167-1f3c13b2c73f@collabora.com>
In-Reply-To: <3dda45b8-1f49-eefd-0167-1f3c13b2c73f@collabora.com>
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


On 3/17/22 02:04, Dmitry Osipenko wrote:
> 
> On 3/16/22 18:04, Steven Price wrote:
>> On 14/03/2022 22:42, Dmitry Osipenko wrote:
>>> Replace Panfrost's memory shrinker with a generic DRM memory shrinker.
>>>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> ---
>> I gave this a spin on my Firefly-RK3288 board and everything seems to
>> work. So feel free to add a:
>>
>> Tested-by: Steven Price <steven.price@arm.com>
>>
>> As Alyssa has already pointed out you need to remove the
>> panfrost_gem_shrinker.c file. But otherwise everything looks fine, and
>> I'm very happy to see the shrinker code gone ;)
> 
> Awesome, thank you.

Steven, could you please tell me how exactly you tested the shrinker?

I realized that today's IGT doesn't have any tests for the Panfrost's
madvise ioctl.

You may invoke "echo 2 > /proc/sys/vm/drop_caches" manually in order to
trigger shrinker while 3d app is running actively (like a game or
benchmark). Nothing crashing will be a good enough indicator that it
works okay.

I may get an RK board next week and then will be able to test it by
myself, so please don't hurry.
