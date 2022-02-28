Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640F54C6112
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiB1CVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiB1CV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:21:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960686C1DD;
        Sun, 27 Feb 2022 18:20:49 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RNqL89026186;
        Mon, 28 Feb 2022 02:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=zaCTdqpCKWiBn1hUBMU+SOx/CkffRBz3ocPFi6t5+dQ=;
 b=jreeHuPEDnDMZRFDUmZihi5b0rAuGuWIbeOqKt2qc9J06Sxh0EMS7Ywp8S2hUx7ngoPS
 k4hV59ouhYIIQ4qgHD8EJ7cSkDgnZu/O0zvqCAmH0WlTWxSWV+q6vWjc31sqUacUltFM
 Sy+AApA4PP1Mbz1/odKM8zcr3H+LL/uHWuLeSCvmqSRCcBLnwp4mIKXtGIdVFIMmvPPC
 8XQP/RlNPzrRNsUr6Co3Nsm0j1xvLrXhUBnhnSge5vnewrVBCNms7bF1eyUmmWnik2Qs
 2o4qpXpj1GQEA5jqWYWoun2mpEbr0GW9p10ajV74sj1ptesDCL+CalT4U4BM3n7pRAJE HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efc3aas6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:20:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S2B9aW001675;
        Mon, 28 Feb 2022 02:20:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 3efa8bw75f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:20:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBwRtkmNuP2Qc+Y8lb6pO4uTnwN4urxsNx7HZb7oM8GCS5FBvqUFdRuoKBf2szIG+0oyjp83bY6D2P0cjhQCiqQ7ahwGAr3mZz6K+FDtRz/CZQEUxDTekf/7Iom1GQMMdeA96ZWI88v5KT6TcUiRUAIa7GT8S3s+a000wGjD3O4fhec806TnugrzZnaBYpD30k7zfyNEG8CJsQq+g4CKqmEh9VjHZoxA1cNqM5RA62f0tTrLrsiObiF2iQMgg507gMVT3Xd1TFjidwVaiH0QKPXXhdFbvT0w10bPIeJGZoB4SDXhm7bZEQTK5OYmm4rsurxXefIST/y0VMrbQcMMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaCTdqpCKWiBn1hUBMU+SOx/CkffRBz3ocPFi6t5+dQ=;
 b=j0ibfwc+utQeG6dJ8ElUgzof1zJPuIVe0IGfK725dY+fYYlpMrq4poZnJaHKeeXz0CokG7MZ6lhctDRATvfGgz9NiUv0Lt1Ddgkei29sTrFH9vX7OwKEm0PwiKODjlEef5X7A1eQoNCD/TUMf3akimALOXEecfukz72Q6ODMPYGlxa9BoHwQh4hI34s/BrbXY/Fg/bJcXAlnJRQOLLxTxVxK5DFR9Jpzj+ONRn746/LE4ohh5wtUdBddfrjd/3SNi+c7AdgeQeQoNZmZ0KwbdI3HOLff21rMsYJeYSgHQK9kXQdeRE3uAmbBZXvSUXciXVeGYlqYKg0ANyAWpLG4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaCTdqpCKWiBn1hUBMU+SOx/CkffRBz3ocPFi6t5+dQ=;
 b=oWYnSoX60tXIjHGS/MWbM3up1RHEv52IwebZ+Z41dudCwD17C/EfmBUOwpQ/kbH7uKjmX7nJukr/5N82XB2RgSaiX029k4ZpEybXCKzziWIQL76DNiKLhK0dQlxFOssbQtEapMuDEV+dyjQclyc9EcVW633jsuvGpz64sTHPojE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB5167.namprd10.prod.outlook.com (2603:10b6:5:38e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 02:20:34 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0%6]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 02:20:33 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2][next] scsi: fc: Replace one-element arrays with
 flexible-array members
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lexv91gl.fsf@ca-mkp.ca.oracle.com>
References: <20220214223903.GA859464@embeddedor>
Date:   Sun, 27 Feb 2022 21:20:29 -0500
In-Reply-To: <20220214223903.GA859464@embeddedor> (Gustavo A. R. Silva's
        message of "Mon, 14 Feb 2022 16:39:03 -0600")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0072.namprd05.prod.outlook.com
 (2603:10b6:803:41::49) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb909c69-dcaa-4b9f-54c6-08d9fa60e64a
X-MS-TrafficTypeDiagnostic: DS7PR10MB5167:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5167F77FB59CA91DB033A0418E019@DS7PR10MB5167.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbnbzO50t5LXbLrOt6vqzlP+j4I8KnOBGsPHrS6t1cRCmlyLWXIqM1wME7VdbyGR4EbVTGFyXvwx4teCKaDlCBSeGyuX8yC34H1ZyDZj7klcv6iXlTUbEaqq/gpwSimD861M0uZMMFWwtsxt/Yr8L8ipHAO+b76wjEHW7YcccHe12nULOmz8jxVNEZUZPPsxem03qSiNtuZfzkNoN4Yi3Jk1Sk4t9KVAJdSurduitQNBAbuoPoue1jzLVcMxz2tkb2IS3c3OJYkvToNqQp7PxCUBjBpq6LHRxiGByWC9/dmWYH0MTlARjiiqsZ37FibO009xTLtMNwH1otmNbsEwBWQW6IVdFOifVUT3f0DIJx3rGm2mKAo/fxi045T2a+gKZK2WCQQdzD6eZFqv5bjH8xAayoFJeCnynyVCRNElo9XKaTaEZtpYZFQZ62f+HM8Esm4NoBnAwNnPdbu+IshdwMZ4btJXhCt/NNsQfZLNnVC5tDOq/89LcBvS4odU/ho2R5etdOsVluT2QqlU/GVPf1hqDyTdf6BNvtf2ieB47G033DpAZ1fG8IhQwTJIvD3VKEpQwXGyLavaKpUxaNPAFZ82UsiKIl6nCMy3CHNmXoMt4oa+YSvUAZRji3LgAtlXLIF160x5czL8e5+FRZZmfKGwh0uWbqelog61PCBUnBB7SzrWVZcyO2wJM0m6KcYNCqrtCdYkv4wmxXUh8yjc+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(558084003)(2906002)(8676002)(6666004)(6506007)(52116002)(4326008)(8936002)(316002)(36916002)(6512007)(6486002)(54906003)(26005)(6916009)(66476007)(66556008)(66946007)(5660300002)(38100700002)(38350700002)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W+acetuiOROO7q9d4nJqjbjytM21zNLfe4O/NtvJmQqp5aI0iJW/SYLMk0tr?=
 =?us-ascii?Q?pkWN4uPi+VQdbNeOk3kwHUXcsF1HRlL7ubEVR9W/DE/0HpqT7DShfEdByFYw?=
 =?us-ascii?Q?l0Fu/Ydn0Xq9jcUMDGTFlqFWaGZUZQdVFmzU1sBDjdjamhQwa1BnsG2LiVVW?=
 =?us-ascii?Q?+6iHFcxSjK4kI/1Wfy7zFO77cREIbk7IvhQHdrHDVemR9lzVG1YE0im0ai6F?=
 =?us-ascii?Q?2WNdW11zWc3FegoHTZgX07/vfbDg6Q0IpMrauAaKhV5+R+B8MjHwF4/ovlZR?=
 =?us-ascii?Q?bijmRC7Obl140lecwlWOml8Xy8TJ2ard8odszx1jH24CtRHzdL+EowqhKLBs?=
 =?us-ascii?Q?S+aW8EJZVwQJKvHQZVh9malz6pqoaGLezsme+ammOh40v+VBNPfWw7JcFuKY?=
 =?us-ascii?Q?yzvBCm7g3yHtOYZe2e2VsVWqZLpKN04xDKgZfzB9jd/4afJ9CvxYbAAmAD28?=
 =?us-ascii?Q?UK94UkPl4Z5sQwrtuqixmgXHk5RTnIdFcEiiYMlEsCC/pve3KZpodwIT2BoK?=
 =?us-ascii?Q?uk0lS5e4dv8EWC9TZpwLAetR47O7mJLd4sTdHVx0mFPb3Bj3rK3l9AS7PXbt?=
 =?us-ascii?Q?oEammgflWZNSFLI0ti3kTx0Do12wPMiCmIBCIVqyvGQxxmzgeAcjQTBxQIff?=
 =?us-ascii?Q?7fJPSgnoLGW1AwjP/OG1VKmYQ+KHZUsUQVq1Jsz0mO7Ylg5lE+A3aAP4hk9g?=
 =?us-ascii?Q?CA8pEJN5ErFUhdF3PZhRxBbKxrHj9yiJxfixOLAXELzeL7NTKDBiiUv0e081?=
 =?us-ascii?Q?jBVuP9iUHV3/Qlp0n7c4cV98VVBBbAROSjcWpI61q6AtjgTqnBHy5DtZKMOz?=
 =?us-ascii?Q?iu+344QA5vhdYbpi7R3EcwQ8YFgdoadlhFvnnHhq85o/fS+rMk8PyvwgzwJK?=
 =?us-ascii?Q?/z8Oxed1pFmkgLzwyupr/t1DhCoc3bhSe3yhwuY2UwxL2nz559m7mSm36yBx?=
 =?us-ascii?Q?NsywZoIOdQUhmhZclJCEucXEALUWpogx+oPKoiZefdXbNsQFzQp+Bk8iKOMU?=
 =?us-ascii?Q?6WatwyHD2lphUXQhlVogNJtzgWdXLoaC4L0mKnuYPtBne/h5n6aBiGBp8+dQ?=
 =?us-ascii?Q?91OsZPnjV+iAzOBa3a4W4VbO4tvwNU8WOQjfAenWrr+QbS4LZtm/JzIjnkQr?=
 =?us-ascii?Q?ePizmDwsp4q297LTirmIoeAhj1K4bs6/8SV7eWsxwGGz/jYLhOgX3s1H/pcZ?=
 =?us-ascii?Q?nTFEOhPyNqmrJG1aYCtrgTTSmqs24BnkXxkKFkBTERJ6ARJVbA52+ZKiNvtQ?=
 =?us-ascii?Q?Uls8MBtUHNqEdiRYnT6n5mIuI5GFzCQLA9ol/WcJon4Ba+MrRWx2DYaJ/RMm?=
 =?us-ascii?Q?z4nFWH/oBeM2VrBRCdbe5OsFR5oie8pW5fPNd2xT54igHBW+C4OcOa50N3hh?=
 =?us-ascii?Q?0wylRxcc3NUbHPLRvAKGIBCYBFpME1DgsM1mP52mtSoIqMwigek99Bw3RqTP?=
 =?us-ascii?Q?cm7FNHXOWcxzfG3tOlfWn4NN1725wC2QqXJT+yS9XcqpEkesW0BKuWeyH7CM?=
 =?us-ascii?Q?ZRJ2Mh9LMY1FfAVfGYKZVlHYZkDeV5Y5BHFvQILptVtjiaJDO2Hhq6clCUu5?=
 =?us-ascii?Q?pu2zJBKODZvhX7HTLBw8P21pQbttanV8Xn1jOidc4NY62tbAz0W/ANUnxmjE?=
 =?us-ascii?Q?YaASylp0jqIPdXTzgOuSLtwxKss+aeCqTbShSdtlJox8dDN+Z82bOPdiHbAk?=
 =?us-ascii?Q?xozSNQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb909c69-dcaa-4b9f-54c6-08d9fa60e64a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:20:33.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kdsg/qhbIEBbcne3TRNUG6jJK+e96hdarGNNb1+0QBqJ7zTWsfXlZLF3PXciHjvmISNLOOcIByMccSA9cZDzSuULaNvsvUkR4P8tf0QHn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5167
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=806
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280012
X-Proofpoint-GUID: UXqpGMrtxMoMSYOofR9D_CyBsCfzFScN
X-Proofpoint-ORIG-GUID: UXqpGMrtxMoMSYOofR9D_CyBsCfzFScN
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> Use flexible-array members in struct fc_fdmi_attr_entry and
> fs_fdmi_attrs instead of one-element arrays, and refactor the code
> accordingly.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
