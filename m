Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228CC4E9B22
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbiC1PcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiC1PcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:32:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F45D18B;
        Mon, 28 Mar 2022 08:30:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id p15so29459602ejc.7;
        Mon, 28 Mar 2022 08:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p3XuvSz9El6nko432TGNXkjhObeuwCH/Ie6ye/gIxy8=;
        b=IIz4FdV0mOAafEMr4USQHNy+IBB8W1SLxNvpY/qmwe2L60jIkh+BtkZhRLusE+9byJ
         VVOGC3zinYbOUHGmsCd3rVC2X3mzOikYzWwgTARQiJoLNejLG6UtsmsOLYNWwa5xebSl
         LNl2I+j4OF8XLi8+9lnxeCIEzt7rAW/BtqIbKaPUf0iApZt76Mbpehd2wRQJCk5yR+QI
         8NZpda1g8E03N2qz7Oh7iXrTozXwVZMMJ3MgtA6bpR25EguMNLOn8u0iMynemdSUOket
         6XSWVQ87FGvnAm7+rdyebHF81x9Q1Xf03LzPHMmJiMMQqQsFNEYlNbGAWHzzK9cZeSNW
         3Lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p3XuvSz9El6nko432TGNXkjhObeuwCH/Ie6ye/gIxy8=;
        b=JAqN2ruLwtMeJyavhf1AGyRb1bh/zGZjY5VuWv70KNDlM1BOFPC7ghhF8uWGru8qJt
         jSV3VZuQ1E0p73NQpC1ex5lngI4kSkhEoiYIVQ+CTEks733QydptkXmU2cogVANTUT5k
         JzTgg2OF8GC6ZjiVsXx8PxmJHZg6K3k2bcYhN/v57VB37qt8NPWEZExKDWDjrgx3uY2/
         yrV+HoqmHO/OKGrfcXcpj3tox9IfcgmRbR+BSlIP0pUVQgU9/4HixcFlf8kDfgDhZ8jo
         986paEn2zsvYQ6DGn1WXuKGFtXQ+pWJAD5JbOUudDoBQLhN/YUnoQeinEeohpxdfWnJA
         9Utg==
X-Gm-Message-State: AOAM5315gscQJaAeg2qeA4U0bm90VK9wPCWSWFnEryVoYUZX0ZtVnGMG
        tE9luG+F+WpReVM5YZJJmKE=
X-Google-Smtp-Source: ABdhPJzTNnMXRuknjU+f0aWqPcOk/WgtWC3qwlzaCIcEolJcpttqYGy3tEe+3vYytAaiM+K47vsWvQ==
X-Received: by 2002:a17:907:d02:b0:6e0:4f1d:7ab1 with SMTP id gn2-20020a1709070d0200b006e04f1d7ab1mr27848220ejc.716.1648481430084;
        Mon, 28 Mar 2022 08:30:30 -0700 (PDT)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id bx5-20020a0564020b4500b00418fca53406sm7022210edb.27.2022.03.28.08.30.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Mar 2022 08:30:29 -0700 (PDT)
Subject: Re: [PATCH 0/3] drm: omapdrm: Fix excessive GEM buffers DMM/CMA usage
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, merlijn@wizzup.org, tony@atomide.com,
        airlied@linux.ie, daniel@ffwll.ch
References: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <e126b6a7-5c34-66d5-d371-b2bae3b94924@ideasonboard.com>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <653c8cf1-8644-f5cb-810e-81539a99d776@gmail.com>
Date:   Mon, 28 Mar 2022 18:30:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e126b6a7-5c34-66d5-d371-b2bae3b94924@ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28.03.22 г. 12:46 ч., Tomi Valkeinen wrote:
> Hi,
> 
> On 19/01/2022 12:23, Ivaylo Dimitrov wrote:
>> This patch series fixes excessive DMM or CMA usage of GEM buffers 
>> leading to
>> various runtime allocation failures. The series enables daily usage of 
>> devices
>> without exausting limited resources like CMA or DMM space if GPU 
>> rendering is
>> needed.
>>
>> The first patch doesn't bring any functional changes, it just moves some
>> TILER/DMM related code to a separate function, to simplify the review 
>> of the
>> next two patches.
>>
>> The second patch allows off-CPU rendering to non-scanout buffers. 
>> Without that
>> patch, it is basically impossible to use the driver allocated GEM 
>> buffers on
>> OMAP3 for anything else but a basic CPU rendered examples as if we 
>> want GPU
>> rendering, we must allocate buffers as scanout buffers, which are CMA 
>> allocated.
>> CMA soon gets fragmented and we start seeing allocation failures. Such 
>> failres
>> in Xorg cannot be handeled gracefully, so the system is basically 
>> unusable.
>>
>> Third patch fixes similar issue on OMAP4/5, where DMM/TILER spaces get
>> fragmented with time, leading to allocation failures.
>>
>> Series were tested on Motolola Droid4 and Nokia N900, with OMAP DDX and
>> PVR EXA from https://github.com/maemo-leste/xf86-video-omap
>>
>> Ivaylo Dimitrov (3):
>>    drm: omapdrm: simplify omap_gem_pin
>>    drm: omapdrm: Support exporting of non-contiguous GEM BOs
>>    drm: omapdrm: Do no allocate non-scanout GEMs through DMM/TILER
>>
>>   drivers/gpu/drm/omapdrm/omap_gem.c        | 198 
>> +++++++++++++++++-------------
>>   drivers/gpu/drm/omapdrm/omap_gem.h        |   3 +-
>>   drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c |   5 +-
>>   3 files changed, 116 insertions(+), 90 deletions(-)
>>
> 
> I have pushed this to drm-misc-next.
> 

Great, next is VRFB and TE support for Droid4 panel, as soon as I find 
some spare time :)

Ivo

