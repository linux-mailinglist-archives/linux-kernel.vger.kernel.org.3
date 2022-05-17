Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E18B529985
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239400AbiEQGZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiEQGZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:25:51 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76CBEE29
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYNEIuC5HT5nmTn2x/Ows/oPGGpk3CQXaAoUiWdZhvPJPYS0RCYBsxRr//3ndXANI9e2Ra/hS3n0v8i4L5+Lf+MSGl39JpGtXf9nF35aKtoJaeI9Pk7OyXQju5DaTJnH7qIbaFCseLK0/etHnlTTkP45KTAgNjiMUshaEXTg2ZtEY/8U2pykbAQDer6OTUzoE32N8B5UxWCpf2peEnwSMPEAIX4UDAECwAX4qXqd0xpulVtrAz9oDCjQVjwJ2DJX5p+TwIvd+dpiz2uevABjbR5WAonjOiPN3rs3tI88NLxUZfmcxCSo28he5U082GBbrAfX39K1HkSPA7JVdomjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6h4OGgH5AArgm4dBZY9qJK2CYUQSP/+/rriK+B3Bqw=;
 b=J1ytwN3L01L//y33wWpheakF3pw/VWitOTpjLEEE2R7tN0jAoXQAVit+UxA5905bM5ietFqLegD2DG50VypVuhpyuiXwpm5witRddihhL01o+MWcInMBcjO4UtYPi1a9YhjoK6jXiSJ+TJYGsn1WV05IoGrkUjkEoZKRj6GCJts1d8SZIiq5yITQHdUoltOycXEzG5PdOHHYnnRL4orOLo+iPb5rPUxXiJ2X4uX2/TNaWB40o/KDurYQMtLaW1rsE7qXPb1fF7Q5+VG967YsyvmRkny6r6H7Xu1odQkK0FzcecOKj0pbJpf50PYFfA2fHUaZiu7TkrPEkHOVkakq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6h4OGgH5AArgm4dBZY9qJK2CYUQSP/+/rriK+B3Bqw=;
 b=RblpqCAFp2RdemOrZGJQkwvdJpggEsb/0EFJh+pnU7p8NCI0FCzef/Z/9KDatTvUDaTKijKp2l0PMzA5viidaMihWGUx7o3hlBjGMiLW3y3iMR9K43oROi9byGVLhELMQVX7jNOuZKL88ODPCr0otQMA5CEAwJ9ExwylhDjUDQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by PSAPR06MB4501.apcprd06.prod.outlook.com (2603:1096:301:89::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 06:25:46 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 06:25:46 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com
Subject: [PATCH] ALSA: seq: replace ternary operator with max()
Date:   Tue, 17 May 2022 14:25:17 +0800
Message-Id: <20220517062518.123292-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0154.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::22) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d31a701-1598-4a07-366e-08da37ce1364
X-MS-TrafficTypeDiagnostic: PSAPR06MB4501:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB450148464D54673389944C79C7CE9@PSAPR06MB4501.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6xrbsLPsSe00Don+dao+Xoo4eoiAVnS5bBzgwR1tD/ZiTb1k3TY0DZ2qN8oAm4xHihibq1OEDoCJ0H7gbHiXAaTYxXelVPglhKdjE/6SfTLL1kjkwaBFtAXLkovw4n/v3L3BmW/dzHYy2uFxAi/AxkQSWhtzKIMKswXMltjzcHRLKPUaTs99KsFoQrGitpYH658m1IRq+/kDgOIG2iEZF/7tVac7SiqENqFCV5aXuP2LsXmVWbrHWcminZYqOCuAWab7FvoN9c2DivPWXnQ9susFV1ALHPSsM0zcOdKpKaIvCX9Rr065ZctaJ2bqGQUYEiMcJa2vUQiLhA0440VzCjG+DEjNFfukKep0IP6yqbzLB8WFDXe8+Be8EJ7QR1VT32gaNFXuchapQXt5Wp1W8rlLMM1KINyFFEPOr0EXeelKsM9qyZzWOuvjqgDgM4eyJEim6oewJ7lYHUaLOp2O4TBh3ly70K5nVoWWSNOmVv/fSmurfTw5oDq7PnhmD7PLHB0lmj2uR8ebTmm3eTiGxQW9axW2YikUd0IjfW3zLUtMUCJ4k+l6mZoReXoHNQ6DrS9MZujnkQfoeBtoQCIV3uZre/cHfRsxUUmAFnPWwc7HeS6F9aJDteQHNrWXx34DKgvet4g9i4ZQRMJ7YoDLvgPTn1la7sbaWMr9uW6T87+DCc3ESkY9jLKvxjVJ1xO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(186003)(52116002)(316002)(83380400001)(4744005)(38350700002)(38100700002)(1076003)(5660300002)(6486002)(26005)(8936002)(508600001)(110136005)(4326008)(66946007)(66476007)(66556008)(36756003)(8676002)(2616005)(2906002)(6666004)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zoEfsT0akEULcFGWUeg7Jf6KNAjIIqP2toYD1I3jRipl3r44h0PIZ0vS4He6?=
 =?us-ascii?Q?pjyljEWpVNC4Eou/XMKuGdzxt0z2LmSGkWrYUq6rVX9minKsICqEX1cFebxa?=
 =?us-ascii?Q?IaxJZLaT1h/Ep1lBhZpFF57fTfPw4UFeh3LSUf+Rycr09AZ/bCfdXW89Ktq7?=
 =?us-ascii?Q?hfFPENraMsQDFLfuv06Boby8voZb0xRl8J/XiCPo6zA5RYMWrzQzv5JK9B4C?=
 =?us-ascii?Q?HfMIcUun1IsoNAQ/hEA6sbmOb4CEjXXoy1ulifVV7V74Ra5HsUQfMusFMAKy?=
 =?us-ascii?Q?EIrP3p77FFg/NJZI2s7MqUlDJ/Zd/oB64q9MczGfC0ITX30CQzEayqfrgLzy?=
 =?us-ascii?Q?Z4kVg0JZFxYkP7MaiejDLODDxcPvYQmwkYDI/WHNrK93wROV6qQdKAleBCUO?=
 =?us-ascii?Q?pv3oDoVqujRV583kd74AA0Y2DLRZZ30oP7AnKvk/S5GZGN8v9qVyZrIXSjp0?=
 =?us-ascii?Q?Ch5PNCeAEyWiEgslIcZIx0pDg4hMFVw12yJw7VXBffLB0oEXXPJIwwg8hYFQ?=
 =?us-ascii?Q?rpaIPL1g5fRcbSAIWInZTTdi4SmCsROuENs/mTSebWyuVCYa6RelhMMHL7NL?=
 =?us-ascii?Q?kawNVvcoRLAPXjv+d4LIeWx8An7hB63C3yVwOMUuU5E/XtxIkeLhLQDs3EuM?=
 =?us-ascii?Q?pRH0VzSfJHCS4b04leNL1y7oqmSCc98EGxfERlBK7uwPKbjvz4f+at+ZnYs2?=
 =?us-ascii?Q?fQmkbPyMcWjlBmPu4o8o5s3mMD19CxBxfq4KuaheFcvM9lGOe1MULqx6MIHi?=
 =?us-ascii?Q?DNfuAJ8njyko1+sbJOleZoBscDbGvw2mFlwi1NPh5GHws331rI5P8rsomvM3?=
 =?us-ascii?Q?4Tx6BHhtu1wnfpAueZLy1GYC1TvQJQeCaTfybTAc9GesGRU6gAmLoRQXPyPN?=
 =?us-ascii?Q?+Q6vrTFYNy+X7lHlGUC6D28IqMBRVnsW3qNPlfZu19BH3tYrrR0Lxvwmt34x?=
 =?us-ascii?Q?KP5P4mCxuw/oZYEAXFnRlvK7BU1IA6VCC1QZO/bo2bRAijfzyHZNUMFyCj7L?=
 =?us-ascii?Q?kqPdRHycux7BpsmL9/jUXVIWKvdMJoSvNWIMJ9rewOhQxrxcTj//bextkjPM?=
 =?us-ascii?Q?39xTFTN8qZ7YQyBJLOP2Dd4mtwvxouJg3F6WhVBUAE1H+WX3hoYLWt72JdO1?=
 =?us-ascii?Q?NWnd3MgiGt3WgaN1P/lm4zrCWOBsnV7qv77pOS79hbsICDVdko6DOyy3Tspj?=
 =?us-ascii?Q?aHoauetZu4Vh+fQnbtR5sMU62PiYsJ8hJ0LTDbEmO0jZNAxwdVcsJKQ+eIrK?=
 =?us-ascii?Q?lyfUzFPURaBdj2rNPn4edG0kG0QxIoCxbKO4+lEnSmS7eSuym6L0tWIb9/1D?=
 =?us-ascii?Q?STtAb/KicHu2K7gzvU4p+Y0GCiZwYHhTOCTS4pHna1/4j4lPfLFq9D1v6+i1?=
 =?us-ascii?Q?RgKH9sM5VvgPIV07vSPWNVm9lu9WTWda2sd019Cbq2P+GnDe1RjNaDYRVLjq?=
 =?us-ascii?Q?tJLNWByem/qcNEFlIDV3FvYOs0lJ4NnrDJ4oaF2WrKZh/UKS048pWXjOmQFO?=
 =?us-ascii?Q?3UKjHA2I8AufyRUF+P8qK0EazOYhpkkWO15IEI5+Mtcb7mkG4m90PtmeMNro?=
 =?us-ascii?Q?YeN3gurxGFd9uPZ12anVTIw5HNi1lRehidKtPyyrgrpqvK13LtnmiiiGODRV?=
 =?us-ascii?Q?cZ4nHUq6vLYosDZqKUOnhBoAptiswFCXN0Uy0iiggCDzAtT2oKY7xr0HB6+0?=
 =?us-ascii?Q?95PDkQkUmjspUgrnHHJUnJQaiveiJtWyh71AdM00OW3hvOc9U3OR7Fh1uPfS?=
 =?us-ascii?Q?3MWrNPK12g=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d31a701-1598-4a07-366e-08da37ce1364
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 06:25:45.8221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fM68BPCiK72twMlzpXmBTvCmba4gPv41tZ4tjI9jbqp8mbTOS17Pl8+xAiI8k59kzqZ4EpSNQQwhsTVXv7W2eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4501
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

sound/core/seq/seq_ports.c:142:12-14: WARNING opportunity for max()

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 sound/core/seq/seq_ports.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
index 84d78630463e..25fcf5a2c71c 100644
--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -139,7 +139,7 @@ struct snd_seq_client_port *snd_seq_create_port(struct snd_seq_client *client,
 	port_subs_info_init(&new_port->c_dest);
 	snd_use_lock_use(&new_port->use_lock);
 
-	num = port >= 0 ? port : 0;
+	num = max(port, 0);
 	mutex_lock(&client->ports_mutex);
 	write_lock_irq(&client->ports_lock);
 	list_for_each_entry(p, &client->ports_list_head, list) {
-- 
2.20.1

