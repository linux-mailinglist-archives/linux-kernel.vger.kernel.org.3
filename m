Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA844A2B59
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 03:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352256AbiA2C4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 21:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiA2C4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 21:56:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955DEC061714;
        Fri, 28 Jan 2022 18:56:37 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c190-20020a1c9ac7000000b0035081bc722dso5284427wme.5;
        Fri, 28 Jan 2022 18:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=0wA1bSjpr2MlmYkJcC53Ec+AcC37OXjp4rcmLeTeR84=;
        b=YU/aftvtmRgn1wce4ABwmW5NTCA5ceQfc7kRFSiED80ZYT22qJ3wORxd5Fmbz3hwN0
         d4y88RUACVxWxNrDqG8oqHd/5JyBt72tay7sG33BurBxdpKarlxTM5FDgzLwqcQ91/S0
         MaOwP1zHjMwLud1l40qrgCgNUbyH7jDagmgVIcUNg6qP0lYalTC18WP6Vtf+0/j3ajkd
         O8liNSGRThlXrG7nH5eNKDReTp/hOtS5LgSZMngk3ktf+S8fz3w0QvW7kYdupxpAXzqV
         RHDJaIdGmSK1t2/m5zoWENXnhs0zrImC7pLoK1Z5Zf+hPAFk439DBLUrmUgSVS0IHy+2
         RmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=0wA1bSjpr2MlmYkJcC53Ec+AcC37OXjp4rcmLeTeR84=;
        b=Ai0hNaG2YKP8L/uDqlzymxoapewd4rxYihRj43b7w/r+z/yIH6HZTuHoA7qm6ebCGM
         hiAgTEHm62trZhbauf4juZtAUttUH4c+IaidlWhGeR2ujUHNzLre68GqBzdggA8bvklf
         9PeDg4rUDFUqzlqtCEzoD8PoGzCpj4y0MvuEj+jRNyoF+e7mpAM+8ES8QOy4nC3j1Idf
         NpysL+FAzYEup8D+Bai3ZXV16BVuYB2Nkmi9pWBoxxbpOZFulgBC7Ws4LITIoj2QFXl+
         0DPqpSRbh+8HWk8DxrzUU3hAJsIM3fMtzq9sFPoV7nZU4yxYaWgjMdX1zV6JLvGtpnxR
         UxsA==
X-Gm-Message-State: AOAM533eU/HKL6jH6V6OmFywr5QqWml/ofQH9l0A/9dLunS7xaU3GzB+
        s4msY0s38IRCfGkKpvjsIsL0gMqL2UU=
X-Google-Smtp-Source: ABdhPJxnrONXYobrnSs3KJduAsnjgPQpIBqaN7XV1DST+dneOEWI8QdPgQ2SJTGZAlVwqPjPwKYTBw==
X-Received: by 2002:a05:600c:4f8d:: with SMTP id n13mr17749204wmq.45.1643424995853;
        Fri, 28 Jan 2022 18:56:35 -0800 (PST)
Received: from [10.150.0.6] ([64.64.123.23])
        by smtp.gmail.com with ESMTPSA id j2sm3575540wms.2.2022.01.28.18.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 18:56:35 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] bus: mhi: possible deadlock in mhi_pm_disable_transition() and
 mhi_async_power_up()
To:     mani@kernel.org, hemantk@codeaurora.org, bbhatt@codeaurora.org,
        loic.poulain@linaro.org, jhugo@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <d3a94b53-0d77-dafe-ce45-f9ab23278616@gmail.com>
Date:   Sat, 29 Jan 2022 10:56:30 +0800
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

My static analysis tool reports a possible deadlock in the mhi driver in 
Linux 5.10:

mhi_async_power_up()
   mutex_lock(&mhi_cntrl->pm_mutex); --> Line 933 (Lock A)
   wait_event_timeout(mhi_cntrl->state_event, ...) --> Line 985 (Wait X)
   mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 1040 (Unlock A)

mhi_pm_disable_transition()
   mutex_lock(&mhi_cntrl->pm_mutex); --> Line 463 (Lock A)
   wake_up_all(&mhi_cntrl->state_event); --> Line 474 (Wake X)
   mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 524 (Unlock A)
   wake_up_all(&mhi_cntrl->state_event); --> Line 526 (Wake X)

When mhi_async_power_up() is executed, "Wait X" is performed by holding 
"Lock A". If mhi_pm_disable_transition() is concurrently executed at 
this time, "Wake X" cannot be performed to wake up "Wait X" in 
mhi_async_power_up(), because "Lock A" is already hold by 
mhi_async_power_up(), causing a possible deadlock.
I find that "Wait X" is performed with a timeout, to relieve the 
possible deadlock; but I think this timeout can cause inefficient execution.

I am not quite sure whether this possible problem is real and how to fix 
it if it is real.
Any feedback would be appreciated, thanks :)


Best wishes,
Jia-Ju Bai



