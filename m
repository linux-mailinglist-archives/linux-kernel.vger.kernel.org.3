Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2255B0A33
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIGQfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiIGQfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DB64D174
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662568516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A0VSNh+UywAONPBjLpCLWLZqP5s9DGWDr3ehS/v+q+A=;
        b=RSAofNuez/18iBp02OijoJtRhRETYtgPwV1jvyzwUPcLNcdGTTrnJDIC81KNvrVLyK8RRZ
        Zm/hYDqCp+/Ba5xXR9ZUg2dS+cwRAyEqtkr7KeXjEOKejTpRIMfLuJkXjmrnFbELTx/H6h
        uUL5mUzr51gHcQWvwEeiBMH2aOzIyxA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-Xk7P-2SVOOmJsfjkVP0akg-1; Wed, 07 Sep 2022 12:35:15 -0400
X-MC-Unique: Xk7P-2SVOOmJsfjkVP0akg-1
Received: by mail-pg1-f200.google.com with SMTP id w1-20020a63d741000000b0042c254a4ccdso7785227pgi.15
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 09:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=A0VSNh+UywAONPBjLpCLWLZqP5s9DGWDr3ehS/v+q+A=;
        b=ap8b0rMJlmVrFL8HaPs71d1Rh2CBpAJxcE2rvw4Dg4FqQUST+YK4cV00deyXDORPH8
         am8lmRjj49e238/LxmhM1HbhV0VWfUrf14Mig3f2R28i9XwnCAxmroeEJQ+OL9ZbXVBJ
         pNM1Caco8bqDTr5zNxoy4HGwY2h9GVtzbQSShWA/Sw/tseBacIbgvPl5ZzHezam1Fs9H
         Dd9EjZ2NF+pEzJGWvJ+Pn/KoIDVU2Dc6WYUz18T3DgrRwqMNYPA17ihYa7SzFJZpZMjP
         mKA4LC1/D8XBVlU7LBNuUFSAdyli8pj0iSW8sHo3LnOmq9/eJQZF0kFdgDZWiV5pFF7l
         bjIg==
X-Gm-Message-State: ACgBeo1EFE0zmads6QmtJHJbsYm+NMWUPpYrV4jSsJ82jBLm1CleKp0S
        JOrqbA4xs1RXmULrQQSx+RR7ubiXOL05nzXRyegNLMyvGROt5oT6QpKBalaohXDJVUn110eWn7w
        BUwrHuNDdXrS5qgxQBkunvW6l
X-Received: by 2002:a17:902:9b85:b0:16e:cc02:b9b2 with SMTP id y5-20020a1709029b8500b0016ecc02b9b2mr4538458plp.74.1662568514419;
        Wed, 07 Sep 2022 09:35:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7r/x7CdhyIi+Ws6YtHvtEtvjDAJ5wS2GD6N2EGK8KrkbtXG4v7M/3xt+UtWy169uWDtkAVJg==
X-Received: by 2002:a17:902:9b85:b0:16e:cc02:b9b2 with SMTP id y5-20020a1709029b8500b0016ecc02b9b2mr4538435plp.74.1662568514147;
        Wed, 07 Sep 2022 09:35:14 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id e22-20020aa79816000000b00537e328bc11sm12688689pfl.31.2022.09.07.09.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:35:13 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+38e6c55d4969a14c1534@syzkaller.appspotmail.com
Subject: [PATCH] nbd: Fix hung when signal interrupts nbd_start_device_ioctl()
Date:   Thu,  8 Sep 2022 01:35:02 +0900
Message-Id: <20220907163502.577561-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported hung task [1].  The following program is a simplified
version of the reproducer:

int main(void)
{
	int sv[2], fd;

	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv) < 0)
		return 1;
	if ((fd = open("/dev/nbd0", 0)) < 0)
		return 1;
	if (ioctl(fd, NBD_SET_SIZE_BLOCKS, 0x81) < 0)
		return 1;
	if (ioctl(fd, NBD_SET_SOCK, sv[0]) < 0)
		return 1;
	if (ioctl(fd, NBD_DO_IT) < 0)
		return 1;
	return 0;
}

When signal interrupt nbd_start_device_ioctl() waiting the condition
atomic_read(&config->recv_threads) == 0, the task can hung because it
waits the completion of the inflight IOs.

This patch fixes the issue by clearing queue, not just shutdown, when
signal interrupt nbd_start_device_ioctl().

Link: https://syzkaller.appspot.com/bug?id=7d89a3ffacd2b83fdd39549bc4d8e0a89ef21239 [1]
Reported-by: syzbot+38e6c55d4969a14c1534@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/block/nbd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2a709daefbc4..2a2a1d996a57 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1413,10 +1413,12 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd)
 	mutex_unlock(&nbd->config_lock);
 	ret = wait_event_interruptible(config->recv_wq,
 					 atomic_read(&config->recv_threads) == 0);
-	if (ret)
+	if (ret) {
 		sock_shutdown(nbd);
-	flush_workqueue(nbd->recv_workq);
+		nbd_clear_que(nbd);
+	}
 
+	flush_workqueue(nbd->recv_workq);
 	mutex_lock(&nbd->config_lock);
 	nbd_bdev_reset(nbd);
 	/* user requested, ignore socket errors */
-- 
2.37.3

