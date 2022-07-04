Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CC7565D83
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiGDSgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGDSga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:36:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE70F59B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 11:36:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id n8so12724714eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 11:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=Qp7Ng5Nb7iDTNPtf51XFaa+yr96t6Dwnbl6LBLEqcJ4=;
        b=MB56LCkOnDUksr53OlvSAh4TGI3Hhs29CQ6b7uzEoGZOHM3bsHutYtXbume6D+dzk7
         TEB+b6d+zr1k+UMRMJBVoesXCnwnmUmZLAw/UCrV5Bnf3KxtNQsLQg5UO3vIf4pAJJlE
         8MmZJR/PR2IGKt8Q3ZEGtdJtTqhxZjCWM99nemjxHSJDD3anu7Tqht0qTszKqgGkGX4D
         BRPLWuI6aWoFyt6bf2CthWq1P5+CRHKFmZ73lzi0rkJsdhm+Z0COVRoozSkSeExhyYrC
         Ade2hp6t0lVlOqY6UGtwBd592egbU201LVwrCaV/0926UTfvN3hN1wBrKXJ7Nz3q2ESf
         YkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=Qp7Ng5Nb7iDTNPtf51XFaa+yr96t6Dwnbl6LBLEqcJ4=;
        b=r8/mjZq/m73128pZcXQlv8cxMgWkBOkDi0JoHNdi/+v8o1PbKNX7BD5/Q0QJuLSkZx
         WJ32gCziX6VSITf1MfZ7lZch24U12/uhjVNhb3Nm9K6pezpZdg5/8KvbyVBFnQZIJo3O
         ssv622xqsFwQAroAA9RE/ijrsecJgzIXUjE30aLiC13nJCkyuoTfHrV62pWfFAT5OiM0
         jRcuUNAaZjI/8vJH1ghz64ek/LDEnQ1ynPkID5tGcQ0hC5F1vWxE1X97vPDZRk0xUcWb
         h224/JgPEkbHrR5zYFxLNo57NdtNT+r7fXOkcNBrgbLF7RtCnz5F5MQ4Ia1m9DweHjRx
         BYbA==
X-Gm-Message-State: AJIora+XukPTohllDcE0kwctzah+33q3pG53GPCEubSFDfoVJfuEeukG
        b6bvn2I0KYdrC4ovcFhZA3FCug==
X-Google-Smtp-Source: AGRyM1svpolHG00l15pBdhgHlq6MIvDCEBV9e+cjPMhwshCi/KvMQVZDWyqc7XCe3toyiKfDEhItQQ==
X-Received: by 2002:a05:6402:2398:b0:435:9685:1581 with SMTP id j24-20020a056402239800b0043596851581mr40783795eda.333.1656959787748;
        Mon, 04 Jul 2022 11:36:27 -0700 (PDT)
Received: from smtpclient.apple (ip5f595116.dynamic.kabel-deutschland.de. [95.89.81.22])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906539500b0072ab9f5ae5fsm2249407ejo.75.2022.07.04.11.36.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jul 2022 11:36:27 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: [PATCH] ovl: Handle ENOSYS when fileattr support is missing in
 lower/upper fs
Message-Id: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
Date:   Mon, 4 Jul 2022 20:36:24 +0200
Cc:     linux-kernel@vger.kernel.org
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

overlayfs may fail to complete updates when a filesystem lacks
fileattr/xattr syscall support and responds with an ENOSYS error code,
resulting in an unexpected "Function not implemented" error.

This bug may occur with FUSE filesystems, such as davfs2.

Steps to reproduce:

  # install davfs2, e.g., apk add davfs2
  mkdir /test mkdir /test/lower /test/upper /test/work /test/mnt
  yes '' | mount -t davfs -o ro http://some-web-dav-server/path \
    /test/lower
  mount -t overlay -o upperdir=3D/test/upper,lowerdir=3D/test/lower \
    -o workdir=3D/test/work overlay /test/mnt

  # when "some-file" exists in the lowerdir, this fails with "Function
  # not implemented", with dmesg showing "overlayfs: failed to retrieve
  # lower fileattr (/some-file, err=3D-38)"
  touch /test/mnt/some-file

This bug is related to a regression in v5.15 that was partially fixed in
v5.16.

This patch also adds checks for ENOSYS in case the upper file system
does not support file attributes. That change is related to a partial
fix in v5.17.

Reported-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
Fixes: 5b0a414d06c ("ovl: fix filattr copy-up failure")
Fixes: 24d7f48c723 ("ovl: don't fail copy up if no fileattr support on =
upper")
Cc: <stable@vger.kernel.org> # v5.15
Signed-off-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
---
 fs/overlayfs/copy_up.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 714ec569d25b..0ad88573e77a 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -142,7 +142,7 @@ static int ovl_copy_fileattr(struct inode *inode, =
struct path *old,
 	err =3D ovl_real_fileattr_get(old, &oldfa);
 	if (err) {
 		/* Ntfs-3g returns -EINVAL for "no fileattr support" */
-		if (err =3D=3D -ENOTTY || err =3D=3D -EINVAL)
+		if (err =3D=3D -ENOTTY || err =3D=3D -EINVAL || err =3D=3D=
 -ENOSYS)
 			return 0;
 		pr_warn("failed to retrieve lower fileattr (%pd2, =
err=3D%i)\n",
 			old->dentry, err);
@@ -173,7 +173,7 @@ static int ovl_copy_fileattr(struct inode *inode, =
struct path *old,
 		 * Returning an error if upper doesn't support fileattr =
will
 		 * result in a regression, so revert to the old =
behavior.
 		 */
-		if (err =3D=3D -ENOTTY || err =3D=3D -EINVAL) {
+		if (err =3D=3D -ENOTTY || err =3D=3D -EINVAL || err =3D=3D=
 -ENOSYS) {
 			pr_warn_once("copying fileattr: no support on =
upper\n");
 			return 0;
 		}
--=20
2.36.1


