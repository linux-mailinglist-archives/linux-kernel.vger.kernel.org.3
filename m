Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140A346B14A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhLGDQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:16:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6894 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhLGDQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:16:49 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5HpV012536;
        Tue, 7 Dec 2021 03:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ZebQlF64jrTcN9EJJsMkMvyunysQZ55J1D4EpOGI7vQ=;
 b=uy0tE+HXM5ahRvJM+1Atqc0XR7y1tLE5sYL6KQK8NNXcQZG4F4ZaKzWWXfJAACdlGe8E
 l1XwP6NE6SdWzyeL698vTfbetKBjY7+p1u7aJIdtC7krOlOAcnjadC3GMTuZaRvA4K29
 6di23eLAb4EmXW2buadK8t+gACCal4JV1hYSkZ1AQL0xdv5SHe6eOKeuUR9pEFDblzgO
 R6mI+Y/108cGQjp3nQ5KgNkDCiBpfQVZuBgZozzdCyfhNVy813Xn6Ght7SuEJw/P4pks
 cJDIkSiDOcwLN9olaBlM8z4YgVyIPaglRjbIPtf5Sx1PVkE0AuZy++fHPBfsmNJ1OCxz 2Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csc72c43g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 03:13:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B73BESa013635;
        Tue, 7 Dec 2021 03:13:12 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by aserp3030.oracle.com with ESMTP id 3csc4sp6b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 03:13:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWG1RjFgoUrBQdirB/6rzZABhzIFq9WIbfzZQSw/RCSdoCunIqlY1qmS9owUdgTUnQc2cOXT/J89ZEEug+019DMybgPbiuo95vqDypnWQDlro9033peQoaWx8SGURdZeXtCh2ohuaSCpG8mjWLI4MpmJO5Bj1xnKxzEfJNpgJUepgl6Sy76nfnU76VNhsvoz0uBfh1aK91dtlKRWHh9TvZRFH4ByASQuzdAxmT4+J4cR4uaLWURcD773cMESJfj1ghL+h+Gw+eqSbyb77uR1DSF7kD2DhtdjaqDr2YoCoffp/0SyZhV1ia3Kd4hG6p1LWNqVKuPwNBY/KpZaoNNGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZebQlF64jrTcN9EJJsMkMvyunysQZ55J1D4EpOGI7vQ=;
 b=QyolppCUKrZkWSkMkcoTARlwJCQE0YiI3OqHHWz/9NOTia/k5DR5dc4x368BCBLTlGnuFGwSUEjjMlAQIKt3LnLpro9j8TGlec5YuDZ0CzcCeyDEPfJ2NlL2O/aUF+7A7b7E+i4WAhNqfhS5OZnmkKqIPBgphPYFXW99hQkmr7y1sIsCqs+cZ5+D3Z/2t7frbJ7MZh3JV/eNHsq649U7MEoCTmJXCtYfWH+w3duB5918wjFYz8CLkGhin/a9fl8JO6H4iwnLDrduEWg2NfWqzypuidQGW9nuFs9D80bFFhIJnSkd9V1CK+G6cumf4VnmOlXTc4MchLwmZNEfTFqxqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZebQlF64jrTcN9EJJsMkMvyunysQZ55J1D4EpOGI7vQ=;
 b=fvLn032/T6PgapXu7Tdnjs/XBObKQrWqbS52KJ0gFUH1+rfZ4+anVKjPJ64LIc1sPn1ZJqeJ+08t1UW7oiQ6MuvWR/CK6nLLSCCgB2PPsOWu9fbN2KIeC19lAfYvybNJB1JKu8+Xq5fWqyQ702dTwq4FPqCDCAxBs92o8gWnyV0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4455.namprd10.prod.outlook.com (2603:10b6:510:36::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 03:13:11 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 03:13:11 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     john.garry@huawei.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] scsi: hisi_sas: Use devm_bitmap_zalloc() when
 applicable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17dchumyo.fsf@ca-mkp.ca.oracle.com>
References: <4afa3f71e66c941c660627c7f5b0223b51968ebb.1637961191.git.christophe.jaillet@wanadoo.fr>
Date:   Mon, 06 Dec 2021 22:13:09 -0500
In-Reply-To: <4afa3f71e66c941c660627c7f5b0223b51968ebb.1637961191.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Fri, 26 Nov 2021 22:15:21 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0016.namprd05.prod.outlook.com
 (2603:10b6:803:40::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.56) by SN4PR0501CA0016.namprd05.prod.outlook.com (2603:10b6:803:40::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Tue, 7 Dec 2021 03:13:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee854b24-8509-40f5-f46a-08d9b92f8013
X-MS-TrafficTypeDiagnostic: PH0PR10MB4455:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB445505266097261A15CFA5B38E6E9@PH0PR10MB4455.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqqyr1wSpzRl8QPR+Vqs4Cg86kvmBBTYgLl1J1DNNLfJAUxQwP9tS2eLNLK4gnIlGLisXTSQvlLv41z8NvL8EcpxzLyFYEiPbyiCPAPFvlfhheh6Q3JRjC5BmwzkKaLPW+dwmT0u8REOqLezgjhiT1ERZZQMGp3xQGNfP1OcQICKJ+7lezzthnuVhyNvxLejD8Tvm64wgbQql9vU17QpnnZiUhfNKJHvs9EszluKszIlA6tViX85t0ccCPNYThmndS8ti4u2Foj/lzMkdrrfdkb+F0mwi0oj0n4A64Bwh75RD6KAYmCkyh8L34ZQslqFxWNVdLad9i5BLxNv2y0wHaSC7kjS6mp3axEDsnd4odJvHyZiPndIHHqVESDJhitmltvN2WgEuuJ6VVAOSAIa9YYZlcHKY7fkS6A7p5vZhyCPB1BFm1zZlpIvWtPeC+HMwJh4b/QQMfLV+qiqL8MwCzo6c8GsNEqX4HL1OkCxRpfbYxq+xR/Dd+x38eSWOoi9+F5z8OQWh18zuoMwJ43DiWhrTnmhtz90bd0cTAlI2+lWgk5WyBqcChNXPwY8isrjXbIzfbmUg3i512PgczpVypXNttnHMO7T5Tt8AkPk2laF/+BtIkB3t4y4PTSrMXJ69v8AfkOVpuRztT3W1pLH8eZa3hVl8vNgIVn4G26hsZ9SmWD1ljPl+nVeA/Qztol4Fo+XkB4zyMrmCFyoH06/cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(558084003)(8676002)(316002)(508600001)(186003)(8936002)(2906002)(36916002)(52116002)(7696005)(5660300002)(66556008)(66476007)(66946007)(6916009)(956004)(38350700002)(38100700002)(4326008)(86362001)(55016003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uZ7uo7jnC0fAa7A2+N2Um9LZ5GVLUBjw7gy1Fv1TB/bKpXfVpq14lW7innkD?=
 =?us-ascii?Q?0fqDigSmFsZG+dccpuZTCE+a5+75FoPKQiEWvC6hjenpkn+By4L2pRBJzDb0?=
 =?us-ascii?Q?0EbO8Z09QyqiQnDtu4mDJkYh3OmGVdJoEmEaWFAVpjX5hNf65dAdv3J503zY?=
 =?us-ascii?Q?/dOoHlI0eD8740/uq+6fqhbI4iVhKFB31Un4h3+TE4cuGoNkvlgHigsvzeYJ?=
 =?us-ascii?Q?uzkUUwCWLgQBUPVOJrm6ZKeAt3t7Uq8qm9sY3dHYznMg69zZNL6XhvUtqjey?=
 =?us-ascii?Q?KrqezQiRfj1vHCkAEHoj5K2r3zpPogLeDj6zWa7a4BQM6wijoFHufsQFbmcj?=
 =?us-ascii?Q?1nvi+wTqNdnnrGIdplMOCel3LolaO/WT5rqgTvMEoJI3tY8f3i07PbhgSOsr?=
 =?us-ascii?Q?ZyK1GGi8LqNMRICAkHIN1hV9nE9L96d9MdGu5Zmr+TdvYL9gJAKv9heCdYoK?=
 =?us-ascii?Q?ykUvOcEuO+1WBnJRcyOzk/vzeeFLVd0ugg0am0j6bUleFPsD0GtUL0NYGslU?=
 =?us-ascii?Q?FTejS9ojQn/LA1uDXsGCk0NEQmrmRgiL4ALLL5KTTs17XIuSpSVJODRQ26Dt?=
 =?us-ascii?Q?q0zuaPLmpX0GuGw7wrpdA5z0m86nCvyvTjyrYpvBHSIs0WkzxyKQAZY3B9V5?=
 =?us-ascii?Q?H5OR+TSdkKCJKVQlMrEdpwzQQomlWO5fz1I8wZwQPJwgYECBop82r6mADQhE?=
 =?us-ascii?Q?24jFMdgGc4V9IRHyvT1h3ltnKhgaVVEqFn/aimltTgri9fNgoN3ShYzl8tXs?=
 =?us-ascii?Q?djAredvzN1Vybc1TbFOv3vyRyeSABympbblGMxgV9M0SEO9rv04SLcjGdfWw?=
 =?us-ascii?Q?ZykfWGu4mPEOy5hiQ16R+uKYU/RuuMOf2ubgMuyPJD0uNbXZd7XhIJr8hqUK?=
 =?us-ascii?Q?cy52lp65BeOjsUze4uoN4BCZA5YhhjymAA3XpM5OizvS07eHhkCS37F/VY1B?=
 =?us-ascii?Q?/hEk/P2BgDGJeuEATGQoU0vKXc/L3yF6qaDvW/9tAyisDZGaJL5yEUEqAaGt?=
 =?us-ascii?Q?N++vY54uNFfHx+5BOgU5KMpuJ5CfrE6tuUarP7YBw341M8wr0J7A5HAaA6pM?=
 =?us-ascii?Q?+aVpOnq1KkItNkmL0rbg0zEK7UA94ylWossjemtwid0vMkHm42Fut5QFOCY2?=
 =?us-ascii?Q?1ZnNIx3B6ZmyVvkLEhCxR3NOjeu9v80l6SYtr0N1K7b6VUoOCSBs3CaGFHT2?=
 =?us-ascii?Q?i06kbVFZkYf9MY4jxg2J7qXYSdqju6uUX2Bzgd2fwi/4BXizeKGLpHXWKaRq?=
 =?us-ascii?Q?ZoXccBV+L3+Lu4OjSQiHReZLxqBZt/zcaOGJ3q8uy3QTsElyETM/UBgqfjgB?=
 =?us-ascii?Q?5q3gq6iDCUQ9OW/QSphgKUVN0IRDw1EM1jXrkotILJu1Sa+Q/7Sew3Y3G2c9?=
 =?us-ascii?Q?1+Ho0QMQLQMql8kapePDFqIfpBdOHuL82FwRJPlKcLqJE9Dqr7PRr0Q0YiCy?=
 =?us-ascii?Q?T52rAmNyNIgJWtm6yNg5HrcBLjpd9PzYjI8s85XLU7L69zdmHdEcl0iNJfm6?=
 =?us-ascii?Q?PGzRF2rxGsy40o6A8tvBrsezGorlhTuxo1h1dpdPR9l/wnre5VUvb9yAgEDu?=
 =?us-ascii?Q?t+cXVRK/dYXY9lhqLaDteN0c/touWUkCPWX65PagiCcJiCskMoC1iUHx2tBJ?=
 =?us-ascii?Q?ouJwXwQn9iKz99eqmwcDlVda+pT23nySLbli5HWR3WOMjgJvZtCDI4hZN78A?=
 =?us-ascii?Q?ngR/yA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee854b24-8509-40f5-f46a-08d9b92f8013
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 03:13:11.4122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFUOkWnL++TK4YOOhEYMhbsBt9Fk6uXnrwZyQRgdtDBKhORDO3spLDx2fyObF8FIfa6k9piM2kfHsQ62qRL+4eGmLUsk6NmIvBjV3rTQ7Ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4455
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=798
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070019
X-Proofpoint-ORIG-GUID: N4So9U6nsx4kF8g2QOKl_Tb_pe1mC8qh
X-Proofpoint-GUID: N4So9U6nsx4kF8g2QOKl_Tb_pe1mC8qh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> 'hisi_hba->slot_index_tags' is a bitmap. So use 'devm_bitmap_zalloc()' to
> simplify code, improve the semantic and avoid some open-coded arithmetic
> in allocator arguments.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
