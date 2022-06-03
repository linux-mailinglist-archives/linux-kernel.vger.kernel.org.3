Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A12853C25F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbiFCAoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239915AbiFCAnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:43:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D87222517
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:43:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e5-20020a255005000000b0065cb3669fe9so5600657ybb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=wX/P+I0PRT/FmLuKfIiWzz4JYduTHcEOvgTKpRq6UvI=;
        b=ohGfmhNoBW/gE6jRNf0MXcnIOq1BnZuWfAoAaD+ubq9T5WfQumj38VOZn3zDju7uuv
         ikPnnwQR6COPlsfjWThFXvtwZJSgrRIoPLvN188nCZFF6Cf7U523IDVu5L5v+71pgXpf
         Npki5bhhOGYw6DTAoNZSH1tkMy4H9BOh4sV4I0LiXaP96P0b5GEBx2gfqWdezOP98M3n
         1yC/+1zZxsQt5V5e2mR6pnXE7c5hpvTLCR/W/TEc/FGrhn//GOuv+zGRZ36x+aeM0NFw
         NfYNxYNxRqmlCVA61GLgexMaYEFrb5zRWmbjn24fsmLCsQhzHHWss/7zCfGRZna1wXqm
         E+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=wX/P+I0PRT/FmLuKfIiWzz4JYduTHcEOvgTKpRq6UvI=;
        b=Pt6TZ43b3lzUDvoZWlSD2zwIuGG7u/s3KDZTbC3vhH62N0fb54uuWGnmXky1Z5D5DA
         odd+WX9lPNXVrBGDIn/P6FfF4dmfKhAhYKmsP6An11C3ghmYbOry7my1FFuhWitcdY9/
         m0nMo+RszVZxlu9rPA4LGTTfyC+xVrSxizIqyrdIr9tduE7tyk9q2rErGXcbh+odKuH4
         GCcJlDnfpYIwlZepQpo553f+I56jR+jXUkuPd7OClv3oqZmc3TcQpRhEMMiq04kuqndX
         h1o7o6lXfCa8zyAHqMSF2httt+Bd6GLzcRPKN4XCxnOo9xWfB9Tj/FllDp5UbdSpuQeW
         xShw==
X-Gm-Message-State: AOAM530kpEru3h2oCJfnvokelWEq65tMBd2Xj9xCO7y3sWR/FjiXcXZ1
        n0DDIIM9U2KncQLo+hIDF9H5JqYpmg8=
X-Google-Smtp-Source: ABdhPJxjGduPcX+/AqwEDSijp3oxgmIpIdd99OYZPvci++iHCcAWUoD30JjcDXOao0HxI6mslc7hN3RC9UI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a81:2188:0:b0:2f5:1b53:9141 with SMTP id
 h130-20020a812188000000b002f51b539141mr8715333ywh.504.1654217020677; Thu, 02
 Jun 2022 17:43:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:41:09 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 002/144] KVM: selftests: Fix buggy-but-benign check in test_v3_new_redist_regions()
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update 'ret' with the return value of _kvm_device_access() prior to
asserting that ret is non-zero.  In the current code base, the flaw is
benign as 'ret' is guaranteed to be -EBUSY from the previous run_vcpu(),
which also means that errno==EBUSY prior to _kvm_device_access(), thus
the "errno == EFAULT" part of the assert means that a false negative is
impossible (unless the kernel is being truly mean and spuriously setting
errno=EFAULT while returning success).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/aarch64/vgic_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 34379c98d2f4..0f046e3e953d 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -381,8 +381,8 @@ static void test_v3_new_redist_regions(void)
 	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS);
 	subtest_v3_redist_regions(&v);
 
-	_kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
-			  KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, dummy, true);
+	ret = _kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				 KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, dummy, true);
 	TEST_ASSERT(ret && errno == EFAULT,
 		    "register a third region allowing to cover the 4 vcpus");
 
-- 
2.36.1.255.ge46751e96f-goog

