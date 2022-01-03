Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB6483855
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiACV2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:28:53 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2096 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229688AbiACV2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:28:52 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203K1OMJ029665;
        Mon, 3 Jan 2022 21:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=p4RkpMXjUsVHbhuS5yRmi/zkP4AlYDmW+qwx+tnIniU=;
 b=L8tYcuicc4i8lASr3gi+PLbavL1Q1Olyb2KWzh6xXreqnviLXZXTZVCf9XoLsA5HHNy3
 JKQPQeXq6KtgPzk/2WSzJ+ws2snQNnddU6nkP1Jst+6Hp+kp0gy/+ylxiy4bAmCreL/g
 9v7M9ppRUVVhhlfXJYQc7pVntfhWAz+0qyOh6zvsKcDdJhQqmobBMq6uqvAooKEokfK5
 C5q7O13e2ubbDsmOteENBlGE0UetYNYfoy25q8gYTLXvDAc5BAef1o65Dntv23pue1LK
 hZo0pc6V3m/4QUHRx8djBg02zt2P+/iWxLFQ1BEY3USuscgKnj/wWAjM1NERc310GJ0z uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3st0ss6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 21:28:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 203LLYDN073336;
        Mon, 3 Jan 2022 21:28:39 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by aserp3020.oracle.com with ESMTP id 3daes2t2tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 21:28:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB/Y1LeFlSY3Hzwsdac6Y1sMI/aWxwglusoZ8j9oposTUxL6NvaH3jU1d8Nf4QLEkO5ZQS9qpd1laEII5zrE7VGFD1+XxIyI8v4sMFZXnhpalOiKx3uGKFtdFQb+dZBWy/LoPSNvR6dFxv1HSD9IMCOh0zAJMHx1H1+OCqcahzGuvP6zRIVxK6fVugQDqwLQWCOoG61J1g20MNckuF0sLUhJzAeY7KSvGXnjGCaA6uNCCvS6UTKzgzh5C9mXODBKajoiNzM9ivsbMlbPoG0ztI/0IciOIrnI7Qbsghi91vMUd76thUrFkzzd5xMIQY5Ba7+B565T38DIswMwTleutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4RkpMXjUsVHbhuS5yRmi/zkP4AlYDmW+qwx+tnIniU=;
 b=ofNDySUDdyZy/qVXvyPG509ANPSBsGHXyewCzapMR++Li+QBLwjHEHZ3eP3A7kU/CUnLnYN4TxScTr38Bc7raHLaBav5+OLfLHcqffRmFXiGiayUzwEm4veO7qqJGGYqji07/SSnqeuJF+ZTpzuVUS7VmhpbHyIBBZMAZ4gsOzd9oLz8IwfFGnFs/0OA5F9Jn6piSew86rRWjIlbhnUyIpbL+UOlB/Q5MtkQZGWCGkhTqXfu1/UZ89fv0UR5nE3j8eScYUo0L7azB8/NXXooyk8uJl7jKStgdT0LfHdLbXDKVLd1NzLVfd3sXkStARAI0ReisX50Tx0W8TPee5+6CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4RkpMXjUsVHbhuS5yRmi/zkP4AlYDmW+qwx+tnIniU=;
 b=FG+mcyGebm/QRi60iigOq1q1Ebr38+PbO3PXWo9yNsDShBc9hEPdAonliBBUj3eYgxE0mISfEnw1Fmig9p0Ov+KM7QvJ523+VmbYid67pomr3RytE3hmVcCmVEV+oBERLkMNMpZZCIq/tWGnWSIVLm7MjMhe9kmUzz8L6n4Sblg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5546.namprd10.prod.outlook.com (2603:10b6:510:d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Mon, 3 Jan
 2022 21:28:37 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%5]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 21:28:37 +0000
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Douglas Gilbert <dgilbert@interlog.com>,
        Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Nix <nix@esperi.org.uk>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] scsi: Set allocation length to 255 for ATA
 Information VPD page
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tuek347m.fsf@ca-mkp.ca.oracle.com>
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk>
        <alpine.DEB.2.21.2201020030130.56863@angie.orcam.me.uk>
        <d9eaa1f8-7abb-645b-d624-5069205c6983@interlog.com>
        <alpine.DEB.2.21.2201032017290.56863@angie.orcam.me.uk>
Date:   Mon, 03 Jan 2022 16:28:35 -0500
In-Reply-To: <alpine.DEB.2.21.2201032017290.56863@angie.orcam.me.uk> (Maciej
        W. Rozycki's message of "Mon, 3 Jan 2022 21:06:15 +0000 (GMT)")
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0323.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c73e4790-11a4-473b-6150-08d9cf0000cd
X-MS-TrafficTypeDiagnostic: PH0PR10MB5546:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB554662772E6168AE0E81116F8E499@PH0PR10MB5546.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0D8ZTi/xoRFSe60ygjdehxnNEKYC20URY63LvGXzoLD6/6ErCSTBv4QrKPrudVXrZgHYlShynF5LdNMkejrczImqz1a9dmsdn/88PEmQiSERX/er4+jHNZ/C90wI2JS5R3o8GjXHMx0MOoKd34MiGabl/z01aY1AroYOtYBaHAZwnYeTEPjPxzqWbCUcFNSjIm5GniMLUIcY41zEx98u3gE7aZCd8BWWu9WCd3AlX0PJHJ1yCiR1lpBOW2y3RNuf4CMm8c0IDPSnP24gTGMOIDZnEs2qSiatI19mpz6hdMPEAsmJD6xXAFJjOk0ST5WNg7W8qRsyGWcTmNtCu0NobxiDvDjGf8u1vVtnR0iEtjbYnVzvoeT2Ku5dHMQF7ZimUpibLEyee9+0uCD4yGkRPfpEG0VK03Aac/yIuCDOIfCLY0ZsrIeClGCNXsijS8qaHFnFLTEnYp0/CR9Zb63z3a/MW/kIHjhodK61VcSXRi8l5TIHu78i+84bo6YXSllUaSYNfXirBcJK/R0n/KTBLtZ0ItIL3MZLkfJ55DtQz4UVwKcBDckpHtIPRMki8qagYOJYF4wpUJ7vRWvm6YNW/ygJy9+GU288dR7tYJbEJQP04LRumwJprBTPTBX8Qm02RA5VRBlrrHlF7SS+YoDdWgrpFiuKpms+T+bMzdK8mXAYxOeAypGXGUYjS9yI74+J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(66476007)(5660300002)(38350700002)(6486002)(52116002)(66946007)(6916009)(2906002)(316002)(66556008)(186003)(8676002)(4326008)(8936002)(36916002)(83380400001)(54906003)(508600001)(6506007)(26005)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z5Diz9RsfgvhZiFmr5UGVN2H7bhZeO8QDnKHN0AlqwoDiRNAj64BtmqmQHUJ?=
 =?us-ascii?Q?jelfQFAafceoRqsBpTGHC+EKkcoCrEp9C6pJawaB84S7xPKK2WuLW3DaNHeI?=
 =?us-ascii?Q?0nW3ARwvU62kxMNXOuszqgbX5ZyMwa/Fhh/AgMu/4RCC3WZD8ujEJuowEYEy?=
 =?us-ascii?Q?W5cN5X03fj9U5Dctd00ecRTF3vcVWM97iQMMdeaJska9m75cSKc2u/toTR/g?=
 =?us-ascii?Q?+bzy0KK7Lu6cYJvfY/BvQv4ZYpdd7e1aJAP/LoeagvY9DMMbu5ChBRc6P16c?=
 =?us-ascii?Q?5CJdpkwrJIsJerZGgbsFChKCMLA1vBybBed8lwjYKgVpo293jwnqpmvvD5St?=
 =?us-ascii?Q?uKkyr+89RliK9p4MXLZmn9gy7lwwTKKg0s7YZM4hMgAqO68Ljz/EIRvKZ5TI?=
 =?us-ascii?Q?ywsBWmluU+HI8dWTydYSYanFhk0KJs8Tp97CEhcnBCne+Kxb6nfIg1ivxzJa?=
 =?us-ascii?Q?gBxy55vbmB1U07VQqMf8Ru3o/aMsi9uXn3DecWJAmFL4b1qHpekTgAJlyRaU?=
 =?us-ascii?Q?HMNbOXFBRJE0l7sMkbfg5YPauv5TU0bismH3KD/n5Sx45TPRr9rOaiNvgdiz?=
 =?us-ascii?Q?D4VRHFmcRa7Tqi9PpWl0HA24IY36u+CLtNwcM74KjOVNuux2hG5lIaOMwZtS?=
 =?us-ascii?Q?13uIyOLJOtGh/JEP5MxefANRN9oaiL138PfJgdsrifx8ZbftYFIfRqpF34gE?=
 =?us-ascii?Q?WT3cQdwll0psIPIi/ZaYjjiCF0ybisiNB0cN7A8iy2/A3DjzWq/oMrpP3U5J?=
 =?us-ascii?Q?BdQTY67M0bF4zWMIWCh4XApLzMklvBmwh3bXO8DYz7KiJdqy/j4LttaNIRZm?=
 =?us-ascii?Q?pJRrT2lX8QVHl0Jc6LEC3QuGmwWEnlWjVhGRcbBvvM8SXBr8vJVn/uu7vYZ8?=
 =?us-ascii?Q?q2W9NXkIE4yI20dSk5OiVU74o9k0GVxqXAbQrLhXVBplEpyGSfp5hmcASmnq?=
 =?us-ascii?Q?bJX0MK2j4fhk/8AepCzelgbHDhD6Q6+rfIhbc5kzkBd4mDek9BQOfeDYNwkG?=
 =?us-ascii?Q?ZiGYKflcMmrnNyMuKlnex1Ue6cWoxfBT3U+ctkIq1oCRfZSp9Xvk63OyIoQh?=
 =?us-ascii?Q?Bb+kRP53pxyVfFcbbw7vya+y6pAi0NoC8tDzpm0ehlbhbZYZPKS/Q4QpXIam?=
 =?us-ascii?Q?1DcTPy0jNbeLs6jEMSWrCSLJHFzspv13u7DIsQl6Xa3GEoBlY9sw5Z+eFESM?=
 =?us-ascii?Q?cSkpvsdOYi8WYLX89rLhPdd+b3c5I4x19R/caJ/b/NK6vBOsiRkq/TVUyQL4?=
 =?us-ascii?Q?eIGuL6CxeERJfKuyRdoTlT+3O2YdGKw7tLXE6TUFlfvlN/OecjM5K74yKqV+?=
 =?us-ascii?Q?FiVn3TlnIpU5W7WmvVQ01VdjpsaFcg2+/Rb7o6eyt7OgiAkv31DGTK2sF6Fq?=
 =?us-ascii?Q?vflcKM8MsOr3NNMad+100qHTED+72B6dQcNgq1JgCc6zQofUh0fwR64idgL/?=
 =?us-ascii?Q?qwvKuo/ia1ch2+W6SNF9U3mehEfc+GRbVQnoUAatL5OBe05zOQsFzlUltfo2?=
 =?us-ascii?Q?VeFIj/b/qK6EkYrSqiFDckOdU3eaGzkHLnKUAogQOdmJhqMcPTmMYfn0gG44?=
 =?us-ascii?Q?A8bM73XBdWZQoqpSlNbKR8WmK57IAD1dse6GroqpgNuOnN+UWzy7tNrGg8IO?=
 =?us-ascii?Q?xfDbBMtdFLEAjmuN6LtZNd7gN3Tfztmi0hM4Ty8rTVL8rgH+IYntoEG6NzT5?=
 =?us-ascii?Q?SxUDZQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73e4790-11a4-473b-6150-08d9cf0000cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 21:28:37.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdfQMMubgrBCaXX1SzM7N+6CfhD4Qva0h3mJWHkgZdGGWRjGvCSsNZ4hXhc+ziLKCYj50/PG1R+A2b86zh4WvdysP4ucBXlDSzWtsfvIGEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5546
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030146
X-Proofpoint-GUID: A48rVuAr4rY1BqYxPbOeQmlq-eTffZbS
X-Proofpoint-ORIG-GUID: A48rVuAr4rY1BqYxPbOeQmlq-eTffZbS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Maciej,

>  So I do have all the reasons to conclude this value has indeed been 
> arbitrarily chosen, don't I?

The SAT spec defines the contents of the first part of the page. The
trailing 512 bytes are defined in the ATA spec.

> If you insist that the value of 64 stay, then please come up with a
> suitable macro name to define along with SCSI_VPD_PG_LEN that reflects
> the meaning of 64 in this context and I'll be happy to update 3/3
> accordingly, but please explain why the value of 64 is any better than
> 255 here and the inconsistency with the buffer size justified.

Can please you try the following patch?

-- 
Martin K. Petersen	Oracle Linux Engineering

Subject: [PATCH] scsi: core: Request VPD page header before fetching full page

We currently default to 255 bytes when fetching for VPD pages during
discovery. However, we have had a few devices that are known to wedge if
the requested buffer exceeds a certain size. See commit af73623f5f10
("[SCSI] sd: Reduce buffer size for vpd request") which works around one
example of this problem in the SCSI disk driver.

With commit d188b0675b21 ("scsi: core: Add sysfs attributes for VPD pages
0h and 89h") we now risk triggering the same issue in the generic midlayer
code.

The problem with the ATA VPD page in particular is that the SCSI portion of
the page is trailed by 512 bytes of verbatim ATA Identify Device
information.  However, not all controllers actually provide the additional
512 bytes and will lock up if one asks for more than the 64 bytes
containing the SCSI protocol fields.

Instead of picking a new, somewhat arbitrary, number of bytes for the
default VPD buffer size, first fetch the 4-byte header for each page. The
header contains the size of the page as far as the device is concerned. Use
this reported size to allocate the permanent VPD buffer and then proceed to
fetch the full page up to a 1K limit.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Fixes: d188b0675b21 ("scsi: core: Add sysfs attributes for VPD pages 0h and 89h")

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 211aace69c22..d45c4d7526d5 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -384,7 +384,13 @@ EXPORT_SYMBOL_GPL(scsi_get_vpd_page);
 static struct scsi_vpd *scsi_get_vpd_buf(struct scsi_device *sdev, u8 page)
 {
 	struct scsi_vpd *vpd_buf;
-	int vpd_len = SCSI_VPD_PG_LEN, result;
+	int vpd_len, result;
+	unsigned char vpd_header[SCSI_VPD_HEADER_SIZE];
+
+	result = scsi_vpd_inquiry(sdev, vpd_header, page, SCSI_VPD_HEADER_SIZE);
+	if (result < SCSI_VPD_HEADER_SIZE || result > SCSI_VPD_MAX_SIZE)
+		return NULL;
+	vpd_len = result;
 
 retry_pg:
 	vpd_buf = kmalloc(sizeof(*vpd_buf) + vpd_len, GFP_KERNEL);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index d1c6fc83b1e3..6d6c44e8da08 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -100,6 +100,11 @@ struct scsi_vpd {
 	unsigned char	data[];
 };
 
+enum scsi_vpd_parameters {
+	SCSI_VPD_HEADER_SIZE = 4,
+	SCSI_VPD_MAX_SIZE = 1024,
+};
+
 struct scsi_device {
 	struct Scsi_Host *host;
 	struct request_queue *request_queue;
@@ -141,7 +146,6 @@ struct scsi_device {
 	const char * model;		/* ... after scan; point to static string */
 	const char * rev;		/* ... "nullnullnullnull" before scan */
 
-#define SCSI_VPD_PG_LEN                255
 	struct scsi_vpd __rcu *vpd_pg0;
 	struct scsi_vpd __rcu *vpd_pg83;
 	struct scsi_vpd __rcu *vpd_pg80;
