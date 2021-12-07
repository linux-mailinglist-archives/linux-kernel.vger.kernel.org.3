Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CA346BD05
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhLGN7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:59:18 -0500
Received: from mail-eopbgr1300100.outbound.protection.outlook.com ([40.107.130.100]:53120
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231280AbhLGN7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:59:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbC+E+mEnV3QyGbcm6KP9tI0+vu3bUBtjUCwx6UWaEWy2J/6gCZ9e2AXIQ5Px4snFnSX5AcXIYrzGXw48kK3UcFFhdsKnOtIxm+cPgUoPQa6FcucHAwol7h60juelIEOd2PEAxEhoSYWvk6J1FRwaJMlJSZcKLll4GJTwxQ90kCzkcqxd7jz/lpdtFiT+1cFQTdc52WGFT49YkSE0qT+8mlWhXhpmIpxCyrPBtL0FUk4iJdPDOstTajBcqUkTTh40w7UKQpgn8yeS+Jij8xqsyGcJIoStu/hofHQUlvW0e3G/6j590O71gwtY+drQ+YCE/I5d0YG25AbtoRf6Co5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HM8HkYBFaNl7/8fCZYsEiHjiD4KOCDXR/r5GJWB+FnQ=;
 b=OPdDpILiE2SEMzI+VN9KN1lHZvA3D8W3V9J1jdxgsIyUPsc401trqy3AjUEtgpkvXom5wMZ+AxNwSvDamKgMQHpid/Qr4muJjXFLuvEDN18EfaQlhZwLev3uXEeBAH3Lu6OT/B+7CS60hfjfJypBSbZwecDbRwFK/BWXAjEApwoj2u8TXUu7IlQFcER6CS+GGiAClHO4IXxJXC21Cdd3RinCYuqbs/fwp0qgByyVMKOz8atJUK9G/uHZ3oRFG+KGtkfb5QKo7HWtw5qu78RAyIbu70OUelT6+umGL2WJJniVh8oQ8I1wCqOlIIvhCJt8cGq6CMcBiikFD1Ob4QjnHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM8HkYBFaNl7/8fCZYsEiHjiD4KOCDXR/r5GJWB+FnQ=;
 b=a2srlHxYuRpQDmj+rKT45Wjz8tqOdjzBFBw0IlHdTnp7M0fTUY1eggg+rN/Fmy6uk8tvRHC/01XPux8QR5PZ/2378VEetp2+L3XIHrNdPyBgGnqg/rha7TYWlqC4cxSP2xx3jsc3WBPEC2L5CPiIiiDnCSZVRqufQFzEl1R7CRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK2PR0601MB2036.apcprd06.prod.outlook.com (2603:1096:202:3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 13:55:43 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61%3]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 13:55:42 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Li Jun <jun.li@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Chen <peter.chen@nxp.com>,
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     kernel@vivo.com
Subject: [PATCH] usb: core: hcd: fix bug: application of sizeof to pointer
Date:   Tue,  7 Dec 2021 21:53:47 +0800
Message-Id: <20211207135401.5507-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:202:2e::15) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from guozhengkui.debian (203.90.234.87) by HK2PR06CA0003.apcprd06.prod.outlook.com (2603:1096:202:2e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend Transport; Tue, 7 Dec 2021 13:55:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90143b4c-3c67-48c3-c88f-08d9b9894274
X-MS-TrafficTypeDiagnostic: HK2PR0601MB2036:EE_
X-Microsoft-Antispam-PRVS: <HK2PR0601MB20361A360924398C727D5D8EC76E9@HK2PR0601MB2036.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /g8JBHkxa2Z6M+7COSv/yOh9gI6RI7bu3LCpby6SIplS6wDL7VW18DzWlYUYxzKmcuwJ44qx9qDYPPBxj1vptZvgkqg+2UgbN/MPaidU9czcjF6hi+g1ysKqw88n7eq1QmFDL8GUgaRvFZMqGetcMkKSwhkwel4VDy2vkGbSiK6w3TIhcMKzKiYgnPB0kxezj+dVXpjAP4nZ8ec3ZYPSDdmQO23u7ZimMgi9XjPkCaklsxQmr1ym82ZTQ+o5Kps4YYM4gHQZwoRdwdDvtSIHk9Z4fqB+XA8Nun/iD+WvjFj9n8WRTbG7EoySbi06TooXnTEUhnPnUUv9TNh3cExsfNVC7c9BlnwDqcbl35hedTW8BewKEE0k/l9K66Bh5MjZvqlw9uq0o2huC7Qng33ueXymDoZ2yBhb7tUMZyDcm5aTe0XWH3yXv/+sAo1/sM1cwSzI10c8n2oTkxrgvfbPJk6cJCPZEJo6PyU5X9CClUZQObrprKhi89a2wsiFacowM/JvSbFg1Nlz/ruYO42yG5SQ7kjm7BAU+3RxYbEsm1b32IB2zzY0/SIlF0moJR3m4EkdJhBgj30PNYZhS0QqJx0KXP0me2np7toRbdXNS3iUA1VXosIwOMrJ4ygOmj0HhnUGTtPdA/9IuDHdANa7GKOcw+/5cFu5STxpGOUovj19TOobMtl9tVPCHO5CHQoF1GWGy6jAPIVcASIpxHBdVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(8676002)(8936002)(5660300002)(956004)(2616005)(86362001)(6486002)(508600001)(66476007)(66556008)(36756003)(66946007)(4326008)(316002)(6512007)(38350700002)(52116002)(38100700002)(107886003)(4744005)(186003)(83380400001)(1076003)(6506007)(110136005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ib7tHB31ISnk09ItDGX6AuFqPtwqRH+v4/fZm332fz2GgDqDnb2Og1h8oQKS?=
 =?us-ascii?Q?B7XNm9Kj84ZzZ9rTgZuHIkcTGn4ALbpBDARSGeKrTM5+tUewhI/FInx2gJiR?=
 =?us-ascii?Q?v2ZOXP4I9GXYQVpLxjOzVs3Z59GelXncEBA8HvJFbk5YPYAOPEhSPJnIHCjl?=
 =?us-ascii?Q?YR+6nIZDtQsvrS+rSecX1WS8A0AuLM6Ipuv19Nn090Lv/FafAuHEDZPp4OEN?=
 =?us-ascii?Q?TOso5oq1zvWQ7SipHWgoCuyToXejwvgrKFRvYeYjC4mmthn2SQjNInFbgv1I?=
 =?us-ascii?Q?vo/68s/JDV791UtHUmDw1rQcOlkt3jmhZEdrrb0o+F5scOgzUVA4Z96e+txC?=
 =?us-ascii?Q?/d+OYZ0Fu81yCYX71VWwgwp4bEqtohiLJy1nBuHLancRFvhK9uVnC9pD5lJc?=
 =?us-ascii?Q?qK7QUr/GgLau4j3WmPVDeU+KovyovSzesskIpA7eUfu3YcmP6rdntG4STOCs?=
 =?us-ascii?Q?E+1Mx8NGDKYq6bgh4Pv8pugNDv5tTZDmHrjxsOVdwzLL/aXe4PuYbY4wf+Zg?=
 =?us-ascii?Q?no2t3eLdSZHzC6xBDhs4/1s8gouRRDTiWRji2RzBtjOkREkuiFnS6xjuozH3?=
 =?us-ascii?Q?pyf+OaYXfns2nIIzj0fEFckhdCrBAT0EK9bA1zby60XyFtxS8WFdtrm/+xg9?=
 =?us-ascii?Q?vmsnLtd54OFB8z+ABdR5lekLCuq18jxj2g/RF6JM+yyAFcCqNXLggwsSCcJQ?=
 =?us-ascii?Q?VhlJ4gtM4FcbIKMFqaYjYUUJIZqNG2VsNtG44ahVsjP7c8pbgTJQGJv8534b?=
 =?us-ascii?Q?pzP8W5ert/iJSn0jbU5FwVQD8393lRmDnxh9e0/ySG2wufwsfpwUMS5zUbGV?=
 =?us-ascii?Q?EnzgxB0TipPIHNU+thn5y7p8gEDAZUBxWdspI8NwEpL7ULXnsyFODmCThjyi?=
 =?us-ascii?Q?yHXouBrnrzMaHxQZW4ARQGp/LjpthowIxynWRLbzeA7sqn3MR19SHpKnhb+I?=
 =?us-ascii?Q?EX2zMofVwAusvFADIUiaxS0RnCFtKMf5o0ghybfGN3BLATjKJT9YQGsJKAtk?=
 =?us-ascii?Q?8Q64JJethxnHSmlVHX4GqmM2YhRbCYd63SS0jwuEKrxIsz1pJioGX/Fy2Kzk?=
 =?us-ascii?Q?QG7EXXSwqp9aiPa+r4ZqEN42e6UwgaFO4v5rNLxdvAvNTOgDzdVD/wVzAJ5W?=
 =?us-ascii?Q?xaWF2MGYVdU9VHt4kTHkGBa+XhKRqU9kigEu1HCi2tk3ck2oKNpt7q9VRIWU?=
 =?us-ascii?Q?aHkEDIrGA3M9x0CexGxYH1Hx3sUsjjMIDjrkmmLSkd1qtKrqZ1POZfyHmVtz?=
 =?us-ascii?Q?GpzbE1/p0wZBbg6sys1y1hwYNwlE4tkMAhwQSDqPi83cOg+Ds2Lmjhj55+Th?=
 =?us-ascii?Q?pfIPA6wToDGdWST7DfHKtY4ZCquIw51FNZEn9uWI+UZExDmAqWF/iidI5lv8?=
 =?us-ascii?Q?iIBHmWXesFNZNRcEJcHn15fol65e0zuYQ2/zEADmkfoEwY86YZ/1INomYfiN?=
 =?us-ascii?Q?Zuv100mfD0GNen/XdoINbyM5dIlNzNPI40Hw87U6l3/AaUqVbZqNBcDB+wRm?=
 =?us-ascii?Q?o1gN3tifWfMchKkq4USDVIgkBC8lOY0jaw41c+b8nPjNgoYMTykUEVTUnvTD?=
 =?us-ascii?Q?7fdidBXEJW0gftyHIYa/jJwo+SkpIRkQlKbfb7UmduntAG6WAxuoPphG/T4k?=
 =?us-ascii?Q?tkwJ2F+uEWJW97EyrZdQXU4=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90143b4c-3c67-48c3-c88f-08d9b9894274
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 13:55:42.8274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRbXC3t5z/itK+4XaA2iyYbMwll0QqOIEaP8twN+VHrlMAy0IzB/A8Pn7OUOUCg/WHvf9/LUhDWXiiKkW9lxBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB2036
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following error:
./drivers/usb/core/hcd.c:1284:38-44: ERROR:
application of sizeof to pointer.

Use sizeof(*vaddr) instead.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/usb/core/hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 4d326ee12c36..996d5273cf60 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1281,7 +1281,7 @@ static int hcd_alloc_coherent(struct usb_bus *bus,
 		return -EFAULT;
 	}
 
-	vaddr = hcd_buffer_alloc(bus, size + sizeof(vaddr),
+	vaddr = hcd_buffer_alloc(bus, size + sizeof(*vaddr),
 				 mem_flags, dma_handle);
 	if (!vaddr)
 		return -ENOMEM;
-- 
2.20.1

