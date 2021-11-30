Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0D1463BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243435AbhK3QZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbhK3QZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:25:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90787C061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:22:32 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so20033776wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b6a6PLyF+M7wwZ1FDN/UTeFdO9+p7QSJdzSxXo0nQ6w=;
        b=U7yVGOdqpzRq412biVH6h4R9wrDhW/Cw4WDky3rZrAYQyvrJiTYAh3ZfQVcKrwZ8Ud
         O7MFHnJga29Yhrf4pZEfZQ95tXiVSgtMSpvV2xosWhpDmaqgsPOHRIxN0sbXD1GaC3p6
         cQUvOQtAtzoavUjpNSm7PN9uXsg1JQhkzNtIaCa1ZPlN+wifCO+1OEehUN3eLWE/UAmC
         mQS0qCYu2KGBxmC4HaXTejkNfRGpYT8+lVX+/3RCPI4pguqDv7fT3DLCLglba3pG+gk8
         h4aAe95hTF5TWBl8LhioJuVoa7OeZ7e3RZQZrBkxtpjHMQ+WBMJCJ0m5nCBk0r7RaOJH
         2B2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b6a6PLyF+M7wwZ1FDN/UTeFdO9+p7QSJdzSxXo0nQ6w=;
        b=cntYG6tb2ekzb5SZzVIgKt5j0XQrqxP/wm0/sqXXgYczrMZesLJ0O7IcuD/vWdXBub
         SaUgsxB4nNcqKUA3z3lPj7p5NnH8ot/EiPHXzaY+nFqSF0P+/x1wFfsQD+U+1Kxf1YMs
         rkD2tFSaJxEXyNkxzAkJjfBw0P7TuG0pTdm8Rtk/etDeYuPdEbmsIypRyOLJF6rg46E8
         21gzedf3gtNAWLHWe4FA4xXUGpLqPLAyJajMN6LO+W5vOFe/gPmFqpFq7fYf5eGzxzxE
         J6BZKD0s09tj0WZQBnwW4lC35+YKfdecG0n/TSFMYv2L+Q14mythVic29X35PpZGNp6d
         SGiQ==
X-Gm-Message-State: AOAM531JL4NxIENhcU2T58nSXIikfLn+T3cvMGXamw3GdULevBbL9rv6
        ogcBQOONLVt7uEe5WSZR9l2d1FD/3hYf0A==
X-Google-Smtp-Source: ABdhPJwOIBYOKR3hSaNFiEBsqZLhO8lZTu4Kh9Wv9+SiBlvi7awXIKHajW0vvKtRvI5aaU1uoAI51g==
X-Received: by 2002:a1c:1f94:: with SMTP id f142mr517714wmf.192.1638289350935;
        Tue, 30 Nov 2021 08:22:30 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id j18sm3278314wmq.44.2021.11.30.08.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 08:22:30 -0800 (PST)
Subject: Re: [PATCH] ASoC: qdsp6: q6routing: Fix return value from
 msm_routing_put_audio_mixer
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20211130160414.21616-1-srinivas.kandagatla@linaro.org>
 <YaZOnJIrl2bO98mL@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b663a16e-e503-3f74-6d16-1b59df41e619@linaro.org>
Date:   Tue, 30 Nov 2021 16:22:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaZOnJIrl2bO98mL@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/2021 16:17, Mark Brown wrote:
> On Tue, Nov 30, 2021 at 04:04:14PM +0000, Srinivas Kandagatla wrote:
>> msm_routing_put_audio_mixer() can return incorrect value in various scenarios.
>> Fix this, so that change notifications are sent correctly.
> 
> This really isn't a good commit message - I can't tell what the change
> is supposed to fix or how it fixes it.  Which values in which scenarios
> are incorrect in what way?

I agree,

the cases that get incorrect return values are:

scenario 1:
amixer cset iface=MIXER,name='SLIMBUS_0_RX Audio Mixer MultiMedia1' 1
amixer cset iface=MIXER,name='SLIMBUS_0_RX Audio Mixer MultiMedia1' 0

return value is  0 instead of 1

scenario 2:
amixer cset iface=MIXER,name='SLIMBUS_0_RX Audio Mixer MultiMedia1' 1
amixer cset iface=MIXER,name='SLIMBUS_0_RX Audio Mixer MultiMedia1' 1

return value is  1 instead of 0


I will add these details in next spin commit log.

--srini
> 

