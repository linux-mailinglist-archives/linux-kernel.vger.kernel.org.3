Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D90954BAB4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343813AbiFNTll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243974AbiFNTlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:41:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E5D27CE4;
        Tue, 14 Jun 2022 12:41:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h5so12650110wrb.0;
        Tue, 14 Jun 2022 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+6Pg7cjduifTxuHDSkXVpXdVfCIHhnTev9bEdkehao=;
        b=IYtZ7iaWkiRAIRvKKUIk5pSOZ0h0e+sPMP05HHbrMw8BcavHu/B7oNw1RZB8wIyXBi
         x7PLLLd7i0q5RiXSIlilCtqFIP+LQDcfOcSZ6XCkJuVoXAlXUoXNTUF7gWfua0ZdFcyE
         aRIiaKZx00Y6VhxZOoNVB+auArvtXN16/q5IIB8L/yGiZoNu9WnRHycBKg88myTP/48I
         Gh4v9NtkCUWrMuMoYCsrNDaUnXS7/EHcWhcu1zcuMhniMbPMVTeGhXMBfxroubKJjgKG
         vCUJCFTmJtUZMm1OXjxboAIwYMLg9I6+TvA6DaFYGVWmNf+Nqx+JOAv+ArWtcInGcclA
         sW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+6Pg7cjduifTxuHDSkXVpXdVfCIHhnTev9bEdkehao=;
        b=FV+qUtVYglCA5JVr2iBfbGRfA9VkcQdUlD77o9z/jmdmG7fm2K/NNBf11aaFkLKsbx
         fHYMMV7+O36XTkpglv9k43Xd6SPDmMTarOeh14neNZ06GrTQld+aAneJN9kV2AsY9nta
         Ji5i8CFozmcLX+zFvDkm4TXeMcXkrbVLyY5a+HQi7WVB1GZa8aVSsAYsIwE4wY1XLRU1
         L5IfOquAF02tO+gN1ZoX5MgvdLaCBT+DEPhK5ZBeBpUsYXai71PWlPjhFmOAkNZADFdG
         pO6q2KjPIqkuWB1xWNAecmNKDHkbACQO1Nr5NvXuXKvuMJZGk21FBbP7230J49MNy1Nk
         XsWQ==
X-Gm-Message-State: AJIora/Zvz2ir39boDKL3oKA7z6SokCDzGIjNTh06JMW5hkk+fRRO170
        pZKx2JhFIYG0Xk7rdIzhDe9KCu88sAA=
X-Google-Smtp-Source: AGRyM1tzzzyNWvIB/8qVgpfk6RtUEHFHtXQ0nyAQDPu0o3R26uINfpYABcTjVk59Jg0mUD6myuB7sg==
X-Received: by 2002:a05:6000:1acc:b0:219:e689:d61b with SMTP id i12-20020a0560001acc00b00219e689d61bmr6212101wry.24.1655235689050;
        Tue, 14 Jun 2022 12:41:29 -0700 (PDT)
Received: from xws.localdomain ([194.126.177.7])
        by smtp.gmail.com with ESMTPSA id k7-20020a1ca107000000b003973c54bd69sm18768442wme.1.2022.06.14.12.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:41:28 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH] platform/surface: aggregator: Reserve more event- and target-categories
Date:   Tue, 14 Jun 2022 21:41:17 +0200
Message-Id: <20220614194117.4118897-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of the Surface Laptop Studio, more event- and
target categories have been added. Therefore, increase the number of
reserved events and extend the enum of know target categories to
accommodate this.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/aggregator/trace.h   | 80 +++++++++++--------
 include/linux/surface_aggregator/serial_hub.h | 75 +++++++++--------
 2 files changed, 85 insertions(+), 70 deletions(-)

diff --git a/drivers/platform/surface/aggregator/trace.h b/drivers/platform/surface/aggregator/trace.h
index de64cf169060..cc9e73fbc18e 100644
--- a/drivers/platform/surface/aggregator/trace.h
+++ b/drivers/platform/surface/aggregator/trace.h
@@ -76,7 +76,7 @@ TRACE_DEFINE_ENUM(SSAM_SSH_TC_HID);
 TRACE_DEFINE_ENUM(SSAM_SSH_TC_TCH);
 TRACE_DEFINE_ENUM(SSAM_SSH_TC_BKL);
 TRACE_DEFINE_ENUM(SSAM_SSH_TC_TAM);
-TRACE_DEFINE_ENUM(SSAM_SSH_TC_ACC);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_ACC0);
 TRACE_DEFINE_ENUM(SSAM_SSH_TC_UFI);
 TRACE_DEFINE_ENUM(SSAM_SSH_TC_USC);
 TRACE_DEFINE_ENUM(SSAM_SSH_TC_PEN);
@@ -85,6 +85,11 @@ TRACE_DEFINE_ENUM(SSAM_SSH_TC_AUD);
 TRACE_DEFINE_ENUM(SSAM_SSH_TC_SMC);
 TRACE_DEFINE_ENUM(SSAM_SSH_TC_KPD);
 TRACE_DEFINE_ENUM(SSAM_SSH_TC_REG);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_SPT);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_SYS);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_ACC1);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_SHB);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_POS);
 
 #define SSAM_PTR_UID_LEN		9
 #define SSAM_U8_FIELD_NOT_APPLICABLE	((u16)-1)
@@ -229,40 +234,45 @@ static inline u32 ssam_trace_get_request_tc(const struct ssh_packet *p)
 
 #define ssam_show_ssh_tc(rqid)						\
 	__print_symbolic(rqid,						\
-		{ SSAM_SSH_TC_NOT_APPLICABLE,		"N/A" },	\
-		{ SSAM_SSH_TC_SAM,			"SAM" },	\
-		{ SSAM_SSH_TC_BAT,			"BAT" },	\
-		{ SSAM_SSH_TC_TMP,			"TMP" },	\
-		{ SSAM_SSH_TC_PMC,			"PMC" },	\
-		{ SSAM_SSH_TC_FAN,			"FAN" },	\
-		{ SSAM_SSH_TC_PoM,			"PoM" },	\
-		{ SSAM_SSH_TC_DBG,			"DBG" },	\
-		{ SSAM_SSH_TC_KBD,			"KBD" },	\
-		{ SSAM_SSH_TC_FWU,			"FWU" },	\
-		{ SSAM_SSH_TC_UNI,			"UNI" },	\
-		{ SSAM_SSH_TC_LPC,			"LPC" },	\
-		{ SSAM_SSH_TC_TCL,			"TCL" },	\
-		{ SSAM_SSH_TC_SFL,			"SFL" },	\
-		{ SSAM_SSH_TC_KIP,			"KIP" },	\
-		{ SSAM_SSH_TC_EXT,			"EXT" },	\
-		{ SSAM_SSH_TC_BLD,			"BLD" },	\
-		{ SSAM_SSH_TC_BAS,			"BAS" },	\
-		{ SSAM_SSH_TC_SEN,			"SEN" },	\
-		{ SSAM_SSH_TC_SRQ,			"SRQ" },	\
-		{ SSAM_SSH_TC_MCU,			"MCU" },	\
-		{ SSAM_SSH_TC_HID,			"HID" },	\
-		{ SSAM_SSH_TC_TCH,			"TCH" },	\
-		{ SSAM_SSH_TC_BKL,			"BKL" },	\
-		{ SSAM_SSH_TC_TAM,			"TAM" },	\
-		{ SSAM_SSH_TC_ACC,			"ACC" },	\
-		{ SSAM_SSH_TC_UFI,			"UFI" },	\
-		{ SSAM_SSH_TC_USC,			"USC" },	\
-		{ SSAM_SSH_TC_PEN,			"PEN" },	\
-		{ SSAM_SSH_TC_VID,			"VID" },	\
-		{ SSAM_SSH_TC_AUD,			"AUD" },	\
-		{ SSAM_SSH_TC_SMC,			"SMC" },	\
-		{ SSAM_SSH_TC_KPD,			"KPD" },	\
-		{ SSAM_SSH_TC_REG,			"REG" }		\
+		{ SSAM_SSH_TC_NOT_APPLICABLE,		"N/A"  },	\
+		{ SSAM_SSH_TC_SAM,			"SAM"  },	\
+		{ SSAM_SSH_TC_BAT,			"BAT"  },	\
+		{ SSAM_SSH_TC_TMP,			"TMP"  },	\
+		{ SSAM_SSH_TC_PMC,			"PMC"  },	\
+		{ SSAM_SSH_TC_FAN,			"FAN"  },	\
+		{ SSAM_SSH_TC_PoM,			"PoM"  },	\
+		{ SSAM_SSH_TC_DBG,			"DBG"  },	\
+		{ SSAM_SSH_TC_KBD,			"KBD"  },	\
+		{ SSAM_SSH_TC_FWU,			"FWU"  },	\
+		{ SSAM_SSH_TC_UNI,			"UNI"  },	\
+		{ SSAM_SSH_TC_LPC,			"LPC"  },	\
+		{ SSAM_SSH_TC_TCL,			"TCL"  },	\
+		{ SSAM_SSH_TC_SFL,			"SFL"  },	\
+		{ SSAM_SSH_TC_KIP,			"KIP"  },	\
+		{ SSAM_SSH_TC_EXT,			"EXT"  },	\
+		{ SSAM_SSH_TC_BLD,			"BLD"  },	\
+		{ SSAM_SSH_TC_BAS,			"BAS"  },	\
+		{ SSAM_SSH_TC_SEN,			"SEN"  },	\
+		{ SSAM_SSH_TC_SRQ,			"SRQ"  },	\
+		{ SSAM_SSH_TC_MCU,			"MCU"  },	\
+		{ SSAM_SSH_TC_HID,			"HID"  },	\
+		{ SSAM_SSH_TC_TCH,			"TCH"  },	\
+		{ SSAM_SSH_TC_BKL,			"BKL"  },	\
+		{ SSAM_SSH_TC_TAM,			"TAM"  },	\
+		{ SSAM_SSH_TC_ACC0,			"ACC0" },	\
+		{ SSAM_SSH_TC_UFI,			"UFI"  },	\
+		{ SSAM_SSH_TC_USC,			"USC"  },	\
+		{ SSAM_SSH_TC_PEN,			"PEN"  },	\
+		{ SSAM_SSH_TC_VID,			"VID"  },	\
+		{ SSAM_SSH_TC_AUD,			"AUD"  },	\
+		{ SSAM_SSH_TC_SMC,			"SMC"  },	\
+		{ SSAM_SSH_TC_KPD,			"KPD"  },	\
+		{ SSAM_SSH_TC_REG,			"REG"  },	\
+		{ SSAM_SSH_TC_SPT,			"SPT"  },	\
+		{ SSAM_SSH_TC_SYS,			"SYS"  },	\
+		{ SSAM_SSH_TC_ACC1,			"ACC1" },	\
+		{ SSAM_SSH_TC_SHB,			"SMB"  },	\
+		{ SSAM_SSH_TC_POS,			"POS"  }	\
 	)
 
 DECLARE_EVENT_CLASS(ssam_frame_class,
diff --git a/include/linux/surface_aggregator/serial_hub.h b/include/linux/surface_aggregator/serial_hub.h
index 26b95ec12733..45501b6e54e8 100644
--- a/include/linux/surface_aggregator/serial_hub.h
+++ b/include/linux/surface_aggregator/serial_hub.h
@@ -201,7 +201,7 @@ static inline u16 ssh_crc(const u8 *buf, size_t len)
  * exception of zero, which is not an event ID. Thus, this is also the
  * absolute maximum number of event handlers that can be registered.
  */
-#define SSH_NUM_EVENTS		34
+#define SSH_NUM_EVENTS		38
 
 /*
  * SSH_NUM_TARGETS - The number of communication targets used in the protocol.
@@ -292,40 +292,45 @@ struct ssam_span {
  * Windows driver.
  */
 enum ssam_ssh_tc {
-				/* Category 0x00 is invalid for EC use. */
-	SSAM_SSH_TC_SAM = 0x01,	/* Generic system functionality, real-time clock. */
-	SSAM_SSH_TC_BAT = 0x02,	/* Battery/power subsystem. */
-	SSAM_SSH_TC_TMP = 0x03,	/* Thermal subsystem. */
-	SSAM_SSH_TC_PMC = 0x04,
-	SSAM_SSH_TC_FAN = 0x05,
-	SSAM_SSH_TC_PoM = 0x06,
-	SSAM_SSH_TC_DBG = 0x07,
-	SSAM_SSH_TC_KBD = 0x08,	/* Legacy keyboard (Laptop 1/2). */
-	SSAM_SSH_TC_FWU = 0x09,
-	SSAM_SSH_TC_UNI = 0x0a,
-	SSAM_SSH_TC_LPC = 0x0b,
-	SSAM_SSH_TC_TCL = 0x0c,
-	SSAM_SSH_TC_SFL = 0x0d,
-	SSAM_SSH_TC_KIP = 0x0e,	/* Manages detachable peripherals (Pro X/8 keyboard cover) */
-	SSAM_SSH_TC_EXT = 0x0f,
-	SSAM_SSH_TC_BLD = 0x10,
-	SSAM_SSH_TC_BAS = 0x11,	/* Detachment system (Surface Book 2/3). */
-	SSAM_SSH_TC_SEN = 0x12,
-	SSAM_SSH_TC_SRQ = 0x13,
-	SSAM_SSH_TC_MCU = 0x14,
-	SSAM_SSH_TC_HID = 0x15,	/* Generic HID input subsystem. */
-	SSAM_SSH_TC_TCH = 0x16,
-	SSAM_SSH_TC_BKL = 0x17,
-	SSAM_SSH_TC_TAM = 0x18,
-	SSAM_SSH_TC_ACC = 0x19,
-	SSAM_SSH_TC_UFI = 0x1a,
-	SSAM_SSH_TC_USC = 0x1b,
-	SSAM_SSH_TC_PEN = 0x1c,
-	SSAM_SSH_TC_VID = 0x1d,
-	SSAM_SSH_TC_AUD = 0x1e,
-	SSAM_SSH_TC_SMC = 0x1f,
-	SSAM_SSH_TC_KPD = 0x20,
-	SSAM_SSH_TC_REG = 0x21,	/* Extended event registry. */
+				  /* Category 0x00 is invalid for EC use. */
+	SSAM_SSH_TC_SAM  = 0x01,  /* Generic system functionality, real-time clock. */
+	SSAM_SSH_TC_BAT  = 0x02,  /* Battery/power subsystem. */
+	SSAM_SSH_TC_TMP  = 0x03,  /* Thermal subsystem. */
+	SSAM_SSH_TC_PMC  = 0x04,
+	SSAM_SSH_TC_FAN  = 0x05,
+	SSAM_SSH_TC_PoM  = 0x06,
+	SSAM_SSH_TC_DBG  = 0x07,
+	SSAM_SSH_TC_KBD  = 0x08,  /* Legacy keyboard (Laptop 1/2). */
+	SSAM_SSH_TC_FWU  = 0x09,
+	SSAM_SSH_TC_UNI  = 0x0a,
+	SSAM_SSH_TC_LPC  = 0x0b,
+	SSAM_SSH_TC_TCL  = 0x0c,
+	SSAM_SSH_TC_SFL  = 0x0d,
+	SSAM_SSH_TC_KIP  = 0x0e,  /* Manages detachable peripherals (Pro X/8 keyboard cover) */
+	SSAM_SSH_TC_EXT  = 0x0f,
+	SSAM_SSH_TC_BLD  = 0x10,
+	SSAM_SSH_TC_BAS  = 0x11,  /* Detachment system (Surface Book 2/3). */
+	SSAM_SSH_TC_SEN  = 0x12,
+	SSAM_SSH_TC_SRQ  = 0x13,
+	SSAM_SSH_TC_MCU  = 0x14,
+	SSAM_SSH_TC_HID  = 0x15,  /* Generic HID input subsystem. */
+	SSAM_SSH_TC_TCH  = 0x16,
+	SSAM_SSH_TC_BKL  = 0x17,
+	SSAM_SSH_TC_TAM  = 0x18,
+	SSAM_SSH_TC_ACC0 = 0x19,
+	SSAM_SSH_TC_UFI  = 0x1a,
+	SSAM_SSH_TC_USC  = 0x1b,
+	SSAM_SSH_TC_PEN  = 0x1c,
+	SSAM_SSH_TC_VID  = 0x1d,
+	SSAM_SSH_TC_AUD  = 0x1e,
+	SSAM_SSH_TC_SMC  = 0x1f,
+	SSAM_SSH_TC_KPD  = 0x20,
+	SSAM_SSH_TC_REG  = 0x21,  /* Extended event registry. */
+	SSAM_SSH_TC_SPT  = 0x22,
+	SSAM_SSH_TC_SYS  = 0x23,
+	SSAM_SSH_TC_ACC1 = 0x24,
+	SSAM_SSH_TC_SHB  = 0x25,
+	SSAM_SSH_TC_POS  = 0x26,  /* For obtaining Laptop Studio screen position. */
 };
 
 
-- 
2.36.1

