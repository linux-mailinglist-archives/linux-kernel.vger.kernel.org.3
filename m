Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985B4466915
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376333AbhLBRbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376261AbhLBRbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:31:23 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAA2C06174A;
        Thu,  2 Dec 2021 09:28:00 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id m15so379136pgu.11;
        Thu, 02 Dec 2021 09:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tvudcEev7xISszO95MdRe4Yr6jFc+WirG9ojE2fb+ik=;
        b=GYpBgwN6LYJohSu0XM/pxJ1nprGvRx3m8qza1wG/Zs7dt8U44nX03uCX8fbD6SvSOc
         rDG6Fz6nzvvaBTKaNdAW2vy6GpX/3GTFchKSYEBen76/UY/+kVGNAfxKY0RCSSYyhT5v
         4NHvUCqzfCmrwsNuWoc0CWVedwzL1ljrRUe71/acVG4gE4zBj6tWTGqk5zEUX1lyvJqk
         4s+61WXy5HyPYwqU+TMP0xgYdrWCtjPVnAoB8KRnUQrmwOodTO/m5E538xsijvA3hZ6t
         QoEDjPc+d+lD3COv4mNOcO2MO3gG/WatZp6vLcIloyhUbOOjdC21EwpBD/MSmgQoUTk6
         greQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tvudcEev7xISszO95MdRe4Yr6jFc+WirG9ojE2fb+ik=;
        b=ysFvb/6u4dAc11/thMlKZWsU28+fU+jWNZ2zOEn+0W2zcugbVMhmssHtburL09Kl/p
         nssdcH0csHh3YHJAXN+bzWuyvRuEMJPo8T6dKo2fJFmgZN6Y9VPDmO3/a4IZoM3mBa2F
         SmtAA4iF7UFidqnVVwD2Zqa0f7q4agSeaxAVqDtGJTEht7DcQxqeA8DcIWX/MX4fcyNF
         Ogl+XBFhZW/q60/N6L8dmcgPXiSJGVux5uxfGHzMqfZMYVbjkfXpJqFs5mbVmffNsaGr
         H2tp0Q8Lg7KBNfbGY4Oko+ZSwmBI1IsilcRIKwB3ZcfYE1njiAiHh2QlZe0ynPg77xV+
         3QFQ==
X-Gm-Message-State: AOAM532BOAJgV7zqmdg+raMCdyxDc935VRQ5LUFN0S8++AVaGBjT9TEu
        IxtRpLkp0KksXD+UlHAqnEU=
X-Google-Smtp-Source: ABdhPJzonAKwsEJo/e1dzk/5cf0gim+ZTn6KbWnSRme1+Co4ApI9sEcIESzPO3bgse/PxcMyOZrZ0A==
X-Received: by 2002:a05:6a00:1513:b0:49f:fb34:85db with SMTP id q19-20020a056a00151300b0049ffb3485dbmr13940202pfu.66.1638466080020;
        Thu, 02 Dec 2021 09:28:00 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id mv22sm145883pjb.36.2021.12.02.09.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 09:27:59 -0800 (PST)
Subject: Re: [PATCH 1/2] mmc: sdhci-iproc: "mmc1: Internal clock never
 stabilised." seen on 72113
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20211202163050.46810-1-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <be8f8f4c-4685-8ec9-9405-06a39327a36f@gmail.com>
Date:   Thu, 2 Dec 2021 09:27:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211202163050.46810-1-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 8:30 AM, Al Cooper wrote:
> The problem is in the .shutdown callback that was added to the
> sdhci-iproc and sdhci-brcmstb drivers to save power in S5. The
> shutdown callback will just call the sdhci_pltfm_suspend() function
> to suspend the lower level driver and then stop the sdhci system
> clock. The problem is that in some cases there can be a worker
> thread in the "system_freezable_wq" work queue that is scanning
> for a device every second. In normal system suspend, this queue
> is suspended before the driver suspend is called. In shutdown the
> queue is not suspended and the thread my run after we stop the
> sdhci clock in the shutdown callback which will cause the "clock
> never stabilised" error. The solution will be to have the shutdown
> callback cancel the worker thread before calling suspend (and
> stopping the sdhci clock).
> 
> NOTE: This is only happening on systems with the Legacy RPi SDIO
> core because that's the only controller that doesn't have the
> presence signal and needs to use a worker thread to do a 1 second
> poll loop.
> 
> Fixes: 98b5ce4c08ca ("mmc: sdhci-iproc: Add support for the legacy sdhci controller on the BCM7211")
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
