Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0664B4611CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347665AbhK2KLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbhK2KJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:09:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D494CC0698C8;
        Mon, 29 Nov 2021 01:47:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 671C861296;
        Mon, 29 Nov 2021 09:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA04DC58337;
        Mon, 29 Nov 2021 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179276;
        bh=8QgHuLKT09qwmU7NQkYtwYyeui5thGFxIHL/EEuGkxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7ahT9S5YPTyEDpkiGtURf/JblJkTElHtNQQgTsE/jzdWILAYm8YqCRFVrnFN4f1s
         hEHR6WZkY6MFaqUtv3qek5r+PUyIWSRDzy+eSsukzmN4F9+ojVD2E1RsR32YsOrVpz
         Zz9LLs+NCoIY6asg0namKX80m1G/621XUWU1kNqEj+KrpzL1LqrjQmAjoSMz8kDVUr
         MchQ3Hr/uI6G0XwGI2xr1ebotLxtSv5v7q29pLKFKw58+iPDQzqiqKHebiGEGmW/4j
         lyAilsxO/ZPVbJ5frPaCk6F65n7V1boZQ6Iqb3Pcjrpv5+5hdt/CPh6dqD935Gz6+I
         PQXhbw0NQepmA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGM-000RBa-JH; Mon, 29 Nov 2021 10:47:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v2 11/20] media: lmedm04: don't ignore errors when setting a filter
Date:   Mon, 29 Nov 2021 10:47:43 +0100
Message-Id: <be579271678245559c0b3fc940c34fbf596acd2b.1638179135.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638179135.git.mchehab+huawei@kernel.org>
References: <cover.1638179135.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Solves a clang warning.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/usb/dvb-usb-v2/lmedm04.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/lmedm04.c b/drivers/media/usb/dvb-usb-v2/lmedm04.c
index fe4d886442a4..8a34e6c0d6a6 100644
--- a/drivers/media/usb/dvb-usb-v2/lmedm04.c
+++ b/drivers/media/usb/dvb-usb-v2/lmedm04.c
@@ -423,6 +423,9 @@ static int lme2510_pid_filter_ctrl(struct dvb_usb_adapter *adap, int onoff)
 
 	mutex_unlock(&d->i2c_mutex);
 
+	if (ret)
+		return -EREMOTEIO;
+
 	return 0;
 }
 
-- 
2.33.1

