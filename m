Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1B5929AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiHOGig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiHOGif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:38:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB551ADB7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:38:34 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o3so5654362ple.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=t0lzq9wXtDZalDc+MqW+q/Qr6dM8adTctzXUvTWqjXw=;
        b=mJZ4VkOcUookg2qKkoDfdsGdAK5ungyXoH75mzIMbXSlD1e3Fb2fu6nmK757mhROgs
         UNXG+dWaInBvgNqv+PAI8VUaledvrOzwjnAT1UxeYn1iOBTzM/2Htua1MwLDVf1QjVHu
         CHcv6VV+jVlxAhUX7PsYB7f7OWJCEJiuszq1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=t0lzq9wXtDZalDc+MqW+q/Qr6dM8adTctzXUvTWqjXw=;
        b=DxmwXCybZwp6u4PEIDXzcqpOrB4PhU02TX4KKXoavXecP9thTf4DRTbGDiFnrXFrij
         V836wQ3rqUUorbPbTj8mrk4y+r53iaWcGmrvkRhqF9XE4/yTUdJhi9wglh5yUNbjGJVx
         uq7lEakoFnR/t1/eidJzR58FEWORXMrq3H5aeXUcSWClMB5+O+lnhT0eqvjHxdszxVXK
         kO09LHdoBrAGJyJnECBB3oiDhNA0fNfXf9EiD8HxYSEX8ofDwBu5lW8tvi00P47CDqd+
         Hlca0LX8y6s4EYj8GIppIUptkwwNl4FskZI6eSdkhc05uCY5XQviIT6pPZN/y0NgThdB
         3VXw==
X-Gm-Message-State: ACgBeo0slMJ2Q6UIv03cmNlkcWqrcn5pVMQ/5sVlmgqwXWPN3kIyXCbB
        TfLyxCaw6NEDmMQZVdRpHwRh4sch2qPGUA==
X-Google-Smtp-Source: AA6agR7lhgSd83SNVI3JVmj+q3jlu0eT7XHkY/HqQvsYT2lX6B8gSJ8NGEu++JfxXrv3C9yGkog63g==
X-Received: by 2002:a17:90b:4a05:b0:1f5:62d5:4155 with SMTP id kk5-20020a17090b4a0500b001f562d54155mr17504326pjb.6.1660545513764;
        Sun, 14 Aug 2022 23:38:33 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id 200-20020a6214d1000000b0052db82ad8b2sm5988233pfu.123.2022.08.14.23.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:38:33 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v5 1/7] platform/chrome: Add Type-C mux set command definitions
Date:   Mon, 15 Aug 2022 06:34:17 +0000
Message-Id: <20220815063555.1384505-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220815063555.1384505-1-pmalani@chromium.org>
References: <20220815063555.1384505-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy EC header definitions for the USB Type-C Mux control command from
the EC code base. Also pull in "TBT_UFP_REPLY" definitions, since that
is the prior entry in the enum.

These headers are already present in the EC code base. [1]

[1] https://chromium.googlesource.com/chromiumos/platform/ec/+/b80f85a94a423273c1638ef7b662c56931a138dd/include/ec_commands.h

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
Changes since v4:
- No changes.

Changes since v3:
- No changes.

Changes since v2:
- No changes.

Changes since v1:
- No changes.

 include/linux/platform_data/cros_ec_commands.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 8b1b795867a1..5744a2d746aa 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -5724,8 +5724,21 @@ enum typec_control_command {
 	TYPEC_CONTROL_COMMAND_EXIT_MODES,
 	TYPEC_CONTROL_COMMAND_CLEAR_EVENTS,
 	TYPEC_CONTROL_COMMAND_ENTER_MODE,
+	TYPEC_CONTROL_COMMAND_TBT_UFP_REPLY,
+	TYPEC_CONTROL_COMMAND_USB_MUX_SET,
 };
 
+/* Replies the AP may specify to the TBT EnterMode command as a UFP */
+enum typec_tbt_ufp_reply {
+	TYPEC_TBT_UFP_REPLY_NAK,
+	TYPEC_TBT_UFP_REPLY_ACK,
+};
+
+struct typec_usb_mux_set {
+	uint8_t mux_index;	/* Index of the mux to set in the chain */
+	uint8_t mux_flags;	/* USB_PD_MUX_*-encoded USB mux state to set */
+} __ec_align1;
+
 struct ec_params_typec_control {
 	uint8_t port;
 	uint8_t command;	/* enum typec_control_command */
@@ -5739,6 +5752,8 @@ struct ec_params_typec_control {
 	union {
 		uint32_t clear_events_mask;
 		uint8_t mode_to_enter;      /* enum typec_mode */
+		uint8_t tbt_ufp_reply;      /* enum typec_tbt_ufp_reply */
+		struct typec_usb_mux_set mux_params;
 		uint8_t placeholder[128];
 	};
 } __ec_align1;
@@ -5817,6 +5832,9 @@ enum tcpc_cc_polarity {
 #define PD_STATUS_EVENT_SOP_DISC_DONE		BIT(0)
 #define PD_STATUS_EVENT_SOP_PRIME_DISC_DONE	BIT(1)
 #define PD_STATUS_EVENT_HARD_RESET		BIT(2)
+#define PD_STATUS_EVENT_DISCONNECTED		BIT(3)
+#define PD_STATUS_EVENT_MUX_0_SET_DONE		BIT(4)
+#define PD_STATUS_EVENT_MUX_1_SET_DONE		BIT(5)
 
 struct ec_params_typec_status {
 	uint8_t port;
-- 
2.37.1.595.g718a3a8f04-goog

