Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E555D5749DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiGNJ6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbiGNJ5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:57:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC515070A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:57:29 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5C7D466015C4;
        Thu, 14 Jul 2022 10:57:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657792648;
        bh=6A7jlNFQV7zpINshdRhbgIXSYTrsbgjrxM+lIjl49GE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=ma2noRfzm7fXHl/oRJSU2uGQjvQStZST3MSz3XPKbZcSSytj5qtZEdNYlXwXj/hYU
         QUwI+5SfCyddMB0/jCw19TimQDZZQOavLuA1FWcBBBV2tgwNN7gMGWHmk7D85A/uIr
         vKwFOF8YQ2joCoJinFl+XQTuFYzzQ5dUv9WXtfNqAynFavlChAhL1LEJKJGyWyaBRV
         hqq2wyTcLjIdCSexRD4aCjNl0nHqodGGn3eHArI8qJBhbwWqTbaJ5Oue3g5moxHa38
         Hyo4TosWKsEW3YLPVFqaYZ8uIUqF9A8naw6G7piTtOGxON7dJaVyUIn/ZIdlqL93qg
         4djw4yGzQf7qg==
Message-ID: <6e0c7590-6ffb-162b-a98d-0a39333453f6@collabora.com>
Date:   Thu, 14 Jul 2022 12:57:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1] drm/scheduler: Don't kill jobs in interrupt context
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Erico Nunes <nunes.erico@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>
References: <20220411221536.283312-1-dmitry.osipenko@collabora.com>
 <a78343c8-2a6d-b223-4219-6b6b0a4fcb1f@arm.com>
 <CAK4VdL2hCEoshWZbCh5mkHuS6wYMiPFR3v4MWTnrEKM9zyv6Mw@mail.gmail.com>
 <ef88ec2c-77b5-fa0d-49d1-fdd2451713b7@collabora.com>
 <573fae0d-c9ab-98b0-c6f1-5b0d4e52dd01@amd.com>
 <a33ab7b9-738f-db91-f6ba-78a9641365e8@amd.com>
 <b05f9861-1966-72f5-132b-aebb4b6e0c6b@collabora.com>
 <107fe968-8311-0511-cc31-22feb994a6d7@collabora.com>
 <3e07a8d0-2cbc-8f3e-8f9f-5b73fb82028b@amd.com>
 <CADnq5_MMmeWkiMxjYfrG7pip8BEkbkRc8ADUDLEi++kRF76sqg@mail.gmail.com>
 <bff42c98-045d-2e5a-2cf9-eb563425375e@collabora.com>
In-Reply-To: <bff42c98-045d-2e5a-2cf9-eb563425375e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 11:56, Dmitry Osipenko wrote:
> On 7/6/22 18:46, Alex Deucher wrote:
>> On Wed, Jul 6, 2022 at 9:49 AM Andrey Grodzovsky
>> <andrey.grodzovsky@amd.com> wrote:
>>>
>>> On 2022-07-06 03:07, Dmitry Osipenko wrote:
>>>
>>>> Hello Andrey,
>>>>
>>>> On 5/17/22 17:48, Dmitry Osipenko wrote:
>>>>> On 5/17/22 17:13, Andrey Grodzovsky wrote:
>>>>>> Done.
>>>>>>
>>>>>> Andrey
>>>>> Awesome, thank you!
>>>>>
>>>> Given that this drm-scheduler issue needs to be fixed in the 5.19-RC and
>>>> earlier, shouldn't it be in the drm-fixes and not in drm-next?
>>>
>>>
>>> I pushed it into drm-misc from where it got into drm-next. I don't have
>>> permission for drm-fixes.
>>
>> The -fixes branch of drm-misc.
> 
> Now I don't see the scheduler bugfix neither in the -fixes branch nor in
> the -next and today Dave sent out 5.19-rc7 pull request without the
> scheduler fix. Could anyone please check what is going on with the DRM
> patches? Thanks!
> 
> https://github.com/freedesktop/drm-misc/commits/drm-misc-fixes
> https://cgit.freedesktop.org/drm/drm-misc/log/?h=drm-misc-fixes

The patch is in the drm-misc-next-fixes, so it wasn't moved to the
drm-misc-fixes.

Andrey, don't you have access to drm-misc-fixes? Or you meant
drm-fixes=drm-misc-fixes?

-- 
Best regards,
Dmitry
