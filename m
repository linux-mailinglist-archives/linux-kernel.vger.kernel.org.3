Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31F74901C8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiAQF64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiAQF6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:58:55 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4D9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:58:55 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x83so9300856pfc.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=+OBBsWDlhHLqnvCwRRiFZ+kgpQAOYsMJlg/fYwGhI+A=;
        b=AhVrOz/zMHPRSceQ/7C7EmSf4BOTcYgUFUEVfVkIYbXmgzB6HJBZtFG4V2g+5M91qK
         tUpAGRE/AKRps0QSHTWghNsIp+FfAYtc+AoeP0B6mBi22KI7VTfMOshS8SFr86GQvMf8
         y/9wWzTbruPGxuA3fhQ8/6eyjiGjYWKfHsbyOer+TgahTAlHm+8DlK1N8OJw9YvRee7L
         yf2yXeRD/hN/JTA54C1HYjtpM3eC7OPtRW7Qf2fNIgU5kHYs5uVxXgXq7B6WZzsnKWd4
         GKqcZoSKfJRbaOBZWsKpljqc/kk6GaelQvPB7YCr4cDA/Lr6ZSoDk5Y2wGJ6Wvn7HxkZ
         lpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=+OBBsWDlhHLqnvCwRRiFZ+kgpQAOYsMJlg/fYwGhI+A=;
        b=VLpod5JGkGemtZ3r0t/GVtZG8UOZjlyo1OGK3pOk2VGSI2lLQthTgvsdA4GN3NUrL2
         yTgrOnGXfZ2ySTw19KXExwgy48gLDXD6IKDyhfObkGS+nSc817L7pgdEeXTAArLHQHDQ
         36Ytq9YxqN0V7WCeje/CPTx49vMnL2DSj4E1s0MX9f60BiK93p+ncYAC10852VG7gIts
         Dui6giRxhRGDcz0MtUKitsa5IvFeWdDByJCfVS5lO8oqekJZq8V1WkdhXvh52IqtP2dc
         QYMUzwhjYRbgrrMe82I299kKbhrxr07daHrXtMshVJzjgfvKKPSDNKOrrtrWwTx9I1Yk
         NEvQ==
X-Gm-Message-State: AOAM530CkN++X5+wonki4GUPy6/INg5e4MKT7/fxGaX619hBRRjVwJ0H
        eaC39ZyRL9IUNkFgIL9jBkk=
X-Google-Smtp-Source: ABdhPJzqFNY3H7KKvdqvwAid4nu+1+Xj7Y/ZyGxk8d0MRItpsUiiGoWB0lQKM3mHMIpZXYQi0DYiDA==
X-Received: by 2002:a63:6806:: with SMTP id d6mr17821958pgc.353.1642399134999;
        Sun, 16 Jan 2022 21:58:54 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id n22sm8754464pfu.160.2022.01.16.21.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 21:58:54 -0800 (PST)
Date:   Mon, 17 Jan 2022 18:58:49 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] staging: pi433: validate min/max bit rate settings
Message-ID: <20220117055849.GA10644@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201162116.8r1xEw9q-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RF69 chip supports different bit rate settings depending on which frequency
modulation is used. Failing to correctly validate bit rate can lead to a 
silent failure and cause packets not to be read/sent.

This series change the order in which the rf69 chip is configured and add
max bit rate validation.

Patch dependency:

This series depend on these patches as they change the same set of files:

- https://lore.kernel.org/lkml/20220108212728.GA7784@mail.google.com/
- https://lore.kernel.org/lkml/20220114221643.GA7843@mail.google.com/

Changelog:

v2: change bitrate variable type to u32 as pointed by kernel test bot
v1: https://lore.kernel.org/lkml/20220116001726.GA22699@mail.google.com/

Paulo Miguel Almeida (3):
  staging: pi433: fix validation for min bit rate supported by the
    device
  staging: pi433: change order in which driver config the rf69 chip
  staging: pi433: validate max bit_rate based on modulation used

 drivers/staging/pi433/pi433_if.c |  8 ++++----
 drivers/staging/pi433/rf69.c     | 16 ++++++++++++----
 drivers/staging/pi433/rf69.h     |  2 +-
 3 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.25.4

