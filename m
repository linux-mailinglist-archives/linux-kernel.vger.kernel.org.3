Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9395247E0A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347335AbhLWI5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbhLWI5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:57:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1143AC061401;
        Thu, 23 Dec 2021 00:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lMTdvEDzla3X9hzuHOeTk48GhbmrHG0cbOf/ry+Fl5E=; b=M0kwR9QHixHRcMs2Ytbdww0WZ0
        /MTmzpcHSAGTUVM5U0uKkRmnqyfKjqAhzcskXnZBCp8kmD2nNLEUwr/9zxKfb4qDcmDYA79mJakOX
        rtkaljSP7Ud/slpYIf8pBkx94JRIq/K5qk5LgL6TgRXb4Qgp91UdSaIubDMLZqWwzt3kaweBwvKvS
        H0ZjaQy8MitD98ubdlDqbpQApE34D3yaReh0HEoLlxK16y9wLmWmq6BTvvmo+T993qEFgbQfoglKb
        M27JdNDo4UOT8OV57uRgetuJcOyAV5A4yoElnh6543H0LEsS7spt/Nw8bmM3w+WT8iixJVb8ThRdz
        X+G1Cmnw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0Jul-00CMKw-VN; Thu, 23 Dec 2021 08:57:31 +0000
Date:   Thu, 23 Dec 2021 00:57:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: return specific error when pointer is NULL
Message-ID: <YcQ5+76XpcbcsotJ@infradead.org>
References: <1640226246-32691-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640226246-32691-1-git-send-email-wangqing@vivo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 06:24:03PM -0800, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> loop_attr_backing_file_show() better return specific error than 0 
> when pointer is NULL

Well, let's turn this into something that is not butt ugly then:

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7f4ea06534c2d..b9ee0a165b75e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -666,15 +666,15 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 		p = file_path(lo->lo_backing_file, buf, PAGE_SIZE - 1);
 	spin_unlock_irq(&lo->lo_lock);
 
-	if (IS_ERR_OR_NULL(p))
-		ret = PTR_ERR(p);
-	else {
-		ret = strlen(p);
-		memmove(buf, p, ret);
-		buf[ret++] = '\n';
-		buf[ret] = 0;
-	}
-
+	if (!p)
+		return -ENOENT;
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+
+	ret = strlen(p);
+	memmove(buf, p, ret);
+	buf[ret++] = '\n';
+	buf[ret] = 0;
 	return ret;
 }
 
