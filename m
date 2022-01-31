Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF4F4A49EB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376538AbiAaPNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:13:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61676 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358760AbiAaPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:12:58 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VF94Bp015816;
        Mon, 31 Jan 2022 15:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=LMiL2M2tVTNlSsG3mgk1++aOUAoqhGKDkttePCrHfGk=;
 b=YKv6lvfc/apECHD9L8YnZt8p8DYnjqrzoppy3+akgsKIGC0ZZ95AwKbdCie8l7I8UXLb
 JNhfXo1dv2rt7/bp33xOyiAV1wOLyoeedDWlGIOw5GAas+GaV/2ZVwFGYVW9+DCDrP7r
 lQl6J4AnefgDTNXTug8n5X9VNqMDj7EkUz4pf5JrmKdnOdfNcsmPwz5JwCM4WMhQ9bZT
 93uJDnk6nyUhT+2icwdrNfjadKL2w6oqFW2vGIMzwimhViehxmZ5SMyzb0ldHI9NhmoQ
 RQqJrei70nqUEsbiLn2Bd55vBvODUhGPU0hzv5roKZb7xLTcW0Zy/iiiAKBy71KpQ4oM xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dvx4uvdva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 15:12:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VEZJQd100834;
        Mon, 31 Jan 2022 14:37:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 3dvtpx323x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 14:37:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOFygq4KoGQSR2omBpqY9TPuZ7oz/OxymBiBi92Z3hl+fOFU5T4cL9p6ocb/YDOyrDm+ORQSlz6kwBZgR91QfHYstIYhH+A3rULXT34SczD8XJRV0Q3TgiSqw/jcd9AzuXiDJ+zU9nmIFpvs6SGS/J4JY8YwlInDkmTzr/6BCnaB8HixuqV8PD+uGftEnzEKeIB9ZUVL5pa78vG9SLRl3yMGfSHRFp89k2v9/j2Lr2cUXeOreaJfLXUp2PMLzI/CUEZlaIfBSb4GahkRH75UJmTmSbWyKrDsDzAZHT0RKFiWKs7XFMfvg/eiylmxSx3/YQeT+TQr7+5oDpD5xSA/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMiL2M2tVTNlSsG3mgk1++aOUAoqhGKDkttePCrHfGk=;
 b=Rp43eoXNh1r3OQMbBxb/fteU3v8tFF2Sb2mMoqlmkZOkSUT3Tv3nsZoqcgcijb3jGm7ZLr3xRY0SqHw75nB8dHuGcxRighb5dflmRHedrS2q90GFQtxZyylxALngCvMgzBKbtm6pWteD10ZsNcYMnJLZcBR/+yyguc3IwbwTQgYT5a32Kbc3RPlaysrvN/1pdhhrANY36yzwQ5H6GNqnlPXDvskBhKwnY5RPjERB58sw2GR5P4XrBETaK8J/EqEJQqwb8c3MlbjIsWqlkLDKfOUGudjEAUtKR4ELGfWi1KCZCSP9+ud0mA/iMooHBMAP3bes7vulbY7Vq4h7sK8anQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMiL2M2tVTNlSsG3mgk1++aOUAoqhGKDkttePCrHfGk=;
 b=mr2ZXv/SUusXDX9VnRY964saJaTJ/ax5lbReDjcCuzrgQ7rqBXo6/2Dho7ds7sFZQTXYSmPilGzpOzCZFxoiLgCNEhJ0YdL22q5RlclRkROKomeWfHL3rOcXXSnsmN83EALt2I7hLb3HR5tw6LV1c9eSRG61sR7JEn+yLbCU2SM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2773.namprd10.prod.outlook.com
 (2603:10b6:a03:8e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Mon, 31 Jan
 2022 14:37:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 14:37:18 +0000
Date:   Mon, 31 Jan 2022 17:36:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>,
        Nguyen Dinh Phi <phind.uet@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        kbuild-all@lists.01.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: make a couple of functions static
Message-ID: <20220131143657.GM1951@kadam>
References: <20220131071006.1764343-1-phind.uet@gmail.com>
 <202201311901.HT4PtVja-lkp@intel.com>
 <Yffe9tO6rRyzod2F@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yffe9tO6rRyzod2F@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 625ed0f7-6696-48f6-ca43-08d9e4c72e7a
X-MS-TrafficTypeDiagnostic: BYAPR10MB2773:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB27731761E5E6C1FA68C96F538E259@BYAPR10MB2773.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 48HJJzLuSYUIQ/IfEoqM79HA/rJcf4xpp1wSN8g70knjjaLw2Rh+sh+W4JLpQKeNCqXW0Zt+/MJ1tVAxjf7Pm4kV+PJcKLb83sC8BYrv28AyaIDVAKP97DCfgQGGL+B+Tq9vu6qXTxBsyDQYiVcgcsFlp3yeWHog+yePHscgzsrYBRzst7NiTnM8VhhiEP0op/VmkEONGUFG4Q8BXJj/7is1PrYfPNZtS5W3v6XOtZu9cxsP/wylYXFhf2dHuWW8n6lts5/zd6AVamyruqQ8IIv0aZerKoVmSr2En0mMJbKUKcBu8jod+CpIHVGEYZDLHNM58A2OGP35k5amZH5reOn9moqiljuBdkugQdj2+3ghPRMn69NAUhxKRpyWK7a8DCGAtv8u5Hl+a8ztm6EuZvqWOVFZ4n/Jw2U4UcjjkKljtYfaroqrj4Jyddb27JBwCE7X3CIkju99wMxvuFMjnuJYVKf22HmC05M/zqisjj0LnLtFGX/eIb9ZggRnqkS+YkjtTQ//C6HL1Oxbz1FqvpfybjAZLshUV25TtXAKGIu432hyowtLJYh7zP6ysz0ZGTIcn4kmnc3yMt8VuWIkcFPUDSZCQZKGAvLO8l6kllDInCK3zKmq+993OvuJASEZyfGkZKm4H1SyWgk1ZlpfAf9kBwTBsdHThcynl4IQH8Q8F7Sx6kDGNqs86LiArp6Vzh7cSeiMUu/XTrCs/VkEAhOrG/eMRbn+0ky0MJL5IOo67ueQPuo3kVBz7ue8gpC55eCnL2TMeDH3fDaME/lGjZud68sD8KrD0s8NfNnk/6Iw45Fzy9QbGwnxynYDL6gS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(66556008)(66946007)(44832011)(110136005)(38350700002)(5660300002)(8676002)(8936002)(4326008)(54906003)(38100700002)(316002)(26005)(186003)(1076003)(33656002)(83380400001)(52116002)(2906002)(6506007)(6512007)(6666004)(966005)(508600001)(6486002)(86362001)(7416002)(33716001)(9686003)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mEVfj99QTD5GjZ3eCy4IuD6j4sQ0ALzVj6VMaxvLKcfEuly9eDLD1IBuLTmI?=
 =?us-ascii?Q?B3CDTR175ac9SGTgfJC+YDvSJaRsNbaESqZy2rHy4RI4/ReGgr7yM48WTHeR?=
 =?us-ascii?Q?3anItU8jw7URZP2fk8ifchPoYmBCCgW71z2uegUJsuldVuSRDfa6YJUVwqsR?=
 =?us-ascii?Q?HC+7HvZbf+smddeChTGT4Yoeg8+idtDgffm0DeGZ0SHTa3ZUxEw5jYddrcGr?=
 =?us-ascii?Q?mkOm/uB0VJOCK+fcjE0xRZhJoxzAQlL8jtxgyr80pkFnBNOHiooWNlgfYWYH?=
 =?us-ascii?Q?SjjKKRkzsPbJneOSNWGaK8zaEkG83B+c3ysy/Vko+4r3r8z79SfPlJoLPxA0?=
 =?us-ascii?Q?q2dwNWPrvo3yhlDTp23/77f2Rj/0ReM9h2n7ooh8vvXfSsoqnMxSpF8Cbl33?=
 =?us-ascii?Q?FZpRcVO28aOYBiumrMEDK0yDohVIJnkQbp0oGn1RkVNn1kCZmzoFRkxr385V?=
 =?us-ascii?Q?ANB5wKRf9eIk7XbhNH47VTVZnANmcas69/hfJdglTytmGG6id8XiwmdEkfTl?=
 =?us-ascii?Q?ocOe+BLIok8YYxwKZ0BtuX+zyKQ22DM5n4KKnDVBlPcr5UMM4ucdJjiEfGEu?=
 =?us-ascii?Q?5S+SVFIo2yoTov5Q9QTfXDmDh/QYRejn6qRMomtmwslpwIJUZ8InsvQUeV1n?=
 =?us-ascii?Q?59O2Hou3RMAOJ9fJ/i1ZD/9O9ULUdnc/xwGMynDMx+SqtpxAv8Ul6aNMvag9?=
 =?us-ascii?Q?XXNo1KKupYlFGQm6Lq7yXv7SgHShJoSrPZgSDFvDTc7KmNloyCPIDAQZZbMI?=
 =?us-ascii?Q?NQWMchDZjBzf6s0aZa5dXotldV53c4ZoRMcijmg37AVKhuvPqtz/qfBy6+yn?=
 =?us-ascii?Q?DWj7WfLVkXmzOK85GFkvUFSReC/c5zoZA75Tv8q9sF11P+m1hjMY5YFv2oC3?=
 =?us-ascii?Q?BSrXpCAqTABbB8MSdNvcP2Y6wKcyZurPrQr/Fl3CoSAgLMFmp6S1wo/HZJGM?=
 =?us-ascii?Q?VjxiR741hs4qYT7U3iWVL9HECtUWo5J4rVSjJLZyHsUJTw9cT6/HRnaUcCYJ?=
 =?us-ascii?Q?RhuQnYEIv6IZ5S1TpbbJJXKLKnHDkHwK2e8JoXDWq+vUwNDi1hH+FkHiJYcU?=
 =?us-ascii?Q?Rl+zdSJt01NWwAwNr3Po37Ewe8AjD9asr8mQKOaL4Q25U0YQytbV1bSPd6QV?=
 =?us-ascii?Q?KLfHJFTsZIG+0f3g3AhbhE9BqEPEnqxJ4rxujREXtRHr6NmVrasOKjhnU3Sy?=
 =?us-ascii?Q?cDlvkKpu6442wecB1P4Ouo5ZmsV3I9a8D+4sCGmNYNzs3s6OJ6lQ2vmiTZPk?=
 =?us-ascii?Q?GKD4n6KNh1AnQ+5BmsLTkxwVwNcFAGUeJtre3j4xHXkOP1hVD2joetCqTQ93?=
 =?us-ascii?Q?WUgGnvYi+XnQtOqLkBRN0XC5XYaVvMRaU3HPRXEN2emfX0t4h+DTfA+fohGW?=
 =?us-ascii?Q?QCQa0v+0mxxpes4S5mCsVCqQbuxRn2R/kNW9tFVzwWE0A1UnrTZye5l1lnrK?=
 =?us-ascii?Q?lXHmK4gnGNDNPHsqoF0TItLrzqj4mwvzuAnE41pSpY/U+idUbuDhk7Sb+ClC?=
 =?us-ascii?Q?9tSfVEc1hYRdGRxzB9wVzVVhjcnaHw+m0F/q3kjQHee+JFI+gbASfhH5q4wM?=
 =?us-ascii?Q?3S5xn7/oUEXNZlIuqsw6yYvmAK7lVdnmb5pvy2bQfKwR6Vvghue/+tH1lZiX?=
 =?us-ascii?Q?K686oXgXZBhMGaLyK6TKPj6ZXZJsMEDGMm0LjMFh2f2QnjaWV73/mitpu1jU?=
 =?us-ascii?Q?agYEGncBDMHHZWYOjJZr2c1Qkqk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625ed0f7-6696-48f6-ca43-08d9e4c72e7a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 14:37:18.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I11SLYOV6sVZ99+HtM7C36l3coW5dnc+V4urMg036Oni3WtgKBuP1YWa1m0o+0Hd0pkKDTpEOzPXd2g3TrB74OHYVQimxp3P+M0lzitppY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2773
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10243 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310097
X-Proofpoint-ORIG-GUID: v31CKWBpEjIVu0JyLIzcc2JlJeVW-Ea-
X-Proofpoint-GUID: v31CKWBpEjIVu0JyLIzcc2JlJeVW-Ea-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 02:07:02PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 31, 2022 at 07:16:01PM +0800, kernel test robot wrote:
> > Hi Nguyen,
> > 
> > Thank you for the patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on staging/staging-testing]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Nguyen-Dinh-Phi/staging-vc04_services-make-a-couple-of-functions-static/20220131-151209
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 64b2d6ffff862c0e7278198b4229e42e1abb3bb1
> > config: arm-randconfig-r002-20220130 (https://download.01.org/0day-ci/archive/20220131/202201311901.HT4PtVja-lkp@intel.com/config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/0day-ci/linux/commit/1b64825a2b5b3312ae309c1714239df049b018ac
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Nguyen-Dinh-Phi/staging-vc04_services-make-a-couple-of-functions-static/20220131-151209
> >         git checkout 1b64825a2b5b3312ae309c1714239df049b018ac
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/staging/vc04_services/
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function 'free_pagelist':
> > >> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:434:25: warning: argument 2 null where non-null expected [-Wnonnull]
> >      434 |                         memcpy((char *)kmap(pages[0]) +
> >          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      435 |                                 pagelist->offset,
> >          |                                 ~~~~~~~~~~~~~~~~~
> >      436 |                                 fragments,
> >          |                                 ~~~~~~~~~~
> >      437 |                                 head_bytes);
> >          |                                 ~~~~~~~~~~~
> >    In file included from include/linux/string.h:20,
> >                     from include/linux/bitmap.h:11,
> >                     from include/linux/cpumask.h:12,
> >                     from include/linux/mm_types_task.h:14,
> >                     from include/linux/mm_types.h:5,
> >                     from include/linux/buildid.h:5,
> >                     from include/linux/module.h:14,
> >                     from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:8:
> >    arch/arm/include/asm/string.h:20:15: note: in a call to function 'memcpy' declared 'nonnull'
> >       20 | extern void * memcpy(void *, const void *, __kernel_size_t);
> >          |               ^~~~~~
> > 
> 
> Oddly, your patch caused these build errors to happen, which implies
> that you did not test-build your patch?
> 
> I remember seeing this before and being confused as to why this type of
> change would cause this error, but it must be for some reason, which
> means we can't take this patch.
> 
> Always test-build your changes before sending them out.
> 

This is an annoying thing.

Unless I'm mistaken, it's a totally nonsense GCC false positive.  In
Smatch, I have a similar NULL dereference check, but I have never felt
confident enough to harrass people with false positives even though mine
are fewer.  (Smatch has *way* better flow analysis than GCC but the
tradeoff is that Smatch is slower.)

I can't understand why this warning triggers on this particular patch.
It has to do with the .config.  A make allmodconfig will not trigger it,
but the kbuild .config does.  Possibly to do with chance and inlining.

regards,
dan carpenter

