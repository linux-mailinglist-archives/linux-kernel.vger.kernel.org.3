Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35343482D08
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 23:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiABWir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 17:38:47 -0500
Received: from mail-eopbgr130120.outbound.protection.outlook.com ([40.107.13.120]:19015
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230498AbiABWie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 17:38:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6qaihE7KehZqUDExpr70cCI56yVmlTWfGdqMJ0mBS4MSvlRXA1LjSEQF0uARwBzgMiJfZOLhrotuBV2a9UAcivHGad5e++E0qa/inxVZj7ioTLcmd3UyPw63GsTiZnGlEyNQUooHy52zRACWT8V1Lf84J5CEKTL516PIj/4lnPUoAYsj9cPqRkF1D3tnTR88MJV9bULL1isLMYSpxo2TybtL6FT0YTWkF7cz8Er/+KoVZNoC+bmn1rog22nWLkk4IVmK/4+3WpHtNHMkW0k1axD1owmktQRE4/z9iPT0s3tHZMexZrHa3yJ+stUi+qR06kT6A8wrc/BD8gBJBFENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLUL9d9jrFSuoVskwGBLLKAqL6JBAhwp6nAOU8pTo8Q=;
 b=jhGU3RYZ3HyyxagEy2K04xNKx5YyKgxY02PjWAbsSe8jnd16cHvRWqNceQOEZgC8WX0qhNxg+xdB8aMqsn+B9FFGtz8o66UYa4pkBcKgbVYXG8MBbFqOr6tycAP3ZcZe1rRjn/y6Kq+7jrmE2ZInRkzIpPKkgxJ02nVQKsYxcPMcVveCAddDv7UJWSwhroqIKQ3H21+Fa11Wrxwydm3qPRgabrIMpwhpbKBw2MfLuPEIR043W9oGDpZdD6jzyexzx141yf8428CicEvl1kX1epzJc7xF/GpAu9XOzvEQe5LVAU9sy9vS0Ikp5yJhZaAoCBGbSj4kVWNssCO3FpEfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLUL9d9jrFSuoVskwGBLLKAqL6JBAhwp6nAOU8pTo8Q=;
 b=Rqr5ZGSoZRERTqysNiIsr5Sd126cS12TRDw8gfIlAlJ4Jgq2orDaXhEwBE72FF0N7CQqb3RvsJH9XMDDXKAX+cKOqNSo7KySv4HUgX+GfN17CCXQUlCb/nm5sSMvmU3m+h/ckX41KV52zEonofMHm1N0nvz2HKE0dVOWKRTk73o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2920.eurprd02.prod.outlook.com (2603:10a6:4:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Sun, 2 Jan
 2022 22:38:31 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4844.016; Sun, 2 Jan 2022
 22:38:31 +0000
Message-ID: <b9bb0b36-cf58-b436-6b72-c4211022981c@axentia.se>
Date:   Sun, 2 Jan 2022 23:38:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: sv-SE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 3/6] mux: Add support for reading mux state from consumer DT
 node
Organization: Axentia Technologies AB
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0080.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::29) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b226adc5-b90b-43d2-a3d5-08d9ce409a46
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2920:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0202MB29201F2D9171F81569B7C264BC489@DB6PR0202MB2920.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:390;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avEtf4EupVsL16s4mulei9fQlgrBKUCMowC5tjve3c4nUtOpBaWRvTSs5cJvxl/QxoFPGkSIxKdWBKejIcTB+LMSOpVXBH1CISqL3vzQ4G+vX8Ox84sbZfE56Wd4ngub8ya6kPYDy1FgnoDJMzmmbnx7P8AQG9kwFrec+HWHLXfCdotwAlQ64EfhRbiY7R3u+J1kMs45FCJd9P+RRCCXvgCPjENJgJrfFVPbvE0rNsWTzNH0VLmWukHCBizfJ+IQco5n7HkmXfx+raR8qDU38zoZJ0/XJotS2C+yo5g9k2HQOTLxbzinvraW3LYs0W1j1aNj4oF8Jj5webLdwdB8eIOCkwPmRklwDhi9x/q6zxGdARKqS1gal1+0a9c8rU/+BekS1kqr882oO8A9poWtJbYL4hVeHKSmxpTJ5sAfhWtzRxr7Utiu3JcHEJIf/9EXy5RYj6QlL1XPfkPA9eZNaw21j4F4quQGtD/G/QVEBT7DBWrcg1LHdvrrN8Adnf/zfdx6Rk42EELuRq+zjlcsFgCKGf8CtpDNkbsCTiFFHvJlUHMoC449NDAXy1NHew5Hv8TIuahcyGxO5senfeMwum4Ve948zTTi/RyGNU06ZMVDrB7KkSuPxrBtWominsX4ERFh0woGYLczK01OSy3mpnCDu13RoA58IuLNMJkSnxLFNg17MhiTWCsek4fHH5kO/CQA/mMOM7Ruv2y0smiSq63Oc4M5tTxTLkPpL9zcvQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39830400003)(136003)(376002)(396003)(38100700002)(508600001)(4326008)(36916002)(31696002)(54906003)(2906002)(30864003)(83380400001)(2616005)(66946007)(316002)(5660300002)(8676002)(66476007)(66556008)(6916009)(86362001)(36756003)(6506007)(26005)(6486002)(8936002)(31686004)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFM4RlNrWVFKdkhCK0xjbGZQTEhlMmwyUmNuQ3pxbmNKZFVaOTdmdVVnUEYx?=
 =?utf-8?B?VmJvTVkwUkJtNVFDUERNL1RHTWNsNGxGNU5FaUdJRVZSQnpMT3cwTVFvMmQx?=
 =?utf-8?B?Zm1rZDQ2VmVnbHRNYkgyNFl1YzFWMlpPRmlZOFBwYVRwMnljS2dLTmh3QmVZ?=
 =?utf-8?B?amh4MjdLUklKTkozbWZOWUtQTzFJczlUU2Z6Q1lxNUx6UG81WHA2L05LZzJO?=
 =?utf-8?B?MitNLytCczVnSXk4UURFMU03MG5rZUFzejJZTmJ1eHFQNWREL1RmSFJMSWM5?=
 =?utf-8?B?S21zNXpsYTdZYjY2UC9DaERJL1d4aEptZDFIOVM5aDhvS3VYSnJpbmJmejln?=
 =?utf-8?B?UjBFYXR0cWQwYUwra094b0lEaEMzdkpBS0o5QTdkYk9VckJJQkxuOWxSSWVa?=
 =?utf-8?B?WENNbjlDUXVoNkQwU0pNSDJpeHlnTXVoUXVYYnlzVjBsL3NRdXJWY21LK3hx?=
 =?utf-8?B?cXBnanNEYUtIL3pRak5NdDRINjY4SExqY1dkS1Uvak96bkY4eU1tNVFLYnp5?=
 =?utf-8?B?eFVjRFVJVUxzOGNZc2pQV2NKcElBVFZld1pHMG5rbWprRFZqMGhkRXFWZits?=
 =?utf-8?B?eVVzU25SWnc2dkpqbGM0eHhPb09rSndkb3RDRzErSTBWamRudUg3RGtvdW5L?=
 =?utf-8?B?VFFiL2RiQTZleW9WVEJ3NDNKTWlaWjc4ajM2SllwaXhOM2l4ekJpemJFQWZH?=
 =?utf-8?B?bWNIZHdLM3laaFpBSnB1QU5TL2I5UEZkNGlSOUZqOHRBaGl6VDVVbHN3YU5U?=
 =?utf-8?B?ekN5UUNSSElrMytpV3hKbWsvRE1YZVVmd1BucG1tMDdVaDFyOEp6eG1LVUI0?=
 =?utf-8?B?eE96U1ZJeVJkdjNSRkdqNEREaDlGN3hVdWRpRDBYVndFM2d2TEE3WUM0N0Nw?=
 =?utf-8?B?cGVodUFnc1U2dS9JT0lFcjB4Z2QwSXpZT2ZoNm9LYXNCd0labm4vdXJhMzBh?=
 =?utf-8?B?cjQ5YTZOeC9lQkM2dVJ1OU5zZ2VEMk0yR3oyR2tUaTlocC9iOHQ0a1VsV0ZY?=
 =?utf-8?B?Rml4TVM4emUweHkxaVB3anpxQyszYlZaUkxvUGlHdG01aTl1T3FhNWNPdGpN?=
 =?utf-8?B?eEVIc2g3ZXo0UDN5akd5QVlMUFpLcTkyREd5TnEycFdiTElFdlF5QjNDdC9I?=
 =?utf-8?B?bW9xRVBEOXBUV1pieTlsYXZuRlgyZkFHUnJUZEtZbStBVlcxblFjeWtnLzha?=
 =?utf-8?B?L3dXUExUVXVQeFpnbWtiaDNSeXBiRXpNcytDcUlFdzhnMzNFUUc5SE01bVdy?=
 =?utf-8?B?Wjhna0wwclNTaDRTQ0RKNldhVkl0YnFRd1c2dVAwWlR2Q1VRM1I2Q2NrOXox?=
 =?utf-8?B?Q2VvYjdEaGJFOUZhKzlJaSswNkZRRzRIUW40Rm50T1BoSFBzaXhTTEtjNkh3?=
 =?utf-8?B?SENoczl2Uzg5aVM4N3ZuVENKZzBINU5FRkZXSndKY2lpQ0xPdWQzVkFXajRq?=
 =?utf-8?B?d3JhUFM1dDl5K3NoMndES2ZIN0xSOCtqa0dpQVpMUCtDK0tnSnJ6UXg0UU52?=
 =?utf-8?B?NGxnREFYVDRpZk1PTDNCVjk1Vi81enc1QXUySlFjQnROczAyZ051WEFPclZX?=
 =?utf-8?B?eStFU01iL1ZQUmN1elhNZDRPbFBRUWt6Vy9HbWdFN200aFQ0aS9VQ0Jxc1VO?=
 =?utf-8?B?WmtaQ0dKWElmZ2ZEQ2NlWWpsZDIrdTJodkVxZnFOK1VrLy9CK1RqTjhrWjVw?=
 =?utf-8?B?R3dEQklzUmxidlpSL0RyWHBUU1RUV0JTakdrTk9pN0ZXR3ZUL1hwdmlKOFpR?=
 =?utf-8?B?Uys5MXV0NjZqclVJcXVONnh4c2l2M1hjRTlDQ0lZSWIwTk1wUklMTVdLRmpN?=
 =?utf-8?B?RU9PeEltR2UxM25JMEowZVNJaHZsa2VMTHhLS2JJd29uLy9WUmhWM3h3UFFX?=
 =?utf-8?B?Yi9zR2JxVENneXZ0U0FHc1BPdjhpSlpyWC9xem91RVBQNHM0MzZHY2JKbXNZ?=
 =?utf-8?B?WlBpUTc4bmwzVjYvY1VMRzhZWlM3ajM1S0I5bk9nUGhZM0J4SzN0TUk2blpw?=
 =?utf-8?B?OUlWV05raC96OVVWa2pQVzNMSXd2TVZMenJ2eVY1NGxrU0JnVmF3TzhoWlY4?=
 =?utf-8?B?aW9HSlZVSjVVVG0vcmV2TTRjb3NxY24rcEY3SitmRHVvN0Z1TUFwb3pLZ3Fv?=
 =?utf-8?Q?u64s=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b226adc5-b90b-43d2-a3d5-08d9ce409a46
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2022 22:38:31.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siI3eVEVejw4RTKsjlD43AkWuWoKC9AjHZw1OayomianBTL1twv8SkKo7nlApTuQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2920
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

In some cases, we might need to provide the state of the mux to be set for
the operation of a given peripheral. Therefore, pass this information using
mux-states property.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Peter Rosin <peda@axentia.se> (minor edits)
---
 .../driver-api/driver-model/devres.rst        |   1 +
 drivers/mux/core.c                            | 220 ++++++++++++++++--
 include/linux/mux/consumer.h                  |  19 ++
 3 files changed, 219 insertions(+), 21 deletions(-)

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
index 22f4709768d1..7d38e7c0c02e 100644
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
@@ -553,6 +673,64 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_mux_control_get);
 
+/**
+ * mux_state_put() - Put away the mux-state for good.
+ * @mstate: The mux-state to put away.
+ *
+ * mux_state_put() reverses the effects of mux_state_get().
+ */
+void mux_state_put(struct mux_state *mstate)
+{
+	mux_control_put(mstate->mux);
+	kfree(mstate);
+}
+EXPORT_SYMBOL_GPL(mux_state_put);
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
index 7a09b040ac39..babf2a744056 100644
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
@@ -29,18 +34,32 @@ static inline int __must_check mux_control_select(struct mux_control *mux,
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
+void mux_state_put(struct mux_state *mstate);
 
 struct mux_control *devm_mux_control_get(struct device *dev,
 					 const char *mux_name);
+struct mux_state *devm_mux_state_get(struct device *dev,
+				     const char *mux_name);
 
 #endif /* _LINUX_MUX_CONSUMER_H */
-- 
2.20.1


