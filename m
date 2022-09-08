Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DBA5B2258
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiIHPc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiIHPcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:32:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9081A04C;
        Thu,  8 Sep 2022 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662651172; x=1694187172;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=NgZtLZH6pPPVwY3tOBVVYg1tNDPAGOfRwXNKxhJuVMk=;
  b=UIuunIMC1Z4DW4iVxExmOZVRYMHr5DFVxg39LznBlEJldJOkiRwn6/iK
   CYaeI3RzIXL2mJCnawP0/LNE9tEOqNW+dyJTRzvHF4k7n8qXe1JEcrdCH
   w9JiVRk6+Pa/NQc7cCB7yxYsElagIYUMG+uTCEF/EO3mC3so2Bphbyoq/
   /Kjf8+4ooWTK7S3qfLga3OpASl6VQRUMKl/t0A4wpfSkPKurK0MMpOTb/
   rd3RCvw5Kn+bzcJlm/8NLHGZg301I4LsWqmFWoGS8leE5V9opD0DMcfrR
   29Q0WSpg8ApLEVgawGL+NO4ALI21ND+B5Sp3ae0jWXn0bSkKLSZq8T+TD
   A==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="179595527"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 08:32:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 08:32:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 8 Sep 2022 08:32:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrQp6eq3ycJGjN7BXvsDctpuQ2Q5rAw4rO5sBx0HSagSxES86gbzNYgAwqm6UL3iiYwN1KSGg9jHRf0KANOMea5it9QXXiiytK+xKj3y+J7bkxF03bNggqiOzn4RP3JVy8s3sLOPnQ+Hcq2Oe6MBGaQ6KQg8h4ptwLe6tEnLN0uEfh/9lpc5dJxlDdLaqtwGkNvr/ySWFk6tMkD98RKr+bV6/rtM1+f1IkTDlNKplaui1HUMykpcvv1vur60OEqT0Qcc5zLYH0p4Ocm8QmPQDxflsj5rfBt9LmrrB2HabMghydx9d8m+ILF2fEYSHVIFaKxL4E6uvHfmfpBobD1Y9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgZtLZH6pPPVwY3tOBVVYg1tNDPAGOfRwXNKxhJuVMk=;
 b=NLdxXB1ch89yMzbxInGgZKQw2uN1b4LRi1YOAkjDBnT6cIclo7A2YC+ipm4LgrCDeFSfoOgMog4i0VlsIRykB7eSKv4fekVsV3PwxvNpzCbtugFpdrMSarnXsO/lfCjz61eZ8a9wU/rbB+unpSuB4+FFztvy9n3oGAa0QNEoyTpGa6DVQ5OKNlLCtPhMsEkPg8cKuXnkZhOchHt7T0t3tlgQRyYAG64w241e4AZpyZ0ElFTF0FBH7OU6OUIwhd3gG1yP5B/U0HseueAO+zSHTxuDAt6bqtXthoFkf4EL3zazQnFm19Mcw5I/m2cqz4Wva1nwi6h4Ba9eOYacluZvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgZtLZH6pPPVwY3tOBVVYg1tNDPAGOfRwXNKxhJuVMk=;
 b=dSSKO5V9UZ4gfmyxVm0DbUYkozwuK8NQ0okgr7TTexoFCkAjfLSzqWV2hmfRx+1saixkz+nSNHYerho+zv1n62y35oeb67F/UVcP75zplnZv+jx5j+oEQrDfykPnQK5niPVchhjPhn0BbthGvIci69ldRC58AOJiGDYvYQvqtww=
Received: from MWHPR11MB1693.namprd11.prod.outlook.com (2603:10b6:300:2b::21)
 by DS0PR11MB6447.namprd11.prod.outlook.com (2603:10b6:8:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 8 Sep
 2022 15:32:47 +0000
Received: from MWHPR11MB1693.namprd11.prod.outlook.com
 ([fe80::ccae:ffc6:d9f5:8535]) by MWHPR11MB1693.namprd11.prod.outlook.com
 ([fe80::ccae:ffc6:d9f5:8535%9]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 15:32:47 +0000
From:   <Jerry.Ray@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] ARM: dts: at91: Adding SAMA5D3-EDS board
Thread-Topic: [PATCH v6 2/2] ARM: dts: at91: Adding SAMA5D3-EDS board
Thread-Index: AQHYvwFp8Od1EQWLAkC3vC8jcHRCTq3VcuSAgAAlItCAAAYMAIAACJvQgAACZICAAAkUwA==
Date:   Thu, 8 Sep 2022 15:32:47 +0000
Message-ID: <MWHPR11MB1693DCB1AED7F08CD1A85F70EF409@MWHPR11MB1693.namprd11.prod.outlook.com>
References: <20220902192236.14862-1-jerry.ray@microchip.com>
 <20220902192236.14862-2-jerry.ray@microchip.com>
 <bc6f19f3-0825-7c9c-c11d-92474bb12375@linaro.org>
 <MWHPR11MB1693B3327E7061DB8DDB5577EF409@MWHPR11MB1693.namprd11.prod.outlook.com>
 <42c193c8-5edf-4b00-9f76-34b9cc947dc8@linaro.org>
 <MWHPR11MB1693A5AF16E14FFA06D80653EF409@MWHPR11MB1693.namprd11.prod.outlook.com>
 <dc22442d-83c0-e6b7-a356-9a6e8e4d8a83@linaro.org>
In-Reply-To: <dc22442d-83c0-e6b7-a356-9a6e8e4d8a83@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1693:EE_|DS0PR11MB6447:EE_
x-ms-office365-filtering-correlation-id: 6b60092a-17ee-444b-4e8b-08da91af61e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: msxsJd7xBJ9Igb5MGkfAKrMBMjRhqhXNDHeAotJJY3RM5wHC0jw7DTfW4AkQHl9wOXCsRzq5QDg0wu0No061ZzI2F4xK10OuDZDOAqrMAG2FnlxeMYDasMK0AEYhCutmFuQfgsRPBAN3HRu+sw1xoX67F2KAaVCM9zrHxdESIzyL+9fFFT3FwJQOfFVBPlI3Iq952pL+2p5iA+60oGft6xAZ/hhM9fUvuRT/CrSppXkN8m0tIKi3yCwARQ3LlW4Of7bWSOczwuOL8hRElXatDz5hKi+F7I0M9+/GACH6sDZCrNdkmKq/RMozK78qEbWqbkoE8kR/EPJKNns8Q5z350ZW7ky3cnFvVNoo48QQPv/LGlEDa3hKG1mzKKivL/LyrAXpTQ2L0zTj5Er70EmKYL1Rh6HCa3qmlqC58HFprSx45jTEnuQoOBKBFBPugq6zXp+fjBThDwi3+5sYQPbJFyilge9AIONugDZJco6I5GH8kw8mypEkTydf1YvaqRQ04eGwHLLZv2YbaILG94TcaMlEucXTtACIew05Ys6U0Nqdz5o38ZLgJtm4MfKux5T7nMbd062vO/nYEMBgw776qtSHjqVMWwJUpw37dB7rkMq/FkV8v+CZwOa/HPrzLFw2zocRpwD8RjnpUpTsf7FKK302bZfMR79BwW8LB6KFjX9nBB8UJOYUfd1/sq1+SWwzqmHMEC2/9G5SWjO6EL3zRu2t4XqA/NlCNbq+6wDstgS5Hum1SCOkKJS/cWyCVr3arY0Zpwel6HeOZK6tpkEBgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1693.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(346002)(396003)(366004)(26005)(38070700005)(38100700002)(122000001)(186003)(83380400001)(9686003)(55016003)(66476007)(5660300002)(8936002)(66556008)(64756008)(52536014)(86362001)(2906002)(33656002)(76116006)(478600001)(6506007)(66946007)(7696005)(66446008)(316002)(41300700001)(71200400001)(8676002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmkxaWpCYkw3amlmYm5pbC9sL1NrTGFPeTRlUkIwNHJPbXlaOFN4ZnpESGZO?=
 =?utf-8?B?NlAxY3IwYWM1dFpmei9SRHVNNksyRVlyOCsxN2JWa2c4VkFLbzRHQlIxa1JZ?=
 =?utf-8?B?bUN3UlpXTUtuQm9sUy9mVXgyVThZT0hLdnowL0RWQ2RtSFVCM2tSYjRRbFlT?=
 =?utf-8?B?TkJQT0hjVGE3SnVqTEQxdzRWUU5YbWtFdGRaK3JyUGt6RkxObE5Cb1RjRjdu?=
 =?utf-8?B?aXZRejJMU282d1BESWJIOUxZY0VBNDQ0Qmd3UWlGazdkell3VzBsejZqTHRC?=
 =?utf-8?B?TjJYOVh1SU96NW4waFhUc2VSTG1DeVBjbVEvTTRUSERFVDlBWldSQUpVa0Zi?=
 =?utf-8?B?ekRPMmo2YUordnFQTHA0OHd5UHZ1SWtycGduT29DQXZ1UXFQc2ZNb1ljcFN1?=
 =?utf-8?B?UDkyUkgzd01JTnAvb2liQlNFNHlvTnl5SGhGSUpWQ3ltL0N1SkNDS3dPNmNP?=
 =?utf-8?B?STl0Risva2Z5aUlpNHpiVkpFeGVjZHpndGQrZFZLMXExZzNZRHhBK1lWOGhN?=
 =?utf-8?B?cmdPeXY5cURYK3Rrem1YcVgrWi9EbkE0cHZKODBrMWhDQXNrdmpHWEQ1RUI0?=
 =?utf-8?B?c0REUG1NUVdZUnJqcld0akIxbFQyS3V1dEZMUG5aOFZBSllRWUwrUlNxUkRK?=
 =?utf-8?B?NGtTci94VWZLQnVYak42ZFZGUjZ0bzdGOHE4OWVVQk41cENuZXRmVXVzM1Rj?=
 =?utf-8?B?RWFYaHNKeVlXblU3NURJaFljSDFXeWlUZWlZZmdoQk9uQmNuYmNkQ0oyeVo3?=
 =?utf-8?B?c2hVdFd3ZWFhbWRIOGNtaTJJc0pobXpaRHkrTlBuOHN6V3UrVGdLKytTcmpR?=
 =?utf-8?B?ZHVCRXVWZk5WOXhRai9PbkZUOWoyNEVPWWFKNUp0bHBVVzdiU1l5bkF4dmZN?=
 =?utf-8?B?R2xva3QvOWdLSmJWTlZTbEM0dUgvaGFPTkdrTDhkVHp2UXFhYzNJZWl2eEZv?=
 =?utf-8?B?Y21WMjA0dk5mWmZCaXNPbjQ5ZFdvcUs1NW1QWHp4ZmRtUGlEaWZQZUE4d1Jp?=
 =?utf-8?B?ODZTTFhiS09SdDJwVy9RVWNFNUtPNW84STE5NjRGRHVSNzltZFl6eGl3bUgz?=
 =?utf-8?B?QTBRVXkybHJldHJZelhCbTZ0TFJSQzFFV2U0T0xJbnRDWFZZZjhZeVFDZDIz?=
 =?utf-8?B?b0JHN09qQ21iYkZhYmQ0dS9SdWFDTjk0Z1FBMVp0d3YxQ1FLZGc3ZXZHeHkv?=
 =?utf-8?B?ZUpsTlFRNTRUOU5mWGltY2RYb1BxdkhKYnRkd0UzSjRWdTZScjAvdDU5ZFY5?=
 =?utf-8?B?OHZ3bVgxOHVLa1dzMUNXaHpNOVlsb0JMWUsxL1hBY2h3OHZETkxxQ08xOW5Q?=
 =?utf-8?B?YmZSNERYWjR0dWhmWXFyWGNaOFZYS01meTN2MGdVckw4ZkcrUC9FWlEwTzhG?=
 =?utf-8?B?bHRTcXhXUmp1a0kvVnFTQW1yZHE1MG9lUmV4M0RPT2VFSnNQejVYRlUrMzNH?=
 =?utf-8?B?SitUOUZWQjArU2RwbFVranlUTllJRGp2NnNhbzZ2anV2dVNzREdYNEVxMXhB?=
 =?utf-8?B?SmpYZ2NROVhOOHQ5SkVJcmpINWlockdtYlpKSVVZejhVQWpPLzFwRzF1MTBR?=
 =?utf-8?B?Q1JDa3hWRTJ2N1pkSDByWVo4ckNPbHZ5enZvN1RhVkN2OGJNT0dQVVJnRUhk?=
 =?utf-8?B?aDR3VUhGQ21xRnFFSTdRejZCSS9weFFINFY3bjkrUVBSM2VoZXYrbHc4L0hG?=
 =?utf-8?B?aUJKV0hSc3lkOFZPWENBVVhkMWI1ODFyaTQ5ZVRjSkRFcndwZU5Wb2V3aEh1?=
 =?utf-8?B?Q2t2ajBFRGRBUkxkN05LQzdIdktxS0ZDK2VsbXZUQkpLRE9GN1c4cldFUDgv?=
 =?utf-8?B?YzVFS21USEhoTjU4QkJNYnlsNTBIOG9WVzY3VCtWeHFId2lHYklFcVVNOExS?=
 =?utf-8?B?Z0xFQWc4NkNzU2wxVS9ka2MwanNHbERNN0xOWHVudGhrcnZiZERLMHNCOTZ4?=
 =?utf-8?B?N3ZXTWFpM3dDOWkwS3VWQWRDUFdEVXVpMk9EVjhzWFBZNTZRS0tWS2M2VG1w?=
 =?utf-8?B?VmFGdWRjYlVTUmZXandrdW93MWlkYWMvemgrZVlBMlFaYVdXWXBCM3FNVmVC?=
 =?utf-8?B?NzJ5T0dwWjZKNTkxRklwOU9BN0xxMk5Gd3IycUtMVUNuak82MWpNL1NJS01r?=
 =?utf-8?Q?vF5Q2OICWiAqsJnl2tUZ1KXBS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1693.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b60092a-17ee-444b-4e8b-08da91af61e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 15:32:47.4043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efJMw6iCn2gARVpQVqP0+ClZayOA3T1sjPzw8kBTO3BfXHZ3cf4t4atOFn/kfnErw0otfkviIEfC+6HfGJhrow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6447
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+Pj4+IFRoZSBTQU1BNUQzLUVEUyBib2FyZCBpcyBhbiBFdGhlcm5ldCBEZXZlbG9wbWVudCBQ
bGF0Zm9ybSBhbGxvd2luZyANCj4+Pj4+PiBmb3IgZXZhbHVhdGluZyBtYW55IE1pY3JvY2hpcCBl
dGhlcm5ldCBzd2l0Y2ggYW5kIFBIWSBwcm9kdWN0cy4NCj4+Pj4+PiBWYXJpb3VzIGRhdWdodGVy
IGNhcmRzIGNhbiBjb25uZWN0IHVwIHZpYSBhbiBSR01JSSBjb25uZWN0b3Igb3IgYW4gUk1JSSBj
b25uZWN0b3IuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGUgRURTIGJvYXJkIGlzIG5vdCBpbnRlbmRlZCBm
b3Igc3RhbmQtYWxvbmUgdXNlIGFuZCBoYXMgbm8gDQo+Pj4+Pj4gZXRoZXJuZXQgY2FwYWJpbGl0
aWVzIHdoZW4gbm8gZGF1Z2h0ZXIgYm9hcmQgaXMgY29ubmVjdGVkLiAgQXMgDQo+Pj4+Pj4gc3Vj
aCwgdGhpcyBkZXZpY2UgdHJlZSBpcyBpbnRlbmRlZCB0byBiZSB1c2VkIHdpdGggYSBEVCBvdmVy
bGF5IGRlZmluaW5nIHRoZSBhZGQtb24gYm9hcmQuDQo+Pj4+Pj4gVG8gYmV0dGVyIGVuc3VyZSBj
b25zaXN0ZW5jeSwgc29tZSBpdGVtcyBhcmUgZGVmaW5lZCBoZXJlIGFzIGEgDQo+Pj4+Pj4gZm9y
bSBvZiBkb2N1bWVudGF0aW9uIHNvIHRoYXQgYWxsIGFkZC1vbiBvdmVybGF5cyB3aWxsIHVzZSB0
aGUgc2FtZSB0ZXJtcy4NCj4+Pj4+Pg0KPj4+Pj4+IEdvb2dsZSBzZWFyY2gga2V5d29yZHM6ICJN
aWNyb2NoaXAgU0FNQTVEMy1FRFMiDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKZXJy
eSBSYXkgPGplcnJ5LnJheUBtaWNyb2NoaXAuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+IHY1LT52
NjoNCj4+Pj4+PiAgLSBSZXBsYWNlZCB1bmRlcnNjb3JlcyBpbiBuYW1lcyB3aGVyZSBJIGNhbiwg
aW1wcm92aW5nIG5hbWluZy4NCj4+Pj4+PiB2NC0+djU6DQo+Pj4+Pj4gIC0gcGF0Y2ggbm93IGFw
cGxpZXMgdG8gdjYuMC1yYzINCj4+Pj4+PiB2My0+djQ6DQo+Pj4+Pj4gIC0gRml4ZWQgcmVndWxh
dG9ycyBhcyBuZWNlc3NhcnkgdG8gZ2V0IHRoZSBib2FyZCB0byBib290IGZyb20gU0QgQ2FyZC4N
Cj4+Pj4+PiB2Mi0+djM6DQo+Pj4+Pj4gIC0gQWxwaGFiZXRpemVkIHBpbmN0cmwgZW50cmllcy4N
Cj4+Pj4+PiAgLSBjbGVhbmVkIHVwIGEgd2FybmluZyBpbiB0aGUgcmVndWxhdG9ycyBzZWN0aW9u
Lg0KPj4+Pj4+ICAtIExpY2Vuc2UgdHdlYWtlZCB0byAnT1IgTUlUJw0KPj4+Pj4+ICAtIEluY2x1
ZGVkIE1ha2VmaWxlIGNoYW5nZQ0KPj4+Pj4+IHYxLT52MjoNCj4+Pj4+PiAgLSBNb2RpZmllZCB0
aGUgY29tcGF0aWJsZSBmaWVsZCBpbiB0aGUgZGV2aWNlIHRyZWUgdG8gcmVmbGVjdCBNaWNyb2No
aXANCj4+Pj4+PiAgICBFdGhlcm5ldCBEZXZlbG9wbWVudCBTeXN0ZW0gQm9hcmQuDQo+Pj4+Pj4g
LS0tDQo+Pj4+Pj4gIGFyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlICAgICAgICAgICAgIHwgICAx
ICsNCj4+Pj4+PiAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQzX2Vkcy5kdHMgfCAzMDkN
Cj4+Pj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+Pj4gIDIgZmlsZXMgY2hhbmdl
ZCwgMzEwIGluc2VydGlvbnMoKykgIGNyZWF0ZSBtb2RlIDEwMDY0NCANCj4+Pj4+PiBhcmNoL2Fy
bS9ib290L2R0cy9hdDkxLXNhbWE1ZDNfZWRzLmR0cw0KPj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlIA0KPj4+Pj4+IGIvYXJjaC9hcm0vYm9vdC9k
dHMvTWFrZWZpbGUgaW5kZXggMDVkOGFlZjZlNWQyLi5lOTJlNjM5YTJkYzMgDQo+Pj4+Pj4gMTAw
NjQ0DQo+Pj4+Pj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUNCj4+Pj4+PiArKysg
Yi9hcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZQ0KPj4+Pj4+IEBAIC02MSw2ICs2MSw3IEBAIGR0
Yi0kKENPTkZJR19TT0NfU0FNX1Y3KSArPSBcDQo+Pj4+Pj4gICAgICAgYXQ5MS1zYW1hNWQyX2lj
cC5kdGIgXA0KPj4+Pj4+ICAgICAgIGF0OTEtc2FtYTVkMl9wdGNfZWsuZHRiIFwNCj4+Pj4+PiAg
ICAgICBhdDkxLXNhbWE1ZDJfeHBsYWluZWQuZHRiIFwNCj4+Pj4+PiArICAgICBhdDkxLXNhbWE1
ZDNfZWRzLmR0YiBcDQo+Pj4+Pj4gICAgICAgYXQ5MS1zYW1hNWQzX2tzejk0NzdfZXZiLmR0YiBc
DQo+Pj4+Pj4gICAgICAgYXQ5MS1zYW1hNWQzX3hwbGFpbmVkLmR0YiBcDQo+Pj4+Pj4gICAgICAg
YXQ5MS1kdmtfc29tNjAuZHRiIFwNCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9k
dHMvYXQ5MS1zYW1hNWQzX2Vkcy5kdHMNCj4+Pj4+PiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEt
c2FtYTVkM19lZHMuZHRzDQo+Pj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+Pj4+PiBpbmRl
eCAwMDAwMDAwMDAwMDAuLmI0ZmUxYzVmMjk5Nw0KPj4+Pj4+IC0tLSAvZGV2L251bGwNCj4+Pj4+
PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDNfZWRzLmR0cw0KPj4+Pj4+IEBA
IC0wLDAgKzEsMzA5IEBADQo+Pj4+Pj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wKyBPUiBNSVQNCj4+Pj4+PiArLyoNCj4+Pj4+PiArICogYXQ5MS1zYW1hNWQzX2Vkcy5kdHMg
LSBEZXZpY2UgVHJlZSBmaWxlIGZvciB0aGUgU0FNQTVEMyBFdGhlcm5ldA0KPj4+Pj4+ICsgKiAg
ICBEZXZlbG9wbWVudCBTeXN0ZW0gYm9hcmQuDQo+Pj4+Pj4gKyAqDQo+Pj4+Pj4gKyAqIENvcHly
aWdodCAoQykgMjAyMiBNaWNyb2NoaXAgVGVjaG5vbG9neSBJbmMuIGFuZCBpdHMgDQo+Pj4+Pj4g
K3N1YnNpZGlhcmllcw0KPj4+Pj4+ICsgKg0KPj4+Pj4+ICsgKiBBdXRob3I6IEplcnJ5IFJheSA8
amVycnkucmF5QG1pY3JvY2hpcC5jb20+ICAqLyAvZHRzLXYxLzsgDQo+Pj4+Pj4gKyNpbmNsdWRl
ICJzYW1hNWQzNi5kdHNpIg0KPj4+Pj4+ICsNCj4+Pj4+PiArLyB7DQo+Pj4+Pj4gKyAgICAgbW9k
ZWwgPSAiU0FNQTVEMyBFdGhlcm5ldCBEZXZlbG9wbWVudCBTeXN0ZW0iOw0KPj4+Pj4+ICsgICAg
IGNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbWE1ZDMtZWRzIiwgImF0bWVsLHNhbWE1ZDM2IiwN
Cj4+Pj4+PiArICAgICAgICAgICAgICAgICAgImF0bWVsLHNhbWE1ZDMiLCAiYXRtZWwsc2FtYTUi
Ow0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgICBjaG9zZW4gew0KPj4+Pj4+ICsgICAgICAgICAgICAg
c3Rkb3V0LXBhdGggPSAic2VyaWFsMDoxMTUyMDBuOCI7DQo+Pj4+Pj4gKyAgICAgfTsNCj4+Pj4+
PiArDQo+Pj4+Pj4gKyAgICAgY2xvY2tzIHsNCj4+Pj4+PiArICAgICAgICAgICAgIHNsb3dfeHRh
bCB7DQo+Pj4+Pg0KPj4+Pj4gTm8gdW5kZXJzY29yZXMgaW4gbm9kZSBuYW1lcy4gT3ZlcnJpZGUg
YnkgbGFiZWwuDQo+Pj4+Pg0KDQpJIGFtIG5vdCBhdCBsaWJlcnR5IHRvIGNoYW5nZSB0aGlzIGFz
IGJvdGggbm9kZSBuYW1lIGFuZCBsYWJlbCBhcmUgZGVmaW5lZCBpbiB0aGUgc2FtYTVkMy5kdHNp
IHNvdXJjZSBmaWxlLg0KSWYgdGhlcmUgaXMgYSB3YXkgdG8gb3ZlcnJpZGUgdGhlIGxhYmVsLCBw
bGVhc2Ugc2hhcmUgdGhlIHN5bnRheCBhcyBub3RoaW5nIEkgaGF2ZSB0cmllZCBpcyB3b3JraW5n
Lg0KDQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGNsb2NrLWZyZXF1ZW5jeSA9IDwzMjc2
OD47DQo+Pj4+Pj4gKyAgICAgICAgICAgICB9Ow0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgICAgICAg
ICAgIG1haW5feHRhbCB7DQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGNsb2NrLWZyZXF1
ZW5jeSA9IDwxMjAwMDAwMD47DQo+Pj4+Pj4gKyAgICAgICAgICAgICB9Ow0KPj4+Pj4+ICsgICAg
IH07DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgICAgIGdwaW8gew0KPj4+Pj4+ICsgICAgICAgICAgICAg
Y29tcGF0aWJsZSA9ICJncGlvLWtleXMiOw0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgICAgICAgICAg
IHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+Pj4+Pj4gKyAgICAgICAgICAgICBwaW5jdHJs
LTAgPSA8JnBpbmN0cmxfa2V5X2dwaW8+Ow0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgICAgICAgICAg
IGJ1dHRvbi0zIHsNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgbGFiZWwgPSAiUEJfVVNF
UiI7DQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGdwaW9zID0gPCZwaW9FIDI5IEdQSU9f
QUNUSVZFX0xPVz47DQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGxpbnV4LGNvZGUgPSA8
MHgxMDQ+Ow0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICB3YWtldXAtc291cmNlOw0KPj4+
Pj4+ICsgICAgICAgICAgICAgfTsNCj4+Pj4+PiArICAgICB9Ow0KPj4+Pj4+ICsNCj4+Pj4+PiAr
ICAgICBtZW1vcnlAMjAwMDAwMDAgew0KPj4+Pj4+ICsgICAgICAgICAgICAgcmVnID0gPDB4MjAw
MDAwMDAgMHgxMDAwMDAwMD47DQo+Pj4+Pj4gKyAgICAgfTsNCj4+Pj4+PiArDQo+Pj4+Pj4gKyAg
ICAgdmNjXzN2M19yZWc6IGJ1Y2stcmVndWxhdG9yLTEgew0KPj4+Pj4NCj4+Pj4+IEtlZXAgY29u
c2lzdGVudCBwcmVmaXggb3Igc3VmZml4LCBzbzoNCj4+Pj4+IHJlZ3VsYXRvci1idWNrLTENCj4+
Pj4+DQo+Pj4+Pj4gKyAgICAgICAgICAgICBjb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7
DQo+Pj4+Pj4gKyAgICAgICAgICAgICByZWd1bGF0b3ItbmFtZSA9ICJWQ0NfM1YzIjsNCj4+Pj4+
PiArICAgICAgICAgICAgIHJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPj4+
Pj4+ICsgICAgICAgICAgICAgcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+
Pj4+Pj4gKyAgICAgICAgICAgICByZWd1bGF0b3ItYWx3YXlzLW9uOw0KPj4+Pj4+ICsgICAgIH07
DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgICAgIHZjY18ydjVfcmVnOiBsZG8tcmVndWxhdG9yLTIgew0K
Pj4+Pj4NCj4+Pj4+IHJlZ3VsYXRvci1sZG8tMQ0KPj4+Pj4gKHdoeSBudW1iZXJpbmcgb2YgTERP
IHJlZ3VsYXRvcnMgc3RhcnRzIGZyb20gMj8ga2VlcCBzb21lIHNlbnNlIGluDQo+Pj4+PiB0aGlz
KQ0KPj4+Pj4NCj4+Pj4+DQo+Pj4+DQo+Pj4+IFRoZXJlIGFyZSBOIHJlZ3VsYXRvcnMgb24gdGhl
IGJvYXJkLCBzbyB0aGV5IGFyZSBudW1iZXJlZCAxIHRocnUgTi4NCj4+Pj4gUmVndWxhdG9yIDIg
aXMgcmVndWxhdG9yIDIgd2hldGhlciBpdCdzIGEgYnVjayBvciBMRE8uDQo+Pj4NCj4+PiBTbyBp
ZiB0aGlzIGlzIHN1cHBvc2VkIHRvIG1hdGNoIGJvYXJkIHNjaGVtYXRpY3MgKHdoaWNoIGlzIGdv
b2QgaWRlYSksIHRoZW4gbWF5YmUganVzdCAicmVndWxhdG9yLTIiPyBUaGUgcG9pbnQgaXMgdG8g
aGF2ZSBzYW1lIGdlbmVyaWMgbmFtZSBhbmQgY3VzdG9taXplIGVpdGhlciBwcmVmaXggb3Igc3Vm
Zml4LCBidXQgbm90IGJvdGguDQo+Pj4NCj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4gS3J6eXN6dG9m
DQo+Pj4NCj4+DQo+PiBJIHByZWZlciBuYW1lcyB0byBiZSBkZXNjcmlwdGl2ZSwgYnV0IEkgc3Vw
cG9zZSBJIGNhbiBoYXZlIHRoZSBuYW1lIGdlbmVyaWMgYW5kIGFkZCBhIGNvbW1lbnQgaW50byB0
aGUgZHRzIGZpbGUuDQo+PiBIb3dldmVyLCB0aGUgY29tbWVudCBkb2Vzbid0IG1ha2UgaXQgaW50
byB0aGUgbG9hZGVkIGRldmljZSB0cmVlLiAgV291bGQgeW91IGJlIG9rYXkgd2l0aCAicmVndWxh
dG9yLTItbGRvIj8NCj4NCj5Zb3UgaGF2ZSB0aGUgZGVzY3JpcHRpdmUgbmFtZSBpbiB0aGUgcmVn
dWxhdG9yLW5hbWUgcHJvcGVydHksIGJ1dCBvaywgY2FuIGJlIGluIG5vZGUgbmFtZSBhcyB3ZWxs
Lg0KPg0KPkJlc3QgcmVnYXJkcywNCj5Lcnp5c3p0b2YNCj4NCg0KUmVnYXJkcywNCkplcnJ5Lg0K
