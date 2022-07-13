Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFECB573CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbiGMS7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiGMS7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:59:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FB62B606
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:59:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso5256920pjc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TF6JfL8HwFXCv9uhSvztKtDwf6D+MErv31jrxf8ljT0=;
        b=qX8eOIm+LTeuNE4ufbbTlT7kyUNHmpspnllvJhUqslC72sE0d/MBy6/V1Pw8ZLlIq4
         7LuhiQtGG0lWzwB+fnpBDbdpSr9k3Mt9ppfK1v4o/ovjaju98CLryid+Q9sqgDhP2LQR
         nUKhzNtRi0Sp5X1LiXOMIUgavV3DpfvwZ7pWu0bu7c76pQ5swInjNiM3rsPHECozWV1Q
         kPsqC+bbwWGHL7isoaG3fS8Jj2vGHGkQzPqPZP/M61bAcjVj8mmuerB/+p103K8Lli20
         IkLVsY6c2h2Ni4QWqTMXEqrDbC4Qvi4Mg2wU4j6vHkthUY9AViL5jbwH5IjeCWrXPclw
         La5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TF6JfL8HwFXCv9uhSvztKtDwf6D+MErv31jrxf8ljT0=;
        b=bQzaRf2CJpZjaDKmIK3oClVq7l3YZFMKV9orllJY7CqPN1kvjPgjQRWb+sClrCDCw3
         8oe7R1zjOhHLVEP89MVLgd5Rl2qGBPY+n/vRmmRoF6AIJoTYqpvU0bx42wQqFNaRMzud
         MSJ5NEt0JFroDaeBtNQwfhB6n12EMg9jXApU9RWN/9OVa9PCvLsxcOM1i2oKXgR6vKCp
         5t9Za4AgkJH91oQ/V+kCIBX1a+PEV2UuTl8wQeZ/vVyi+ekzRtu6hqZ4upN4/0Ak9Yy4
         EQ3uPHd9fI1nGcHPBNUzCiHKdmGt5WC1q0idhc/0R9JifcoU4AoQ060TM/U7pNhqnR5p
         8Hrg==
X-Gm-Message-State: AJIora9Vp+sKs1WS1O9fz11bH9gKGKbRukky6rnAeHSQs3Jc7eXr3hbO
        o5K+vaFB+hJ9AUrKZT1ZJizjjA==
X-Google-Smtp-Source: AGRyM1ugyZyaw8ZVZQ0VDS32HO3APeMfGi1zf+F+OtEp0dVUg6fCpM8E5H+LBiXErsJsKumJkGkmmQ==
X-Received: by 2002:a17:902:d588:b0:16b:fbd1:9f53 with SMTP id k8-20020a170902d58800b0016bfbd19f53mr4482864plh.156.1657738782507;
        Wed, 13 Jul 2022 11:59:42 -0700 (PDT)
Received: from desktop.hsd1.or.comcast.net ([2601:1c0:4c00:ad20:feaa:14ff:fe3a:b225])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b0016be6e954e8sm9228080pll.68.2022.07.13.11.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 11:59:41 -0700 (PDT)
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com
Subject: [PATCH] ext4: fix kernel BUG in ext4_free_blocks
Date:   Wed, 13 Jul 2022 11:59:04 -0700
Message-Id: <20220713185904.64138-1-tadeusz.struk@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported a BUG in ext4_free_blocks.
The issue is triggered from ext4_mb_clear_bb(). What happens is the
block number passed to ext4_get_group_no_and_offset() is 0 and the
es->s_first_data_block is 1. This makes block group number returned
from ext4_get_group_no_and_offset equal to -1. This is then passed to
ext4_get_group_info() and hits a BUG:
BUG_ON(group >= EXT4_SB(sb)->s_groups_count),
what can be seen in the trace below.
This patch adds an assertion to ext4_get_group_no_and_offset() that
checks if block number is not smaller than es->s_first_data_block.

kernel BUG at fs/ext4/ext4.h:3319!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 337 Comm: repro Not tainted 5.19.0-rc6-00105-g4e8e898e4107-dirty #14
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
RIP: 0010:ext4_mb_clear_bb+0x1bd6/0x1be0
Call Trace:
 <TASK>
 ext4_free_blocks+0x9b3/0xc90
 ext4_clear_blocks+0x344/0x3b0
 ext4_ind_truncate+0x967/0x1050
 ext4_truncate+0xb1b/0x1210
 ext4_evict_inode+0xf06/0x16f0
 evict+0x2a3/0x630
 iput+0x618/0x850
 ext4_enable_quotas+0x578/0x920
 ext4_orphan_cleanup+0x539/0x1200
 ext4_fill_super+0x94d8/0x9bc0
 get_tree_bdev+0x40c/0x630
 ext4_get_tree+0x1c/0x20
 vfs_get_tree+0x88/0x290
 do_new_mount+0x289/0xac0
 path_mount+0x607/0xfd0
 __se_sys_mount+0x2c4/0x3b0
 __x64_sys_mount+0xbf/0xd0
 do_syscall_64+0x3d/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
 </TASK>

Link: https://syzkaller.appspot.com/bug?id=5266d464285a03cee9dbfda7d2452a72c3c2ae7c
Reported-by: syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com
Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
---
 fs/ext4/balloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 78ee3ef795ae..1175750ad05f 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -56,6 +56,9 @@ void ext4_get_group_no_and_offset(struct super_block *sb, ext4_fsblk_t blocknr,
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	ext4_grpblk_t offset;
 
+	if (blocknr < le32_to_cpu(es->s_first_data_block))
+		blocknr = le32_to_cpu(es->s_first_data_block);
+
 	blocknr = blocknr - le32_to_cpu(es->s_first_data_block);
 	offset = do_div(blocknr, EXT4_BLOCKS_PER_GROUP(sb)) >>
 		EXT4_SB(sb)->s_cluster_bits;
-- 
2.36.1

