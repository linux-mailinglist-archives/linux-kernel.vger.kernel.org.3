Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A20495651
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 23:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378066AbiATWXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 17:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbiATWXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 17:23:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45457C061574;
        Thu, 20 Jan 2022 14:23:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FB67B81E66;
        Thu, 20 Jan 2022 22:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FCDC340E0;
        Thu, 20 Jan 2022 22:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642717378;
        bh=Oc+tuApp+4Mu9kKJflp51DXGJYPh3CtLlHInz98uJnw=;
        h=Date:From:To:Cc:Subject:From;
        b=UdzqSMq9/oit3xhOkbUmT65YfIvT9mAEvqK/AEqnWGl67Yx4MoauRg+0dcYMNHTDb
         /UHz9pENgdPM2kELo6lrjwKmKyxLVrW3ZQ6G1nbOvTk7kkFNgFaL6VVpp4iFxveBWy
         1g9ge+fNHGWLDWFpXV5OUfLdTFfZsZCu7JKMqXUM1ba4HLEG8PByPth61Pb7jzuc6t
         kTYcrS2bCNC5UGyVETwAd1HZDrRLHMTrJTZWMPe+IQ3GDD7OGAgkpW227GUnbFTP7f
         iIMMKuiSd7aJEtN3AQ5Y8ifUyDGvNHmu+DKd1Xx4vY/Jgsp678lpRCiIl75Ee1RpPm
         QNndOvDPzrhYw==
Date:   Thu, 20 Jan 2022 16:29:33 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] usb: gadget: f_fs: Use struct_size() and
 flex_array_size() helpers
Message-ID: <20220120222933.GA35155@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() and flex_array_size() helpers instead of
an open-coded version, in order to avoid any potential type mistakes
or integer overflows that, in the worst scenario, could lead to heap
overflows.

Also, address the following sparse warnings:
drivers/usb/gadget/function/f_fs.c:922:23: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 25ad1e97a458..7461d27e9604 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -919,12 +919,12 @@ static ssize_t __ffs_epfile_read_data(struct ffs_epfile *epfile,
 		data_len, ret);
 
 	data_len -= ret;
-	buf = kmalloc(sizeof(*buf) + data_len, GFP_KERNEL);
+	buf = kmalloc(struct_size(buf, storage, data_len), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 	buf->length = data_len;
 	buf->data = buf->storage;
-	memcpy(buf->storage, data + ret, data_len);
+	memcpy(buf->storage, data + ret, flex_array_size(buf, storage, data_len));
 
 	/*
 	 * At this point read_buffer is NULL or READ_BUFFER_DROP (if
-- 
2.27.0

