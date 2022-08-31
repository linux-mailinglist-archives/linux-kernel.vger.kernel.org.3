Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43E85A7249
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiHaAQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiHaAQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:16:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF7E956A3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:16:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3328a211611so189888727b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=RLmxwVwtne7Ris2nr8dSsVg7os+UaP8tQY3U04GCx/Q=;
        b=NJoxFv51S9HcIE88Xfk0z9ARm+YW3lBgF/itE8xbqEcD4h+I/HI9qHdqiHvI8nszbL
         OO7wA8VQA5+reAeskw4TV+lpn2/nwsnTESgC8Qsa4DkIBvp5yqMYi/8cSJ1xLagHg7VI
         7wxwZ0qodBJ4LMh8htf4g0tHvoRYC7r1VZ9zYWgqHchA6qID2L49q1+pfK9REWZ+NViu
         el22XRXpiRfohPKeQnr5bBUoFZ7g6pr5q4dV56BF1TRVit3s6Ic42vYLec4NvXtErfo4
         7PmEDEhK1I8HEaYvpClp2CleXCHZX1K17Ri12db+VrcWo3FNX435UiXW/J2gr3mzkDax
         FiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=RLmxwVwtne7Ris2nr8dSsVg7os+UaP8tQY3U04GCx/Q=;
        b=fD1QNpzAJuLXYgVCqfmUz8pOTLdpnNKHkSb7xnwDgB1GFRhZcrH4yuGHQwh+fEEElR
         aB7czsGpI2L9YJY2lWAw8FH8EcpuEF2ZYIUAdKrwgIrtvSH9w7r+GJPVpiudboHPNnT+
         /hugfhGzT/FhixGkAIjAstQPqz1G98FaaQ3CJNtAgQhN6ZgQPT//I0imZt9k+Ed7vBAX
         zZYIcPVpML7Hn5TbvqJTJjiowIKn5Suf8OcB7Uls0NCQWcrDLAwjfz3r8UNIGJFjivbu
         ao/a3b8jIQym1wQTBjdgugfU+9MJP6Feh5SjIAxzqWkIsMqPOyQ0mtZLLigrIEmI9mQj
         J0Ug==
X-Gm-Message-State: ACgBeo2afNfJjuXOlIPQB6zC5f8SvE6cHNkUIYHkjN4ajksAgOWF3tv1
        nGeJuLBgeiKKLBMa69FplasJHAqJ9lU=
X-Google-Smtp-Source: AA6agR7iS1SKx5V+0qnM6d9Ylkl3Nlg1fC8CtnEH7ewB9Eq/tzrDCRaxIRrsrAeG4bL0KCaFqC+X65/abGY=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:377b:cea5:463f:f0c9])
 (user=badhri job=sendgmr) by 2002:a81:6703:0:b0:340:a52f:67a1 with SMTP id
 b3-20020a816703000000b00340a52f67a1mr16926357ywc.31.1661904968432; Tue, 30
 Aug 2022 17:16:08 -0700 (PDT)
Date:   Tue, 30 Aug 2022 17:15:54 -0700
In-Reply-To: <20220831001555.285081-1-badhri@google.com>
Mime-Version: 1.0
References: <20220831001555.285081-1-badhri@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831001555.285081-2-badhri@google.com>
Subject: [PATCH v2 2/3] usb: typec: tcpci: Add callback for evaluating
 contaminant presence
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds callback to evaluate presence of contaminant in
the TCPCI layer.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 9 +++++++++
 include/linux/usb/tcpci.h      | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 50674ecf430d..53f6fad61781 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -403,6 +403,14 @@ static void tcpci_frs_sourcing_vbus(struct tcpc_dev *dev)
 		tcpci->data->frs_sourcing_vbus(tcpci, tcpci->data);
 }
 
+static void tcpci_check_contaminant(struct tcpc_dev *dev, bool disconnect_while_debouncing)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(dev);
+
+	if (tcpci->data->check_contaminant)
+		tcpci->data->check_contaminant(tcpci, tcpci->data, disconnect_while_debouncing);
+}
+
 static int tcpci_set_bist_data(struct tcpc_dev *tcpc, bool enable)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -777,6 +785,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.enable_frs = tcpci_enable_frs;
 	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
 	tcpci->tcpc.set_partner_usb_comm_capable = tcpci_set_partner_usb_comm_capable;
+	tcpci->tcpc.check_contaminant = tcpci_check_contaminant;
 
 	if (tcpci->data->auto_discharge_disconnect) {
 		tcpci->tcpc.enable_auto_vbus_discharge = tcpci_enable_auto_vbus_discharge;
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index 17657451c762..250b34ccbf9c 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -188,6 +188,11 @@ struct tcpci;
  *		Optional; The USB Communications Capable bit indicates if port
  *		partner is capable of communication over the USB data lines
  *		(e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
+ * @check_contaminant:
+ *		Optional;The callback is called when CC pins report open status
+ *		at the end of the deboumce period or when the port is still
+ *		toggling. Chip level drivers are expected to check for contaminant
+ *		and call tcpm_clean_port when the port is clean.
  */
 struct tcpci_data {
 	struct regmap *regmap;
@@ -204,6 +209,8 @@ struct tcpci_data {
 	void (*frs_sourcing_vbus)(struct tcpci *tcpci, struct tcpci_data *data);
 	void (*set_partner_usb_comm_capable)(struct tcpci *tcpci, struct tcpci_data *data,
 					     bool capable);
+	void (*check_contaminant)(struct tcpci *tcpci, struct tcpci_data *data,
+				  bool disconnect_while_debouncing);
 };
 
 struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
-- 
2.37.2.672.g94769d06f0-goog

