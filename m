Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD8C5622E8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbiF3TQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiF3TQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AB663F894
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656616581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=YfIy+4gvd/lbZdQIcXGuL2bNS8ZcX5l36dLsXmKY+tU=;
        b=iwMgEOlUX8L90wSW5ML2c+jxFL467DISevGlgdEVxG6umXUd5r85lFAV1K+cbbgqbxL9Zh
        dcAgBJQ9lHnaXSy2SIhwXPQPO+2+bmMeyokuUJQk1by3sQ/f2FB4OS7hFfFoATCQDVPgkS
        z8JAEHNQ0MiVvSF5n3HQDou47O+s9dk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-G-EeYRCiOUKvcqNuoM-IWw-1; Thu, 30 Jun 2022 15:16:19 -0400
X-MC-Unique: G-EeYRCiOUKvcqNuoM-IWw-1
Received: by mail-wr1-f70.google.com with SMTP id a1-20020adfbc41000000b0021b90d6d69aso3302237wrh.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YfIy+4gvd/lbZdQIcXGuL2bNS8ZcX5l36dLsXmKY+tU=;
        b=dQDOt8yLuV81xjOHciMSaEd/TQHSykMpAvqlg6EfxAYR15dxvg0hxJjU8gKogwGfU5
         /Z1vw0SksdnRvfAdKppIqwH4hNSNJStxRDPJQHEAanEY1njPkPJ6ZJljiLUhymPwgAEk
         vDT7NuXI7Hys2IlfncVUk6mP5upiXPa9raqIE5Zln0q8R+6XQ4FlGAkoyfAArZpUEUvF
         Xu/OqPpibDMMSGv40ID4ci5QIOCmqoTh+KJiZlBt88z0kUTPhOAmqIZDiyMc6UZNRU2w
         XJTqQov6mTRVT8M3vmfqtXamYXapUp38fwZCyMPjRpgtTw7IIcTzQIcez1is+zfhDx/o
         LQPg==
X-Gm-Message-State: AJIora+icjnpPdjAvGVbFvDFXPLy5QIDND/ZEMUsls9f3fOm/j9A1z2J
        /rRf4T4UHlSaoESG/+j6Qk/0OmWcGkquIQ/LTx3JvYuL0Edb+r0Ej6W+sZvHj1eFN6yDIJCu3Wm
        Ua0rIbwczfcXLcaCs7eMx8578vwJla/kix/MYDmDls+paMK8RVCcJ0VWRrKMQ32CvC3wkgQ==
X-Received: by 2002:a5d:584e:0:b0:21c:e4db:35e with SMTP id i14-20020a5d584e000000b0021ce4db035emr9821074wrf.192.1656616577978;
        Thu, 30 Jun 2022 12:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uIKmZuYR4ZzwFuRRqKsirvt0WLtvLcOYn6IIXl1lJjoxm21cIWDoqwMpYY9h/B+uEIpeJSmA==
X-Received: by 2002:a5d:584e:0:b0:21c:e4db:35e with SMTP id i14-20020a5d584e000000b0021ce4db035emr9821043wrf.192.1656616577714;
        Thu, 30 Jun 2022 12:16:17 -0700 (PDT)
Received: from redhat.com ([2.55.3.188])
        by smtp.gmail.com with ESMTPSA id j19-20020a5d6e53000000b002102b16b9a4sm20128454wrz.110.2022.06.30.12.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:16:17 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:16:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio: VIRTIO_HARDEN_NOTIFICATION is broken
Message-ID: <20220630191559.16738-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option doesn't really work and breaks too many drivers.
Not yet sure what's the right thing to do, for now
let's make sure randconfig isn't broken by this.

Fixes: c346dae4f3fb ("virtio: disable notification hardening by default")
Cc: "Jason Wang" <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index e1556d2a355a..afb9051e0125 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -31,11 +31,12 @@ if VIRTIO_MENU
 
 config VIRTIO_HARDEN_NOTIFICATION
         bool "Harden virtio notification"
+        depends on BROKEN
         help
           Enable this to harden the device notifications and suppress
           those that happen at a time where notifications are illegal.
 
-          Experimental: Note that several drivers still have bugs that
+          Experimental: Note that several drivers still have issues that
           may cause crashes or hangs when correct handling of
           notifications is enforced; depending on the subset of
           drivers and devices you use, this may or may not work.
-- 
MST

