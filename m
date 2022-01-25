Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1B549AB6E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S255001AbiAYEx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:53:57 -0500
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87]:34847 "EHLO
        out162-62-57-87.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357922AbiAYEl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 23:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1643085678;
        bh=7945bRSZNev1fxXSkPlWshLRauTragynEtURS2/Qcwk=;
        h=From:To:Cc:Subject:Date;
        b=iWTUipZzfnLiwCESfjSfwEnRhmbz67xL6xZXn0xyobZjOiSINFDSP17azsg/J1WBL
         fA3RUhFyJDh5Q1TaUaAp+Gt9BijY77qkYemPSQuz86P4y1u97QzV1lLkn4dFymzbCX
         BTsAixSxJff1DPbsg/h/imOV8+TAxZDDiN9rGugc=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc7.qq.com (NewEsmtp) with SMTP
        id 1F808456; Tue, 25 Jan 2022 12:07:56 +0800
X-QQ-mid: xmsmtpt1643083676t5wn7vuix
Message-ID: <tencent_C52895FD37802832A3E5B272D05008866F0A@qq.com>
X-QQ-XMAILINFO: ObFHHlrAm440WFqxXpfy2OMEFUwmcfhEw6FCfS53x9Jq1IXUo3IRffNwG19du7
         RFda4CCqLn7tKxMtg2r4ZJlfK7OIeRj8PxwhqhTsYLjMrvmT+MpphFrU/HqwQoDS0qF0zkUT/QkN
         KK5rzw6P+UCzGljmG/7iTSDvk9KDtHciHw5m72OPt4Km1W+9P7u5+nidc9lPCSgEE9ZjEWOHZxRb
         i0BrVbOiS3CgeXPIi4L+sbaYVmagqZJiFEh6WMkGdF+zpprInFxd7QnSGbh98lC8HHq7nSCYU13M
         mFZMCRO5uTFH8E5FivSS+wgpbvLGHwMaBTYk33rLEm1gEa8lDrnJniLpKa35d0CbhSceO2/XCjL7
         DJBdlnambp7sstXFU+BQcEbGYFVRw8+OkGjUvqwB/hZKvDFMwGjmNY2UOPRAV8u8sSNZZCtvLuJk
         t4CUMtf6QRjubs+2wyFj0IvDjiJC8BaTbUMNt8SgGKogKbq2iowQJJm1hEjB5vjbKvnYs2ygIqL7
         /tQ8Yj1mzOfFSnOdSkXI8yr+nU6+5gQJaJHk0+24sjaGcVvILs7RutH3/RBaYL3pRemjyYNbxX5L
         9RW2Ioe6bOeGFXFWnXmqIT7S4b+QGgwcUHd06ddWva2yXCDw4xDcFTVfuzOHsadjOWreFNPeewQX
         CecQp7hb/LaoETFR3g2G9k9+egWCTZqr8jjijNhQVL5yNwkt46gp200NHjq0j9R54ZzyeBSJ3hBX
         dr4cX7sNgJXFQ7j8PPq9HGdoFVOmPiDVH5CxN1DwTrkO5xjzvrxCXi9Q+mGFk+RX2TozD3uBTDc6
         h8FBPgylsNJcRegAdtdloJgc7HwD8CVZY4Q4t19sryAvDCERYE0N7KtLjRwwQd07xrlmvj94RgB1
         O1QYkBEkBO4vV0Hpj8AAJfVtaa6HnTzkBJLPS0EJ5sKgA6gwPcOlCqfx2l3zlXpA==
From:   xkernel.wang@foxmail.com
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] tracing/histogram: fix a potential memory leak for kstrdup()
Date:   Tue, 25 Jan 2022 12:07:15 +0800
X-OQ-MSGID: <20220125040715.2057-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kfree() is missing on an error path to free the memory allocated by
kstrdup():
> p = param = kstrdup(data->params[i], GFP_KERNEL);
So it is better to free it via kfree(p).

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f01e442..1fac14c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3578,6 +3578,7 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 
 			var_ref_idx = find_var_ref_idx(hist_data, var_ref);
 			if (WARN_ON(var_ref_idx < 0)) {
+				kfree(p);
 				ret = var_ref_idx;
 				goto err;
 			}
-- 
