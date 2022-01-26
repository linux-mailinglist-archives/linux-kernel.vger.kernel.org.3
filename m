Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6333949C27A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 05:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbiAZEGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 23:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237499AbiAZEGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:06:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7180BC061747
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:06:50 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c76-20020a25c04f000000b00613e2c514e2so41784724ybf.21
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HkfPmpCPhI4ODIe5DoaH45p7aAixzF8Mvfn5ikpABY8=;
        b=PcqY+kCDb8UqpK1dbw2lWC2guuzF7QDxlHNXlojxEspoAt0IsvZMUY/4+w4Zmk2i7H
         POj4/X0fq5WzuXP6mk+hQtEf0PUQa2Yf8EKH0vx+XfAv6bl9dKa30vWtUxA//FgLKQEQ
         tImo3owgB2h2Tj16PS+IuY35CKVIox2JQKQdtfrVFZPbOdxiLB9o2mlDv58G32ktakfZ
         dJpgZcSxYPczZyqbguctBdp2G43VJbXeduU9q1rloZxYfNpf9OU7iayZUta38sbS1eHY
         S3/YGLFmbW/to6LyAKj15/7wbl8jWonI+XP5ZbfPGb7scPT8ySAGRhw4Yx1Wi+EhmVWS
         vP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HkfPmpCPhI4ODIe5DoaH45p7aAixzF8Mvfn5ikpABY8=;
        b=mZVNqg3aqg2YOZUN9LkucjB4BoCm87tgn2TXMhJIbrbr3SjaFR9Vpw/Wkn5ZNVhQGG
         5OIsi3l8Ls+0spTvngbY6PjR9v5hwhO5OraKY2Cm/2LHAmLzhwk0Bf3iNT4K76ZNNjcI
         hZgfRJgPdlPlWiYLisEo5L/BYhayLFvGGPHu0GSPsIy5Q4uIKhjeNAF0LJv0oDBJnjUl
         LDoRq58/+fytTFADstOZWWo8t0Qi3Sr+jLN3Ery6LIuKusRPvWyxAKfUVM0H33+jqu1r
         pfQSgwWCZKU9gWQ6WTSEFMD158+qMVMn6VGuOuer9zEw1XBN+rkY9hhQIL7PuxMVMQC0
         ptuA==
X-Gm-Message-State: AOAM531pqkk1Ed2aFWzexs0yaLQ6HI3ft7ZGnPVUzUxi86nGt/aAxjF3
        qHIuJq1aIevhwXbsb8m69OQ0rQeQjKY=
X-Google-Smtp-Source: ABdhPJzb2Oy2KHD7blNoWFU+7dfaY6NUQZhgukPyDaqmXS3SPggM6Y8slRYZ4fbK8cld6zYI5O1x1+SGBYk=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f4a7:8e16:f301:160])
 (user=badhri job=sendgmr) by 2002:a25:b94b:: with SMTP id s11mr34233129ybm.439.1643170009692;
 Tue, 25 Jan 2022 20:06:49 -0800 (PST)
Date:   Tue, 25 Jan 2022 20:06:45 -0800
Message-Id: <20220126040645.3187200-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v3 2/2] usb: typec: tcpm: Do not disconnect when receiving VSAFE0V
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
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since v1:
- Fix typos stated by Guenter Roeck.
Changes since v2:
- Add reviewed-by/acked-by tags
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

