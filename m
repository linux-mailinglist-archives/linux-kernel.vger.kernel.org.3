Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E6F4C9BFB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 04:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbiCBDT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 22:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiCBDT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:19:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FD4B0A75;
        Tue,  1 Mar 2022 19:19:15 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2222eVR2010950;
        Wed, 2 Mar 2022 03:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=H8tfBOBKj2j33gPvEd3BkzqM425qobL8zI4bPlJgWbE=;
 b=QMoV1y5JsKMFcbLFM6W6L6yB0AZC3SX/5B4XTbI3YfuPhv9GIUgD2wjowAg8TgOHSEcy
 mEJgnukpjSnvALny8tEPqXXFxm+MYfEuA7l5bg4wdqxnIp/928tI2boRZkpJ1zsjm5Jd
 lAnVN6Te+z1dcH4pFcgMO/bBenWEt//CUwxOroPK4O/a1uhLO3JwXT+pGwgARLL8Wg0t
 fFY/ypdsfSJ8uUf2p6HuGLhfNbadmYn8bBrt/W5uAexwUPZFg1+9K+VQTuhZnCYPAt1X
 9HwmtdPZC6e1HXuuHonGrLX0nQWh3dtZzrhVez3DAqWGvREMducFWGomVuBcGGQCZx/1 Fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh14bvqsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 03:18:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22230p9G150423;
        Wed, 2 Mar 2022 03:18:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3020.oracle.com with ESMTP id 3efc15pk8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 03:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmdT1dlBu0jNEDBYonzEDQxX0/qzR727AI4pyQTVE0myAA9yPe/g1OwO7AhCUujkgqvZAfnbJh4XKkgqe3yX2ytOSI542xIkcQfim/6cQggFufvDhqFIp3o6RY3aeAD/NeIfIlG8gZGYm/DFLKfgPps2l9pEi8EXU03ODoqreg9Mvx/UeqaakQM/vtY47+P7JM7Si/GgaOtZqjeZc/5nmPxYB3ntSizq+/UnyBuINk+9cFdNVplYZT3M0bnMyFo7efZGjXMq6ikpdwfrVqgjmgKNQz1AtHLbUHbWekdVkTpvwTfIEyCfA9kzWIpVkVlNpHYF+BqPLtb//pU0U9bRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8tfBOBKj2j33gPvEd3BkzqM425qobL8zI4bPlJgWbE=;
 b=fYqdnw+fNCr2yL5S1YhKKZRNbNdrnGcwtPvFQRSliqkFZ0IvRIYLLZWp6vuanjZMPnU2/o/nPrjbl+2UO21DNDMKeWBUXm1sJmcqzJBiqpBpJ2+GotrDTy8c2vYW64nxgefMmPOrGWOUkejpbM5LSLs8utG5ER3c6p0W1wd4GG+wm0xjcu8YP73MLdYKySWMANrNB2L/583tFvyndwydCr3gZ9AKinmXOR6la0yCImVCdlDFT7wOdr15D3vvCw3KRgurNcpcqrBszxAzhjT+Rryg9EBkI3SIUrgJ8+bKbTFXDvVvGXFrndMAexavMTZhsgOiS460sdYiUqCcyPa5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8tfBOBKj2j33gPvEd3BkzqM425qobL8zI4bPlJgWbE=;
 b=n92zXnHNIlAJWj1ohOyAiJIvz96d8LCOzKCBYt66KPXXslMGDTLJp7c2thHs+ZswQAZQap9oAxezMk6OkO3nKx+aOSL7mm5DERmcginUgEnxoGQMAvacsd3mCk/O8w3Ccg0VbXvZnxgWx4LVUMO7kitjRwSe+zoPnlKaQI+EKqw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN6PR10MB1794.namprd10.prod.outlook.com (2603:10b6:404:fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Wed, 2 Mar
 2022 03:18:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0%8]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 03:18:54 +0000
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de,
        Hannes Reinecke <hare@suse.de>,
        Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCHv3 09/10] nvme: add support for enhanced metadata
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lext11qk.fsf@ca-mkp.ca.oracle.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
        <20220222163144.1782447-10-kbusch@kernel.org>
Date:   Tue, 01 Mar 2022 22:18:51 -0500
In-Reply-To: <20220222163144.1782447-10-kbusch@kernel.org> (Keith Busch's
        message of "Tue, 22 Feb 2022 08:31:43 -0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59a2ba5f-4bd9-4f5f-3d09-08d9fbfb6153
X-MS-TrafficTypeDiagnostic: BN6PR10MB1794:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1794251DAF2440A58E106D8A8E039@BN6PR10MB1794.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8XQBf7PgSeQzUTNlNEiTcUg0duHVQJEaOyLw7NV5dtK9WelvRdIWVV+KtbedMVyBuUsujSZdd42u3fXq07B0S+hSc1cxTQ11bjbVPpqtjY8XXJzBJZOHXa4oERoask/MID/NDM3jApoAACsF4SWu/tz25QMeDZ/a6Ctppqh63jkyDLObsiwXtJgaz8peKWgJG5YFeO27MniCfry0AcTzTuYuwNBDYIgBJ6RuzKbyRYKALzOejkfofAtkjOoRD2sFVxYE8s1gBDlwVaWozzXl/VwcUQlg6ksltvcBmZm1q0Add/+QrRJ+6SL22Az1WfI9TOhSKsJIiu+nmxnF88tMhnha2LdeAWIgr5dqZFg9OpV1Q18bHky0uoHq3ykksL3dwHYT0xZ/fvUsTG70V+oOfdySe/agKHBMTGwWINo8Bl8irUHFBjJUMwlDvHSl+4G3ep8kS+SchgKVcUoLGETxS3UoE8afDNzwahxRirKINYAnR6xa3id1qwtsX5uSlZO1TnabNz/d6FPOwb3yoo9q4PrqjTqD/9bzN8F7jpzX+557Qqf8pzwd0NDnXh1ddVtGeqZDNvBdnsMaVfPsmKVBV32yAWzOxARf8WQlWT9Oqh6VOQ2skDtEXMUr1Ce8Kh+2p2n5xYh+4nckH02RlGPcMqJCnmTXo3ft5BvptlbHVoNVB2swZo9tZPTFzgspymJAiFKoSXZhihxUelimWSAXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(316002)(5660300002)(6486002)(38100700002)(86362001)(66946007)(66556008)(66476007)(7416002)(8676002)(2906002)(26005)(186003)(4744005)(38350700002)(52116002)(6506007)(4326008)(36916002)(6666004)(508600001)(83380400001)(54906003)(6916009)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bC46E5067380QVX2vxUHyjxOOd0iqtO2EOfG2LzfiNSSU8iEdDnYFjaHUJlz?=
 =?us-ascii?Q?naCldgBpOmcNNIJnu6HgYhWP67AUgDbbhfVyBo6rRWuPoHo/FqMD8LvxmlhX?=
 =?us-ascii?Q?boMcJqYsuWlEsaVr+FOnKux77Kf0QsFn4auQH0X4SXs4/kiwaSzCz83sUm9U?=
 =?us-ascii?Q?Nek1677flMxFljX3qE0Kex52falr1Gb4EglwBzdtmM/4UEMPBFAA1kOD+FXz?=
 =?us-ascii?Q?fjXyLBHNXBWRv6qASrDxUA2GFvF9ps52yP2Jd+8WuT1nwixfvefKW0/fQaZL?=
 =?us-ascii?Q?3iz4vjvJoTdjMQCIPs7gKzvjF/huIWkoHCYmRwVmmMkFsJaFsejZEUccxo+t?=
 =?us-ascii?Q?xK8yx2JI+/CX51XXENuzYDBNYHXvzYVOFyq3qh7VosT1+4oA7rHseZuRaW9M?=
 =?us-ascii?Q?a9xi/1gJmk4cMLl+pbDKfmEX+5LT5yat6Nmsq/irAyOBXkfgexD4+xdKs0Bu?=
 =?us-ascii?Q?NywRsFUlo5hUsS71lQxUFq3RD9UEeKjwN9ZE187OUd0bd28YM/ClXmOh9a0B?=
 =?us-ascii?Q?hMLPV1kequXv5/aglgGvqa6KE6+9AiHfIUca6+5gJ315n2gFUhAjp/arUDEd?=
 =?us-ascii?Q?/F8589//tCnr14meedv29wclBWer75+uJsd6NAjYmTiwm9Lm/0d9umsE5Sy6?=
 =?us-ascii?Q?ov2AXrhIjos8y+Kgyg4zArfwYS3YxQ0TLxskphqQKcy8ZpWeksGnFsUAD8Ps?=
 =?us-ascii?Q?4iO7bqR/dNIvddrlwo63s8DQlimxyGBl7yYLkleAxicbspmkqdD0t846uPe0?=
 =?us-ascii?Q?Yzhov/GO3T1m9Nwu8ljmO1caxbs6ULY5Np1SAhRbSMmFl+VDsgmnSbNjCZ88?=
 =?us-ascii?Q?afSMrLyqNjio4xxRoul0fQOFegMF0H5j4pyVkyEvyttNPPHh+mGxDFSTHN0x?=
 =?us-ascii?Q?SR4dQbOGlHQiUUhkZ7u7CZSU1JvbUfdeK3cS9K1KnQLvwVzztu6ofx0Q0aaA?=
 =?us-ascii?Q?OhX5tBpRof2pMwR9mPhbLHpphANisg4MNwCisxI7Q3TUcum/jsdjH7AZwU/w?=
 =?us-ascii?Q?RS+c8TxokQjxeIVW27zvRFV9flaQWhVF+iAs/LzibldtbiLkfMoU/VI6oQqt?=
 =?us-ascii?Q?LUORKjAt8qS6G9w504Khij5/D9gR46vUPvG8DuPh0bB3EGap6DXWe//N2tQ4?=
 =?us-ascii?Q?ZufRANevhw7uEy4IHGM0RmwoeMKBse6FPwKg/9l93ziFJwd+CfKvkzRbqMQm?=
 =?us-ascii?Q?6rpNTU0Q+EQRtoxuodt6jhAv9nQRGxPDUvK6z6zx9BMqElMjYSiMSVjePCF/?=
 =?us-ascii?Q?kQjCISDEPOMCmhQx+kH3AVKQQkLfYV1clXEKOAIjLAnLHIB1X8FH445KB37v?=
 =?us-ascii?Q?y7Vjg1r4zytCOQwBSAhvOf9iOrfQBrL8GlwdLnORtr9fr0Rk6LOAkPxKhtLm?=
 =?us-ascii?Q?wCvivLAjGplN8o46dFo/H+kfbZvsz6SwhE+2g6AjcUkv+Yu6SdiQH+FpFPYI?=
 =?us-ascii?Q?d1gZ0MQ1QfXKNaAJZLVFGxFlzT+RfOatKRB2ZlSkUeV77BE7NuhXluHTMGLj?=
 =?us-ascii?Q?3MlXXPo+kZwIFWTcOleWWXOe9PoskYE+0aLVUsKX4WTZA2H9mdqXbhhYVk8D?=
 =?us-ascii?Q?S5FuCt0Zs/3haFtKpXaZ2xKC59uiBIXuR+HHS36nVnN7ecJ9d2CGdBonn/m8?=
 =?us-ascii?Q?OszAfv1fMyagj1b6Fj0ouA9xD7k9/ogCbs6WtCDbxu8zoyaIM6Quu7jNwnnO?=
 =?us-ascii?Q?bXpC7g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a2ba5f-4bd9-4f5f-3d09-08d9fbfb6153
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 03:18:53.8938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4d8rNKBDEvM4qlmEPeT8HneQPxwt0RZLxXI65pr6ppA78syI/OUfAUI755UjpHC6qZw94KAhB/BmXcYqmyZ1rsd0xeSJdmI5XFafdQ6zzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1794
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=997
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203020012
X-Proofpoint-GUID: uNxB9DY_ROaqbON6PPMIt9vt3IJ05JYo
X-Proofpoint-ORIG-GUID: uNxB9DY_ROaqbON6PPMIt9vt3IJ05JYo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keith,

> NVM Express ratified TP 4068 defines new protection information
> formats.  Implement support for the CRC64 guard tags.
>
> Since the block layer doesn't support variable length reference tags,
> driver support for the Storage Tag space is not supported at this
> time.

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
