Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E5F4BECE5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiBUWGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:06:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiBUWGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:06:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D4E22BE2;
        Mon, 21 Feb 2022 14:06:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AED5B810F5;
        Mon, 21 Feb 2022 22:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7CEC340E9;
        Mon, 21 Feb 2022 22:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645481186;
        bh=7LWosMqRDOsNooX1HPjL606jn97RZiS2HzXWtRFqKp0=;
        h=From:To:Cc:Subject:Date:From;
        b=smPXcDSKyeJ/38vIGtvvhn/bNOBDfhwj4WDjvG1e+z5YYJwaK4V2k6hVIVhO2xOEb
         gr+rntafb+UD+d1JGF5eGkAcikA5H1FQKOz7jcahy8Vj0yeGFRCZty+cx6hhUhuBnQ
         Ur31UbgmIu2CpF8X93fY8XrePMMhrv1+6miT0lQ0Vkt19UtitiGUOJlnblbtqjd4Nx
         UKDLcp3IVAcOeoVULCJGmGoIpIF0tNp/3JPnyStKu0yupQ9uSZ/SajHp2/n79zxkHY
         Rn4HooSrs33m6HX+ODPzcqccV/58kb2WgwfOthPoxi1q6JGo+JZNc+DRY4QX736oVz
         EIiFgfQrju+Xg==
From:   broonie@kernel.org
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the scsi-mkp tree with the block tree
Date:   Mon, 21 Feb 2022 22:06:22 +0000
Message-Id: <20220221220622.3000432-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  block/blk-lib.c

between commit:

  0a3140ea0fae3 ("block: pass a block_device and opf to blk_next_bio")

from the block tree and commit:

  2988062985d59 ("scsi: block: Remove REQ_OP_WRITE_SAME support")

from the scsi-mkp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc block/blk-lib.c
index fc6ea52e74824,bf5254ccdb5f8..0000000000000
--- a/block/blk-lib.c
+++ b/block/blk-lib.c

(took the deletion of _WRITE_SAME from scsi-mkp)
