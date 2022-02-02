Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7E54A6B0D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 05:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244571AbiBBEs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 23:48:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60454 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231669AbiBBEs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 23:48:56 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120Dg6Q008551;
        Wed, 2 Feb 2022 04:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=BNt+InS4mmiyJ5iTXtCJv1cHO+Bb9JzAcF6+vcMAT/s=;
 b=vFLfHmfB8IIC7IXX1b8kDSQ6FJf26zskF/3xjtxR91N3BY97+Z6MmICijKMCCuS62I9V
 huFcl77iYN/qjqfEZn4UZgdZVluowA1HkX9YMxHLs9i+Yo+oreWrhJ+nOTVTsfn9T6AF
 RLboOd/YsF0yilN+jQkCcexuwO1KYHhpuor63c+MgYKtdmatNT+l/HXWrrxkq/sDZgft
 /etAQO7Cg5GcycqE++hy3eBr1OEzo3nV4q+zuw01TriGGRCoG3UKPlXZPyXKxZ3hp4cS
 xkxb7YhrPWm8l0BkSJ+iuuVL5P89dIrmPnwqzgaGoOTgqNsmALMqk6jyEC0/LnTceVLo MQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatw025-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 04:48:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2124jero135166;
        Wed, 2 Feb 2022 04:48:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3020.oracle.com with ESMTP id 3dvy1rcxb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 04:48:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJzySKB49o9XPqacd9fVk6hLa3h+WSNqXshKXYy1Fev970oJBjVsufE0aiosYoxjfSS0sH1+hA2WXeSqL9dSU2xI3haowVMkGmTE8N4yzuFukmyOq4/jlVkxgpKhhGu5iQ//bHdScr71ZST/Kd6Ryak6LNVk/Pl0ghfEFAFZooQZTgE/3ttkB5n8sz2RrLtr0fz7Ht7jBOSh+tSUm4xyg3Ks10nGqRI1OY7/E6+Ct8o0Ugi2NT2d16kntW1GW3kt8TPBOs96WYcA+ETNwEeFxMd3pqh3jlITS/7Fb79NcROCrtw0n5yNPf8HcfQK7/LZCDY/zyrd6cu3sA4KqNyf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNt+InS4mmiyJ5iTXtCJv1cHO+Bb9JzAcF6+vcMAT/s=;
 b=Ru/UWHMs/muOFqpvkMh5W5x6f6afYttvbBkITA6JM8jPMVjbyqx8tQlGDj6RlfBdecJ6QMju3rwWI2M5NvG/Izqg1aa3W76akT/1uX8vCTNXQBzMC7QnVnsOvK5TgmYQGIIXyCCxrBUDY6soSoTXuS/dEOxRia1EjTE1v8/PKR0+f+q/o9VyiTP4qD9IWTzT7+bdZNWjPrO1/j7MMaoPJ9I2RPO0zY+DkNsJ1dmah6WcwcmfqmFg4b9I0b3pcp6cyJsjJmkpgoOjG3xDc+Qev1vVOqzn+F2ihzRztnGMx3tu+Ljwhn0m5dSlYJMawbNXr3YoP789gbU7ckbTWYuNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNt+InS4mmiyJ5iTXtCJv1cHO+Bb9JzAcF6+vcMAT/s=;
 b=yeYkhkJ2cxETQmeOYOEcdbN/PfPisnArbkRRGa/zec74iAtW6RixIgrLQCnCUn3Fzlb+2+wQSqM19Vlo3WqmSrwVUPnh9A5wcxeShJYx3dD+eQpQMBEWmlyn0ngWzyiiXP1Wp53wrTsMKVbLVSeowbPIk8HFlRwmCo3eJSMvBiU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN6PR10MB2480.namprd10.prod.outlook.com (2603:10b6:805:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 04:48:39 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3%9]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 04:48:39 +0000
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv2 7/7] nvme: add support for enhanced metadata
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11r0l50x7.fsf@ca-mkp.ca.oracle.com>
References: <20220201190128.3075065-1-kbusch@kernel.org>
        <20220201190128.3075065-8-kbusch@kernel.org>
Date:   Tue, 01 Feb 2022 23:48:37 -0500
In-Reply-To: <20220201190128.3075065-8-kbusch@kernel.org> (Keith Busch's
        message of "Tue, 1 Feb 2022 11:01:28 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:806:6e::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b13b0cb-3c0f-4db2-0149-08d9e60747e7
X-MS-TrafficTypeDiagnostic: SN6PR10MB2480:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2480D01BB947303886F7E7FD8E279@SN6PR10MB2480.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEmjfhwK7ugn4O7O79koCwaEmNw6JjfS/Df/QXjp+ySlS0Fn8Vo8uGADTqn+RiJ9n20N4f7a1y2yR8RGW8P+gzrOqIyJrWM11CxD+EyyvK2j1O/xQq65dtMX6pi00st8gYVTE7w4+DIWylk0KSRd/H6YF/wXdjcoBSCCAgvRSQotYJS0nU89wqofxRuRMgxps5ayX2qSYkbsk3Eer4pEVnv7PkW/pRsMwwuEWkGa7WrBOOjvkiz1eyqlNBp8nQqCPeT04B6wkKskCzdrzFn0PMSb0wc5bDJ0MYSFWcRK+EU4rRClQN/VS/b2X5TTLNxtDah/TJTJ1p5LWTbshQJkXw3+qfwRV2I7m+bPJEuN3WKlmqF6bUseUA1FymRCDypg9902ddbpDcy+I3gguYJ3S6xaZYPocjHoaaUiP6gJcgUPUTa+NHzusd9mTinc93UiY8YXW+BrAASd6v5rCeF7pVhCo7KN10cHbVukj2KE3jYmcR1RptzIGzN1kd4w2/tvhVu/TiQFZSPc1m8Xa9sshK0gSzVVX1Uwvo/gU+PZTQYRiQ/xDNtvENcy4MidOyXgUxfGOJEk6+Ok0EqK2ZSvKdKyKJ9+798NfBjkhORfytM7i0f024YsNjg3AHrHGSYZs+58/JADUDZxxHP98eD4LuTNWDCehoh0fbawQQ55+rcws7L16ZSFOIG72WeGlzFInWLg9YCYY+oJIqN1IPVnkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(6916009)(4326008)(508600001)(38350700002)(6486002)(86362001)(8936002)(52116002)(6512007)(6506007)(36916002)(38100700002)(66946007)(66556008)(66476007)(558084003)(316002)(5660300002)(26005)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oJsIY3xcBj2PXDxA1Bw5YpIH/0p8zuVdIbqW+/pLJvJHVpYOOkpi5EfICaPJ?=
 =?us-ascii?Q?bOg38/mIhcNV5/XdaA3NltFaH2W2byBJ19ZkbdWVpmbqIWw+ZCZC1Yha7O3x?=
 =?us-ascii?Q?q8pvC/xgAUgDqKzOO7yAykPFFE1cOjbHyGZi+rcUThmH7N9AzlCl7P4Z+UDw?=
 =?us-ascii?Q?RuXt2HcZ4o5ceO+mTjNH1Z5WRvIu+c8/qDa+Nhe4nqSY6aXgwZXT6wLv5pNi?=
 =?us-ascii?Q?CkAwmMZq7cF+QHpQ73W1kaB4kNBCjJsT5ivdRN9KUtAd3akFnVV02S1Vxyrq?=
 =?us-ascii?Q?w9bbM4+Xl7ng5qg3ADVBSd/IUJSxTk67GwJ0RqIO6+UoHoyGltsyKhc1kUin?=
 =?us-ascii?Q?LBQpWBWajFhvwL+kjYX2bIuC1sIiCd846Q97d48f1euof39vSlpllvpQlwb7?=
 =?us-ascii?Q?OlbOu83P2jSNHRsDr2s1Q97LXzY50K1UWs12lT1aG4xUf5Jk8lq9m/PTpAgZ?=
 =?us-ascii?Q?WSHclbzJ/Qd4xQMXpebmbla33gOZtbXAZQjP3wGvaUreeNlTfFHiIX+Xo+AQ?=
 =?us-ascii?Q?p1QgYaoEhVpK3S2Te+JWir6/IIlUQZAsWHoix6J4zLzHrAFGo/xoJ3TrvEfQ?=
 =?us-ascii?Q?wKh3fU6XSFLL4PlpOMp73Rh0nXcpJgtycKrWr1yxX9Cz+Fy4y23d23Kzfpq9?=
 =?us-ascii?Q?bpJbR6uMxtrEQSXT91Tsc8/cLQ/fsY0p3TPL4qZMSCgKeGcaG9yak8St5YoW?=
 =?us-ascii?Q?TYJwZVt8jhWL+tKotVYVWBardYMuUkALv0TBkFRpRsPJUBFsQ+M+mn/aaSwr?=
 =?us-ascii?Q?VxuLc1lRKJxElQZZDTH6jqIcUtWFZxLUMOAXnrlCC4LSll0vhEKlqZrdX1BR?=
 =?us-ascii?Q?DgzYigT5u47byN8DaDTCxJ1qSKyJDChzldLv8fiowZtl9elHQt4/s6TsSiN5?=
 =?us-ascii?Q?A1m1arJijjxIw+qjJd7nBuDsHHQv7QRQL+Wja8+YCtKCYzBp45wsyDrlqzav?=
 =?us-ascii?Q?FTOxNksi4jb4keRLTaFXWoJEXkS3nXrUNo5DLQFfgmINKjMskO9ws11D+8fl?=
 =?us-ascii?Q?iAJW7CJ0JdnyuRq0g7uona6c6eVlY1QP6x/7wO7PoYm2J1zlR1gpeHGy83YH?=
 =?us-ascii?Q?DIGNgs04J4P7f2GpxQKgnyxKMBXEx2917dY8/WV7Etutygqt9QCnS+lW4inJ?=
 =?us-ascii?Q?/ul3FiDdvrATFWSQrKsBWV5+f0cegMSJH7eRnJa/4voSHxV0hsgPZtRcUD+M?=
 =?us-ascii?Q?zULr/IsAh4O/4k821fhpFzo7LJVo3zhNMMpxMalSG3o0ZVuFfR/ZplAnlgwP?=
 =?us-ascii?Q?DYrxzLX/rDNYi73ouyp4YpmL+mv9rsGHKn/g+UW3x7+oPLjUGaIKCxzlrv//?=
 =?us-ascii?Q?ZQD/eyQQcxckiDgjSxxldA1vzncFOpQYP2L77sXlmgdz4ghGEpkA9WaQSfFt?=
 =?us-ascii?Q?UZJEJ3/VH+84bHRrs5tLyv0ASsyJ9aRUZB1lWHXMfbb/Iqpg2aGsCc0wO3QI?=
 =?us-ascii?Q?KSzCjhlNWUN3COXOcPtRmvv8DaDQdupaxPFeX878bRc3BR9gHDTKOJG/jH3B?=
 =?us-ascii?Q?k+UPVTJ9t4K/LjPkpW0FDsLx4ysVTOlBPYY6ELzdv4ytE4Dchm/9/YrTZve7?=
 =?us-ascii?Q?ut5J/p9NlnhSq6auwGuGpaUw63NPXNHHvTb/Gh8SJQOBqrZ5I1rZ2Nsjg39q?=
 =?us-ascii?Q?NHuTtj4jNgWoBw8JlJw/fnZt7i9ErBmtx8uMVw9tr+t9chjtVj9WHF+CoBN4?=
 =?us-ascii?Q?EhPBmOajmuf9Bio29dnghDiUXJA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b13b0cb-3c0f-4db2-0149-08d9e60747e7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 04:48:39.6366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuoK/wmq4gQxRd2uyfHsVHzZLFp3V5P4mba1XVaiq/1gxQBaV7mEnR4l075PC55aHV8/7UW5NMx5Jw4tekl1sUw9Dt0Jjn/IYy8tXcq7Q6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2480
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=926 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020022
X-Proofpoint-GUID: Ianb9tWB_YAtlhFzSOFWIqivpR48htNI
X-Proofpoint-ORIG-GUID: Ianb9tWB_YAtlhFzSOFWIqivpR48htNI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keith,

> NVM Express ratified TP 4069 defines new protection information
> formats.  Implement support for the CRC64 guard tags.

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
