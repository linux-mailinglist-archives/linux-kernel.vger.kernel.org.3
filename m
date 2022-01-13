Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB5248DE86
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 21:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiAMUAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 15:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiAMUAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 15:00:37 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FC6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:00:37 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id z19so4235664ioj.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=zpxRDMDpjP0eyt7BG8eM1po5m9+B41KQmJKORqe0L/s=;
        b=TjiTCQj2jJ7CoQ8GnN2iLukX9BxHsjzpLEYpz6iZ8+YquZUwRx6w7Vu0FMHHioZotw
         yDBEcF+ZPmiDEqdk94DCGJ8rkkVXDfdkugYUFtIOAWYI84MmArCHsdM40U/JWzuec3xi
         Nmn0DIz5szn0lGVn+2q+HySl2RCTv4z4/jnlMz48nGfth4S2qFbWQefRebpO+RHhNNBg
         0DE5cTCgccLLLgWfF9asCn4aX8ndeNhFVb7MSW8eieDk4nF/SfWU1xwkxSVIZd3P+6TP
         91BeYao6JNv2FN74KGaflTpdVzsK0qW4fYozPSqPKdcsn4AkbkPWpFTKNGkXTC42hqiC
         KbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=zpxRDMDpjP0eyt7BG8eM1po5m9+B41KQmJKORqe0L/s=;
        b=lf+d/jIRLdXNewwNhDp/1J3IoVSarPaPPzck0Uk1V3D98DOawx/8oRhjLsyO9ngdW4
         yswWCW2yVWWD8wlzWASIJ0TFwC+4/0GCxkwmjaAQPGY8bohy52Opv+jT6KyZFl4CPmVS
         1KOAwdZsRHyaJ/491aiSc6ZmjvxrRcW0PZNSNsIjryYYSxSOfs69E0tfoMmTsynahMG3
         bwmfsHd3iwC66yfJk8UnFyqNYasD6HYHnbmqhSexWXlzEkFhoZ9q5TdGh9dxcnX/HIyn
         JJMMWa+agvrNSh3ap8du/vL3fvjtKQEAM95/V0y7RIkti/84lm+3oBUXFW2LBkPsEUwS
         CDOw==
X-Gm-Message-State: AOAM533gnC73v1fCkpU9A0NUbpWIB3dFe8hTLlRkL1t4yhuS8s1UeEBH
        aFA+/E1Muj1eLPVFUGkGM2++ww==
X-Google-Smtp-Source: ABdhPJy93FHoGOJVPE1DdunyieZI/cMIH71wQsT32PPznbncX4AFfK4i6YqaBGZuoilCs5lGW3zZmw==
X-Received: by 2002:a05:6602:2f0e:: with SMTP id q14mr2974399iow.75.1642104037044;
        Thu, 13 Jan 2022 12:00:37 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s6sm3483277ild.5.2022.01.13.12.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 12:00:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20220113001432.1331871-1-colin.i.king@gmail.com>
References: <20220113001432.1331871-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] loop: remove redundant initialization of pointer node
Message-Id: <164210403642.172421.8237866191152253472.b4-ty@kernel.dk>
Date:   Thu, 13 Jan 2022 13:00:36 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 00:14:32 +0000, Colin Ian King wrote:
> The pointer node is being initialized with a value that is never
> read, it is being re-assigned the same value a little futher on.
> Remove the redundant initialization. Cleans up clang scan warning:
> 
> drivers/block/loop.c:823:19: warning: Value stored to 'node' during
> its initialization is never read [deadcode.DeadStores]
> 
> [...]

Applied, thanks!

[1/1] loop: remove redundant initialization of pointer node
      commit: 413ec8057bc3d368574abd05dd27e747063b2f59

Best regards,
-- 
Jens Axboe


