Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328FB58F934
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbiHKIgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiHKIgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48386792D8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660207000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FWJ1TtCFzQxMqrkhZVnYiwTdjQdpAimD5051fxwruHM=;
        b=P0l8IcjKj8SQpZidHVy96URGsxYpVpuwuGg3efOkPruzVdEJkvh/dt30rivhLmIBBPR0Ta
        bidv8FqZZhzkcVZfkt94DmCi7G89PrOHhh+JjYErzwiW5KDsqUa8P0ZzPbw5la7k2m3gTt
        Twl624xjVs3jRCaYir0Ft38ZDz0MigA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-286-SJuraTCzMmC8NN2FtTSx1Q-1; Thu, 11 Aug 2022 04:36:38 -0400
X-MC-Unique: SJuraTCzMmC8NN2FtTSx1Q-1
Received: by mail-qv1-f70.google.com with SMTP id oo27-20020a056214451b00b00477249248e2so9016142qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=FWJ1TtCFzQxMqrkhZVnYiwTdjQdpAimD5051fxwruHM=;
        b=TxGnhWCI8xadqSICJrf1UJuqvwFXH2c0ok6zwqGvr/Ep6x19pR6hen3RV9r0gs8dOz
         MIw64OANhjEzLCjqLq3LIG3/9qF9rUnEvKpwbEOK4TaEFAwI2319faeByllg7+zuwHvZ
         4/CMCoesrcTA8aWggrxUk5Qfu8OXJ1TvCPF74KBMMPTMa3kceUoDTGq4mc/4sfaZda15
         zPtRhjgilwKiCTcQxN1MXYXRGxmXYPmRw8Bgn/jYITvz0RmfwMfGGzdDhsoI9SlTi/W8
         cQ6nz0TW/TFp7GgpJaa+sMJfXGChAcSL4/LiI7yQpRinh7xZzU7boOJ0VX/yk7QrL7tl
         XCLw==
X-Gm-Message-State: ACgBeo1aNC2neZI56/uI6G3reS8JDYgcaLUqwZCtznwuISD1DDAN9BgT
        PZdF4I5n8e5SSMX1tSk27gQ2ZW7+PA8qDGWodnem6upsLn34mLI/H6bHkG0WAoriRQN7+n5Inre
        odOlOQAbl/j2kswWKpMu2I6DW
X-Received: by 2002:a05:620a:1903:b0:6b8:c90d:c586 with SMTP id bj3-20020a05620a190300b006b8c90dc586mr24032791qkb.751.1660206998120;
        Thu, 11 Aug 2022 01:36:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6HmlG9mm3nf92dLCuVNjWrcJaBVeQSRP85eCW0n/1qzGsVdE31m7ThSf9P9hFhBWfg3fK4iQ==
X-Received: by 2002:a05:620a:1903:b0:6b8:c90d:c586 with SMTP id bj3-20020a05620a190300b006b8c90dc586mr24032785qkb.751.1660206997914;
        Thu, 11 Aug 2022 01:36:37 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id ga25-20020a05622a591900b0034361fb2f75sm1343083qtb.22.2022.08.11.01.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 01:36:36 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 0/4] vdpa_sim_blk: add support for flush, discard, and write-zeroes
Date:   Thu, 11 Aug 2022 10:36:28 +0200
Message-Id: <20220811083632.77525-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first 2 patches are in preparation and generalize parts later used
by the following patches that add handling of flush, discard, and
write-zeroes requests.

v3:
- fixed clang issue reported by kernel test robot <lkp@intel.com>
- used le*_to_cpu() to access virtio_blk_discard_write_zeroes fields

v2: https://lore.kernel.org/virtualization/20220810094347.20449-1-sgarzare@redhat.com/
v1: https://lore.kernel.org/virtualization/20220428151242.213824-1-sgarzare@redhat.com/

Tree available here:
https://gitlab.com/sgarzarella/linux.git vdpa-sim-blk-flush-discard-wz

Thanks,
Stefano

Stefano Garzarella (4):
  vdpa_sim_blk: check if sector is 0 for commands other than read or
    write
  vdpa_sim_blk: make vdpasim_blk_check_range usable by other requests
  vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
  vdpa_sim_blk: add support for discard and write-zeroes

 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 127 +++++++++++++++++++++++----
 1 file changed, 111 insertions(+), 16 deletions(-)

-- 
2.37.1

