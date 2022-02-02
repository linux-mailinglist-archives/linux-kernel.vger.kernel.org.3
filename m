Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696104A6AF3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 05:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244428AbiBBEir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 23:38:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60016 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242010AbiBBEim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 23:38:42 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120PI7d004733;
        Wed, 2 Feb 2022 04:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=vq11n9clRApYVHArGQ7HrLgx4iwJ9jp7VTvR1/Bex9c=;
 b=xGXL01hJfKeGTKRnI4q52k0aVEqFD4W6uZqflvV6h3ypsNwp8aQmKkhoXYjr/M0cBYNV
 xpP5BwhLrYXTVQNRX8HG0HqE4hOdkIvnCy21hvmK1ZQRNP+mpplHqbMbEYRsCGCxuzpV
 kSBL8MXJTFeinbP7b13AV722ULzztHtr3K0qZlndxAQdOfYodvCszaD6LW1gL9vfib71
 WMl4gxzFdSMY10t1vvy7i1ZO2whotWYJLx8iiUhdGe7dWXyy3z2C6uJCe6tls2wBVqyt
 Bs69dZTarUX+y+pzCEkFxP2wfxhyw/LA6/9J3hkXFmDquO0GiNv2xx9LwdhoFwSZ2+Nc 6Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4u5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 04:38:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2124VCYA034193;
        Wed, 2 Feb 2022 04:38:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3020.oracle.com with ESMTP id 3dvwd7c5mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 04:38:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5e0IZJlaokmUN9ToSZ1EI0Tbb4aq847XNyoGjRcW/t4/x3EeIr5RhiiIW48EJ+ptE2lanBshabSET86VFrnjXBVrUm6pJWY9MbfKsWuvmEYHvV/5oWSftJu+IQEydxuxeuTfe2/4lrqvMZ/vpp5Wfo1reKPWxk03h4RjjCCxh/4S32zdjbFfqNf3/oo49qsoDKNNbLuTVNuZcobB3nz8vANzKY8EoGh4Y3B70IR+GPHB+z/I06qbf0A3kQ88CvP/92a6pzxxW0gAGRxL0RSdVnXeM2HFokCamrW8AGI24r28KAL9YXeQqIqBfdVOSShYrjuT9FlaUvjox8OY2snOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vq11n9clRApYVHArGQ7HrLgx4iwJ9jp7VTvR1/Bex9c=;
 b=QalEjyE4B58tRGsWPILCMoHweE+Xmh1g5aVhpyz1Ph5ZsdkwDpw9Ji3DZbuXqHjwdKqEdqS+lfZAwkOIhn7h7k8YTyvmVRYPodEg3uWSgLFcIDlOuim4i7dm4vaictDqS9N234ye/v43t4siNt40WUeCQTI3odIalFL82fAhacPqq2F7Zle+pI1IjYwyPCn3ELWOAWHjNagH7XIwpmz8qVdjW1rLLdFRpMahBQsoAJQ7RYHnMBGvDaIhvxlEkRpO1neL3xCdHl2gGOd0Dp4RIOztRrZeED0vcZNhbR/FQiY44kBWRMBKFcOWtBr5hSxspuIovuZH6x9n30PuFFjhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vq11n9clRApYVHArGQ7HrLgx4iwJ9jp7VTvR1/Bex9c=;
 b=b9LC0eML41vgd4OaPd2WWUIsjHJr3EcY96guFBmmUuCH1yTNX540Q+rp4HLTPF74kGOW5K6Z6XDaqVUBB+GpDsohvt6x6TPA9Xn9IeXSSZ8PNn17tuop5dAGOr2oJOjExFB8GselzYJKRd2rIXi+AbZXH5PKHVeIR2640AhjjD4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR10MB1911.namprd10.prod.outlook.com (2603:10b6:903:120::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 04:38:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1caa:b242:d255:65f3%9]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 04:38:29 +0000
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv2 1/7] block: support pi with extended metadata
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
Message-ID: <yq1tudh51eo.fsf@ca-mkp.ca.oracle.com>
References: <20220201190128.3075065-1-kbusch@kernel.org>
        <20220201190128.3075065-2-kbusch@kernel.org>
Date:   Tue, 01 Feb 2022 23:38:27 -0500
In-Reply-To: <20220201190128.3075065-2-kbusch@kernel.org> (Keith Busch's
        message of "Tue, 1 Feb 2022 11:01:22 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 150ff1ae-11bf-49cd-27bd-08d9e605dc76
X-MS-TrafficTypeDiagnostic: CY4PR10MB1911:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1911AC8AB508A30083F052E78E279@CY4PR10MB1911.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHww/ay++QU/Kd7Gzzgtp9JML09vdA8YZ1iqanOJ8OKYamm00QH0qEjDVtOEJ36rfM5qgSBAMiM8eCOhChZZmOHU3EOSN4TF4gCdE4OTAlF9PJ5faY91P6gDHSFCwWf9sa+NvoWmfI5au4AA8Qgtmy3A/1gT9b0//tE1a4lANqA97f6VuiomTvsQBOHBLmV8P8Uy3jdwXKugRc9P87mOv3udQ068mexc6dkMwdPC5gtb0gmoW5QmMckozwEobVJIAKNsg4J7JcLbCsK43w01ATEH42yrIUT4fzNba+t6kBFr4l1uQi4nfhifBs6poD3tRE+NU6cGi8WL5fWYlcPhTbJnRWek6XrULk0EYRQ1xzaqgu+pGS+QjbkX3INgnElWBx3OjMXLvBRLFsdxpZ6r7ql0tlT6XIW07kDVJ2P0ZzNZ8/oUbmJnhCk0ZhEuSygxHgTqvovcIOoreG/kfoGTkdm9ihvcEY2+q8fIr3Xt/kBlD0rFXzKiB4mUbKi8XKCI2F9nmCNwRXRZBPDAsk/HCRAmSdVduzaQd5MzsQsGOsA7wAVurqW575QA88msPJe5PBNfK/7p5aQf6u0s3ufzDY+ny6dnjFNmqz6H7+y0Zz+D3Shmv64y3OgBcwPQIgfKfdDJHfSuXNYtzqxSfmcmlXXcVEdMc/2zeIWjetmImqwGs408bbufCrsxq52W7JiKKHVelwW1W6m69zg9psqxhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6916009)(38350700002)(316002)(6512007)(36916002)(52116002)(6506007)(186003)(26005)(66476007)(66946007)(508600001)(6486002)(2906002)(8936002)(8676002)(4744005)(86362001)(5660300002)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pozCPweM2+GQSjYfeZosBVWE2bTm87Yx73JJ43E3Bp+WyVYhYryVPH2UXKPy?=
 =?us-ascii?Q?YXvmLLbCx1BpP289nJ8gk6ApvZkUwYWE+o9XrlGXh960W/AlbJ6f/EbUwM4n?=
 =?us-ascii?Q?LoZzt7z+crkWdfr0BT9InxNmxJRlHy4QOvfzA7TspK7vk7lywwlYA6jQ/c1d?=
 =?us-ascii?Q?c+YZbTJX6K29Eyd2kH1iNX07AEOtxerQFp2F6JHBvfEK6BQGkvPSxdlB07bD?=
 =?us-ascii?Q?2G8n2X67+1vnjTqr36RrHzYUQRqRi2yDAJSv2CYPkzDPSDGQWUy1CsEL/7yx?=
 =?us-ascii?Q?0HQB4wqiLUCYoTDMZ5ivroofc+BRML71Ra9bq8bMVPoEt1UTP2dgSaz6rk0v?=
 =?us-ascii?Q?wa7iF8InyD+AScNo1DvN7AiW1mxGZ7Pkhybj4d3fkBwSeM1A8LjEbFcg4PML?=
 =?us-ascii?Q?vLIxVipWMy4nxbwY0y7balJxjqzCt0m3lTDt+HAzFL+SgI/RMGT2R6SnaiQ9?=
 =?us-ascii?Q?HAIuaQFuYeX3MHPDmIaUzYTySQ9KFutjA+zaTtLo0qCqpirfabPB0y9HXF7V?=
 =?us-ascii?Q?AAn7RYhOiocXptyaRSndNQmFRHp6XXOW9Y50pQaZE7DY3ql5/N3mZDHVElJq?=
 =?us-ascii?Q?u3EBjx3gfz3u47bt3R5RdKHcJlPo6lZA78cHuhuKRw3FR2GKDm1Hob6zRv2l?=
 =?us-ascii?Q?7Yqf7pT+7nR63MDnHJzvs8VWQNt0z8fwTrX6kwzFQ7T+NvSFr4eQQJD4062y?=
 =?us-ascii?Q?j2CTsmBLG/LMxaAUBFxMROvpFVlDf1g0ILRah2PNJEjZ3eoZ3KFXp7Io+NG/?=
 =?us-ascii?Q?dpepNPU1r9XXnJWmYapz3cUytSbjkeHu1BAJgkATv6RLuDckGszW4IIZMCE6?=
 =?us-ascii?Q?ILhFBKNXY+bSEj7zhD83mDJ3aHTYhy5a88r8pzzoA8xeNma4oBAYlGDVRTo4?=
 =?us-ascii?Q?42EN6B1noMv/WShowONGf+ffm3cuU7h4xaEEeJnLG36TMPNZ0fqAM+l+KAQJ?=
 =?us-ascii?Q?NCLPIct+T5g/jaBBIdkxKzEaLKc9oa+gg5dc5xtMdRuKW8wOylQVzMMlhk5i?=
 =?us-ascii?Q?8yL7VWhBHOHvT06S8A106B9RqmVYk64A3BzjGhUB+Qdizjjku0wRmaY5XIDO?=
 =?us-ascii?Q?6QgBAUOVDXvYIL59QC7f6QiQvIFaOnDKNoOeG0faw7eKnIlAEZczigLBiky7?=
 =?us-ascii?Q?68YTCGdafv+LC7P6h9qkumifajplsey3CMT8DjVqv1aWO2kHmrZbBO+RuKNC?=
 =?us-ascii?Q?y6Tp2JEjA+pfWJt1DMzXMWtM8N/4vOwyiu88HeCWFbCn5kEkCvVykvR9flr3?=
 =?us-ascii?Q?dQfc8mDzYbVPBqNQb/k1lj8bQYklCa0J2G72m43kGL7p3XtDpHQN1lrZWipc?=
 =?us-ascii?Q?9BIDq42gubxxhtLUIX+nmFCMs6HAmxmFx3NmrVsXmI7VyMBg65y0jP5Sq7lB?=
 =?us-ascii?Q?MOM6/B0eFRmA7nwXH0FlApTFIqn5VS/FGHjRm1v+/6VNjJE0q9f5Hg0VHrx8?=
 =?us-ascii?Q?Sp3pEZX5RlcFTjn6BpTVclPRAo0B0zQi2/nMTUWC2D4BIISuW2/N5R27Esk3?=
 =?us-ascii?Q?9YaHbpv3MpaP8Yr+4GjcqVGHYMhpXm0Jb3++Gq7HkHPgIpGE/6B+7ASGwiax?=
 =?us-ascii?Q?UfX5hM4lc7vMbv9Qc0TGYyafua6ejSSR7UFLF1EkeroJ/5G389JuX6uAFAif?=
 =?us-ascii?Q?55iu/hiYMBr3sw93xVREwD42r4GBVqn9ghbPNBs69rcY7nzdIFpBtBjHTIuO?=
 =?us-ascii?Q?1693O8YXZeSnESVdt+y82Mxun/I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150ff1ae-11bf-49cd-27bd-08d9e605dc76
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 04:38:29.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4F1kOZGazZKgV97um3//ctHi3sX2K3QIx62ddI2s8ZhIyoBZ3tRT6eDC64UDX3wj5njemudBihmnJUAbprPW3OqGUW6dxs3ouirFH58Rr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1911
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=953 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020020
X-Proofpoint-GUID: rNBfuDVkR7PY1SHv-dJJlQQqD5gDW-ip
X-Proofpoint-ORIG-GUID: rNBfuDVkR7PY1SHv-dJJlQQqD5gDW-ip
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keith,

> The nvme spec allows protection information formats with metadata
> extending beyond the pi field.

This may be true but it seems the rationale for the patch in the context
of this series is to enable PI metadata bigger than t10_pi_tuple?

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
