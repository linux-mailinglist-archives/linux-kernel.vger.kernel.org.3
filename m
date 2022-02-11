Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F0D4B3027
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353977AbiBKWKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:10:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242929AbiBKWKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:10:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2ADCF9;
        Fri, 11 Feb 2022 14:10:19 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BL0n16006473;
        Fri, 11 Feb 2022 22:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=JOcmOul5U/oEA7NbQR/gzggEi7KA61XdSiMS9HMJsek=;
 b=td0uZMjHpnAcP9A5O4TjP9tIYi/F2ia/UkMzdP+Qmxi6HEKErnqkkfOm1hBR+YYfQfqW
 IdCHb4FhYgaw9o4w0+BCafYDNjNdNH3b21+pIVkEvWVgsd/MlEBawCo2y5pnAxf3ArWr
 sVzvMsyBq1An2jlxpLl6gH7Ssdmp++H7R/sVbxkcfXTjfJBjYa965ql3fOCE5ml7AL/L
 jOW2SKJSXUGiY/DY7G45zyTWMJ4YE3adqEskhCv4QHORbb9Z7fC4Bma/lB8Zmg3LXi/l
 ykkMEES5VWELk9p+K1mI7Bj4IzwohUxpBvY4XQ3ZTsM5YfIzCtHva/vzftB8i3EEK04E /w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e5t7ks155-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 22:10:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BM5xpg147843;
        Fri, 11 Feb 2022 22:10:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3030.oracle.com with ESMTP id 3e1ec849sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 22:10:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3Zt2OKVBzaQbSFBxEIhg7e8giWzKuBQbXPzbx8i3DjtnmZO8DzJ64sD05OwD20Eqx0Mg+KbwA5KZZcxiXHlXjSU5UH43C6l+5wtmPok7zuRTzLKYgeI6h+5FEjpjVR6CT2LKKO+ZXcu7x0SauIHhvib1xAntmTzYwiVOcUih5tG/a4S5mtceU2G0tuOe0eGMYY8TazJIkTYeX2lTe2RwnWmGJbCpFdKyNii74hPh+3dnx4Bc9rVSqx7ltfv5NAht6YbJgjwFipcmG9VNCGWPZc6i/cGzuM7VHGBBnApZ4gHygi94uHk02Pb+T2Oeg9q1d5SUiFl7b4ENKKu65h5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOcmOul5U/oEA7NbQR/gzggEi7KA61XdSiMS9HMJsek=;
 b=fWgc5XfpiqFi3U91UZjFWkBYwz3sohk+9nkDpeJzlmeQ+1+FzPLSbBme2gq7GwwpeqNvRyrQwyRQoj0Fnuk8RJEah/X4YLTKJ851x31QSTe4DpChZlU3Sz5tIkaURGyoeBLa6yX8y8WEi1qFfNdPRTWoEL02Vtz/j4DtT25iPBqBlYi0/mVLKHVMgd6yfVMYX9JmyxaySw87yumuWFprzIu54QoIY0n2G3B037sXGoRzVlaepx/KE73LLcWH/19D8DUaG8ykSiGdW27oGZFY6RqBQn6ydn5CYXXimJzviXFsIBkvmDNyqe77npt/n+ZxHRExcF7SSss4WxCO9QOZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOcmOul5U/oEA7NbQR/gzggEi7KA61XdSiMS9HMJsek=;
 b=wnrKSAE6uVjy7MPoWv0lFp5JUOGF3eWwJRFynD+KPM82Ov6Kb4+qPS6h7dOkIFDuxtkGCJvPIaobfEwPwjDtbT1rRqSNssVBcQP3S5g2ANWS8eC9KfWS9xgely+mHXPu0QkeLKYccaBNeEKk2d0BW5/bm9fWRJvXiIaMkvgNIRQ=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by CY4PR10MB1559.namprd10.prod.outlook.com (2603:10b6:903:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 22:10:11 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::40f6:dc10:6073:2090]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::40f6:dc10:6073:2090%5]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 22:10:11 +0000
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        kernel-janitors@vger.kernel.org,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] [SCSI] mptfusion: use GFP_KERNEL
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ee49oy13.fsf@ca-mkp.ca.oracle.com>
References: <20220210204223.104181-1-Julia.Lawall@inria.fr>
        <20220210204223.104181-9-Julia.Lawall@inria.fr>
Date:   Fri, 11 Feb 2022 17:10:08 -0500
In-Reply-To: <20220210204223.104181-9-Julia.Lawall@inria.fr> (Julia Lawall's
        message of "Thu, 10 Feb 2022 21:42:22 +0100")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0076.namprd07.prod.outlook.com
 (2603:10b6:5:337::9) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2763037c-d70d-4757-2153-08d9edab45b1
X-MS-TrafficTypeDiagnostic: CY4PR10MB1559:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB15594A41A783A25AA5B6F4C58E309@CY4PR10MB1559.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKM6EGwPljESzlmaFhPhrf9XQqugJQt3X7+UIGbJEZslooKBnGDVjvPKpIlQQrdxEDT/WiUcrXI99Wz1po/GAQS+7oT5hwawN+o19A3fR9lUfKMvSd3NfP2C1SHBteq5SvtB8gDcTUd7+ajCgwh1GPhKNAW4+tc/jhmhM87/K/Ywz+R9fhU7DuPuev5BFePcCR8UL4waoH2b2W8L5gacFkzvi9iuFLKwnGWi15DM9KSnDzb11uIiwH8D3vYL1WYCnJUFFPg+BS9Po1N6Y3xlSoGciPNauJ07uld59zkXkHX/+xaRKeGkSydsY7oOT9pHuQq7dmCy+MStTWDfP29mH4kKjgzDWIicJEaH3M9XlbRQD9I+/+b3N0muzcgIq8h2eMBIuXeMAYrFMoB7GEQWXRk2V4Z2T6lsoHh7WtedxMgd1Q0iXMv+9aQmu5rpoLi9DVGOcofJIXyugRIbAIqmt5ndVzJ6BwH2m0foMeh2gPsNkVSae644iHSB3iKohB4mHULFfHk/fQEgbRvSW/pXlcPoIxIAWpvf4L7ZMr2UJLSmAn6e8KjCIbUS6wV01rPnEidmLvGueXV0ZsaM/Srmu1xTefk/4HvF6GnS882NWMfsg0i/GS9yTXDY22tmgs2dfzHF6dZGQ6L4Xeg945XmVFjvwzWwFvqtYqSCUAt0KuiO8NePE4lVLelqJZyFGBob6saDu4iZxSj6NO4H3PYoaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(36916002)(2906002)(26005)(6512007)(86362001)(8936002)(6506007)(52116002)(5660300002)(38100700002)(186003)(38350700002)(508600001)(558084003)(6666004)(54906003)(8676002)(6916009)(66556008)(316002)(66476007)(66946007)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?beyr046L0UE1bmsOKdDMlVKrEZdmLtwhfmAy0dZO3plRDzaYi4p9GSJaPstL?=
 =?us-ascii?Q?p6MLB/iBIMyVNTk3VYifJ32XYfe54JBdwZ8p+LoNJwQ+esul+yUXvCcy7m0q?=
 =?us-ascii?Q?U67AsqnMb9wd/UPttavL0RA4+5S0GTIfiNxRST2KbgtwmN5XlG8kOa4ittxu?=
 =?us-ascii?Q?/HD9I9ztnRqtBPyN/VvZiZ/ytMZEN24oe6DCFp/ccrPM598J7eLhEzOdoXcJ?=
 =?us-ascii?Q?tP8PcnoHpftsV4HLj+0q3VWc5foU6lA1cuw4dam7UeLqcw7kShgdYg7y2sVm?=
 =?us-ascii?Q?tKnvP0d5WnvPfMl4fxBXoHzV7jzi6WPyzr59DXgRof+qEjoO3Oe43w9+c/6y?=
 =?us-ascii?Q?mh4Yq9mEcu4o7JpP7TXdWDeaJxZxxrpQfdsYwlyWH9eP9HVsphYCF9GHHGM6?=
 =?us-ascii?Q?wRx1bkJJ73mg2nZMP1IY9Am6HPsMre//SjedsIumBbfY8ShY7mjE8lw2CwiT?=
 =?us-ascii?Q?nbId8OHSaxSbW6kmFqmuiLznt/PTTRqShMl0QpOpteQXu2SlQzBvmvZLzY1C?=
 =?us-ascii?Q?7F88CyZ8Gr5y7OmVvtKAjd/YhxpcIPHHh2W1jp2uhy+zgPn/XFvdN7Cq6oxa?=
 =?us-ascii?Q?bYLcfHd9hsX3b/LFQ5/LPpcDRSS0E7ufJzUz+b+H4oaq14C+6LMhGFGVw/LB?=
 =?us-ascii?Q?zsCReUyz8QeOZkBIwHy+OEpAOPghb0ReS61gsCzaoGoBaBSeiyzppwA/hP2w?=
 =?us-ascii?Q?L/3xrK5GPezJKAc/mgNOopnaxtJ8AJf+Z5y6JzwaaYH/yCvlmMBJf6iApqxU?=
 =?us-ascii?Q?q1T7wFYWQ3mjOjh8Sd5I2DirTkS8jym2BXegLE2PK9NRSW206PI7UwBtZ1pK?=
 =?us-ascii?Q?g6xeOLa3wQCK57cdytJzaH6OfSK+IUlhnNL+KuOTCxU9EIJOF6uo4XAVK/Zd?=
 =?us-ascii?Q?vxdmU9YjD0b5qBx3Psz3y09y0NQ/wzHN7ZrySdVyMelZ6oXJxqAPRrBRUVWw?=
 =?us-ascii?Q?3qvn7sGs6nipfXRlNNf3vn9wbDxGberGec0mwJHbH2AQgDbUhdrJqUH1OOIb?=
 =?us-ascii?Q?uDmgg/8g9yIR/UIDJ2jvpIxMikvRUegFBb4mLd57fgiJTZgI5MBMzTNotYMt?=
 =?us-ascii?Q?PkO0dve++VwtSVNES2L8VwIZc+Gt9MkiKuzl4ql2YaQLWfXXncKy7CrIcMS1?=
 =?us-ascii?Q?0KUL9ILpudg5N9AIra874RN9AVEW3lJQA1poKWLTpYLKGWS1Gxxh6oETq3Ew?=
 =?us-ascii?Q?1istNkusyg/oyYrMddV5UVegtSfiYYZaRK39z9iKUMuaCXHW6EhgMsJ8cxQH?=
 =?us-ascii?Q?/nqPhHVF6ItDDeQqDCVN81+Mu7qKz9qZfDpDIMxeAEL1In9cRVPwvOufhRKf?=
 =?us-ascii?Q?MiXPFy9MivfX08H6rxtvCcN3f6KPhl7/qIu+y+JOvcNeHjvOo4JdCsJKq468?=
 =?us-ascii?Q?NAzvG3+MjA8mWAN7h7juI5Esb5pDAuHHtwia1NhWi3L+7ahT/6F8vjHPByCI?=
 =?us-ascii?Q?UCt62OzyAk+wKMpkuA5+TSj0G84SnZZJLvJxmRrGcEfFAxOGvVLJSBiyOEZi?=
 =?us-ascii?Q?mcSa7LU422cdywHjnI9iXXaq693AvBTBzywoLh8NcI80i6+epma0F4dprQmi?=
 =?us-ascii?Q?gyofPAGXaLvzLiW1JrBm6xkWjr+KhTekwLo14EWzr9EgjQnWsigGOCsNZZRu?=
 =?us-ascii?Q?8C0rrhG9H98iPCeY+WPUYveGzzyhG+W9+tbVvk14M5c2wMgm56L/zvHgB2Tk?=
 =?us-ascii?Q?Jak07A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2763037c-d70d-4757-2153-08d9edab45b1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 22:10:11.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIJMQtd5puan5NxxOvehG/aD8CYvHDzSl3TKIiCYw/rvHxqSli0viRBg6QiYp0YvUNDAUK1czUtdeWjwagFlnW8TTwVKLtpJ2VQ3L8w3VIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1559
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10255 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=729 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202110111
X-Proofpoint-GUID: U9NJ6G_hJUulxuTZCfapiLEKZlywZCMW
X-Proofpoint-ORIG-GUID: U9NJ6G_hJUulxuTZCfapiLEKZlywZCMW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Julia,

> Pci_driver probe functions aren't called with locks held and thus
> don't need GFP_ATOMIC. Use GFP_KERNEL instead.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
