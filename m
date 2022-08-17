Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBDC597545
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbiHQRod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240683AbiHQRo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:44:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E524620B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D28CC6130D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 17:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9D2C433D6;
        Wed, 17 Aug 2022 17:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660758264;
        bh=RUGwvuAQRArCjX8ifHZubqA3C7OTKG3kXa4gkAdYYas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FaAsS1i2+0FDOsoI5r001GJsjskp84fnvr18WAj/ayy2ejW6ey0HCpfTWmU0OwzJ3
         T2MFHduv1IihnTQhcnIAJsnGBsw4GBpQEnJGcQUk42V3Z1MxsIChB14ZmcXb76Avng
         HtIxCuQeFmNI94yfoU5enj+DJKS+cI0C9H5i+hR1I60xyImpwWhelumNno+JJe38KM
         0fw91lFhKrjYki+AezrQbc3g/cFbzFJmDxMF2aDRLFGMfA6DFuCmREPpgPD4hQWh/m
         Zk7GP594ZQ9YMq6bIDQUOfY7ryARPwGwEQhHdAjUSL0/hOU05/gDmbB0aGZCholtrJ
         S6MDGtZp4w5NA==
Date:   Wed, 17 Aug 2022 11:44:20 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Message-ID: <Yv0o9MlqCjXUcDKc@kbusch-mbp.dhcp.thefacebook.com>
References: <20220817170427.15682-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817170427.15682-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 07:04:27PM +0200, Fabio M. De Francesco wrote:
> @@ -329,7 +312,6 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>  	u32 length, offset, sg_offset;
>  
>  	length = cmd->pdu_len;
> -	cmd->nr_mapped = DIV_ROUND_UP(length, PAGE_SIZE);
>  	offset = cmd->rbytes_done;
>  	cmd->sg_idx = offset / PAGE_SIZE;
>  	sg_offset = offset % PAGE_SIZE;
> @@ -338,7 +320,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>  	while (length) {
>  		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
>  
> -		iov->iov_base = kmap(sg_page(sg)) + sg->offset + sg_offset;
> +		iov->iov_base = page_address(sg_page(sg)) + sg->offset + sg_offset;
>  		iov->iov_len = iov_len;
>  
>  		length -= iov_len;
> @@ -347,8 +329,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>  		sg_offset = 0;
>  	}
>  
> -	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
> -		cmd->nr_mapped, cmd->pdu_len);
> +	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov, 0, cmd->pdu_len);
>  }

I earlier meant just use a local variable for 'nr_mapped' rather than replace
it with '0'. I don't think that 0 segments would result in usable kvec.

I'm not even sure the existing code is correct, though. The sg->length can be
higher order than a PAGE_SIZE, so it may be over-reporting nr_segs. It's just
supposed to be the number of initialized iov's.

Anway, the rest looks good.
