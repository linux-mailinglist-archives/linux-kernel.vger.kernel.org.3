Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA764EAA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiC2JJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiC2JJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:09:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BB9242203;
        Tue, 29 Mar 2022 02:08:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T8oV4u028622;
        Tue, 29 Mar 2022 09:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ykMN/lpl4FxnbXFPw89SFkeE/DC+xzGC+w8I351Wc4Q=;
 b=uZUAS7Cneir+xQ/pI0u29PnqNLLrB1wOSQfqzXPTZYnsxSEdZ4HZPUX7VFWn9Pm3fenr
 caJI/1RRZ/aDr/JrzqoU9K118OupGhQB4LOShLc8yyzPbTUkULoB3e1DNHX2LGjy/9ka
 fbyhk32oX9oK9NLntu0Ns0iXW8HuXx5YqlO3SmBlq5/WNGOlBcIDTmofkNgQWelCIBwu
 5WtgDVUxFPvRMoJo+5/kJrM9vIt4a7JTg1CqyrUtZ5WId1dojz5c++iUmdzilZWGoH1w
 LXJT+15Uymc05kfF1y5CGo4ttN6dXkFARk/NZ2YnHRTS0DkekITJoQiHOof29ARBL2P4 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqb5xy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 09:07:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22T8uwdO007083;
        Tue, 29 Mar 2022 09:07:45 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by userp3020.oracle.com with ESMTP id 3f1v9ffh99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 09:07:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOKc5FO7vccR0X1i9DtmTqqOMHiJ3jvL09gfpKOXOGxeMfxZuDCm3WCQxs+KVm14kVT/Ij1BREcVaYFtUbzaPu5d5NhYcvLaHBTXNlRtkrVHvtEWzob7yvaL6akM34lvE5mrOBNB9md4GvAydjJXr1oNt8/LV/DguT2WfJhmpJ6faqYp0QAUKRQF4ioeS4Mmspevw6u3MjUGaQaTk8hNtOms86yy5+cKRjVaQGXN5MbMaQpWL9leyNBtIoGyMwGt30Y20LZEJhfza/nBn81+gU1kpwH8tDG/15gj6hNMJ5lGc0e5c/qHbr4LqxcVr8rw9Nda+6m3YA9dbscg07TaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykMN/lpl4FxnbXFPw89SFkeE/DC+xzGC+w8I351Wc4Q=;
 b=eO25Iuc0iZp2bQaH1MKLmzdrxIeF7DsT+YImH7+oh944q2KraQoIK6pNtHsIXQi53xLPWHPmcsDPu7MePkEp+a5qCMK/2mik8IrznBqBkFcEQK7aTAbmVJEOd0YXTDC2jIE1TXPXEuP/DRBx9LLTK0TjRBnI7uCZbupZ+O8Yy5sEq8W0DwcQ7aFMMYxNealjLVgjDyysL+inbgl5WehnVjlO61TSpe28WqcB6w3QZypk+eZlcGDXWxg1m8SwLuvZpMhfHrNqROGQUGTF/gFXhI+uYVoEc8EfFprs3f3B9gBtjHzQpvmoYnPLYimHa+scCm4FBf9YlhSn8S4LYLk3ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykMN/lpl4FxnbXFPw89SFkeE/DC+xzGC+w8I351Wc4Q=;
 b=G2GvQDKo4Vg6SPZPLiFtl42uIEN7y5WIwKEwP/s7GvcqbeIHGNuz4omoUBauKCceZMkKZHp5IkQmsvz+8ajxPKGknIuRWJjDsmuVrNNZCCPuv7rJy7JDwffCUsxzaDljzA6Fc6mc7DNvvQth/1IhjKkMwNccSmgv0aR7JN+TpKA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2523.namprd10.prod.outlook.com
 (2603:10b6:5:b2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 09:07:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 09:07:43 +0000
Date:   Tue, 29 Mar 2022 12:07:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, corbet@lwn.net,
        mchehab+huawei@kernel.org, davidgow@google.com,
        linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org,
        cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] Documentation: dev-tools: Add a section for static
 analysis tools
Message-ID: <20220329090721.GW3293@kadam>
References: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
 <CAGS_qxpjj1W54BM7v2Cszne4nh5kUXZt89Dq-5nO3nD7RWhsRQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxpjj1W54BM7v2Cszne4nh5kUXZt89Dq-5nO3nD7RWhsRQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0071.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d03f3da5-fcee-436e-e83a-08da11639542
X-MS-TrafficTypeDiagnostic: DM6PR10MB2523:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2523D32E87FC7C9B8B2B34148E1E9@DM6PR10MB2523.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrnzRnPRsnP/NuLy8jpcXW9oumUf5okR/HK0skCOIJWncfYqthrd93NUQBbYUudc76BzKznvUudvYcv4yzvCjgL4htwv5kiApH+NTBPV33gIPxriTuSwiRVT/OMBB8Wm7Ifn99gA5OkYLYbkFUSXMRd9wEbYSBhXeSkfS+2fEL2v9gwfSjoE2cWo6fEHHE94TcKbFmayRsv9YkFXMlp6LoC2PBVkfJcmpjG5b0Bqmn1aN5fhTHNwHwcb6Xkujbijj1lOT4PSDHwpisWnb+VNYB7noLyVXC6P5OpdGwceE6CFguWTr8xVIf02JFyV5wHE9h7L6SZ6os0UdPy+eA8RP6bb+AGL2wT2o4Ejn2IeXb8JS3pJeTs2cI/YU2K0bEQO9ELENquzEfEHRiM6Q71vzekbDRTzvlDgNZEEsMXjRPoGw+5S4kHA55hY1+124K1zYqlteMddbLmF+S+gs/EYEbOCFaxiGTWQptqiCzP3wLokunKpOahlKo/w4mqmxoc8TsmasA6LrduGXkGcYfeICSq0sjwfpU2HdTCokxywMm7RjSug/yUsM7x882bx0mTKtyKT56YNCS8imdCq3g3/X3mQS4p6GimeYFloz5AZOFeHae7A181EVtWy69dJH3Jr0E5muxmPjiy5fQxjW2XwS5+W7K5kY2KtZYHKVdcbY1fHjEn8KrhW9rVXjZT7cCh1Xrcs8xGRamqFCGwh7HP/N+PAInwNMvD2/8A+u8Y+BzEOvyBny08iLEojiCEWxnwgxewlOjX/yopfHyIWhae0vbFcbaWtpjWnb0SdBDkPqhU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(8676002)(53546011)(66476007)(52116002)(9686003)(6512007)(33716001)(86362001)(66556008)(6506007)(6666004)(33656002)(1076003)(26005)(508600001)(6486002)(186003)(966005)(83380400001)(316002)(6916009)(66946007)(5660300002)(2906002)(38350700002)(38100700002)(7416002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GyDN2ks3C/gFv88ihgKEzvgjj6VBmPzh0LsSgMfqKEC1sbK7H3+T14IZYRj5?=
 =?us-ascii?Q?P3kMMKrRYJWF/koX4Ydhu+C0R9FLD/kK6Px1O0B0obiY+xJtMcxOxu1IAPpR?=
 =?us-ascii?Q?CREJwLsD5sTPqLFcrxAmwO/qY8F1jzdvD2XsfaHQ6pyN1u3WiTzIQXB6tUZ6?=
 =?us-ascii?Q?ThqAQYcewNWSuyDJ0bGFro2YYunpkRySNyJqUpHOyWkuhvXDItppgw1ZG0xC?=
 =?us-ascii?Q?zhCIOFrPQLhnY6rVRtYfqKJ89fhQchbMVuP4FOwBesZPJ9Spn6rgAnMEcuCe?=
 =?us-ascii?Q?6tNHxLCaPLj235xJXi4uIFs9bhfrob/HFodzg91LDgdwnSYA+JoDJ91u6JL9?=
 =?us-ascii?Q?jTr20I/tmAWUyDL+xCSGjpMtx74m77pfQze/43x9Ebv3BBbLCryzfV2/drJ7?=
 =?us-ascii?Q?gmUxzkYbHzq3cTLN5E+kdoKxkcAyDr0bGMfxq1h8yiZtyr4AX1sK84RSrmiv?=
 =?us-ascii?Q?SBk5N9VeHB29iNvfibHTCzqbwpYSfJyAnFeMqF5P+GPxdSaX1HoO5M0hA4WK?=
 =?us-ascii?Q?71tUOVN+32MQAl0ngZlDpztYpWr+scc2eZhjtAp2/aBFaEcwPz0nzB6UCLUU?=
 =?us-ascii?Q?3S40BuKtRL51MjU5Vnoz5cssOtu+QFLBagJ+ZgXSg47pWYyUQYOLJ6vM49ln?=
 =?us-ascii?Q?D2BA123BXF3CZWfjuySS+2y26IzutYcdjkEUHRp+Zuy5ZV/+9fkBDawlblrR?=
 =?us-ascii?Q?hxk+RQ6Zpi6Rw0pleh6BLToEw0QcUqxsTd0/PT143wDX6bLuNX9rX6FLvaPI?=
 =?us-ascii?Q?e56ut6jLH5X461wEHMI0728MnGiOvoJCz86lK27EVARi0fQsSozkLEoq1vj1?=
 =?us-ascii?Q?ChoLIc86+LS0L/M3BNHMR0YmOmPJu0vwPBHvI5IySfLz24l8kat5ipKQ8aIY?=
 =?us-ascii?Q?t2tr7ewYqsqXSFYesD7jLBzSWXOUW8wBGppj1G0MKbD9CVklPB2fezfs3+xy?=
 =?us-ascii?Q?LLFedDdBZhRV9BmQMKJwZlYhjY2uDVM5NsPXQP2Awgms60DNit/jXo6puz+6?=
 =?us-ascii?Q?mKnEeE+v4+Nm9WhPVb+gcH7Y+dcPPqKBjFyk4PDyatjh5aSxtsdzqbDAp/L2?=
 =?us-ascii?Q?MPj5srekSBA2siAZPBS3LPZDrtym8+pKyisvgvV2AmsyXstVf2t6WUG5ej40?=
 =?us-ascii?Q?381is99NBluSS3XQgYeKUmSnAOrpI7ECub8s+rB3PugOUgOet3pTVvP1b2yB?=
 =?us-ascii?Q?axgdEGp4qvRoD+trth+9Yy/II9dz89YmY20WA/rNvfV+v/ycptH4uLe8KF42?=
 =?us-ascii?Q?6/mUNm/1w+0SKf5gUTFjSpr+Yb9OBbnclvAWJhbxAbSfOITFevBXjQRsu7U3?=
 =?us-ascii?Q?6EotjrUyXxFRTGv7T5QRIpSsKF+9tGjbyw//bSF//tSEm9RF9Lluc10woCCu?=
 =?us-ascii?Q?9JbGB+zbZT86KIr7P15PDVmcoaV7onTrpLo4b6wmZStk/WwdU5juQ4UYv8ch?=
 =?us-ascii?Q?sx6iPo3xkk3FD15wiPDwJfXSaMMIZsqSnBaYFUTaB0u1R8PElupZOJRgS2JZ?=
 =?us-ascii?Q?qULaMhNJucv5OMdYLKPBqIkuenGhqbvec3f3dDI84REuzfMQ+QxqV3s6I0Zm?=
 =?us-ascii?Q?AfayyvNhQnBZbyVIpZqXFlbPTWT8Yvxhw5aW1zw5vsb3JYdFClV/g6igurB/?=
 =?us-ascii?Q?TCOd2rtD+s0zbbfKYtnKQ7Mx/vkjGcWdbd063kJCHMR1z2mVqubFaW+n52Pc?=
 =?us-ascii?Q?vUOzuShpFSGqsIcwqYeNQ3AuG6iJLIoPrBiSImQs+OmVo8QLdBes+VutPZdM?=
 =?us-ascii?Q?WFLMvomum8wn3jSM/zh/QQGwCYzl6Ws=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03f3da5-fcee-436e-e83a-08da11639542
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 09:07:43.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fggk6kJWZQXoSwOGM4dinIP8Uh6SJG/8KbnITiNPWgSq+tGfwwY+bMou5cpM12qRnAEmdKnjPXiUZE1YaxSwvGw7HpCla7uPNHFLhi6nEME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2523
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290053
X-Proofpoint-GUID: oNBWbRljdBorZ9wZYB8RTmvg693YjJR2
X-Proofpoint-ORIG-GUID: oNBWbRljdBorZ9wZYB8RTmvg693YjJR2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 05:37:28PM -0500, Daniel Latypov wrote:
> On Mon, Mar 28, 2022 at 4:20 PM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Complement the Kernel Testing Guide documentation page by adding a
> > section about static analysis tools.
> >
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> 
> > ---
> > Hey everyone,
> >
> > I think this patch can be a good addition to the documentation as
> > discussed in the thread for the testing guide documentation page:
> > Link: https://lore.kernel.org/linux-doc/CABVgOS=2iYtqTVdxwH=mcFpcSuLP4cpJ4s6PKP4Gc-SH6jidgQ@mail.gmail.com/
> >
> > If you think it would be worth it, I can try making something more
> 
> Nice!
> This is definitely worth including, but I'm out of my depth here.
> Some ideas below in case they're helpful.
> 
> Acked-by: Daniel Latypov <dlatypov@google.com>
> 
> > elaborated. Maybe provide some guidance on when to use each tool.
> > I've been studying how Linux device drivers are tested.
> > Here's a post I wrote talking about some testing tools.
> > Link: https://marcelosc.gitlab.io/how-is-linux-tested/
> >
> > Best regards,
> > Marcelo
> >
> >  Documentation/dev-tools/testing-overview.rst | 29 ++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> > index 65feb81edb14..b00511109a9d 100644
> > --- a/Documentation/dev-tools/testing-overview.rst
> > +++ b/Documentation/dev-tools/testing-overview.rst
> > @@ -115,3 +115,32 @@ that none of these errors are occurring during the test.
> >  Some of these tools integrate with KUnit or kselftest and will
> >  automatically fail tests if an issue is detected.
> >
> > +Static Analysis Tools
> > +======================
> > +
> > +In addition to testing a running kernel, one may also scout for bugs by
> > +analyzing the source code semantics. Three tools are well known for serving this
> > +purpose.
> > +
> > +Sparse can help test the kernel by performing type-checking, lock checking,
> > +value range checking, in addition to reporting various errors and warnings while
> > +examining the code. See the Documentation/dev-tools/sparse.rst documentation
> > +page for details on how to use it.
> > +
> > +Smatch extends Sparse and provides additional checks for programming logic
> 
> Coming from a place of ignorance, when should I use sparse vs smatch?
> Is there an existing consensus on this, or is that a controversial question?

I am the author of Smatch.

Sparse is a compiler which can print static checker warnings.  Smatch
uses Sparse as a C front end.

Sparse is useful for type checking, detecting places which use __user
pointers improperly or endian bugs.  Sparse is much faster than Smatch.

Smatch does flow analysis and if you build the DB, then it does
cross function analysis.  Smatch tries to answer questions like where is
this buffer allocated?  How big is it?  Can this index be controlled by
the user?  Is this variable larger than that variable?  I feel like it's
generally easier to write checks in Smatch than it is to write checks in
Sparse.

Coccinelle is probably the easiest for writing checks.  It works before
the pre-compiler so it easier to check for bugs in macros using
Coccinelle.  Coccinelle also writes patches fixes for you which no one
else does.

There are sometimes overlap in their checks.  But I'm not going to
re-implement Sparse's check in Smatch because Sparse already does that
well.  If it's just way easier to write the check with Coccinelle then
do that.

With Coccinelle you can do a mass conversion from
kmalloc(x * size, GFP_KERNEL) to kmalloc_array(x, size, GFP_KERNEL); and
that's really useful.  If you just created a Smatch warning and try to
push the work of converting on to the maintainers they would be annoyed.
You'd have to argue about each warning if can really overflow or not.

regards,
dan carpenter

