Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8052E55AFB6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 08:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiFZGp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 02:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiFZGpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 02:45:47 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1D112D3D;
        Sat, 25 Jun 2022 23:45:46 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b24so4196804qkn.4;
        Sat, 25 Jun 2022 23:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65Om7cI1iZiSRbTj+XC8mPGulcbZYjRMsykJZECgre4=;
        b=ZelHsEW7JxtuOPTQ4LkYD6Wl1FZ1ZpCfkWUnRMuOrFGuu7NwKfQdLdzZ+w79thm1JB
         T2eHzb8PXEJYHHhTj5DvSKX5PE9POwrcbFtaelrxSfMKuYhxW0SdfG35D4ox4yipCWiF
         1EjSMFzvH8ZBbGrRsrD/t6/BVTDRc7fkV2r1XvLoJDinVsg6+/QvsTQPc74l/mZ68Ogl
         rmYCv/cNeUr9gc/rfjoyKjhZz6iuLMN4BPvlFUtVFexN5h82O6cjAhnKD6zDNygRTRkZ
         rFlheo34gApJeKpAMCoXqDDafTZMXHs2mJdRrWCliuqQnvs0K5nxDfuLK5dDrgnN9eTF
         4KTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65Om7cI1iZiSRbTj+XC8mPGulcbZYjRMsykJZECgre4=;
        b=HtM9LgAew4cHow5VjT6eitWNMiV2D8CMiq0PG2arBUv+tb5YcRik3o+GG/qri4kgnn
         nMkf3ewTp4Gf38cKE5PgRnMmsLxv9048WuYo9wTvJEW/hZqxdA3Gxzuu39UaOdgHxbF3
         FfzIZkPr9I+3hbP5lhRzgoAltKSRXUlTFHnFO8NbxD4n3hMQljeuO1GdNFLsBsPgbwTK
         qe9jT8PCOnNyVk8NFPK56bwSsAplgZ5M9RcT0Y1AKrD5b6+VQ8cQ3QKyB5XDQUFM9Y+W
         kBKhNwzWPCrjGbJ7vApz8aOQn18LSK5B3ntRzQvDo77Fb0rGu3aY+H/N9nTy60MSOKZa
         RTuA==
X-Gm-Message-State: AJIora8nq/1754EgYdcu4xzYHJ05Pe2WUWxdZKMUWQV8Sun3gsxzoYc3
        OS932LrU3MFVDKucRGIZPmk=
X-Google-Smtp-Source: AGRyM1shU9hXMkcKwBVORAZwmlasrhw7cQVb0CDJ9AQnLpH/Re7ki80rn8EekM+XLJdPOR32oGnyuA==
X-Received: by 2002:a37:c86:0:b0:6ae:ded5:2002 with SMTP id 128-20020a370c86000000b006aeded52002mr4677369qkm.594.1656225945475;
        Sat, 25 Jun 2022 23:45:45 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a76a939dbasm5914620qko.112.2022.06.25.23.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 23:45:44 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, olof@lixom.net, linux@armlinux.org.uk,
        abel.vesa@nxp.com, dev@lynxeye.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, leoyang.li@nxp.com,
        sebastian.reichel@collabora.com, cniedermaier@dh-electronics.com,
        Mr.Bossman075@gmail.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 09/13] dt-bindings: imx: Add clock binding for i.MXRT1170
Date:   Sun, 26 Jun 2022 02:45:19 -0400
Message-Id: <20220626064523.3683775-10-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626064523.3683775-1-Mr.Bossman075@gmail.com>
References: <20220626064523.3683775-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock binding doc for i.MXRT1170.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V1 -> V2:
 - Change to GPL-2.0-only
V2 -> V3:
 - Change to (GPL-2.0-only OR BSD-2-Clause)
V3 -> V4:
 - Nothing done
---
 include/dt-bindings/clock/imxrt1170-clock.h | 282 ++++++++++++++++++++
 1 file changed, 282 insertions(+)
 create mode 100644 include/dt-bindings/clock/imxrt1170-clock.h

diff --git a/include/dt-bindings/clock/imxrt1170-clock.h b/include/dt-bindings/clock/imxrt1170-clock.h
new file mode 100644
index 000000000000..be0dd6089059
--- /dev/null
+++ b/include/dt-bindings/clock/imxrt1170-clock.h
@@ -0,0 +1,282 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright(C) 2022
+ * Author(s): Jesse Taube <Mr.Bossman075@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMXRT1170_H
+#define __DT_BINDINGS_CLOCK_IMXRT1170_H
+
+#define IMXRT1170_CLK_DUMMY			0
+#define IMXRT1170_CLK_OSC			1
+#define IMXRT1170_CLK_OSC_32K			2
+#define IMXRT1170_CLK_RCOSC_16M			3
+#define IMXRT1170_CLK_RCOSC_48M			4
+#define IMXRT1170_CLK_RCOSC_48M_DIV2		5
+#define IMXRT1170_CLK_RCOSC_400M		6
+#define IMXRT1170_CLK_PLL_ARM_PRE		7
+#define IMXRT1170_CLK_PLL_ARM_BYPASS		8
+#define IMXRT1170_CLK_PLL_ARM_DIV		9
+#define IMXRT1170_CLK_PLL_ARM			10
+#define IMXRT1170_CLK_PLL_AUDIO			11
+#define IMXRT1170_CLK_PLL_VIDEO			12
+#define IMXRT1170_CLK_PLL1			13
+#define IMXRT1170_CLK_PLL1_DIV2			14
+#define IMXRT1170_CLK_PLL1_DIV5			15
+#define IMXRT1170_CLK_PLL2_PRE			16
+#define IMXRT1170_CLK_PLL2_BYPASS		17
+#define IMXRT1170_CLK_PLL2			18
+#define IMXRT1170_CLK_PLL2_PFD0			19
+#define IMXRT1170_CLK_PLL2_PFD1			20
+#define IMXRT1170_CLK_PLL2_PFD2			21
+#define IMXRT1170_CLK_PLL2_PFD3			22
+#define IMXRT1170_CLK_PLL3_PRE			23
+#define IMXRT1170_CLK_PLL3_BYPASS		24
+#define IMXRT1170_CLK_PLL3			25
+#define IMXRT1170_CLK_PLL3_DIV2_GATE		26
+#define IMXRT1170_CLK_PLL3_DIV2			27
+#define IMXRT1170_CLK_PLL3_PFD0			28
+#define IMXRT1170_CLK_PLL3_PFD1			29
+#define IMXRT1170_CLK_PLL3_PFD2			30
+#define IMXRT1170_CLK_PLL3_PFD3			31
+#define IMXRT1170_CLK_M7_SEL			32
+#define IMXRT1170_CLK_M7_GATE			33
+#define IMXRT1170_CLK_M7			34
+#define IMXRT1170_CLK_M4_SEL			35
+#define IMXRT1170_CLK_M4_GATE			36
+#define IMXRT1170_CLK_M4			37
+#define IMXRT1170_CLK_BUS_SEL			38
+#define IMXRT1170_CLK_BUS_GATE			39
+#define IMXRT1170_CLK_BUS			40
+#define IMXRT1170_CLK_BUS_LPSR_SEL		41
+#define IMXRT1170_CLK_BUS_LPSR_GATE		42
+#define IMXRT1170_CLK_BUS_LPSR			43
+#define IMXRT1170_CLK_SEMC_SEL			44
+#define IMXRT1170_CLK_SEMC_GATE			45
+#define IMXRT1170_CLK_SEMC			46
+#define IMXRT1170_CLK_CSSYS_SEL			47
+#define IMXRT1170_CLK_CSSYS_GATE		48
+#define IMXRT1170_CLK_CSSYS			49
+#define IMXRT1170_CLK_CSTRACE_SEL		50
+#define IMXRT1170_CLK_CSTRACE_GATE		51
+#define IMXRT1170_CLK_CSTRACE			52
+#define IMXRT1170_CLK_M4_SYSTICK_SEL		53
+#define IMXRT1170_CLK_M4_SYSTICK_GATE		54
+#define IMXRT1170_CLK_M4_SYSTICK		55
+#define IMXRT1170_CLK_M7_SYSTICK_SEL		56
+#define IMXRT1170_CLK_M7_SYSTICK_GATE		57
+#define IMXRT1170_CLK_M7_SYSTICK		58
+#define IMXRT1170_CLK_ADC1_SEL			59
+#define IMXRT1170_CLK_ADC1_GATE			60
+#define IMXRT1170_CLK_ADC1			61
+#define IMXRT1170_CLK_ADC2_SEL			62
+#define IMXRT1170_CLK_ADC2_GATE			63
+#define IMXRT1170_CLK_ADC2			64
+#define IMXRT1170_CLK_ACMP_SEL			65
+#define IMXRT1170_CLK_ACMP_GATE			66
+#define IMXRT1170_CLK_ACMP			67
+#define IMXRT1170_CLK_FLEXIO1_SEL		68
+#define IMXRT1170_CLK_FLEXIO1_GATE		69
+#define IMXRT1170_CLK_FLEXIO1			70
+#define IMXRT1170_CLK_FLEXIO2_SEL		71
+#define IMXRT1170_CLK_FLEXIO2_GATE		72
+#define IMXRT1170_CLK_FLEXIO2			73
+#define IMXRT1170_CLK_GPT1_SEL			74
+#define IMXRT1170_CLK_GPT1_GATE			75
+#define IMXRT1170_CLK_GPT1			76
+#define IMXRT1170_CLK_GPT2_SEL			77
+#define IMXRT1170_CLK_GPT2_GATE			78
+#define IMXRT1170_CLK_GPT2			79
+#define IMXRT1170_CLK_GPT3_SEL			80
+#define IMXRT1170_CLK_GPT3_GATE			81
+#define IMXRT1170_CLK_GPT3			82
+#define IMXRT1170_CLK_GPT4_SEL			83
+#define IMXRT1170_CLK_GPT4_GATE			84
+#define IMXRT1170_CLK_GPT4			85
+#define IMXRT1170_CLK_GPT5_SEL			86
+#define IMXRT1170_CLK_GPT5_GATE			87
+#define IMXRT1170_CLK_GPT5			88
+#define IMXRT1170_CLK_GPT6_SEL			89
+#define IMXRT1170_CLK_GPT6_GATE			90
+#define IMXRT1170_CLK_GPT6			91
+#define IMXRT1170_CLK_FLEXSPI1_SEL		92
+#define IMXRT1170_CLK_FLEXSPI1_GATE		93
+#define IMXRT1170_CLK_FLEXSPI1			94
+#define IMXRT1170_CLK_FLEXSPI2_SEL		95
+#define IMXRT1170_CLK_FLEXSPI2_GATE		96
+#define IMXRT1170_CLK_FLEXSPI2			97
+#define IMXRT1170_CLK_CAN1_SEL			98
+#define IMXRT1170_CLK_CAN1_GATE			99
+#define IMXRT1170_CLK_CAN1			100
+#define IMXRT1170_CLK_CAN2_SEL			101
+#define IMXRT1170_CLK_CAN2_GATE			102
+#define IMXRT1170_CLK_CAN2			103
+#define IMXRT1170_CLK_CAN3_SEL			104
+#define IMXRT1170_CLK_CAN3_GATE			105
+#define IMXRT1170_CLK_CAN3			106
+#define IMXRT1170_CLK_LPUART1_SEL		107
+#define IMXRT1170_CLK_LPUART1_GATE		108
+#define IMXRT1170_CLK_LPUART1			109
+#define IMXRT1170_CLK_LPUART2_SEL		110
+#define IMXRT1170_CLK_LPUART2_GATE		111
+#define IMXRT1170_CLK_LPUART2			112
+#define IMXRT1170_CLK_LPUART3_SEL		113
+#define IMXRT1170_CLK_LPUART3_GATE		114
+#define IMXRT1170_CLK_LPUART3			115
+#define IMXRT1170_CLK_LPUART4_SEL		116
+#define IMXRT1170_CLK_LPUART4_GATE		117
+#define IMXRT1170_CLK_LPUART4			118
+#define IMXRT1170_CLK_LPUART5_SEL		119
+#define IMXRT1170_CLK_LPUART5_GATE		120
+#define IMXRT1170_CLK_LPUART5			121
+#define IMXRT1170_CLK_LPUART6_SEL		122
+#define IMXRT1170_CLK_LPUART6_GATE		123
+#define IMXRT1170_CLK_LPUART6			124
+#define IMXRT1170_CLK_LPUART7_SEL		125
+#define IMXRT1170_CLK_LPUART7_GATE		126
+#define IMXRT1170_CLK_LPUART7			127
+#define IMXRT1170_CLK_LPUART8_SEL		128
+#define IMXRT1170_CLK_LPUART8_GATE		129
+#define IMXRT1170_CLK_LPUART8			130
+#define IMXRT1170_CLK_LPUART9_SEL		131
+#define IMXRT1170_CLK_LPUART9_GATE		132
+#define IMXRT1170_CLK_LPUART9			133
+#define IMXRT1170_CLK_LPUART10_SEL		134
+#define IMXRT1170_CLK_LPUART10_GATE		135
+#define IMXRT1170_CLK_LPUART10			136
+#define IMXRT1170_CLK_LPUART11_SEL		137
+#define IMXRT1170_CLK_LPUART11_GATE		138
+#define IMXRT1170_CLK_LPUART11			139
+#define IMXRT1170_CLK_LPUART12_SEL		140
+#define IMXRT1170_CLK_LPUART12_GATE		141
+#define IMXRT1170_CLK_LPUART12			142
+#define IMXRT1170_CLK_LPI2C1_SEL		143
+#define IMXRT1170_CLK_LPI2C1_GATE		144
+#define IMXRT1170_CLK_LPI2C1			145
+#define IMXRT1170_CLK_LPI2C2_SEL		146
+#define IMXRT1170_CLK_LPI2C2_GATE		147
+#define IMXRT1170_CLK_LPI2C2			148
+#define IMXRT1170_CLK_LPI2C3_SEL		149
+#define IMXRT1170_CLK_LPI2C3_GATE		150
+#define IMXRT1170_CLK_LPI2C3			151
+#define IMXRT1170_CLK_LPI2C4_SEL		152
+#define IMXRT1170_CLK_LPI2C4_GATE		153
+#define IMXRT1170_CLK_LPI2C4			154
+#define IMXRT1170_CLK_LPI2C5_SEL		155
+#define IMXRT1170_CLK_LPI2C5_GATE		156
+#define IMXRT1170_CLK_LPI2C5			157
+#define IMXRT1170_CLK_LPI2C6_SEL		158
+#define IMXRT1170_CLK_LPI2C6_GATE		159
+#define IMXRT1170_CLK_LPI2C6			160
+#define IMXRT1170_CLK_LPSPI1_SEL		161
+#define IMXRT1170_CLK_LPSPI1_GATE		162
+#define IMXRT1170_CLK_LPSPI1			163
+#define IMXRT1170_CLK_LPSPI2_SEL		164
+#define IMXRT1170_CLK_LPSPI2_GATE		165
+#define IMXRT1170_CLK_LPSPI2			166
+#define IMXRT1170_CLK_LPSPI3_SEL		167
+#define IMXRT1170_CLK_LPSPI3_GATE		168
+#define IMXRT1170_CLK_LPSPI3			169
+#define IMXRT1170_CLK_LPSPI4_SEL		170
+#define IMXRT1170_CLK_LPSPI4_GATE		171
+#define IMXRT1170_CLK_LPSPI4			172
+#define IMXRT1170_CLK_LPSPI5_SEL		173
+#define IMXRT1170_CLK_LPSPI5_GATE		174
+#define IMXRT1170_CLK_LPSPI5			175
+#define IMXRT1170_CLK_LPSPI6_SEL		176
+#define IMXRT1170_CLK_LPSPI6_GATE		177
+#define IMXRT1170_CLK_LPSPI6			178
+#define IMXRT1170_CLK_EMV1_SEL			179
+#define IMXRT1170_CLK_EMV1_GATE			180
+#define IMXRT1170_CLK_EMV1			181
+#define IMXRT1170_CLK_EMV2_SEL			182
+#define IMXRT1170_CLK_EMV2_GATE			183
+#define IMXRT1170_CLK_EMV2			184
+#define IMXRT1170_CLK_ENET1_SEL			185
+#define IMXRT1170_CLK_ENET1_GATE		186
+#define IMXRT1170_CLK_ENET1			187
+#define IMXRT1170_CLK_ENET2_SEL			188
+#define IMXRT1170_CLK_ENET2_GATE		189
+#define IMXRT1170_CLK_ENET2			190
+#define IMXRT1170_CLK_ENET_QOS_SEL		191
+#define IMXRT1170_CLK_ENET_QOS_GATE		192
+#define IMXRT1170_CLK_ENET_QOS			193
+#define IMXRT1170_CLK_ENET_25M_SEL		194
+#define IMXRT1170_CLK_ENET_25M_GATE		195
+#define IMXRT1170_CLK_ENET_25M			196
+#define IMXRT1170_CLK_ENET_TIMER1_SEL		197
+#define IMXRT1170_CLK_ENET_TIMER1_GATE		198
+#define IMXRT1170_CLK_ENET_TIMER1		199
+#define IMXRT1170_CLK_ENET_TIMER2_SEL		200
+#define IMXRT1170_CLK_ENET_TIMER2_GATE		201
+#define IMXRT1170_CLK_ENET_TIMER2		202
+#define IMXRT1170_CLK_ENET_TIMER3_SEL		203
+#define IMXRT1170_CLK_ENET_TIMER3_GATE		204
+#define IMXRT1170_CLK_ENET_TIMER3		205
+#define IMXRT1170_CLK_USDHC1_SEL		206
+#define IMXRT1170_CLK_USDHC1_GATE		207
+#define IMXRT1170_CLK_USDHC1			208
+#define IMXRT1170_CLK_USDHC2_SEL		209
+#define IMXRT1170_CLK_USDHC2_GATE		210
+#define IMXRT1170_CLK_USDHC2			211
+#define IMXRT1170_CLK_ASRC_SEL			212
+#define IMXRT1170_CLK_ASRC_GATE			213
+#define IMXRT1170_CLK_ASRC			214
+#define IMXRT1170_CLK_MQS_SEL			215
+#define IMXRT1170_CLK_MQS_GATE			216
+#define IMXRT1170_CLK_MQS			217
+#define IMXRT1170_CLK_MIC_SEL			218
+#define IMXRT1170_CLK_MIC_GATE			219
+#define IMXRT1170_CLK_MIC			220
+#define IMXRT1170_CLK_SPDIF_SEL			221
+#define IMXRT1170_CLK_SPDIF_GATE		222
+#define IMXRT1170_CLK_SPDIF			223
+#define IMXRT1170_CLK_SAI1_SEL			224
+#define IMXRT1170_CLK_SAI1_GATE			225
+#define IMXRT1170_CLK_SAI1			226
+#define IMXRT1170_CLK_SAI2_SEL			227
+#define IMXRT1170_CLK_SAI2_GATE			228
+#define IMXRT1170_CLK_SAI2			229
+#define IMXRT1170_CLK_SAI3_SEL			230
+#define IMXRT1170_CLK_SAI3_GATE			231
+#define IMXRT1170_CLK_SAI3			232
+#define IMXRT1170_CLK_SAI4_SEL			233
+#define IMXRT1170_CLK_SAI4_GATE			234
+#define IMXRT1170_CLK_SAI4			235
+#define IMXRT1170_CLK_GC355_SEL			236
+#define IMXRT1170_CLK_GC355_GATE		237
+#define IMXRT1170_CLK_GC355			238
+#define IMXRT1170_CLK_LCDIF_SEL			239
+#define IMXRT1170_CLK_LCDIF_GATE		240
+#define IMXRT1170_CLK_LCDIF			241
+#define IMXRT1170_CLK_LCDIFV2_SEL		242
+#define IMXRT1170_CLK_LCDIFV2_GATE		243
+#define IMXRT1170_CLK_LCDIFV2			244
+#define IMXRT1170_CLK_MIPI_REF_SEL		245
+#define IMXRT1170_CLK_MIPI_REF_GATE		246
+#define IMXRT1170_CLK_MIPI_REF			247
+#define IMXRT1170_CLK_MIPI_ESC_SEL		248
+#define IMXRT1170_CLK_MIPI_ESC_GATE		249
+#define IMXRT1170_CLK_MIPI_ESC			250
+#define IMXRT1170_CLK_CSI2_SEL			251
+#define IMXRT1170_CLK_CSI2_GATE			252
+#define IMXRT1170_CLK_CSI2			253
+#define IMXRT1170_CLK_CSI2_ESC_SEL		254
+#define IMXRT1170_CLK_CSI2_ESC_GATE		255
+#define IMXRT1170_CLK_CSI2_ESC			256
+#define IMXRT1170_CLK_CSI2_UI_SEL		257
+#define IMXRT1170_CLK_CSI2_UI_GATE		258
+#define IMXRT1170_CLK_CSI2_UI			259
+#define IMXRT1170_CLK_CSI_SEL			260
+#define IMXRT1170_CLK_CSI_GATE			261
+#define IMXRT1170_CLK_CSI			262
+#define IMXRT1170_CLK_CKO1_SEL			263
+#define IMXRT1170_CLK_CKO1_GATE			264
+#define IMXRT1170_CLK_CKO1			265
+#define IMXRT1170_CLK_CKO2_SEL			266
+#define IMXRT1170_CLK_CKO2_GATE			267
+#define IMXRT1170_CLK_CKO2			268
+#define IMXRT1170_CLK_USB			269
+#define IMXRT1170_CLK_END			270
+
+#endif /* __DT_BINDINGS_CLOCK_IMXRT1170_H */
-- 
2.36.1

