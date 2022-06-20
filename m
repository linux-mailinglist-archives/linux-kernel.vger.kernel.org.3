Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49060550F97
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 07:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbiFTFLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 01:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiFTFL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 289525FA5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655701884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KxKn6abF8VEXTTv8fBbGkXyKe1UQvimMwlU2U7O+wlA=;
        b=b19/SCx5P3bTioa7iD5tr8Gv7yTNUEK3hCsgTs34Mk9SCZEYMzpwLsiaJ4pMve9JIEporT
        yohVxlk3mSAjBbQNW4Bjst5yzvbfC68aTRUaQI26jePFZ52YABffZBUhz+seASQUIIguAE
        YZ1UAfGr9Zks5uA8y9Yvab3uvCYVdTY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-0oX7z3cqO2a1DGbkoNIIgQ-1; Mon, 20 Jun 2022 01:11:21 -0400
X-MC-Unique: 0oX7z3cqO2a1DGbkoNIIgQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3095F101AA45;
        Mon, 20 Jun 2022 05:11:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-16.pek2.redhat.com [10.72.12.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05601C23DBF;
        Mon, 20 Jun 2022 05:11:17 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mst@redhat.com, jasowang@redhat.com
Cc:     davem@davemloft.net, kuba@kernel.org, erwan.yvin@stericsson.com
Subject: [PATCH 0/3] Fixing races in probe/remove
Date:   Mon, 20 Jun 2022 13:11:12 +0800
Message-Id: <20220620051115.3142-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

This series tries to fix races spotted during code review for
caif_virtio in probe() and remove().

Compile test only. (I don't have setup to test them).

Please review.

Thanks

Jason Wang (3):
  caif_virtio: remove virtqueue_disable_cb() in probe
  caif_virtio: fix the race between virtio_device_ready() and ndo_open()
  caif_virtio: fix the race between reset and netdev unregister

 drivers/net/caif/caif_virtio.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

-- 
2.25.1

