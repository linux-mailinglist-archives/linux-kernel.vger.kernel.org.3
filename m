Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAF846E14D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 04:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhLIDfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 22:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhLIDfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 22:35:41 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9CAC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 19:32:08 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n26so4212493pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 19:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=n5D9j62aLJ1+fG9wTsNvAoJm0MnkmZ9E3fqfoRqVqgQ=;
        b=d2n0WLemxkM3AvTgShubVt87nB+MoNU0jWskn97Aro1M162OelQj920qEtdAPJFuCz
         Dne49bZ1dZUxJadgF2Fu6723qU9Ymk9zt1VT3Oy6dp2dCDNc7/v2r0URxOlf+yWa9Pni
         Yw2R2Noffb/h4Y1+Vop1QSNE8ZIG4bCX1RNJlY7ZH8UqaA1saVBoVvQGAvbu3zWN5egA
         xzcWsWRDf33Y7SHBey0sLvk1PUn32vF1IAv2bocMSj8HR5iD4gd4QefbAxohIZhAURTT
         wVYyvibZqKtG5syR0ZOxOVu8tgysKHW68yVFqI5vU4nGczBQ31LC3fVM4xyv+zh4ctgZ
         IqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=n5D9j62aLJ1+fG9wTsNvAoJm0MnkmZ9E3fqfoRqVqgQ=;
        b=mBxHVvF9Tij67SxojHhFtJPQZwmcVRufDKB0mmDd6xjUo56EspVP7o8FXB3G61nxjM
         YtVaLaoRqmoSdP4mte8Ld3jg1JV3xanymFCe0ZVEGWSKGAUNL9tGUhmUtEb1wNGrHzgM
         QkzeuuQ6S5jN8XVFtqvCUsTFbiZlKQs/wvdhS2SRfTBMUBU+6TjqAP2Sqriz+Mu9hkwV
         SUAXi4NurTVnQC7T+s95B9uIJTznw0P2DJO38mtsviXfOzAY5pv9nNZZl+F2eBDYXpTK
         y7lrTbO1NtqF6mQCyi67Tzst7nFDItzaZgOVv7qGMTMJ+vuQx+bp/lAaqAIkR04l+7Fd
         Q92g==
X-Gm-Message-State: AOAM531w1bnoLRqAj9JJErHNJue+EY8TYG2UEg5sanUYkf+TRMSRAHni
        TI7/U36FAiTcgUT9nuqLlj7IzWbpraE=
X-Google-Smtp-Source: ABdhPJw6hmO7CntdCxZ8lHNThS3s1rc6zaJgR0zqgXiUGoiyuHnsrm0RNM0XpMkJkiO3j1rKXJSh9A==
X-Received: by 2002:a63:f749:: with SMTP id f9mr32031978pgk.330.1639020728016;
        Wed, 08 Dec 2021 19:32:08 -0800 (PST)
Received: from [183.173.151.43] ([183.173.151.43])
        by smtp.gmail.com with ESMTPSA id f8sm5423951pfc.77.2021.12.08.19.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 19:32:07 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] gpu: drm: possible ABBA deadlock in
 drm_gem_prime_fd_to_handle() and drm_gem_prime_handle_to_fd()
To:     maarten.lankhorst@linux.intel.com,
        Maxime Ripard <mripard@kernel.org>, tzimmermann@suse.de,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <ae29d7e4-2794-7d4e-becc-fccb576a706e@gmail.com>
Date:   Thu, 9 Dec 2021 11:32:05 +0800
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

My static analysis tool reports a possible ABBA deadlock in the drm 
driver in Linux 5.10:

drm_gem_prime_fd_to_handle()
   mutex_lock(&dev->object_name_lock); --> Line 313 (Lock A)
   drm_gem_handle_delete()
     drm_gem_object_release_handle()
       drm_gem_remove_prime_handles()
         mutex_lock(&filp->prime.lock); --> Line 16 (Lock B)

drm_gem_prime_handle_to_fd()
   mutex_lock(&file_priv->prime.lock); --> Line 433 (Lock B)
   mutex_lock(&dev->object_name_lock); --> Line 466 (Lock A)

When drm_gem_prime_fd_to_handle() and drm_gem_prime_handle_to_fd() are 
concurrently executed, the deadlock can occur.

I am not quite sure whether this possible deadlock is real and how to 
fix it if it is real.
Any feedback would be appreciated, thanks :)

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai

