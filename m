Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F314D60AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347079AbiCKLdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348282AbiCKLdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:33:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A432A26E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 03:32:39 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BBRkCA023462;
        Fri, 11 Mar 2022 11:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=TRecXhuLroGBJtvJkeXr/xoFH6XSrCHIJQ1/0plhI0k=;
 b=ybLlbTBdnyvSpN89VdtNufChRWpi3yCL1sRZUCkkzHreqxbbXuynfvjkyZg4Z0w999pr
 ur4+JUEp6/iQ/O010uG40nIgKpY0f73SJUbWjsIcf+yTRSwbzTugGT98KQXo8rdfLk9L
 JYaZiCt+aVxxfRXD8Jgg47gzZigEJz+mGE1b6l/tt3RU0XnNKlIhJX417l2wCdJDU+yM
 aDeipxELRDs7kIAH1Ur3RxIFCqoH3zPGrP88mvAFyS1C+BLG5K4i95DUCxPGjt3iba1g
 obsn8/Ur/rvgapFLOhXT/51cz2fuGqWJpwIuAiO/NKCCWwNsL9cxERwU3Rrf/u0gwiM5 nA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2rxvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 11:32:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22BBHEI1192259;
        Fri, 11 Mar 2022 11:32:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3020.oracle.com with ESMTP id 3envvp37t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 11:32:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+UmsVlNEnZYB3LPg+rpOuGCHib/lMd6Dym58tjUdE1xwhelP1298HQb7KeRzGNC9UN0SEHFyU7Js92dBQS75D+URkRomxcMJ622b/AIowrnAsVHw+K7yFyFfEABATe5XUlP8DVUV/iPflp+v9ZswhxuvoJg5KzrTgczqQWt9kzSHROvvGEZHi/fRm4Jigi7KtLcXnVQgHVSQKSWaGcSGLij/62Jj4s9p+FUn9vIFM9/Vyh6xlI89QTULvBPlvFzdcknMlt4656qgsYPbhSlUtjqMSf4dY4C9I3fdnY9pFZ52Vgyx6uc2rtbRdKsgEadW3i7pNQN94wioFE8O2bJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRecXhuLroGBJtvJkeXr/xoFH6XSrCHIJQ1/0plhI0k=;
 b=OC6r92uAL3teOz+XKPR3CfVCAWc0Kj2/H1acWR5hC2610id0KPtDUx1WYlPbirxsM0xgN2AOEbcSIjD0AVPv7pI41guo0npUgkuwb9QR/ffNq4UdgiH9ovi3higAvUdnIaoLWij2yXbf5xRMXDNM27jQBlLC2aIJEodfg/O+/Sx/5B+CQVZ/013+ZTv24LbQ8JVQ2yiBTVPICSdwgW/5qxg6sNKz8YxChp2p6RrnIPFE2DZyk5PPryTKqUjmuiBtdEFku4n+oOPXJaEzfI0MYCRa/jY6kIF0GD565mYjaUknbc8YJEiKM2a/gITsw/q2RYAl7ZKRZMAjq76sO6P1hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRecXhuLroGBJtvJkeXr/xoFH6XSrCHIJQ1/0plhI0k=;
 b=GZ0aTzA7UEVUvNwPbsqTx9vFW+WlxuSzin6RWfawz3xYRLZR8QtwkZv+ggURBVIkz7Dxew+gvAjihPYU0cQ8Xq3I6B9mzictp0VceYw2I8EeLgYZg9eZwzFTsXwgl39gn81nXY9wXSkBkyxWYGBVOydTB+PkLvArBNFotV/zYW8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2991.namprd10.prod.outlook.com
 (2603:10b6:805:d3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Fri, 11 Mar
 2022 11:32:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 11:32:25 +0000
Date:   Fri, 11 Mar 2022 14:32:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Fix potential NULL dereference
Message-ID: <20220311113208.GK3293@kadam>
References: <1646987730-7597-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646987730-7597-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0061.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6d5d7e6-7c9c-4860-a349-08da0352d105
X-MS-TrafficTypeDiagnostic: SN6PR10MB2991:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB299196D8F43A5E573A55D3038E0C9@SN6PR10MB2991.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WN1iHd3SrtjNl031qtEGGSE2deeQ3FIVwo5vbJ0YjKvj/QrwNjQLIAK5evkgQj4idFBzjAQhP1Gdgi2jENZ9U7YiYQUy+5lvxlRqZNKqkkm6rqhVrEpQBRkOw6IEi2d4rkQOLs0Fz9LZM0OIn1W4onyjHZEhX0Yqtw7xgfRHEsPgrTB3cE4HWl0/7x+kfztkfTfjat1hniliznARzsP2+8CI3W9UMHegkRJMWoAPwvHb+2G+6BDGVQynfq6Hh2JFa0j4ZpW6y37CGk7aILMUw1l3ByTrDisUWdmEaND3HjNzFINsQkX69zJvu+FO7iLbfNukdIGaX21yQgbbF4lFM5ZqG7dMSBxCZv4xd2o5r71NITHZNJ2RB3HjBCGUL3Q3QLrDvg4HcLAAdIhRA195FDkHWH7Wan8QQMztAOnjiNdBo6Cf52CNBqTKO56jbksWjKrfgEu/grfYNcQK/5H/D+4obBETqe+GRitYNdK+BK5rPwULBI4cemCSnRZHzVc9dEaz7HoKLifHn4dR/uxRrCxHLz9yS2G3m8wcZW/z5hW2woWX+id0jo7jg0yk8vxdNTJJ3lsBNL7BHVG6kEZYH40zsNq5GRJCh4rHY4eJa0eYNyC29eX9goVHQ+F5nuQrEegBQJvJHXMVqPqh/P+HhzGDy9HBs+aZDx4q8/+/7YwmOodplkG75x23RiVBkJzHkWC8QdGewiH+opis7J88TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(26005)(186003)(1076003)(6486002)(4744005)(8936002)(52116002)(83380400001)(6506007)(6512007)(6666004)(508600001)(9686003)(38350700002)(6916009)(316002)(5660300002)(66946007)(66556008)(66476007)(86362001)(4326008)(8676002)(2906002)(38100700002)(44832011)(33716001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?770o23y6LHinky/qJlcii1o5H8FikhQZkf2t79rdpUIgBOhOyysMeEYc+yeo?=
 =?us-ascii?Q?tYdocxqBKCDoA1jwoEkAZ1zsYL+0KILkoMzUH8vyuNkOqVeYyn6tTUuCt2g+?=
 =?us-ascii?Q?JV0d1Eh0mp+eVd7rcKiE7Zes2tsm3xAgEzSq9TyskRsCNcUjXBcmp12Q1r18?=
 =?us-ascii?Q?chHub3jLeh7BJATil2jwppt20xaeinbmVk6PSmrxtv+4BfbFD9wNcnMywqzv?=
 =?us-ascii?Q?88j1HvdBUTQXTmyNyKb6xnzy1khsbeZ0B7liSeLToJccoXMyitLui6p+jl0c?=
 =?us-ascii?Q?BwGvN8BoWQQbYMgspQDieu4p0LCLRttGwhuQt4rnsUULJ5LD9DrRPwLl4hMu?=
 =?us-ascii?Q?I0k5SODGXEttzjTS+6Y2sPtKdtS97Yfq6G7GeI/xPgFGbVTIakKRu7dT5TJd?=
 =?us-ascii?Q?jLgkRRg9BGVaMUiR2506FtLxL5Rb4Oz/peG4+T+3wzPQImM/ntMtNn1bYRPa?=
 =?us-ascii?Q?qPpwJtQeggdPhRjezozNxPX9kAXG/Wnr6VFdgTPyZvG5Wt/6CX9nPOQVmdQS?=
 =?us-ascii?Q?TvGEzLs/orp2N95DMe+VEC9HjCsa2OiDbt5KGpBg+p3U7UDddgHNgTfR+4uU?=
 =?us-ascii?Q?+1iGygzd/GVS1FQ3GjLyIwsHkKObdoQF3fgUytvX94gn5TiT1ABunmHasVPw?=
 =?us-ascii?Q?MDEnKmlVotzyqJfvG4YZ5m8USF7ftzi0xOHYlSpLBn48qp/aKVL7VhzdZ01i?=
 =?us-ascii?Q?tRdso1WxFq1+eOGenm4YbBpE+h0mK656+BG5iTkuk17lvFPeo+6u/84hyw8c?=
 =?us-ascii?Q?f+GfDyWY5tptpVn2AyRKv19ZSqGLh4NJhoPDqWG2X0W8+eb2SLClY3Waa4+U?=
 =?us-ascii?Q?Jrr3V6GusueLzvOy9pJ+F7iTAYfsr6DgDGXcRdcUvnZThNSGulsehoEXdFAB?=
 =?us-ascii?Q?R18JydfJjupUJSL8potsMrcblkq77C3qzt0oOeF06ej+5nfsDz7Lu1hKvG14?=
 =?us-ascii?Q?DsP1Gb6dGg7gNjrswrzAuboE25+xIw9HIfmKXWazT/H2a+XQaN3tLrc/QJFm?=
 =?us-ascii?Q?MTHlsZhtBFLA88XlomdsQlEp5OpE9qSywcCeYwY0Z/qgU7uG5gsi5IrD+4oc?=
 =?us-ascii?Q?XWXoHSVYMfXqkn5t4tKnM9OrIeAKRK7e3O0VMwBHnHXhGFLNP3UqWU1TxrMH?=
 =?us-ascii?Q?gWHt34H3FcI+M0hKUXUMY2zptuvX9GQz26zFioTMtD05jymaU7vhx9jAuAne?=
 =?us-ascii?Q?yU6MVX3JzABHoLeqMaqB9QZDhopj7U26NgHaoEAyzzGKQY1r8A2OfRyRNZyg?=
 =?us-ascii?Q?xAoNX8KRL+lvEi6rwSIw11C1T5TR8musl6iooYiT0UXKEqEJqcDF/R7y1kvz?=
 =?us-ascii?Q?Tn9fE8HDr0UMueXtcEMTg1F0dih6AzUAhliuMCyGxCbvqDjHynu8T8wSlBf3?=
 =?us-ascii?Q?ERUyCkSiwsKJx2OKWe4/bb5urf+i7ETjNKfsvekquh8sDcAAPABvTrIMLH5L?=
 =?us-ascii?Q?Uz0/sZTrtL4ak7ADlPt0etex2Lsy+xwA97Lqsm7R7H7K7V20pZzshUjAqOOx?=
 =?us-ascii?Q?HIUtOWhErNpf1ZcHq703Mr3RNOoZRdsFkVU9iBVFZbArmSCW0D+NvxxVuPq0?=
 =?us-ascii?Q?NzQSvJ5n3nAZB2oH4Rf2qhUzDXnNuzKzsSYehP3jD3diHconFeqUMTzUesvG?=
 =?us-ascii?Q?1iU6tBmImucasJnr0NupGm26ESZteeoOySZ5H8L1YvWntj43ZCWZh5zKq8rC?=
 =?us-ascii?Q?pEdt0w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d5d7e6-7c9c-4860-a349-08da0352d105
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 11:32:25.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtiuNkFTuHjqwAvla698w9XF9r9iK6yXNVaid+dCGdECnRXHMvrHD+LdvN5K+1hvLi0FpG11+seHTLyHejsL+KI8oBRoymxEi3fQcEQKOq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2991
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10282 signatures=692556
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=959 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203110055
X-Proofpoint-ORIG-GUID: b9p5_bVb2PkS_pVhKldqxf_k97aZE3On
X-Proofpoint-GUID: b9p5_bVb2PkS_pVhKldqxf_k97aZE3On
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 04:35:30PM +0800, Haowen Bai wrote:
> Fix following coccicheck warning:
> drivers/staging/greybus/bootrom.c:301:35-39: ERROR: fw is NULL but dereferenced.
> 
> When goto queue_work but dereference Uninitialized fw will trigger a NULL 
> dereference.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

Your patch claims to fix a bug, but the warning is a false positive.
When we "goto queue_work;" then "ret = -EINVAL" so that means that we
will not dereference "fw".

You should ignore false positive warnings.

We would apply the patch only if it made the code more readable but I
do not think that is the case here.  I do not really even see how the
patch silences the false positive warning, but it may do...

Anyway, the point is:  False positive.  Ignore it.

regards,
dan carpenter

