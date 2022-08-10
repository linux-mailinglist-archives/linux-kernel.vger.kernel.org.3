Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A358E9E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiHJJn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiHJJnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3815B5005F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660124632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VtlaRizDRVz5xKTGkF8JZcC+vIs+0Z48fSCCTWvcw2I=;
        b=BDL8blnsdBMBfsHE1BNpEK6s1+Y4D96ijKBCka9yZSScdY8l6SEwhvxsihf7sdxLKGA5wH
        rEq2YL7F79VGBDKYKg97qw6QNvevi3c05S2gCKaH4hnPYOh6auoesI4hk2LjGpduFDxDnP
        kWLxtXjyMCj6LXIkIoXPgL+Orn+q7ak=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-0jGByBNVMP68i_IV_5IYQA-1; Wed, 10 Aug 2022 05:43:51 -0400
X-MC-Unique: 0jGByBNVMP68i_IV_5IYQA-1
Received: by mail-wm1-f71.google.com with SMTP id v130-20020a1cac88000000b003a4f057ed9fso7175182wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=VtlaRizDRVz5xKTGkF8JZcC+vIs+0Z48fSCCTWvcw2I=;
        b=AClCJEKCCDmMwAtnw+b/5M07xzNBvCRZrv/1Z8N2JEKJ403L71wI26jQFJvqXbhJps
         OQR7LVn3VN6M5e0BHlBkZMBhG6KijU97zgWnkkklLfFMfnLlIy1alcDIdcW6UE9bB+oR
         LQPo1aYeT6NJ+B/jXYR9W3+th8BpcXxeoEw2n2OvrImZUufOBTLQvuObhxlqPlz0ZFQZ
         iDfVZOabtOT4cicPyakzunjBXcGHK1ArEY7Zw47RGbf45e2eepmBH2lwL3GCrhzNhyjz
         whvMUPeDG1mVGA372zjNeaMKfeqM3GWWCTX2mt9YjotDf/oc+ALwBJoxvCq0YpoBoMCc
         1nxg==
X-Gm-Message-State: ACgBeo02TIHNzC9RTOBgsPJUIj+m79ZOvXnLA8cFgDBhao2Jdirx9+TX
        iYrgTl4FTlcrZNBQHoTkC9Rdr7244wg5R6vSM3xceX8FA+bd4zV8C6nOyRd1DvqD6vux/V3tZBK
        xR5mzu9BsaS8F+vis37mnjFOR
X-Received: by 2002:a05:600c:4f44:b0:3a5:6de3:8375 with SMTP id m4-20020a05600c4f4400b003a56de38375mr1815822wmq.198.1660124630028;
        Wed, 10 Aug 2022 02:43:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR73NTIQcHhhjgyT7WWLXo220NhOzmLOYriyW/7ugDFMDAUT4z9ZA6kWovCQgVfIpay4scizNQ==
X-Received: by 2002:a05:600c:4f44:b0:3a5:6de3:8375 with SMTP id m4-20020a05600c4f4400b003a56de38375mr1815803wmq.198.1660124629773;
        Wed, 10 Aug 2022 02:43:49 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id q11-20020a5d658b000000b0021e4bc9edbfsm12921743wru.112.2022.08.10.02.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 02:43:49 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 0/4] vdpa_sim_blk: add support for flush, discard, and write-zeroes
Date:   Wed, 10 Aug 2022 11:43:43 +0200
Message-Id: <20220810094347.20449-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
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

The first 2 patches are in preparation and generalize parts later used
by the following patches that add handling of flush, discard, and
write-zeroes requests.

v2:
- rebased on https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
- used dev_dbg() to print errors [Jason]
- moved sector to be 0 checking to another patch and generalized for
  other requests
- modified vdpasim_blk_check_range() to be used also with discard and
  write-zeroes
- added discard and write-zeroes requests handling

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

