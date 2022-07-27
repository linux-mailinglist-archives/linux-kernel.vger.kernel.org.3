Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6955832DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiG0TFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbiG0TF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:05:28 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEA0C50;
        Wed, 27 Jul 2022 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:References:Cc:To:From:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=SxqIxoB46XQQzufy517WF/ExkkxnsZ5pxzOa6F+2UDs=; b=F2Wd3ULW8xn5qjhM2xrw5lGl04
        6wCCjtdhIn/taUdv6L/aNTC7OAfh544VNRi/pcpBj3UH3I+I0CycnBncTCxv8IR2eRnWCZjxEzMIw
        kbtUgQMVjhqAwmq9b5ixP+OiZSFbgjxR3Cj9R2SYaaXLz+ueIYG2nHcF+QBpgWsQirsBUGAqeM9ke
        s4xivoC6de24FOOrDX6HwATqbTWdjy9tbnYITd12YRzueNtWA+afQqKowXArcZHxXGkfY+/h1YA7J
        u4uu6HiIDHGxdyU1UVEo/P3M+3kdg8SoZkWY7V4DU6ybq0938kP4eeZtiDW5hUkXe9HestBDMS4MM
        24pD3cFQ==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oGlpO-001n9P-H9; Wed, 27 Jul 2022 12:32:16 -0600
Message-ID: <838314fe-a85d-19be-71b6-264cad7e83c9@deltatee.com>
Date:   Wed, 27 Jul 2022 12:32:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Logan Gunthorpe <logang@deltatee.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20220727214807.6209642e@canb.auug.org.au>
Content-Language: en-US
In-Reply-To: <20220727214807.6209642e@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sfr@canb.auug.org.au, hch@lst.de, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: linux-next: build warning after merge of the dma-mapping tree
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-07-27 05:48, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the dma-mapping tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/driver-api/infrastructure:50: kernel/dma/mapping.c:258: WARNING: Option list ends without a blank line; unexpected unindent.
> 
> Introduced by commit
> 
>   7c2645a2a30a ("dma-mapping: allow EREMOTEIO return code for P2PDMA transfers")


Oh, hmm, I thought I addressed this when I added the extra line at the
end of the comment, but it seems the htmldocs is a bit fussier than that
with the white space. 

The only way I can seem to suppress that error is by adding another tab
character in the list; see below.

I'll send a full patch shortly.

Logan

--

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 746d46825d08..99e1e0c9a295 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -249,15 +249,15 @@ EXPORT_SYMBOL(dma_map_sg_attrs);
  * Returns 0 on success or a negative error code on error. The following
  * error codes are supported with the given meaning:
  *
- *   -EINVAL	An invalid argument, unaligned access or other error
- *		in usage. Will not succeed if retried.
- *   -ENOMEM	Insufficient resources (like memory or IOVA space) to
- *		complete the mapping. Should succeed if retried later.
- *   -EIO	Legacy error code with an unknown meaning. eg. this is
- *		returned if a lower level call returned DMA_MAPPING_ERROR.
- *   -EREMOTEIO	The DMA device cannot access P2PDMA memory specified in
- *		the sg_table. This will not succeed if retried.
- *
+ *   -EINVAL		An invalid argument, unaligned access or other error
+ *			in usage. Will not succeed if retried.
+ *   -ENOMEM		Insufficient resources (like memory or IOVA space) to
+ *			complete the mapping. Should succeed if retried later.
+ *   -EIO		Legacy error code with an unknown meaning. eg. this is
+ *			returned if a lower level call returned
+ *			DMA_MAPPING_ERROR.
+ *   -EREMOTEIO		The DMA device cannot access P2PDMA memory specified
+ *			in the sg_table. This will not succeed if retried.
  */
 int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
 		    enum dma_data_direction dir, unsigned long attrs)
