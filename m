Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BE84DCCBC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiCQRrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiCQRrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:47:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E012D0A5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:45:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 3B5F21F45995
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647539145;
        bh=aAOXLIlLLxolaEW1Wc2fkceSynAuP4sIIbhdmw65sMg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Rct+s6YPEXeYia4L+VIYOA8OlStP0I6CfIHOYzU0IwzopO/JcaFha27iCICtSAvf5
         w21NXM28Olc0W6Sk21ZMc3VWO1Aj9qGXdzKKSKullKb7cBdKi4i3Qy0FPbFQ4BCpAw
         yg7L2iNCVbDUNDBRsDQCZWq5WDnlr8XyRBcTw9ssWEhlDn6JN/00XWnd+T293dy91/
         BPurcDVq2KDT6ZnfZ5Bhb37VoBGxc7+9vlffRh9CdcJ8eTHK0s6oOgeqPCK1QOA+OL
         D3GrmCJjbsDJXz/sifzOOTLC+DFohcP8zrsuW3PzxRmlGm5fWx62q3nb+z5ZR+MbFS
         u3tzFS23iTtiA==
Message-ID: <aa3545cd-03c6-d45c-8b2c-9779e8327a55@collabora.com>
Date:   Thu, 17 Mar 2022 20:45:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 6/8] drm/shmem-helper: Add generic memory shrinker
Content-Language: en-US
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
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
 <20220314224253.236359-7-dmitry.osipenko@collabora.com>
 <YjNwnOMvboOkGm4w@phenom.ffwll.local>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <YjNwnOMvboOkGm4w@phenom.ffwll.local>
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

On 3/17/22 20:32, Daniel Vetter wrote:
>> +static void drm_gem_shmem_update_purgeable_status(struct drm_gem_shmem_object *shmem)
>> +{
>> +	struct drm_gem_object *obj = &shmem->base;
>> +	struct drm_gem_shmem_shrinker *gem_shrinker = obj->dev->shmem_shrinker;
>> +	size_t page_count = obj->size >> PAGE_SHIFT;
>> +
>> +	if (!gem_shrinker || obj->import_attach || !obj->funcs->purge)
>> +		return;
>> +
>> +	mutex_lock(&shmem->vmap_lock);
>> +	mutex_lock(&shmem->pages_lock);
>> +	mutex_lock(&gem_shrinker->lock);
> Uh this is just terrible I think.
> 
> Can't we move shmem helpers over to reasonable locking, i.e. per-object
> dma_resv_lock for everything? I know it's a pile of work, but I think
> we're way past the point with things like this popping up where we should
> just bite that bullet.
> 
> I discussed the full thing with Daniel Stone, but maybe a joint refresher
> on irc would be a good thing.

Aha! Perhaps I saw bits of that discussion, but it wasn't entirely clear
to me what was discussed in fact. Sounds like a good idea to try to use
the reservation lock everywhere, thank you for the suggestion.
