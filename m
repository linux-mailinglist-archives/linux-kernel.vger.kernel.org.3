Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FE44CCA40
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbiCCXrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiCCXrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:47:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7177213DE25;
        Thu,  3 Mar 2022 15:47:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0145861656;
        Thu,  3 Mar 2022 23:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86318C004E1;
        Thu,  3 Mar 2022 23:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646351225;
        bh=qELuvZR37Ylzxt28jAAWXFUW9hvkb8Eiv69yFb0SIoA=;
        h=Date:From:To:Cc:Subject:From;
        b=nS2f7nYM9TgElWijog1JiXagEXXVaFfQytIsiIBNYNKlaUuiwqUx6v04ZKvrvc5n8
         2V78AbMplcPXOZPzmh5B1orkMsnflzm2Tr0S1LE4vLWpVg2fT/jD8dXsu2mqMDbGap
         uU21tn9KETkGlaN4CitCCy89q7IFdsVUDcItgo/cb/EVNfQy9VZzIDuCFZy9GVvnvA
         8FbB2RDdpbWz9LcuMFgU286GsRopZT0AQ8TDyJt5+nHJ2EirafieoTCvg6s3bf772R
         TUMLmLmOKth4mpwj3o141y/rljXDTuR09eqlD8/pLa06BuBrzIZzz1Nkq1PZY4V94/
         7o6tx1E/UutrQ==
Date:   Thu, 3 Mar 2022 17:55:21 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Robert Love <robert.w.love@intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] scsi: fcoe: Fix Wstringop-overflow warnings in
 fcoe_wwn_from_mac()
Message-ID: <20220303235521.GA1745589@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following Wstringop-overflow warnings when building with GCC-11:

drivers/scsi/fcoe/fcoe.c: In function ‘fcoe_netdev_config’:
drivers/scsi/fcoe/fcoe.c:744:32: warning: ‘fcoe_wwn_from_mac’ accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
  744 |                         wwnn = fcoe_wwn_from_mac(ctlr->ctl_src_addr, 1, 0);
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/fcoe/fcoe.c:744:32: note: referencing argument 1 of type ‘unsigned char *’
In file included from drivers/scsi/fcoe/fcoe.c:36:
./include/scsi/libfcoe.h:252:5: note: in a call to function ‘fcoe_wwn_from_mac’
  252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
      |     ^~~~~~~~~~~~~~~~~
drivers/scsi/fcoe/fcoe.c:747:32: warning: ‘fcoe_wwn_from_mac’ accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
  747 |                         wwpn = fcoe_wwn_from_mac(ctlr->ctl_src_addr,
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  748 |                                                  2, 0);
      |                                                  ~~~~~
drivers/scsi/fcoe/fcoe.c:747:32: note: referencing argument 1 of type ‘unsigned char *’
In file included from drivers/scsi/fcoe/fcoe.c:36:
./include/scsi/libfcoe.h:252:5: note: in a call to function ‘fcoe_wwn_from_mac’
  252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
      |     ^~~~~~~~~~~~~~~~~
  CC      drivers/scsi/bnx2fc/bnx2fc_io.o
In function ‘bnx2fc_net_config’,
    inlined from ‘bnx2fc_if_create’ at drivers/scsi/bnx2fc/bnx2fc_fcoe.c:1543:7:
drivers/scsi/bnx2fc/bnx2fc_fcoe.c:833:32: warning: ‘fcoe_wwn_from_mac’ accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
  833 |                         wwnn = fcoe_wwn_from_mac(ctlr->ctl_src_addr,
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  834 |                                                  1, 0);
      |                                                  ~~~~~
drivers/scsi/bnx2fc/bnx2fc_fcoe.c: In function ‘bnx2fc_if_create’:
drivers/scsi/bnx2fc/bnx2fc_fcoe.c:833:32: note: referencing argument 1 of type ‘unsigned char *’
In file included from drivers/scsi/bnx2fc/bnx2fc.h:53,
                 from drivers/scsi/bnx2fc/bnx2fc_fcoe.c:17:
./include/scsi/libfcoe.h:252:5: note: in a call to function ‘fcoe_wwn_from_mac’
  252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
      |     ^~~~~~~~~~~~~~~~~
In function ‘bnx2fc_net_config’,
    inlined from ‘bnx2fc_if_create’ at drivers/scsi/bnx2fc/bnx2fc_fcoe.c:1543:7:
drivers/scsi/bnx2fc/bnx2fc_fcoe.c:839:32: warning: ‘fcoe_wwn_from_mac’ accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
  839 |                         wwpn = fcoe_wwn_from_mac(ctlr->ctl_src_addr,
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  840 |                                                  2, 0);
      |                                                  ~~~~~
drivers/scsi/bnx2fc/bnx2fc_fcoe.c: In function ‘bnx2fc_if_create’:
drivers/scsi/bnx2fc/bnx2fc_fcoe.c:839:32: note: referencing argument 1 of type ‘unsigned char *’
In file included from drivers/scsi/bnx2fc/bnx2fc.h:53,
                 from drivers/scsi/bnx2fc/bnx2fc_fcoe.c:17:
./include/scsi/libfcoe.h:252:5: note: in a call to function ‘fcoe_wwn_from_mac’
  252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
      |     ^~~~~~~~~~~~~~~~~
drivers/scsi/qedf/qedf_main.c: In function ‘__qedf_probe’:
drivers/scsi/qedf/qedf_main.c:3520:30: warning: ‘fcoe_wwn_from_mac’ accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
 3520 |                 qedf->wwnn = fcoe_wwn_from_mac(qedf->mac, 1, 0);
      |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qedf/qedf_main.c:3520:30: note: referencing argument 1 of type ‘unsigned char *’
In file included from drivers/scsi/qedf/qedf.h:9,
                 from drivers/scsi/qedf/qedf_main.c:23:
./include/scsi/libfcoe.h:252:5: note: in a call to function ‘fcoe_wwn_from_mac’
  252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
      |     ^~~~~~~~~~~~~~~~~
drivers/scsi/qedf/qedf_main.c:3521:30: warning: ‘fcoe_wwn_from_mac’ accessing 32 bytes in a region of size 6 [-Wstringop-overflow=]
 3521 |                 qedf->wwpn = fcoe_wwn_from_mac(qedf->mac, 2, 0);
      |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/qedf/qedf_main.c:3521:30: note: referencing argument 1 of type ‘unsigned char *’
In file included from drivers/scsi/qedf/qedf.h:9,
                 from drivers/scsi/qedf/qedf_main.c:23:
./include/scsi/libfcoe.h:252:5: note: in a call to function ‘fcoe_wwn_from_mac’
  252 | u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
      |     ^~~~~~~~~~~~~~~~~

by changing the array size to the correct value of ETH_ALEN in the
argument declaration.

Also, fix a couple of checkpatch warnings:
WARNING: function definition argument 'unsigned int' should also have an identifier name

This helps with the ongoing efforts to globally enable
-Wstringop-overflow.

Link: https://github.com/KSPP/linux/issues/181
Fixes: 85b4aa4926a5 ("[SCSI] fcoe: Fibre Channel over Ethernet")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 2 +-
 include/scsi/libfcoe.h        | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 1756a0ac6f08..558f3f4e1859 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -1969,7 +1969,7 @@ EXPORT_SYMBOL(fcoe_ctlr_recv_flogi);
  *
  * Returns: u64 fc world wide name
  */
-u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN],
+u64 fcoe_wwn_from_mac(unsigned char mac[ETH_ALEN],
 		      unsigned int scheme, unsigned int port)
 {
 	u64 wwn;
diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index fac8e89aed81..310e0dbffda9 100644
--- a/include/scsi/libfcoe.h
+++ b/include/scsi/libfcoe.h
@@ -249,7 +249,8 @@ int fcoe_ctlr_recv_flogi(struct fcoe_ctlr *, struct fc_lport *,
 			 struct fc_frame *);
 
 /* libfcoe funcs */
-u64 fcoe_wwn_from_mac(unsigned char mac[MAX_ADDR_LEN], unsigned int, unsigned int);
+u64 fcoe_wwn_from_mac(unsigned char mac[ETH_ALEN], unsigned int scheme,
+		      unsigned int port);
 int fcoe_libfc_config(struct fc_lport *, struct fcoe_ctlr *,
 		      const struct libfc_function_template *, int init_fcp);
 u32 fcoe_fc_crc(struct fc_frame *fp);
-- 
2.27.0

