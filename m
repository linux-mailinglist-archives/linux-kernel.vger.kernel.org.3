Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3054794A8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbhLQTOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:14:30 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18582 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232827AbhLQTO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:14:29 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHGYLih013129;
        Fri, 17 Dec 2021 19:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yRUvy4Egen/QoS3mQOGQLXmSh0t2R1/eqYgoZCXyKcM=;
 b=rNwkXvlQ2AhP+EVVbvttz0KC6ngDP16yKC+EeQ2Cwo61kl6aTgXmVhTH9xpTeXWJRZb2
 pc0IM4pEfHoZy2fSs4h6c9ALUiDk9r3q4d8pXw+rUIRKKPbeRD42GYLV3JQzt1sTFfQ6
 /yPxSG621cLBoaMovXV5lJIgHS/yzTCUKkuKp353uewCkb74ynu8ZMGyCGcf0dRtkn5a
 vuTXll/5twNmqXgL4KiX6VLN4WpOrnmdfIbKBKc9qpcLBbO9y1Mhx9Li4SY0ii0b+aou
 YRc3moxIZE9sxxOhJO/f5+IEq5Z5LymkhMH/aG/JlQjDxy/6XaxxDWPdqHmM+ZdUA32r cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknp6kcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 19:13:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHJ5vmp133833;
        Fri, 17 Dec 2021 19:13:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3020.oracle.com with ESMTP id 3cvnevwu87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 19:13:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPZnBki4LTG7bUh2QzlRLkmzJE1WxNtYQvKAO4v/cWTvUNdRi0XrKr2Nh8wu6MPxhU3SkeuceE1aP/1S8kTeC62cZCDKEuFtcJWP91TruAc/xibzpAJJfEvhg1iT3oTfjZxjPfKVo46/4Ljk9kccfBcRlLt5U/pJGOrTdwWkOjsQ7en391NAbvy7cbzGJF0UpHoY+eI5fOX+Y6neAzuiPy+gpIWBhQPth2Gzbfcsh/JNZ6Kw3EMKXWltyFHC+GrqAr+bihUXK43j1BqXsZbbE75NlpE4LNHE9REDytT7iyoXMVt0U5DLP5/Vmj3ducDZnPdyUoPHrJaNmL/x/egAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRUvy4Egen/QoS3mQOGQLXmSh0t2R1/eqYgoZCXyKcM=;
 b=PWuGCCE2vsmCga5P4qkO3FhWk2MVuuaztrmWWMT4TF8mOMnjUzppwYuslJ/9aJwCRQGrtTHDBxPxqLEPpuwcz3uMXRllvcCrdU3y3O3I+t1xxuv7B5Hxf6OXWB9iPbDnHttvkJ622rLSoehsViux0ViJ9HUZ8NBy0W8kn9+efSlC2+mN/gKir1HyzO0OtP6AssInDJeWyTvZM8rIFc3+WNJQAUpeMeHfHWBSUJXBE+3Gf3bbkfBJDj/fcBEDz9tqAQFZo+pSwU7cKPYNR3Ii9IC0LSZh+gypTkf8a9HiLofWZDApT3MWjKqSJgeojqU8H8M5oOUx8mthUeK5DT77mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRUvy4Egen/QoS3mQOGQLXmSh0t2R1/eqYgoZCXyKcM=;
 b=zWMrpgRyh3AIkGCFii78F+I3ykxS0ypjmBiaSFtTK1aCpesEJQAjU/n6/THaGr6twFTBMLKesfTZW9F8hb9eblLnD6+/JyNSrS4uIOUDcTbmkMwGIO04lYUkOg/5/XFWsFWubBvuMgkXXVPGOKPM2lV3VuS8htB5JGh7ltNPGMI=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BL0PR10MB3043.namprd10.prod.outlook.com (2603:10b6:208:31::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 19:13:54 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12%4]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 19:13:54 +0000
Message-ID: <81c97e6a-f5e3-3f5d-c9ae-a35933cf4e61@oracle.com>
Date:   Fri, 17 Dec 2021 14:13:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH V4 0/6] xen: Add support of extended regions (safe ranges)
 on Arm
Content-Language: en-US
To:     Oleksandr <olekstysh@gmail.com>, Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Wei Chen <Wei.Chen@arm.com>, Henry Wang <Henry.Wang@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Jiamei Xie <Jiamei.Xie@arm.com>
References: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
 <1428a0be-b80c-f996-1f72-6545dd66c1bf@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <1428a0be-b80c-f996-1f72-6545dd66c1bf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::35) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3915c82-3f03-472d-357d-08d9c1915dc9
X-MS-TrafficTypeDiagnostic: BL0PR10MB3043:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB3043F1A5AC239C6B8453D3338A789@BL0PR10MB3043.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwGwf4FzUH6241ypqTUE/nxETehcdcVW8+9Z9MVSG68rdYr44b7h5wqZK7D+fwEl4rHYYAiNGADVfdiU5Q9Vt2nj/DoqQ8N0JsdEtTUzQVyphPOd6wG61jElNqWrelod/nTTkVllco7bh3YxgooMiD6iQnRPKLp1Tdh6dDslLzcVNx/eKVtbMRro4gnnLH463/VY36Tu/Tj3+wrp3EulNTskaNY2TrC+Elyqs7583F98JDej3eQz7PvBbyeLa2qSvC6XvLNXV6mWiHs+Y96mx3vnCnJt6MTquhUbo3tPV4RbzHd4OGR7drD61W2m40laPUkkc0LnSugKZoRzd9AWnaO3ChEtiMRFl/1vu0nWl29ZKtzho/ARYobOD5f6vw2W482jOCx23qsI00af1jzjA8T+EQGYq7obVxgBd5RirjU+R8yhOD+KvbW6T5pWA3R+1ip3tpqDz6z+4PYlhSn7I7DBHyLQmwZA3zLghEIyViyvEt0jG2x0LWvc4hBnaTePtPgLkgOMDHQ0R67m1ZTcmvOBK2XhQUTpDYTK3njQHmsrUqkK8B0C9fj9tx9Y79ywz6VObqAA6NphARI9YIC/9XLJaPj96YJYZS/2p3z09I5KCBBOJ/49At3DqsgfXBAuscahee9wO6XlF7rQESHlAtVRl+1+gkIzNNfBknHWWaypr7o3FXRsPUqBm26xtdLG1ezHr5IXpmCXKJFdeQaHT/iY5OZ9jWBV2FyyHQvWdgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(186003)(54906003)(110136005)(8676002)(6506007)(4744005)(6666004)(31696002)(4326008)(38100700002)(2906002)(66476007)(53546011)(8936002)(66946007)(66556008)(6512007)(508600001)(36756003)(44832011)(2616005)(5660300002)(26005)(86362001)(31686004)(6486002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmRDRUlzQzVCdnZOK1JDVFkwQ3BnaEZJWEpHcHJUa1lLNzVMdG4rUmhIMlJC?=
 =?utf-8?B?U2hrT0dBbVp6b0ltUkZ5b1RYcEZkSVlJbFkrbmtxZzZZOFJ0MzV3cW00WlVL?=
 =?utf-8?B?bEdHenFQc1VEdWQwNGhpV21nbmYzWWpwVEJGaEZ5bEZlV3ZwekVEU0p0K2dv?=
 =?utf-8?B?d0RYN1Vmb2NWZUxLMkRVMklRdmYrMFFTN2hGQU81ZisrK0xqRE8rWXBaelo0?=
 =?utf-8?B?MFBrZXV6dk9rVWhkVEN1NjZWdTlZSDV5VWhBcUV1TlRxY29uNGxKOGg2ZkJR?=
 =?utf-8?B?b1pHakZWUE8yNDRUMGE4VFpYbld0QXJTMFhBOUNJcUx1a0d6L1U4K3poTzdx?=
 =?utf-8?B?QkQ3VFpBd2pGV1l5azhNMkxBcFJ4bzdQYUlqTGhoOGdNWGpsK3Z6Qm1FZkQy?=
 =?utf-8?B?cnNlKzBVWVdNbDhJYlQ3d3lMRjROVHY1ZlNGUmkwb0F0a2MxK0RPeTMwV0JE?=
 =?utf-8?B?bDZVY2ttRmhpNXhub1VXdVpyVWo3RmQyKzBKU0U2YVdYYm5sYUhRRjlSb3NL?=
 =?utf-8?B?cC9JdWp6OUVmVUNmMnM1c05PWFhvUnU5a2M1RUc4T2ZGK242NVd2ZlRrdGdu?=
 =?utf-8?B?ZWFtdENJWElGOHA2NW4wRGFBV2h0UmdmRHlIQ1phWFVSZSthOVgzczZTTnNy?=
 =?utf-8?B?WTlydExEeVM3QzRHYlNuWDVGQjZNUW5rUGJhV2JsSERuL1I3S1oxU3IweDNB?=
 =?utf-8?B?RytQVng5N0tETWZCQWpIYm1HNzRMaFBCTUNQLzR4Z3VHN01rd0ovUjQxTkRk?=
 =?utf-8?B?RC8xWGRFTGJvZnB5NGsyRFRwbEt0U0orZlJYNThnNXJUZzdHZTZWOEVSbmRy?=
 =?utf-8?B?eVhyWW9RcXYrTUNGdk82MUJJL0d5ZWVNa3UvMlZuNXdrRnVadGZvNkE3NnB1?=
 =?utf-8?B?dC9KZ1dMZFo2VlhrMmdRV0FvaHQwVGRiK2cxMzcxZ0pHSVdnNDVRMUFCcFRa?=
 =?utf-8?B?T2Z2d01hNnBKU0MrTkRLQ25tVVFsd1o1czZxMk1KYm8vOExYVVErSDRGOGQw?=
 =?utf-8?B?V1BiYXdvaFE1d3ZLY0dqdjNLNEhKMnhpZEwxY2V3UWtqeHZ6STlvbnRaSjFp?=
 =?utf-8?B?d2dCQ0o0VDR2MWlWSGlITFBvSHRJUnNQdUdnRGJlZlpKZ21SVDZIclNGcEJO?=
 =?utf-8?B?cVdqa1FRWW4rOUExenB3aU93Q3ZabnhZSXRwTzgzckY5NnNLUHpyZ2Z4YWVE?=
 =?utf-8?B?VEJYRSsxcmRDaExwdnhldDgyOVdjYnlWVjhnbTVlQm54Z2JjdmxZbkxCZG9V?=
 =?utf-8?B?RXF6MUsyR1hiakJ5ZVZCMitFd1UvdE4zUTROSU1VclJmL1k1ZHBVSXpiK0Q5?=
 =?utf-8?B?N01WRVF1Q3N2b2Q1MXd2RWZEOEVOdVlLN2FwK0pGdE9NN0cwbmdSblc4QVJs?=
 =?utf-8?B?bi8vQjhqUDRVVG50QXo4U2Jhd24zUTlaMFlURFduRDJhREhKN0pPSHlMQnEr?=
 =?utf-8?B?SmdRaFZGS2lwbFA5SzBmMGorUlFseFFIREJrT1JZeGR6ZmZ1Y0Z2Q0lDZXpt?=
 =?utf-8?B?TjRPWTRDaW9JMHRQTVdOQjU2SXJQd3BGeUROSTdCZVQvbDRnN1praXJEL1h6?=
 =?utf-8?B?VTlLZEFrNW9NSHA2TXhyNU92RE9TalB2SGViUWR4VWlKemFlSGk1R21NakFJ?=
 =?utf-8?B?NGhLMytVbnR3NDNmOWd5Q1ZFRzVJWitXeEd4Nk5pSG9kSnpOTndOQ0s4QkJv?=
 =?utf-8?B?aWZPV0EzV0pxdDN4cjFWcDEyYnBpNFBmYjlCeHJTMHMwTWpNU2dEUG12bEpp?=
 =?utf-8?B?NzdCeURHRDcwYWcyTXl4TENTakJmVXJZcWRYN1hjNDFRMnFsQnRJQkV4RllM?=
 =?utf-8?B?VW4yQUhsbENZUW1BSThoSzJ0SkdXQ2NTNUtUZXUzV1diV25PbkU4QStXeGhD?=
 =?utf-8?B?RTB0TUw1NlZ1a3pINWlzTHFpK0t4Uk50Q3doclRaYm8yTmJnWlhia2J6a3NX?=
 =?utf-8?B?dW8wdXo4WHdESTNmSHpZNXNGMHNIYmxxOElXOVlwQXRCd04zblI2ditjODVX?=
 =?utf-8?B?bEd0dXdpWnBCaXRDMFRtTzh5bnl6cmEvcVdINFBwTmJSWEZoNXJJSjJEdm1W?=
 =?utf-8?B?OFdyeG5kWGFPREk3YlNPaG9SaUJlOXdOb29FMVdlY3JaUlFET0dlZm5VdnZ5?=
 =?utf-8?B?MmQwZ3BDckcvSXAzNnMwK1IyRnVwSnF5QzBxN2NwNXdkMTNabVdOVFFISUlt?=
 =?utf-8?B?SkZxT2dMOFdkSmI1bGp0S2p3MDQ1NGJ4TVhaK3BFRW5zcnNGWmw0bU5UTzlW?=
 =?utf-8?B?NUR6T3FuR1llVGVRUXRpakNBcEpnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3915c82-3f03-472d-357d-08d9c1915dc9
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 19:13:54.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPC4AxeABJ2JWoLw8v5yF3VmYs6vUy0OqTLtFqct6OKDU7Ds8EFLLUKSxQxShEgHWgLc1ynVDqgceTXZ5hH+/MymwiQgMcuTUSTZkyWnWh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3043
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10201 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170109
X-Proofpoint-ORIG-GUID: 5B3jgs5mnv_TE7aw-EtQjKJ7RwoJULb9
X-Proofpoint-GUID: 5B3jgs5mnv_TE7aw-EtQjKJ7RwoJULb9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/16/21 5:02 PM, Oleksandr wrote:
>
> On 09.12.21 22:05, Oleksandr Tyshchenko wrote:
>
>
> Hello Juergen, Boris
>
>
> May I please ask, are you happy (or otherwise) with current patch series (I assume, especially with commits #3-4)?


I think I mentioned last time, in patch 4:


+	if (target_resource != &iomem_resource) {
+		tmp_res = kzalloc(sizeof(*tmp_res), GFP_KERNEL);
+		if (!res) {


Other than that --- LGTM.


-boris

