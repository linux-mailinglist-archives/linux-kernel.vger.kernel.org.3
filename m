Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8314D9062
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343699AbiCNXd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbiCNXd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:33:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF5AFD10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:32:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id EB1A21F433BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647300734;
        bh=9clAFUpmyfjDVmXRc8GUa3ADKwVw6CLuu2WzpsLgnrQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cusMh++HSY9Mu8xH2QJtv7+yNcgFTInEIC9S1TQ37r87YqQK0Cbr+l8E5kvCU2AHU
         IPrSmZbOYKir/Zm3aQubN11Jfer0fCrYEkW0TZcvzt7lcTuzdjL3lFvD0FDAsieTyX
         tiaHBcIQn7fxWcA43hBPz2VSoJOCe3vsDpQhF7/eUsui8EsKp289qqBwduO4KnTU+M
         UhbX4uBTGvUJ9vEiU+gbnygEKmla/oeTSxevMvoEOpirWNUC1XU13yYBzUha5hiT8z
         9Kge3LtkPCnnTfa5b7fETcmqq5F3OMtEVkpTx6/7qdf+63JzqhwtXM89NytBlOQGl5
         YjMDA3m8lTv2A==
Message-ID: <4c107b1a-ad6b-8d20-9336-8e08adffe09c@collabora.com>
Date:   Tue, 15 Mar 2022 02:32:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 8/8] drm/panfrost: Switch to generic memory shrinker
Content-Language: en-US
To:     Alyssa Rosenzweig <alyssa@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
 <20220314224253.236359-9-dmitry.osipenko@collabora.com>
 <Yi/PCCQqvxA6aHzA@maud>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <Yi/PCCQqvxA6aHzA@maud>
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

On 3/15/22 02:26, Alyssa Rosenzweig wrote:
> On Tue, Mar 15, 2022 at 01:42:53AM +0300, Dmitry Osipenko wrote:
>> Replace Panfrost's memory shrinker with a generic DRM memory shrinker.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  drivers/gpu/drm/panfrost/Makefile          |  1 -
>>  drivers/gpu/drm/panfrost/panfrost_device.h |  4 ----
>>  drivers/gpu/drm/panfrost/panfrost_drv.c    | 19 ++-------------
>>  drivers/gpu/drm/panfrost/panfrost_gem.c    | 27 ++++++++++++++--------
>>  drivers/gpu/drm/panfrost/panfrost_gem.h    |  9 --------
>>  drivers/gpu/drm/panfrost/panfrost_job.c    | 22 +++++++++++++++++-
>>  6 files changed, 40 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/Makefile b/drivers/gpu/drm/panfrost/Makefile
>> index b71935862417..ecf0864cb515 100644
>> --- a/drivers/gpu/drm/panfrost/Makefile
>> +++ b/drivers/gpu/drm/panfrost/Makefile
>> @@ -5,7 +5,6 @@ panfrost-y := \
>>  	panfrost_device.o \
>>  	panfrost_devfreq.o \
>>  	panfrost_gem.o \
>> -	panfrost_gem_shrinker.o \
>>  	panfrost_gpu.o \
>>  	panfrost_job.o \
>>  	panfrost_mmu.o \
> 
> I'm not sure you actually deleted gem_shrinker anywhere in this patch?
> Diff stat is too small.

Indeed, I was also confused by the diffstat once noticed it after the
patches were sent out. And yes, I missed to git-add the
panfrost_gem_shrinker.c by accident. Good catch, thank you! I'll correct
it in in the v3.

Meanwhile, will be great if you or somebody else could test this
Panfrost patch. I don't have any h/w with Mali on hands yet and only
compile-tested it.
