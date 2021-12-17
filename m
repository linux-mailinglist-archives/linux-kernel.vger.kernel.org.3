Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F104783CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 04:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhLQDvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 22:51:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48350 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230194AbhLQDvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 22:51:50 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BH2eXIw009323;
        Fri, 17 Dec 2021 03:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Qkzo2czHQzQTxFzu4gzimBOKe3/FjKFZmh7vJQQIlss=;
 b=egNq6ovWDTB7V+DQUKF9407626+H8mY3doKsOQAqiNCuosTwf35eYyLaKreEkbz1v5YD
 3B9RsvVthWj1WJ3RoYBRkzhtCWZL7L8GQsFxnH7KagQ+IkxOdHuKAE3PF5bZasSjVnOD
 3lLgK1h8shGRLu0SXb3GQUzQm0id9u5tcXRE9dLWSDFPEjWfYmRorpa9Z5YBiSH3nDE1
 8IANa+r/oVwb+jdxMOsnIO+cTHykb8NyaC2VEZ01LVuCK60+j2b3eHcFop1AeQhcoyMq
 KmV6gWs8OjdAtp3RhAwbEsKVBcAo9lkOl3+KrJ0mpbLA5xI02vMxVOn1o48QOB3Ruzq0 1A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknp4pqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 03:51:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BH3oinK133512;
        Fri, 17 Dec 2021 03:51:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by userp3030.oracle.com with ESMTP id 3cvh436045-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 03:51:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/vn2e4kBYOkpIH+W7C3DX9cVT0I4rEBzRil6zjqiwnE1o/pbLIGXgX4A3O6cgnko37GkG6o4DW5NAWsbTlz3yemvxyRmCOQp70mG7n/TtqZKiHnRE0f3sdlL0g/xyOyoh4Oqfdnv2ykW8oi+GHEUIk29fNowRhh7BU+otGWzhZKrxPIzEroMzw0d3sx6+QsyDQ9BcgpLhWgCvzPfOzn4MYrn2F3tIws1weZce/ZizmnU04KfEgI/cjC3gsA+smWr9mB6uGMY1j/wCv8Wud8c5jiHcPGkdPRVlyFGg6Recf6ABbhRqAYFl0ADwByQFj/t5wnYASn2rA7yL1ZUlrKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qkzo2czHQzQTxFzu4gzimBOKe3/FjKFZmh7vJQQIlss=;
 b=OiP5QHqYrcIExd+GssJmEggR158WB/0azbwITYPaayCM08N5hbpoCkVvxbCbfsNCBGSKZtzfFpx+Gpl04RPB8+Jhq/CL9BTImlctA5qqffJyGh9eRWul8YHuqgkh/g9YOFqDDLTRmwjIWKWLADfRyWvUkgCMu7PgRRCOLIvprd2Iculzfk/i5jBRdjj2xKjSo9wfqAo2Kdghzntgt8KAyNr3y89MT8kL8Z7Sgvg8WFE9yXPm0pI7eADoKJ0pOrRj0rjXu8uNa2s/UsMu/x98y1+fMm3/f/gzzQ2PihBS3OawrVHxm5a0ml1BLDw+0pco+R1qFwZMK2B/XxjSP56ixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qkzo2czHQzQTxFzu4gzimBOKe3/FjKFZmh7vJQQIlss=;
 b=sRDrCeYY/cFttUKoM2kJAKLaUEGfcWp5SdmIDrBNeD7wd9JNf6kj+i8qQlDz1Il4ieCL80R9rM+ktYPJLjx6Iz1yVsloTcTG+yOYavScw5IC57SeV4jsI+YIQLQdrXEzQ5uPp6cagMuALllcb3p9NjmFSu6sDhAp3z5o1Qey6Zc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5420.namprd10.prod.outlook.com (2603:10b6:510:d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 03:51:36 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e%8]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 03:51:36 +0000
To:     Bean Huo <huobean@gmail.com>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, YongQin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v2] scsi: ufs: Fix deadlock issue in
 ufshcd_wait_for_doorbell_clr()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rwjlwhz.fsf@ca-mkp.ca.oracle.com>
References: <20211214120537.531628-1-huobean@gmail.com>
Date:   Thu, 16 Dec 2021 22:51:34 -0500
In-Reply-To: <20211214120537.531628-1-huobean@gmail.com> (Bean Huo's message
        of "Tue, 14 Dec 2021 13:05:37 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:806:125::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 011392aa-ecbd-4690-c724-08d9c110861d
X-MS-TrafficTypeDiagnostic: PH0PR10MB5420:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB54209B583C5B779C220BDD6A8E789@PH0PR10MB5420.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CrnoE1qFeRE1738o5L4pPPoCfRBMClwab52yB+G0kes9cjFDocLiotpfDD9YTDF+58mC3sT9+QkHu/6KM/WldByv5jxInSWWs5pWs5QBDCHP2an0RIHluneCBPv/q8YZFqHi4zgfM6FjOZDM01GNRijiNaf8HvS84FtdEjDQIYa2eMBrjf//sMWppyJLtUR/qAoRqNQXdKBI4OyV2nukATsyWtAz388z3SENzAlrxIwdf5cH34kiHRQsmCIQjwnrM0KJWUArpAGH9/LEgTGtBrcbC0gFHjYJRDkzqNH1fIA1VlIpskzUk4k5WYyzqiXqS6Nckrd4PKx71ur2qZNKQfm3KNYO+SUT1BbLDbsQTvRsal7zNPnaMmZDkzUe5lqDyTXmMiNsawaApcyYamn3d+mcExItFO6EzeJR/YHxTI4dZceb83Zs8w9Swd+uEDvCb6AFk5Bun+xTbH52KzBHsqJXqp6yUlei2Uol9CIOr2CVdW0+vRK3UQB8NdA6QvUon5S2EFqayOSxwTjMIt6LTLyGGKXQ1cMJenBqjbaz+12tGIkWiSV8SY12C6G33G1NYefvNGnV6WG7UjHNmX5AaeADQU0f10yeZl4rtqww077loAsnDOxojMxyKthg6rf8IIHDKG415XdBlF1gnLNet2/SGg/jy4hIjWkavVKLvrIK2y2tztlgSr2Zu+EdwkEPEL+U2upf6WII/qKKkBPKrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(36916002)(38100700002)(6512007)(38350700002)(52116002)(2906002)(186003)(83380400001)(86362001)(5660300002)(7416002)(508600001)(6916009)(66556008)(4744005)(6506007)(8936002)(316002)(66946007)(8676002)(66476007)(26005)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fIuU2xX5OFpUiNRLJXD6ispvoWYasLo1G3k+j+pU5+r85G/JPjdKL4ZbO1T+?=
 =?us-ascii?Q?HVF7EiM6aIGQXObLWzp3wds3+qKrAX5BZYKSbtoewfMnlHI5N38NhYY0F8DQ?=
 =?us-ascii?Q?ZkahTQOU6+rvhLbkwaZWQ6wWDadTeQsspT02fp9xjsiGbhBLsVOR85dnHckD?=
 =?us-ascii?Q?LAY9EgsQMvAd4Myi1HTkTIEhkfok46+1DvxCYEIC+Vm9gqhCVo2RziT5Ipsx?=
 =?us-ascii?Q?sPlDxoAikz3CSROxQp3NMdETagfLCAgP34OcKiHAxPstcbD3we7TgY9SszDi?=
 =?us-ascii?Q?kA0nxCp5knfSp8kV+8NdiDUJw14ByUQlejh0OS85NsoMB5XAnaVtkEe10ZZ1?=
 =?us-ascii?Q?rPCiOfV97wEqsw7e23V3pcjj2B5qjN+2iEMPgItq06nJXtgkFAzW/GpEchkg?=
 =?us-ascii?Q?qQO+iixP54GEr0umBrLAM2Tn0gPthNuUvRHgv5RtPUgwg2R4hntbPYyn4RiC?=
 =?us-ascii?Q?fZW6jLebNq7tq/YA+K93+uhrMqlGLhzZhrlNsQylGSMsJQ+Q9HAl5frGfGRn?=
 =?us-ascii?Q?sdX9VnwyeW75VWjeInL1qWcHIpsUj4tbKSFbX4mRKni/rWlEMUkxxrk6jw2x?=
 =?us-ascii?Q?J8J/dk96xPiDJjYUewDNVMaQWXSl5J1T6LSRA8Smkik4v4lkqwy+HkuweRks?=
 =?us-ascii?Q?pyio58Ub/kXLd6BxBiyJ135nq2+78Gux9ZbX5/5ChMch6qQeLOit1j5gXGyQ?=
 =?us-ascii?Q?wBNbxQsfTN4J+vsrI8LAlDzbsj81ISGnsO6fbr3lyNhLrJ0yh5sNzgeYjHUm?=
 =?us-ascii?Q?jW3aaq8KCleDZS4suX+mwz0yNWSlCycKd5/9r+wOaD/J7Uj6HBjX1b+6spP1?=
 =?us-ascii?Q?h8xl4dVgweKl3DQewIGThAARP5J23K+jDqIhwG3uJs2ZczTQ4Ne1i9iqm23Y?=
 =?us-ascii?Q?248LERb3bmhV75WzpwUoMBdQPCv9UeYr2VuD7jlXzvDptXc/OVGq9+57YH3z?=
 =?us-ascii?Q?227RxeI4fqAT1IkY8VT9NkFyaUoLFADNcgn3LOmRQxw+zfF8yFXEHLn3DYve?=
 =?us-ascii?Q?aNNUkJQhSIxz4SIqiZDbk08HQ0OKzPlPX21hLzPxJJ6FNYtCTlBGMqU/rcMj?=
 =?us-ascii?Q?x5YF9C+RcS0CeI4rj53n7BKrumJxWv4ZckD+gid1envb1fvixewG3nNWcZow?=
 =?us-ascii?Q?iR2SouIDEosgzOLxxxfHJsT0ZXqKf4YH9WMiONEZzkNkpQP6Mvd001lZQ29s?=
 =?us-ascii?Q?xbCTdjMtuBMgeqDzlV/cM+CACPC7E2+9+18wMj3I2k7YlHJX2VmjOWzK/ssN?=
 =?us-ascii?Q?i++e8g4Qhfm4Whi8Uc0eeqvUFFzowtzhTip1pbi8InPOQukgNx+0jNuz6tsM?=
 =?us-ascii?Q?vH4JlbjRnms6vqxXKggwyc5kU1zglf3+sIsQt8RjgDaU323P3L/4B6HGtzfo?=
 =?us-ascii?Q?HniBlPHz9QdPe+jgP/4dXT27nbua3Fbpdg+mkZ8qCtm+FfH7GdtQY836xOMj?=
 =?us-ascii?Q?3Y4UJ4BKzwed1f8TZs5tC/Pt1v5VjjFrTpdpEr3gyPeziKWAzpI1yJ1pLOm9?=
 =?us-ascii?Q?7nj0xIpv/1Ox2OC8MyhiD9K0By9YVCdok47i5xDSQJ+dISyA5NfAd/mUxIqD?=
 =?us-ascii?Q?8jMNo5MUUnZsaH6fHv48rp8kkrWM3B5lKIw/80zHiYK2Ei2OfsGpFgSAKmPh?=
 =?us-ascii?Q?pJPLc0aw+7kIdXvHXIpSOr3Cqd32/OT5oasmoQS4KoXkB3K8gfS3Whbw617A?=
 =?us-ascii?Q?rffItw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011392aa-ecbd-4690-c724-08d9c110861d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 03:51:36.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDCDqZRpj06GMO9LRFzvp1J33Abvx2a34IY3XrznCyra+LWpToL+UGBPqiN/MXFJK1gKbYBYIU8EyZSrVN7jjrc2heymyfpKmVLwR1MPB88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5420
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112170019
X-Proofpoint-ORIG-GUID: _RfDhJaNxlbiH7LWQG9RhCVVMgSAeMcA
X-Proofpoint-GUID: _RfDhJaNxlbiH7LWQG9RhCVVMgSAeMcA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bean,

> Call shost_for_each_device() with holding host->host_lock will cause a
> deadlock situation, which will cause the system to stall (the log as
> follow). Fix this issue by using __shost_for_each_device() in
> ufshcd_pending_cmds().

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
