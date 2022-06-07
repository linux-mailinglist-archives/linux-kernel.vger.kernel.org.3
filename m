Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2625401E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343712AbiFGO5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343597AbiFGO5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:57:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E169F5079
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:56:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA05BB820BF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F41C385A5;
        Tue,  7 Jun 2022 14:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654613816;
        bh=sHzvGlVy0kLF8VbeUYrSjjQM5WU1NKoCg9+52u9vPq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nmgv2y98abPxiTcoaT7QHAfS6kT1GimV8V9fSky2ZT2BBF7b+qSAsgq06SIPjGOhH
         ZistjUzn/sGzPGHwTdGEnch6SBf9dQWoSiBwirnuH4nAQIAQMZd0OyJz1z9rrMzX9j
         JYzJJQQpVe6fSj9TBwGKsXBQIlmPpahxbQXwMNHpIdavpB1qhIjQuphjdeHr0jYPtN
         P8i4+m8UxT1t6dsOMia0ORBCFG6qlll7P4OW1mpg4SlZiF1JbRV+oy7NeXJQabmSJf
         nFU+yrlGK2UT1xlMyNj5TXMwfPCqr3bmEshpwr5Ya4ECz9GCs3KWs423qgPliRpPtP
         V9ofZgei1Yi0w==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        tzungbi@kernel.org
Subject: [PATCH v2 04/15] platform/chrome: cros_ec_proto: assign buffer size from protocol info
Date:   Tue,  7 Jun 2022 14:56:28 +0000
Message-Id: <20220607145639.2362750-5-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220607145639.2362750-1-tzungbi@kernel.org>
References: <20220607145639.2362750-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`din_size` is calculated from `ec_dev->max_response`.
`ec_dev->max_response` is further calculated from the protocol info.

To make it clear, assign `din_size` and `dout_size` from protocol info
directly.

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Add R-b tag.

 drivers/platform/chrome/cros_ec_proto.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 65191af5139c..629dce3e6ab3 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -449,12 +449,8 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 			"using proto v%u\n",
 			ec_dev->proto_version);
 
-		ec_dev->din_size = ec_dev->max_response +
-			sizeof(struct ec_host_response) +
-			EC_MAX_RESPONSE_OVERHEAD;
-		ec_dev->dout_size = ec_dev->max_request +
-			sizeof(struct ec_host_request) +
-			EC_MAX_REQUEST_OVERHEAD;
+		ec_dev->din_size = proto_info->max_response_packet_size + EC_MAX_RESPONSE_OVERHEAD;
+		ec_dev->dout_size = proto_info->max_request_packet_size + EC_MAX_REQUEST_OVERHEAD;
 
 		/*
 		 * Check for PD
-- 
2.36.1.255.ge46751e96f-goog

