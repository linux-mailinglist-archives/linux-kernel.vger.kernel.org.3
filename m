Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8544784C5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 06:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhLQF5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 00:57:47 -0500
Received: from mail-vi1eur05on2128.outbound.protection.outlook.com ([40.107.21.128]:2006
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230405AbhLQF5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 00:57:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5xmgg4CSLq0fAs8nI+yV7nb9LmCVF4LxsCj120VMEWPtAs01N63pRlEYNOZ001yn6FBTWIYBq2c3AdEPYQYsRXid86XJSg5n+DqMW67ef3FVUwZtS4xOo05AkEUnud2bIQ4nlLLATDE9bVWf+YTDwjenWhQqQYEKJObl+6VlRWjHwaMHvOoLju0rG9JxiyJYtyL7IZ1bDCBD4Ul5UcY7Fi9mKKRrirGO/M4krQg4JY0VwflRBsXylujMwWlbdX/Dl3X9kKde4KqjQihuMH7xqNQ7P9xk/BMTeVARr82HmHl4lWvxi1P1SZy3tBPzmoOp/f/S2nKGIPzZSJHfhgPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/6gxJy4mGdt40jsreMpQd895ZRJdfTywZGkfCmC9pM=;
 b=FDhJI6v7ZUDeFLwmucLnqwbHtYjnH2VBwuTf3JV6MvEom11gDcFmPVYHhdkdgt+vPgyQc2MtOWW4o+AMQZXsD9fwofX2o/6235DmeLpDLlovZQ1iGGaaNyB1/VY4g65ZQ3DdVlXWUQmGW4C2TsXmwaXq8CRqkqh7Uu4s5mQRHU3OLrW3fBqS5P2Kqi2KaOoEVRCTdhfrzirQzXcJnuDbYqy9dN81HK5dnb2PsFJLlA6/5xqOVpQgQBToRtRcgImpzboSgTVzwB9q0UeEzLm2AnAXhKsklLUHJ5VutzGgkkKS8GhOCC35IVHcBYAnP0OZGSOWwqpmxBzUvw5ZBt+EwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/6gxJy4mGdt40jsreMpQd895ZRJdfTywZGkfCmC9pM=;
 b=MH6guJ/UHjSg1agXfMb4qIatAMZFiNdvk8ujAgp+QUNPlx376JC1tKjZpF4sV11vc3046Uq9bUje2p2SvnS81VAOLjBkjzHq3s2R4xYZz4wQqS/aDTnGa0lY0D8DRU0HU7iVHWL+XStDc5HQQRLo96U9zIxhUMJuUTWqszyDkfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DBAPR02MB6037.eurprd02.prod.outlook.com (2603:10a6:10:180::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 05:57:43 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 05:57:43 +0000
Message-ID: <59c57ab7-a272-b925-befc-79f88c925e3c@axentia.se>
Date:   Fri, 17 Dec 2021 06:57:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 0/2] MUX: Add support for mux-states
Content-Language: sv-SE
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20211202124053.2835-1-a-govindraju@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211202124053.2835-1-a-govindraju@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0090.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::31) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9fd31ed-3135-44a8-b43e-08d9c12223fc
X-MS-TrafficTypeDiagnostic: DBAPR02MB6037:EE_
X-Microsoft-Antispam-PRVS: <DBAPR02MB60373601AEBDB772C1A50FC4BC789@DBAPR02MB6037.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRdAnImPOoEnDZcOW/SantiVwHMC8BvqUvZ4fClFiVpsefKG6AH76ZYAAZgNuO5oXyjrG9V18BdHkZSniSK3dBzj5td93Z2mXt4+pYrHZPkxBM6KjGgOpG8aVxA1hEnO/XWFVuUgxK6LTG3c60w5eiBBNihSTpE9KnDXGcHWuMXhQl41sHrWHGP+J4BYTYMGEs8s65KhzY2L7yrwv+LZY3pF44Ty8fJKe6MAErreNYI3Y50AK84V+OaaEUzqK3tUpniObG75Tr7sbXmlUJYvgA1ySTHdyen0B+PXOdSt20dNCuZTdJAZskktYHpRz9DKdJeqbsk5zPULE8sO8t+Pfiwn/cyQlWMPl85i2xtlRrlAWIkWb06uPWk4e0dcon0FuQtdQP5fRvdAnwo/bpvb/IDX2rrIUKEaiIjeDvXJmiBkqw2WQBwl4KGWws9CBKyDyhvjpn//U6Gif2WwDALlAVoSKBqknzL+9BYi4OD/IYEycq8X9RGqeoaaLVlNy1EgkZvg5+a0ZewtiszfVh/38PDlbdTFI8lcdgbsxmEUDqcyDyrTEGwSREpqNkb7AeVsVEcbZ49EnKOqJ0jtZk1cTQhnofs+A09KTuAyCMhFTXZJK+O/v7yQA/tdq64F1moesHgcWVWGZh7MbGqKLsGt3pZr2yXtDIBwFR0qVz6QJDFmSFH/gbx2JdoNTPbaVriEPhLyeYFH11v44H6gEHqvWaEjy85/gCIN5OnhGe/2c8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(346002)(366004)(6486002)(38100700002)(36756003)(2616005)(54906003)(83380400001)(53546011)(6916009)(316002)(31696002)(6506007)(508600001)(86362001)(5660300002)(36916002)(6512007)(2906002)(8936002)(186003)(4326008)(8676002)(66476007)(66556008)(6666004)(26005)(31686004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkswTmo5MHRaNVNlUkhHbTBwWnBTdkpPZld0SGdFdnBDeWNDWFdDK2xtV0tL?=
 =?utf-8?B?L3NFajVmaDEwTjVuYWVCMHVsUURxbXpWb1k2TEJqVkNLY242dG1GTzVWN1NH?=
 =?utf-8?B?d2t3SDJwNndUWjFBTUM5dFJrVmhkVDlscnFob1YrZWk2RUVwSXJPM3N0Nzhp?=
 =?utf-8?B?V3o2MUJ3TCsxcjZzaWRoZkhWdHp5bFQ4eHZXMjdQcG5NQU9TTHE1a1dxWWtV?=
 =?utf-8?B?YnVSN0JjS29ZbWtwdGdBNlBtdG5VSXg2dGZQVkJISGFRRHdVa1hVTU5YL213?=
 =?utf-8?B?RnZNemdUUFFrdHV3Vy9XMlRRWkFLK0JMUC9LcVZwcnV3dmVrSXRhaVdadStV?=
 =?utf-8?B?STBMRitpNWpPTlpEcjczMFlEK0ZLbS9id1ZJMnl1dDI0cHBhNktOSUFQTWZB?=
 =?utf-8?B?UzZ1WUxrbno4eXQveHg0NUxpQ1AvWU01WHRSUm1IQ2hUMktxcEgzRzRBZDhK?=
 =?utf-8?B?cFVRNUY4MS9uNWJoZEdNSUJVdytWemtBUGxOTnVCVDNKOUZIVDB6U21pK0dM?=
 =?utf-8?B?VkRiR2tEb05EMnhXamVHVCtucTdDWE1LU2t6Szl3MWJCcm0xZ2V0dGM2cU1V?=
 =?utf-8?B?NjJOb2JrR3I0UFVMUll4Y3J2SzZKeFl1WEZDNmNkYWx2aEtMaTdDV2NDK05D?=
 =?utf-8?B?VlR2bWFYckNDbnNVM0d2NGNCVlJZWmVQd3Zza2NYUTZBWXh2Z2tqTmpWVlZy?=
 =?utf-8?B?Mm5icHRFK0IvdWg5YklzVFZ0SHJBWHBpQjJOcncrZ0ZDRFVaY0lMQVRHbEg4?=
 =?utf-8?B?aXdCTTV5cDQ2aDdTVHBMVGNNNStDTjlpdXZRcTJsTk1DWm56eUU0cjgvN1B3?=
 =?utf-8?B?NGt5ckdCRVl3NVdNcHBycUg2RUpnT0FEZWc3SjJUek11dSt2ZnYyWjhBb29B?=
 =?utf-8?B?S2kyR2d2eEE0TnZuUEE3Q2NWMms3UGNJei95UzhWdmJVNmJReE1kbmhncUZp?=
 =?utf-8?B?cS9JYjlmRXZsT0RjYlBreXBUNUM0ZGdQclRSUTRDUnJoZ1dRYTQ2dnppUTV6?=
 =?utf-8?B?L3hNbm92WDlSNkI0WnhlOC9RL1RabmQzTzVLOTNXUUlRalhBaTVhV1dORmhO?=
 =?utf-8?B?Tll5eStBblVzQjRWVk8vUGFrbjBCSWcwWWRnSEliLzhjVTI1OUNMRWxuVG45?=
 =?utf-8?B?ekNweDVPbDBOQm0zUDBqTU95elloMHZuYjZ4T2pjQWRtVUVKYk1Ycng2ZzF4?=
 =?utf-8?B?WWNGdEowWGx2V0RBcDVJOVJISExUZFJlTUY2b0NMVEZ1UitCRlczemlRMWl0?=
 =?utf-8?B?VW5xMGw1Vi9FS0lVb3pLOFViQWc2eFNxajVzMFJwd1loR1hTS2JlUlArZ0Rn?=
 =?utf-8?B?WHBESURWejVVc2NXcHRJWVB6WUs5eU9UZ0IwdjZOWnFDL1dpQ1pURHhHVHo2?=
 =?utf-8?B?UUcxazRBb0N5WlNmbjhoeVl5bDZRQ2FseGJCTmJZcjZ5VjBMK0tGS21PSEVQ?=
 =?utf-8?B?WjJGdWM4NFdkeWNxYTVuaC9BTUpJRGZXbzRqUmtvdS8zYk53NnVST0hZNENP?=
 =?utf-8?B?L2RSMzU0YktEZ0lBRXhneWVVT3RPaERtTHdjd0xhVWc1WlBndnFKZFh2K3dW?=
 =?utf-8?B?ZGwyelg0SlpWb3pXVGUxblZRNVNlMjdVTUEwTnRsT0pVL0l1UzRVYzJrRHVY?=
 =?utf-8?B?RW1SK0J2b01YNDcvTTluYUJ6YXUwUGEzRkJUTkt5a3haRWR1R1gxNEZ0bHFi?=
 =?utf-8?B?RjYyUVVRd1ZlZUZMREpGUFRYaGpqdVg2N29qcGhRMk5YNUhJL08xYXcyekwv?=
 =?utf-8?B?cTdlYy9vTWpHaHRWdzArK0tvK2hkVjNiY1AvV2Y1dlgwUTh5d0dVRk13N2tF?=
 =?utf-8?B?Wmw2NFBYQnJxZGJ4N0tPRUlMd0txSUNNUXBRMnFaS1NjZDBNbVZMVmtoR042?=
 =?utf-8?B?bFo5TTV0eVFPcnB3ZWdpZndNR0RlTlhnQVZYcnpwdUJ4QjhtMmxhbUNCSmN3?=
 =?utf-8?B?akVwT29QUDZBT0J2cnZlL1NuS1pqTzNEcDk2QzJYcE5zNSszUkVRQUJaUENX?=
 =?utf-8?B?cUZoaVNyZ2hIMHRoOW1YK3Jrdy9qY2haMmlaTDdRUDB5SUZ3QVlGMVlZRVkr?=
 =?utf-8?B?YVVYaGZKeGpiTXZ0L0dIeWNpREJTY0dsK0RFYnFpRWlWTlBuR2IrWHBXY1V5?=
 =?utf-8?Q?gEAU=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fd31ed-3135-44a8-b43e-08d9c12223fc
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 05:57:42.9636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18wwdlEH4YwpCgAZvypuT7XmsVv8JJO0JS+jA0hx1sl1dEHZMjE6677bfAxnCWkG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath!

On 2021-12-02 13:40, Aswath Govindraju wrote:
> The following series of patches add support for reading mux
> state from the device tree.
> 
> changes since v1:
> - Made grammer corrections and added more information
>   on the usage for mux-states and mux-controls
> 
> Aswath Govindraju (2):
>   dt-bindings: mux: Document mux-states property
>   mux: Add support for reading mux state from consumer DT node
> 
>  .../devicetree/bindings/mux/gpio-mux.yaml     |  11 +-
>  .../devicetree/bindings/mux/mux-consumer.yaml |  21 ++
>  .../bindings/mux/mux-controller.yaml          |  26 ++-
>  drivers/mux/core.c                            | 219 ++++++++++++++++--
>  include/linux/mux/consumer.h                  |  19 +-
>  5 files changed, 271 insertions(+), 25 deletions(-)
> 

I finally found some time to have a last look at this (fingers crossed) and
pushed it out for testing in linux-next.

I did end up squashing in these trivial changes in patch 2/2, I hope that's
fine with you. Just holler if not...

Cheers,
Peter

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
index 7355c5ad41f7..bf448069ca85 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -30,12 +30,13 @@
 #define MUX_CACHE_UNKNOWN MUX_IDLE_AS_IS
 
 /**
- * struct mux_state -	Represents a mux controller specific to a given device
- * @mux:		Pointer to a mux controller
- * @state		State of the mux to be set
+ * struct mux_state -	Represents a mux controller state specific to a given
+ *			consumer.
+ * @mux:		Pointer to a mux controller.
+ * @state		State of the mux to be selected.
  *
- * This structure is specific to a device that acquires it and has information
- * specific to the device.
+ * This structure is specific to the consumer that acquires it and has
+ * information specific to that consumer.
  */
 struct mux_state {
 	struct mux_control *mux;
@@ -354,7 +355,8 @@ static void mux_control_delay(struct mux_control *mux, unsigned int delay_us)
  * On successfully selecting the mux-control state, it will be locked until
  * there is a call to mux_control_deselect(). If the mux-control is already
  * selected when mux_control_select() is called, the caller will be blocked
- * until mux_control_deselect() is called (by someone else).
+ * until mux_control_deselect() or mux_state_deselect() is called (by someone
+ * else).
  *
  * Therefore, make sure to call mux_control_deselect() when the operation is
  * complete and the mux-control is free for others to use, but do not call
@@ -384,16 +386,15 @@ int mux_control_select_delay(struct mux_control *mux, unsigned int state,
 EXPORT_SYMBOL_GPL(mux_control_select_delay);
 
 /**
- * mux_state_select_delay() - Select mux-state
- * @mstate: The mux-state to select
- * @delay_us: The time to delay (in microseconds) if the mux control
- *            changes state on select
+ * mux_state_select_delay() - Select the given multiplexer state.
+ * @mstate: The mux-state to select.
+ * @delay_us: The time to delay (in microseconds) if the mux state is changed.
  *
- * On successfully selecting the mux-state, it will be locked until
- * there is a call to mux_state_deselect() or mux_control_deselect().
- * If the mux-control is already selected when mux_state_select() is
- * called, the caller will be blocked until mux_state_deselect() or
- * mux_control_deselect() is called (by someone else).
+ * On successfully selecting the mux-state, its mux-control will be locked
+ * until there is a call to mux_state_deselect(). If the mux-control is already
+ * selected when mux_state_select() is called, the caller will be blocked
+ * until mux_state_deselect() or mux_control_deselect() is called (by someone
+ * else).
  *
  * Therefore, make sure to call mux_state_deselect() when the operation is
  * complete and the mux-control is free for others to use, but do not call
@@ -415,7 +416,7 @@ EXPORT_SYMBOL_GPL(mux_state_select_delay);
  * @delay_us: The time to delay (in microseconds) if the mux state is changed.
  *
  * On successfully selecting the mux-control state, it will be locked until
- * mux_control_deselect() or mux_state_deselect() called.
+ * mux_control_deselect() called.
  *
  * Therefore, make sure to call mux_control_deselect() when the operation is
  * complete and the mux-control is free for others to use, but do not call
@@ -444,12 +445,12 @@ int mux_control_try_select_delay(struct mux_control *mux, unsigned int state,
 EXPORT_SYMBOL_GPL(mux_control_try_select_delay);
 
 /**
- * mux_state_try_select_delay() - Try to select the mux-state.
- * @mstate: The mux-state to select
+ * mux_state_try_select_delay() - Try to select the given multiplexer state.
+ * @mstate: The mux-state to select.
  * @delay_us: The time to delay (in microseconds) if the mux state is changed.
  *
- * On successfully selecting the mux-state, it will be locked until
- * mux_state_deselect() or mux_control_deselect() is called.
+ * On successfully selecting the mux-state, its mux-control will be locked
+ * until mux_state_deselect() is called.
  *
  * Therefore, make sure to call mux_state_deselect() when the operation is
  * complete and the mux-control is free for others to use, but do not call
@@ -642,26 +643,6 @@ static void devm_mux_control_release(struct device *dev, void *res)
 	mux_control_put(mux);
 }
 
-/**
- * mux_state_put() - Put away the mux-state for good.
- * @mstate: The mux-state to put away.
- *
- * mux_control_put() reverses the effects of mux_control_get().
- */
-void mux_state_put(struct mux_state *mstate)
-{
-	mux_control_put(mstate->mux);
-	kfree(mstate);
-}
-EXPORT_SYMBOL_GPL(mux_state_put);
-
-static void devm_mux_state_release(struct device *dev, void *res)
-{
-	struct mux_state *mstate = *(struct mux_state **)res;
-
-	mux_state_put(mstate);
-}
-
 /**
  * devm_mux_control_get() - Get the mux-control for a device, with resource
  *			    management.
@@ -692,6 +673,26 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_mux_control_get);
 
+/**
+ * mux_state_put() - Put away the mux-state for good.
+ * @mstate: The mux-state to put away.
+ *
+ * mux_control_put() reverses the effects of mux_control_get().
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
 /**
  * devm_mux_state_get() - Get the mux-state for a device, with resource
  *			  management.
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index bf5abf062c21..babf2a744056 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -27,6 +27,7 @@ int __must_check mux_control_try_select_delay(struct mux_control *mux,
 					      unsigned int delay_us);
 int __must_check mux_state_try_select_delay(struct mux_state *mstate,
 					    unsigned int delay_us);
+
 static inline int __must_check mux_control_select(struct mux_control *mux,
 						  unsigned int state)
 {
@@ -37,6 +38,7 @@ static inline int __must_check mux_state_select(struct mux_state *mstate)
 {
 	return mux_state_select_delay(mstate, 0);
 }
+
 static inline int __must_check mux_control_try_select(struct mux_control *mux,
 						      unsigned int state)
 {
