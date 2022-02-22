Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AC24BF17D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiBVFfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:35:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiBVFfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:35:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FA31DA56
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:35:19 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21M2YR1F006177;
        Tue, 22 Feb 2022 05:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=rQtTle7gtzIU+IFYXVQ8DeDmCK/q+lCNi4jDfK7sk0Y=;
 b=Xw0AWAyn1U9K1jLxYCUQH6YkafZgOgIE+nRk2s2/QHOJVQi9nKdLP9hZ7s9aHJH79Tep
 XugxI5+EUeOYUjrXBoVC2YJZ2NmQCLeRuiF7sk1q9VD9IJst56m1LdGnFxwSASxCUTDE
 KH75eLFeIQBmBcaF1q4+WfkYeRU3u2ZFG4/qMFynSMfatttlQC3q6bhTrdSAwECy9FJF
 JIZBGTkNdn39oGU2wAqtw/O+xzvwi1OaIVTWfaruN6MuKQVrXvzfZYIpMbzpUQ2jnp59
 BZWPViSvW2iht5zK52BJiHtSDGjWk10LXxg+7hkHNlsTw4BvAwTJF/8/tbqMxyUrmdTq MQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eapye5y1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 05:35:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21M5FW1U159042;
        Tue, 22 Feb 2022 05:35:12 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by userp3030.oracle.com with ESMTP id 3eannty6hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 05:35:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBWGDud7RSwgH3ocYZ7kX0YU0SGCFb+BgIz1UDi30O/SkYeEoC4XysVrOVSNhpsATJ5OyLGjwj+JS54gkSmL45Jra4XWZhyDzNX/Y2e0gF5a4IYiEBHUECii6/sNS1mmBx/PvxsxDepjEj01+x8N1ZW2CNWFV4c/Z2xctYzwrbc5G1K2I1Ccj2MkhMDn/wW7Vcv6w++OCzZfqr5OoafW7QPqpeELLxS/y1OrhvD6l2Gs81GHk3hszKp3u6cenfid5dR7r3x0U6s9UAWFWam+uLrxVWJl5RD52bXFsOaMe3K43L5Ye4mDRn/UjG2SXq12B/pAI/NwmBtm/dhY/9+8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQtTle7gtzIU+IFYXVQ8DeDmCK/q+lCNi4jDfK7sk0Y=;
 b=DNEKTeJNBVFLWhfhd1FD990/DydxaOPvRA03zmZ+jQPChZFpt7hkczUkA27pv1ZmWfRF4OeOXW2mIdK2Jz5SPyz9iX4XUwaV59x7QEeNs0+t/pFiZY6+/4EgLaZZSbUlreWUKHaFUKM6vj8lJHBoi30Yn1OLK9qyIfhztLeWmYSYM9nS2s4uGh6l+vjL/KTYUp4NnChhQh6AidZy4gBqBedoKdFR2ok+SBFB4KeiBtoBKlx9BhwLTViG33WZfS3PcoWdg/7pvS0lB0V2MjeRZjUPPEKD8aCqCy0G6COAaxN4o5b77sXJ3WRPZJvJvQaw26r/sBnz0Be+ihIbFDN3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQtTle7gtzIU+IFYXVQ8DeDmCK/q+lCNi4jDfK7sk0Y=;
 b=PFy90MBjjqSBvp8Mn/5EuozhvaXHgDbOrCckgE5jvO2IGrmk7btaL9SCY6+kqXjmtEakpLM4HOI39/ISLahszaVXfXkMo6vDooDwcKQLAJx3HNNj4qoFovywsFAX50IrrVvTBihQgQNIs3f1OgjMRus1xXG3WF9C5pUGdKM98d0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR1001MB2196.namprd10.prod.outlook.com
 (2603:10b6:405:32::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Tue, 22 Feb
 2022 05:35:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 05:35:10 +0000
Date:   Tue, 22 Feb 2022 08:34:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, gregkh@linuxfoundation.org,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: r8188eu: refactor rtw_ch2freq()
Message-ID: <20220222053452.GC3943@kadam>
References: <20220220154847.7521-1-straube.linux@gmail.com>
 <20220220154847.7521-3-straube.linux@gmail.com>
 <cb7db1ac-8e7e-d549-a5c0-fcd072ae815e@gmail.com>
 <94160654-ec16-cad2-3cc2-46628caaa17e@gmail.com>
 <20220221122250.GE3965@kadam>
 <32a2b74b-f541-ddf6-d8c9-6bd6ca0ad07b@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32a2b74b-f541-ddf6-d8c9-6bd6ca0ad07b@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fefb049-5ee8-4bab-a62e-08d9f5c51717
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2196:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2196FBD5A26309AF9B083A7A8E3B9@BN6PR1001MB2196.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSLxxkBCdYsglUGUbv9cDIWEpx2uVtNRYAax/RUknSgNh7BN2aeoEU0T54chzBsRoaPqi7E5oqPBIim/KdJtUeoSUvlafZ5ZE9bMpZRsata4lb4eccpeHmdmbUuJby5rvyetMSwQPL4aXh42r1phxwUrZzJNpfU+Dl6r/hBTyS163PvB6aoc/4tXg8Jbo4Z/nXX8Xt5gbJ3LNZt4mcj9g0qwaEpXuuxyHGBG8XNBDofDRDKTpHkjnFI4VVpNKouaznI6xYlim8usQhwDBm55CtdGFEGVaSkckp3OJfZhLuvkUmvcMlqQ4ADCEnOTOPbXDkl2Sk31i7KvA7pqGpawy593XgPrF86pM2T4ljG6KHhEp8479fBvJ6eAapPMzoFyPvMFXVGZuWydE4a1wb8Hgeo3aKCQZoD3xQS05OlrfU6B7UKqKFoeGiGXopESpXvMekEhwr+Kr5juQ3xzmDbXi7fLIW9nzEnmiEAGayZL8RARurNoz6eE58fuh2rWT+y4xa2Gz60x9TQ2QQ347axKGMy5YX/NpkP7Ls2OCx1V5jn80laOVJsGB2dVe6IkSQiAbvyKzNA7b3IazlWAeVP9I6jjdSVQj3fdmcyg3mCLQbjWp8qMpxbMTm3s8RrNXcrPoYmGktdc9gCb9cqh6YFvOjG7Mup9GUmKrLXvvtL8GuQuz9kW8yNC09D8lgxUj5Fz6Pr33MM0ogRiosz7tM8SuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(8936002)(4744005)(6666004)(6512007)(5660300002)(44832011)(53546011)(1076003)(9686003)(83380400001)(52116002)(6916009)(2906002)(33656002)(316002)(186003)(86362001)(66476007)(4326008)(66946007)(38100700002)(66556008)(8676002)(38350700002)(508600001)(26005)(6486002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?syAmC869AOo1OEYhx733HKRbVtzMMJlsNqcwHOqFhSG5UHxAXOCdidTlOMTl?=
 =?us-ascii?Q?nahbuygu1DYmTlOmcXpsNW7x3/2K6+9s8X+yvHSEMrm8QpSaXjBLlBCODUg7?=
 =?us-ascii?Q?niqwyHjgrO0KiyBmcpuwS9Tb3WUQalN/LFBoSmGot5VkUkgt1zHbVAitMlm2?=
 =?us-ascii?Q?RcMFbYTsoaFwRqKSZPuSUE3IBlJFaX2xmwYzuECixlNZ3IS21pILl4E6kB+o?=
 =?us-ascii?Q?efy1Xn662Yq1rrx5qL+YBKKniVnHogi8cCF6J77LO5xf8h2SCRDTaPgogFRD?=
 =?us-ascii?Q?g92TQLrXYzP/VNqfRW0fiN30MZ1sUf5JQcoPrGqRwUv0OEMsuu6deJP5P/Ap?=
 =?us-ascii?Q?7BTw3yMrnzStHm9OBSIiaoYsOGrcTXjI22F0QB6NJbcAOuNS1kk26aMv3KhQ?=
 =?us-ascii?Q?3dOc8M8/mhE4zOHXeZib7OkcWqrwT/ZXTyZg274ra5JjK4+2FKi0KegmL5HH?=
 =?us-ascii?Q?o/+wi0KUaHZB02RG4o/895BqWXx0S5ETvTYI0ISNwa2ZAoFLAGWgYYS0GBvR?=
 =?us-ascii?Q?OQAVT3j2DOamwlM+N+0h7F6PqLbGm5bfVUZBbX06Ya8+r5CV0I4mzgQIcbze?=
 =?us-ascii?Q?3D3R/4ZTyv2HlPmFsWidk2+ZvrdoRs9WaAp5RuGGxyvvfneb2LjdQNkOLRuZ?=
 =?us-ascii?Q?hnXyxC/FrSOr7KOMGCDETBIVo2bU3n5gubyZJ8+9zrcsNMYFwzrhKPMnMrR6?=
 =?us-ascii?Q?WvIL8yDafjdhWz373KYPo6hWMEKd0BqJnMdwz2RAf4CJDScgVIceN+3QJVKT?=
 =?us-ascii?Q?A+5nrCub6BBp3oqlutHRDyqxv8d9gywJ67TiLCb9QBT3kDYrWTaAvaiDbgkZ?=
 =?us-ascii?Q?g5yg+ojQc5vESsjy2N/U5hOH9F2Nni+rxTWFSf803Airlss5pZqBBUlfGwdm?=
 =?us-ascii?Q?E9vj+ht7Mt0wwnohQ89pDA67suN2cutSuU0IXWnZP3g58xvBmsanUgDJ0HLW?=
 =?us-ascii?Q?5kZjHoBt9/oxXmlg9PtBxSfBfl//88jw+robNjnwZrnXmib/LYMvq6HJuBPY?=
 =?us-ascii?Q?k38U0IOEK0yX/ojzjHLJ8ssv9w8XDM3Sokb5LPzAh34RfxA2Y0i8A7vnNAxV?=
 =?us-ascii?Q?QciEnwyt0BVqBe7TK61iWysDMwa0w+QZL0BLdYmGs8jJcl8vvWeGikXvJIKb?=
 =?us-ascii?Q?2SH2GbzK7KA72yKWIAS/9onBu6qt/ZvNzs18x6OCFMOCUafvuBN3nw1Ydk0y?=
 =?us-ascii?Q?nIMG7bbOpe07t3Nhy3gvtbE7yEK0tsSy5Nda5Ig07qmg6braxkSwoF5Z1c7u?=
 =?us-ascii?Q?AjdQOOLukvMjPfRTF4vd/JErb/RuiYBg0ZFcYCRtnANd3Oc2xLYFAzJYPFWF?=
 =?us-ascii?Q?vX8lDmvNYQjrGFrAHdm4wfAiNwcVXmAKdlSNQJaoKHdLoi+dcLJt9GYDaQOe?=
 =?us-ascii?Q?legGiRnVavuiMTTgJmZwsDvn+GDhtGALdC0zaW/ZDUYta7/0gnTOjvSXoiGQ?=
 =?us-ascii?Q?MP86RFZSVcHC1GFzQq2XuJ6dJ6x3uzYkPYBxcPBmnLnhJJko+Lv3nDX7huAI?=
 =?us-ascii?Q?ba3wRiUNqwEa7+NBUJNbf+HaW9u7jn2SMcNIqgnmK1P79AnDT8hnB4deFtww?=
 =?us-ascii?Q?lBadojdf8gwBHZUunNcASSnOmuR/m/9HhYGu5Uwtf9eSsnCeL6iDQlwc1Sqs?=
 =?us-ascii?Q?ntK16H2ZjZXU+yNSkyfTuGM7xIkCL9gx7gucKjxIKs2MYCD36HO8H94SaTUj?=
 =?us-ascii?Q?1T/DTw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fefb049-5ee8-4bab-a62e-08d9f5c51717
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 05:35:09.9111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkXpGia8J4qWyr0FhD10xJPnc8o4unQVBzcUkqBA8RYFvgAc+DZ1/D7UCnLk5UcJM4AFmK1R+sxkVn4Indzttw7RM3Y0KXsytXVajmQdll4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2196
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10265 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202220032
X-Proofpoint-ORIG-GUID: HqtFSy0kIXoK3J-hfdxxA7n7fRDvuJ_F
X-Proofpoint-GUID: HqtFSy0kIXoK3J-hfdxxA7n7fRDvuJ_F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 08:20:14PM +0100, Michael Straube wrote:
> On 2/21/22 13:22, Dan Carpenter wrote:
> > On Sun, Feb 20, 2022 at 05:30:08PM +0100, Michael Straube wrote:
> > > On 2/20/22 17:20, Pavel Skripkin wrote:

> > Just from a review stand point it would be best to leave the original
> > behavior.
> > 
> 
> Do you mean to leave the whole original code including the 5 GHz
> frequencies? Or returning a default value if we have a channel value < 1
> or > 14?

I meant what Pavel said:

	if (channel == 0 || channel > ARRAY_SIZE(ch_freq_map))
		return 2412;

	return ch_freq_map[channel - 1];

> 
> I'm a bit confused now, because Greg asked how we know that the driver
> is only for 2.4 GHz chips.
> 

Haven't you been deleting all the 5GHz code for some time now?  Greg
isn't saying you have to keep that if there is no reason.  Just put the
reason in the commit message and resend.

regards,
dan carpenter

