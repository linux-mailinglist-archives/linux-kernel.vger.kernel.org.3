Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4544DBACE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiCPXEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiCPXEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:04:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E13DFAC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:03:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 71F991F44C42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647471812;
        bh=cw1c3IVv325Z8b6mJJEs4HEBjZj9x2UDC55LA51Tjsw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gNN7CMmhxdZZ7js/GDH/LeNCtv99QQu//2AA/ElU7yHMo9wb9thbdFSK3P33l7byl
         5DuTzvAk9xh5dBfjI8doFHWcLYJqarjfrzmM58A/7t9yBl4EVhZp9RXBSItKET0rjo
         pQ3mbIPSUVvr5RuYODuK5FnD0N10cxrnnCnzxazkZ4vozKzr8qGdg9LbUjWT+AR13w
         +OOeHCGPbbw4by9zcpnxr/rDWBDLgflOCuHLfRzORwSojjbbnTQjId9ldAs7m8YJkl
         Ik/5QeTy+8c18s7M1sn4lH2VB0FzQ1Nx27AiCwKqNFjcjoEdSf4iHV40krt8Ca9fe4
         QAbCpmPvPsqWQ==
Message-ID: <3fe18a5f-081c-c5aa-7366-0a44035e5082@collabora.com>
Date:   Thu, 17 Mar 2022 02:03:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 6/8] drm/shmem-helper: Add generic memory shrinker
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
 <20220314224253.236359-7-dmitry.osipenko@collabora.com>
 <d9b39fc0-f8dd-9569-833d-7fe12a0dc859@arm.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <d9b39fc0-f8dd-9569-833d-7fe12a0dc859@arm.com>
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
>> Introduce a common DRM SHMEM shrinker. It allows to reduce code
>> duplication among DRM drivers, it also handles complicated lockings
>> for the drivers. This is initial version of the shrinker that covers
>> basic needs of GPU drivers.
>>
>> This patch is based on a couple ideas borrowed from Rob's Clark MSM
>> shrinker and Thomas' Zimmermann variant of SHMEM shrinker.
>>
>> GPU drivers that want to use generic DRM memory shrinker must support
>> generic GEM reservations.
>>
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> This looks fine to me, but one nitpick: you should update the comment in
> struct drm_gem_shmem_object:
> 
>> 	/**
>> 	 * @madv: State for madvise
>> 	 *
>> 	 * 0 is active/inuse.
>> 	 * A negative value is the object is purged.
>> 	 * Positive values are driver specific and not used by the helpers.
>> 	 */
>> 	int madv;
> This is adding a helper which cares about the positive values.

Good catch, I'll update the comment in v3.
