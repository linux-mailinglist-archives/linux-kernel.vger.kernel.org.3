Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD2C4A6E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245724AbiBBKFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:05:46 -0500
Received: from relay06.th.seeweb.it ([5.144.164.167]:51949 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245650AbiBBKFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:05:43 -0500
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 0927D3F704;
        Wed,  2 Feb 2022 11:05:42 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v2 2/2] config: android-recommended: Disable BPF_UNPRIV_DEFAULT_OFF for netd
Date:   Wed,  2 Feb 2022 11:05:28 +0100
Message-Id: <20220202100528.190794-2-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220202100528.190794-1-marijn.suijten@somainline.org>
References: <20220202100528.190794-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AOSP's `netd` process fails to start on Android S:

    E ClatdController: getClatEgress4MapFd() failure: Operation not permitted
    I netd    : Initializing ClatdController: 410us
    E netd    : Failed to start trafficcontroller: (Status[code: 1, msg: "Pinned map not accessible or does not exist: (/sys/fs/bpf/map_netd_cookie_tag_map): Operation not permitted"])
    E netd    : CRITICAL: sleeping 60 seconds, netd exiting with failure, crash loop likely!

And on Android R:

    I ClatdController: 4.9+ kernel and device shipped with P - clat ebpf might work.
    E ClatdController: getClatEgressMapFd() failure: Operation not permitted
    I netd    : Initializing ClatdController: 1409us
    E netd    : Failed to start trafficcontroller: (Status[code: 1, msg: "Pinned map not accessible or does not exist: (/sys/fs/bpf/map_netd_cookie_tag_map): Operation not permitted"])

These permission issues are caused by 08389d888287 ("bpf: Add kconfig
knob for disabling unpriv bpf by default") because AOSP does not provide
netd the `SYS_ADMIN` capability, and also has no userspace support for
the `BPF` capability yet.

Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: John Stultz <john.stultz@linaro.org>
[John suggested this in https://linaro.atlassian.net/browse/ACK-107?focusedCommentId=117382]
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---

Changes since v1:
- Drop accidental `From:` override with my other email.

 kernel/configs/android-recommended.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/configs/android-recommended.config b/kernel/configs/android-recommended.config
index 22bd76e43aca..e400fbbc8aba 100644
--- a/kernel/configs/android-recommended.config
+++ b/kernel/configs/android-recommended.config
@@ -1,4 +1,5 @@
 #  KEEP ALPHABETICALLY SORTED
+# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_LEGACY_PTYS is not set
-- 
2.35.1

