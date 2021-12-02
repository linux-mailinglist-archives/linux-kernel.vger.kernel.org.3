Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A66466569
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358641AbhLBOlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347205AbhLBOlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:41:07 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB660C06174A;
        Thu,  2 Dec 2021 06:37:44 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id d11so72933ljg.8;
        Thu, 02 Dec 2021 06:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4vEQhDmd+Bmxi8r3tu4+PWjNjPYfx5p03+GfmpdY0g=;
        b=TEwsMJteFeje1cN64vjLp9spN5yn4Bh25t4gG0C+gcPkd6OoKQDqOcqZiDN0+K/P5Q
         fE89zl7G5tvpcdG8JhmJQz0yRnnajfYPvNTXkSClSvjLjU3QhiP/hcsp01Wi7wpnkvpT
         AXlxhUzX5GgU3c9zQCiLXClQ+/4Z7LXOG3FLc5tFnDFSjpm4GhG215/CRmgeZ0i9yO8H
         5HiRr5jmXoj00i1XtGkPGd5OfmL4EzLlWjLaGZWmRCYYf2LGnPWWozZ5EoJ6TRSn2AnC
         2wOKtt0SPn6e3v+vCIuSlwCgrPcIWurLmVgsmMsO7Z8tMEWTdvp+XbMkJo+tzm4bgA10
         7tnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4vEQhDmd+Bmxi8r3tu4+PWjNjPYfx5p03+GfmpdY0g=;
        b=lNCQBHCZeay9AcFIjpK6e/6y9LjtGYubCk1NRg1bAiIr8vCI6MhU8dtvhp9q90QRTk
         vwn3FQ2xen606PQ/zSsAWkiEpaNlGqCB+euw1DAfzqSwwWlSRlkNPP1NJA0Tqa8k/66c
         MQCvO7rliTG7hlXHXuMK7TR+USZfEin8Sj4AtXr2+wyotpQneKAVydmEUqh7S6ZPgejA
         CDTv9wrLqF+m8kw4o/cfbG2isC3tOIxvV6J4fMRBK1TsJy84VqKYigKY2cogYwrKy41i
         W8L8Zb68SDJrdGj+PZdbXcF/0U6rFxo0XlhGxMJOV3RFyhBOhHltJsk37VylqnAUyMoY
         Iwuw==
X-Gm-Message-State: AOAM533V88zAEUrymELxD886ICnRYr6gkK4etOgwBLmGOK4+qck/jYfx
        JT6LjovMyO9cwQ04uSxDfzw2I6hZq6M=
X-Google-Smtp-Source: ABdhPJx3YHpS+rX+CSWi4QKkTQBO4TQ1mv0wOHQw2u76ZS9/6q7wgJX3++w7zSwaiD/TQNj+fGnYiA==
X-Received: by 2002:a2e:84c4:: with SMTP id q4mr12100290ljh.266.1638455863144;
        Thu, 02 Dec 2021 06:37:43 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id f19sm368976lfm.119.2021.12.02.06.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:37:42 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/2] powercap/drivers/dtpm: Constify powercap_zone_{,constraint_}ops
Date:   Thu,  2 Dec 2021 15:37:33 +0100
Message-Id: <20211202143734.101760-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202143734.101760-1-rikard.falkeborn@gmail.com>
References: <20211202143734.101760-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are only passed as input to powercap_register_zone() which takes
pointers to const powercap_zone_ops and powercap_zone_constraint_ops.
Make them const to allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/powercap/dtpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index b9fac786246a..d7ac5e79fee1 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -341,7 +341,7 @@ static int get_max_power_uw(struct powercap_zone *pcz, int id, u64 *max_power)
 	return 0;
 }
 
-static struct powercap_zone_constraint_ops constraint_ops = {
+static const struct powercap_zone_constraint_ops constraint_ops = {
 	.set_power_limit_uw = set_power_limit_uw,
 	.get_power_limit_uw = get_power_limit_uw,
 	.set_time_window_us = set_time_window_us,
@@ -350,7 +350,7 @@ static struct powercap_zone_constraint_ops constraint_ops = {
 	.get_name = get_constraint_name,
 };
 
-static struct powercap_zone_ops zone_ops = {
+static const struct powercap_zone_ops zone_ops = {
 	.get_max_power_range_uw = get_max_power_range_uw,
 	.get_power_uw = get_power_uw,
 	.release = dtpm_release_zone,
-- 
2.34.1

