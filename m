Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E7B4E7BD8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiCYTtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiCYTrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:47:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9521753AF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:30:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so9599732wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=4au4HQJoqTVH7QuLfTG0ctyg44Z9i1a4JMpNhX3HXmE=;
        b=fHaI5D6OllN0BflSbbgRLyRyoFi34rIUMZTPyE+6vre/pNCfg/y6/Hu/vsRiqRgDjo
         nLfNjlhpv5j+4EHsWTCq+g85rIB7CPeMArzmGXer2e0cXNVxVtgFdttB7JdGUZ1Gw+tz
         G/a9fEmSsa7MrfkHt5apOHfDkt4Rnu/OAhCqKw3UoXBuEEJpc0MniybM/pQ2h6vEhpln
         3Ys8iW6T+xfrKN9yBM1s7MTyv+GZkJ0E36sgSUcPenLbcL79FW5aiOL55DgDTCphx5ye
         GoNw2zFKY21asbuaxzIqfufo3XDO8NhSfRrWmRFqeQCOzL/aYIjUMYGRA4m8X3hIPcQM
         movg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=4au4HQJoqTVH7QuLfTG0ctyg44Z9i1a4JMpNhX3HXmE=;
        b=NXYiklvnwdYybySwOd3pd18inS7Sp/6qVAmIIT6bBXKJK8YYR/bDosyU2QQILsKMzB
         904OD87AizRbNxQK/MnrPmWLsZFT2e3Ym5EQDL0KFLl6dFHRe5qbYttYtV1BZOL+RYmq
         wFeuke2Fyt8ImcdOnsFUC+bb5R0O91eU4DCHZBTkjxfPSSZPp4zh699FsOkfFR+UY809
         OL1y1Dy3AWAZW51Sq8MPZBWr6zlVAuw6VVyrTBYyDhwOh3ZIPIj0mshTRbe7R9QnXOgw
         +KwxooF0azXjWnuZheTC/I8E2czv9+6brFfo7ZKKXsb3AdC4ge+80vEvutfmaTs0Pxln
         yfXA==
X-Gm-Message-State: AOAM530Ne5rKYA6nw8154owRVv3q9CTO8wSRBWcXEqEyOAe8Pjv3AAzF
        PqvxH2Mu7iyrdY/XrvfyzO9odPId+AL6F4Ml
X-Google-Smtp-Source: ABdhPJz/V+jMzW2tGs/g4V4RP3QBLNrE9pk5MgdSkzns2BmU5yeIbnWkFVw5TIqLNLr7zmOsb7wWwQ==
X-Received: by 2002:a05:600c:19ca:b0:38c:a190:9a0f with SMTP id u10-20020a05600c19ca00b0038ca1909a0fmr20524715wmq.57.1648229643918;
        Fri, 25 Mar 2022 10:34:03 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:d3b0:47bd:8485:31cd? ([2001:861:44c0:66c0:d3b0:47bd:8485:31cd])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c028700b0038cc9bfe6a4sm4734266wmk.37.2022.03.25.10.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 10:34:03 -0700 (PDT)
Message-ID: <394573e1-0786-75ef-65fa-4b75d57714f2@baylibre.com>
Date:   Fri, 25 Mar 2022 18:34:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] arm64: meson: update dts for JetHub devices
Content-Language: en-US
To:     Vyacheslav Bocharov <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220325165501.81551-1-adeep@lexina.in>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220325165501.81551-1-adeep@lexina.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/03/2022 17:54, Vyacheslav Bocharov wrote:
> Update dts for JetHub H1:
> - add bluetooth node for RTL8822CS uart port
> 
> Update dts for JetHub D1:
> - add ZigBee serial alias (ttyAML2) for backward compatibility
> - update voltage regulators and SDIO config to match board's reference design
> 
> Vyacheslav Bocharov (3):
>    arm64: meson: add to dts for JetHub H1 bluetooth node
>    arm64: meson: dts: update dts for JetHub D1
>    arm64: meson: fix sdio in dts for JetHub D1
> 
>   .../amlogic/meson-axg-jethome-jethub-j100.dts   | 17 +++++++++++++----
>   .../meson-gxl-s905w-jethome-jethub-j80.dts      |  5 +++++
>   2 files changed, 18 insertions(+), 4 deletions(-)
> 

Can you add Fixes: tag in all patches so they get backported ?

Thanks,
Neil
