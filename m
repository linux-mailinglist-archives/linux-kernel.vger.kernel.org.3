Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001C8505B06
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbiDRPbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344875AbiDRPaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8102956C36
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650292751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VRx1EMRQlbrP9hE/WVMMi/xLag40bmMY2mKv4xrHQ/c=;
        b=htb7ArwwHwOWx0nRMqsDi/wI4vYp+zPRXhB+QyRaItqa1mj217F6ToggkcrIPRRzweAKjD
        2yFilephRE9roL22TfREL0DnFZleN0xpet4NBD3OBxf2pIdkJW0pUA4RuU7+ekJ8n0BZjF
        8aWkXOn7fpB/G7jx9C6c1KLvRKr9obk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-MC-6aqhSM9CvtiybJgmrjg-1; Mon, 18 Apr 2022 10:39:10 -0400
X-MC-Unique: MC-6aqhSM9CvtiybJgmrjg-1
Received: by mail-qv1-f70.google.com with SMTP id 33-20020a0c8024000000b0043d17ffb0bdso12283004qva.18
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VRx1EMRQlbrP9hE/WVMMi/xLag40bmMY2mKv4xrHQ/c=;
        b=iAAZTEW8YgKoT+Hu5raxKVcnlSAilNteUZdbv+GdPfDRLPtiRiz5pSVEvEKcWZ7DeY
         rvSvv2dhrOEtx3bPxXMW97NTc1E5RHSsaaVfctzcAtOUS4OT6zF2y2lFn0b9EW/WS/rv
         3h8e0aqpIV3zpNIxc4B1me9XdYhT0yadO/OajDmn5np1HMRCAOzGUq/ZIBgEoelNXXfI
         F79vzmDEiBX848EXcPpNxO9ALMUt2UYHaYNlEmW152/+/ft+WwjfE3cpnuBWx+01FkJS
         +NuPV7toz/VM9u7rq+A+4MAP2tww7H2+dqTaHT4XpccNh22PqN4A5HszPqTpONMi6ZiZ
         s6mQ==
X-Gm-Message-State: AOAM531u3UT5awWwnRDlZh0Rpfg0BwRGmJsj2onZ7jlpCq7CxGuNk7I9
        GuLDubSoCF2hqHbtBXhArGyvvuJwmeLbUe9j96JrXV00w8J4bJjPlTkAFYfJLQAq2cafUW4bfE7
        Kjmsliz9rZqKS+H4hP/dePx2U
X-Received: by 2002:a05:622a:17c9:b0:2ef:c9bd:b8a2 with SMTP id u9-20020a05622a17c900b002efc9bdb8a2mr7286948qtk.246.1650292749869;
        Mon, 18 Apr 2022 07:39:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDftJOOh6eAAbvnnzw+gQdt0tgXgfA0SPB6SgNOxetFY+nyFKgBqNdtYZG6uiyj4bxVpQafQ==
X-Received: by 2002:a05:622a:17c9:b0:2ef:c9bd:b8a2 with SMTP id u9-20020a05622a17c900b002efc9bdb8a2mr7286932qtk.246.1650292749688;
        Mon, 18 Apr 2022 07:39:09 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a16b100b0069eb1eb06b7sm590798qkj.131.2022.04.18.07.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 07:39:09 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        jakobkoschel@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] USB: omap_udc: clean up comment
Date:   Mon, 18 Apr 2022 10:39:06 -0400
Message-Id: <20220418143906.475932-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling replacement
reactiviting to reactivating

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/gadget/udc/omap_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 2d9815dad2ff..1dab74577ae2 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -1467,7 +1467,7 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
 			if (!udc->ep0_in) {
 				stat = 0;
 				/* read next OUT packet of request, maybe
-				 * reactiviting the fifo; stall on errors.
+				 * reactivating the fifo; stall on errors.
 				 */
 				stat = read_fifo(ep0, req);
 				if (!req || stat < 0) {
-- 
2.27.0

