Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C761482D0B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 23:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiABWjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 17:39:00 -0500
Received: from mail-eopbgr130104.outbound.protection.outlook.com ([40.107.13.104]:16774
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230493AbiABWi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 17:38:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjzEDxja55YaV12CQtq+Ov3VtsYnXusrDS/rKlCJ5QXJYql0fepqzlXo5Ec3gww5HvCM3c2SsA2v3MdKcktFaeYyCGnoU3RovZoixe1JMKkHe4SE9WMFUa/7VBdozLogv3vNOPZhHTkyTOAH2MSk0sEJbTzQwWTTRW5p6Mx9jQYGgSO1tTvCHkSsq1awFJld7bGVH9bJzm8Q57vXaAvknEBHu7pkoQSSYYQKmjP873/J0zVOXJh3VUcR2oGKu22n6oW0Q6l2x8gmwhbftkbVK4jk83ALSj9owbpd85nKTcy/e2fT8QScrkzrEA6IVyF8pGCizNh7Oojwu/G2xKOGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJYoSz1dOB8Usi+T47aToYTEkI6Si+2Q73jn/b1jA+Y=;
 b=TGymrk/cifmat0DM+QqrKvNT0//NxRevZBVUidMNKO4uiLxsBKZ1kbIM7uydt6JYAaf7mwk6WPaXR0pQ7OowLeoKXILl63GRJXIaBCIFMJS5/9d+pigoNDGJchaLdtCOSiFRe5uX99CQQSniyhGKunsaq74IadX9qwYXwNjOJ0XgnsnEaIUwQOPUWHlTqZu5OxBlaMRqQN5TCW9BOdZE+UpVTplRpohu+kv8d65wkgy7lNIHjY7pN3YUt0buUB/cwKbZDEwOG+R2dAbAku4aseyL43e78wDk94KDxwfc6x7o7XmMDpR/BcycwatSiIaCHGHydUxtzzuxuL6tGhuPPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJYoSz1dOB8Usi+T47aToYTEkI6Si+2Q73jn/b1jA+Y=;
 b=Wmc22GKs5Mj8QQ/9eNN2YJXtI/KWAH7pQGbyUEXBBSqoo13/K+y9WJnKkd6zhu49pP2erQU/kOed1QJYazwS+yWMl53KkwC5VlLovQYRUblOUx2BXGpR1UR7JkTcXq4z4WmtxiUipO3l7giv8ptp+S/0D73OYGKUCxIBN0k6Q+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2920.eurprd02.prod.outlook.com (2603:10a6:4:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Sun, 2 Jan
 2022 22:38:57 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4844.016; Sun, 2 Jan 2022
 22:38:57 +0000
Message-ID: <2f5b3fa0-1722-e7ca-dc88-a0e870cbc5a5@axentia.se>
Date:   Sun, 2 Jan 2022 23:38:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: sv-SE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 6/6] mux: Fix struct mux_state kernel-doc comment
Organization: Axentia Technologies AB
In-Reply-To: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0068.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::20) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 005e3cff-a4af-4ffd-2c57-08d9ce40a9b0
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2920:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0202MB29208F112F2FD116392C45F6BC489@DB6PR0202MB2920.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eiILTjiOmbAPJ0X/xewaBynNt8PmCzZ3FHJVBMW0/kfUJPSMmjttf9KK3DH1yB0XWzwXzVd7wsZBkoFmFeizb4N/dXY1ILrzr2gnVG02C/l9mN3sfw3FonxlCXOmKtfVtzVcUq0DwJct+vbYC+V9YFwy4pRPGeRcV94y1XR2x/NOvnfEqdD9Jtdbr4qmvKLwRQ2vOHf7lq3PiRnAbMSMVhFC1mRJOOvm50Th6GETEZ2hkDd4aVqHm3dmYEthE4bEfkYuZ8MP/pMcnBT9LOGHE3YXve66WlFagHwnh6l7SND36tBiKOX72ANGYujov66mz2PYvjwHATWg1neUaaO8c4ae3NaJRfTAi2ubEaqyQs+sNkFl2MwMSfv2YrNX9j9UT7DDwHXSBBn8uZtnZv/TusBD21FPJSacCW5oJaFK2ObLqaDW61DN1XfUETpxHRxaTn2V5pZowps+z9h7ja1GOvxEUh0kuXKgG3zcsgRfbCmoGzQCGBJcCu70eENAO3qBG8g0jM2qqU88x6zhWNP8rI9iRT0wF47CiqZaDQsmuD/F5KQG5O7kgFLiGBU7gk19zli9z/LAm6jBmM0yIz354B0NUBH5zeuTV87RWd3ZeyM0x6kGNENn1tJuYHlG7xOZ6vG7gqPwCU3+SaMGV1d08TNxNKKFmxjWYkp86JSkR6GVBbIXN9jccnNA/2Lo76NvKlYYTwAcjWY0O1L6aw6akhbqD5Sv/sQKmCwwzhGVP34=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39830400003)(136003)(376002)(396003)(38100700002)(508600001)(4326008)(36916002)(31696002)(54906003)(2906002)(83380400001)(2616005)(66946007)(316002)(5660300002)(8676002)(66476007)(66556008)(4744005)(6916009)(6666004)(86362001)(36756003)(6506007)(26005)(6486002)(8936002)(31686004)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODl3QXpaL0NrNGwvS3pTTnRJRlJrYnVMblNpR3VLcFREZXh4bG91dDkwU0M5?=
 =?utf-8?B?OXl0N1d4OUNNdXh4T3p0dnFyV2ZDUkFoS2pONGFBSWViRm9vNEQwRUdoT2tp?=
 =?utf-8?B?a1BSSzRBNUxZMnpnaytFcDZIUUtIcHFXeVZRQkNoM3dHTGpjM3pDVk9nYWNM?=
 =?utf-8?B?N1k4S3I5ZlllbXc1eVZrVjlvMkxUdXl5cGxDckxzTjd1V2Nwck5hL2VIa2lp?=
 =?utf-8?B?VmF4ZHhiVVlVdDJ5VzF2bHlXeEJySDFVdG0zdG53bTBEcU9oWG9pVnFwTklp?=
 =?utf-8?B?M0MrNVpDQkNhb0c3M1orK3IrQ25kSzZlVzE2d0xRSWh0aGJJY1l6b3dIMDd5?=
 =?utf-8?B?KytXVVhVcHp0Y3VsSDRvNFVlMUVodkprMDhQZUhVMTV4bERnaHVZbTNwdE9W?=
 =?utf-8?B?Mmp4Z25NOVFVZXdpWW9vQTJ1THJrVnhjcVJvTGJIYWpJVG84dEJsb3lIU0xT?=
 =?utf-8?B?TldtaWlHeTBSaWVIeGZEdGFTNDJQUXp5RHU4S2xjNDZ1RFRmSkwzWTRxQ1JO?=
 =?utf-8?B?Zk1LN1dnRkd0RjlDWTVtdU5IQW5UNk1va3h2RHdkOTZFVWdLM1l3VnJUdm9q?=
 =?utf-8?B?M3Y4QXZsUzhHemRoV3FtaEpxaE1Fc3BkYWVwUGYzVEgwZkx6UGZmclUxZEFI?=
 =?utf-8?B?ZWJkL0cxbXQwTUp3Z21WNk82cmVlMlNwUFN3a3VmSzNGeWY0Z3FEUDB3SHBy?=
 =?utf-8?B?aGRldUs1Z0tJSHdmRzNLc0tjWTduckF3eVFlYVlPL0RxSk45cTNhemtYMDRu?=
 =?utf-8?B?LzJZWGlvYlFJWjh0Z1A3K1NTbGU2WVRwZEZOZmNYN0hjNDNaNzN6TEIvSS9P?=
 =?utf-8?B?VDZvYXJNSUdxVWhrYVBBaENNd1F3bTNyNVh4bWJDczRiSUdSckZabDFBZXZs?=
 =?utf-8?B?bE9TWFEzUGZ2Z3NJUWdWQ2wyME93ckhua3pwdEJycUZadGVVRGM2SFNGZlBj?=
 =?utf-8?B?SGFmdFBEQWtmT25YM1JPeHM4dElNdExxdlBORDgvYk1pb0swNXVVQWM2QVJI?=
 =?utf-8?B?cHlDanZRdURKeUFhQ3JxRHZ5bWxlaTROelBSWU9OVTJnS2x1ekFqL2NyOEoz?=
 =?utf-8?B?ZjIxSmlraHRCR1RXdld4OTh4ZldjUElEQWxZM0lOSTJwcDAzWnI1aWJ6WDF5?=
 =?utf-8?B?MFlRZW04bTdpSWlqTWNSajBPci9Kd09PcXhUM1ArU29Objd0MXkvMzVUK0JB?=
 =?utf-8?B?MHdpMG9tczhlNWt6SDByQkhGWFJDeWRreC9qQW5vdEM0azdGQVhZdk1yZDJh?=
 =?utf-8?B?N3BUZVJuQ0dyTEYwTUxpMmwxdG44MFpyUXNCMW1iQ2d1U2tyVWJSbmlSakFP?=
 =?utf-8?B?QVp6WjRnemVqdzFuY1NIa3V6UHpzbWRjdkJzbHdQRHNRRy9jeUdwOW5hL3pm?=
 =?utf-8?B?U3pJT3FjRXdhc2dXQ2pxblZGR0g5WHRoK0IxYVRRNTJkNUtUcEcxM2t1ZUVM?=
 =?utf-8?B?V2tIVTFJQlpmR1g2Ym5zeUFGL1lMSU9zOERaMFRYTmt2RzI0VlNBZkZacU1Q?=
 =?utf-8?B?UnI1TVJiWGhzTTZDUXZsSkRrNlBLMlNPZTFnZkZ3OG5PQTdVMXo3OTNRWEVV?=
 =?utf-8?B?dVZoTTkrM1c1bEpPelNMSktIeGNQRElsdElJYncwaTk2clVmUUxUVmZJcGIx?=
 =?utf-8?B?OE95SDZOdnRBNEpJRHBldmhraDQ5c2h1cUd2Z0piaXFsVzFEdFNFb2t3RFQr?=
 =?utf-8?B?bnJRY0NJMXpZcU00MWVTNk5ZYTBNZ2pzaFFqTW9zRFZtQ2tLYk1kc3JkcVhR?=
 =?utf-8?B?TW1FcjR0dzhtR3BvazBvb1Z5azhxWS9iVi9BNVZYT3VUeHpNWldvbzhDWDhF?=
 =?utf-8?B?TURrS2d4NmI5YmREQTVRQVVpK0ltdUhCVmtFWnhQRWw4WitZTXlHZzNjNHhQ?=
 =?utf-8?B?Qk14bU4rU1M4MkR1WjRHUDhHREU1Tm5MaG03RHZxc2FPL1F1Zlprb3MwMDYy?=
 =?utf-8?B?bXlFSlZldE5wMXNXWVJoWDVvVThDN2dNN2lMaWMrendDQTFSL21kUitBTCtM?=
 =?utf-8?B?eHloZjZRajFtT3F3bEJWSEl3ckJGM0xhZnVCWFV0aFZpL1JQOUJqSnllRCtI?=
 =?utf-8?B?SzVocjB2STNvdGQ4enlJVGhBSERVTllNYkZoVUQ5R3VnMmdCZTJKZFJhUTcw?=
 =?utf-8?Q?AkhY=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 005e3cff-a4af-4ffd-2c57-08d9ce40a9b0
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2022 22:38:57.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoO3LGzXlL0Evxs2S3AO+OiGrHhAknj+aECl9cFNNYIut606OyfzwFueTLfs4Zth
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2920
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Li <yang.lee@linux.alibaba.com>

A warning is reported because a colon was dropped, it is found by running
scripts/kernel-doc, which is caused by using 'make W=1'.
drivers/mux/core.c:44: warning: Function parameter or member 'state' not
described in 'mux_state'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index fc339b0064e9..11a5c488c812 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -33,7 +33,7 @@
  * struct mux_state -	Represents a mux controller state specific to a given
  *			consumer.
  * @mux:		Pointer to a mux controller.
- * @state		State of the mux to be selected.
+ * @state:		State of the mux to be selected.
  *
  * This structure is specific to the consumer that acquires it and has
  * information specific to that consumer.
-- 
2.20.1


