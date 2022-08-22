Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BB959C92A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbiHVToa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiHVTo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:44:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5425F87;
        Mon, 22 Aug 2022 12:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661197466; x=1692733466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Uppklx7Q6yOyqZxgIFEsA3rXLWADYME30GnloRh0iSc=;
  b=Yudmb1CXa1VXIePa0yCMDerknrk9kvbyOWqIHvrRsAghIL+nLf1gNKqu
   ZR2ZKq9hb23/S0NqX/2HKk9yQaB6e4OnAWc8YtTak5S4lp/z0klE9ohxQ
   zuZhUxyjSsiHwRW1PStpNKo6ccJWcche0RkyrhBY5Xo3vgEauoXhabtGL
   FYyRnw1MaTdJuseIxKl/CABDCZ6PcwyMKqQcJhEC5j7O3MfsHtPhVa5vl
   P5YuaIzNtIuwT37pacjdahIh5NsAyDhH9XBnRINsKe0/+vj4Rc7rHGIN1
   W8C+2VpqLtBJj6z7Lw64hCYuImxk9AVYn/2raWfjDfVxYnhxb2BBdFhYh
   A==;
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="187583262"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Aug 2022 12:44:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 22 Aug 2022 12:44:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 22 Aug 2022 12:44:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL+e3kPEdPN7iDcIZcNqJquq7X766xOkl7lxS8uPc8CAs6G3vd1UI1DTI23wI/SjaxJae8E7+33+lb8tWzzCYPXQsnebvyjOJjmygeE97lZyk7tDnXevRM7F39qyDEivVx3iJn2BYdMaCXRHM4eu3BbqDeAbHztCiKxy9SVTAWHP1xFcY9mlfxiPmQVKBQMS1/v4xmDjHDFP3wfxJMDUdOJVPc8s1howRTPtP6Xvb3zm4HltUPhYLdv18LUFx6JQ4CBPa+XOYL1tDaRuVixLTrbbiPBOTAI0M/55Pwrte0evCP7yxiEhxOUkqbj2gVsr5MMhfr7TAuHRU9VbcEOIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uppklx7Q6yOyqZxgIFEsA3rXLWADYME30GnloRh0iSc=;
 b=mAkhr+opXBCIkweViqpQTM2b2WBj+R0dH/uFiTM7bCr9cGEXUJapgxoYBLClKexU5ghyHOhTZbi8HrqUimnkNheVayE6LqYruTCMYBRalCzTKmseEC2TJPsoVO8QlJaW10UBfNxwHq5FF5pkJnI5UWRXbF8FtvDTA4vvTGsIdVfpDVJPFTYkdP9mbXvVYSUhfXD6LrGKLndb96qgbYS1Jl8Sj1jHYYW9CLvaKZqbuYUW9OK0kz6AGmO7EJkVs3SOGR9xNKyp51hjS4mYkAgA/WUelAiudgQkwmZh7ZkVUTkX7t8i6uujzMmVp8xx0oOVt0XeHOW0UYYLpdwS8/LGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uppklx7Q6yOyqZxgIFEsA3rXLWADYME30GnloRh0iSc=;
 b=MZmufRN4CEZnNyRZodIkYwDbPBeQKHx+yjWFfIWRrNN5fYm9QdGhdEkbYz+ESQMUOu3kZvGRc1bu+4ObRyxPj+huBpw9pmWU/DZJRNGGX9D7XVVKdaCH0LEt0MTuNfzLC75dI4AqWyVKr6TqqGbWrpRBteD/AP5NzrwQugoN2eo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 19:44:21 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 19:44:20 +0000
From:   <Conor.Dooley@microchip.com>
To:     <robh@kernel.org>, <Conor.Dooley@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mturquette@baylibre.com>, <linux-riscv@lists.infradead.org>,
        <palmer@dabbelt.com>, <sboyd@kernel.org>, <aou@eecs.berkeley.edu>,
        <robh+dt@kernel.org>, <Hugh.Breslin@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <linux-clk@vger.kernel.org>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: clk: document PolarFire SoC fabric
 clocks
Thread-Topic: [PATCH v2 2/6] dt-bindings: clk: document PolarFire SoC fabric
 clocks
Thread-Index: AQHYthqSUVtMWR5Ot0GrcHpCiU3dwK27UesAgAABBAA=
Date:   Mon, 22 Aug 2022 19:44:20 +0000
Message-ID: <92e15fa9-65f4-1dea-48eb-f3afbea5d3f4@microchip.com>
References: <20220822112928.2727437-1-conor.dooley@microchip.com>
 <20220822112928.2727437-3-conor.dooley@microchip.com>
 <1661197242.557172.413609.nullmailer@robh.at.kernel.org>
In-Reply-To: <1661197242.557172.413609.nullmailer@robh.at.kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ab0ae0e-7550-40e2-8712-08da8476b543
x-ms-traffictypediagnostic: BN9PR11MB5289:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qLBO4gaN8NcOGIeT6XP9LPhP3QqG9pWAMltxKxw0h+l23aF/kIih+Ne0rWIQyDl/OqeJ2XCXOzYX9SQHBWhIXhzNGS/G4kwD7FFcc/cV0kExnAaf+TmfAtxAgzzpXs9SqLPSwxpFpBAz6iUlQkcL5FpOAgbL/BGQAz95v++c+aNQFi2gPFDtaOv3ZApYVjN0610tjwy7lSxxkF7HbJ3LA9l4KUQE0UhsSobZ7HkYC6A7bv8cZ3GzeCgE/AM2Sb3ZVshCV9rvQ9sxuQJ14PxhBbkMn4HHql1ewLGsjEGCjKRUme+e2DO0CA/0hhmX3EqXDqTe15kzdWFix+28zKBGJuBE70P075rogTCv5IcRp9Gr8OERRk+r+cjo+wy+LqLRi2xq+buvFHez1K1jxvGKigzxSDDcrdi4IIFDBAdXGg34at4s/xOxKfVSrrPhvSEZyVw7n5TJqf4rw66SVa0qpVgdTz64IuWI+9PPNTgQNyr7ntrDfWbmYWzXL85+FYxHsYNF+AODiw6KPTI9XDsCrTyzPh0DqV9eTcarpuNpEtzBWv0RcI1Xgbu7kuqrx5eNys8AiC9/yEEnMv1wqw+X6n5WHlXe1ccL2ImriDDwG+UgZGooeSjD1j2qO/lBdEW50DKpb9uqe/3vOxT6N1Yj9V1M1gcCC61OlVqBL8ApjSDFbMBH5fEjRZPeun7r+gpZYNqLiB2Vl/YBRHCKb3ZrgAV/UYD4yDYB2r54rpNqPwHw0H3Rf3nBMWoRioTuNuL4YB2IzR6XfLmUNf3ZTZBlhDpwQ52KBrdF0zm2f2GDUssPKiYKQXw8jbA0JTL+JTkD6f5FuYo9Ro2FWDuhgphAC2i/Yip4b+TEuJLw9rk+RXU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(376002)(396003)(346002)(2906002)(38100700002)(31696002)(86362001)(38070700005)(478600001)(966005)(6486002)(186003)(41300700001)(2616005)(107886003)(6512007)(26005)(71200400001)(6506007)(83380400001)(53546011)(5660300002)(7416002)(8936002)(122000001)(4326008)(54906003)(110136005)(91956017)(76116006)(8676002)(316002)(66946007)(66446008)(66476007)(66556008)(64756008)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2ovaFNaeVBYbUUrYWFWcEp5UFhPb09HTXVSMkk2MzBPT2dQRWZGU3k3SkRP?=
 =?utf-8?B?azFrR1dqWmowSWtKN0d5N1BuWS9DL09QdzNDWXFyS0hjLy8xdnVzR2lXKzIx?=
 =?utf-8?B?RDdZbmRzT1lEL1h2enJkbzdrektiNXRzUmJaWXV4YVUwektkQW5vUVhzT3Vz?=
 =?utf-8?B?MkJweEdpZS9kVXd4cGc3UHV4eXB5WkVXN1FzM3lVSTUvTy9aM0d5S3Q2Uy9Y?=
 =?utf-8?B?U2FyWnBQQkRTTWJMOE16R2FLbnl5VDlNMXpRRlpleS9CVUdmRldQUXJQeWRw?=
 =?utf-8?B?N1NEU3kwTXZrL2ZQSGFIWlcxdWcvaktaRFpmVTZ6ZkNEQnloczFCYmZzbXlM?=
 =?utf-8?B?NytVQ1EyazI1Z1BXMCtlcVY0cUoxaWR4YWxic1ZHWVdHMFlYbk8yZlFYQjl4?=
 =?utf-8?B?ejlGMmFKSm5xTzZZNlkrbm9VRXc5aHQ0U3BKd01SWFhCN3JDVVlCTTFsWnJw?=
 =?utf-8?B?bFE2TGE1U0NtSy82YXp0OUM4eW5FM3pndXJYRURSRkR0Zk5Nb1l5c2F1OWdT?=
 =?utf-8?B?KzkzZlFENUp6bUk3dGFIUGlOUFllQXBRU2NvTThMdWZHVFVWalBqZnN0OTZN?=
 =?utf-8?B?aVVYRzhWQWNZbkRWNjFWMHBLMEpVeDgzWU9mckpZek1tdVNkUjNpL0k3NmlK?=
 =?utf-8?B?OTYybXVEa01abVBrZnh3dG9FNXBhbTl0WitSSmgxWTZGWmRQZVhyb0NEd0tp?=
 =?utf-8?B?bVRoQ3FsbDJxam9Va3hBYkJweWJSVkhkenVaalpvWXhYQy9uSmtUbEt1Um9N?=
 =?utf-8?B?YWFDN1FUVUZ6NUxrRGd4K3hTN1JJeEpMbjBDRjZkeW1sTUNMK3llVjRUYm9I?=
 =?utf-8?B?eDJGZDZIRHY3QmU5c012c1FaY1FoKzBpaXUraTRxY1RXejBMeXZCT0NrdXds?=
 =?utf-8?B?NGZyTkhQcm9TWUpLdVhLeUpkSEhDOW9iNlFCSnZZd0R0dDQ5UEZXeDJTMFFr?=
 =?utf-8?B?T1cwaEc1QmdxZVIvTXdScUE5cXpwNVZQT2ZkUUQ0T2VJTUJLSnAyUnRrbFBM?=
 =?utf-8?B?THdmVThUU1V2cThacjNOSXp3N2ZiTkFPTWhjM3dUOTdvRlBzR1czRDhkRlpM?=
 =?utf-8?B?aFlLZmdFNDM2dTNiSkxYeTE4aERtaCtLeXpKQTd1N2NvSFY3UURWTmgyMU1u?=
 =?utf-8?B?d2hwMjFLc1BhOGdSL0JYOUJEQnp2TWNVVG8xUkZUZTVvdENDMXpCMkxCQSs0?=
 =?utf-8?B?V1lwNlhPWUxxTUFjWXdBUkQ1MXFNNVZscHJSRnY5K0JiS2hHMGpzYjZwSWdK?=
 =?utf-8?B?Zm5YVzNxdFFPdnEwcG9GUWY1OUwwMVNBOFlveXVWNmhsdmQrQ1dkRjBoZjk4?=
 =?utf-8?B?NnRUYlY4VjZndmkvY0xQdWY2MHJDNzA2MWlMdGlGS0svS2l1R3R3ZlFtY3Ix?=
 =?utf-8?B?Q1RVNVJrYStmY0R3aGNuR0FtMkxYNjdpMFdzSGZyVmdjclFmOU1ka3RHaHpV?=
 =?utf-8?B?bUozR3lxc0NaT0hEZGNjMkdGSmp3TlN6SVdzR1JJa0kwUjRuQjBSZnV6QldK?=
 =?utf-8?B?WC9EcUR5a1hHNFVoakJBQ1JMQkozYmJuYnhockg5YjRaZGpGZVlDMDEzU1ZS?=
 =?utf-8?B?djE0OCttT3hEbU45dHA3RlJnZHc5Mys1T1dvWjRqa2h4QTJudFc0eVpvM01C?=
 =?utf-8?B?a1JsQnN5RFpvdHR1cDhRbFRwTnFOdERoZFhMWThHRTU4SmRDUFJoVk9sY0J0?=
 =?utf-8?B?eWFXM3hma1A3YU5nSTM4YXF6WUR3Uy9zUWxsNzVwZmhqRnRXYlFwdDZqM1VG?=
 =?utf-8?B?Ty9xWlR1SVFDOXoyRzFrQnFvV2U1Z0gzNTcxRVNOTUdlbGZzVTBqWHhJNWZL?=
 =?utf-8?B?WWx2RW9NNzl4UTBnRlNEU3pTaDB1Q09XQ1VPVnJwNjNLYnpuejFWbGd5a3VB?=
 =?utf-8?B?NE1PR0d4cDVBeWlTTHQvTEN1RzJMZFF5cXBOcDNFOFB4QU5SY3M2MHFReUhW?=
 =?utf-8?B?YVJGTlpMTXN4T0g3QmRGWndYaE1XOTVhVHlnbGlaSitCZ0xZMDBQQTJmOVFl?=
 =?utf-8?B?THE3Y01hRGNONGc2dU5Xd2YxblF6YWZBMU1BaHpxc1RwMU1idXk1TkxwQ3V2?=
 =?utf-8?B?OGxlK25IZmwzLzUxQkhsNnE4K0JYaURIeEJxMmQ3T0IyZUU4ZVNISkk1WTUx?=
 =?utf-8?B?MkIrZTZOUEFsUUVOVnRNVDRUckdqMnhlVGFmckdXOXZtMFU4KzRRS0dMU05k?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5A5EE481183BD41A8C12739B62CE968@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab0ae0e-7550-40e2-8712-08da8476b543
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 19:44:20.8142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDtK2l6NbEWTMBMH27R9tuR4bDsqxpWAtBdRDIF3XdQOVSieZJ9hPO22kJxdQo0MoVcmNKST1MsU3zv4f1p706Q/1NnJ+K+C+2tOR8ShnTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMDgvMjAyMiAyMDo0MCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIE1vbiwgMjIgQXVn
IDIwMjIgMTI6Mjk6MjUgKzAxMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4+IE9uIFBvbGFyRmly
ZSBTb0MgdGhlcmUgYXJlIDQgUExML0RMTCBibG9ja3MsIGxvY2F0ZWQgaW4gZWFjaCBvZiB0aGUN
Cj4+IG9yZGluYWwgY29ybmVycyBvZiB0aGUgY2hpcCwgd2hpY2ggb3VyIGRvY3VtZW50YXRpb24g
cmVmZXJzIHRvIGFzDQo+PiAiQ2xvY2sgQ29uZGl0aW9uaW5nIENpcmN1aXRyeSIuIFBvbGFyRmly
ZSBTb0MgaXMgYW4gRlBHQSwgdGhlc2UgYXJlDQo+PiBoaWdobHkgY29uZmlndXJhYmxlICYgbWFu
eSBvZiB0aGUgaW5wdXQgY2xvY2tzIGFyZSBvcHRpb25hbC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAg
Li4uL2JpbmRpbmdzL2Nsb2NrL21pY3JvY2hpcCxtcGZzLWNjYy55YW1sICAgIHwgODEgKysrKysr
KysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspDQo+PiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9j
ay9taWNyb2NoaXAsbXBmcy1jY2MueWFtbA0KPj4NCj4gDQo+IE15IGJvdCBmb3VuZCBlcnJvcnMg
cnVubmluZyAnbWFrZSBEVF9DSEVDS0VSX0ZMQUdTPS1tIGR0X2JpbmRpbmdfY2hlY2snDQo+IG9u
IHlvdXIgcGF0Y2ggKERUX0NIRUNLRVJfRkxBR1MgaXMgbmV3IGluIHY1LjEzKToNCg0KSGVoLCBi
ZWVuIHdhaXRpbmcgZm9yIHRoaXMgb25lIGFsbCBkYXkuIE1lc3NlZCB1cCBzcXVhc2hpbmcgY29t
bWl0cw0KYmVmb3JlIHNlbmRpbmcgdjIuLi4gZml4ZWQgbG9jYWxseSAmIEknbGwgcmVzcGluIGxh
dGVyIGluIHRoZSB3ZWVrLg0KSSB0cmllZCB0byBtYXJrIGl0ICJjaGFuZ2VzIHJlcXVpcmVkIiBp
biBwYXRjaHdvcmsgc28geW91J2Qgbm90IHdhc3RlDQp0aW1lIG9uIGl0IGJ1dCBJIHRoaW5rIHRo
YXQgZ290IHJldmVydGVkPw0KDQpUaGFua3MsDQpDb25vci4NCg0KDQo+IA0KPiB5YW1sbGludCB3
YXJuaW5ncy9lcnJvcnM6DQo+IA0KPiBkdHNjaGVtYS9kdGMgd2FybmluZ3MvZXJyb3JzOg0KPiAv
YnVpbGRzL3JvYmhlcnJpbmcvbGludXgtZHQtcmV2aWV3L0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9jbG9jay9taWNyb2NoaXAsbXBmcy1jY2MuZXhhbXBsZS5kdGI6IGNsb2NrLWNv
bnRyb2xsZXJAMzgxMDAwMDA6ICdjbG9jay1vdXRwdXQtbmFtZXMnIGlzIGEgcmVxdWlyZWQgcHJv
cGVydHkNCj4gCUZyb20gc2NoZW1hOiAvYnVpbGRzL3JvYmhlcnJpbmcvbGludXgtZHQtcmV2aWV3
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9taWNyb2NoaXAsbXBmcy1j
Y2MueWFtbA0KPiANCj4gZG9jIHJlZmVyZW5jZSBlcnJvcnMgKG1ha2UgcmVmY2hlY2tkb2NzKToN
Cj4gDQo+IFNlZSBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLw0KPiANCj4gVGhp
cyBjaGVjayBjYW4gZmFpbCBpZiB0aGVyZSBhcmUgYW55IGRlcGVuZGVuY2llcy4gVGhlIGJhc2Ug
Zm9yIGEgcGF0Y2gNCj4gc2VyaWVzIGlzIGdlbmVyYWxseSB0aGUgbW9zdCByZWNlbnQgcmMxLg0K
PiANCj4gSWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIGFuZCBkaWRu
J3Qgc2VlIHRoZSBhYm92ZQ0KPiBlcnJvcihzKSwgdGhlbiBtYWtlIHN1cmUgJ3lhbWxsaW50JyBp
cyBpbnN0YWxsZWQgYW5kIGR0LXNjaGVtYSBpcyB1cCB0bw0KPiBkYXRlOg0KPiANCj4gcGlwMyBp
bnN0YWxsIGR0c2NoZW1hIC0tdXBncmFkZQ0KPiANCj4gUGxlYXNlIGNoZWNrIGFuZCByZS1zdWJt
aXQuDQo+IA0K
