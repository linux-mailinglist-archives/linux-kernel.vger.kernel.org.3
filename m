Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340CF58A732
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbiHEHeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiHEHeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:34:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7B443E7B;
        Fri,  5 Aug 2022 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659684860; x=1691220860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CHkDsD6F8ln0oqgqLvjP2mOVLp0AwpdXle3spQnnHk8=;
  b=cu35gJh3SilWVBWXuBBYrxjGV3rfmx44AhXQWlumMlUkbTlWe91qkxPh
   wjvRVTeIs2EcrmDslKIJ3KaLWdeyseDn2/t7piy3ntS9CxtxLnxZ21Uqy
   XGRbax2WCrhvCo9tLbdzSN5tBczcv3ZeUqx8tDqRys5oRr06H0XAQe0Aj
   65gU6UXgXTPbuMgA9Q9yXuvPInUk76KoOnwyPpQ/MbTN36DN1W5E8g4y9
   9Nn1v+TzxXOznVrbJVZggBwWw/ykoIEX8inFVw1qwxzF2HaI4dxw9hg6K
   zLdN15hr0Hdi2Q4MPs5UpKVUHwwfgKfv7+hiGVBc57fq1uaYwxgT7RzNm
   A==;
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="107703806"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2022 00:34:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 5 Aug 2022 00:34:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 5 Aug 2022 00:34:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKMp49/YNENtphFSUReeUmOhvXkcfQTwr2tzUztPkXtjD56Pgb6rxs/F+zTpNtv9Ptnh3gVtdms4uQdt2lh0cbGHt0RSRfKOk53MNmzY1iMwS8HcZWLVopvyIsQPnqQWaHorpdk94uvwot1aECgRlC3uVooSKRQPldSExlg2iScOfLoFPt8gJpSlvL0w0d4Fnn+Qy/dt+zaJJVBeCrKa8II5azdjmKhPGmZohYfsNpxvn2iFtcnw56dsYnNldhy4fMnUJcv/kyFYRpQb5/nmcioBINQEY3bfQuTY+lLi9hrRy2cVAOhF0PzBOUyTjmms1h4GxskzD6CDtnnoRn9UCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHkDsD6F8ln0oqgqLvjP2mOVLp0AwpdXle3spQnnHk8=;
 b=Quu9ZiMJnuOcIClB9QS8jx0zBPZqjrdL6k5ndASaju5m7Pw8nldiaCuuhXjVrFWL0A7u/cXSSUUoqsF/fAVUsdABGxN4ZsB55Studfysmf3Z3dI2LfP1edWgjCcflmszFG7LioscdhPC0Xl52ZePTJE5WqqGG0bvoLtSgBT5q/C7YXMZuPVjrS4mdxyJdj0Ng0c3X4HG3sR+RMipW4KnxtnULw1MYKGz4DGnHYGADanhbsqykiJzHt9mmdmMneu+GyN1HFcWYHiNkfHKomED2fmFdyFuV8tOpH/hjWacaP3r01vKVGNT/3WnJ6wl1nOlKcYekp2qm3stb0taPH/JBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHkDsD6F8ln0oqgqLvjP2mOVLp0AwpdXle3spQnnHk8=;
 b=RlzcEPwY91HYBYvbseCUwCoOheu+OSJOZCOde/B/QroXfg1wf8Bx8A5PeWEDtn9M3UsL0qBFTQUsYwFf96iLdOmx4kRYjsZcKsC3iRnOy4UuHGB4ZZd9ZW4IhhFoVdca+YFgyY8UVwRD/cR9cqfq2t/eQhtPRLB6ZCeZZOsHi0E=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN9PR11MB5481.namprd11.prod.outlook.com (2603:10b6:408:102::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 5 Aug
 2022 07:34:16 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 07:34:15 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <Nagasuresh.Relli@microchip.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v3 2/4] spi: dt-binding: add coreqspi as a fallback for
 mpfs-qspi
Thread-Topic: [PATCH v3 2/4] spi: dt-binding: add coreqspi as a fallback for
 mpfs-qspi
Thread-Index: AQHYqIybeJXvHam7Y0inKes5YtTewq2f3dwAgAAMvQA=
Date:   Fri, 5 Aug 2022 07:34:15 +0000
Message-ID: <1e48a9bb-9e35-66e7-e8e7-ff5de9941fc7@microchip.com>
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
 <20220805053019.996484-3-nagasuresh.relli@microchip.com>
 <a83c5784-6c86-497c-78d8-1550e8add7ec@linaro.org>
In-Reply-To: <a83c5784-6c86-497c-78d8-1550e8add7ec@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8777ee83-fef9-44f7-1375-08da76b4e66f
x-ms-traffictypediagnostic: BN9PR11MB5481:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JsRIPgaJ2pz9ufSCe3hS0yceIbFroYNyBKaNCR1AMdDPg/h/fuBnQNW7YEoNCLAjed/SHgPSiDciLB++bkY4cyrejAztTII2W9vdduyUf2k4sSJxL7zjRdSykmwQFgeSQbhFOpFQkI8b/c5THY5cUgC+c7Ewh3PaX2vw7dcPGBsWWYSjT91Qew3CUGUQqlexDxB01tbFxUygovIw9dovpWvIFfykrb7KGdzXnk7VyLGOZS1EU3s1xdony9xCRY0YoNXa4n8e8oyBguRTcO5fbkHnWAQGHxQoB3bMLpmrCvBUKO/zUyBx7hTuP5b1X0HPCFaFQ+QWxT8/qhA1Kph3e/G3/LDyPNF4FZ67QhD5vh/V0mBgM/o1L5yHk7X1pqCSKT8ZTlsv+pavZqDofIgdQWtk3ki4Yzvc81Y105+sX5AtAdUdnM3c1YfESH3G2m3EYarEwNGqyobsGF+eB1nc1u1if5pXcNnXYVKqh0V7z4BtboZMW/HOZx6Yx7esibMwjrW3Fu+OE5acNRnK790Ce0wkasyv3YLpYgN55Wb6GVPdlZCAWAoJJjVVWASVj+MEg8CDFFrMCzTvUxd29dg446+hgsXvo4R64SyskuP9+L80uwzvMiHQuf+wPwsNtivPCBn6GSiOm4sh7s3JmZDUqMfDukVaoneZdHC6fEcCsyyPLQXrM4BH/Pc2IU/t0xI8SmmLRZnq3vK9WCiFs4WkcRDilc5iOksNaw4K9Hk0002slE9RnXSvyvV0YmlGrKYmQkDCNymyfWlWhpA87A2ebr1DhRVaswkwd8UIldFQBWT+YeEPb53UV6kM+vmhSbJjI7tTgFKRf36ku+LWMj7Xv3ACIIKUeFxPo3U5ERMNOG9FlxNNK/XoZdavSVgr4Qov
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(376002)(136003)(366004)(122000001)(71200400001)(38100700002)(186003)(2616005)(36756003)(2906002)(107886003)(31686004)(6486002)(478600001)(5660300002)(54906003)(86362001)(316002)(110136005)(76116006)(41300700001)(6512007)(6506007)(53546011)(26005)(91956017)(31696002)(38070700005)(64756008)(4326008)(8676002)(66446008)(8936002)(66556008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEl0WGdld282a0xPNm5DcTQzanR5TWtIcXZDRzFLc0FJOTlsZElFaUZNYmt3?=
 =?utf-8?B?M1lEMVRjaHhJRjJuYS9QK29zT2xKOGlmZ3paaEY4WXZ1ZUJKSXN2dWl1eXd6?=
 =?utf-8?B?ckpOWVhuUVZubmswblBXQ3c4V1BPQ2xMVUxYUll2bUliNCtKS0YzYmVNbFNM?=
 =?utf-8?B?VlljeEh1N2xMekxDK2s1TjFYcHo2a0hBNEdhbnU0ZGJMT21pV3ZVbFIvdC9v?=
 =?utf-8?B?MEJpVkZDaFpHbnZzVzJlSW41WitSYU9lTmZtcllJVGY0TkZRNHM4SWxkeTZu?=
 =?utf-8?B?UE5zak1KMDFnNHArVTB1WGNGT09oUkdTM0xnN3JaZkNLTThwa3lFdlN0VlRa?=
 =?utf-8?B?b3dMZllVbDh5QkN3STlVRVZMTzBoanRMbFpvaEw5QjhyblRYQlhWc0tvc1BH?=
 =?utf-8?B?T0VqZnVLN0wzYmJ5eEt0VjdSU2F3QXpaa1dhMkU5cURGdGlKZWFyOVowVXlW?=
 =?utf-8?B?ekgyWWlGWUhtVGdLMVp1MTdiRGxtL1dqa3hmcldDOTA0MXcrcDErTDRkYTVo?=
 =?utf-8?B?SlVucEFOT2ZZRTQrOVkwVUNMUWpad2VmbHZBWW16WlpqNnFwdU5NVzRWSVlM?=
 =?utf-8?B?ZWF0d0xPOEM3Sk9xbTJSaFBQdXF3UWd4a1k5ZXRlTjlldWVXU2dGeE9vWFlW?=
 =?utf-8?B?cHhLQmdvSlNKeE5lNVFpbkhjQTNJK21xQ2Z4azR2VmRIQ3l3eFNVZ2NmN0V6?=
 =?utf-8?B?ZmZzL2k3S2VrdUExMk1OYitYWXBkYUdCQ29LZDNsM2FXanZhQU5RRDdGRFh4?=
 =?utf-8?B?OFpHZEQ0VTRwbmJWdTlYYmtRd2NleldDRXRUNFBaV0IvMlZKUWcwZzFlSXo0?=
 =?utf-8?B?M3JiZWZHenNHNzlsTzhORG5CeHhDZGlGQjlKVkk4SmQ0eDl6UUY4ejdDM1g2?=
 =?utf-8?B?UkF5WXFFUXhqbkk3UDJxL0pCSDlCWDRkTWk4TFI3MDROejVNQjdZaDRWUnV4?=
 =?utf-8?B?YnRZaSs3WVdpZktITlJqT2gxSndzU0pqZVlHbHdxQjJ3STJmN1JmVmJpUzVq?=
 =?utf-8?B?eEFjNWJkSzJIQnNsbEVxWjJtSEZPOVl4UTgyWUZGSVQwMmdaYktLTnI4SkUw?=
 =?utf-8?B?Y3NKNStvQlVjbEpYSW9nTklHMWRySVFMWnhhTTRxdEpBVjJqUk1OU1NoaXVj?=
 =?utf-8?B?RWUycDBlS2c0azZxRmxDOXlQTGVQOXZQMW9nakdYbmtjYVZSbFZmSkM2RVk3?=
 =?utf-8?B?cHI4d3ZJWVBiNGFFaUhGNXlBaENIMnBnRmYzMkorZjNMNWk1bndIdUswQUdM?=
 =?utf-8?B?VUhEanBueldWM2hsTDRCeXVmVCt4TnVzWUhWZGJ3VjcyREY3b084dUF1WFVx?=
 =?utf-8?B?YTl6RnNjMVFzVFh4TENXdWZ6cm1ndEE0ekliUVRoOGhTTEwzc1djUlExWkFP?=
 =?utf-8?B?RisvUStYclJYSUdyOC8wbzFEUFlPdHYzMy91V3RFRFNoQVlUaUhGZHZPcmd4?=
 =?utf-8?B?RVliblQ0bzdLQWNhY3Y2UnMxVDY4Q3ZFMGVvaWZzL09wd0NGNU56V2dHMjl4?=
 =?utf-8?B?UURuVkpmbG1KdnpiRnlId3JnYTlXN2xqWFhtMHJRbXdHY2VoKzdzQVQwMTc5?=
 =?utf-8?B?RTFDVjhZRFR4a3BJbVJ6cGlidEJnemFuQU9kNS9sWEFpNTAra3REd0FyUFN5?=
 =?utf-8?B?Nm9ZU3JVekZIU1lubUZUZStiU0ZpR2JqbENCWkhrblFSdU1XelZzWUhvSVhQ?=
 =?utf-8?B?UHd1aG44VGJUUUVZNVIxS01ZOWxpWTR6ZG9URTAweEtWVWhtNnpsSWF6T1cw?=
 =?utf-8?B?MjN4NW54Ykc0dm42cG1xWTRtU0VNcnVpcWxXaUdOdlV5Z3RpalVhdlB0Ylk2?=
 =?utf-8?B?cTE4NStjWkdtSkNCWCt5Mng2eVFNdXZuT2ZncDAyYWpKVHdlWVdpK29qSnJG?=
 =?utf-8?B?Rjh0bDBJQTRFMCtzOE1xL1dRcHM0TnF1K0FXMGltTldGazBaWkNlNUJXTkh2?=
 =?utf-8?B?MVdCZUFiamNJQjVqY3BjUHVIUGtxR1FHNjhjaG5nUmUrNitDQnRZakQ5dWoz?=
 =?utf-8?B?RkQ1YTY3WjJoWGtGR0V4QzkvSDNORGF0TFFDSXhTL3cxak9pcUM4c2FGeENQ?=
 =?utf-8?B?a2NxSmcvQkdhYitGOXhEN0ZVZVBQTjJweUxxeGphMGpKbGhPRTgwajRQRTN6?=
 =?utf-8?Q?OE97Opw0b26lKODhFDnfI+pLx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC4C340F53E3F144B0FB8AE53A3C23E6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8777ee83-fef9-44f7-1375-08da76b4e66f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 07:34:15.8264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vqGnJ0MWR4Ea24XzJzIbz6hXKi/2OSoEpbQXZRwWocyoxkd2tJZpAucN/go+fdPDC0su9UhgfDQ103t9qY2UVoEzTGo61vC5n0AQ6R/Hvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5481
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUvMDgvMjAyMiAwNzo0OSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwNS8wOC8yMDIyIDA3OjMwLCBO
YWdhIFN1cmVzaGt1bWFyIFJlbGxpIHdyb3RlOg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvbWljcm9jaGlwLG1wZnMtc3BpLnlhbWwgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL21pY3JvY2hpcCxtcGZzLXNwaS55YW1s
DQo+PiBpbmRleCBhNDdkNDkyM2I1MWIuLjg0ZDMyYzFhNGQ2MCAxMDA2NDQNCj4+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvbWljcm9jaGlwLG1wZnMtc3BpLnlh
bWwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvbWljcm9j
aGlwLG1wZnMtc3BpLnlhbWwNCj4+IEBAIC0xOCwxMCArMTgsMTIgQEAgYWxsT2Y6DQo+Pg0KPj4g
ICBwcm9wZXJ0aWVzOg0KPj4gICAgIGNvbXBhdGlibGU6DQo+PiAtICAgIGVudW06DQo+PiAtICAg
ICAgLSBtaWNyb2NoaXAsbXBmcy1zcGkNCj4+IC0gICAgICAtIG1pY3JvY2hpcCxtcGZzLXFzcGkN
Cj4+IC0gICAgICAtIG1pY3JvY2hpcCxjb3JlcXNwaS1ydGwtdjIgIyBGUEdBIFFTUEkNCj4+ICsg
ICBvbmVPZjoNCj4+ICsgICAgLSBpdGVtczoNCj4+ICsgICAgICAgIC0gY29uc3Q6IG1pY3JvY2hp
cCxtcGZzLXFzcGkNCj4+ICsgICAgICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxjb3JlcXNwaS1ydGwt
djINCj4gDQo+IEVoLCB0aGlzIGRvZXMgbm90IG1ha2Ugc2Vuc2UgYWZ0ZXIgbG9va2luZyBhdCB5
b3VyIGRyaXZlci4uLg0KDQpXaGF0IGlzIHdyb25nIHdpdGggZXhwbGljaXRseSBiaW5kaW5nIHRo
ZSBkcml2ZXIgdG8gYm90aCBvZiB0aGUNCmNvbXBhdGlibGUgc3RyaW5ncz8gVGhlICJoYXJkIiBw
ZXJpcGhlcmFsIGluIHRoZSBTb0MgcGFydCBvZiB0aGUNCkZQR0EgaXMgYSBzdXBlcnNldCBvZiB2
ZXJzaW9uIDIgb2YgdGhlIGNvcmVRU1BJIElQIHNvIHRoZSBmYWxsYmFjaw0KdXNlZCBpbiB0aGUg
YmluZGluZyBoZXJlIG1ha2VzIHNlbnNlIHRvIG1lLiBjb3JlUVNQSSBjYW4gYmUNCmluc3RhbnRp
YXRlZCBpbiB0aGUgRlBHQSBmYWJyaWMgYW5kIHVzZWQgdGhlcmUsIHNvIGl0IG5lZWRzIGENCmNv
bXBhdGlibGUgb2YgaXRzIG93bi4NCg0KVGhhdCBicmluZ3MgbWUgYmFjayB0byB0aGUgb3JpZ2lu
YWwgcG9pbnQgcXVlc3Rpb24sIHdoeSBub3QNCmV4cGxpY2l0bHkgYmluZCB0aGUgZHJpdmVyIHRv
IGJvdGggb2YgdGhlIGNvbXBhdGlibGUgc3RyaW5ncyBpdA0KaXMga25vd24gdG8gd29yayBmb3I/
DQpUaGFua3MsDQpDb25vci4NCg0K
