Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F4B4B20E4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbiBKJBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:01:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbiBKJBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:01:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B543101C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644570103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MUJ3kp9XV1crkiRU1Q1VRzma3f38pwQD2oCOh9SbY8o=;
        b=Z/0Lc0VTas0KJCgpLazGew6CpEqe8UYcEbxAzCnAH+t5QEKi6IJ/pcsaD8IFomMsDBLrvE
        wcMRN35N7xlgEhTSSDNhGm+yDbIfcIY03d0P6iuU3UBA+RY0Y872jFYD05yOttv5tKEF1e
        RJXeZzifd9UrGF24hSn/JkCH3a0iMfs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-byFejv1ZMO-0AwSB_9qPTg-1; Fri, 11 Feb 2022 04:01:42 -0500
X-MC-Unique: byFejv1ZMO-0AwSB_9qPTg-1
Received: by mail-qv1-f71.google.com with SMTP id iv13-20020ad45ced000000b004248c87cc4cso5854824qvb.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MUJ3kp9XV1crkiRU1Q1VRzma3f38pwQD2oCOh9SbY8o=;
        b=m/p0ivtwxeE0nOd5e3+A7aGZNhxeBO22I2JH4gRkZWlL9Cfg89qn7pRo/G0Y61ApQe
         RUKvBMm1c1Ouv1/LLf5FzzxOO2zOaoJdu48TzwLDLMMDo22OZfV3ugkOWAJGd6KlDFoI
         7G79WTVcyAouixPTELFRdbc1mzhhpwedG36yRLypcDQttfsbBRWjurC+zBaXl52ZJCaR
         T818r7hq8EQIywYvGNFX5JnAYM+mCAm705IymgDtwICv4J20DUmB0gb2Y5i66ejxthk8
         h7wlCyRFCAmobjh26nWY7H+3iK1Z1ojAckVoRNtZDEdmam0NSvStiye21XJn8V9GpjGf
         vr+Q==
X-Gm-Message-State: AOAM531OpAThJtqaS953Q2dpdxZS5mAI5v2bSTsFw+GiO/6fMQXPUsdl
        YZct8DGwLXMg005e46bXIrpp8IQuzJ/xqQ2WhKu551qw2jHlPOp3/k9id1LuJaRrFOddnI/Fqq+
        FJLREPqc3t+TXJd5OhVlkg8B2
X-Received: by 2002:a05:620a:40cd:: with SMTP id g13mr235554qko.57.1644570101704;
        Fri, 11 Feb 2022 01:01:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyNuZXoU1YXd7dflX1tLfs7w8jGDkinb/+LSW7pW/yCk8l/jvZYRrAUOMjJt184Nuyt+EK0A==
X-Received: by 2002:a05:620a:40cd:: with SMTP id g13mr235544qko.57.1644570101489;
        Fri, 11 Feb 2022 01:01:41 -0800 (PST)
Received: from step1g3.redhat.com (host-95-248-229-156.retail.telecomitalia.it. [95.248.229.156])
        by smtp.gmail.com with ESMTPSA id p70sm10931673qka.62.2022.02.11.01.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:01:40 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH] block: clear iocb->private in blkdev_bio_end_io_async()
Date:   Fri, 11 Feb 2022 10:01:36 +0100
Message-Id: <20220211090136.44471-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iocb_bio_iopoll() expects iocb->private to be cleared before
releasing the bio.

We already do this in blkdev_bio_end_io(), but we forgot in the
recently added blkdev_bio_end_io_async().

Fixes: 54a88eb838d3 ("block: add single bio async direct IO helper")
Cc: asml.silence@gmail.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
I haven't seen a failure, I was just reading the code to understand iopoll,
so IIUC we should clean iocb->private in blkdev_bio_end_io_async().

Thanks,
Stefano
---
 block/fops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 4f59e0f5bf30..a18e7fbd97b8 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -289,6 +289,8 @@ static void blkdev_bio_end_io_async(struct bio *bio)
 	struct kiocb *iocb = dio->iocb;
 	ssize_t ret;
 
+	WRITE_ONCE(iocb->private, NULL);
+
 	if (likely(!bio->bi_status)) {
 		ret = dio->size;
 		iocb->ki_pos += ret;
-- 
2.34.1

