Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA99549825
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349962AbiFMLA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 07:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350210AbiFMKyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:54:45 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC1D108;
        Mon, 13 Jun 2022 03:30:14 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=CyoTGrJYmoOuRr65n8mdsVCe7+1hzilsIRVllrUBcwbE0VrAWO+Bvfph/wIE4zkh22t42HnwK4tGvxGjmSUrXCJXjGaAjT1xdQeNwOJbN02iprk+x1ygEf85ZYRK/JcaMUOMB94i8XhrjOup+iOGKBHmQX3fxfU+aJnUIV/nSS7liZxvwmcrG9fl18CeRfBGkWyRQui52Z6EDkMviUxhp9UOU3sKVJPmnu92i48CXYcpwnalakjKRmSnhF9X4ZWrTP3foVQjGsT/FhMbnmiy1sxFrzHaAhvU/QbAaCuJjPbsU3QCpkQH56kEMuslJzGMQBnzBqtwhulIhXbHls6U/g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWzRg/L22n1xOCTWBe2yzvTVmYbKxl5ZnwHoYi5/Mds=;
 b=dbfv30HGdGKUhc6WBBBA6+mvZnBETMiUtP6RPzM6aOF9NHgqiiPg0OunPYBYEwRW0LS7WctQ3jUbNbjBfAdaRSB2dGhYi/60xQPNvg6JPkoM/wlhemMFveVfniHpvo41o39KTuZz12gzpRVcfiu5wkcs+VP2QqnTTDXZrQZEBdYOzcr/KLaGvUeRP2kAMkjwrv+NmZ2SS4d35eS+CK6gZ4TeWeBq/YCPz6yGFryTiRkAwUmi4sBxf3pEBHcyGFg+4tjw4pkJvCNzqYNSuW+aWU6zpy4iGrejA1/68FxhNfWMfin39X8hyzc6Lz/0qXNEKOuEU6ntwwDkiW/V5FqUYg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWzRg/L22n1xOCTWBe2yzvTVmYbKxl5ZnwHoYi5/Mds=;
 b=BWP2BPUru4FEeI5TPC7P0OsDt5sPOKimNrfuTt8yjqHqD1vKHZX53qIzkLyiPAdfiT7S1sdmevulDpFinOZduUYdKGG+J5puJnwP6Lmz4yk/qTLpeNwd3PgqyStfcaRgzA8Fzz/4+UVncVO7PuOB8eiK7M16b6ZgLLJTZpXsT3Y=
Received: from DB6P193CA0002.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::12) by
 GV1PR08MB8178.eurprd08.prod.outlook.com (2603:10a6:150:92::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.20; Mon, 13 Jun 2022 10:30:02 +0000
Received: from DBAEUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:29:cafe::c7) by DB6P193CA0002.outlook.office365.com
 (2603:10a6:6:29::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Mon, 13 Jun 2022 10:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT062.mail.protection.outlook.com (100.127.142.64) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 10:30:02 +0000
Received: ("Tessian outbound 4ab5a053767b:v120"); Mon, 13 Jun 2022 10:30:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cc48599a9a123a97
X-CR-MTA-TID: 64aa7808
Received: from 39aeee96b344.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 86C17D0B-46D7-4E1E-A2E0-7573B0720900.1;
        Mon, 13 Jun 2022 10:29:54 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 39aeee96b344.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 13 Jun 2022 10:29:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQ26utfSP0sIbF+yjS/eENSKeiNI/Un6py6+hQgJHFSWqK7G81z9QF59WLFaEnrn+HdEh9PQN/ZTD1yz+uoCDVh2pjM/qjOT+J+jETQ7ZLMWbp37Nkn6xlZytbVD/2WnuoAKKR58JRoyBoq9r+8PBwNXJhNHw0/Ij2O6pQjwsm2kUkAe8z9js2iMWdV1oaf32duhVsl61U/X0MGi/FEv8cwT2lCF3gWO8EpMi/4OK6F5BgW3BCL2S+zPAZGapzY9iDPtYUUv7sOnmlPRKJsexKnVAsiwVrfjJuTXqXsIhkpmJv1N9kQtYYDod9jfln4vu58SOIlHtLqNacvm1HgxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWzRg/L22n1xOCTWBe2yzvTVmYbKxl5ZnwHoYi5/Mds=;
 b=OsFBFI4+0iBXbbsNQ+IUqjieupcLBUiF0jA4jUu56gcB8Blw9EQaRtfVCs6DmCSJtRM/uY52XAJgze3sU/L1+vLQrUrCw10YN5YBv+FAk/hHCaxi1zpPFBhzSHdTW3GhMxHXgUPsFgYW8O/5HQQKYOa5BUVDhjeQQfMeYNou4GTu/AFQuzv/Pn2RiWXTEVwhmbCpBJZsmHI/E52VdDX7Ytbv645LnaJ43WODnVUensBXA/0wTRg4Nu1Cd4pj09dYZNeS6ULTS8qCwCFQXQUYzjWgpxedGrA1vLnphSyGnnO2DdTiv2gBZix74IqM1sWHLdiPwrHmf4YaUTICdaLkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWzRg/L22n1xOCTWBe2yzvTVmYbKxl5ZnwHoYi5/Mds=;
 b=BWP2BPUru4FEeI5TPC7P0OsDt5sPOKimNrfuTt8yjqHqD1vKHZX53qIzkLyiPAdfiT7S1sdmevulDpFinOZduUYdKGG+J5puJnwP6Lmz4yk/qTLpeNwd3PgqyStfcaRgzA8Fzz/4+UVncVO7PuOB8eiK7M16b6ZgLLJTZpXsT3Y=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM6PR08MB5240.eurprd08.prod.outlook.com (2603:10a6:20b:ec::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 10:29:49 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::7dbd:5836:c9c7:dfa3]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::7dbd:5836:c9c7:dfa3%7]) with mapi id 15.20.5332.019; Mon, 13 Jun 2022
 10:29:49 +0000
Date:   Mon, 13 Jun 2022 12:29:14 +0200
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Saravana Kannan <saravanak@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [CFP] Power Management and Thermal Control MC at LPC 2022
Message-ID: <YqcRei5RWehiobFE@e123083-lin>
References: <CAJZ5v0hjp2-yLN_UyQvMwhoPreTkA3xU0g3boYtxgLi6TWqabA@mail.gmail.com>
 <CAJZ5v0iLoGsauHTh+H7EemsjGApXpant0RQFEDZRQMiGoHzpCg@mail.gmail.com>
 <CAJZ5v0hEodhL2P50=MwN-jW7EF_k21CnQOnwiqTAGHyDo=2u3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJZ5v0hEodhL2P50=MwN-jW7EF_k21CnQOnwiqTAGHyDo=2u3Q@mail.gmail.com>
X-ClientProxiedBy: GV3P280CA0038.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 97248d3a-0fce-4f20-5f35-08da4d27acc9
X-MS-TrafficTypeDiagnostic: AM6PR08MB5240:EE_|DBAEUR03FT062:EE_|GV1PR08MB8178:EE_
X-Microsoft-Antispam-PRVS: <GV1PR08MB81789F72FE79E24B2190969299AB9@GV1PR08MB8178.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: rapmsSeQYs/5aCL3sCsDBnSy3OaGNn93dpFuOCTgNKqdvwi3d4UjnM1CWcTf1QLnxwlCupUualN1VeEqFlBoEYZIfNvow5tmvN5XNM1JOO+U7+p92Qoiq7RYCqPb5HydXlGg3x9b0L378Ei8bqr0ff2erAnPV43GvKZnVJ+hVtvSDuwwVCgTv2yUiVyWoIBjGf1R8WdaVbW7gbdzb2Q8jjGBsHaAEI3oDRoQP/MCEnsTBntry2Emie+G6hMsva7O67F1eA/wls/7KBNndmrGmY3GGfQLanwxD1QFcfiC53SSZPGsNmGPyF5EUKz4j6Jh1SJWbAzAOnE4Y29zG+ingKAirMlANxzQSFiSLExJRpO+J5ciWZ2e9bZAOWvyB27m7i48tqwdo+UtXaUkFDydK/T+3Dsx6wN3Yo0BPAdAat/hetmH66VPdjYt0guPRG+xXfXahiTKODFsN9tvtSoNKBPlm2rvvyjhIqgM7ffKSYs0RuEINIlyKrLgyUEy3b4m1XT3eNHjMUISZ/Vpuwch1rI7qr972zSQrbTi6z3psfuj7TeQULfVKsaPHYabYi7QBDOoDO9TLnvTG2ZjrKqPmVjVY7Tm9itrOu1jhYKL07ZlbsJSHUvXKNKa47SkJRxtJRKKMgwiFqiLvXzRTuSzFlldZ+Ioq/wSSFv/HaRibPiK6NEtx/wbPVGMDD75U9MOufsBpGD1mEnngQ12Nl+JlP9ZSLeX12ex6xbecHRwr0Q=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(5660300002)(44832011)(186003)(7416002)(83380400001)(2906002)(316002)(6666004)(508600001)(6486002)(966005)(54906003)(6916009)(8676002)(66476007)(66556008)(66946007)(6506007)(53546011)(26005)(6512007)(9686003)(4326008)(33716001)(86362001)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5240
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 85d79ac4-b2d3-4bc0-1d3c-08da4d27a431
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cwLys0vS851swZAMrWiFJGtsf4whRtoybQZjhn2wmIYHJbKJh7RKg921ydiIRfjpf5IkYC4VRQ8Pe6T6STM2YxjAeT5IFPKK9RZno8Bhy4wVPIH9KXGlvHQT+l66mQW8Ctt3m/w2dnDq4Wc2VFYwoajEZzmzFtSjGUtxlNN0rmOHRKHuYFZJVj+8nTEdiDxXlMrNylJp7SchULh9B/p6h9uqJQKoSRE3FCOC7ZxYCdMUwf2z/lCOtzEFaONm+bPt6nUaVBAhLQGhZJYrMIffx+21G/B2sYeM7Bs5+a7HsKkIMXa8ikzfKc/LR2/H/97k+ztbEACh9LH8QOyszQy/gtEwAvKV0aiPT00+NlPwr8FJJkbHqVoTNxSMCpSgizSn4m0HwQPZvtrPLhEaIqHkXxK/d7oqf3f6XPjfihbrNywUQs4d3kAtF1YFRXWe30q2KWT+KKKMBbgF7XcV0JGA7diHTXo6XQqTksP1HhkDjFVgF+brtQdeqsiA371YN+lpaG3I0mlKyQb3XyOkE3aPae/31VQPWEIMxQgvNWX719y3jbmTwYoBPWRX8KqZ6Vk7IvKOQmBj0aHumcdpiDGUUeYIjSuafgLLKPmYi3s8TILZ+5dx/khVTjzJ2hvWfrugAuTwKv82LAbOvvcDTDSjFew+BNWQH4mkg20FE5e5ZTjn0RbgMC2+73Wh833Y5TXM+se6Sti2nHCxVReVZTrz7TjvaDpuQQ16F2ti5zZgw1uHFrnkOAOWi0wnBQf2sKLSi1V9mosN5jsj4Diz9k5L5w==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(7916004)(46966006)(40470700004)(36840700001)(336012)(53546011)(6506007)(6512007)(70206006)(70586007)(6862004)(186003)(9686003)(83380400001)(86362001)(40460700003)(6486002)(450100002)(966005)(316002)(33716001)(508600001)(4326008)(6666004)(82310400005)(26005)(8676002)(54906003)(44832011)(2906002)(81166007)(356005)(36860700001)(8936002)(47076005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 10:30:02.4131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97248d3a-0fce-4f20-5f35-08da4d27acc9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8178
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Thu, Jun 09, 2022 at 12:20:31PM +0200, Rafael J. Wysocki wrote:
> [I see I sent this from my personal e-mail address, sorry for the confusi=
on.]
>
> On Tue, Jun 7, 2022 at 5:30 PM Rafa=C5=82 Wysocki <rjwysocki@gmail.com> w=
rote:
> >
> > Hi All,
> >
> > On Wed, May 25, 2022 at 7:48 PM Rafa=C5=82 Wysocki <rjwysocki@gmail.com=
> wrote:
> > >
> > > Hi All,
> > >
> > > The Power Management and Thermal Control micro-conference:
> > >
> > > https://lpc.events/event/16/contributions/1158/
> > >
> > > has been accepted for the LPC 2022, so if you have a topic for
> > > discussion in that session, please submit it through the LPC web page=
:
> > >
> > > https://lpc.events/event/16/abstracts/
> > >
> > > (please choose Power Management and Thermal Control MC as the track).
> > > Please also submit topics already listed in the MC description.
> > >
> > > Please note that the LPC is mostly about discussing work in progress
> > > and development proposals, so make sure that your topic falls into
> > > this category.  In particular, please avoid submitting topics
> > > regarding work that has already been done.
> > >
> > > The LPC will be held in Dublin this year, but it should be possible t=
o
> > > participate in the sessions remotely, so it should be fine to submit =
a
> > > topic even if you cannot go to Dublin in person.
> > >
> > > Looking forward to seeing you all at the LPC!
> >
> > The deadline for topic submissions is approaching (it appears to be Jun=
e 15).
>
> There are 5 topics submitted ATM, 4 from Intel and 1 from AMD.  ARM is
> obviously underrepresented.

Thanks for the reminder. Conference attendance and travel is
surprisingly hard to organize this year. We will have presence from Arm,
but most likely only one person.

I have submitted a discussion topic on "Energy model accuracy" that I
hope to present. There might be overlap with some of Daniel's work?

Thanks,
Morten
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
