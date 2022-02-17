Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4979E4BA2AC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiBQONh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:13:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241762AbiBQONa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:13:30 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32B2291F99
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:13:14 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id y7so2296968oih.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qb7ol7cP6dS+SYaBDXsRKb9z2B7mLjMfAohF1xVujD4=;
        b=LgFgBcySCIooM2tx8Y8RMWnEm10vFNWo9fDRqTf/WARg6vTADtA2R5LEfC6kL4iQMB
         CbkHqBWLhgmjjf6rSgj9GnfA7x6Jv4UoWaGWithXmYhxWyHG2UY3P9Vgj6iHUIGleeQj
         CktVPS0RyvKt2nbZNh4aGsEVo7gdeAyLprB6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qb7ol7cP6dS+SYaBDXsRKb9z2B7mLjMfAohF1xVujD4=;
        b=TbkZDfAYZfWsevQ/+9PK+kth6/z7zZIum2QwTrDpu8tdNSJfXySHVwAE2BRj6rlJ59
         DoYI6ZZG9oyOlrNdazEuOIIEXHc/M0FUMwmCKK8GsFdSepzmOSGWCxl2nXktqFjnPFAm
         wFOwlgF2tJxl1KNxJal1pUmQGrzUR2u5ohkwWl4kGX2QNSIp5ky4nblIC5Ljtkx4S3XI
         ijx161zRp057R54t7TzlVh0lwOUV/BMj32rm2zHXqAI4K+0gwvU0I96sXZ/RCK4ipG1/
         aRpqozssJ1HpThIqj3q3/msT4TZRk3ZGSVFviEWfB2On+bYsg/AccxocgzZKr+ACOAJb
         aKGg==
X-Gm-Message-State: AOAM533/jMlxvAYKSoM0MDqKYuTFlAORUAV5SXWa9cs9Z4Ag0boz0e/z
        GRJCtEp+GD1TrTY59o8ZCa8LzA==
X-Google-Smtp-Source: ABdhPJyIjKB54xE5ZECSy5ei0Bc0imaBkjmgNgu7HW6oAwPwzRsHz/vweze7HAiuuftsYPi6KLmgFg==
X-Received: by 2002:a05:6808:301e:b0:2ce:6a75:b880 with SMTP id ay30-20020a056808301e00b002ce6a75b880mr1142025oib.327.1645107193753;
        Thu, 17 Feb 2022 06:13:13 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:e6fb:7a78:2789:5566])
        by smtp.gmail.com with ESMTPSA id p22sm20481925oae.33.2022.02.17.06.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 06:13:13 -0800 (PST)
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] vsock: remove vsock from connected table when connect is interrupted by a signal
Date:   Thu, 17 Feb 2022 08:13:12 -0600
Message-Id: <20220217141312.2297547-1-sforshee@digitalocean.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vsock_connect() expects that the socket could already be in the
TCP_ESTABLISHED state when the connecting task wakes up with a signal
pending. If this happens the socket will be in the connected table, and
it is not removed when the socket state is reset. In this situation it's
common for the process to retry connect(), and if the connection is
successful the socket will be added to the connected table a second
time, corrupting the list.

Prevent this by calling vsock_remove_connected() if a signal is received
while waiting for a connection. This is harmless if the socket is not in
the connected table, and if it is in the table then removing it will
prevent list corruption from a double add.

Note for backporting: this patch requires d5afa82c977e ("vsock: correct
removal of socket from the list"), which is in all current stable trees
except 4.9.y.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Seth Forshee <sforshee@digitalocean.com>
---
v2: Add Fixes tag and backporting notes.
---
 net/vmw_vsock/af_vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 3235261f138d..38baeb189d4e 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1401,6 +1401,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
 			sock->state = SS_UNCONNECTED;
 			vsock_transport_cancel_pkt(vsk);
+			vsock_remove_connected(vsk);
 			goto out_wait;
 		} else if (timeout == 0) {
 			err = -ETIMEDOUT;
-- 
2.32.0

