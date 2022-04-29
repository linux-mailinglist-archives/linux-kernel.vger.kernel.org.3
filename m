Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F0A51487D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350011AbiD2Lsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344925AbiD2Lst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:48:49 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E9AB36B5;
        Fri, 29 Apr 2022 04:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651232729; x=1682768729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=E9/sHe9nOwDqji6H6q4rBHu9AKbC9okRvdSnwVkmrPE=;
  b=uzr1dyutnVqsR1kBF5TpumAvYAOsFt+7vx3tstGC2MFRb8lj1lBLCFq9
   RoJ1n3XiqzAULC0SRiVGnyZnBNZ3Erc9XvCj6p29Z2rnvU+GN3ZUpI2sq
   XIWhH0BzIUSqt3o+GbSpuJM97pGYEi7QC26moH93ZC3Cit3FzHowGhEAE
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Apr 2022 04:45:28 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:45:28 -0700
Received: from blr-ubuntu-242.ap.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 04:45:26 -0700
From:   Naina Vaskenly <quic_nvaskenl@quicinc.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        lijian <lijian@yulong.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kumar Anshuman <quic_anshuk@quicinc.com>,
        Naina Vaskenly <quic_nvaskenl@quicinc.com>
Subject: [PATCH V0 1/1] media: v4l2-core: Enable reserved field of v4l2_event
Date:   Fri, 29 Apr 2022 17:15:03 +0530
Message-ID: <a24b19a835430064a0677e04d746f72ae7987a3c.1651223992.git.quic_nvaskenl@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1651223992.git.quic_nvaskenl@quicinc.com>
References: <cover.1651223992.git.quic_nvaskenl@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'reserved' member of struct v4l2_event is currently not enabled.
This field can be used to transfer data, if >64 bytes of data
has to be sent. Hence, added this change to copy the reserved field in
__v4l2_event_queue_fh.

Signed-off-by: Naina Vaskenly <quic_nvaskenl@quicinc.com>
---
 drivers/media/v4l2-core/v4l2-event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-event.c b/drivers/media/v4l2-core/v4l2-event.c
index c5ce9f1..3d741cb 100644
--- a/drivers/media/v4l2-core/v4l2-event.c
+++ b/drivers/media/v4l2-core/v4l2-event.c
@@ -137,8 +137,10 @@ static void __v4l2_event_queue_fh(struct v4l2_fh *fh,
 	/* Take one and fill it. */
 	kev = sev->events + sev_pos(sev, sev->in_use);
 	kev->event.type = ev->type;
-	if (copy_payload)
+	if (copy_payload) {
 		kev->event.u = ev->u;
+		memcpy(kev->event.reserved, ev->reserved, sizeof(ev->reserved));
+	}
 	kev->event.id = ev->id;
 	kev->ts = ts;
 	kev->event.sequence = fh->sequence;
-- 
2.7.4

