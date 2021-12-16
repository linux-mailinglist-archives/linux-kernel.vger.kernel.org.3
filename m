Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2F7477B16
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbhLPRwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhLPRwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:52:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931A3C061574;
        Thu, 16 Dec 2021 09:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n+g+lvGHdNpf0xfA7DkfKHlGpYO/TxlL80W/2ejeooc=; b=yGXnQBZeYfX3/CxKKNTMt8PT6R
        /KPGGxM+3pQVbqMdLqIjGsfudFQa/6j9/+MohpGme9OFJXJrnxQe6Uyn1krHhKJxBhBEX1CO7lPyJ
        svc8VGOt+2lOhjlsaA58JiN1yN9nY72z92noGBU+SO8FcnpFl0yWgj9csFO8h1klEc42fTjDVLNm7
        S690vyG6vQS8TEPMNNi3Gi8H6SYIVYhl0BG7dnYVT+kD+Ny3hyxnTko8a0pX/tvfgJ0csG9L99dqJ
        CXZ3ofcFXz8NDtvbBIYzzG4Y8JNK65BHq1oeCde/etMippN6i+qqLnoKdo745RkmvBuamUo5oYokU
        Uap46I2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxuvn-007281-DK; Thu, 16 Dec 2021 17:52:39 +0000
Date:   Thu, 16 Dec 2021 09:52:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Miko Larsson <mikoxyzzz@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] zram: zram_drv: replace strlcpy with strscpy
Message-ID: <Ybt8554NZpscKx2K@infradead.org>
References: <20211215192128.108967-1-mikoxyzzz@gmail.com>
 <20211215192128.108967-3-mikoxyzzz@gmail.com>
 <YbsRlDYT2BfgrXRX@infradead.org>
 <20211216160021.1b9e6d87@zenorus.myxoz.lan>
 <Ybt8wY3U2ETjQijH@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybt8wY3U2ETjQijH@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 09:52:01AM -0800, Christoph Hellwig wrote:
> On Thu, Dec 16, 2021 at 04:00:21PM +0100, Miko Larsson wrote:
> > Thanks for the heads-up! That only seems to apply to the assignment of
> > 'file_name'. The usage of strscpy seems to be correct in the other two
> > cases, though (since they're char arrays.) I suspect I might be wrong
> > though, since my knowledge of C is shabby at best.
> 
> The second one also sounds like a case for memdup_nul.  That adds a
> memory allocation, but it keeps all the checking nicely encapsulated,
> and the last one should be fine with a plain old mempcy.

sorry, s/memcpy/strcpy/
