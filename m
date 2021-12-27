Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C7D47FAD0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 08:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhL0Htp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 02:49:45 -0500
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:15936
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235561AbhL0Htj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 02:49:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QebsHTzFWP8hv5oOQcJ/AmTxW5skCvsVVMOho6BKKtiP5u5y/OTePg6JjmBYW+x1DU+P4qxORMlV8vw28Uz/VCCVf/Fnq63eoJV6KFnO3/OE2DEEMCT9RmYFjnLsYkkIUc0raEdqS+Vth+4CKJ5xfdjTkcAP8Gfp94DDVh7e5E2aHMA4YvYXQEiTfO+ma8cx9hMEoMlAXVbtrsCPJAlwo3D2ChMLEClU/qkPcjam+4ZVBT3OflCwRGhLaP0CEjK7EZ528jOQYQy0cKmSueMpe+awJEl5rWVnzIPoG2h5E0N1lNJrrBpd+QgWQyDNDCXXFWluMVPvvMUX2OPbz6dJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1jezXools/y/l/bcphAuJgmvbXwOynT63sfojpuGy0=;
 b=gPK/RZBimXxElzPAtVbobBMhBw63OtHsYU5pXxtdwpnlUcuxa6NE2C/pQvKbHfpLLZkDLZ/aV+t+xrg57Z8K03x8hSiq6ea0sJzjt+yEpxnGK5rUCn3wpkIP5wrCRxkh3LJkrMAQ0Bx1gk8pQ1EwdJfxvMI5/6obsXSTqX242K+8n33yAAUxGjr8z//FVhn8xXznJrYSzrfbVtLRvrittj1xKueROf6d4WiwyrWUl3UTe7QrNczmQl9wPm+qzm3kTMWBF163NZgTjNw2ed8noMtdJZoQKZu2lKnlQ4wq+ncx1/VG9+of6ds954g56hQ3D5DL6OdI3rXFbuJ0iKW3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1jezXools/y/l/bcphAuJgmvbXwOynT63sfojpuGy0=;
 b=dUui1vQT25hNDPeC4xnzu+O20wUIt6tsnggz/WwsqRhV1jxoyfzN85mSg1kPvfPGar2EfRXSeYnvWIs7ou3uzUewaRzEd+A4uOJfGYHvMF9d5os1hSAmZtCzFoJEpj6eZtXif/bJ36cpDScX31Oyst2i/4lUQ50A24Ix3d2kcSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5631.eurprd04.prod.outlook.com (2603:10a6:803:dd::27)
 by VI1PR04MB5629.eurprd04.prod.outlook.com (2603:10a6:803:de::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Mon, 27 Dec
 2021 07:49:33 +0000
Received: from VI1PR04MB5631.eurprd04.prod.outlook.com
 ([fe80::90fe:b60a:94b5:c748]) by VI1PR04MB5631.eurprd04.prod.outlook.com
 ([fe80::90fe:b60a:94b5:c748%5]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 07:49:33 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 7/8] i3c: master: svc: add the missing module device table
Date:   Mon, 27 Dec 2021 15:45:28 +0800
Message-Id: <20211227074529.1660398-8-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
References: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To VI1PR04MB5631.eurprd04.prod.outlook.com
 (2603:10a6:803:dd::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2562f110-d166-438c-350b-08d9c90d6ba6
X-MS-TrafficTypeDiagnostic: VI1PR04MB5629:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5629B4A204AD127C4797F7BAF3429@VI1PR04MB5629.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Efr5EoxNqmdOOudZLsb7NMbbzYi6QmkTh7Fv5XefSBVCvtmJgvVO8xE0ta+udqoXyBwRXeWJkRj/c69WFUlG7gjPtDw5JPY3juQs/eik6aFPSiJ8ImP9VZd9KJ4k31XUTiySoQMHypEFLrKA/S8JMXuOcd6wwBxkSZc3HRZQDXglTfv4JVEU9AZSIlOs8VpqlcxH8qhdh/4Bzfd6vxXKEAcCPQchCQIIQfJ8snGfnXjGuAlNS7K/Z9E0CDF7c4wy8b+lzUexYVigR1K/cahMJlp1rNVxpBeXitPDkwKLl9ugj43WzPw1WENUPeyp86PFihAfed1Q7+bQ8sbJCBmHWHwTomCqrrEJpoFLiD/SXyQqaXPhNydIXYiPzh6zb63XpveJ02B3U0MVHGBArsyto6Ko6p9zNO25h/JAo1FgvVIjWEW+Pg0TTd0zvl8qeNI2TqU4TYcHYfXltrUyLBvFGkl3a3PFp8OJH6zEq9WKOf0gVEG1rAfbezH41N7MniONWbm6N7GoRNrhSncPFAKTjByJTjv6u+JVftzFfcDIPGTbqxCxMTGfs5PcZiQNehEhWBpB7Ll8kCll/Wq51nFa0JIZe+943l70ZXFDS85pKqBdGkddLUTI2YU8R/3sd/tQgz4SQwsfXUiHcZf8YiVjcMWJAvZ0A9RdhfZ04yz30JvOrG/b1Evtl4W5uUmtt79BIHIunVKY4kGWYzxr5JNiog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5631.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(26005)(2906002)(6916009)(86362001)(36756003)(66556008)(6486002)(66476007)(66946007)(8936002)(52116002)(4326008)(38350700002)(38100700002)(2616005)(186003)(508600001)(4744005)(6666004)(8676002)(6512007)(1076003)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aUPvWIYZBKerfbNNCVQrTjxvW5tFW/lHnDWqbrHfrZBPP/yOK46tXLhhyUm/?=
 =?us-ascii?Q?3RY7auzpbPDYbXNelRiyyQ1NhaCbuC6fu1NEoar5O4I0JeLaEF0PRWV7qoUU?=
 =?us-ascii?Q?ZtT8+OWGmyMKdSe5Y8F8izdpTT4w6fDDth/pOZwGKEKCL8U0ABtVN6C1NerM?=
 =?us-ascii?Q?E3gcpl04m1zFs9o2NBgd7UBQtmrGd8hGJ8nPa5owZWrdkFC8ahZAV2dAUgJv?=
 =?us-ascii?Q?a4EmcG3Z+mWMx2IOgKV975yDy7BSASZuG1A6sKYIcIWCrzKQT6023ZuVllB0?=
 =?us-ascii?Q?aynQzgDi+dJKEqPZ5m9oEk1+JwU25Kxuo1LkAYxmbf8p7e2M0mTCcL6E7rx9?=
 =?us-ascii?Q?s8Q3PmptD+Wl7+t45BOOCHiTVmy+XvdUkRhQE7ntig3FpVxIPbzSG+Wc8b4H?=
 =?us-ascii?Q?jzh/N+/k9KVvn5GGRt14eDw4KWqCz6Abjsz9uE93Y3qpBZc67X+SJ22VrsJx?=
 =?us-ascii?Q?/F0DVzPE9KjqujudBNEXsCCHSEqAXrvRB8FlUZxAdghuPD0tFhGl+4nWE3sg?=
 =?us-ascii?Q?p2K8OemQa3kusj4zS1PsJG5KdvTWl6pjrRWXMij3zY9Lm6gsc/eZT3PjGvs8?=
 =?us-ascii?Q?4yRucd4AVwtJLa15O9bc79gMVJgGZnSzaums3cspHK548ohaNUjkVH4IATq5?=
 =?us-ascii?Q?cvccUzWY0jap53uYPuqhpUTIDAJSez5wXYiNkjsfACh46PXoajEEuf8E5+mw?=
 =?us-ascii?Q?UbstdbuqFYZLM0ztZH/GOOMdMF1BLQU4azrYf/lUW34GU+ezhMpbi1CTDn6a?=
 =?us-ascii?Q?1uWVZpJrJHPpWbwCm6cLL9YF5m66gllhD6p1F6+iHpJkSzl2JZfXxbtqQTIw?=
 =?us-ascii?Q?Bwn9LDr0B0IPaGS8Jgy5BX6Rv3JIo7XQj9ib95cHK/QJvjvrkcw4eurllXSe?=
 =?us-ascii?Q?1PH8t7Ky2QcnK+tvvm//fXbfqjf63ZPTLGAyr2l/c/8hQZpNsiK1wuGRLEYu?=
 =?us-ascii?Q?ctbj+XRhkBX/BY5km3UvzSrvdTGeYDeEjY3utACK17qW6yNEdz8qD08hNqCv?=
 =?us-ascii?Q?kKIEL42JPtrtwe05WCuZU/z9qgHhwxXg5/jHBWkVBDbuqFq5lTSaQrXah7Kw?=
 =?us-ascii?Q?2kNwfMkm62eO2X8QCk36p4auJ6vmkXxK3eMZbMqeXhV9SsSXFF2KvC5cQnap?=
 =?us-ascii?Q?VlXeAQyRhGo7jz6qP+FH+E0f5nCo2clnsTW8EmQ9l04Rk6Qs11NMHkjury5P?=
 =?us-ascii?Q?0aOHpwXXIBW1NF1+O8ry+gbiJQfx/BP7rRdrLd9YIdRd+kL8zfKkNytSdWXp?=
 =?us-ascii?Q?BiuxoRZ0J1wPA9MbzfADSWoJ+7C7T6Ei4N2f+CSXjs7ysJxlZHWlZTrR5xuw?=
 =?us-ascii?Q?tI1eZ6ieXOeneVC8ir+AJbqkfqal/Y/u9ZsSQ4vswV58ElpWIKum/Y46Gxhd?=
 =?us-ascii?Q?9ujHExpW8cXTX6art49HzdJ2lgXvzsiAknl2eyC0H7vJ6mZDsOO7a2YCEYb8?=
 =?us-ascii?Q?qbNS89Hx8B3hrsVL5XBd0tuwf2XDfo0bTgFbGbhjD4WsC/dhYADqNg7z+JEt?=
 =?us-ascii?Q?kSbskKV2MyyiajK55AuilFc7zJJquXmUUfHXTdytQA+RKFtZKybJV5z7iNn8?=
 =?us-ascii?Q?3kS7B5wyZEJKfHKlTfA3bpBi3B1nAMIewAXWO4mIA87mlNk/+eKA9Tf0owht?=
 =?us-ascii?Q?oYko/wx+M+1aCP6IsfIdnS4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2562f110-d166-438c-350b-08d9c90d6ba6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5631.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 07:49:33.0886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRnJzSOWuCbmgDMLTiZUE+Y5VIuXSn3TO3InwvMRiwfydynzH/VCJQKQkn2CTHu3kvaHXfVSHR/BIL5ZOyuBRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5629
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The missing MODULE_DEVICE_TABLE() will cause the svc-i3c-master cannot
be auto probed when it is built in moudle.
So add it.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
---
V5:
 - add Miquel's reviewed tag
---
 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 884f5349fb76..3bc81ef95334 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1614,6 +1614,7 @@ static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
 	{ .compatible = "silvaco,i3c-master" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
 
 static struct platform_driver svc_i3c_master = {
 	.probe = svc_i3c_master_probe,
-- 
2.25.1

