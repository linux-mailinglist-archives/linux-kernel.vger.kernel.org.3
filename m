Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DBC4DBAD4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiCPXFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbiCPXFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:05:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0428DDFAC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:04:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 6E9DA1F44C42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647471855;
        bh=vypIGC9yqBVxDvY1DtMdZYum709Wnji4exA+N/PneQU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A6tG0fKkfNiroiVkC5AuUMu0miL9hXVOUDNaQPQCpIopWYTUDzNIMIfaUkqM+N3B7
         BTKqhaNJgv7R49/bydapNWn+rNBZUPb3eA/sTT1JFBVdaWPxEhUJu3nnlh+F/+o0U6
         Rd1pFUOh54KcMnVr1n/nP/SvajR1rLXvFBIAi7DRFOdywZU58lzfAPTj1CGaXOiIbb
         tlNc/BF7NZreO7EVKH87tJVl0JmuwSGr3fYYNgCOvDxBeGDzQs98F7ev48ZfygR94W
         kyf+Zu/MchO9fRmCtryTDlgwb7C7fmDjOtobRCA7usmJukcnxb3kbuAZ16/4V9dV9x
         XlQ1qc6w6CaGg==
Message-ID: <3dda45b8-1f49-eefd-0167-1f3c13b2c73f@collabora.com>
Date:   Thu, 17 Mar 2022 02:04:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 8/8] drm/panfrost: Switch to generic memory shrinker
Content-Language: en-US
To:     Steven Price <steven.price@arm.com>,
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
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
 <20220314224253.236359-9-dmitry.osipenko@collabora.com>
 <4e6256d0-a3c6-ba01-c31f-a5757b79a9ce@arm.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <4e6256d0-a3c6-ba01-c31f-a5757b79a9ce@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/16/22 18:04, Steven Price wrote:
> On 14/03/2022 22:42, Dmitry Osipenko wrote:
>> Replace Panfrost's memory shrinker with a generic DRM memory shrinker.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
> I gave this a spin on my Firefly-RK3288 board and everything seems to
> work. So feel free to add a:
> 
> Tested-by: Steven Price <steven.price@arm.com>
> 
> As Alyssa has already pointed out you need to remove the
> panfrost_gem_shrinker.c file. But otherwise everything looks fine, and
> I'm very happy to see the shrinker code gone ;)

Awesome, thank you.
