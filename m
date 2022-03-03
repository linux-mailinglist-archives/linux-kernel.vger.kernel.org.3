Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58E44CBF2B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiCCNxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiCCNxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:53:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDBC332;
        Thu,  3 Mar 2022 05:52:30 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223BjXkq013834;
        Thu, 3 Mar 2022 13:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=T7KjAE6RkKNQrciZ+JP32LG3eGH0vQwY7IlaKkhFQOQ=;
 b=WQz307OqDjHoHYrcgL99469xTVW2mf8tjpi04Tm5pcBH046Fo5WAUTq7P01lWehX9b8m
 LS5W0SGy3/r8xsAczQgQ228l0onjncp1YYYAaFk+fdOfoY+B/jkIIpWyZIfD25Rbd+TZ
 00GDWPEvA9OExk6zRu1a/4LqBZLwgHrl0yVYhqn3UQTpLSWc7aSMPA0b9wtKLpF/5sma
 42/8RySR9kBF4mQmHvl2zB+qCAMzKETdZjpquRAmTNCACRmTHIFyxeBX9gbegeORY6pK
 YKGR++Uib9QdvdNrKV4RABsftXBC+G7Ry65oMjFPQXEKMJdUJr+eqZJ9pAZPvMFgctF1 Ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k48v3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 13:52:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223DjMrs175945;
        Thu, 3 Mar 2022 13:52:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 3efa8j5ess-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 13:52:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMES84G3ywa8Pe95jqnhDPAHsz7cy8tf0Wq5J0iEr5XvavaAgQ+iJPG2sDV6AYK0Y5cHJ2tdrpF4a3HEe6SZ2n2Ba2IyIFyihK9qGIP5QAmyFW8rb3bEGJi2JMOEs1mH7dE29EmYmDr+ocKe7F8+3AC1J4C7F/UR5R8xiUjtQe5VUpMFIvHaebIGNpWq16GQ2kG7DOGTxxGXTwqD+rk5Z7C7jRH+wNKYeSfuZeZVlcVp6uKc61ijKKW0DM2R6Ui4sT1MXopFNSj6Kgf5H/fQIpXcY2FEC3lea5TA/Vh6IoApAvnV4XGfGw5OdanqxyGTmRwdR5CQEtDC/PZIjjGzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7KjAE6RkKNQrciZ+JP32LG3eGH0vQwY7IlaKkhFQOQ=;
 b=UYgXOY4bwzyp87WwRldkQf2GncZErenGl039eq7Y0gugj2YARZbxFDYO25nZ0LeA2Ot+NhyhG0ed2qhHDjCJnO8L93hD+EvPRzBEhblu3NHZaB3ffmvr1P9k12o7Xo/MVtxJZzgMLxKsNWS9gIiT4ISf9t0aghftdFiGhu1RRoVRN3MjxfOuKphenpHymYr7bEDkvzdaL5I4aZunKjxuSpvNGtSXkOtVgTvu+WXOy/iWmtrE3eEETQ3o3uxiHQHzFctXy1tK84tFIf/niFCIEUGwJiLk3umqMJR+71RhHHHiKZjXdNCzLXwwuW38/KjaoN8A55sH0pUYqglCmFax0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7KjAE6RkKNQrciZ+JP32LG3eGH0vQwY7IlaKkhFQOQ=;
 b=PnFh6pU2jPP/3cXH+fJXZRXW5uUMAdWznTqI9NgXzJcIS8m8MoMXirtfP9VQn9zzxCek091Hq8cx5SE6nSzZPq87zdbEmNefZU3FntRDlvL8QRCA6W6/6ma3//y0KEQaOtH9PDI3wS4sZ0l9swpnuoEA+Je4/bPw7nBWvF+tw30=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3186.namprd10.prod.outlook.com
 (2603:10b6:408:c9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 13:52:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 13:52:00 +0000
Date:   Thu, 3 Mar 2022 16:51:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>, kbuild-all@lists.01.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH v1 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
Message-ID: <20220303135139.GN2812@kadam>
References: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
 <87o83xrwk9.fsf@meer.lwn.net>
 <YfPzNNvK8Sy8YmGW@casper.infradead.org>
 <Yff9xoh873aEikY4@hovoldconsulting.com>
 <YfgBi9dn8LI8d/bo@smile.fi.intel.com>
 <YfgSpArfoL9LUaBO@hovoldconsulting.com>
 <YfgninPOaJhq7dsZ@smile.fi.intel.com>
 <Yfj0lb50vS3ssrsn@hovoldconsulting.com>
 <20220303095432.GB9912@kili>
 <YiDCTqWzdCeNfOdv@hovoldconsulting.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiDCTqWzdCeNfOdv@hovoldconsulting.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CT2P275CA0020.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:b::32) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e988f2a9-bac5-4873-a2b7-08d9fd1cfda0
X-MS-TrafficTypeDiagnostic: BN8PR10MB3186:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB318679754099B8E17E6325828E049@BN8PR10MB3186.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60kx+WAg4458lPexo8niFhmK6c2ZP6xnUl08BPWzLQGTypUJHm/R6ws175iRo6FITj4Id6vNUgP7rnxQ5vi/5DxCRl1cSIvNjLT4cWa/0bAVVnaz4leEXGb7svDDIqB/YZVOWi+Eo16N9J/bG6D9f96eZ/DKZ6tyjWfM+AldHahHvgyLdn8h6E1iU5/X5KSTbhsHpLOD1d6CWUlrmdegXYzdbn5NK7IUcxiLA3FJt4zIwqX/JCXTf0NWovGhc6OX4Mtl7dglw474e3djjrMf//Yb9vQbyqmy8eIIY8Lg3gE5kqkG/cI/6yqlkbjGe8nYDciK0sk/uQUcpQkghfPACxj2SRfvFjc4KV24jvWo4qf+XuF5ywfOuQ0CKJcFaZfzD+K5LNpqOrMgOjAk1GQcJFuSrzm5n0gaQlpXr/mWAo42w9Lz6dLKghJpBOOxk92zjj2l8n/g1SXVM95r32t/SATlfOYhftHDl2M8h1Sj9kzRm5ya+nt4cWvMTy6BEj96XycWFfgw9Z0utOatLcQva4ZY2Y4Qvgij3g12olUQsxYVpN3YiAjvWEsZojoZXUV78vijj6hWEzkxcb55vDB0WTxXVVhrbMwP6ZKDNlvEt1WHuqGtilAzbCtg4b3LYMepgCQ+rm076g4CYXTMpUfS5gZ7YL0faNgW9E3QCDttDwaURTJ/Hp3j8/I124vG5YpNsa5BS34+CRpEuahSc81fog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(54906003)(2906002)(52116002)(38350700002)(38100700002)(6506007)(5660300002)(44832011)(8936002)(4326008)(8676002)(66556008)(6666004)(1076003)(66476007)(66946007)(186003)(86362001)(26005)(316002)(6512007)(33656002)(9686003)(33716001)(508600001)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7+t1dCLc8DH5s2xXu6v9i3csN0NogAdqPjUT4ZzCNXwj20VpZPQaaa1Cp0yN?=
 =?us-ascii?Q?9tgJLsxmGs8XXgDe+gOjx7SSnn4BjkSThCAoNDXW+cOGG9aqi2nwdPtW6YHQ?=
 =?us-ascii?Q?e4QSGsee5lMLsWovysRfh25mUbBLoowhAgTEOmoGhMmDaA/ZkzGEJs4gJg5P?=
 =?us-ascii?Q?59VospUU9JGBU87FkZkhg7q48hZPxDL+7JgUuFd0vhdwnlFXBGqCCcGsXaC7?=
 =?us-ascii?Q?Jg/f6EFLKk5Yq4U3Z3qgnYqU0pW/JGvnfji2tlteuouBfrfYKZIUdfCMgFVk?=
 =?us-ascii?Q?hrwclAKCuO0HH5Aeat7vNNO60+jxRivgdi5BW8k59xFzKxZufZWf99xSq2/H?=
 =?us-ascii?Q?BRGi9P64pBEuZrn9UIPUfEdS75uy5kYikGn8Yds6hUdTGEB6uSBw3FsMM4e1?=
 =?us-ascii?Q?0xFiXvHLaBChFf9zAbhgiL28/JUERjbyY4mjNnnOw6BKVYoqGXl83SKNYJYz?=
 =?us-ascii?Q?Ll7RxZRfQQM1o5MPObHJtNeWtHlWD0owpts3s2jkGIuKMpS6G7jXcy3IA01J?=
 =?us-ascii?Q?68FlUtZ5fBPvI2LSuXBgsM2wtelRrMhP6I01fW4G343Ga8YQEmoIefbL8SbU?=
 =?us-ascii?Q?nrqDkk8B0QdVE1d1XkNvwlMhQ6Fzv27Ztbj7JO+wM9wATjgpRvJE8027g8ce?=
 =?us-ascii?Q?FwdSymLU62BxYjSfFKP5RZZeiqOHNDDuIT+qt/IYaUz7UEYPLoV4f3i/1PD+?=
 =?us-ascii?Q?GnwVOe2zY6nxsd8Vu7zG9Cy0Ki39sDXgb8o3waP4GFqxXJiBVpu0p1v5WbtI?=
 =?us-ascii?Q?F3JK2euGuGmYy3PjY8KNDE9vP7jJMnsTEZE+N16tB9QsGSZs//E6O3v9f70s?=
 =?us-ascii?Q?AvP6PExKXS/A9t6SmOKxk9SdV5i8lMIWiNnTDAcENGeI6TCl7eysyxBppHYI?=
 =?us-ascii?Q?Im/sEiv8lNHF0kIP36EaGLFCWVwpu13Dz+tp8a9drqEqw+hcEJyxUpHKvHgA?=
 =?us-ascii?Q?NGSxf1WXfA4dYGGwHozgR5/HQ/2i+XUIKwuPYDhXzscppijOwaul1vIDe9zO?=
 =?us-ascii?Q?uk64YtaU5U0vlWLeqyNFWlFyep0cRdcOcpX3MRpTNdau+aNViTV0xzngnzUQ?=
 =?us-ascii?Q?hV9t1BLZedbIpuy5CKl4ZoUccslBIsbciVXOJkhe+KFO6Sqe/7MlULJ8Nanl?=
 =?us-ascii?Q?Mqc4/rHpFHmBM2uKQHE463KJvYQLRyK7sB1erv3MaWIobtn5qoz+rNseGeh/?=
 =?us-ascii?Q?yKJcCq55tyBfgdA2tDgFsnkmyYGSOgvX/jShEVGGRFtWi24Z1yN7VvpEKmR4?=
 =?us-ascii?Q?SIF8feNB8M+gvMmf7Uwqtl4TLu87wCVhidFt3je7xUuGdJR6U3fDaemSi440?=
 =?us-ascii?Q?62YqTtfW+69JgcllIJ3MVbEu/ThSFTVXk27o9djiuWueqH49qPtMXyBLDWhW?=
 =?us-ascii?Q?QHL0jp+51U/MaDTNptS/VIAyvW/IJKwwB2lFqQrzM/sXkpHoV7I880ijhOmM?=
 =?us-ascii?Q?MkgrmPfQPaGLh9Lhpc3lvwoDrQcPzBFW7ErPzNkUc00hegplRwKdcnulGG6+?=
 =?us-ascii?Q?lxX+8MNliic+ADyL8r24up4e3oHBgZoUGgL0VwwIMgU4t+j6lWgxb9mSm8qL?=
 =?us-ascii?Q?a2pV/yqhzW2Dl6AAH5DDjWPEJv6m0fUB3M6TGntFYJOH0x/HNX0vRSMG/PP3?=
 =?us-ascii?Q?t0feN1+7RqqL+I9TdMieAFg/67kOVD9yFDZg09Ba+yz0zkgQqN/k4OfX9RNU?=
 =?us-ascii?Q?h71WYg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e988f2a9-bac5-4873-a2b7-08d9fd1cfda0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 13:52:00.7585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sQHFBARtLFPnDbcMfRgV4YHZJK7Ra2RLO0E0Eq1KLokX3eN5P33RYCTX4RZ99UIvof8wEpT2FwL/OrsbmNPOPWt6isA6oBISEQxEXWklio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3186
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030065
X-Proofpoint-ORIG-GUID: ROI-CrbxzRH9Neq9dxDPWkebjdm-PTPP
X-Proofpoint-GUID: ROI-CrbxzRH9Neq9dxDPWkebjdm-PTPP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 02:27:42PM +0100, Johan Hovold wrote:
> On Thu, Mar 03, 2022 at 12:54:32PM +0300, Dan Carpenter wrote:
> > On Tue, Feb 01, 2022 at 09:51:33AM +0100, Johan Hovold wrote:
> > > On Mon, Jan 31, 2022 at 08:16:42PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Jan 31, 2022 at 05:47:32PM +0100, Johan Hovold wrote:
> > > > > On Mon, Jan 31, 2022 at 05:34:35PM +0200, Andy Shevchenko wrote:
> > > > > > On Mon, Jan 31, 2022 at 04:18:30PM +0100, Johan Hovold wrote:
> > > > > > > On Fri, Jan 28, 2022 at 01:44:20PM +0000, Matthew Wilcox wrote:
> > > > > 
> > > > > > > > I think this misunderstands the problem that Andy is trying to fix.
> > > > > > > > 
> > > > > > > > The situation: I write a patch.  I post it for review.  A bot does
> > > > > > > > something and finds a bug (could be compile-error, could be boot
> > > > > > > > problem).  That bot sends a bug report with a suggestion to add
> > > > > > > > Reported-by:.  That suggestion is inappropriate because the bug never
> > > > > > > > made it upstream, so it looks like the bot reported the "problem"
> > > > > > > > that the patch "fixes".
> > > > > > > > 
> > > > > > > > It's not unique to "new feature" patches.  If I'm fixing a bug and
> > > > > > > > my fix also contains a bug spotted by a bot, adding Reported-by
> > > > > > > > makes it look like the bot spotted the original bug, rather than
> > > > > > > > spotting a bug in the fix.
> > > > > > > > 
> > > > > > > > The best thing to do in this case is nothing.  Do not credit the bot.
> > > > > > > > Maybe add a Checked-by:, but that would be a new trailer and I really
> > > > > > > > don't think we need a new kind of trailer to get wrong.
> > > > > > > 
> > > > > > > It seems like the only way to fix this is to fix the bots. Adding more
> > > > > > > documentation is unlikely to help in this case.
> 
> > > Perhaps I'm missing something, but if you re-read Mathews description
> > > above, it still seems to me like the issue is that the bots are trying
> > > to claim credit for finding things that haven't been merged yet.
> > > 
> > > Your suggestion is to document that the bots should be ignored. My
> > > suggestion is to fix the bots.
> > 
> > Originally the kbuild bot used to not have that notice but adding it
> > meant that kbuild bot got a lot more visibility.  The truth is that
> > managers love metrics and it helps people get paid.
> > 
> > The whole point of kbuild-bot was to search the lists and test code
> > before it gets merged.  If they just waited and tested linux-next they
> > would get their reported by tags because most trees don't rebase.  But
> > we're punishing them for being better at their job.  It's a perverse
> > incentive.
> 
> I hear you. But I also get Matthew's and Andy's point about it not being
> quite right to give an automatic test program Reported-by credit for
> finding, say, an unused variable in a not yet merged patch. And perhaps
> even more so since real reviewers often get no credit at all (but
> perhaps a mention in a cover letter).
> 
> > We should create a new tag for finding bugs during review.
> 
> Yeah, I guess your perverse incentive argument applies equally to human
> reviewers even if I'm also reluctant to going down this path.

We could make the tag more explicit:  Bug-fixes-from:

You would only get credit for crashing bugs.  Even manual reviewers
should get credit.  You would not get credit for style complaints or
noticing typos in the commit message.  If the bug is not severe enough
to merit a backport or a Fixes tag then no credit.

People always complain that this rule is ambiguous but we make those
choices all the time about what to include in the -stable trees.

regards,
dan carpenter



