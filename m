Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7323D5AA754
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiIBFl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiIBFlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:41:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35E58C037;
        Thu,  1 Sep 2022 22:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662097282; x=1693633282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TzTw7jVdoabmpPwY/+fCwAY9hfWjQHp6u0HVV+052qY=;
  b=aRV5mF6vYUZdAcQEi0/kdgWNG6bptVgBPtrxG7l4T2H6VImjzZJ/cps/
   avXgzzb1WAoXOizjqpvKbtm3CXJHAKrMToYx4Xh2ilpRXr7vSSIk7fdzF
   1lKGt/XFE50IKefn9sEM7YdEIsXbqay4/AO6YGCLg2diK84X47SrZBi9/
   XP1k13pwjKfjgUHxrAH3PxhPff95bpkeVNvWJQa3v/vrzcx4xIPP/k6C8
   Bu+IsvpHoCR0tCIIi9DYgHUfzdjFNwPSweTO+a2xHIbnE5Cc5cC7R7pi0
   Obgqy111F2fnD6zod9e4r75RqjitT8+L94Pb1h1/iglfflKfyX5QkveTc
   A==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="178746502"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 22:41:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 22:41:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 1 Sep 2022 22:41:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4sCwoIgje0td0uEZKYL+j/smLUS9eLreHGnJ+DbJvKj+ev/zsiijve+Ts1IC6UE7sqnQouTXI9IFpzF+U+zXy6QwKga1J5rmM7dZ6OGG53zEo/IbHRC8mW+yUju7h4h6Ync9bGxDDZuTtwEzewdJJ9mfui+xMSLQ0Hz+PBIw8G+iRZyUgREhUiDHow3HCU+FuvrPpgm+HxeuVkPKbSf0UjUMxWRY5Zs5XXAhFUtQMbgjmOFKmMMzmEK4HrQQfLJeBSLkzHnD+62A/aWF+LrUCgD+O/roPoAJd0+iS9M39SHzSgtzP9W0gZyji9ImSdHzCY7oZLnLIlxOMnLJvBNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzTw7jVdoabmpPwY/+fCwAY9hfWjQHp6u0HVV+052qY=;
 b=dSHyqWZae6S3J0/cSq/9bQLzN2Cj7Hl2xQsgILXpU6a120QbxVTdv2a2r9mrbNHl30UR0nn6cyKWse/BYbZwYdSqV5ZHbQzC2bPRVLzMLZ4YcDIcsoUguLsEqlNaZgfRWs/fxBsDJevQlu9TJG9KTJVjqv3S1KAWX5Z3zvkX+jU/hiGYQJzB/9TArwZHGmOrErVu2/z/vB3FDAz19Adsch5TKoUvQTyFLkRdTIKeBqlEntrAXm8HwmwXOf3H3oyv1KADnbUjiIwYnmi/KFvY1YMUYxwef4QR6KBFNguvOmXHJDxxLWjn6UBIZ7z7lcJs5PBLaq90+i3tlIMsU7vjPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzTw7jVdoabmpPwY/+fCwAY9hfWjQHp6u0HVV+052qY=;
 b=MxNVaM2X+lpze5p2G1CYdGg9KlRQuPOpvCerPQMNLqQQzKlVLlK5ibzfBN8XMZyHPf8+HDUvqAkRJh+fexFrU10RWa4qBYQP4EcJQO5JjDQiQfXUVVNHx6Kr4DUBzRXgR8Oa2wNK0I/VypKPOr59NL1E8vB7OAJtRMbbfxfsN0o=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB4577.namprd11.prod.outlook.com (2603:10b6:5:2a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 05:41:18 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 05:41:18 +0000
From:   <Conor.Dooley@microchip.com>
To:     <cristian.ciocaltea@collabora.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <michael.zhu@starfivetech.com>, <drew@beagleboard.org>,
        <kernel@esmil.dk>
CC:     <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
Subject: Re: [PATCH 1/3] dt-bindings: riscv: starfive: Add StarFive VisionFive
 V1 board
Thread-Topic: [PATCH 1/3] dt-bindings: riscv: starfive: Add StarFive
 VisionFive V1 board
Thread-Index: AQHYvlReYzhKr+GYqkG/LxjAgTXzD63LoJWA
Date:   Fri, 2 Sep 2022 05:41:18 +0000
Message-ID: <e5c57ddd-91ff-a2be-439a-5b82fbcf2506@microchip.com>
References: <20220901224253.2353071-1-cristian.ciocaltea@collabora.com>
 <20220901224253.2353071-2-cristian.ciocaltea@collabora.com>
In-Reply-To: <20220901224253.2353071-2-cristian.ciocaltea@collabora.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17da20c4-0935-4918-248f-08da8ca5c222
x-ms-traffictypediagnostic: DM6PR11MB4577:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GzGme02MCLhWG4k6JYPqFWgLo3LAVDnj/HhNuwLym3+/4YJb3Tau7zlh5MAiR7eGZfgtmUSg7bS7bQVSTOcYvQKsRluA9Yt6N23iKU0OjcSQex/G8znNCLqTA5POxRoRjZilGZcNVFIItcPZg80Ur9nabfLdsF5FSbA5YDQpjMtP+GLo6AMuEiy7KPFJQe0evyucbymQ5CJuYYRFFmYztbTeKpKv15p8ryI0hEeoeeYgvJefo19b6AS8anV/jhvcnU+mhpnSfLOmz1Mwvg+1iHb0O5uSYYykZ7gK5RAWmE8c6qbvcS+o0mzZbcZgi2gVMv0mTuOiVwTRHjGty9yBek8wybVoll9MN5iAj+AusF/K5pZV+Li0m1TJBKz70oWlHlhRtdvJy+ZIdjNNatwVmCnIHyaCe8A1s+I8bFp/EsYP6qBBBPHNwb+V7O3suLoMHsEguD24hYDwCiXE8DRflP+C8A7wvhacN1tRVclLdTjO8sCcO9RdODo3og/7TcYQfVWQEXP2o5L7IpIpF+Ylyw4jMCXgI7bJ/JroH0ICSz91QXEH2qD2GdKKV7cR/dkJdhyM5/ewfeU+eUWmVzTVAltk7cE5xY5lK+m9fWwUu22TPnLhcsgH3Ut3AhQAA7KepI1MEuERAe4LlE/zDH7TepzIj4cjFqTD8ONw4+RiI/XrdoZM6qSfQJQj4RhGRwE1ejPidhzAfm872UEbFej9hApZeI/Ami1TdX/d22cc+q8mukNrhCA8KL8/c9HX2zRv0k25ZFwxwIEGPbAn9zXKqxz1TByeMQLMzpwrWWfMtI68Fco15Cxax4AKvE8VCAAut/UDZExmKM5/YUoSrlle4NAdNAF0hFVi0mZy8BAY99+pXPYWI+S9ZiytVRxXyrzV6wassbSZ6/W4T8uiyJZU9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(396003)(376002)(136003)(2906002)(186003)(36756003)(7416002)(26005)(31686004)(6512007)(2616005)(38070700005)(66556008)(66946007)(91956017)(66476007)(8676002)(66446008)(64756008)(4326008)(76116006)(5660300002)(8936002)(86362001)(31696002)(316002)(54906003)(966005)(6486002)(110136005)(41300700001)(53546011)(6506007)(122000001)(478600001)(38100700002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU44UXNoN3VPelh0Wk9TREQxejFjUGc2dGplSXpETkV1dGpUVDB1TW82OXN2?=
 =?utf-8?B?OHVscTMvam9TcmdnUWZYbzhRZkwwMW5zSS9UY3QzMEVwVEtMOHpGbVpoRVhk?=
 =?utf-8?B?Ym9hR0tETzNjSFU5WEtZdXAzQVJTS3Z1cFRzMG5DTUxtajZ1Z0lNRTNJYW5y?=
 =?utf-8?B?c0dwemxLcWcyVkZZekRvUkFzZkx2bUQxOFBWNEdjVXFlZWdDU1lpSkJQUmNr?=
 =?utf-8?B?bnJNVlJ6a0xnU3NLQXNuR3g4ZklrVnhhbnpDS2Rqc2xyU0ZPejhEeFc0RDQ0?=
 =?utf-8?B?RjZvb2pQMW11a3JsUFRjb3ZWOHhUcFY2MVBHREsyMTlwcDBuMlN3TGZabmJl?=
 =?utf-8?B?bXY4WUV3U0IvSXZqWitGeE05NDNoYXQ3M3VteGoxMnhSWmVDUkRjQ2VuTllq?=
 =?utf-8?B?TVhWOWRjbndvS1M5OXVpQ0FROGRRY2ltMGVjNzRlSzNTcjVZbkNqTE1tS29m?=
 =?utf-8?B?Y3hKcnlRRDBrRElPazZvOTRBQ1lwcndqUWpxak5VT0JubFpNcTR6UXdFejU5?=
 =?utf-8?B?TDVOMG9JNHJRUCt5ZDBmMmI2T3VIRUxjaFJyWFUwWGM5eGdRbTJPOGpTa082?=
 =?utf-8?B?bVhJV01KbnJmVTlnTElzV0R2dG1EYlNGU0lyN2JHK3lzNlRZYlpKVHZPMUVs?=
 =?utf-8?B?Smk1NUtNMVB5d2pYVWYvUFE4VlFkWXJDajJwQXJDVzBhOXJDS3J3aU13cWtD?=
 =?utf-8?B?VVJ1WDZVRzM5T294eVVUTXdSbjMrdlBvSjBQMGc3M3ZHY3dHZkNsTWtsRW9r?=
 =?utf-8?B?U0FNWG9ad0FEbGhsNkhTcXJjNlBTQUsxVzBvSHYxbENmdlpmU2U0ZzJYWTBV?=
 =?utf-8?B?VW1oNlpoK2swWERkSDlCaFhyZ09na3R6dThodjM5UjkxckwwVndwNXRhb3Ni?=
 =?utf-8?B?NnYvNnNrbjZJL0xrR3NjQ1NhN2s3YmNaeHA0NncwTm04cFYwYlJjTlZTc1p4?=
 =?utf-8?B?UWswTUdwV1ovOG1sb2RPTFZaNjRtcGxMd1JDTmhHZVAzWExIWGhKQytHUWVO?=
 =?utf-8?B?WHNpWU44a3Q4YnJGbHRwcnNzYi9oSVdJRGsyL2pSYldJenE1ZTVwOWY1bDRo?=
 =?utf-8?B?emVVb201U1pUR3dOWUhpMlB3U3U5UXVESjdiYy9NYUJMRkR3SEVRSUl1QWJM?=
 =?utf-8?B?Tkt6NDg4SmVnUFM4VnBlTmxwRGtnT0x1MEdIWGtjQXA2cityUVJwcEdseDJQ?=
 =?utf-8?B?U2hBZTZRWjJuK0xjcDJuSDVkZEpZREpqZVFCbjVWYjI0Qk1iY1FJMW9uZEdI?=
 =?utf-8?B?cEpZcU5RbTkxUFl1VE9KVGhZUnN0YnpVbUN6Y0VYMmF5aUU4a1VydzFYdkFu?=
 =?utf-8?B?d1lpYS9JZGpxRHo5eGZmUHNsS1hTbzRiSkdyNUk3eGNWVVhlcU5obzI1RGgr?=
 =?utf-8?B?M1hXNjQ2UEJhcDcwclg5bEE4YUJlWkk0UGhTeG9oZ0g5MmRCS1RqMGdCakhn?=
 =?utf-8?B?RU9IaFZ1WXJaQlNLTUdPRWxEUFVLSzJlOXl5d3g3Zzh4OXAvcWNTdWZjYzJY?=
 =?utf-8?B?NUlDbHViZk40dWtlWWR5bHJ2Wk1ZWG1yUUxETk5wYVV4ZlY5NUxxdml5SWZS?=
 =?utf-8?B?RnJxVnBGUlZlL0taR2pYQk5Jb2xjOTAzRlBmSVlRd2k4d3VUcHlhbmdGMmRy?=
 =?utf-8?B?YjBvbE84Wlh3VzlXV2JybXNoa0lkV2ZTWUk0QTB4S2lBZlZMelVmdEQvRDR2?=
 =?utf-8?B?RnB4eDlSTTFnaEhZZUlqUVpnZnRWa2VHUWFNbUE0Z08ydjFpYisvd01Eb0RS?=
 =?utf-8?B?RzJUajlmU2JsSWE3ZDVqV0tBSkZzeHZnc1YrdFNQVERJNExLcWF1T3drQzV1?=
 =?utf-8?B?UzBTa0wwV2ErZDBxNVdmOFBieUhxekRvbS9zN2RabVI3U2hvQ09vRXhlOThE?=
 =?utf-8?B?VXdDNEVjT0lOWTNQT0JTRXNXNWtCY1ZKNUN1N0VaUG94cDgwWGVYT0hRYm1C?=
 =?utf-8?B?R01FNUoxdXgxSmlwRXprYjRTM3U5SWlFbHVIcE0xdVl1R2pyVWhjUElBL2Ew?=
 =?utf-8?B?dFBJcFNvK3hLZCtoK0pPRHo5NkM0aXZsZzBUWk1iaXQ4SnV4QlNuc0swSEVl?=
 =?utf-8?B?Q2tKR1FHR1A4bHdSRHVDM3lrbjlCZU5KYVBxVDA0YlYzUUxoYjAzUWdlOTRC?=
 =?utf-8?Q?sBt7EI1qZ8tqDeQK3Rl0Ca8rt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC25E10228677C479E0C59A59638E733@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17da20c4-0935-4918-248f-08da8ca5c222
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 05:41:18.0544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWHzrxjf4xb79I0qJnAwn5sfneyvUnHYd8BbE66LD0TIPbotF50IB6pB4K8K20G9uHHr9Q9IQus87mv3QzZypw3n1FRDJ7coQ8f4tWs2HGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4577
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IENyaXN0aWFuLA0KDQpPbiAwMS8wOS8yMDIyIDIzOjQyLCBDcmlzdGlhbiBDaW9jYWx0ZWEg
d3JvdGU6DQo+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gY3Jpc3RpYW4uY2lvY2Fs
dGVhQGNvbGxhYm9yYS5jb20uIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczov
L2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiANCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBEb2N1bWVudCB0aGUgY29tcGF0aWJsZXMg
Zm9yIFN0YXJGaXZlIFZpc2lvbkZpdmUgVjEgU0JDIFsxXS4NCj4gVGhlIGJvYXJkIGlzIGJhc2Vk
IG9uIHRoZSBTdGFyRml2ZSBKSDcxMDAgU29DLg0KPiANCj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNv
bS9zdGFyZml2ZS10ZWNoL1Zpc2lvbkZpdmUNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENyaXN0aWFu
IENpb2NhbHRlYSA8Y3Jpc3RpYW4uY2lvY2FsdGVhQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2L3N0YXJmaXZlLnlhbWwgfCAz
ICsrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9zdGFyZml2ZS55YW1s
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2L3N0YXJmaXZlLnlhbWwN
Cj4gaW5kZXggNWIzNjI0M2ZkNjc0Li45Yzk0OGIzNzljOGYgMTAwNjQ0DQo+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9zdGFyZml2ZS55YW1sDQo+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9zdGFyZml2ZS55YW1sDQo+
IEBAIC0yMSw2ICsyMSw5IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgICAtIGl0ZW1zOg0KPiAgICAg
ICAgICAgIC0gY29uc3Q6IGJlYWdsZSxiZWFnbGV2LXN0YXJsaWdodC1qaDcxMDAtcjANCg0KQ2Fu
IHlvdSB1c2UgYW4gZW51bSBoZXJlIHBsZWFzZT8NCg0KPiAgICAgICAgICAgIC0gY29uc3Q6IHN0
YXJmaXZlLGpoNzEwMA0KPiArICAgICAgLSBpdGVtczoNCj4gKyAgICAgICAgICAtIGNvbnN0OiBz
dGFyZml2ZSx2aXNpb25maXZlLXYxDQo+ICsgICAgICAgICAgLSBjb25zdDogc3RhcmZpdmUsamg3
MTAwDQo+IA0KPiAgYWRkaXRpb25hbFByb3BlcnRpZXM6IHRydWUNCj4gDQo+IC0tDQo+IDIuMzcu
Mg0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQo+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0KPiBsaW51eC1yaXNjdkBsaXN0cy5pbmZy
YWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtcmlzY3YNCg0K
