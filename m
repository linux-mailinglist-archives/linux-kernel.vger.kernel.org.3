Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494EF518786
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbiECPBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiECPBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:01:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0100B3969C;
        Tue,  3 May 2022 07:58:04 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g23so20141195edy.13;
        Tue, 03 May 2022 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4J0TXs18gqns+4JZf+KQYg5aqBVIKZja+gfFqzNHW4U=;
        b=G9URfULxRy4NDm3FtIZIY5DV9M0d/Ksbx2XKFDBuN2LX5aVgdT4wsZeSL4D5PVPbcK
         0rJZ0AWX9112nieQ6/EMXwBF44KKWkBg2U5PgqSkB2pTHtrtkVBMXMcm61UAXqICSh1E
         E6G7XPSMYHRgq4ISdqtpNI6YmEUYg2UmSNcvHkahig0aXEcGCmBMjPwI/yzqmTKLCLAU
         Sww+Zm055zRVQLo4ajOMfAVJo2Xugml+vae3qo34QHIvJGuWSkhQ/xHHu5WKENar6aPd
         RUXfx4r10hcskmHcUxD6N2USiNBgDGhvvwE0KVCQPOwJvG9dMFmS3HA5kD2xOsWLsFFe
         yNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4J0TXs18gqns+4JZf+KQYg5aqBVIKZja+gfFqzNHW4U=;
        b=fga12p93BgXUYzTG7iflrrwbp/c6dZBvFVv6nuiFSWKTzkeVwRbUKluPD6f2H3PATR
         nA5yLU/VEZkU3T5TYrgo6ndjqFmSZFKOrM6u/yUh9gtWo5kpY6cozUe73gb13flB8f0b
         /SQsmLhcBGxxjEXZn3F1KY8tIS5CDcVsQ5sRhToGpRq0Vd/erakZcb+KpL6PjgePmM7R
         cVWI812AihRqNfFhKu8Nq069XNhRcTZpqn05+dB/0pByd6RujCbNoYxVKa83fAZo34Jr
         Zy3nfIjsTav1NM+bfg2UkYE77kuMXWAxWi0M5bHgc5PoymMFbkmdpo5XwMy2CEHdqJNF
         fNBw==
X-Gm-Message-State: AOAM530WGuLdWkEvd319EHnYt26fqJjZ30sw0euWNPVeKLpS+LEIY3U1
        hZR0Bn6AXbmD91aU+RJL2Q==
X-Google-Smtp-Source: ABdhPJxhOitPimRKcC6R0uItNkUYJ5AXQsfhN97FuuLyZZixvMr1ZR6ggUCXLend0xGlh4qmzgJAow==
X-Received: by 2002:a50:fa84:0:b0:426:4850:2fc6 with SMTP id w4-20020a50fa84000000b0042648502fc6mr18253828edr.38.1651589882498;
        Tue, 03 May 2022 07:58:02 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.148])
        by smtp.gmail.com with ESMTPSA id el8-20020a170907284800b006f3ef214e0asm4700920ejc.112.2022.05.03.07.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 07:58:01 -0700 (PDT)
Date:   Tue, 3 May 2022 17:57:59 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     mcgrof@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: [PATCH] module: fix [e_shstrndx].sh_size=0 OOB access
Message-ID: <YnFC93NVRqOterbV@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is trivial to craft a module to trigger OOB access in this line:

	if (info->secstrings[strhdr->sh_size - 1] != '\0') {

BUG: unable to handle page fault for address: ffffc90000aa0fff
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 100000067 P4D 100000067 PUD 100066067 PMD 10436f067 PTE 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 7 PID: 1215 Comm: insmod Not tainted 5.18.0-rc5-00007-g9bf578647087-dirty #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014
RIP: 0010:load_module+0x19b/0x2391

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 kernel/module.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3033,6 +3033,10 @@ static int elf_validity_check(struct load_info *info)
 	 * strings in the section safe.
 	 */
 	info->secstrings = (void *)info->hdr + strhdr->sh_offset;
+	if (strhdr->sh_size == 0) {
+		pr_err("empty section name table\n");
+		goto no_exec;
+	}
 	if (info->secstrings[strhdr->sh_size - 1] != '\0') {
 		pr_err("ELF Spec violation: section name table isn't null terminated\n");
 		goto no_exec;
