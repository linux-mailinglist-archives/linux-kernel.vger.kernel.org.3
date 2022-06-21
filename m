Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7959E55380D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353988AbiFUQkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353383AbiFUQjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:39:51 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475B51C107;
        Tue, 21 Jun 2022 09:39:30 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s10so16085292ljh.12;
        Tue, 21 Jun 2022 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mhIiUkoVFz0wPW9tQouAUPqb2d9trqlO1mA9uf8w0Ks=;
        b=FIjnHKZ++BZwbnW/IETfzzE9HdfruXLMCZ2afU8f8Ol9x8E7l51cySVPm4KWm5juQG
         gvX77m5NrkZGy6opdeOW3LRwfEVZD3UiZOrJaMZQjx5mhQWDWWBzAgbL+4P6dmqW4Ybr
         pnJWoWI7QHQJSteAPaPBGKo0nX8KMOGEJJStZWmxp4DZK/wrdSA5PXIfblpzcGzawRa1
         MeB9sdH+if74n2gTXbLRxglLSaNkv5FQLHhjr8l1loJCZtcGUyvXakvtZV7uSTRiacct
         DlG37LBGraBOSPqB4o8FlEBG3UbFB1lHDbrO6892U8ZlIb6y/14e/lKA5JIfPI67jtMv
         Uu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mhIiUkoVFz0wPW9tQouAUPqb2d9trqlO1mA9uf8w0Ks=;
        b=TxdL8F/6NPd303tIJ8YeoHX5EUUNqfu8DhQU66Pbw4hpZCdhF2qTSFAhQIw1uiAPZ9
         lTvNQPX8qdw+LnaaB0Dtu0uWJzZdZT2OgP0vpaV4wqDe94mXLW/ZVhlMWAftpVcK4cty
         bPa8B8sid+NMP6QfVlqnmDs7HwxQ2+UQ253VhaUxyrq+hTKDbS6RuSzPRXnPcatxSAh/
         3RkR/GF03ViZSxXJ8m6Y/AN3EOjt+Uvu9WzBQ+ugrcWn+p/hhiiBDgSyduual7JlTQOW
         V4YpzYg5knYKam0DuT8IBE66LvYCb7yT1baqxX5ix9drdVRJWIb9B9ftssbdlkNo4Xe0
         O4Ig==
X-Gm-Message-State: AJIora94dO/37qy/99ItgO/KHUR31dJHauIo7tvfxbgJd3sErPDH1biO
        +0AdvisoSP5XsiZmhx3SoIk=
X-Google-Smtp-Source: AGRyM1tTeVIJS0PV6ghwi5oLN82VfE9B8lRb5DRIlTC+FNYEK1w9sU215ZQ3z+wF7iT6GuEnyQM6mw==
X-Received: by 2002:a05:651c:160a:b0:25a:62a4:9085 with SMTP id f10-20020a05651c160a00b0025a62a49085mr8422999ljq.214.1655829568510;
        Tue, 21 Jun 2022 09:39:28 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-92.dynamic.spd-mgts.ru. [109.252.136.92])
        by smtp.googlemail.com with ESMTPSA id y19-20020a2e3213000000b0025a69521bbdsm1106096ljy.121.2022.06.21.09.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 09:39:27 -0700 (PDT)
Message-ID: <c1d7b5f0-32e0-df37-e447-c525e3a84253@gmail.com>
Date:   Tue, 21 Jun 2022 19:39:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 17/22] drm/shmem-helper: Add generic memory shrinker
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
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
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Qiang Yu <yuq825@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kernel@collabora.com
References: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
 <20220526235040.678984-18-dmitry.osipenko@collabora.com>
 <CAF6AEGt=EqeF+3UaYjxQCCFEabRFJwLbiWN9brGveYoHTYyZ7w@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <CAF6AEGt=EqeF+3UaYjxQCCFEabRFJwLbiWN9brGveYoHTYyZ7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.06.2022 18:37, Rob Clark пишет:
>> +static unsigned long
>> +drm_gem_shmem_shrinker_scan_objects(struct shrinker *shrinker,
>> +                                   struct shrink_control *sc)
>> +{
>> +       unsigned long nr_to_scan = sc->nr_to_scan;
>> +       bool lock_contention = false;
>> +       unsigned long freed;
>> +
>> +       /* purge as many objects as we can */
>> +       freed = drm_gem_shmem_shrinker_run_objects_scan(shrinker, nr_to_scan,
>> +                                                       &lock_contention, false);
>> +
>> +       /* evict as many objects as we can */
>> +       if (freed < nr_to_scan)
> oh, one other small note, both in scan_objects() and count_objects(),
> you should check that get_nr_swap_pages()>0 before counting
> evictable/willneed objects.  (And you probably want to keep separate
> LRUs for dontneed vs willneed to accomplish that.)  At least for CrOS,
> inside the VM there is no swap enabled (but instead we rely on zram
> swap in the host.. plus vm-balloon to balance memory pressure between
> host and guest)

Noted, thank you!
