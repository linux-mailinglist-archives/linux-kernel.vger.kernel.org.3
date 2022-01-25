Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA3749BD58
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiAYUlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiAYUlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:41:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF830C06173B;
        Tue, 25 Jan 2022 12:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wTFIgfu16335Gx3oq+pioLGVCsaF9YtbWH5+gxe4W2c=; b=RB5vu3jOCzht8oUW3jFXMfbNde
        zkDIv2h22MrVwwCF0NQ+JiaArMaUuf45eEPgqPhak//kis3M125M97fsFMESuJYu2KUZllFg+YCIU
        03DYLlMciEfmy48mIZXBLPyjs3VanoVEvpqb042iJBIGUQUkn+bKqvINkzt0CY6vILdrNpVNvrF0N
        MHNzjEYNO58/0XqBRkSnxRBQdTaghYFsqpHXqS1mg+8NfspZoidYqgvHF/m0EnQUWsuXpnFy2lH2z
        aSocJbMrQ9BTwvjA9+P3IqGjNGoa40LPwxdiBRvFhIdXANhiRS5njITxeDvEzbC1gEqW9Z1UwT5Bg
        8y/S7F2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCScu-009WZ9-1w; Tue, 25 Jan 2022 20:41:16 +0000
Date:   Tue, 25 Jan 2022 12:41:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     snitzer@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] dm mpath: fix missing blk_account_io_done() in error path
Message-ID: <YfBgbLVOPWEy60bH@infradead.org>
References: <20220125122654.2236172-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125122654.2236172-1-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 08:26:54PM +0800, Yu Kuai wrote:
> If blk_mq_request_issue_directly() failed from
> blk_insert_cloned_request(), the request will be accounted start.
> Currently, blk_insert_cloned_request() is only called by dm, and such
> request won't be accounted done by dm.
> 
> In normal path, io will be accounted start from blk_mq_bio_to_request(),
> when the request is allocated, and such io will be accounted done from
> __blk_mq_end_request_acct() whether it succeeded or failed. Thus add
> blk_account_io_done() to fix the problem.

The patch looks good, but the subject is incorrect, this is not in
dm-mpath but in the block layer.
