Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6904646C31F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbhLGSxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:53:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:43376 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240718AbhLGSxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:53:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="301043043"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="301043043"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 10:50:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="479627198"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 07 Dec 2021 10:50:04 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 10:50:04 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 10:50:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 7 Dec 2021 10:50:04 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 7 Dec 2021 10:50:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gc0mDVvdPMU4Od6HUdJ7fBknmvFiBSfZmZWfhmp6yr1sYiyQ5dL6yGSM7nOAFod00eLxhIDEZVA+PhzL9aCKriTjYONZVq94gT0EaEJBHFqNGuhfBVagJme5IFyUJVEq2GgTm1+QR75z/iR7a58ej4LczafMyuF0l27OI4A67kl2NvQh5daanM3ab8pkUb/BHO3H2YgOSlVmDm5v3wfVxmUhuDPPxUf6zkL+GAbkUv5DbQqcwQ9HyoeLn3zx/IKJ0r1GlfnoJC+oc1GiedEWQlQqwIP7dW6e6s0crs+3+8ijJoLg+YIF7QKzcDxLyVifPbQ5UllKgOJWtiHPnjsSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo9wEhRl0GhMwfk7bnH3I/gtBohVtxOaAsUWkzbkmOY=;
 b=oRTma42IFOpnPq4nrV/oQ2pj1UywHjBgD5CSisPz9f+C7kDs1bu9Xay3GArWggKtfjIRz5jXWWP4jVAkzJ7eqDkVEsawFwoPJWXGkRHbY6pYyfALu9tOmy/R8TmUWndq9djEef5Wy7k7zqVgGNEQbDU7BB+lYZ7qWmISTaCITJ0zqKVZTewEvF1GKOcrRwoqw4gXcrS482AtY3+9zNix+Y4n5XsWed2RuTNzvNVGnCMBCUO/WGeMJojfX3SkLaTW2bGbkw9y/Hh2kS0aHrrmuU8hBcO2gLWuo4K3C0M8xjLe9JWuSE9jd37WLooTNRWYPyU1R51AKseByvJPBvnDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo9wEhRl0GhMwfk7bnH3I/gtBohVtxOaAsUWkzbkmOY=;
 b=H3KwHWZ3UAEllNQz+eKU+oXMf57QWyLwrjdAZKnWuaH8cexWS1H62dXrJOPePM4gbqMp8bXwlfhqg/M/qEvKHtsYElzSdD4EgUhWetwvPZ/hyfagAlgUMJeJNf9z4pFMk5Ys8PWtQJfVjyNUPVZOim9QAjBNG1HR9SRaHsk7C/o=
Received: from CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 by MWHPR11MB1440.namprd11.prod.outlook.com (2603:10b6:301:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Tue, 7 Dec
 2021 18:49:59 +0000
Received: from CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::c01c:cb8:96a4:e135]) by CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::c01c:cb8:96a4:e135%9]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 18:49:59 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "Sang, Oliver" <oliver.sang@intel.com>,
        Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [x86/signal]  3aac3ebea0:  will-it-scale.per_thread_ops -11.9%
 regression
Thread-Topic: [x86/signal]  3aac3ebea0:  will-it-scale.per_thread_ops -11.9%
 regression
Thread-Index: AQHX6wjSQCOD0XfrOkWXZZ4ZMWo0/6wnCWQAgABXAQA=
Date:   Tue, 7 Dec 2021 18:49:59 +0000
Message-ID: <81783AEA-1313-4353-837D-8217DEF3B9A2@intel.com>
References: <20211207012128.GA16074@xsang-OptiPlex-9020> <87bl1s357p.ffs@tglx>
In-Reply-To: <87bl1s357p.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccc1257c-af7e-48f0-3c12-08d9b9b25eb3
x-ms-traffictypediagnostic: MWHPR11MB1440:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB1440B4910E2816D33D3C7F3BD86E9@MWHPR11MB1440.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aa+8v391oMgDZjCSz231K26xMt70/HoZvpUjmDVXdwcID878cQdf8WnMXgYaduXw/Wra6dGi7lpFUHfuZJpmAWT9JEl+2LzB6I6YfznIawI2AGcvhGuIBjCTUgBWdErP7k6yWMTzgI0nSSpYR1TWq4ud8RiDYOqNkKcQuRAsYbI36MSRzKEo4sNYH3jbSrlgQ2oyGAyiJ3F7G3xx+/k5jvEoKbOQpBs5T7lTgZmyr8xpZumUALDm/DlqgKoq25EkMObgps7mw0/mFT39TDvApoR/7I8ZHtm0SdGEUFL5LXSNd9GKnRoCqOnTKPt9o/2c85RImQKXAOG5x5DSa300dt+BrmG7UgUC4vyKU5my46kK2iWERlLWDHcVV8b0bJSnGW+XRMcL/NmOUjG5cCJzMbmG9Q4MOFL4lWIAjpzaGOg4spzXIJcN4mojkV6k6yOAq2eUryHa1JCNmlTMXS2u12QpeBs3DAfxfK6gNC9vmgmSWVBXfh5q+6RabQjeNmuU+Q1qOwyiah4C9KlCP3P5g4aSDOKkeI6B/keR852rA5Wo1T6MEWQU2HTbIudKu+D+nfcgN0VZ5jSi63Ub8+0NRm+YrGsGuUjgKWMCM1trjBCP5Hntb/PziIrrASKE7tmK03QjbZCDd6W1Y5KWFERv/GmLmqSbJA/E5IqnbI3SA13L/kSwo8KXMzJIbj2HV6JkJ5S8mPYOQexRyxaen9oc8RrLeUB8iP2vNOIJshqfuvDBFdj7GuPcd3QuTmLDmK3breyOE2HGc0Rn9Bd5Xn8eQcxmfx5FY0fK5SG9SWFWl1b9hrOnQ0Z1twU26HUzFF/9TNxej0AJpXPL/fLsET5X0FX3bFykbCTNk4BKeEo15yO+hyd86iTGSfNn8bOn3bA7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4849.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(122000001)(66476007)(54906003)(38100700002)(66446008)(64756008)(66556008)(76116006)(91956017)(8936002)(66946007)(71200400001)(33656002)(2906002)(6916009)(36756003)(82960400001)(2616005)(5660300002)(38070700005)(83380400001)(6486002)(8676002)(4744005)(186003)(4326008)(508600001)(316002)(26005)(53546011)(6512007)(6506007)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ozHA9vfrzLgEbw97stfyFihvke64IMsCtCS6qEWm6Lkfdxu4sk5xzuDThBSk?=
 =?us-ascii?Q?XojKVfkAQyubIA2GLIKzVj7ySFEnrxAI5lScGMjwoQ7fL7IKu/wJ7Tvk4SMj?=
 =?us-ascii?Q?idk8eFAJ9R/rwFQ/pon/c/mjW6VEGRX5mrsptG3SXyHSiyxVk7gklcU4uaiN?=
 =?us-ascii?Q?LQlK/88C2nFBOySLuuXxAER1W0Hb/O9Fi9DFkMtJcE0wCQFykBIbgr1oYuUz?=
 =?us-ascii?Q?Y089xks+n3cex2d02egwGfGemSQUZbVHAi4FDWUWand78GEGUQeK/n4OB81P?=
 =?us-ascii?Q?x6729D8U46jR10SUohbMoSxKfnAqUQDdBQXZA1w3HfyAMUCwKTU0LvSPlAJ+?=
 =?us-ascii?Q?nlr5fo4ptS4FAKWFt7l2IJFC7h0ToZftKw1cBmsZLeHxJMpCkAro9gIhT6SF?=
 =?us-ascii?Q?HDTEluzjurEDAPa/iSh1Y+Dz2Vk961fKNbUYXg9FmlelyoZYkOOh+QZPxb38?=
 =?us-ascii?Q?WnQiGSj3NjwyGR24gWFXFIII3QHOAoBPoUolgUDWyP5zLCzRm5G/GtlhGHdc?=
 =?us-ascii?Q?S4H+Kc30B7lVB/UuTDA3iqyR49Y5A3fHQVI49mvT7UWMaf2leSkVEaddiB4O?=
 =?us-ascii?Q?NwOjUIxdxLBEua861hwONHrj33h/E/xT+dfiffGHKZUwgw0PftmnmOeMoDaX?=
 =?us-ascii?Q?SctZLm6SYR3bzIvY/saZqMfSI2fARJWgFZjE3U4dklknVgZaua60Ll+YXDG1?=
 =?us-ascii?Q?HOga+EZo7n4++bBq08Cc+NUqCYpqgSsrz3BOAgK+BDt8gZEMuSub9sPYgsxS?=
 =?us-ascii?Q?7v7mKj2KVqTVAA9Mb80jHLrh7m4rjaGYytxVz8+4jA0gSLc4OBo9d3tio+5t?=
 =?us-ascii?Q?vUr5OoF0v3o32TkGgb4QSSfxxQ14s8ElyRvct2oU78Te0LA8hHR4mq7W1qmx?=
 =?us-ascii?Q?Bhnm3cOkmQEDZBqS+lQphRk0qBO6A9qz+l2PgovfaHVIuTBr+QNcLiYIgwKL?=
 =?us-ascii?Q?nSfOtY1hImlEL6hyVbL3kZXng1g3ujbSyx/gfGxnMtYfP9cUMddbAubgKHzG?=
 =?us-ascii?Q?5ZinzmwJ1I8sGBFQL35fGQmiQ33g2vyow/9yQcly4BbPDQQhiTeHAKMFgg65?=
 =?us-ascii?Q?2FrwDhzj4pQtmSo5Mp2oZolLhZ8AADXnAztX0doJJfPA6JUvTdiu/WU+/RIb?=
 =?us-ascii?Q?TsqOG1H4tf9tpZQyLxORqmNjOh1Rl7PvqnfaC7p1RGqNKORBEa2XEVG6P86i?=
 =?us-ascii?Q?DCKEl45Ckt/inuWuCYLVyF0uIVwMvBuv8c6vo9MEt8feaDAntnyy0DTzl7da?=
 =?us-ascii?Q?PY/GUIHNWdN1K55fsKxzDsDSltKWPUzG8UsBO+JF/eEqcfgcQPoMcMrJ+BDT?=
 =?us-ascii?Q?mmBBvIpamCJm115CYbVN4Ac7jA4BpGZd9mkyHFmPoTM+gTr9bvOimuslwFLq?=
 =?us-ascii?Q?MkPaqVcTPBHQSHrWimGHsxMJystIxg/892aCthvpKclcuCkneZrOJT4WTPXG?=
 =?us-ascii?Q?R04FtNdgP/mWPe/QwALpj6JgsgIO1VPPk8IvgLC3GYsEKQFWdJT1j6wOtIZ3?=
 =?us-ascii?Q?VlF33M05gSd5C2coAsWMMrhg6NYl5mVzdxH/2LMVwdbN2qG+yMLs+AUUZpSb?=
 =?us-ascii?Q?js/FmtZjB2BU5sfXmzr1Hb+Vr/rkZL0+9+IwiwgXLxXASckBWzliBnZOsz3m?=
 =?us-ascii?Q?f4VlUhU4H4/4XVDYEZTAcQufUBegdWeJVzqtncDx/okJ62S/Tdhnw7sJytkh?=
 =?us-ascii?Q?A9eyx0BZyTrKC/BPvkmH6Lh3qic=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <69AE2623D6EB09478537C18C89C87979@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4849.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc1257c-af7e-48f0-3c12-08d9b9b25eb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 18:49:59.3180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BY2Vu625XCGiTjLUq9Nh2QLMENy3JcAvD7piMnvhsLS2OXn4aucHk1PZbt3kmaFqRqJK6t6P1ZKK/fp4DvWuMKbEVxh60EelMb8TXpRdXgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1440
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 7, 2021, at 05:38, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, Dec 07 2021 at 09:21, kernel test robot wrote:
>> (please be noted we made some further analysis before reporting out,
>> and thought it's likely the regression is related with the extra spinloc=
k
>> introducded by enalbling DYNAMIC_SIGFRAME. below is the full report.)
>>=20
>> FYI, we noticed a -11.9% regression of will-it-scale.per_thread_ops due =
to commit:
>=20
> Does that use sigaltstack() ?

FWIW, I was also wondering about this with:

$ git clone https://github.com/antonblanchard/will-it-scale.git
$ cd will-it-scale/
$ git grep sigaltstack
$

But, the test seems to use python via runtest.py. And the python code has
sigaltstack():
    https://github.com/python/cpython/blob/main/Modules/faulthandler.c#L454

Thanks,
Chang=
