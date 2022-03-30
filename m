Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F084ECB07
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349504AbiC3Rso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349611AbiC3RsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:48:21 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD75D1EB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:46:36 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id e15-20020a17090ab38f00b001c9989ae56cso260029pjr.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gp5/oqbk2fI6DwAcVjqyKO14WoJq46+G4sTbdYNQ4HM=;
        b=QOLiRpewW+t88OqSkBE63r2/Xntuf79cBo45qAE8JYSTK0gFn6pzIKL1x9gluakFAy
         fPCYzPwzm2OcKUaY49IZhe79HyD30+YtjVSc316U++wqEoBw5ipIoT8qVtRmIv+f9CGJ
         Ey41djoQ4ewLWYggnso4f50BhAeBb4vRooLgOM4aaQNuLMVVyAEbE6dOmNJqiROnrONH
         PwPJeerDRoceKY0rFF/V4yjJtcdzniRUtVff57IhatmV5yHuDCJ5K9BWdsSxNB8JGuWH
         aOushq/lf3mdpFZFFSQmzEUx5RCnFn07Av4Nv8ANl/gO3JThCAdYl96vwWXZ05p/II6b
         cNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gp5/oqbk2fI6DwAcVjqyKO14WoJq46+G4sTbdYNQ4HM=;
        b=fk99DUfPPo2mLN8CHJDpCeV+Cut0RkInhpKRCApV8pY4mUFOlkj9ILoN6T+mGaFxDl
         CEE+pZ56vRy28TcBJTr3ujC4nX5+GM+zkyKUW1EHmyO71Cb9KfHekTgM1TbCrl9UPeFw
         6IkQqERp6Hq+qIZkLgoSd+Fo4YmrtQrqSH7rPgOTBTnhxY+KD/q5knnCRis1DGSUe/sl
         ex7NJt7lerHdu7O+NtFmNiOBWX3m1ikY+MoTrf8uJ8LA+mkcaeuuYjkZ3q6tpnUiBCQQ
         KixKuuDBJjlhIM/GwWHRDmCYdXmESIAY3KDEt97wfiqAVGRLbP1qJlno93jEO09XlyTU
         Ty9Q==
X-Gm-Message-State: AOAM531kWCdht3BAiTziqxtQrnuxUh5rUAPN1ZiaX6IyfFR805VumQ/d
        fy4ozqJqzp3Vfd0NVxDrk0OdJTMS8wOh2Ej5Z7uIszp1ZxsMBlEWuuPmsw4+LODP1309/57RRis
        4nCx0k5QEa9nsiYsdXTeC+AVbYEXY5oI/duYHVDkysO8sOdXf0AkUkJLCtFWU2DohJjingbQU
X-Google-Smtp-Source: ABdhPJwTYFZ9uPFmUGU1PepEmiueCb2rVeROZuwOheKg8DQ1WHWEsnVB6IAWI0UaUa513KbYMjGTH2/uQTaO
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:7c53:ec2f:bd26:b69c])
 (user=bgardon job=sendgmr) by 2002:a17:90a:858b:b0:1c6:5bc8:781a with SMTP id
 m11-20020a17090a858b00b001c65bc8781amr110130pjn.0.1648662395639; Wed, 30 Mar
 2022 10:46:35 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:46:15 -0700
In-Reply-To: <20220330174621.1567317-1-bgardon@google.com>
Message-Id: <20220330174621.1567317-6-bgardon@google.com>
Mime-Version: 1.0
References: <20220330174621.1567317-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v3 05/11] KVM: selftests: Improve error message in vm_phy_pages_alloc
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ben Gardon <bgardon@google.com>
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

Make an error message in vm_phy_pages_alloc more specific, and log the
number of pages requested in the allocation.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 09742a787546..9d72d1bb34fa 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2408,9 +2408,10 @@ vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 	} while (pg && pg != base + num);
 
 	if (pg == 0) {
-		fprintf(stderr, "No guest physical page available, "
+		fprintf(stderr,
+			"Unable to find %ld contiguous guest physical pages. "
 			"paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
-			paddr_min, vm->page_size, memslot);
+			num, paddr_min, vm->page_size, memslot);
 		fputs("---- vm dump ----\n", stderr);
 		vm_dump(stderr, vm, 2);
 		abort();
-- 
2.35.1.1021.g381101b075-goog

