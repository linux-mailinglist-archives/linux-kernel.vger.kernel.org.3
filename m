Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A4C5A82CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiHaQN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiHaQNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:13:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98982D3E41
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:13:21 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 78so404750pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2/XdbCrUv8gzI+JX2k2NXC+D9E3l4e2SIhgqVmL688s=;
        b=f5QU2TxsaHqq0+Tv62FC10+qGUJsEr8NPuARb4jmb+PSyWWm9/cTxOfwL9rqklEsiU
         lpOIU+hGzwSvrbyPaof+oTZoi+3fafUymzWJOVR0+d/DTc4QNFRmkYysCx48cajI9NVg
         vBP2omKhKD5vZViL7dIgWNZ+DrdkGTLeP3UHvdI4rtCyWGeR/szG8k/vysZ9Az9U1dqU
         4U5zW5knps6TcOVneBucynP2m4TBVEdlHkI2gyupJPm8qmt/ANwU7XPMQTDIEU4/0En6
         dPySy37hkxmFMrPlu8oqHrFGRrT5GbVT50pBucuqmbrh4FUGI81rrbHMBE6q7jg6bToI
         Bepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2/XdbCrUv8gzI+JX2k2NXC+D9E3l4e2SIhgqVmL688s=;
        b=k1BYpbh1uBY7sODma1i6+F+q8OtTCJ5k6ygmcDyp4LfjFjxYhmSzt819buliXdJcFn
         bmDee9OipOo6gfwzk4f51TQqZkxEse4RI+iM36jc0C6iKSXkKLvyOCgGqPdoJTP1tyCu
         PgaCu05XnAVe9u8ZEDSH7TLoVz1iLrtfDRM5Dh17TuugJs5pUt+WGHr5fvuObnSearmI
         mTlM3izFnbHnpCw6UPY2VDtlOAu3AafX4NL3q2/B8y4zcJZ7O0vBw/awGLL6gUxiHGnB
         YMWDIjnuNqXrMsIXOrP1v1e9ccwQlmUV0NTM/tkawZwSezRfsyZPXz+wSK8SDNQlNt1g
         cSSw==
X-Gm-Message-State: ACgBeo1GvYZXvYx0+gfZ6qLXh8tLiOBa8xsLsXmoWYRaWWB/hP1RR+zK
        RiLHRMCiS3vZ1EgOv7u/Vac=
X-Google-Smtp-Source: AA6agR4g7ANCCZnZLbqBt1B/FVTEl7FACQ3ukgyLFuVCEsDq1UeSAGPQljKMq2loqOHwgS+5Q1prxA==
X-Received: by 2002:a05:6a00:2918:b0:535:ea9:791a with SMTP id cg24-20020a056a00291800b005350ea9791amr27095438pfb.54.1661962400574;
        Wed, 31 Aug 2022 09:13:20 -0700 (PDT)
Received: from localhost ([36.112.195.70])
        by smtp.gmail.com with ESMTPSA id c7-20020a624e07000000b0052d417039c2sm11439458pfb.133.2022.08.31.09.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:13:20 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        Anton Altaparmakov <anton@tuxera.com>
Cc:     akpm@linux-foundation.org, chenxiaosong2@huawei.com,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com,
        18801353760@163.com, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2 3/3] ntfs: check overflow when iterates ATTR_RECORDs
Date:   Thu,  1 Sep 2022 00:09:38 +0800
Message-Id: <20220831160935.3409-4-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831160935.3409-1-yin31149@gmail.com>
References: <20220831160935.3409-1-yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel will iterates over ATTR_RECORDs in mft record in ntfs_attr_find().
Because the ATTR_RECORDs are next to each other, kernel can get the next
ATTR_RECORD from end address of current ATTR_RECORD, through current
ATTR_RECORD length field.

The problem is that during iteration, when kernel calculates the end address
of current ATTR_RECORD, kernel may trigger an integer overflow bug in
executing `a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))`. This
may wrap, leading to a forever iteration on 32bit systems.

This patch solves it by adding some checks on calculating end address
of current ATTR_RECORD during iteration.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/all/20220827105842.GM2030@kadam/
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v1->v2:
 * Add check bounds on ATTR_RECORD's length suggested
by Dan Carpenter.

 fs/ntfs/attrib.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index cec4be2a2d23..a3865bc4a0c6 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -617,6 +617,14 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
 			return -ENOENT;
 		if (unlikely(!a->length))
 			break;
+
+		/* check whether ATTR_RECORD's length wrap */
+		if ((u8 *)a + le32_to_cpu(a->length) < (u8 *)a)
+			break;
+		/* check whether ATTR_RECORD's length is within bounds */
+		if ((u8 *)a + le32_to_cpu(a->length) > mrec_end)
+			break;
+
 		if (a->type != type)
 			continue;
 		/*
-- 
2.25.1

