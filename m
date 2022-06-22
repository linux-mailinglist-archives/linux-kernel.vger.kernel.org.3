Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00CB556E88
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359458AbiFVWdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359295AbiFVWdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:33:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCF7222A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:33:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso829505pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=QAYDnhWBUumQJXLfjLM/HrotAv8NVofKnBHrbwoQ4uI=;
        b=T4SQKvmVgykOMJflWwdcXiHwHaW6ppUL6HpcoyV5P5YmLv05PZ6ywgtWJGQ81+ry4m
         KszItlKZ3EpSACiBoKNrLwpXRyen8O2vs6mNbpNljaC5f++yyLxx9MZMY2XBeRgdaKGS
         A09Kxam4vbOBqas6DMCnXxbiHv2vgOyUg+nis+ZaifLjO2p3D62Uamrmaacp3j6HzKLd
         gCaxNXS5PcwEZ9PvFm7wmN9+rrIK3WKQrtYGPvw3alATQw6CJ/odCJ1ugivLjM2GCFEs
         cQDUIfAud4wtRq7y5/IGcX6YRcyll6JC9SwX3zx14ytWSwCqmz1r1cPZ2rC2SAw1Tj2n
         6x8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=QAYDnhWBUumQJXLfjLM/HrotAv8NVofKnBHrbwoQ4uI=;
        b=K6Y8XEGPDRBD5LzvzTdo0pXQXR5ZX64RkCHP5iqlCWkVr7iuzgeccln2Ob3UtrlhgR
         p3JRQeLZLptpA9Zds8M+mLmpE8c1WGISr3oro3o0rN8BryjylZrzfUma+kkbTj8OZPgZ
         UxquffEkIhPM9Z3o0O/+fOouhMUqdYrYtt2zt8CiEnqnfrwhP8c0PiDnauHYcAIDxDrN
         WyQ1nPKewNRCiP6Qy23NLYoKjw350CymqsRafDxSq25jGNCKGod+MC5yxiOs/GtlJcVs
         Js6B3RCpkviFgUSU40yjacGG33TaTkl2R3pCefamC9ZHb5hg8MN5BUAjWCj6mfQPhyX4
         woYQ==
X-Gm-Message-State: AJIora8NN9LlffSJvm8pBJdnmAtSeb28ne6q3zRBIKbOup0PRGASpAt2
        jIkCdtRjDvwX57kqBe+U/Aichw==
X-Google-Smtp-Source: AGRyM1sVc1ogbU/b7rlbzF68iEfptv2tG9a4AJSUp9uVgyMRQ81sfKMlvvYWh45MR18JSdkr1pN45Q==
X-Received: by 2002:a17:902:e810:b0:16a:2934:c8f7 with SMTP id u16-20020a170902e81000b0016a2934c8f7mr16468040plg.171.1655937191761;
        Wed, 22 Jun 2022 15:33:11 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m14-20020a63ed4e000000b0040d2717473fsm2191066pgk.38.2022.06.22.15.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:33:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     christoph.boehmwalder@linbit.com
Cc:     lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        philipp.reisner@linbit.com
In-Reply-To: <20220622204932.196830-1-christoph.boehmwalder@linbit.com>
References: <20220622204932.196830-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: bm_page_async_io: fix spurious bitmap "IO error" on large volumes
Message-Id: <165593719059.163762.1120892404181433441.b4-ty@kernel.dk>
Date:   Wed, 22 Jun 2022 16:33:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 22:49:32 +0200, Christoph Böhmwalder wrote:
> From: Lars Ellenberg <lars.ellenberg@linbit.com>
> 
> We usually do all our bitmap IO in units of PAGE_SIZE.
> 
> With very small or oddly sized external meta data, or with
> PAGE_SIZE != 4k, it can happen that our last on-disk bitmap page
> is not fully PAGE_SIZE aligned, so we may need to adjust the size
> of the IO.
> 
> [...]

Applied, thanks!

[1/1] drbd: bm_page_async_io: fix spurious bitmap "IO error" on large volumes
      commit: 66923326b519bbc4ebcb5275645b58427f801824

Best regards,
-- 
Jens Axboe


