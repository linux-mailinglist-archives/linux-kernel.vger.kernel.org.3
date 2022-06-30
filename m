Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62179562420
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbiF3U1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiF3U1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B96053D48C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656620832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=B3cZCUIF3lnhc5FF1faZXpJlZvOkKmHLoTPPOnd8z5Q=;
        b=deGcGhyuGQFUbgrhGjO61nJOz/MBbkWudsIKoaIWkgdcxyai4vvYCtKx/GfQgdDmZZTmyX
        P7rDJ9yoFg6L5lTMib4gguPxWdAuegMqltk8C+pOYfJuaFwVUrzcH/ras0slCi0IAhiU1H
        t8EQmY2IHUjQNIeDSWQaPx8J4PAJrzU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-XMTnXfYmNm2AUdEwe45u9A-1; Thu, 30 Jun 2022 16:27:11 -0400
X-MC-Unique: XMTnXfYmNm2AUdEwe45u9A-1
Received: by mail-wr1-f69.google.com with SMTP id o21-20020adfa115000000b0021d3f78ebc2so15720wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=B3cZCUIF3lnhc5FF1faZXpJlZvOkKmHLoTPPOnd8z5Q=;
        b=MbrAI8nF/+hlH1GgiTCpUgH6rur7drbgBujemhlIV4cOSNxFWvPX5fWdRxJxC7weUW
         jJoQf9x2gWOpuAo2ixbQOlh1ZtLIZdgqWspTCzkVCuFoTOyxPwhrG1599RW9CLQ2atuT
         YDQ+5W9QsLDI7eLw2rRU9XRE4iP7v/NKBQ2scpDZO+gqmKm4p8kgSou2LDmCkHKvYgC8
         +/kgl3oivmE/nZSd2c/sXTbSvNzcpo+EmPHJE0iByJogyTK1faPCUU1RWqRlgUJDB85X
         8QSQbJMktUiKC0LtwdwlUvUISu3LB+1bwqpE1KSY/m9iW+J9YKT+vqf29+gq5u5xb7Zt
         oJOA==
X-Gm-Message-State: AJIora8Z3Mbayxn3ATBHhAk65XYqIKOBsPnFu5t1jqBoiJJPN7yyGSlc
        R1gaXUKzK55aAq57vkgwbGm+qhuUg1/nCIyoKJ9LaMzHXX09HgKb+OO3ONdm1CIdZMzABYddWt9
        eGEJc4ge6zZH8M4s55HXk7LPkNg8GZwZOOnv1Vlc64qaA9BmnMHwpfLaaVYXUXQwQ92Lxlw==
X-Received: by 2002:a1c:4405:0:b0:3a1:886d:c33c with SMTP id r5-20020a1c4405000000b003a1886dc33cmr1979080wma.200.1656620830421;
        Thu, 30 Jun 2022 13:27:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vN3emLAhFi79LfaVq/yG2oz3uypiyXu0Rea6T98wAbOL8ANlXOGgUJAGGt8l7pf/DJEfTVhg==
X-Received: by 2002:a1c:4405:0:b0:3a1:886d:c33c with SMTP id r5-20020a1c4405000000b003a1886dc33cmr1979048wma.200.1656620830194;
        Thu, 30 Jun 2022 13:27:10 -0700 (PDT)
Received: from redhat.com ([2.55.3.188])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d448a000000b0021b8c99860asm20440516wrq.115.2022.06.30.13.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 13:27:09 -0700 (PDT)
Date:   Thu, 30 Jun 2022 16:27:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: virtio_bt: mark broken
Message-ID: <20220630202700.18187-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issues around the driver are not addressed
- issues around device removal:
https://lore.kernel.org/r/20211125174200.133230-1-mst%40redhat.com
- no spec
- no QEMU support

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index e30707405455..c5bb105416bd 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -435,6 +435,7 @@ config BT_HCIRSI
 config BT_VIRTIO
 	tristate "Virtio Bluetooth driver"
 	depends on VIRTIO
+	depends on BROKEN
 	help
 	  Virtio Bluetooth support driver.
 	  This driver supports Virtio Bluetooth devices.
-- 
MST

