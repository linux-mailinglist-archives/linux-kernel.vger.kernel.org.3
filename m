Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED5951122D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358666AbiD0HR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358675AbiD0HRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:17:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8333B4A3FA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651043651; x=1682579651;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LmyUxIEYO0iSu7GeJ/sNTZR7/lB1iDtAGDl8xifScN0=;
  b=Om9h8VXw7eGMhZQE0BLGQQQrtgBomuW1eP3yAK7BR9y2AiesYtvOa95Z
   JOePlV1hBlO0APkfRSwxTPyaufRr6uMpWcaKegBYzEVVn2QtZSwfWBa4Y
   aLBhuYx96osJvp0AUxJfgUbIWzBNMpy6HsLMFWsH1DfAYGaClB2KCWcfz
   RNnHanab3dhQuOIKmGNgPg4kA189X8Vjt4poQKl26egp+U+cdKIn7KpWL
   Ew/Z8YGjNTTiAzFCI3Jd4hetdB6iiewYCBZdUu9JufiiSTewgePBd4wAY
   aQzfXyv/KEfUWBDed+xpdXE4TGh9+S+U+MzeU3tR5Wo/q5bcOFsX3h/Ch
   g==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643698800"; 
   d="scan'208";a="171072847"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Apr 2022 00:14:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Apr 2022 00:14:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 27 Apr 2022 00:14:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbk5hubsW/s2DkMn2cN4yg+3eM+3d59AsI2ATwkvdpJ2zlYPh3Hhw5AQqvISYwlYH9+NKJJPfadeopQJtavnx6gidKaKxxi+FdlEEGxiObRNeWy9SYCAGGK8qcml8h8E6XMM+xw10bkyMmulv7XIDwXOL9iGGm/OROdE63xtGoBmnP6Rw2pqUiDFV50jFjuY4/9bq1mzaTs3vzoXT00RyPZwGBloA3vZwPXScMYjCCh+P+6OU+/kQuD0TdFx0xQsZmKk93/refJR6lglssWsbPdU0rNUjSZFJIBgkVB9QcVEWP6h+e5D0l43y1PRdH+EG8GrdW+r50iXKGsrmycXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmyUxIEYO0iSu7GeJ/sNTZR7/lB1iDtAGDl8xifScN0=;
 b=fgJm81IVlwi0WhbKs2D5J1JQw07OKEM5B+/XSCACiKcDAKLW45R24YWyo0bH2wXZVVFrzQvq2JpGtZAxrHewkV3h6GwACVh9mMrdqqCQb6Xqeic1U9bBAsRWderkAeZaobKCgR7p0h4WLIuNU0XnPOxD/5ZoTmJai7K/PhVsvXf7OodM9grUrGPSo9ENIQy5KyeaQOZU5a3B4TM1IdFOsniHQzF7ygZHf43YVJRL3Vm73eizrccgKSg5LbsbGj3xl6qemxz+5O+1fewTSDKgM2r0sekyjIfG32kTxFy6h+683rNCjGi3cBmIhDQPmZh6fgr/Da4Od7MwaYDFPLmuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmyUxIEYO0iSu7GeJ/sNTZR7/lB1iDtAGDl8xifScN0=;
 b=Sn3laNcT7xo568RPaWlNdj81hgc3iSK+GWyxoKT6L0UXGpZdnrEtYsI68QJHGsE+IL9KXmTkLJRIjzfrSgqfu2xPGjNbn62Loxi/kd4Myu8qa1jpEREq/jsyeNzqauzq/IAOmvKhp4rb1KN5vRcUa4ViGzIdP3qd0IZl3EcmNHs=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by CY4PR11MB2056.namprd11.prod.outlook.com (2603:10b6:903:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 07:14:09 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::2447:4025:79e6:7c08]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::2447:4025:79e6:7c08%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 07:14:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <chentsung@chromium.org>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [RESEND PATCH] mtd: spi-nor: core: Check written SR value in
 spi_nor_write_16bit_sr_and_check()
Thread-Topic: [RESEND PATCH] mtd: spi-nor: core: Check written SR value in
 spi_nor_write_16bit_sr_and_check()
Thread-Index: AQHYWgX8ewfNtQDrSE2YBtaW8mA4Jq0DWLkA
Date:   Wed, 27 Apr 2022 07:14:09 +0000
Message-ID: <c6b2956d-85f6-19c3-4282-23a72a1b5849@microchip.com>
References: <20220126073227.3401275-1-chentsung@chromium.org>
 <20220131171929.uk3z5sr453c3eefp@ti.com>
 <0e02112a-317c-e95b-e0d3-7ed2c74c3509@microchip.com>
In-Reply-To: <0e02112a-317c-e95b-e0d3-7ed2c74c3509@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83afb843-1975-4ce9-fb69-08da281d85db
x-ms-traffictypediagnostic: CY4PR11MB2056:EE_
x-microsoft-antispam-prvs: <CY4PR11MB2056FD7DC86C3CA6A2167C17F0FA9@CY4PR11MB2056.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZRNb1RS8m06C2J4mQooH3jfekmkbWDlu6Q3Gxey5k7IqLVo5D/+eNw6wpYngl/g6qFuDQm2UebpptlqyX6We+fvUkaXp97o+mW5LprXXIVsKF6hJr/izjDCbPuvDKpD7sUhc/wQirfwc9WA1DW+9cjWZTw/Nou2oVL2vRoHGCK6ydXRoc8WRlQVU4Lgz/xps7SZuQ3u/lYb2jDvStyZsxAHNM6D4RifA1zkGxkSp3hEzD5aohuF2x0JdoTfkxg0OHkEoXlph5H79nEU6RGivCRImjjkQR84X1NyoYdQtaDNcXeCWzOSW2ULTXwpiH71wbJYWEi0r+YLIrJqUcdoG97Dqssv3Yn1ufXkIyzKJU6b0H0wTZSQzsxRBtauJZnu+Ljr+XrCgJPVMGEmKj8TccXbpww/TDNXTHiUfRdWEOZVVwLbrYfA7eqlucLOjRqEKVdxS5MACjr38anYYdIsj4gpXW+I4p1FIt5/+UKPYnycDwc/46v2VTyCkabwiikJl70lDGump/ReR6TCAbrSbDaONkH4InD5zBXu69RSxn5kFkqswBCQNohKPZcwwh76WsBui9pvzUYL6HIiCicHIUaH3QU0W/Ss8nXpePpLcNrUW49NhqMPOCEff8eTcdspTTqwcWhB6k5luveE+UyDVMcya6ZxhyfZaD4adBALSfX1GIQfEf7jKZq+Omkz2HqsdoMLlQ0s7YWlMMMVIMubUkgrYQ9HAmjV7Z8+pHjbiwae6uv/z1cD9GsFS/eevpx06zl41KXgV6dRY7P/KZmu8Tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(66946007)(5660300002)(6512007)(91956017)(122000001)(8936002)(66446008)(66556008)(4326008)(76116006)(316002)(26005)(38100700002)(86362001)(31696002)(38070700005)(2906002)(508600001)(6486002)(71200400001)(64756008)(8676002)(66476007)(83380400001)(186003)(53546011)(110136005)(6506007)(31686004)(36756003)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2QxeWhleVpOYlB4RzFabGJ6dTRKc2cydjZxbU1kTW5FYjRvR1N1OXBhbW0v?=
 =?utf-8?B?VEVOQktTTmtJSFR5T0hFZHMzeTB4Nkk0NzROb2h3VDcwSEpDWUx5VVZiL1U1?=
 =?utf-8?B?YlR0dVI1NVRySy9La3g0WDRSbjhVSDM4aXVTamxzdm1KYm1hM2J6VFlkRjFR?=
 =?utf-8?B?MmdSL3psemlmTmt0N0Job3BJMWNRYlJFMllEeW1lNDk0VVFyMFA2RE52TXlP?=
 =?utf-8?B?dDZhQjlCM1JnWVA0dG1QNDdDRkwzTmdHOGdjQnNoQ1p2Ni8vUTVzT3JueXQ4?=
 =?utf-8?B?OG1CNHY2bVJabEtZaytIRGxIWEphNmRmU3g3TGJJRytDUC9PVkhsQWFZNFIz?=
 =?utf-8?B?UUg3TGZHOE5hbEVvU0ZGMXZaaXVwSzdlRDFrb3Q2VmJGY0QvYWpmdlVlYmdq?=
 =?utf-8?B?dDh2RTVab1pQeXZEUmRacUFhVkFOYWh3bHFSS25wbVBQMXRnZDk3aHpkczYz?=
 =?utf-8?B?cjJ3QnlaZkpFV2Q3R1R3c1Y4aXk2T3Q1aktGRytJd3UyK05zWkZDZU9oSEhK?=
 =?utf-8?B?VkVPeGNMVzdiYXBFWUdKNHlDZzU4ODErZ1owQyt0MmJJVWU4Q1VhOG9YN0VR?=
 =?utf-8?B?N0YrOCtsdkRuMDhoTnRlcEVLZ2ZMWEdEWDBmMDBZZG4wamc0SW9vNDk1aXht?=
 =?utf-8?B?YzlUVng1ZzhJdTRkQjN4amZ6dmlMaXJ2OGJlbDFnbytZOGRxT1FRdWw1SUtq?=
 =?utf-8?B?ZGFlNUVKRGVIUzN6bU1ubG9OOE1rd1dBT1Fvc2VneWg0WkNlR1gya1BPdDFt?=
 =?utf-8?B?YXI1RlBKTEYvZ1FKMlJpbmVCMFdudlFRbmE4OGtEWWtpdVYzOCsyemI5OHFr?=
 =?utf-8?B?QUZJSXEybUZSYmFLTkVadUNuaXZHMFA4T1hqaUdyQ0VDTERTNHdCM0JCYUsv?=
 =?utf-8?B?L2tNenZlN1RQRmZZbDl6RVhuSkNzUU8rZ3gyK1FQMUNPbFZwbzRBR2sxSDda?=
 =?utf-8?B?RGhickFWWUdwUllwQk1ja3NkU2lQalk4bVRVMGZvZ0sxS2RRWWd5V1IxNFBk?=
 =?utf-8?B?R2Y0a0tEZjdQZ1p2M3FJS2FlbHJ6UE5rVlpyTlU4V2VmbkFzNlBDcXoyNEJ2?=
 =?utf-8?B?VWNGaGQ2bVJ4cVArZUtDTFE1bXFoWU5NNlpDd2t5UVhiL09XaVFjKzdCeWFw?=
 =?utf-8?B?SEtNQXE3ZzlkOWJBTS9zWXB1ZlpCVGhTOUFQZnhYbDBOcTRIMjNneEdzNjI4?=
 =?utf-8?B?MkxoRm1hdkEvb0xVZm1kRU1Rd1NrMll6eEJBYXBDODJoNk5UQmFUWUVjZTJy?=
 =?utf-8?B?TGhDRVZCNkh6ZTE3ZkhzQnErTXdsdFZuZmF1bWV2RFNEZkhEU3VkbjRYMElW?=
 =?utf-8?B?dmpCZjN0TUpkR2tpOWNvRU1YTXg2WVRCcUl5VGsvdDdiVHh1cjZlUzNwT0RV?=
 =?utf-8?B?ZWZUMU1lVHh5WERVR3dnWXVYOGY1SWNjQ1RBUC8vdXBmMzBVN3FJV25ZWk1F?=
 =?utf-8?B?cUMrY09pZGVERWQyOXRzbXBpMkFpWnExVGpnNzRGMXdZeEt4RzNBQ2dMdUJB?=
 =?utf-8?B?SThjL29NbzE5UXo1VU5SUXU0aTRqdHRVRW1ROFBDWVR6TnUrOFlySEQrTVow?=
 =?utf-8?B?R24rQXhLalVNYW5HRFIwSU55K1ZkcGtFTXk3RXFyWVZxUW9FNXRwcm5RMDFp?=
 =?utf-8?B?RENRc015VGRGK2Rnek44a3NjQ2FHQnY1MGE4RE4zSDhmMkNIYzhIWWtnUEo5?=
 =?utf-8?B?TUVVL0xPZjkvbTFMc2R1cHI1Vm9vTG5mVmE1MUlhMU95VU90aThXMXBmeGpx?=
 =?utf-8?B?WllOZFVBR2EreldadXhNWjcweElCcHpjMnZBMm9heHEvVGtUYnZZVWZkRDVM?=
 =?utf-8?B?aVZ4cGFTZFMraTlDdmFqOEZoMnluS2F1aW9lK202MlllTHRGU0ptLzdJL2da?=
 =?utf-8?B?bUlVUHVXV0cwM2Voak50T1hSVzBjdVducWxOc0lPdGZkRm5PUWVQbUY4SVBt?=
 =?utf-8?B?WDlsN3V0dkhwTWtwYzh0QUVVRWtISS93T3Y0Z0JEaTM3NGYzWHNWVVJlbVI1?=
 =?utf-8?B?N2x2YWxNODFLZDNjb2doYnBFR3hJTHNJZFNRbFRTUC85MGwyaWxXMDBKZXdO?=
 =?utf-8?B?T2RmaUNUMlVOR1pEMXRmTDU5MG0rSEU5SnBPaHJyaU1vK2xtYTBuUUFvcnkv?=
 =?utf-8?B?ZkRRRzBmSHVmQzZDQUNvYWhsOTh4MGRaajRlSzdyWWpSSVlYY3NtVWNaRTli?=
 =?utf-8?B?ZjI4OG9Ka3UzNU04SXozVzN0VDBhWWNvZEZlNDhuQXIvMlBOY2swZHpFM1FO?=
 =?utf-8?B?ZVZnWHpWMHlsTkRCdnROU3N6OC9JVWdsZEs1cVVzS1ZqM0J5RmphT2VMMmVT?=
 =?utf-8?B?WEliK3JpZmpnamdXUm1YZGp5UG8zTlY5SGx5RE5ZbmlSb2hUeXR2ekNUMldx?=
 =?utf-8?Q?h7b6+LxOmXITHp30=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1234CB304526FE418E6C875ED5B5BB9C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83afb843-1975-4ce9-fb69-08da281d85db
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 07:14:09.0826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtOInf2zUHl3JTvP9DeSC8uHhCQS82Dd8Q8IXcQT8dvUQec3Au5KjtUjSekVdEdQLWdaxetw6gA+2LlKat4IYtYvHrRmES9SbEUAbwA36A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2056
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yNy8yMiAxMDoxMSwgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4gT24gMS8zMS8yMiAxOTox
OSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlz
IHNhZmUNCj4+DQo+PiBPbiAyNi8wMS8yMiAwMzozMlBNLCBDaGVuLVRzdW5nIEhzaWVoIHdyb3Rl
Og0KPj4+IFJlYWQgYmFjayBTdGF0dXMgUmVnaXN0ZXIgMSB0byBlbnN1cmUgdGhhdCB0aGUgd3Jp
dHRlbiBieXRlIG1hdGNoIHRoZQ0KPj4+IHJlY2VpdmVkIHZhbHVlIGFuZCByZXR1cm4gLUVJTyBp
ZiByZWFkIGJhY2sgdGVzdCBmYWlsZWQuDQo+Pj4NCj4+PiBXaXRob3V0IHRoaXMgcGF0Y2gsIHNw
aV9ub3Jfd3JpdGVfMTZiaXRfc3JfYW5kX2NoZWNrKCkgb25seSBjaGVjayB0aGUNCj4+PiBzZWNv
bmQgaGFsZiBvZiB0aGUgMTZiaXQuIEl0IGNhdXNlcyBlcnJvcnMgbGlrZSBzcGlfbm9yX3NyX3Vu
bG9jaygpDQo+Pj4gcmV0dXJuIHN1Y2Nlc3MgaW5jb3JyZWN0bHkgd2hlbiBzcGlfbm9yX3dyaXRl
XzE2Yml0X3NyX2FuZF9jaGVjaygpDQo+Pj4gZG9lc24ndCB3cml0ZSBTUiBzdWNjZXNzZnVsbHku
DQo+Pj4NCg0KY2MgdG8gc3RhYmxlIHBsZWFzZQ0KDQo+Pj4gRml4ZXM6IDM5ZDFlMzM0MGM3MyAo
Im10ZDogc3BpLW5vcjogRml4IGNsZWFyaW5nIG9mIFFFIGJpdCBvbiBsb2NrKCkvdW5sb2NrKCki
KQ0KPj4+IFNpZ25lZC1vZmYtYnk6IENoZW4tVHN1bmcgSHNpZWggPGNoZW50c3VuZ0BjaHJvbWl1
bS5vcmc+DQo+Pg0KPj4gSSBkb24ndCBrbm93IG11Y2ggYWJvdXQgdGhpcyBiaXQgb2YgY29kZSBi
dXQgdGhpcyBwYXRjaCBsb29rcyBmaW5lIHRvIG1lDQo+PiBmcm9tIHRoZSBzdXJmYWNlLiBXb3Vs
ZCBiZSBuaWNlIHRvIGhlYXIgZnJvbSBUdWRvciBhYm91dCB0aGlzIHRvbyBzaW5jZQ0KPj4gaGUg
YWRkZWQgdGhlIGZ1bmN0aW9uLg0KPiANCj4gUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1
ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBBY2tlZC1ieTogUHJhdHl1c2ggWWFk
YXYgPHAueWFkYXZAdGkuY29tPg0KDQo=
