Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F9B580E03
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbiGZHkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbiGZHio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0118125DB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r64-20020a254443000000b006707b7c2baeso10452626yba.16
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Yr2SeyZfI0iUSRRhOZVPZMhkgZCPOBYcwpq2LIzTDZU=;
        b=ld594KmaC+x5hDg3TfDCFLBo3mJAZfZadHtvCv4LxhROGpYJjZU5u3nKSiZtJGEeDg
         IIuDeTXXeGCm/m63A/vVxNjaLgs/Y/a/sPcp5QPfaHOHooP7/BenwvBsnpWGgpYKdke2
         NSEaG4+gALZAkhG6CrQW2qi5i3MnwMxygSzrgKO+y48x97DWG5b6cKMHnWq5gI3k7I8o
         aF84buGLeVeeiDm2loKcvHAEv/qJorx273cBmBrFBtvuFayq67ts1t/eZYcPdJiP1OrJ
         37UDImjN43qQLenhSw1pgI8Q7IZ/5+VyJ8X+qvF10PD0zs4JSX97+y7BUrreFoc3hEaK
         +Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Yr2SeyZfI0iUSRRhOZVPZMhkgZCPOBYcwpq2LIzTDZU=;
        b=r2zaWBmwvx9BzeVK+P2O6AMgOKvQfBsH0DWiporefLiUW5em70dyyWmsLbjUkK3n9s
         p2GlLbqVrTSIB1Lql1joc/VrByGjkNk4ClSOvT4dzN4kRSwfwcfn/0lcw6Gr4eb4FQPI
         bD6T+ObRQrVij+1NCIzMp0cHdZp40Oor6lnRVqCWat6Ukfa7CR14PDYAwPc29drwI9tJ
         SZUjWnk8g39T/f4v1gj/IdMctXt9pH82nUB7bGqxO8WWJheZWSJXEm6BkWnvIOw6gicY
         UanmShiSvbleuAEn4SqmphVfxOIKTQnlszmOR/PUnkUUbjpN7I0FK73fiLiApAC7JT/N
         ta9Q==
X-Gm-Message-State: AJIora/v2xZIxetdAJNVRdpNcH1D4YpHGROCFL+eITK1AEwdwJp7mpbK
        N6aZXCw7B5iqXx2kRDHSHnlMk+ozC+YkEzZrdg==
X-Google-Smtp-Source: AGRyM1uUV8LVmqLvK9zIG/LZdwQHtzL5gI4YShW6qDDsHeG4grPXlFeu6lQVvyPm5rCyBP47PIGIWuZltzrJGPwwYA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:4f77:3b64:736a:394e])
 (user=kaleshsingh job=sendgmr) by 2002:a81:911:0:b0:31f:4906:80a2 with SMTP
 id 17-20020a810911000000b0031f490680a2mr1032907ywj.351.1658821107235; Tue, 26
 Jul 2022 00:38:27 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:37:46 -0700
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
Message-Id: <20220726073750.3219117-14-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6 13/17] KVM: arm64: Allocate shared pKVM hyp stacktrace buffers
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com,
        oliver.upton@linux.dev
Cc:     will@kernel.org, qperret@google.com, kaleshsingh@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In protected nVHE mode the host cannot directly access
hypervisor memory, so we will dump the hypervisor stacktrace
to a shared buffer with the host.

The minimum size for the buffer required, assuming the min frame
size of [x29, x30] (2 * sizeof(long)), is half the combined size of
the hypervisor and overflow stacks plus an additional entry to
delimit the end of the stacktrace.

The stacktrace buffers are used later in the series to dump the
nVHE hypervisor stacktrace when using protected-mode.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
---

Changes in v6:
  - Fix typo in commit text, per Fuad
  - Add Fuad=E2=80=99s Reviewed-by and Tested-by tags

Changes in v5:
  - Fix typo in commit text, per Marc

 arch/arm64/include/asm/memory.h      | 8 ++++++++
 arch/arm64/kvm/hyp/nvhe/stacktrace.c | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memor=
y.h
index 0af70d9abede..cab80a9a4086 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -113,6 +113,14 @@
=20
 #define OVERFLOW_STACK_SIZE	SZ_4K
=20
+/*
+ * With the minimum frame size of [x29, x30], exactly half the combined
+ * sizes of the hyp and overflow stacks is the maximum size needed to
+ * save the unwinded stacktrace; plus an additional entry to delimit the
+ * end.
+ */
+#define NVHE_STACKTRACE_SIZE	((OVERFLOW_STACK_SIZE + PAGE_SIZE) / 2 + size=
of(long))
+
 /*
  * Alignment of kernel segments (e.g. .text, .data).
  *
diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe=
/stacktrace.c
index b8a280aa026a..e2edda92a108 100644
--- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
+++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
@@ -34,6 +34,10 @@ static void hyp_prepare_backtrace(unsigned long fp, unsi=
gned long pc)
 	stacktrace_info->pc =3D pc;
 }
=20
+#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
+DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_sta=
cktrace);
+#endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
+
 /*
  * kvm_nvhe_prepare_backtrace - prepare to dump the nVHE backtrace
  *
--=20
2.37.1.359.gd136c6c3e2-goog

