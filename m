Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495DB46716A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350205AbhLCFWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243166AbhLCFWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:22:40 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB88C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 21:19:17 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r5so1947372pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 21:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GVqafunwPWXmAjyJPdNL+lOWplDkoj4GRSmoAGhLTPA=;
        b=REEg2gS/dh5rFKyzK5RKYyUBiMEkwuUjNMc3emuUNQXyNd0RRMozScpH2ONRBntqFj
         iSE8cZ0VuPdz5S8YBCUBcxcHUqn6/cYCavAK83D7qJ8BVovuuMbZUHAm6m32cdY6L3RP
         /PFlfkwgMvc5V1c099gRNQ+CLM+TKF1aZ9aLufVE6kW5qs2icSEO2ax6anJfBIxHCR27
         enUC8Jsi5MbFpvcYB01QDksGZjsKsuUSKmIXErvf/uxMCxQQ7mCOIpY6+QAbC8jlUnxF
         1h5+LlqCr9cPWfJEfo4vS4t78ltU2IfGo6ZZBPuTMF/wNgWW8m2qO9VWTApx/e3E0j0f
         3oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=GVqafunwPWXmAjyJPdNL+lOWplDkoj4GRSmoAGhLTPA=;
        b=wOdvc0IFonGUiHfATUs76kPUlcyixJaq+14afYgyz088W1TpKLNNRC990A6OVySSEo
         CRV2ua257gcDN0YWONW+jr1BXvrN6oDT5pm0XMM6cwWR3CJhcac7aHUgejdts5cmTBQ5
         FML7OpFUE+1cGfAj8MKya7INomx2kKVVxZaeJiNklLmAevLXTJ4JjBL5rfBEbRtGTYk0
         d4DmXeH0UuaO1wF93PWr1As27QNqai1wJE2x9xDNb+fjOgOVZHqSbPrQxk0Hw14jCKpo
         P+2CGnWd3++UKkVDkU6DNUrm5/bKtA0Z8VY1hhK5ByY7WORtmWy9KapPu2MQnWRKkC7Y
         hmpA==
X-Gm-Message-State: AOAM5329FZDUgGMHO8chUC0ENycIGP3c+WeZfgkMKOve65XT4rj+0fHE
        4TVEGEFQHqfFM2QrtXt57/c=
X-Google-Smtp-Source: ABdhPJw91DFPDQg/VGrcA08T3OZPHg5qyZjuApkdl9jCHQ8tLSL3Fd/Mt9wimLao50slC5S8XO4+bw==
X-Received: by 2002:a05:6a00:1349:b0:4a0:2f9:e3ab with SMTP id k9-20020a056a00134900b004a002f9e3abmr17109711pfu.80.1638508756861;
        Thu, 02 Dec 2021 21:19:16 -0800 (PST)
Received: from vostro (173-228-88-223.dsl.dynamic.fusionbroadband.com. [173.228.88.223])
        by smtp.gmail.com with ESMTPSA id t8sm1130752pgk.66.2021.12.02.21.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 21:19:16 -0800 (PST)
Sender: Nikitas Angelinas <nikitasangelinas@gmail.com>
Date:   Thu, 2 Dec 2021 21:18:52 -0800
From:   Nikitas Angelinas <nikitas.angelinas@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Denys Vlasenko <dvlasenk@redhat.com>, linux-kernel@vger.kernel.org,
        Nikitas Angelinas <nikitas.angelinas@gmail.com>
Subject: [PATCH] ptrace: remove redundant setting of PT_SEIZED in flags
Message-ID: <YamovBH+iLagivSH@vostro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PT_SEIZED is set twice in the flags variable in ptrace_attach(), so the
second one can be removed as redundant.

Signed-off-by: Nikitas Angelinas <nikitas.angelinas@gmail.com>
---
 kernel/ptrace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index f8589bf..eea2650 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -419,8 +419,6 @@ static int ptrace_attach(struct task_struct *task, long request,
 	if (task->ptrace)
 		goto unlock_tasklist;
 
-	if (seize)
-		flags |= PT_SEIZED;
 	task->ptrace = flags;
 
 	ptrace_link(task, current);
-- 
2.10.0

