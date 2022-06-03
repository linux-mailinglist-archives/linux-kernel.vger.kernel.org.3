Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD16553C241
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbiFCBAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241365AbiFCAvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:51:03 -0400
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D5135249
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:47:51 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id 188-20020a4a11c5000000b0040e4e4ced2dso3159275ooc.23
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=+4nNoyX7JeBm/N7spsN6DPOga3uPSoar0+etXxoGgD4=;
        b=NvMh4Yj+8LUmAda/RiZF1K0mOWuGUuA6Hl1yujDnw/gMWAp8EN+UZ0d5KujDvcyVBC
         QJjP4ouu6XsidrpZw3w/tXGOIhUcFc02xHYtwWFkihpyJfNCOr4Fs/QUg5eQz9tT3uPk
         mCHUt4t9PYUIBLQ37J6/90GtfjugR+FkSGG7nBYEXljjkvQY7+LJYyip5yTBwgR4yoJM
         JFJcrlibEbU1UPEfX0Dy5fhvciVLQeIelNfuIcntb5kSusSM5fGE+jZJBTyTkh3tDbnF
         mBanNkpTk1HglE+10CDnNjFChoKvNPQanFrP5gz9MgPf/j87iDttfGwS1aHvwsagr+5W
         pbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=+4nNoyX7JeBm/N7spsN6DPOga3uPSoar0+etXxoGgD4=;
        b=cg/9y6+1tnk8+x7wVLQiQhcqbr1u8iN0WnmSFd9XLYEg4KoQuMIzIep20Zx2iRcgce
         exwk7SVRDSEILLBVaUE2eW/ocPOBNJMtFLP8aXb+5ju2cMux/fHufq1VUHLxkTApwi1i
         OQv1GUn6N9Me4/kviuov5JhH9BhAvBCkttTct9L3qPL5M05ICGNigaxyQSzxTDr5TGHy
         vWZdicaHHcgJDBNokGO97RsIcP+Onx3cTcvsH2raVRdGUnuRN68Ukqva2DUgtgJm/7t5
         7Jg0h50dsiXJzSQYMwUNqEAEn2xEqWa1jQxYBcDYYYwkZ1BVR9AWEPt9eyDV9hVt7vOm
         gCCQ==
X-Gm-Message-State: AOAM530dZt09JXlFUX1efuTpr4JaG7aQONVxxzs5AVPBW0ZCkIJ/3u7s
        5JiuA0dPWpQ/ihFbNaxkpNfYtKWhTiM=
X-Google-Smtp-Source: ABdhPJz9agXYe3qC0Put60InXSJB1iqnJiW+Ya6NWeg2trr4toG5zFlkBkkvXEHd6cR5tugGatjlX87uXzk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6870:c193:b0:f3:3d31:1b94 with SMTP id
 h19-20020a056870c19300b000f33d311b94mr4507626oad.90.1654217271021; Thu, 02
 Jun 2022 17:47:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:43:28 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-142-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 141/144] KVM: selftests: Return an 'unsigned int' from kvm_check_cap()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return an 'unsigned int' instead of a signed 'int' from kvm_check_cap(),
to make it more obvious that kvm_check_cap() can never return a negative
value due to its assertion that the return is ">= 0".

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 2 +-
 tools/testing/selftests/kvm/kvm_binary_stats_test.c | 2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 1c762988ab9c..72cc0ecda067 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -167,7 +167,7 @@ extern const struct vm_guest_mode_params vm_guest_mode_params[];
 
 int open_path_or_exit(const char *path, int flags);
 int open_kvm_dev_path_or_exit(void);
-int kvm_check_cap(long cap);
+unsigned int kvm_check_cap(long cap);
 
 #define __KVM_SYSCALL_ERROR(_name, _ret) \
 	"%s failed, rc: %i errno: %i (%s)", (_name), (_ret), errno, strerror(errno)
diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index 7f2ddc1535d7..982bf3f7d9c5 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -213,7 +213,7 @@ int main(int argc, char *argv[])
 	}
 
 	/* Check the extension for binary stats */
-	if (kvm_check_cap(KVM_CAP_BINARY_STATS_FD) <= 0) {
+	if (!kvm_check_cap(KVM_CAP_BINARY_STATS_FD)) {
 		print_skip("Binary form statistics interface is not supported");
 		exit(KSFT_SKIP);
 	}
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 2dcd83a03cc2..8f7ee9cb551c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -69,7 +69,7 @@ int open_kvm_dev_path_or_exit(void)
  * Looks up and returns the value corresponding to the capability
  * (KVM_CAP_*) given by cap.
  */
-int kvm_check_cap(long cap)
+unsigned int kvm_check_cap(long cap)
 {
 	int ret;
 	int kvm_fd;
-- 
2.36.1.255.ge46751e96f-goog

