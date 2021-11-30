Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14657462BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 05:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbhK3E2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 23:28:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32888 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229773AbhK3E2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 23:28:53 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU4HFBw028197;
        Tue, 30 Nov 2021 04:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=4dXadKk0Cxg04fr8zYp4RUJr1tDyaPchJm9hIJSiIIc=;
 b=qnjRDTf1RQyFHPphzkx1LF1dWZ1GWtj9tpaDXI0y+UbCdnyjYh6CQ54QHt9j7dcorR5h
 RqxaSzqiv1b5xN4i/Y2Gaa0uqtjZeXOQeiZPBgb1GTdJiexwPzQDM5FZHYNX6wWXiaAu
 PVUixB7MAP8+9DoYOGoQ6LU011v0kCwJU+upcK3UDcvwiPzn2MSW5/7OG2NfI628lB69
 iMmSJv9ZW+4Quso94GOqj4LwjbtlI4ZgaLhsfRiiB9UqHQd+kU5mxdMp1MeypPvDihNA
 x3RwazJS4KGNHzhToFJ5UsU81K50HJtAj9Mhdl4/1CqM6jAxiOqPHzGwFYoec5+g5PJ0 kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1we4jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 04:25:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU4G5ec114106;
        Tue, 30 Nov 2021 04:25:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3020.oracle.com with ESMTP id 3cke4nsy4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 04:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1QR9l/YkLLdpvXvAPqtZJKrShUqRBeRph7qc/O7BtV02zRoZNfIblcGlCmDUvlliG8v3pbrgH3TJ6w7G6DE7jJvC/5pmzlWKB1QNzmdmKKo8MtwFZOxh245BLiCs8ylF3Q1ozLaB+8iqsXYqeZFvE1sF7ayFWWktZezx2MEDyY4EBjtNcd3rIlMpCPR70Og/L74bHYzpNfw+6A4AyJp0HKfB2pH2UsDdGCzO0Oo+hrBpuAz9A9TXAIfFsgAhpAihcDP5vdpENediUdOac4SZAlOVQotPgQqiImOgCHGglzJ/8YcnaOvVzzgRV8t4hyfgH/SsXhxKfIFDGWOHL1DvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dXadKk0Cxg04fr8zYp4RUJr1tDyaPchJm9hIJSiIIc=;
 b=TC4B+VkLnEjoJXeSgMfJftvZCT08OBftEGi90IgZ9iPHbp4bXdEuQ/HwkIGdQLteyast/CLG6oKzP+nBkcNuG1TKPv07R0pha99C+RyF1w3K+pp+POi8UWVgavXlQmxqMa4n+RkI/+HKccW77t1aGSZdCJyizWzqaesDLiSVhjgsqelVKjlf0xJHGEt47k1DLFK6XpL/bUM/PyyPiste0WOhxAqd+SyNgv8qp5ACQHDcyBhu1Vt6Wj0OqvoWgwti84bROMrrX9RDu2Kc+iHL2YzbkgDglupw1cmuhKnzyUsyMpNIO2Wp8MgfcKvvN3JN5F/zpmo5QXp+1BdmVzI3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dXadKk0Cxg04fr8zYp4RUJr1tDyaPchJm9hIJSiIIc=;
 b=IyYp6xC4fut/fsvfHW1rxGULdytZxyUAsQtzInN3+ch+9/p+XaRuGYtANYt2ClSURkATdlMrtJrUbEhzuGcfbIMTaRAIQvV/DyxCS4dEaOx553ENR3XLcsr5Eys65evLjqHdCPjaTZRb1RjT+X9oPweHwG0zolNF4/BFajhs7hw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5818.namprd10.prod.outlook.com (2603:10b6:510:140::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 30 Nov
 2021 04:25:22 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%9]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 04:25:23 +0000
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        "supporter:QLOGIC QL41xxx ISCSI DRIVER" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:QLOGIC QL41xxx ISCSI DRIVER" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] scsi: qedi: Fix SYSFS_FLAG_FW_SEL_BOOT formatting
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r1ayxoj4.fsf@ca-mkp.ca.oracle.com>
References: <20211126201708.27140-1-f.fainelli@gmail.com>
        <20211126201708.27140-3-f.fainelli@gmail.com>
        <yq1fsrez4cn.fsf@ca-mkp.ca.oracle.com>
        <4a61707b-a82b-4950-88b3-5f268d9fc92c@gmail.com>
Date:   Mon, 29 Nov 2021 23:25:21 -0500
In-Reply-To: <4a61707b-a82b-4950-88b3-5f268d9fc92c@gmail.com> (Florian
        Fainelli's message of "Mon, 29 Nov 2021 20:09:55 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0059.namprd05.prod.outlook.com
 (2603:10b6:803:41::36) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.10) by SN4PR0501CA0059.namprd05.prod.outlook.com (2603:10b6:803:41::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend Transport; Tue, 30 Nov 2021 04:25:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc55b438-8bb0-4791-8fc9-08d9b3b96d28
X-MS-TrafficTypeDiagnostic: PH0PR10MB5818:
X-Microsoft-Antispam-PRVS: <PH0PR10MB58181977FF0BEA6241308A678E679@PH0PR10MB5818.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6N0gAItIDhi+pyw35mh9tCsVyFsh0c9P5zMSHi7mPmYU7eCM+9iuFPWBgiiQuTZwV8/MZJQ3w8/nVqLB0ih8sSKDHTLNGxv0ArxjHLyEfFrEhUStmZFBOCtJeZYg6VT8Qu1NYCe/tLmUr/SfC/5bgZ2wJMC6AQQfuHeXBPoPv4BeYtVp2L5pwB6KpND0p8o+yJN2Iz2GTYgcZQ0kldBucryy57ugXLyRAqZdlo2yqe5+O3zymjO6wjUJsiYzq/Wfl11KK/gr5WqO4VoclgrS0zGKD/rlHi/gkiWvQFEjv/IOil6zCOVEGCFRag/6w52W9DkUgqL/3eEmoASHhyXmDqN73Uz8xPnSHTGC/oV/Wgi8B/MsCTXNqjV9GWCSStqvHbco3G1fdd/7aqx44ts9OMn9MB6nTOFuLzS8urJ6dPFPRVRSpDG6iC13Zpn0NohPUC+8gANWdP8rhtH4yUy9Tw158JgBG9BPI2Ni+zI+ZGiD0VRFYsI8Gn264UjPhxVBPil12oz5QXvK5En7SmrBvSJn7nzX7boscyTwDHVZWAIq/573CNYfZftH86X7hU534O/VODgv+Vq8y97+o74klgJH0iZo+jnewXr6ixCXPfujT2o+tkvUtjXBtMCvxaQVGwYSJJeYYFUZ4PpWmkVMZj3HtHV8W41TIH+uNq8epX2lo0XAF206vxJZoCVoB19eqArEtpLS31oSFDRI7Tk1Y69gyVOSpD4vLCRocst7psev9ER6BshqKzXVKU+YBErSzdwax0D06HElgCsEH/7Jfcg1Uqou7cVj3bO11ThTJoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(36916002)(55016003)(4744005)(26005)(5660300002)(186003)(38100700002)(66946007)(52116002)(38350700002)(6916009)(66556008)(66476007)(86362001)(4326008)(966005)(54906003)(7696005)(8936002)(2906002)(8676002)(508600001)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NXIboFPSTQxY7aEczZy92/fWTNRQ4j6h6Q0ZMv1ZAaUjRQTbmx9R8kW7FYjC?=
 =?us-ascii?Q?I/PuPamPAQI76sFbcus9446GeUV7ghRDia2TF89e6ZudovroiLPeATX9nEuW?=
 =?us-ascii?Q?lfl11NtLmnBi6ctqkPZSXcCsEtO0IcznitQtEyDyFAD57xc1b8cdFy20lNF1?=
 =?us-ascii?Q?P0pEkVCNEA6Te7ykOMLn9QYu0/XFfVnYkrRkE4XwWaOUJzyeBqOwmD9F1/Vh?=
 =?us-ascii?Q?lDyD+n0/rvEeZxR4WEAQ+LvEDK2FYQtSQqlM6SilI0Yif9Ej3pyjpd3CCmVo?=
 =?us-ascii?Q?7U13+M1t1RTLJIfYkZBh7hNM02nXVvxINYDgjHvJyubcyqT5aCcsHIwIbwTh?=
 =?us-ascii?Q?20clnxIiogvtUc1MiJwid0FjoF++sKCVg9js/Otyf7hKRxQff86sQB9bSXgg?=
 =?us-ascii?Q?u6HHXr98+ZpOCUulgRxJ8bGAVvh1Z2MhgxBdZR6aD6eKFSxY3OpSEdsHR2YJ?=
 =?us-ascii?Q?HzszCKxxy8qaKko7YGapfk53Aaz3/6VWA3dTjlhVCjDp6WwXviIUBu50xeBp?=
 =?us-ascii?Q?oH5+J1Ys+0LdYzBd0rD4qr1fsBEusdv1XT9KDKvR4Ik9LRzaf58qOHiTA+0I?=
 =?us-ascii?Q?shIz8pQjXIs3tv6ATDXPLlp3OtWt5mlX17ZyvTBMhkWqsVv0Bl01SJAjly+6?=
 =?us-ascii?Q?WbPe1EcI1C2IA5fs8gkCLNNtcZbKJOH/5yYMJRVJj+bO4IWk7PNMgTO+bDKL?=
 =?us-ascii?Q?QOT8v1YoeAPOAUiw/xwJK2jQ9COjO9KDG/dzLHJMduYcCH00iyzs0ePRDx73?=
 =?us-ascii?Q?8pD3sT17DkPP6ELOAW07V1yTq7UGvANisqOKu/nIdGnMoDhromAAToWlmQJg?=
 =?us-ascii?Q?L41qzpdysoYwOpRWUhodwRfWvn1bCTNnYWBXIgTJWYBXlAbEJoGs1GAN+o0v?=
 =?us-ascii?Q?yWlg0JAcubRdhLg4KJkNOPecF+Z/bHAmmTDhBpWKpj6/trepW5K4f4Q6PJ+n?=
 =?us-ascii?Q?m3kSUa55aeHYe68Tu7M9tX43zvYNl/qgQ2QJ3fA+l1LZh7v0YmbqCW0FXd0o?=
 =?us-ascii?Q?mcrmCHr7A0QzwkELxI1dIN56Cp1ik8JYxEo5J/QeeJvdHfPABAHQhOgUU+8r?=
 =?us-ascii?Q?vM+EdYWLcrmC0uQkfOo1hB90vyCuIFSZTx5gjGyl26HzH2CwqplDZaqeeIu5?=
 =?us-ascii?Q?L86PtT4Yh7lN1d/0paJmCvCn3zi8zu0/Y4ii5XP3RNuwYWbviR6y7PoLA0Y5?=
 =?us-ascii?Q?x9THsMYDSwfjKI5e5aHlGPaIv/HY8HnczWK82nZTHGfhhB26l6Jy+5QtopAc?=
 =?us-ascii?Q?rf0qhhBnm9R2lhOoln8lxKvczx1SDDPbv1aYuOPDYGbxCB5CjUI2qHzu1Iqk?=
 =?us-ascii?Q?NJ/V5psiTGumQH7opZ/lvr7NPulBQTs+B1rXqtIFxyCgeJr/iE85nbzyQI44?=
 =?us-ascii?Q?4ZK1wyD/0q75JhJh7BVupbjo2D0hb8aH1QJVkWdeyuqL4017qVKs6IZdofal?=
 =?us-ascii?Q?FRj4UFpO4pUMk/nhi9Ve3uK2kDnUSMUUJRQMV2m3NgezZnvcRW/yietDt9T+?=
 =?us-ascii?Q?MDYyEG/pZsrfTDTbCDCuP/czQC/CHH4xsGFmiyFlXZZNv/jicOBRUM2WtV8Z?=
 =?us-ascii?Q?etUWOId9WLiIEJ1juJyMKMYIQdaQQ8PeFQMnm8sNdD48Xw6zWNzLHxbIsrPb?=
 =?us-ascii?Q?qQaFB30ttmOQzzOtGibAJVSAq8aVgS1dcSc93Tgud8gbfV4Vntu/sJpa5eh7?=
 =?us-ascii?Q?F+3SxQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc55b438-8bb0-4791-8fc9-08d9b3b96d28
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 04:25:23.2288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7KwoJKn7wYovy69AOZ/No54w5N0eC2bDrsTY4+7ny3HOk7ihoSZANow6gnCjooUQCQTKepsU+BL0b+0ed10Rh0tDTyBLgH2O8uZ/xHaSgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5818
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300025
X-Proofpoint-GUID: WNY1cFjW2puHsR1mNh_Bf8dXUKtZqfsv
X-Proofpoint-ORIG-GUID: WNY1cFjW2puHsR1mNh_Bf8dXUKtZqfsv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Florian,

>> The other occurrences of SYSFS_FLAG_FW_SEL_BOOT use "%d". Since %hh
>> is deprecated I suggest you just fix the snprintf().
>
> That was what v1 did here:
>
> https://lkml.org/lkml/2021/11/26/9
>
> however Manish seemed to want that flag to be printed as a byte I am
> fine either way.

Not sure I understand the concern since this is a constant which will
always be "2".

But if you must cast, do it in snprintf() and not in the macro
definition. checkpatch also complains about the cast.

I would prefer for all instances of this to be consistent, though. So
whatever you do, please also fix qla4xxx.

-- 
Martin K. Petersen	Oracle Linux Engineering
