Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B377B58FCD0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbiHKMwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiHKMwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E0C62E68B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660222326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=fZR1rg29jmUTn0ZaHr80FrLXJcO6qark0sdTnOhFYqg=;
        b=fgjuhF2888kixK31DsaF0wU5Nj0zwW1zxD77vCa3yZIztZDsrV9Dop8bSgKm2MzOOGNuks
        ih0TXoLvWZvtps/k3mHtrOfCcOWLTG94PPTSe/ZcPGqDENYrSZ4ogcqIjktt2mvZu8W+iA
        2WFFjii8KXm8smua8Rswf8wTVc+TdTw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-223-KJ7ISjWiPGKlAiCIAeE9lA-1; Thu, 11 Aug 2022 08:52:04 -0400
X-MC-Unique: KJ7ISjWiPGKlAiCIAeE9lA-1
Received: by mail-ed1-f69.google.com with SMTP id g8-20020a056402424800b0043e81c582a4so10912451edb.17
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=fZR1rg29jmUTn0ZaHr80FrLXJcO6qark0sdTnOhFYqg=;
        b=oiwTI4xWY0f+vH2AUOGIFlYyr0NaRCJcsLElSp72Mo0PhniAUSSpKlVV7zBzycP1og
         NVzay/1eNoX04vvFryCnXaNtOW9j+Y48dac0TBaItOryrjgY44mpntkEbrvzPiYd4OcM
         5FzLLmCG7j4CbU+Lj9JmOeDLEAE5Yw506yQG1m3fRAFYUhnMl96rGhGL1oszFNMJtPsK
         XXWCAWHVEnYULFXDd1maSvjEi5SahSunvv09qjVu2yIOfLL8dlUM+07iJ+FmekPxj2Q5
         MeHkziPJCkVMkvOi653dZgDbl3PpsEWCTiOgE5G3ZV9/FXw5vey93YclSYF7TyzdUR0n
         lMXw==
X-Gm-Message-State: ACgBeo1TBW70xi9HzfurazcVxyYQzeXoy3nAla6CFwtUdqstJvQSKsJD
        T14R79XMSsZEMGy50q06GTvxdKCdgFypkFTzl2KDOdmyk4lmKGiFA96XzRK6s8qiWB9Qr0xX3jh
        hRKipwtX/P644fBHi8Sef92smOq2E/+89yBKdDim7/lwTaRtk5IBiG60d4VLQkiBeLxYgDg==
X-Received: by 2002:a05:6402:424e:b0:43d:9d9f:38f9 with SMTP id g14-20020a056402424e00b0043d9d9f38f9mr30995459edb.411.1660222322646;
        Thu, 11 Aug 2022 05:52:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4Uonm4Tt4dUrVuSW7DOj4CixZE71gE99A8Xg5JVQuHVDIdMz6RS86ZeW5EQJ50fie/SzlXCQ==
X-Received: by 2002:a05:6402:424e:b0:43d:9d9f:38f9 with SMTP id g14-20020a056402424e00b0043d9d9f38f9mr30995425edb.411.1660222322396;
        Thu, 11 Aug 2022 05:52:02 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id w21-20020a170906131500b0072ab06bf296sm3424029ejb.23.2022.08.11.05.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 05:52:01 -0700 (PDT)
Date:   Thu, 11 Aug 2022 08:51:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Melnychenko <andrew@daynix.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH] virtio_net: fix endian-ness for RSS
Message-ID: <20220811125156.293825-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using native endian-ness for device supplied fields is wrong
on BE platforms. Sparse warns about this.

Fixes: 91f41f01d219 ("drivers/net/virtio_net: Added RSS hash report.")
Cc: "Andrew Melnychenko" <andrew@daynix.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d9c434b00e9b..6e9868c860bc 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1208,7 +1208,7 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 	if (!hdr_hash || !skb)
 		return;
 
-	switch ((int)hdr_hash->hash_report) {
+	switch (__le16_to_cpu(hdr_hash->hash_report)) {
 	case VIRTIO_NET_HASH_REPORT_TCPv4:
 	case VIRTIO_NET_HASH_REPORT_UDPv4:
 	case VIRTIO_NET_HASH_REPORT_TCPv6:
@@ -1226,7 +1226,7 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 	default:
 		rss_hash_type = PKT_HASH_TYPE_NONE;
 	}
-	skb_set_hash(skb, (unsigned int)hdr_hash->hash_value, rss_hash_type);
+	skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
 }
 
 static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
-- 
MST

