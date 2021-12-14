Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E249C473BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhLNEcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:32:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61554 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229513AbhLNEcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:32:07 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BE1k651017988;
        Tue, 14 Dec 2021 04:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=7R3cv4S0fxrDgumFRbPFeONX3eBKkk8gDZN/Piejtsw=;
 b=YNrEI5xM2nmvNv/h2UW1JpoQintnFm6Pt6Y2v3byEUjcrokmYWwct6I+ALBSIC8RQT7d
 w+wmuDQZXP55pjQCDweD1u7IGk8EKTab4Hw0YzcYvXZQ+NUQpS6hlcNxtqTcpUrTXQpt
 lj8XOkYvuORGh7+vqV7maRhoapOcjVJ4+SIjA2a7Wf4UwGKZdp3DsxvqN6+y7W+xW8q1
 fDYpdMnKEz6KKxoaBKHBCyyELh6+P8gJ60aBNODvPdlOTXoss0y0BErvsY/PIrbGWUdt
 XX7s1Qh9R9RN94L98yrWm7ii/wPoeAzxq4jgnmqz7cPgWzjcCF+GO9tgRa+DNBA19r80 qA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx5akabts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 04:32:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE4QR7g138188;
        Tue, 14 Dec 2021 04:32:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 3cvkt40vyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 04:32:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ai4pNbaRi4MMdCMzjjwEoeZnOAX4NoUy4B18SwqQ7TKSsYhB3mbcfjmqXGO/WVsNEiQ9p6xbyVQOCA06ZSZXYTUOrgo9r2BOLUtlZ2vmuyzYiV1AWb+aEp7Cll/z2sVOMs2CecCbgtrhYhqfS1uZaSW5t8BEHZyasa22mkz8T3bqNQmpYmY2NFAtCLe7SfvY0jXiIbTzMMWEI/hD8a7zyVS/JNUZv4J2OtmSnvii5q6K0ZCN0WgFTHqVjtYKYQU4IJ9V+YlO2tyCyBW9JPzE72odSTheh5Uh76Vfwki7GRMVrUHHf8rXfgCQC71IeS+2P15fsk8TdDYp/tFk+7gaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7R3cv4S0fxrDgumFRbPFeONX3eBKkk8gDZN/Piejtsw=;
 b=mUg6dcO9aSZU7BNJSAIfKU7IeIQQ0F4bKRc8cFt8VqE21WsOucHmEpa/uMMRTTZ06/mtMJb5BNSEJxXovmSx8ZF82O/ydjIjdVu/yHl4JUeBVnQHuYp631etnCDMg59VRFgfYOrtNpmwNmGN5k7gqv3aPqRB8FdVD4jTBU5dblwCU370wT6/V9Om5jBKFSQAEvmSX/Y/4bUBTiSrvUqTHXx1FBJr3lMcapfJUnN76hUOTs24BnMnSQ/PjQCzZabQblle7YT0SSKqbeZv3WidpbSLGiREd4e6eYevwfqcyxntKSrKyIBeUUI8tb2dkQ6YLCyjnS4tjr7/iURhXM8r/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7R3cv4S0fxrDgumFRbPFeONX3eBKkk8gDZN/Piejtsw=;
 b=Aozhfv5crHvcBgF5ZA+ypvOL7CgNcD30BJM78HMZ+WRi+/7wakxhLBDPYLEJOciLdEsKqXlU/drHTDyc5tXFQyf0v8gYt99VlWoHnzCk8THPMoVy5onvsogtqxSG014qavPOovHqkno2hbrbzvo0Kx7yjrfQ/rwOIPxD7L71fG4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB5771.namprd10.prod.outlook.com (2603:10b6:510:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Tue, 14 Dec
 2021 04:32:01 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e%6]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 04:32:01 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: Use struct_group to isolate cast to larger
 object
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfuvolhk.fsf@ca-mkp.ca.oracle.com>
References: <20211203223351.107323-1-keescook@chromium.org>
Date:   Mon, 13 Dec 2021 23:31:59 -0500
In-Reply-To: <20211203223351.107323-1-keescook@chromium.org> (Kees Cook's
        message of "Fri, 3 Dec 2021 14:33:51 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67b3d0ea-b6d9-4b6a-49df-08d9bebaac3c
X-MS-TrafficTypeDiagnostic: PH7PR10MB5771:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB5771CEDA1FA8FB6BB1A3E9148E759@PH7PR10MB5771.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OllPmOsreYqiwZ7eDhtwQfJ4qQXpzCcqPfoUZ9EdDgymjUKDNaDbsG8ur9gyGigSwJPtPOLo8Ps1lkg8L8B/dmV4zP1q2cg3S54mGbV6fZfYo0LQ66jW64o3+/eDLXsSEMLciBuT1Y/tIAzACFO8dAWrbJYSDJSUT4Utfl82YgWIJgP7GlTZma8Ts8AlT8PlysUfOStwmo3soEGEz8HpUPsANi8lFu924Li7qxtDmMDq4SIe/Lb8p1KbHGIWoW/9Kpl6VXwrDeYxM1xIITLb28aawx6cveMeHcHfiVp4TgJYY8yvapmaKXfWUNybI6lu2pWgbxdmc+Op0RYzl2YI4gDkPcjjKifsFqJ2+NjMsnIpu4FgfVcLQV6HcYwQPdsQQQ4ioU9Flm9y1IH5FNk7KKyarn3rDtMs0JZ7eNCYCuoiIYpahWUrhsExmPQuugAohFMPWvJGg7QpeDbjpmTWIBcKOBdICboCuwyL5z74c93qb7LsVJATX5YrbHPt8sVReN/kjwaZJ4qY9zO9Lcfabw0y1I/wJm54lPNiPK9P4bEt9OMexd7sKd7FKkBt1GeA+O3DNF1N2vQQhkCIYm/rPul1Bh7WP4PIWC++8n64T7+fglWrIJVqbp/yLH30K/SKlCpeljrOthnm0PFOGfp0XGD9DFZW8OoXjjMJZLeFrWejonfmz5Zyu6f+uz/6nKHNuAZz0h+UuxrC+2et/UUnJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(508600001)(38100700002)(6512007)(8936002)(36916002)(66476007)(52116002)(5660300002)(66946007)(66556008)(86362001)(83380400001)(6486002)(38350700002)(8676002)(54906003)(6916009)(316002)(4744005)(186003)(6506007)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?caPQHwmG6v3rwaGdmFxDHRLIdKbni7qHnjsHhDJTid6yKvhkLzQp9dFZ/x2/?=
 =?us-ascii?Q?Uio8kojj72HHNNGVEsEW2jq4lUc75HPpEwl01iinnXuhyCenHaZ4FBC2P8kw?=
 =?us-ascii?Q?v0+OsPv1N2HfHqsiUMKd35bh7QI2N9jBvUBgNQuBmuZSECs98dDvwDF/PEla?=
 =?us-ascii?Q?Dca/8yLq0Dd9arKSyH6Q9EkFKXHebYvoV37UrL4KGYlgO5d7MY7mHWJ6/F5k?=
 =?us-ascii?Q?WgfqfCgY2dheK45Q7fFD0CFNe9GR+G/hGF+vSpysiDTeYm4QgZ3UazzG2zBW?=
 =?us-ascii?Q?xpYfrONqiFAFGAW8wn9u3WsKu4MmxDYD7Q4TxxT11UK/FPTB1zJ48php8ANM?=
 =?us-ascii?Q?QLxAa9pJMdczqy/5fRZv6ic0cb9ntPjj+ry8pm2bMqZBBSR6ui6LPRiNOVss?=
 =?us-ascii?Q?jl0RzUDXHOqJMsV1LGfDC7UXARkXODRimHEWGlcQVWHynYzynbweRfLVLQac?=
 =?us-ascii?Q?Zn+TQrjIKulgelE4RDJ0yFIu+q0hOxsrvOaQMpHntjPuf6cYCRr7ABICOM2V?=
 =?us-ascii?Q?yYZwnswti3ABcLyJv88ehQ354hyDoWexB7l7c3rGdy5G9arnH/OwBDxA3k+Q?=
 =?us-ascii?Q?lIRWi4srx0P1w1+21NEyp0+pizINL3WElzMEYOEjgAYAuhvxX815OE/1G+PT?=
 =?us-ascii?Q?zf2QS4ip44EWShVdJd1VnwHe7QFZ9B2GBhtD77iWoKR+qbRI/d6pP/n6JkJ2?=
 =?us-ascii?Q?nGJC9M29uif0aHd6jn8UGdFnuiJtPSU7F1/IL+ax/OgnIEzTeEbgyj5r4id0?=
 =?us-ascii?Q?xuDedG1Y6s/1Ubf9XuRNMDIU9/dGTLjTAYWCtmOlVQ+qeaHdvfHuEH4ofRPV?=
 =?us-ascii?Q?4qcH1iDvNpwoJoQ6QocqQdJJibCbmqRAfAiszv6GagYb1FIIyV2STNenhYFB?=
 =?us-ascii?Q?WW8fY0znKEgyaOOwwqb8LpBywctEz++1BdfrGqTMHsg3iYulUOZYSPM9Ae1w?=
 =?us-ascii?Q?Nd2EhMZpm9AaTBjdlWZpwSSirLSjcBLBWBG8afUkoLY2hkYBLiibBhMFPY9y?=
 =?us-ascii?Q?zsFGYI6A0D65bC0IUznb4KYOoaZhsKE22cWJO/iDPOkmLrXer5vAnGcAdjzy?=
 =?us-ascii?Q?nZyJRIQWlSmFRro6p3KlTMGkEORo4M24HSBYzlzx3yVHEpDP58Pl2XSCzKc/?=
 =?us-ascii?Q?UOrENKnzKAK+rf5b+tqZ5d7+tu21wfyBzfIF8wMnrbMsXJJJDrYvmYNLyRGJ?=
 =?us-ascii?Q?ezMj5sgO4vw/sWamOPln/2hjnYLnVSkfnDBvYHyYFw5L0EZ6vCKYqoBMWuWA?=
 =?us-ascii?Q?NxvH6QTEVkNBz2Q4DgQ4JMpfn8CEnNTLt8752f1yUOR0SGrO8QJ20VKZ3oMQ?=
 =?us-ascii?Q?8FHwKf+AE50ugd+9QsqoMluvDTxZuFj5cgwMuaQqG6CKqf9Vy0Aa/Z8qMOMK?=
 =?us-ascii?Q?6AGNadd2WqFLh+3ec7r5uTJejlB2jVgeeZKghd1ZUXsxh/BLtFhpEaWamLVD?=
 =?us-ascii?Q?ig8cnqzyrJwg2Qy3QaDL7F/EXAshtOp3dyTDeF+datHOr4j0jqQqjy+D5bVU?=
 =?us-ascii?Q?IYiTlO6OanvAdkeepO7a6lZ9Q8wz+Bgwceyt9rPpAwliS4hY+hFfOuN8DZoj?=
 =?us-ascii?Q?mn7BjYhs5bhUU9AV14RoAs25V6sNkNYWRFz50coyaF2W4HHFJCt/6+IHg6/w?=
 =?us-ascii?Q?xCtMKaaoC+oBqGqrWhosu6n7G4qYBhnDULbpu1LGUXdTPJSoIW1teKI80i1H?=
 =?us-ascii?Q?Mqu5Zw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b3d0ea-b6d9-4b6a-49df-08d9bebaac3c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 04:32:01.3243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmxXo+wzkkKWBP6xj38hD3EKHxn9y2UmBU0ULOeQQxJmu2ljmB4CWqrTk6c9gIRe22/xUnrbT+L7UKahUMqSNqNCVBluX8EIBklQZ8G0gdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5771
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=987 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112140022
X-Proofpoint-GUID: H0B7doskgJ_SJtGz-rakAFTC6uC13pgf
X-Proofpoint-ORIG-GUID: H0B7doskgJ_SJtGz-rakAFTC6uC13pgf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> When building under -Warray-bounds, a warning is generated when casting
> a u32 into MAILBOX_t (which is larger). This warning is conservative, but
> it's not an unreasonable change to make to improve future robustness. Use
> a tagged struct_group that can refer to either the specific fields or
> the first u32 separately, silencing this warning:

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
