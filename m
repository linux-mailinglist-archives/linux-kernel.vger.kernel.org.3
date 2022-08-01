Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612FE5866CE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiHAJXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiHAJXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:23:14 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAF2D2B244
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aUlPu
        r86Uq5+zhGr0WKOjZ356tSLa5JuFMCfmHLR1uA=; b=lMsIuqNOTVuG/f1PeVWI5
        VhbKZwX3T/ymV/gf2IKIp52lKWoRwexHpUYyDANv1BrD4HY3u73e4WWZ0j0Yj/fS
        IV/8M6aPmrezVY9NNcW34BL7cXTbV0AjmI29E95T4+69/0gdxTzY3JXyUUtvxHha
        7h/E5Xpago5amflLhlgF4w=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp4 (Coremail) with SMTP id HNxpCgB35+M_m+di06X6SA--.6070S2;
        Mon, 01 Aug 2022 17:22:09 +0800 (CST)
From:   studentxswpy@163.com
To:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Xie Shaowen <studentxswpy@163.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH -next] f2fs: Replace kmalloc() with f2fs_kmalloc
Date:   Mon,  1 Aug 2022 17:22:02 +0800
Message-Id: <20220801092202.3134668-1-studentxswpy@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgB35+M_m+di06X6SA--.6070S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xry5XFW8trW7ur4rCr4DJwb_yoWfGwc_Wa
        48J3y0kry7JFZ3K3srCa9YqFyqqw1rJrn09FyaqF43K34rWrW3W3ZruF13A3y2vrW8Wry3
        Crs5XrWjyr17ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1IzutUUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xvwxvv5qw024ls16il2tof0z/xtbB3wlQJGBHLN29uAAAsx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie Shaowen <studentxswpy@163.com>

replace kmalloc with f2fs_kmalloc to keep f2fs code consistency.

Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: Xie Shaowen <studentxswpy@163.com>
---
 fs/f2fs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index d5bd7932fb64..712b51f69c04 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -232,7 +232,7 @@ static int f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
 		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(dir)))
 			return -EINVAL;
 
-		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
+		decrypted_name.name = f2fs_kmalloc(de_name_len, GFP_KERNEL);
 		if (!decrypted_name.name)
 			return -ENOMEM;
 		res = fscrypt_fname_disk_to_usr(dir, 0, 0, &encrypted_name,
-- 
2.25.1

