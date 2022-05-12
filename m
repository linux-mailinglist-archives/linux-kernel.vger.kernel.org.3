Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CE7525030
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355054AbiELOfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355389AbiELOey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 144B726084D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652366085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mglyuvEmvgYHun8zwNB9cJvmded1N/ByJaYNnqZF5m0=;
        b=DCjV9shwDe2NJNBHZbCEGM38GXpAgNYHK/6d1uaetlStwLRQfuwY7h6zReMU2/Tq/PQaoI
        cQNUSUwmho7cFJOYShkMRCSf0DTwBISS61DUi4k4ZdlQmVwa1n9wRpLIE6gTOKgsQ2Nd3w
        nzD85L4iHUaOq4eB72kwPfrTG/8L4qA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-MhFf1UAxNAW6SmEMJOd-yg-1; Thu, 12 May 2022 10:34:41 -0400
X-MC-Unique: MhFf1UAxNAW6SmEMJOd-yg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6C2538149A9;
        Thu, 12 May 2022 14:34:40 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8005E552781;
        Thu, 12 May 2022 14:34:40 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mkoutny@suse.com, tj@kernel.org, longman@redhat.com
Subject: [PATCH] kselftest/cgroup: fix test_stress.sh to use OUTPUT dir
Date:   Thu, 12 May 2022 10:34:39 -0400
Message-Id: <20220512143439.26104-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running cgroup kselftest with O= fails to run the with_stress test due
to hardcoded ./test_core. Find test_core binary using the OUTPUT directory.

Fixes: 1a99fcc035fb ("selftests: cgroup: Run test_core under interfering stress")
Signed-off-by: Phil Auld <pauld@redhat.com>
---
 tools/testing/selftests/cgroup/test_stress.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_stress.sh b/tools/testing/selftests/cgroup/test_stress.sh
index 15d9d5896394..109c044f715f 100755
--- a/tools/testing/selftests/cgroup/test_stress.sh
+++ b/tools/testing/selftests/cgroup/test_stress.sh
@@ -1,4 +1,4 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-./with_stress.sh -s subsys -s fork ./test_core
+./with_stress.sh -s subsys -s fork ${OUTPUT}/test_core
-- 
2.18.0

