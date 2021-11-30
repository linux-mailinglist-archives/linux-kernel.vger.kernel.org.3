Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B275F462B60
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 05:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbhK3EDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 23:03:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20684 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhK3EDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 23:03:24 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU3eMFm026595;
        Tue, 30 Nov 2021 04:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=lum5alEJkymbJkuXY8T5jDBqz5jSMs7KeU3+tss6m68=;
 b=DgG++W40r38Sz3Zc6XX3Loxkv52F1X5G2JvZTdmj73cU3draTuuwcemDmy41tAM3rK3Z
 F/psw5V0zM3BxRmhMVAlyMQEBehUFlarcJL0aWvrqcJ3ynTD1RYEdL3AudW6fV1lpvHZ
 LokH0rIieTEuxWHCLxYj6USvWvqBKeoGKjzK0a7cvCaluojxt2hpZ0FM0ARiMbOg2PXa
 WRpykJBwCe2RXXqLY2xXmSTCNDqJ1P7dR7AU0EgevKlz2yFCIsxn41tcpqJK0scRJvbN
 n2ZMO3mVW4BCAsq4sQrZJyJTyAwY4JYHtTjyMHxlKBfn0hMi/U3+c1YMj3b1wJQKt/6W 2w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmt8c652d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 04:00:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU3pgGH104425;
        Tue, 30 Nov 2021 04:00:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3020.oracle.com with ESMTP id 3cmmup8tkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 04:00:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFNPd3YUM8PEMopXL/wA/Vs7GNVz4tNNsU0KO9dg8oPFx71/CaLKLWOz6V0UUt2d8kN+oF8c287VqT/oL6jB84ayNgQFtGm/r7X2L9L0AIU1C7gjwqlKcSuYJ63tYg5nXBMcqY6jkpQjAzJAvbsOVnyPOH1E5TNM/29HUyZZmX0j+VXrx0y/l/dQi+F7aNVFf0Q++YjtDVPwepEYANdVFSugcbYcpeVecXXh2stOMgs+Cu5o2Il6yUDXFc93m93s6xT4It1ZDdINgfJ/AQmuYFZ/vLJZrB2mEeqBRepDZg+xPk0Fl9WHQWXBsFc5pgrBG/kWLuL3jEBv3Q/CzFH98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lum5alEJkymbJkuXY8T5jDBqz5jSMs7KeU3+tss6m68=;
 b=CfPpUvDk2lDR8wE15lGaqOar5dMr9hPQd55l8wJKLWHO+WtdbBDAbjoSCo8R5jEYJJA7q9M+8dUEI7jXyK6Qmuwnwuq9cGIgxNyzfvvrXLQslTAJ3GW2NHLg/8fTaGd/wmGW48oniVz4iVdZVZAU83lzq3rS/8Y5FANfp35jq0sCfskOqkVOfYsaInSXl+TqSBzUdVwta5SI6YOEXmEgpl+IsxsnTieb702BunTiqjffQCtmzopOn9lSiP4vq+0CV9Kb8privN4tYABeOOjHQwk9yUId8sfPvAV4LnV/GhRr7dTsnWdZWgjZfWTC9L1NiYQj6gnUNdntX7Q4aTOifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lum5alEJkymbJkuXY8T5jDBqz5jSMs7KeU3+tss6m68=;
 b=D2xr5BU9FIG9QxJnmOA9lk7st2kAox2CKCVW+8ZtiFQHMjnYn59JvZ/rubXXlDgNt/H3gJkGJRsaDAgsLIojO1Xt/wENYCqfqYkI+ZpfGUJTwqdoWmB/BU21vtfaTXCUxAvrfYQmieDlztF4oJnx7bvNrh1hzxXK+qHJsHFcJgY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5732.namprd10.prod.outlook.com (2603:10b6:510:146::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 30 Nov
 2021 03:59:59 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%9]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 04:00:00 +0000
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com (supporter:QLOGIC QL41xxx ISCSI
        DRIVER), "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org (open list:QLOGIC QL41xxx ISCSI DRIVER)
Subject: Re: [PATCH v2 2/2] scsi: qedi: Fix SYSFS_FLAG_FW_SEL_BOOT formatting
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fsrez4cn.fsf@ca-mkp.ca.oracle.com>
References: <20211126201708.27140-1-f.fainelli@gmail.com>
        <20211126201708.27140-3-f.fainelli@gmail.com>
Date:   Mon, 29 Nov 2021 22:59:58 -0500
In-Reply-To: <20211126201708.27140-3-f.fainelli@gmail.com> (Florian Fainelli's
        message of "Fri, 26 Nov 2021 12:17:08 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.10) by SJ0PR13CA0221.namprd13.prod.outlook.com (2603:10b6:a03:2c1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend Transport; Tue, 30 Nov 2021 03:59:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2aa79e1-a988-4e7d-ba68-08d9b3b5e13c
X-MS-TrafficTypeDiagnostic: PH0PR10MB5732:
X-Microsoft-Antispam-PRVS: <PH0PR10MB57329417273566A59CFCB3F98E679@PH0PR10MB5732.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9TFIg81bFYIiwEkAzgAEosNPvAjFaG5RQej9wYKFvcwOsRo3CDccLkf5cF2jq0uWd3GeteWnWfUqxR7I7K/QSE4aSW9ENzyySem8i6LjcCjZkISRIAc+/v2+kUQPypkNFYWOoGAXIF2PbOvWfVu5jxG76uOAlI+C4WiLSdW5ci8CZ9YKXsU1r0IEiGmKxsJEgHpDxf/GJDFNmk4mszrgXsOlB6HKPWpfe0cA1hFrLxEFvRJgNKuTNV4bXWLuIb64V7v92W4fk1FjcVpBPBdO4xb1rZQdvWzwwGBGiksWyvD5M+DFzcJ7cKoem8FZpJPfPGF6BUULKfVzQEVGenVDAsnpVus+8XBkYIlAPcLK5e15/eWrwytuv6tQEViuZkU5hrOa+YlMbl4QuvZVgvv4AHfNL4JA6xiw/zaZ9igSW5A7c+A368ExBu7fkDlE/Dac+owzB3rrjTBI7A23LxZI1EI5yzCHoEFwfKH3SfjO/uAD2/OBI9VCOYPImgusLBLIpy9weTiiyn7AW8q/PaXnySjvK0r08XhO2FdplVEemKk5xEiPPUsGh8DEwiClqs9A+JlYcFWvo/rksdacjlxYS3RGF+apVK9kIXVCDQnaLnQdAzbTatxbUvDX0Vq86yl7YIOIiwW8gDLYFe/TYKQ8UwYjtSg8c1c7rpyt5+m+etDEgHjK+VuBAEC3HylXvrLwvoIKRclUHDKvR0Apv/sow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(4326008)(38350700002)(8676002)(36916002)(7696005)(86362001)(38100700002)(4744005)(5660300002)(8936002)(186003)(52116002)(508600001)(55016003)(54906003)(956004)(66476007)(66556008)(66946007)(2906002)(6916009)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TQwy708Lxm1WI3Yy+Eg87QkVCvqSU5Pu2weNowt7eg7Qzu/LqRcHI9oUwb8q?=
 =?us-ascii?Q?EEzJIWDXN7XUte3GriFr8QA8goCVDC0UdA8/m3QAJtam3iU4PJHgEvqb04pk?=
 =?us-ascii?Q?31RflUr22hmIb+HVcUpDFh30I5xicFyctm+rKJXCK1g54OgHCrBiuzcu7bre?=
 =?us-ascii?Q?49r16QVDxMGkqHMiknuR7yK4yQgnZgYRIK4cCaG/XYE6Oga3AX/qoApJOyWB?=
 =?us-ascii?Q?iAy5bKvC9RnkhUPyi4QQRby0KQlWbiogNxGfBDj00g+HVTarsOe6wLP1dM55?=
 =?us-ascii?Q?OXj4jaNx1QehECqBm8MfdRo7vJgMInozoa7UbSbLUdyWLAWjS25Zpf25wQ0+?=
 =?us-ascii?Q?Fwu4PNfU/PMQ64KqQt8OJTI6MGOZpQC6G2tRFQ1+uOw2qi6siQzO6PsoShDz?=
 =?us-ascii?Q?hfpCitvuS6YS/TawDLrVePuegaW6ERcAd9KCdqg2qoviW5A6mc9b6MRSXo7g?=
 =?us-ascii?Q?quHQ4jN0LGbilnTY1M9BR8zv8Wn7QuoXNjmkx1HoG15OYMr+zuf3S2lKjilp?=
 =?us-ascii?Q?VGAMtpUtMUVKRjjfI9/OA9J+DOhOiifA1iWEgBjuBLdjCEBx7Clx2gxaKltt?=
 =?us-ascii?Q?YbYuXM8sphFU6qBhsHI/T4wAfAZ0uMhNJ4/lhpNDiAXeR39xtzergYPSh8bx?=
 =?us-ascii?Q?26PTOJuwcNjbkMC21E2xih3765yWZBZUujo3cZd9Sg2PNSSUerC9sK0yIhCV?=
 =?us-ascii?Q?QW7mMXa7rWzm1G/BhwzW2YsOfj6zI0fuWlawT0lKWYR/JaEAVNZ2Q3YE6NVl?=
 =?us-ascii?Q?BhAcmcDnBketgFXlfCCLK5T0C2dcHiT6LUJR9PpcYMZoLBwUs9SVtdRhaA3y?=
 =?us-ascii?Q?qVz68brE+alYF5tewNy6MOwSDUbaQ2qIcc4ZBSkFsW66jQlzG41u7BU019hs?=
 =?us-ascii?Q?2wFZMvThVDHCVh6RDlc4Ao55rMmWR26Lt44SZQDREWafGvU25RaTlAuwb+OU?=
 =?us-ascii?Q?cUmmnpEFitzjPSBM+aoaErszZ/TAh37/bNe7PeV5Ys5nca1Tqi7YMcwwTWAT?=
 =?us-ascii?Q?88y8zRu/OHw9D89rXmRnl8gMm2BBPhcb6CXEpcDJ2S/fE8zK7OqSjAhD3UIF?=
 =?us-ascii?Q?P4wff2veF3qMlRJw2yaWCmL3bZ7HgPwFeO/PZ1PYwWlz0WIX3N3YY/euov9z?=
 =?us-ascii?Q?uipUuRUJemF5TzjV+8TnuvDt/fuP6rLZXuzMl4pfNkpI4dLSWJHTt6+GyKUc?=
 =?us-ascii?Q?uIuwfsvol4Vs3uEledsUGjSM6yyQVeqQmJD+gJogNDnjeWXJZ+O+yXoLnCRL?=
 =?us-ascii?Q?FHvPvyr7DLBdrGuE4Iaz4M2D+cWLa3iHW5xMLFh6MyxCjjUbmDuSzBBPN0qJ?=
 =?us-ascii?Q?rjyQWiQpCXQFPtwdZIpQnUYo+LxG2KVtQ36LXVjzmudO77hOZOWQ1m4nwDNT?=
 =?us-ascii?Q?r8KsgiOZs4ChCuS9cD46KHHdWlgCqAkUjML5u3MwFNFOKCHdd1imhmpcRcYp?=
 =?us-ascii?Q?e2hXamlrzsAwf7AITEYYtiQ4/giDjA1SbVG2j+jl1/0qMm7xHD+tO7FbWcwU?=
 =?us-ascii?Q?+2ZFy0AZT0o+b32P674Dj42OzY7geL/I+xevBX5D1qaDpDmJE8iRuJx5Cwby?=
 =?us-ascii?Q?YH5+FQklPui6jHa++Ef1PZS2/oay2gHtefRF2rBkPLFjGKYI5QVz3N26XV/M?=
 =?us-ascii?Q?0cpcpKPF6fPncGgumEvwXpqA35+YKqeGbpib2ewlR+5JBlz1T0nO5P74hz6v?=
 =?us-ascii?Q?m78kyw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2aa79e1-a988-4e7d-ba68-08d9b3b5e13c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 04:00:00.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UzNpPNZelEy3DgLPacsPloAsJsGZdPxwK4gDe/WwZfrvfy6PPvczmOYLbwV8g0/AXIW/MCm+Hxzx9TGizwMfyFGhmsMEtbWNNxzZ1WXDug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5732
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300022
X-Proofpoint-ORIG-GUID: ZSS2CPQTc9FyRSUvObHRO5BwPbp-iJBh
X-Proofpoint-GUID: ZSS2CPQTc9FyRSUvObHRO5BwPbp-iJBh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Florian,

> The format used for formatting SYSFS_FLAG_FW_SEL_BOOT creates the
> following warning:
>
> drivers/scsi/qedi/qedi_main.c:2259:35: warning: format specifies type
> 'char' but the argument has type 'int' [-Wformat]
>                    rc = snprintf(buf, 3, "%hhd\n",
> SYSFS_FLAG_FW_SEL_BOOT);
>
> Fix this to cast the constant as an u8 since the intention is to print
> it via sysfs as a byte.

The other occurrences of SYSFS_FLAG_FW_SEL_BOOT use "%d". Since %hh is
deprecated I suggest you just fix the snprintf().

-- 
Martin K. Petersen	Oracle Linux Engineering
