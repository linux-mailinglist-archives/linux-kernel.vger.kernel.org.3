Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B101F4A51CF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381144AbiAaVpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:45:33 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51168 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232398AbiAaVpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:45:30 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VLeegX010613;
        Mon, 31 Jan 2022 21:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=QQJVJzm4LrrX/jfSojG8zcZYAu9WmKucGUMipPcLL/Y=;
 b=1KTeVhSbbJBnOrQqlYry+5bRF03HiinTWG5LnfWQkQKy2d89b36FiImLTzt1EHm9G069
 sqPF/YNQ4VNCQS1s/S4EZgS1ijYFk0Cv9aSLIArKSYhWCFuZTMP6tSRhKwV3GlysSPuT
 D2BMOQAcVVTuAe9Cj9hSXhWkQmqOaeMgraDqxRjB7Jisp8hN1tOUH/lvnEChigFTNOox
 W6YSv45ZxoDlMFyx/zu7/FDxOLwqMs/ZzrkpRzyrf3OdO/ZxTZtsVj07EH+8DN3BHPSx
 IDBYRLn3qJcH0XThirBMJe3UJcRbxc5PwHu1q3OSPaseBdumgGLFkTWaC0UzNzBATmuV Vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjats3b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 21:45:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VLj6vo112011;
        Mon, 31 Jan 2022 21:45:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3020.oracle.com with ESMTP id 3dvwd50qx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 21:45:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajgpZG6yEKRqsOiVAoAyZgVlh2RoifhIVN2pXKtemUUMcStIIDRA77w/zGVGqmYH+YREcUhnYARx7bugvv3WAj/VjSQj1nR4Ch2VmC3hmX58x0OZpq4eeUihTsbtpJYGp6XzCUFjAFes1kkV7EeaElt2Q1bAhkFMoiHBRO5AbQgXw/oCvxr5ZmSQVklKWsFCGD8eWqmfy9+lHkqxAizgfpIqgyXeKavogCiuP0nV/uA3bQLlgOT2aFrhzRmafazWjOeDaCWSt5lOBWuqafM+TEHYQf/xC0YAlN9K2Z4naXqjFfmdUFkaTtM+UhNvYGT0OUxdCEHWW2ps5kAkrTBNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQJVJzm4LrrX/jfSojG8zcZYAu9WmKucGUMipPcLL/Y=;
 b=GzQqgGSPmbUJQ46RpFL0PW4wgewB8jjx4ISsq5TtRjFG1u8ROK4IVsRXAGqcokn0DqylJHQX8i0yxSehaWdXAezsvTGy9HySRiaYzRN34xXaULpHnfkn1MNRougJGd7fUtPOPceKx2+WPm2tceE7s128hlxsXmhHT/4ql5vuU4ug3vvQgB4bP+CGMY1CO7voEUbrOkpmiRgS8gxZGJE14aiDAAu6y1IedkIeUZQ2+RvC1bb64uYJBqTkk/1e9VRv2Pkou2lOGjZkeXlqoNdmju67toXZVmIU0sdkdpd2+oXxUKx3U9RS+IZxDHXRNjbopBVK4DJ7kDoQDiXakZj7rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQJVJzm4LrrX/jfSojG8zcZYAu9WmKucGUMipPcLL/Y=;
 b=Y3OjiOpMGeJl4kH3gCa/njsEQlJRu+lCzDCDluiiZX2CnPUT49pG1QYbwZkdgA/MiUWr5xG3U8qkfkiCnhhdM0cDjPOFB1WuoMCRssyU2Tq1Y9lwv2Crp2VzzS2ZD+cBntCehtOBaNPI2X7drjn8UqzENDffVaNM2kQ+bUje17M=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM5PR10MB1706.namprd10.prod.outlook.com (2603:10b6:4:7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Mon, 31 Jan 2022 21:45:15 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3%9]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 21:45:15 +0000
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huobean@gmail.com" <huobean@gmail.com>
Subject: Re: [PATCH RESEND] scsi: ufs: Add checking lifetime attribute for
 WriteBooster
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8xz8tr2.fsf@ca-mkp.ca.oracle.com>
References: <CGME20220126104125epcms2p50afb250190ffc3f2dc7b16df31757c94@epcms2p3>
        <1891546521.01643252701746.JavaMail.epsvc@epcpadp3>
Date:   Mon, 31 Jan 2022 16:45:12 -0500
In-Reply-To: <1891546521.01643252701746.JavaMail.epsvc@epcpadp3> (Jinyoung
        CHOI's message of "Thu, 27 Jan 2022 12:00:25 +0900")
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:208:2d::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44abf5a6-7486-48de-a144-08d9e502f718
X-MS-TrafficTypeDiagnostic: DM5PR10MB1706:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1706D659FFCC06C5448D74D68E259@DM5PR10MB1706.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Sj1uc2xC0rUjbqsC3v4TrIBbBrdf+VMBkQOPi1CG5y2NMm4nbShOxMXtNlKPPJYw/yIQpixdXNr+0pYcbX1w0S/k20olHwPxfwggQqR7mHtZ7QWMx7ctjujW9dp2RQOw14wyFvfBOPaAcWVije++YBGaGjYO1XjA09F3gsaqi200cHrnTfViyeiWrTaZKBceRGBKvV83/RI4lAAM+SNVyi8y2Et6351Uoqr8DdaJGqNfnx7QZ48wLtmvZCEPJVcgZcsLLc0fQkeNR7ZmweSGc+0w5UIYz66TsomVYTNXw7f1CbmsDeffBVY0V5/0sa0OEjr4myCmRDcNvQna1T2D8P5K1uJI+mZGYufvIkz9XUCkcosws17C/gOuLyRsjalUcLBCGQsTvbbA0SwhjT78HQbl/Ji6UUbF1zyYGWTqUewBUmESKeL9oqYvvy+2RjnKhXY2AtLEZr6SNdRY6HjLCqjAiIePJlkrW3nel7e512HH2pSHzwEiGdrP5aLR8PfkzruRtH5uAr4KQtbWw5uqAYDA2q9zmxo50QOH8iLwTZDF9s2Tl8ySjBeXtx15bFgeie3oAEZBfVAEB3ewlfOwtrZ4pSRh9GKAd3DrwfctlK3w847So+qWChfq4VXAdjYw3R5NgvW4+r36OkwBp3NGuCQQEdNbidJTW0yaW217jhxgQu19MFk0JqdmkgrP7fFFJF7pJr5dCy6AnzG2iIdpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6666004)(6512007)(7416002)(54906003)(6916009)(36916002)(26005)(5660300002)(508600001)(558084003)(186003)(316002)(52116002)(6486002)(2906002)(8676002)(86362001)(8936002)(4326008)(38100700002)(38350700002)(66476007)(66946007)(66556008)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7TcvVxeDLgB+PG3ThBBY8TCq6Zsm0iCwj0T1zBAl6FUs09HT+L6baTn4drxV?=
 =?us-ascii?Q?6XSpM4mBXG5cCMgwEYYWoM4oxElNmE14mrLEAtMoL2fxB8oMYZM7zq6nHKSC?=
 =?us-ascii?Q?C2CmLKnC6KZk5S5ctgYnRQ/GWwgNceEuQpd/X0Cal6qNOSWwZF17wGv0/aKM?=
 =?us-ascii?Q?pTvKagM/MBzxqrYqYhza05S/z8ykiRZnkqkZFOdufk5oT5I+Hhw4dW+esXjA?=
 =?us-ascii?Q?ooJKPmqimOQgNQgezM2y0GzGhAO6lguUTsTsbRfdDbchTvXVHBAeZw9GY4MM?=
 =?us-ascii?Q?yVGacg4PMaN7PKNq4j2/WPK+VnReIzsMNFw3nUQ/xHHSXWI5iatDAu2xFPBN?=
 =?us-ascii?Q?o0zH73/jSUNrjU0O6zUd6oaJHqBaO0xWvPA4TJDSg4LoxFbgE8rAC5IGqp5l?=
 =?us-ascii?Q?MHGFeghjbuPnnsqXzyPTkaPTaga7qd3tFQDQXwZ8zRdvr4L3bpNNXJY4VRLM?=
 =?us-ascii?Q?V5vc10kSW2yGncC+eBFHn/UeafAl1iOv3MbM0NBI1VIEceEx6BhmAMjFP9TL?=
 =?us-ascii?Q?bClSVu72qf47SW0Rmy9mLkiN0CP0wdqSvUScSnngr3f5fEKgLasJVasISlCf?=
 =?us-ascii?Q?FzWawfFKnzu1zSYyvKxJlVa5+TJaSp3E7VAOf5aynyqg6KbupyZCtRrH5pS+?=
 =?us-ascii?Q?Ts+lLMch+DVOmCpBYkOFGDazf/kVCThtluA86D/Rpfs5m0VsmVhkeBWIO/kT?=
 =?us-ascii?Q?qIhubp30jRf4ZUGaaeMO/jIxjC9Zn6O7+nF148aAy7cBMsTzJW2v64VU0bUv?=
 =?us-ascii?Q?cGqBlkCuPsB8VVtkWDewtXDxXogwvHboXBN1h8tpuLcStE6UU6HoynLPctlb?=
 =?us-ascii?Q?6By/y4rRHwIWerOqwkmAJAmvkFa7LSJXD4j81poIovoz2nzuxYzupPWW5Vwl?=
 =?us-ascii?Q?I9YHev9tKJlahQ7WmYQ25rRKzr/fSJo+2ZMSbciap10JPRbeA8wWPcd7nyxR?=
 =?us-ascii?Q?+dwhZbiHbLYNWNK7DMXHp70cEIkDCij3tdGLNIlDOQgWG/j2b0/AbDZPT2OR?=
 =?us-ascii?Q?D7ikRiVoPh7Qg8olczj5anvqMluOTdra+jgCPKxv5Oj+oYsPsxf+nyhFSDFz?=
 =?us-ascii?Q?r9qhuutP0baVI03s+RSOuUDfI9KpSIfz61m/5ghz9wshaGNkh4RLRP8i/NNd?=
 =?us-ascii?Q?20JBdTTDzgc1x9oGl5/utfxx/ixISZCReAHQm/YlIMIZKtEUfQxnF43tSwc7?=
 =?us-ascii?Q?KCjT4IaA8OciO5cOF+d27mGt8lzFKwg0hOaTPHkqiV3Mm9IPsPjSXKBaZoHa?=
 =?us-ascii?Q?3oPqy6CMSTHsp5GeitLBoSuyjZuRluFWcbuFW8ztB2EGl3lR+z3yuLCIeW6E?=
 =?us-ascii?Q?I0Zmhyu68T8SQs3xSi4310nBLloPmHRr2qejIRMmdTi/T7Wxwg1boZqp3lnf?=
 =?us-ascii?Q?9TtmLdqbJ0lDVVNprYBL56Dr96DiVlcIwolzYxOwa3P5xDHqKtSFjL3Uodtq?=
 =?us-ascii?Q?PwvIYXHBVJs5WK4oSTQu30iSjyJngGBBRZz/IPG2QZgP+S4l2DLwb+UGSqhj?=
 =?us-ascii?Q?nGUr8WinNI/tNlAZ6C88LH1j3xYS4IX3D51vXxPimOZ7ISAd2FGdcNJWGW6j?=
 =?us-ascii?Q?CbQnopZJaPpH+msgCtggeVnuzQMXlzk7GGY7x2/zO8vppWToutKBmpFXo5By?=
 =?us-ascii?Q?HBdrUvY2EIF5wkkF2QgUzleMPrDWna7Z7xYCmkaJ8oABV0dweJGNIs5GWc3/?=
 =?us-ascii?Q?0fTiWw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44abf5a6-7486-48de-a144-08d9e502f718
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 21:45:14.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tFfccW8rg+aYur7tH0vE+xJic8AoN+XsY4dpQDDsVXpSVw6gvfJPhU2yFGBW7Fmd3M6nwjrvR4gs9xr26dKib0NaJzpCAA1ls6bTuuCRIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1706
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=684 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310138
X-Proofpoint-GUID: D9liihkn1FWuOoOntu9tlncoV84zdogF
X-Proofpoint-ORIG-GUID: D9liihkn1FWuOoOntu9tlncoV84zdogF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jinyoung,

> Because WB performs write in SLC mode, it is difficult to use WB
> infinitely.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
