Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386BD462BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 05:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbhK3EeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 23:34:06 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52454 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238216AbhK3EeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 23:34:05 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU2bZue020993;
        Tue, 30 Nov 2021 04:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=5jptU6JLHnE6NiZxwpOTTOcqm6RTZXCIILQDj0G7Zak=;
 b=qTQJ0WosYtJ/UxXhUOT+gpozZtyIQhx2L1dVuDvjKuOSR6S34S/CLcwvVbUJv51hFyxD
 y0Ds5eRr4Ab+amIh7AJ+S9w4BlZFwOBiYPOsJtpHyTsc/yWFbfz59qI326awMClhAiBc
 JmafxVj+2PZ6g2+kyqsTVjoGQKea8Q8AC1sW7n+qMe0nDYtlc612pOjNgcZGVGDny6X6
 lr0OPvKPPu6jTYZsmoxe6PbiuSYP96sw4B1VPSh2VXXawOadtHehdQpisXTeAgDPhqTl
 /UbWNE+suDk3v1S0+RwEJlQj/qZNHM2UA5uT7vcodklSfuPtW7aKPNUbIVbb/O4M/T2E mg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmwpc8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 04:30:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU4FjiJ145385;
        Tue, 30 Nov 2021 04:29:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3030.oracle.com with ESMTP id 3ck9sxs4jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 04:29:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJAq8Udz6OGFHXKtO7F3eW/pj9sgaGgcwbF7PH63pbQe+DHSsw6G80/BqJBpOMEYf2oTxYkUz8nW/SNBy2tRzbqBIlU9rEyV2zJI9Vbj5B5bKRs/wZIjSKUKKGnRNJR2PdR6mq1SAcY77RjCdxGVHUU1Fb1U4YLgbwnRpCEsEq4TXwYSl01ttJr0DhiTLkvzOtfXhEYRoSsf3cfbHi5Q5BMMx/c40D+SzfrQtizjB/PsP1AxnT9DhFihrTxZfT7ADFbGrvStTjzLwC/1k8knHpFLgEEJeJ7tytnEJPTecoxVMwjm2LqpJhW60l4grBcIwEAbruN/6fTxkhEUNwGdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jptU6JLHnE6NiZxwpOTTOcqm6RTZXCIILQDj0G7Zak=;
 b=HuWwzQFoHHiMQnFBLASax6qMiEgvVBQCpDtcThm5wedRqgidBQEKX7zKHyWsrYQY5MPQ0WR23ccB4/7U4JUvOjCoPqWwmk7kbp5yU4APOXlsknb008ir/kG6lMd4MZOS8/RMguROGy7pd5mIpQXdfoQtxbbDM2DbHmL5FZS9hZjb4czMe4C0ngynRUNRxxVX76EpQIVId13Y58T2wWQfWn18WqBZ3H+G2WY8tsuriFjtMVxukJx2zIYf9FRjPDbTjIMREfq3tg5ko5dZa2eaBkywhlyUawGdJEl+ZrQ2XVthxke8rukU5AX/TPAkmT0kf+nSA4j2fYqMPI0pbaK5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jptU6JLHnE6NiZxwpOTTOcqm6RTZXCIILQDj0G7Zak=;
 b=PZZ9ejNx/GqPCclAMwu57uP4WWDTDqy1nOxwfdrDx0p8RGLc9BiX7d9zSFshCiea2NhVVJ7hHGwAvLGNWzDv29BaVbunADPQOJe+sIr3x/+Z2ig0ltIwm42fValp9097CnKR0JLIPaqOBjKcqUXGw85qfj7pfEACNki6Jl8Ger4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB5877.namprd10.prod.outlook.com (2603:10b6:510:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 04:29:57 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%9]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 04:29:57 +0000
To:     cgel.zte@gmail.com
Cc:     james.smart@broadcom.com, ram.vegesna@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, dwagner@suse.de,
        hare@suse.de, christophe.jaillet@wanadoo.fr,
        chi.minghao@zte.com.cn, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cm>
Subject: Re: [PATCH] scsi:elx: fix cond_no_effect.cocci warnings
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lf16xo7y.fsf@ca-mkp.ca.oracle.com>
References: <20211115055725.85631-1-chi.minghao@zte.com.cn>
Date:   Mon, 29 Nov 2021 23:29:55 -0500
In-Reply-To: <20211115055725.85631-1-chi.minghao@zte.com.cn> (cgel zte's
        message of "Mon, 15 Nov 2021 05:57:25 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:a03:54::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.10) by BYAPR02CA0052.namprd02.prod.outlook.com (2603:10b6:a03:54::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 04:29:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c98babfd-d9b0-4d61-fbeb-08d9b3ba10c2
X-MS-TrafficTypeDiagnostic: PH7PR10MB5877:
X-Microsoft-Antispam-PRVS: <PH7PR10MB58778624E0FD84E3D0C3D4248E679@PH7PR10MB5877.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JchsY5j8g5UWYnEg0Eokr0IGPUTdAC0PF/+zfxZfnYMy8ImMT4egdp5PIsoR0ALwQ1B35tbKVZGk0AYPpgoySMLHWWk/F9lIKHDehAoa8hNvzxjdgS7XXwyZo2E/LuLFYYbRjnFJmzDjv5yX+iFbFBRBecRHBRIzERed0GezbU7+d3kf80C+4RZsfCuI5k3laCwAvtVrhTUSImOi+OkHREPOyNEWeaqCJ6Ugx7P1PTjOYoluVbvY6tOYgLEuANcfMHAHlW46vzgL9Br4uhg12eKfcvNki6rSAbGM/kRPDLSOLH6QgyfLfDKDfrq0plAdlHkiFWYqAUy51CdaxNk5Bt2LkwCCGgKoaPwAgaBNLPDnePm/hnJHSBQxRD60VxzO1Jrd+xIbdlfw2r+anTqRBpavuklpla/L54MlaVbvNCL/W2rnycfMLWpBQfkxtVuVTQRDzs5DC+Md0C3b/7CzJy3vYnFV3YInY8JLRLvDEK76OkSYXk5EElhnhQ875gjvaceRmK4nK6KW/GcFBJpZtL4uhYtg/XYSzlnTvblP7udApCZlD5UQNUMo04FVJaTXIq9Wx7jJ3Ge6cN4E+fVI/iz+9w16BVdrpiGI23quGym8uqU3ieA0zjZCPL5CcxBYgo2Jp0SO94l7QC2PfBGi6ylFkyGLemQSCFoITkdqPRDhm0ldSOcTqigsjKy08ehfx95XjtlPFojvKbtwjleuCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(83380400001)(66476007)(36916002)(8936002)(86362001)(4744005)(5660300002)(26005)(38100700002)(956004)(186003)(7416002)(66946007)(66556008)(7696005)(52116002)(38350700002)(508600001)(55016003)(6916009)(8676002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f4dskZdn7CesCWZzYUC9ef10G1gMGIwptBbAxM4hMzbnME1jhheC8fc1ONKK?=
 =?us-ascii?Q?9zaDipwO3H8t/UZAg/ccpCJ7JaG98p5wP7qYsR+Y7y8O0SgaR+qnbmKsSW4P?=
 =?us-ascii?Q?npa1wOUjXhVd5QY6NL/QTl+NOc7jPaI8uyVmeW6qye/O/tko0nW4RBZOU8V2?=
 =?us-ascii?Q?Fxv0ExnK93Wbw7xRGXN0jRN7R+M8L/d//OAkFs1wkJkMttRNGtDyPzF1u9ga?=
 =?us-ascii?Q?AqBrmyvxsOg1H10ohwb4sGVdRnj20++qwZ5PAtTMi2C7zUKUftEGB7kiu1O4?=
 =?us-ascii?Q?uLnWVtlK95i4eGD0YTeDQ7zxy9P2zKXlZKzrGLPyafIaVZ395cUEyG1coXji?=
 =?us-ascii?Q?wnfMWWBiRDGvatJjW+OQlazGQppUAlL8tInajFm1+MDSj233EUF4dNdbGdP6?=
 =?us-ascii?Q?zc6QohifCF76I8yHgVb5uBw3WtT8g0niuabV6C6RGri/GTrpZflLoNCHYk3l?=
 =?us-ascii?Q?7F8d5ttv/v7QaVEewEfR5GgLs2yod7yzGDAI8cGMJO13ZCk+XGvNUcjiAccd?=
 =?us-ascii?Q?h0UMToLlpSNsObQo36nmFa18jAN+tZrZyNVNBbf7UBAuERWNhaQInKvHnpl5?=
 =?us-ascii?Q?Ni/mYWHSgOUPTQQort1nL6FMQRCuUxV8YJv/y+zH6f3Ev4fMFSKY0oQiiLxn?=
 =?us-ascii?Q?xEWQw4SejVAJEfwbRDxVD4ATPmZny1erAUuyfyhLMbUDp81GYt7RhE/6MlB9?=
 =?us-ascii?Q?77YjTVH30FiOyk9nsuL7B4xVWWMOIS23QkiF0dnDibzZ51fe9zwKHYrzWyDV?=
 =?us-ascii?Q?7vXiK3XXHeRLWwrkQ1JN62h+wV2hsSpqDC1kvBuAUkiu/tKMkVsI4jVa/zJY?=
 =?us-ascii?Q?oSl+PmyEVK+PrzjAZFcADc0+DZDucj/diOMcXecC9mo2HJtkGOOQwFPo3FUj?=
 =?us-ascii?Q?7Uyn4EvYTlG1bcCiCvMW0OrvypZoaadt0laAsUG1YhK+doxPuKFAz+WumxX8?=
 =?us-ascii?Q?pDr4xj7zbEnW2mCJvM9mRVuFVgT6XoEsT9MzwzrKTkeCfdLtLbPenZVGZEop?=
 =?us-ascii?Q?rTnMBl15FCnOGgfYNLvSs8rNThMOytU1IZMewicYSYamuMYWVwz0QdtcLv5L?=
 =?us-ascii?Q?5/y+8nuffokktZ+X/ihUCvHGcY87JKgSe+DJ9qPd1nuMvFEf2GX2/pWMCRT+?=
 =?us-ascii?Q?qJKyk8ENTV8+fVS7eLEJN4BhhKLcI9kkaotj+Go0pz4JvcPRbrVg3qDJhPdP?=
 =?us-ascii?Q?7SiXce83XJXshVdSNPiu2JH7z5+g+4czdZT2RYYxPOQaXudh9ScbQuE1jq6D?=
 =?us-ascii?Q?d2/BmHiR4wnslN9QNb11vep6Xz1+cnwADcjPfRNGw4Y8ijNvnR1AEOazZHw2?=
 =?us-ascii?Q?dVVj4MpcFUnjOUzi63cYsqAs/aEnjna9sFJwmd925wm5In8Binn50mnl7KUf?=
 =?us-ascii?Q?sm4TERkPM0r2Xr12+E18roQdgBYT5K6wTfmSIYZsdscfeU0JJsHRjl8NBkXE?=
 =?us-ascii?Q?GsKer2em+VMpQVfcUC1DGa/JecU8WNF9P59ry+S9f5JApbZCftb+Etoq3znv?=
 =?us-ascii?Q?I1JeKIs9alfIGgBOkH1t1VBtVPF3s+UqKp1TvSIB91Vrn7Hx+9LbJwJFEJ/9?=
 =?us-ascii?Q?+LckJbRKOCXH/yR8paj4wL/APbCN34zTdJDGA69Epg+u/7po/tG5yyeexPSw?=
 =?us-ascii?Q?wGqDLkY0AEXJfnCqVkDKOsrF3/dl1faX1Q9burGa/K4BoG/KHwIaohD187Qy?=
 =?us-ascii?Q?0Ie+cw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98babfd-d9b0-4d61-fbeb-08d9b3ba10c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 04:29:57.7094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUR0G0fxMpwrdBEvtJO+NXKCZO9OLZ9ZKN3cM9ZgF7zzfw99Hd0spkNn92PFRj25sjEu+63BJ8oUzOH34fS5jjpKKWJCAEk+8YkhoidbwP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5877
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=839 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300025
X-Proofpoint-ORIG-GUID: x8omW4rlvozshgXIFM0NfgjtHgB7UDEq
X-Proofpoint-GUID: x8omW4rlvozshgXIFM0NfgjtHgB7UDEq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: chiminghao <chi.minghao@zte.com.cn>
>
> Fix the following coccicheck WARNING:
> ./drivers/scsi/elx/libefc_sli/sli4.c, 2320, 2-4, WARNING
> possible condition with no effect (if == else)

The patch attribution is confusing.

Patch was submitted by <cgel.zte@gmail.com> but there is no signoff tag
reflecting this.

> Reported-by: Zeal Robot <zealci@zte.com.cm>

.cm?

> Signed-off-by: chiminghao <chi.minghao@zte.com.cn>

-- 
Martin K. Petersen	Oracle Linux Engineering
