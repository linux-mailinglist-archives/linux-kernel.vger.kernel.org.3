Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E325A5ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiH3E2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiH3E2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:28:32 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A355B9E0F5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:28:31 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 10so8331676iou.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=IiYV69tyEj+bybX6EJGKjRJBog8U9SbwxG5mkmTGRVw=;
        b=XVONKF7d3W7EwJOLHgmUQlSsZx1O823f6Rhtuul//ZTdPlpsEw5PIODBxIhzsc6WGp
         j7x+W1hY5a28AYYVt9Za/EaIMXL15HdiA2ms5ZYAOFAVkTRuIrcQeOsRnZuYDB7FVk3c
         +NpN/9EIQQEOa+4Qejc4S1azLG25u/kHejDzz7P2ipMV4HRizNArSkviiV7dVcQaehg1
         qkZ4g7X71uOE4EFrZZYzQsZVt2yNAZVWB/WsVfxeUt6t9ZZA9DVkgCyOjeJgYrWFj+gz
         Mq5owqtaO2Gg96hQ1XKjLpodC18At1I4l2w98y/0svMPRbZct5kGmo9jQnbrj02qZxTL
         j75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IiYV69tyEj+bybX6EJGKjRJBog8U9SbwxG5mkmTGRVw=;
        b=4uww7okH7uQvQBtL1teIvOP0IGm17YwC81+eKOHPiQEAL87/BDAg6uRYJcgkMziMF6
         ZEwfKw+AnXowzAOO3cujk2lEfEdsqLp3/3YZ2+4cKpo9Uj0F+DHhHqP+aiP2PJrLSXI7
         5Sg3Q6TPcv/twUSbwgUPdm40KF4L8Shpk+twfCHbcOUcF65GNorb/uua8BbNkZ8Uf9Vl
         K40ZeDy1F6pvkTFT9Nn5HxLFAjV92k189jDaERjhswQBG1qjmHVJ647xdRsFDcfj2yLm
         jMhM/gtJGinTkF3be6A82SgFCdZ8YIYAy+ZOLPhDrpwrA8WatzmGCeXkMexpuhm1PL8r
         qMIg==
X-Gm-Message-State: ACgBeo1zvBtKa+nUy+pQfwnhCr63ZHfvRQSFAn1L/e4ApqxUVx5M770H
        gfnLrTLUpc0BUaQaevs2jqOScKbE+oLjIXqciIg=
X-Google-Smtp-Source: AA6agR5YwsPm1vdnZEuZ/JPg/Q4vlN/vmdgvE1r7QOmb/lP3dObcMTm7SnQwunOu+42Lb3Yuu0bO0ea1iKw1LcOT1QQ=
X-Received: by 2002:a05:6638:2613:b0:346:e2c5:aa4e with SMTP id
 m19-20020a056638261300b00346e2c5aa4emr11473681jat.160.1661833710912; Mon, 29
 Aug 2022 21:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220803151217.75962-1-ppbuk5246@gmail.com>
In-Reply-To: <20220803151217.75962-1-ppbuk5246@gmail.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Tue, 30 Aug 2022 13:28:19 +0900
Message-ID: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
Subject: [PATCH-RESEND] arm64/kexec: Fix missing extra range for crashkres_low.
To:     will@kernel.org, chenzhou10@huawei.com, nramas@linux.microsoft.com,
        thunder.leizhen@huawei.com
Cc:     linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like crashk_res, Calling crash_exclude_mem_range function with
crashk_low_res area would need extra crash_mem range too.
Add one extra crash_mem range when crashk_low_res is used.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c
b/arch/arm64/kernel/machine_kexec_file.c
index 889951291cc0..378aee04e7d4 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -51,6 +51,9 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
        for_each_mem_range(i, &start, &end)
                nr_ranges++;

+       if (crashk_low_res.end)
+               nr_ranges++; /**< for exclusion of
crashkernel=size,low region */
+
        cmem = kmalloc(struct_size(cmem, ranges, nr_ranges), GFP_KERNEL);
        if (!cmem)
                return -ENOMEM;
--
2.35.1
