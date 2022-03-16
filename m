Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B7C4DAF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355549AbiCPMLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiCPMLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:11:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9687A53B52
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1647432593; x=1678968593;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=1kQMpMmJlMugt1lI9oAgfEhJcZX4wJ4U0jzdDN6PJKA=;
  b=DYwc8pgl5hWyk/CbHXtp2ckwztJy2kX78kTuhCPlKAvNwna+ZftGdN9D
   ullKDrL8cO0Bb5BBhPslRgkHS3WlfrFC73lOQ1YwJh0z7b/0k6QUiDDAa
   v6yuN4cPgy5BkDO9MypXTqbE3R0JuFuwXiADkj9Brelx4e/hHlnp4aYEu
   mdD/N2KTAIWrE3gNTKD0ooZrcrlZYj8YseXtIaxjQWUinwsdNihGLzX5U
   4B3Iitau+OO62g44nTcjhwO878h7sg9JgvOuqz3b5H6k/TUoc7VX9tdno
   oNtTN2k9qywQCIrzvlnmWvzRCTW00x0tk+KM80OYIuGvfNrofqSK6Ty9k
   w==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643698800"; 
   d="scan'208";a="165987004"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Mar 2022 05:09:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 16 Mar 2022 05:09:45 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 16 Mar 2022 05:09:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBeWRgYDpS32ac36CuhaG4UqbY9ZunZ9TDNSvdfqe4oJV8Skbzi3xMnGxBkF00kPK9UfKlzWdWCWSolpJPDXKQfgc6Lj49eESGLO/CBhagzOAk4G+9ZJbNJQ2fw4aJWPbGyCKULi13mvBAV53M1KOG0Ip2c5X2fz41glDaW0spW3D49YXSSfzkMjZEyLEPXyQQW90XHAfm3QAe9DpOewnhOg5N6GZ7TJzkdSALEIthjB4ZmC3uLzjn7HZOCt0jyzq1m/CuBatoNnX5MhgfLmD51ieRP1LyIzmf5LYhI1wyL73Pcq2O2jczdgSw5EqMBYyxJrHbjBeILcMpkon2vdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kQMpMmJlMugt1lI9oAgfEhJcZX4wJ4U0jzdDN6PJKA=;
 b=RrHg2E5iwwk5K3F6KjeyyFWtWxF5n0YdTpEsi1/2bZDFseHTvTh1J397mCMj0iqPMUySE8xYuZDhi/d2sshqQj5YZw+4GJiSu07QcCcJq5XLdbWVtnlOEPsIt1gsOJgl48Am5/3UrSUt2wmoAc00O0WpVpn4kA0wGKXeszCGjOd80Pm0PwRLGTKoij6L0vpzn6LvJFsNGQ8msC5St0L/LlD0G1C0egK6TYLbV8etuC69I3QrFiL1Sn9AXvbYi+bgFnNyQYRznWilwAGAXugoantiFGrVTs2W5dZaqTrR+uC5943eXCC/bJdX3DiPg5D83DVjTRG1H83psAaqf5J+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kQMpMmJlMugt1lI9oAgfEhJcZX4wJ4U0jzdDN6PJKA=;
 b=nSkgzqqGY9EwLczRP1Q5Eo/iUYM1SwlKw+4TtDl1KGsyBLM7LLa514X08qUWjlLwkjJM1I1WajDvIsWvnr447rgdlS+I/7HcMB8R6LIXZGKycadRsjbwmyg+79UdOfPQ10XHXaEzAv4pBKqHbNQ7SZb5Lw14VSfXGYKs6UfA0Vw=
Received: from DM8PR11MB5687.namprd11.prod.outlook.com (2603:10b6:8:22::7) by
 BN6PR11MB1939.namprd11.prod.outlook.com (2603:10b6:404:ff::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Wed, 16 Mar 2022 12:09:43 +0000
Received: from DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::fc32:96a4:933f:194f]) by DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::fc32:96a4:933f:194f%6]) with mapi id 15.20.5081.016; Wed, 16 Mar 2022
 12:09:43 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <linmq006@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <richard.genoud@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: atmel: Fix error handling in
 sam9x5_wm8731_driver_probe
Thread-Topic: [PATCH] ASoC: atmel: Fix error handling in
 sam9x5_wm8731_driver_probe
Thread-Index: AQHYOSc3ZCqpPBJfxEGALz7ngsVtdqzB6yKA
Date:   Wed, 16 Mar 2022 12:09:43 +0000
Message-ID: <72087233-360a-372c-439e-b3bb45f688a2@microchip.com>
References: <20220316111530.4551-1-linmq006@gmail.com>
In-Reply-To: <20220316111530.4551-1-linmq006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fdd9e85-cb59-4efa-c206-08da0745db17
x-ms-traffictypediagnostic: BN6PR11MB1939:EE_
x-microsoft-antispam-prvs: <BN6PR11MB19391310D68D326B3632C913E7119@BN6PR11MB1939.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rnq+lE8OezM5lnlWufwCdmzS7RvsJy9UT8Cw8vFJqJfuUaNtRzBVXlnPkynwySu7pymWMdcYRnvn1GamqVat0AzhCQEQLC+OIW7l84rUxkbCExCHzX8vGhhJFepRYt072iU9yZA1XAhIK2XjETDgWB/5V1MyQmvLH+9VHzbvKsZPyXjJojv4HD5L4e79V4ELUmzyhkREffsbHQ1KO3HO1tFyTGX0r1Ujclp7ut7yu/28ZkMf1cDPaI5strJ32Cwl6Dc3q49wVjoZgj3IyJA8bAFJGq6Ty+WhMGb5uiXkc1GFgw4nosUw0fp6ZR6hWMPz8GX56V2JjG4Ip/4CAgnTPT8wGuEvrpEB3ueOVjt7vKAjSQPaFJXfBvJv5dE7479wdIjFc+KWJyJFTz/GdgUAPifPSX/NylkSWlHrmJY6DxgJ8qprjqW2arK1UZyv36MFOSbKdC2MZSwFq7A29+zy9vkNY7BB5RNskadWohVSL+l5T5RxzxWmUPCuK8zIUjCZN3El4PAtAfW3CNd7MliAhHHuKc+p/Ib6MxNH9j/sxCn0VcsL4cxlh0J1LtdfdxsYW+Ck7LUe1y1MAom0jl1AamRZZJ9L5t0Oa2rM7Dh3KPJ0GuWC30vgK+LIRdjMtOtciZgtNS90SuQ6xCtyW+LHBp7qhG+VWedW+34MjPiadgm6g8hWMTFWeUWJOm5wAlgKWeVwVDlw5uXafKyfgau4Cev6QvzxzKXXJFLJm23hGHlmhGt535aSBwUmj8f4EHF3DhRAz/tAuCrCiiCfHnCDGV+6G8YkUE0jOeMtmMak5hs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5687.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(66476007)(66556008)(66946007)(64756008)(31686004)(8676002)(110136005)(6506007)(91956017)(76116006)(36756003)(38100700002)(2616005)(316002)(53546011)(86362001)(7416002)(508600001)(5660300002)(26005)(38070700005)(6512007)(4744005)(186003)(6486002)(122000001)(31696002)(71200400001)(2906002)(921005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUpxZUV3Z2lRRjJwNmlsNUwwa0N3OVFjY3luZnhQSzE2dVNsYXduMURwRXlY?=
 =?utf-8?B?RWhqNFJuOUZhSVA5bUtUV2lrZ0p6WmxodGFqNWhBRnZydmp5bEMzK3c0VDVN?=
 =?utf-8?B?RnJseGVKT0s0cWtoRy9ONUdnWklCb3RRaWMyNkszZi85S0xmZHJMRmNFVko0?=
 =?utf-8?B?ZlpUbHFVZzZNVElWKzV0T2wvSmNmZjJIc0lya0hRRkhjaUZidWRKNS9kaVJs?=
 =?utf-8?B?eUJvQ2FjaDFhNFoySzhUOWRpNHJ4UjdIR0tMcTZkeG82eWZrSkJqUUpOZmNN?=
 =?utf-8?B?N2o0STc4d0lMeWJ3cjFySkFubEw2UEpZVWdBZXN5a3ExU3Bicy9LRSthdE84?=
 =?utf-8?B?NkY1cmpSektDbTIxRVQ5aERiQXFoVWpmclpnWGZhU3V1cHU3NnVLTjZ1UVFJ?=
 =?utf-8?B?ckorTnJEWEhoNjN0NzhlbVRnL3FzMEJKMEUwb3R4MkJvbWduOEliWm1WRmtB?=
 =?utf-8?B?VmtXV3U0dkNScGFaZTNGYmgyQTJlZlpEd2JmZjJ4UkVWR0NRREZUV0RIZjgx?=
 =?utf-8?B?cTBLRkJKVGxUT3pNS0ZSMER1YjdSWm5HOEtqVWNyTWNFek8ySUdUSUhkbXU5?=
 =?utf-8?B?Nzh2NmdXeFA0SFdIWHpWV2FSZy9ESG1NSWM5SFRCWFYwYkRWV1J1V0pPemFT?=
 =?utf-8?B?bmw0QUtLWk5YK1pnTzYycVVBaEZZcHllZEtJMU9zQ3JmOGxtek8zUGVERVZU?=
 =?utf-8?B?U01ZL2VTWGM4SytlMzBQZUxrVnQ0V2Y1dFdnU0FTcVBhcFdnZUs4NU1QTXha?=
 =?utf-8?B?bDRYUHlvSnNUdEsxa3liWm51emkvVGJ3MDFheWJvVjF0WEl5a29SQncwS1dV?=
 =?utf-8?B?a0RJdVFDeldOM2oxdWJzT0pOeHk3UWdyTWJyMFNLN3BOSmRYRkdyNDNsQXkz?=
 =?utf-8?B?aWRmcDlqeUtKODkxdHN2dWhLa0tBL1llNlFPNktPSXJ5WnpBWFdmSmJ3M0Ez?=
 =?utf-8?B?UkRzdGJLajJTZXhFME1RQ2JWbVo4ZGNyalNUc3YySzEyQlJoYnloSGROTmhi?=
 =?utf-8?B?bGo3V094RzV1eTVOZEhja2dLaXdZWkFCdU5ocGhSUGo4VXloMXVyNm1uclFk?=
 =?utf-8?B?YnFXbXVVUTFsc21wamJvYWdtTE1jRW4vekhGSjB1aEY2Q2xHeW9DZEY3T2Vy?=
 =?utf-8?B?YkVHUzE5eVNacEhyTnJ2cmRoUEJuVWt2dTZsYk54bkRFeWNmc2J6UzNkK3lS?=
 =?utf-8?B?WW1RWjFSWWI4MGpWcXRLd3NqUWJzeGJ5ckN6Z0NhSTdDTUxRMDVSWXpHYXhu?=
 =?utf-8?B?Wm5JUXNMbWNvQXd5Y1BXQnB4M2ZmRDgxb1Yyc3VMb2FUc0N0NHdLTy95b1hz?=
 =?utf-8?B?UVJxcUEraVR5bU42MHFxdHBDWnc0d0FUaXRSWjQyNzc0aGh5RC9KdFpIaksx?=
 =?utf-8?B?NE5wcG1NakxIQnVJK3ZwOTdLVmlBL1Z3N1VsYmh4MjlQczRNUlNSTldTTTIy?=
 =?utf-8?B?YlBVZlpDeEJPaXF6bGZpdnlhZzhFdFF6VGM1bitPTy9Ib0ZZWFpmYUxrNWc3?=
 =?utf-8?B?RmdWbFJra3RJMFFzM3ZudUUyR0M4SmlWbURkandPVHd1SnZyTFZ5RDV3ZFB1?=
 =?utf-8?B?V1BFMGtkTGNzL1N4aFRMdmpqelFFK3dQUmNCbkpxcStnWDRpakdkeStqck1X?=
 =?utf-8?B?WnlURHloaXR0TXZ0Y29zZHlvSys3Q1Izdm8rWVBudmtSVXFYVyt4aURUc05L?=
 =?utf-8?B?Wk1zd0x1ZWhwZ2V2bkxoU3BzakUrYUtucERPamlaVm8xK1VTbFg3OE51V2Ja?=
 =?utf-8?B?MUo5ZDBXeFU1eEt2OXJzemJNR1o1dEQ1WDZWQW5UYjZpOU1COUJVMmJrN2NV?=
 =?utf-8?B?VXh6MFlKSUYyRDZPd0g4aGZxY2o5bEFlWWJ0a1c5eS9zc2lscncrNnVXMzFR?=
 =?utf-8?B?TytNdVp4WUNZU2FvenVIaVQxYmpzSzA3R3lQcXdnVDJvS0pUSllRTS9xYUxN?=
 =?utf-8?B?RFQrZFNIYyt1MytCV3c3WWUvZi96YVNDNE42R2Q2emYvK29TYWxxc21Ndlhl?=
 =?utf-8?B?UU9oaHE0RDF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB12F06081E2A84D8BC66CE2684D7952@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5687.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdd9e85-cb59-4efa-c206-08da0745db17
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 12:09:43.5314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GF2VAOhY4v7MHTB6UTRaVJuFGQ9Q7h3dwUvup+InQsIG+8VWnBeG4i+v3hs/ccBQ05pyX9Q0SwCPmrG2KSijg29Rgu2KNM5PVa3Zphe+4Dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1939
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYuMDMuMjAyMiAxMzoxNSwgTWlhb3FpYW4gTGluIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBkZXZpY2Vfbm9kZSBwb2ludGVyIGlzIHJl
dHVybmVkIGJ5IG9mX3BhcnNlX3BoYW5kbGUoKSAgd2l0aCByZWZjb3VudA0KPiBpbmNyZW1lbnRl
ZC4gV2Ugc2hvdWxkIHVzZSBvZl9ub2RlX3B1dCgpIG9uIGl0IHdoZW4gZG9uZS4NCj4gDQo+IFRo
aXMgZnVuY3Rpb24gb25seSBjYWxscyBvZl9ub2RlX3B1dCgpIGluIHRoZSByZWd1bGFyIHBhdGgu
DQo+IEFuZCBpdCB3aWxsIGNhdXNlIHJlZmNvdW50IGxlYWsgaW4gZXJyb3IgcGF0aC4NCj4gDQo+
IEZpeGVzOiBmZGJjYjNjYmE1NGIgKCJBU29DOiBhdG1lbDogbWFjaGluZSBkcml2ZXIgZm9yIGF0
OTFzYW05eDUtd204NzMxIGJvYXJkcyIpDQo+IFNpZ25lZC1vZmYtYnk6IE1pYW9xaWFuIExpbiA8
bGlubXEwMDZAZ21haWwuY29tPg0KUmV2aWV3ZWQtYnk6IENvZHJpbiBDaXVib3Rhcml1IDxjb2Ry
aW4uY2l1Ym90YXJpdUBtaWNyb2NoaXAuY29tPg0KDQpUaGFua3MhDQo=
