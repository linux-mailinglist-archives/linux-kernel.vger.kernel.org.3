Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA280515E18
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382795AbiD3OTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380625AbiD3OTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77D994D9CB
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651328171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QPrMgDy5yB7Hta/JI8DxMyoAvcnzjiGrseGCPyjzNXw=;
        b=d6RPR5JRAJ0ufCC9DpN7NLGtZsi8BQYEs8jljSWL7TRJCRJQ4r5taon6DKOAsePzEE0PYy
        BnqNd7UYXnPpJC6gZt+lL0PHKz0Qzpqk0DKlrHfgJpZjx/SZbdA/Ki7qFtb7jOV/PVcmM2
        rqa2fqzOE69eBONETZC2VSteI7+HAnI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-wV7U5s40N0eqjMUUVnWJ9w-1; Sat, 30 Apr 2022 10:16:09 -0400
X-MC-Unique: wV7U5s40N0eqjMUUVnWJ9w-1
Received: by mail-qt1-f200.google.com with SMTP id f24-20020a05622a1a1800b002f396578cbbso2800572qtb.18
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QPrMgDy5yB7Hta/JI8DxMyoAvcnzjiGrseGCPyjzNXw=;
        b=vaUXq3V0XRJ60ErD/D3NMdzwiyTTgJf6sNY50gdLVRUJHOAlXXvgyEHfxvF9208unX
         w4TI3MdI3y5xvsPrNEFiXuMsxeJ+ZfP53K0PRZlJaKGAagFq8GOUxqDcbgaEK3HT/LRN
         crr2K43rkXzlMAVtDqZDBsGFBkIBtVMwJLCeoMemcrXIVq9xvqHAu0Ku2w08rFb9Oin0
         K4gysCTCf2GjnwDBu61c0j6GBuepuHbjz1XL53QgmWR3EqrUFYywEn7AnEnPvJhYCHMZ
         nBSySXK9FCijhRB4P7+EdzODdq2tWDTbNcd3+mcgblYmzzdyssz1+CjXrbZJ2Xd4uuHD
         S58g==
X-Gm-Message-State: AOAM5306ey8YAgKefAEtzxs9pNfgzNf23qWtTBtb8Ot+hQtMCFHFdjEM
        PAlOscYGQMAVop84HdwzTR+50ELY1nMDNw4NZJ3/CbGpadHKpS3D/YTAaTFoPtdAGNmu6ULsndf
        XFchQjfPgyYqWOCzqpTzYVGy+
X-Received: by 2002:a05:622a:38a:b0:2e2:2fdf:246e with SMTP id j10-20020a05622a038a00b002e22fdf246emr3646869qtx.482.1651328168855;
        Sat, 30 Apr 2022 07:16:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycuPFxc7mpvj76wRMMFa+8pkiJoTQXsRG6+O/KA8uzS5Mu+Z+k19n+bYltcBs/N7XHJpwVaw==
X-Received: by 2002:a05:622a:38a:b0:2e2:2fdf:246e with SMTP id j10-20020a05622a038a00b002e22fdf246emr3646851qtx.482.1651328168680;
        Sat, 30 Apr 2022 07:16:08 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q77-20020a37a750000000b0069fc13ce1fcsm1279581qke.45.2022.04.30.07.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 07:16:07 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     lenb@kernel.org, yu.c.chen@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] tools/power turbostat: close file after use
Date:   Sat, 30 Apr 2022 10:15:57 -0400
Message-Id: <20220430141557.1065405-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cppcheck reports this issue
turbostat.c:2039]: (error) Resource leak: fp

When the fscanf fails an error is returned without closing fp.
Move the fclose so even if the fscanf fails, the file will be closed.

Fixes: eae97e053fe3 ("tools/power turbostat: Support thermal throttle count print")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ede31a4287a0..2e9a751af260 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2035,9 +2035,9 @@ int get_core_throt_cnt(int cpu, unsigned long long *cnt)
 	if (!fp)
 		return -1;
 	ret = fscanf(fp, "%lld", &tmp);
+	fclose(fp);
 	if (ret != 1)
 		return -1;
-	fclose(fp);
 	*cnt = tmp;
 
 	return 0;
-- 
2.27.0

