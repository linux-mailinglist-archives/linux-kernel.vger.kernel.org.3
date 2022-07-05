Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E7B566481
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiGEHs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiGEHs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:48:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC1C3BF;
        Tue,  5 Jul 2022 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657007303; x=1688543303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FQ4HRn1HW3hxg8v/VgydszIMVn+cgr0S1KVn6uh/SRk=;
  b=m2S/D+CozWbfmM41Qf6ma4IL+KdgbKX5FRSAdBSCATwoZc1mSn3cEuDa
   PHw6H0rmfzIwDq12MAUWa+i1NGjOwSIxOtAHz0NRQFLQds+X7uHxErLas
   WD8rThczJG2MIBFaCt32OdbGeJTL4lR/Wa4gzLstAeH5USZT46dTfaNXa
   4dSKStMsf7mE4FDYx35GOSZF9NjZUJ+nTPJxgXrPC3xgatgawHdv5UEoA
   I8MTgEizw2UmuC9nFqRH2i3zjougn7GMMNe4u0PJFLB38tsZrarl9FA74
   6ak91FN/0Jo17ujuzbEuV4MTkTf69q8oddudj/ohhg4Tp+y3GUPhs5sPp
   w==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="163314819"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2022 00:48:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Jul 2022 00:48:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 5 Jul 2022 00:48:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ee15sWs53x4XqiuISwMNhsD/mrubO9DDHG58Ad5GFAfXPRpVra9Z4GAYNOd61JV1z8S2Icng+3AW5J+w2JifPFUt92tV6NSCzuDykCRe7yZNmwINfzKxV9vKYOZchIW2CsZFUKLQGWd7NsFKTwgy3gSy2LDw6VCRstgZFXzjjzZ7udZC7bAGeagT4pGSq+OfRkdRYKxqQSFXlXtiY39+O1x2k4AIGB96O/fYLKXTEE9q5h6jyhefCvtuDI8XywDx7Y8U8lzYHqTv5YbfClb+tz0it8JPhCqXnRvxKf8jwDSou6MwkWwxb8Kfx7ZbGchn7e+R7LxY9q2gzP/N7P8BuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQ4HRn1HW3hxg8v/VgydszIMVn+cgr0S1KVn6uh/SRk=;
 b=gY0KKdmoMxw/ldiABrdRtL3NAuY+d9cgFD252+TpDnXlLv9cABDQh2Cqk+NOr0AsZH9UBNLfur85GjN2wkq7/VVkP+NdP6MUFEs/IkbcA4scJvRA34YahPMnjaznfqGa9gEUx+VlZWjXM9NNoNE3gfiuwf6qUed6lyyMuhtA9V7qMe246h0A60ZkCgB7LbfuHz9qShIzXAVYuUSrkniXZrCPUvp3p3bV2fMLOS7mIzCukAdp5p+4QpJepawXMoe08p2ujmPJIjTPAqj0pzweh/8UfQZbQRvxr2LCxGG9XamGkC8olAGQQyJqRPqDNMFGO45o5Ah8YnaWumhbWVmDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQ4HRn1HW3hxg8v/VgydszIMVn+cgr0S1KVn6uh/SRk=;
 b=qC9wRmrw10K62hwdnggSpSvWm4BMQdkZMScxT8FLLtN0UDrvTqeYvpUVWt2P0f8sXsuPFPWqndYIqJsnK4M9Lp1H84/Y6vTbFSipHLx3CmxKeVCI7Pkn7NrovpIkEDXwp/NYDu+FMLHGvf5mqkvjIB4tRqwsHY96/UUSR+zzxZA=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Tue, 5 Jul
 2022 07:48:09 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 07:48:09 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <herve.codina@bootlin.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Horatiu.Vultur@microchip.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 3/3] ARM: dts: lan966x: Add UDPHS support
Thread-Topic: [PATCH v5 3/3] ARM: dts: lan966x: Add UDPHS support
Thread-Index: AQHYkEORxWwuEVT4HUu0MT3SkSFsZA==
Date:   Tue, 5 Jul 2022 07:48:09 +0000
Message-ID: <fbe8358d-c05d-04a3-55eb-4292418e7883@microchip.com>
References: <20220704102845.168438-1-herve.codina@bootlin.com>
 <20220704102845.168438-4-herve.codina@bootlin.com>
In-Reply-To: <20220704102845.168438-4-herve.codina@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 936482a8-7ba0-4d52-7105-08da5e5ab486
x-ms-traffictypediagnostic: PH0PR11MB4968:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xLFSF75P9c5ozVUC96Myi0POz8zDyf37j6yWWnrodPeeklMup5OX0/5PgNtgq6GAawUrAQGfqfhMI/grVRvG5YVTzkghOApWUTNYiyuUGvRCLoJkcT1fOUFcrsnFwQKZgPUS3iqcPmpmifU+x4sHXUlCWxRSrrI0pifZR1ulS4+0icHMdlEenvJRFQSJmCwGGLI1ixUFP5H054Az3WNYGS+be2V+PoDiAzH9gESTB7etQwsUeRS3gUm9v9FadTmpfLTCKixsvo7jEL0HXxe0GK+519DtBOnQIC4lRNmplxH+higy3QVo1n0Eb1hdjTxO/DDslsz08UAaQH6emCwx4g/beQQAf7j887othie3Knw501L/bquy0ER4fh8Las2NyQZXzpf0EnN8arrOT2vpNjumpSvjIiStbT1Hm9lOq71GIAjEZPaJMyw/Oma2IJMx/1iZMiKi/ZWR4mmc76L3OTgpC6rkjRfTPgi+axR33UHNLoLpIHYSk+u30NHqozn5Z1pNdyP8pGL7CZG1PCdHzCj2tV6dmcBex6M9hmm1Iq1NGuZlLU1C3ibsUjxP5Na9+vM5VtFYxR+ntST5+Ju9COAdRAdYzzRRIozeYFZGd2addwa/g2nzrDqI+tqrYjCx2XaCo3oAku369fLrvsfAqEzXOopBuBJNILhmM/kpDMRtb9kco8ZhmJ+AJKTsf2T+CtirY9ugLqijt7vKFFxoBqEOLjZjIbES9uzGIlOiepGL3VPVvNWiEg23W+YNX9hErBNiFW0CsDKdQSk6SF3PU+SNWjrQrTg/HaXbnADhe8weKBhwMxkLd2+WiHflBPvlCINv0H3jtvIideedTz3QYyZPa7RAwU2CrVwkjofDyCig55g29A5DGYgpXXaH7PT9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(366004)(346002)(376002)(6506007)(41300700001)(31686004)(38070700005)(71200400001)(8936002)(316002)(122000001)(6486002)(478600001)(8676002)(110136005)(54906003)(38100700002)(76116006)(7416002)(186003)(86362001)(2906002)(5660300002)(83380400001)(6636002)(31696002)(2616005)(66946007)(6512007)(26005)(64756008)(66556008)(66476007)(53546011)(66446008)(36756003)(91956017)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXJxakpONk9MaER1UVY5bmhpNktpbllBWVJYNnIzVlQxaGtxcUw3cWZPMkht?=
 =?utf-8?B?ZGJudUhUNHBLY1RwcXZuTWhvV3ViSmhJRHhXQ0Y2UW9HZkRoUkVkZDlDK05W?=
 =?utf-8?B?MWdLSkpUWXBIZVJkdkc1SGhNOG1BUDJGN3EzZkZqVWRxSWdTL3REYU5OVXg0?=
 =?utf-8?B?UXJ0MHg5Y0ZRNS9XTG1peVJaWWM4TUxVQW5reWcvdFJFUk1PNEdLdldFSFRV?=
 =?utf-8?B?TiszMkRoemhZd1BxZWo0MXRLanhFUmZ5QXhNZXY1VDBkREc5TUVuVzhoNUxq?=
 =?utf-8?B?VERhQ2hoUHJUNU1kMWxtTU9ZbmhmWHExZW9qQVZBeFY5emdPcXUzVy9Ocmo5?=
 =?utf-8?B?K1JHRnJxbFpldU95NkRVRXpEMWNmMVRtZmxZeUJkMWVJVFU4aWhnV3o1b015?=
 =?utf-8?B?SHV2aDFjeUQreFdZN1B0MDFzTjVLazJVQzdDQWJVN054LzkvYUIvZS8zMDdx?=
 =?utf-8?B?bHdsMkJOb2JyZDNPcmoyeCtTZnpsa09sdWZ1cnpEcTlZaEJTRlMxYko0d3Fs?=
 =?utf-8?B?QkRsbDJmNmZHQUdJMUpqSHJuTDZneUhCY1VRMHpNR2M2UnZDSmdsTm1HRWNy?=
 =?utf-8?B?YmkzcXB4d2hZMHl0cWVXcTl3ZFhTQ2FKbHFyOTM2YzBQb3NwUytUQUVVUWU4?=
 =?utf-8?B?WTZwNTBLU3U5bnExYnBORDJlMHFENzRQcDhuWVdpckRUNURKVUd0cFZjdVpD?=
 =?utf-8?B?azhodVBzajNtRlR1SGV6bERtVHA5cHd1c1g4NDdLOGtpUXd5YWZJclU3b29k?=
 =?utf-8?B?RE5IN1RYZTdlN1JmbE1MdmZwWUVGYnlvTGVzRG81bXkxODdXL0RxeUlCNC9T?=
 =?utf-8?B?cE94TTY3VUgzZ25GUC9pTFJwcUdRbjV1NlQ2NjlCL3hURktCbXRXTktFRVJo?=
 =?utf-8?B?UG9YZk9KMGtyTjEzQTBQOEViYmo0M3lhVmN1L0owUm81N09Vd2NrWU9GM2k3?=
 =?utf-8?B?WEdPMERQTkQzV3hPNmkrZGtkK2d2Q0NxRk00dVlzbTlxQkdrd0I5a0dQU1VI?=
 =?utf-8?B?d2ZjemJoMlB2NUZjQjZqVmZPYUtra0JBL1NIeTZWRHFDZTAwY3l0aWREdDlv?=
 =?utf-8?B?SDlyanRmMG9XTm9zUHVxai9wazF2TEVvZS9zY2JaNER4YW1YcHpJdGZJaTE3?=
 =?utf-8?B?aVpQQzdPUndybVBZQTBWUFNNbUYyL1BRbUNIWHN3OHFsVnJKQjdmVHFua204?=
 =?utf-8?B?VXg2RndCSkdiYS95QU9SMkR3WUVRQUtVOVhrRUw4NFlnb1lwZ1FocGNtSWV5?=
 =?utf-8?B?ZG5qSHBZL2JBb3ZZNGE5L2hxT1RvOEY1U3h0M0QveFI5NlBHeVNvbDJQVWs0?=
 =?utf-8?B?MkJ2ZGg0MUdoVVdPQ3cwcWlXVVYyTEdHZThTbUJWRVoydFVIS2d3MVh0Ympi?=
 =?utf-8?B?S2QyNXNlUk1jSS9pNk9acFJ1V2ErR3ErUlhRV1ZqN0tYZDF1U1NMV1RvOExn?=
 =?utf-8?B?cXBMY21nSTFYaDVtaFFoWXArZWpTTGhDbElKT2hXYVV1aDVjMmg3ZWRqaTBt?=
 =?utf-8?B?eUU5UlBKQTIzYUZtUXlvUExmOG02aGFBZGZyVmJlbzlaSlRtM3cwNEd0OG5a?=
 =?utf-8?B?V1FjSlBpN0hCVlE2NXg2YXZEbGdKVC9rakp0UU90WEpPbDJ4TFJiZ2k4WXc4?=
 =?utf-8?B?dFNMQlJUVUtqUER4ajdNN0txa1Qzc2xyMmFXWEpFQ2QzQzB3OGdYbVA1YkIw?=
 =?utf-8?B?dWJ4QmRoNFpTeVcyTlhoaEl4ZTRIbVQvRzNSYTFQaUpmTkxtTkVWKzhsSHdO?=
 =?utf-8?B?TXBnWWIwSnh3R3FrSUd6bExQUVlrMHFzZTBidlNZdElWci9jUk9wTVY0anpH?=
 =?utf-8?B?VG5hY29NaURHMmV3bU4zTnk0OHBJT09kVG5tNGQ4UmUyd1gxZ3JXYVAxdnJP?=
 =?utf-8?B?ZEc4WmNEYURWLzlFMms5Wmk1aTV5all6WDVFVy82QjJTalFTaUNFRlFpVENK?=
 =?utf-8?B?aDJDaWNEYzR2MGk4UDhZM1pZMHp1enllOVBYMmtZMk1SYnBWc3ZpVlplYlJm?=
 =?utf-8?B?bWlnVGMvTHFIZU5LV3hwNWUvTldUdlhGTzRqY2hLZ3YwM01zanVkRXMrUVk5?=
 =?utf-8?B?QWxNQkRCNGtDMEFsTDlxUUdEUXM3Z3lkZ2dYM0Q3NWtjRGplZVVIeG9KOFZu?=
 =?utf-8?B?NXc1bi9pazhnd1JGR1h1elhBTUxSMzVkZEdJQ2E3Z2lvYURmWEhLbi9nWmlk?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2212FDED9243C34C8299150CA1B6409C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936482a8-7ba0-4d52-7105-08da5e5ab486
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 07:48:09.4498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3yJALqprfqf+nL5qhdyGAclz4c2DpSMEOTgw6Q9nJHOZonx1Cx21ipjSMXh6a+4eh7y187t78q80DwhAODBRIaSnYP7ji4qz5G/qlT2FQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDcuMjAyMiAxMzoyOCwgSGVydmUgQ29kaW5hIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFkZCBVRFBIUyAodGhlIFVTQiBIaWdoIFNwZWVk
IERldmljZSBQb3J0IGNvbnRyb2xsZXIpIHN1cHBvcnQuDQo+IA0KPiBUaGUgYm90aCBsYW45NjZ4
IFNPQ3MgKExBTjk2NjIgYW5kIExBTjk2NjgpIGhhdmUgdGhlIHNhbWUgVURQSFMNCj4gSVAuIFRo
aXMgSVAgaXMgYWxzbyB0aGUgc2FtZSBhcyB0aGUgb25lIHByZXNlbnQgaW4gdGhlIFNBTUE1RDMN
Cj4gU09DLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGVydmUgQ29kaW5hIDxoZXJ2ZS5jb2RpbmFA
Ym9vdGxpbi5jb20+DQoNCkFwcGxpZWQgdG8gYXQ5MS1kdCwgdGhhbmtzIQ0KDQo+IC0tLQ0KPiAg
YXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIHwgMTEgKysrKysrKysrKysNCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvbGFuOTY2eC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+
IGluZGV4IDNjYjAyZmZmZTcxNi4uYTU0ZmVlNTI1NGE0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2Fy
bS9ib290L2R0cy9sYW45NjZ4LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2
eC5kdHNpDQo+IEBAIC04NCw2ICs4NCwxNyBAQCBzb2Mgew0KPiAgICAgICAgICAgICAgICAgI3Np
emUtY2VsbHMgPSA8MT47DQo+ICAgICAgICAgICAgICAgICByYW5nZXM7DQo+IA0KPiArICAgICAg
ICAgICAgICAgdWRjOiB1c2JAMjAwMDAwIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuOTY2Mi11ZGMiLA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgImF0bWVsLHNhbWE1ZDMtdWRjIjsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmVnID0gPDB4MDAyMDAwMDAgMHg4MDAwMD4sDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDwweGUwODA4MDAwIDB4NDAwPjsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDc2IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNsa3MgR0NLX0dBVEVfVURQSFM+LCA8Jm5p
Y19jbGs+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJwY2xrIiwg
ImhjbGsiOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0K
PiArICAgICAgICAgICAgICAgfTsNCj4gKw0KPiAgICAgICAgICAgICAgICAgc3dpdGNoOiBzd2l0
Y2hAZTAwMDAwMDAgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1p
Y3JvY2hpcCxsYW45NjZ4LXN3aXRjaCI7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9
IDwweGUwMDAwMDAwIDB4MDEwMDAwMD4sDQo+IC0tDQo+IDIuMzUuMw0KPiANCg0K
