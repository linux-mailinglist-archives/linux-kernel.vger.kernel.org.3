Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6044C4727
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbiBYONW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiBYOMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:12:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3925416DADD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:12:16 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PDk5W7017413;
        Fri, 25 Feb 2022 14:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=mPNiATgYewGJEZ/MMwxhMaiA+2XZgtAEpChhxHjKF8I=;
 b=TjALdTuTwZ8PKIEs9x6kKMOSIKuQ1WdIBcRo7kEjh9tQLjaAzszaXUbo4SoAw8HtgAT0
 AlCL5A++pJow3DLJ39/9PlinuwtMDyk77e2QVNI6AV68VKpjFkZ87Tm7hxOJPIep/IYY
 +0XePSZczDDaJxZbi3anJbgCobfOPRIWxnNzhBlkalRCzrfa0Ct6P+8vXe0w16krIYOM
 pnPWMSPpuhIed/1VTvIE8dXTh9lt6/LwJqfWkFsTJNTY2m0HkH1rq3bNL1jANG4+gIva
 K6+GLfS7ggjx6JDRas1W8VhU6THY1DXwVQ4jAMfA0lt5JakGpw4/QauEZz99mQIbfPLm nA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ef09pr60h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 14:12:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PEB2nx069584;
        Fri, 25 Feb 2022 14:11:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 3eapkmvf11-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 14:11:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8mclbjXSvpq1be6r2v7wZcMuaBs7aLLN176DchTu8fK2Qj2ww7g7bv8/vDrZ+enwUoYEmX5etdP/oj98/Fa4XcaIQK9hNTrhu6BNmA7rhG/HWmaT4EkCSVYX4+jXDeA707NxO3qZpK+FVNPPJ5F/YXgERBDctfaYxcTzYXL+s28PpSh5uUiuYBuXUkj8ffwjRj+DOo8Bf3x0KPayWtHq296/ShsOGSB7WHI5eSLds8Htwfx8b86Pi0vxpSxTHb/v12rG6andlYs25MbEY6Hxz03BV6qITe4aPVAveEsIlm4pVy5OisdSZYxPkcgL9G45oStUScjF+7zkR08+YR3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPNiATgYewGJEZ/MMwxhMaiA+2XZgtAEpChhxHjKF8I=;
 b=Fjd5n3Q6XmUy/gl1+MoQXdGcpoNlDGeBnweeUZGw03LqJQ803L5Xm3WnUyEH05Susmfh04dIPpBjoCG1n6oTmqi84HPKLAwyfG5MBI08T8V5MwLSsX9XdD1p/XGfySIEHhenqphsOdP3YDtA0HiNIoqcfGuJXhwxcY68lr6fqlYQoQkZ86FlaIaaAPCA4xfpUNhYdvF09uJB5v0xZJLsWLqKGeSjX5mTXihMkKJqFj8EvyMZQR8JSsz6CRU5QZGjEagnqyT8b51zqCqlflmfscoB1+YplCqwTpyZPdjcklIJ8PzCYCjODL3Kjbj5cUIBR/brugJ3BDdS73t2S+zjWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPNiATgYewGJEZ/MMwxhMaiA+2XZgtAEpChhxHjKF8I=;
 b=dwRAbrnhgRWcjSvP0q006WCjTlodK1Flotcd7vACxAqbmXGwuDA5/t9nFyQsB25PlSxHde19Dl33Y3jIbM2O2WpZ/JKvHxNC6eIB3B4UISnIzsNyyi6CnlKAHWbZE8qLoZYE7MHwvwM0u9fnEDJCsuwz0PBFv58tjsJ4GIbiaO0=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by MN2PR10MB3328.namprd10.prod.outlook.com (2603:10b6:208:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 14:11:58 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a825:7455:e3c8:3b65]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a825:7455:e3c8:3b65%7]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 14:11:58 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     ross.philipson@oracle.com, daniel.kiper@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        dave.hansen@linux.intel.com, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v2 2/2] x86/boot: Add setup_indirect support in early_memremap_is_setup_data
Date:   Wed, 23 Feb 2022 21:07:36 -0500
Message-Id: <1645668456-22036-3-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645668456-22036-1-git-send-email-ross.philipson@oracle.com>
References: <1645668456-22036-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::32) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce62f2ea-6621-47c8-c7fc-08d9f868c90c
X-MS-TrafficTypeDiagnostic: MN2PR10MB3328:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3328E0F5E7461838AB3742A6E63E9@MN2PR10MB3328.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wMTvERc6Dk8jTEZS3awMFATxZkUt3Si8zZFhMOpt2j2TajEFglq6KH2LW3tlEMpskdjd/0Kd7Yd73cdd7x6ZMibsBLAZOXVQmMtBH16PxIdXRR4xEB3H7GEU6/KklsQ6sx+ZsBVgwXMYS0mq288a/4LtuO08XBm+uMuHyxeK67YP3xtiUKUoB+9OrFVze00pZjiGIJ0VbPfEg2qL5YZlwQcSc5XoQX2J+AoZvlXJeLg/d4e7QyKmRh7bo2OSo0uLLjJSvXneUVk/Utjrh+Z4YOU41LwrNHkMqEPo9oODqRKuHQjJXLMP1CC4P2X2uAmoBc6deTam83KhpwCF/1sL+Pck68bX/vEH+9QgAyrD8GgRriZz78ejnwDY5em12l8z2RX0WBUDMBoyObhmJBXrcLHc7HMVgLZG6qtjmHgI7hV5vE2dJisXBXrhtu+9z4SQrAre4JVNWTXfVVxk++hx3jo5fiLIhchDR9qsemEJyhN6hW5jhdaCUy8GoJoycPBhuUvcRVOJ/tcUgLlTFz9rCetd3jhuMZ4fn0KymzzS/SDuj01P+dMeh1YrN1DhQj7Wf3yOO3vi7gIssCea77+9TR4ctGxMbLOxsYYCjqcXxzELxM9wpEfNMN2SUtDVN4U+sCR4AInO40l/Mzb2cyeQxG8eJSXyNS62NOizPzTpb4nYCO0NcPbC77bsN7bYMmrU/GFj4QY4gL0ys+Bea2e9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6486002)(4326008)(66476007)(38100700002)(66556008)(2616005)(66946007)(83380400001)(186003)(8676002)(26005)(6506007)(6666004)(6512007)(52116002)(2906002)(44832011)(8936002)(38350700002)(36756003)(86362001)(508600001)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UZqgJSDj7ZfDyTUcJOoNiyaX36czTH1S0C8aJ1pW1kP6kNjqEdCY80RluV9p?=
 =?us-ascii?Q?t5tS0ZP3ARl92yiNcRJ5PcQP8x5aFFU0jx/FxQnuOcXiC/aObTZ+bZGiihtz?=
 =?us-ascii?Q?5mfQai4nF7bNHsAKXD/xBm2wEpWewoakDw7EdjVc3KuTNnS4Dwod4xPbzS/M?=
 =?us-ascii?Q?VAt1U0xVZy60Z4AEykaUiGXq+aBnqmtKJolfgagK+BxH2UkNokkVdEHFutz2?=
 =?us-ascii?Q?VHYaKKZ8hQNIMHQJdZhqV7jgLuB7WW0IRN1r9xebGLeV8zRToIZLnm15Wl9Y?=
 =?us-ascii?Q?W+0yT0jIJe3K/PdijhjgHNxVV1K46+HcCx9nx2pS+QsCq/pLWCYv7KG/XwB7?=
 =?us-ascii?Q?gSigJXfyYaub8woPgyXq5lmuN4h/9CA89hytb3SaOPucnqxAxKyJnl2RmFPk?=
 =?us-ascii?Q?dt3+a+XpJY+c8nP4qR3GJC8IPfbLF4MGujE1jIYKQccsSTjE2rsET0B/2Hsd?=
 =?us-ascii?Q?DzjC+enKVpNjVZooqwE+2FqzXcvUHNAU9y22Fy0ubfr3pVK73gvXdco1WEnL?=
 =?us-ascii?Q?uaArValAdAMFciRGRBeppc1395unMtxG1nrbStb9kYy0Jk6RmUJCZRdVImFW?=
 =?us-ascii?Q?IU94d0r6viMlzoShu/jY5jXSogpLKJ7Eik6AwrBeqwysnm6YNzZPA/QA3/Q9?=
 =?us-ascii?Q?ate08lbHr+YV01xSYMwmY5ZrNwdwjenCQ2xaq9QYmsqLandTyEK7D5ak6b5l?=
 =?us-ascii?Q?hrcosST/wq0agYprgE4iathQj+C72LH6yVzrR/Vkc521siDfZUDdHWNNMaq2?=
 =?us-ascii?Q?XvN9GFoM//3yhoQUyzMdA2W4/rUNPyMri8rhNPlFf77iaAuCaBvipy5uaGtJ?=
 =?us-ascii?Q?nwvqZGWKY//e02h8uHJhRDw7xwcJHurRc/H2mGPn5vk7Ufnlsv+5urA/0UxO?=
 =?us-ascii?Q?zFWx7Hymyjwxzn0NGJaCjRjgBFgMt4c5GP67bLIGDM4gI1No5N8kiDneCG4G?=
 =?us-ascii?Q?BMxCm6JnyRUoulg71ixTrKjXgIa5v1pZa/Uac6Och2X9SEkIvEdyKmdbhgoX?=
 =?us-ascii?Q?XDueskTiQoGWv99lvHNBWGPOO6eGPMBC/9HhIZH7180NUjlopNwT0/fH/5C4?=
 =?us-ascii?Q?RM7YR6VMR1aQdqeBWBw30p8T/RZyB+krIWQmEeWiUIPDVF5/2IAu130bdFGI?=
 =?us-ascii?Q?ufylLcFcygUMD7uswX7nU4gRdeXi/DTB8D3zXZCEF/e9UH7KQyi9Cg0cNYsF?=
 =?us-ascii?Q?5iNvhSRN/18OYRGtAfKVlBVPx9O+CTelKDzGKoHwn3v37x2UZvCJYxJhe4eD?=
 =?us-ascii?Q?zoCvY8+B8RsYP7Zwkl6UvfhARy2ZKLUYlH6lvX6kHpARYavOa8DbBar8XJO8?=
 =?us-ascii?Q?ZHZuavvoPnVdel7rydTt1iuduo+jHkflV3pzrGxotYL4QFQLfCxfF3uEbP4J?=
 =?us-ascii?Q?xkV43zSYrIt+cOR8Z+ZX3euFCx0t4csXnqzZvZIbYp8qdwkWgK6mb9XqKZfg?=
 =?us-ascii?Q?LLzSAB669A05JJgNLRlHC4PoDfgaN0XHnuInKQMCiQ+WclkyDT4zO1Am7EVL?=
 =?us-ascii?Q?po65WN1TyUT6gZCiPkAVYaRa+uxG4FmfsKK+JnD0GPCDipDrsdmTOWLASUVM?=
 =?us-ascii?Q?Ri6LfDczIPL+c5vt8otY9q+ZFI8nWB0Lc0ZABvfpFm5RfLbBgUopMYwwQDiW?=
 =?us-ascii?Q?7dQUMGw1K9GiLRdcFqF0/FACJy+fPqdZ55v0jZFpMWUqNJbFV6iE7XIVUWav?=
 =?us-ascii?Q?QiOMKw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce62f2ea-6621-47c8-c7fc-08d9f868c90c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 14:11:58.4543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bL5LFZpc/Z69BXyG8Rp0N2l1tOzzrccW/M1h4tmrrg7B9TDkfGwyYQXAnJ1KoDg80od7BTBGHM4xF904DqCP4/zdUYcrOu59Aif//5vob1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3328
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250083
X-Proofpoint-ORIG-GUID: cNLe_QACVryIDDgbMZyI_-cmDoQoVnfi
X-Proofpoint-GUID: cNLe_QACVryIDDgbMZyI_-cmDoQoVnfi
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 boot documentation describes the setup_indirect structures and
how they are used. Only one of the two functions in ioremap.c that needed
to be modified to be aware of the introduction of setup_indirect
functionality was updated. Adds comparable support to the other function
where it was missing.

Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/mm/ioremap.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index ab666c4..17a492c 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -676,22 +676,51 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 						unsigned long size)
 {
+	struct setup_indirect *indirect;
 	struct setup_data *data;
 	u64 paddr, paddr_next;
 
 	paddr = boot_params.hdr.setup_data;
 	while (paddr) {
-		unsigned int len;
+		unsigned int len, size;
 
 		if (phys_addr == paddr)
 			return true;
 
 		data = early_memremap_decrypted(paddr, sizeof(*data));
+		if (!data) {
+			pr_warn("failed to early memremap setup_data entry\n");
+			return false;
+		}
+
+		size = sizeof(*data);
 
 		paddr_next = data->next;
 		len = data->len;
 
-		early_memunmap(data, sizeof(*data));
+		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
+			early_memunmap(data, sizeof(*data));
+			return true;
+		}
+
+		if (data->type == SETUP_INDIRECT) {
+			size += len;
+			early_memunmap(data, sizeof(*data));
+			data = early_memremap_decrypted(paddr, size);
+			if (!data) {
+				pr_warn("failed to early memremap indirect setup_data\n");
+				return false;
+			}
+
+			indirect = (struct setup_indirect *)data->data;
+
+			if (indirect->type != SETUP_INDIRECT) {
+				paddr = indirect->addr;
+				len = indirect->len;
+			}
+		}
+
+		early_memunmap(data, size);
 
 		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
 			return true;
-- 
1.8.3.1

