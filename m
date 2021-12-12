Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D14747192D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 09:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhLLH6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:58:45 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:35064 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229449AbhLLH6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:58:44 -0500
X-QQ-mid: bizesmtp38t1639295793tlenb3pc
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 15:56:32 +0800 (CST)
X-QQ-SSF: 01000000002000D0I000B00A0000000
X-QQ-FEAT: ipjz9r0KCw45BcGJHR0/xo9gqDd0d055zbZMFckWOkH0n8oeRFwIdycKxt0Uo
        gn4b3CBWf394MRAbewqFy0XGKfUpzixd0x4FR7EMhtgDCBUHsv0rfyyxr6Cudp9wpUjryJm
        n57Lhhou7e1TPICZPsxutpFNToA8v6lXECcRrx2TXLRRPL6lJD5yy1cMEgXFXEpeXqs0b06
        ojAdGxjWhU8W7JcnxjYHi3bLQF/YAufNitHM/AMqSZRIoXAfQYiRUQvDdMIgTLIrTFBLtfi
        YMTuMdCZTx5BA2I2V4DfsHriXWkg9dXSShNVqu7/8LYaDAGiRhAwPLzYG1qqV0ajhpD4239
        d4nztsNQ7xmrRk5Ao9kTH/JHmCi/PsudzCd9xo2Wx4yWjZ7dag=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     linux@dominikbrodowski.net
Cc:     lee.jones@linaro.org, wangborong@cdjrlc.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: pcmcia_resource: return 0 if success
Date:   Sun, 12 Dec 2021 15:56:30 +0800
Message-Id: <20211212075630.349459-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial value of variable `ret' is -EINVAL, which is used for
returning the error status in `pcmcia_release_io' when errors occur.
But if there is no error in `pcmcia_release_io', `ret' should be changed
to a successful value to return. Thus we change `ret' value to 0 when
the function's status is successful.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/pcmcia/pcmcia_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
index c1c197292111..257181cb686f 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -409,6 +409,7 @@ static int pcmcia_release_io(struct pcmcia_device *p_dev)
 
 	p_dev->_io = 0;
 	c->state &= ~CONFIG_IO_REQ;
+	ret = 0;
 
 out:
 	mutex_unlock(&s->ops_mutex);
-- 
2.34.1

