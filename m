Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A47D4EB8DC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 05:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242316AbiC3DfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 23:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238430AbiC3Dex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:34:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFAE20D80B;
        Tue, 29 Mar 2022 20:33:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U36NkZ026977;
        Wed, 30 Mar 2022 03:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=THj9z7Yi0Ik5VdvY+3ga5mdI1IMIgp1aIj1LZpbm5wo=;
 b=BmOqI8Bi7cbufelSgSSMOSyeQxynV3KWwCTcPMqog5+XA0aNr5WGph3oNpEqf5UZjljF
 xDI9vaImAxzqZCm6+xdc2Rax78iVpdmz0XqEH0AhlYQHyM37vcKtH/LM9rePOX9HzDri
 mybZpQVeMvhrjB03zkN2WUUTGSCPghMC0ThGYFHlN0Y9jbFQRi4AESwa2V9/kn+XIBwu
 Y8xZxt6VfZMpZFpyNi3DHOrunDn+mwPru6GNW5Defz0eG0t/5JOnAPCkRub2STV1FXGs
 KYbJsLVnVoMy7uSYPN+bWsUxTlbEN80TQ//H+uG9DrxGFz6JULqZXpzoL7pK9Zy0YChO TQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tes089v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:33:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U3IrUM111878;
        Wed, 30 Mar 2022 03:33:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 3f1tmynbwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:33:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aagnGB4YaOpQ84+4PE6mktwiA9qpKGIeYDilvXzv5TF/d5FNcQhtqWw+TjqAu0XPuK7Ap3fJxvvNONScPAUD41mvXxR8ltf45elWnKlfBI5KjNddnevAhPprYeL1yO4ISpDFXmYq+cVOwzB8j9qX+6p0bxoNBTAqGNRw3PmOfRb4fSOh9lCOQKhZ++cEzbcw5W2ogo0e0hj2E3CVI3DMb5P8qLX61ohLZW52w2kSDrEzURDvf1W4cwl4b5WQqfmEOHLe+sxz2CSjsmLb1GHYSAihwH5waHKH9vUmu/dKLaRPPSezlMNq0dJXks0SsSgz+yoL3f+XrTFlgBan/yv/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THj9z7Yi0Ik5VdvY+3ga5mdI1IMIgp1aIj1LZpbm5wo=;
 b=iTxK4PU+EqeAwpXADU2I/TAv0KGU+Tx47Vfl/+IGw6hGmhZP3u/qg4sKMOeo9I83V+1z71XIKI/vR/C4sWka3V+2QjlRbXUDPrchl/6QUV0cewinTLwaAXB4ZEk049qs4TFWbsJLnCy1DozR2V3Y+kZe/DXkh+089HVgGQ4c4q9QyYf2GO1PRDizAWPtdkh2JGDrUv8r/RxpAkXWjMGEBpCgg9MmJ2dJBI8eJrs/c3Z8bnhm++DdQqHi33QuBJ3lraA9hzD7V1wfurC3HgchYMUXJkXRtA/kF5QBYpjlGSBLT0ocU/uv8b8nu5U7qb9GT6tnP9ileoD7TIx2g1+dug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THj9z7Yi0Ik5VdvY+3ga5mdI1IMIgp1aIj1LZpbm5wo=;
 b=o/T6xN3tpUREOqP2TlIqxRGYWLJ9pP98/cKWb+U+qNUPmL5rUmqP2as0M44J7uI0yLqSDFYDHaomWW3rgYu0aKXnCgL3dq708JVTGrRUgws8lAn2GdXfuKaAUHmwx/IuOzaGeakGj7wOIhqI40xLlR/7fBvi4crAIShRPVwP0JA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN4PR10MB5575.namprd10.prod.outlook.com (2603:10b6:806:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Wed, 30 Mar
 2022 03:33:02 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 03:33:02 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3] scsi: pmcraid: Remove the PMCRAID_PASSTHROUGH_IOCTL
 ioctl implementation
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qykw1wd.fsf@ca-mkp.ca.oracle.com>
References: <7f27a70bec3f3dcaf46a29b1c630edd4792e71c0.1648298857.git.christophe.jaillet@wanadoo.fr>
Date:   Tue, 29 Mar 2022 23:32:59 -0400
In-Reply-To: <7f27a70bec3f3dcaf46a29b1c630edd4792e71c0.1648298857.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sat, 26 Mar 2022 13:48:15 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0298.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd8219de-c02a-4b9b-77a7-08da11fdfe8d
X-MS-TrafficTypeDiagnostic: SN4PR10MB5575:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB5575644095982B39FAB848A98E1F9@SN4PR10MB5575.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFta7bw4D9XAbCPamNjv2dMySvVz5eg1WprAhLXRojwt3VdRJiRjuF+42Czl6w4+s08oQZYmD3gJfyHMp8tLXi0KF7Jaa9AlIaoYPHDLKFje3z+B0wPfWzKyPyVCM9KHbKe2XMlNohzip2NAcWPkLDgtvwJge9uybWuLfphl+hcthu7SWqJ25f1lyATt/YcV8EWqDiSPgT/jtPrfEY/7R66kTs+f1VAPJm/vXqiUbJCJA8a/TFM8letwhjMStKGvIk/MEeZNQBj0Tz0Rjrm9CToy+hf/48H9de3YGtjTaCD7OIBkhCtlBcwho9HS7BLZRvYBn7qLWFNX9p2LJnfnDAKWqQDxRvNANoHkcGvCMJ7GeqsmdSRP0CecNo5jBlBG3REwdlm2vyMduYWu67Afgxt2hE5GoVoa7MZM/+aCF8YL9of/8sCYOznQJ/4edoaoy5AhXDM1ZF+XfLnT/WxNmJgMNcQac4MZtXv/OWJN7tQ9sZVomcp1iejEFo5db8HBsn33qyW3YlcjiLJGegmZGQiCWKAJZ/PCF6DMWpUmqq+MBSCW/oBNQoLzRix1Z0z7JdQbIKwGsEJ4Xxs18VqYWqREj3hbnzzfIbIjhDPmtDAl5iFRD1bj+zBn7AN0ttn9TQBopPb1Ab4HNdILQ2QrF1YStInEyXfih9QK/JdkjK34S15Egf4ufHmjsU79EcvKK57ZZ++gWc2q4LD/44voQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(5660300002)(66556008)(316002)(66476007)(86362001)(6916009)(8936002)(54906003)(26005)(4326008)(186003)(8676002)(6666004)(36916002)(6512007)(6506007)(52116002)(558084003)(2906002)(508600001)(38350700002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dGP05MjVlxHZi3NPoAINd5bNTEvwgXfn5gcYBYaXsn+LMeBeqOhGVavbjv5r?=
 =?us-ascii?Q?YDq/AjmkZ0M4XcTjNwpgWqFnNnm1YxVxH0L/ab8flo1E+G9eB57ODHzPhOBM?=
 =?us-ascii?Q?JEGJm1O7FkZ0hNDbM4td5iFUUOTyMvxZAiDcreZpS0NtWEdmWF/iHU/Sa4E0?=
 =?us-ascii?Q?cqki7E/hkvJSJxoJfR5LLOJkH3WT1BSl9T3JXoGOj/SXX6WGIEid3z1nOYsV?=
 =?us-ascii?Q?tMDxw7j0y4jolVqsSjsmyjdqPTkq+CMY1q05qCpTvwDAr8JdwOfQE9/wqHNJ?=
 =?us-ascii?Q?CR3t68XctLXReneO7f7onMgAhwt42puwaBwBgpwo8yfOp9Tg/gUuXac2auIV?=
 =?us-ascii?Q?jRHz3/IUsFXcVWUYBMQN+FwC98LBii7ZAvrTAZViJ24TKm0TyyjUUCUaINP1?=
 =?us-ascii?Q?GLPnMna0OCmOt11Y1xxp3KY8+U2B6bM/02TA0yX7vzY8tnIxcW6BeFtzI3PH?=
 =?us-ascii?Q?cuilMO1aZky8k1RqOBybgyc9yBdXqzX0evEYb6TlLS14jKnrUBGMZHnOtV++?=
 =?us-ascii?Q?IqLzSTc9JKOR6fYAPWKFK4RpfPUNnJ6FyPZ91UztgGHJrPxN1yTRrJb6YQOH?=
 =?us-ascii?Q?nGcWwX4d3Ei4g3NDRUbwjjEudgOIQ6jw+rxCJiPyqwXK3OY/ZEbyyQSucAdf?=
 =?us-ascii?Q?gc8PSwVXKGjaQOZdEFKsStq/PVIeYJYABCgnBvjUUUcWoIBSqVvvBBwrcH0p?=
 =?us-ascii?Q?/YqpzWLqyETHIdhHtEISOFoRCF13gPp1DOJ5Pa+m5OvndFzsUKR1313SFmlA?=
 =?us-ascii?Q?cefVxhBI0Yu2/2X6rAVj6xlbTvUiRknpPxWlQTZHNuFSV9fOvfq3zjbje4hq?=
 =?us-ascii?Q?goY3z3mQmpbYK+7VV6aKxYswgcvkLYKWlgmHFlvwJZRcKkXJ/d/3eP0bgGZ4?=
 =?us-ascii?Q?1xXx7DcuVirIn6drXZPwoT9D83FO4JsA8LImi0xfZ3+Q5Jthv7I2HDs2IWnr?=
 =?us-ascii?Q?NReSnsX0LWS+lwR6zM9l8M3D1+oIRUKFNMkbKQETRHYusJG9rZLoC8TR5mwE?=
 =?us-ascii?Q?vz8LB54j/OcS5ve3GscSKZVUo4tWphi8T1e+FFcsLy0aDB/nrHBaKEO0ik/7?=
 =?us-ascii?Q?xJL/wj42Hl2hk6DYRkifhQvDEQ01ExqQFB8S7wmOYoJDaqfmMOwQ7SBL1oBn?=
 =?us-ascii?Q?wAta8dK1fRO3X0VipgmgpBSjQOXB2JhaGWDqREdNuu8OFlAwhXjf/6exnSkU?=
 =?us-ascii?Q?qAGRr2CNq5jzHh9A5tNReqnJwaUD55jsUEwIAQjbkcr5a8iwuj+0YHD5Rprr?=
 =?us-ascii?Q?+kn3shQXVnu/RFE0hc/f3Vq84utIhoK6Mk0sXPkwhTHgUEN8aTQZjn/gg1y8?=
 =?us-ascii?Q?0G6eA/SEAFfHAozPLAWeeXceWgWcClo7/gy8CeP7lI43qmr3ezI7eET6I1HO?=
 =?us-ascii?Q?3Jtohl4OSwsFzmu02Y6afeBczqLrpkcYCvc3mkFveK7LolOWK0PGYG6Ox9+0?=
 =?us-ascii?Q?mA7aflkBI0BABx8VP661KHTLRczx3Ygcn+ckqQJ9gN5kCKyxq/iKrqOCsd4k?=
 =?us-ascii?Q?zWKatvo3bHiA5eGdXO41xM6GiunfktTjLGu1SmUj4ayyi0JETG+92rPxzmWx?=
 =?us-ascii?Q?dI3prgUleMoqxgYhfkupDQ6nck5BvoW4qIALryknebZye7blB/1HBRZnlEz9?=
 =?us-ascii?Q?3uKvUEsm6TJPuIkwccBju0QSc1pJ4Jn76M4QUfxiKSUDUjvXIenynUvoS1HY?=
 =?us-ascii?Q?x2fJ2adgteKrryPqnTC3IlwEMuisj9kGrooN3NgqXyLaqVDget523eVWvGY+?=
 =?us-ascii?Q?P4Oi55q4oYt2pSb1WMz7Czz7uLVAOwc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8219de-c02a-4b9b-77a7-08da11fdfe8d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 03:33:02.2678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCyq6Nfo1P2IPVju0uKGEEGltrVakqjoQiLL7Kg1BRNfCU/XDFuMYrunc6lmXTgWdOv41utikKyDuScdDnupkvmmhjnx6/B+aQWl8Jz1RGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5575
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=805 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300014
X-Proofpoint-GUID: a5GCfwnM097UNRRaxcRJ6q6btd_sxIzp
X-Proofpoint-ORIG-GUID: a5GCfwnM097UNRRaxcRJ6q6btd_sxIzp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> The whole passthrough ioctl path looks completely broken.  For example
> it dma maps the scatterlist and after that copies data to it, which is
> prohibited by the DMA API contract.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
