Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FD64C4A65
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242775AbiBYQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241469AbiBYQSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:18:04 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8273C632F;
        Fri, 25 Feb 2022 08:17:31 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DD99468AA6; Fri, 25 Feb 2022 17:17:27 +0100 (CET)
Date:   Fri, 25 Feb 2022 17:17:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de,
        Hannes Reinecke <hare@suse.de>,
        Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCHv3 09/10] nvme: add support for enhanced metadata
Message-ID: <20220225161727.GC13845@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org> <20220222163144.1782447-10-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222163144.1782447-10-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:31:43AM -0800, Keith Busch wrote:
> @@ -918,6 +918,30 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>  	return BLK_STS_OK;
>  }
>  
> +static inline void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,

Overly long line. But I don't think this should be marked inline anyway.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

I suspect eventually we'll need to lift the new Identify call into
the common revalidation once more fields get added there.
