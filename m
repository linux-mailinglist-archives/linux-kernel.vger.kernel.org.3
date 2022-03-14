Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275DA4D8CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 20:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244443AbiCNTsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 15:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244454AbiCNTsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DED23E5CC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647287232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fJ6w/h9IQS83uNAzPXSeVXDkLSEU7B4Oh5HlrNQNuVw=;
        b=ZETSZTGbyycC2cZN6ImJtzEtdBz0bJbAcqTdZUY2FQF9Pa9Cfu3f0Qn3W31T8McECCPWTM
        LKLW4ughnQ+oquzkXJk63+HDGIt1ZZjZLhKYH9veI36RfSAroVyZNFmDZtE4reIhm5pHy4
        R0QrRY17wA6+3+BR15nLB7vIx0FWMl4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-aF2uSoLfPdC-1I_LGOoPaA-1; Mon, 14 Mar 2022 15:47:09 -0400
X-MC-Unique: aF2uSoLfPdC-1I_LGOoPaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E9E8801585;
        Mon, 14 Mar 2022 19:47:08 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A9C6400E43A;
        Mon, 14 Mar 2022 19:47:07 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Feng Tang <feng.tang@intel.com>,
        Bill Gray <bgray@redhat.com>,
        Jirka Hladky <jhladky@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] x86/tsc: Avoid TSC sync failure
Date:   Mon, 14 Mar 2022 15:46:28 -0400
Message-Id: <20220314194630.1726542-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting a kernel on some Intel CooperLake systems, it was found
that the initial TSC sync at boot up may sometime fail leading to a
fallback to HPET as the system clock instead with some performance
degradation. For example

[    0.034090] TSC deadline timer available
[    0.008807] TSC ADJUST compensate: CPU36 observed 95626 warp. Adjust: 95626
[    0.008807] TSC ADJUST compensate: CPU36 observed 74 warp. Adjust: 95700
[    0.974281] TSC synchronization [CPU#0 -> CPU#36]:
[    0.974281] Measured 4 cycles TSC warp between CPUs, turning off TSC clock.
[    0.974281] tsc: Marking TSC unstable due to check_tsc_sync_source failed

This patch set tries to minimize these type of failures by
 1) Put all the TSC synchronization variables in their own cacheline to
    minimize external interference.
 2) Try to estimate the synchronization overhead and add it to the
    adjustment value.

With these changes in place, only one TSC adjustment was observed for
each of the affected cpus with no failure.

Waiman Long (2):
  x86/tsc: Reduce external interference on max_warp detection
  x86/tsc_sync: Add synchronization overhead to tsc adjustment

 arch/x86/kernel/tsc_sync.c | 84 ++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 36 deletions(-)

-- 
2.27.0

