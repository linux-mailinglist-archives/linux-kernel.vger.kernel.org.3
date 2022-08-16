Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4E4595375
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiHPHJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiHPHIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:08:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CB12DEEC3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 20:34:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-329a474c437so87705777b3.18
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 20:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=oMq/Q0WHMdmeoiF7vE7Sk5AVWHJOEA/+2leGxl7BaOM=;
        b=jEX3tw6kAvwKDBcJUacrjtB/w8b83gno5Cqq2GKEkaxcB8D5G2hK2C9IeD9ZiSL3tJ
         ngYwklOzyYTyZGmcBptO6SjQhS5hb+Ro02RbJ7EOUdQKCKjBrE9Pc/5Fb68lLooOvjom
         tGzM1FAXVxEAu9ybLouoni/W0u1AXiGel2Otzu0JQy/f+v3Qe+5cMFPmx+6SheXBqv/0
         TacO5kK23T+qrtlWrsjwdiZ/9KSsDinphR5deklejHbTelyiDw62FXidu/RcD/2eVDxb
         gv3q9+gWXyQCl1Cm6PEIf+nOFiL2V3ujC2VBDjsIRKBRkCKzcTv8Rpn2YFKs9z4sRS/I
         7qsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=oMq/Q0WHMdmeoiF7vE7Sk5AVWHJOEA/+2leGxl7BaOM=;
        b=ja5ybfG6VHu6ZC3mE65lrm/UWdcLStk0y2ACY0T1t9tvYuFWyKwth2mFuMUerIpOP1
         usZ/IjJxkDpNp8jrE4/xzss1Ua63UbuquTJf7evrvgXxzigrWT88HQ5GZarWLJz7iy0F
         wvg96mEjsmoxbn+ITQmgPWbGRKfkUDKLkJ5wVpOiIqunMgwBHebOEptjzD6zq9ADwUKA
         zgmGMFzqJbRrhovCaVAMzVz94O0rx3syj3muzV5y9HucqtMoel5MYg5PTilmzYJDHZIc
         pb2vNPczjbygau+y0cRuCNG57LR8HAw4iiq44ehSLc2tT1LsOO/KKZfjw7qfur+XjlLx
         88bQ==
X-Gm-Message-State: ACgBeo2JzWbPa6t+6IBcoxlKMMeIMCWKq27DBbV17UV2b0quxldGNHdW
        xsFlqblqQSa5PgLoj4ZM7SDEZc6E7c4=
X-Google-Smtp-Source: AA6agR6KjiGB15ddrWa5pYYcMxKojrKX+siy+E/PK6VYC4sBn9NBPVjOxLyJ83WGbD10odAgr/A2D35Jupo=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:d4d8:f172:2a2f:bd53])
 (user=badhri job=sendgmr) by 2002:a0d:fd05:0:b0:329:3836:53ac with SMTP id
 n5-20020a0dfd05000000b00329383653acmr16017944ywf.455.1660620843599; Mon, 15
 Aug 2022 20:34:03 -0700 (PDT)
Date:   Mon, 15 Aug 2022 20:33:55 -0700
Message-Id: <20220816033355.1259400-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v1] usb: typec: tcpm: Return ENOTSUPP for power supply prop writes
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>, stable@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the port does not support USB PD, prevent transition to PD
only states when power supply property is written. In this case,
TCPM transitions to SNK_NEGOTIATE_CAPABILITIES
which should not be the case given that the port is not pd_capable.

[   84.308251] state change SNK_READY -> SNK_NEGOTIATE_CAPABILITIES [rev3 NONE_AMS]
[   84.308335] Setting usb_comm capable false
[   84.323367] set_auto_vbus_discharge_threshold mode:3 pps_active:n vbus:5000 ret:0
[   84.323376] state change SNK_NEGOTIATE_CAPABILITIES -> SNK_WAIT_CAPABILITIES [rev3 NONE_AMS]

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index ea5a917c51b1..904c7b4ce2f0 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6320,6 +6320,13 @@ static int tcpm_psy_set_prop(struct power_supply *psy,
 	struct tcpm_port *port = power_supply_get_drvdata(psy);
 	int ret;
 
+	/*
+	 * All the properties below are related to USB PD. The check needs to be
+	 * property specific when a non-pd related property is added.
+	 */
+	if (!port->pd_supported)
+		return -EOPNOTSUPP;
+
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
 		ret = tcpm_psy_set_online(port, val);
-- 
2.37.1.595.g718a3a8f04-goog

