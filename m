Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229EE59F6E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbiHXJv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiHXJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:50:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D4F3FA26;
        Wed, 24 Aug 2022 02:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661334633; x=1692870633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/pPgVhakidXOtvfxSP5T5jOH36qcPytX0REIhnNAccA=;
  b=QrtSJuzhLEVnJwVQ1JhYA7/xxhOdHGVYbeRwswAVx95GZ04daAj/q6kI
   +CQzq/YNptJz1xO0yWEltHIcreBja1lLK6g9bewpIsgRamC7mEH6gk8i6
   a/r4+sgFExeRRuDdGsBuGimMFQtD8M2KCNVyQMCJ5Xjg3p8FCUIyIJnCZ
   /mH3blruBKz6USkdLO0BZQ1qma6qK6bbT94tsoCCehz2x6OSORMOTXaDa
   7rzZnrWm54HHEA0lx0Yabg/U/jFaTA5o5MpNDWnShKzaIJtjhvSxT8FyG
   SXcDHPvpiafhV4YAcQuw+lsDYMjh2KrH28GHIR5jelmYqJe1GqiQRJg0B
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="177672472"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 02:50:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 02:50:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 24 Aug 2022 02:50:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iO5Akeur77eYNG6t9AVK2SG3VT9vdoXTlZO4TxfLV8QaRftsDmnZQv1J6ma545M9l75kjMOhIm1Jmx4pHGtUNmlfhrIt66tBbNB83yfDums4MSpvQTCRYEKY6frcP3EMy3bgiZNC8IDAT5urFImIKoWypXJXsQmOjdOL+d8bNfb2DR/Onx9wvhcii7NpB/+ac0U6CPMfQ6wCl+3sdgbkq9LxERYs2UfbxdG3KhObJ56zSl8cPaWBZwgAU4BEnqiIkFc5KfIUMJlYn/0hwycNNHuFO7+vAvAurbMIO3gVXlK46x2obF1wXbd2LaSzkBRBvbt11hFMpxveXnFo7JozMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pPgVhakidXOtvfxSP5T5jOH36qcPytX0REIhnNAccA=;
 b=dgahpicSdq4oeBTRNK2ytP7q/GhuM/eyFetkkh0ZzqwWjuC5mAd6YkrKKDzARBXJZxlp/GEByE2VnfEP0VxurHGe54N+aNwtyWjNziIGq7umpy5rSTNi1ilRfAQgwKnkDsBZvSbReIqxhAJvKyYdJjLrls6NTXpuHWppTY3DJgtUv4iUKN9gnaBH44dv04+KhRN0D1eqlmrTXfb/JgD06gWxFssf1zK61ZGVx4C4SxeJXwM+X50jwiHys4UGO0JbSrDuAm4zaffduQ+TXNg3wiRneJML2/46qhQ3J2yOTMMvmkbV4Q0D/b0jb7uTK7EvEyiZMHNQiTwSc5JTvoelhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pPgVhakidXOtvfxSP5T5jOH36qcPytX0REIhnNAccA=;
 b=e7j9yVc9rX+pan9BCiILuMIWIs04FO4qrbopD+VS+RwLea2PxNBJ+BgwiM4cOcZLjeG25qRKLufDAwqfIu1qOFVBW2JPMneHQ/MMtarzhLbd0wDr6e2Ci5+3z3VbVEons+3JJjPnh2xgjUmulNrwODBsBj1/lg/rxzVhtH5LojY=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by BL1PR11MB5398.namprd11.prod.outlook.com (2603:10b6:208:31c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Wed, 24 Aug
 2022 09:50:28 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::8982:37b8:a755:ace6]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::8982:37b8:a755:ace6%4]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 09:50:27 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <dragan.cvetic@xilinx.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <arnd@arndb.de>, <derek.kiernan@xilinx.com>
Subject: Re: [PATCH RFC char-misc-next 0/5] misc: microchip: pci1xxxx: Add
 auxiliary bus driver and the GPIO driver for PIO function of pci1xxxx.
Thread-Topic: [PATCH RFC char-misc-next 0/5] misc: microchip: pci1xxxx: Add
 auxiliary bus driver and the GPIO driver for PIO function of pci1xxxx.
Thread-Index: AQHYp/F8a00QxssoaE6kQUAQxdD4h628dTwAgAF5HoA=
Date:   Wed, 24 Aug 2022 09:50:27 +0000
Message-ID: <e0e2a1e9a2da25a3070f01f7533344030be7c2d6.camel@microchip.com>
References: <20220804163219.921640-1-kumaravel.thiagarajan@microchip.com>
         <YwS4WDekXM3UQ7Yo@kroah.com>
In-Reply-To: <YwS4WDekXM3UQ7Yo@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7066496f-5350-4770-7f1a-08da85b61304
x-ms-traffictypediagnostic: BL1PR11MB5398:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: juajJOWTOzryrZGGafYwS4jj8yYzc+OVNo1CwP0OrdtIXktCv/16w6QeaV/o0jKoTCsfMlWcefrj0yGrKeG7bXuso4hyljxWWcYzzCTdxeOEAuxEIiuf49wd1Z+5NhjT3vxTiCcd0V99e7bYlkCxLHGy+zh4nAomg0oZ/Cs/Qvs4wfA69+lImKo4RhfoXWsfaEXPsak6PcWCtOevz1hpx6ihwfyZeDG8Vwkwa0pcFq+7YC01ysonkbG6yjM5Ht2g+8ECs4bjyqTnIDw8SVPUq+WBmubUSmov7pHq2TTdKbKhY0l0miQvD14u/T/q1OX7rXyohYZ45FYygG8D+L6BEcUoZ0qM8guO2r3hRfukmAn6LHls3BKpGJEJvmYvTXoGW3xD21Jl6MraTF/YwniyzzTfBzBo+aQJqDmnWC8Us9HvIQov5ThG6dKIyZ1iZtyHcjrXjwWS0idwGAs24D8j43+OfA86XSr0oUuhXS1pVdOJP7JdaTToIg0uq/+euSM0MjiTrfs8nRW17sjP38zqgv3bEbkuFhztHOWKviC3otZKebO5DxKGLKDlkHQHBt3Izj9Hu4epD3JKixIVaMt5WpHHsLRJKNIVLJt5+f5epynPzH0IQZ9/tevnUMmaVHfkSGbL3Ev93lMhD6P45VLvyaIy+kvoco7AIViVNdxQqW1nOtAVgc7pJTlTcAXXvt5LsAEfgjViS5PyjhHYhFr8DfwGh+arXXWhdba5se+iek4JwWtTJigyVWkRGOj2x1fIajFTTrXGnfajCv2vA7kw/cOB61taBqxbs3T51Iu7MNP793I8qzgaeBlyQ8Tmdozp2bLPT/Xb2m7/DQUdOQSFpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(366004)(396003)(346002)(478600001)(186003)(66446008)(4326008)(41300700001)(6486002)(66946007)(8676002)(66476007)(91956017)(36756003)(2616005)(316002)(71200400001)(76116006)(64756008)(26005)(54906003)(83380400001)(6916009)(6512007)(5660300002)(86362001)(6506007)(38070700005)(2906002)(8936002)(122000001)(66556008)(38100700002)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFBpaXNsOTVoQnpmL2JEby9xUitEUEpkc0QzZHBpSW9lenZjaUtWOVdJcWNm?=
 =?utf-8?B?ZkJjOEJFbmgybGpFWTEwZUppRVo4eHI0MDdzUFU4czFCbTdFZzdFRFlmMlhR?=
 =?utf-8?B?Wi91bVNRV0JZVk4vNEQxOUczSlZlOVhzMWNIWjBSbHZKWnE1Y0RFblEzaVdS?=
 =?utf-8?B?ZVJYWkk3SzBPR1pyVjVkTkVtc0dTT0JYU1plcEpiT0RpMFlXbGhpZ0hWUjN6?=
 =?utf-8?B?RDRqYnN0SU5LdnZVR2x4bVU5ZFFocXU3RzFic20vTFVHa2pWb0dwWGdFbWh4?=
 =?utf-8?B?YUY0SlNRemZESW5DR3pINlRCR2IxOHQ5bllkcTVkZTc1aUdZb3ZJS0RleE92?=
 =?utf-8?B?bmJsQi9KS2JneUlkU2VqbzdtVEpoeHRmbmZpdkxRWmRFL25vRFFLSzJPTE5z?=
 =?utf-8?B?eDVLYmRBZ2kyRXlJbElGdmFTVHNtOC9BMFg4OXJMQzg4VWlONEhJdE5NTHNy?=
 =?utf-8?B?cHVMc3FlNUpOVE5GSFZhU1I0TFpidUYxMUtkOUVqTkZZRkJLUUV0V1dPKyt5?=
 =?utf-8?B?SzltWDBLV0NObnhWVUNUdUNKZXVoV25kNTJRT0FKaVZxNUNDUWRhSTVjLzlW?=
 =?utf-8?B?R3R2TTB1ZWprYzY1RDA0ZUZ3RUpjMmsyNGx5SHJuNWczUTIySm5mUVNNMnpB?=
 =?utf-8?B?SFJsZ0N0dUJVZnVQL0JqYnpTSE16aS9EZjEzZzh2RlBhL05LcmUwRmFGRW1t?=
 =?utf-8?B?NjRoUllhMDEyWjNEMWZMTjMxQ0JYNWZtNzFuNHRBVjZ3bW9aY2VpUzgwOE0w?=
 =?utf-8?B?dExYMDNJVng3cGd2L05uSk9wd0xOdy8wWGpNNVRyNTltaEdSdmpUMS9Pd3do?=
 =?utf-8?B?am5VaDhIUnBHaDQybmYxU05LNkt4M3poTDhJdGZZV05mVk5ERDN0NVJ4Y1Iv?=
 =?utf-8?B?aExkb3F0NThqQkQvQ2ZMM2lZZlM1eEswU3VjbUVvU0doUzRTbWI4djZEZXZT?=
 =?utf-8?B?N3piVDBsak5ISFJVbkV1dVJqKzlaWEN3M1FXbnQ5NkM4dGZaNXhObnZjOWZw?=
 =?utf-8?B?S09yS0h0Wkk5MFFOa2tZckVFaFQ1bVFYVkRNeVNOdllzNFFOekxseitoOEk3?=
 =?utf-8?B?LzhraGlKaHZmY0VHT3JBUnNReVE3NElEcGRndUQ5enJwNmRuZ0tJVWlsME1P?=
 =?utf-8?B?L3pXblJRVStDamlSeENqbmpVU1B4b1lHRXphU2ZaNi8yMkcvMzVzSVNzNDhQ?=
 =?utf-8?B?RjJUU2R3Vms1aTBGdGpqa1FnK0ZCVVdTb2ZPN3lteVZERTY3dTljUzBHQVZG?=
 =?utf-8?B?WE5jejAxemRIRjFMUDE4ZThrb1RJZGlaK1Jqbm9LODQ0Y2kxRXQ1RnhjVHJW?=
 =?utf-8?B?WlVjVnlmM2ZOQTFqSVJwU044WkJlWVd5QUMyckNrZlM2N3RYcDBQTzN2dmZm?=
 =?utf-8?B?QUh3MEttNlJwMVQweHdIOE4vZUY2RFN4Nm55V29LelVYdW1neHJ0bEcvcVd3?=
 =?utf-8?B?Y2kycnNWakdOTXdoOFc3c2VXUTBIU1UvOHQxcVNoWVRxVEYrU210U24yNEEr?=
 =?utf-8?B?Q1lZZUc4cjhQZlFyazgzWmdVamlzUUpUNWhKZzNUcVBIRTZLRlVycW9IMTFI?=
 =?utf-8?B?bDY2Z1czUmV4K3ZNTTc4TFIzNTR0SEIvRHFBYitPTDBjQ1FwYUxQY0h5T2sz?=
 =?utf-8?B?T0paT1JlTWw3ZFdoR2szYjFhd2tkdzRGZXhib3RYdmVSNWdleHh5cTYyRFVJ?=
 =?utf-8?B?bzhRWVVoYS9DSkViS0JoM0JXOFR2UzloZFJucHo3QXhvUWN3TnpLNHEyV2R3?=
 =?utf-8?B?a0NMRkNaZTAwU05kWFNZV1V6L3Z0MFd1WE1XWTNMdC9YcUlKSC8vd1VERE4y?=
 =?utf-8?B?WCt6RWpMRzNnYnBUSXZJVDlUbk5scTBPdkFkQVc3OFRyMnpKeEprdmhsbU9H?=
 =?utf-8?B?Yzd0UHhPcHVEeGwxcCtOQTQ0d0tVeG1MdWJXV0pmb0lQVUpSY2d3NkFHcG1i?=
 =?utf-8?B?UmhtcURZRnZXVHBERXQxTytjb3lmektMYlppaDlyMjR2WUx4SFF1NnFuOXlB?=
 =?utf-8?B?cTJZME5SUkNVWFVlc09jbENjRVA5dWg5QUhjNWFROE4yRHczTEt3dHlQRnND?=
 =?utf-8?B?bVVCVG45WFBrdGFwbHBJbE41bEN4c2pBdnJTWkdEVzdYKzZGcUl3YjZlbFg2?=
 =?utf-8?B?NGZSVlJxem81ZEtrOUFsaXBQYi83cE1MN3grL2JqVGVKQTNsRUdPTjZlTEFm?=
 =?utf-8?Q?WwuCFyLWevB5NIJX3z4FQRmpHrrPv/6tkQ8bag2zRqrN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08D40A65A8F38648B6D36357B45D2A36@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7066496f-5350-4770-7f1a-08da85b61304
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 09:50:27.5794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9PRDl7R1BkM/OhpZBhvgHgaK/C7oWT5Z2PWbDuSh8sl9vTQtAQgFLqo5iqHh3egHFdBEGkg+dSAOEJYqxGYeeEOQjGfBUyXzrowH6MyqZNhQuhTx4E/LY6PPS44T/eE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5398
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTIzIGF0IDEzOjIyICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiANCj4g
T24gVGh1LCBBdWcgMDQsIDIwMjIgYXQgMTA6MDI6MTRQTSArMDUzMCwgS3VtYXJhdmVsIFRoaWFn
YXJhamFuIHdyb3RlOg0KPiA+IHBjaTF4eHh4IGlzIGEgUENJZSBzd2l0Y2ggd2l0aCBhIG11bHRp
LWZ1bmN0aW9uIGVuZHBvaW50IG9uIG9uZSBvZiBpdHMNCj4gPiBkb3duc3RyZWFtIHBvcnRzLiBQ
SU8gZnVuY3Rpb24gaXMgb25lIG9mIHRoZSBmdW5jdGlvbnMgaW4gdGhlDQo+ID4gbXVsdGktZnVu
Y3Rpb24gZW5kcG9pbnQuIFBJTyBmdW5jdGlvbiBjb21iaW5lcyBhIEdQSU8gY29udHJvbGxlciBh
bmQgYWxzbw0KPiA+IGFuIGludGVyZmFjZSB0byBwcm9ncmFtIHBjaTF4eHh4J3ggT1RQICYgRUVQ
Uk9NLiBUaGlzIHBhdGNoIGFkZHMgYW4NCj4gPiBhdXhpbGlhcnkgYnVzIGRyaXZlciB0aGF0IGVu
dW1lcmF0ZXMgc2VwYXJhdGUgY2hpbGQgZGV2aWNlcyBmb3IgZ3BpbyBhbmQNCj4gPiBPVFAvRUVQ
Uk9NIGludGVyZmFjZSBhbmQgdGhlIGdwaW8gY29udHJvbGxlciBkcml2ZXIgZm9yIHRoZSBmaXJz
dCBjaGlsZC4NCj4gPiANCj4gPiBLdW1hcmF2ZWwgVGhpYWdhcmFqYW4gKDUpOg0KPiA+IMKgIG1p
c2M6IG1pY3JvY2hpcDogcGNpMXh4eHg6IGxvYWQgYXV4aWxpYXJ5IGJ1cyBkcml2ZXIgZm9yIHRo
ZSBQSU8NCj4gPiDCoMKgwqAgZnVuY3Rpb24gaW4gdGhlIG11bHRpLWZ1bmN0aW9uIGVuZHBvaW50
IG9mIHBjaTF4eHh4IGRldmljZS4NCj4gPiDCoCBtaXNjOiBtaWNyb2NoaXA6IHBjaTF4eHh4OiBs
b2FkIGdwaW8gZHJpdmVyIGZvciB0aGUgZ3BpbyBjb250cm9sbGVyDQo+ID4gwqDCoMKgIGF1eGls
aWFyeSBkZXZpY2UgZW51bWVyYXRlZCBieSB0aGUgYXV4aWxpYXJ5IGJ1cyBkcml2ZXIuDQo+ID4g
wqAgbWlzYzogbWljcm9jaGlwOiBwY2kxeHh4eDogQWRkIGZ1bmN0aW9ucyB0byBjb25maWd1cmUg
Z3BpbyBwaW5zIGFzDQo+ID4gwqDCoMKgIGlucHV0IC8gb3V0cHV0LCBnZXQgc3RhdHVzLCBoYW5k
bGUgSS9PIGZvciBncGlvIHBpbnMuDQo+ID4gwqAgbWlzYzogbWljcm9jaGlwOiBwY2kxeHh4eDog
QWRkIGdwaW8gaXJxIGhhbmRsZXIgYW5kIGlycSBoZWxwZXINCj4gPiDCoMKgwqAgZnVuY3Rpb25z
IGlycV9hY2ssIGlycV9tYXNrLCBpcnFfdW5tYXNrIGFuZCBpcnFfc2V0X3R5cGUgb2YNCj4gPiDC
oMKgwqAgaXJxX2NoaXAuDQo+ID4gwqAgbWlzYzogbWljcm9jaGlwOiBwY2kxeHh4eDogQWRkIHBv
d2VyIG1hbmFnZW1lbnQgZnVuY3Rpb25zIC0gc3VzcGVuZCAmDQo+ID4gwqDCoMKgIHJlc3VtZSBo
YW5kbGVycy4NCj4gPiANCj4gPiDCoE1BSU5UQUlORVJTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgOSArDQo+
ID4gwqBkcml2ZXJzL21pc2MvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPiA+IMKgZHJpdmVycy9taXNjL01ha2VmaWxl
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDMg
Ky0NCj4gPiDCoGRyaXZlcnMvbWlzYy9tY2hwX3BjaTF4eHh4L0tjb25maWfCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCAxMCArDQo+ID4gwqBkcml2ZXJzL21pc2MvbWNocF9wY2kxeHh4eC9NYWtl
ZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPiA+IMKgZHJpdmVycy9taXNjL21j
aHBfcGNpMXh4eHgvbWNocF9wY2kxeHh4eF9ncC5jIHwgMTY3ICsrKysrKysNCj4gPiDCoGRyaXZl
cnMvbWlzYy9tY2hwX3BjaTF4eHh4L21jaHBfcGNpMXh4eHhfZ3AuaCB8wqAgMjggKysNCj4gPiDC
oC4uLi9taXNjL21jaHBfcGNpMXh4eHgvbWNocF9wY2kxeHh4eF9ncGlvLmPCoMKgIHwgNDM4ICsr
KysrKysrKysrKysrKysrKw0KPiA+IMKgOCBmaWxlcyBjaGFuZ2VkLCA2NTYgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWlzYy9t
Y2hwX3BjaTF4eHh4L0tjb25maWcNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21p
c2MvbWNocF9wY2kxeHh4eC9NYWtlZmlsZQ0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvbWlzYy9tY2hwX3BjaTF4eHh4L21jaHBfcGNpMXh4eHhfZ3AuYw0KPiA+IMKgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvbWlzYy9tY2hwX3BjaTF4eHh4L21jaHBfcGNpMXh4eHhfZ3AuaA0K
PiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWlzYy9tY2hwX3BjaTF4eHh4L21jaHBf
cGNpMXh4eHhfZ3Bpby5jDQo+ID4gDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPiANCj4gDQo+IFRo
aXMgcGF0Y2ggaXMgbWFya2VkIGFzICJSRkMiIGJ1dCBJIGRvbid0IHNlZSBhbnkgcXVlc3Rpb25z
IHRoYXQgeW91DQo+IGhhdmUgaGVyZS7CoCBQbGVhc2UgcmVzb2x2ZSBhbnl0aGluZyB5b3UgdGhp
bmsgbmVlZHMgdG8gYmUgaGFuZGxlZCBhbmQNCj4gc3VibWl0IGEgInRoaXMgc2VyaWVzIGlzIG9r
IHRvIGJlIG1lcmdlZCIgdmVyc2lvbi4NCg0KT2suIEkgd2lsbCBkbyB0aGlzLg0KDQpUaGFuayBZ
b3UuDQoNClJlZ2FyZHMsDQpLdW1hcg0K
