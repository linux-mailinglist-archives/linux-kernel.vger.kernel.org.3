Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B7C4AB7BB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345319AbiBGJ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242710AbiBGJWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:22:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3C5C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 01:22:37 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2177lSj5003588;
        Mon, 7 Feb 2022 09:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=IVysGkHHqGOnIyhRzbyCbqePSQEOTLpdECc5Ws6ywd0=;
 b=qVqqU3Tqi873vVwx3RejAxzAGEtIw/UaKf8lf4HBjSMth6TJ4Dzc+/edfiC2jne11YOj
 +4mHj9tV2PjZp1AGi0HDv051Mnbh/yd8k6i572DI+ydagmgrraEkOuMZ07TbR3gGEtjX
 BOm770PqkMivGf3S1byLKtdcR5dild4PcvgnWtK8edh0Ga8wieKNw13ZG/JB2bVus5m7
 EqYRATUIs9+pZcMNQScm62OUb/EHkeIxetOD/qL0t3eH2LUXSM6zYCNssxVvahnhd387
 LZ993g1qB8Y95dtOp9hciaXRVm73q+F8JY7/PKqxYLMB896Cpp7I4x1h7FZ3y6vqcj+u mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1g13nn6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 09:22:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2179BUJD067773;
        Mon, 7 Feb 2022 09:22:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3020.oracle.com with ESMTP id 3e1h241rv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 09:22:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8hpod0aDrGsEedyBgXuddjkbhSUj7wmlvVMDwu+KWVgGM5sQHFM94S67Wn7hrbEj004jZbkpqLO9A8303EXCnRDztqUUPp40VIfD5uKATLdMXd8rquw2Ts+iob/61rUsl4OkMZh9Df2KPVmrVGqc80R6CNC/8LB6fbzyK8/IGrz1dVbPb1kxW4mXR7lYC26UHreUx8UTgaD7t9PWGB34+wZfEMPT4CFQAj5p/P+/kC9/FxPCEeY4JzFuP3pNgyZjShVOHMdohYEbbDKXE4tEQZDvOCG98j0dm4xcvMFOGyEqsqs7izqL2EVw9XNO/o8QR9j3kmI52ARtj2Hf7rEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVysGkHHqGOnIyhRzbyCbqePSQEOTLpdECc5Ws6ywd0=;
 b=DgG+kW4e+CJkxCoyJvFR3rWFRYE6RoanZkXIavXAB7SXM2xIQAd8YrOoYlLCKfOXdAtH7yg8zAQslbTMue2gRkbWcmz1Dj5E4IQOZNBxdT0/6BMmTK9WHrRYtAVbfXsSqR8M7DREvIjjPM/ct74yRypcAvpeUirqtrZseh3YyqWFpI3A2QtpUQ8lFjsvscMUwumSNHlgKp4fnMlA/qc6DYKiimVdzvmbNfadaTmcEYTuvgQF3I3J/GBnwkajtD6wfHxHVjk29I5g8Ft7/eaPfB940braJOUb9PSDldiG3J1kIcCMiJs4qrfgy9tzcRy7I3LrrUJwjJO9sOGH+oMnTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVysGkHHqGOnIyhRzbyCbqePSQEOTLpdECc5Ws6ywd0=;
 b=A+sfRiq8911H17oLxPDkv7UPNEAhxJWXWSFoqPgc3ZQNhq/fDkOMvUqWCQvuuB+SBAK0BHViiludkcpqoiMT4ZeGBLzPJwIJTdQmQMG3RsW8kVGDbCTVTnXPLzKz/e1fMv/Uz52Th73UHeOYb3+pgIpOnhDImRv6bw4Hq94mIkg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4976.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 09:22:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 09:22:01 +0000
Date:   Mon, 7 Feb 2022 12:21:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        phil@philpotter.co.uk, larry.finger@lwfinger.net,
        julia.lawall@inria.fr, linux-kernel@vger.kernel.org,
        Michael Straube <michael.straube@stud.uni-goettingen.de>,
        martin@kaiser.cx
Subject: Re: [RFC] staging: r8188eu: Sleeping in atomic context (SAC) bugs
Message-ID: <20220207092133.GE1951@kadam>
References: <2111927.Icojqenx9y@leap>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2111927.Icojqenx9y@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0063.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4803fa54-6204-46e5-d1b3-08d9ea1b4bc3
X-MS-TrafficTypeDiagnostic: DS7PR10MB4976:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB49764CC6D7006BF62B4F22A78E2C9@DS7PR10MB4976.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8yXlB4NcvjJzbCDRxQ41NPGfJsKC+UJ/IC4R4T++Q5AWbRQYLCQ0Nxskd8mYIWWPrCMRGjMaHfdefceirkM+f758bb0kHKnrGpi40qHUdgfgkh1i72qT7KTQ4QslT/KmrS/Pv9fago2Rkk+m9npdd738matlVE7bNNkuov479KSDPTf3ZYsBBNs2wOSAJtO/E3my6mR/nvkkm1t0KtFtBB1W51jdZEdZXWJEdRmycOeWeZp/Y/2v2gns9cJFcDHSpflFOi0rVkFbV2+bipK/qA5Hrh4UvodNco4GKgHxGiXnnsk+zyE8UJqL49Fvxfae/gRvWxM8UCzs5qicVsFyfS8C4Wnu/sJ/rBK6BVIDbGK14Ve/YeDKqSMVw5mcgTajHt4w0NAi7THomvz0uf/gXVu0frfV7wwhjxHQMBmNF65Dur7dyJghTkcDFqvIBRpNLjheGznfGXKUNm0XK9dmDWtMEZlQFYob8GDqOWUyWeBG3K6xJGsQFtZmwHnbLkcLNzEw1yc0YhvSGtAipBsWwuZYDMl2DcLh7Yy/dKVpF3T0KNMneC+mbUTn7jVcqXLetJLhvsaCdVHeF8+FY4SvHQsVyx+o/dyWKklTTq8sGOTKW9cPPXYy9p9w4BuCjcFptPkFka0olWd1SdHsBe6l4VqPJ2EsDE24U3KYmSH4pnHJQ3E9aVGLuAgpF7IZuhVKZR/z2FK1ElYKvS3l0TSg5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(2906002)(38350700002)(86362001)(6486002)(44832011)(38100700002)(83380400001)(26005)(33716001)(1076003)(5660300002)(66946007)(4326008)(8936002)(8676002)(66556008)(66476007)(9686003)(52116002)(6506007)(6916009)(6666004)(6512007)(33656002)(316002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eg4K3KfbPXu11Lrdz92VSGVBT5nV8/JSvPApZGZexlT/sb1hK6LrBemKIFRh?=
 =?us-ascii?Q?v5D6Rq0a0L6vTU0VBfnL57JjR2h6EYHTnGoEaTbwWYJW5messtJzMdrMNwv8?=
 =?us-ascii?Q?gQgKJeu3Lxf8AR/FEVbfnTufpze1lxIlARIeOCLv0VFl9cxncIFIT/lNt/v6?=
 =?us-ascii?Q?Pd0D/e7c7S6Zkmr4iKosS+JVT4e0/QPwmRJKBN/n3axKBCljl5nuxn1WEgWM?=
 =?us-ascii?Q?/83+ZuQWlIEHs/c39G8k4QLnu+N1HkKSaklb8jLHj0bmcwUXumbWvCrUNmte?=
 =?us-ascii?Q?VEdFqDJ7rBvKiZ4ZGsTAzsIyj/ewzX1Il+7ukzuXMcJDSp/DzHEda3MXZOMP?=
 =?us-ascii?Q?Q1Rw3UKfr8qmaVsS19GEiQrqxu7SfTPocaeaBeubx1N7nFHqJVRrD3LbnPNp?=
 =?us-ascii?Q?stZt3LKn7kQOFfaXhrfo28MRSPoCObfqV1EtG62hyPHudLQkN3tDNS4OjWU7?=
 =?us-ascii?Q?2h+yYO5uDkJR+r/10t5Q/BLM/8iLSh6tX6LO1+1NmBERWLg1TMo4G22S6mcc?=
 =?us-ascii?Q?ko61zfFcW5VhU7vTByPRyEd1owhYtQLlDRWUE2SCePH8fOvDTLQLQq/wp5Nj?=
 =?us-ascii?Q?0l2GqnS2nosqnQ9vVsjiWWNwyTDvoGpmGPKH1sm9xnqDvleJ9KSjFSjYNMYY?=
 =?us-ascii?Q?yORfurWnK7Pabc528t878Lyrdl7jR0uQ+Dgr1h1xOd85VHW4Rh6rH6GFXByW?=
 =?us-ascii?Q?6FL+94jw+EJGR5OJjMibBmekz8wV3YsY9um12xw2XrN5217bb4IX5tJfZ1u+?=
 =?us-ascii?Q?0XgfK+6rXTPMY+qS3CbQmSw/xabdmFSc7Jm1/rwy6Z/U4oHDkJbqv7tC0Yn3?=
 =?us-ascii?Q?p9bb+g4AnP9pEm1dKcb43ocWszsi46YHC+dNJ8bqBYiXpeBXBftM2Lmu07VG?=
 =?us-ascii?Q?lWxReMbMyEF7Be/e0dH6aJf9EjPSZZpXwrC1iOvOQBaV5HWe/Bi9/ImOMLPB?=
 =?us-ascii?Q?53jEWEQZhgYLuKVrHHPDk7xJx5SpqaVKEWWSo5nHkOwrS0ZZlESfUz0pnALA?=
 =?us-ascii?Q?IKj1C2uZIFqD9HNtf3aOig+V20erYhS1kY2DRyeAAGV80+NQvWL5R4jO+0at?=
 =?us-ascii?Q?JYYj2Eh08hhhS2kb/v5BoD+EjfaFiIYiIsSObBsIB7s2E/vevVpu0y3tY2R/?=
 =?us-ascii?Q?UjKCl9UM//IoXITx8GzB8XlnLhxn+KsAC6Pmpt/n4NcwPjsJnFNHHXaixXlH?=
 =?us-ascii?Q?iIGnhyLa6/iYdYmNo+ns6/AsRfFtmOdQ+FBSDEqm+oyj10CiUBqQnlmc1Ovq?=
 =?us-ascii?Q?CFJj0L2ExoopzSH20noctREie9sNNywTG3Ncikdhh9wqAbQvWUetdgL4/ArT?=
 =?us-ascii?Q?ZRQ/UJlZ3pmF5BJMab80QIsN/kzBW+NwBs/iJ5gpt3cjXqRa7BXD/7Ey12kD?=
 =?us-ascii?Q?zLNkWLpXFZIeMN3wVXZeP/tRUp45/imGnkZcYF4Cx5L3KUcNYnfkW+pBL7nd?=
 =?us-ascii?Q?HAvbYKZGQUC3ls4iaZCYKxc3sg2VAWkM/1tndwU4NnREXQ2Zwtme0SR5QRnQ?=
 =?us-ascii?Q?3zz5veiFI+VErbnKTC1Jj3rd7cMhfBWD+AfWFRCgaXxLAdnEpYvrng/acBAg?=
 =?us-ascii?Q?VJiLmwz+vHXXwiTjousj3cBsETqJaZySH8cWVrN3IRg6DvM9zjzkSlHe6Zmf?=
 =?us-ascii?Q?uJ74PVtrqs1yUN63Ao2Dd60aaAnvez0M1vMDOcKFYOEKbl/mmokVhF35JJ0w?=
 =?us-ascii?Q?KT+fNQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4803fa54-6204-46e5-d1b3-08d9ea1b4bc3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 09:22:01.1713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEMYA5yai5n85YncPpHoq5nZXt0XOpx1lzFjArGDXzFuh5AxwUTGqUQgebqKfK6amZ6frjfsAsRgWMnxYgRBbra5CPOlPGRYtbacvxs9KsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4976
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10250 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070060
X-Proofpoint-GUID: X4GxM2JmMfIaq1Qn53VrLv5ucJa66ff5
X-Proofpoint-ORIG-GUID: X4GxM2JmMfIaq1Qn53VrLv5ucJa66ff5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 01:02:17AM +0100, Fabio M. De Francesco wrote:
> My first question is whether or not msleep() can be called in atomic context.

You are not allowed to call msleep() in atomic context.  The Smatch
check for sleeping in atomic did not look for msleep so I will update
it.

> If
> I understand its semantics and implementation it seems that it should be forbidden.
> What about changing it to mdelay()? Again, it seems that mdelay() spins without 
> sleeping so it should be safe. Isn't it?

mdelay() is does not sleep, but it's not necessarily a good idea to
delay for a long time while holding a spinlock.

> 
> Furthermore, I noticed that _rtw_pwr_wakeup() calls ips_leave(). The latter 
> acquires the "pwrpriv->lock" Mutex. Aren't we forbidden to call Mutexes while 
> holding Spinlocks?

Correct.  You cannot take a mutex while holding a spinlock.

Where is the spinlock in taken in the code you're talking about?  If
it's rtw_set_802_11_disassociate() then that's fine.  The check for
if (check_fwstate(pmlmepriv, _FW_LINKED)) { will prevent ips_leave()
from being called.

> My second question is: should we substitute that Mutex with a Spinlock and use 
> it everywhere else the struct "pwrctrl_priv" must be protected in the driver?

Changing mutexes to spinlocks is tricky.  I can't review your proposed
patch before you send it.

regards,
dan carpenter

