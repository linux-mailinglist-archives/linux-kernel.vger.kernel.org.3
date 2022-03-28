Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F1E4EA1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345920AbiC1Urz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345664AbiC1Un0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B65666ADB;
        Mon, 28 Mar 2022 13:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFB42B81202;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E69C340F0;
        Mon, 28 Mar 2022 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500102;
        bh=lnro/6UV02jSjWrQ0SysMDI1v1hK0XcwWyaOXFLLFAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ga4yUIhF+ZsImo7V1iUqWWtmT4e8r0v4nZ+WAItPZD3YIHNxWrDbclbZpQAWavZg1
         ubZaoO5+zFPFOxGouyCV4UXLNabCIUyT7stkDuxurwUsSAwR/rDffFG9+4chkdjjt9
         YHJ57V1M2VYOArdZATliyVkJ7+TIV8NuHNW8T4pfqqG+52usSGYsuozMLfCZYXwTYC
         YOclHTKt3+4UgvUpXKKjsls2fsuHewy5q4V6lCrbRhnlCGRUsOxixCbTrc/eMvkisk
         5O1xkZzI/vzT9AE729CjVctIfLdIb1eQqe3Qa5pX7uKWl8LTEq/1QiyXSr4tkJBOhC
         fuSvWRjtDWXMA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lc4-25; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 04/26] media: dvb-usb: Add helper macros for using USB VID/PID
Date:   Mon, 28 Mar 2022 22:41:16 +0200
Message-Id: <f82e376dea2e9b922f51a03d1e7730b03e49cc7d.1648499509.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648499509.git.mchehab@kernel.org>
References: <cover.1648499509.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use designated initializers and to avoid avoid big lines
at the USB ID tables, define some helper macros.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/26] at: https://lore.kernel.org/all/cover.1648499509.git.mchehab@kernel.org/

 include/media/dvb-usb-ids.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index 9577cae8c73b..5ae55c20912e 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -10,6 +10,14 @@
 #ifndef _DVB_USB_IDS_H_
 #define _DVB_USB_IDS_H_
 
+#include <linux/usb.h>
+
+#define DVB_USB_DEV(pid, vid) \
+    [vid] = { USB_DEVICE(USB_VID_ ## pid, USB_PID_ ## vid) }
+
+#define DVB_USB_DEV_VER(pid, vid, lo, hi) \
+    [vid] = { USB_DEVICE_VER(USB_VID_ ## pid, USB_PID_ ## vid, lo, hi) }
+
 /* Vendor IDs */
 
 #define USB_VID_774				0x7a69
-- 
2.35.1

