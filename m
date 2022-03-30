Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09624EBF92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343523AbiC3LJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbiC3LJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:09:06 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374B2DF21
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:07:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i11so8867350plg.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gZDsx89oNk9ecCZgu7KJS9C8N6zgmIGWjvyPPdJUVi0=;
        b=TnejDI8s2vmrfhxCxUhC5M3j7UIVNqXIE57QjETShrQX72D2pzHtyrcbdbILuYiPzc
         16xnYyTpMWdkkozkXNWU1D9FfFcOBuWAfkzWjfirgrKSh6kRajGOJdb3IhDKHjatNy7q
         QzskjjJqwYqcDrOE/iTpmbGNY1FE2CX1fAZB44pjK3GfxXw6U6Zp/8X7QiphtwCv0Cnb
         9PAmq0U4xkTdYsqOt/svKYyO5h/qnFtvyq8EBH6QPP7IG2cSYgZpP/i46d0/koXKKebg
         /UPYp3IpqpRGVx+IspqlDWSbnhko80nOHYqj+dvdqKvqzz2HQwg2ZDm9I1lThf1y9vrD
         8B2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gZDsx89oNk9ecCZgu7KJS9C8N6zgmIGWjvyPPdJUVi0=;
        b=HdcZf6gJECsG9ZXCDW7y+mEzfgpLeBaOdDV9RwaLhdPaS57VVol85v1tASzwCrq8ZL
         yJiB0PFZuc3xV7ulJu/a2UWvSaSTCjnuqzX5TQa8qjHwP2YMqMCEj9puryt3+bcJqYf5
         M+lMwiPuVD0Y1iBT7Xq4EeT+KgsLZzc/xkUB3kjvwc40yb73BW9n+pJmy1fHzTaL4dRg
         +5DvMritc4vKZoSMziEmkUySjcnhU7SxzsA0V9gL20U6hLQmbWDVnhZgNaHxo98LHi3g
         39MWir72G2scWfNn7ZgXPB79wo48JLLt6eRfcuAu24wgK73l1UFBqU7qrojkbqO/97sC
         ccCQ==
X-Gm-Message-State: AOAM533ODaaRBnoM+2AMYVv7Fiuzm60K5Rf43h869QmtQUYk9AMXi/Re
        21252q8GdL1Z9U4UNAFu/rlRZdQ/hlqeWzqZ
X-Google-Smtp-Source: ABdhPJzoPU/cisSRGMv2i5K+JEagW3tINDP53KoRYg78DmzMZiXCvR1SOGs5ZHpFs6iq/dq7o2zjBA==
X-Received: by 2002:a17:902:e549:b0:154:b1f8:cc82 with SMTP id n9-20020a170902e54900b00154b1f8cc82mr34909820plf.82.1648638441528;
        Wed, 30 Mar 2022 04:07:21 -0700 (PDT)
Received: from raspberrypi ([49.166.114.232])
        by smtp.gmail.com with ESMTPSA id g12-20020a056a001a0c00b004e1307b249csm23383105pfv.69.2022.03.30.04.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 04:07:20 -0700 (PDT)
Date:   Wed, 30 Mar 2022 12:07:15 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        austin.kim@lge.com, p4ranlee@gmail.com
Subject: [PATCH] arm: kdump: add invalid value check for 'crashkernel='
Message-ID: <20220330110715.GA1534@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Austin Kim <austin.kim@lge.com>

Add invalid value check expression when no crashkernel= or invalid value 
specified using kdump.

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 arch/arm/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 039feb7cd590..8018d71ccaed 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1004,7 +1004,8 @@ static void __init reserve_crashkernel(void)
 	total_mem = get_total_mem();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base);
-	if (ret)
+	/* no crashkernel= or invalid value specified */
+	if (ret || !crash_size)
 		return;
 
 	if (crash_base <= 0) {
-- 
2.20.1

