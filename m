Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D64759FF9E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbiHXQiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiHXQiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:38:02 -0400
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B554B9C506
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1661359071; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=N1fJaeot2PPs4W3Y92ufxyPQq1wc0Hl1TfTz0dK2OF52ezEYtRtUO8kUPvj0CHRNwcR0kaP/WV+PPVyTMMx//s4nEfeFn5WZo46ePqyisw49rRJ/v60DmRd8vmOCnGKHteXc0K3Wszujj+fcpVwILibqVZPqQ5u9Bo/mv3kbHXI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1661359071; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=yaBknMOqdVz+7gAjA3ortDF0RcumQ0A8XMHD6N3VTMU=; 
        b=f4alC4ln6rNyxCnCJXsGj/KTjNyRtqnb38m6sluiAAOoFZ5nmzpr8r/D3DHA7hQiIv9kcqUn33UeO244rdYzOooTm+kS9p+CeHdZ1+20sbWnvBU4XNB6agVFrMI2mlOfbtROvigSI0J3FVviV2XzcjrvM3vyeiEfcPfZynDGhtM=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1661359071;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=yaBknMOqdVz+7gAjA3ortDF0RcumQ0A8XMHD6N3VTMU=;
        b=rZ/8CSZ9bgoTVoZtLeHgicqJFWNxgVsv8l/aDpTY2GAFcQ8DuxfRukomesRA0kpE
        1fYh0MZA5b8ZoGrB/NF0Hpvj1r5U7ckACqkKRX79ZxeFJ5TUsuJVAOfxrUVsg6aPNL1
        DI4PLKjIO6XE6V/hw5OLOOEj6449YVFMUXugxrwI=
Received: from localhost.localdomain (103.249.233.18 [103.249.233.18]) by mx.zoho.in
        with SMTPS id 1661359069257993.5119383102618; Wed, 24 Aug 2022 22:07:49 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     syzbot+9d67170b20e8f94351c8@syzkaller.appspotmail.com
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Message-ID: <20220824163739.722115-1-code@siddh.me>
Subject: Re: [syzbot] memory leak in ntfs_init_fs_context
Date:   Wed, 24 Aug 2022 22:07:39 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <000000000000cb172905e6e28808@google.com>
References: <000000000000cb172905e6e28808@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master

---
 fs/ntfs3/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 47012c9bf505..c0e45f170701 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1281,6 +1281,7 @@ static int ntfs_fill_super(struct super_block *sb, st=
ruct fs_context *fc)
 =09 * Free resources here.
 =09 * ntfs_fs_free will be called with fc->s_fs_info =3D NULL
 =09 */
+=09put_mount_options(sbi->options);
 =09put_ntfs(sbi);
 =09sb->s_fs_info =3D NULL;
=20
--=20
2.35.1


