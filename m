Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6DE513BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351184AbiD1SnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiD1SnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:43:11 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DCEBE9F5;
        Thu, 28 Apr 2022 11:39:55 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 71CC137A;
        Thu, 28 Apr 2022 18:39:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 71CC137A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1651171195; bh=fxw3rNrkfLA2emenBhZ8L7bdgypypZpUWtQbyeBbAl8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=G84Kt3DbbfUzzepGREd8nWnTW9WwCy231V3+AEwXL7wKFJxLer3Ya3dXEZ2o9bQMm
         70kAjxtBCWiaFuj2nenIbd9Uh1mY6EGSGBM2TMnq943D0cGF3H/zyZaog5Lrvf8vXT
         e+7bex7EKjDXYQYW9XrNCaawpbj65EYOBQGmbi0pAp0iZVzk0clTeQ/veu+ModTV/D
         YFcY0LAux0tv7Y0bK15RF7LLN9hJj94KuRFaPuTwfyXrioSKj1EHCziccYZRstExE4
         uol3LxVzsTUxoI8vDqonSUrojaRvywPd+PvhZviGOr1c3NDUQLaWV6lc2hCjQ4PtJ6
         m0a5Fj3Nb0YCg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joel Savitz <jsavitz@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rob Herring <robh@kernel.org>, Wang Qing <wangqing@vivo.com>,
        linux-doc@vger.kernel.org, chao <chao@eero.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] Documentation/sysctl: document max_rcu_stall_to_panic
In-Reply-To: <CAL1p7m4drKAz4yocoT7ovhmFC_cGBbAC+jPvsg+exYkwJ72POw@mail.gmail.com>
References: <20220324221156.44813-1-jsavitz@redhat.com>
 <CAL1p7m4drKAz4yocoT7ovhmFC_cGBbAC+jPvsg+exYkwJ72POw@mail.gmail.com>
Date:   Thu, 28 Apr 2022 12:39:54 -0600
Message-ID: <87levp59xh.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Savitz <jsavitz@redhat.com> writes:

> Friendly ping.

This was waiting for an ack from an RCU person.  Looking now, though, I
see that you didn't copy any RCU people.  Adding Paul and the author of
the patch you reference (and appending patch below).

Thanks,

jon

Joel Savitz <jsavitz@redhat.com> (March 24) (kernel lwn)
Subject: [PATCH] Documentation/sysctl: document max_rcu_stall_to_panic
To: linux-kernel@vger.kernel.org
Cc: Joel Savitz <jsavitz@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, Huang Ying <ying.huang@intel.com>, Eric Biggers <ebiggers@google.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Daniel Borkmann <daniel@iogearbox.net>, Rob Herring <robh@kernel.org>, Wang Qing <wangqing@vivo.com>, linux-doc@vger.kernel.org
Date: Thu, 24 Mar 2022 18:11:56 -0400

commit dfe564045c65 ("rcu: Panic after fixed number of stalls")
introduced a new systctl but no accompanying documentation.

Add a simple entry to the documentation.

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 803c60bf21d3..4e48139b9a34 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -781,6 +781,13 @@ is useful to define the root cause of RCU stalls using a vmcore.
 1 panic() after printing RCU stall messages.
 = ============================================================

+max_rcu_stall_to_panic
+======================
+
+When ``panic_on_rcu_stall`` is set to 1, this value determines the
+number of times that RCU can stall before panic() is called.
+
+When ``panic_on_rcu_stall`` is set to 0, this value is has no effect.

 perf_cpu_time_max_percent
 =========================
