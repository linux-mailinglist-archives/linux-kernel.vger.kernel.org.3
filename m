Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A20F46F2F5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbhLIS17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhLIS16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:27:58 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5CBC0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 10:24:24 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id z8-20020a6553c8000000b00324e0d208d3so3690230pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 10:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nEbnmMLnxFijfTxQFcKhYorjkHl6s9gXZWmFJky2ed4=;
        b=fXVRFEk7Cwg9g8Aqe3Ykv4J4B3w4CcF+ToWWfV57DYZV6gXroGNDLRRokT/P+48VFL
         FzluMjiJAYOhxp5sWoeeow0lmLsyPZxbAtFySkOOUcCGFdSS1V+K54Jwup402IrOTc/L
         pdwdqNW8Yil5LsC4KnnJDOb1JatjdyK872PnRREm/FIjv1AivlSSq/xwqZ7Fi/Z+ALpF
         C+smcVmcZZB5eFocfENiu0uVHvhCRkIc2GS3hoHYRWL4sl+Y2HttONXcWe+dWjObGYPU
         O4E55PdLACnmysI3NW8JL9fDIS+IWjLZ8YagqGW+EFzUTMOJTGtwkYT1EIF5VzX5mpXJ
         0OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nEbnmMLnxFijfTxQFcKhYorjkHl6s9gXZWmFJky2ed4=;
        b=ToY3sdm+J8rEsy9gNFq3Syx7UtQybo1RdEhwXf/GCfjGWmh5yJuKP4M3SoYJ84iXH+
         MHGXV7F2rpAkW9TYMou5esW5c26ZE+om2hyMB9aICcHhkNEI8cAVB4R4zKpD5JLwbMzW
         AI3QTMqvsVBmcVb5QBkgrfDX0bJAVbZdfbnjcnic5pmD+ZO8QY3l83bW1iXR6pe0PwLL
         By4ggCz16Zdqz5Jct/YtHMvq4zg+GlI2XuGTY4wa6QpI1AzDdjlWGhCj4Zs5Hf0PWSDk
         z5uuMqZ7XE5sgF0yJWmM6mDuCYVZBmkOkXMPhQn5jpA69ONtXTV0ry5pIH/8RrCqIZqK
         S5zA==
X-Gm-Message-State: AOAM5307tmNfKseGWJeB/JPwlk+Ua4bXThpvuJ05+wc3NH6UhJRUuMmB
        /Yur5xodjoJuRV1f9isEC3hQqCxZYyyH/nhgWhJQ+q9PQR3GpTEXq4T5ElNRihJVhTgGOGxBBB0
        0XUGogKlpjspTKQG7N1qQnMO9O5RmUzhNrIXsHzL76StOnFw++cC7bh0K5a3Om7DJ0xXMmQ==
X-Google-Smtp-Source: ABdhPJwD9mtX5fZHIN/Vq9GSaColmVEza+eOOt4xFB6eYKpBQHRpyn0YETu5FlTxwCr4FmjDVO4168EM/YY=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:ef0a:5d4a:e2d7:ed84])
 (user=pgonda job=sendgmr) by 2002:a17:90a:284f:: with SMTP id
 p15mr1037136pjf.1.1639074263837; Thu, 09 Dec 2021 10:24:23 -0800 (PST)
Date:   Thu,  9 Dec 2021 10:24:17 -0800
Message-Id: <20211209182417.218496-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH V0.1 2/3] selftests: sev_migrate_tests: Fix sev_ioctl()
From:   Peter Gonda <pgonda@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Marc Orr <marcorr@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TEST_ASSERT in SEV ioctl was allowing errors because it checked return
value was good OR the FW error code was OK. This TEST_ASSERT should
require both (aka. AND) values are OK.

Currently issues with the PSP driver functions mean the firmware error
is not always reset to SEV_RET_SUCCESS when a call is successful.
Mainly sev_platform_init() doesn't correctly set the fw error if the
platform has already been initialized.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Marc Orr <marcorr@google.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
---

V0.1
 * Removes extra whitespace line.
 * Corrects patch description.

---
 tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
index fbc742b42145..4bb960ca6486 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
@@ -30,8 +30,9 @@ static void sev_ioctl(int vm_fd, int cmd_id, void *data)
 	};
 	int ret;
 
 	ret = ioctl(vm_fd, KVM_MEMORY_ENCRYPT_OP, &cmd);
-	TEST_ASSERT((ret == 0 || cmd.error == SEV_RET_SUCCESS),
+	TEST_ASSERT(ret == 0 && cmd.error == SEV_RET_SUCCESS,
 		    "%d failed: return code: %d, errno: %d, fw error: %d",
 		    cmd_id, ret, errno, cmd.error);
 }
-- 
2.34.1.400.ga245620fadb-goog

