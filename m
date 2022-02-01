Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3414A57E6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiBAHkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbiBAHk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:40:29 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A20C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:40:28 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u11so14666884plh.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=SGj9JOZOXXgNtUDRvOLvflNgqKK7vcnNbFrla5kWCKY=;
        b=HIlMLw6Bavjhij3LFseBLkQcqZ3YtaepttclOGF5d4rpm/iy3NiHIqZRvP/ZM9Xns1
         gjJmmp3nwlO5oS9+klLmAy3SxtRMjANEhwrGORm6tYLKVqJx1Fz9M+6a3Dqm8swFZ8Nw
         WQiSbqhvJNXa0dio3ZYUF4Ke09jAII/JFLLuOZ9XGjpuNAgnUpaV49XluTt++n7/Yu7Z
         EXsZKtEOUa8wItpMU9NLOZBGJk/dF0uCmK67txg9A58OF7rTRbYlhBphNO2pwjwb4ovH
         CIQVWAg9eLBopT3Rn51YpZ732Jn9LgpBRi+2HQXF3WxGwHracYFOM7BJx+jTrW+zK+mb
         tGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=SGj9JOZOXXgNtUDRvOLvflNgqKK7vcnNbFrla5kWCKY=;
        b=ERFh8htkrlx0Kw1yIKzG/QgvgWG8krjbvxXZRse5zhR1R/iWEBT6FtH5+4cEK11O8Y
         dAGWd33qaSF6kGA+fS9/3Ko+G7uh6nyONRixB09ZbpItZM0GiksA6v1drqDkaX8PaitI
         dniwvufkLYLjfI2NbAmthXrSAZZetffGL68cSW/rvnH1vQAx4Wtc9CNFCOFhKnaR6jRC
         7U74SZ+E2+SvD9n02XwJY8Ec1/uNAk7nTupuHCq7UNBTIYh9IWjx9Pk2rSLIVrMTNgqW
         1/2IWHUyWi2oQLASPo9E4OGuywsp85v0ks5D4cqvpl0GoDt2qUZvGhz+gcFBCVouJrIh
         oPOg==
X-Gm-Message-State: AOAM532rPvTP/9TimzIwEuTUixYC7u3oW9vGp9sKCVXt02fC5IOkfxj6
        KOvU0PwPzN6eq4aLTVtJg2/UwFyu3Wg=
X-Google-Smtp-Source: ABdhPJx4vjRVsORMbUQucnv6qLo4yewajUBEplHgzuVDiDorxS65zYYg9m0Qgb54QqAI+xvCwvtKqw==
X-Received: by 2002:a17:90a:d203:: with SMTP id o3mr884699pju.122.1643701228233;
        Mon, 31 Jan 2022 23:40:28 -0800 (PST)
Received: from [10.59.0.6] ([85.203.23.80])
        by smtp.gmail.com with ESMTPSA id e14sm21254160pfv.219.2022.01.31.23.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 23:40:27 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] gpu: drm: radeon: two possible deadlocks involving locking and
 waiting
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <d5e4460f-7e26-81d2-2efe-6f47760b78d2@gmail.com>
Date:   Tue, 1 Feb 2022 15:40:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My static analysis tool reports a possible deadlock in the radeon driver 
in Linux 5.16:

#BUG 1
radeon_dpm_change_power_state_locked()
   mutex_lock(&rdev->ring_lock); --> Line 1133 (Lock A)
   radeon_fence_wait_empty()
     radeon_fence_wait_seq_timeout()
       wait_event_timeout(rdev->fence_queue, ...) --> Line 504 (Wait X)

radeon_ring_backup()
   mutex_lock(&rdev->ring_lock); --> Line 289(Lock A)
   radeon_fence_count_emitted()
     radeon_fence_process()
       wake_up_all(&rdev->fence_queue); --> Line 323 (Wake X)

When radeon_dpm_change_power_state_locked() is executed, "Wait X" is 
performed by holding "Lock A". If radeon_ring_backup() is executed at 
this time, "Wake X" cannot be performed to wake up "Wait X" in 
radeon_dpm_change_power_state_locked(), because "Lock A" has been 
already hold by radeon_dpm_change_power_state_locked(), causing a 
possible deadlock.
I find that "Wait X" is performed with a timeout MAX_SCHEDULE_TIMEOUT, 
to relieve the possible deadlock; but I think this timeout can cause 
inefficient execution.

#BUG 2
radeon_ring_lock()
   mutex_lock(&rdev->ring_lock); --> Line 147 (Lock A)
   radeon_ring_alloc()
     radeon_fence_wait_next()
       radeon_fence_wait_seq_timeout()
         wait_event_timeout(rdev->fence_queue, ...) --> Line 504 (Wait X)

radeon_ring_backup()
   mutex_lock(&rdev->ring_lock); --> Line 289(Lock A)
   radeon_fence_count_emitted()
     radeon_fence_process()
       wake_up_all(&rdev->fence_queue); --> Line 323 (Wake X)

When radeon_ring_lock() is executed, "Wait X" is performed by holding 
"Lock A". If radeon_ring_backup() is executed at this time, "Wake X" 
cannot be performed to wake up "Wait X" in radeon_ring_lock(), because 
"Lock A" has been already hold by radeon_ring_lock(), causing a possible 
deadlock.
I find that "Wait X" is performed with a timeout MAX_SCHEDULE_TIMEOUT, 
to relieve the possible deadlock; but I think this timeout can cause 
inefficient execution.

I am not quite sure whether these possible problems are real and how to 
fix them if they are real.
Any feedback would be appreciated, thanks :)


Best wishes,
Jia-Ju Bai

