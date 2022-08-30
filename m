Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA365A6942
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiH3RI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiH3RIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:08:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84620A9C23;
        Tue, 30 Aug 2022 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661879332; x=1693415332;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=5ILjFA7npDOVzkJXrNqxeM8bScoDbegYp2C0DnfWjZQ=;
  b=c++QcE2S39cOnEZc7lRd5+0P6BEpgpMXU2MJ+TkgOBuwSnWUp2PdAYz0
   wusQQ83sDG+HIzWI9Kns9oiZJqmkmJZTg6Sj11jDW0XcnhQvP4MA2nf/L
   643A5RyQBUHMMmfeCnM2vOawN2XWTH3YooVBPhNu9LXZV6+M83Eyubf2e
   esBr+JNeNiDFN18OhiAvOVlHa+Ym8Btc/FAgKSYIoYe0wN90R6oqpOZsL
   TKiXP0i8nt52DOQTk5xXbuO80XNNMc5RlLTJvYzV+qhK80LQ69ewQL8xE
   MPCiZKxolw/xw8tFr/S4WKB9e+SuI8V7GKx7UVznm3zTRq5ibsffhCBzY
   g==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="188690185"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 10:08:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 10:08:51 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 30 Aug 2022 10:08:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rw2tXWLZ322A2EzOMXZ6tsGSHpZhl6tZHZvomRvFq743iqmS6TdmK/hdkRRr9UaHkXYJPrwPcQdcdIruTMYk8shGxnYXX1w0SBCk1zTE0hewwdVOKHUGAlOEB8QuKSt+LxstUhfvCeMLBhJzFpBXccOZKENwgxbSfolkoDFIkbEvKjj7wIiUPF3PMR1clPtR8Lso+rsl6Ki0N9JFD+vD83NBhiGgyVhxVDFPmyVYCFoSUgTmcQFt1knu4kWuEICfe/fAEdjxBZHDS5UPI9ZGNbhhOjw08BMqQ5tJf5mrnZp4XnKlN+CLO0TcaqXWKPLWxawU/HyWiUQTsfPQOVZVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ILjFA7npDOVzkJXrNqxeM8bScoDbegYp2C0DnfWjZQ=;
 b=XNniumdVvLQkhak3CNyWYjLFhCldtnnVPureX+Qge8E+E5YkNTwJM0enHbtaVcAT904SR7Sge5sc1vEUnzqOTQiCa1WDcH+2seo5GfcpEoaglcV9NEAwNOx3bHafi+4F20+h4jvUlht0IAMl997ocPF53LCuppFptwYG565JoxNapOXbjgWzNq4SncFjNLxX5OnnpUz4NPSi10pIY0scZORVLcB4N7UNONVNB06vzpeD4/+u5Cr7TZq7Ob0Iwd1YFuiRfVS/tbvJilGImljosqFKLhx1N7HZO45e2QlWDxKrV0OhNJAeB/RJmh3F/6L5CML16f4D0CuPsS7D8KptZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ILjFA7npDOVzkJXrNqxeM8bScoDbegYp2C0DnfWjZQ=;
 b=Ca31osiD8BQJhr80mpW2uyCJzqgEXIHfuHsMgTN3nvE1Rx5dPwk+F0rqTWlWWFKKw2ghle1nNzoq0VXCtIPzUCmaYMIHJ4jwOAf+4wEeReavao9KKAHdB6WXuqcaqw5LAYpUN/ymYoGAYCZBHzC79xE6pgE1V5YCd2T7HMbNp2w=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN9PR11MB5531.namprd11.prod.outlook.com (2603:10b6:408:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 30 Aug
 2022 17:08:49 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 17:08:49 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ben.dooks@codethink.co.uk>, <Conor.Dooley@microchip.com>,
        <ben.dooks@sifive.com>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>
Subject: Re: [RESEND PATCH] dt-bindings: sifive-ccache: fix cache level for l3
 cache
Thread-Topic: [RESEND PATCH] dt-bindings: sifive-ccache: fix cache level for
 l3 cache
Thread-Index: AQHYvG9DsO2L31s8JEW+tF32qWQ5gq3HZuqAgAAAiQCAAA5EgIAAMmEAgAAFYYA=
Date:   Tue, 30 Aug 2022 17:08:49 +0000
Message-ID: <6d58cdeb-044d-b83f-79a2-fb9b86491c8b@microchip.com>
References: <20220829062202.3287-1-zong.li@sifive.com>
 <20220830125133.1698781-1-ben.dooks@sifive.com>
 <b810d354-18f3-9ae0-6310-57d9e36f4f9b@microchip.com>
 <6b6837c1-5a2c-567b-ba64-72a1dca38807@sifive.com>
 <8422fb34-fc05-eddd-0eaa-3e713896d05d@microchip.com>
 <c2f86a2a-a30e-5fac-de6c-6a28edc5bcee@codethink.co.uk>
In-Reply-To: <c2f86a2a-a30e-5fac-de6c-6a28edc5bcee@codethink.co.uk>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ea75f5a-15a4-47a3-1f9b-08da8aaa4e97
x-ms-traffictypediagnostic: BN9PR11MB5531:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KFhyM5IHO6jBxigwbxs/OSQ/q8/fMBwe15d0eoHyPDkzDh77RaHFi7ELM3mZjzUNWQChaGJzJgVb3D+TozwrjfRhy+gDTqg8u7kf7YDK6BGjBQyDMq88WU0R729sUhZSw8sp1cxWRaNfvmdNDI7nVInwF6Gokov49eOsJbwOErot6Hdgqn8U8hMTS325mQHp4j+VskEq+WSmdCi3wFdC9F8TfRQK8L8EdTOqft+KNAOfXWyFVMx99VQ/EpDd6mfoJTwT+C/Q/VIQOl6yyHVmsRxGN+4NEdM0p3Q7EhZAFR6rXphT5aLzzjl5MYSCC4/Z7XUdHMJPDOe1kAnOiR9FchmPOq4cT8KDbbynV0b+L6R5SDwHngaP5CchUDCXonCDCTFOpUP8VRJP1SDt9vafudSC13Qn0bvZCMvVln3Dj30t8416E4svzcY9TdOqKdaSqkZIH8krGt6dNzPs5+dz6Uh/LtpucIHnZTRfnxZ8Pyoo+b9ClRuA71qIyHq+R5obbjRexH90I/GNr/z6LoerFPtQVHOw7PQ4U0rAiP9cvUr9ij3KBqr2YYShSQJHc9NWUC3WPcH+30Jk+c2gWbg/FoS1sD5IjGpwC5wYNWL9kiOeEIf/PKCxr7Um5xKcDrPck12nz1QO55UKhb7gZ5BDWFmqXQcIXLx2m3oZGAvlRH/qbsNsQZ+KJE8QLT+f+5gCCXWvOLp52cwmkmLKeBL0hjaVIn3p0WxXxzoykf0MRfbgKt6DpcO48B7kmRE60TlTXePzOppVpGnwYhHJSmBwIYIX2mjV+rPu630TK9CR6InJNmSdTKyDtMWHRfnmDaE+hNiUsHLFNgP7GSY2UHuk5Oj+YbhIPeLujss7/smD0jjimHuMnT9Z9Ir9RCrVijBW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(346002)(396003)(366004)(6512007)(31696002)(53546011)(86362001)(71200400001)(478600001)(966005)(6506007)(6486002)(41300700001)(26005)(38100700002)(186003)(122000001)(921005)(38070700005)(83380400001)(66476007)(2616005)(66446008)(5660300002)(66556008)(66946007)(110136005)(7416002)(8936002)(64756008)(8676002)(31686004)(2906002)(316002)(91956017)(36756003)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkJUMnh6MnF5NzNnUzhMSGhMTEZZZWZGOUZ2cW1NQ2tYR0tZVk5Cajc0VWRT?=
 =?utf-8?B?NE1qaUNJM29HTEdxZ0dCbXc4Rlp4ZnpSZ0Ryc2FJWHdHcFRFUVI0VXM3bnJX?=
 =?utf-8?B?ZFkzSDdxR2RMb3VXK01SUFN6ZEdqb0JDV1RlRzg0dTNYem9VRElvVy84S2pD?=
 =?utf-8?B?ZE9ORWxIaXdUMnh2SGJNZUlRZGhlV2s0enR2cDFVeU1JTU9nYXVseEVFY1Nt?=
 =?utf-8?B?bGZSSUZCZ2ttNGxmMk1RNVBVMm1NT1VOeGcrcEhaRSsvN3NKVVVoVHlNSkd6?=
 =?utf-8?B?L0tKWW0zSXUxOUtjMml3NGp2eUJTRHFHKzZLN01LMW1zZnRNMnMvRWg2dHF6?=
 =?utf-8?B?VnpUMVlENXJTbUVJaVY5NCs5MjFVZ3RBTG9CTjlXc2d4a1pyZlR5Sk95bUNq?=
 =?utf-8?B?RDRJcmREdHBDc292V3ZlNkd1Q2ZEbnNmNGRpZEtkNWhNbjMrSjlWL1ZDRnBy?=
 =?utf-8?B?bFQ0MGJ0ckUrcTJmbFpsTlF2b2JzSzJDTVJqRnJ6VUw2ZkVGa1h3aFg2Nyt3?=
 =?utf-8?B?N1JoQ25tV0NoczJpWjY1T0RmWWljeFJlZDdCTTlSRkptdDJ6L1Z3V2xFV0Ny?=
 =?utf-8?B?TmJpbXRkQnk1ZU9KKytROEdyQmtLdTFCN0JmaVl2U3NGb0E0L2lyMWFHZFZP?=
 =?utf-8?B?NWNmUm4xblQxUWZUOFJoV0F2QjN3NURmeVBWeWUrYTZEMGF5L1RZVklZMzVE?=
 =?utf-8?B?ZlV2bkQ5dDNzRVVwajVjTTVCWnlYejVycjVjVTVrbnpOakFiUmR1N1h3ZE1U?=
 =?utf-8?B?WC9ic3JKTTdZcUhaL0E4RkRSZ2dxNmdtZHlDemhEMitCVGtzZXVFdzFlWERW?=
 =?utf-8?B?MTQ4NlhicUxBLzQ2ckxsSG5VY3pJcmtmUFF4d3h1UUkvKzhXS3pha0UzT2Nr?=
 =?utf-8?B?SG8wL0VwQlhTdDBvNG83eWYwbGZ3c0RYdVE4NXdNcnFSeWdHUHdGRnBnREpk?=
 =?utf-8?B?T3hGZ20yTjI3WThnTHkwZ0owWEdsWHBxcE5YUHduT3NsRTJ0QzBCTjJDeTBY?=
 =?utf-8?B?Si9RcU0xYlo0UUs0S3VTUTRadXZ2dHY1TmZHWU5Oems3UkoxNjFyYWVLZTlG?=
 =?utf-8?B?UHdsd3VrNVBtMkg4WUI4MHpKdXVmVEI1YzR2ZzhDVjB5dHdsYjgrOUdTOHBE?=
 =?utf-8?B?UC91aVFkaXB3T1FLTVNBc01wOXpmQThxc3UwbzFzamZ4a0ZnejBsZjlWSVhB?=
 =?utf-8?B?VnRuSW1YRnRRQUxSd0xzUzdFclM2R1E2ZVJPN3FXWVZaTGUvSlZZeUJEWHlZ?=
 =?utf-8?B?Z0NrcnZLeGVHU3hiVUswRDg5YlBlVUdYZmtNSFlBRUVMVTVJdWk1cExHZnA4?=
 =?utf-8?B?bGNsMnQxK2R0eTJWc1NaRE9YcDlPVkdLcmRZQXczWkY5ZjZPOGVsUXNHcEc0?=
 =?utf-8?B?UENKb25SRGFhMGNzeEtrRUFKNVNPY0pjZm9sYUxGcktodFJDMkkwaW9SYlN2?=
 =?utf-8?B?NnJPbXhsZkRvL1BNWHJabzBVOWVTN2ZHZWovZlZLdmVTT1BOYzFpSTAzVEFo?=
 =?utf-8?B?QUhUTnptZ3BKeWdqblhlQ2NqVW1CTHBjUk9vL1BPOFdhZTU4TWloeGIxQnR0?=
 =?utf-8?B?ajFSTFl5dEZUUWYva2gyWUhCem16UVBhY2k4ZmRuUDMwYkpkcTdxNndGUjg5?=
 =?utf-8?B?V1YwM2NRenBseWZqamptUU1sc0NNVlR6NTM1SEJudjhvdFJKNkliQk95ZElE?=
 =?utf-8?B?U3BQR1VlM0N3dkx4VWtTSTRrbGo4aG90emYzWXRDUVY3b2FFN0lFYit3MlVU?=
 =?utf-8?B?NGJkYkVZUjByVnordk5RQ2o4UGdzcXhKaGZtQ2VKaHhicXpDd2h6MGkweG5t?=
 =?utf-8?B?TjhIZGYwUktYbnpacmxEelR1Z2p5L2hTSjFGSjU4blZiZW5tMnJOMXFLQkJG?=
 =?utf-8?B?cWdQMGlmOUY4NUM2THczcWVXN1BHMlN0aG5Na3ZFcEVQTWZnbllINjV0dFps?=
 =?utf-8?B?Rk0yYzQzUXZncFZMbFBCdDFmRlJ2VjViM2FSM3lacTRqV3pMVDUwdzFxSU9H?=
 =?utf-8?B?ZU1pYmI3WFE4TUpCZ0ZBZDc3cklFcDZIWWFtc0xHMGpDMU1JamRlYVkxaWEz?=
 =?utf-8?B?S25aS05ObFM4UnphbXpkeTRtbWRCc3RPYkJUTmVCcjM0aThUdWo4TzBBSWJT?=
 =?utf-8?B?RGdHNEFVa0h5TlVybFFSejVVU0JLM3RXME9FVnlmUnF3YmxDREFMTkRUM2Zt?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1048AA24FCB02649BBD286517806FA2D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea75f5a-15a4-47a3-1f9b-08da8aaa4e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 17:08:49.3791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LTP5+KLo5noRg9gKcDlmdxGkc0KQSmODHb+83pZAf93X4AvCLN14+th5/+lhQPpACVqE6ZyNkHzCuzgN2CHsJE0EkAtbos+jYvwwf6OEmvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5531
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDgvMjAyMiAxNzo0OSwgQmVuIERvb2tzIHdyb3RlOg0KPiBPbiAzMC8wOC8yMDIyIDE0
OjQ5LCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDMwLzA4LzIwMjIg
MTM6NTgsIEJlbiBEb29rcyB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlz
IHNhZmUNCj4+Pg0KPj4+IE9uIDMwLzA4LzIwMjIgMTM6NTYsIENvbm9yLkRvb2xleUBtaWNyb2No
aXAuY29tIHdyb3RlOg0KPj4+PiBPbiAzMC8wOC8yMDIyIDEzOjUxLCBCZW4gRG9va3Mgd3JvdGU6
DQo+Pj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pj4+DQo+Pj4+PiBX
aXRoIG5ld2VyIGNvcmVzIHN1Y2ggYXMgdGhlIHA1NTAsIHRoZSBTaUZpdmUgY29tcG9zYWJsZSBj
YWNoZSBjYW4gYmUNCj4+Pj4+IGEgbGV2ZWwgMyBjYWNoZS4gVXBkYXRlIHRoZSBjYWNoZSBsZXZl
bCB0byBiZSBvbmUgb2YgMiBvciAzLg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEJlbiBE
b29rcyA8YmVuLmRvb2tzQHNpZml2ZS5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+IMKgwqDCoCBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3Yvc2lmaXZlLWNjYWNoZS55YW1sIHwg
MiArLQ0KPj4+Pj4gwqDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcmlzY3Yvc2lmaXZlLWNjYWNoZS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3Jpc2N2L3NpZml2ZS1jY2FjaGUueWFtbA0KPj4+Pj4gaW5kZXggMWE2
NGE1Mzg0ZTM2Li42MTkwZGViNjU0NTUgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3Yvc2lmaXZlLWNjYWNoZS55YW1sDQo+Pj4+PiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3Yvc2lmaXZlLWNjYWNoZS55
YW1sDQo+Pj4+PiBAQCAtNDUsNyArNDUsNyBAQCBwcm9wZXJ0aWVzOg0KPj4+Pj4gwqDCoMKgwqDC
oMKgwqAgY29uc3Q6IDY0DQo+Pj4+Pg0KPj4+Pj4gwqDCoMKgwqDCoCBjYWNoZS1sZXZlbDoNCj4+
Pj4+IC3CoMKgwqAgY29uc3Q6IDINCj4+Pj4+ICvCoMKgwqAgZW51bTogWzIsIDNdDQo+Pj4+DQo+
Pj4+IERvIHdlIHdhbnQgdG8gZW5mb3JjZSB0aGUgY2FjaGUgbGV2ZWwgbGlrZSB3ZSBjdXJyZW50
bHkgZG8gZm9yDQo+Pj4+IGludGVycnVwdHMgYW5kIGNhY2hlLXNldHM/DQo+Pj4NCj4+PiBOb3Qg
c3VyZSBvbiB0aGF0LCBmb3IgdGhlIFA1NTAgY29yZXMgdGhlIGNjYWNoZSBpcyBnb2luZyB0byBi
ZSBsZXZlbDMNCj4+PiBhbmQgbXkgY29sbGVhZ3VlIGhhcyBzYWlkIGl0IGRvZXMgY29uZnVzZSBz
b21lIHRvb2xpbmcgaWYgdGhlIGxldmVsIGlzDQo+Pj4gbm90IHNldCBjb3JyZWN0bHkuDQo+Pg0K
Pj4gV2hhdCBJIG1lYW50IHdhczoNCj4+IEN1cnJlbnRseSB3ZSBlbmZvcmNlIHRoZSBjb3JyZWN0
IGNhY2hlLXNldHMgJiBpbnRlcnJ1cHRzIGJhc2VkIG9uIHRoZQ0KPj4gY29tcGF0aWJsZSBzdHJp
bmcuIEFkZGluZyBlbnVtOiBbMiwgM10gcmVsYXhlcyB0aGUgZW5mb3JjZW1lbnQgb2YgdGhlDQo+
PiBjYWNoZS1sZXZlbCBmb3IgZXhpc3RpbmcgY29tcGF0aWJsZXMgYW5kIGRvZXMgbm90IHByZXZl
bnQgc29tZW9uZSBmcm9tDQo+PiBzZXR0aW5nIGFuIGluY29ycmVjdCBjYWNoZSBsZXZlbCBmb3Ig
cDU1MCBjb3Jlcy4NCj4+DQo+PiBJIHRoaW5rIHRoYXQgb24gdG9wIG9mIGFkZGluZyB0aGUgZW51
bSwgd2Ugc2hvdWxkIGFkZCBzb21lIGVuZm9yY2VtZW50DQo+PiBzbyB0aGF0IHRoZSBjYWNoZSBp
cyBub3QgaW5jb3JyZWN0bHkgY29uZmlndXJlZCBmb3IgYm90aCBleGlzdGluZyBsMg0KPj4gY2Fj
aGVzIGFuZCBmb3IgdGhlIG5ldyBsMyB2ZXJzaW9ucy4NCj4gDQo+IE9rLCB3ZSBjYW4gYWRkIHNv
bWUgZW5mb3JjZW1lbnQgb25jZSB3ZSBhZGQgdGhlIG5ldyBiaW5kaW5ncywgYnV0IEknbQ0KPiBu
b3QgcmVhZHkgZm9yIHRoYXQgdG9kYXkgYW5kIEknZCByYXRoZXIgZ2V0IHRoZSBjdXJyZW50IHF1
ZXVlIHNvcnRlZA0KPiBvdXQgZmlyc3QgYmVmb3JlIHdlIGNvbWUgaW4gd2l0aCBuZXdlciBzaWxp
Y29uIHdoaWNoIGhhc24ndCBoaXQgdGhlDQo+IG1hcmtldCB1ZXQuDQoNClNHVE0uIE1heWJlIHRo
aXMgcGFydGljdWxhciBwYXRjaCBjb3VsZCBjb21lIGF0IHRoZSBzdGFydCBvZiB0aGUNCnNlcmll
cy4gQW5kIHRoZW4gd2UgY291bGQgYWRkIHNvbWV0aGluZyBzbyB0aGF0IHRoZSBlbmQgcmVzdWx0
IGxvb2tzDQpsaWtlIHRoZSBmb2xsb3dpbmcgKHdoaXRlIHNwYWNlIGRhbWFnZWQpIGRpZmY6DQoN
CmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3Yvc2lm
aXZlLWwyLWNhY2hlLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvcmlz
Y3Yvc2lmaXZlLWwyLWNhY2hlLnlhbWwNCmluZGV4IGNhM2I5YmU1ODA1OC4uOTk0ZTRiMTQzNDg1
IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2L3Np
Zml2ZS1sMi1jYWNoZS55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcmlzY3Yvc2lmaXZlLWwyLWNhY2hlLnlhbWwNCkBAIC0zMyw2ICszMyw3IEBAIHByb3BlcnRp
ZXM6DQogICAgIG9uZU9mOg0KICAgICAgIC0gaXRlbXM6DQogICAgICAgICAgIC0gZW51bToNCisg
ICAgICAgICAgICAgIC0gc2lmaXZlLGNjYWNoZTANCiAgICAgICAgICAgICAgIC0gc2lmaXZlLGZ1
NTQwLWMwMDAtY2NhY2hlDQogICAgICAgICAgICAgICAtIHNpZml2ZSxmdTc0MC1jMDAwLWNjYWNo
ZQ0KICAgICAgICAgICAtIGNvbnN0OiBjYWNoZQ0KQEAgLTQ1LDcgKzQ2LDcgQEAgcHJvcGVydGll
czoNCiAgICAgY29uc3Q6IDY0DQogDQogICBjYWNoZS1sZXZlbDoNCi0gICAgY29uc3Q6IDINCisg
ICAgZW51bTogWzIsIDNdDQogDQogICBjYWNoZS1zZXRzOg0KICAgICBlbnVtOiBbMTAyNCwgMjA0
OF0NCkBAIC0xMTUsNiArMTE2LDIzIEBAIGFsbE9mOg0KICAgICAgICAgY2FjaGUtc2V0czoNCiAg
ICAgICAgICAgY29uc3Q6IDEwMjQNCiANCisgIC0gaWY6DQorICAgICAgcHJvcGVydGllczoNCisg
ICAgICAgIGNvbXBhdGlibGU6DQorICAgICAgICAgIGNvbnRhaW5zOg0KKyAgICAgICAgICAgIGNv
bnN0Og0KKyAgICAgICAgICAgICAgc2lmaXZlLGNjYWNoZTANCisNCisgICAgdGhlbjoNCisgICAg
ICBwcm9wZXJ0aWVzOg0KKyAgICAgICAgY2FjaGUtbGV2ZWw6DQorICAgICAgICAgZW51bTogWzIs
IDNdDQorDQorICAgIGVsc2U6DQorICAgICAgcHJvcGVydGllczoNCisgICAgICAgIGNhY2hlLWxl
dmVsOg0KKyAgICAgICAgICBjb25zdDogMg0KKw0KIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxz
ZQ0KIA0KIHJlcXVpcmVkOg0KDQoNClRoYXQgd291bGQga2VlcCB0aGUgZW5mb3JjZW1lbnQgZm9y
IGV4aXN0aW5nIGNhY2hlcyBhbmQgYWxsb3cgeW91DQp0aGUgZnJlZWRvbWUgdG8gZG8gdy9lIHlv
dSB3YW50IGZvciB0aGUgY2NhY2hlMCBjb21wYXRpYmxlLg0KDQo+IA0KPj4gQFpvbmcsIGNvdWxk
IHlvdSBwbGVhc2UgaW5jb3Jwb3JhdGUgQmVuJ3MgcGF0Y2hlcyBpbnRvIHlvdXIgVjI/IGl0DQo+
PiB3b3VsZCBtYWtlIGl0IGEgbG90IGVhc2llciB0byByZXZpZXcgd2hhdCdzIGdvaW5nIG9uIGhl
cmUuIEl0IG1heQ0KPj4gYWxzbyBtYWtlIHNlbnNlIHRvIGFkZCB0aGUgY29tcGF0aWJsZSBmb3Ig
dGhlIHA1NTAgY2FjaGUgd2hpbGUgd2UgYXJlDQo+PiBhdCBpdC4uLg0KPj4NCj4+IEZZSSwgdGhl
cmUgaXMgYWxzbyB0aGlzIHBhdGNoIGhlcmUgb3V0c3RhbmRpbmcgYWdhaW5zdCB0aGUgbDI6DQo+
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi8yMDIyMDgyNTE4MDQxNy4xMjU5
MzYwLTItbWFpbEBjb25jaHVvZC5pZS8NCj4+DQo+PiBJIGludGVuZCB0YWtpbmcgdGhpcyBpbnRv
IDYuMC1yYzUgb3Igc28gYXMgYSBmaXgsIHNvIGlmIHlvdSBjb3VsZA0KPj4gcmViYXNlIHRoZSBz
ZXJpZXMgb24gdGhhdCBzbyBpdCBpcyBub3QgbG9zdCBpbiB0aGUgZHQtYmluZGluZyByZW5hbWUN
Cj4+IHRoYXQgd291bGQgYmUgZ3JlYXQuDQo+IA0KPiBEbyB3ZSBuZWVkIHNvbWVvbmUgdG8gdGFr
ZSBjaGFyZ2Ugb2YgdGhpcyBzZXJpZXM/DQo+IA0KDQpDYW4gSSB2b2x1bnRlZXIgWm9uZz8gKHNp
bmNlIGFsbCBidXQgdHdvIG9mIHRoZSBwYXRjaGVzIGFyZSB0aGVpcnMpDQoNClRoYW5rcywNCkNv
bm9yLg0K
