Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D477152114F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbiEJJto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbiEJJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:49:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C057613D7D;
        Tue, 10 May 2022 02:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BEB3615F6;
        Tue, 10 May 2022 09:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EE5C385A6;
        Tue, 10 May 2022 09:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652175940;
        bh=DA2sXq3+sFtWkZvanBaOfDxgyFD71ZwLr0nhsoVt/Vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSYdStevd34miebV06Iq8S7LogMNsnybjdRk8kFhtYWJCiG+xDCZXddPnvEy3wgAS
         lqkXSJqbX+/FScknnQvdxd5+w6U0N/CW29rEvI9i58awd1417yhTvFe1j/JtJbHFQC
         ZP6JkiIWR4Qmxx0mHGApe1W2j7RcxXZKiNlbdFu/eyYRB5oPGlNpBB8VVLlwySI+kJ
         2lz6OUIuQwgXuBGjcVZ+KsDDVhPKaKm/ScZX49IgnPpjvZqZrWcPXuXoqJG7XgZM0/
         AvEH/IdFwyCVkrTu0Ol6i9rJeSAiSqYnfmPQ9lzTtMnPeaZi50GrozyBprOatGJXOy
         qkN3l0+AOZlHw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH 3/3] tracing/timerlat: Do not wakeup the thread if the trace stops at the IRQ
Date:   Tue, 10 May 2022 11:45:25 +0200
Message-Id: <b392356c91b56aedd2b289513cc56a84cf87e60d.1652175637.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <2c2d9a56c0886c8402ba320de32856cbbb10c2bb.1652175637.git.bristot@kernel.org>
References: <2c2d9a56c0886c8402ba320de32856cbbb10c2bb.1652175637.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to wakeup the timerlat/ thread if stop tracing is hit
at the timerlat's IRQ handler.

Return before waking up timerlat's thread.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 9b204ee3c6f5..035ec8b84e12 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1595,6 +1595,8 @@ static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
 
 			osnoise_stop_tracing();
 			notify_new_max_latency(diff);
+
+			return HRTIMER_NORESTART;
 		}
 	}
 
-- 
2.32.0

