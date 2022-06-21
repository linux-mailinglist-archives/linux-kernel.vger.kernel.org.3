Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C66553773
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353771AbiFUQJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353761AbiFUQJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16E8B2D1C2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655827744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9ILEoqsZx+2myJVQi86gTVEQaPIoJy1nmnDc84Xu+Qo=;
        b=NysyxcsBRZ/f3IjprA7dQYAjbz9a2hn2Ak3INlaC5TijwHSaVcRlQdB7z3I70oloLeTffY
        on2RXqFr/yIjR/MzsEbvEC0R4n/pp8y3vjTkFBwVRTERT6w4+uIrMyC/oxBJSJXGlOFBux
        HxhlcgUB9oiBi9u4/yggH/Gdf2oGGBc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-aq5gsZDWOPCYfZ7DwSlP-w-1; Tue, 21 Jun 2022 12:09:03 -0400
X-MC-Unique: aq5gsZDWOPCYfZ7DwSlP-w-1
Received: by mail-wr1-f72.google.com with SMTP id i16-20020adfa510000000b0021b8e9f7666so1763153wrb.19
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ILEoqsZx+2myJVQi86gTVEQaPIoJy1nmnDc84Xu+Qo=;
        b=41AjLJlXp4+YWnf+JFQ7pSlE+5hMgRdRXGYyvKmcMw+fRs2X1Xb9J2cw1ziq2DzMSP
         xnJArCgcDbsGPJ4PChLWyDd5onhTpdhAZ/M8081K60FtmzLEhwaJpcV8M2UEd4KOE7UW
         5K4Bt0qN/c56jTqfg73qjEhBei22Wv7MBZlxrDHnxnN0evGuMCI0wOKcsJFrjOcsc3wP
         hE/lak49ai6mfu9uMybrnhl+cKMqzHiOIaq+DQiN4NqaHGUvxjZ0kAU4N66zBVHiPKvv
         Rcs6dbXga6faIZ2YTiBy2cdLw+Jse4KgQS2vdBuSf8nLZmjD9wcn/+rvAnu2tiSNNlrO
         5TKQ==
X-Gm-Message-State: AJIora9YKFmnKrdl94vC0Xm+U+1fQJSzlXbaSoQpdfHNG4DcDhD22Zjn
        lgQ6PWUOW7OXOI2ZsAWDLl4YW3rKHv8JowcXj/gr0v++jQA5kQlYbLwFBPayRaZIIJF0j7OFvCG
        s2A06wqNVw6p06aW0hfBSVSxX
X-Received: by 2002:a7b:cd1a:0:b0:39c:4133:ade7 with SMTP id f26-20020a7bcd1a000000b0039c4133ade7mr30341518wmj.111.1655827742347;
        Tue, 21 Jun 2022 09:09:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u5ULEJ6eMdX0D3UH7W5nqFcJOjZBZzUz4qpSBaU+tC8IeUMaGk2dezobQcH3CZWJvYsom4Sg==
X-Received: by 2002:a7b:cd1a:0:b0:39c:4133:ade7 with SMTP id f26-20020a7bcd1a000000b0039c4133ade7mr30341492wmj.111.1655827742111;
        Tue, 21 Jun 2022 09:09:02 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-40.retail.telecomitalia.it. [79.46.200.40])
        by smtp.gmail.com with ESMTPSA id ba7-20020a0560001c0700b0021b903a018bsm6531560wrb.92.2022.06.21.09.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:09:01 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 0/3] vdpa_sim_blk: several fixes for the vDPA block simulator
Date:   Tue, 21 Jun 2022 18:08:56 +0200
Message-Id: <20220621160859.196646-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches essentially limit the possibility of the guest
doing a DoS to the host.

The third makes the simulator more correct (following what we do in
vdpa_sim_net) by calling vringh_complete_iotlb() in the error path as well.

Stefano Garzarella (3):
  vdpa_sim_blk: use dev_dbg() to print errors
  vdpa_sim_blk: limit the number of request handled per batch
  vdpa_sim_blk: call vringh_complete_iotlb() also in the error path

 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 49 +++++++++++++++++++---------
 1 file changed, 33 insertions(+), 16 deletions(-)

-- 
2.36.1

