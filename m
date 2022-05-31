Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D17539668
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbiEaSlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiEaSli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:41:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605F5915A5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:41:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t6so19864534wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yYizjhpptmJ3gJ2nYolv0UobnAZmjN42VSqblJmcmmM=;
        b=61BmzmrhJzkorY5mMUVc/VhaMMSTg/F+8KYmJxWuIUAZkOMXHH3tgrkva4vRthXRoy
         keL/YbreHHmOU2wZ7lk32CPaJh8iIF89S3ZR0/u8ZCv/i8Ma8yZpLAOfRsC55T5D680J
         38Y8ZCQj9sOed9MeMUTp8WqcZD8jk83c2Xy3XpcbRQNjav+mn+i7lXxp1WGzo03aa80Z
         JAPiSRv8ZCIY4l96YskqjXCsxEbCaVTkJz+3xqIh4aeGttzJvnR+S0QdnRX65cNUZbsf
         8L0SMoO6moUlRQIJLBTKO9GOZLuY3NfN/XZz2dVUWKCSo3gXiQ4/dQzXpsv6lOL0gYeL
         jeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yYizjhpptmJ3gJ2nYolv0UobnAZmjN42VSqblJmcmmM=;
        b=xKk+jzMX0Hn0V967LxbERGP/eJ1LgN5eLcH9v8y1G/e9QT8NYmQF1TV5nxOKJG8oA2
         YHqpQwWKyXmILyxIpif1UbWLllTMHQGV6Cf4sl8cfcuMkqtQsbaskLl2zP44oWY8Lazb
         YLNDd87HdNGWFz1rxZPI/9gluZBP+v/wGDhLWfNB0/4J1jjf9zP7YRKVTu9FyGU7YSma
         bXYyo+HmhQhV3ha+FgIs18//Hg75+MruTcMYlHY6LowiCfHQg4ZF5R4cK5TbotwhTewR
         Cn6W/ISyccp6Om/ItCEadw1ROQTXHbcUtf1kKsflSXu09ZKbCVRAFyns8TtCK62JOU0g
         38xQ==
X-Gm-Message-State: AOAM531vUdfnQp4aBcNAi2/sdIO3w5NEwG+gWHHerX/aFjPxcd/I4wIx
        EWDWeX3PYiF/BSruBs/Lqa/2ug==
X-Google-Smtp-Source: ABdhPJyuUBcBs0najrLb47SG8Xhyus+J+Xa0zxKEtakIQBe1mLyq/BSxvQvt28dTSZuREq/UGE4bGA==
X-Received: by 2002:a05:6000:1887:b0:20f:de1d:9fc3 with SMTP id a7-20020a056000188700b0020fde1d9fc3mr37261401wri.111.1654022496004;
        Tue, 31 May 2022 11:41:36 -0700 (PDT)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b497:0:359:2800:e38d:e04f])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c059000b00397342bcfb7sm2831877wmd.46.2022.05.31.11.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:41:35 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     io-uring@vger.kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Cc:     fam.zheng@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH 0/5] io_uring: add opcodes for current working directory
Date:   Tue, 31 May 2022 19:41:20 +0100
Message-Id: <20220531184125.2665210-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides consistency between io_uring and the respective I/O syscall
and avoids having the user of liburing specify the cwd in sqe when working
with current working directory, for e.g. the user can directly call with
IORING_OP_RENAME instead of IORING_OP_RENAMEAT and providing AT_FDCWD in
sqe->fd and sqe->len, similar to syscall interface.

This is done for rename, unlink, mkdir, symlink and link in this
patch-series.

The tests for these opcodes in liburing are present at
https://github.com/uarif1/liburing/tree/cwd_opcodes. If the patches are
acceptable, I am happy to create a PR in above for the tests.

Thanks!

Usama Arif (5):
  io_uring: add rename opcode for current working directory
  io_uring: add unlink opcode for current working directory
  io_uring: add mkdir opcode for current working directory
  io_uring: add symlink opcode for current working directory
  io_uring: add link opcode for current working directory

 fs/io_uring.c                 | 116 ++++++++++++++++++++++++----------
 include/uapi/linux/io_uring.h |   5 ++
 2 files changed, 89 insertions(+), 32 deletions(-)

-- 
2.25.1

