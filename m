Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771CA4C928B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiCASGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiCASGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:06:30 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C924CD6F;
        Tue,  1 Mar 2022 10:05:49 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o8so14954774pgf.9;
        Tue, 01 Mar 2022 10:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QurDe6TL5EhdhjiT4eZKOlrbU9U65iNNBkyfVPe9X6E=;
        b=O8jqHAjLgWtItjKi6TmygcETK9PuMmIUMCl7lS4icSph/iEchk6rlGvUM6jFtuAddf
         L0llhWsiPs9UCQWPgiwrbuY5yh73X+QK/lHnoto72qGEUK8Yrb9WAniv8Hdbh+EScFcq
         Eh5b11zzkIRmzr+LFuSBGpgJZq6BXLymR75p4DmAnSshx1ybipKnV4dl9VushTzmtK4G
         wvCtkkqMslXgjQY4FDqqASt5r/LZm6xQvFn4BA2qBv9JM6JfwweqbKgE38bb8PIoPRX3
         w09n0VXo+Aww5JgGgCA/wmLpH7mh+XYVEqR+9wU1DKJlJkDpcFQxEUHvnywefhaDSgcT
         CvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QurDe6TL5EhdhjiT4eZKOlrbU9U65iNNBkyfVPe9X6E=;
        b=pNxPtcS85W01cwyMm1NSxjlg//ir+txZGkSCuv/DWLqbqrCaIeDTs1+aK/Euo6D4F+
         ANMxfhQW4M6bqGvI4qdCf98CSDjZpv95qMUrFZ/OYQU3gS1fh+LS4xijF9YcXrmEAB/z
         yRBYfS1EvlT3MS872QujK6SCW1c3JUwoo0aK4zih90OR6ji7A9aJ2ooZbi+rFc8q1ALf
         wMyX81A04cRnqEX2pWMXnZMiFDPeamjp9Afz+zD+ZOsAi+Q4y5Ssmin1aaSQqLBVzGJT
         ELCY0FNu/rQTvK0nmnEn1UvU6wKLVDittR/I+wLPEUYxs1ciJQpxvGEND+6kwSSd2NhQ
         4H1A==
X-Gm-Message-State: AOAM532Hmv1L2V50/FlxNerr9N9IlDvXFDceHej0mTDWQIqz/A+bpTCm
        4UmUitvjal1fcOj73xkZJ025TA/Ea+Q=
X-Google-Smtp-Source: ABdhPJxGJarq1sO2uj5+4zx3WG0LkhzdpGu3+hZT2reomPmcT7Yc9iR4Ms9geEryIpiV7VQzIH5UQA==
X-Received: by 2002:aa7:8d42:0:b0:4bd:265:def4 with SMTP id s2-20020aa78d42000000b004bd0265def4mr29066482pfe.24.1646157948925;
        Tue, 01 Mar 2022 10:05:48 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id n22-20020a056a0007d600b004f11e614565sm17747675pfu.189.2022.03.01.10.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 10:05:48 -0800 (PST)
Message-ID: <2f8da2c7-98c5-4061-2e16-42b7fd4f9694@gmail.com>
Date:   Tue, 1 Mar 2022 10:05:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] thermal: brcmstb_thermal: Interrupt is optional
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Markus Mayer <mmayer@broadcom.com>,
        "maintainer:BROADCOM STB AVS TMON DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20210426213647.704823-1-f.fainelli@gmail.com>
 <933c889e-dee0-4fc3-bf1a-b3655cabbb28@gmail.com>
 <7359c3c1-8928-d448-e503-13f587cbb567@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <7359c3c1-8928-d448-e503-13f587cbb567@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/2021 12:51 AM, Daniel Lezcano wrote:
> 
> Applied, thanks

Was it applied? I still cannot find it in linux-next or Linus' tree.
-- 
Florian
