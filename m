Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B50C5A435E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiH2GpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiH2GpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:45:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4709140DB;
        Sun, 28 Aug 2022 23:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661755518; x=1693291518;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=IKnf53DCUq4LDatojdPZMcmoCX7hXtdhaQQg1rs5Mm4=;
  b=zDFwl5P6neBG7w5Va8RJrZwwPXBhnxauiH81g8H1PN/0gDizGL5IDLBE
   hgVyfmeBvqhPot6AmYPcGM/FkXee6vFyRx1uxzvieJKsF4MltHJmMQGed
   u6cP19m+Ew5BTbIL37d4n89qlEc7rwuJ6+ImoZ/Sj7ITHse764BZ1RlZ5
   sAP+oT6hG3S31QLnBc5iHcHk+c9rzroOmcoDMaojrDCX7X8bTiDr9gM8O
   pRhlbS8ypod+5uXtgsLnDpHdtLCePtpcGvZUgXYgXlRhoQOG6ANkgDU2M
   caD6GnEP1GxHI7xe5Dn4jKCRon6MekIJwP99dXBdK4O9T/hRSKAg6I16J
   w==;
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="178099245"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Aug 2022 23:45:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 28 Aug 2022 23:45:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Sun, 28 Aug 2022 23:45:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg1RYFfFxvWloo8D8GEtmQ5fEKexjPfI5AVv6Su0PFAr64yMNpuVbUepY49E3KHUBjrq+2qqC8MDDpJqynlz5FiH5TiTA6Kno/zYIrh53hlotTDA/VqHJfhnTG1E3ENwugjQTDuZtiq2dyUPcvI1CGkuY+aYJ1NwPNck1aglozDMkZ6qdJCepum8yufadV74DqiCvd/EZfuZfPtfiL9xq+C30atV2Y60fjL2QMTFsnJuI9HiyXrDnA7gqNiLqRJ8Mm+tS2dnAkGoAuf/9GgP2HPXqL/Wy76UQJekFO9gPrXDS16iSslht5iodyov+D5+xps7rMd80RnWq2mCxcciow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKnf53DCUq4LDatojdPZMcmoCX7hXtdhaQQg1rs5Mm4=;
 b=jqbWylPpjEHVyYpjyp79SeWw/NUg33DmMUgYQ0zNG02ud+VCjI9dAb+hXMZKtvnepOJONMuiuc91XFlJfNIBgEvgv+PzotiakOb1W0jxJSsJ1hU4BNEsf7FXoOvGDLoy4YaJzJWOvyymBVqAsaMl/ad8HfMrw3X8V4zr3yYyRJ7LVrgSXK8OIci09Tb5gpcTuZJmSpGRIBl4uNfHIXaJ5soqEOR3wxWIrOFYMSFzbkkTHwrbRYpeNMuziGXsSoc5YjWP+u28xN5Vme0xO7CSD6Ypy7VcqCfEzExMoNVQMx/Sl6y4Ytofyhlw4qVIyqRZl6mDmD++UPp0AKsclN/6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKnf53DCUq4LDatojdPZMcmoCX7hXtdhaQQg1rs5Mm4=;
 b=K0iasgibj/fv60NXOkSqFrBfApWIB324LyDLiKJRtjAJOvrFUOx1VRquKI0tsM9NtQC+4j+BymTQ8qtsaGDJgUldQJWbOQfT9uFvhnwgdmmCq0TI94VrzJZdgd/SL53LsAk2DC1KsPlwZH2N0kedlb3Cw6A5ApuKbArHwWWT0mI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3097.namprd11.prod.outlook.com (2603:10b6:5:6b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 06:45:06 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 06:45:06 +0000
From:   <Conor.Dooley@microchip.com>
To:     <zong.li@sifive.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: sifive-ccache: rename SiFive L2 cache to
 composible cache
Thread-Topic: [PATCH 1/3] dt-bindings: sifive-ccache: rename SiFive L2 cache
 to composible cache
Thread-Index: AQHYu2+1XcSE4znQXEqWCBh0Heoa7q3FbsuA
Date:   Mon, 29 Aug 2022 06:45:06 +0000
Message-ID: <d009d829-54d5-7b96-cfbb-3f75515a29fe@microchip.com>
References: <20220829062202.3287-1-zong.li@sifive.com>
 <20220829062202.3287-2-zong.li@sifive.com>
In-Reply-To: <20220829062202.3287-2-zong.li@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8017602e-559d-432f-7f19-08da898a0265
x-ms-traffictypediagnostic: DM6PR11MB3097:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uvcoetxPFkgKzoiW7FQR9HBVVzqNWzrNY6PJvddyJxRiUHfFm9EWM96OjVg6QNLkD//ok6Y0pJoz79U7Paf2hyc92Y633uxGWuyfA5RXSnXquD8QhTqZ0GhvYXivZhM/i7uBqd1HDwtrCujpaEnNo0z8KWskVxewVeEe++ID9wUwvlAPlZubXpgAQK1r2HPVNNjpVI3UUmUljUcLzOt+CmgJecMhxceVs108HEgscXAusPCe3CmFShKukvYQEO4XAzGgthRU+o2H7MiRtK3gCbMnJiUAAjFE2t9hs43rLO5l/vQG/gONYhUGHaqEDtiJeVuAcVfMT3L60VDXtlo24Tqdt2BVcSf0Boe4TGPVMXiV7pjppnfLp/R/gRr6XyFMugW9Jf5bxu0L+fViaB3rjDZ/Adahy1SYb0sDn7BJNXDKqn4lg2Yk8yIBi8yYsRo1vBMr9Ycq44B45bn6Sj0kfuiqpICuywVmIrHMe/6bZPJFbbFU9pLA1XoVkATUAHgT5KovzKkxxPv5qCbdDTGVhkszqxzAXvevT1xfUZtNBsML3aWq7rZ55WcMyhc2M50W/hsix9+bNwRT8ZoxHbL4H+9NHCfGQ0dsi/1FsemWahjdb0+vTEV9HZhC1SVNcDEA9chLzTrja9zqQ31+gxORYHHWOiCV1keymdD+REBJiLY6l0erOygA9juktwy9L+0Rexmt7BGI0mySJ0qP85L+Q3dle0nYPEVyk9gqH+MvdyagcINAZ03Wd39ZZbBKh1P7cqSnRk0ybGEKyklFY1FS9jAvpZgbaNV9BPSn+uE+fNA8aRDFN/gHFy52OmPrJnPDxmEcl8se/KBu3WyBYxAZubPCkTtmAmFrfm6uR/nKyU8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(6029001)(366004)(396003)(39860400002)(376002)(136003)(346002)(66476007)(2906002)(66446008)(110136005)(64756008)(66556008)(5660300002)(66946007)(8936002)(8676002)(2616005)(31686004)(36756003)(7416002)(76116006)(316002)(91956017)(6486002)(41300700001)(6506007)(26005)(86362001)(6512007)(53546011)(71200400001)(31696002)(38070700005)(186003)(83380400001)(478600001)(921005)(122000001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlR2YTFxRWJVRGw0TkJ2eG9PemdnS3BIRmRtUFBNcDEzb3FPdjNwZmxSYXFs?=
 =?utf-8?B?ZktQVnhWeUU5RjNkQ2oyRXFLZGlVTHpDRkZuWWRBT3YvOXZtTUgrbWtNc2ZO?=
 =?utf-8?B?RXJMam43VDlZa1ZSQTFPeStyT1hGTzJjN25ZeUtsVFVBbXQxTytQcGxzeXR4?=
 =?utf-8?B?bFlMWjBpL25pWDB3dktyMWRpNS9hTG54QzNEVmJhUnZVU1lSRm5tWEtRSzFx?=
 =?utf-8?B?QjM0RXpPMy9QMC9icEUzOTBUYW8rRStRZGtEazdsbUpIMDVLeE9zL0RJZzlF?=
 =?utf-8?B?QkMzcVV0UE5yWXN2MkhHWUNBa3BIRFRCanlmZ1B4NlFaWHlhOW1URjlnNjRy?=
 =?utf-8?B?djljTmhIV3M5MkUvMmMzYkJ2WlR0STdacTFLWXdGbEFUU3VQR1VqR0g0WWxX?=
 =?utf-8?B?RitmU1ZEOHU4Y2Z3cjV4YldxU0xPUSt0RTM4aUVDR3pTcFVieldhKzJkYlRG?=
 =?utf-8?B?bjBJS1piMEtFS1FMR1UwRUxQdE02Sm9WT2NUb0lwVHBLU3Rrb0s3OFduQTda?=
 =?utf-8?B?WGpwK2l5ZFF3dVdKT3ljNStDMzU2UW9pNXZJdGhrSmQyQWMxYS9TNUwvaTNR?=
 =?utf-8?B?MUMrVGplUFNTS3BWdm9ua2EvOExDb3lMdktGRzRGM3dKRFlsTXNtbzVjZkZ3?=
 =?utf-8?B?NHl1QnY4K3dDOHJKMUZabW5wUlYvSlVTMFBBV2hKU2dyU3lMY2V6S0RRVEoz?=
 =?utf-8?B?TWZ0cEN4bU9HRWVMUGZLcEtrWlRidHpybmFuSjU2bEdMMnlMRkM2eklyN0dz?=
 =?utf-8?B?Rk5OREh3eCt1ZUpCdmFGM1VKcmtidWVHNWM4NDl0cEQrQzVVd2VDVTVKTTZF?=
 =?utf-8?B?eTNDM3ZMR3JUeTRYMXFVSVdMcTJUM0lLWDhKcXhWWjVGbnNqS0k5MWNtWWNC?=
 =?utf-8?B?MDNsaTl2MXZPRGNIbmx5WndGMWQ3aGN5dWdvUnZ4MnZndDc0Z0RZQjhDLzda?=
 =?utf-8?B?aDI1Z1BpQjJsZjNjVVNFUTlqaWJ6dldTajdneEpZU1I2T0J1eitFcGRTcytj?=
 =?utf-8?B?UkZscHlHQlROaXd1VVVmNk9kVVhEMVk0ejlheVdkWHBWZHo2aTVYdDlMVG9U?=
 =?utf-8?B?OVBoRVhrZWNidnJIb2hkcDE0UWZCY1dhVHMrRzdVeGt5NDRvTjZlVHloUFlQ?=
 =?utf-8?B?Tnp0em5lVWd2ZUovaUtSUjJtYlpCZEdMTHd1VE0weXNuT1FQaC93c2JKVTFF?=
 =?utf-8?B?TXpBSHFCRHk5bmdzSDduZ3B1a0dVSCtLWWhuVi93YnBYRnVNRDBTOFprNjRy?=
 =?utf-8?B?NitEMUlBM250SjJuTGhqWldaWmk0dkQzZnp5YnJYaGhuUjRTS3QySG91UGJG?=
 =?utf-8?B?NzhhcUI5WUo5bUt4NFd4c245bmxCN2tBK1VWTzdaOGZMQ1BoK1dSSm5jVFBu?=
 =?utf-8?B?bGY3SndwU3dLUHlSK1FwbWJocGhFNllQZk8rRjlwTVNqVmo4TzJjZDRVWVRn?=
 =?utf-8?B?QzhSQTgrT3ljdjByMWNmbWJpbnp4dVZqR2EvTXhuM2tQZUY0VDdQYldIOEs4?=
 =?utf-8?B?RTFSTTFKWlBmVjJWUGw2MXdwV3pmZ0FvWDFTdGhQSTdWOHpjZ0cyYXNuc25o?=
 =?utf-8?B?NXdxTzF1dFF6bzRTdDdxSnZnd3dDOVA5RU1XTExyMmVFUnkwT003ZklCVDBB?=
 =?utf-8?B?TzlNMjMrTkVJUGk5RzgzTDlDTHdKclZKbWZHMCs1OTVpZlgyb0tCTE52MVJp?=
 =?utf-8?B?aEJQMGtvcmdWZmJ4aHd0SldJOURBM2tLcHI1TUFoYnU3L050b1l6ejByRExt?=
 =?utf-8?B?ZTJ6d0RPdEMvVlZleVpYRnovREdGb1c4TVJqTGxFVy82dlV6VXFxQXFhTkpC?=
 =?utf-8?B?MGJFMUtEc0FMK21NODI0Z243RkVuT05uTmJYODk4SmEweXoyK0gyQXArK2VR?=
 =?utf-8?B?REQ1d0lCQnBocjJzZDVocjJtWDN5MGxJV1BpWmFFb2RGZ0V2a0Y3VXROaEV3?=
 =?utf-8?B?Q2FxYVZxWk16QU1WWXkrZGxERWoyUXg3Q3kzb2x0WFo0dzdTSlhXSW1seGtD?=
 =?utf-8?B?clIvM2ZlWFhad2lzS0hIdEd0ejdRTFFId2g4RkZKTFdrYXpKaGU5bUJDUlNo?=
 =?utf-8?B?cGY1eWVaSG5kVXBJMGhyWnBzdlBkMVpBUWNQLzduK3VjdnVDNDI3N1JWVXlO?=
 =?utf-8?Q?BAkZhKqxoWXyxitZbf7WPpCer?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78E2EA4FD82C144B897624B785270A1C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8017602e-559d-432f-7f19-08da898a0265
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 06:45:06.4731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpN632N98UhWIW7AWpe4OdgOugWKSEqw6K0yi/MlrzeS2KDRJO76ZFSHPqcwjVDZ/P1HnOXYlkOX+1J4DTC3d+M6cD0k2SNgm4tAhrHANWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3097
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IFpvbmcsDQpDb3VwbGUgcXVpY2sgY29tbWVudHMgZm9yIHlvdToNCg0KT24gMjkvMDgvMjAy
MiAwNzoyMiwgWm9uZyBMaSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBz
YWZlDQo+IA0KPiBTaW5jZSBjb21wb3NpYmxlIGNhY2hlIG1heSBiZSBMMyBjYWNoZSBpZiBwcml2
YXRlIEwyIGNhY2hlIGV4aXN0cywgaXQNCg0Kcy9jb21wb3NpYmxlL2NvbXBvc2FibGUNCg0KPiBz
aG91bGQgdXNlIGl0cyBvcmlnaW5hbCBuYW1lIGNvbXBvc2libGUgY2FjaGUgdG8gcHJldmVudCBj
b25mdXNpb24uDQoNCnMvY29tcG9zaWJsZS9jb21wb3NhYmxlDQoNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEdyZWVudGltZSBIdSA8Z3JlZW50aW1lLmh1QHNpZml2ZS5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IFpvbmcgTGkgPHpvbmcubGlAc2lmaXZlLmNvbT4NCj4gLS0tDQo+ICAgLi4uL3Jpc2N2L3tz
aWZpdmUtbDItY2FjaGUueWFtbCA9PiBzaWZpdmUtY2NhY2hlLnlhbWx9ICAgICAgfCA2ICsrKyst
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
ICAgcmVuYW1lIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi97c2lmaXZl
LWwyLWNhY2hlLnlhbWwgPT4gc2lmaXZlLWNjYWNoZS55YW1sfSAoOTIlKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9zaWZpdmUtbDIt
Y2FjaGUueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9zaWZp
dmUtY2NhY2hlLnlhbWwNCj4gc2ltaWxhcml0eSBpbmRleCA5MiUNCj4gcmVuYW1lIGZyb20gRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2L3NpZml2ZS1sMi1jYWNoZS55YW1s
DQo+IHJlbmFtZSB0byBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3Yvc2lm
aXZlLWNjYWNoZS55YW1sDQo+IGluZGV4IDY5Y2RhYjE4ZDYyOS4uMWE2NGE1Mzg0ZTM2IDEwMDY0
NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3Yvc2lmaXZl
LWwyLWNhY2hlLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3Jpc2N2L3NpZml2ZS1jY2FjaGUueWFtbA0KDQpCaW5kaW5nIGZpbGVuYW1lcyBhcmUgc3VwcG9z
ZWQgdG8gbWF0Y2ggdGhlIGZpcnN0IGNvbXBhdGlibGUuIFNpbmNlDQppdCB3YXMgbm90IG5hbWVk
IHRoYXQgd2F5IGluIHRoZSBmaXJzdCBwbGFjZSwgSSBzdXBwb3NlIG5hbWluZyBhZnRlcg0KdGhl
IGdlbmVyaWMgY29tcGF0aWJsZSBtYWtlcyB0aGUgbW9zdCBzZW5zZS4gVGhlIGNvcnJlY3QgZmls
ZW5hbWUNCndvdWxkIHRoZW4gYmUgInNpZml2ZSxjY2FjaGUwLnlhbWwiDQoNCj4gQEAgLTEyLDgg
KzEyLDggQEAgbWFpbnRhaW5lcnM6DQo+ICAgICAtIFBhdWwgV2FsbXNsZXkgIDxwYXVsLndhbG1z
bGV5QHNpZml2ZS5jb20+DQo+IA0KPiAgIGRlc2NyaXB0aW9uOg0KPiAtICBUaGUgU2lGaXZlIExl
dmVsIDIgQ2FjaGUgQ29udHJvbGxlciBpcyB1c2VkIHRvIHByb3ZpZGUgYWNjZXNzIHRvIGZhc3Qg
Y29waWVzDQo+IC0gIG9mIG1lbW9yeSBmb3IgbWFzdGVycyBpbiBhIENvcmUgQ29tcGxleC4gVGhl
IExldmVsIDIgQ2FjaGUgQ29udHJvbGxlciBhbHNvDQo+ICsgIFRoZSBTaUZpdmUgQ29tcG9zYWJs
ZSBDYWNoZSBDb250cm9sbGVyIGlzIHVzZWQgdG8gcHJvdmlkZSBhY2Nlc3MgdG8gZmFzdCBjb3Bp
ZXMNCj4gKyAgb2YgbWVtb3J5IGZvciBtYXN0ZXJzIGluIGEgQ29yZSBDb21wbGV4LiBUaGUgQ29t
cG9zYWJsZSBDYWNoZSBDb250cm9sbGVyIGFsc28NCj4gICAgIGFjdHMgYXMgZGlyZWN0b3J5LWJh
c2VkIGNvaGVyZW5jeSBtYW5hZ2VyLg0KPiAgICAgQWxsIHRoZSBwcm9wZXJ0aWVzIGluIGVQQVBS
L0RldmljZVRyZWUgc3BlY2lmaWNhdGlvbiBhcHBsaWVzIGZvciB0aGlzIHBsYXRmb3JtLg0KPiAN
Cj4gQEAgLTI3LDYgKzI3LDcgQEAgc2VsZWN0Og0KPiAgICAgICAgICAgZW51bToNCj4gICAgICAg
ICAgICAgLSBzaWZpdmUsZnU1NDAtYzAwMC1jY2FjaGUNCj4gICAgICAgICAgICAgLSBzaWZpdmUs
ZnU3NDAtYzAwMC1jY2FjaGUNCj4gKyAgICAgICAgICAtIHNpZml2ZSxjY2FjaGUwDQoNCkRlc3Bp
dGUgd2hhdCB0aGUgY29tbWl0IG1lc3NhZ2Ugc2F5cywgdGhpcyBpcyBtb3JlIHRoYW4gYSByZW5h
bWUuDQpUaGFua3MsDQpDb25vci4NCg0KPiANCj4gICAgIHJlcXVpcmVkOg0KPiAgICAgICAtIGNv
bXBhdGlibGUNCj4gQEAgLTM3LDYgKzM4LDcgQEAgcHJvcGVydGllczoNCj4gICAgICAgICAtIGVu
dW06DQo+ICAgICAgICAgICAgIC0gc2lmaXZlLGZ1NTQwLWMwMDAtY2NhY2hlDQo+ICAgICAgICAg
ICAgIC0gc2lmaXZlLGZ1NzQwLWMwMDAtY2NhY2hlDQo+ICsgICAgICAgICAgLSBzaWZpdmUsY2Nh
Y2hlMA0KPiAgICAgICAgIC0gY29uc3Q6IGNhY2hlDQo+IA0KPiAgICAgY2FjaGUtYmxvY2stc2l6
ZToNCj4gLS0NCj4gMi4xNy4xDQo+IA0KDQo=
