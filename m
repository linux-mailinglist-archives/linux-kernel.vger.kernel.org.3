Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE10A57E6CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbiGVSpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbiGVSpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:45:06 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE45A242
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:45:04 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id d66-20020a636845000000b0040a88edd9c1so2694879pgc.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oBaauaBIZjrieTof2FGDg75mtCH/CB1KU2oTgxF56KE=;
        b=n7ZISF7P0c/oRx0sJ9WPdepLb4eJUQgpXQDXjgvo0KJX7kPA2r4EbdOFkQiIB4xYJA
         48/3exbglFlVY+oXYsKQhXAjLm7FBbZ6HGC8+IcyekAk0G4e4zmzxDeEiJy/4ph3o29i
         tDgrMBmYM4RjvOU1sLPzKFktof2eMfBOhLK+dl96gSc03eucM06TF6ZbpQlzHr/9ejAY
         8X24suFfsNBLHWN3bR5wjfKQtTVJMpRY8eS1+b/dV14p+lxfTcpJ5g4chbjao0aioYJB
         BqxUGP5yv8jwWiRFogKKlYEg32BDBVZ9Q9jW6R1No+fbmwZDfRNQdYfLyEOXuoFVvaYx
         dVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oBaauaBIZjrieTof2FGDg75mtCH/CB1KU2oTgxF56KE=;
        b=h4DlcHDrKAGyGziIFQJkRlhG7QQhWtGAMW4DP9SDc3inpuLAoS0zqE5I4b/9mIZxaY
         AplROTpxHXxswCQ5H0v10o2kNG0ne1LvrVGJ0DveXrexRaRDrpoASVooy2nbXc7+bygc
         Cr6PirUX+quPwRHBl/zaacNIzzag+lrVLzNbxpVhtMZiR9w/x44qI4gx8l0NVAMWnVYx
         TXal0EpOoLaiYipp6IIRv++qDSBo8ZZ5/y1KJd+imMIurLs/DoknP7knMLQIaveYhZaZ
         m/cg7AnQfWiPtov0qmfxgsXYc21AzgHBn6K+vEIFfIFp7L8B2TRhqtvsTj77t2cUrJSY
         yACg==
X-Gm-Message-State: AJIora8purCp2/vQJ+OqYtHOQdM2aAwhUUx4XEgprWZxTR26QYQG8Hzc
        nV6KzWzNRmWyKKSDet45RM1Hok/NLAg/
X-Google-Smtp-Source: AGRyM1vN3WlCMN72nJ5jc9Ik2xDUl3kgfKgcFdGOzta9WiLWfv31zr1Kj12o0c4KRCLEMjVDMJqdux/+E36a
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:903:230a:b0:16c:58a3:6395 with SMTP id
 d10-20020a170903230a00b0016c58a36395mr1135339plh.20.1658515504364; Fri, 22
 Jul 2022 11:45:04 -0700 (PDT)
Date:   Fri, 22 Jul 2022 11:44:55 -0700
In-Reply-To: <20220722184455.3926696-1-jiangzp@google.com>
Message-Id: <20220722114449.kernel.v1.1.Ifce963ae9c092b69c116736b57e5d3a40b776060@changeid>
Mime-Version: 1.0
References: <20220722184455.3926696-1-jiangzp@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [kernel PATCH v1 1/1] Bluetooth: Return error if controller not
 support ll privacy
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return proper error message if the controller does not support ll privacy.

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Return proper mgmt error if controller does not support ll privacy

 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ef8371975c4eb..e5eb422d14464 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4143,6 +4143,12 @@ static int set_rpa_resolution_func(struct sock *sk, struct hci_dev *hdev,
 				       MGMT_OP_SET_EXP_FEATURE,
 				       MGMT_STATUS_INVALID_INDEX);
 
+	/* Controller does not support LL privacy */
+	if (!ll_privacy_capable(hdev))
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
 	/* Changes can only be made when controller is powered down */
 	if (hdev_is_powered(hdev))
 		return mgmt_cmd_status(sk, hdev->id,
-- 
2.37.1.359.gd136c6c3e2-goog

