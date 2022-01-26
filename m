Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811C749C101
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 03:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiAZCAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 21:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbiAZCA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:00:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD881C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 18:00:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so45430990ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 18:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3UM8XKgMP3gqCK4oj/W0i074FevQzm4B+XlHTOgS0D0=;
        b=WCiqjcBOHA+dIeeTBnO8nVQSTbQsxMynZTM63mWgD7T1OssP7X752BVLCM3hrgzU/b
         5Vnnd4fiQMmxOAjhDmjxsGFXoEyac5/ML3FKVUgybDLVS7OFze4gfDm/ipObvE+cneaf
         8sIceVls3jSrRfom021ipI2HFYsBMw/+vHlkf/1qDaZsetp7xpmEJTHMmbeLriQVW6ub
         mMVFYefqoNMvJdgkMHyK4tDR7OAA6zJvl0l/F9s2oTqeUtYGgXTj68p7CYA12SHjDXCP
         KVUxmTW3l12r2ecYkfLFnqFczFrDTov1CQ09J9YYmrbWe9ILdXN8oYVavU04/n4prZkQ
         rU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3UM8XKgMP3gqCK4oj/W0i074FevQzm4B+XlHTOgS0D0=;
        b=upU7u1oRx81sHry4B0J3V+XtZhje0hLiD2DHTjqFgqKtSkIGLAsd73v4GSkp82iz2h
         8Q3G8gGwSU1vyDDXgdBo4DskYM6DwUsYBa0bUpGrPLcTAe/FMyXJsFw/RvCzTCNB9u6F
         Ypek5nas+45NOqNLU51XVMaN6PnluMCMF0HztVX4uJ6GUE/Qq3LjUAPM1LzJ1+Rn/MEy
         ZGxcGhHXSME5Dzw5o4mHAcsH2fmIXqUByX8qmozsH5iagOxwEEg/rCqAesN2q00bplw/
         pe34A3/pVJYXAsxCR3Ths+qEeGLpAJU1FMGBwlGJ2E0IRfZZrW7n2Ma1E2Xb4DjoC1+y
         vLSw==
X-Gm-Message-State: AOAM531gX7lbNB6ZgEw4m4psfZ6qgADLLy9vtvoy7NlSr6cVsVagTpGM
        WqUxnLD1XC8R+0XU8EENMhj9i1mBUTQ=
X-Google-Smtp-Source: ABdhPJyoVZnqQZBLsKxf6oSHvLwmIBoEVumXM0KPtMB0Vm9hcHCgmRPvIETN8lhxhNoUJh6jiYCCVFd+4YQ=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f4a7:8e16:f301:160])
 (user=badhri job=sendgmr) by 2002:a25:b9d2:: with SMTP id y18mr34554948ybj.615.1643162426054;
 Tue, 25 Jan 2022 18:00:26 -0800 (PST)
Date:   Tue, 25 Jan 2022 18:00:16 -0800
In-Reply-To: <20220126020016.3159598-1-badhri@google.com>
Message-Id: <20220126020016.3159598-2-badhri@google.com>
Mime-Version: 1.0
References: <20220126020016.3159598-1-badhri@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v2 2/2] usb: typec: tcpm: Do not disconnect when receiving VSAFE0V
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
back to 0V causing VSAFE0V to be triggered. This will report a VBUS off
event causing TCPM to transition to SNK_UNATTACHED state where it
should be waiting in either SNK_ATTACH_WAIT or SNK_DEBOUNCED state.
This patch makes TCPM avoid VSAFE0V events while in SNK_ATTACH_WAIT
or SNK_DEBOUNCED state.

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
Changes since v1:
- Fix typos stated by Guenter Roeck.
---
 drivers/usb/typec/tcpm/tcpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3bf79f52bd34..0e0985355a14 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5264,6 +5264,10 @@ static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
 	case PR_SWAP_SNK_SRC_SOURCE_ON:
 		/* Do nothing, vsafe0v is expected during transition */
 		break;
+	case SNK_ATTACH_WAIT:
+	case SNK_DEBOUNCED:
+		/* Do nothing, still waiting for VSAFE5V to connect */
+		break;
 	default:
 		if (port->pwr_role == TYPEC_SINK && port->auto_vbus_discharge_enabled)
 			tcpm_set_state(port, SNK_UNATTACHED, 0);
-- 
2.35.0.rc0.227.g00780c9af4-goog

