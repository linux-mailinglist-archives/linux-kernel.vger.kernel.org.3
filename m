Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB70568BFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiGFO5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiGFO5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:57:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FD3A1B0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:57:31 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E876366019AA;
        Wed,  6 Jul 2022 15:57:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657119449;
        bh=gKKVNdBjcN8KkoeprOxQ8ffGlP7W2ucwq70DNkoi0pM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AFo5SHqa1+b4dKZSAM5aDazw8Dg2FSqMDEb3VHe4xH5gT2saeZZZURl7+B4fIuO7W
         YFfBEEN4fNQmNUyiudA4KYXf+8e7c8bOOjy/hoVWKs8W1XSCJ3qmtfYpXtJFWmswcI
         an0mMfgGHr9fFc2LS2KrBOhUoH2qUxqsZxx3/SjV3lzhtfX1qujv2JEgNOFzsKa0HO
         XhOVOWY4yr6+GasG6QxhB4zXKuMAJ3RdbwDectgJ0Kmyj0zZ7gE6OfzvwcAvEGIm37
         lHf8Lw66AuZovpAJ0Cxwdn2UsegQD/cvnZsJ5LP9C3PTgqzsIbE6uoCrNZa3wOPj/9
         MimulBF98GOog==
Message-ID: <4cb8ef00-1b8a-7ef0-aa4c-be0912aba496@collabora.com>
Date:   Wed, 6 Jul 2022 17:57:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1] drm/scheduler: Don't kill jobs in interrupt context
Content-Language: en-US
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        Steven Price <steven.price@arm.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20220411221536.283312-1-dmitry.osipenko@collabora.com>
 <a78343c8-2a6d-b223-4219-6b6b0a4fcb1f@arm.com>
 <CAK4VdL2hCEoshWZbCh5mkHuS6wYMiPFR3v4MWTnrEKM9zyv6Mw@mail.gmail.com>
 <ef88ec2c-77b5-fa0d-49d1-fdd2451713b7@collabora.com>
 <573fae0d-c9ab-98b0-c6f1-5b0d4e52dd01@amd.com>
 <a33ab7b9-738f-db91-f6ba-78a9641365e8@amd.com>
 <b05f9861-1966-72f5-132b-aebb4b6e0c6b@collabora.com>
 <107fe968-8311-0511-cc31-22feb994a6d7@collabora.com>
 <3e07a8d0-2cbc-8f3e-8f9f-5b73fb82028b@amd.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <3e07a8d0-2cbc-8f3e-8f9f-5b73fb82028b@amd.com>
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

On 7/6/22 16:49, Andrey Grodzovsky wrote:
> On 2022-07-06 03:07, Dmitry Osipenko wrote:
> 
>> Hello Andrey,
>>
>> On 5/17/22 17:48, Dmitry Osipenko wrote:
>>> On 5/17/22 17:13, Andrey Grodzovsky wrote:
>>>> Done.
>>>>
>>>> Andrey
>>> Awesome, thank you!
>>>
>> Given that this drm-scheduler issue needs to be fixed in the 5.19-RC and
>> earlier, shouldn't it be in the drm-fixes and not in drm-next?
> 
> 
> I pushed it into drm-misc from where it got into drm-next. I don't have
> permission for drm-fixes.

Thank you

-- 
Best regards,
Dmitry
