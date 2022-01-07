Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B431F487424
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345920AbiAGIda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:33:30 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48888 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236245AbiAGId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:33:27 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2074QvjD009297;
        Fri, 7 Jan 2022 08:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=rDTrtmy8ADEMeJGyqhkCIxQ3RzwdKdp2pZ3DO1kK5D0=;
 b=T/MFCgrqUwI06aRqZQZIEe4SnpBhuWvrMr6eGioAFQFxeSZM7Vy+dKVvY335bW+h28t6
 NttobyZ9ER8iUgIseHn5aU9jQrmjFnN8RFm4JjKXSbyRueO6ZfwEGRJxHo4mGOmmF+2T
 9LRm4+wO5w2PQTSivUN1JZF7sYRjnXLbaNFDdaqUJ8Z9covMvwJco5j/CkYWkDHFCYAl
 rrtntevDHC2ViCeJeMlw7aQMcAMwfxmiyta/Zg+udMOAwHrJpkfnJ66UPycbOVsGxMCv
 h0xOKPFqmobrkhzk8NObhpstAb+dbcQOcFUqvL3ERjo/apd4/4DYU+kNJHx4nqDljUu1 9Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4vh9b7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 08:33:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2078PsMM146385;
        Fri, 7 Jan 2022 08:33:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3030.oracle.com with ESMTP id 3de4vxek9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 08:33:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sum5DxWKvM/WNx8+IwdtCFeSB8gBkgRJvx1Ep6wnx1BmygYtOBi3kb+La8/wB0VB8OxAR0J7x5ArKL0W1gMqDzXwwBZyOnk9uR/WwL6tmK+wrZ5h1QxQDoy7kauPTHkxt9BXY1NIVPpKcyFhAvJptxDVcBgJl3OV0SFGKfhRSWNiRI0/bqMPAWevejyILT8Gd9m4K4muxz8SiTJLMu6HH6ON+iLsR0QBsgXH0WnNOZZAmARRZjK0vT1WOzRlyps99ILT1eotYEXmIefPRS3qTZ15D2XYOhwNP0Ttf9ikk7I/rEM3I/YDnqw9bF2e/02IcGJ9w9Lpkdn/1Rz1gqQcKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDTrtmy8ADEMeJGyqhkCIxQ3RzwdKdp2pZ3DO1kK5D0=;
 b=STIpUKQQ/ePSPUsGL03wxXNsZekgVcZdrRVHC/eCm51c0wfFR0cgRvcZdT7WVjPtwSJFbJT0lYS6eajUgaOf5O6GLxoLcIbFQBuSO2Vi5l2YP3AL2JrxKv5pyWI/G+LPLG3lA0c7Prn92kYMOti4qxFKzfrmSV7DPqPepEIhBWtecIV4rNcSYSajP/6xbFQOfl0K4kxR5rpN6NPOEXeRw6qebueOGL5CfpZdKy6CEfA+HuEN1fq424z7ivjVTgAOYx9QjODILEFKGr3Vo7Ob2SB7W82X+dandH685hVHrmg8mxbYjQLRley1I/eiZR9p4ORQjdPTdLBh0NDyjs5FmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDTrtmy8ADEMeJGyqhkCIxQ3RzwdKdp2pZ3DO1kK5D0=;
 b=fxVMhAx6w9/QtAg0IIP8Gdbz//2zifqfDo+AxySLAOYfwweegkO9uz9Ze3JIakpOP8TVjQFVl2lcNl9eY+0qG042QihD0MLLmGLRDxtgnTejhEIWrjhfV1drxmErj7/LF91IohkPrkkJDU13zBBrlotdIKyfgrMu5+G15c/Hxn4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4691.namprd10.prod.outlook.com
 (2603:10b6:303:92::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 08:33:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 08:33:19 +0000
Date:   Fri, 7 Jan 2022 11:32:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: move get version func to where all other
 functions are
Message-ID: <20220107083258.GO7674@kadam>
References: <20220106093110.GA20011@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106093110.GA20011@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0060.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fb64b4c-ad8d-4560-520a-08d9d1b85b86
X-MS-TrafficTypeDiagnostic: CO1PR10MB4691:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB46912E22979ADEE9B8DA67CD8E4D9@CO1PR10MB4691.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHqniYvnQ+kovkutyVJvew+zJGiYnB/sDIbMHUCtPyMvLttQtMtE+Ml2EtJPw3ibQUJsH81M3+GinNV4pohgx6vKRE05ywjaV2sw8Ruvkyo+oygX5F58DZ3YjDa76Iv14goi/hg45B4g8/L3BVXwsYZSmbzit2LrQENnQ1eZou9Ay8PzJGaIAVQbzFoY8Tgg57GqMSbbooLP/nOjfiCXSrerhglupePkWCZAIXjR4gpbROvu+TbUVKPBtkdj2cL5PUCP2r5ShiRx97ETWcV5B4gWueRRSuGu4mUoha6SPVU2Lu0wlLE1Cb2fUVRI58TvtOxgqgVIBTm6DyjNEtEsebNbGzrdAqV2t3s1w0JkQKohmr9LA7AO72VWyoQ0F+r3m7jQQB+1JsXhpPqP3Yg11s4CPVJS421kLovJ17lI2zDCekGX3/IoWYt3xBE/TfgtjD8EeFfrTClcjm0pEKg82L7a75mNptzHS7zRu2HR7UU/3ETyMqaPQEQcNVk/w+WjJkLMzzt3opHoJj7a40vVGwZkWPKtjs5ZgVsxgCFLS3SIUA/qzyIs90S4aMwxAEfmx5FX+pbmImmzvrDZEOAKn6DlC0x/v3ErFrANMCQfgfC4pKudjIhDu+yk4mad3Xn2QuDtPrx+IKEZ1gpDoCyIVdUUH8W7MWFe/scEtvzvUEO4McqVuMwKPI1S85ioupANAwVEc8fhX0xrDK8Thc3TTb+1Jmy0bJ5AKpMvgjvIyfa8PpoyalLSL8eoDOSrMzf9qCTnXkG1T/euWtRBfL+QGvDe/IGrYrx2kR/Ikaci7XU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6916009)(44832011)(6506007)(52116002)(5660300002)(6486002)(33656002)(2906002)(9686003)(38350700002)(83380400001)(6512007)(1076003)(66946007)(33716001)(66476007)(508600001)(66556008)(38100700002)(8676002)(8936002)(4326008)(186003)(4744005)(316002)(86362001)(966005)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p5QF/lT7bSG+ETneh3UqDTNdopx8VXqnrcCxFpI20WwE3o1qzt3A1rappjyQ?=
 =?us-ascii?Q?nDe8iXlX+annmdGz18C3UhIm/iFBxJwbOFP/utcQH7ssE5yrop4tlf3eTT/E?=
 =?us-ascii?Q?3KQ3d/r1tZpaS7Z8OdrbUw9ptgyV5Kpf/6IMGmEMG0NQi8L5GgR5DoxzCMR+?=
 =?us-ascii?Q?4XOh8dXidcRLadUE3dxPVrCxIZjpEYnb5H8KgMMSSsXNfGtGM9Fu2jfo9DT1?=
 =?us-ascii?Q?KOabom8Fe5uDcEBFutV19onJasHAcnmZAfBq7OpQ5UVS0YObdyjapv7VKPJ3?=
 =?us-ascii?Q?/oN1So4CiFEPDLzY/Yuc28sU86XOI8yu168w0GaYrNG5DGW5Ajp9jrjQVclS?=
 =?us-ascii?Q?gaMqkejG718k9DAhV+o75IvIlp3df0NgVVxaP/nTRet/p2EAq1noP9eMzbUR?=
 =?us-ascii?Q?i9ydxybf0ShAi2ph10YgsaGnvqF3t774k0xBU9kbKhnz8WGunF2XfTuZS5eH?=
 =?us-ascii?Q?LayPKdw0JtJ66iYrK+508TDrNWhlTjVmga6a84ZKCRiAumx2fCNCBhCds/vK?=
 =?us-ascii?Q?AzMk4vtQK0KSr27hAHkIfa+5byWx+iLl7/GxoUfRMJjgOy7b3YUdhX9Z9lZ4?=
 =?us-ascii?Q?wYQIpiMAuQ/4vcjTmoyvcd0hF/uXe0OWpX1uDRF5jmeBuloAJ3gglzxywEtZ?=
 =?us-ascii?Q?LwRCZ5HN8EOHdP8lKZjktvzje4SEtGnfHJSmnceinqYbzXqHmJ9ssAu+Txm0?=
 =?us-ascii?Q?ibuznuGY127ZRQLs6mDwcoYZDBSniP6vZXWdr7II7Fz7x25+Z04Q+3xxAudH?=
 =?us-ascii?Q?OAoFUOrVYlamLf+YTeBfvr90znk0E/RbNER+jqTBcrfedeKYi+E2gXLDyIHH?=
 =?us-ascii?Q?cr9CBG5u3fkjosyp57pJOX+U1TmbZJ8uIx3cY13z0NECwAnt5XGXaNPa/LW2?=
 =?us-ascii?Q?QJFQjHnn2G13avNcvgTP6zrmZd9z4OsDqHXkSIMxD3zUW7rkMXqmS41ZkuqQ?=
 =?us-ascii?Q?oMwc7hCtJhydHEvGEsdFzuGCqJdsUwLpHwLYqcuBl7DJfiwbn1xwWq11gPqU?=
 =?us-ascii?Q?ODJyDBym5Qh3rcH1oz6dTRWlLirJjTgr0Lua7iAdvSCcXpxeyyOBfs/Xz89q?=
 =?us-ascii?Q?EYVYVfqxtcZTL6zNEkAjeSnRN8DYeELpx+iYD2Fe4hn9CBDzquljPWVtQhvs?=
 =?us-ascii?Q?MJLac38f/toEs5IcWWN1m501mACY1ja2X/QBqVUiTL6OAw8h5aEjexWcb5/m?=
 =?us-ascii?Q?gfRsYJSrujw0p8K+j8EBwjSKhTGYqvpFQyuEsfH+1tx3/Kp30lxDXEdROjkM?=
 =?us-ascii?Q?LN6GcF1/xkuNQCn4XQZ6SYAtHojEKVSmHTkGq6ogG6lnFhQZ2YtvzUqlpCwC?=
 =?us-ascii?Q?3cRW+v7Nro2qbYPJd1t92ksSibHOXZPnFW9whLYHEcMyaqZoobo9iQdjOjpP?=
 =?us-ascii?Q?WPasNiqIAexFEEZhjAo/mqV+g51jpRllpjwduMtTdEymvF0tzucN7WvdIdR3?=
 =?us-ascii?Q?Xn61yi3L4WBnxl4ySw/U3FgVTmdj9tCPf5g+rZ/4HFugZZt6LQLOVPP01XSQ?=
 =?us-ascii?Q?HQpDZU2rWvyxWRK52pgiUy4o7rgH+Wly2gTi06UqLxe95iK0YnaOj8W0xwb1?=
 =?us-ascii?Q?hHROjLLYg8QniabMV3MV+iGmiaqkH0v5S9+F0dP0rGsJKpL+7kSMdoh/Z5tQ?=
 =?us-ascii?Q?oIeB9w3DxNVLGpzgZ3TiKTqqnLnELQP/l8R1JdXQQwqmRMhxCk7XQF392StQ?=
 =?us-ascii?Q?vDU4jtH2/mKRTH7XilT7j+laNY8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb64b4c-ad8d-4560-520a-08d9d1b85b86
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 08:33:19.1227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAEl6ABy24xl/q95e+vPAvxepL3vnxEu7bmKr9IJoRQa0YeW2gEsV3mfQvfeaev8rwTbdQthHhH0RDrQ09yxmMU6teaPFiO9VLSQ6p79qy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070060
X-Proofpoint-ORIG-GUID: grzIKllSRv3wk4dCJjhALuP0fcYZPouJ
X-Proofpoint-GUID: grzIKllSRv3wk4dCJjhALuP0fcYZPouJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 10:31:10PM +1300, Paulo Miguel Almeida wrote:
> As a convention for the pi433 driver, all routines that deals with the
> rf69 chip are defined in the rf69.c file. There was an exception in
> which the uC version verification was being done directly elsewhere.
> While at it, the Version Register hardcoded value was replaced with a
> pre-existing constant in the driver.
> 
> This patch adds rf69_get_chip_version function to rf69.c
> 
> Additionally, the patch below must be applied first as it was sent
> before and touches the same file.
> https://lore.kernel.org/lkml/20220103222334.GA6814@mail.google.com/

Put these sorts of meta commentary underneath the --- cut off

> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
  ^^^

here.  We don't need to preserve that information in the git log for all
of history.

Other people have basically said all the other stuff that I was going
to say...

regards,
dan carpenter

