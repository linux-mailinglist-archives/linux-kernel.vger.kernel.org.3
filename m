Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596F858F38B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 22:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiHJU2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 16:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiHJU2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 16:28:07 -0400
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98EC275C2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 13:28:06 -0700 (PDT)
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
        by cmsmtp with ESMTP
        id LkeXocmceSp39LsJBoa2fY; Wed, 10 Aug 2022 20:28:05 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
        by cmsmtp with ESMTP
        id LsJBoKEiFGRNlLsJBo8I7A; Wed, 10 Aug 2022 20:28:05 +0000
X-Authority-Analysis: v=2.4 cv=Sfrky9du c=1 sm=1 tr=0 ts=62f414d5
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=biHskzXt2R4A:10 a=M51BFTxLslgA:10 a=nlC_4_pT8q9DhB4Ho9EA:9 a=3I1X_3ewAAAA:8
 a=bLrhdl3v5zxwkAIYeHEA:9 a=QEXdDO2ut3YA:10 a=VG9N9RgkD3hcbI6YpJ1l:22
Received: from tuyoix.net (fanir.tuyoix.net [192.168.144.16])
        (authenticated bits=0)
        by fanir.tuyoix.net (8.17.1/8.17.1) with ESMTPSA id 27AKS4OF023471
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Aug 2022 14:28:04 -0600
Date:   Wed, 10 Aug 2022 14:28:04 -0600 (MDT)
From:   =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH} ntfs3: fix [df]mask display in /proc/mounts
Message-ID: <d3337d95-201c-43bd-3b37-4fd9e654d821@tuyoix.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463807856-683457024-1660163285=:22026"
X-CMAE-Envelope: MS4xfHzSaq5HPqQVabYBLWfN2WxjESpgcdfyF6ZSYuqNPItuCIej61v/TD644pVI1eAyqPIOv7J9ObNCpmtPMjIJsyj2A4pdWaT8aWxrxgZBq7RTEL+qCWC8
 oSCaPHbcJ6JJv2uAesfLdFuraokVFbt9ibwJajonRo1osHnTpcBmoZ0h0Y65DAeAeNbK4yRrZe9lLo1KD7JsySrTZA54OEWYlZPQEo4BnRs6Cl6CQBumw9MY
 3SFb886bEIfz9SG1zRl77b3hExPm+auyGcCRy0XtVu5xaBmSCDDpgpoCrCSZXu+Y
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463807856-683457024-1660163285=:22026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

ntfs3's dmask and fmask mount options are 16-bit quantities but are displayed
as 1-extended 32-bit values in /proc/mounts.  Fix this by circumventing
integer promotion.

This change is not eligible for stable@.

Please Reply-To-All.

Thanks and have a great day.

Marc.

Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>

diff -aNpRruz -X /etc/diff.excludes linux-5.17.1/fs/ntfs3/super.c devel-5.17.1/fs/ntfs3/super.c
--- linux-5.17.1/fs/ntfs3/super.c	2022-03-28 02:03:22.000000000 -0600
+++ devel-5.17.1/fs/ntfs3/super.c	2022-03-28 07:14:10.799008309 -0600
@@ -518,9 +518,9 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 	seq_printf(m, ",gid=%u",
 		  from_kgid_munged(user_ns, opts->fs_gid));
 	if (opts->fmask)
-		seq_printf(m, ",fmask=%04o", ~opts->fs_fmask_inv);
+		seq_printf(m, ",fmask=%04o", opts->fs_fmask_inv ^ 0xffff);
 	if (opts->dmask)
-		seq_printf(m, ",dmask=%04o", ~opts->fs_dmask_inv);
+		seq_printf(m, ",dmask=%04o", opts->fs_dmask_inv ^ 0xffff);
 	if (opts->nls)
 		seq_printf(m, ",iocharset=%s", opts->nls->charset);
 	else
---1463807856-683457024-1660163285=:22026--
