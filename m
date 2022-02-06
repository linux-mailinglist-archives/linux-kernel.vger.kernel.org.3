Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C417A4AAF1C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 13:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbiBFMBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 07:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiBFMB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 07:01:28 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EA5C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 04:01:27 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s185so14125267oie.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 04:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Pp+I75epMV+BmhPOmXiVI+uznZlIMxkRLCzkT77FiqA=;
        b=OZS9exAxPbSsHsAy/6CMBrHstL+Jrqqm11q7ztNfho9fv0L4E2R+mFmEg5wmxaJpMq
         wxB8ZDxbJGhzpbvDmfFHu/zCXpBLeSjYiDLlqqxbr+d3RuGfnyTzsXeKtav4+MYjbBq7
         H4tRDerLO36yxHkWR7aDU7Im8aWdksIAmS0fA6kCxvu+Fr2Na9Tb/n/4UXnHdVmc2vSI
         uazGz+nbsc8fqzlrdSs6Uw5dVIZNxax2RCbAuoaPu3Cek93NFe1xh3FI/zdzr7o37HrX
         escktGyFHz6F4kK4QtXKy5BOoZs7hE3EEPm2TeaJ5JxL1Mgu8kzI43Nnvm+4370kb7U5
         QQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Pp+I75epMV+BmhPOmXiVI+uznZlIMxkRLCzkT77FiqA=;
        b=q2WCE02AogbWNMEOT8xx8MwBknNIUp2NZu1rYowue5PH+9PTtLqVzUUjJEIQnMaCYj
         CTwt8axETAP6M5Uqd/v/K+Ts5vpuGAikAGO/8NfThZg1ittJd/+yD73i+0upCSEpXs0O
         eQxilsneBaJFuzQ4zFXtahzwYrGO8FJL1O9zda+AExNbdQW5+zYiUFO05hSoS4rlmp5O
         tglM+NUWzrkHnxtPimiRVd1EQ2B4TEGQIjIoQgwl8s7Q9E4E6vLTIslE73Aqn+kpjvTb
         nfqDCVtEAlDAuKD6y3HVhRRFcr+sFTqZmjXyl7YS2dyTDiJdt6XJ1jcxDM3sJr7cuOj7
         8ayw==
X-Gm-Message-State: AOAM532i7bAfWy0J0poqhHlU/TVMWqM8YIL50Jd9GuA0Ec33KFqPUDrd
        bUrakFWZhZMqxS2ehwVW34k=
X-Google-Smtp-Source: ABdhPJxFAoDxEyCGm8mMXiFpmuI8DUrpwCvFWZ8wwetNh+NdC+VEiiHb6Sy8wo75PGr8c2NFiROZ1Q==
X-Received: by 2002:a05:6808:8d:: with SMTP id s13mr3198748oic.227.1644148887048;
        Sun, 06 Feb 2022 04:01:27 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n13sm3054331ooj.34.2022.02.06.04.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 04:01:26 -0800 (PST)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8949D404A6; Sun,  6 Feb 2022 09:01:23 -0300 (-03)
Date:   Sun, 6 Feb 2022 09:01:23 -0300
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Janosch Frank <frankja@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] tools headers UAPI: Sync linux/kvm.h with the kernel
 sources
Message-ID: <Yf+4k5Fs5Q3HdSG9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Just FYI, I'm carrying this in the perf tools tree.

---

To pick the changes in:

  f6c6804c43fa18d3 ("kvm: Move KVM_GET_XSAVE2 IOCTL definition at the end of kvm.h")

That just rebuilds perf, as these patches don't add any new KVM ioctl to
be harvested for the the 'perf trace' ioctl syscall argument
beautifiers.

This is also by now used by tools/testing/selftests/kvm/, a simple test
build succeeded.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index b46bcdb0cab1a369..5191b57e156220bd 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1624,9 +1624,6 @@ struct kvm_enc_region {
 #define KVM_S390_NORMAL_RESET	_IO(KVMIO,   0xc3)
 #define KVM_S390_CLEAR_RESET	_IO(KVMIO,   0xc4)
 
-/* Available with KVM_CAP_XSAVE2 */
-#define KVM_GET_XSAVE2		  _IOR(KVMIO,  0xcf, struct kvm_xsave)
-
 struct kvm_s390_pv_sec_parm {
 	__u64 origin;
 	__u64 length;
@@ -2048,4 +2045,7 @@ struct kvm_stats_desc {
 
 #define KVM_GET_STATS_FD  _IO(KVMIO,  0xce)
 
+/* Available with KVM_CAP_XSAVE2 */
+#define KVM_GET_XSAVE2		  _IOR(KVMIO,  0xcf, struct kvm_xsave)
+
 #endif /* __LINUX_KVM_H */
-- 
2.34.1

