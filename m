Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD57586706
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiHAJoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiHAJoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:44:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8276937190;
        Mon,  1 Aug 2022 02:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659347076; x=1690883076;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W4AnvstPIzdlgTyZ5a2iIrMwNj3XZpbvLWxWsomfcYw=;
  b=bfbnPYZCyhVuLaSebBFDf+KJqGsjZozZjH/r6SnQJu2RftzstnxtCX/f
   gDLehZbbpbesXZae7Y9e7e3xkftAkDD68FHgGEolueY6G4/G7A7JvOzA/
   lQsxWCEfsNFO0nLyPr/MOUcnAaZ4CUy5WaH3P7s6HHksWE5FhqWXS4k1v
   wFcp/5gH24yH+jszg3t/dQl721TTRz8Y8x1pM6gBbACsHFE7uDQ9piUt0
   Xv74Y9Hv/RUkDp1dJQOFou0SzewmeYH3ttVk4INl4t6TzpdBhKmwgKMZO
   vkdGpb58MLceQqoetb+rlvt/gZBezI+8qD9iBA87kP2Pivc1SquIP7FLy
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="106989123"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Aug 2022 02:44:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 02:44:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 1 Aug 2022 02:44:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZCGQ7KW6HPsxoQacZNGrnw/zr9BfB6IBGfd6DCW/zOwbJappbFXYmQD4SJSoHiDZ9VIbFwvxIJ0ZhTR0RDIOhusbNB/z9UzvOMAxRx7IExkML3W9SwcAk7hw0KoI/R7PhDrur3gLLYDAdKS91yB153kH7Oxj22+SiZCNnN4+QDKP9jSWOcTSO+f5AhlZq0xonW2Hz29hpGS+LHeJGlQvjOHzNIGzZxrvUvHKF8fudFBNi2Q7f0bMM2vI2SHn51b4XvOwgVYGqDs/9WKp2eV/2tZCk7ztjnewvpmmEsld9ulcB6omvAnVjSgzZUFnKzFi6aix90hHbAKMj49cviMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4AnvstPIzdlgTyZ5a2iIrMwNj3XZpbvLWxWsomfcYw=;
 b=A6IoldUW1DyrkzpSWej8pEzwblQCjkwKtbCEtWJfMoApDV7KO9bCR3eku4Odb0B8bGXsB39CUSKiy9hQt5gJBoDrT6AhzbJctMHIVGJdHX1rvJSdpyUog4e/jJW3vlm2gXOBZszSsRHvWHq+sVFMbs61S9iYSA5uvUxgkRjvJL2lYRHeKPu+j1S2Onk0YBzylbygc46zjbUnzEYtcJS+ba6SlPAj6uL69CnETQfyT40C4nKLotf1n66uAGkNz3d9KYd+BMnQUSW/zKXpIAYMevo+UsXfHpDh6/iJNEpRDdphc8Xy0/uQjQpv5AfptX9Jjq7kcSnIUBybQ3mTCQFDMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4AnvstPIzdlgTyZ5a2iIrMwNj3XZpbvLWxWsomfcYw=;
 b=CobN6T2bUr2PBR6JWf5dlzJgLt4feTleIiAMwSixDbIieYbVj6cL+9yYs6FQf3ULA/8OgDayiP/i3XoI3pKkxu693UEfeqQBMwAk5FblVwln1QnDwfFEeT/22og1+qnn64foX/ZdoiVMZgY104MCVuX8mQ2tLWQyjOPwe3+66Yc=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ0PR11MB5615.namprd11.prod.outlook.com (2603:10b6:a03:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 09:44:30 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 09:44:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <jic23@kernel.org>
CC:     <Eugen.Hristev@microchip.com>, <lars@metafoo.de>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 19/19] iio: adc: at91-sama5d2_adc: add runtime pm
 support
Thread-Topic: [PATCH v2 19/19] iio: adc: at91-sama5d2_adc: add runtime pm
 support
Thread-Index: AQHYpYtLkpQs06VmrEudrSLpXJCwXg==
Date:   Mon, 1 Aug 2022 09:44:29 +0000
Message-ID: <dcdbed32-bf81-3e28-6f68-21bfc8e3f57d@microchip.com>
References: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
 <20220628151631.3116454-20-claudiu.beznea@microchip.com>
 <20220731211101.2ca0ab1b@jic23-huawei>
In-Reply-To: <20220731211101.2ca0ab1b@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4d69d04-146c-484a-65ca-08da73a26e16
x-ms-traffictypediagnostic: SJ0PR11MB5615:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bWvFyNILDDQQBn+CkXpwIUW4tpW6DShSSBfPoy2Evo02w2yKzS5p/HOxGDLCIS5NLmfcbCJAIhzefX7nfHGBtLq9pllX6qbcERo4JedNUQJ5tNv+l48oSlxTQvQq3PfkwEJSqJorqzaL4OsjeuDhSYamE3s4YAACMUoQvCwvE8XmJzxILCGR6LWnsWSafFGEyNC4dx3amdg6KTUI2fPF7qjzSlr+boS7FKS17koWNYR8s5rpsAd/6czNUGLvwXN9A6P+Kasto2AJgvT/c/fj09VKJdjLO+qQBro5ryUOLob+u6aPv8Ykmd3EJyK6ws2J3iLbNGKA9dz6cSLuof+G2NHSs1IqMKN06kUNUEB/JRkrB2SuboXjy/BJJC2tAjttS5iUAAWhDZGGDRKRP1c6OUxRrgX6xxDkpnzsvlj26lyqNF3mOZbDj2Q1nr15Il6kqXFFI0XZtkT5CXhq5UbaGnKciV0GSAE5GDU8nTG0huV2M0ixF8b3E13Slr5W7lgY/p8IQ23ZLGfFGT369gTWpHrpH/pNNk+wbmo6eD35JunAwI4dpHxmVWWYtxKyUF/3grvUnn2JqWU+/5MF3wo2qNipWgXuNoz6twmPJr7tMfSbxKZS0Tpb1XNR7pZTs4wOJ201lMQfSdpAFoexYjM2xR4tGgwffynPfduE/AW/bysHrz+0mJPsnED1WQ810bIBrnVrZxnuETTBJCqw9C3OOkxZkG0VM4WAcdIs7cP9LEyXhqiyQZ4DSLDCAhiEyN/UFVGS8+mvyUWBRGO+9TBBiCkRtkhGOjS5ijonmadbyYaKXo4fbnH2jlMouXcGOofLaP4btOq05xhw35jXB0YhzlNHF4yYD+irmIaVYuCpxYoNQZpSS6N8eIrKsLLKNUdU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(136003)(346002)(396003)(376002)(5660300002)(36756003)(8936002)(64756008)(8676002)(66556008)(66476007)(2906002)(76116006)(41300700001)(66946007)(91956017)(66446008)(31686004)(316002)(4326008)(53546011)(54906003)(71200400001)(6916009)(478600001)(6486002)(122000001)(6506007)(38070700005)(6512007)(2616005)(186003)(38100700002)(86362001)(31696002)(26005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU9MZlRQcndHOGRCek5wZ0dJMzdybms3YmxwalNpUnNldEphR2dYVkZqRjdE?=
 =?utf-8?B?cVZOMUNZaFdqaGpKbVVpWUQvV3RHVldjUFE1VnpsNFhyblNSdkZDWE1lcDdQ?=
 =?utf-8?B?NzJUdS9UZ2FFeHVMbW9LaHVybGsxK1JvV29oMnFyVmIxWVhZdjVIZU1najl2?=
 =?utf-8?B?N3JmdnhOSmJ4UVdIdnlDb2JZR040UGRhazJzOEp6aitMN1M3WlpjYlllbytX?=
 =?utf-8?B?OUViN2NsT1BTYVV5Sk54SXhUd2d5RjJ3aEhEVXVSczFldDZiYkR3YzFGRVA1?=
 =?utf-8?B?OWE5Y0pVUXh6dnRhNnd5N0xMN2VoeVdvNEYwcURwbEdxYVFwbDBqSXZXNU9q?=
 =?utf-8?B?dXNFbTZieUhSQ005aUpnVUJFMm84dWhwVldETGZUN1k3N0wvUFUyYlFjWEkr?=
 =?utf-8?B?cEhadnVQaGNnNmR3c0JlSkNtOUM4OUNWVHJhS0hrOHZCTGRpNFpqY093bnNH?=
 =?utf-8?B?SUhSdjRRNWpyL3k0YUlXUFlCMUpkaERxUE9QYm13MTk2b1Aza3JMcklCd1k1?=
 =?utf-8?B?WFk1RWFZYkdSd216U0RiaTFHL1Q4ejhFUkhoU0diaUtRWEhUdEtsK2U1TUZj?=
 =?utf-8?B?NHBNN0w0VlZMblhyTFFwUDgyQ1J3ekM5aVJKN0gvQkJKZzdLOXVudVRNdllI?=
 =?utf-8?B?djlvbEJXS3BMWGZhZFE3UnFLekJGbXNUNm1qbjZjTWxLbFc4SmIrUjBtM3Bp?=
 =?utf-8?B?bStlTk5teFVLVm1DZ3lxcHFHeUdOamlIdWdWaTROMVhrTi96c1crUVV0ZEFu?=
 =?utf-8?B?MzdLSFBjdEViNXJ0R0U0U0NtbldIWkFobis4UitkdDhBOTBSVmU2TktqNE9M?=
 =?utf-8?B?WXJNUmlQS2QwWnRIeDVoM1ZhTkNkaDVYdSs0eXRuRnd1MmM5UjUvbjhITC9D?=
 =?utf-8?B?NHl2WDg3L2VZeE5YbkRoeFFLbGNReFNCcG1sdmZRbnJGdTJOdjRvNUZWQkxU?=
 =?utf-8?B?UmFOZDlCcFZDWm5ETkJEVHp6TitFalpTWVk5UGE4TWM5U2pWdUFobm93MEY2?=
 =?utf-8?B?U2NJdHJYTStHYXI2cnJQdG5UL3ZKZzVhcWtIUXNJUWpBc0VOanhYRHRKWUJl?=
 =?utf-8?B?THcwRnhINEpqaTI2U0dJeXRUaXhYeGFDSFI1ZWkxNUE1QXZzNnowNUJmUTd1?=
 =?utf-8?B?OVpEcjlsNkJwYzRsM2hjOTdsK2svMmQyV29LS2tFQU8yaXdLQUk2eHo2U1BG?=
 =?utf-8?B?S3MxZHUrQUtySFEydlIzWVorZE1FOUd6NTFpUXNIanpnTndXQVludDRBSVNV?=
 =?utf-8?B?RkdhbWlSdlVDNGtGRnN3WlNaS2lLZm02cCtpbFA3VUNtNDRpRWJlYUcxRWJy?=
 =?utf-8?B?cy92RVYrMzNCSEQxN29UOUl0ZWtONmNsWjBPTzcvWkMxbFZpNS9mOHZPK3oz?=
 =?utf-8?B?OUVRYndnWDNpQ2dISzNLS2U2MHkrYldOeTJVK3NJalpES2FVOGR0Um5FQnI2?=
 =?utf-8?B?UVdNbytydi9QejF5YVExLzVXblpUSjhCK2dLUXh0dEp2a095QlE4akVyYXFl?=
 =?utf-8?B?VndndkxXNGwwT3VhT1NqMG9BTWVrbmZTM3FUbmVqb1FaNDBiekswTEJtNHln?=
 =?utf-8?B?SDNaZ0FSRDlQS2d2aEJ0Y1ZIKzRlUW40ekg4RCtzZHBQcmplUVN6VUcvOXRj?=
 =?utf-8?B?RU5RVjRTYWhlNis5UUVqTzA3VTZlcnBoUjZlZTFGalMvTEhURzdselc5dEk3?=
 =?utf-8?B?TmpXZGc5MEZIdU0vNjgxTThnUloyNkFsVGhEMnFNNmVPa0FFUDJyS285bXpX?=
 =?utf-8?B?NWtxNVhjYzJjTW5kY1oyZXNPd0IzMC9qUkNKNWtNb0x2S1c2RHdRWW5SRFZX?=
 =?utf-8?B?a1M3SlBUa1ZCWmZFNXo0RGRrZnJaeFBFWWpNUDNzdFg5WmR1N3YySHoveWF2?=
 =?utf-8?B?UE1FZ0xaQmQwbHBnYTVwb0JNaVZPTEVTb01JWWdoY0gwems1R1o5OEdwZjZ1?=
 =?utf-8?B?aUZOcXNOdDdjanZtSFp2VEtObHBUdmgwemhqczlaQWZGa3RPRDlyMzNkcDFj?=
 =?utf-8?B?NlRRb1AvVlMrS3JPRDdXSitVNzZ4ME1hOWlOeFJzNU44cThYMXB2VUk1OGdu?=
 =?utf-8?B?SlBhM3FtaFR0bE5GUm1XTjJ1VjVQcTdzSW9zcXlkOU56VGN3d2NzdjBYZ2xx?=
 =?utf-8?B?ck1uMHF0NWFGUisyZ1pxdW43cGFCOW40alpTRmMyT3VnblNjcXFianJXMHV1?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BD7E8FFFC1E8648B72AC83E657FCA33@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d69d04-146c-484a-65ca-08da73a26e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 09:44:29.4735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekgDQMExf34QXacV5x4dVwXa+epOuXzqTXvSjt7r4nK9ed2qIx4p28lKuqTbexq1c1A6ePFNbPz2cIXlkk64vihXSipHx92wgyWbomJW+4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5615
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEuMDcuMjAyMiAyMzoxMSwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUdWUsIDI4IEp1biAyMDIyIDE4OjE2
OjMxICswMzAwDQo+IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29t
PiB3cm90ZToNCj4gDQo+PiBBZGQgcnVudGltZSBQTSBzdXBwb3J0IGJ5IGRpc2FibGluZy9lbmFi
bGluZyBBREMncyBwZXJpcGhlcmFsIGNsb2NrLg0KPj4gT24gc2ltcGxlIGNvbnZlcnNpb24gdGhl
IEFEQydzIGNsb2NrIGlzIGtlcHQgZW5hYmxlZCBqdXN0IHdoaWxlIHRoZQ0KPj4gY29udmVyc2lv
biBpcyBpbiBwcm9ncmVzcy4gVGhpcyBpbmNsdWRlcyBhbHNvIHRlbXBlcmF0dXJlIGNvbnZlcnNp
b24uDQo+PiBGb3IgdHJpZ2dlcmVkIGJ1ZmZlcnMgYW5kIHRvdWNoIGNvbnZlcnNpb25zIHRoZSBB
REMgY2xvY2sgaXMga2VwdCBlbmFibGVkDQo+PiB3aGlsZSB0aGUgdHJpZ2dlcmVkIGJ1ZmZlcnMg
b3IgdG91Y2ggYXJlIGVuYWJsZWQuIEFsb25nIHdpdGggaXQgcmVtb3ZlZA0KPj4gdGhlIF9fbWF5
YmVfdW51c2VkIG9uIHN1c3BlbmQoKSBhbmQgcmVzdW1lKCkgb3BzIGFzIHRoZSBkZXZfcG1fb3Bz
DQo+PiBvYmplY3QgbWVtYmVycyBhcmUgbm93IGZpbGxlZCB3aXRoIFNZU1RFTV9TTEVFUF9QTV9P
UFMoKS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpu
ZWFAbWljcm9jaGlwLmNvbT4NCj4gDQo+IEhpIENsYXVkaWEsDQo+IA0KPiBUaGlzIHBhdGNoIGNy
b3NzZWQgd2l0aCBhIG1hc3MgY29udmVyc2lvbiBzZXJpZXMgdGFraW5nIGxvdHMgb2YgZHJpdmVy
cw0KPiBvdmVyIHRvIHRoZSBuZXcgUE0gb3BzIG1hY3Jvcy4gVGhhdCBjb3ZlcmVkIHNvbWUgb2Yg
dGhlIGNoYW5nZXMgaW4gaGVyZS4NCj4gSSd2ZSBoYW5kIGFwcGxpZWQgdGhpcyBidXQgcGxlYXNl
IGNoZWNrIEkgZGlkbid0IG1lc3MgaXQgdXAuDQoNCkhpLCBKb25hdGhhbiwNCg0KSSd2ZSB0ZXN0
ZWQgaXQgb24gYSBTQU1BNUQyIGFuZCBpdCB3YXMgZ29vZC4NCg0KVGhhbmsgeW91IGZvciB0YWtp
bmcgY2FyZSBvZiBpdC4NCkNsYXVkaXUgQmV6bmVhDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEpv
bmF0aGFuDQoNCg==
