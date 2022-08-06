Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8842C58B544
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 13:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiHFLxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 07:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiHFLxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 07:53:01 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395DC13F35;
        Sat,  6 Aug 2022 04:53:01 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f192so4327732pfa.9;
        Sat, 06 Aug 2022 04:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=b/QRNAmR+dRj8tez6CuFsMgvGm1WxN/JAuG774jeys4=;
        b=Xknb4oJjGFrojDDrlDYIe7lM7C5Bt6RsnEguKcHkxOt8buI0Qly2xBN3MWUvq7qEmY
         txZIEL5QrhPo2/xUNdtJvPQnYfx2NW2Me/WzwiqlXvbgutrOWG7iwl5GdnP18fJt8SuM
         A1LAMqK/uG/elY2Krsd69ZRdA++EFfH35z48Ee1iCGoAhHlCEyaQUZfhovkkY9+tTmfx
         Ztu2hdCpT7UdxYoZdCA0Gr6UK1gNWtVoae0ylJbFYTf5q6d3uAPf8UgB4eUTrLT5/+T6
         ZP+UEtRMgwCHYhkV4DEVoq+iRbBBHSsME3R8stK+Owu1N2pslHXuuBz5gP0E1p5Sef+l
         ZP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=b/QRNAmR+dRj8tez6CuFsMgvGm1WxN/JAuG774jeys4=;
        b=3MXT6LAGfdUF+jVFA3IouFboDuMtuce8+9iqIY5sGyp2mNprQK5H7qd7lM9POLI5Op
         fHY4mrLLrja87H4yXhxq1TyVTCp144mCOLFxgS7jTcKLLKAtZufq298MP21gqn6cIf8n
         xdgtBavVLb1bQYylmhSZBw1mnL3N3AvDtaYCozzN0vzoQB43wJgS7atThDwF61+phgdf
         WQC4bPkI08/LvC9t7Jn3PrMuDugJeJWnPwtP2kGlsTsMhphMu3ZGJTXFVc/waX8Mt3MT
         aOQReMryrQFKKx3QK22KOC+JDbvzzp2PO+znhJAP+ZI0VtQkZOUeG8RrI5RLhJZPrRlR
         0CZg==
X-Gm-Message-State: ACgBeo0LAdDc9nvPCGEtA3jWHVwjcRDxZ51mMXWLQ5s00tkJW4Z7lwWL
        BRf6pMOAFheKIgzXHP/V8Uc=
X-Google-Smtp-Source: AA6agR4pFL4kQ0yfPuoJrM9EQ9XudHJcQQRFH556aivnjPFcfGYA55AUtIT7ew/YtsmOhozjowCp/g==
X-Received: by 2002:aa7:8f13:0:b0:52d:fe17:ce11 with SMTP id x19-20020aa78f13000000b0052dfe17ce11mr11080360pfr.26.1659786780416;
        Sat, 06 Aug 2022 04:53:00 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b0016c57657977sm4954649plk.41.2022.08.06.04.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 04:53:00 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/1] loop: introduce LO_FLAGS_NODEALLOC
Date:   Sat,  6 Aug 2022 19:49:42 +0800
Message-Id: <20220806114943.8754-1-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch gives userspace ability to prevent underlying file of loop
device to be sparse. Currently, if loop device is 'trimmed'
(BLKDISCARD), then underlying file will always become sparse and disk
space freed. This behaviour is good for thin provisioning but not good
for preallocated disk images. This patch introduces LO_FLAGS_NODEALLOC
flag, which will write zeroes to underlying file instead of punching
holes when BLKDISCARD is requested. Thus reducing file fragmentation of
preallocated disk images and improve performance.

I will also submit patches to util-linux to provide userspace support if
this patch is merged.

Best Regards,
Zhang Boyang 


