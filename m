Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DA9568F12
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiGFQ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiGFQ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:26:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7D8275D7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C57A661CAA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B832C3411C;
        Wed,  6 Jul 2022 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657124773;
        bh=/XMuQfK+Lx5qvBfgupKs0ht8LEtOx5afaMDwU0HsGuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hsAHIOUM1bH816MW4VoaIMkqlTjFmdAQLDxa48L3ZbcvY5OhYyJKIdbBRkGBouV8V
         2XRlDzGKY6hUm4SKcKEcd3rRFiigNFUK2zczsL8EN1fP8qmUsAdKw27UT5ZBgghPXN
         9rkb9zWSw6N/XN0kyLpHIY0rHPUgxpxGQTWP3Ymt8kvyySCPERpiK9KzaFHEjz6SvW
         OLqqEDZW0hORJ1j2P8m0aputLwgKO0J2WrOWeUDNbtI9IJUpHnM8YL8CGAtqHRWFrp
         4uNqt2oqQ7LnYfm29sX8zSt0DM+LI8bviwABuDqiS23JAS7oGTDYvmvjBrzIh7GCCa
         HwCzsE9B9MsIQ==
Date:   Wed, 6 Jul 2022 10:26:09 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     John Garry <john.garry@huawei.com>, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix nvme_setup_command metadata trace event for
 cdw10
Message-ID: <YsW3oXcCe6/y6iRb@kbusch-mbp.dhcp.thefacebook.com>
References: <1657095398-114310-1-git-send-email-john.garry@huawei.com>
 <YsW0orMaDFfrHbx+@kbusch-mbp.dhcp.thefacebook.com>
 <20220706161825.GA1962@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706161825.GA1962@lst.de>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 06:18:25PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 06, 2022 at 10:13:22AM -0600, Keith Busch wrote:
> > Did you test what the trace looks like afte this? We're losing valuable trace
> > data here. The field is supposed to get CDW's 10 - 15, so that's 24 bytes. I
> > don't know why it cares that the address of the field being read is only 4
> > bytes; we want everything that comes after it too.
> 
> Because accesses should not spawn boundaries of members in structs unless
> copying the entire struct.  If we want to trace the various fields we
> need to individually assign them.
> 
> Anyway, I'm dropping this patch from nvme-5.19 for now to let the
> discussion conclude.

How about this instead?

---
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index b5f85259461a..3c5e7fa03707 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -69,7 +69,7 @@ TRACE_EVENT(nvme_setup_cmd,
 		__entry->metadata = !!blk_integrity_rq(req);
 		__entry->fctype = cmd->fabrics.fctype;
 		__assign_disk_name(__entry->disk, req->q->disk);
-		memcpy(__entry->cdw10, &cmd->common.cdw10,
+		memcpy(__entry->cdw10, &cmd->common.bytes,
 			sizeof(__entry->cdw10));
 	    ),
 	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%x, cmd=(%s %s)",
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index e3934003f239..1be226871763 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -906,12 +906,17 @@ struct nvme_common_command {
 	__le32			cdw2[2];
 	__le64			metadata;
 	union nvme_data_ptr	dptr;
-	__le32			cdw10;
-	__le32			cdw11;
-	__le32			cdw12;
-	__le32			cdw13;
-	__le32			cdw14;
-	__le32			cdw15;
+	union {
+		struct {
+			__le32	cdw10;
+			__le32	cdw11;
+			__le32	cdw12;
+			__le32	cdw13;
+			__le32	cdw14;
+			__le32	cdw15;
+		};
+		__u8 bytes[24];
+	};
 };
 
 struct nvme_rw_command {
--
