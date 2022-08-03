Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F53588BF3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiHCMZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiHCMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:25:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79D26167;
        Wed,  3 Aug 2022 05:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F233612E4;
        Wed,  3 Aug 2022 12:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68F9C433D6;
        Wed,  3 Aug 2022 12:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659529521;
        bh=rncz+GGwg257PVeOLmwaasfCTNBolPJGae/pZnnARYs=;
        h=From:To:Cc:Subject:Date:From;
        b=hU8VGtAnnwvxv/w1ak9JSRlCZLcWm1qfybzGjQ56CIEx/26fYdlQYH478a9IunQ9a
         DewaUAwtn+CE952tUnPyN2ebA3BxrBWiCycxMCxi/8t6OqwV3lpftiy69yfyEzX4ap
         ZV3HougOQ30+NZQV1eKJ/nFjtkFayLrfH5A6vvPOx6vL+qZnzxfMfsKvznd56zEQhU
         UkWSCBdHJTb9J1Df3bMF3BTI5yTW6jvNSEY9JP7VWlEUWK5uxamdOh2+/Aqfgk/fK8
         e7d3vTCU75ezRLOPzGLH7GaeZuFLRhoV/gWXIEQbQ8WJSWDQ1Ome/W2JitjyX1OqOj
         wLL7t6fOCtGPA==
From:   broonie@kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the origin tree
Date:   Wed,  3 Aug 2022 13:18:15 +0100
Message-Id: <20220803121815.54438-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/io_uring.c

between commit:

  ed29b0b4fd835 ("io_uring: move to separate directory")

from the origin tree and commit:

  164f4064ca81e ("keep iocb_flags() result cached in struct file")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 2b784795103cc..b20ba87e4926f 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -661,7 +661,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
 	if (!io_req_ffs_set(req))
 		req->flags |= io_file_get_flags(file) << REQ_F_SUPPORT_NOWAIT_BIT;
 
-	kiocb->ki_flags = iocb_flags(file);
+	kiocb->ki_flags = file->f_iocb_flags;
 	ret = kiocb_set_rw_flags(kiocb, rw->flags);
 	if (unlikely(ret))
 		return ret;
