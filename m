Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E1046BA00
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbhLGLY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhLGLY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:24:26 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001DBC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 03:20:55 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id o13so28682946wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 03:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7SnhNwByiawTTcw1MP4TZPPrzNaWp5dA9zL+41P8YmE=;
        b=ZPaXypHqqQIK8shTaoa+pgZJVWsa6Vpw3WiVp0PVa7RClYDHyW7fjzpbeV/FEz2q9y
         sJ1lw3jAD1eMOE6PGIRx53FuNOZKzSZGIDJu5jrqjQm2Dvx+sgGNxAKbv3XmqhNMZ8lj
         gvTJYt7FIaYuLUhk+hjEDJfLT/EGCbzEgzmvBP+lR3IIR1VP0QaP/cfpmYJpET/AbhkI
         zRtopceXWs+j5tAYYaplTzYj9gzcFi4/X5wJLFk7fhtbP/DZb4iHHzm1srQnU6dkADNL
         lXnzMmQQC+jm8g0PNu9PwEGfcvBMalK6Ou/2abOGn1Zn1SdP7b8qFfV+wQE0MtaNDoLh
         0b2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7SnhNwByiawTTcw1MP4TZPPrzNaWp5dA9zL+41P8YmE=;
        b=7sCvKYtGXgUSeUSTbZJ1MyDlffNfakubmfu7D84H1NQqauxPZkmu+UhLqO6q/spuJT
         YTXPjRavchWcCYuH9mMCorJAx8yrTpPVf+rkBnpGMvqTS6EB1Aj9ueZ5fhhr97mSXZw5
         2Ts+3ykMeKeTSpEgxLCvEBYesZt7V4tEtBiF/Kqn0FvWlBPsOutLSrR6Ml9Efg9enOGW
         krmDmPeXMnctBfDbMgrnwkIeOOQ+mnOBPYjAVTCAIP0lAOF51Ap+cDCK01pxOBkhTiIE
         iVaKfbKUjTBLb4BqK0dvyI1nta4SVmbqy0SYEgQZj3p1CyEMpkiVqpwV0rnW88BwLx5Y
         eOFw==
X-Gm-Message-State: AOAM5312fxZLg9OMEZhKEeSoXTf5G7xgSrHnssI+Pg/jN+Gtx17Tn0gT
        mMkQ+L8Ucf50z8CwnZbxH6Z/tQ==
X-Google-Smtp-Source: ABdhPJzV1KU4uSd4ulFMhhQmpYjFf8+HOXv8bLaVUlLoysp/amdEohmwMiaZLIOsnY1xXY1b7YhJqw==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr52092601wrd.105.1638876054507;
        Tue, 07 Dec 2021 03:20:54 -0800 (PST)
Received: from [192.168.196.27] (46.172.185.81.rev.sfr.net. [81.185.172.46])
        by smtp.gmail.com with ESMTPSA id o12sm2600823wmq.12.2021.12.07.03.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 03:20:53 -0800 (PST)
Subject: Re: [PATCH v4 1/3] phy: amlogic: phy-meson-gxl-usb2: fix shared reset
 controller use
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        p.zabel@pengutronix.de
Cc:     khilman@baylibre.com, balbi@kernel.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20211205215846.153703-1-aouledameur@baylibre.com>
 <20211205215846.153703-2-aouledameur@baylibre.com>
 <CAFBinCDZ2nTg2V_6qxok_y+wXHTVJ6XyyvON59TLJZ9B3fKY3Q@mail.gmail.com>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Message-ID: <23fd1b50-75e9-25fe-cff1-b25e4f472f8c@baylibre.com>
Date:   Tue, 7 Dec 2021 12:20:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDZ2nTg2V_6qxok_y+wXHTVJ6XyyvON59TLJZ9B3fKY3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the thorough review.


On 06/12/2021 22:19, Martin Blumenstingl wrote:
> Hi Amjad,
>
> On Sun, Dec 5, 2021 at 10:59 PM Amjad Ouled-Ameur
> <aouledameur@baylibre.com> wrote:
>> Use reset_control_rearm() call if an error occurs in case
>> phy_meson_gxl_usb2_init() fails after reset() has been called ; or in case
>> phy_meson_gxl_usb2_exit() is called i.e the resource is no longer used
>> and the reset line may be triggered again by other devices.
>>
>> reset_control_rearm() keeps use of triggered_count sane in the reset
>> framework. Therefore, use of reset_control_reset() on shared reset line
>> should be balanced with reset_control_rearm().
>>
>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>> changes since v3:
>> - Remove unnecessary reset_control_rearm() after reset_control_reset()
>> failure.
> I double-checked your patch in v3 and Philipp was right:
> reset_control_rearm() should not be right after reset_control_reset().
> However, I think reset_control_rearm() is still needed
> phy_meson_gxl_usb2_init() whenever clk_prepare_enable() fails.

Well seen, reset_control_rearm() should actually be called after

clk_prepare_enable() fails. I will wait for any other potential reviews

before sending next version with this change you suggested.


Thank you Martin.

Amjad

> So my suggestion is to add reset_control_rearm() in
> phy_meson_gxl_usb2_init() if clk_prepare_enable() fails so we are
> resetting the ref-count for the reset line (just like
> phy_meson_gxl_usb2_exit() does).
> The difference compared to the previous version is that the
> reset_control_rearm() call needs to be placed a few lines down.
>
>
> Thank you!
> Martin
