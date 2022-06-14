Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A880A54BB29
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357245AbiFNUIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356689AbiFNUHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:07:42 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1642DE8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:07:35 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mh12-20020a17090b4acc00b001e32eb45751so8639929pjb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=+K2U9ZQLTr9r2599616R5ArFkm9I26JZTi1y24xJeZM=;
        b=WCW721NtOLXF8OgreyIUQne2OjoMN1a3eLd251FVPN/55Ud0cP8y/Sjc+VYwrSgwnB
         zam6Y0aljOPtgfYno6oLzsHbjGoBbt1ynomyy8Q0OH+ea0bk81TZwoY9uUUin22XifI9
         NGDNq8M5BtvqYlT2zVdhMTM0Feyar4QiZQTvb4qgSH07ySOk88fhw8fjGbp6ykYiWYOP
         8xCPe8GzJKD3U6Q/THOKV27Dg7CQ3V4cCqju09EIGzs7wvhvwVvst48GaFaUI2nwPAOG
         IMWG4Asu+x1J6EsTdwiu+JGe/w9pc+hfPbLTUJ1BFTYoIpzTCGzeo/Mb4ph6OgFPbzO3
         Fjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=+K2U9ZQLTr9r2599616R5ArFkm9I26JZTi1y24xJeZM=;
        b=NRYoxDKExHQRFTlLyF9brz0bxNCcq1LClkYvRrlarl/gvpiXr2Rc8ld0ZmSGQd1w6C
         6zDr395CsVp5fF/LmCG3QPfQNN1zyXlBPhPj+2BNGkT1QIp2XLm+CPy32hfQLbgslZpL
         2wUQMZaHA0CohU2kNijMG2dW6SbWK9ISoLXlTxQb2V1StyLXC30dfk56BOtHggGLvhQG
         YRQERIQg7jjbxHWEkZ6SXlDa9UQVXP4ukkDhau6wlfhkNoYME7k0YBzrYC5Wp79cuQgq
         wWdgZkCLUtU1RLP9GX98LUE2DsWRkaGWaypEmU/itNg+S+Kxa11knRFScWgqm7Y002bo
         wMzg==
X-Gm-Message-State: AJIora/aUngfuK94RHgokw/6HGFac2Y9vLXTLc1qJqCmlkPukvHM6auJ
        VSt2tHAZgT0IhavGyruQR7fewd0GHbI=
X-Google-Smtp-Source: AGRyM1umlki2IGqUel3cRE/RbccGMPSY0ssB0AV3HHohG2BDAlbagsZzWAxDSe3r8RwVDj60wIYIjKRYl0Q=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:cf0f:b0:15a:24e0:d9b0 with SMTP id
 i15-20020a170902cf0f00b0015a24e0d9b0mr5869347plg.42.1655237254915; Tue, 14
 Jun 2022 13:07:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 20:06:37 +0000
In-Reply-To: <20220614200707.3315957-1-seanjc@google.com>
Message-Id: <20220614200707.3315957-13-seanjc@google.com>
Mime-Version: 1.0
References: <20220614200707.3315957-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 12/42] KVM: selftests: Use kvm_cpu_has() for XSAVE in cr4_cpuid_sync_test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
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

Use kvm_cpu_has() in the CR4/CPUID sync test instead of open coding
equivalent functionality using kvm_get_supported_cpuid_entry().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
index 8b0bb36205d9..092fedbe6f52 100644
--- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
@@ -63,11 +63,9 @@ int main(int argc, char *argv[])
 	struct kvm_run *run;
 	struct kvm_vm *vm;
 	struct kvm_sregs sregs;
-	struct kvm_cpuid_entry2 *entry;
 	struct ucall uc;
 
-	entry = kvm_get_supported_cpuid_entry(1);
-	TEST_REQUIRE(entry->ecx & CPUID_XSAVE);
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_XSAVE));
 
 	/* Tell stdout not to buffer its content */
 	setbuf(stdout, NULL);
-- 
2.36.1.476.g0c4daa206d-goog

