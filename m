Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90755ADDEA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiIFDYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbiIFDYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:24:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF725C9EA;
        Mon,  5 Sep 2022 20:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWhsv2Sfcstjyi26zogFG8HdNhraKpGo+DRBNBCc0zOhzgC+LnXmCBS8oNwNenNiRUMU+Hh47KvTPI6plUP+T7CQeBOcFxWpaAB5jaLlEWEnQRSSCOvv82tpQProrlfqYszp/nhjkEEj2N4Y6PFFBtr2dBk6LdOMSoBa3RpfvCPMOLJpTqZgLgW40c1Csh9dDQNElcyj25fIGzH58+rz15SrT6O5uqbh+VgNoQk0UlcwiF9T/FKxK+bs/gV7BnRlhddsDHeeQDSRib9nzOn1PrCGLdJhCF0XYk+TNIM4Zyq6iRskAA29LHl3fhNcYCtb8EVkvdnua275bOU/XgP/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pzl61Mi/bOVuPKVdo5Zz/Q6L3vDEQj0ewKCvuqwvV+s=;
 b=SNfcxegcKSMjhh0ZQ0lE8gCJQcg+YvsydlBWbDEcZ7tCti/bt/xLjc78Zrsih/ISabIVWYDR9HyngRgVEbr7d13t46t84UNtVEwHJTdOYHfazgUhbY8xqO4G75u1lRIiAInVFQU9rOWn1WKllxjYJQM5uTdNkDPfXoxWSrIenH4YAD2LVyQtdxTo368ADC/krPgQeKoM1uz7X0iCLdKQBxdl+L9ImMI59bN0fh2o/kkgZppdd4KEFLBuHzuuzU9nlNdWsdI1u8KDcuinicCiBniHv0XmGrRV9OZHhCcDuCfI/mdH8rtUFWzmtgP72DNK7POL2GAwHW133HaTReNo4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pzl61Mi/bOVuPKVdo5Zz/Q6L3vDEQj0ewKCvuqwvV+s=;
 b=idVsrrM8X8SjVR7lhBjy8Wa5kVvmbfUPjmnM99svG/0h2YHBUuUUWSNO/T9vBlaep0i5rLFdZ6P+wXloXSD1c/EzBRC5818Y3CWiy/9SN5iOMnfs3p3RM6uQ+VfMvA21+bixXopo4I2921jcbDO+DL52k6OtY3m+GYUIjpTDngA=
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.12; Tue, 6 Sep 2022 03:24:13 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::cfb:b63:3255:646c]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::cfb:b63:3255:646c%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 03:24:12 +0000
From:   "Huang, Ray" <Ray.Huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Recall: [PATCH v2] cpufreq: amd_pstate: Fix initial highest_perf
 value
Thread-Topic: [PATCH v2] cpufreq: amd_pstate: Fix initial highest_perf value
Thread-Index: AQHYwaAiPofEvjY25ke+IHeKx+J+6A==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Tue, 6 Sep 2022 03:24:12 +0000
Message-ID: <DM5PR12MB2504A37AE98115E09EB072C8EC7E9@DM5PR12MB2504.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1008a53f-746c-43f8-f964-08da8fb7452b
x-ms-traffictypediagnostic: DM4PR12MB6664:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rsT9KXq0JXy+wgKXUqTSH1r1WqTpUvPd6Iw7hAuvCaL1ZM9DHjaiJM07uFy7YqA/hgapqFY87ZC3evb65QWVH+OmakbTxtsLqVrpZky7g8KH/PND+UQc1KpEQYL7iqAXjl5JrnFIm7BNFv1rEldFikUTScEWlf1GcMC484kIaOaZLOTivsMIIFUbxzbYepxUsPVg4AelPrkzNqjgzZg11weeNbIlhYz+YDw0/v0tT6qMfNBuUcQjOfWNlnL8UxuHjgJNosFYvtcDHZKg/rOGPviY/VA7YFrAotMqKZNcz8vP11zlUWLUHmuzUeCFBY97NDm1h1o62ojNz5kJlJeiiGI92iGKVQMQdZ5ztdvbPbpx87zWQVZ06/QiseIl59RGOSxLNvNq4TfWzE1RK46BBbpJejqwb8X5WaXLWjSbqzP1M0gLUS78bTgixsCFVtvJgbJg1rKNlby7K9gxQpGqrE9ziq2cJjianEGjPdWGffxK7DCrxCOdMfQX6YGcpIdDlc9tw93MSgPtj74ZYk5UFiaPJnZHYQJQNWb3EPzr0nfgU5UBislHS9+55S/BlEaVnCxXUQqzJuxVJqNaNme3DED7CUjAh+GdVUDYfuKQ2sHsGWeoULsGzWYdy4cbMDF/90yrpVwIcX9flyrTXlZHGm2PWivVSt0D1GpG7GOqIgs6awtB7DEecgTb2TG5i0UsWwAJtASF9l7nZE/2ngdMD+f/0oCXiaDkUzPXR3nIHPt43Jnm9iHIxYxM5ig8EhmVkIAey9Nrd7BOYGBCG9NoUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(5660300002)(8936002)(26005)(6506007)(41300700001)(71200400001)(4326008)(64756008)(66946007)(66556008)(66446008)(9686003)(66476007)(76116006)(7696005)(8676002)(55016003)(6862004)(54906003)(478600001)(6636002)(52536014)(2906002)(316002)(33656002)(38070700005)(558084003)(86362001)(38100700002)(186003)(83380400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CkrsyQy+ol/IywnejjlBGNz17SUZdCl5f8NgLxoKb/arD2XBK3YhHh+a7c0Q?=
 =?us-ascii?Q?9QJv0LM1n2xvDmKEOJ4nxpyrJ0fNzn9EpFmCQaI1c87iN4hxjurBDBc7Bqc5?=
 =?us-ascii?Q?kLe/gvXzAfOZqzWuZsUzNHrlYwJIyiFGkWdpnLfzy8++LIgpBALiZK+3rAAj?=
 =?us-ascii?Q?twGA7GkKacHARleLjVbYXuqLf512P3Xouw1BSb62UeyhEZ8AWF0xCMnXKaRP?=
 =?us-ascii?Q?ZQ1dXlf0mbAPfWdgDAy/3aabSt3jJokqzjESH7WCgkfMzXW6hD4Xy3OxuoQq?=
 =?us-ascii?Q?r6Z8ZszF1cOgMSzhMgKUGDJIXng+q9Ro9NrHkhqzEmBqws1Oi4BKf2tAZq8U?=
 =?us-ascii?Q?v0BNL1cfv+hp7YT++BejHcwyHr1+ulJLocHWXe6g0eJcDDRe2WcuRdOlE9MD?=
 =?us-ascii?Q?LH/9ZtIiXu9hkZ8j4vF5TL99ZhxIuoW9MhAw7FturMG87mr7nkRzVwB2si+V?=
 =?us-ascii?Q?rEYy94h3hbFSiWdPH2558SOvSRswleZRVALF+WGoRQ4pklZ3QmV0uuNgp4V/?=
 =?us-ascii?Q?jCwHi76dIKwQmL2ZzlhE6sdL5gzkKnezArvWbLg1O6J7y3cWQS582KY0ApsA?=
 =?us-ascii?Q?FNFtR7LYY93lUoxntR2cW7JAQ7nu6mHu2gA5CSvqRQERf1YdB0Xwf6SOQA5n?=
 =?us-ascii?Q?f6GVkwZXCSh9wAOMpuNSYxotsAtHbEe573vBV27Qs4XWVZKFOTdsSP1BxcpP?=
 =?us-ascii?Q?cIHTLCvWr87ndRhukoBO4WR6JaEbykY0nE2yddPn2TDV6ghC1u5Mx+cjKJfK?=
 =?us-ascii?Q?c/GbGwSZIqfi3A4WJQB2N1uICTfuI/suIwQD4aehULieCwbeL8/QzUemRiwk?=
 =?us-ascii?Q?dE+a9xh5CVdl1IjCyrohRh+l6JfSeCaq4LxyUv+km0nC7ws4cK48X+1qD2kx?=
 =?us-ascii?Q?CQG2ZRP1z3BNcyLVXlsNg9TvXE/5KujJGB5rxPpD4gxxuYcey2nRYCatIq5/?=
 =?us-ascii?Q?+FevzJAR3fWba5dDmRHC7zY6lPw+TqTzkfVbetk2FohJxS0yPgIltmzv7Au2?=
 =?us-ascii?Q?IAEBW+Fs8Wlvvqn+yU0yJmsSWX4GYGuLZ0UnhmE6gDmOcWBVBHNlVX9aI2w8?=
 =?us-ascii?Q?ipCnn8f4+ZX43PtFCEgFvjVC7xtaL8pswxhVizpFtvQ3983ZlrIFUHVK1YyS?=
 =?us-ascii?Q?BCv6DkcTSQtONgJOBfdQolDdUsgj1Y68kDep46LLqrbXo+2hu7NpkDbkg9MS?=
 =?us-ascii?Q?Ae9WFrgPCk93feFNr+K62NmHKHQ3qx826ADdJDwTV8A3E7lI5zHl+J6LlFs0?=
 =?us-ascii?Q?bmGIwVfc17kTzjUtmCq6a0zPfFow/YI6JfeJvvkbgfMl0Cw91gi7VAh2LC+A?=
 =?us-ascii?Q?Qo2M1x4Nf67qSg2+L6+hg3EiYEFZUfunEWw4pDKkti3bUcx1OdR+3LMjlZo/?=
 =?us-ascii?Q?MWsP+zTLmT8aXq0iMcaM638Yr69n1NM1LuSiWD5BAe3HEO1qy/LnWOv35l4Y?=
 =?us-ascii?Q?mA+3xvUdA0VB9vcsXZbA1pDhftLLPbLGJXe6ym/DpOSC5myoxpFzko0POK8D?=
 =?us-ascii?Q?FI2ojaIU3VaUyOupXVfQdmqoEjF8TrYeQs9oWRhSB0PUmIJ9HJE+2xwVpLTr?=
 =?us-ascii?Q?DLhtun49pDoqKXydFFosei182QNo2Tc0F6pmZIy0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1008a53f-746c-43f8-f964-08da8fb7452b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 03:24:12.8174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3PTrjCAqIyKyBQXPFaLkWm9lUEs/WcAbCc4CRrKEUN4CfgoR+iQ7uBnSzhC8sgHrrrQR+9SsripsvDUwZ0hKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huang Rui would like to recall the message, "[PATCH v2] cpufreq: amd_pstate=
: Fix initial highest_perf value".=
