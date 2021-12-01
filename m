Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D20464A76
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348159AbhLAJYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348151AbhLAJY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:24:27 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F293C061574;
        Wed,  1 Dec 2021 01:21:06 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z7so26833360lfi.11;
        Wed, 01 Dec 2021 01:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EW1wi/R0HJ/aIlcJ78YVZpDJaqTVDjw2XjRr1Aiua+Y=;
        b=KmKygmNS2HDoOrXvHoPtSP5ThMLb0BiEehCNwNJMd9+LIXp0HvFktBWHDOh7o3zlQ1
         GOWvmOrCa2KpFSRi5ouSYvG731XE15g2D0tIP9iJ03ZLI82fSxRcJYf14OmWIjRClen6
         ygmyu6wJGXR6SSJTz1mnYShf4aAXLa7BO/idgtEwxifRdiYGpStoYQ4axjwkQcrraAHO
         hykEZbSnzfKWB3BPBVNnzntr0S156jk1hee85pwbg4DDyKffjuJmTYipydhLiXlSJtcH
         yKIdXOQXSd2B7YaJIGGvri6gkb02X2IReZXEnfjQPcLfIOAbqt9DzculaKAhFlKLOWoF
         Bq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EW1wi/R0HJ/aIlcJ78YVZpDJaqTVDjw2XjRr1Aiua+Y=;
        b=N8+thzXXVAiLTAa87AKEYeeCgXTVXQoYNCWK5eWQvpM3slj/bicZJPWAK0l+Rfe51p
         83Z0LQm04PkeEc4z1zco9A93clpN+C32JOBP7WmQdUopiEpJdv0vgsVEWqmZ8WX6laEu
         J5yRcvoIXHIb0ttn+PBrMwXvOHHprBFOf9K7t8SV3jVerEz5c88PbMbW5g5Bd7VpdJ4q
         Gu2YjYwe2MHJVhr3ej3dbaf0vip7WdTeZK7m8biJn5PNuUk6JiagULDEUkxEr5ApD8e9
         ds+BIiDMjz8GPXj+1KlCXVIEYUfupwbzIV4Szm3zmtidvzS/7v36irFgWBfjIR7WxMY3
         AZXA==
X-Gm-Message-State: AOAM531jG4e0j386K3ne7M5mpLj2PqMLwSJdVPrz8L6/i630AI+oX/ZX
        YmCsElElVi43kuabzFmTy9Rx6wgDrQpsmoVFOl0=
X-Google-Smtp-Source: ABdhPJxVH7yfO8Womt9noB7P+lew7CjqzgIgsAEiBxjk0/XKn3k7gIufpniu4nsXfl5GrNvXJ66KnQ==
X-Received: by 2002:a05:6512:1189:: with SMTP id g9mr4685487lfr.396.1638350464351;
        Wed, 01 Dec 2021 01:21:04 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id v9sm925457lja.109.2021.12.01.01.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 01:21:03 -0800 (PST)
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
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2] rcu: Fix description of kvfree_rcu()
Date:   Wed,  1 Dec 2021 10:20:53 +0100
Message-Id: <20211201092053.2000-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The passed "ptr" parameter might be wrongly interpreted
therefore rephrase it to prevent people from being confused.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 88b42eb46406..9d7df8d36af0 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -924,7 +924,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  *
  *     kvfree_rcu(ptr);
  *
- * where @ptr is a pointer to kvfree().
+ * where @ptr is the pointer to be freed by kvfree().
  *
  * Please note, head-less way of freeing is permitted to
  * use from a context that has to follow might_sleep()
-- 
2.30.2

