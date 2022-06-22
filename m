Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C841554DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357706AbiFVOs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357373AbiFVOsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 386453CA7E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655909329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BfzGA2BfgEmm4tcaB5rbMih4mJIyv5Ggi+5ejPnvGzs=;
        b=dce/0J5FNyVc+yIPOMNPhr7hriBEP8Py+Z4ktIbsJLZV6oGXn1VsZEt2hNXqr2lbsP6UCg
        3CVlfTMmn3nMAzLLlBHr+BFIVpK69l59dhrcvmlyGHkdXugGOTceXJHSpO+UGzcSIZ16Hl
        eRXx2/5IlcnLO6abspZ1P96VU1026QU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-N2RvB7y5NLeqzs-ommWDCA-1; Wed, 22 Jun 2022 10:48:46 -0400
X-MC-Unique: N2RvB7y5NLeqzs-ommWDCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AE6418A6534;
        Wed, 22 Jun 2022 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1365A40E80E1;
        Wed, 22 Jun 2022 14:48:21 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Jane Malalane <jane.malalane@citrix.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-crypto@vger.kernel.org (open list:CRYPTO API),
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/4] x86: cpuid: improve support for broken CPUID configurations
Date:   Wed, 22 Jun 2022 17:48:16 +0300
Message-Id: <20220622144820.751402-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to harden the cpuid code against the case when=0D
the hypervisor exposes a broken CPUID configuration to the guest,=0D
in the form of having a feature disabled but not features that depend on it=
.=0D
=0D
This is the more generic way to fix kernel panic in aes-ni kernel driver,=0D
which was triggered by CPUID configuration in which AVX is disabled but=0D
not AVX2.=0D
=0D
https://lore.kernel.org/all/20211103145231.GA4485@gondor.apana.org.au/T/=0D
=0D
This was tested by booting a guest with AVX disabled and not AVX2,=0D
and observing that both a warning is now printed in dmesg, and=0D
that avx2 is gone from /proc/cpuinfo.=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (4):=0D
  perf/x86/intel/lbr: use setup_clear_cpu_cap instead of clear_cpu_cap=0D
  x86/cpuid: refactor setup_clear_cpu_cap/clear_feature=0D
  x86/cpuid: move filter_cpuid_features to cpuid-deps.c=0D
  x86/cpuid: check for dependencies violations in CPUID and attempt to=0D
    fix them=0D
=0D
 arch/x86/events/intel/lbr.c       |  2 +-=0D
 arch/x86/include/asm/cpufeature.h |  1 +=0D
 arch/x86/kernel/cpu/common.c      | 50 +-----------------=0D
 arch/x86/kernel/cpu/cpuid-deps.c  | 84 +++++++++++++++++++++++++++----=0D
 4 files changed, 78 insertions(+), 59 deletions(-)=0D
=0D
-- =0D
2.26.3=0D
=0D

