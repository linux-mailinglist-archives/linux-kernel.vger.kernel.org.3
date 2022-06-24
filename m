Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679B1559453
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiFXHp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFXHpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:45:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D610522E6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:45:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m1so1999895wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0ZlmPLrZBq2C2GM7uxjJCPFVuBCp2JLIVhQIgplZtYk=;
        b=Kp2Nv1BQ1WXuHYS+r+amWX7zs4ExnkoARLCQ3YEZzS+pd3iLAehijDsI13VEWsRW39
         D+gWnHOT4eCVZ8kLJmNaB8a9XnR1PlXyrBk5KZe3RNkQOLC9GQbzsoE/Cfc7VxYBsjPH
         Ps8Bz1tau1dvnPaxZ1DXFfIIhgKzyJpC3gAqdyZuMB1OhhlLwv5kMdzCfcxlE1IsSD4Y
         lQJk/dygWkaMKBLbsK9dBAp9mVkQzuDL8Ew5QdAUE+hw19FMORJhUbg6Qkkh7/bNrHOk
         Zu3E1BJ5GQVbzW3Xq9GHoeuDkRsHn57ZobjtxEZxpCzAswM4EN/bg1vk60rozNnynm+X
         vV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0ZlmPLrZBq2C2GM7uxjJCPFVuBCp2JLIVhQIgplZtYk=;
        b=6BVZPuG9qVIOtzjRSqLCP58wZ/XrIKbCn60FB7N85RKa18e7b+dHyKTnFdFAgh8ZAf
         VQTrxwI6PlsKxBbL57P5dpTTsZ7iBEcOKEiOnhRL2E6ZsACietLw/T06EygWdz+ebqYz
         nrEdTSx2UbOrBuhTQXHfJHjJZDtL8v6SUT2VNO4gz2FDlupbsLp+Sw9nRnewvpn/7LvN
         yX+3MWMuPFDJvbL29QoiQ8uS4zXUGePnS/iJwLPWnUxgpuzwnYdsRmv4JB8d4LwRq/3h
         8Fyo65NvgGIsAjPaJWSBkInesgdMFRfwJv5JSB5GE1e1bwm14QOoW4oJoPzh8C3APpqb
         Yi6A==
X-Gm-Message-State: AJIora+AQxnKiWvMFE43tiWnei2JD1AGOHG94rJJQZGMUR6dJX8plzht
        8FHRi1b2UnaqjmDCnV0YgWqCaA==
X-Google-Smtp-Source: AGRyM1u229Xg0jnxyiwwGmz48kdjamFG0VBRWUfXHBmPxvLHYMUtXWbKweF8OrKj6IP0zuy0VJl2tg==
X-Received: by 2002:a05:6000:168c:b0:218:4523:c975 with SMTP id y12-20020a056000168c00b002184523c975mr11934867wrd.23.1656056753037;
        Fri, 24 Jun 2022 00:45:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:a0f3:21fd:ac8:ae79])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d4acf000000b0021b9c520953sm1508526wrs.64.2022.06.24.00.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 00:45:52 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        linux-arm-kernel@lists.infradead.org, etienne.carriere@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] scmi/optee: fix response size warning
Date:   Fri, 24 Jun 2022 09:45:49 +0200
Message-Id: <20220624074549.3298-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some protocols check the response size with the expected value but optee
shared memory doesn't return such size whereas it is available in the
optee output buffer.

As an example, the base protocol compares the response size with the
expected result when requesting the list of protocol which triggers a
warning with optee shared memory:

[    1.260306] arm-scmi firmware:scmi0: Malformed reply - real_sz:116  calc_sz:4  (loop_num_ret:4)

Save the output buffer length and use it when fetching the answer.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Tested on sudeep's for-next/scmi branch

 drivers/firmware/arm_scmi/optee.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index b503c22cfd32..8abace56b958 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -117,6 +117,7 @@ struct scmi_optee_channel {
 	u32 channel_id;
 	u32 tee_session;
 	u32 caps;
+	u32 rx_len;
 	struct mutex mu;
 	struct scmi_chan_info *cinfo;
 	union {
@@ -302,6 +303,9 @@ static int invoke_process_msg_channel(struct scmi_optee_channel *channel, size_t
 		return -EIO;
 	}
 
+	/* Save response size */
+	channel->rx_len = param[2].u.memref.size;
+
 	return 0;
 }
 
@@ -353,6 +357,7 @@ static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *ch
 	shbuf = tee_shm_get_va(channel->tee_shm, 0);
 	memset(shbuf, 0, msg_size);
 	channel->req.msg = shbuf;
+	channel->rx_len = msg_size;
 
 	return 0;
 }
@@ -508,7 +513,7 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
 	struct scmi_optee_channel *channel = cinfo->transport_info;
 
 	if (channel->tee_shm)
-		msg_fetch_response(channel->req.msg, SCMI_OPTEE_MAX_MSG_SIZE, xfer);
+		msg_fetch_response(channel->req.msg, channel->rx_len, xfer);
 	else
 		shmem_fetch_response(channel->req.shmem, xfer);
 }
-- 
2.17.1

