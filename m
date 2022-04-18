Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91329505EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347732AbiDRTpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347724AbiDRTpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:45:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8410024968
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:43:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 90E4C1F41C3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650310988;
        bh=e3aXhhV0iMbSTBQMtpX2+7/OpY3JByN6nT0sgNfy5eo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WA4NVuAj0cyf/adVZpyR3XPEfwqgPhrzLAbhFfdZ/CinSZF97KjZJlY+8CmMSQ1qp
         rz0ySyDia/c9dEvKixvPeeWbcTKuGhvZXpgiwNJNstgRssmJ+jfWaRuzUfveZgwan5
         5lnLlEaj6uqh5m8DHyyVeqVEk0Qgigr4NG5/4nEiBomB56hAIa+uBVLdkiK+JAfNnD
         x+S9+U4j6V9J3+8wxQUFLlHRR7o/Zq1EuSPiFUcGV4/8fkUuMors8F2UExujcMVm/y
         HBn3KRF8mfjuvaPO5ZQXzIguoHfErPiYd5rFd6/wppwnDBlF05URRJOvG9HfzrFHFN
         jscGbrCLtAOew==
Message-ID: <33625122-6aad-86c1-444a-07144325835c@collabora.com>
Date:   Mon, 18 Apr 2022 22:43:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 09/15] drm/shmem-helper: Correct doc-comment of
 drm_gem_shmem_get_sg_table()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
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
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>
References: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
 <20220417223707.157113-10-dmitry.osipenko@collabora.com>
 <eefe5120-638a-40bc-5ed8-e26defe178ca@suse.de>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <eefe5120-638a-40bc-5ed8-e26defe178ca@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 21:25, Thomas Zimmermann wrote:
> Hi
> 
> Am 18.04.22 um 00:37 schrieb Dmitry Osipenko:
>> drm_gem_shmem_get_sg_table() never returns NULL on error, but a ERR_PTR.
>> Correct the doc comment which says that it returns NULL on error.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> 
>> ---
>>   drivers/gpu/drm/drm_gem_shmem_helper.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c
>> b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> index 8ad0e02991ca..30ee46348a99 100644
>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> @@ -662,7 +662,7 @@ EXPORT_SYMBOL(drm_gem_shmem_print_info);
>>    * drm_gem_shmem_get_pages_sgt() instead.
>>    *
>>    * Returns:
>> - * A pointer to the scatter/gather table of pinned pages or NULL on
>> failure.
>> + * A pointer to the scatter/gather table of pinned pages or errno on
>> failure.
> 
> ', or an ERR_PTR()-encoded errno code on failure'
> 
>>    */
>>   struct sg_table *drm_gem_shmem_get_sg_table(struct
>> drm_gem_shmem_object *shmem)
>>   {
>> @@ -688,7 +688,8 @@ EXPORT_SYMBOL_GPL(drm_gem_shmem_get_sg_table);
>>    * drm_gem_shmem_get_sg_table() should not be directly called by
>> drivers.
>>    *
>>    * Returns:
>> - * A pointer to the scatter/gather table of pinned pages or errno on
>> failure.
>> + * A pointer to the scatter/gather table of pinned pages
>> ERR_PTR()-encoded
> 
> ', or an' before ERR_PTR
> 
> With the improved grammar:
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks, something went wrong with these comments in this patch and I
haven't noticed that :)

