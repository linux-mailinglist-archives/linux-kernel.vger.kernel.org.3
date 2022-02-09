Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F42094AF4EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiBIPQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbiBIPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:16:46 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368A1C06157B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:16:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoyBAf3rzZp3o9J7qSXvIdcixnge5Ehsm3kpW093jghmYuHCbWQg3pr5TTzeoZEGKG0t2TwtkohthiqETarQlFkEhGYUW0JJW5b+6PnsYNxEfH1gNlgR7L3DmB1mzLAIyqMD5c2k5H34VOos3pd51K3/TOx41UTNxBnxlxwPqfDC9SbvC92m224i6dK2Yn2x2TMNieFcDkKwmsGBOJvGXX9pLIChjLX31xhZe1Q7tmn6BgfjTnMWtFqxj7qph013wvpR2kCpiF+G0EcFu0eEJnLwyZ4fIvtGavK3b1siXDNWSQmYrm4HnNZ839T0STcWCSDKwfZpZWYKOJssUzFQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cmDOKCyhkLiRxvFr28lDlNg2Tij3J6REYw9ts4jDbc=;
 b=e5DaN6HkpyYYp2/lRjIDE34TTwsFpc2Av+j5aTvKphV68n1YrjdaIz4Je3c50TMVGTSlSSivPb53BNeflrNQUUlCXiUumAXnCLGxboGk5Gr4nTbQvYd7kQvMwgOTqJp1O60wN10QQR2CvfOxaRBxedPGAF28WCD4uW2TSi5aWPr3QzvkbvzyBBkeWkLsksAJbiDEqta57jWVW5Bs/zV1371SQhl6yuZZUulQa/Tv15Qg1D7nq4hLLFtQtn4bNX/E98jRRAYSuuXoFR/+x0lO4J6kYHvJvhtrU1NBddLOi/GmHF4+GH8AkSI0MW8mkyTcLjPob+c3UdGORPLHZcH9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cmDOKCyhkLiRxvFr28lDlNg2Tij3J6REYw9ts4jDbc=;
 b=0n8z8PgCSz/66dd3Vpf3m6Ars0GecJCwv7sndv66mTV/5nZ3gtnvExHUEfYDqMlFnlA3+02Xr6JfQjCw8Ylqq1fKR540rNLoAf0HaJ0/PSdUOLFjQ5bj9/GB9y/y0tCjnoDFgMYEth7IgOmu1xwBzBl0Tb97XLS6pM9tI9o///o=
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM6PR12MB2825.namprd12.prod.outlook.com (2603:10b6:5:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 15:16:45 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432%2]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 15:16:45 +0000
From:   "Nayak, K Prateek" <KPrateek.Nayak@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "efault@gmx.de" <efault@gmx.de>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Subject: Recall: [PATCH] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Thread-Topic: [PATCH] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Thread-Index: AQHYHcgMo5+1j8RCJEC4nQBNplInZw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Wed, 9 Feb 2022 15:16:45 +0000
Message-ID: <MW2PR12MB2379057ECD44ADAC2BEC971F982E9@MW2PR12MB2379.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86e7e904-5f28-430e-3cd3-08d9ebdf2f7b
x-ms-traffictypediagnostic: DM6PR12MB2825:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2825C8F51CA134B4833886F8982E9@DM6PR12MB2825.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qe9qejOZw3uMEtEDle1aJO4atvSv7O8sv2IfG/ZcsNl1v5M4z6uOTP4Zgs/wVrIihLL+QFSHo7hZdogjnE//08UXixoHiANTNLY4izYYv5jRqbDzatjyEiWpx4p1w59z4TPHT0LznBXx6UGAn7tQSuHaYXEtiegw+JIgAENuH32URfcSIljNWRPryDBHcfZ5o0fz6LT7VAKtZJcjLZeRsZKBOCer66kQvgBFzVxzAbLnS7Wi/tDuaHDJwxFC+mf9g0Im4UhVuBhqq4QmpgUaacZquvxC1mxQ+eRRFCmlk3dZqofyPcE/XxkaT4FuTBPRU7VK9l0ysqCSiUJINf1ueTyy19M6AeRKBl8Xr+t7sg4WAzX31Clpgr+rGNCJKMrHeRoSsgtIR4UbndlrKulqr9zj3rNtxqZD3RNOvWgToLs9dyBSxiz0CVwoteIiBs4aXqaaSAA+0aB70Vx7roceAxX92gZkeV9k+tbQffPfofwOWESrva7/0TYZzVDXunbfLn4JKkt/T0ScVdAuU3/+6B6Tgx9HwLHId1VRT44LezC3KfK/Eb5gHxOSAdMMyp52jPTkjxwLdAOo/zdom59CnuJc7JOqu+d0Hfp3H7GSm7U6OjWXp3AYQQGE96qYiTySnz+7yis/1mhRLlKSvWndDGBri4lBfmdU2QQumVf0xboPLdywt1CHA7WDHzJ5Y0JkBcN20+Nk+EtCiz3rCYxplQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(64756008)(8676002)(4326008)(8936002)(66946007)(26005)(66556008)(66476007)(7696005)(55236004)(6506007)(38100700002)(5660300002)(33656002)(186003)(76116006)(122000001)(7416002)(508600001)(86362001)(316002)(6916009)(38070700005)(52536014)(55016003)(9686003)(558084003)(71200400001)(2906002)(54906003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WZNq/kCyOax5oPovpDUnjbdhKFZ5gVHq2AIJ1O6LtkxnKWLCMLRmVTGyxdHM?=
 =?us-ascii?Q?7ZGDCsl4Pump1Z+XEuGCMhUTn0o60TENxj4LTgdbd+bdISlsSMBb19BsofW8?=
 =?us-ascii?Q?wKMJU274zjT3CHM08YegiwJI4IsOD1VtjfLJHgJv1QreyCKKAgkCV0QdgGry?=
 =?us-ascii?Q?MCQGexxYKaNrSxawBRx3BGUhDnHhemT7zJe0W20XmyYpfwBnjzzUTD6WpEHf?=
 =?us-ascii?Q?LNLUS7fscJ5EmkCDJymnQyRkPQgg9tW2RkcYhhAn+cEJlnIMTNTiFA3u9CZF?=
 =?us-ascii?Q?U+i2BDz2XeYzgdhdeiwabp8m6FWjMkMD/Ymjq9o6hnqQeOWLKMT7AkyUGVoC?=
 =?us-ascii?Q?maOcT+ppuRM+ecSTSE5iCKLp0h4DCIt+Ze1JBGbgBaROxW0z22kRnLRdQMNW?=
 =?us-ascii?Q?5Vj8JHVPgZJLCxeSbP+ISfomr58YD171iEH8rOOV6piuE2JhuBpg3TZH7QVv?=
 =?us-ascii?Q?Onn+fFB668wLjxsCDeYO1SjFxgkSMHq1W2fepyKcMC221tZdaBh7Wj+DO3CO?=
 =?us-ascii?Q?TVl3oO3MxueSoHVl5GaHsdOjgvQolN6haRBNo6YgAfc+ijsLx6MUcMWMcedy?=
 =?us-ascii?Q?QwsoEEUxC/pGZa7hgbMl8tiTWrI0v2111mwk7xMP3nj8JsZZjlG2TOcsp+3K?=
 =?us-ascii?Q?hHWhy8IvYQ96R0QsEQCvFB7RqDkwFykntBQApCQIypGQvC/5Pr4NhZJDCtV9?=
 =?us-ascii?Q?LBJpi+H+ceAFVoFdyVLMyOJMnXHzykMOAuvjxlVEo2hdwiHKcw/sS+t2969D?=
 =?us-ascii?Q?xMCoADuq86uuM2d8tvGrbj+yPAS0gq2775svNaDhOt6fv1McF5KHjy9KHSby?=
 =?us-ascii?Q?d4w1KyYn8iOYu0ne18m8/6LjRW03Fd4wXi20ez8CDoReSWmBCGFlM/FsSshE?=
 =?us-ascii?Q?BKsqE2yip3f4mXhzPf7n4RRPBUuOsp8JsjRqlJwuKesnJR9LAPtp+oOWgLhw?=
 =?us-ascii?Q?7c0S2Xf6cHQ3X+FUTVl6/WkR5TFxnNPpbFDsn54mZXV7KJ2yLDSFQYtsA3Xu?=
 =?us-ascii?Q?/SnJMmzySX7o6KA8JqOGKqkwBJvQWe763kfrjzsC1xb+5rrkQ6sNFo7nxcE0?=
 =?us-ascii?Q?2H6X+bNUH2tKd7H4chwP0CQsLMjRSkJ2FV4+agO6iC7A3nNVvcNX4ow/ETRk?=
 =?us-ascii?Q?Nk9yBnV9kHgSIqPHsmmh9IFMLBGNRhFOns7NbCfOSLiWisGQOKvcPzh9wJ5T?=
 =?us-ascii?Q?lAjEhFYX1adMp4BCOr+Y+/g4Hu9fg5EOw6KTdqaOkE43oy1nv5PGNzR3FE0A?=
 =?us-ascii?Q?Spst8fpLyq/cTtks27g25ncTjPboOUokgwFRSiT5Awz/NmSEHDqZmRAdskdM?=
 =?us-ascii?Q?accOQLhIcc4Q0tQTq4Sxisd/fAwQXIgsWwiTNVIxG8VKd1U75FwFiwjik2mo?=
 =?us-ascii?Q?mU867HiSKMYK+o0Nz81NiMrdbgdVWF6s2QxW5iTAfkgMiiu8MOD4urF9DTh/?=
 =?us-ascii?Q?BjRYnN96Y7TNc8H/l77PJukstHCUIDvu2sYLlYRNrwOeHK4Jo6wxP5a0quIe?=
 =?us-ascii?Q?cscMQl7Au0tOSepBEhnFyX765LL2C0MkSaGpiTPExWhrCN8aUpQgQBQVw7Vx?=
 =?us-ascii?Q?68hRHJYq0/iXX14GdPbzrrB1sofzTp6Dk2EX/wQ6LZG8k5nc8wjcUd4gXvvk?=
 =?us-ascii?Q?SmX8pFiPy+3Zyg2za1ISx/s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e7e904-5f28-430e-3cd3-08d9ebdf2f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 15:16:45.4600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +TTKPkLO+s+QI5qZpg37j6lbNCiKXZ9BTLnLHQ8ql+aY1tWYPNjqqiodgymz6rGfuKhAwXRBCdzCzqGllVRm3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2825
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K Prateek Nayak would like to recall the message, "[PATCH] sched/fair: Cons=
ider cpu affinity when allowing NUMA imbalance in find_idlest_group".=
