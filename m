Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C683649AFA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456880AbiAYJNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455316AbiAYJEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:04:07 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3E6C061346
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 00:47:23 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id t7so7671046ljc.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 00:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k43NlouVQB8hM1beYosBs1yb2iePFVYZFONuMP14vSM=;
        b=zp0RDdvCCfDNZfHZsadkx2auxVmRnOOpvABVv9a1MtModBQsy/um51GjHOd7t53C2N
         tA/G2rMzpf9wWg761k/ef2SUVbbzAlVs+mozPmJjymGAUK5aAiwRQfO9lqwGVxuK5otI
         Pl1RMPJRJoo69MW/tkfnBcf3JEn0aqVRkjuYH7BCr0Pg+c0rglS3vio4S6gl7bQ3UGaX
         1nscK/FwgBv2TA0EsI+2kfdGD0JEbkH1eUyfkEWgAx/EtxIiGFnJMBxIBmnpy6KBN84l
         tTtoY8j5IXK9nVZT2/cuCoUN70rFwtLCwgB0kS14UaLp/KVsdxFJ+fsZKbwvjAtdn1Ll
         DoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k43NlouVQB8hM1beYosBs1yb2iePFVYZFONuMP14vSM=;
        b=U8+Ru+vidnD3TcrnboIP1lRdjqwRhtk2FpbxUBMu61A0mAfexP5dzuieeFnqRIBAeI
         C39/eOjwANjTwdvyKJh9Wdv4U4TSK2TkSyil2glRCoqpPOMRsBwjgPQSeUZM7M2z0G8U
         pJeVFJ+qqcXZy/+MorJ7/KOQ+8pNnetVBOY7zl2HCXWj0LqXyiJjW/GOslF3hGX7BFza
         q+7RkXq4KK0brW+Ss1/txn+BVDVmqkRzO0zbw/gXfElHDq+IjDDXSE5adC1K4Eoq8S7X
         0paRUi/vWO2bl+ak7XVVvhNvrQTo9EOp/dwXCnjfbdVDghDBq4Fe50vh1R+1tMyFzKJU
         BXig==
X-Gm-Message-State: AOAM531wtfRSS5uQ/JpnZkFE9hhVq/DR/UIRM2zD8OduaCilaJtu3huU
        nHE12Uxle/04TPurJGWvoSngEg==
X-Google-Smtp-Source: ABdhPJyYp87wYisP2/l1MxOBncqSB6zBTz6Bvqiipiw7V7kXabqJmsZ2TUeV3tPNrW20SUDhl6kxAg==
X-Received: by 2002:a2e:b914:: with SMTP id b20mr13735990ljb.6.1643100441653;
        Tue, 25 Jan 2022 00:47:21 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id q5sm1418944lfe.279.2022.01.25.00.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 00:47:21 -0800 (PST)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     davem@davemloft.net, kuba@kernel.org, mst@redhat.com,
        jasowang@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     yuri.benditovich@daynix.com, yan@daynix.com
Subject: [RFC PATCH 1/5] uapi/linux/if_tun.h: Added new ioctl for tun/tap.
Date:   Tue, 25 Jan 2022 10:46:58 +0200
Message-Id: <20220125084702.3636253-2-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125084702.3636253-1-andrew@daynix.com>
References: <20220125084702.3636253-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added TUNGETSUPPORTEDOFFLOADS that should allow
to get bits of supported offloads.
Added 2 additional offlloads for USO(IPv4 & IPv6).
Separate offloads are required for Windows VM guests,
g.e. Windows may set USO rx only for IPv4.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 include/uapi/linux/if_tun.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 454ae31b93c7..07680fae6e18 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -61,6 +61,7 @@
 #define TUNSETFILTEREBPF _IOR('T', 225, int)
 #define TUNSETCARRIER _IOW('T', 226, int)
 #define TUNGETDEVNETNS _IO('T', 227)
+#define TUNGETSUPPORTEDOFFLOADS _IOR('T', 228, unsigned int)
 
 /* TUNSETIFF ifr flags */
 #define IFF_TUN		0x0001
@@ -88,6 +89,8 @@
 #define TUN_F_TSO6	0x04	/* I can handle TSO for IPv6 packets */
 #define TUN_F_TSO_ECN	0x08	/* I can handle TSO with ECN bits. */
 #define TUN_F_UFO	0x10	/* I can handle UFO packets */
+#define TUN_F_USO4	0x20	/* I can handle USO for IPv4 packets */
+#define TUN_F_USO6	0x40	/* I can handle USO for IPv6 packets */
 
 /* Protocol info prepended to the packets (when IFF_NO_PI is not set) */
 #define TUN_PKT_STRIP	0x0001
-- 
2.34.1

