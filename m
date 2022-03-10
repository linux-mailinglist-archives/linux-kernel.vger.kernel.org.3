Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4354D4258
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbiCJIUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbiCJIUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:20:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676F04615A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:19:13 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso3814468ybs.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pv28Faolj+7Soj0gHDlyBK1ro4ADq47RJXCswgEhoDI=;
        b=kCv0EQ4leIi6VX8IuGQH8RY+BYnAWGb4zDTP+u3AhBQjZHJhClLcnLIwRNSvazvPrF
         815KOvPdEHorGRGxn316fgWQV7tMIkvzL2jGzBaKxNKxouXQQgaw++qYv+ob9EDCVdkl
         agXhAolohgV5Qb1eXlgO+UjMxYaDDvYenLlqDtM3p9q/iDU21rCEEEIKislXAvpSzL8d
         OoOq6i51cwh4TCtwvgPmNMldB4TjmBSdamBrxyPLKbCUtb1j7dykt8IA+MX459tt9C0h
         5fG0jjU0Vk6f6eLonRwsw6cmdaqXJgRTOw8QiZytxQrcic7BQ7OYP641qKzzB3iY6+tf
         61xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pv28Faolj+7Soj0gHDlyBK1ro4ADq47RJXCswgEhoDI=;
        b=jNFs4t8VuU1WFCyU1cd8KV2RCZp7KvEljLzZE6KsIkl/OLPqzne4XT8q3niCfWo1uT
         lA84A1BMaHz3+yXIBxtgu5rr55O59LrubX1yUU6qAFfB450DyC2V8Auh38lNdL8hQ1g1
         fyeCW8QN5JLL9T+lkN3fk00N5czNg9fag6CtSpZSFyetZlwko7JrrD+ZqDCO4t3KO4zi
         7UMPnSJJ/npFc4RxNRr4ogl8C+06dQskcKz0TRB8lLjqcM8/jtu4Z5E54jczJgPAC17b
         na2ZsUpj6RTVI7p4+Y5ZVJy8xdpgCAi2Ot4nQg44/j1iGeNr1LBchhcUhc73zM1VGZ8I
         30LQ==
X-Gm-Message-State: AOAM531XU6RzpAIR9oVSoiXjbdV0Vu1x/N3fgjejlWOn3dnGobBDs0Hh
        37Qmsq7J6iSiTjxE8p0hQVMjZApLuSw=
X-Google-Smtp-Source: ABdhPJyA9wa4MHLHx744C9yWLaZhNveWWxDh9E2nzCTaaSHp4dAKLhvjlmzfkuCWe+3fmaZ67rNFzLpQ8xA=
X-Received: from jiyong.seo.corp.google.com ([2401:fa00:d:11:f59e:134:eb7:e1d2])
 (user=jiyong job=sendgmr) by 2002:a81:c24b:0:b0:2dc:7d67:a57a with SMTP id
 t11-20020a81c24b000000b002dc7d67a57amr3207630ywg.272.1646900352571; Thu, 10
 Mar 2022 00:19:12 -0800 (PST)
Date:   Thu, 10 Mar 2022 17:18:54 +0900
Message-Id: <20220310081854.2487280-1-jiyong@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH] vhost/vsock: reset only the h2g connections upon release
From:   Jiyong Park <jiyong@google.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     adelva@google.com, Jiyong Park <jiyong@google.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

Filtering non-h2g connections out when determining orphaned connections.
Otherwise, in a nested VM configuration, destroying the nested VM (which
often involves the closing of /dev/vhost-vsock if there was h2g
connections to the nested VM) kills not only the h2g connections, but
also all existing g2h connections to the (outmost) host which are
totally unrelated.

Tested: Executed the following steps on Cuttlefish (Android running on a
VM) [1]: (1) Enter into an `adb shell` session - to have a g2h
connection inside the VM, (2) open and then close /dev/vhost-vsock by
`exec 3< /dev/vhost-vsock && exec 3<&-`, (3) observe that the adb
session is not reset.

[1] https://android.googlesource.com/device/google/cuttlefish/

Signed-off-by: Jiyong Park <jiyong@google.com>
---
 drivers/vhost/vsock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 37f0b4274113..2f6d5d66f5ed 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -722,6 +722,10 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 * executing.
 	 */
 
+	/* Only the h2g connections are reset */
+	if (vsk->transport != &vhost_transport.transport)
+		return;
+
 	/* If the peer is still valid, no need to reset connection */
 	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
 		return;
-- 
2.35.1.723.g4982287a31-goog

