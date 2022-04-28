Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE74C513BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351208AbiD1Sot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351204AbiD1Soq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:44:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576F466F99
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:41:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 1DB581F45BA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651171290;
        bh=HSr1KCZ5LnslRjGdE29dDFgwDJWDw5RpI+XCM1ThDIE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bfLldcJ+mxw6WfTtItLTOjLcjf0DYyzsn4duwT4V65y2wh/auNP5VbaKcF1uLtb0B
         iB/cky4I5BR35dO0sBsMH/IMcS2hQcrcukVUN2Se+PPS1Acf+cYw0aWDojUZPfuPr6
         lry0gDJpMS6Znk7q4EgkKajPlWGFIbW3IQSsLO06kQYS5k5BW2+iwu3TyC1kW+eE2T
         ltrTAD36FgqZAog2GI8KGWD5k8oX5TmtV/lGfBCUjyzIl3wf69EgFqlvTSr7MWV/Rl
         O+vG2kloLrPb0rbCPCkO+207H8MSE6C8OYDbpOG/crx11Q8yVrBAc1ev3YHC1FTzVZ
         Ke2HvHpsR9S0A==
Message-ID: <9647245d-b0b5-12d1-fef2-7a5f759f908b@collabora.com>
Date:   Thu, 28 Apr 2022 21:41:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 01/17] drm/panfrost: Put mapping instead of shmem obj
 on panfrost_mmu_map_fault_addr() error
Content-Language: en-US
To:     Steven Price <steven.price@arm.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Qiang Yu <yuq825@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>
References: <20220424190424.540501-1-dmitry.osipenko@collabora.com>
 <20220424190424.540501-2-dmitry.osipenko@collabora.com>
 <37dae9fa-dadf-4b80-fbea-689472fd7dce@arm.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <37dae9fa-dadf-4b80-fbea-689472fd7dce@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.04.2022 16:19, Steven Price пишет:
> On 24/04/2022 20:04, Dmitry Osipenko wrote:
>> When panfrost_mmu_map_fault_addr() fails, the BO's mapping should be
>> unreferenced and not the shmem object that backs that mapping.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> Fixes: bdefca2d8dc0 ("drm/panfrost: Add the panfrost_gem_mapping concept")
> 
> Reviewed-by: Steven Price <steven.price@arm.com>

Thank you for the fixes tag. It appeared to me that this problem existed
since the first addition of the srinker when I was looking up the
offending commit, my bad :)

