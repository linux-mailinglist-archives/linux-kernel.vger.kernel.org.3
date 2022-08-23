Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9699659EFBA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 01:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiHWXdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 19:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiHWXd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 19:33:29 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46B686FC3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZpgOnfoB3G+8B3GPX7SSqWvigoev/1tx1b5/Xxi/HEg=; b=bftmL1ilNDBTxY0TLs2/XjHJOi
        62QLnNu13X7qG7JoV6DxrNDx6qdbL+OPIOMaiesR3MQfzjO7bGK93fiFd5RcbEQnZISN8999jAwEJ
        yVMKEW+r5ylYM3u46HAyjk+IidRRhyNqUOM0Npg5/3TPI5YY3EW2hC0liR14M6EN3VmFYmRoz7OCL
        7D6PX6AGLWMOzVAtZHQ1GNU83Xp1ng21/BBCbSikZyppheIR4zbwVQW4ItqcKrVG2AxrKT/5heBf6
        HR/XR8odIyoS2/q9tnw7U2i0EOQ/9VXE65Qtde1vRpRCK0ZbKW5zMN8GCor5AmWy+Yksnbnr3rm/P
        +FcIZl9w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oQdO9-007aKM-Hn;
        Tue, 23 Aug 2022 23:32:53 +0000
Date:   Wed, 24 Aug 2022 00:32:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        James Smart <james.smart@broadcom.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come
 from HIGHMEM
Message-ID: <YwVjpTW6vWvdVQTK@ZenIV>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com>
 <20220822142438.5954-2-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822142438.5954-2-fmdefrancesco@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 04:24:38PM +0200, Fabio M. De Francesco wrote:

> Therefore, replace the kmap() of sg_page(sg) with a page_address() and
> delete the "nr_mapped" field from "nvmet_tcp_cmd" and instead pass a
> local variable to iov_iter_kvec() from the call site in
> nvmet_tcp_map_pdu_iovec().

I'd suggest looking into switching to ITER_BVEC...
