Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721394EBBAB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243769AbiC3HXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243821AbiC3HXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:23:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADBC6548F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:21:26 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U6o7eX026035;
        Wed, 30 Mar 2022 07:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=9T8PMXTN/g210ARevaN15nKpLJtij3hcqhspeCHerpg=;
 b=NBMA7iLV0H1UuRyp4SMlOTxonOMad6eugqtF5nMQCNisNmy1gn6cM/QTKNkkE/HDHkvr
 H1XE+JhmVSOS+wngtwIAkHpufWlPfTC1MxXQdxJ8X0JKEY2wPBKL54geMnRYoonX9Zdq
 VSyFKJCGOTP0JEPQwn9dsxGlzDi7IpOB9CKoDeAoxmh2Qnu/0K46uTLg39hnNYjgWAPY
 kdAHNMYBjoAUyFwqF7svEiANl23gSeL/i5V4yUAyefkaliSuI0ayGWIwcKNjbYTGRiuJ
 LJ4FvXLvef7uI3c/l2UFih3pbQIdBP3F96221kjqzN8d8IXpUd7gN5ARBiRbJrDszKTH nQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqb8h5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 07:21:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U7J10K195142;
        Wed, 30 Mar 2022 07:21:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3030.oracle.com with ESMTP id 3f1qxqgsvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 07:21:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx+Py02aLIcFNnIGmFq9HDHvxvBy8pS6Pqj2kegt61w16wV49wDiNMbWV6kbB1TMrRGDoJ12cMys7jyZ3RYju27eRWd/JXXPFyU8ad+xMXaBFi+81Tw8BK5YREInYTAmFRV7M4ePQFgnyzVc/f+qJgBcQLdyMg8T/71m0jue2alAIUAiySKsnGxvBoeKVSpVDe1EfOTcpUKmnumVC46T381VcKxiJdzdgKSOWJ6DUbCcgAPpdxYMv9LvgHMO15MAftGf8eVsMn+MI2oUXWWbI0MuGYWf+pBQgpMGVhZLE2iXkuya9MWaOXCQxIADvHJ2EQR6kFhYJh60NcO7Zcp2NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T8PMXTN/g210ARevaN15nKpLJtij3hcqhspeCHerpg=;
 b=Nu/SLKFRb7o4fc0B1lPE4u+qIiBJci+LJvRSxbaR7F555y5qHcfA34lSgLfez9m/i41PCaYOmHmZ0BSBvllxGGJaBvz5d0fjdp14BS2GtKAmqneYHY2knPAF3ne42ivpl1OkCKyadZhJ6Jwa0kAXbzytXwV23h5In4EWcUHCzZut00LUF6ajFP1Qmj2ZRJBy7JYDm30wKkteHmrakS8Uv8+Lm4KArJVBGUEv2BlbxgWjEmH9sg0DYpzNTQ3PlydDw4XPBppP0eiBe5gxWBPL1fxDarIHcAZOxP18d2+iMmYwK9jWJCwzc1hITI+E5ab2T1NAjpQtWu8nPZZsndQE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9T8PMXTN/g210ARevaN15nKpLJtij3hcqhspeCHerpg=;
 b=Pusc9DLvBN5GxljLEk7/q/JFcMzK7IFH4IqrQU8/1XLj39qy+0DnRv8EcZi9jmyYw7Hd+GrizcFTfpwrfD0zujtRmtvHBvWiSajLNHrTp5sRJxbwIIAdM70HDvbY9y+v0oT+Bgb3lvUCttyswdHXCSqVJ3Kj3HO6vCnN+uA2Q0E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4079.namprd10.prod.outlook.com
 (2603:10b6:208:1b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.18; Wed, 30 Mar
 2022 07:21:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Wed, 30 Mar 2022
 07:21:11 +0000
Date:   Wed, 30 Mar 2022 10:20:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] staging: r8188eu: Directly return _SUCCESS instead of
 using local ret variable
Message-ID: <20220330072034.GH3293@kadam>
References: <ce82792a-9e9e-f324-641e-d1fbcb26b1a0@meizu.com>
 <1648603740-14760-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648603740-14760-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0055.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e73c1b3d-0a3a-4311-847d-08da121dddd3
X-MS-TrafficTypeDiagnostic: MN2PR10MB4079:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4079F514B6DC76B714C56FEE8E1F9@MN2PR10MB4079.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qGkef+9iTd/alfU73dhzZUuHUu6MyHIjsdtan8NY7vQSBQ9/NYRpmjSRvORLoTdTEcONgEAtWGTX0xsNzMBkp/sWkvCPgN/IX4lO65Mx3fzFFuVo7Jv048Dsx9S78cxeJbH/hsdBLapROeZ7zCgJdIXzR9Dp7TXVqlFceNziKbdnOZLAmh9+kOLG/6XVxG2eHzf0GouA8CylbqTNn9THKMEspAJybqfXYs7KjotIqPB7RdTUXOWR6BRP2HKpLZeKV1wLUaECqfzmT+Maf83Q94L9lLJyZ7GnRmn/IeHI3oN/IowmXYoQb96kN1waNWBhi1iOjPfS1xaEw5723GRg1/BuHmIGTZwxkyqvQ2mKpfFor1Um1+SeiQL8EJKc1qSmKBQ2d1nHNmKYczORleufmdAM2R5drioqXn8AsQJ+pbo8nQfKJzfCS465IujdSVnc9bJCKSAOAzkHJ50leqN1ocVTapokCpjfj7hAsWrj2/fB2Z6kqftZ85dOAm1fOro+B1iQXVf28Cscf9Lwo/zH0FGUeqZyReZ/+GzzqGQfKjPVOP9VNQuhSvEIuQVWOH9X6CIVI9YDLsjDYeAjx11U/6XwEuVaPZtJuFlm6zFb1rZl7W5a3MWE8XfNlFcIPpGn/gx60HKOLRNKR8YS2cI2mxLu8rwXx5t25xylS2VjRdRSX3bY64sPjonVEQK5XJeLNZppd9psaBUuNxS3KOgEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4744005)(5660300002)(66556008)(66946007)(66476007)(8676002)(83380400001)(4326008)(44832011)(8936002)(38100700002)(186003)(2906002)(86362001)(33656002)(26005)(9686003)(316002)(54906003)(6916009)(6506007)(508600001)(6486002)(1076003)(38350700002)(6512007)(33716001)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JxNDhXxBzzViJCgdhgwE7s/xDliv1qh6KGDGtAQemtVZ6n5QWb2n4Ohkqamr?=
 =?us-ascii?Q?5NQT4yKb1rXfKWlvrDsCikkSgKSzdtB9iHQc+4d9bu8GllkvaQ3P3RksIFZe?=
 =?us-ascii?Q?yO13XYdi5OLJVjjSsV+C+ADEI8oYdnJRmZuznEIRGxcrOEbot/ji8kuwtP+S?=
 =?us-ascii?Q?6Cup27FlYMWjhnfFXid5NBY9duJs2dgr33EzDyoNcPX7N96NZW9cT8/NmP28?=
 =?us-ascii?Q?LSVBWBovrjIx5aiu7qOqifV2LD6JqXiK8VEUJJvqBHGUbyVhEDYpwC/SpEr7?=
 =?us-ascii?Q?5USZUUAaycnvyrQe8nuWt0nh8NIzsQ0ub+ImlzQHdiKfkWuud2meBeNG//hx?=
 =?us-ascii?Q?BAnGQB5XKJKtSCXTBaE7uTy/e5tOBZIUSWPkw40d6hZxAerC5cEd67zILp0W?=
 =?us-ascii?Q?bI47krinrusMNPnnyUfkuiNJz8zSMAVYl3PZg8Sq6Gop9sumbzEqZ0sNiMi0?=
 =?us-ascii?Q?vwGwUpjOmfzpf5wjdjQKmqyL7N8/Ts4Okx0O4e4LNqlA127sZMPVdSXTaer9?=
 =?us-ascii?Q?BajFua+XnIhHjBpRKdYXNQyEyNrGRfRSdp76wdBHEQk5BwPKdceiBlfDAbB9?=
 =?us-ascii?Q?CxoxlQ9UVE7Swwhu5hLKeMbtarF4W6Kv78qNr1HtVgxyy8bDU8BwXp2p0bye?=
 =?us-ascii?Q?2EvAwDDXWJm6gMzqiwCF5Bb6woMjAo+ddGkKeXz2eM7Hlpf+qpwbME77vkHy?=
 =?us-ascii?Q?e+ez9+RHG6i5UPazavkq5HGTznv/KJpwLK2dLWzGky6rF54ln8wCP/cIigzC?=
 =?us-ascii?Q?WDFChJ8IWBAsXuAY2peQYu7IWeFmQi6Fi2ssTSnEXErIY+LFXU5sc6AuOWEo?=
 =?us-ascii?Q?f8Er7Q2QMf9gJK6pjEnY9ZNz3Gx0oJ0WN2ApPAQBIfJQfapTkhfXgXg7zC+h?=
 =?us-ascii?Q?n9SCQadGj97L5CxEI8P4sh0ycXvzaN9kesuko0Nl3fpthSiW2kgHjFzV2Rd0?=
 =?us-ascii?Q?xJaHx9Kvgff5CphwWm4h04Zo8aOzRxVa7UVXWvaA9QL/yk2zyVSldKBN3Wd4?=
 =?us-ascii?Q?Q/Q6CkAbBoW8MvQpIWptTwEMQiVQhVKm1QnBWiEGa8r+QLaUXuwUNZrEIdaN?=
 =?us-ascii?Q?Z8ET7RgWvEWTPcBZZs7ZYLb9FnPLfh204+i3N4BKuq6a1PDdTG+LLShMQTAD?=
 =?us-ascii?Q?8MCRXNv1FxrwqXpd2RY4gDUIGs7LywV7ie5CVuDjiNGdH51R80uSbEmKdcHJ?=
 =?us-ascii?Q?4P6kYPFNgcLNanwS4eIZKG6JoWHRrSkuSV5eIewwA8EgCgPq8ie//2M2vM2v?=
 =?us-ascii?Q?N9SAjwkIPaJ5/fzuLJs0yWrz1NDkAC82fVQcY5dslPkWsw0FwbeBTfUPGt8M?=
 =?us-ascii?Q?QJFc1YP191oxXLJHJ1ft8iNWSeVRQo3v4lvmpp8zZPzlNuIemhqfXoPfEfoH?=
 =?us-ascii?Q?XGTATTscD4EJwf06rX32vqW+Px4QO6Dn7SCcmwUT9SyrxU3neM0aqrrnBaNk?=
 =?us-ascii?Q?iMSdz8lLesl+c3JqJJxg+VkSK1mdVhh1c1xiQoF/1kMHTEmnr/qrRJgtbcDB?=
 =?us-ascii?Q?aq5NSHMb2Ae11hnq+cvXPKUg6+q6vDcFVbovbqqNO0aV2Eip71CW6BOzCpH6?=
 =?us-ascii?Q?Zdn99nMwwmAzeSZVtBVwuQ1X7aYtVP4IjT6YIxVh/jYlPfH7vBr5xbpFGnQR?=
 =?us-ascii?Q?UQX5sT+xS6+uXwmFYD8sSDbfp3n1ZimgBnt6Fk8FmstgStdtlEa+2MciF8tA?=
 =?us-ascii?Q?zRxVOyoh0VfKUTTVn/5cBsZ1fKRIsiDaBZuC9kH6Z9tjeU4QK+wIWzQpJEWi?=
 =?us-ascii?Q?2Q5Sk8zQ3N0VYICyaTCASKWTRWUirAg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73c1b3d-0a3a-4311-847d-08da121dddd3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 07:21:11.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrgLYO0kdR38+yOCnD6IoK/XT10hhhzeDgYfeVRj5WgID77CPvE85Rv5ANfs2N1cEtilcycPGWfPHx1jVWMfIawbVjuqG9WgsYSwr3Fqd+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4079
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300036
X-Proofpoint-GUID: gUc5IFhgcRjwiLE89gP05zlHNsKuBnJU
X-Proofpoint-ORIG-GUID: gUc5IFhgcRjwiLE89gP05zlHNsKuBnJU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 09:28:59AM +0800, Haowen Bai wrote:
> As init_mlme_ext_priv function always returns SUCCESS , We can change
> return type from int to void.
> 
> fixes coccinelle warning:
> ./drivers/staging/r8188eu/core/rtw_mlme_ext.c:357:5-8: Unneeded variable: "res".
>  Return "_SUCCESS" on line 380
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1->V2: split into two patches.
> V2->V3: change return type from int to void.
> V3->V4: just delete the unused label but don't delete the free function.

Looks okay now.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

