Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A954D476EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbhLPKOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbhLPKOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:14:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3CDC061574;
        Thu, 16 Dec 2021 02:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WWYDTeaHlkuwbTwXZ8Y/aKUsN3E2JPUxKL0TpyOv9Jk=; b=A92k8sWkKfkYhh4iMl8Hy6r5s6
        8bjUCghBxIUnkovIxC/T+fEzAVMTGL7m48GqkzgFmAX+e7lwVW1PA9O+5b7TBZ2wRSJXM/iQZbNnz
        gBm9omNtP0lFThjAy6mVCgpYk5m9o9CXS0NV3c+N0od9i5dQgxQrMlLwjtqZvNYPqphvGB5Ou6hBm
        6fi4zziTw4Tl/v5YHRsnmFa5SJnGor9IIJkx8Mk7hm68aoHgUVkOYVkVjaKrmOGLw6i72lqufie61
        btTHrSmnjjzhec01XrkkEFkAcsaVsd/1YZIU+sZtvjiugKhC/Yfje54IqbQQKLWkUVFcM1OOu5J+F
        nx50+jNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxnme-004moa-Nk; Thu, 16 Dec 2021 10:14:44 +0000
Date:   Thu, 16 Dec 2021 02:14:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Miko Larsson <mikoxyzzz@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] zram: zram_drv: replace strlcpy with strscpy
Message-ID: <YbsRlDYT2BfgrXRX@infradead.org>
References: <20211215192128.108967-1-mikoxyzzz@gmail.com>
 <20211215192128.108967-3-mikoxyzzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215192128.108967-3-mikoxyzzz@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 08:21:28PM +0100, Miko Larsson wrote:
> strlcpy shouldn't be used; strscpy should be used instead.

I think the proper API to use here would be kmemdup_nul.
