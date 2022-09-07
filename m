Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFF75B0454
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiIGMwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiIGMvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:51:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D510BBA9C4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 05:51:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bp20so19752996wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=d8usAzUq61FHCkycIEkOgq4s+Z72vQd7Ep2+wzeLNx0=;
        b=tc0mdEtni7/nOq0fIaWQgH+uEG30vyB66b9/WsPVyH+gpue1NXrm7kTQX6pgN44qpZ
         xWjgVI7c8uWhnA8ZQF+pgyRHzV7La780nYJuaDQMjcD901EyChb/dkNRdd/j5D/Yj2IO
         3PZV4/iBDOXKb7/dWHm75vyV1yfH4WYWLKJ6mi1LUMobFHRNNOup1DdYZhwzAgpXWATi
         FDDFX4A0//QRgbyT0kSt91Rx+u7zIEg/B7j0gvI3Secnir2M4KWuebK2vCq0Pp16+9DB
         s3OallXrqWazBet592eeqOHspb5iokojsQO1b99z03rbYc6kghqFqQ733GH+HcGfr3ul
         MEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=d8usAzUq61FHCkycIEkOgq4s+Z72vQd7Ep2+wzeLNx0=;
        b=zZTUi15i6Zs49w4ZhInqrneRpWNh4enaqUGsYnO/0/14Fbm1gAS+3q4KXlMs1zopHx
         Nc8s3gcIJEC676Eq1DANEGrdnrUc+JzaCBIdpNkkZ6EJWF/JqSlFZ99FdOOrRbyA1ABm
         df3BCG14/66dYxEKQazZll/EnWmV1g+hCcmdhJth7IdMH3DQCuE3KYK4wWL2hSyh6vyi
         Q1oJO+MOe7rDCS3x9pHbuKurhMnTOBVNi/lcAfiV+nixoUGM2v6YBGlziEDEFaEKyCNj
         qKyOZw3Fi1J6koHEUpJ1lTVtSk9Xi45MXC8pLxk/F7/99uZlKkOLDUNbMDwABX5MjwYB
         hhHQ==
X-Gm-Message-State: ACgBeo2af4Rx15Ic9d3kp/UL5cLQuQPkWT//rQ0gjRthFCSg017l26sw
        RdzG8AMRTn8D36YFvLUBSZtSrQ==
X-Google-Smtp-Source: AA6agR59wHMg1sPtOCvnjt0/QqpolL8iqEduFZMHwOY1R/xf2tHBzq16FwMtqjvJ7fJ6vbfLc3TvYQ==
X-Received: by 2002:adf:f6cf:0:b0:228:9b2f:c305 with SMTP id y15-20020adff6cf000000b002289b2fc305mr1971325wrp.427.1662555096441;
        Wed, 07 Sep 2022 05:51:36 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm11480001wrc.41.2022.09.07.05.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 05:51:36 -0700 (PDT)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     edumazet@google.com, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        jasowang@redhat.com, mst@redhat.com, pabeni@redhat.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org
Cc:     yan@daynix.com, yuri.benditovich@daynix.com
Subject: [PATCH v3 4/6] uapi/linux/virtio_net.h: Added USO types.
Date:   Wed,  7 Sep 2022 15:50:46 +0300
Message-Id: <20220907125048.396126-5-andrew@daynix.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907125048.396126-1-andrew@daynix.com>
References: <20220907125048.396126-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added new GSO type for USO: VIRTIO_NET_HDR_GSO_UDP_L4.
Feature VIRTIO_NET_F_HOST_USO allows to enable NETIF_F_GSO_UDP_L4.
Separated VIRTIO_NET_F_GUEST_USO4 & VIRTIO_NET_F_GUEST_USO6 features
required for Windows guests.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 include/uapi/linux/virtio_net.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 29ced55514d4..5156a420564f 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,10 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 #define VIRTIO_NET_F_NOTF_COAL	53	/* Guest can handle notifications coalescing */
+#define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
+#define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
+#define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
+
 #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
 #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
@@ -130,6 +134,7 @@ struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
 #define VIRTIO_NET_HDR_GSO_UDP		3	/* GSO frame, IPv4 UDP (UFO) */
 #define VIRTIO_NET_HDR_GSO_TCPV6	4	/* GSO frame, IPv6 TCP */
+#define VIRTIO_NET_HDR_GSO_UDP_L4	5	/* GSO frame, IPv4& IPv6 UDP (USO) */
 #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
 	__u8 gso_type;
 	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
-- 
2.37.2

