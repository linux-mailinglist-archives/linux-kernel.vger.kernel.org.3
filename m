Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4940C49694F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 02:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiAVBzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 20:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiAVBz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 20:55:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CC3C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:55:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n196-20020a25d6cd000000b006139bdfade9so21367589ybg.17
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=w+J03WX3dcYDAp4cPk2KTKsHcLGHwowGZLQnlpzXNlE=;
        b=R+Q2VH/AcsjDDr+ApptRh7eTbb51+F1grMcFt9Rf2pdd7udJOBFKiNXuHYRPt3vT2H
         1nd49QaT08vlGTVFrThrms/tXZAAfFnLlXINYts72GS7vRZbF0d7SRb6KjJvJ1klOijl
         HxRg8PspMA5IjWvGuSzjL1cW7Uq+o3G8kCTYm4BgymesQPpQ/UN9xlrhS+rV825X38um
         dIsVF91gbBMe3+0bIY+lXJK4kIuzIFpqtdz1C3zppnfPR9HdaIVZTf+MXsCDdwYgUwKp
         L59ke7gbbLhsNsCB0/DCCIdA+WuTdGSEi4BAaR2c9DHRJvjdrLqztI1C8Q3L2jqq256y
         D1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=w+J03WX3dcYDAp4cPk2KTKsHcLGHwowGZLQnlpzXNlE=;
        b=GN6BlDeKc9twLMiuOhQe0alWj74E7mlWHUwclRQc5E+3/tcqZgG86i5aIOWE1ugnA7
         WfZawmR+c0ulvgcN+b0EjSraliDCFcM0+K/eGXE4DajrrP8Y5mbctfwQ/ZVlje9WwhsL
         35syOrKf/5TprjyHZTnBlO0mBkWdegFRhOE29fTwz+mULgo6iZuGrwg84rL5T2Frbiwu
         P28fnaHf9mkE2QuEshQ/ROtdz2GAetO8HIPi2DWZ0vseQcy4C5WYHi14m1j7Lw994zm4
         B5CD4VoxtO3RPS+VVNL3o7WfSjsZD7Zd3F6VJdCXbqqyBSj00Qzr/PmJnxunzMIePb7V
         pWgw==
X-Gm-Message-State: AOAM533ss8lyBr8fTjMJ3pDpjRyjZvJPS3Yx2qxUx1rhphbNFaDc3cPs
        FVKT3yjH/bO5Hp9DOVYM4SJCvxGzJc4=
X-Google-Smtp-Source: ABdhPJxbMfwag8YhXW+FSnTNUaijX6hQWAmIoRvZruMOQxHrjVZNICee2Trn1oql85aYSyXHs1+59ct8adU=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:e346:6a9d:2ca2:5c1c])
 (user=badhri job=sendgmr) by 2002:a0d:d8c8:0:b0:2ca:287c:6beb with SMTP id
 00721157ae682-2ca287c6e3bmr07b3.144.1642816527942; Fri, 21 Jan 2022 17:55:27
 -0800 (PST)
Date:   Fri, 21 Jan 2022 17:55:19 -0800
Message-Id: <20220122015520.332507-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v1 1/2] usb: typec: tcpm: Do not disconnect while receiving
 VBUS off
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
back to 0V before tcpm gets to read port->tcpc->get_vbus. This will
will report a VBUS off event causing TCPM to transition to
SNK_UNATTACHED where it should be waiting in either SNK_ATTACH_WAIT
or SNK_DEBOUNCED state. This patch makes TCPM avoid vbus off events
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

Fixes: f0690a25a140b8 ("staging: typec: USB Type-C Port Manager (tcpm)")
Cc: stable@vger.kernel.org
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 59d4fa2443f2..b8afe3d8c882 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5156,7 +5156,8 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
 	case SNK_TRYWAIT_DEBOUNCE:
 		break;
 	case SNK_ATTACH_WAIT:
-		tcpm_set_state(port, SNK_UNATTACHED, 0);
+	case SNK_DEBOUNCED:
+		/* Do nothing, as TCPM is still waiting for vbus to reaach VSAFE5V to connect */
 		break;
 
 	case SNK_NEGOTIATE_CAPABILITIES:
-- 
2.35.0.rc0.227.g00780c9af4-goog

