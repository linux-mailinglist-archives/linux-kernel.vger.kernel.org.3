Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A0748739C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344827AbiAGHe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:34:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20220 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344595AbiAGHe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:34:26 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2073Hfu2014505;
        Fri, 7 Jan 2022 07:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=KtWka6YYZ4VBdwmXEq0PNM4GBSIOfWsKW/+brqgHpwE=;
 b=LgVXzc0Ep38RoSA5Qo3gsxauItpL+ugFEYZwQQvBi5GnUPkL7U+rg/mcvy0DmfPFOBT/
 jwxJ0wCS1e4ZBjlGFhiZOnJ9tmxD5YQJSWHtickFJqeTYDGv4OfxaCX9nr+LOincELiM
 NL/gs8Yk8Tc2rzNkatOOj2dHLm8E1JMNiwBp1aokhbTeqHHeXXKuH4J9cWE+p3sRPxyp
 IHKvb8zdFGBKPT8FWOk+JlfSL2NbGhUwOg+UejJZyTEqmLAvfBv3woyKNiuaT0fmBDNk
 uhgKVXXXEghPIb1npfstiv7OAO9NacFxOxzRYo9GfttWbyCxlOKw9kHfXAPBIWzQT69p 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v8ha8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 07:34:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2077VOO2142220;
        Fri, 7 Jan 2022 07:34:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by userp3020.oracle.com with ESMTP id 3de4vn88jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 07:34:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIJcLEavEVIdVCIpqapF+zmMMQVjXIIfISz/J1MDd+NVDMub9P+daNpgZ7imuzWxMwbw9V1fx+QXzjce+p6VD3trgUpvYlHLBbZjfyIIoj/CDHc15u/A7d+9GTmrmPpI6Me8Q6D8IuPGjrwVJVl6YKOGbnLKWUW0zODGbkAGJUFJ7rtiJHT4GZDAWXWib4oMLoJoS+0YgZ6T0CMJm54sT/LtRBlg3PDbO4tLnBsHH666INx2gcWBXFs2WxJNg3b2jP5VMrgudYKGSeKppJg2rNrWC11Ah91Fj/HAWYWc5BJlW7ITBUMvnvsxTcekEn6GEyfCfVV5ovmce7cmnyaCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtWka6YYZ4VBdwmXEq0PNM4GBSIOfWsKW/+brqgHpwE=;
 b=kA1B741hgEQBTyoxDM9K8CcU/3tjeP0xt2L0Gwsaxgc/yPSy725Jx6LWnn4ZvR/tK/+nRI7WqLYBkEkg9cpUsLFPXwplxxROo8V29Ix/6M8ir1TCh9DlcK4ramlcLmXvmAXTpYWRymU+nduCR8PiWCWvQiUL8ZR0ZkOyXZtwqgIen0doInzY/+bJHecnU8NsCfY4JLTBjxehOUEQC7HRmCXP6L4vomUziW+APQIG28bZSnvAUoSGTy8gwKHYDKiA9UDJgd5e60KQTlSAU1zveCMAW0+gy78BEI5EIAltzSeRTTjtBlU8CRQWpBdz6Xbu4FbIpgwAQlpQLb6mOSJeuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtWka6YYZ4VBdwmXEq0PNM4GBSIOfWsKW/+brqgHpwE=;
 b=KUAq+2QWs2lnYBl431KPoPVuyQSsA7UwREEB2CkyCWhsesmtZtFQwupNMDaPTZBAkP/yEGzaI4zls9cfPaxwYxjyoJZ4Pi2JaR3uzKQXxN92MpJdun+OScbx2WcBz8SA6pcFEzZbmXws9AUasDrydDeQie5k2bMjcejlT0yq1hs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5752.namprd10.prod.outlook.com
 (2603:10b6:303:18d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 07:34:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 07:34:18 +0000
Date:   Fri, 7 Jan 2022 10:34:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ACPI: pfr_telemetry: Fix info leak in pfrt_log_ioctl()
Message-ID: <20220107073407.GG22086@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0184.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3d98a26-1fdc-4e22-2942-08d9d1b01d3e
X-MS-TrafficTypeDiagnostic: MW4PR10MB5752:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5752D7CD0DFB6402057441318E4D9@MW4PR10MB5752.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDCnhHFM/zJBViTznO333zdfjv44qPB2sHdKJfz4dxqVJ2TN6XqPRKD8rNBQw3tPY4DpcHGXG7f6rcIcdPOFRjhQCFPUq1MeeuG51+kX3jlvXlFdC3c7rM1e+SOuhPc/leIJmfj6e5Ekgc5GlATeY6RYQqtx+boueF75uXaF4eOXDlCl1zq7KtjgDpf6oO9M+ZQm4uJCxghdVYazS++c05d5XQPorKebgdYHxRHalSmj1uuUvZHmeTKj4CrWdHxEwTTlqnlB7/IjDZGnUqTKlSVM7vM+c8tIjdZ24I+y3X2Q6g9FzHbgptcrC+HzVAv1CUqv9XE5P1E+iPbLR0KZ21D5IFuORMWxRUs05xlEexRQbRBRHe3Ejvd9kz9a1KSsdL6l9qpR0Kt140oLK2+z2n+krfihMDWH6rTg1y3VIkB/ofWPvGMe5z04vmnAX/dU6MTDvRHSPYFP6mrPGrmzWaTLkyoiuFeUAB+b68G3g6oLRmDsIgsgOPkyButqpwU6FHD/AJh3tktzpYKG3waDJl5vKm5DnZ2QAF0jNxkQB1ljra7Mg3JeM9cUfzafHEhkoqaVK95jrD+3rMscdkp4lJpdoBch1cfHwMuRTa1sDcGq9HuxfhOasi/g6psNUHtO5zCheF0beGT0IITA/7WVC3C+g3aDDVeFR6SYNoIFRYH4r3JIAVe6+59LFp10wMrGGI4CXTVl4gop6/8ttkfJ5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66946007)(6486002)(8936002)(6666004)(2906002)(186003)(4326008)(33716001)(1076003)(5660300002)(33656002)(44832011)(9686003)(6512007)(316002)(52116002)(508600001)(110136005)(38100700002)(38350700002)(66556008)(6506007)(86362001)(66476007)(26005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dnHlmsr628+T7sCDgD4KvgLKVMpYG2MkZIQbkjbFlesbfJ4wSqNvJIQvOpTk?=
 =?us-ascii?Q?C/ZsTafTEEzw6qJD3ZY2hBo9MTBbVzA+kWWakBrlGtnTc5uXZIafG9VghiQ9?=
 =?us-ascii?Q?jEvD6vaZJZkw6KdX+5XT1m+oQFikzGrm87O+RPHgRoqOlaszr1xp2LLriEHv?=
 =?us-ascii?Q?pyAaNekKAZZMKOR5zJ/1VuSmWUav075G115SDedx2T5hudf0yhILJzLAQUin?=
 =?us-ascii?Q?CNBPjPgobbjNPHmbmCPDy3KsRM17f1qEEYQCYV2VXSILgoH3U1jCgjwArjWn?=
 =?us-ascii?Q?GRIvyBcHz9qJr4vojyKbIsh4LWsI5ORJvo0d5IuKuEuUBBG6WOvetIjaUMft?=
 =?us-ascii?Q?sXITj73iMVTo4VXjinkGEaMrtwfpDHdK0tzL1JsxDhnq1fZRcfpOvsQjArKX?=
 =?us-ascii?Q?+kZSbB6z6vsTcvlSCDwtPvUxQbar9gYcAEJ1ZF7v65lo2zGJ72ckNXUoZWTf?=
 =?us-ascii?Q?/fnycE8pB10Klw312MMG8II8QXDn92OghAS8khIFSCSeGgB01VJos27hAVOn?=
 =?us-ascii?Q?WhvMc6R+aRwsaOXhpTTed2XfCQ6SdDYtxpUfAg9F/QeeErfIy56zOh6MVZRZ?=
 =?us-ascii?Q?gyp2nSRtl+gYsIbAmfDmUxGJPrhgQdX5o8DGrrPKhD9hJSD5pI1Ny+T0nqSB?=
 =?us-ascii?Q?FCvziN3NPBPwtO7yFeze+GyFOasK5FFPf9hHzh9aVBYwPIqXuWYn8C04smwV?=
 =?us-ascii?Q?IqsSS5Gmx/unlQB3NU9FqTUvvmfGlLCmgekTcSOwiuTsYlLij29cM5bNHXod?=
 =?us-ascii?Q?RWlH5/Sfe7aMPdQY6P6Ur3EfSWr967gXBiLBmwNY2r334cwu4iUL4ttj4I4t?=
 =?us-ascii?Q?V5mZp8Ho9eRtg4aMzJO1ma6CR+Iz3Y8QeE4Lk302fqESJzNl86CvXCwBcOKe?=
 =?us-ascii?Q?wCsMJUrKQ6DBhFKf9ketBtHAM0TChzM+ZSk6wqaOyl+IBajvmZdIqXj/WGl1?=
 =?us-ascii?Q?b9ZILDqmyLwZxNIvqjkAGA//eBTEPIUujmKvqyuL77rL5Wq4rcKtUzB/Lwek?=
 =?us-ascii?Q?AKnF/Hkj/69qjhF7zUyR5ddZmq+mw9NVdeYjtQzAU3zjz8fy6AqBX7oKGnA0?=
 =?us-ascii?Q?ONKPRiKgVaakaUlaeVYJXLPCJNAou/EaV+yqp3TNO4FipuNuW+RS1LiJklnc?=
 =?us-ascii?Q?put4QxcxwT/sUr1XnFL7iIAlmBPv0UyQd5gxfAUv+KH77pPuhb0uyEDur+Nj?=
 =?us-ascii?Q?XqFt3O+46i8GUaysto4mGZeuB6rBteW5CbGuEyF4KjaIC6r/OaxW4bXLpQLA?=
 =?us-ascii?Q?TptbZvXrAWpNK3MPVHkXh7mQS/y8Vd8duAiou0zXb8KTGTb3e6GoxwEU8hQt?=
 =?us-ascii?Q?kob3pa+pxiOvVGvkZnMCwLrFPuu2qE8udarXPBlH409q9McH6+AgX/h3kn0d?=
 =?us-ascii?Q?rdL1dnCNkgpGj3nKNz/5Z1n06m06POfqcuMCqEAPWyJPfxrzkGFre7zB9isw?=
 =?us-ascii?Q?DtzGhEjyPleAVLatLisJMyi6MoFOXzoYWbG1Iqp0rzythsofpt6bgA5zs7RF?=
 =?us-ascii?Q?mVU5S4/wDx22H4XthkWLccV1hi5ltWKZyXgWlmjhOORKljHO9/RA4+h1sr2Q?=
 =?us-ascii?Q?u0mGRBAdkfpI4vFm9GqOjJ00MAprY87KWHMM1BEGEsy/Z3JSqKU0iqfvcbej?=
 =?us-ascii?Q?KLA3ddh1yBoG+Q4H5eGhfR5/QDfwlOiQyHCIhLEgi27v5mvfueYZZCjGUWLL?=
 =?us-ascii?Q?fpuXMS09G26+ZbFqf4pShFRdH1Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d98a26-1fdc-4e22-2942-08d9d1b01d3e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 07:34:18.5635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDToMSzQEX+T7gbw7vdB/g3XRIFkcq29VYbNZ0K8XmrdnnO2Z0K5BU1H/npLzXPJJHnahevuazbSWqNH0k6JTMbscY7wAYycT6ZDkt5GGIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5752
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070053
X-Proofpoint-ORIG-GUID: y0EA88hfT8teSFG4j_1XdOPq8cAF05Rv
X-Proofpoint-GUID: y0EA88hfT8teSFG4j_1XdOPq8cAF05Rv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "data_info" struct is copied to the user.  It has a 4 byte struct
hole after the last struct member so we need to memset that to avoid
copying uninitialized stack data to the user.

Fixes: b0013e037a8b ("ACPI: Introduce Platform Firmware Runtime Telemetry driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
When you're adding a new driver to the kernel then please use the new
driver's prefix instead of just the subsystem prefix.

 Bad: ACPI: Introduce Platform Firmware Runtime Telemetry driver
Good: ACPI / pfr_telemetry: Introduce Platform Firmware Runtime Telemetry driver

Otherwise it's just up to me to guess what prefix you wanted.

 drivers/acpi/pfr_telemetry.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
index da50dd80192c..9abf350bd7a5 100644
--- a/drivers/acpi/pfr_telemetry.c
+++ b/drivers/acpi/pfr_telemetry.c
@@ -83,6 +83,7 @@ static int get_pfrt_log_data_info(struct pfrt_log_data_info *data_info,
 	union acpi_object *out_obj, in_obj, in_buf;
 	int ret = -EBUSY;
 
+	memset(data_info, 0, sizeof(*data_info));
 	memset(&in_obj, 0, sizeof(in_obj));
 	memset(&in_buf, 0, sizeof(in_buf));
 	in_obj.type = ACPI_TYPE_PACKAGE;
-- 
2.20.1

