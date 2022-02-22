Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190274BF9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiBVNwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiBVNwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:52:25 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F817986EE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:51:59 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t14so19624756ljh.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=NsGSasV71blvFAQsUeTICtCaC8t3lLOY7dmm0my+M4s=;
        b=AJ/I/oj0OYUCwVJAmn4np80YsTakFowMhpIW/OjZXOW89NFj1/PftD135TnJ8Z/LI/
         phCp6HJjvpEUnJRHfF9K1BgyGXwxoB6W5MDk854iU3af6RUr/kHXTpiG/NzsQyTOh+gD
         kMP4OuIvponFrwXI617qzjNjPPsVrSYGnPYmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NsGSasV71blvFAQsUeTICtCaC8t3lLOY7dmm0my+M4s=;
        b=dE4bJTxj9XE6sRszOEry4NsOX2VcQJvLkle1e3i5HRPG5ahyiLi3NcKkYtHR2a6llU
         pZNKW5MhoU9lFvR7OxVe/tMte7+/bOQ6bM6LLqpf5Ey8CTp0tQ8QUQIXQfMYpgg34Dg2
         bzQh/dgM13LejKoXgkX/zi8XsWCUu86CPOWyojEbW92UgakfUHcl7iFAJPl5R/+gqgEw
         BK0Txln0LHMWmARdIBVeIo3PjT6VlNpp0MM39KXThnUTfxITl4vAC3ZouiLhA8JdleKL
         bVPbl8VP4Mks0J5/8UQHE41mS3dPaIYARhxkQBl7jpCfJtLKiqcB84SBhPRcSLUrEJiu
         LxDA==
X-Gm-Message-State: AOAM531sSMH21zM557j8fnpJ4ou8xVZJYzFVz6HishzPMm1nUGwJosc2
        bZ4EevPoj7P2wCQso9/DGb/WyQ==
X-Google-Smtp-Source: ABdhPJxI+23Gdjl0KlMs6D0D/n7roxfjb4Eu5X3j0I3KcmM67FZxrBTBWvYuS399uuQpiLuHrCVJmg==
X-Received: by 2002:a2e:880a:0:b0:244:7dd:9256 with SMTP id x10-20020a2e880a000000b0024407dd9256mr18390534ljh.525.1645537917845;
        Tue, 22 Feb 2022 05:51:57 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a28sm1382796lfm.251.2022.02.22.05.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 05:51:57 -0800 (PST)
Message-ID: <708eabb1-7b35-d525-d4c3-451d4a3de84f@rasmusvillemoes.dk>
Date:   Tue, 22 Feb 2022 14:51:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFT PATCH 0/3] Fix kfree() of const memory on setting
 driver_override
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
References: <20220222132707.266883-1-krzysztof.kozlowski@canonical.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220222132707.266883-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2022 14.27, Krzysztof Kozlowski wrote:
> Hi,
> 
> Drivers still seem to use driver_override incorrectly. Perhaps my old
> patch makes sense now?
> https://lore.kernel.org/all/1550484960-2392-3-git-send-email-krzk@kernel.org/
> 
> Not tested - please review and test (e.g. by writing to dirver_override
> sysfs entry with KASAN enabled).

Perhaps it would make sense to update the core code to release using
kfree_const(), allowing drivers to set the initial value with
kstrdup_const(). Drivers that currently use kstrdup() or kasprintf()
will continue to work [but if they kstrdup() a string literal they could
be changed to use kstrdup_const].

Rasmus
