Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095544D2F03
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiCIMZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiCIMZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:25:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE1A13CA17;
        Wed,  9 Mar 2022 04:24:33 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229BLS3h028053;
        Wed, 9 Mar 2022 12:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=8ZwIbVnNvXTCE2cukcUeJqGHSd0/J796HAkwS3vT9gQ=;
 b=tL4aOb6rIBo+6TDBdz7PivdZIXxwBkkx0jL6CpihvCdm1ycDCPCm4KIapMRsCMbiuBhr
 e6dq73vPzd1acDhbtDXK5EdS3uuIoGgJJZCdI/0NI+y6KR9ganTPnTt/0QGoIofJuUrj
 LsvzCaFoyZNiZeYZkLmNdJsum8w450pkdWbX30N3/Os9d93iA4z4c/0AjAVmqM6FHZak
 agYN7VYte8akT9JvzKJf9TnkdUdO6tgAXZMTehQffJYAPWHC/19DrDdhhzY6c1uQzLEh
 5TH+1AxPfQrh6cnSGt1fF1qHbhfsQSrWvEfO/X9sThlqfH9GgZG7fy4OuHrhBzhC/JD3 ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2j0uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 12:24:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229CGi4e143627;
        Wed, 9 Mar 2022 12:24:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3030.oracle.com with ESMTP id 3ekvyvshay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 12:24:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=St0guKiGyVRVKikmjmzkiI8hQgMWtAT2NZsmW4Sy4zShFmhFyb1lt2F6RsstR9OP00d5WWv7+2RWjT7GdMWConixYX5DlstkM2CcZf6doaFD1C4wQfmCkeilMYpHLE7cUjgR5Ihi1XvCxmfDV0uHsjGYxyA/RdgQ+nbxdkZOqUK7iKQt6oGfBGiakJXBPDKWoiI17P6AUQvh8GHP0u2UbFseYoN5NWw0q1XhalWmiNRL7Qw5BKgwClaETd6lBNQT61V086h1IBtKgk6ydsEZh4QDDb4HWCXloKIY9HKqcwRS9jbp+Czsjp+iiao5J7YXl6Nil3DxiJJ29dAkOLjH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZwIbVnNvXTCE2cukcUeJqGHSd0/J796HAkwS3vT9gQ=;
 b=IS+rH7UDwOGiwYGm0xMEhiVLZ9iKvPaheueXrEVLQq+lxwraPWzMmdPsrZOa03D01B6Mw6B2CmW9DN14qq8vnm7dYk4igsSCHFQFkDgmLr4rT+Eu8SYjbaIETbuZC9nSgnHC+qaq+/A49FkaQnKh1fDjpkcgzPFbcgAOWIJN2WMxc6La2jxtgEu0bKzNQdJd906v/Uc60LJ18QLowSuYbry/I+DUNTGIlFlo0WCAoHY394NWdYRyxiNOEJVSUx5nhttWFaFkNi1+9xOk8IA+nQOuu8zhfbaEJeWa6/XXTHfaISHvJcdS274tfsfxFyqHJjXDyMvOOPdR7g7zVx4VBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZwIbVnNvXTCE2cukcUeJqGHSd0/J796HAkwS3vT9gQ=;
 b=NR83+CyaAZwq8IAabqTlg9I3dd2W2M+JXlghdHJtz+hKJHJOiOlOzTSEPb/53oYF/p5q3SVrP2XFBtwPRz7Y48zWOpQwF7wCgc0RM91dJWa483xL3//zTLD0OCKByyamPMvCyBmjN0eJJFMtwFtLP6peomTVF9p7unUyHsJK4PE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5271.namprd10.prod.outlook.com
 (2603:10b6:408:12d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 12:24:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 12:24:14 +0000
Date:   Wed, 9 Mar 2022 15:23:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, hverkuil-cisco@xs4all.nl,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v18 05/15] media: amphion: implement vpu core
 communication based on mailbox
Message-ID: <20220309122356.GD2592@kili>
References: <cover.1645670589.git.ming.qian@nxp.com>
 <58d4fef9a9b9295459dd15747c2630eea839a5fb.1645670589.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d4fef9a9b9295459dd15747c2630eea839a5fb.1645670589.git.ming.qian@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0001.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd241410-3258-4372-1d3c-08da01c7b92e
X-MS-TrafficTypeDiagnostic: BN0PR10MB5271:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5271A03C5F3624CD781195CB8E0A9@BN0PR10MB5271.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iz0TWa60ANGkj6m8RiRyzFC1xKeoLHMDnTK54xV1YMpUzVCpWYJas0cKyuzCKRlelcqvr9LRVCoUSLC5YDs7RjVb2dIuhV/jg8Zmhr6XQf8own90c8ElvIRAJrb4D5GVir5Ea/ogV4P4C5UvBeNvxvWJ904OFC71F4jLi4hoCAVpZbMT4PJbbRQeWo2h1kJuKRdnGBnBnHkBeRqq5jn232mqYNv8nWjCS8AntHSFbODd/hMw0WrMfghSsx3itB3nkeBCwpJin+4zMoZhuzp/J36o6gjaBiYQO1R8liBofc6L/uzCI2agCDxmldSqskhDocUbHSPTnt26yk89vvaCh6uebrC2QHsbqMp82aG0SnEpJb9U7/SgGxnySsLE3LV62QTZOhJhzIBX4rUdHwjDs2shMbq8OLnFccfhHGiXBu3kDTB8BD1k5Kk38JmKXJSiuzDDOWdteFVfX179CyUf2gFLCQj4SysXF43b3Ni5ipiq4Y2FWXUndyj28IqDYl9rL9st3ESqaQY7sicWcfL+Rsy/VEHwppv9xmPTucPbX6RvtY1rrcowdI/KQiE9cC3jmMXHbsMBqCMV6MXN08YVVmtycX/wqi8fMSabngqfkGrjhiusq79EoN0tuSt+wFrxdfyHKIPABzbX3GCwQdBIWscwPejFcq4ZWg0vD3zVCh3K4Q3VbaBeZjiNomjSkY3munToHgc98QsGf53lVtQjUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(316002)(33656002)(6506007)(52116002)(86362001)(6486002)(6666004)(1076003)(186003)(26005)(9686003)(6512007)(66556008)(8676002)(4326008)(33716001)(38350700002)(38100700002)(66946007)(2906002)(66476007)(8936002)(6916009)(5660300002)(7416002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WKOc3eNwVoX/xrs7E5VdPvaolTDODXnlA9d1CaKOzNntbOpnW+vZ15IxVubG?=
 =?us-ascii?Q?2XgEgUKwiHhiiP9Xx4UjebobJL0Ffnthaih/tgNo5mpJ4Z3GcpczPN+jSglZ?=
 =?us-ascii?Q?fezNpZRRuvu8owArwqy43Amx2R6B1O5xPlA3NDubYRZthOJQuNWEZNVh5TJ0?=
 =?us-ascii?Q?7thYWcr3zQ1BrMfGxIGWdKZke0yEgKKxJoM9Zv7sOD3+Ktq7ZgIxCHeoZAwK?=
 =?us-ascii?Q?vbetrqkG2uy/oolq3VdmwuZrmgtXuf96vmYbWkj0zMrl1keDSCaEuKbYFoWc?=
 =?us-ascii?Q?OIrLm2CI1r7ZtrtLyZ5eEEJPL0fALUqPWIgvQg1hupmhBvHECOgtqxn0R4jq?=
 =?us-ascii?Q?FCjupTrUl2OSrADQO/UJjH4QAQYeWAc3z0Y3rZ7KCGHb8kkvfGptR7WBxtXQ?=
 =?us-ascii?Q?oHsYnzmVHM6MNpQ2xUUvzJP04QpiSAmxhmKDUptigATTnywvStfM6FvwKE2L?=
 =?us-ascii?Q?RU/ECpk5ISkEQ8DmpDOLn/rZxmObUudGtVNGi3LLb7xSpmaFq7wAn92Ttww6?=
 =?us-ascii?Q?OOqLACS+eSBz8EN9o4YMiqaB1qYghWaOXoMKOkSqH3CSXcIbiEac5qtjm6la?=
 =?us-ascii?Q?NFGBbZkHnQwnL5BzDCrjGQsEXp8J6LWRRk9Ubrdm6RqwTCjapYt3FtTR0Ur3?=
 =?us-ascii?Q?cT+LjuDvJPSauxjesLyLjAqOPI7pFSVaD+udtj5T2ZwMeH+2z0eswgHOeYzL?=
 =?us-ascii?Q?bo+dpEirS0NX4kx6bjBtnC4tfIUNchyZp+YkPNUKEviD4FjmJuIeDzgQ+7PU?=
 =?us-ascii?Q?bM5UJX8bXgI2AA9dIzVkmbGqfCx1sxCIIVhoYAleH5J9xqQ43z8gp6IWpls5?=
 =?us-ascii?Q?bL+vYtoIQLPgSbb/1J97cNCEcsdcPq/yKOU/it5WI1QrcJM4JcyOLylFwWDJ?=
 =?us-ascii?Q?2ogWUy+LGoRhikKdmEn/ZZZEMWume1RiTrzk14l4jbgEV4t7MfAk2a1rh82X?=
 =?us-ascii?Q?dDHrtshT83GEEiS5YJa50ILB18B6Z6UvqL6XM/JLpShh6TpgqAehs/kr4bfo?=
 =?us-ascii?Q?OgGDYsFOK/Ynra9Bv0S7Kr+l+pLMvmYnCQDHN9lqamavFKtyTsvYjhZFi6h0?=
 =?us-ascii?Q?I4nvq3Y8BwoKrsAvMsRmuTNpEhFQjnHZV+AafGbrSaGlUrx3mOlvl90ATx+e?=
 =?us-ascii?Q?ct+cYS8xTFaYLtweegfaQGp2y+7gw4dep3QnAwfJlJ4cBJ9JAaZWEQHEs/Dj?=
 =?us-ascii?Q?wJ3jxMlxp+GcEeYFJSqvVduVkoEqpZzoOM6va+fhy1Qcc/YdsV47JJXXhaxo?=
 =?us-ascii?Q?jBkfoGTt1UBYD/68garPyjDA5TD8WJ//O86KBBhcvq4lBhV8gZ7wvPIsvhPV?=
 =?us-ascii?Q?n5URTETLMU47ArevV13mhMQkqgA3HLcpHTTT3bHprp9LJztt4S14zCCTFot5?=
 =?us-ascii?Q?rI1YGRhzAv+2+W3oUGhZl8TzJH+XugwE+0Lk+5fY1th/EPELC8MubBrQqYd6?=
 =?us-ascii?Q?6sfOBaYDrrVlfp0nX6rdG3+zbBFHnAQu7vPhqxbls8DowgsndyFTj+PwS13y?=
 =?us-ascii?Q?6v34NMdodq+AVYIejip6T0rfnRgSw9wqbunceHnzdHP2cPU6DplXY83LoXQm?=
 =?us-ascii?Q?z9uHzioTux7+yrRWinpdRNnMtBHAfxS4HHjq1+eBg8PB5wS0pgHXSEbqdjvG?=
 =?us-ascii?Q?7Bu4NBt+CriEj3Tu+6lWUT4Q4ce8AhmgpYkxDCip3fiWEihqkzkfcnIAVTSC?=
 =?us-ascii?Q?cwv+RQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd241410-3258-4372-1d3c-08da01c7b92e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 12:24:14.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIL2To8mm3IVgC/LJyMDhTuxSwd3VIpjc/ELUrl0+Nao8/MQas+E2uunvHO/8mq6Gucx/sHhpbx5//9MW1Dd7Wd71oG1niY/V3oci0iuDaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5271
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090068
X-Proofpoint-ORIG-GUID: aaresucT76ebh5X64t-wxTK_I85ErPhV
X-Proofpoint-GUID: aaresucT76ebh5X64t-wxTK_I85ErPhV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 11:10:03AM +0800, Ming Qian wrote:
> +static bool vpu_inst_receive_msg(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
> +{
> +	u32 bytes = sizeof(struct vpu_rpc_event_header);
> +	u32 ret;
> +
> +	memset(pkt, 0, sizeof(*pkt));
> +	if (kfifo_len(&inst->msg_fifo) < bytes)
> +		return false;
> +
> +	ret = kfifo_out(&inst->msg_fifo, pkt, bytes);
> +	if (ret != bytes)
> +		return false;
> +
> +	if (pkt->hdr.num > 0) {
> +		bytes = pkt->hdr.num * sizeof(u32);

Imagine if we had declared "bytes" as unsigned long, then on 64 bit
systems we wouldn't have to worry about integer overflows here.  The u32
type has a lot of negatives and none of the positives that unsigned long
has.

> +		ret = kfifo_out(&inst->msg_fifo, pkt->data, bytes);
> +		if (ret != bytes)
> +			return false;
> +	}
> +
> +	return true;
> +}

[ Snip ]

> +void vpu_msg_delayed_work(struct work_struct *work)
> +{
> +	struct vpu_core *core;
> +	struct delayed_work *dwork;
> +	u32 bytes = sizeof(bytes);

LOL...  You got jokes.

> +	u32 i;
> +
> +	if (!work)
> +		return;
> +
> +	dwork = to_delayed_work(work);
> +	core = container_of(dwork, struct vpu_core, msg_delayed_work);
> +	if (kfifo_len(&core->msg_fifo) >= bytes)
> +		vpu_core_run_msg_work(core);
> +
> +	bytes = sizeof(struct vpu_rpc_event_header);
> +	for (i = 0; i < core->supported_instance_count; i++) {
> +		struct vpu_inst *inst = vpu_core_find_instance(core, i);
> +
> +		if (!inst)
> +			continue;
> +
> +		if (inst->workqueue && kfifo_len(&inst->msg_fifo) >= bytes)
> +			queue_work(inst->workqueue, &inst->msg_work);
> +
> +		vpu_inst_put(inst);
> +	}
> +}

regards,
dan carpenter

