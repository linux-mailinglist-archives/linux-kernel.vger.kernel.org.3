Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB834A6453
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbiBAS6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:58:43 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18248 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236132AbiBAS6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:58:39 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211IELvW011778;
        Tue, 1 Feb 2022 18:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=PknLJi8F0aGObEhYbgnGyUAARitikSD/ZkuzqEDaSMY=;
 b=BjeOATtSTtz8Dsvd7DiJ2FpG4H3ywudDYzDaequP3niplAkmiELYRCofGo+NJ/ynLn1T
 s0dn5UvbiMx7lUpm75gLqZnsannlsq0q+qRo1Myg7EXQRUzZ8Dc6FBN+8xZRbEwsV9Jv
 mz7PRVrPl8icbe1lTSnE4fX51D0y0aj6f7WABHxdYauINH18yeHPNf/MovU7ZGfGEAwY
 OxmyI2nSb8Rbcyxg+pvQDMTMiSmMeW41glP2vNC0atfXelWHCXqar7ohPfR7oNpovgd8
 wvvSli7XlTwcHeWzuKN00VC+03nIOQgqubeSIzM9N36EUWwKRdJxi0msKLuwv3Fov3oT iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wbttt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 18:58:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 211IpgaN040413;
        Tue, 1 Feb 2022 18:58:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3dvumfxus5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 18:58:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7fKrkK6QRWYeWvGVnDjdvw9i8OxYEY6rxY0UPt5q80jXxfSfLbK+fq0idTAZ96riH2A7aAxPPWabYAKMTTpwwcT+Y3aLr/5HNrLAjuSjEGY//cAEVAiK4mKeVvIITG9AuuOxDodY6pbPGfJ67GfR4wfAwfgVSWG/k2DIz3UMxGXJ4qe00CeI/k4ohQsmi2cn0PNlJ4v35qS/MmmonR5tYXji0mzXRIaFiVBo7jJwsiOa1PZAkBT3DuwpkxDPEavoCEWgv3NQLEdSSHo/N7LjkKJFBDYQoVKVyy9EYjj6wq4tXeE11pO19i+/en6cZBcpzuhCL/cE/Grc9cOiB3kEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PknLJi8F0aGObEhYbgnGyUAARitikSD/ZkuzqEDaSMY=;
 b=gVS35I8jYjRlSRVsSbEQ2zS4Q4FuQMyoK4WwV2+M6tgnFMTpZ6E2Lqa8sRGLxhNhO/IqMMZvhJr2G8u3mIq418ddtSZAwLGbRxrPzIEJR5220UBMTnaALsBS0N51YLTdQ96rpodDzatC/Qy7kJwF1g4mM9fovH1SYO/k2SJvSXx2WwmuEHcGd5RvyJGykayg8CFA6GU2ZMmqHambmMSNPIxy1A668LMpbOwUlOS4Jy9vwbVWijHIXQEfsgFx3COIbnJAXhx7ohICN9Rh0713f1jisFYbEzvrZHRcvlcpu4fu9F+eYufHERC6ug2UQk3+DKgoEhlHmXjHSsEqGUj5pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PknLJi8F0aGObEhYbgnGyUAARitikSD/ZkuzqEDaSMY=;
 b=IVyax0WnEZ9WJg6gs/j0tdUXNCJTU0tGfQ2+MuwjOvrEsrlGb2WFleTazW09Vroxos/MLHx/ZqtALDnJvEXNAEt7ixFz9dShvBc/QmYmPArF3OT22FDUZ5tZ1vz2/aHAnb1LMfL5LZVQJwMqOFQEf6X2dqV/BAQ6K0excYlaeBw=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 1 Feb
 2022 18:58:09 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.012; Tue, 1 Feb 2022
 18:58:09 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v3 1/4] printk: Add panic_in_progress helper
Date:   Tue,  1 Feb 2022 10:57:59 -0800
Message-Id: <20220201185802.98345-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220201185802.98345-1-stephen.s.brennan@oracle.com>
References: <20220201185802.98345-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0051.prod.exchangelabs.com (2603:10b6:a03:94::28)
 To CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1142c20b-5222-4df7-ea0d-08d9e5b4c9a1
X-MS-TrafficTypeDiagnostic: BLAPR10MB5156:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB515653065AA3CFBBD1006D68DB269@BLAPR10MB5156.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5K87zco3k4P0CtZ1pMnJKTmHzYMATFDCTUoimVkLbt/e5rUUBSRcywOyQrfBX0pzfXjFUMwCrNMTmmxHWYWaqKaqF7Avvduy5lcGuMPLR/u5/8/S3JnS2igeRnigNI6v2RpXLn1zdb1oXB147LhCPlA1QC7MUB69IdcyZVMwazvVWlhaicd+kTevEu8TJE19hDDo3xwbcUNmTtidvctAvRXGr7I3mzEU4PinVu6erAVqnvySiwVZLNAQoONwtD79NI8xoC1H9onwYqvw2eCKt8eQhOM8Y3TMv1OUQ3pns4kbFDK7DiLouSDlv8joxTk+pe2X/nXrlIpPe0IshUWm+JJHeseWIoorXB5k5K9P8yx6H/r7mm/Tzpuk18YVOXm55UZJwB/hjmuov+QBV1unQKFIrsAjEeckx9jYmUGOJ3ppUfQPhO4TiZFR/1uyvicqlHGHadnr/xcpkiE118nuEAnHB184tKbGIXjTNGgLHB7kUq6Xuxp4uRLu9Jd6Dwxgg8iciadLyuK+OzP4E6MvyEveTSX9PeojLk53CWhILGMZYet96cScyHKavPgitcc7clUGdlVYs7E6buHx9XOkJHZqxXHXTVF8ixc4cjX4Bdu+zhjJftQXsZHAEGqQzhQ8ccRPEOzDlZPCZlzWw/q/+bbT5NUsG//1S42i6i48NrvHXsQKyg8cEWsXqOq+rw15KvkIbOYkHV7qZCvjBQcbdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(103116003)(6512007)(6506007)(6666004)(508600001)(66946007)(4326008)(66556008)(8676002)(8936002)(54906003)(110136005)(26005)(186003)(316002)(66476007)(6486002)(83380400001)(1076003)(38100700002)(38350700002)(2906002)(2616005)(86362001)(36756003)(107886003)(5660300002)(52116002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?isaWgyD2nR4XBAHfAxZ8R0dN+zL0K0bewVSKv9kT+6CRFKj6OlaaJUojNP2C?=
 =?us-ascii?Q?YLavyHNnzpeVc5UyITrHPAWx51x2KZKx1NB3KO5qrkk46HDtk7eOW0JBYIPK?=
 =?us-ascii?Q?QrFECl2hmU7xBMPgteHh6B2NPAjakRSDcYWChSQA6TTbQ2M0GSBEDCONehB/?=
 =?us-ascii?Q?8gXvd1DdwggdG79CJ2QDqAU9kzdz/tFE1HSVytckWJ4M08nKAHdyf/BaPgzS?=
 =?us-ascii?Q?gOXymtb8uFwohYHfjgo8tJR4PT3gz3QrJE+wk9d0baA8GeDK6/V7F91zxNuv?=
 =?us-ascii?Q?xMC/Lu/s1c5mClL74XMvMi3Q0E0Ud+x/qdnrR9T8QzEAGYjxcrr8T0YjlDMP?=
 =?us-ascii?Q?QJdF/ZD9AZ5rr/HQqgza9VI0OXWM/ym/ukdWuOZzyx468YLoOsAATnePEO2e?=
 =?us-ascii?Q?i5vIzaPiyNoyxIReEIu6BJAWJ+vNxKqGzyrNzFyJG4417DUNnCgoGOHS3VgC?=
 =?us-ascii?Q?N/ehvsREgEpcIl8zmDhuut00ggYSxixbFYxopgBIUD3kQcHUWh3d8Nr4dyrK?=
 =?us-ascii?Q?z1+n/jZTeGqlps79cJq8QyUESJzHFoDXcigHXfuty4ptLNAjemYhs7XUpQZt?=
 =?us-ascii?Q?/IRIuBgkZOeATQlYENWUOXNWISAf14MHHLc0blBD0evIin8WEK1HOtV0yThm?=
 =?us-ascii?Q?h0tExXYoELzLxAKCSDcduHgDVQ0aR+j0bah2Iikw6mUCAXDrHYqAk8TK/12U?=
 =?us-ascii?Q?tDuBNDqv4fZMYy5pnHKWrGEyHRs1Ba6qONYV61kKQjAWzBTwaw6l1UDzEeRC?=
 =?us-ascii?Q?a26hSILFi0zAeJAanYNF9fDtdX8RXpbfvXj79Oedb+SzrhAyQKLWwPX+tysN?=
 =?us-ascii?Q?7hOAUypEqt0kJyjyOUTTUIeO9NGqwPaCRzUBPDaawO/if8sNKry46PYl7Ky7?=
 =?us-ascii?Q?RnDs3OhMg26qWQjDNiON5ISoNVHKw5o5+INhZ3LieAW5B2sYQ8w5oxZ7uxsl?=
 =?us-ascii?Q?xMd2aqxU4Sh1rDCAwDdwvaE3e8Xt0WvNDULY5yEECDSvh39o8OdWPrdD0HRe?=
 =?us-ascii?Q?42UE61/XOt7bnuK3QGM4Yn97jEoSaS6SbGP6tEKzC7eruTCxV+7FmR6awooV?=
 =?us-ascii?Q?1uUfAwnXp8EY7aCEwASumHoCkivPPwylEAoo85s32n77+XacC9IG8EC/mF7J?=
 =?us-ascii?Q?/AWU6CG3zl34JgeU7sdr+gPXEHoUt8kqpxALZPs3+vX0I7KLO/Vy89GCD/uY?=
 =?us-ascii?Q?VIYboFcwAHnU/2gGt2eHO6Ta7pSf8P777iocnSItiHFutpT7nsJ/tCaZ/qgT?=
 =?us-ascii?Q?qWQ8J+umVakhT7VdNd0BMAB2/DQCRU0nUSStp8XTMh/Vdt22gzcZTu8k5UJy?=
 =?us-ascii?Q?6pTqAbxxxDCMQe+k6EkuXB21oniYrcrDEHFow+/wrGc0lCnaOydWXppS1494?=
 =?us-ascii?Q?tPJdEdz4dJrL4YpD6iKdck/3D1ahI3P5Zjmb7XurAdiPODwvt8lvu+MpSdNn?=
 =?us-ascii?Q?S43tqhDG0H1iuR+8sdNekrfwUsHOrxCrzne3C3JWwuAjjw3lcsqS8y/aTydp?=
 =?us-ascii?Q?UXYr8mnKB8e5RtN4MUWv7GqUi4iJFJlJTYkFklFojRu2DI5lorYjvI9uQPh3?=
 =?us-ascii?Q?w/cgVZI7mBRsO0SQr51JyJ9ASNxendUjE55wxMWKrP7vSnVXeAPAHzZZh6Hj?=
 =?us-ascii?Q?duQ1jDyUAqMMo4pk4ClYq8objlR9tXN/JqvqQ8Pb7QRBXlu/CXHvFVNgdW2p?=
 =?us-ascii?Q?xMk2oQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1142c20b-5222-4df7-ea0d-08d9e5b4c9a1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 18:58:09.1038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uX095P6JD0/w2CBeCnJXqP4Ye1SkNThGt9ozk+7NaTXIdv6VT/4plOydgu8XQ9v4M/Y8MN5ZNMg+KOvThGlGtHd/xqd8xZUNWaTDBY+2Q5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202010106
X-Proofpoint-ORIG-GUID: qWgNtR2oZ5Ppda_VLf8qgsn1AtUGvuuv
X-Proofpoint-GUID: qWgNtR2oZ5Ppda_VLf8qgsn1AtUGvuuv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used help avoid deadlocks during panics. Although it would
be better to include this in linux/panic.h, it would require that header
to include linux/atomic.h as well. On some architectures, this results
in a circular dependency. So instead add the helper directly to
printk.c.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---

Notes:
    v3: Move the helper into printk.c due to circular include
    v2: Switch from macro to static inline function

 kernel/printk/printk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 57b132b658e1..b33c2861a8fc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1762,6 +1762,11 @@ static DEFINE_RAW_SPINLOCK(console_owner_lock);
 static struct task_struct *console_owner;
 static bool console_waiter;
 
+static bool panic_in_progress(void)
+{
+	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
+}
+
 /**
  * console_lock_spinning_enable - mark beginning of code where another
  *	thread might safely busy wait
-- 
2.30.2

