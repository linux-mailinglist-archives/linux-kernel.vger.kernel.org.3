Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75D34A2B71
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 04:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352295AbiA2Dde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 22:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbiA2Ddc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 22:33:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F799C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 19:33:32 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c23so14417794wrb.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 19:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=MEEV8WH7gcIBaywuZqpSloW8+fQPmSsXYorwBGkwcEQ=;
        b=ft1K6ec+bpsSUrO6sHzilNhZI5D7ygOV6cUs23pfaPUJ86HDBgX0unZVVHu1tlpSzV
         S3HLok9V9mqEFkQpws5xw3ogn4wQonCdzOjENUWOUKy8jo4+t3fYvLRvRDxuVO+D/A8n
         uVVH1VpoDrgOPq8e6nNviJBhGUMnUUFf351smOMUpH42GpfGrQUlo0HiNEt2nPCdDija
         Nq1cTeDQUAxClEhhGfdNvCub+wDMVFSBMW86P6wTCiyT0VBQQyrZ/86VMrYpRGJ/eYAN
         FSNbmr2PQVAZT2m7sVIM3lcR8LHGZiXTF1Eg54+4IXZ+i/y0eIvKSj1+PNMrNzT/eDp0
         Bv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=MEEV8WH7gcIBaywuZqpSloW8+fQPmSsXYorwBGkwcEQ=;
        b=qV5bbmOlw5qPl7I8S8gH79zffgbrRabGbmgrte/1jDpYiCmantQ5MiDz3Y4lbCItKT
         rffOMNfOpgvFtwMiYN1m75IwT8kFyiEwH8De+uVEo5Nflq4JNIjnmNqZxgPoXtJkCn8N
         y8+g0b50V31P60GILrqppvAMIhkt9R1UhEUhDNa4MYvWHP2U+iCUECqXetTFcBnZWmtP
         WNgyqOQv3N3xmHEVHDhV5hkckt4xo6CCsiuSt3HAJVMf9lMfqNM4mYM4dc6iqS9qdWx1
         NPheYCVCCFSNsnp1EY55AlBRn2MYT7oCyBNdNre25nuiMfbgxg/mMhogbmRQsXQeDV/H
         QlDA==
X-Gm-Message-State: AOAM530gPm0OUVX5IFlnnCF/pJNDsc7GAuLGjU/h6291cyuKLuK97i6U
        17OPLOfl5PXpqEuv4tL8qAl700Uvy2k=
X-Google-Smtp-Source: ABdhPJyiMDc7MH6tbWAjV3Be75ZoFQZE5hbcKQdm0LjQKmgM7IzYGTiitEr0vIiW8lRjpb0lPUKvKQ==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr9289806wrs.626.1643427210591;
        Fri, 28 Jan 2022 19:33:30 -0800 (PST)
Received: from [10.96.0.6] ([85.203.46.187])
        by smtp.gmail.com with ESMTPSA id j19sm3551042wmq.17.2022.01.28.19.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 19:33:30 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] ALSA: core: possible deadlock involving waiting and locking
 operations
To:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        o-takashi@sakamocchi.jp
Cc:     alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <56766037-972e-9e5b-74c1-88633a72a77f@gmail.com>
Date:   Sat, 29 Jan 2022 11:33:26 +0800
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

My static analysis tool reports a possible deadlock in the sound driver 
in Linux 5.10:

snd_card_disconnect_sync()
   spin_lock_irq(&card->files_lock); --> Line 461 (Lock A)
   wait_event_lock_irq(card->remove_sleep, ...); --> Line 462 (Wait X)
   spin_unlock_irq(&card->files_lock); --> Line 465 (Unlock A)

snd_hwdep_release()
   mutex_lock(&hw->open_mutex); --> Line 152 (Lock B)
   mutex_unlock(&hw->open_mutex); --> Line 157 (Unlock B)
   snd_card_file_remove()
     wake_up_all(&card->remove_sleep); --> Line 976 (Wake X)

snd_hwdep_open()
   mutex_lock(&hw->open_mutex); --> Line 95 (Lock B)
   snd_card_file_add()
     spin_lock(&card->files_lock); --> Line 932 (Lock A)
     spin_unlock(&card->files_lock); --> Line 940 (Unlock A)
   mutex_unlock(&hw->open_mutex); --> Line 139 (Unlock B)

When snd_card_disconnect_sync() is executed, "Wait X" is performed by 
holding "Lock A". If snd_hwdep_open() is executed at this time, it holds 
"Lock B" and then waits for acquiring "Lock A". If snd_hwdep_release() 
is executed at this time, it waits for acquiring "Lock B", and thus 
"Wake X" cannot be performed to wake up "Wait X" in 
snd_card_disconnect_sync(), causing a possible deadlock.

I am not quite sure whether this possible problem is real and how to fix 
it if it is real.
Any feedback would be appreciated, thanks :)


Best wishes,
Jia-Ju Bai
