Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35F552B1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 07:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiERE5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiERE5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:57:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C3D42ECD;
        Tue, 17 May 2022 21:57:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 22C5B68AFE; Wed, 18 May 2022 06:57:05 +0200 (CEST)
Date:   Wed, 18 May 2022 06:57:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: Tree for May 17 (drivers/nvme/host/fc.o)
Message-ID: <20220518045704.GA30131@lst.de>
References: <20220517194118.2caa01b8@canb.auug.org.au> <5958ccea-d89c-8b1a-15d3-19d8cacd141d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5958ccea-d89c-8b1a-15d3-19d8cacd141d@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch that adds nvme_fc_io_getuuid need something like this
folded in:

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a11c69e681180..3c778bb0c2944 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1911,7 +1911,9 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
 	struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
 	struct request *rq = op->rq;
 
-	return rq->bio ? blkcg_get_fc_appid(rq->bio) : NULL;
+	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq->bio)
+		return NULL;
+	return blkcg_get_fc_appid(rq->bio);
 }
 EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
 
