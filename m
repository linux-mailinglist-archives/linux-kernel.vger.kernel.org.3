Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE824EBFC8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343638AbiC3LcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiC3LcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:32:10 -0400
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3BE199E01
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648639820;
        bh=9+iY9B+X+YN1oo9ipnds6d68zDiqia3PAGjqADcjvcM=;
        h=From:To:Cc:Subject:Date;
        b=CtCWFi30zyQ3HEnXWzSyAXr6Uyd4YGRzze7GKOPiyvTg3LpSE2FsrhsaryfGcj8fB
         pKedVTSodxpNAXxeaJQD8AJoWMatDAFrdR/GkFDD4Z/Op2XUzWZElBixmi4uhsFwHz
         Tn02gppZXV7ajdaXx1VPGs10rDxZV0c5/TNrJL7A=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc6.qq.com (NewEsmtp) with SMTP
        id 7908284A; Wed, 30 Mar 2022 19:30:16 +0800
X-QQ-mid: xmsmtpt1648639816tob60ixc0
Message-ID: <tencent_D95ACC78B93B1CDD14C4E13E4A66FF892008@qq.com>
X-QQ-XMAILINFO: NiAdzfE16ND47ZF6Tl2VR9BjOUK8lcRvYvAREVjoz5arzoXnDmGPiNFew9xdpb
         zbW/sU2P0JbiGodmPdqoBxOK9HFSeovv2ghnVxUqxhPHSO+CN3Ta3YPlNmKZIh9uM0Nvwvh6q6WH
         7lQAaHkJXlxRmV+MbUI64mhTuzVt+AkFi8VQT+j8fSQ1Zcgop3OOZUyAlIgcJGmY6uPVjYzTo5iD
         09E7iPGI9kGQJ6tCh//UKcj1Wi3RKcccy+zjwcvinHTC/5Orjq+m4hVADwb4LzFWcrE7hq7ooKQT
         7ygPvkkX3eQo537ARZ4cUpakwEzwVvprAAKekTJTm/jWWDSOt6g/ZZZ8D+NjXviMbarZ21Uu1YFZ
         xZ6EXA+SrWmOtAEiyVyCA396mJYW0y1Xhfg8iQGbVxwsRuwjVsKQ7wwIpytIWfsMZufbdosJtbWo
         cxnDW7bAPfehAZOarOv4lhO7AwxuSAqG1/1EWkieVplZF4jIKyO/nfpdHZ8/BA+G6LydDsi02eWB
         TMkkAEKycZIKw1WxF99Y3ImGw20/VWI3HPJNsLAezdT0LMvIOvUOD/yItTY0+qC8gCLGxPPp3Oi3
         KtPQ380VXATdWYqz8d1D7xijmrLJeJSY+SX82qpTNq1mcq/XN8dsW9rf5oNfZq4GlfVE4EXCoNbh
         PHsr2LgAiAdr/BNeALEx/WYoqb3fwEaqtaRABsgEIxdvZp9LHTbPIjuR7iNH7hTLJ/TM0Juvmfsf
         bqzgHiNLQRf5rSONzDkFGRBqJ5RX6ZlAkahyBUeIdrI0d5BjhtvJhGb5ibGPlCoGpA/dPQGVNOoE
         nGZgr5Szxd7WoBgVgcoFxHeh50b0zoUfPvFa/P1NUa09Tb6RbFd8GzCC2IuG1m0Negh39Zd9ufZZ
         oAUN5GnQ+T+QrMXqlIhDm6WUB5NgAvUu6EwNsKkVEKj/KG7ggGyjgrWBMvJix04OvJyFoFEfU6dh
         qkHK0Ih9wTrMdCiR8CTw==
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] staging: r8188eu: add a check for rtw_cbuf_alloc()
Date:   Wed, 30 Mar 2022 19:30:05 +0800
X-OQ-MSGID: <20220330113005.5465-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kmalloc() is called by rtw_cbuf_alloc() and it returns pointer of
srtuct rtw_cbuf, NULL for allocation failure. So it is better to check
the return value of it.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index ce73ac7..56910c3 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -69,6 +69,8 @@ static int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
 	_init_workitem(&pevtpriv->c2h_wk, c2h_wk_callback, NULL);
 	pevtpriv->c2h_wk_alive = false;
 	pevtpriv->c2h_queue = rtw_cbuf_alloc(C2H_QUEUE_MAX_LEN + 1);
+	if (!pevtpriv->c2h_queue)
+		res = _FAIL;
 
 	return res;
 }
-- 

