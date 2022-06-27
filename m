Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6A555C631
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbiF0HwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiF0HwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9CC76174
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656316309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xZRxk45blbbVKouBNkJa4r6LzelZm251Oyfsi7Y/n3g=;
        b=U+9Xtuar5jpg1NiJ/d/M//KPzzMfb924bFaaOdXVSfovuM9gBhH+baI2F0S1yQwfce52cN
        pF2azUy+2H8NhAkW83nAPLgslbQkloUXrtz3Uinjy2UVbWHDlUy9UzfDvR/Wp6L/fjJjdv
        7dQMpgG2cwUC9HEl6nisnUSviDhZw7Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-GVZDCNw-OxyYp1Mg5P2hcA-1; Mon, 27 Jun 2022 03:51:48 -0400
X-MC-Unique: GVZDCNw-OxyYp1Mg5P2hcA-1
Received: by mail-pj1-f69.google.com with SMTP id h11-20020a17090a130b00b001eca05382e7so3228768pja.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xZRxk45blbbVKouBNkJa4r6LzelZm251Oyfsi7Y/n3g=;
        b=S3YDQVTW1e8XBeVcEOfd8HNnXU2qdzrMTBGDr5OCEJiDygl3j6l149xOolT+Tqk8Q7
         +hJEfA7grZogudQADy535Z8bCkSQxUVmhsVG9FZfVSJhT087q8hj6cfoLSmGDCU2KWke
         AQdPmqHVWaZFLouOJ/9fvvcWXOcvx76a/L8cUg2JRFANnSwgT7qcPrspLnDhcxSqVkOS
         w+25qz/cwdNcdRWEHBQokBp4BHbSEG/sMoZ9F0ROlthiMnWpKjyYyj3SkgUrQjK/smfP
         0RYWjRx2iwZxDMuWu26N+Jt6Bci/RFMprztFex7wuvtnw4B6yA8LAHhlkFIcS8Y2HowL
         396A==
X-Gm-Message-State: AJIora9f0CJnmkYrOnQTsa/ksrrgnfDoI1bRAuMiuAxBDzCfAUV7KXAV
        YIN1CX87y5UddGa3RmxTLLRhMtSLd6987Pv1vHGuRDcT69FT2uiP5jvO/bqfkv4zSQgZJM4N7HN
        LSCfOpFNk41PEUJHRQI2sHWc4
X-Received: by 2002:a17:903:230d:b0:16a:73ce:9068 with SMTP id d13-20020a170903230d00b0016a73ce9068mr13186034plh.57.1656316307234;
        Mon, 27 Jun 2022 00:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vA7kWLyjSTH2Ul73cyviWapNDDOK80s/6Tz5T94ix0V5MyOp52lL87RqwN812fFM4e7ARtjQ==
X-Received: by 2002:a17:903:230d:b0:16a:73ce:9068 with SMTP id d13-20020a170903230d00b0016a73ce9068mr13186019plh.57.1656316306908;
        Mon, 27 Jun 2022 00:51:46 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id em20-20020a17090b015400b001eae86cf683sm6520169pjb.42.2022.06.27.00.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 00:51:46 -0700 (PDT)
From:   Tao Liu <ltao@redhat.com>
To:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Tao Liu <ltao@redhat.com>
Subject: [PATCH v2] kdump: round up the total memory size to 128M for crashkernel reservation
Date:   Mon, 27 Jun 2022 15:44:41 +0800
Message-Id: <20220627074440.187222-1-ltao@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The total memory size we get in kernel is usually slightly less than
the actual memory size because BIOS/firmware will reserve some memory
region. So it won't export all memory as usable.

E.g, on my x86_64 kvm guest with 1G memory, the total_mem value shows:
UEFI boot with ovmf:   0x3faef000
Legacy boot kvm guest: 0x3ff7ec00

When specifying crashkernel=1G-2G:128M, if we have a 1G memory machine,
we get total size 1023M from firmware. Then it will not fall into
1G-2G, thus no memory reserved. User will never know this, it is hard
to let user know the exact total value in kernel.

One way is to use dmi/smbios to get physical memory size, but it's not
reliable as well. According to Prarit hardware vendors sometimes screw
this up. Thus round up total size to 128M to work around this problem.

This patch is a resend of [1] and rebased onto v5.19-rc2, and the
original credit goes to Dave Young <dyoung@redhat.com>.

[1]: http://lists.infradead.org/pipermail/kexec/2018-April/020568.html

Signed-off-by: Tao Liu <ltao@redhat.com>
---
v1 -> v2:
Modified commit log based on Baoquan's advice.
---
 kernel/crash_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 71122e01623c..b58b27cbdb61 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/sizes.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -43,6 +44,15 @@ static int __init parse_crashkernel_mem(char *cmdline,
 					unsigned long long *crash_base)
 {
 	char *cur = cmdline, *tmp;
+	unsigned long long total_mem = system_ram;
+
+	/*
+	 * Firmware sometimes reserves some memory regions for its own use,
+	 * so the system memory size is less than the actual physical memory
+	 * size. Work around this by rounding up the total size to 128M,
+	 * which is enough for most test cases.
+	 */
+	total_mem = roundup(total_mem, SZ_128M);
 
 	/* for each entry of the comma-separated list */
 	do {
@@ -87,13 +97,13 @@ static int __init parse_crashkernel_mem(char *cmdline,
 			return -EINVAL;
 		}
 		cur = tmp;
-		if (size >= system_ram) {
+		if (size >= total_mem) {
 			pr_warn("crashkernel: invalid size\n");
 			return -EINVAL;
 		}
 
 		/* match ? */
-		if (system_ram >= start && system_ram < end) {
+		if (total_mem >= start && total_mem < end) {
 			*crash_size = size;
 			break;
 		}
-- 
2.33.1

