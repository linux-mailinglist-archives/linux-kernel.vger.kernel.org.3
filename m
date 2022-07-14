Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1D15751C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbiGNP1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiGNP1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:27:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF99474C8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657812433; x=1689348433;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jGC5ZfKdhaw1xtGGRQ2hdUqqCVxwiWKPbvS2yOoeEXo=;
  b=OlK0zz9IvJAjHSLk32jA+WgmYscvyh+ukH0foUMxZF+QMhaGtSnSRaA7
   vdfFt3wgTAFEfNbq4HU3I6XdXA4GA3iFxqGjNuns0DtUMgRzzYUwobXun
   ppef2LtqKeJ5cIgHNOz31qm8rQLg9fLekGjU4l0qtvjK08YrLNbgUJO8a
   4N5zf9qk9BibQpZJkdUlSjy3umI8759rv+2lcA+V60uyN5M9X0LC15Q8t
   6PhV2Od7SL84b/o4x0xovOuyIB1oNp7mY1Fu6RQtpuqnwm321QbX30AAO
   dbOcZ7JraoZHHGf6cLcRBCpkoQWUcvMCDnvxy6mP6IE9QEzt1Tn8daUTb
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="167851292"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2022 08:27:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 14 Jul 2022 08:27:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 14 Jul 2022 08:27:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj1nJ6sH1O5HX6Rk+3+eItF+yM+Mg3XBukN4dzy0AbU96gluAR2o0Waz9f+U1uY7GqWc7kNtFjpO2ec+pHdYKh5/aPW9+xNqZqYu4XyGdTE+UQxZ2SnsyIG6P8HW9YtICbePWrRvSWWZEb5HH9fkoTDIiFzNoKlmO/y+zloeYHkzLVFBg9OrUmFwF73BkYFdvw/iCrN/SrsO2woIU/c8YCNI8lujA6LHRx2TBA4rzaQMAxS6Hx+WE8O/oVWiIAJ7ZMKHw6QJTrNt6mTmf3vLjk6CUE0hvEK1V9Iowx2cTUDvNxfmlFvOiNCPy3SrKmTYZ4uZbb12DdBcle2a+Yhqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGC5ZfKdhaw1xtGGRQ2hdUqqCVxwiWKPbvS2yOoeEXo=;
 b=HYGiQs4gC8B0Vd0i08Fcxq1kZeJCuyDlXVK+jTv44aiQu9+kFehnkPsPNx8QI3pGb/JqhFBpsRO9d+2oDKkMsdp8DV+Z2oFA6hBSRAgAea0p9tZE4qXMhF/jOkCHByvbTt+ZNOd7GEb10DawG4Ifspkvd2WbXMXoKx3hr9DpdhiwzccUfiGDIsWV0vpeA36Gf5GyjL5XtSBw9cyvmMoT8wLQklX0ZJIoq/FH/yeEBXjo8b5L54btjMNJ2k7VtGLcZESPP0DMEN6VjRDtI89swxWwSLMuLmgNsdE0BzWtH+B4b7IjJNgbeqtm6ay3J2588g7BhBz0smHR4Xznff9JEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGC5ZfKdhaw1xtGGRQ2hdUqqCVxwiWKPbvS2yOoeEXo=;
 b=NikR4rhz9Cita03xXVZcVBkLUoNEXA8613l04rYXLrhrOLPcay57HvP3PdZ21MA/8+YNvBtMadUUty9bkn/JXi2mR0MTbUzzb7Vq+oT13iSr9JoLSFNCDAKAwH9ym5IIgIzlU3iiFg/SxhUjjIt7OvUgtdQPU22nmWtPdLiC/3Y=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB2537.namprd11.prod.outlook.com (2603:10b6:5:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 15:27:10 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 15:27:09 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <Conor.Dooley@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Thread-Topic: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Thread-Index: AQHYlr1LjktvAhTwm0O5ibr9nGIi2q19638AgAAMFQCAAAdOgA==
Date:   Thu, 14 Jul 2022 15:27:09 +0000
Message-ID: <f9b13298-5a0b-34ee-44b9-90168205cc59@microchip.com>
References: <20220713133344.1201247-1-sudeep.holla@arm.com>
 <0abd0acf-70a1-d546-a517-19efe60042d1@microchip.com>
 <20220714150100.aqvmdgjkymc2dr5t@bogus>
In-Reply-To: <20220714150100.aqvmdgjkymc2dr5t@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55bf0567-3a95-4ee7-7863-08da65ad5199
x-ms-traffictypediagnostic: DM6PR11MB2537:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zWQ+JwVKhoCgR2838G4Z2PG2MxTjrdxjuT9qEw/8fj+tY6NZ+3Nu/30n8s11wnU284DNKJhSbOouzy1kArq6SHWVX0b5EGpjbjc7+H0rM/ELibrEufpk1qATeRTuebhWZ4yCpFqqCJJwYK/X0HiaSTQElXboSpjnH9f6FNAjJ6iMQiJR8X5z+kJwyN4GA9t6600jGpAJLTxwV7aze5hpRCYlc9d7YYWXllvh4aWU/tGOcXKB9tTbxntqQ2JMvVR3KtvujakDbvHimTib+JzU3gJc1MTyw/ZswjxGu/SBxnVEFe/Z5CupUfES4BpYLO0whfC3ZBRR8bH8U7r6oyYYegFf3aPJAgshEBlTuAt0lVw5XZ9Ra/KZdDdMIWyuRxsv6XM9wQ03LR+hX/B7CKxEVZ7WQXVbJTsOTl9UDMmL0jk9r2uxNxVCEbvnOl24UdXYDicojd7G423NQGZx/WliOwYvKHnu4JZwe57aIhOD8V30hu6BU/vL47NCoPIlh9w8/ZD2yGA0gLJtIqDzfRp4XECPtPcjcb2TQfMmU1lqFbsczlVwHlwjlM2ccj2fOs0o62/ODQbFbfah3hAPhqMniGdYqvLTlAvFp+ju4WSQu/r959/1ZK1XX2MHgDb1de+nURdeAfG7+tbU91djH7e7xIPJeuTIhxSqKHKQkPicNrI3JeLLJ1ghBHahSRGjeO1ZzulCp2SGUXQBahL57MZMddNKhkW2fl3kF9IPAtqJMblbw+zNONWQYEvXCVhdVz0cqYwbbnapFvBdairvGFJAsTHvfLzmZX33FDDVVT1sdD0sWK4bf/F9dW5mKo0jEDXkNV46AREqedK5qDp1d8lS9+oB6do8/EOm0cw8u/ezhoG9MHgY1Uk3qWNLU+Yyv+vs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(346002)(366004)(396003)(53546011)(71200400001)(316002)(38070700005)(6506007)(6512007)(8936002)(86362001)(478600001)(6486002)(31696002)(36756003)(5660300002)(26005)(122000001)(4326008)(31686004)(8676002)(76116006)(66556008)(66946007)(66476007)(91956017)(66446008)(64756008)(110136005)(41300700001)(186003)(2616005)(83380400001)(54906003)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b290WmpyY3NYZkdrZzZrWVdHS1llWlRXZytyZXlFK1Jkb21kdFNSNjBxSGF5?=
 =?utf-8?B?VmRMWCtDbjViNzRGRTJSNkNrMENoOUxZQ3hWT1BVdmtXZGdMTHFaaVRMamNG?=
 =?utf-8?B?MXlIYU1GSElmQjVKcDMwYXZRNEpZbXpKZC9yekxWM0MrOTdJOGU3UkZVbndn?=
 =?utf-8?B?Zld4R1pLL2oyU3ZXcWtGa0xFVDBXVG5YUy83VjRwMjUyaVM2dmorV25jT0VB?=
 =?utf-8?B?S1N3WWVoemdaVE91U2ozZHkzeG1adncvUDlMRURDRmxSWXgxTDY0ZU5zNDU3?=
 =?utf-8?B?Mzd6WVFvU2JJTDVOZGtpcDlDMVdiTW5McjVHNVJsNE1TTmJjNFpjQ1U5SXdL?=
 =?utf-8?B?UC9wYThpNE10MkNBOUlZMDMwaVk5dUtBVXJ1Q2NDdzc3ckVza1NhMzUyRTB6?=
 =?utf-8?B?WmlQbWs2aW1LSi9oM2QyZmJmUVpJdlkrNVExM1VMbmJGR01aYTFHVzhxMUdr?=
 =?utf-8?B?YVBHRUpXcExRSHBlRUdiQlhveVZ5b0Y3dVZ6aWV1cjlaM1g0YWJsb2RYalo1?=
 =?utf-8?B?eGVSK3pXandYVVQ5elFFaHl3OCtrTlcxckZNSUhwOVg2VXdCeU5BSm5JSVpo?=
 =?utf-8?B?YnZITjhoOXZzejR5c2s1YUx4MnJMbVgrSWV5V3NabkNiZWRFVlVlMlFYZkFo?=
 =?utf-8?B?bjJFdjlXdnIxa2NsOUFzaHBIQ2dHTDhvdmI1K2Y5REVyZlVLSU5qVXRSNkpk?=
 =?utf-8?B?c0cxc0JUUUpLSE9jYjN6bDdkNGxCd1Zubm9IZVQvaTFCOUU4S0xTNW9xVjBt?=
 =?utf-8?B?a2FwVUprS2tuNXJ4RVc2OHdoMC9rOWtIUFpXQVVzMXdaV2FDbm5qUExENGlL?=
 =?utf-8?B?UkgxWkZqVFlZSlhYOG9PbWlKT1BFYjl2cW0rM2gvbzFyRzZWL0tSY0J4dllp?=
 =?utf-8?B?Tzh0NTNNSURNbit0OFlBTldIS0hzbjk5d0pEM2c2ZWZweWlDd2wzZnp6THA4?=
 =?utf-8?B?UjN6azY3K3k5ZG1MblJ4SVZWU3pIUWV4V2tQQUw4b1JyV2p0S3EvMVRDSEZn?=
 =?utf-8?B?SWlRVzFUM1ZvdHNGVzRPbzRSdEVlWkdnUmR0ekFHMmlyVFVucGd2UmtoRHZ3?=
 =?utf-8?B?NGpSQjhyZlJ4b2NBdGdKSDhRUGVrUjdOM21RaG9xcWVEaGFiR2FKQk51SVRr?=
 =?utf-8?B?ZGV0dDZZNjBLU0F1NDh5VWxRa1JSNkFIaHExTHU3cFZqT2ErVUJPd1FtZllV?=
 =?utf-8?B?Wkw2Ui8xcG9XQzNFV3FNVTlYdXV2VVg2WFAwY0FVMDBsYmttZUQxdTUzYTVm?=
 =?utf-8?B?cVVTenFaaXhkRHZpdURKamdJWTB0dnk2aFZVbjBEKzRDZDRtM1ExalFtdmpN?=
 =?utf-8?B?dUV3NFdjdFpkZ3hsMlJxbDhiTmNVNnIxWWRybHpoQjZxUUZJOTJnN3hpQXpi?=
 =?utf-8?B?NXhSdjI0Zk8vNm14aldwN2oxSC9POFYzWDd6MHdUMTZDVjFQK0xpRWJvVGRx?=
 =?utf-8?B?UVhLOWZHU3hRMWI1WUNnRnc4VGpMbnlzNmpRSTNPNHY0Tk5maHRlc21lVTBo?=
 =?utf-8?B?ZGNzQjhDeG1vZ2xEa3IrQTF6QmxzbWllZi9OaHBYSC9jRm5kaTNSb3QvZ3RC?=
 =?utf-8?B?WGJkc0FRY1hock85SXYxc0tNdDJxM1VjTElYZHpVYmpaT1dzWXh2d24yb2ls?=
 =?utf-8?B?dlpnaTdKM2JDb1NIdlJETTFMd3crSVcyVHZxejI5NkJ2aUpYYkpvRkNianVP?=
 =?utf-8?B?ZHlTdVBtTW5uMjFxTVlSQ296YlNmdEdPU1ZXQ0FUQ2M5Z0dHTWhPeWxCQ28v?=
 =?utf-8?B?TGQyMWdiNUUvRFd2STBqYkxvWHZualR1bEpuUnJRREpmdmduWXJ2dWRkcmVn?=
 =?utf-8?B?ZVZpeVVHMFF6Y1ZjOEdpbmVXMitLQ3hSK2JvdHkzdWI1QkRhL1hwTDBlZVlL?=
 =?utf-8?B?SFl6eXBya2I2YlRQU08vMS9zS1RveHRaNGNpSUwyUDNTSGo1VVFNWFd4djZ1?=
 =?utf-8?B?SzdSc1BmY3NBT3ZMVkx4UElHbmhnN2ZSbWQyWEtOcFhYTm1ISmN3RXhiaEpz?=
 =?utf-8?B?OFFKVFNrN0FYRS9BdnBxSCtFQis2WktVVUlMdHh2OXp2OW0vTnk3T1RJRVhz?=
 =?utf-8?B?VVhkQ2MwQjJFS3RKbEhsYkdWbDhic1k3S1Z0MytXbG9hZTB2bFhkSjlid1ZO?=
 =?utf-8?B?cyt6R1I2djdGSTVjcHp0R3pGR1A3TWIvZEhENHdmUkwxbC9ZMkg3aHRONmQ4?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <754BF887A885334CBA40242E0A79314F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bf0567-3a95-4ee7-7863-08da65ad5199
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 15:27:09.8481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3jFQyGdLnvoxps9Q4AgyDPGBMk19ZxxUsQ06wUQMQGHArjUVmn+Y3PeLPEPSVFz/qhja1+q2S3npnQAdB9jQCMFIn2LAzQCyTvFcWZHtNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2537
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQvMDcvMjAyMiAxNjowMSwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBPbiBUaHUsIEp1bCAx
NCwgMjAyMiBhdCAwMjoxNzozM1BNICswMDAwLCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3
cm90ZToNCj4+IE9uIDEzLzA3LzIwMjIgMTQ6MzMsIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4+DQo+
PiBIZXkgU3VkZWVwLA0KPj4gSSBjb3VsZCBub3QgZ2V0IHRoaXMgcGF0Y2ggdG8gYWN0dWFsbHkg
YXBwbHksIHRyaWVkIGEgY291cGxlDQo+PiBkaWZmZXJlbnQgdmVyc2lvbnMgb2YgLW5leHQgOi8N
Cj4+DQo+IA0KPiBUaGF0J3Mgc3RyYW5nZS4NCj4gDQo+PiBJdCBpcyBpbiAtbmV4dCBhbHJlYWR5
IHRob3VnaCwgd2hpY2ggSSBzdXNwZWN0IG1pZ2h0IGJlIHBhcnQgb2Ygd2h5DQo+PiBpdCBkb2Vz
IG5vdCBhcHBseS4uIA0KPiANCj4gQWggdGhhdCBjb3VsZCBiZSB0aGUgY2FzZS4NCj4gDQo+PiBT
dXJlbHkgeW91IGNhbiBmYXN0IGZvcndhcmQgeW91ciBhcmNoX3RvcG9sb2d5DQo+PiBmb3ItbmV4
dCBicmFuY2ggdG8gZ3JlZ3MgbWVyZ2UgY29tbWl0IHJhdGhlciB0aGFuIGdlbmVyYXRpbmcgdGhp
cw0KPj4gZnJvbSB0aGUgcHJlbWVyZ2UgYnJhbmNoICYgcmUtbWVyZ2luZyBpbnRvIHlvdXIgYnJh
bmNoIHRoYXQgU3RlcGhlbg0KPj4gcGlja3MgdXA/DQo+Pg0KPiANCj4gR3JlZyBoYXMgbWVyZ2Vk
IG15IGJyYW5jaCBhbmQgYWxsIHRob3NlIGNvbW1pdHMgYXJlIHVudG91Y2hlZCwgc28gaXQgc2hv
dWxkbid0DQo+IGNhdXNlIGFueSBpc3N1ZSBhcyB0aGUgaGFzaCByZW1haW5zIHNhbWUgaW4gYm90
aCB0aGUgdHJlZXMsIEkganVzdCBhZGRlZCBqdXN0DQo+IHRoaXMgb25lIHBhdGNoIG9uIHRoZSB0
b3AuIERpZCB5b3Ugc2VlIGFueSBpc3N1ZXMgd2l0aCB0aGUgbWVyZ2UsIG9yIGFyZSB5b3UNCj4g
anVzdCBzcGVjdWxhdGluZyBiYXNlZCBvbiB5b3VyIHVuZGVyc3RhbmRpbmcuIA0KDQpTcGVjdWxh
dGluZyBiYXNlZCBvbiBpdCBiZWluZyBhICJjb3VsZCBub3QgY29uc3RydWN0IGFuY2VzdG9yIiBl
cnJvci4NCg0KDQo+Pg0KPj4gQWN0dWFsbHksIHdlIGFyZSBub3cgd29yc2Ugb2ZmIHRoYW4gYmVm
b3JlOg0KPj4gICAgICAwLjAwOTgxM10gc21wOiBCcmluZ2luZyB1cCBzZWNvbmRhcnkgQ1BVcyAu
Li4NCj4+IFsgICAgMC4wMTE1MzBdIEJVRzogc2xlZXBpbmcgZnVuY3Rpb24gY2FsbGVkIGZyb20g
aW52YWxpZCBjb250ZXh0IGF0IGluY2x1ZGUvbGludXgvc2NoZWQvbW0uaDoyNzQNCj4+IFsgICAg
MC4wMTE1NTBdIGluX2F0b21pYygpOiAxLCBpcnFzX2Rpc2FibGVkKCk6IDEsIG5vbl9ibG9jazog
MCwgcGlkOiAwLCBuYW1lOiBzd2FwcGVyLzENCj4+IFsgICAgMC4wMTE1NjZdIHByZWVtcHRfY291
bnQ6IDEsIGV4cGVjdGVkOiAwDQo+PiBbICAgIDAuMDExNTgwXSBDUFU6IDEgUElEOiAwIENvbW06
IHN3YXBwZXIvMSBOb3QgdGFpbnRlZCA1LjE5LjAtcmM2LW5leHQtMjAyMjA3MTQtZGlydHkgIzEN
Cj4+IFsgICAgMC4wMTE1OTldIEhhcmR3YXJlIG5hbWU6IE1pY3JvY2hpcCBQb2xhckZpcmUtU29D
IEljaWNsZSBLaXQgKERUKQ0KPj4gWyAgICAwLjAxMTYwOF0gQ2FsbCBUcmFjZToNCj4+IFsgICAg
MC4wMTE2MjBdIFs8ZmZmZmZmZmY4MDAwNTA3MD5dIGR1bXBfYmFja3RyYWNlKzB4MWMvMHgyNA0K
Pj4gWyAgICAwLjAxMTY2MV0gWzxmZmZmZmZmZjgwNjZiMGM0Pl0gc2hvd19zdGFjaysweDJjLzB4
MzgNCj4+IFsgICAgMC4wMTE2OTldIFs8ZmZmZmZmZmY4MDY3MDRhMj5dIGR1bXBfc3RhY2tfbHZs
KzB4NDAvMHg1OA0KPj4gWyAgICAwLjAxMTcyNV0gWzxmZmZmZmZmZjgwNjcwNGNlPl0gZHVtcF9z
dGFjaysweDE0LzB4MWMNCj4+IFsgICAgMC4wMTE3NDVdIFs8ZmZmZmZmZmY4MDAyZjQyYT5dIF9f
bWlnaHRfcmVzY2hlZCsweDEwMC8weDEwYQ0KPj4gWyAgICAwLjAxMTc3Ml0gWzxmZmZmZmZmZjgw
MDJmNDcyPl0gX19taWdodF9zbGVlcCsweDNlLzB4NjYNCj4+IFsgICAgMC4wMTE3OTNdIFs8ZmZm
ZmZmZmY4MDE0ZDc3ND5dIF9fa21hbGxvYysweGQ2LzB4MjI0DQo+PiBbICAgIDAuMDExODI1XSBb
PGZmZmZmZmZmODAzZDYzMWM+XSBkZXRlY3RfY2FjaGVfYXR0cmlidXRlcysweDM3YS8weDQ0OA0K
Pj4gWyAgICAwLjAxMTg1NV0gWzxmZmZmZmZmZjgwM2U4ZmJlPl0gdXBkYXRlX3NpYmxpbmdzX21h
c2tzKzB4MjQvMHgyNDYNCj4+IFsgICAgMC4wMTE4ODVdIFs8ZmZmZmZmZmY4MDAwNWYzMj5dIHNt
cF9jYWxsaW4rMHgzOC8weDVjDQo+PiBbICAgIDAuMDE1OTkwXSBzbXA6IEJyb3VnaHQgdXAgMSBu
b2RlLCA0IENQVXMNCj4+DQo+IA0KPiBJbnRlcmVzdGluZywgbmVlZCB0byBjaGVjayBpZiBpdCBp
cyBub3QgaW4gYXRvbWljIGNvbnRleHQgb24gYXJtNjQuDQo+IFdvbmRlciBpZiBzb21lIGNvbmZp
Z3MgYXJlIGRpc2FibGVkIGFuZCBtYWtpbmcgdGhpcyBidWcgaGlkZGVuLiBMZXQgbWUNCj4gY2hl
Y2suDQo+IA0KPiBPbmUgcG9zc2libGUgc29sdXRpb24gaXMgdG8gYWRkIEdGUF9BVE9NSUMgdG8g
dGhlIGFsbG9jYXRpb24gYnV0IEkgd2FudA0KPiB0byBtYWtlIHN1cmUgaWYgaXQgaXMgbGVnYWwg
dG8gYmUgaW4gYXRvbWljIGNvbnRleHQgd2hlbiBjYWxsaW5nDQo+IHVwZGF0ZV9zaWJsaW5nc19t
YXNrcy4NCj4gDQo+Pj4NCj4+PiBBbnl3YXlzIGdpdmUgdGhpcyBhIHRyeSwgYWxzbyB0ZXN0IHRo
ZSBDUFUgaG90cGx1ZyBhbmQgY2hlY2sgaWYgbm90aGluZw0KPj4+IGlzIGJyb2tlbiBvbiBSSVND
LVYuIFdlIG5vdGljZWQgdGhpcyBidWcgb25seSBvbiBvbmUgcGxhdGZvcm0gd2hpbGUNCj4+DQo+
PiBTbywgb3VyIHN5c3RlbSBtb25pdG9yIHRoYXQgcnVucyBvcGVuU0JJIGRvZXMgbm90IGFjdHVh
bGx5IHN1cHBvcnQNCj4+IGFueSBob3RwbHVnIGZlYXR1cmVzIHlldCwgc286DQo+IA0KPiBPSywg
d2UgY2FuIGlnbm9yZSBob3RwbHVnIG9uIFJJU0MtViBmb3Igbm93IHRoZW4uIFdlIGhhdmUgdGVz
dGVkIG9uIG11bHRpcGxlDQo+IGFybTY0IHBsYXRmb3JtcyhEVCBhcyB3ZWxsIGFzIEFDUEkpLg0K
PiANCg0KV2VsbCwgb3RoZXIgdmVuZG9ycyBpbXBsZW1lbnRhdGlvbnMgb2YgZmlybXdhcmUtY29t
ZS1ib290bG9hZGVycy0NCnJ1bm5pbmctb3BlblNCSSBtYXkgc3VwcG9ydCBpdCwgYnV0IChjdXJy
ZW50bHkpIG91cnMgZG9lcyBub3QuDQpCdXQsIGlmIG5vLW9uZSBlbHNlIGlzIHNwZWFraW5nIHVw
IGFib3V0IHRoaXMsIG15IGFyY2gtdG9wbyBjaGFuZ2VzDQpvciB5b3VyIG9yaWdpbmFsIHBhdGNo
c2V0Li4uDQo=
