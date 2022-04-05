Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A71A4F2C6E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 13:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242138AbiDEIg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 04:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbiDEH7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:59:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B59266F9A;
        Tue,  5 Apr 2022 00:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF676B81A32;
        Tue,  5 Apr 2022 07:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF8CC340EE;
        Tue,  5 Apr 2022 07:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649145295;
        bh=FNWouC3CoH6+dXI5kygOzexAVVRXN9qg89YVmFU1Dbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nj/CB5fL/1sxCXzU1DyGvcauNdbJgpM5DJNJhQfva7/YbekeeNF1YRG4yhEl31zE0
         WA0tJOrGHvbqVoYOKe14vkL8VvCtk/4PfVfmKOWKY09FXfvUaAS0aK8SXnpYAIhCUR
         brmUk+ssOURpjQF1TcWaKsJX465uUgMSWCaVZH/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0356/1126] media: cedrus: h264: Fix neighbour info buffer size
Date:   Tue,  5 Apr 2022 09:18:23 +0200
Message-Id: <20220405070418.078301947@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

[ Upstream commit fecd363ae2d5042553370b0adf60c47e35c34a83 ]

According to BSP library source, H264 neighbour info buffer size needs
to be 32 kiB for H6. This is similar to H265 decoding, which also needs
double buffer size in comparison to older Cedrus core generations.

Increase buffer size to cover H6 needs. Since increase is not that big
in absolute numbers, it doesn't make sense to complicate logic for older
generations.

Issue was discovered using iommu and cross checked with BSP library
source.

Fixes: 6eb9b758e307 ("media: cedrus: Add H264 decoding support")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
index b4173a8926d6..d8fb93035470 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -38,7 +38,7 @@ struct cedrus_h264_sram_ref_pic {
 
 #define CEDRUS_H264_FRAME_NUM		18
 
-#define CEDRUS_NEIGHBOR_INFO_BUF_SIZE	(16 * SZ_1K)
+#define CEDRUS_NEIGHBOR_INFO_BUF_SIZE	(32 * SZ_1K)
 #define CEDRUS_MIN_PIC_INFO_BUF_SIZE       (130 * SZ_1K)
 
 static void cedrus_h264_write_sram(struct cedrus_dev *dev,
-- 
2.34.1



