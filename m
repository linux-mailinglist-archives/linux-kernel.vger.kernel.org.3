Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45065535499
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347841AbiEZUiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348076AbiEZUiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:38:11 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E730EE275D
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:38:09 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v11so2464018qkf.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rRoGonP9HfX25x1VUl7zmMTYRYO/5pDsYCe4KdNBzdE=;
        b=DwU6e3KxjdUUnRv1wd9M2Gs9/WozVUiDGXJovnWPggTGPL9tlM1OIEB1TUmeAsJMdp
         r6dh3S42iKyv8/FZ1Li4lTgJbpVpn45lneLyt0dDpfUXqmR+bqcKjb4vjaSuHCSBRJVN
         n753mR+anAVg3ketZH65sBZ0NKkbKf4dDHA2yDwAFbzZhpP65ZIlURFAXTCWUWgr3glv
         Jk5djArH5WVq2cEyvugg5PmG+kKo2AlMWS3FKURJFclS5FFOa2Xr3Pf0ADA8JS9I4l3Q
         FtMGazqYu4/2Zw0cgyYWrL1FHd1MUFjaW1tzBah9f2UVeLtejZScPZjF0iiaG67+x6lB
         5KEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rRoGonP9HfX25x1VUl7zmMTYRYO/5pDsYCe4KdNBzdE=;
        b=ZiZCFO6ap1H/dkgQUNxhS0cROd3rc9Tw5p19/ZK5D2gB1Mbuxc+JdLXQMfxcNIqcU5
         ZuHoHMM22D82FpdJroLM2qHJmwrcCKLJDcslmse+MR7m7Uuez8oNdZgC0XrynouWEKhg
         GaY1L7waC4WmpaKFRjjv+wpU2JGl61ufTmLc1rzmRQNsCMzEQBdHoVTGkMXSOSG+5klS
         MESO65U1PAXDmsE+SJ5RJC0Xl5jMUElX0KZWyYAzT4mAX66YbZQpCguu7+R4IhrK7oY0
         tSajf3/WvYQQSZ1YRv2DQkxT3XMYH6MQcZm3pspLnajoAV5NPcbuterbQ0A7TC6e0Stk
         91zg==
X-Gm-Message-State: AOAM532pAA+GizpKK92JOH2f9uxi8gm/3htme74l5LZKXysCOcnqQohX
        bHFop4hwkvLrKwMoJI7OZkke/w==
X-Google-Smtp-Source: ABdhPJzVBKEN8HOtWhrci8jARirNNqgqDh4wWJNdfELfcn/rJoTmLiEOyhH2wbyuE8mR7HA9bPOrfw==
X-Received: by 2002:a05:620a:166e:b0:6a5:c6b5:7823 with SMTP id d14-20020a05620a166e00b006a5c6b57823mr2098185qko.12.1653597488761;
        Thu, 26 May 2022 13:38:08 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id o124-20020a37be82000000b006a32c991501sm1711725qkf.12.2022.05.26.13.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:38:08 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
X-Google-Original-From: Pasha Tatashin <tatashin@google.com>
To:     pasha.tatashin@soleen.com, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, rburanyi@google.com,
        gthelen@google.com
Subject: [PATCH] kexec_file: Increase maximum file size to 4G
Date:   Thu, 26 May 2022 20:38:05 +0000
Message-Id: <20220526203805.3659597-1-tatashin@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some case initrd can be large. For example, it could be a netboot
image loaded by u-root, that is kexec'ing into it.

The maximum size of initrd is arbitrary set to 2G. Also, the limit is
not very obvious because it is hidden behind a generic INT_MAX macro.

Theoretically, we could make it LONG_MAX, but it is safer to keep it
sane, and just increase it to 4G.

Increase the size to 4G, and make it obvious by having a new macro
that specifies the maximum file size supported by kexec_file_load()
syscall: KEXEC_FILE_SIZE_MAX.

Signed-off-by: Pasha Tatashin <tatashin@google.com>
---
 kernel/kexec_file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..1be2227b33e6 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -31,6 +31,9 @@
 
 static int kexec_calculate_store_digests(struct kimage *image);
 
+/* Maximum size in bytes for kernel/initrd files. */
+#define KEXEC_FILE_SIZE_MAX	(4UL << 30)
+
 /*
  * Currently this is the only default function that is exported as some
  * architectures need it to do additional handlings.
@@ -227,7 +230,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	void *ldata;
 
 	ret = kernel_read_file_from_fd(kernel_fd, 0, &image->kernel_buf,
-				       INT_MAX, NULL, READING_KEXEC_IMAGE);
+				       KEXEC_FILE_SIZE_MAX, NULL,
+				       READING_KEXEC_IMAGE);
 	if (ret < 0)
 		return ret;
 	image->kernel_buf_len = ret;
@@ -247,7 +251,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
-					       INT_MAX, NULL,
+					       KEXEC_FILE_SIZE_MAX, NULL,
 					       READING_KEXEC_INITRAMFS);
 		if (ret < 0)
 			goto out;
-- 
2.36.1.124.g0e6072fb45-goog

