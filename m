Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F78485F94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 05:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiAFENx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 23:13:53 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2062 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232228AbiAFENv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 23:13:51 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205N504D009819;
        Thu, 6 Jan 2022 04:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=qrPZjOZsQGGb3jXZ9pR5oZCJNJNE0oUCh/dFWQpTJJo=;
 b=kozaveN2qpTmJs8ULhDRaYATJB0z3SqY6vFOuVyv/C4oaSHy2uiylVjwu6xpCoHVGZpc
 lRV06AE8U4v6lSXhv6P7dOr2j8/94+CgZHWBdDRCQWBlWnnbBlodGLR/ZjSP8cX3F2cS
 BWprJ4dzcRYE2BMUMnK+YMDZ1BRdtLQS5LZlTr6Zp9hYlacTBInhNRMkXP1GLNGDue+0
 /rMdcMiiMT/Y+i0w2YOtP2ZdP+Pcp0C+JKoofm40Wel7U0eiRwAlBFpoP/P0tr/ILwq5
 liQTP+wRmsRkGC89ge5EDC7snxUmTiz/0GYOmY2MHv+vqnTupy+AaJfIfQS1w+JyWUAn /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpp8d5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 04:13:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2064BnfA041084;
        Thu, 6 Jan 2022 04:13:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3030.oracle.com with ESMTP id 3ddmqc4131-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 04:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2pU7itpueiM4G6exC6muAMOGH0KfKK72xzy9RIBveyU1GHO2jbzUgHzrSOwhuRVFNaCcQrFPJcdIuE6YaIm+4UGX61Yex7FpLOLFjO7ARzJ444TpUPRy+nlNG0+tEXu32XY+R28rEz6mOHrf7hQ/HnfbQAyIy2tQj8AFUkNpEAON3BA4cp1de7H2geB8EgHyOfU+BpE+A6kNAae7xMPwGm6mlSDIhzx2eMqNpWFduMgnmNDsW4s1oa5XDA5Q8EaPlo5TcQJDS4Y8iHYi3Y751p6wXLg6QwZKsyhy83FeXsC2tPScAaDAytJ/EBiKRG67cLYUIyi4OhL01BGKsSnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrPZjOZsQGGb3jXZ9pR5oZCJNJNE0oUCh/dFWQpTJJo=;
 b=dU6RA2V33eVZuAMBykt9tNXoZCVcbg4050CvUoZQ2pQs972hxRnisdr4Re6vvIhblowNcfn3IVVJyZNRLa37V8I7IbMdm5WhQbZXza5rkv4g+ijBTBiLamQ2L61mah3tpr71xrIZrAFQ2pc8NxiIWDnl9uTjSCnp06QCNB/Y9hnKpFS+ZjLw36re/XG6ReC6Fh2QRiGhV9krS72+v9Dv+y/glp3wUkv2kD9nTxI/Th9Ox5C3Cwwp0xz4zXroPenNz+cvBLlyGyClz/X5OmvPHfTOChtXKdp0vZ2ED/jB9mlKBZ96tPI5lyGqVJ+g6+wfOuwCOQmm6hlsLEfjs2oFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrPZjOZsQGGb3jXZ9pR5oZCJNJNE0oUCh/dFWQpTJJo=;
 b=a7x/2YgIgL5P91fb+PH1SWAvNBtKEPRPV86SZh3pCUjrfVpvm1letsDgTQpIh8ML6iQFhpAb9Ko7fDat0xiQ/8Tb3ijpCDQeRaXQ/XAGIlx76xnT46KyypfP0rg61lWR9SnMh8Z6IsXBe2uQOTktsqc1NWxFyIj9K82LS3aSgb4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5683.namprd10.prod.outlook.com (2603:10b6:510:148::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 04:13:36 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%5]) with mapi id 15.20.4844.017; Thu, 6 Jan 2022
 04:13:36 +0000
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Douglas Gilbert <dgilbert@interlog.com>,
        Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Nix <nix@esperi.org.uk>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] scsi: Set allocation length to 255 for ATA
 Information VPD page
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lezty169.fsf@ca-mkp.ca.oracle.com>
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk>
        <alpine.DEB.2.21.2201020030130.56863@angie.orcam.me.uk>
        <d9eaa1f8-7abb-645b-d624-5069205c6983@interlog.com>
        <alpine.DEB.2.21.2201032017290.56863@angie.orcam.me.uk>
        <yq1tuek347m.fsf@ca-mkp.ca.oracle.com>
        <alpine.DEB.2.21.2201032324230.56863@angie.orcam.me.uk>
        <yq1tuej1j22.fsf@ca-mkp.ca.oracle.com>
Date:   Wed, 05 Jan 2022 23:13:34 -0500
In-Reply-To: <yq1tuej1j22.fsf@ca-mkp.ca.oracle.com> (Martin K. Petersen's
        message of "Tue, 04 Jan 2022 12:57:22 -0500")
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:208:2be::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af87e8d6-dbda-44eb-9343-08d9d0cae952
X-MS-TrafficTypeDiagnostic: PH0PR10MB5683:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB56837620AF9C56015E8C17008E4C9@PH0PR10MB5683.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78WQ6sNUYbbU+DkeT1GYx7zgR17NDivQhp1vlbcTNjh8OMDWGEJFX4nsPRIXh8gKaku88lGqckVav/Ou5zu32mCCMKly0XfQWWT4Bf/M+l6N19Pcn9A9RFY0rWzENR2I+tQTYiGrC50hQTfS3X5xTGonS+rA8TRha48Lvhbdd0EWHLFqDRaLpUMI0Cv3/AGBHRA9LVr1WgAsorNXYtNHrlVlwQOKI1UAZg/uQAmSGFqb2Y56J0eT4ajVvjnoMdfGTER31vYB29zQeLc3V5KnCw4aj4io5sKTh2X6MN6O4MvLT4uxaDK9w/fX5guJ9GyPP0X+sNZOtsaOdtlhOARn5BtAKh6m8wV2XvXX5shaYQF39gNh1WwWfOZKW7rl1npK6tB4w9FoVIsyiSCCSKXPRUJParGKxq7ISeD8fLVD4h4S5GcwXnKXosiZGS6GJBjnWaVySlPBwrys1Ft6ejlJ6LanA/qccRN0z/dZPo+/zR/H95t3+2I8mv/bXQ81I7ru930ntxG33XXwuSrGSLQK497/qRHg3XOxE1VzNH7xOIEyouqulxfzGyv5/By6Ez9dmYaofe+9dHoajIZ0rYhHGAYcdwnRq01f6tEAWwVq7vB/Y3AMXHz4H01H/kiYExERn9JDL21SSY+SJYaCIl8WWO/gjbB/0eavopL+FxOuHl+nBeXljWHpHVusdOibky9VbigElhmouUadHWbGvgI9uXIQbLzNXffbHIx9EFjaLSaOwqTDfMAH+YDaWjcgdD6m6Wrqd+sYFbH/hJ2KweZBAlevKg5GEqiVd5cfZLGKtrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36916002)(6506007)(38350700002)(186003)(26005)(52116002)(966005)(8676002)(508600001)(4744005)(8936002)(2906002)(54906003)(86362001)(4326008)(5660300002)(66556008)(66946007)(66476007)(6512007)(6486002)(316002)(6916009)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ro5OySj/1+lIw9NjILlPQ2bAmP71oQwK0pvaBUYYOGRpnNif8BGLwMbYPi0?=
 =?us-ascii?Q?bip33bKJi16t8NDQ06luCE1qfNDjw1x+/UL9ROROwcln3Mzkl7OjeHvCUPZU?=
 =?us-ascii?Q?RAFKxHd1xcgINLWLxO5R66z+5GHQGYLD/tkxhSj7i0XheufZ5Xntw7ie6v0S?=
 =?us-ascii?Q?TnGFmqS0CP19xwoWhIJO8dEmEkg+WqERFio+1v158hvEi976Ut8tBEapIQsZ?=
 =?us-ascii?Q?CUe7AI45vmDACCdeKQ3gt+stjDhyGkYmYQVqa6Q1343Zbz8I9pRv24wZ7tOQ?=
 =?us-ascii?Q?JC0nzUujUCWtg/Q0O1qpBKJa9f6bNmgs4k2QBSOtyP1bLrrd8UN+XoMbbuKh?=
 =?us-ascii?Q?TX1OHpP7N6beDLp//gaQmvXxIBc2zq8k6L2DHr5U8u3Z4srs5YBqY78EFbjR?=
 =?us-ascii?Q?2ynDJgFq/yezSwfwau7q4MV4gvsffW11nUsImvUOt9ntkqzrG43hQ5bfmyHP?=
 =?us-ascii?Q?eH8LwoP5GwJGey86W1jihskRPku+ntMq5FH+zffuE6PaWKt9lLU37MOVhrtJ?=
 =?us-ascii?Q?8j2hsq3gL/1hb0T1XBFuOLUTr8IEyurUB0Hj0zm3O+sp55whQcUpoG00D1lg?=
 =?us-ascii?Q?GrVp8ij8GISQU1JLtyuhX8u+Q7DchD0LjTkxIIuhyW9S0QurFhHXZDH+/ymh?=
 =?us-ascii?Q?6yCamsB9uH3ZMkz/65JNZ+tcaGemBt4wkdguCIZeHub0iUrotYYKjUiinEC8?=
 =?us-ascii?Q?UwPKMPbnLXBNK2+yy8bETyVKloPvHrxKKUUs19XQsyZs0tGj26IHhMZsZvlM?=
 =?us-ascii?Q?rVVyQrTcvVBEzyQ7l+fvwAVne52488nNtNhczLYh79b22OidJTyaFJcFA+GN?=
 =?us-ascii?Q?EVojByOl5MI5J2Vye1RJbYfouGrt5wP3sqChNVfQV8PfX9zwWw3mSNHUjv9V?=
 =?us-ascii?Q?3rwxFzKl+U2Eg4m3s2w1ckaGNOjQkF96tt8E20c203djflNomNgWJGI6xRrW?=
 =?us-ascii?Q?cYi3xTMXQrR/0nvxFp/Bbg8qOzXlHvcYzUwuEqZE9LRQOG4mEnOpLnT7BERg?=
 =?us-ascii?Q?K8RcyWDK/wZpMFXqVvgU0tmcXPJqZSIdBTfskff3yBevMdvdDr/vQXuyIJBW?=
 =?us-ascii?Q?hXLxgI4HN/5ikj4McM/oySDZNAdkjBjf161kmqZFkr5sfMw1Pj935CVaaBkv?=
 =?us-ascii?Q?8Wiz3K+MjBNa+iqcjn5TlYbNP8B/Iy4K890H23n3NASkTO2wQVEzCa0itTq0?=
 =?us-ascii?Q?kRkiTHZqLcP/CR+S8Du7L91taT48V9FA01x1R1T1APUUqyFVMbEoXgCHvYSz?=
 =?us-ascii?Q?531qoZZePq0c/rHfSMAV+yxU19xMpebCe4cnDX9NJS2D456w5ue7wxWmJ/4n?=
 =?us-ascii?Q?AI6IHxuDBIy3F0MnQxxDlIaRQBUAmFcY7+1scO6OJczz/Pq3hK8KqmnoZIPH?=
 =?us-ascii?Q?2a9wExmEqwbPu1jbVFltb1JJDVLOnHiRSwXD2AxDm59IUBb3qLMNkh0tyQIK?=
 =?us-ascii?Q?LQ8eVXjcx8u8HKIByuMRs7/z3ZoRmzkGh/pWBBSCYDqtpwb/b4EQpLxCWwbV?=
 =?us-ascii?Q?XDnFOQeg+y+P8AWObdqZoXgMvPvGs8Nu6YcMMDBpwmV0rJPHF89OiJ08GK5x?=
 =?us-ascii?Q?JVSKRqOCKRM5hNu6suF1z/1cJjjjp67Yd9h9AFv5QMExrs0HfH/Bw4q9zK9S?=
 =?us-ascii?Q?o2xa3lbyZuvrMR7mOveaXrh58chtKsxWwen8TeenVL3u8BMOPMcFXfSgE+/S?=
 =?us-ascii?Q?j3KvJw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af87e8d6-dbda-44eb-9343-08d9d0cae952
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 04:13:36.7671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XNjWQMsWiMY/uHq3LqgjiqhC7re6rTR2hn94cG97x0kc2l8u6CZ0ERtSAMpUbcLw41QjRdJY1vvY3AVtOTj2fiWMXYd8tijy2TNQ3UKUeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5683
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=498 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060024
X-Proofpoint-ORIG-GUID: we6fs_iAYLcdqZ5sisLOCod83R2b6Nea
X-Proofpoint-GUID: we6fs_iAYLcdqZ5sisLOCod83R2b6Nea
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Maciej,

> Oh, you'll also need a follow-on patch that uses the cached ATA
> Information VPD page. I'll try to get my full series out today.

I would really appreciate it if you would be willing give this a whirl:

	https://git.kernel.org/mkp/h/5.18/discovery

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
