Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588C455D8DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbiF0QY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbiF0QYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:24:55 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21D9BE39;
        Mon, 27 Jun 2022 09:24:54 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e63so9571186pgc.5;
        Mon, 27 Jun 2022 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=agTdFC77wAiPKF65qUDFakFqsb81qxDJ3UaD4sEYt/w=;
        b=IIE+TLwo/0K9iYZITp/hc6jUuto3k5HhvAD+nsiUisLv5Q4wyvr9FmMjtJYZsH3E9S
         Wzs6+cVruekXJPSY8wVLoZOU7kIYaO8EcBZqF2+r2+a+Ox3/W+rQ4jWtvvZMN2HM0C5O
         QzYBRzgRINKohbhhk9bD7Dd1XLJ0A7sx2MfwMjPKt4f6Hjr4DxpWchGyvEsDN9G3Xvde
         ae3vzMHrE2kgBP93GTa6ag/KAS5mfEFH56yPg1cfYiMM7LnTLOET5S8qHNldYHckM3gS
         UK+qtGImHgor6rqpZY5chuYnLqBsxZ9FGT/Mgl9qjCMG5++fuTWOmo9eoPb0ODtsjMVK
         yhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=agTdFC77wAiPKF65qUDFakFqsb81qxDJ3UaD4sEYt/w=;
        b=HCn4KS8skzPRWOIUDCIeV1yZyd06mnToGc48CraRjc1pIS3RIBaK6GrunI3VaeQxLo
         GP1QkK6r1qme+sOOX6YHfCdLsvtx5IZ+dT657K7hBzEDkjD2Ffk8U8HfQxXQiTzq/oNi
         gVo5vyT8IT0b72HGDm8W2zBRcj0hodA2Z0pRfUrYX0EtzHzfYHAV57tyY7u2Dsiicfoc
         wpWIrJLgqP7C6O2QPCREAdUw++6NEdFoVvL55olbWeKSJjg2iFhOYyPwM53AGZl2VdAO
         rZT4DX8ElmJqScNh+cU/tY5i0bgSUmfX47dq83CQg8kRFvTNCMloAFtgGSIP54BwYEn+
         iw6g==
X-Gm-Message-State: AJIora+NIQG7ibCYlEocUEA8mHXBV5jJlPAg5xLKePU4eqU/mOIdvPEj
        /Aah2p3NrorM45Nyio9E5q8=
X-Google-Smtp-Source: AGRyM1sG27yOPsRPwIvHWPhLNZZUlBJTHGS/Rtcv+tHJafgzf9lXLWrQ3EU8HM3gCD6lvDfXgJVNHA==
X-Received: by 2002:a63:6e44:0:b0:40c:73a7:b6c9 with SMTP id j65-20020a636e44000000b0040c73a7b6c9mr13235895pgc.285.1656347094073;
        Mon, 27 Jun 2022 09:24:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t5-20020a17090aae0500b001ec4f258028sm7647327pjq.55.2022.06.27.09.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 09:24:53 -0700 (PDT)
Message-ID: <7656fa2c-590a-8f0f-03ef-904e4f186c82@gmail.com>
Date:   Mon, 27 Jun 2022 09:24:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] clk: bcm: rpi: Fix error handling of
 raspberrypi_fw_get_rate
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220625083643.4012-1-stefan.wahren@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220625083643.4012-1-stefan.wahren@i2se.com>
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

On 6/25/22 01:36, Stefan Wahren wrote:
> The function raspberrypi_fw_get_rate (e.g. used for the recalc_rate
> hook) can fail to get the clock rate from the firmware. In this case
> we cannot return a signed error value, which would be casted to
> unsigned long. Fix this by returning 0 instead.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Fixes: 4e85e535e6cc ("clk: bcm283x: add driver interfacing with 
Raspberry Pi's firmware")

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
