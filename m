Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368944B0DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241859AbiBJM4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:56:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbiBJM4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:56:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC27101E;
        Thu, 10 Feb 2022 04:56:25 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21A9o4TS013525;
        Thu, 10 Feb 2022 12:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=20NkRsiSSpwPzBp9xBYIOEjNwm8jI+IoeeAuD+n/Rr4=;
 b=kF6PmIYU3U30seCHaUIPJ1SMOCqarOD1byRSI7kkSQSCx0DS3tTJnf11rwNjxNaC50vS
 8ht2u6U4KjkRDr9sw948c3+mGTAG61l2csFscezY+Xn5U0/KfGYJ4dEP38rm97w035fW
 bSbQCBH9TZuAs0ClKYa4pnBFR4/BiRzRhO4l1rlfFCamIJbHnEG/nesIEx28v2LVcWcc
 RdfwZz90uy/GlNjtZw8JgUbABK69cehThoeHE+Q3fvik7LtNFFwICaGr4HC9oNz8K1Cg
 WH5qSuP0F9GSTYs7zLzjYjO3HDzZ4Au8jFXffeR+3A7DN9yx4ivvmkDRiUkclHzyzvKf +A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345ssvd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 12:55:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ACpumW136171;
        Thu, 10 Feb 2022 12:55:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3030.oracle.com with ESMTP id 3e1ec4vdvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 12:55:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4myHD43EGMXtqpva/e2/6n8x20sphTgV0znU89BPvrjGFaj9C2EVTFowM+XY+gNrnSH4Re9NlDQcwcx7gewxxgI+nZUnkbtogM8AkKnwJiI/xDWHUaJdkWpAhjzvr2mbtuMqd6Jz/8K9qMEg8WA1rhW8x+0eHGa5KtVCvahj7xxyLEY7V4ex/SzSdrZUCLiXr0u/FVU7Q0TPyoMHwV0I7n7if3AkTzhCD00ygC8mmm8nq6F2G6cPNll9jovMfYjVmfaTBksK4F9fFKB7ONYu0MvOqgJsZETe/i3LhLx5dSWenmZCZPV0B8lz7ocd0y3J5ajR9o1KzdatOxvN7Hslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20NkRsiSSpwPzBp9xBYIOEjNwm8jI+IoeeAuD+n/Rr4=;
 b=WEVOUyRd2XeNww0XkdYbWIfy83cM3fdvTW1g2alJovjzEhxpkkulnWgpaMDU6qPENS1bKrhJCqDi4Z/TpFLV0GmI5ShZYZvnTOHf7YVbpWE02QOB0Dd9k8hAgY2sMkNMqMEs/TZ9SAAvYXPz/uQBsIBGGc9rJJRxZeuFYa/kll6nMHz2ieAw1anMacA/mpyUOwnObMrwyKqFWbbwqvsdjkQgPjPOsvpJ+y9NC56avzBd+PGqm7P9dAF97hKqs+5GxYCOEVP+EOiS8/Lf3mst/DZ8FIBARY8EKJ3k8r11u9Gg7hminANFY7dVpC89DMEMLldhHc6yuctQyBPNa6xQEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20NkRsiSSpwPzBp9xBYIOEjNwm8jI+IoeeAuD+n/Rr4=;
 b=mcCkUzpL83ar8uhujQnpbY8FJ3DJoY6Qvl0760rlUg3uPCTabqnK4A/nR2TyH+4/5A2tJPrd3084dagsfDk6gAecm2OPk6WaMK8GfcNY+S1ND6jlGx4X5qmjLQToNGhRhpJYn3OjZWlVSdh5tMmvpziL/XHSqybgsaFaykgA+hE=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by CY4PR1001MB2245.namprd10.prod.outlook.com (2603:10b6:910:44::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 12:55:52 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::a1ca:a394:7333:2aca]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::a1ca:a394:7333:2aca%3]) with mapi id 15.20.4975.014; Thu, 10 Feb 2022
 12:55:52 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, bas@baslab.org,
        tglozar@gmail.com, Ast-x64@protonmail.com, viktor.malik@gmail.com,
        Daniel Xu <dxu@dxuuu.xyz>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eugene Loh <eugene.loh@oracle.com>,
        Kris Van Hees <kris.van.hees@oracle.com>
Subject: Re: [PATCH v8 2/6] kbuild: add modules_thick.builtin
References: <20220208184309.148192-1-nick.alcock@oracle.com>
        <20220208184309.148192-3-nick.alcock@oracle.com>
        <CAK7LNAToG8ozUcMcro4osBKPiisqW4mpo+=uBeMUmVfztnNMDA@mail.gmail.com>
Emacs:  ballast for RAM.
Date:   Thu, 10 Feb 2022 12:55:43 +0000
In-Reply-To: <CAK7LNAToG8ozUcMcro4osBKPiisqW4mpo+=uBeMUmVfztnNMDA@mail.gmail.com>
        (Masahiro Yamada's message of "Thu, 10 Feb 2022 09:35:45 +0900")
Message-ID: <8735kqswxc.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0238.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::34) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9a084c2-5bf2-469a-fef3-08d9ec94aafe
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2245:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB224594CB1B62B6EE7D70E8968B2F9@CY4PR1001MB2245.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0sjwU2YVXgkMs4AHefKzyHioz7sHcS1ymnAkfRrrS9efNMe2z1rbezvBY+bZs1UaXF5sHAR3qt6lfuzEvR1uBNNK+zZHvpWw8AwTTIwZZ2H4AbiEeoBPtlFcxx/COZDZmbNl93ioJAxY1AdOEYx0iN8IgewuzLigtusMc9nIdlZcamqpRaglXNfVavC2zkidRxcxkSTkvrF7/L2TM/MaoFP46c7ljX3525MarMStSpUdEyfDgJ/HhckDuNqJhPdGtGyBOQEIh8BRc3DI6Vktvcuqky09jvb1deEU2y5D7kSG+2csMP5A66oR6HEIEoOOOt2Io3zeTvhY0JOdqP82fjdsiX4pXbFpQ/n3muKrQ9BnLwUbbIGrdgTNRK+21Ug4nrvbVO+HetlXNFKjBw3yMciT1cDRs+SpsB8fE662KWsKrbLqgbJwXCe87KiszOCpDGCvVpjAArSqHPl1u8U+v7IzyGgMd2Vq6g7Pqzl9MjeGHK3M43KX2SXc1AvNnP/QY8U5JLmInSy26plHeEPCmtFnErS6Ktc5LoLsHowusmxKB9VZvDOFtZkJiD8P4N9DqQ3Z1O8r8NxVGlOQZPKNIaAs+Wnl7dUoRgR0kPEZN0cx0h+tTPzhY15RiPn229TXWLtq7f3VgneHPk8SGYiMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(107886003)(7416002)(83380400001)(2906002)(8676002)(6506007)(38100700002)(4326008)(66476007)(36756003)(8936002)(316002)(6666004)(6486002)(508600001)(6512007)(6916009)(5660300002)(9686003)(66946007)(52116002)(44832011)(53546011)(86362001)(54906003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EYjXTKk/hcZiIpvp3ZnoZvjiJ2FYdy18x9KUrr0VXB0hGyBUV8KbfbFdFlQg?=
 =?us-ascii?Q?b6p8OWCgiftVmhe7VxjxGaX7iNeo6QofLqlrhFF8KUED8Y6ufZl/sc2FawHb?=
 =?us-ascii?Q?azLTaYE6CbrBJ1DySHK/Myhg+Z7sVbyCMGKzUFF5vw0R8A/RT157oeOQrOyr?=
 =?us-ascii?Q?CJDP/rqrjUjycv7a6uNDwn7OEia1Agx07ovLOqkrXQX6cWggePJQTxkx0T7q?=
 =?us-ascii?Q?LSIVkkIawN/QLrzQJjYeT5mLHSVG4MyetnRFBM0SzOw+BgPQJhG3nQzmm4+G?=
 =?us-ascii?Q?/+sZnd3Nb6bYW/Ek9TjQeAbYbmz2rj4RzMfPWYuSMYgX5JHqDR+OdL4N86PX?=
 =?us-ascii?Q?csk/omsPc/9IySj9PU3jeYK8MhwHH/z5Zb+gv1vJWahsDp61NvIYbfeu8Xfi?=
 =?us-ascii?Q?pyNLKssrOWFIZXITBsyxawiqrjJIgnVzYlIE0IuOVf3Bv+WaQtu4lhxcLuFE?=
 =?us-ascii?Q?zUGsGtiWEfkDg8OiZJPPCH3r5Eu04WFkx3j+3RNmu4oEw1cKiobmtjrD0RFF?=
 =?us-ascii?Q?UqPDoDGIaOyldfVS9MHCpvYJTvqGirf+iUnNMTtdz+14DK1PJhSFxL0WTGOT?=
 =?us-ascii?Q?haRPCnS92xo2sPzDJtsYZEE+reaYSOqJRRt76100RYaOYnertt+oOU8HzAsk?=
 =?us-ascii?Q?Gy4xJfZx25HA+Vt7InnqztkByxlrdInCm5+rDxnBhAiMZH1FmZPXfmYk27Wh?=
 =?us-ascii?Q?Z1P991ULBFTw66yDj2TX7JIv43tnazNZVNaASJu4L5nNXEjCqiYjrjeOI+Kg?=
 =?us-ascii?Q?F+3s/A3Xgz7jDzM1oCX+HRdrCZLDIaeLQoTw+bC+nMBbEtgljEetV/7LjILn?=
 =?us-ascii?Q?6vDmN8tYDfKAWyNw+59oX28EVMScsQmMZ63tQgnX33LpGn1VcwLTNztmDhCI?=
 =?us-ascii?Q?cASVot+QJbgFWD/WTdty+Ed4bVv1CAEwsPEdgneNl4YKBw0s4sFMXPbL3cKN?=
 =?us-ascii?Q?/XIqAYgKxGw49kJeI+eLL5P2s4PDKvcyHVMCz0u1QBPd54vv9bQc2Ivqkwp7?=
 =?us-ascii?Q?IzuUg/1Yd9VfViQvuGCx33ml3+8sz1fjX2oxZ9TSoRyqj6qkrwf/VXjXaMoL?=
 =?us-ascii?Q?kI8KNtyrMW9bj0sUBfsFrBZYv0zgqevJ/FhfjYA8W105c4Fxjx6nnzJ4+1Ag?=
 =?us-ascii?Q?fXMuMthQ5v70+zvBrndkINJRFMuBHQvkwGT6QIMRKYdKhJyVpegiuFIQtzYI?=
 =?us-ascii?Q?C/EKSHUjb5AwQgsVhNs52Iise3x48syZqR8tmF+FiGmibOo60ZKQ+YEIMbAl?=
 =?us-ascii?Q?+p9gzusPk0O7zyOFWUboFy4pwF3wFhNs53sm1jmu28mtVP9ZECfwWi/gZmil?=
 =?us-ascii?Q?TtqaLqtS0y+G1MgAPWnXH/TjpGn09e6ooA9Olz3ZX7GQfCkASQeg2ojsnQG5?=
 =?us-ascii?Q?MS0jnA68Tsk1H6hMfIgU5esowdrQB3fA3CMTK5GAlIcOaBCKA15qD2N7Ie4B?=
 =?us-ascii?Q?TgPQHS+179aGzxudotKpYkRqJ6NiQq2Q0rST2GTtJptn5q1sHMalMgXiPC3v?=
 =?us-ascii?Q?stZkJhcCx55leXK/YBLZQGllKAJ/XzJwb+GNIOyRHtqEvbUQuonN/LxepxPw?=
 =?us-ascii?Q?7crfOkfs4y7RRWeSme2Trafb+5H9eJ7MC5N+6ZZDOy7023JgJYi8CPBpt8oc?=
 =?us-ascii?Q?0OvCKI5F7EQbo5tQJ/VeCbq9Bk9Pzq+6D1qNbqqEgZrT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a084c2-5bf2-469a-fef3-08d9ec94aafe
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 12:55:51.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AzIGKZXCPbwB6cnuqkzAmzslg50WBR70PHrr1xmhvNA2qEdXYQjm50VnM3QOI0VCNwps4UWShdN0M+pO5RlJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2245
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100070
X-Proofpoint-GUID: 0GvNy3sxaHOQsS0pNb_CyM5oVVCMlSk_
X-Proofpoint-ORIG-GUID: 0GvNy3sxaHOQsS0pNb_CyM5oVVCMlSk_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Feb 2022, Masahiro Yamada told this:

> On Wed, Feb 9, 2022 at 3:44 AM Nick Alcock <nick.alcock@oracle.com> wrote:
>>
>> I am not wedded to the approach used to construct this file, but I don't
>> see any other way to do it despite spending a week or so trying to tie
>> it into Kbuild without using a separate Makefile.modbuiltin: unlike the
>> names of builtin modules (which are also recorded in the source files
>> themseves via MODULE_*() macros) the mapping from object file name to
>> built-in module name is not recorded anywhere but in the makefiles
>> themselves, so we have to at least reparse them with something to
>> indicate the builtin-ness of each module (i.e., tristate.conf) if we are
>> to figure out which modules are built-in and which are not.
>>
>> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
>> Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
>
> modules.builtin was initially implemented in a terrible way,
> hence I cleaned up the code and removed the double recursion
> of the source tree.

That's why I said I was not wedded to this approach, and I'd be happy
to use another one.

I tried to reimplement it using a single recursion, but it seems to be
impossible or at least very difficult, since you have to somehow
interpret each target in the tree in two ways ("build this" versus
"figure out whether this is built-in or not): if you can think up a
trick, I'll give it a try. I tried to make the core Kbuild makefiles
interpret obj-Y suitably, which might mean you could build the whole
tree with tristate.conf in force as it is in Makefile.modbuiltin, but
got lost in the tangle: and in any case doing that seemed far more
invasive and far more likely to be rejected than just bringing back
Makefile.modbuiltin.

But for now, to me, this seems tolerable. The time costs of building
modules_thick.builtin are so minimal I cannot determine them in a normal
parallel build, well down in the noise, unless your machine is so short
of memory that it can't even cache the directory tree walk (and with the
cache hot, even with -j 1 building it takes only half a second). The
maintenance costs appear to be basically zero as well: one file, not
tightly coupled to the rest (the only coupling it has is the same
coupling as every makefile in the build tree). Also one file that was
present for decades already :)

So... honestly, I don't see your objection. What's terrible about
scripts/Makefile.modbuiltin? If it's so terrible, do you have an
alternative way to do what it does in this patch series?

> Honestly, I do not want to see you bringing back
> all the bloat.

It's come back because I find it necessary for the series which follows,
which surely makes it not bloat. If you can think of another approach
that can similarly figure out which modules are built in and which are
not, I'd be happy to use it, but I can't think of one.
