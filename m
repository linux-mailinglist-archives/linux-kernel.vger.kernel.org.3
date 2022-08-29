Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E1C5A4485
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiH2IGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiH2IGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:06:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721A01FCD9;
        Mon, 29 Aug 2022 01:06:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DEA260BFA;
        Mon, 29 Aug 2022 08:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A564C433D6;
        Mon, 29 Aug 2022 08:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661760404;
        bh=uzRzujJGOciKFu8Gj92NDh4cjfgPZuOyniIH4EBM6L0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkV1hBnMTtFs31/OoT7nHFXclGoGovwCvc6BJT1RFrmTvsYuc6NfBzL4ijxrKCK3K
         s2oJhERJvyM/WXLRE7zKpw53jEV0rEvw/eNkvwZGxVm2CeOMlJTbgs3h7w/92i9EP9
         vNHseRsXpbrgQJpJlDvcmsIZwD9b+Afn055Dms9ljMlGbDJvqXO6nX1x7wkHLX0xrL
         D861MXn07Ww0K4rrsMQ1yhBahLxr2lVaQIIo+tIM+LijrImxJxJnOb62hjti7smfCs
         Dt3UsTZD+txsK1jqy3VXWSKvb2ynKENG+i6uILQ6xpl6Nh8uGQKuzMOHd9PSPD9/Wn
         LQG9x8upXhMXg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oSZnI-0007jY-6p; Mon, 29 Aug 2022 10:06:52 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/3] misc: fastrpc: increase maximum session count
Date:   Mon, 29 Aug 2022 10:05:31 +0200
Message-Id: <20220829080531.29681-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829080531.29681-1-johan+linaro@kernel.org>
References: <20220829080531.29681-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SC8280XP platform uses 14 sessions for the compute DSP so increment
the maximum session count.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 6e312ac85668..5d9e3483b89d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -25,7 +25,7 @@
 #define SDSP_DOMAIN_ID (2)
 #define CDSP_DOMAIN_ID (3)
 #define FASTRPC_DEV_MAX		4 /* adsp, mdsp, slpi, cdsp*/
-#define FASTRPC_MAX_SESSIONS	13 /*12 compute, 1 cpz*/
+#define FASTRPC_MAX_SESSIONS	14
 #define FASTRPC_MAX_VMIDS	16
 #define FASTRPC_ALIGN		128
 #define FASTRPC_MAX_FDLIST	16
-- 
2.35.1

