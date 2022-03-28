Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344EE4E932A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240615AbiC1LU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbiC1LUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:20:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0E355741
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:18:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w7so24106725lfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=CQb3mBxSCWM+ulf0NN0OcDqev6TRbJ0Ip390Rr+PwxE=;
        b=ObfXCKoqDrHaLfhDGBh1SKtdZKCDFq8ONsWFdRwrSCMeiztkQz2bXqiHkkDqdGts7W
         rYYbKlrjBYViG3Hm2pJFR7bt48aReyKqgTir+0yktFtUZGJ0/8iibcLqW6Iby860hdFk
         TNPqSYyNGxCnT6QfbMHPtmrxQWx6ZKJsxiYPHJjpv4jVOWveqqkUgH2fnjUtwrEXJORc
         cgoJuuqqabZjDkeh9CbMBPIYLvX6CX0Uq/yL8sSJtCt7zFcnWlIxrAX1mLT57VviLF2G
         DVXTdlkdIMkPKY4jZd3FgGwWNW5GXbnqLGcL3IBmornpUz/kq85Y98fCZNy+o6ZtXCXi
         5bwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=CQb3mBxSCWM+ulf0NN0OcDqev6TRbJ0Ip390Rr+PwxE=;
        b=zwnwWCQRwRqM9QW3QZL8PFi7q/xSxRHxgcR0bUAbPEPjt+t4kc77exGcWh0FyWdxTu
         10J3nK2pzNsiA7L336bdT8H+VMcpSo8gKIDL1+U1XgGDsvA5KH8w0efkXtABj+1/Qg4H
         fjVT4c5ftvDbI/gwpfRD2kfaKYtmCa/MNx9AiQNEdF6gVZJUsgQKhx3Rpnk28NkPpEUc
         XDWFjTpxMni9n3C5jZgU54d8n8i8sWhrvgs7fAsy/UG4iUKzL0XUiaXIvpDdRhrWUtLW
         Ax/417HbVWf0oq4prIpv2I0zMrVwkY5KNf1dLCheNHRAwllFXvT+K9A9FTHYUeTBlJlO
         bV0w==
X-Gm-Message-State: AOAM531kF9RWdGvehIHx3EiET7l2ed0P69rvWRDQT/a3QqiSYeeLRiit
        KgI2+P+XpaAx6h0w2xhmAUwNag==
X-Google-Smtp-Source: ABdhPJzC9I5iTmkp1bV3jvbqseRJhFE1aB29rKJ9JSfKooecWBKUfY8aJyGzmUFdJjF2jaH2tVLXbw==
X-Received: by 2002:a05:6512:1156:b0:44a:1027:e505 with SMTP id m22-20020a056512115600b0044a1027e505mr19494729lfg.88.1648466310213;
        Mon, 28 Mar 2022 04:18:30 -0700 (PDT)
Received: from [127.0.1.1] ([2.92.192.17])
        by smtp.gmail.com with ESMTPSA id f3-20020a056512228300b0044a0e0a609bsm1605694lfu.38.2022.03.28.04.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:18:29 -0700 (PDT)
Subject: [PATCH 2/4] dm: Process .io_hints for drivers not having underlying
 devices
From:   Kirill Tkhai <kirill.tkhai@openvz.org>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, linux-kernel@vger.kernel.org,
        khorenko@virtuozzo.com, kirill.tkhai@openvz.org
Date:   Mon, 28 Mar 2022 14:18:29 +0300
Message-ID: <164846630905.251310.11706161266244591219.stgit@pro>
In-Reply-To: <164846619932.251310.3668540533992131988.stgit@pro>
References: <164846619932.251310.3668540533992131988.stgit@pro>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes dm_calculate_queue_limits() sets the hints also for drivers,
which do not have underlying devices.
This is useful for dm-qcow2 driver, that wants to have incomming requests
are likely splitted by QCOW2 cluster size alignment.

Signed-off-by: Kirill Tkhai <kirill.tkhai@openvz.org>
---
 drivers/md/dm-table.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e43096cfe9e2..aa2e85bef6e7 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1660,8 +1660,11 @@ int dm_calculate_queue_limits(struct dm_table *table,
 
 		ti = dm_table_get_target(table, i);
 
-		if (!ti->type->iterate_devices)
+		if (!ti->type->iterate_devices) {
+			if (ti->type->io_hints)
+				ti->type->io_hints(ti, &ti_limits);
 			goto combine_limits;
+		}
 
 		/*
 		 * Combine queue limits of all the devices this target uses.


