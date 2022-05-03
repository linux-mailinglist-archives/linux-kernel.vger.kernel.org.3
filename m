Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B83517E06
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiECHFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiECHFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:05:49 -0400
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980452317D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1651561334;
        bh=9FDEMiTl+z/wCxW+Guf4auIR1peUkb2NVkPH/qZqMi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Xv9RNCmgpzLO0beVYFDlbaCwa63ue9gKrW6OdUzUCRdLoo+QfWWpdrO7pqCwrAAIv
         A2qSp1OSdg9TQnFiF73JUs0DZDbdKm9K4OtJTr3FmFqCuXCcMKYK177AtB+XmJfTKP
         olERmL6Jw3tTlCMEdl4akD9JwFr6avbtNYCNlz58=
Received: from localhost.localdomain ([59.172.176.242])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id 8C32A28; Tue, 03 May 2022 15:02:12 +0800
X-QQ-mid: xmsmtpt1651561332t81yuboxp
Message-ID: <tencent_1545FC5783843197E6C2738852E884C7280A@qq.com>
X-QQ-XMAILINFO: MOZWoti2yOjR1WCeDO5N20SjV776IuChw0vIo2aGoKJDSYZyhu4uwROr7MlBXp
         rOGVD9kGn1+LpU3ojVGy8+Iy+S20GBygglWJ4kuPUNMvi99a02BckC5aW0RtbsfCL4gcPYewBsmt
         4n80gh1/7M2hySPUT5HTdnLd1XeMIpoSAqNopkiBcvG54VLFfDtk8uDIszUiVtr9iu2uXvNlkVWV
         7/rCDH/9gGAqBxGqEtZ4UzIpM5A14UEnLqiHybjH7qaAHkpRzgkGc/mJIqb6jSyLvszR3jPlkuQH
         yUn9f42x7Rcd15GaZHCIIjuNNJzjJWhnbk+mR8WW794ikqrvVjdA3lTWmHuE7AZpXBdK/EXjXqUD
         IpH1/8+K6rsgVO3L/GDVm3Wd/MypcwLAjeAvXXETW3Ktv7Cs1uhsj+IInxKajlxJOUBAUOaz07nP
         xUiDAi/1RFp5xtEmmar2f4e1c0eMDRSOaIjsDyJGEV5y+WVjmQ9Q/86bvWBpkbEURLAQH6ixJ1FJ
         kgXlI6FQpjjJBHUB7l9JxYhxYHGOIxBxV/PtPpsjCDCQS133Qpmrgu4kdM8Duo25erQFs48O7NvO
         hxL0oF6whaK9iXG4mrtpdHU3yqa+RvMPx2hVmHvVfx5FZEK0uvEoCeuBe0eqgG3E6tW/Tfd2Fq5u
         M5Z4Peq3x27rCD9A9A+jKbZ6Wk69tGhW89iBj5arnitRdZR+whGrGeXusOGyBJ9g4D3L0Gq/C7KG
         mXjsWKGM0TII9fM5G4MixMJzrJx2O52xGTLzNyobWZysPf8KbjnEUWYiY+PfWJ5ZQTUiKMFtLXhB
         jamR8k8EeddpYP7H7Md7pY57b39neajBjKp4xF1e3C2E0/TUvuMsoKkE9PgUuW5Mk0VR+YJ7G/Bf
         jD16BAHp0mtzl/jR+ZGtNwpLGk9CYd8AgpiVs4qRb8siF69FAg03MhR8/nqu2qcL96oTvg/UddsL
         tNm7TgVOgiGzUFqVZp0DyWtCm71bHeSusyzNcv8bjuvCHhCJaSdQ==
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH 10/12] staging: r8188eu: fix potential memory leak in rtw_os_xmit_resource_alloc()
Date:   Tue,  3 May 2022 15:01:51 +0800
X-OQ-MSGID: <20220503070151.3369-1-xkernel.wang@foxmail.com>
In-Reply-To: <tencent_A80380E4306BE7BA73E450F084232B4DFC0A@qq.com>
References: <tencent_A80380E4306BE7BA73E450F084232B4DFC0A@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In rtw_os_xmit_resource_alloc(), if usb_alloc_urb() fails, then the
memory `pxmitbuf_pallocated_buf` which is allocated by kzalloc() is
not properly released before returning.
So this patch add kfree() on the above error path to release it.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/r8188eu/os_dep/xmit_linux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index e430c64..0c448e0 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -75,8 +75,10 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
 	pxmitbuf->dma_transfer_addr = 0;
 
 	pxmitbuf->pxmit_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!pxmitbuf->pxmit_urb)
+	if (!pxmitbuf->pxmit_urb) {
+		kfree(pxmitbuf->pallocated_buf);
 		return _FAIL;
+	}
 
 	return _SUCCESS;
 }
-- 
