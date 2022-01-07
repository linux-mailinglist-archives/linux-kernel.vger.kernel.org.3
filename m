Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F227F4873B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344970AbiAGHob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:44:31 -0500
Received: from mail-vi1eur05on2120.outbound.protection.outlook.com ([40.107.21.120]:43744
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344827AbiAGHoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:44:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CE9rEEBSZZTg9t/XKi6kNMYTXXUZBuz89V85AHdBDbFyo+hATiv2hBavs1j0WDuN3/PPEuPPc2chRJ5Yl1NZ3LLRP7wf1UcSCiSZqcR3E7iI9H7koQPjQSEMFc0sD2y2WobZgPuTqWSlqP0ANDKSbtGwSS6ONHFUgqL6/7bdZ6hp6aRhH7vodN36CUjJt1vjB4itRHh/Jk0lLWLgR/ooYQJw1QvtctdwJxeUgt5YS98uarnjNhstJKBXadHVfeC45spcBMSH/1swr0+EXcaYTgeS5fXgLlWmjGeJbaM4HKBQMMtBuFw72ZnoUwNB+5UfvylY+AV/1Xt8/b6dE3JR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xc/yQbL0IGc7qvuyjON7Ce5eE9T+c6acnj3L/mptDZA=;
 b=JNLDamnt46e71Mq5nAYuJUCN1T1R4fQ5Faj9GE7n3s/tTFcw4d09ZLVhwmzM8/r6hv9PG+7QCsEQdtMDjW5b9/QJLQJOu4pbXieUuHWeMlwpqwlgHBwbjQ3MqUQ4tHifvQMpZgnciiuYbxbQU6P+RrYCVzD91G/hv8hIkq1jwR8ZP2Orc+68AD1Wp5XPHXB3ah5Eu/7krSWO91w+wxUE46/30BBBe5IUxDnm/H7dH99l4TtC/GLRIDplvKodTCjjya74UGmyzWSEmuigs3Oa5G2Frl8t9MDlBi3VWPMzV/VXu97cVcQShOuvPy++/8bbquqMjv24z+YEKgWtteRipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc/yQbL0IGc7qvuyjON7Ce5eE9T+c6acnj3L/mptDZA=;
 b=LEqMAHpFdk7NL64TkEJowBlEXguUx/G46F7GnZx8CMBesbSccBlip8xgd8yGha0T9SSZolpN6jTnLdD3apJHDD9LJ6faiaXbgutJ3wfSw7Qt6u+UkB5DvbqlM2iLSerzWJvlL5Hix6ExIQiVcfSlpalK3peDp+JNz2hH/m630ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2792.eurprd02.prod.outlook.com (2603:10a6:4:b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 07:44:28 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 07:44:28 +0000
Message-ID: <aac25be8-9515-a980-f7cb-709938c84822@axentia.se>
Date:   Fri, 7 Jan 2022 08:44:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: sv-SE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 1/4] mux: Add support for reading mux state from consumer
 DT node
Organization: Axentia Technologies AB
In-Reply-To: <bd26e410-b2c4-888c-9bef-efc26146e366@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0101CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::24) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f74ec8-1e5d-4342-1211-08d9d1b18897
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2792:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27927C315CC8A320406A5FEDBC4D9@DB6PR0202MB2792.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:390;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1qgHMsZQO/vmzzvDCXP41CcurlWZfxwtGK6mDx+SLRzaRUpb3U2EfuqXNkWKeG+XyyZkj0acTB86NSY3s+NpI/RW8dBzxphzEm+zHerdK4D8J8MC8GW9nwoTUbbewEq/n74r859vdg8Z1cR0TcQpta9uXhh8rTVUnvU1HWxap9Jjw9dTDksBu7SazX7J+8EdudRL4YBSE3cImIERPn4boX8r37NWw5CGJR8vo0ZCb6m0b2ADJ7wt1mY5tx6pz0z/4+icj67lH/3HTGXfgnhmaS2A3MzddQpb4xo/6evpoREt0h5qon1PtyX6cigG/dPx1/ksNzywrzQEv9JapeV8VExds6UBkqEhG/eDvpOQv00pEufLL+62MjzU1w4yqvuPpu45f4KqkbAewIIldNS/jewCn96XezXnvV0eWb3St8YAKAruJqxoVEfMRnxgAckXjhihOfqxcwdJTXF0vWXGbaVNWRvOzDocMZUt/DwTbYvbRBj4fXF8Bx+cBQ2DFuBtHdTW+KXKobpu8NiI191GzoDPHfc5uHpd6wvHdECdPS2ffapEsgpObWSyQLnxFDsUFFTLvogv8cCt+qhSbTfLIf58Il6JsGwCN+q12Uq+5nKyIHVRJ47gfTg8BEMAZeCsRkTJUED8wIuHTvINhwaJ1h5VpsxMhqEIYut9o6WomNoWiY0+1ZqyLgZfr2HSNpJSCuf6TbRgUtN3G763NLplU5VEX2ynuvClGTjNm79iJPf3yo+PEZtF5vuyBqzpC68QSAa4Ugdz1vZ2EJbyIS1MQD8aQitOlwnloeSxDzSTeAlhvoFjKDloepIqtFF7sIu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(136003)(346002)(376002)(396003)(8676002)(8936002)(54906003)(6666004)(36756003)(31686004)(6486002)(86362001)(2906002)(5660300002)(83380400001)(6916009)(36916002)(38100700002)(186003)(31696002)(6506007)(30864003)(26005)(4326008)(6512007)(2616005)(508600001)(316002)(66476007)(66946007)(66556008)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHVBU1FIRmZvS1JqaGNDdGFIdEc0OGdvS0hWZVFKK1ZGNEhja2lxbmtaNXpK?=
 =?utf-8?B?aTNkc2pyZ3VWYlU2SzdqREYzM0lEbG1rTkdpVGNqamUwcW9mWGdLeVA1WHU3?=
 =?utf-8?B?UUE3Y1hQSGtoaVJWNXFJazJMdkFuaUZrTC9PMDQwaW1CL0I0SytYaGRGc05H?=
 =?utf-8?B?VFc5VTR1aS8vUG81VCtOQVFZQlRaV3o3amoxME4rWjBKSmNjb0ZGYTgyQVQ5?=
 =?utf-8?B?clpkWGxmVDhLeEdoT0d6bTFXZlZXK29pQjFQa01SVXBIYXI4ejYvc3QzYzJ0?=
 =?utf-8?B?Qi9NVFZGcTJvamYreDg0dStWanZrdjNiNXA1bjRrbEY3bVZJUTFZcUJIcTRa?=
 =?utf-8?B?cENuNjRnNEtIWld4ajJqU2RxRFlrMkVKTmxPOHVyUkJTMVBDYVpva3RLMUx1?=
 =?utf-8?B?Z2VMQVRHWEpGZmZ0a3J3UXh0Q0x6Tm82QUd2R1Btd0F1cTJKeXdELzNncUov?=
 =?utf-8?B?ME52T0VxbE9RbXNSdDFRdUp3dVZmbVhESURSYmRDVjBiS3llWEw1NHg1eWFD?=
 =?utf-8?B?RC9iWDNpUCtPREZOUUlJYzJuaXJpVTB2ZUdNR2g2WWxPQllQaDVPWkY2TUk5?=
 =?utf-8?B?Rk1DVmJReUFZMTRzVHVTV1RvVjZnT3lZemNXRXhxZHZlMkVuaFRtR2Y4VTFk?=
 =?utf-8?B?ZFdpcWs3SytCVjdWZ1BIRU5HTTM3K3JZZUp1WnFoZ0h1QkcxSmlVajZVUEdP?=
 =?utf-8?B?bHBHZHJlYitIVG5BU1RwWEVlOGFzOTdKOTdnSzRKbUt0aUNBM0REL20vTFQz?=
 =?utf-8?B?dzhlRTBHRnRDSWI3OTFSeGRsdWF0aG1Yc3cwTUo4b2s5TEtySTgySXg0eTY4?=
 =?utf-8?B?M1c5eG0xTXdnQkhMaCtaVEJsNGE4cUxORHJQeUtuWVROUzFzdEJlUEZ3MUg3?=
 =?utf-8?B?M0VlSWw2ZzJUMjRYV285M3l1UjVaQ0plWkhuZDJza2VFNjAycVdjaGVpZDFu?=
 =?utf-8?B?b1R6OFdFVStVRkw3UHRHN21tWUZvT2YvbVFvRmxIV0U0UVV3aU5XZFRJYlhj?=
 =?utf-8?B?L0h6YkdZeFVPMFVUUVZNV3BkYjV0WHNZMnpxaWRhMWxkTGZQVWw2MUxsOXhq?=
 =?utf-8?B?bzJlODVxNU8zTFQvQmtta3pyOUQ1SUtBazh2QjRlVlYyU3RHUmNVeVVKYi9l?=
 =?utf-8?B?QUx4ekd4Z0VXY0xzZXhoTUNVeUZlN1R0RVpScEZ6R3YrSE1TQ3gwVHIzZnBQ?=
 =?utf-8?B?SUZLU2R3aFN4SHRwYm9NOWRXaGloUWowMnA0N05QZkhubS9NRitTQ2xRUGk1?=
 =?utf-8?B?QUMyL3J3L282UVlsQmtFdXdOODNGM1VTckk0RWlod3B1M1kvWGwxVncyTXhq?=
 =?utf-8?B?WG1mMFBvM0Z5Z29xTHV5SURQVDlBSWIwNlB5eVVXWnZjL3dHVCsrYzVkM2d3?=
 =?utf-8?B?MnRwUTd1OXdYSmNHYzI0L2JZL3NvZ1R4SVFHUEJnYWRwQ3A0VHZ5VjNSNEts?=
 =?utf-8?B?dnRNdTRFOHArTzF0U1VmeDlIbkZucjZsbWZVQ1VpdGQvSUtleWkrbXpCVVBM?=
 =?utf-8?B?VDRMSFljNFBqZmREUFNvSWxGY3Fpa3RQcE9NblBacVF3REhhakZLeGRNd0M4?=
 =?utf-8?B?dmlnQUo1aUZTSE5kd1Zrc09OaFFsQUFteGZYMm1meFlZaVJSMXFZYVYvdHhy?=
 =?utf-8?B?TDk1bkg1azRyR2R5eThJaDNpdjNwMlBnZXptQ2ZreWl4RXNDRHBCbEhqWGhS?=
 =?utf-8?B?dnRSR0lNZjJvM0VaZXJnUjFWblBmcFVzZzJqNUErcjRQUlFaRlIrNGJzcWRB?=
 =?utf-8?B?cFFPamlMMmRnb21wVjduSnNPWmY1TkVpVVJJMVdvRzBNME5OcVdlMmtkV2hO?=
 =?utf-8?B?dWo1WkR3T1NZV2hjNUxhbXg0NitsM2N2UUR0VWpFazg0VEUzSm9rclUzUGpT?=
 =?utf-8?B?SkZpeGgyZyt4bGJleEh1Y0pvSGU1N3dHYVRCd1VQUmlzc0oxMDhCUGh3cFlY?=
 =?utf-8?B?em1zSFBtczN2NEpRdmxXWnQzNG9UTlVEVkN6NW1LVldEWXhLUGlNSk9LZlQv?=
 =?utf-8?B?bU9kS2QwU1RMait6aUxJWmdPWXN6TklFbG9acG5XN0dtOXlpQkdQeXZOQTFQ?=
 =?utf-8?B?T0ZHNG4valg0cmpKUHAyeVA0eEc4QUhUdVVxSHowT0locHhyMnI0aXptVDlu?=
 =?utf-8?Q?9V+s=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f74ec8-1e5d-4342-1211-08d9d1b18897
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 07:44:28.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQt6jOeRJnDwCxxKa88osuQRiPQn+2cENS/TwZUzqijTyIR/oPiz9cPRxZnluf1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

In some cases, we might need to provide the state of the mux to be set for
the operation of a given peripheral. Therefore, pass this information using
mux-states property.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Link: https://lore.kernel.org/lkml/20211123081222.27979-1-a-govindraju@ti.com
Signed-off-by: Peter Rosin <peda@axentia.se> (minor edits)
---
 .../driver-api/driver-model/devres.rst        |   1 +
 drivers/mux/core.c                            | 219 ++++++++++++++++--
 include/linux/mux/consumer.h                  |  18 ++
 3 files changed, 217 insertions(+), 21 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 148e19381b79..5018403fe82f 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -368,6 +368,7 @@ MUX
   devm_mux_chip_alloc()
   devm_mux_chip_register()
   devm_mux_control_get()
+  devm_mux_state_get()
 
 NET
   devm_alloc_etherdev()
diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 22f4709768d1..931fa8bd4962 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -29,6 +29,20 @@
  */
 #define MUX_CACHE_UNKNOWN MUX_IDLE_AS_IS
 
+/**
+ * struct mux_state -	Represents a mux controller state specific to a given
+ *			consumer.
+ * @mux:		Pointer to a mux controller.
+ * @state		State of the mux to be selected.
+ *
+ * This structure is specific to the consumer that acquires it and has
+ * information specific to that consumer.
+ */
+struct mux_state {
+	struct mux_control *mux;
+	unsigned int state;
+};
+
 static struct class mux_class = {
 	.name = "mux",
 	.owner = THIS_MODULE,
@@ -341,7 +355,8 @@ static void mux_control_delay(struct mux_control *mux, unsigned int delay_us)
  * On successfully selecting the mux-control state, it will be locked until
  * there is a call to mux_control_deselect(). If the mux-control is already
  * selected when mux_control_select() is called, the caller will be blocked
- * until mux_control_deselect() is called (by someone else).
+ * until mux_control_deselect() or mux_state_deselect() is called (by someone
+ * else).
  *
  * Therefore, make sure to call mux_control_deselect() when the operation is
  * complete and the mux-control is free for others to use, but do not call
@@ -370,6 +385,30 @@ int mux_control_select_delay(struct mux_control *mux, unsigned int state,
 }
 EXPORT_SYMBOL_GPL(mux_control_select_delay);
 
+/**
+ * mux_state_select_delay() - Select the given multiplexer state.
+ * @mstate: The mux-state to select.
+ * @delay_us: The time to delay (in microseconds) if the mux state is changed.
+ *
+ * On successfully selecting the mux-state, its mux-control will be locked
+ * until there is a call to mux_state_deselect(). If the mux-control is already
+ * selected when mux_state_select() is called, the caller will be blocked
+ * until mux_state_deselect() or mux_control_deselect() is called (by someone
+ * else).
+ *
+ * Therefore, make sure to call mux_state_deselect() when the operation is
+ * complete and the mux-control is free for others to use, but do not call
+ * mux_state_deselect() if mux_state_select() fails.
+ *
+ * Return: 0 when the mux-state has been selected or a negative
+ * errno on error.
+ */
+int mux_state_select_delay(struct mux_state *mstate, unsigned int delay_us)
+{
+	return mux_control_select_delay(mstate->mux, mstate->state, delay_us);
+}
+EXPORT_SYMBOL_GPL(mux_state_select_delay);
+
 /**
  * mux_control_try_select_delay() - Try to select the given multiplexer state.
  * @mux: The mux-control to request a change of state from.
@@ -405,6 +444,27 @@ int mux_control_try_select_delay(struct mux_control *mux, unsigned int state,
 }
 EXPORT_SYMBOL_GPL(mux_control_try_select_delay);
 
+/**
+ * mux_state_try_select_delay() - Try to select the given multiplexer state.
+ * @mstate: The mux-state to select.
+ * @delay_us: The time to delay (in microseconds) if the mux state is changed.
+ *
+ * On successfully selecting the mux-state, its mux-control will be locked
+ * until mux_state_deselect() is called.
+ *
+ * Therefore, make sure to call mux_state_deselect() when the operation is
+ * complete and the mux-control is free for others to use, but do not call
+ * mux_state_deselect() if mux_state_try_select() fails.
+ *
+ * Return: 0 when the mux-state has been selected or a negative errno on
+ * error. Specifically -EBUSY if the mux-control is contended.
+ */
+int mux_state_try_select_delay(struct mux_state *mstate, unsigned int delay_us)
+{
+	return mux_control_try_select_delay(mstate->mux, mstate->state, delay_us);
+}
+EXPORT_SYMBOL_GPL(mux_state_try_select_delay);
+
 /**
  * mux_control_deselect() - Deselect the previously selected multiplexer state.
  * @mux: The mux-control to deselect.
@@ -431,6 +491,24 @@ int mux_control_deselect(struct mux_control *mux)
 }
 EXPORT_SYMBOL_GPL(mux_control_deselect);
 
+/**
+ * mux_state_deselect() - Deselect the previously selected multiplexer state.
+ * @mstate: The mux-state to deselect.
+ *
+ * It is required that a single call is made to mux_state_deselect() for
+ * each and every successful call made to either of mux_state_select() or
+ * mux_state_try_select().
+ *
+ * Return: 0 on success and a negative errno on error. An error can only
+ * occur if the mux has an idle state. Note that even if an error occurs, the
+ * mux-control is unlocked and is thus free for the next access.
+ */
+int mux_state_deselect(struct mux_state *mstate)
+{
+	return mux_control_deselect(mstate->mux);
+}
+EXPORT_SYMBOL_GPL(mux_state_deselect);
+
 /* Note this function returns a reference to the mux_chip dev. */
 static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
 {
@@ -441,14 +519,17 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
 	return dev ? to_mux_chip(dev) : NULL;
 }
 
-/**
- * mux_control_get() - Get the mux-control for a device.
+/*
+ * mux_get() - Get the mux-control for a device.
  * @dev: The device that needs a mux-control.
  * @mux_name: The name identifying the mux-control.
+ * @state: Pointer to where the requested state is returned, or NULL when
+ *         the required multiplexer states are handled by other means.
  *
  * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
  */
-struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
+static struct mux_control *mux_get(struct device *dev, const char *mux_name,
+				   unsigned int *state)
 {
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args args;
@@ -458,8 +539,12 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 	int ret;
 
 	if (mux_name) {
-		index = of_property_match_string(np, "mux-control-names",
-						 mux_name);
+		if (state)
+			index = of_property_match_string(np, "mux-state-names",
+							 mux_name);
+		else
+			index = of_property_match_string(np, "mux-control-names",
+							 mux_name);
 		if (index < 0) {
 			dev_err(dev, "mux controller '%s' not found\n",
 				mux_name);
@@ -467,12 +552,17 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 		}
 	}
 
-	ret = of_parse_phandle_with_args(np,
-					 "mux-controls", "#mux-control-cells",
-					 index, &args);
+	if (state)
+		ret = of_parse_phandle_with_args(np,
+						 "mux-states", "#mux-state-cells",
+						 index, &args);
+	else
+		ret = of_parse_phandle_with_args(np,
+						 "mux-controls", "#mux-control-cells",
+						 index, &args);
 	if (ret) {
-		dev_err(dev, "%pOF: failed to get mux-control %s(%i)\n",
-			np, mux_name ?: "", index);
+		dev_err(dev, "%pOF: failed to get mux-%s %s(%i)\n",
+			np, state ? "state" : "control", mux_name ?: "", index);
 		return ERR_PTR(ret);
 	}
 
@@ -481,17 +571,35 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 	if (!mux_chip)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	if (args.args_count > 1 ||
-	    (!args.args_count && (mux_chip->controllers > 1))) {
-		dev_err(dev, "%pOF: wrong #mux-control-cells for %pOF\n",
-			np, args.np);
-		put_device(&mux_chip->dev);
-		return ERR_PTR(-EINVAL);
-	}
-
 	controller = 0;
-	if (args.args_count)
-		controller = args.args[0];
+	if (state) {
+		if (args.args_count > 2 || args.args_count == 0 ||
+		    (args.args_count < 2 && mux_chip->controllers > 1)) {
+			dev_err(dev, "%pOF: wrong #mux-state-cells for %pOF\n",
+				np, args.np);
+			put_device(&mux_chip->dev);
+			return ERR_PTR(-EINVAL);
+		}
+
+		if (args.args_count == 2) {
+			controller = args.args[0];
+			*state = args.args[1];
+		} else {
+			*state = args.args[0];
+		}
+
+	} else {
+		if (args.args_count > 1 ||
+		    (!args.args_count && mux_chip->controllers > 1)) {
+			dev_err(dev, "%pOF: wrong #mux-control-cells for %pOF\n",
+				np, args.np);
+			put_device(&mux_chip->dev);
+			return ERR_PTR(-EINVAL);
+		}
+
+		if (args.args_count)
+			controller = args.args[0];
+	}
 
 	if (controller >= mux_chip->controllers) {
 		dev_err(dev, "%pOF: bad mux controller %u specified in %pOF\n",
@@ -502,6 +610,18 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 
 	return &mux_chip->mux[controller];
 }
+
+/**
+ * mux_control_get() - Get the mux-control for a device.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
+{
+	return mux_get(dev, mux_name, NULL);
+}
 EXPORT_SYMBOL_GPL(mux_control_get);
 
 /**
@@ -553,6 +673,63 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_mux_control_get);
 
+/*
+ * mux_state_put() - Put away the mux-state for good.
+ * @mstate: The mux-state to put away.
+ *
+ * mux_state_put() reverses the effects of mux_state_get().
+ */
+static void mux_state_put(struct mux_state *mstate)
+{
+	mux_control_put(mstate->mux);
+	kfree(mstate);
+}
+
+static void devm_mux_state_release(struct device *dev, void *res)
+{
+	struct mux_state *mstate = *(struct mux_state **)res;
+
+	mux_state_put(mstate);
+}
+
+/**
+ * devm_mux_state_get() - Get the mux-state for a device, with resource
+ *			  management.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ */
+struct mux_state *devm_mux_state_get(struct device *dev,
+				     const char *mux_name)
+{
+	struct mux_state **ptr, *mstate;
+	struct mux_control *mux_ctrl;
+	int state;
+
+	mstate = devm_kzalloc(dev, sizeof(struct mux_state), GFP_KERNEL);
+	if (!mstate)
+		return ERR_PTR(-ENOMEM);
+
+	ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	mux_ctrl = mux_get(dev, mux_name, &state);
+	if (IS_ERR(mux_ctrl)) {
+		devres_free(ptr);
+		return (struct mux_state *)mux_ctrl;
+	}
+
+	mstate->mux = mux_ctrl;
+	mstate->state = state;
+	*ptr = mstate;
+	devres_add(dev, ptr);
+
+	return mstate;
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get);
+
 /*
  * Using subsys_initcall instead of module_init here to try to ensure - for
  * the non-modular case - that the subsystem is initialized when mux consumers
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index 7a09b040ac39..2e25c838f831 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -14,14 +14,19 @@
 
 struct device;
 struct mux_control;
+struct mux_state;
 
 unsigned int mux_control_states(struct mux_control *mux);
 int __must_check mux_control_select_delay(struct mux_control *mux,
 					  unsigned int state,
 					  unsigned int delay_us);
+int __must_check mux_state_select_delay(struct mux_state *mstate,
+					unsigned int delay_us);
 int __must_check mux_control_try_select_delay(struct mux_control *mux,
 					      unsigned int state,
 					      unsigned int delay_us);
+int __must_check mux_state_try_select_delay(struct mux_state *mstate,
+					    unsigned int delay_us);
 
 static inline int __must_check mux_control_select(struct mux_control *mux,
 						  unsigned int state)
@@ -29,18 +34,31 @@ static inline int __must_check mux_control_select(struct mux_control *mux,
 	return mux_control_select_delay(mux, state, 0);
 }
 
+static inline int __must_check mux_state_select(struct mux_state *mstate)
+{
+	return mux_state_select_delay(mstate, 0);
+}
+
 static inline int __must_check mux_control_try_select(struct mux_control *mux,
 						      unsigned int state)
 {
 	return mux_control_try_select_delay(mux, state, 0);
 }
 
+static inline int __must_check mux_state_try_select(struct mux_state *mstate)
+{
+	return mux_state_try_select_delay(mstate, 0);
+}
+
 int mux_control_deselect(struct mux_control *mux);
+int mux_state_deselect(struct mux_state *mstate);
 
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
 void mux_control_put(struct mux_control *mux);
 
 struct mux_control *devm_mux_control_get(struct device *dev,
 					 const char *mux_name);
+struct mux_state *devm_mux_state_get(struct device *dev,
+				     const char *mux_name);
 
 #endif /* _LINUX_MUX_CONSUMER_H */
-- 
2.20.1

