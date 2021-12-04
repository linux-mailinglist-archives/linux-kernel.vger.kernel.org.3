Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C0E4681F2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 03:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384069AbhLDCWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 21:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384064AbhLDCWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 21:22:33 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B45C061354
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 18:19:09 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id m24so3289317pls.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 18:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kp6JhYL+Z3ZfrtYFfZ5FODVyqreKCCwC0m5TFZk89LA=;
        b=F8qKo9szMxHOXTPS0meragjB5M2kuUMwFpJDkCy8U5TLqzkZGu+cEGaNoO3FMBlzpA
         1LmMpesyGXbwBJFY9pqhJwadvG8BN6gLxbfPcpA1NKGq41zBfXoPtOCdnBZO2IWTENGR
         8mnc+Fb47DDvvEqAbRFq092jziqEuv+WgxVNXCn3Kwed+lVLSbBIYfU2KEz48r/KOyIJ
         7irzQazIj6uddz+/y/z4WfQRCurp8KeadEu68FT02AD9AkjRuon19MEcLsKTKvpodP+j
         VPo+ZpXTaM4rFibL3x/G6f/NJM8/vQkFOClzaRa2CSf5ovQWikSstMRnV7TaviZZJ7yX
         ln1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kp6JhYL+Z3ZfrtYFfZ5FODVyqreKCCwC0m5TFZk89LA=;
        b=SGQJOP3zaJZStairhmCNg+7Hfy2qpyhDgwZa640uO18AkSmdSbHzknUh/kKaujm1Ds
         2qMFuDJB51if4K1xZD65wP2CFCq0e4vNKwRAIkqQuB3XvIESr3j4YxpCVGXXvy5pzPvb
         l7bqfim1/I6LlxpsvFjdIqnNsh6s9kk8V+sVAIvLhhGkhYG7jzIlEBy18VpvqsTbepIo
         ErtJGZ6czN80smvAfUDworMrIvD1hSBRcLcAYeBpT59qwJ8KSzLGAOf0L+VMLv+YmuBA
         ZLRWEhUBZhIGoyoBkxAh2DqBGTJIrsgSFV62BkMSx/yjOhxXLU9lSh+HZaFEh5PiHe7G
         12lQ==
X-Gm-Message-State: AOAM532hwEo7uEtLAxi2apE63SrPXtuNrYLZ5O+7OyqwQhC1c/imIhlL
        vL0mF10nl8zPDcg8/crcyr6ZYY0QnZTJdg==
X-Google-Smtp-Source: ABdhPJwVQYFabKTToF80XLT85Ns5lteAmFJwIiYzK6nRHC7DnPk0uKUHCwqDt4dprLlWwedWrrBYFg==
X-Received: by 2002:a17:90a:f481:: with SMTP id bx1mr18949125pjb.117.1638584348435;
        Fri, 03 Dec 2021 18:19:08 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id r6sm6147647pjz.56.2021.12.03.18.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 18:19:08 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/3] openrisc: Use delay slot for clone and fork wrappers
Date:   Sat,  4 Dec 2021 11:18:41 +0900
Message-Id: <20211204021842.1853549-3-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211204021842.1853549-1-shorne@gmail.com>
References: <20211204021842.1853549-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This saves one instruction.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/entry.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index c608f76e5753..8cd2113057c5 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -1162,15 +1162,13 @@ _fork_save_extra_regs_and_call:
 
 ENTRY(__sys_clone)
 	l.movhi	r29,hi(sys_clone)
-	l.ori	r29,r29,lo(sys_clone)
 	l.j	_fork_save_extra_regs_and_call
-	 l.nop
+	 l.ori	r29,r29,lo(sys_clone)
 
 ENTRY(__sys_fork)
 	l.movhi	r29,hi(sys_fork)
-	l.ori	r29,r29,lo(sys_fork)
 	l.j	_fork_save_extra_regs_and_call
-	 l.nop
+	 l.ori	r29,r29,lo(sys_fork)
 
 ENTRY(sys_rt_sigreturn)
 	l.jal	_sys_rt_sigreturn
-- 
2.31.1

