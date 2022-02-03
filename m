Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8524A85E5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351029AbiBCOMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:12:15 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59730 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233643AbiBCOMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:12:13 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213DdOvR029955;
        Thu, 3 Feb 2022 14:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=/MCHGybeEVk/dadn5NjnTXhtl0wjeOYQxIL0lbuFsm4=;
 b=DISWT/2KRq6j64rrjGuU8V+HFxaYQFeF9r3+01a2HrHaouoeiL7PW3BZdIwg3wmU2kgI
 NiEEg/ax9diI3u5KxR73r5NZddqSl8tCx6RCzN0kxEXLxvj5OmCKIymiDrvRWnMc/J7c
 QV7Bmvwh2CMGdFKfOanWjMRwvtViHPJ4myBVo+BKRmkVagJptsi1lJxDP4VZo8Y1b+l4
 uZ+zOhwpe8DhbMx6fXzyU4yvCf+todyGWAzpeBI/6oI82UOZpp5aATdIkAuiZj59x6N7
 3K4eZe92pgGl0gko/2f5bxCfA+jcVeK/q8r7iRcmgcyx9IrbSg4Z+vuqsMPj7HpHM/jI nQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2s10h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 14:11:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213EADli010250;
        Thu, 3 Feb 2022 14:11:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by userp3020.oracle.com with ESMTP id 3dvy1uyxn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 14:11:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFtWNakttZTgudp5mUmOcQN0o/y3SegCXUAGJTAF//6UiE/5i2e9vqGQxG01GrgYcPy32TCYgid2vtB7Jmcvwa/EtbtXyZ4f4rgJv7fRYO0S1ZjqirE0pPwwU8KaoYOeooXqrn34gtcary0tzQ+u93W184nur3wohyRWxINZ/a9QTfmi1QsDXc+zE/bDks048Zud7ZmwBYvwclHN5hnGJ6tkVVJcWg+lIPAqophOrpR1J6rcp5363nuAzpnX/13igiuNH7YDr8bejJq/cV2mkVEqP2NxC8VZ9wzWJoHNhSakPU3Gy0oAFvvl0phjGg+5quTz1wjY5DSyYFEnvTjozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MCHGybeEVk/dadn5NjnTXhtl0wjeOYQxIL0lbuFsm4=;
 b=PwtgeyVjmOnDLWaWfZ4VTjLNFQiKRDFwvT6JP7QInGqXTG7DgbeyBwsxb6k5qXoZeGmOiEjIP29coMfyQNdM33odac9E2VsQ0jOIhMIqTFigbO+TfCentvZudaRox8C073kYJBYbaG3OeeuHi4J514lrsbp/mGyYZ94qmmZZdNvdxIS5t58Iww/6GVRdTh5n+we3jpFkGvuXE0LRtaLa/g6PX+QQL+EGFlLMqJv3IKX2+erzaEFEazlrXwZGXVpJMwBOhQKY3e2u+7lExwprLnvnFLrfVm+R+GirN0TGB+Ofb41yQMQfmATOoQSvi1Q8kgEAFf/aZVFen6pq02PS2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MCHGybeEVk/dadn5NjnTXhtl0wjeOYQxIL0lbuFsm4=;
 b=RBlA4aYiy3HpDwG0Ph7DZ2rxRvAQhILmvQDa2uCwwLbG2tXUxPGhyH2TcoN6nAkYgp5M7jtEVVQIqdwZbPXl7dLLtsvIvhdp0xoSKe9C4aVjPmcP2GgAqxHCS0xU8EuDbeGPvR9oTlINL3C8y/7drJEZe8XGEt82p/xrPLxNqAw=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by CH2PR10MB3941.namprd10.prod.outlook.com (2603:10b6:610:4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Thu, 3 Feb
 2022 14:11:49 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::644e:5828:a72c:c1de]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::644e:5828:a72c:c1de%3]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 14:11:49 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        bas smit <bas@baslab.org>,
        =?utf-8?B?VG9tw6E=?= =?utf-8?B?xaE=?= Glozar 
        <tglozar@gmail.com>, Ast-x64 <Ast-x64@protonmail.com>,
        Viktor Malik <viktor.malik@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, jeyu@kernel.org,
        masahiroy@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PING PATCH v7] kallsyms: new /proc/kallmodsyms with builtin
 modules
References: <20211216201919.234994-1-nick.alcock@oracle.com>
        <Yd8CDJA0dy0VaXrB@bombadil.infradead.org>
        <878rvk7uv2.fsf@esperi.org.uk>
        <Yfn145FyE3PDBEad@bombadil.infradead.org>
        <20220202181047.frwirxdpufwzkbv3@kashmir.localdomain>
Emacs:  because editing your files should be a traumatic experience.
Date:   Thu, 03 Feb 2022 14:11:41 +0000
In-Reply-To: <20220202181047.frwirxdpufwzkbv3@kashmir.localdomain> (Daniel
        Xu's message of "Wed, 2 Feb 2022 10:10:47 -0800")
Message-ID: <87v8xwrqea.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0233.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::22) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1824c630-ef35-4473-bc90-08d9e71f1e6c
X-MS-TrafficTypeDiagnostic: CH2PR10MB3941:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB3941F9F1C40829C005336D4F8B289@CH2PR10MB3941.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xt5Z5914Py748V9hUdWStX5FMtTb2R+2ze+mdtuN9UbV3PsP1mK5OAru8Z10EjzggCwXmwB1T3b4MWnPAoaLWozfWbiyKXZF6siJJEGB8uWX5RYdKMmsTtUaNDg/jp1K3Ka555049v5fKs3XTF6hawP1l0irMfwgHMeo7ckmVyh+Pd6S1HrWfpiPvwYOu06LiBAb3qMjAPlcg4EppJlgs6am8BSQDhb97xJLjyW4TPq/gZwVLUiorrTC/aM3mpVKZG15WBaL23Ycauo4yFx0kKsM4gZTtaudYjddo8w3b84W+u06y0yeyy0Ueiv92FvGQn//Y8h1Z86C7VSRvw3ajt19XTqduXPMxiAC5KHoto7moyS1yi25VSs0XPIvTw2sPDWLXJ8Hh8ZzOJnMqhp3Vb0wPgfhLTisePLgiTQ5R6cCKv9AqPSyrClaVG0oNDge9SwIqk9oQjNZVvkgGfW0ZZKqaukNjmAkvEtw8yU0jkK3CL9EY7u16fQ1IwLYNaXtPyPNXOOZDbqSlvJlSkEeQjgdNvMMz1XIKQoNWxCs7iSY++4G5BOXI5ttsfr8GuSTujstEZ75L0KaLx6PP0QXbbsuTbp8YRSekIEher4ncnNOpKSJht98mAtIuiZxuWt5Xs+cnEQFHRd8DDlta8+bSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(44832011)(107886003)(2906002)(83380400001)(6506007)(36756003)(66556008)(86362001)(52116002)(6916009)(38100700002)(66946007)(54906003)(6486002)(4326008)(66476007)(8676002)(8936002)(7416002)(6512007)(6666004)(9686003)(508600001)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jGPyNVcrGb/bFz3UmZwB53w36Z3Vj7NNSaLeio1sHcl5oReE56wnw54B45MA?=
 =?us-ascii?Q?nA9mI6rWzHWzwWz/GEMuUzS7KqZDhW6FEp1PvYzTLLyZj6GG1eFrWORqSx8M?=
 =?us-ascii?Q?oFRkWhmUONwpZGew/CR5sB+I4nNNVhnGwGddY1RuGH1g1LNA08vxGzEmwOh1?=
 =?us-ascii?Q?N0ezrHuAgz0dmwRFToc13eqO8LfGR16ngeoNPZnrGA7pF0eKTPBRLVffC487?=
 =?us-ascii?Q?iKK09UDYe0Irudn7FnzSGUr9PPxS3YNwjSXoZlXQdIIIjRpPVpziPPbCyH/r?=
 =?us-ascii?Q?XLkhhSpzWiCHR81YblEDxIZfpfQ/iTMxbHbfYFaf5smEyJHM3ybfd3frvzwJ?=
 =?us-ascii?Q?T5Rjbp7rsZfkELl/uLnx0Hv42XQGBkbmBN4JuC41BigdJF5xs6JDy6EOa4uw?=
 =?us-ascii?Q?ImMIjQ9+1BBrgqlVOPV5beM1tLffnBw0DX0ctnf6hcox0OQs65a2F2PZCiW9?=
 =?us-ascii?Q?i3cAfJpfUhYM0EcM+yz7ICwFTWTgFf2/KxQKy064nJbfRApb1pkFZEkBqFQh?=
 =?us-ascii?Q?QHO+tLfHRJDO1pVJF8nj88JraYA4shULxyzSYlTL+YWYF7flZJ+JYs+8KGJD?=
 =?us-ascii?Q?b0E+2bWAKOndD2V/OICuiBjEVRMRBo5w9gqImjNEl7dEDLDHio0cm5rpMQL7?=
 =?us-ascii?Q?gCYTzLaxnGsxTlhdmQapdAgarbLlRxoLP/jeQQuhaTtejd1GdZCkD23//eC7?=
 =?us-ascii?Q?3Vyn0LHe2dBWD606JFa+K8EswiaEZ9wRQGZeCM9jEHHZ3zs9JCWkL7Hj7WYN?=
 =?us-ascii?Q?zpqq3YMMny18qPhFZW7dq5S3APxRb3QQoAsVLHiJiQSGyFIywGfOcDRgsueg?=
 =?us-ascii?Q?9huzw8S3n+mVeqASFn5qG63y9szozzqhBOst0malL2VCV8kSYhsxNQAM4iAX?=
 =?us-ascii?Q?B/HCOM8GRc24HYoJRdlpB46UCMDKCtL8cNWyCrIDUNKyaf/hHOJ05V1AD8Bv?=
 =?us-ascii?Q?u6RM0+cxvEwcsEI3Ck4vV65eHSFCsAPICgukIrUyxpOfWx9hcI3/u/x67cOL?=
 =?us-ascii?Q?I7MCz2O2gx6nao5l2eQ+gsRR/X8ZCxHbM9LIkTx7MQ+7EMtnk2cssjLsWFG1?=
 =?us-ascii?Q?OL4EVgIFnOFNXaRZe9SQatdEfhvFvIh/VvkPXJfr2Xn4PyS5O76E4RfvVTz0?=
 =?us-ascii?Q?VJjQ5bGkRadHDm88fWdkX6yxqHHFKdHekIvL1D/hJ5Zzw1UdV3VElTqyVBDg?=
 =?us-ascii?Q?6LuvKQ/rgO8oZtkNe3AEeeZXUgtKReg9Y7o477v8EM9XrnkLjCWrE9YDztEg?=
 =?us-ascii?Q?98Cu5cQKuxOkczp3y+CD9rWGaXFp01doYvIfoTXLmY0jYNbNmNWDzRSlcCOj?=
 =?us-ascii?Q?cNzu17wGL+99M8Bn2pxyPUP40AucA8eVlTMR3Bc9ZEfE2NZJ+sF3B9IiPFXz?=
 =?us-ascii?Q?b2cvyZOYs8jYodktXvzwXXcTjjUxGZAvd87QaUF7wNrDcGNMF9Ya9akbiFDS?=
 =?us-ascii?Q?/IGd2N7keEjVYEZd13ak8B/8gvQKgaNDda4IyxPxbZPmkjuejjugs/76AxMz?=
 =?us-ascii?Q?DKfITTlFfGbkNsRbxNbYxQtq/7b9x1uXC+JWFLBoCm3CwfihdEXTN61GuqRE?=
 =?us-ascii?Q?lC2cGIPrK6MREnZ3VVqMP2NJepfC3huZxH61IjyP1tbVCopTHA74cRvSDGNi?=
 =?us-ascii?Q?m8DH0vfLSLQ9dKToXORRfoh5xpR5f8QZicAcJiTJH61W?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1824c630-ef35-4473-bc90-08d9e71f1e6c
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 14:11:49.3049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiXWASlQb7E1LbYUjpp+AdjgWszmoEGSvtuivassW9XRJCM/cWXvTOJSwl1olC3a9iSQMSYkG/B62PAmQ3wMJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3941
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=895 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202030089
X-Proofpoint-GUID: UGQhI-8RgtB_dRBOmTOVRiRqPxDoDq5_
X-Proofpoint-ORIG-GUID: UGQhI-8RgtB_dRBOmTOVRiRqPxDoDq5_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Feb 2022, Daniel Xu told this:
> I took a quick look at the v7 cover letter (I'll take a look at
> discussion from previous versions later if I get time) and it's not
> immediately obvious to me why a stable mapping is beneficial.

(FYI: I'm updating these patches for 5.17-rc2 right now, and will be
mailing them out once I've given them a spin. There are a couple of
bugfixes too.)

> Nick, could you elaborate why it's beneficial for dtrace to have a
> stable mapping?

Simply because when a symbol appears in both module names and the core
kernel, users can able to specify which symbol they mean via the
module`symbol syntax (the core kernel is of course called vmlinux`).
There are thousands of duplicates, so this can and does come up.

DTrace goes to some lengths to make D scripts portable not just across
.config's but across kernel releases (the whole translator mechanism
exists to translate kernel data structures into a release-independent
and as far as possible operating-system-independent form): it would be
rather silly if we could handle task_struct changing (which we can) but
not handle someone taking ext4.ko and changing .config so that it was
built in without having to review all their D scripts for references to
ext4. It would be even sillier if they suddenly found that a symbol
they were referencing in D scripts when ext4 was built as a module was
suddenly un-referenceable when it was built-in because there are already
symbols with that name in other built-in modules: in /proc/kallsyms you
can't tell such symbols apart: they differ only by address, while in
/proc/kallmodsyms you can at least tell that they came from different
modules when they were built into the core kernel.

(In fact this isn't even going far enough: in the long term, I'd like to
arrange to have *no duplicates at all* in /proc/kallmodsyms, but that
would mean that clashing symbols in different TUs in the same module
would need some sort of per-translation-unit markup, and I'm not sure
what syntax to use for that yet. It would be very cheap if we used the
same approach we're using here, literally one copy of each TU name and
one pointer for each.)

> For what it's worth, bpftrace uses /proc/kallsyms rather rarely.
> bpftrace relies on perf_event_open()'s config1 parameter to resolve
> kernel symbol name to address for kprobe attachment. /proc/kallsyms is
> mostly used to resolve kaddr() calls in bpftrace scripts.
>
> Kernel symbol size information would be useful, though. bpftrace
> currently uses the vmlinux ELF to acquire that information.

Yeah, that's a perfectly reasonable place to get that from. I'll have to
see if we can do the same thing, since courtesy of /proc/kall(mod)syms
we have access to the symbol index. This would obviate the symbol size
patch in this series, which is the only one with a nontrivial space cost
and the only one I'm unhappy with (it needs 4 bytes/symbol rather than a
few bytes per translation unit full of symbols).

I don't see any way to get the kallmodsyms per-builtin-module thing the
same way (also, it seems to me it would be much less convenient than
having it available directly in /proc almost for free).

-- 
NULL && (void)
