Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724BF4F8E73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiDHGCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiDHGCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:02:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19706D4C9E;
        Thu,  7 Apr 2022 23:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yUfU77rU29Ug0Am6GhAJCd/BoIsDfP1OgWIu7qTm9p4=; b=4lnT1HMWxexe2GgqCPW2cj8JbN
        DNLd+Tl+sz2yoMSB/6z583gHFhIwWnHIMFsEpoFjrFLdReVTMDJoQKk55eK7O/44fRLL1cPP9lSkE
        42HRozXxTqqPx/InXETa7ceDD9di4rct6kkjbwqxVaNtSdBTlE1djGVasySilTJRTYUykElZXj0iF
        7QIDueY2gwSboHkpQv+rjXxVs6PqrLtU6fz95NVx8O8kA68dP9igPGUPnzSo4gx4ujlhVzspHHvE5
        58qvgNeaBklmLPnzeHSug34EYY+60VDZiLW94k3pumSa7//lNNPjyzwK9B4vsyXi5X9za0eWEVbow
        R9A2IJ6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nchfM-00FDnq-G2; Fri, 08 Apr 2022 06:00:16 +0000
Date:   Thu, 7 Apr 2022 23:00:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>, Shaohua Li <shli@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v1 2/8] md/raid5: Move stripe_add_to_batch_list() call
 out of add_stripe_bio()
Message-ID: <Yk/PcIxpGx3h6Skp@infradead.org>
References: <20220407164511.8472-1-logang@deltatee.com>
 <20220407164511.8472-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407164511.8472-3-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 10:45:05AM -0600, Logan Gunthorpe wrote:
> The call to add_stripe_bio() in retry_aligned_read() is for a read only
> and thus wouldn't have added the batch anyway.

This sentence is missing an object.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
