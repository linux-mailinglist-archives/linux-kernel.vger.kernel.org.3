Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9960E54C9EA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352421AbiFONfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiFONfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:35:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C50235DEC;
        Wed, 15 Jun 2022 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k/zQupm933CmyzuMuKQ5Pb2iFZ/vMndU5RNv3Bx/QGM=; b=NfisZ+MxgdT+zEE6yIaknzVni+
        jt+9MUhobgv4PyvKmYyaTJxghnZ0x1NsR3giqBCBVoPrlrchsaNvcDHJk/sHrTIROPyCDT5AINmPv
        33oq3m4K187tXCtZUIb3t7+Oby4Q3aOrVeb7eZRRByGjxJNsvUtsHcNSzcWW82l6P15mr6KElEPWS
        bCJ+4z+OM4vkUGjjqPArkFAsk0TLdgKGraAmH152H7g0jFXZ1pSmHf2SgtFIdBu0B/FDyeDcklTD9
        uruJBQdpPiybTdDyvZr5w0krSXXMVJBm21iJ+Yp92fZSXO9iUKq5RFUP/bEuU0ZtXxThyxN4CMu1k
        OjJBMAxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1TBI-00EjsX-Bw; Wed, 15 Jun 2022 13:35:36 +0000
Date:   Wed, 15 Jun 2022 06:35:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: support packing multi-segment in UNMAP command
Message-ID: <YqngKHnfVIzq7Pgr@infradead.org>
References: <20220615132846.2232920-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615132846.2232920-1-chao@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 09:28:46PM +0800, Chao Yu wrote:
> As SPEC describes that it can support unmapping one or more LBA range

s/SPEC/<insert SPC reference here>/

>  {
>  	struct scsi_device *sdp = cmd->device;
>  	struct request *rq = scsi_cmd_to_rq(cmd);
> +	struct bio *bio;
>  	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
> +	unsigned short segments = blk_rq_nr_discard_segments(rq);
> +	unsigned int data_len = 8 + 16 * segments, i = 0;
>  	char *buf;

Nit: for readability I'd move the bio declaration just above the buf
line.

> +
> +	__rq_for_each_bio(bio, rq) {
> +		u64 lba = sectors_to_logical(sdp, bio->bi_iter.bi_sector);
> +		u32 nr_blocks = sectors_to_logical(sdp, bio_sectors(bio));
> +
> +		put_unaligned_be64(lba, &buf[8 + 16 * i]);
> +		put_unaligned_be32(nr_blocks, &buf[8 + 16 * i + 8]);

Can we have a local variable here?

	unsigned int data_offset = 8;

	....

		put_unaligned_be64(lba, &buf[data_offset]);
		put_unaligned_be64(lba, &buf[data_offset + 8]);
		data_offset += 16;
	}

