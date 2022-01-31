Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FBC4A4C48
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380545AbiAaQiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378272AbiAaQiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:38:17 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE67C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:38:17 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id z19so27931087lfq.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AIOLUSIJu0tNp0OuaV9P5L9B3qaObFHnZycKiVkaU1A=;
        b=64X94uv2GH6qSSKTOedtresZbziebe8LNz//gjVK5gXLXntHF6gFaSY2yq9aSpj3fl
         q+Scl/+1/aE58Fnf0PmqwEmDzMztFQulvCQmY1kcKd5/pekrhvDwi1EfDaDA2a6bqW1v
         7Ly3w260lrbuYKkvVH5sRXcHzRRIdW03HgvFRVcj9vZ/y6zZCqreLokXL3AXqbyF9LmU
         sdhVHteMGk2zR7r9Tc+dBwkGTcS7y4HkYycT1xARbt/MjFyL7Tt3JGPtXr2a7iQETSGn
         RHFeF9j+NZvss75Gb+Z0Y9kem8rsYZ79mDBYvBKhR4L9ff84UUPKcxv+gicOYEM+UK4I
         Njtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AIOLUSIJu0tNp0OuaV9P5L9B3qaObFHnZycKiVkaU1A=;
        b=AGiYzo0snJce1MLxSelXScIAWRwcv15aRbesURX1E4myorSnLyn2KVcXXvZxNqE27Y
         bnJLbos+Z9fTI7PiIM4DYR/Ki154kNDaur3SCIVVKxwqmYyfT2fhQEDfOgMZR1J69Jck
         XhsLtUlVSKm2iby+TLyE5P3LqoGrC1ZVqXfKzzaGIOmlItAlwcYwmx+DBZqwgeiDRiHL
         Bi1TJ/1wVZKN0NBZlD6nOY6BY2klxtlxNUh5D4BZgoV2zui/D6JLevDV3col8gzB12Mb
         JGfKO3B1afoHkn+CLZBh9Z+W1JZtwUxzfijHHNHaiCbttuFMPFbBz/+WjBKN2yWUbupJ
         kB/g==
X-Gm-Message-State: AOAM530fGebTu0qA0d4f01J51bOU2zW1EbXZAQ3XK0g60v28YfqW+Sjf
        1A24GfcqDzCy6ytcLCFp6nw94U/kNKaPcw==
X-Google-Smtp-Source: ABdhPJyoCcErQX0vsg98FdoDAMuRvyMa+2GRoObUDbZMEQ+bUB/ipXLT4CCABJpkI1hQHUdkoPexXg==
X-Received: by 2002:a05:6512:3e18:: with SMTP id i24mr15837511lfv.522.1643647095637;
        Mon, 31 Jan 2022 08:38:15 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id r14sm3704681lfr.129.2022.01.31.08.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 08:38:14 -0800 (PST)
Message-ID: <a7d0b013-6114-07b3-0a7b-0d17db8a3982@cogentembedded.com>
Date:   Mon, 31 Jan 2022 19:38:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/bridge_connector: enable HPD by default if supported
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211225063151.2110878-1-nikita.yoush@cogentembedded.com>
 <Yczy3UYpU2UMFQ6N@pendragon.ideasonboard.com>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <Yczy3UYpU2UMFQ6N@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hotplug events reported by bridge drivers over drm_bridge_hpd_notify()
>> get ignored unless somebody calls drm_bridge_hpd_enable(). When the
>> connector for the bridge is bridge_connector, such a call is done from
>> drm_bridge_connector_enable_hpd().
>>
>> However drm_bridge_connector_enable_hpd() is never called on init paths,
>> documentation suggests that it is intended for suspend/resume paths.
> 
> Hmmmm... I'm in two minds about this. The problem description is
> correct, but I wonder if HPD should be enabled unconditionally here, or
> if this should be left to display drivers to control.
> drivers/gpu/drm/imx/dcss/dcss-kms.c enables HPD manually at init time,
> other drivers don't.
> 
> It feels like this should be under control of the display controller
> driver, but I can't think of a use case for not enabling HPD at init
> time. Any second opinion from anyone ?

Hi.

Can we somehow move forward here?..
