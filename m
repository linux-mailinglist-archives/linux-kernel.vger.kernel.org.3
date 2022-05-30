Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66599537B23
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbiE3NNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbiE3NNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:13:33 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A335E54198
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:13:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d22so10283739plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=UaqxJNIVovbjPuskyCOOV69Jt4uO8x92Y/mZNeTBBaU=;
        b=OYPCnTPs0KYYjmLl6/JTNmWAUvcHipOX4Gt662U3NI+AQzope8dUNjJpbUe2MUgsjX
         YiZ4agiGQWdwRbaydEaPMUb0cpi2k6b8tOoXXQlRYJfAxiIiy1ioafRJHCsRpJhHDP4T
         vqVGukPcn1l/R6rOzpBgfjMCgS0RdlG+7frp8JiyDrKVk8TI52BNhzwH0FXNFSgmN0Pw
         cRwa9s59yUmpUnojua4gQFHV4wZr/Iy8UKcLNKycbImtEuQ/L1/eBa6k71NLk7x4teQ+
         bzeeqEj85oZW6lFCR11yxMtmRxZs9n7qJh+kAeLz67xoJg0cNWqZoMeNVSf0KuKVH4vE
         bp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=UaqxJNIVovbjPuskyCOOV69Jt4uO8x92Y/mZNeTBBaU=;
        b=vJtckY4KCMW2MZANKzdXHhKezGoEnpkMVKF9f2M66kttTVOFMOdbihmAQwCUsv8lAF
         nN6lvMIsa/3dstWjcGlCX/Loq5Xb2VOrsUyaoZHfR0zEs4R7jCZDdc1hNrUDcLDgVtgn
         YNuIYh4vB9X/HVziMrFWYNxcEtfZPMeYcLrqghY2KZ/dh27oGjoEePCCYoGyIrSFK7sr
         n1lUoiKkjWeO6Hs4OM1E/qAJ57V4vHcKwmnb1NAPkrCmYzznBnS1+4Qf+GCgsayfTijf
         7k2XUx2KrsGx2tAWAe/QAeVgXjkXD+FwwSD1pt0cINhKdWJLQcsBMw6ez/t8Id/EfRbb
         oiyw==
X-Gm-Message-State: AOAM530cNC0XDcCbbJcRGHNoNe3eakD4Ky+M7eNyi5KKRlz9ZOq3wnE7
        zNZ2KddzKnarDbARvdVAtLPlgCWPXFwTQQ==
X-Google-Smtp-Source: ABdhPJyXoCpbtW33PGhQHejus8rUmfxbjndq39jlUfUh5Pg1kUWU4bLS2/rhu/6sbBbXxOqe3v0cMQ==
X-Received: by 2002:a17:90a:b295:b0:1df:8462:b96e with SMTP id c21-20020a17090ab29500b001df8462b96emr23316122pjr.162.1653916411896;
        Mon, 30 May 2022 06:13:31 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090a0e0900b001df93c8e737sm6838524pje.39.2022.05.30.06.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 06:13:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     iamhswang@gmail.com
Cc:     linux-kernel@vger.kernel.org, haisuwang@tencent.com,
        samuelliao@tencent.com, zhangwensheng5@huawei.com,
        linux-block@vger.kernel.org
In-Reply-To: <20220530064059.1120058-1-haisuwang@tencent.com>
References: <20220530064059.1120058-1-haisuwang@tencent.com>
Subject: Re: [PATCH] blk-mq: do not update io_ticks with passthrough requests
Message-Id: <165391641103.1520577.11281581560221839316.b4-ty@kernel.dk>
Date:   Mon, 30 May 2022 07:13:31 -0600
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

On Mon, 30 May 2022 14:40:59 +0800, iamhswang@gmail.com wrote:
> From: Haisu Wang <haisuwang@tencent.com>
> 
> Flush or passthrough requests are not accounted as normal IO in completion.
> To reflect iostat for slow IO, io_ticks is updated when stat show called
> based on inflight numbers.
> It may cause inconsistent io_ticks calculation result.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: do not update io_ticks with passthrough requests
      commit: b81c14ca14b631aa1abae32fb5ae75b5e9251012

Best regards,
-- 
Jens Axboe


