Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C8F4CCB7B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 02:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiCDB6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 20:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbiCDB6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:58:22 -0500
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40067.outbound.protection.outlook.com [40.107.4.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866B56258
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 17:57:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOMp4fmIHwHmoKaiv1W8i/nsuTsWNMVhBbRK+p0ciD/ft+kFcQG7run4hjq7kZjjkCuBs6x3Z2QzkD6Li1z0iYyOw8JY+Gxknf7BA6TfkD21FNueclrS6MvUUFj+WVq5OmYPuPOVyngmtrYnS7VQHmzxgavW/LpBtW5Y/Ln+VqjVDGMR0ITfE3bDPj4tqJLwjp3igkelOEzEbzui59So0iNf8p12xlpDVMDMakh6RBqqpD6nVGMa9CDj1GhXt62eFFSTuUzVyVZqd3yuM0txjXmy8+UmFkTSkmOnUhzmRP0xRHDtvvd/SxDrtQny76a5BmQC9Dc2kEaC0yvbo1cT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtR2IWbKMdP8VqcFdJkPQX2zNEC6R/v7q0cVPtVnVEY=;
 b=T6SG+H2phdvXqw+upLwOZl5+UrL+6GqsTtim4B/oZSkdDvoxlzDpZtPdW150GsFMGSd457LfNfAhlX7HpE6T2he6kcw3AekT48kTY4VEWs0FiZOuh0Bv4dLChTUS39BnFnA1vYMWJle7knvwNDiGPUs+TjGn3w2qwC+BRew6Cop2qDdPSPKcdXNoYxNVoNnTWZ87NUeSk5mbibH/NaSoc/QvsiPQsbWWhOGuGQZIdFJsdqiir09XsGdmP60/xo9RpP06aQp3tFOE0NOQvSYiQYco3qSjUSIrHrEkb/ULcJU9iujt4YSTxcqJnAC5GM3fILNxtvIlHqhuto+BvUiAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtR2IWbKMdP8VqcFdJkPQX2zNEC6R/v7q0cVPtVnVEY=;
 b=oNjGhvjvB2f+tDqx3f/jLEFYElYCWI69eXx+A9uG1qHoYiAMcmu7k67QhNDMmga5VpsqEeIHjmQ4CCbwnRzuwKxrizkq10SngN858Z3A5+qmJn0tTcNPrYTXCDz4o45wu8os551z5RSNx+3aax0H9QcOqpfU04IYlfuxdepdw1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB5771.eurprd04.prod.outlook.com (2603:10a6:10:af::27)
 by AM6PR04MB4920.eurprd04.prod.outlook.com (2603:10a6:20b:9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 4 Mar
 2022 01:57:20 +0000
Received: from DB8PR04MB5771.eurprd04.prod.outlook.com
 ([fe80::884:f2d3:1dfb:6669]) by DB8PR04MB5771.eurprd04.prod.outlook.com
 ([fe80::884:f2d3:1dfb:6669%7]) with mapi id 15.20.5038.014; Fri, 4 Mar 2022
 01:57:20 +0000
From:   Kane Jiang <jian.jiang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Kane Jiang <jian.jiang@nxp.com>
Subject: [PATCH V2 2/2] clocksource/drivers/timer-imx-gpt: Change to cyclecounter for GPT input capture.
Date:   Fri,  4 Mar 2022 09:56:23 +0800
Message-Id: <20220304015623.338645-3-jian.jiang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304015623.338645-1-jian.jiang@nxp.com>
References: <20220304015623.338645-1-jian.jiang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To DB8PR04MB5771.eurprd04.prod.outlook.com
 (2603:10a6:10:af::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f957d716-5c2c-4df3-1b60-08d9fd824280
X-MS-TrafficTypeDiagnostic: AM6PR04MB4920:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB492031CEF758704644D1598E9A059@AM6PR04MB4920.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYeJ+bU0Qd2k/mjm6yu1RzF07EnFJEoV2W439BF/QhMc+MfUhVDXrOyBcq3z6Fn3689raTrtfM2VxddoRIfbLcviebIq/XSER0yrRtJZ6sThAiaZTNtTTwfasTUTJjibncb9gz8O4490C/MqxjbposvLzM2Xxw6Wo2Q0dPlgPj8ttsWpJ37quOqu1/bGid8iZhp2m6Y9EDhTQv2WnAz/nlnit0BeQfA3JZqnhZKG5JmtpFe6cGfn61yZo0dx8ZQ+617u3g+ig/0LYYI8keB3eR2hLESTNFmMYfg/TMLrt5euNISzRUL6kLlI2/pFD9QloaXp94Stc1JnYX9aXuwJo6OT2g3tFJJxuqgUeBUZ0YOk/EW20sseJd+pr+JmmhiP1xNqCo6q0vCwxdiIgbyvRMGdC5RDJG2ArwoEfL454anX/gfTZvAx/57yduRULYglsgv/HApSGu0KXGzUsk6mxbSRNAcByBdtm3irW2gFdi39BdNrJW9k/Ji0TuxAgFMcTPW4B+fy9gpSHrr15SgmlTL03qQt9uygMTYWWEgS+LetIh0hBiT7CW5cgdi6yQSDJrrr5OcxEH0WHYZ4rwjvDka7gCT1TaDigDzjCWb1PtGBuByTnLfs6qAkEFDzfriUaEwfPGzqamnxFGFl5DADWeyumL+b1t2LHoMm7Qw4z5ejB1P00RyKkkV5wXc6se12CcZLcZ4zBcV3sD7Jzz5VOcPp4X5tRYe3IUM7OyHWwTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB5771.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(921005)(6486002)(2906002)(6506007)(52116002)(2616005)(36756003)(6512007)(5660300002)(498600001)(1076003)(110136005)(83380400001)(186003)(26005)(8936002)(8676002)(4326008)(38100700002)(86362001)(66946007)(38350700002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/H3kyZw+wZZwTvxyJJVogK0c4U6RcCZuBvAJlP0YM/vLXU8aV+w8a+acCYWF?=
 =?us-ascii?Q?yb7b2Wkz+nLFjgpgmk0REcIKAGih4pgGAOGnX1cvRBLgc/U+Ch82WX9o/+AS?=
 =?us-ascii?Q?8x03vBLGd1JgJ3eAvgeTY4TmXzlZsxZALYVJgF+dmPhl8ExVN2JJF50dQEtC?=
 =?us-ascii?Q?6+j3+3NSi6a+NM5Izd862bZp++5mq8hXpqZz3lprZRugf9t/Hf3odtadyPiL?=
 =?us-ascii?Q?1vpA9naF4Vjy3zFK4FFoGV4RuxHHgFXGyI19l6MPbL+mMAe8yUPRKZVMbI68?=
 =?us-ascii?Q?c6SjilDc2WN/Hac6gziMNpKvAOfLrgCLRzVPT2X2bNEiKNlonlMn20/DPaJU?=
 =?us-ascii?Q?MtzLA3zkZPQQKKY6QbJpaYf8bX7S1BZ0biR7BAKIqEfBV9B1NVTCXdT+K/zY?=
 =?us-ascii?Q?21jylaxmL1ZBjsxysFvvFwNSC1NGcDmDzKW/yMxRTOVtgr8cj460EWA6Sm/4?=
 =?us-ascii?Q?orAte0Y1Fx0FrcTnfX9/862WGACXgrxsjb7A4QTzN/SOmlWJQlBKy4m1dt+7?=
 =?us-ascii?Q?WnoTPzYWVRKsNtEHoCWBV9N7WIaaaC3kh/xMzwVQYwwWNd30H1rkAcEAsI7L?=
 =?us-ascii?Q?dcNupAZOzEv/C7/qBULsiEg3FiWrRedhSvzjPYj6fz5CWma0YFZQrtsaHdEa?=
 =?us-ascii?Q?hb04BHCOmolKXFbZL8l9BQ+vjarvKwaHdSDqzGaM4suA1lmyj5OhdkxLrrWz?=
 =?us-ascii?Q?Dwb/Djk7R0hRnAIDqZY+vnf14oYDnlRoAP7dVfWKdrE4r75dQ1f+cjBJbIGe?=
 =?us-ascii?Q?ELMMyR4/7fNMj53zDoS1m5kqhdg74tkbwGIw0N6kO8mqaGoVNs25UaaS/oIm?=
 =?us-ascii?Q?YNKkQ6mWhzcqqM2rCpYDf4usyzf3OImT7JFgsgd1Nb1SoyxrNT+AR9lO+Xlq?=
 =?us-ascii?Q?FWwmUiLHh/mRhD3RMgqXv95rT+iJNbrdEEduCGubLYmGvceW7EWzrm5weAYI?=
 =?us-ascii?Q?Gj9typnDETEVnRMYtTNqr3CxlWlKLLKr0WyCOmevoMIw7nk24hvKoMAl6nLp?=
 =?us-ascii?Q?li+SXQXAYqWPnC+IGs6WnW4igyQfM/cZ1JfLwgmGZXTMhgHP9HjZkh0QykV5?=
 =?us-ascii?Q?yy3vZ2dcNjSIWYctGwPr94ehkCfDiP0zSZ7NStDXP7VHFBdw7aLd/lK67ujz?=
 =?us-ascii?Q?d2LXc9ub219nHm4pOvRW06TMw6y9s3MwyUEQvqF30egvanwmHdfLd5mibBrs?=
 =?us-ascii?Q?Wrrz6cdU0ZPbixgOyRMcM+tz8Nz+ao6SityM/GuioffjR6AuwWMEo8pgeFII?=
 =?us-ascii?Q?PrH5qV8/tiii0iyXrRME92K30ttW00syX/0WRGVJsbJk/0UNc39BN4yKrO1x?=
 =?us-ascii?Q?hum2/XRU7hXrZusBUMYpNYqW8s4pfT1PrbHoh9zPO0YWQWgFFXnEhKO0akVN?=
 =?us-ascii?Q?bBYSfzxxQCWVnDHaFAjxiN05p4MLGDyNPrDGE6Kncef7d7dBoJ3SMh2rE8E/?=
 =?us-ascii?Q?yXTYpJnqI/ZAO/ysSm+eqjnp8vHvI+WlroU9lzAKpTGJrQ2nRI2keGeqWems?=
 =?us-ascii?Q?luEGv+IQVrtuQO3oHQZlXrKZFINIs31qsEkOEApA2UYNskqAv4BV3Cv/4BkS?=
 =?us-ascii?Q?aBxUPaSpUniQ7LFWsYESFwdWUCUFgMouiSDR3OSDQz1hB16GS6hr26Jpbufa?=
 =?us-ascii?Q?zm0I8oynRKeG3Wk933pm/9E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f957d716-5c2c-4df3-1b60-08d9fd824280
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB5771.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 01:56:55.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMhwAtu6L3x2+DD+KFsDDLu44s7H+oG93kFXTZM0TQvCvWyxFv/RVZJ/HVtt9gWDzjciRFuW/Xw4Dn4L9Mm9yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4920
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the timestamp to cyclecounter in i.MX GPT driver for input
capture function.

Signed-off-by: Kane Jiang <jian.jiang@nxp.com>
---
V2:
 - remove compatible support for NXP i.MX8MM
---
 drivers/clocksource/timer-imx-gpt.c | 9 +++++----
 include/linux/mxc_icap.h            | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index c6aa1462e441..01f4d78d0b6e 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -417,22 +417,23 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 
 	for (i = 0; i < 2; i++) {
 		struct icap_channel *ic = &icap_channel[i];
-		ktime_t timestamp;
+		u64 cyclecounter;
 
 		if (!imxtm->gpt->gpt_is_ic_irq(ic, tstat))
 			continue;
 
 		imxtm->gpt->gpt_ic_irq_acknowledge(ic);
 
-		timestamp = ns_to_ktime(timecounter_read(&ic->tc));
+		cyclecounter = ic->cc.read(&ic->cc);
 
 		if (ic->handler)
-			ic->handler(ic->chan, ic->dev_id, timestamp);
+			ic->handler(ic->chan, ic->dev_id, cyclecounter);
 	}
 
 	if (imxtm->gpt->gpt_is_oc_irq(imxtm, tstat)) {
 		imxtm->gpt->gpt_oc_irq_acknowledge(imxtm);
-		ced->event_handler(ced);
+		if (ced->event_handler)
+			ced->event_handler(ced);
 	}
 
 	return IRQ_HANDLED;
diff --git a/include/linux/mxc_icap.h b/include/linux/mxc_icap.h
index fa5ffdf3b589..292c15b6b028 100644
--- a/include/linux/mxc_icap.h
+++ b/include/linux/mxc_icap.h
@@ -7,7 +7,7 @@
 #ifndef __MXC_ICAP_H__
 #define __MXC_ICAP_H__
 
-typedef void (*mxc_icap_handler_t)(int, void *, ktime_t);
+typedef void (*mxc_icap_handler_t)(int, void *, u64);
 
 int mxc_request_input_capture(unsigned int chan, mxc_icap_handler_t handler,
 			      unsigned long capflags, void *dev_id);
-- 
2.25.1

