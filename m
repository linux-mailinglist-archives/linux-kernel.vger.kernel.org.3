Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D194B95BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 02:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiBQBz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 20:55:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiBQBzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:55:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5212523D5EB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645062939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Mp9AX7ZHbxVTigfVKoo62QufVN1YR9M1H25gWEWEMhc=;
        b=UNX8/xVGrs1FX/eb9J3jUJyJ5ERoM+iwJ+mqzBpnrpTuacYMZO6QEYb9IqT+CjS//NAA2G
        EGOB/ZKuDtBZEUE9I2BIPmgFFIihrczcjPRI/EA7Gjzd3KETGMJcmVTmYYg8ZjUQ5E9GE3
        9sTsYvZuij+kBShxwUd/w1LL2s6C6zY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-fajvFKc2OFKy08A4FMSNXw-1; Wed, 16 Feb 2022 20:55:38 -0500
X-MC-Unique: fajvFKc2OFKy08A4FMSNXw-1
Received: by mail-pf1-f198.google.com with SMTP id 64-20020a620643000000b004e13146921cso2357586pfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mp9AX7ZHbxVTigfVKoo62QufVN1YR9M1H25gWEWEMhc=;
        b=IEc5IpkLJ1cjpylxGRc0DIiP+fQAWGwKVEVU8X3dNmFSYwAqEDrjloMMqxqeXVWwnX
         4c972tHwPSUNxJUswlwrVz0hN/mafPBxC3GwgPzhP9JtxwrJza6w//bEs3zrtMMv5PCg
         dXfAI3uwnMPWr32Qh7X9w1lKVLDWs4hEww2gV8Bm2CfM+s1KFrXnDUg3OzQOVM/8qHoO
         zlQxXc9GpgjCkJDOVbI8bJRejbFtsL8O0q9hM/dPuPuJLnJug8g1v67fGre0pgM1WWAL
         3pC8CCq+wm3IRs3SqOXBgBCf+K/kSZMjMogsWmSFtyvohrpgsIqf/qm8LaNA2ztXJOUK
         L8mw==
X-Gm-Message-State: AOAM532tFvaXLeYF6vSEYtLwObutXRfP8vOVjmbxjI1vSiIOmJ/iikdL
        5gjOC+sjm2GFjCItP/H6faj9g3z4Sa7wiTSfwX94Kkd6u6nHotIqNJiz3ACHwEWGlEHadXDSim2
        5EGt3V9P/JTu24kNF8rVlAwoY
X-Received: by 2002:a63:ff0d:0:b0:33b:9299:104b with SMTP id k13-20020a63ff0d000000b0033b9299104bmr646566pgi.480.1645062936979;
        Wed, 16 Feb 2022 17:55:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzommiekYY3g9xl8nIxnhIiXZZA3G4HY/QlQjsn2GbNuZBxsXv2rTV1fcHgefgswpehxohKA==
X-Received: by 2002:a63:ff0d:0:b0:33b:9299:104b with SMTP id k13-20020a63ff0d000000b0033b9299104bmr646545pgi.480.1645062936646;
        Wed, 16 Feb 2022 17:55:36 -0800 (PST)
Received: from localhost.localdomain.com ([103.208.69.158])
        by smtp.gmail.com with ESMTPSA id l16sm295579pjz.38.2022.02.16.17.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 17:55:35 -0800 (PST)
From:   Suresh Kumar <surkumar@redhat.com>
X-Google-Original-From: Suresh Kumar <sureshks@redhat.com>
To:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     suresh kumar <suresh2514@gmail.com>
Subject: [PATCH] net-sysfs: add check for netdevice being present to speed_show
Date:   Thu, 17 Feb 2022 07:25:18 +0530
Message-Id: <20220217015518.62719-1-sureshks@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: suresh kumar <suresh2514@gmail.com>

When bringing down the netdevice or system shutdown, a panic can be
triggered while accessing the sysfs path because the device is already
removed.

    [  755.549084] mlx5_core 0000:12:00.1: Shutdown was called
    [  756.404455] mlx5_core 0000:12:00.0: Shutdown was called
    ...
    [  757.937260] BUG: unable to handle kernel NULL pointer dereference at           (null)
    [  758.031397] IP: [<ffffffff8ee11acb>] dma_pool_alloc+0x1ab/0x280

    crash> bt
    ...
    PID: 12649  TASK: ffff8924108f2100  CPU: 1   COMMAND: "amsd"
    ...
     #9 [ffff89240e1a38b0] page_fault at ffffffff8f38c778
        [exception RIP: dma_pool_alloc+0x1ab]
        RIP: ffffffff8ee11acb  RSP: ffff89240e1a3968  RFLAGS: 00010046
        RAX: 0000000000000246  RBX: ffff89243d874100  RCX: 0000000000001000
        RDX: 0000000000000000  RSI: 0000000000000246  RDI: ffff89243d874090
        RBP: ffff89240e1a39c0   R8: 000000000001f080   R9: ffff8905ffc03c00
        R10: ffffffffc04680d4  R11: ffffffff8edde9fd  R12: 00000000000080d0
        R13: ffff89243d874090  R14: ffff89243d874080  R15: 0000000000000000
        ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
    #10 [ffff89240e1a39c8] mlx5_alloc_cmd_msg at ffffffffc04680f3 [mlx5_core]
    #11 [ffff89240e1a3a18] cmd_exec at ffffffffc046ad62 [mlx5_core]
    #12 [ffff89240e1a3ab8] mlx5_cmd_exec at ffffffffc046b4fb [mlx5_core]
    #13 [ffff89240e1a3ae8] mlx5_core_access_reg at ffffffffc0475434 [mlx5_core]
    #14 [ffff89240e1a3b40] mlx5e_get_fec_caps at ffffffffc04a7348 [mlx5_core]
    #15 [ffff89240e1a3bb0] get_fec_supported_advertised at ffffffffc04992bf [mlx5_core]
    #16 [ffff89240e1a3c08] mlx5e_get_link_ksettings at ffffffffc049ab36 [mlx5_core]
    #17 [ffff89240e1a3ce8] __ethtool_get_link_ksettings at ffffffff8f25db46
    #18 [ffff89240e1a3d48] speed_show at ffffffff8f277208
    #19 [ffff89240e1a3dd8] dev_attr_show at ffffffff8f0b70e3
    #20 [ffff89240e1a3df8] sysfs_kf_seq_show at ffffffff8eedbedf
    #21 [ffff89240e1a3e18] kernfs_seq_show at ffffffff8eeda596
    #22 [ffff89240e1a3e28] seq_read at ffffffff8ee76d10
    #23 [ffff89240e1a3e98] kernfs_fop_read at ffffffff8eedaef5
    #24 [ffff89240e1a3ed8] vfs_read at ffffffff8ee4e3ff
    #25 [ffff89240e1a3f08] sys_read at ffffffff8ee4f27f
    #26 [ffff89240e1a3f50] system_call_fastpath at ffffffff8f395f92

    crash> net_device.state ffff89443b0c0000
      state = 0x5  (__LINK_STATE_START| __LINK_STATE_NOCARRIER)

To prevent this scenario, we also make sure that the netdevice is present.

Signed-off-by: suresh kumar <suresh2514@gmail.com>
---
 net/core/net-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 53ea262ecafd..fbddf966206b 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -213,7 +213,7 @@ static ssize_t speed_show(struct device *dev,
 	if (!rtnl_trylock())
 		return restart_syscall();
 
-	if (netif_running(netdev)) {
+	if (netif_running(netdev) && netif_device_present(netdev)) {
 		struct ethtool_link_ksettings cmd;
 
 		if (!__ethtool_get_link_ksettings(netdev, &cmd))
-- 
2.27.0

