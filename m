Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6697B4757A2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242005AbhLOLTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbhLOLS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:18:58 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4D4C06173E;
        Wed, 15 Dec 2021 03:18:58 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id m12so32790649ljj.6;
        Wed, 15 Dec 2021 03:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Do+igy+24OpCO8ayQtrvopM+UKDBXHu8XcWDcF2aT8A=;
        b=gtea3RiShrHzm8K2NJN9kLT0Tk3BzL4XLXaiyJ8GsRdnG96DSfC/fD+bR6ixZFSUkN
         feEZjnAR22tXPQSjRK/vYhizXd0p/GbIn3n8ixnaBw2fdatq5yqIxnRwcj8PPKWUHRro
         afFIL1zBsSx1PJSL5Lt3+TSfkLfnDPZt/JuWeUuUFSLOsok499cR2e5yYD77hhcXihmF
         /qBJGE/xBl2C8rn9OndUgSaUW50zg+Zhv7kr/aJv8TsMkFCemKxSMcNR42jOilLuhPTt
         0G73W/rS3Jux/oxGd2GBxC9uzlPYIelwV/N6I7jzy+hFq+0FDG8AOeHhvvDALngFDuKF
         Y25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Do+igy+24OpCO8ayQtrvopM+UKDBXHu8XcWDcF2aT8A=;
        b=Cc+HaaPcxm3m3JHM+lW2cGRCEAaQHEUxEGOIJIUmmhU6pEG/q1TDgMvJOIM8N6aP3O
         makWdaBawkdDNJn3PyhmpTI7QqBds1vQPoBbOKT09C2KGMqyH54S0tCcXqbafz6G2ku1
         BiPBjaO9AGS2Xf5TEhLVPZ7bfVJInbqjmCaKdRndYiBfUJHkuyCZSXa9IHFeoXogkwzl
         YUvhiM4a2MYEh3TozyrkheGZuRUcDb2DX7YLBa61F7ikuPIDXx7x7/DuoslItpANit4D
         5WrXAZz04Uod6b4oGDKlLIH09s/IySurqwVYeNNImBE/s5/F3V/DWTTAXJRayNvOhlze
         ynHA==
X-Gm-Message-State: AOAM530keDXnp5/gIVsdonFOwu1lZsm9/W5jzTEANcF/43LFBa9y0qrb
        5iiJ/eaoboOu0aY+Fxek4Yia8X3E5tpIlgux
X-Google-Smtp-Source: ABdhPJwFOszL8X0098U2pAArbk7tuSgkGkfS74rjH//U2QP8U89diYehibh4lSdLUziYcOh7tlp7Fg==
X-Received: by 2002:a2e:2a46:: with SMTP id q67mr9683196ljq.398.1639567136643;
        Wed, 15 Dec 2021 03:18:56 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n17sm383906ljg.128.2021.12.15.03.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 03:18:56 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>
Subject: [PATCH RESEND] ext4: Switch to kvfree_rcu() API
Date:   Wed, 15 Dec 2021 12:18:39 +0100
Message-Id: <20211215111845.2514-3-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215111845.2514-1-urezki@gmail.com>
References: <20211215111845.2514-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uladzislau Rezki <uladzislau.rezki@sony.com>

Instead of invoking a synchronize_rcu() to free a pointer
after a grace period we can directly make use of new API
that does the same but in more efficient way.

TO: "Theodore Ts'o" <tytso@mit.edu>
TO: linux-ext4@vger.kernel.org
Signed-off-by: Uladzislau Rezki <uladzislau.rezki@sony.com>
---
 fs/ext4/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4e33b5eca694..111b0498a232 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1886,8 +1886,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
 		return -1;
 	}
 	rcu_assign_pointer(sbi->s_qf_names[qtype], NULL);
-	synchronize_rcu();
-	kfree(old_qname);
+	kvfree_rcu(old_qname);
 	return 1;
 }
 #endif
-- 
2.30.2

