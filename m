Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038FC4D2734
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiCICJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiCICJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:09:25 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2096.outbound.protection.outlook.com [40.107.243.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94010C3305;
        Tue,  8 Mar 2022 18:08:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilb3yPaEy6chdDrqJJPkqEFpP5jX8YTw7N3cNuuuZ8g+b8cykE1X6gYBHxsuRkuRMH1EWnTzBlI9ZmlQkYhP/947v1qaq4j9s0RHNQUeF1XAUUx2vXTZC2srZ02iTCZKipC/EK1NqFnWn8S2HFgSkUwd4Q08Hg9mASB3RRC16RxSi/22+ZM/AP8CibiPJoLIYU7SfUBxIUnYbjAqzsccqu6TXD9QLIndNgmxpUrs8Z3vu95FrSkPIq85v1LYpUwMge1ddQz5ioPKsZ9inBboP+Lx2ogGP7vJBG7Tz6GvN89fLI/GOERPflcsWdYJNBKOY6HtMt/kk1EoeUu8ItU2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/pNR25m76J3ou5e/I866l8x3mpHuJyr6k15clz2jZE=;
 b=mzo/afNq0DXN39vGdR0Cl7fTZuaW8aZWL3xzm3Ep7jouiGjwH2XiS81526ITE32qW5GziBU0eVX9IrvDnSs8Nr2E0+UTyJjlxmuisxGHmXCzwP7K3lCfc4UZCUEvi8nM7xV5mMf4bKCSW4Xe5Q7Wg80Odk0wireNhlvtfVVUmxOIXAH0ZxAu6eK2V77NnLkibXNGLC8U3y1PZAoGou/ubrQi3jPVpnwildblmGXtdEaUgaQw+pU5XDDY55JKFFiQJbRiKzxIDP1HTleBqMy5LnWvWnTzQ0/jD8j3eQWzR1Wv67/KQXaO09a5gKxsY//czPm9kGopEbfI6YrjuQNqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/pNR25m76J3ou5e/I866l8x3mpHuJyr6k15clz2jZE=;
 b=kbgUXEBHoIKauT9N17qPPewaLVC8yFnV2X+sz7XhCahskbQf1XaWvdmYVGEUcBDq1glAC6BiZDhAihSdgapao9W9DJZMudg716kq/sACe4FGhy47H1xWBZ77it1MV2ed/RU94TTuY4l+pebo5LQro9aqfjZ6KhzEODgj2B0HTtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SN6PR01MB4288.prod.exchangelabs.com (2603:10b6:805:af::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Wed, 9 Mar 2022 02:08:21 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243%4]) with mapi id 15.20.5038.017; Wed, 9 Mar 2022
 02:08:21 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com, james.morse@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: [PATCH v6 1/2] ACPI: tables: Add AGDI to the list of known table signatures
Date:   Tue,  8 Mar 2022 18:07:49 -0800
Message-Id: <20220309020750.65399-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220309020750.65399-1-ilkka@os.amperecomputing.com>
References: <20220309020750.65399-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0423.namprd03.prod.outlook.com
 (2603:10b6:610:10e::6) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0a09ad5-1188-4e6c-fa80-08da0171af01
X-MS-TrafficTypeDiagnostic: SN6PR01MB4288:EE_
X-Microsoft-Antispam-PRVS: <SN6PR01MB428870CD51CACAE19FE676F69D0A9@SN6PR01MB4288.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYF5WABay46v2UziBnNndC3Wfq2zxykvYxkPw5O5Ec3R+h6V8mjFeNWCm4SLBcoauvgGj8pJVK5Hex6q+6qh1hv/+XfbvlXPTOFzcDUx2R0MgmpcG78Dx9mi6PLDOKwRwxSk1G3nxZ5LuVc3rgjXQ+wI4DICfbyA/pxFviLkDGZ0+k3M00ya4iykz2UFALIvhBKaBCko8zP+TLPyWPPXhWD+FrYHnJ4diY58K1Pkc7+xpcVGvyQ0sUytvWMEcGoSZOU8SCKgs2nSGvV9ouu2CABdTshYnqTqZL82QrVaamVbaXopm9g/TXfKzT9nEcaLztyqJqiFbDJPpacEvx1ti4d77kGN2wdHK1gR2EQtSMFI19ZsML7Vd2Obnz3jaSYlZTHv7kylIiNrlQYzmIiynyeOzbi5ZUgaYxmKO0PQLgfh01de/JJE0eRhqR5Z6xV0R6rwhN33dlDVew1SSeoTq0XxP3htJG18877RclKkVtEi2pncciv79032c4hDFoXADBA/RXP25k40GSXM0IKsJkEQkmtyJNUKsZVf+1PWWSP+/iTvUks7hT1YBWwsps6/u/yyJne6kBAYzlMSzdewvRnPcsKPXhmPtdnI3zFvu6noYyRAYLQR0U+wYMVrqCrzqWGlf0jqsIq/ud2Zxm+SivcWC/zOqY0uIBo1+Bs2I+yWsYo0i+2PUZO2JuRSOWhf0UdDQVxswoue9AOx10KEzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(316002)(86362001)(66556008)(66476007)(6666004)(4326008)(5660300002)(83380400001)(8676002)(6486002)(38350700002)(26005)(1076003)(2616005)(186003)(7416002)(8936002)(38100700002)(4744005)(107886003)(52116002)(6506007)(508600001)(6512007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iuoZFZBv/DUQedeNchK9s4NbvcDHp3I4WvnH4WegHTksMAcXnIbpb3S/DJCF?=
 =?us-ascii?Q?dW9X9L7rbw7iJW2Fx1UWCirLtOmlZumHhr9mbtJ9WS0PgLav59n/RYytHHsI?=
 =?us-ascii?Q?VnEQ3dLZqgPHHZ4Cfrxr2J+ARc0TQC2tK9wmDr21v0vX/jnWo+T4+a1OduIY?=
 =?us-ascii?Q?uAdUEnHb40cYDE+z7mPr2uXWqzCTNSRiejeN5wL8iIl2wOsFA4eUuI20T7V8?=
 =?us-ascii?Q?+4zA3sI0xGCVyiMV4lA/2JmyoNLbTgzkjII9K/I40dMYQ/kBmnYZwXElO2Jr?=
 =?us-ascii?Q?N3aN7Hq++dKzb5nHB0UzOWkesptYfCDI1jy/MtUeri9u2gM7Gj3TuiWmk00Y?=
 =?us-ascii?Q?pydyz75RSJ1wALIuH8PjKRSOyyS9sUoC25NKRGbXui9jMSxIqikpKXAQiXMt?=
 =?us-ascii?Q?ztJwRcQvZ3+sEvamMUz+NnjdwRxdIXAP2PqVogAgQe7bSuMFl5jvxDRV05+z?=
 =?us-ascii?Q?tlTEEl1/SMoWgUyh8MVS4GJoaMjlw1tKBAXm7f78CFeWlS2tIkkkdFC2SFfw?=
 =?us-ascii?Q?338NAn1bkxElkmFqf7H+Vu7u52Mx2ZdEn1Uljofw008j93SuGF/C12mNaolz?=
 =?us-ascii?Q?ublMI/1VlDEijVbXmlZh/RKk+bM8duDZMkEpZoi5R6ZCWWpjuclDrjI5WwiQ?=
 =?us-ascii?Q?ZeaKcOZJcISHTxY6VrmWzsdhBlEo3nB7wcQCcsCdJO0dy7y8IVTjdyJPhMrp?=
 =?us-ascii?Q?Y9bUczJkohu1KXsr811RZZX/4uCmj5S47RjYikRga4EGgq70okgOkmzbhppJ?=
 =?us-ascii?Q?G+ephDuwYTX992OdKuaGPcemBXZUqmiGDybz5lCgKdCvk5McPbP9pfad6EG3?=
 =?us-ascii?Q?cMZ+ihCyn1CmyhrFCPBBqFJxn8k9DIX/u20shvbKBhn2SO4cn6HPxrXFmiXs?=
 =?us-ascii?Q?11rdVdao+UieoXXXaIIQyiBA8bhiXuey69JWjdd7xiZ2HC+uTwLJBuGQtyUp?=
 =?us-ascii?Q?ss5MjNUItlaBcOQt1Jn0yBgwZBHIYmWvvx17ZYFzKhDf9VR8C1rnKwpZZxJx?=
 =?us-ascii?Q?l/iYvjs+6fZZnyavB0ohcz1DsmTqjYIOpWOTU7Bm7LccZKJ2d4KhBcRiI7/p?=
 =?us-ascii?Q?TZMy6t/YXEm8eZqyLkO0Q5tBDHjmyvoK0ZF2cmyoLJODcIZmQHycSt8dGnrZ?=
 =?us-ascii?Q?Q12Hb3R+H1niI6jn/5IXpnqDea+y/y3RKBsKcnHVZd+++Hcc68kZn2pMuXxV?=
 =?us-ascii?Q?L4wT8e07Rv6UtkYgO4USezGVNzSxD5RrArlt9PLtGL9ZsqWq4AUioyRnkawU?=
 =?us-ascii?Q?psHSONzLoTVBc65wGr9OpkvvJXAQ/A67m+EbyIaEGRdPaROZJpFfwXLPQi5z?=
 =?us-ascii?Q?z572dlXPUDhm7CWQEu/TJsy6+Soil3NodpjLDbLd9i4Ag4rKr29l8OnsZ+5s?=
 =?us-ascii?Q?Vos7Kp2sS+FnSm+HSyWfh/fs/DPD0NqpBnMVL7iH30vNbZX4K1VXxUfD4wgC?=
 =?us-ascii?Q?EFMTnCuSZTPWc5hycTheAhL5mXIlg/Sjm1Sxc7eimInIeLcUYxN3j+NdEA2+?=
 =?us-ascii?Q?yEBhe56j/AT/hiaa0UNILI+GvK9eZ7MRR2nJ1fb8QN13QluThcrZQH0dM19p?=
 =?us-ascii?Q?CamfpCKcsjNH7PSobmetnZWSHVq2cVrfgY9fTuEsP4SVpqareY7MqwyHWR7E?=
 =?us-ascii?Q?vLZeSmkusVd7n98zlEauGvrKcIhSbY5xbWyHHa7DWTPJZ3ko5CK1ls+BPTn+?=
 =?us-ascii?Q?Hj/3gcT3TG+/Ye/HdkiLFrTDDg6DVZ8eYHjMcWhgtMZh6xn27M3GjCxNsddb?=
 =?us-ascii?Q?8Dn8gPj1AA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a09ad5-1188-4e6c-fa80-08da0171af01
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 02:08:20.9639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yHYlOAJOls8TJh6hKstU9+nJZvHY72Wvt5iDQ0uZc5JiyRqVBIsO/OrKV6etMePfCd/suQG6b8ekGyNXkBdXBVwyCrTkOmxQ0w6bMcsOT1AcDkkeXO+VufVB8ePFNat
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4288
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AGDI to the list of known ACPI table signatures to allow the
kernel to recognize it when upgrading tables via initrd.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/acpi/tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 369eb998c3d1..ceee808f7f2a 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -545,7 +545,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
 	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
-	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT };
+	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
-- 
2.17.1

