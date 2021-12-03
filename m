Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F59646700F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350835AbhLCClP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350551AbhLCClM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:41:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF55C06175A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 18:37:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso3662770ybj.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 18:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fSw1ht/VcZ3dSf5YuPKT0BcZLwiLH8OOB5DtUZgNMMw=;
        b=Xnx6dEs6acvz81QlVuLmXZMWgzDXPNak7TnUiGkbMVubfP4OHilSQf/RxSCgL9k2uw
         S4MeHA2mRv4qVUg/RuE56bCmds4fm/4WSajSpH+WnGGC96iFY/TOOazGhjlAfd1z2SE5
         YqSe/e+hO9lnRg2//z0getll7GikcejkXDSP25pni+r08TnieVWRY/4ZF+qaIYyy2zGF
         zIhHnlJTSZaONZ19tscSkuu6yi6U1SQ8YEok5g9ro2NL/fY36DfMgKf28vLgSVuGCsHy
         //XXyrLNu4HakZ9ZMmAraZk84/T4sqOKk9LOkbX7mXP5086m+hWgI5Zrr422UwLZTf2B
         HnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fSw1ht/VcZ3dSf5YuPKT0BcZLwiLH8OOB5DtUZgNMMw=;
        b=XGNFW3DJZwKaRCP8zvEliaC1JN70KImIET0GDV6pssk1B+SBY0ZJ0D/Pz85zld7+Vf
         VdOoUeLw0XQCcE+WcZG2zbMdY3eyyoZjvVPT985sbgHt+FzktPWA85zi7ihaYMKPkCdE
         QwhY1yOyWVezGqIXFkumkh8SanR+b6a4Tx9p9T9D3uMkrNjhDHy7awB/oTcPyI9y5Ur+
         ZFMsR0fXNDpNTfG6az500ylafG3JyhoEVgFGBUqv3u6m/9btkhSjp2KlxWBQx1tBdVZL
         sVQjMchmH+6Zr+40dPj4gH8b+ghALqfBoGjTYhsyTRAwIuNAPQ8Wwlob44z2RRd5Ox4w
         e9Ww==
X-Gm-Message-State: AOAM533xdDVqiEnWfIaqhaVciVXfQALHcl0gqgnla2kWLPtA4eDVnUQF
        /4LX5qOkU3FritDbqLPwcnzTHam1uCoxqNOW07TwQZVKxq0FYddt61h/11Z9ia5CeRKdQ1C2CiN
        b2X1QpMvWrR4LjFwLReo1IKhWobXoPNrU1GyCFbquJpwjbYF4663zPaqArp6yVTKpu4Afx/vz
X-Google-Smtp-Source: ABdhPJwnEfF+Irtkf60aNMSjduABvwU4/QHaaj4fyZOSZiapm3CEKdh0zg13dyEc38z3JrO0bwhfaVrzC6Qa
X-Received: from suichen.svl.corp.google.com ([2620:15c:2c5:13:bc47:f5e4:20fa:844b])
 (user=suichen job=sendgmr) by 2002:a25:abcb:: with SMTP id
 v69mr19365697ybi.628.1638499068416; Thu, 02 Dec 2021 18:37:48 -0800 (PST)
Date:   Thu,  2 Dec 2021 18:37:28 -0800
In-Reply-To: <20211203023728.3699610-1-suichen@google.com>
Message-Id: <20211203023728.3699610-4-suichen@google.com>
Mime-Version: 1.0
References: <20211203023728.3699610-1-suichen@google.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [RFC Patch v2 3/3] add npcm7xx debug counters as sysfs attributes
From:   Sui Chen <suichen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        joel@jms.id.au, andrew@aj.id.au, tali.perry1@gmail.com,
        benjaminfair@google.com, krellan@google.com, joe@perches.com,
        Sui Chen <suichen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds npcm7xx debug counters as sysfs attributes using the
i2c_adapter_stats_register_counter function.

Signed-off-by: Sui Chen <suichen@google.com>
Reviewed-by: Tali Perry <tali.perry1@gmail.com>
---
 drivers/i2c/busses/i2c-npcm7xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index 0b87706de31d7..1268b2d71ca0a 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -2228,6 +2228,15 @@ static void npcm_i2c_init_debugfs(struct platform_device *pdev,
 	debugfs_create_u64("timeout_cnt", 0444, d, &bus->timeout_cnt);
 	debugfs_create_u64("tx_complete_cnt", 0444, d, &bus->tx_complete_cnt);
 
+	/* register debug counters in sysfs */
+	i2c_adapter_stats_register_counter(&bus->adap, "ber_cnt", &bus->ber_cnt);
+	i2c_adapter_stats_register_counter(&bus->adap, "nack_cnt", &bus->nack_cnt);
+	i2c_adapter_stats_register_counter(&bus->adap, "rec_succ_cnt", &bus->rec_succ_cnt);
+	i2c_adapter_stats_register_counter(&bus->adap, "rec_fail_cnt", &bus->rec_fail_cnt);
+	i2c_adapter_stats_register_counter(&bus->adap, "timeout_cnt", &bus->timeout_cnt);
+	i2c_adapter_stats_register_counter(&bus->adap, "i2c_speed", &bus->bus_freq);
+	i2c_adapter_stats_register_counter(&bus->adap, "tx_complete_cnt", &bus->tx_complete_cnt);
+
 	bus->debugfs = d;
 }
 
-- 
2.34.0.384.gca35af8252-goog

