Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEDE570C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiGKVQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiGKVQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:16:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 777F3823B4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657574185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HQK/MBlEjX74s0apUftzaPPRJK2H5VXdkugL64NaRtk=;
        b=aDygW9n92pS3FlOmDMx+XUJcTCfxPYcWKWLk2Y2LP+F7nDi8atNkYlTW/M8HYzFVY+CK2P
        7zmRx6/XL/nz6D4wJBP7HhE6EyyFqC+i6ku7iioHgIkUgJBdrb1FuDj8epswO/VHMRwzmR
        DBgcp3wCB5RCcc5bjJyRH3vbpP7Piz8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-pYHXJ_uWM-ybrzYxwdO3gg-1; Mon, 11 Jul 2022 17:16:20 -0400
X-MC-Unique: pYHXJ_uWM-ybrzYxwdO3gg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76A961018AA4;
        Mon, 11 Jul 2022 21:16:20 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-237.bos.redhat.com [10.18.17.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 480132166B26;
        Mon, 11 Jul 2022 21:16:20 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH v3 0/2] cpuhp: fix some st->target issues
Date:   Mon, 11 Jul 2022 17:16:17 -0400
Message-Id: <20220711211619.112854-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several small fixes that clean up some cpuhp inconsistencies.
The first prevents target_store() from calling cpu_down() when
target == state which prevents the cpu being incorrectly marked
as dying.  The second just makes the boot cpu have a valid cpuhp
target rather than 0 (CPU_OFFLINE) while being in state
CPU_ONLINE.

A further issue which these two patches don't address is that
the cpuX/online file looks at the device->offline state and can
thus get out of sync with the actual cpuhp state if the cpuhp
target is used to change state.

v3: Added code to make sure st->target == target in the nop case.

Phil Auld (2):
  cpuhp: make target_store() a nop when target == state
  cpuhp: Set cpuhp target for boot cpu

 kernel/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.31.1

