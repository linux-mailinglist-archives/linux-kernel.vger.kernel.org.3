Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34620473C05
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbhLNEea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:34:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30762 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229513AbhLNEe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:34:27 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BE1niCt021570;
        Tue, 14 Dec 2021 04:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=GBLBvgl9Pieodofovf6FygiL3ax2vfPlZkr7qGii6dA=;
 b=be/kP1hWrqRQ/HCHGDHWBJNNxYBp6spcX7qa5oDUv7B+96wEdcphuJmGklI0lLbnvumM
 Elnqi+QndpygMpzB1Cv6KGPAqf8u6yNP53UUy5BU8G1fPvPsMZanZ/7WsLcSk25ITSOs
 LQvFQHYIA+xJQgkRwKAvYz7NA7lgfZFfbJrEAOqOXBQhNpdCFjYQQhfMV+rQvdOf0bil
 T8leE3cpg14s0NTpccu93SBKNtOUgubcPjcKrB53Mr1UYpZDHzR1n+Lyy6672JymM/h8
 8PvfZgXEDbN1In9JH+teLa525mNP3M3SFYieSJ9lvQBpDwmSIjfM5L/DZtwIDq2DHQYY HA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3ukakrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 04:34:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE4PWuF008362;
        Tue, 14 Dec 2021 04:34:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 3cvh3wp09y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 04:34:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2JcGLEiOpOxBAkWcXYXutF8KezKc5bExEBU+BbOZiRPYLr1j/JIQlIubhmHLsAy2DfjfAJBdQAoZNRTXcBFMEBVSEOodfoAXwft88ebFtMZfmx2LtLJvigf9IkK+Mt5BUEMr4FGnkSQFx96omEDDbsH5SoaXMcGgIjwM2yMhiUi2yzJ352vzssNRTQ9CI5wk7nfUMIszh36tDUwlM9R6ylVSQ88+4hON6zve4e3Tt5YEyJ2liJy6ES90QV3HIplT1K+3jna+a9qw/3oH302yLXbDH88tXfWBVkqJLuouVgKZ/4sMyjbZZwy+KF4PFyVZvgYo8yR9xduODnjKYSoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBLBvgl9Pieodofovf6FygiL3ax2vfPlZkr7qGii6dA=;
 b=eH17Sia7vX9mN4UfCRulrphZJE8ozE9inlN54zswOUBEArQvweeO/Jfs0YKjLdpiWPyWrG7Vin/G2lH0uwN3EUh2Io18sFmkFuTdCRMsUxow5ZfrrLNzk0zkHMSefngQ6h73595huNGPrpTLrxLHT4LsNN3d6w0dCzzI366rsQ6Ud3UfzDUipQzeomd6opt/E6z1ZWlzSWvzZB9LiVxGPBYaHFtmtFEIGGbLxSPTFULScduE3u6Pt/q3t86aeUbZFlSIsO2KvQ8ckSazUMd5M2znt+yV+LE3pGVEuwiCFRbEM0Rx0Jm/EREDPS68+sbRCUa552fogwBQFK43ZsYmaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBLBvgl9Pieodofovf6FygiL3ax2vfPlZkr7qGii6dA=;
 b=tbdAg2YIIVVnwlmkvn2QrLMUVJy4bgsGMp8VdosvMD69VnHIwHMVuUH7lpcixHSFAn7fqMhnV0FHyZdo5MpV4II3yNEDhc0m8Ki0xOyqnM81AdDCIAhNOTdOKNkVjgVANoUIY2f0m6fVKaxguuyEfP1GAQbSMyImYxSAGdEDToA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5468.namprd10.prod.outlook.com (2603:10b6:510:e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 14 Dec
 2021 04:34:20 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e%6]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 04:34:20 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     don.brace@microchip.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, storagedev@microchip.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: hpsa: Remove an unused variable in
 'hpsa_update_scsi_devices()'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mtl3oldu.fsf@ca-mkp.ca.oracle.com>
References: <9f80ea569867b5f7ae1e0f99d656e5a8bacad34e.1639084205.git.christophe.jaillet@wanadoo.fr>
Date:   Mon, 13 Dec 2021 23:34:18 -0500
In-Reply-To: <9f80ea569867b5f7ae1e0f99d656e5a8bacad34e.1639084205.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Thu, 9 Dec 2021 22:11:56 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0178.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fdfd88a-9e31-4b1a-3e58-08d9bebafef4
X-MS-TrafficTypeDiagnostic: PH0PR10MB5468:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB54682083D9F8AA6A39393DF98E759@PH0PR10MB5468.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTkZcn5/xlEh7QV9j9bdmw1Z7TFTP8vE02PD9qb68snNK7KNrWHVBbmEHVFUVM0L66v1EfhD8+mfdKTtGxMrlFGhlo8MMs3O1tZNkKyFIHNFQpUx4LEjWPdoHuFVmDJT2FrCP1GBwWF64C+RD+G1JIiZVLbx7KWZqXfCKGH9Tx68/Sns/Ha85FpqKXEhxudRsauzekTPBQZyOpQxW7DYkrdhE9f+QnNu4aDJfigtTM1C+absW/6G3cNjTxbSq1n2v4UQ9Fl/OpoQrfv1U1ZmE+xgBWi/e3ozlAKsAagwIc1zHi1SuaOdneYhtmH+t9iK6Hr/9ZjB2SYvD0ARu03bwhH/r4xW3HldEchRWkCRkVhBS1bZkOijGAcSLjP9S1zd+ele8JYOCNjKWieEIibU0+hvycJLFPP2Yqs0dCxrW11Q29oI5HstbS6caQ1YNdkvNTHIpnhssfj/aNxSe5bz5R/GIGxKiprQENBBj6fFWTRD5SUbfBSlv6Doh3j/JIt/mOqX62IYQv4Y6aSEtznWqZEe/oJ6yERRG/P5TK455jLXF7vv5pkB6pU4816ti4sAXRTICXM7FjRjykxfXHoEx17WojesgH/4GbJ/POaXSijWhYcBoypf72qcd0aRIpx5ijNkD8SCf6zmU0zoH7l4AM1FoqVieLo67cHDLzp0KHUPMV9FT7LTPpe/Y98yG8UIDaQlz831hPUgQW3KTMDaJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(2906002)(8676002)(52116002)(26005)(66556008)(36916002)(8936002)(66946007)(6486002)(316002)(66476007)(508600001)(5660300002)(558084003)(186003)(6506007)(38100700002)(38350700002)(86362001)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FL61wYOGzpf1dU+YUttihdXQqd0CyBMX8WU88wSKWaa4GH1GvEOG/cPm7+j5?=
 =?us-ascii?Q?MVlCRsIUpil5vrgrlVFRoUU7MNe+vExb8S0pP1jhBwPK/zq9pqxH/Y8SOuHj?=
 =?us-ascii?Q?l9UY/5Qads6jG17NlpzgA6NkOp+3MxwgYtH+KY+/yc3SwWTXV7rlSS+e21y8?=
 =?us-ascii?Q?cS+Vj9kIIRjcdmKD0+Hq+ehw0Omiaw/FWIZexjzoeSF6r+6J5dnfYgSfLc4y?=
 =?us-ascii?Q?nhmAz0/xx/kQod/Nn23CuYc24fd+Ux9bV1YzMdxIYW/1esjSu1wfZKEC4Hnc?=
 =?us-ascii?Q?lyFe8D5Ra/y0gUaBA81BVXNyqBb5xRJhcnAvCGe32gocOfgcxMUUwFK6mC7Z?=
 =?us-ascii?Q?RPZEaVcWSZ5P/38vpazZTU2M7VLbqTY7aDQvvKCDwkYM0ySyR6dSi3ZlZpFI?=
 =?us-ascii?Q?DRJNg8cf2vfHAy2Y8DSEvDcIKXRuBDw99oDpZ0Wr7yhzf+hJ7j/5Kgq0PEF4?=
 =?us-ascii?Q?BolI2Wv+kqh5xiOenJF5zla+KrWyy3UvELANrgfsHrpH9pKIxnoC9p09uiTG?=
 =?us-ascii?Q?zax6Jf5bVioNQTDAPr+Zt0DYgddBAtgpAXBPWmirdImkJvXn68JtONv/phq9?=
 =?us-ascii?Q?9VtQK084THaAOBtpFPcdEMuH+mF54MKsecUJhkP6N8u7UIXuZ2iVctbdit/8?=
 =?us-ascii?Q?E6LqSC0xoCvjnwgzbj7Q04Oow1gO2HY7KEzow7J1S68Tjjmblf3Yz3UwIZjf?=
 =?us-ascii?Q?lTjnLI3WMQvCi8quRxsM5UfVpRBjRQLZ2dKCTcgauiHQs/19XuNB+E7g6FiX?=
 =?us-ascii?Q?FQ5gmY3Mt1b4WPCvbEJZ2aFyt7m/5hKOyvKwh7TNzQ+1K0zlS43JbqLCIrOR?=
 =?us-ascii?Q?zjGFLBFAlQs+fe00RZKef0oTXkd4bLlOLkyEFhbYm3cCbq9j0ELxKFgRLTbr?=
 =?us-ascii?Q?Pj1icR4FicG0yGXgIZ6OLkFNS5CgFxQHxJ9URxR/e0Jxn/+5OlKrJBruV/uv?=
 =?us-ascii?Q?KjyQhyVVbQPU0NqJWMmE+SokyXb1bijL/GftdGnDCH+qqf2zk/kN0DwU3CRk?=
 =?us-ascii?Q?o5KHUBHnNEml2myXKyQWwkesR+Ku07srrF7drYaQGwCuSXSGjgYOblKhQIRd?=
 =?us-ascii?Q?cxS9S4UEroNc8a4Gt4iYb8TC3YhKGpgTV7tFgsKIhqyw9Ih3KD2XBW0S3MhW?=
 =?us-ascii?Q?+Bk1puUtH6yVWginVq43Bu2RqTl7+laBMLwrjrNU1AmH2L+3fZGTkRCNVEJz?=
 =?us-ascii?Q?+D+kBVCLFAYUzSbidR6CuHVX70Y5x4c0MuQvNvZ7Fatb1zMNAGgbWqL7i1j9?=
 =?us-ascii?Q?V1KIn4dmUP4OnqPV4b0Tt80VcKg60pU3zyct7C0accz+WRiBCaM4+pufa8Of?=
 =?us-ascii?Q?p4YVfxaGAQXwL68d0fDsedK6ZCUrQdGXjcSE3WJpqmAN3a0Q4pExnn7kT9YF?=
 =?us-ascii?Q?U9T4Lpba9HNP+sWEJbQtElFluWie0ueCuN4SGL0g33Hp8XfxKRhJL3uk0L3C?=
 =?us-ascii?Q?sTM+7Z017Qz2hHrSbaPGLA6BxUdAukQhLdDpq0HUTbb/wYmQTI/Cuax62pPj?=
 =?us-ascii?Q?YZEfqUH9wxGT9IfQpVMKFeeFZy2bxx3E5a1/l+faoppQN3dRyc6rflujZrtI?=
 =?us-ascii?Q?RbvgmD5kyBDlN7s2nUOy0oyxnkIbTKlTWeWVUfIQt8PxomubmCZXPwcpQ5PO?=
 =?us-ascii?Q?nAQCrthBtzRRnNkpfiacUq+deylPfjwpIRt7zgY9hgvxcxi1IpKyBprTKSDX?=
 =?us-ascii?Q?QuGrgg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdfd88a-9e31-4b1a-3e58-08d9bebafef4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 04:34:20.1186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bKcxk0sIecrfn5sDJSsgJc4TkAY2eJ0falfDRVntLF1GaiIi8WJU0MVh7H5nV/WrxYYN5iKDO66PFsl0InqCxHHMeT8XEpS7T1javYQZWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5468
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=866 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112140022
X-Proofpoint-GUID: haE3Bxtchh8Vz8uUzmkLVqtgPIykL5yv
X-Proofpoint-ORIG-GUID: haE3Bxtchh8Vz8uUzmkLVqtgPIykL5yv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> 'lunzerobits' is unused. Remove it.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
