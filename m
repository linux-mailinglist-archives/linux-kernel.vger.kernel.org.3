Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA864A51C6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381161AbiAaVmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:42:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21160 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381147AbiAaVku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:40:50 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VI9UfS010613;
        Mon, 31 Jan 2022 21:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=uwjYoiw4pZf1ba7uaNK0kOCeorISaCJVLeO8sdLdZSA=;
 b=cPe2DiyPyNQBLWFawyCl6an6sZFnDQv3syUZ054Fk1mkgFF6WgjEXtmOOP87Q8L54g1w
 bie8hNsd8Xg5kwsm+MdrNaHl4uK0wBuD9yYWiRR1Aa4OmDWm+c4duqcH6mR6vevfaSoO
 NYBRYyy9ErT9tV6j3kInkdQKQGNMrFRiL7dbm//9I7DO1+Y6/HcB7MVEskugxuBTwFyG
 eh0KZWz+YC9n7OB0I4Pqae9CLrJW2/A8oAkK6PU5lD5KnWnCiyi+/fg7++VR7NZDlP+7
 1xx3SnShaSKzqqBYXG3VbJnNKQ1it4wXS+6mmrUeJOElmWzTT4/JidGAykmkRJWv5ikZ /w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjats31s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 21:40:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VLbK5I067838;
        Mon, 31 Jan 2022 21:40:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 3dvtpxv07c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 21:40:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STJtyKcr4j4AactFlyLNxjrC6KFydNfuq1WCZMJpJFHK9yh6QvfMquvMTTX4GTn4+a1BLm5wZdoGSC5Q3Nd6C/EGu0h7Z7aJfw6rDdmJND5VfCvlFAHKayj+1IjIkmsGdezl2Ex/DPvHzZpnbIj00jbsDHWLDmxwcP0iZEQJ69a2daGE1l5I7C67GJuPj84WEsVSe3ynUFYGYZqFQiQ+fq6gYaAaj4ERJrkp0BjsdWlgBqqRDsEIq+CIr8gLj760lwCtdDdeuKhYVtRMOQcv4bqM95IT4Era2EEVuuFDdTvA8LZxB5UuIZDDFKEnJH2zhjMY+u4zxS96Xy3DLrFFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwjYoiw4pZf1ba7uaNK0kOCeorISaCJVLeO8sdLdZSA=;
 b=fnjLVihlwv+33KtEhxVmNz3nwpsVOm4OYUecTrwOkYXs+zA2UkTGHiOAXPpz94TWpwWlbqowHN9sJ6oVNlG117olfh9DwF/GAeovWsXED6zwmHGXPwnVUoEAx0Cijs2yGvOXA+5fPeMJ7bZ/CWvv5KaaOsfJdmcmwoXKi1qSYzMKLO5HsBdPUJ93sqqm/dQeqLOkWf9UEXsROpEc60cPRE939Cej7PCDG7HAG5nTI91GbQRPMk9XOIz4k6D9aPUsaqvUtJBpSNLLsAXyDdvYGVYloeaGrmR+ybVu/uOhQHNU+FVqlJ7IfQ/Sav8WBWPff7ym5FHJT3PT+npoFxU7eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwjYoiw4pZf1ba7uaNK0kOCeorISaCJVLeO8sdLdZSA=;
 b=atohdULIeI0ZBpxM2c+nvsztC4AH/aGDqWo/dCAUfHDam3wBu8V03EpPrfeSRaWlGlJlEOfZHW0PucfnnvQ8PbK4oQkascsBdVJ2mnHx1YiilPSJJzatGasdE0Zb/tNKeB2EvvcXnMUGcP0p2Sy1uY5f3q9KVJHjX2LqB13+4MM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH2PR10MB3973.namprd10.prod.outlook.com (2603:10b6:610:11::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Mon, 31 Jan
 2022 21:40:32 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3%9]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 21:40:32 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>,
        <Ajish.Koshy@microchip.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Viswas.G@microchip.com>,
        <chenxiang66@hisilicon.com>
Subject: Re: [PATCH 0/3] scsi: pm8001: Documentation and use-after-free fixes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11r0na8jg.fsf@ca-mkp.ca.oracle.com>
References: <1643289172-165636-1-git-send-email-john.garry@huawei.com>
Date:   Mon, 31 Jan 2022 16:40:30 -0500
In-Reply-To: <1643289172-165636-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Thu, 27 Jan 2022 21:12:49 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::9) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d84706b1-f49c-4575-e3bf-08d9e5024ebc
X-MS-TrafficTypeDiagnostic: CH2PR10MB3973:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB397311C58A91DC9B224069398E259@CH2PR10MB3973.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQhY9qiKGi+NjbzhCGWMrVyaMcdrDr+6LHMfem2foExMnoQl9KBKzwfoPsQl0McMfVVuGBHRU+pmzetnCDyFe1GFlwit77gcfeS/VF6om5S6Hr3sd6T+BYkga1sqEUaT4BxFb+f3ftYe7beo1mlMklHKve7MsuoEORgWPXbsnD7/2KZgnqBCCJiDkxZLHmhKLlKfzmMmjEmvqyC78RCvJH57jftEKRICEUY90x8MtsSDDuM3BWddddjYlhU8G7+GM5/YrmT3yJ4qewv7dKXRt3AibXIzk7CSiZcofAZnV79BJs3IwbBQG4WrPho/NZ5kdiw46O9Ta0Qm1u07xBYGvVWRjKOy9xQYkViVzSLBQ58P1nPc1IM3xvJU81rhSAG8llw6cnJM90097xvMt+bdQDROzXWHyFa5EqGnrHyAb67FgxK6/5ajsUEyLZYYn29/Z8lPa/Xfx7Ae+AdeQ8PHBb/ddM8Dt10jlMSojjuz5edsP17MwUgFwMKl16Cwi8zezRvigyPESpJjSBmxg5Q95kWLj8DpFUaPvTahTq2hKEb4aF0q7oldgCVDv4vSE2Ocda+BDWaETWJfZuc4QmfHTCpYo8fOCFfDl4g0VlmfksaGK/fp2aB57/a9qoSE697VpQWjmQ8z23IF7MObGy3KjKX8yyqkoN4tFeher5G7E3sg+hfjSeGaJlUiPAMewNI3NjS9Z8JO5YdTjEOzSp3ExQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(38350700002)(6486002)(66556008)(66476007)(6916009)(54906003)(508600001)(316002)(66946007)(558084003)(52116002)(83380400001)(86362001)(36916002)(6506007)(6512007)(4326008)(8936002)(8676002)(26005)(186003)(5660300002)(2906002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3H0VJnW7GsuFEp8zkxrDYp3VLN8A6Z70Gz+X4rS7xl+yfpNxKjGqqkmw6PF3?=
 =?us-ascii?Q?5v7hR50W9cSzObFkQ33VWm0F/DmbDBwBEzHC/mNE7Krkkg4QBUhnFa7R5ZLv?=
 =?us-ascii?Q?jCvNL9d7llZqExBtlZp0hdC6GkpNLgeOYk3mlBvR6XlMJMF2Jy8UFN6tSBUW?=
 =?us-ascii?Q?mptUNyRiGWaUYuCX/vnsCb2drsIGbGjJHnyhUmOtloyXWAEMc6aHbAUo2s+B?=
 =?us-ascii?Q?D31BSCSXUvziPNtATJCroL23giJH8u1eRgM5S1Gtwx/oCY657Ay5ldbFBFsX?=
 =?us-ascii?Q?s5ZdGODTh/0cCMoC58DFwtqbwsvgIJ0ibwJCrV4Jn6kt7RIZjqiNF4tsVGoE?=
 =?us-ascii?Q?yRsiRzDOq6mWQn4VVRBwM3fetZGmlKCqUMS7BosiEyIdYQR86RfY8jjeCTA1?=
 =?us-ascii?Q?pYga7VzPxdwkOf5FDfbtnTuEuUC7RCBBWdjRO0MkP7JKSQWwtEhhLu/qS4Ju?=
 =?us-ascii?Q?z33zAdOrPVcSdzhaAgo+00kQXudaBjiMksquys6grd1FmAPyf967iLiHiH0b?=
 =?us-ascii?Q?zI6Nfyfehee0KweoJQlaKbDmEz/rP3RyOWf+ntb8Yz9u0maP+IxjHJ1OavHw?=
 =?us-ascii?Q?y72NcJ76FX5A1MufZelbK1UHugSF+EUWJzjTVb6wDTbnSjI23SDK8fllux7e?=
 =?us-ascii?Q?Ze63z7JQ0M9fPAHfawQ9UNrPtsYwDt1GnH3kak+Bia5qExBaYhnd8dvTf8Qw?=
 =?us-ascii?Q?sjSIVoXqsvCDzM143+jWTRVlMuoI2GA2gKs8TZDzLa7ykSfsnmt7Za3w2zQZ?=
 =?us-ascii?Q?v2WEFdiC1jV8jih4+LY4P9U8CXJ3JkQSHWsogXcCNz/Hhgr3Ey88haEYZ3BW?=
 =?us-ascii?Q?wnDtZNWFOGCFzAA5uyKzvJK6NLx5zGH+Y1W0nO/2USJgmey2CCEe0bEqSVeR?=
 =?us-ascii?Q?eCBhgxB+COv2HuDx/ex/3Rqx+4JsBTkTiCLKrme9P7KzZuUYqE+GWjytULhq?=
 =?us-ascii?Q?qW7MiVB7BjsXnrIz98Pv66HNocdiWPmqoS8CGcsbw5WQtA/Vm/6zbdZnDIEc?=
 =?us-ascii?Q?xY3Vf780z4FCGqlFanZMEvuUKtCtBXgUQYXtS72Lb4lsznAjATLhZgqhA/bx?=
 =?us-ascii?Q?/11uQu0pfNE4u1rQPPvWIgBjhRKxaqvNZhc3u9vx+r/iVLuEgEES17HPafze?=
 =?us-ascii?Q?E8dVX5WAoDQrDoBqyw8ZpPK4nzAyb+yvuSmZVd+jfiOw/K2e6A9paoIEv805?=
 =?us-ascii?Q?iXbsaOVypW9LEG3+HOhsF+JtbIEQm8DrG5cU++QMewrZrEd4WtbRvQkF3/FA?=
 =?us-ascii?Q?5DzCk54UlBmbPM3Fr+u22hgxUWctFQicyeC+dYy0shRS5V82AI+PccZcu1su?=
 =?us-ascii?Q?KB66kLSWTWknd6/cO0Gm9cUMnUgACupBLX1x79yd9O4/Mh1rryRVTmvAQyI7?=
 =?us-ascii?Q?gnduV1eReWUTDpp5xU0jBnZxNr5KrBf5LtOwjQGIIOPxJ6X2TYZIluOYKf5d?=
 =?us-ascii?Q?oMpSpqf5OC56K9ofORnTq7SDvPwPjNIL5lOa8MkW0l/5yWzW2MmDoxuXCW1w?=
 =?us-ascii?Q?lRs9LZ9j+hg51Bar9sQwacezEGYhfscpl48SiXG0aqEUEMX8n0xu97iJcgks?=
 =?us-ascii?Q?DI3FDraQ8y8Qbp85MDWQj0meWqYuvE4aL8k9dRJx6noF0ygDyLB3zbblNxMb?=
 =?us-ascii?Q?UnFS5cjZpaLMcZz1fhU9QQYKhUg2LA9Yd0bVMC0VBzLl5nNm4x0g4jglmTRr?=
 =?us-ascii?Q?GxAX5g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84706b1-f49c-4575-e3bf-08d9e5024ebc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 21:40:32.5208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KC7/YfULF3yvgPrXZG+YBNBi7FmUmTj3siRAsdQaKlNbks4ix0v6qsgPoTYlwa6cmGy8XR87zv9A4Zy+ljDBpLWBMJD9KVqqDwXeNXhzkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3973
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=752
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310137
X-Proofpoint-GUID: MtPhtEbTpVrIQRtPZ7YsAo43xWVbFD4c
X-Proofpoint-ORIG-GUID: MtPhtEbTpVrIQRtPZ7YsAo43xWVbFD4c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> A few fixes:
> - Remedy make W=1 warning for undescribed param
> - 2x use-after-free fixes for these KASAN warnings:

Applied to 5.17/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
