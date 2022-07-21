Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FA157C5A1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiGUIAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGUIAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:00:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8AB1F625
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658390399; x=1689926399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i6p1PI3rOj4rtrZZu5BGhLl954yGb8XdTuYUi6PyrGw=;
  b=W3das5VYlgMtzhbi8JPr9FYF+vpUUMMMjtQoj9niecoYKJncoAgdj9VD
   vhbBtR1PHsLXU5Xbkb+W1rOwDtzT3RyOg5hmBjocGxaNyz5ps38rLuZV3
   xJzYEV8DefBxTd4AjvantqnUH2Yly5oew5NyWtrIfqCX6Eiqvb99hGsjf
   ojynRAfJCbVgmHY573w+9sTE5nheIbIlv7HO2Syf0hnWk/9cmqnXpYYDJ
   SJrpyAZeD57OegnvDdTTNN2ubAjn7wJTDwvKLLuayHYDaG1btdKlWfYjq
   fJJaGWiyDj1kOsKh+uUBE8YucwicsLi9rWfXbcx3g8io4gaVcLocFWNQq
   A==;
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="168853893"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jul 2022 00:59:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 21 Jul 2022 00:59:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 21 Jul 2022 00:59:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtYgsfMkzSfFLCJkDH/ko0SUo+6oGJd5MMcDbHUw615CuJymBDdri9UJl+HY9HVWOIkJcacvYPIvetgyueMLQg2mRBC/5IiNCNj3Y6OG9+VoTPm9j1h7Ujh7czriMWTUw4hcsBynApmdysmUJr7JgqENOeGIjRIAdnTosMa3oGnq0XI73936Ydjhvw5DBGmTLHaMeGKzzt5QPcqGExKkcMXVN8AZUL47zZq2vPxDNIvjD3em8CdIhysDkN5lokSuw13JfL70oFtqSwmuv1L08lHWoOf7zBmD47TYtvZzQfXnji+c9i3C2Z5GNqySy2A0aoroR/+WQol0Lt5UCvj3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6p1PI3rOj4rtrZZu5BGhLl954yGb8XdTuYUi6PyrGw=;
 b=mV0RMX8ttJDlL710oR141MdowyrCN8LToxknz0zH948f8NSvtgSuKJHjI+wb35lwPnyvzoTvFEniF2hUmDbkCJ7ifhkhvo6xNuBH4DxlQ3FgC97b/Yw561QTC2tfUj2Tn1+tscrTR9y9NUO+d+DTLsPrOfC551Su7kFij9WbqdxWAu4rqrYzi9sR4+BmN0OvE///Svu32eeQ7QMpGdLAQ35QNIh7u/MZEon4ofRK71XQ2YZs0PjgZh2OIfmDtUMmDlvBe/3yGuJOZcbMvRT73Or7tcMHRemMduscCvzus/SAgVJEJ6vfwd9vv1Q+0KtXA2zjcQEsIac33v6Tx8Bktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6p1PI3rOj4rtrZZu5BGhLl954yGb8XdTuYUi6PyrGw=;
 b=HmVM6xtcFA0yz1yMODwhMvbtgQPz/JlPIopa5tN3Tds+ywskhEvrrR6r2zyuy9DjHi4M5nwr3QXvrvtTr4viVrWkGn/uoPVfq/SlV6VppI9i2i/9nH8b2ysNVL8fMl7Q+NtqkFuZqNqcZyuCnub3NgxKmuBu/nAkrvFPOuny23A=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 CY4PR11MB1525.namprd11.prod.outlook.com (2603:10b6:910:9::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.15; Thu, 21 Jul 2022 07:59:56 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%6]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 07:59:56 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <jiaqing.zhao@linux.intel.com>, <linux-mtd@lists.infradead.org>,
        <p.yadav@ti.com>, <michael@walle.cc>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: spi-nor: micron: Add SPI_NOR_DUAL_READ flag on
 mt25ql02g
Thread-Topic: [PATCH 2/2] mtd: spi-nor: micron: Add SPI_NOR_DUAL_READ flag on
 mt25ql02g
Thread-Index: AQHYnNfdv9ZVU9zPV02fSmHYhCykcA==
Date:   Thu, 21 Jul 2022 07:59:56 +0000
Message-ID: <9fe7ad54-99d4-b972-1f4d-a5744efc5583@microchip.com>
References: <20220522054802.1719443-1-jiaqing.zhao@linux.intel.com>
 <20220522054802.1719443-2-jiaqing.zhao@linux.intel.com>
In-Reply-To: <20220522054802.1719443-2-jiaqing.zhao@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2cc1fc9-1ab2-4f72-b809-08da6aef006d
x-ms-traffictypediagnostic: CY4PR11MB1525:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wpsFXi8cvHVEnURZdbMNG/u3LcmeCY8j6fzBDBADpGjTIPCJGmS5oMM5GwPovxPyfVXByQBrWolWHGmlbuhNa4a996RouKma7aKxsJ1rxkaaE7W6MP2u028EG/oC8GKZ2cmdOK5wc73VfKMJ4hnpD/4yyeg1eCjGAI/1S/wCTITaovBOSCnTmWQzACjINV+hjgE5Y4h192EDph2bA4WgByR1QB7bxxZk3eYA/MGYBunBzWoTD+UfUzlHe5QMoaQPmauhUvjB5mp6kUkl68I43W7ziKlJok6od7+5R0cwAT6HLwkrVoqaxJ3+Yj9SZdZ6vBfiF4SJXT5ItYEqDaHkUtkhlAiZlQsOr728A0iCUKTjpLqyuRw9XPRsA9xHwU2I+qeSyXS/rlggF2DpPh+Ua7ZMZdGtEGOra3xycm7UtuDDEkqot90faG/pE+4A2Y5vq9+HA75frVCX6eGPJiPOJCnmstEt9lm4rvG4+VcHKWmPtIR/rU8JEi891vYX6nELxlGFwv4LL30bk2gZWGeXlmCLsw5bL/bbjKO3EfXmhmNbPrtgG1SWxY3mPUdEWFz1kwisMzajZx26rO5RLgZKeR5AsVqtrbuIZwKSWdjNPeU8OjRyDBVtqsNpf1sV1NknjBpTAsAqGroabRlPolOw5ltKVY/QZMQ+2oFFEmbLRmZiQWaZ7QvLR6O5JJqv+vc+f9vajRGKlnsnz+bAQ6Dl3jKv7c+qaRZ7P2LN+chLGxnu6gfhGt1AOV6mDbF0HqxkFH2w3RMDSiyHtk+K7y8mhZF4xE4vHz3OLbyGWWpNWGM/e+TrbxO2MEomi4OKDAIzEZQ3igum6Jsy00G09MQDH/CRak95R/efqrkjifdJl74=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(136003)(346002)(396003)(366004)(6506007)(38100700002)(36756003)(316002)(66476007)(31686004)(2616005)(186003)(110136005)(38070700005)(83380400001)(4326008)(2906002)(64756008)(53546011)(966005)(66556008)(86362001)(31696002)(41300700001)(66446008)(5660300002)(91956017)(8936002)(71200400001)(478600001)(6512007)(76116006)(122000001)(6486002)(66946007)(26005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aklDTXBIVlBSMFFBdFhPNHNPdm93RjRsREV6cGNhMzNPM2FiVEZPYVJJam9C?=
 =?utf-8?B?ci9VRjRncnVSa2duOHU0enpVaXhmb0dBVFhPUFl4REVxWEtBRW13RlNtY1VO?=
 =?utf-8?B?UkNpQ0hKYzEwTDkxR0prZXNLb3I4bGtRTFdCb2NhYmR5T0FJdGFaRlpnMnRs?=
 =?utf-8?B?c2lpb2dwZE9BL0lzcGJDNUpsVWRiUkJuS1FteVZtR2R5RklHU0dpdE14N3ZL?=
 =?utf-8?B?andkZ3BQMTkyQmlMVkUrYzdYMDBMeG5LK0RTUnNCTmpRRTFEOTBsUHBWdXJ1?=
 =?utf-8?B?TzRLR0tNN1FzUktyek56b3JGb3RZKzlUR1RPZXdzSmtCRjg1UGpvZnZWUXh1?=
 =?utf-8?B?c1RsdlBFa05qMjdpN3FSUkJHMm85Um9tUGR3V2dISHk2UUh1a29sazBXSVZa?=
 =?utf-8?B?SEJqeGdkV0pNR0JyWkkydzBaUzdSTHdWWU1lSEN1TUdDcytyRGhGK0QvRVZX?=
 =?utf-8?B?ZEJhNElZb3dESmRGOTZZSXkxaGZCdDZpT3VXNS9RUzZ1MTFQNE5YbVN6YTgx?=
 =?utf-8?B?MStnK1RpMVZIRHUrNU1UaXRVTXZQTURjZ1dFZ21SQzMzV21IaFJ0WTFnUFM4?=
 =?utf-8?B?Vi90ajV2R29TWE5XWE5LdENpUkdrbDNsbURmVGNJYVQxVXZCZE55R25UcGNi?=
 =?utf-8?B?WUxCc1A4VG15b2hDZkl6TlpRekJ2bUE0MVU2cng1SXdzNGNsRGdHSWRpYzd1?=
 =?utf-8?B?RDlKV01WZlRRMHdIcHY0SDF5cUNrdTZybDNyaW9ndGpUSnBDbE14UFBvald2?=
 =?utf-8?B?VVlDdXBuOWovZkZWY3piaXNsaWhyaEROKzlFMUYwOXdxYlVsak54SytqZVBv?=
 =?utf-8?B?VkU0MHFvM0RWbE84NGtEQ2RrY05tL2hhZXkrb0xpdjBLL2swQWtoWGxzWXN1?=
 =?utf-8?B?b0lPQVU2RkVIYlJEWXB4OWtaT2RjV2JvMStLc1Z0V1ZXRnZ6R0RRUW9UZFZ2?=
 =?utf-8?B?RWIwNTFRcTIzdTBRaDUxRFgwSDlSVjRJMVlmb3F2aWgwbFdqOGhzamdoMlVF?=
 =?utf-8?B?UXpmdE1WR205eWhmc3UvMjVqT29xR0lCc1dVbnNoOUdvSC8rRWVFVTNDQ3lI?=
 =?utf-8?B?bEhBbFR2NW5SVjh0WE5jTC9FZEgvZ2VxNXJ1d0NDWmNDWCtUNmpCSjB4dnVk?=
 =?utf-8?B?dHdVaXh5eVpSU203QmpJK3d6d1FrbDdJekpNNkQ1ZTZTZE8rK09RVFRDVTNW?=
 =?utf-8?B?RVhKUXAwQ2xwd0Q4WWtJTm5LUkd2MFFMdWdvV2g4ZVJiSGphdEVFd1FINXh1?=
 =?utf-8?B?MkUyUVZUbW9Sb1pYblJXcnQ5TGE1cUx6OC9SWldrZVc2WmZsTzYyWDFLRG00?=
 =?utf-8?B?bzQrb3FWdDlmQjkrYWxOR0VMUEhYd3ZBUTF2djhIT1FPRm9lSG9uanhmWGZy?=
 =?utf-8?B?dkdPSkZlUFRTNGsrUXhtSm13bTlkR3ZPNWdCSExXT2tYWjVCOUxkM3hsTysx?=
 =?utf-8?B?Rjd2V0tjU3gwdU5KWHM3dWg5emVDUXNVOHlJYXNjMkR4ZnQzeGJCbE5paFNQ?=
 =?utf-8?B?TlBabjhuN2NMTVZSc1NUYXJoYkFXM2hxZ004SVJsUDEzckI5TmdCb2VKQUJ1?=
 =?utf-8?B?RjJjUDB5NktEMlNtUUJlY2RhcjEwbFdTNVk3OEFGRHNPVFcrK2FJRnV4aElE?=
 =?utf-8?B?UE9pNFZ2M1lmL0F2S0s3WlZicGMvVEp6MlB5dExBeWJEY2o4VUVrczhYSkZW?=
 =?utf-8?B?Vnl4cTdpcUpKNGtXeGdOKzlnb2U3MUJGMFNPOWpQZ2tDZ0kwdTNaRXFsSXRE?=
 =?utf-8?B?ZjYwOWF3WVQ1SDBnd0doQXJKUFRWVnJIeWJ3b1hOUDl0NlpVUlhuRzN0cnZ5?=
 =?utf-8?B?Y0FLcUp2bkRnU1hiZlJLL2txd1dRQVEyS0RDWUFaek1LNjJPa1pBcUptbHl6?=
 =?utf-8?B?bGZraTNjSGdqSEQ1dUhEUloxcE9Wdzg5YWh0VVV2eGQ5Nm9pblB6TUpJYzF2?=
 =?utf-8?B?ak9YeldSZ2tBRTZjOEcrdHJDYXQ1bEJKcnFzSG1FMnZ1cnVYbk5HOGlhZis4?=
 =?utf-8?B?dmRtcHZjU2hiMGU1eVVud3RPaG1nZTRsNG5Pb2Q5cGVvNzJ4S1RMTThvbWdx?=
 =?utf-8?B?NGV1eDZmdDB3cFJkWnN2OFRxY0Z4ZTdoV0F5MFB1SXYvUENzay9DN1hHaTV4?=
 =?utf-8?B?Rnc2bEVFb2I2cGY5bnZDMHVGZndSMFB2KzV6K0UvTGdNTmNZTVpPZGMvMjJE?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <384FB453B8CA484686914261AD562570@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cc1fc9-1ab2-4f72-b809-08da6aef006d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 07:59:56.2640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IehlI358SsTN79f+sE0PoCergdX7wDWq4oOX2POWoXSbLxFb5DV9bKHyIhphhMIOuORrkt6PallDT4g+2w/EyJgyb3841wpwkmlwmotVnTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1525
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yMi8yMiAwODo0OCwgSmlhcWluZyBaaGFvIHdyb3RlOg0KPiBbWW91IGRvbid0IG9mdGVu
IGdldCBlbWFpbCBmcm9tIGppYXFpbmcuemhhb0BsaW51eC5pbnRlbC5jb20uIExlYXJuIHdoeSB0
aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRp
ZmljYXRpb24uXQ0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0K
PiBUaGUgTWljcm9uIG10MjVxbDAyZyBzdXBwb3J0cyB4MiB3aWR0aCBkdWFsIG1vZGUgb3BlcmF0
aW9uLiBUaGlzIHBhdGNoDQo+IGFkZHMgdGhlIFNQSV9OT1JfRFVBTF9SRUFEIGZsYWcgdG8gaXRz
IGZsYXNoX2luZm8gZW50cnkuDQoNCmNhbid0IHRoZSBkdWFsIG1vZGUgYmUgcmV0cmlldmVkIGZy
b20gU0ZEUD8NCkNhbiB5b3UgZHVtcCB0aGUgc3lzZnMgc2ZkcCB0YWJsZSBwbGVhc2U/DQoNCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEppYXFpbmcgWmhhbyA8amlhcWluZy56aGFvQGxpbnV4LmludGVs
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jIHwgMiArLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYyBiL2RyaXZlcnMvbXRk
L3NwaS1ub3IvbWljcm9uLXN0LmMNCj4gaW5kZXggOGEyMDQ3NWNlNzdhLi5kYTAyNTFjMWEyNjMg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMNCj4gKysrIGIv
ZHJpdmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYw0KPiBAQCAtMjMzLDcgKzIzMyw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBzdF9ub3JfcGFydHNbXSA9IHsNCj4gICAgICAg
ICB9LA0KPiAgICAgICAgIHsgIm10MjVxbDAyZyIsICAgSU5GTygweDIwYmEyMiwgMCwgNjQgKiAx
MDI0LCA0MDk2KQ0KPiAgICAgICAgICAgICAgICAgRkxBR1MoTk9fQ0hJUF9FUkFTRSkNCj4gLSAg
ICAgICAgICAgICAgIE5PX1NGRFBfRkxBR1MoU0VDVF80SyB8IFNQSV9OT1JfUVVBRF9SRUFEKQ0K
PiArICAgICAgICAgICAgICAgTk9fU0ZEUF9GTEFHUyhTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JF
QUQgfCBTUElfTk9SX1FVQURfUkVBRCkNCj4gICAgICAgICAgICAgICAgIE1GUl9GTEFHUyhVU0Vf
RlNSKQ0KPiAgICAgICAgIH0sDQo+ICAgICAgICAgeyAibXQyNXF1MDJnIiwgICBJTkZPKDB4MjBi
YjIyLCAwLCA2NCAqIDEwMjQsIDQwOTYpDQo+IC0tDQo+IDIuMzQuMQ0KPiANCg0K
