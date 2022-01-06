Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5A64862EC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbiAFK2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:28:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64270 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237037AbiAFK2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:28:36 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2067Xwlw017380;
        Thu, 6 Jan 2022 10:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=D6vZCrrvXtQOu4iAmIFIgNe2eIZ6SUt/m9fL4rumSMM=;
 b=bBMjenI9pTN1RdgxOyqYC5zS3bFRJMbf6daZtjM7WcCeRWZ+nKDfMpmqWFnysk42Krri
 gJZB+q6hwr9p4A9Z8Vz6iCkhYLCpKUaThn/6CdoD/hntiTiw61vVFVyV6I5I89HU4EAN
 c2RnqUpOnb26WnBqMmPZtMN558s4JvOVLcBeet6Es+gV4LPpqJCSIziDs+CgnQZDTacR
 EQSP+z8gZE5fsKoJ8M2MzT7YJfDxK3mnD1n0DCCxLdbQA/o48i+cuXGquJwXok+tj57e
 R7OC9Ed4u9y2Hno5UhBY04Ayp7g9SZYIfftgnVrHpTg8udE4bu4RlmVDYTzSwdexlzjV Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpm17r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 10:28:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206AFpIV131082;
        Thu, 6 Jan 2022 10:27:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by userp3030.oracle.com with ESMTP id 3ddmqcj0f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 10:27:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIQIN6Mo3DYGxipOEmnSg+mpoYAmpLF6Cv8zjzhkuUTRSjPk0ojIQj4K2Cu/fuRprWohUYwF1ITEbA/6Pxr+BnMfosCUI5v+UEdezagb6XCM1HQJ00lFtoVPFsbxdLxzHWDrHKhqBMtS3wYc9hLiiyX5YIT0B4+o5MqDQee0UPWK6WYLA0H8lLsfLdALOBjdY+/rJ0LE+PFTUxTGAp1WbI/kbDg/rT4OYcDIXkQQnDWN+Tk0YB2pssDcu8TTWXM334ww3TuRWbZrY8kYxN/fd8DLzwurvXXQgPQ84YWDmMjcOyiNqQ29A8C/NjPwvjdYwcXDWdFhcObofPnLc5GXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6vZCrrvXtQOu4iAmIFIgNe2eIZ6SUt/m9fL4rumSMM=;
 b=QiUzKqrzWSf4RYYrTNTkiKKqgPQeeImHYcthRtm0O7ybXLxT+i0JFa7Ir2js/CdbUtQd6zVfm/Yb/ef1RoEAcTG7MAIiG5ZHBrwk9L2YIuxFg9I1z7kj3LyFqAEur1zPGst4u5j5VAa/eUm8/PsGnB0ioqi8UIRhECBNz3FFbqj6mWkdIBchHxZPRTvmXAkwNw2qthIbZjkc6xo7VT57kk4swKjn80Yre7rQqpD0HyRp3Z9YZNl8lvLmmZUG9TAsmVcR5uNbzlIhZUCGOk9StuY3ijniRW0UEFOyhZPKhmE3PF9189+uBMzMvZfwxJ+CEt7dkWAAWndZ6XkFHXP4rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6vZCrrvXtQOu4iAmIFIgNe2eIZ6SUt/m9fL4rumSMM=;
 b=q6O4SDvBn4T3FuANLzAfdjr49DotzyPhOgljLX6KzzU8NghK7zXRNiHesu91BsyF35gDWNVpy/Ox6hsVFbSmEWoAR+3yzyPLHbc/XiGb6jVjJvRogTi2KHCnP+fVZ2fGasgkY8JGBOGUrJtf13DHdsBYET6lXDySXuwHunjv/so=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1885.namprd10.prod.outlook.com
 (2603:10b6:300:10a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 10:27:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 10:27:56 +0000
Date:   Thu, 6 Jan 2022 13:27:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alex Elder <elder@ieee.org>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, vaibhav.sr@gmail.com,
        mgreer@animalcreek.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: audio: Check null pointer
Message-ID: <20220106102733.GK7674@kadam>
References: <20211228020221.1635885-1-jiasheng@iscas.ac.cn>
 <2410da25-5f91-dd4c-77d0-b7226b56616d@ieee.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2410da25-5f91-dd4c-77d0-b7226b56616d@ieee.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0063.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00f7aa5f-703c-4de5-55ce-08d9d0ff342a
X-MS-TrafficTypeDiagnostic: MWHPR10MB1885:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1885B0F5632DEE3F5CEE334E8E4C9@MWHPR10MB1885.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:483;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V66yt/VupFaQaol4d2LO4/1DXzT41lzPytRW1gQciYxOvXFLFoqzqXGN6EvKhsadi/mQWTFPmDxMKYCTLZJuT3Giyk0+DqFEFB1VTENLpmDFAcBVKwfM91YpAIbiQDJhxSJ7TQetd7QfHcAr4GrsYNhxfArrEg3MeUdxnaLi0hQo1xTjowQQur0X7Aru9pfC33lb5Xc239C1YUghF+0bvGidVdc70AL7RUrqKyypis1rihBRxgyL+KekL6FeebHsjGEB3ly3pYwPj7KyWN1aS7NUbFixQqptNUIvOd6x+MaokpLPB2Ns4gdJJgcBCR14LS9uMLXHmbCUnQu5RPtwLCM/cZ/bPh9s5kUJjrqDROG9VJCj7Lm3DR2VO6xXqhrFqChBrBuNl1/06YUJ/aHHyHpC0Io3yJHlctQMxbvvAbIai+GEMk24CmEltyZ13erJDrWv1kM9tdPzOemf90CsA/we/mtlzEBKXRCSjSa9CP/ksNg5G3YcWAwmPjgdiHF9cm4NGwDoo8HeDmTmNSX7dRbbJmnICY7x3YjKJn0ck3zheZwxgZe+t4bAMoSMBOO3QQPYdSo3gM6RS4GfXnJooQZbfSJI7UmaojVgkpIHe19ktc7jox9F3R7uPDpZ4ufRctIh9PI/fMKjci1RUFx04Hwma94/DcJActkfpxK01Bi+o6XU2YKQj1WLCODe5hP2jNCJM4oXpDB1SqrFlsU3sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(316002)(508600001)(8676002)(8936002)(1076003)(6916009)(33716001)(86362001)(5660300002)(26005)(66946007)(2906002)(6506007)(66556008)(66476007)(9686003)(558084003)(38350700002)(44832011)(38100700002)(6666004)(52116002)(7416002)(6486002)(4326008)(33656002)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vaCmDdw6hyLWQje73hSzj7MKFt+f0xKp2F14TeOfnLdcJtQ1/3QW/hj3ukEh?=
 =?us-ascii?Q?T6ga2oOMGdaHWJQxpxg239ruBw+2F+ix/IP4hjiI56lsvFf7UkH1IFdHsymv?=
 =?us-ascii?Q?e1Cb/PKjcvJAsu79qPZCcIDxAcNX3flA/u3viOgGNA7h92VQp6DuX9BPvoH/?=
 =?us-ascii?Q?CGRJTcfB+Sf3wX93ZG9emuo4lWeFTT30/m2putcjvXXt03/IfXP6wbzWE9mr?=
 =?us-ascii?Q?XO1RLfhuhdEyT2P9CEbDZBW4VcYOpUiSPprR6e78iA3xux9EwEjD354PGcto?=
 =?us-ascii?Q?g83wSmf0705rYKxyVkF2HybEBcQSHCgZM7NinTkJDq7XlGbx5BCqzl9GIfD9?=
 =?us-ascii?Q?HZtX1i/S+MV6keu8JKRvndWGVB1Po8of4SqcTxwG31Wi0enFQA/x2MnOe8pa?=
 =?us-ascii?Q?XLw7QCPdEJUB3Bp7YsWGJmBl0LiFfEUb60RpLNwU5LOOywtd63Hi11A730zd?=
 =?us-ascii?Q?OXiFiiQmlLJHUKQIZlk1R3TJQgSObihliVswZEt5zZ7ixDh4SD+cMBiVF7f5?=
 =?us-ascii?Q?VAN0BSp/LWTKzaMmrXzj/fVr2Bue1PQ/h08B6A36MTgHBdUjl1KhUSUxmZ15?=
 =?us-ascii?Q?UWg+10RVy6L3p8sILJLK46R01sS4JoY8WtuH5SsWBloKp2zmg+i23s49nGNu?=
 =?us-ascii?Q?oP6rMl3JHl64AwRnIZkLo1OQCCBfMzSWSd9IJV2Nbzo/qqysZCE1mqcysany?=
 =?us-ascii?Q?eOi/Qx6jSy9JWLvMN/ja8PiOLtGa54xWmhz3Gd79dtw+HA8MoA1bDOhJvhuo?=
 =?us-ascii?Q?p6GZU0okHRfE/Qj+2KYlDMOO2Z3Zn0/qc+BEFd6iTB5bDLpgEKzdblbh7Imt?=
 =?us-ascii?Q?6bTV352tzeioVAiPsntSlY2rL9fpaVi9VrrO+6rX1L5qeQ7rgfmqjKVPDAnD?=
 =?us-ascii?Q?Zlffd1drx39B0SYgUiTGj5+nJR3L1CdNq1FGtXagEtYB5Y0sJjqlCblo2/X7?=
 =?us-ascii?Q?UEDGkQjeUNWK2ZZ7PDLXZi3SjcHWOvu+jVZCKfh5iAPC/l0jUcRCHxUE9A5k?=
 =?us-ascii?Q?6fX/KIUv1BT7eR0K8ZllTQZ0qUIv2dkW6SREOoMiu2R3xU9B2l+lLzcfED8e?=
 =?us-ascii?Q?IPjCCgxGso0J7x7upEJP1Zf7ZBPU58/rZ1fIhroTBAoKmW/dHHPG5SrARmV0?=
 =?us-ascii?Q?/2W9Wu8sDJpwaiJugGSneR5Owmv3WAorteZLXgakewnfeeEg69Lo2Iguz+6l?=
 =?us-ascii?Q?JMAbNnGNz6gIOlf2WgYR31T15OkGllMsQltG4X4hFxN/XLaUUbcXvB9SUsn1?=
 =?us-ascii?Q?ZFRFN6lKD04RnT2R+wgVyHdz+LrQPjn2cyZ7znx9wOCPSycOP4DBgG8ItXAp?=
 =?us-ascii?Q?huHn2uD/bGIvIFCYvoCjgw2lTLesYJQidLyxL6Qmctkm+xbM7NsnORgfyNJ+?=
 =?us-ascii?Q?XRxLW340nMkI24WzCOfZfe7mOsof4A4ewN2vPbgafhVsLWwca6G6dDz4JITb?=
 =?us-ascii?Q?d/Ay9aQVHpyx/BwOgrkC8aSknawdqCrXaRGqLDlhbUVBARVCSTmAJLryFON3?=
 =?us-ascii?Q?cJeftOiVuGdGnWU2yIIAwbsXBhIvJkWygFh0yLT2D97WS2Y/xLGRko9sNCUN?=
 =?us-ascii?Q?vROX2AqwG3w/1IdUcSjdPq21UAOIHCuR4ue2V83hrenX37xbSPHw3QD0352d?=
 =?us-ascii?Q?XzQu0aSlwUC9B3XfUeaA5FzH0eob+Kw3XBTAUNenBfn9e0X/HpVPi7UEZ6i5?=
 =?us-ascii?Q?twGAq56BDIffzmX5zuN4jBUSStg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f7aa5f-703c-4de5-55ce-08d9d0ff342a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 10:27:56.3188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Ie+iHSBaB5AjnVXJvrYLsM28DDNS8+u9X1835B7mZan6pr6jNb1IsmZVhBCmnB+kznLSeGjhLK11ScpJNnBTCeuZ7aJjGIAwh39i2ys+UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1885
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060073
X-Proofpoint-ORIG-GUID: asPPJRk-SeQxlekWboAEkInOwmGo3Tw4
X-Proofpoint-GUID: asPPJRk-SeQxlekWboAEkInOwmGo3Tw4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 08:50:22AM -0600, Alex Elder wrote:
> 
> There is a chance that your simple return would "work"

No.  Your original comment was correct.  It has to "ret = -ENOMEM;
goto error;"

regards,
dan carpenter


