Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E4B49EAAC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiA0S7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiA0S7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:59:12 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644B6C061714;
        Thu, 27 Jan 2022 10:59:12 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id h23so3001214pgk.11;
        Thu, 27 Jan 2022 10:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Kf+kdg2c1HJXuwMScXRqFZTXE8Hr5rEGSTqbhdf4ZY0=;
        b=SHlJFbWQLWkZNDz26HSpcPryc7ewCVr0VBXuXoOwGPVHQBahF4J2x943moqrQdDYoj
         8kuW8y0ZqhhE1yk9JXOwTYnVh4KKlv8YLahzGsI3YWjcalMGQocu13vFnJ78p6LR6zLU
         k63lc/02L/H2JfFHVTbU6rv5N5dV20+nLVdpu3PN448rTlS3jI6v9yrg0V4f3AQ2yepS
         kBkWQPvlmSSaxQQEZBFuD5J9EdTHBtBtB1lHBD3UecOTfMoZm0DzhVk4AC8flHg/Tt84
         yg0RWNVvATOGq+qZPNypnZF1Dt+VU9SyCHCXt2FKPjjwJz3K0rbT2p9mcKaZWuFb3rLt
         yeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kf+kdg2c1HJXuwMScXRqFZTXE8Hr5rEGSTqbhdf4ZY0=;
        b=k/gk36kU13sOWshxkx+heNzAdoMZdgeOWedY8/j3tCYGGsaBI/RPdLBl9c4JKsjS2N
         neUFZTYFf3JizMb++WAkZogENlWJz0JjiaRc5BP+u0Xv6CcRxtwE0QtU1yG+91jcjtTO
         qoAMXmA0aJHnDwcO8utD9AdCxUO3ICwsOloMqTNVUpe2CgFXm4Oq5SZLhzxWW0ODjmzH
         TQsfUGz22BqYLxFLyBj3zgZPAVGBblIuSxWslgPV4Ag6snyDD0oibNe92VkyoqeajnAV
         e4IMVW3rzJB5LOVya0bZa2Fwuk8bKyzWSwd5TH4szgBMVLtPQpW/PU9ZvAykJnHueS1v
         6DeQ==
X-Gm-Message-State: AOAM532kxYM82s2GxXCIvzS6BGFFQmbyP/gESKHAhonEUOCFGWAmieJn
        9Oxq2P4oCQ/uaCJRmC76Zpg=
X-Google-Smtp-Source: ABdhPJxSlRx/Wuc6u+QSesomAeaF4V/F3yOvUxnMrcT/tjSt8q7RDRGIk3hBT9sLw9eMlHdFPAe0Aw==
X-Received: by 2002:a05:6a00:1992:: with SMTP id d18mr4030814pfl.85.1643309951730;
        Thu, 27 Jan 2022 10:59:11 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id p22sm6507491pfo.163.2022.01.27.10.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 10:59:11 -0800 (PST)
Message-ID: <01d73e56-346b-a175-6113-db98be6b0a53@gmail.com>
Date:   Thu, 27 Jan 2022 10:59:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] spi: bcm-qspi: check for valid cs before applying chip
 select
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com
References: <20220127185359.27322-1-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220127185359.27322-1-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/2022 10:53 AM, Kamal Dasu wrote:
> Apply only valid chip select value. This change fixes case where chip
> select is set to initial value of '-1' during probe and  PM supend and
> subsequent resume can try to use the value with undefined behaviour.
> Also in case where gpio based chip select, the check in
> bcm_qspi_chip_select() shall prevent undefined behaviour on resume.
> 
> Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian
