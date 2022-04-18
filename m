Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A127E504D98
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbiDRINr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiDRINp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:13:45 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Apr 2022 01:11:06 PDT
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2955117E07
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650269467; x=1681805467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J4NLuiWr0+jgH6088mfQ6ewgiMWT3Mb8RGOWEwyBwA8=;
  b=rHJ77y0v/G47TMN76WNhHM/H99fm7AOae07ndcewiXXXN41TXjeUM9j9
   x1p5RwpWijRs9ffiYdl7r6sjxaOLCEBlDfOuxUzSnpRxxfxbZK6cNC7kY
   eZzqek4xENS9i0UQLFmrEH6exLyhu+jmZ1DQYIaipeEKNLMHtPjVirjht
   4Xn4J1WGE6hSVgnZ52Bvr6JLWStlUxs+8mzLAx24Gfj3JffsLEKr/QKQV
   2Pn9VQIetTN0xJPHBXei6jmAwADM4f2enjZAH76orywpNcx976bZCxEOO
   F5y5Hp/WnSZgUf0LOIW8uADZ8h7lMTeJJagsmi6maymN+F1TS9ScjhCZF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="53916603"
X-IronPort-AV: E=Sophos;i="5.90,269,1643641200"; 
   d="scan'208";a="53916603"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 17:09:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqiEXF6haP0ds1sCWBMFgN9NpyBj6pOEhyvis5jYL3WPa3OJywJNtvsNuqru9kiakcFa6jDFFyTp6rM5nhxgOiKQznQgjgUEgMu7ASV5VB38ma/obQT3ablOpFcRNDNe+DL8v7AywhzWSBvOWyPBtza/8mJ1d1bwyGI0uz8+BLM2Je/pHA1TdLfN10INoPlLUDXfopdKO63cz7xI0WpjWWLPr7tKntSdS+yGDPcSFNUwnlvDo4HldEY8xnQwRxDhSFvz9GPw70bDOJsK3bQKQiOS/LrV4Ga+3qTtYbTntIcTXIxX92Ie89L5RM4iMGm/UBCahqufDTdMgS/R0qiLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKSUzM/3yVfwaD8V56eFEHSuIXWLp9zx8UsGQAgpx24=;
 b=HOqH8R5xXpPZBsGLQVQ4TFKkWYYhMc0eEd9gKGpDo6wPCtH32UK5xmT8HO9gj3+AyIT2WQUNk+Isz2QFqQnkAj0nRyYYrRwN8dvEfA6qG5Sg/UBgpPENTXQO7FPo2gzTECZz2ojrnqejsm4wKNbh0tlVrLIxIv6VAWc51a+L1uZyi+rvdAzmb6EcgQwcGE9Zs/yUAYyltGH7Vw3Zs54nPD5Aj8zmXczQ/zikMSkpAckEXYiqerb7gxQ9j/oObiHP3rXmpPbIH7kFvsTRMQz3A162kW9JVsxlJ3cdIeEMwvuAMt30ohf+fb+TC6WHKNJP6C0Cmxe4wnO8VX3SvIPGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKSUzM/3yVfwaD8V56eFEHSuIXWLp9zx8UsGQAgpx24=;
 b=hYNhJXH7ZLnXjlUo301nR2tsEy8RhHO6DXnjZfa0FD3m0PvClOapgJQKtzgyuyVK8lunakrFU1QlJ1EAx+na+UalJEyZzeWGJFe3HO/p66mVkJeW/yVWdeMUlwY8AKbzDT+uXAXbDrdN2qnfYexLPlVjdn7RmoSaYdJEIM+Syg4=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB3216.jpnprd01.prod.outlook.com (2603:1096:404:83::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 08:09:50 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::6135:4a6:edae:8c07]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::6135:4a6:edae:8c07%8]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 08:09:49 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>
Subject: RE: [PATCH v4 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Thread-Topic: [PATCH v4 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Thread-Index: AQHYTmsRRz81jPhIdUmAknmsnyPwF6z1QEAQ
Date:   Mon, 18 Apr 2022 08:09:49 +0000
Message-ID: <TYAPR01MB6330EB52505BB328510896C88BF39@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220412124419.30689-1-james.morse@arm.com>
In-Reply-To: <20220412124419.30689-1-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-04-18T06:35:50Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=bbb1a478-2c95-452a-b04d-bc3e80efdf00;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05251291-dc16-4924-a6d6-08da2112cf0f
x-ms-traffictypediagnostic: TYAPR01MB3216:EE_
x-microsoft-antispam-prvs: <TYAPR01MB32162AADBD3ECBDAE7EAFA598BF39@TYAPR01MB3216.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2XFT/rP0+m1IS4iLk1FSu//4r7dD0gkBok+UCaZVN+F5WdUKBttVxfq+sbBsoRGvvECJAXCKseAiIHRRRc1OjL5ZH5sPUL0/tPyklkwUpFbC3cQwiHj3mtk/teSEYdgI2sXEmsDgfPgtDGOpG+7ILDLJOIQGiuoBwEmeXxefBPzdPJGFZxvgVtCYDk51m6/vS8rqsp8Qj95AWAaCBzHiRYVfcEfEhbWi4//wGdXWoGrmk2qlUopwlh+Wp5vxYsTW5vtdpNQ/2pVw4uALPy4/0Vr7Ir6V2qd65CXWY09nAWE0V35z1DbmGuNBnOrMWOWYu2b+9I1UgBb23hZmAxOWV+lJEp2uMs2QdwLaGIDAvYzsoY76Ap5COdNC1B4R2bWwAO8K+VFs3BAEtTF8eRocM60pWu2jfvQ4bh6HnyKR03d+3fr+ZJ21WF08O7wBNJKCpnMy4wXR1CWOjT6W6pofKdXvDN4UUo4yIvlXK05OtVH0LT2CmBkh5yG0qn5WoARB9DHX7OrNShDSahTQ6suhK73OuqHjUHJE72VXacyebgji6DAUQMuZMtNSu66d6SMcyE9VCEBkCcXpZzh76OpC/LXoz7HQ4ecQyXhh0k9ic4wYR8atRv6abrGrRhzK75kxH6MTL4I5VWHFYNJfLOx+/VC3VcJ7137f/ITSNZrahyPvZF1aI+NLD4unb0EH5HrWOly5cvAR6WWTce/myO0bWWlZigmy4btY095vWOcZ0QMMgGr8LqDOTC/IMmsBZpAO5/b/lT8rDy08e5BvDJLhA7qR28ngTz3p0CpLQU8pYXJIuYq0ILxSH35ec6F7rMKDu00KOn3kbLt7bUyj2/58fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(122000001)(316002)(2906002)(508600001)(64756008)(6506007)(86362001)(7696005)(55016003)(82960400001)(26005)(186003)(9686003)(966005)(83380400001)(38100700002)(33656002)(66946007)(66446008)(76116006)(5660300002)(38070700005)(66556008)(66476007)(54906003)(85182001)(4326008)(8676002)(7416002)(110136005)(71200400001)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YnFqb2NZV085ajlXQ09ITWlkTXBHRFVDcXhuc0xTeDVjemozN1VjU3Z5?=
 =?iso-2022-jp?B?MlBZRCtWYVZDUkI0R2VuVGRrV3VqUFRGaGl3ejZSODIwYWo3MDVUQ3hH?=
 =?iso-2022-jp?B?MDF1Wk13bFBFQ084cVVnUExPS0pkeW5pd2JLMmYwZ0w3YitKUktQYjVN?=
 =?iso-2022-jp?B?N1VEYllBUFVnaWluYnc5UENDbmxSWnNEVUwxNkVHMVExUmswVnE4NFI3?=
 =?iso-2022-jp?B?TE83TVFSYUUvVnRLektaUUZVMkxRTndSU3BmSTZJZDN3OStRNmZZSjUx?=
 =?iso-2022-jp?B?aDVHbldORFZtb2lYOHcycXorWkdSTERzcW5qbWY5UDhETWxlSWhwVlBW?=
 =?iso-2022-jp?B?VHg3RUUwWWJlMXRlUmVTNXlEVUFDR0pETGt2bmtQYUwyMExtcGhtY2kx?=
 =?iso-2022-jp?B?bGl0eHYra1VaMU05cnpKRUtNR1V5SElIVklac2dPZ2twWkhadVRWZys5?=
 =?iso-2022-jp?B?VWl2SndYZFhkbUNHS1d2M2l4WlpXZGxqNmlkUFhMZzgyRUEyUjRKTkJC?=
 =?iso-2022-jp?B?WWl0MHlQOEl2VExlcnV4b1kyaWVyMEtNV3RmTWJaT2lKSHcxaVJKYjJa?=
 =?iso-2022-jp?B?RDh4WlFVMzFQdkU3bXc1MGkwMnpJaUxtNkdRK3ZkR2Q5WldHdmFPUUZi?=
 =?iso-2022-jp?B?cWxxcUlxLzdZRVdTdnhRVGdKZ00vakJKTVhNeWlHNGJDRm1xalZQcGNu?=
 =?iso-2022-jp?B?cXRhSUdWNVM3eUdwcTlDazJpSTVxNVNPUWdOalBOZ2N6U3FQWFkrZnB4?=
 =?iso-2022-jp?B?NmwxQUxHck9HZ0ZkNllSMVd3eER3alJPSTlNVzZydE1lQSswNlBIdzU5?=
 =?iso-2022-jp?B?ZjFLYS9xaXhvOXNKaGVZV2kvRFFhK2J0V3Y4UHdYbUdDOTRzYWh5bXEx?=
 =?iso-2022-jp?B?QUQ5TGFMU0dUZnFtS3V3OFBZNFpGSWFXZ0FmUXprUHZmdkJxbnJTL1FP?=
 =?iso-2022-jp?B?L3hYY3VPN1UyTU5FT0xmQUJaUGZuNVRGM01UZ0xqTDlJekVoa3pjbE1m?=
 =?iso-2022-jp?B?U0xNTzdveHhLN2ZOQVo4STVEUThac1dWdzFFR3QzK09OTHpNcDlWSDlu?=
 =?iso-2022-jp?B?bTF5aGprczgwQzEvNlk2alhyaWlWOEM3Qnh2ZjhRRklnRWV4emlDS2p5?=
 =?iso-2022-jp?B?blR6K1NONzY0OVA1VzBROUwzS1g2Q1hlM3Z2c3hGNmNuVlR4bHdXU2Ir?=
 =?iso-2022-jp?B?TzRmWTA3RFNBcWdsemJZRWx1WW9CR0RrTXNNS1FqUkdPL29XYk10cFNO?=
 =?iso-2022-jp?B?QlRqSEVXcVpiUVNIT1BscE5jYkEwNElCL3dtOWVINUhpSW1ua1pPZFZI?=
 =?iso-2022-jp?B?R1p1a2N5Y1hLYWFpQ3dzbVlpL1J3UVNBeE96SmxaVnVibTZ0c1d5V3FM?=
 =?iso-2022-jp?B?ellKODhiakxSNXl2cUxLb0hseE1pTTRCWHdscGM2a0R0WCsrQjJmY2Iz?=
 =?iso-2022-jp?B?V29aa0VyM1VKaENlSmR2WTlSTU5BbnhyQ3d2MWpETVplUllwdVRydnJy?=
 =?iso-2022-jp?B?Mm1lK2s0ckNxOHFYWGpVRHlnOXBjaTBtS0ZRcExiYnRhTkt0TlhoQWtS?=
 =?iso-2022-jp?B?SkJnYUtWdDF2UXptTktROVVSUWRZcUNEWGI2aVZONiswNkNCdG9HdHcx?=
 =?iso-2022-jp?B?b1VZM1ZHWFhReGRESnNNbFRoRWttbjFlK0E4dE5CUmNZd216UzRZZ1Nm?=
 =?iso-2022-jp?B?Q25ldVFKeUZqM0pJeWNnaUlMbzNMNE45RjR1R01VV21Uano4WnZ5c2Z2?=
 =?iso-2022-jp?B?OFNBTEJ6Q3phU2syM3pzZDJBMEQzWWZUbkk3L01Kb21qeWluQ3JVRG5j?=
 =?iso-2022-jp?B?Mkh0cWFlamUwWm5rVmQwOUNXTVI0aHEzTXVMYlRVT0lPV2ZQeHNwYnNn?=
 =?iso-2022-jp?B?SjJ4MzFXendVOGhwWkZaK1pYM0x3cDIybG9sdzh6VXN1aG82TXRxVFdj?=
 =?iso-2022-jp?B?QmUwTVBJQ1lMVjdEQTVuR0w0KzllTEF3aThGYkpSYVI0aGlYcXFka0Zr?=
 =?iso-2022-jp?B?dmxCSDBmTzJXNDNGbUl2eFVtUTNsKyt5dlVPR0NPMlZFUEw5T3NGV3p4?=
 =?iso-2022-jp?B?QkNsZkd2NkQvSU5WZTVnbDVNYVZtUVBHVTdvcUpkeVEzVHZLNXpDSVJY?=
 =?iso-2022-jp?B?Y2ZhQmJUajlCY2tpVWFqSndXV01Hb3ZydDVHNldTWXNzM0FyZjQ0Q25G?=
 =?iso-2022-jp?B?eWJPYzd1Vmt2N01ybVEvWFJaa3Q5VHFtREw4MC9kalo2QzkwdFVjYU1R?=
 =?iso-2022-jp?B?dFFIc3U1YUpJSGQ3dFM1d2wrd3FxUGJ5U0M3Yk03WGxwKzlwTTJjNFox?=
 =?iso-2022-jp?B?eGVyOG0yMVBzRWhqZXZydFpzMWJKODJQeEpweklQQ1VDZ2pYU3RyUXdp?=
 =?iso-2022-jp?B?NVA4QythWk4rQmJ2eUlTdWN1NXpFb3VydDlXMGtqcFZIR3pCTHljU09u?=
 =?iso-2022-jp?B?Z3VPQmh6Y3ZzUHhRcmpuc0lsSTFUYXA2cyt1S1pYWmVEMGtjNXNkYkg4?=
 =?iso-2022-jp?B?WjFPRGlXVm1BVXg2bDQ1YXMrOGlac2t5R3hqTEM2Y2FURW4rWFZZUnJ1?=
 =?iso-2022-jp?B?eElLS0Z3ND0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05251291-dc16-4924-a6d6-08da2112cf0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 08:09:49.0883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8X9xZgVlPSVGmv4iTLAMiHHBeMVhAB57QWCaMFPn/nI4BifU6oMes7r9TxvgTC8p8/7oDYkbYKCuU9AKqNAjJnMcZ5vxIcReBJRoCjRjJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3216
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> -----Original Message-----
> From: James Morse <james.morse@arm.com>
> Sent: Tuesday, April 12, 2022 9:44 PM
> To: x86@kernel.org; linux-kernel@vger.kernel.org
> Cc: Fenghua Yu <fenghua.yu@intel.com>; Reinette Chatre
> <reinette.chatre@intel.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo
> Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; H Peter
> Anvin <hpa@zytor.com>; Babu Moger <Babu.Moger@amd.com>; James
> Morse <james.morse@arm.com>; shameerali.kolothum.thodi@huawei.com; D
> Scott Phillips OS <scott@os.amperecomputing.com>; lcherian@marvell.com;
> bobo.shaobowang@huawei.com; Tan, Shaopeng/=1B$Bk}=1B(B =1B$B>RK2=1B(B
> <tan.shaopeng@fujitsu.com>; Jamie Iles <quic_jiles@quicinc.com>; Cristian
> Marussi <cristian.marussi@arm.com>; Xin Hao <xhao@linux.alibaba.com>;
> xingxin.hx@openanolis.org; baolin.wang@linux.alibaba.com
> Subject: [PATCH v4 00/21] x86/resctrl: Make resctrl_arch_rmid_read() retu=
rn
> values in bytes
>=20
> Changes in this version?
>  * Fixed the problems with mon_capable preventing mbps_val[] being
> allocated
>    on the correct resources.
>  * Fixed initialisation of ctrl_val[] to ~0 when mba_sc is selected.
>  * Assorted style fixes.
>=20
> ---
> The aim of this series is to insert a split between the parts of the moni=
tor code
> that the architecture must implement, and those that are part of the resc=
trl
> filesystem. The eventual aim is to move all filesystem parts out to live =
in
> /fs/resctrl, so that resctrl can be wired up for MPAM.
>=20
> What's MPAM? See the cover letter of a previous series. [1]
>=20
> The series adds domain online/offline callbacks to allow the filesystem t=
o
> manage some of its structures itself, then moves all the 'mba_sc' behavio=
ur to
> be part of the filesystem.
> This means another architecture doesn't need to provide an mbps_val array=
.
> As its all software, the resctrl filesystem should be able to do this wit=
hout any
> help from the architecture code.
>=20
> Finally __rmid_read() is refactored to be the API call that the architect=
ure
> provides to read a counter value. All the hardware specific overflow dete=
ction,
> scaling and value correction should occur behind this helper.
>=20
>=20
> This series is based on v5.18-rc1, and can be retrieved from:
> git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> mpam/resctrl_monitors_in_bytes/v4
>=20
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> mpam/resctrl_merge_cdp/v7 [1]
> https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com
> /
>=20
> [v1]
> https://lore.kernel.org/lkml/20210729223610.29373-1-james.morse@arm.com
> /
> [v2]
> https://lore.kernel.org/lkml/20211001160302.31189-1-james.morse@arm.com
> /
> [v3]
> https://lore.kernel.org/lkml/20220217182110.7176-1-james.morse@arm.com/
>=20
>=20
> James Morse (21):
>   x86/resctrl: Kill off alloc_enabled
>   x86/resctrl: Merge mon_capable and mon_enabled
>   x86/resctrl: Add domain online callback for resctrl work
>   x86/resctrl: Group struct rdt_hw_domain cleanup
>   x86/resctrl: Add domain offline callback for resctrl work
>   x86/resctrl: Remove set_mba_sc()s control array re-initialisation
>   x86/resctrl: Create mba_sc configuration in the rdt_domain
>   x86/resctrl: Switch over to the resctrl mbps_val list
>   x86/resctrl: Remove architecture copy of mbps_val
>   x86/resctrl: Abstract and use supports_mba_mbps()
>   x86/resctrl: Allow update_mba_bw() to update controls directly
>   x86/resctrl: Calculate bandwidth from the previous __mon_event_count()
>     chunks
>   x86/resctrl: Add per-rmid arch private storage for overflow and chunks
>   x86/resctrl: Allow per-rmid arch private storage to be reset
>   x86/resctrl: Abstract __rmid_read()
>   x86/resctrl: Pass the required parameters into
>     resctrl_arch_rmid_read()
>   x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()
>   x86/resctrl: Move get_corrected_mbm_count() into
>     resctrl_arch_rmid_read()
>   x86/resctrl: Rename and change the units of resctrl_cqm_threshold
>   x86/resctrl: Add resctrl_rmid_realloc_limit to abstract x86's
>     boot_cpu_data
>   x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes
>=20
>  arch/x86/kernel/cpu/resctrl/core.c        | 117 ++++-------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  75 +++++---
>  arch/x86/kernel/cpu/resctrl/internal.h    |  61 +++---
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 224
> ++++++++++++++--------
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 212
> ++++++++++++++++----
>  include/linux/resctrl.h                   |  64 ++++++-
>  7 files changed, 493 insertions(+), 262 deletions(-)
>=20
> --
> 2.30.2
I tested this patch series on Intel(R) Xeon(R) Gold 6254 CPU with resctrl s=
elftest.
It is no problem.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
