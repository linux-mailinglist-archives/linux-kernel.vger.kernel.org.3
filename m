Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C064955E4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 22:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377762AbiATVSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 16:18:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60290 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242456AbiATVSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:18:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D998861884;
        Thu, 20 Jan 2022 21:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07916C340E3;
        Thu, 20 Jan 2022 21:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642713479;
        bh=8vLe+3vRBl+4dO3EZ6a5gaJmwld5AtI9w7i6K+Ckdy0=;
        h=Date:From:To:Cc:Subject:From;
        b=mrufb3EIK+jrdzU98CNotfSYG0SuglkelIIFpndca12AIJ+9QDHSEq/W4479rv4Aw
         7aSLJeCXAjywAGYvb74in0EArJpEEBuY5qJknlCg1FSfOqoAUjIjYYeyU0NLpdcPDw
         NnEPqcBEZfve1AC/vODlv6lapkB7hsXN9WCg/MxXfLEa7Dh9NbC38te3C92yeFw3JY
         TJ0Ola9vr6DCSR2UNWk6/Az4VBVNaS8nWaKpDWKEX14yD8nv/NqML1RA+rA/tt8RcT
         T6zzCs/6rxx5IqSPpXYjipW6BdMJ7kSFhLVLBnN5CnFSph7JRLZCAn+/vxq9DuWXlZ
         jJehLgHLdDRuw==
Date:   Thu, 20 Jan 2022 15:24:34 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] media: usb: pwc-uncompress: Use struct_size() helper
 in pwc_decompress()
Message-ID: <20220120212434.GA30630@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Also, address the following sparse warnings:
drivers/media/usb/pwc/pwc-uncompress.c:44:44: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/media/usb/pwc/pwc-uncompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/pwc/pwc-uncompress.c b/drivers/media/usb/pwc/pwc-uncompress.c
index 68bc3829c6b3..faf44cdeb268 100644
--- a/drivers/media/usb/pwc/pwc-uncompress.c
+++ b/drivers/media/usb/pwc/pwc-uncompress.c
@@ -41,7 +41,7 @@ int pwc_decompress(struct pwc_device *pdev, struct pwc_frame_buf *fbuf)
 		memcpy(raw_frame->cmd, pdev->cmd_buf, 4);
 		memcpy(raw_frame+1, yuv, pdev->frame_size);
 		vb2_set_plane_payload(&fbuf->vb.vb2_buf, 0,
-			pdev->frame_size + sizeof(struct pwc_raw_frame));
+			struct_size(raw_frame, rawframe, pdev->frame_size));
 		return 0;
 	}
 
-- 
2.27.0

