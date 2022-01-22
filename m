Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E2C496951
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 02:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiAVBzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 20:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiAVBzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 20:55:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7000CC061744
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:55:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n198-20020a2540cf000000b00614c2ee23b7so5811698yba.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BZ3G3fVahBgfvD1PLnJ5plGpaQB8Nz6YDD9CnFxwqWU=;
        b=aEbW4CX9WQLNRf8TXTJ9ga+wb0n51IyEkBz7WXrYST7gN5mBKYF91qrqGnDzgssZot
         nEL0UMTIPcqHSf4nSWR7CRctzdJjPqofUx8U5x6nNa1HUZGOZo57D4EmhwGcIjTCaN3w
         lW1nQe66DTUSHiD5VKgZS6WccVqsRZd7QIULAGjvy0J++NFhUdab7AOuFjz+bDNCdKlx
         R1HTe/FgHpcdnVS3PpaMpDkjJHR0EQoSQyHNmkWTlWkU1YeiaOhc6ZkBWagDkqor2a+v
         DWS6atwZf2OM2GycHWSgk7ieIAaWCkqIjgeLBbKW68Oal05mH0A45gkKnBkxC9Yc8eUI
         /dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BZ3G3fVahBgfvD1PLnJ5plGpaQB8Nz6YDD9CnFxwqWU=;
        b=0En0yuac2bempMahY6fQZs4mT6QuKEf6//QWhwiA8ErIooIA0G7CB28usDFXxN/678
         bFO0RE3r91u3Rw/hbtBvpAvyhFB1YR+V1TcHyphzwrM1IbHUaisoll3fc7RPkly0wLZn
         ouEpmATGK1PmLoeMtFy9o8rtEAgufxBS7JJZsItywySInikYQLQTw4OF3lr6GWtB8L5I
         27PAEyXSc95zGBombqsRXOQ7hnZH81pR9mi6wxRfnI7MPyUxY0+5oavBdIH7tYpOkYwu
         q+rbVe0UP8JWh/6vMPGsh609GlL+tLUjGPH0Un6FCXFt2bv3M6TZeCKGwcmi1dzB6pMr
         3X8Q==
X-Gm-Message-State: AOAM53320HzrM5eXfNFB6bQI8+MF5u9C5El9vDOjFsiotBtLJLGs4N8F
        QgKJTuO0Xu3ouOnMwPoT1FCMsEixqBI=
X-Google-Smtp-Source: ABdhPJxatmGvxKtH2Ij5NF6AJZsNOmRCLZnAsEgBIK9ESq37zb28PEXs1VyvxtWxHoUVP2ow/kbMVnbzGMY=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:e346:6a9d:2ca2:5c1c])
 (user=badhri job=sendgmr) by 2002:a0d:c1c3:0:b0:2ca:287c:6b9e with SMTP id
 00721157ae682-2ca287c6df0mr27b3.67.1642816531219; Fri, 21 Jan 2022 17:55:31
 -0800 (PST)
Date:   Fri, 21 Jan 2022 17:55:20 -0800
In-Reply-To: <20220122015520.332507-1-badhri@google.com>
Message-Id: <20220122015520.332507-2-badhri@google.com>
Mime-Version: 1.0
References: <20220122015520.332507-1-badhri@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v1 2/2] usb: typec: tcpm: Do not disconnect when receiving VSAFE0V
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>, stable@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With some chargers, vbus might momentarily raise above VSAFE5V and fall
back to 0V causing VSAFE0V to be triggered. This will
will report a VBUS off event causing TCPM to transition to
SNK_UNATTACHED state where it should be waiting in either SNK_ATTACH_WAIT
or SNK_DEBOUNCED state. This patch makes TCPM avoid VSAFE0V events
while in SNK_ATTACH_WAIT or SNK_DEBOUNCED state.

Stub from the spec:
    "4.5.2.2.4.2 Exiting from AttachWait.SNK State
    A Sink shall transition to Unattached.SNK when the state of both
    the CC1 and CC2 pins is SNK.Open for at least tPDDebounce.
    A DRP shall transition to Unattached.SRC when the state of both
    the CC1 and CC2 pins is SNK.Open for at least tPDDebounce."

[23.194131] CC1: 0 -> 0, CC2: 0 -> 5 [state SNK_UNATTACHED, polarity 0, connected]
[23.201777] state change SNK_UNATTACHED -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
[23.209949] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
[23.300579] VBUS off
[23.300668] state change SNK_ATTACH_WAIT -> SNK_UNATTACHED [rev3 NONE_AMS]
[23.301014] VBUS VSAFE0V
[23.301111] Start toggling

Fixes: 28b43d3d746b8 ("usb: typec: tcpm: Introduce vsafe0v for vbus")
Cc: stable@vger.kernel.org
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index b8afe3d8c882..5fce795b69c7 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5264,6 +5264,10 @@ static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
 	case PR_SWAP_SNK_SRC_SOURCE_ON:
 		/* Do nothing, vsafe0v is expected during transition */
 		break;
+	case SNK_ATTACH_WAIT:
+	case SNK_DEBOUNCED:
+		/*Do nothing, still waiting for VSAFE5V for connect */
+		break;
 	default:
 		if (port->pwr_role == TYPEC_SINK && port->auto_vbus_discharge_enabled)
 			tcpm_set_state(port, SNK_UNATTACHED, 0);
-- 
2.35.0.rc0.227.g00780c9af4-goog

