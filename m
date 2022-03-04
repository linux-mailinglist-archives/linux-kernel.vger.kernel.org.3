Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0504CCBD1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiCDCl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiCDClZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:41:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85E245AEF;
        Thu,  3 Mar 2022 18:40:39 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2240bbvx031267;
        Fri, 4 Mar 2022 02:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Bc6imIhAXpOuWfzzmCN5G2EgAW8Qg7jnXSZPcdjHE30=;
 b=N+xSuwEJd5pJ3QZc4pEkwNRQ9d/zUbsFGn11i1iV/5ArOkg4QskhDIm5XVRHCGyHwaLM
 Fjtq2jfpMQH799UInSy8OrbF8l3hum46eMqOI5GEAjQRuAm0sOe+YqLtGU8RkXo9x8dY
 Jx6UUzYIERALfdztcUxj1xmEuzbOj6F4jtNRAQ2yG+A7tf5UNCI76+df9kr2FmDrHWOr
 knJ3B+dH0op+u2EQNaC0Bi3E00VZm6DmNuvtl9aAwadZzu6M4M8EYySxzUUrD7oS7eZJ
 4cV2UrihyNg+9qtPhUrqz7nFoihYEzrxfbjhFRBa5dyNb9bMbcwu1Od51YCIdLdJVB4Q EQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4ht0kmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 02:40:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2242bDXS030914;
        Fri, 4 Mar 2022 02:40:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 3ek4j83kk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 02:40:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZ3muOeBbYsYnxJonHka9AvVO2qtYsfKMJArPnzmiUJvWsZ34QFebjHPbowhxJwW7fF5hNuV6q5QgMFgeJyCu2YUewT55Ropv8wfkEYeVutyQCtr/DwG7d9VqHy01QP5PTZ2axxhb8MqAH2bJXCGBWdQRVlMY+70OhHeD+T+Z0l1CW32hj+5IGqn4+HIwYgX2g2PZWpW/vZE/GEjdDil0bxoJu8BaTcKd126T6uW/MMnk2JiuDLKq6MrWwtT5/X8QlQ10rL7gh4j0pcguJ61s4wg4A2Vd1uTg67Z6+upGaHmzXTq8h2/nP/nCbHT+H2bY2ERoVROFJTys7esi6uobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc6imIhAXpOuWfzzmCN5G2EgAW8Qg7jnXSZPcdjHE30=;
 b=Wv9+kVv90+DG6mTfXt4+b9ZKbvEK3Nzc/BI6wUkwoaIGi66OHctrzp9VhUm3v/7dgpjhFcDMKG8Z3BQo/ezVrfuuaS4EZgma7DlwCsiPCJ9wqUvvk3wXQCrRjBfmECE7CTxmVXnIW7csqHzR4oycnKWO3bGCC+baa91KdTluf1h+7aTPRZ7OpRKL8A9MlI6vMFrAz7HO8cCIkKJaFxzo0C/ptJIbJOEMVF9q5nVDmxnTZNzFOMhw6w9Nr4d7eVCCxrgp/ek+nlZfuPahH12FP4xc2rbx8TJRNyA1F8OxDHdzHpvvcaeYeplwqXYCdcuSHdtyyCY7A4hQ7tsq4PRcNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc6imIhAXpOuWfzzmCN5G2EgAW8Qg7jnXSZPcdjHE30=;
 b=HRhreQrfz0fNMMw6AKHk8WYEEs2NIVXnjts1s87/k2ygqm0PcSukFbyPp2YsPFEwcAWtNItyofbbDOUjnqOTrxcVIx90nPBx2SENRxLNkKQ4QKyBYGCf68bld23Ga+1kD1aiBs72l1TYG5vV4c8T3PkxIMrd9ZwLRISrQ4TmS9g=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by MN2PR10MB3328.namprd10.prod.outlook.com (2603:10b6:208:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Fri, 4 Mar
 2022 02:40:16 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::b51c:77eb:39b5:f67d]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::b51c:77eb:39b5:f67d%3]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 02:40:16 +0000
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Keith Busch' <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4 3/8] asm-generic: introduce be48 unaligned accessors
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pmn2v3ua.fsf@ca-mkp.ca.oracle.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
        <20220303201312.3255347-4-kbusch@kernel.org>
        <2d8895d24fff46738f98c2dae74fa440@AcuMS.aculab.com>
Date:   Thu, 03 Mar 2022 21:40:14 -0500
In-Reply-To: <2d8895d24fff46738f98c2dae74fa440@AcuMS.aculab.com> (David
        Laight's message of "Fri, 4 Mar 2022 01:31:26 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0168.namprd05.prod.outlook.com
 (2603:10b6:a03:339::23) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5334a3f-63f8-4d0c-db61-08d9fd8850fb
X-MS-TrafficTypeDiagnostic: MN2PR10MB3328:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3328F05BD90149418F485A0A8E059@MN2PR10MB3328.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hyulkXgLeFZtl6iVfKtBpyxtA3olDoYUES0hbEvA0oa5cjiZYFl/0K0K5SurKFSA2IAWJbkm9n/wQ6m8XWBJx6gS9GJu1R/DQpmhs7UgTGjNBoADJchNU4Y4Mzo5z4mU0kCc25jfe/02aBtcZslnRCmNavego6CvqFsuclk2BVzm9/+ShSlVHQj6Hafm8D1RYFOobe18DGkWw1yufASvREXzycAP1p8Mket22ks01Xt5B+mNnq/Zq5sD/ufxGNZCc0wYghG5x7yWoboDCnLhGzkHftwHpO/BnFefd/qoZRBJu3sPEHZwYsGFTywOUHldoOCzbRkrXGUdxMkgc64vPDgvmZeW02RBs35M1ayN4041e97oi4bK2Q08KCuzG+yc6EJu93FyHdwgx4RdzUB1tqXbeVslyha+Lm65hXYa7Shf3mkpWLHQqrYrdDvBsCRyxth4+ZJwUVjYR4MqxN4upYXAO6Ih6Mx4aCyyY9QUc6gZ/2OEctxC4arfpasFdxGsKeF6BHJva7842JuFNgsVAtv3kAX4rV0RKM9tQQI0lPoT1lF5NliAFXcGkPIaygAwwJ5W1nOiY7+iGZbhQVbnh2KG2WQk47uPXBjvXeCNj/CQMyQPvmbsbjKSUAIlwUoC/57tAPEve2mIUvZ3u2vF5YUcpBIF+3osETMK3qsl5xcKqaY+ZTXUHhlSQXTQvVdtycLxIjbMPA+sRD/pOKS1TQhWoXB4+MsD8qk15RVqWoc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(6506007)(8936002)(316002)(52116002)(36916002)(26005)(86362001)(186003)(558084003)(6512007)(83380400001)(5660300002)(54906003)(6486002)(2906002)(508600001)(38350700002)(38100700002)(6916009)(66946007)(66556008)(66476007)(4326008)(8676002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kSVHKjzqrkSW8ZEzMsue0CpBZTJfvUIcoYxtH2aVb+A6pb/eaafAneeWikfe?=
 =?us-ascii?Q?o50sJGj7kAVSR52/DF1snfSWcB/x+D3Y//EI6hNhDs142S4hfaBkECL6LxWS?=
 =?us-ascii?Q?4acGS72VcSHzEnl8Zp3X494HavkQFLEKjUNPOzvYdjOu/USjMEnbBtGHQWyI?=
 =?us-ascii?Q?3wAEVBrXopoyPtykUjBX17nHRvWUGJCxDa67TL9yQWM3lbVeEc8FWNkwQN7L?=
 =?us-ascii?Q?068aNGkF2ICKQOpyVkPSd5ewYBCmAU3eGfoVWk082BqCtra/4igvDewW5+hz?=
 =?us-ascii?Q?ZWFYKWt2qKeo2fifRHy5ruhqY3yXy5OtJWU3j9s9k8t4BdGjGy/jkBRjH+MF?=
 =?us-ascii?Q?n6FQlvbaeuVeaxufiPga2DaZuKD4iNgEYMS4X1/VZXKOvfgFuaBsDWolS547?=
 =?us-ascii?Q?Fy/wdZ5t0UCgp9ENw0mqR3HQH6FQ9EQ3B+i/Elg3teJYUsS40EmYoo/+2js8?=
 =?us-ascii?Q?48txfCMSPAbNhL4erv76rfc6OeSl9g92OvtSwZPiJYDQhBkmRh8fc9LvpJv6?=
 =?us-ascii?Q?krt8HVq4mV1TiAQHSYUfTpCZKv8yUZ89u0SgxHcTqpLUdz8W/nRW+b8uQeoY?=
 =?us-ascii?Q?0luvB8V5ZruYAVPFPcqmsCiPSRE4QUVpg/8eQaS04P0Di/7RQcxmFHlFIlCK?=
 =?us-ascii?Q?0FnIQ0pcGmkWV5b2plrE+0kRGyRd5eaWI2RtM1kmlRfBo/lVd17RiIkr000a?=
 =?us-ascii?Q?qMESpXIcWRT7gDUdI6VxDeAd4eUtS2oO9jzVBsX1uysX707qSb0eLRf93F0T?=
 =?us-ascii?Q?Am3CWnvwVPpxsPs235HzqAMbu4k25Erpx7wgyOMiSLHb+MRM1lX1rCxDqEii?=
 =?us-ascii?Q?5KtcgB6i2qGp+K+YBWW+dAFlwibOFdD3inYe5JcaoewBrpQIKwe3DH01q0Ns?=
 =?us-ascii?Q?hU1HKzbw9b2bgNM2oPAK/S4UJ1GOnZIFHmBq1DhYz1an2ts+VxJuMVlnPdYH?=
 =?us-ascii?Q?BUC1hRP/XIIG3iTw8jHu/5tZw2akwmWfhSR482LodoIAhE8RS2NJtcPjkeVC?=
 =?us-ascii?Q?cDxNxx1ezmATfVRbOJwmTvfW08NilIGkmR99xiv7J+0I7D6cyDGeu7t7UgQI?=
 =?us-ascii?Q?S4ZQkNTNEtYzcJ0zN3hVVo0mA6rvOrBtcOhIrPJTSFWvocH61iDVoHS97yWE?=
 =?us-ascii?Q?NjtqfUX9lSBnoeheVNTM5kpYJLrTs35oDUC0Mo1us8zisvcOn/k1Jqv6iIJV?=
 =?us-ascii?Q?GrrNYfcS2IwQm3SUWQ+peEzUGqHoyunzpQuJrydHrPgoMXkIJ/DF6SDTz68h?=
 =?us-ascii?Q?rSVOt585mArxlBTIvC/wYszBYjly+9P9/AVhjy3AzhbnVgh1O7F7CMVajpSp?=
 =?us-ascii?Q?aOLQzCn8JGK2+arCbhFlNnPZnEouBQs2oTAkfugz7n8n11KmkiIe6nD2dLid?=
 =?us-ascii?Q?FKpW97CZlbtw1ZBICDGwxTE7bov69Ne+Q01pIPmsKMwtNR3VTLoqdkfQA1zb?=
 =?us-ascii?Q?tIeKfjE96rTftDdRlQ9h1TOA9kVn8psDQLWLbNPOSWbCmI6YggmS7AZpzsPR?=
 =?us-ascii?Q?av22tMyuHI+HUCXgzDCfKT61UZvxgckL0Ei2Jw2uYQtHDpDNviMu8j63+pDK?=
 =?us-ascii?Q?Qn6gEMUmIPOasqt4O+7ofk3ejI7K3W3HP/lgP0liJMzaIFSWIYYNqGoB7lNy?=
 =?us-ascii?Q?Evq4COT+QIE91BLg2pJmlzJRT5xroMnWqiSlYIIb88JkZ0Z+9fqhYK7ZpKWB?=
 =?us-ascii?Q?pRKulw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5334a3f-63f8-4d0c-db61-08d9fd8850fb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 02:40:16.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqJE5feIXj1hkYRY0LC8VL66jbp86P34KezB1Zb0pXiB/RlZulavNGUhJo87KubO/F+LxXe4psBB8u7DmTReFU53W7J47z3A73v8qOZWr98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3328
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=725
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040008
X-Proofpoint-ORIG-GUID: bi78Hlxri7aKv74D9aAQ7qcxcqJM1oja
X-Proofpoint-GUID: bi78Hlxri7aKv74D9aAQ7qcxcqJM1oja
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David,

> If they are reference tags, are they only interpreted by the sending
> system?  In which case they don't need to be big-endian since the
> actual value doesn't really matter.

The tags are validated by the storage device.

-- 
Martin K. Petersen	Oracle Linux Engineering
