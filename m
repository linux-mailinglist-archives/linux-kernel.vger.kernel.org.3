Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4A352EBA3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349033AbiETMLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236610AbiETMLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:11:25 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2061.outbound.protection.outlook.com [40.92.53.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027C31157F4;
        Fri, 20 May 2022 05:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyedVb3uJrveWN5dW2knvVEb7MKJDC48EFu3QGVesDf08WuXp/3ak2FiPj3evIh5V7TPGBBTqUTFIk23Z4I2lI3/+drwbwf/or04NcdzbrQMLgCdJxCjV0Tjaip+lX9kO+J4MShXg4rnZIwX/keAhLDl1cRAI3LcztKb/HegM/ln5LiqMC4Zwtj2Qdx7pbG0eRTEyaYsCzUTZLzvGflbIbIL9SatOss/huNNiIFlcGWwh23fCdj1DH+qn0nphaw5g02R7TcTB+oKYaFusdq1FMABjRHR1zRSNx+8IXdCpUh61q8w3xKF1mOKUvFCH+Hu0xd/rn97QqLC1WuFAyZ1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qO1DMUoWyiwO0Qm0VFkiyciDE8mrwKUFMoAfnqFvEQo=;
 b=hWVreky8M/doNuMcjKgNMcV22rtIXQtAYjUWYoBniv8R8TBla4AW6PZnXIi46F69zWvf3JWKci+lWi7giGCL+HkcWlE1mM0PY0z+9yJtBJcsbahabJuVfUYXsxhIRMJhvxKax/n5IsKSL+c+klWFXpBRY+/KtllxY5yqkKovAPUQedwoZ5tbO+7Tp3Ldn5WI81uzxKy//caaB52MVQHZkhSz0GtzHNCNUV6f6kJTERO7HbNrTWJQEiTxA426QE4HAxCqvf6RIJU0uZFG7WSQZNzMglUQudjeq7YJtGIzgUj1cHjpkoc5pmldArRBDB9e4P5YpSTep0xICCXqoI5CZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qO1DMUoWyiwO0Qm0VFkiyciDE8mrwKUFMoAfnqFvEQo=;
 b=cdmW2VX+YLYUsfcSVvULuHuH+1nBF4UgVsytEG5N8vN/zKBJeyYSZEM+OaqUO9Oe4R3bhD1zQxU3KW1xjn8XEDxW1Kr+PunJjYr4fGAg0DSOoJ6Jbx/HQvEkpplxAKYBW3Kp6gvga0EwzX09ZYz2QXcLaHb5JHl+j8A1cGbMeGNYr6IOlSCtNFhE6rgqRp45P8q7tnCQf5qxlo3Q2U+Q81VRl7BVCMP1IqNK+LtprhMxP/RFjlXChsnUYeo1wUqd0T10ruim5bretgop+ypuqgkn5nwQCTnHQudrcsVrtaXuPcfJxire3bmRpmJ2DxjYH8d3biORQckSXdyRA7TuHA==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by PU1PR01MB2092.apcprd01.prod.exchangelabs.com
 (2603:1096:803:1a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 12:11:20 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 12:11:20 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] usb: dwc3: Fix multiple checkpatch warnings and typos
Date:   Fri, 20 May 2022 17:40:44 +0530
Message-ID: <HK0PR01MB28017A611E881B30930B5D6CF8D39@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [HgMsllKbLvCdudgXXA0fvzVJ2wNtGTn61TSt6TOuqrG5LZNA6h+23NFLXkM0ZGRq]
X-ClientProxiedBy: BM1PR0101CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::12) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <20220520121047.21026-1-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d97d55a-851a-4fdd-11c2-08da3a59d948
X-MS-TrafficTypeDiagnostic: PU1PR01MB2092:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9qy66x1f/vcRFAr5ZPTnSPJk2zICK36ViBifPm8Cwsk/mau1LtZxAHj0rUBmvSlXBS+FgdZjfTcV6FWC1CmjimHwPryyULH+oYwSGwqvxg3m6IxAhiKWloTxRKkKYW1aJyxB8+BQNyEAZjZCZ5S9GRJ/1ggzOsV3aFR/y+fZJNx/LAk+Jhx8UG1KnHhxSXoJ7ObvDi914afimmlNlW2UGu+vObBJ3ElCNenCPc/q8+xETZ0LXYnecdshEiRFGRWoEkOt1bqZCHnqUX+kfnE1xdlOPlxnuBa/rf4wIw3GY8kxKdYmXI4F/QS5VwpyslZgsr2Z0H//irXoxDzyqZsoalMG6FWJfLUM7CmtcO4MpnszQ0mf+zbnUX/ZEmifk4jS/MLCwQDAQVvdSQQlPG9VB/VksQjKnCWj+SoVFX6Zx6tlNcWvRwP49rdNWnnX2temxguOe4anpkTPYhUSuSSj/ihx3td1lqgsGQ3bhG3S2R03g45YO5YG54rUFwvXIij2EVU+rVPH+2/SPIVa3q4jb7pelaiX9s1MEFl3dnzoiXCqOOyrJw7mZUJsAb1jBNWcXyL/9WJT+gt7nH7FkPiog==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Di55IxCN34X8zDpTKChi76VbKC5Q8QfXyz6uAeeDnYqwciuj0DWMCCdIBT/t?=
 =?us-ascii?Q?BKxOXQwarKaoovxRUU+pKzXE6GRqcvNM/zIQCpJ4JQuWDKDO1ReTNFAI3DBt?=
 =?us-ascii?Q?6QIa0Wb/jBaWuH1BwO6VY0vqs/HRakXU4F3iFP3t5MqnsxM2PyQeOGhFUxgu?=
 =?us-ascii?Q?OA1oOPqheFtdyPbvJ2gO+JqcOJ5FVU6CwWH8PEINBjyDCtSyQ9ob7ykn+93i?=
 =?us-ascii?Q?qF4stSQqNC4+pPZfRfAiR7jv2USVczNzmZbkaoHt9iuOX0gw/g0zmJXFFzag?=
 =?us-ascii?Q?jHqIXVMpp+K9okir/ZIv0HB6AbJoCAENhWwlHQHLehIbVveQ93fuopOSYoKk?=
 =?us-ascii?Q?PFWfhN1YIlLuqDnJaAwCR/kty0Qp2UZoIakRF2hlntvJZzMAYeeXvXKhDTcJ?=
 =?us-ascii?Q?D7GChGnJy/zTfkFSJomz3PyOKaMab4U3JJ6WvJM96y1CQfZ1Gz06Mf6+rHXR?=
 =?us-ascii?Q?ZJM1V+Xvaaw2M5Zy6TYMmwxbdiP+WlP+X/hz7MjCwf8hUrdk2ipA4u21PIg8?=
 =?us-ascii?Q?FcQVbAwgaahv5+1HMpw1bU2zQi207/HOahWcP9B8REPxEknnrVaD24YuUGGm?=
 =?us-ascii?Q?LR8kOCZZF/JObRNY4gkRJ/9Sf+vg8PFXei+r1X5Aw8QlToaldT/trqRYbcl4?=
 =?us-ascii?Q?VjzMzfapAHQIjertRac9a6dKBDccLbLZYE096JEo8mADTT2cZhajI5UQ9EMI?=
 =?us-ascii?Q?Gt26h6COXbkfI2tBiBoMFlIORJnNz9LCby3gmY9BSqwl7EGLYT1iLm9l5QLx?=
 =?us-ascii?Q?yPdsJ2WBmFeM5+zjLwrvEQXuR2NphmY2Ibusz0vDnl/qcRyUeBKQcWLnN+ij?=
 =?us-ascii?Q?GNg+Gwy/cH/wlQ9KCCge7JsxM/OOcopGUxfzsDeDbDoWoHBIStahvbdYiUlk?=
 =?us-ascii?Q?58c/dmLwYOKZuQ4mrmU2xoBGYtdoYz6zgNcU2WfxSVNeIfwMaVUsgClOJXtb?=
 =?us-ascii?Q?vGInBdgsg3v+3w6VzZUL6ZKl5DxXFfBx1AlDI2+qUTMNyYfWcYO7eGhzzxZJ?=
 =?us-ascii?Q?hrL3cIFQ9VNXLgqrPHzwXxaHy7Ijg5R2fqSC5nVOJ1Zp1bnO38BAEMKr6HXR?=
 =?us-ascii?Q?3IpoOxgokTCrm2N0TQ/OMdXimV0Ijau+FwbnGTqvwXTLIk54YmDlChm9Jvs+?=
 =?us-ascii?Q?RDcUeiQKpCCrHfvhZtIpCHHjzyVt59APlC9ne1+gfj8YbQa47gF/NOnW3zoU?=
 =?us-ascii?Q?jRehWOkUKTFXf0OAbTsS+ZDW8SRnrQX7WDQNP/eUneiNrZQzeUIWAvCa7N5L?=
 =?us-ascii?Q?rjUvcrv3pb8NUtszMqdHHR5B+XjM16a0UOUgZFylmUpwLgP5tDW3TTuIo4yQ?=
 =?us-ascii?Q?Mxnp0BX0MSnaamDr715SSYj3QbDyo5s+799kR1rv4AZXKTE+SC/Ml/Cxofx9?=
 =?us-ascii?Q?kGk5LXYD7PwNRsXU+HcFYg1MJIbH2SNDNhf+IhtEgZxThrJC7Owgwvg6ojCy?=
 =?us-ascii?Q?ltHKPL2m7bI5frq6hpnYih9BgOxtLtGxVViUmSQjpwyhewJhW+QKAkwrhNLi?=
 =?us-ascii?Q?ZJh/V3K8p+Bm3vxrgH/Ediiv8EGm2K61O7XS?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d97d55a-851a-4fdd-11c2-08da3a59d948
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 12:11:20.2288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR01MB2092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes 3 checkpatch warnings and 2 typos in the dwc3 driver. All
of these changes are minor fixes.

Patch 1 fixes a bare use of 'unsigned' checkpatch warning by changing it to
'unsigned int'. This does not change any functionality.
Patch 2 fixes a repeated word checkpatch warning.
Patch 3 fixes 2 typos in Kconfig.

Change since v1:
 - Updated the subject line and the changelog text

Kushagra Verma (3):
  usb: dwc3: Fix bare use of unsigned checkpatch warning
  usb: dwc3: Fix a repeated word checkpatch warning
  usb: dwc3: Fix typos in Kconfig

 drivers/usb/dwc3/Kconfig | 4 ++--
 drivers/usb/dwc3/core.c  | 4 ++--
 drivers/usb/dwc3/ep0.c   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.36.1

