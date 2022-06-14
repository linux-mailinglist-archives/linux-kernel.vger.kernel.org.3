Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA0854BCC7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbiFNVaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiFNVaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:30:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22DD51308
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80309B81B79
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 21:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FE1C3411B;
        Tue, 14 Jun 2022 21:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655242211;
        bh=MAO6Ltn+ZJDp9ipd0GNmKkEUG7gekxxwFt5tgjHOFDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q3idHCxoibq4SDFqLrq2RDnuUjW27Qd1UgHVoUSCnPF5r0HLZ79uHrPMrNsurhzpW
         HBcY8duYJ7NLKsLXlb0E0/zRE+lMh9ikoFposs7cVslt8FJVg6Pdwa8TQgeaewqa9M
         NGe2NHiBy59OT5b9aN5ICkmaA8L0px6mtXEu6L8BdGpMlDPy9wGJ9tAWlFIryY+biP
         4AM1i+wYXC/JWmEA4LU/IuKMqmrVUscrfuGLY2EcrRb6MWUHsxUtiHFMpemuzETag3
         aSA+AjKyRQ8VNluFfeluLSdaudBizyo4Nzz0ux+bu7K20uzh8ORK96dpN0v2VrxJvv
         OT4zHPNpaS+9Q==
Date:   Tue, 14 Jun 2022 14:30:08 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Erwan Velu <erwanaliasr1@gmail.com>
Cc:     Erwan Velu <e.velu@criteo.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] nvme: Report model,sn,fw,pci device information
 during init
Message-ID: <Yqj94JXMwjrdSbqG@kbusch-mbp.dhcp.thefacebook.com>
References: <20220614210902.744318-1-e.velu@criteo.com>
 <20220614210902.744318-2-e.velu@criteo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614210902.744318-2-e.velu@criteo.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 11:09:02PM +0200, Erwan Velu wrote:
> @@ -2982,6 +2982,14 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>  		return -EIO;
>  	}
>  
> +	/* Reporting model, serial, firmware and pci info */
> +	dev_info(ctrl->device, "MODEL:%s SN:%s FW:%s PCI_ID:%04x:%04x\n",
> +			id->mn,
> +			id->sn,
> +			id->fr,
> +			le16_to_cpu(id->vid),
> +			le16_to_cpu(id->ssvid));

We don't need to print this on every controller reset, so I think this needs to
be within the "if (!ctrl->identified)" block.

And since you can't just null terminate the these strings, you should use the
"%*s" format.

I'm unsure if the serial number should be logged. Firmware and model are
probably fine.
