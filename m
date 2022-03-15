Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C614D9693
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346105AbiCOIpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346101AbiCOIpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:45:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F4220DB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i8so27805889wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XOKCoe4jWaD7x9lPq3isdzFOVnNDQZD4YR70OuDp6Zg=;
        b=lKCdBY2z8w3dHGFZSXF8p3ejcdhgR/KW5Zla+wMlGvotRQdWgjoWkfJuUT5CPf8vH9
         coCeNnKyAI6cUvix3o0IdN5QtJsHqUOmwEiu9WG7oV3hJusQ56MjNWt4WtYiANawRb2d
         EXzYj2WYDfuVARRY1EdhUgiF/4zBsFLeSl1uSWYyKXgzhh9sQ/ZLWQh7nv3hVezGS7n4
         43j/p6f3F2wL8+QLoIA91SvHfoYxZUhpH7Z2UP2YJI8DZViXJLQOUyU+JDeX1rcPZ6BO
         YYhPd6RbGRJbmIRHuhR4i3bGwcDGoRemTlMo7lqNku+c5/y00XFIJkjIJPhRuwtIT48h
         czCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XOKCoe4jWaD7x9lPq3isdzFOVnNDQZD4YR70OuDp6Zg=;
        b=yRPNDA/0b3Q6F2YbidTbEC41zTJAtN1FtL4Dc/wcPGTYWrPj1ehQteq+ztnRekeamF
         T7nPuQnMmab3KFt4/jzqmhWvx/4Kdpa6S0pOfiqtiMo6qfVYaLUFy84aI8RpIN4Y9+TG
         HsvXtdSoVzoIUie5UM2r/TU3UGUDL6K6B+OMSRGBZN035ftmqvXReCodXcmyNeuPkAkx
         SoRw58pkU6DFn07qXLBDcIjjU6hgC2oTdIXi2LiOYnR+XjnuAs2YxFftH0DTbajRlk6r
         XNcvQFSF/jGCOgsDdOkxaXseEyGsnRqKx6F3SeU/ONeM0hS8VSTzHPQZeVo4zPb+VtqE
         vvRw==
X-Gm-Message-State: AOAM533kl2ZVp1psHfllQp+Fx1bpyy9zNiriG9Q6zUwt1BN8YLfqUdbx
        AaRB4vfQZHH14IIYVMa2TENMZy8lGJg=
X-Google-Smtp-Source: ABdhPJxNgrgL2pqa/NjQgOFxf2ZXQYmaWLzMRViF4EjC7wHdaITAPxupOvQXVcr0AnQxvnQMjKca0w==
X-Received: by 2002:a5d:6987:0:b0:1f0:16cb:db6b with SMTP id g7-20020a5d6987000000b001f016cbdb6bmr19518110wru.702.1647333829298;
        Tue, 15 Mar 2022 01:43:49 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:43:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 01/15] sched/headers: Fix header to build standalone: <linux/sched_clock.h>
Date:   Tue, 15 Mar 2022 09:42:33 +0100
Message-Id: <20220315084247.40783-2-mingo@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220315084247.40783-1-mingo@kernel.org>
References: <20220315084247.40783-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses various kernel types that don't build standalone.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/sched_clock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sched_clock.h b/include/linux/sched_clock.h
index 835ee87ed792..cb41c5edb4d4 100644
--- a/include/linux/sched_clock.h
+++ b/include/linux/sched_clock.h
@@ -5,6 +5,8 @@
 #ifndef LINUX_SCHED_CLOCK
 #define LINUX_SCHED_CLOCK
 
+#include <linux/types.h>
+
 #ifdef CONFIG_GENERIC_SCHED_CLOCK
 /**
  * struct clock_read_data - data required to read from sched_clock()
-- 
2.32.0

