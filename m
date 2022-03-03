Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0AC4CBAD2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiCCJ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiCCJ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:56:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AB415DB3F;
        Thu,  3 Mar 2022 01:55:07 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2238SoZw013762;
        Thu, 3 Mar 2022 09:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=tTlPnmqYrpNXn7f5ioY3LhcvcH7mo/9m3AOnmcvfXbg=;
 b=XBqT5YnzDNWKz/wd31a5Wro61LMjx9SG8GE8wpYdKMtPzJuAscirJ1LCeNtgyssXJf/g
 a78WAeakI62IYxGkBfKwbDxZl+dJKV7fqig4O9D/Ep5DKZrthEnBzpzYk27eoNDk6rE3
 LvxuJBo2inSPICG8Ga/zw5qsbApBgFBkagfo2K2XbMuT0ldo4vPwulYJag4KFW4X+Lcy
 ixqj6ijVdCsJ7yQrD18jEtMmsUIH11VALWNuUnWXs577HfjBsyV88A97t03/9Zf6tKer
 Z2sMHzp7WfUuvbHbQMhrJhpYd8nft6BHlZSwtkjqhEYttjigyCNEQuKEpYqwpiHZ8Cl7 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k48bsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 09:54:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2239q6Hf057401;
        Thu, 3 Mar 2022 09:54:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3030.oracle.com with ESMTP id 3ef9b2y3su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 09:54:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvKZgsZKdInuSCHj+vmQPfhHc+krTtBoX21yQSxIDEZzeof4ocSNooX9vHsKKtoGpuBF5XEhYdbvtIqsL3PHEpJdJoEiFABkTcm4OL2R8PSBzxwF/AjFZb9uexMbsFfXJVqIjiw/dakbzW6MFD9JKjz/jsERl6JTck6+q/ODAyE2kqgRq8nfMWOKx1nk6GGfiZhG7S/c9PLB695Rr1ES6uTbVucvtx2K/Dot4Aj3Tidv3MrMc/Mmc6djowGgc7Riuw3Y6Y7Au9UTkT91U60P6hZ4XUwatt31EQR9Lhj0KO1SwktDMnpFtqnwJcgFZgZwM/3TvVrvwOm51cNR8w1mIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTlPnmqYrpNXn7f5ioY3LhcvcH7mo/9m3AOnmcvfXbg=;
 b=StK/NN4/Uc64jfm8HYLQdQqvZtKbDqSTfURk6kCeLk3DY8ZSHZWqZzbkefemiSV3JW0VmCoc2SNEMsNBspg5gcschoy0qJGEmFZvyhVhpidOYIMCJ96hGVUgfpiZ7dzFf4UZayexD6AcydP//s5ePjcqEP9kXKt3FIkFjjBMH87rKT7Eu7WyQH0bX3P3kTVYtCKc9X5om8X9gu2q7wv8tOVp4yhoFzOz8g8UWQBdBDj6DI8Yv86IAEFZFH2TTlBGAGYGLdJnmYGfTtWW7dsuoeSlqIs+JdGDQLOhuqa7EXPVLz2mwc0jSUxzCKow/EqroRMwp4rf2fTPmGKVe2bGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTlPnmqYrpNXn7f5ioY3LhcvcH7mo/9m3AOnmcvfXbg=;
 b=ifte3lmrAByJJmTeUyfwQhxqp0DfJX6l1EBki1/kgFMnqiiKpXVC0cPXRlEBwQOLFpvL9xDjXOKaCI0ZICP2Y0xF8ay5KYzo/VLMr0W+SuYkWbHlGxVpO5zY10SVOxxE4delXf1AXRXjMea5GLcOp1LhFA00RPyW6WTXdXJzCIo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 09:54:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 09:54:44 +0000
Date:   Thu, 3 Mar 2022 12:54:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>, kbuild-all@lists.01.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH v1 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
Message-ID: <20220303095432.GB9912@kili>
References: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
 <87o83xrwk9.fsf@meer.lwn.net>
 <YfPzNNvK8Sy8YmGW@casper.infradead.org>
 <Yff9xoh873aEikY4@hovoldconsulting.com>
 <YfgBi9dn8LI8d/bo@smile.fi.intel.com>
 <YfgSpArfoL9LUaBO@hovoldconsulting.com>
 <YfgninPOaJhq7dsZ@smile.fi.intel.com>
 <Yfj0lb50vS3ssrsn@hovoldconsulting.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfj0lb50vS3ssrsn@hovoldconsulting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0155.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51fe4716-c233-4c2f-c903-08d9fcfbd7f0
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB54813AF757CD11D35B0052728E049@PH0PR10MB5481.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khaW8dYorQQcwr0ITt78PFjd6QjMdYvFt07V+PssiMiGf1vIjj7uzfuxUeJ3IdMoCd/yHBsEqoRqsemn6iz7d65eC8uHmajM3vUzMm1wk3iIEJMMCou3R+M+WTaik1NmZEbtSzdak/upqyiKWMLBq8DmqW/NuUjUNCSD3FkjCaiVtOU4IMuegZj4hRZmeM75ZHd5Pq9xk22KVTfsjESQy93DGiKMsV3yVjwCNJwH0OFDxyL1DzBpeI440uOFhAKGyUaEMD/Ceeu/DPNhWySvY4AY6hNoCgKbh+Bm/8yd1EMztjW3l6jX8cV2N8RbOcVPqtQQXyb9zce9m8SJiqgG8LV5b4dIC0ufK/lVqMhJM8wfYNNK+j/aH/mmzOHsClX3clmrAfQEVGN6sEcAXShhFNu0/R4iWY3FsIp2gdIHGReBfZ8lFGM5+Ve3up+Wn4TLeS23WUT+A+zye0O3ZGE8SEIg0Nz3PQFw1Ayauiu5b3vPcpYwqyhfETbxm0v2QMnltEn4DEgEde0WxFw76s8lJo8cWzgpJL5pdPd++7ePJ6uUEDu4BKYbafK3anQTo0L9nJYSuqZRfBQC4S1VqzWCGI7+qvHYrRcaHr3o2fqSv48UB/K2GD6s+hGcX7XDZb3X2pZhjbucDrJpS1052AG30lkzqWcpMraakw7Pp0se0gA/aXq6e60cDFnVGHjeGj4zfmla+t3lduwhJYmrQCcM6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(6916009)(54906003)(316002)(6506007)(6666004)(6486002)(83380400001)(33656002)(6512007)(9686003)(508600001)(1076003)(33716001)(44832011)(52116002)(8936002)(5660300002)(2906002)(26005)(66476007)(66556008)(66946007)(186003)(38100700002)(38350700002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UY3pQI++Tiiu8n0rvs/BD8rvcbIiJeLvwTjLCltFvwEFrN4j3UNNdDfNCguX?=
 =?us-ascii?Q?hHyCtPeE40tQt8Ebc969D9KWGzt8RlF4wuzWftbDYLJ5mN4SaKaBplooCi55?=
 =?us-ascii?Q?4IWLFlZVpBRVOfbTLTVZRtbGb9elIgkU88/lg58ZxNyXz0QmEXtQCQGk9J1g?=
 =?us-ascii?Q?zZjSCd1eB6AwJtcWwHiMJdyslJ83jrFI8Yx4gsLFgcEqFDqRLhczX6Qte/eH?=
 =?us-ascii?Q?QZQf/dCVuzWH+GrXoYWCdORviJpN0+faVvCfdfruUFDy0reZUIYq42/xN0gF?=
 =?us-ascii?Q?UdDKHg+bsTVwz+qXMxzZfBjAYlDkCLJIepxB4IRQTi5p0W5/5mZswuoUdMRJ?=
 =?us-ascii?Q?YeshXYTNC0whex0cKPJdTHf71kn9eBdrXRI2vKOz1sseKilmNaYXQupqGppY?=
 =?us-ascii?Q?r0Ssgiff2A0wV3OfUeP/zygdyVefBRVWamTvUSd5Mtejnbael/ZLsvR9zcrY?=
 =?us-ascii?Q?fCktiM4soFewy10WR58t0frYwcoP7hLLxC/PnGNTtpSFNlsf2d9tNmZBNhom?=
 =?us-ascii?Q?SkLartGdqhT5Dg4dqBmWASM4c2BH8yIp4y8VXqMgj7Ebu0nEzYmNy7VNp3eO?=
 =?us-ascii?Q?gWkPsaQaZ4dr5DrUElnShKkoO2xmNQk9fdgyMMR0idL37TJVVwTLVnO3G79U?=
 =?us-ascii?Q?c5XWb1xpMunwlbJZX7AB7xHwGTAeRhNc6b1LMGmAlmydd9Pw4Aby//KL+gCS?=
 =?us-ascii?Q?4kMksbZLgcMjR2ilXidH7KxTL8SHT328wvGLQfenqlMAemsPAzXCDykZLsRg?=
 =?us-ascii?Q?QvWwUi1Co3zRz2Dxmx91vwHBwJXDo0FmJi3JoZ6+9uDo/KPEt5PpPaYdiBpA?=
 =?us-ascii?Q?xr2LNEy4QMK+88M8UDnIqTQAV4pdJWciqIHjTTlkkf6uCJNBK2FpRqplm/zv?=
 =?us-ascii?Q?vJd3MfyKQx25O3DDetGUwSdHnkciUCurcy5bwmEszdKfSFfdQLsMLMFjLrQD?=
 =?us-ascii?Q?94pkQmYPM7Gcu4ZrdWTAOTcQxASpkx5JDLCc+NxT1bcgEOQ6xNE+oVyV14lH?=
 =?us-ascii?Q?PL6LfayjKAQUl+E9YkOqLoHBX05WA0fMGVOMcCe1KgZ9zaAllR+8HPIanB3B?=
 =?us-ascii?Q?C/nBrIAHXlAuXzsC4G+7/9SfmJzBls+XCxIVKSW99u6nMwA8w0eonZHWn4Eo?=
 =?us-ascii?Q?S/lBl+3w7mUkm9lgaDgf+E2SYMQ+Tg7VKEpD9VLY8BWmKA5rVVUOhyM3E42H?=
 =?us-ascii?Q?Nfp25GBk6uSqs5TVEe82zI3LDw7OdgXThQ8ZNuJ3nnzuQrvRPpsuoYPsq7gI?=
 =?us-ascii?Q?l4P6/DhYxXFI08S5SnZ+ihJumMGGQHA3EAlk+hruYxOG2ZDU7KlOtZpP5VGU?=
 =?us-ascii?Q?uTtQYPr6TrowZZdaWJVHEfccbo+5lLsrA3lvBjU7QWCJpK3icZzcpePGt030?=
 =?us-ascii?Q?cn4uJIDAPufouKrVo8K/wWuFWyumJdUDb52vwXa7l9eD9/dQyzdJOvwtwJ4b?=
 =?us-ascii?Q?ZUzt3/aX6Iz3Z98UbjZlL3XvzBEQCtilQS8alJN2eu0AaAkJQ9rjR/AvjbhT?=
 =?us-ascii?Q?AMrD+5dN6h3BFD//7k1+YuPXf0vule8fA+Mm5MuW37nECAC7F1sDNEnbXxH2?=
 =?us-ascii?Q?L6SSOde9wrcrCz294V3QrFreM8loT6yJbRv5eQLMl4zCHVk84bE0QYrOOIXt?=
 =?us-ascii?Q?2J79n8yBndbOBsX22YbHKf7iRmIXHSfrb/Jr5W3SRrG94JNjeRQs2H1Lxrnv?=
 =?us-ascii?Q?7uuJGg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fe4716-c233-4c2f-c903-08d9fcfbd7f0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 09:54:44.1695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlaa2nBcJM0w9HkB63CCAK9uvpnXLcZT31vlLkCv59xuetZph3yFS1ehfnOSDcxsonR4A03dOV5UqVzeqpeSSns0j8SUtqSfwbxt7jykzDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5481
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030046
X-Proofpoint-ORIG-GUID: uHPY-0y8uYqqFLOjMYXmwYYX4oeQGxi1
X-Proofpoint-GUID: uHPY-0y8uYqqFLOjMYXmwYYX4oeQGxi1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 09:51:33AM +0100, Johan Hovold wrote:
> On Mon, Jan 31, 2022 at 08:16:42PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 31, 2022 at 05:47:32PM +0100, Johan Hovold wrote:
> > > On Mon, Jan 31, 2022 at 05:34:35PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Jan 31, 2022 at 04:18:30PM +0100, Johan Hovold wrote:
> > > > > On Fri, Jan 28, 2022 at 01:44:20PM +0000, Matthew Wilcox wrote:
> > > 
> > > > > > I think this misunderstands the problem that Andy is trying to fix.
> > > > > > 
> > > > > > The situation: I write a patch.  I post it for review.  A bot does
> > > > > > something and finds a bug (could be compile-error, could be boot
> > > > > > problem).  That bot sends a bug report with a suggestion to add
> > > > > > Reported-by:.  That suggestion is inappropriate because the bug never
> > > > > > made it upstream, so it looks like the bot reported the "problem"
> > > > > > that the patch "fixes".
> > > > > > 
> > > > > > It's not unique to "new feature" patches.  If I'm fixing a bug and
> > > > > > my fix also contains a bug spotted by a bot, adding Reported-by
> > > > > > makes it look like the bot spotted the original bug, rather than
> > > > > > spotting a bug in the fix.
> > > > > > 
> > > > > > The best thing to do in this case is nothing.  Do not credit the bot.
> > > > > > Maybe add a Checked-by:, but that would be a new trailer and I really
> > > > > > don't think we need a new kind of trailer to get wrong.
> > > > > 
> > > > > It seems like the only way to fix this is to fix the bots. Adding more
> > > > > documentation is unlikely to help in this case.
> > > > 
> > > > Links to the documentation at least may clarify the point in case of a
> > > > review.
> > > 
> > > Sure.
> > > 
> > > > > Can't we file a bug to whoever is running the bots (Intel?) and ask them
> > > > > to remove the suggestion to add a Reported-by when the bot is testing a
> > > > > patch (as opposed to mainline or even -next)?
> > > > 
> > > > The granularity here is not a repo. It's a code itself and in some cases
> > > > it might be easy to distinguish new feature from the code modifications,
> > > > but when code is already there and feature is just an extension of the
> > > > existing file(s), it's hard to tell. And it might be true or not.
> > > 
> > > Not sure I understand what you're saying here. Perhaps you and Matthew
> > > are talking about different things after all.
> > 
> > I'm talking about your suggestion to fix the bots. It's not easy.
> > The problem is the same as Matthew explained.
> 
> Perhaps I'm missing something, but if you re-read Mathews description
> above, it still seems to me like the issue is that the bots are trying
> to claim credit for finding things that haven't been merged yet.
> 
> Your suggestion is to document that the bots should be ignored. My
> suggestion is to fix the bots.

Originally the kbuild bot used to not have that notice but adding it
meant that kbuild bot got a lot more visibility.  The truth is that
managers love metrics and it helps people get paid.

The whole point of kbuild-bot was to search the lists and test code
before it gets merged.  If they just waited and tested linux-next they
would get their reported by tags because most trees don't rebase.  But
we're punishing them for being better at their job.  It's a perverse
incentive.

We should create a new tag for finding bugs during review.

regards,
dan carpenter
