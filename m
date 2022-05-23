Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CE05313CB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiEWOri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbiEWOrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:47:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F098E580ED
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653317253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=xowbhnWw8S2OkJoKvNZYNUT5Z/TGdflrhWgMmR2yiPk=;
        b=LNHsVPUzvY2KorBQKsm2stTz8TxokZTgUJh0ZsQA2ZvHlxq4bhX/PcF9ZNXl1JZUTUBnm8
        e2exemiRleRig0c2GE9hogUl9Su7UMjiE6e5Lqq94J0KH4/9JbxtMFqpnq3hMVAJxGT2fa
        cNn3E/8WnjMwfjEwoS0LSgLnCBEfyik=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-XITpsU5nMYmmQr4sXVnP-g-1; Mon, 23 May 2022 10:47:29 -0400
X-MC-Unique: XITpsU5nMYmmQr4sXVnP-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70B4B2949BB2;
        Mon, 23 May 2022 14:47:29 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F4481410DD5;
        Mon, 23 May 2022 14:47:29 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] cpuhp: make target_store() a nop when target == state
Date:   Mon, 23 May 2022 10:47:28 -0400
Message-Id: <20220523144728.32414-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

writing the current state back into hotplug/target calls cpu_down()
which will set cpu dying even when it isn't and then nothing will
ever clear it. A stress test that reads values and writes them back
for all cpu device files in sysfs will trigger the BUG() in
select_fallback_rq once all cpus are marked as dying.

kernel/cpu.c::target_store()
	...
        if (st->state < target)
                ret = cpu_up(dev->id, target);
        else
                ret = cpu_down(dev->id, target);

cpu_down() -> cpu_set_state()
	 bool bringup = st->state < target;
	 ...
	 if (cpu_dying(cpu) != !bringup)
		set_cpu_dying(cpu, !bringup);

Make this safe by catching the case where target == state
and bailing early.

Signed-off-by: Phil Auld <pauld@redhat.com>
---

Yeah, I know... don't do that. But it's still messy.

!< != > 

 kernel/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index d0a9aa0b42e8..8a71b1149c60 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2302,6 +2302,9 @@ static ssize_t target_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 #endif
 
+	if (target == st->state)
+		return count;
+
 	ret = lock_device_hotplug_sysfs();
 	if (ret)
 		return ret;
-- 
2.18.0

