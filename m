Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD703559301
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiFXGGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXGGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:06:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C0B45796
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:06:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n10so1286087plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59X2Y/lmawDJzmXwQWp9mJFaRGi+BKzpUp2IksdQUqM=;
        b=OnJXKxUvdaQmcj7PIEfMQNOZQNQrgxlyqFN9pCLtIv2JPQFwKTqbYue+ASHmg7LJHy
         BLqF6T9A3bZliGYY2FuNcbcMjUFDn1Ukxn/AKAalmbGHX/lN6MWAFZ6lZI6E1JSsxi8w
         ImtOP5ZnM+BJORSm9xxUjoCkhdO50ENI5Ma8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59X2Y/lmawDJzmXwQWp9mJFaRGi+BKzpUp2IksdQUqM=;
        b=NwEfm/qQQ0iXbyLQ93kai0DCrYqA79qRmwai9/QDDhy9BZNZBZkzyHQwjjYYlMZ3CN
         A0ugLiHY60KOeIu51F7g++MiFXaGhMXwS/4Bc+ahgYi1++SF3Fg7xVh1pV/wbg0KOPrN
         EtezVKGL7zE+EqeDhtIH+m+YdxJJVZKBF9K3Xz+JBnjzAQSauD/cTkjnEhVEBQ7MW5nr
         5S9/bibQ4tg00elE5AQBqxg0pXYQi9RO3J1vbRrqOmj7283SO5f3MDefCCWIyyGg42DH
         oZ/Qkx0tvpmORJ8ESKwO9ELmXV3BDxGQw3raude1rSGLD34NPG9kmGl/WL+SxDgVARvS
         PLag==
X-Gm-Message-State: AJIora+XcMm3mW6YYsXmcSUbJebAW9aQGDvLAtoev6b/dwhnr7BM79dH
        eNGThnl3NGlfnMj93eVX302T2jPvSLbrVg==
X-Google-Smtp-Source: AGRyM1tFIpPGmWtk1MlqL9vrcPT41S0nFC9urfAPlwORV2qpEJeMO3V45pNMPosGn/lLjhDHolVF8A==
X-Received: by 2002:a17:902:74c7:b0:16a:1be3:b7f2 with SMTP id f7-20020a17090274c700b0016a1be3b7f2mr27150781plt.42.1656050771473;
        Thu, 23 Jun 2022 23:06:11 -0700 (PDT)
Received: from senozhatsky.kddi.com ([240f:75:7537:3187:421d:f075:63ad:7026])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902694700b0016511314b94sm850765plt.159.2022.06.23.23.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 23:06:11 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2] zram: do not lookup algorithm in backends table
Date:   Fri, 24 Jun 2022 15:06:06 +0900
Message-Id: <20220624060606.1014474-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always use crypto_has_comp() so that crypto can lookup module,
call usermodhelper to load the modules, wait for usermodhelper
to finish and so on. Otherwise crypto will do all of these steps
under CPU hot-plug lock and this looks like too much stuff to
handle under the CPU hot-plug lock. Besides this can end up in
a deadlock when usermodhelper triggers a code path that attempts
to lock the CPU hot-plug lock, that zram already holds.

An example of such deadlock:

- path A. zram grabs CPU hot-plug lock, execs /sbin/modprobe from crypto
  and waits for modprobe to finish

disksize_store
 zcomp_create
  __cpuhp_state_add_instance
   __cpuhp_state_add_instance_cpuslocked
    zcomp_cpu_up_prepare
     crypto_alloc_base
      crypto_alg_mod_lookup
       call_usermodehelper_exec
        wait_for_completion_killable
         do_wait_for_common
          schedule

- path B. async work kthread that brings in scsi device. It wants to
  register CPUHP states at some point, and it needs the CPU hot-plug
  lock for that, which is owned by zram.

async_run_entry_fn
 scsi_probe_and_add_lun
  scsi_mq_alloc_queue
   blk_mq_init_queue
    blk_mq_init_allocated_queue
     blk_mq_realloc_hw_ctxs
      __cpuhp_state_add_instance
       __cpuhp_state_add_instance_cpuslocked
        mutex_lock
         schedule

- path C. modprobe sleeps, waiting for all aync works to finish.

load_module
 do_init_module
  async_synchronize_full
   async_synchronize_cookie_domain
    schedule

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 052aa3f65514..0916de952e09 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -63,12 +63,6 @@ static int zcomp_strm_init(struct zcomp_strm *zstrm, struct zcomp *comp)
 
 bool zcomp_available_algorithm(const char *comp)
 {
-	int i;
-
-	i = sysfs_match_string(backends, comp);
-	if (i >= 0)
-		return true;
-
 	/*
 	 * Crypto does not ignore a trailing new line symbol,
 	 * so make sure you don't supply a string containing
@@ -217,6 +211,11 @@ struct zcomp *zcomp_create(const char *compress)
 	struct zcomp *comp;
 	int error;
 
+	/*
+	 * Crypto API will execute /sbin/modprobe if the compression module
+	 * is not loaded yet. We must do it here, otherwise we are about to
+	 * call /sbin/modprobe under CPU hot-plug lock.
+	 */
 	if (!zcomp_available_algorithm(compress))
 		return ERR_PTR(-EINVAL);
 
-- 
2.37.0.rc0.104.g0611611a94-goog

