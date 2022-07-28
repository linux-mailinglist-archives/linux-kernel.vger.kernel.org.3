Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10938583FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiG1NbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiG1NbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:31:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169D714095
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659015068; x=1690551068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XUSKSeiaiXKN2xiayW6PozrXSMSjFdxIcU4lmcfM4OM=;
  b=DuXh01DLQ5W54nDIzRYMoHlDOBzsZeUXfPF+nQFeTIiKankZM/lhfpcN
   1+bQs0UqbeoUWG6djfpH2tuh/zwxQLgMlHb/n8AKq9386pjyZ1xrhmNPE
   vedMVqUfvZFUBuRUnzgyk4odg8ROUjvi0p11WN2wwBCQWCcN/VXkZl3hZ
   LawqbgJQ4pZQs9EYSPoely/kCVrmLvBHkg/fGYNs5LXIEE9fV9kYxW2k2
   gOE55KvyzpS2RzoUEXZkLPmdAkB2nJkmcyKBXtaKzHa1lCYqt6kAVfNQh
   WSC3e348rcew719mhnI1coUCDapEWrDynvHx6eqZx9mm7miRojwQ6BYyA
   w==;
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="174001987"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2022 06:31:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 28 Jul 2022 06:31:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 28 Jul 2022 06:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4Cr0xe89UBHDfddQU2Tl7V5r3PndjBDV4rut+wjB58UIwfNagi79cgfaaWlm2U6zQnS1TEcDZyTWO3o4QF6WLellM8l17kPpu8syuLoJg39LF83bFK1vd6HeTDtthwDQ9joX73MYoL3wNrR6hOnCJx9rKdLuI6yVsMu3sfwX4NiwrxbbZDsS42HtP7XirZelQ5mGvm2bSWF8GAPcXfEXbyHE0RPTqom9BRZn7vbg/CKgJqFGvvdcVJS61LV4QfKrWM5mhHr8VL5maYptFq60vVycABijNxROmYuq4psiI6BmC0VEpYGrJeZXzhPNfeCtD4+mxwJ8kRLtSHOZWgomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUSKSeiaiXKN2xiayW6PozrXSMSjFdxIcU4lmcfM4OM=;
 b=hx7gOZ7k9KR1dE/se432zrbpQSeBjDAdIEIujVz4EfBvwgwssBnwx31VJRuOMWGarlj8Z1Hu8AxUz37JpEvs6Rl24N294cWX/zLII0I0yVqurhRo62YgLxnuMo7FCJg7zShFDwvqV78SHwWV+fREREZoRBtwPh7oTy2KI03i0/TYmM+cVcyHAqHvmVzFiJ7OTWyO8d68as0BPElJff/wXJEl9XOAjB3s3OgxfjkuiIkUz3aQBObuNAj37ttK2j2oA/RrwN8+uczjaASLrgUzEUW/ERYgHXSOvTxYPlgww0WqzQ7hdJlSQzlzcat8VYHEfnaYpn6Hop2Fr0+jua4KYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUSKSeiaiXKN2xiayW6PozrXSMSjFdxIcU4lmcfM4OM=;
 b=Why/ZQtFktkJqn/j9c7K4dmH/SurA8jxurlXU7pzeCozZSCJHNo0o90goojAyc0FpOqPiuCfWgDecc/XtN3EVmrDSEzbxuDzfNE5d4pIshI4QdEaO3ze7vGG4wDVcFU9Sug6mOt2FDGexdB+RB5METOBZDohQh7g90ltS22J1P0=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM5PR1101MB2202.namprd11.prod.outlook.com (2603:10b6:4:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Thu, 28 Jul 2022 13:31:03 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35%5]) with mapi id 15.20.5458.023; Thu, 28 Jul 2022
 13:31:01 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <quic_c_sbhanu@quicinc.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
Thread-Topic: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
Thread-Index: AQHYmzRwuAFPdIe45ECo1RhI0CKwAw==
Date:   Thu, 28 Jul 2022 13:31:01 +0000
Message-ID: <29f4cff4-edc5-3838-2495-253e794178ae@microchip.com>
References: <20220510140232.3519184-1-michael@walle.cc>
 <20220510140232.3519184-2-michael@walle.cc>
 <160ddac1-6d0a-c922-1380-09e7823a285e@microchip.com>
 <41e6b74d-6973-60da-1556-82a1e879ffd4@microchip.com>
 <ff6ffb3f8e77b29b44883d30c9b4385e@walle.cc>
In-Reply-To: <ff6ffb3f8e77b29b44883d30c9b4385e@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d003c66-087a-4642-3640-08da709d6a08
x-ms-traffictypediagnostic: DM5PR1101MB2202:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yY/oC5qfFN+OknbeCZzNkMTfrOxs7tZhlVyXLwHJoa8fbGkSt/1asrAqxKoKBL/DnYXVKbQvaY9z/r/oM85HfJ8zBNe40ciZLFjpzvWeSTUhqFBYz/5E6+9Tc4AxuESwaR8ad1VwwcEWK8bYO39ZHyS5hUVbEouM8dtV66dVqyJO4w0CahfVhHThD7gvCY4KJlS4iGXuVPpzubVVDokjrTSc2sE0Vu9E9CtjcaRNB0BCKZvqryGCvG01w6b8iOMPIkjzI+VD6/usKoQbQBj5tERiCVBr21meW+tcwYc/cz5F4r18A15WadoerZvWehtHIa5C3JdiYhv8ll8GV3KIEcJ5a9ixj4dEBy9LZpWWbIpCRJn4l8vWxABPfIQcO44OW+o8XI3HeKjwdnIbNsmKpZdbcDWmUzXP5i8oCRvFQQRn6zmaXkMvLBDrk5VZjDCZ0TV0oS13bXMTZYPUFOklVvkaXKgoHSK6Z0Jzrk9jXCNrJtS/eALqTx6+QI48Zy0spA8oBW1n7Bbmt6muRvZhVPD+gVheWsToILMsiFE8KroBDC6d4zgkIiPUxd9GQHO7y7UtigTV0ESKX5fsQxax/eDs00r7jbHKIVGafh5I+FAmIbyKNikncznwehC6RwcckoJRblfDV+/VTw+LZSru5fAxrmdnqZu421Cs+ojLJT752KPmUeWkGCOT3qygoZEJmmspK7oEu27iBTxD9mlV3rEgqm2lk9Zj7QD6lm/CWHy0pJUVBlH+4iVMM48G7aiXRfSN/2qcb76SVPLg9Nl38rNc0Bwq/JWHk1/8YgHMJAuAu9Py5GDExu3SqRLn55+U3wOJDIzK5qYIQMMTKn3GrWbJc40ypvOUWPUu6+nPZ+kSksXkD5VwThH8YT21SCp4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(376002)(39860400002)(346002)(186003)(66556008)(2616005)(122000001)(36756003)(38070700005)(2906002)(5660300002)(6512007)(4326008)(6916009)(316002)(4744005)(76116006)(54906003)(38100700002)(8676002)(8936002)(66946007)(31696002)(53546011)(71200400001)(66446008)(31686004)(91956017)(41300700001)(478600001)(6506007)(66476007)(64756008)(26005)(6486002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEFMbVh5NUJKSHpXWCt5d2RWUzduc2dXWnpFeklaNGIxYjFkMldDUCtkeDVN?=
 =?utf-8?B?ZFptSlYzQ3FncTYrYldmL0wrZUZiNUp2MUFaYmp6YjN0NHJWMjVYcWZIMGJn?=
 =?utf-8?B?djNCY0JwWkpNVzBXWWRLckF3Q3RUVmhzd1lmMVRUazd3TmZ0NFd5MUtENmha?=
 =?utf-8?B?T2U5UEJoZTA1NndRZ0pUa2NDVVkyT1pOS2lUeVc5QThwcTRraDVSZzhFUDkz?=
 =?utf-8?B?RFVCaUhSYUJOcW82M2NFdzN0d3RDREVmWFJ5eFdpNi9sZVQ2SDRqaFFYMmY0?=
 =?utf-8?B?UWJsbzlOdDlxRnBSeDlSZ0tycVluWS9objhrWXVFN2JqTGVqczBOVWRZcE1F?=
 =?utf-8?B?T3BLemI2QU1wRXIzT3grcEUxdFFhWTJYYUR3aVo0VS9GSDlaR08vSkpheVVz?=
 =?utf-8?B?Z01lbXZseUI2Yk9rVnFXMUo1VWdPdEVkYktaeGlIT2ptREpxdjRhZkhNS3FJ?=
 =?utf-8?B?c0p5VGIwYlNKelRZSHFlZndiajdHTm16K1J3VEFHWjkzVy9rTU55aE1pOEhj?=
 =?utf-8?B?TktEdTNBVlVRMjFBUzk5V0xibTdIRzZCUE9aUVZFZ09IRjZNbUpObVgxVjNn?=
 =?utf-8?B?OFluRzdacXpnRWxoNFR0ZGFQcUcwYWFTKyswdzdVTmRLak5OaERINk9pd3M1?=
 =?utf-8?B?TEtFZTRycG1LcmNTbWV4bk1yNEdOV3dwTW01dCsxTHBwN2NBckJBd2NNTXNt?=
 =?utf-8?B?eks2MGU4RHh5Y1F4V05yeHlwR3hlL2dEOSt5a1U5aktEUk95Vkt3bXBhOE5B?=
 =?utf-8?B?MlUxbmJjYVFqUFJrNTNtZDVQT2oyK2V1VUl5T3dRQnU4Y1RqQmI2aTB1TkMw?=
 =?utf-8?B?dVgyU2NRRzVqL1Uya29WZHlGM1NsYm5HbUdBUldHUE1qVFJVMHdNQkNmMllW?=
 =?utf-8?B?dSthMHk5NkZtaDZtb1BVemtqcXI1M0JQOFFPS3NMeGxFTlYwSEU3TFZBSldo?=
 =?utf-8?B?MmNtUkFIMVpBaHBlSUZScGRwRkdwckhwR24wUlREZEYxYzVZd0c3MVFFMGh3?=
 =?utf-8?B?V3dCd1FBTTJZbDZzdzRMNC9FV09hQ01WUTFuMXBMd0NXNlArSENoR2ZFTEhr?=
 =?utf-8?B?OWlJN2pURkVqQ2RsQnRyUS91SWRWOFNKTHRVZGhBbTBQN0paZ2ZYV0hlZm5T?=
 =?utf-8?B?ayt1WmIrd2xDNEVUSTFwdDNScktmYWVwcXBtT3YvaFFQWkludmNkTjUrbUJZ?=
 =?utf-8?B?QTN4cGltaU9waWRwakdpdUtPMXNiWXZiM0NHOUZzTUp2TEZndGJyNDV1djhu?=
 =?utf-8?B?alFGSXRxcTh6bjBrQVUzOUM5WkI3a2EvVzJXQWJPUyt1SXZSODYwN0M0enJw?=
 =?utf-8?B?V3BhYU1FL3VLQmxFTkphemhkK2NsMEtHTFNQN1JXb0p3Z0p6NGNQMUJhYjI2?=
 =?utf-8?B?VjdQbFVIM2x5QUlsZ1ljWDdlL3VHTGtYRmkwMTE0d0FwWnJBNDBsUzVJdnF0?=
 =?utf-8?B?RW1tMGdVc2RZRFFjd05QSHJDNDY3WGhXYzgyQi9ackx3Ly9VNHFnV3Z5L3dD?=
 =?utf-8?B?alJ1RnB4b1NiN3R1ODIrSUJQQ0pEOGQ1NXRKU3dFSUliZHhrUXVkOGNoRW1q?=
 =?utf-8?B?ZENadzFZRzZ4RmpqQS9XTUZNUDdNWVJlUk04N2orbk1ZSW5ldElBSFNGZE51?=
 =?utf-8?B?MWV0ZlFiaFJrUXdwQy9zaWpZQ1JKQ0ZpM1NCamx1RWlmRXl0RVlMYm4yNWRP?=
 =?utf-8?B?bFN4SVlGY3pQekI0S1k2RnI2MTJmbUI4dHdOeStWTUF4UGRKWFd5d2FFNDVz?=
 =?utf-8?B?dndSQTVmZHlXUmtsdDBUOFpLS2xGUGZwQko2a1pXQ3J6bEVNRGhOVENRTnBt?=
 =?utf-8?B?VlRDejYwQUZTWTBuQU8zR3lkb0ZvMkdHMkNSZElUTEFxZzlmRkdlOGZaR1RV?=
 =?utf-8?B?dkhlVmIzWXZpWWU5bElCQStpWldXek43ejloc1QxeUhaTWFha3UwMTBSNStp?=
 =?utf-8?B?MDFERExFU3lyRUpkTkhFbk5nRkxtd1NzU1R4d0N4ZTRqUmp5Ni82dkpabS9l?=
 =?utf-8?B?VWxzVFNvZ1kybjFEWlhHWW5YRjlpMlpqZ0dKZ0xId003cHcvd1FrZXc4MHdN?=
 =?utf-8?B?RUQyTE8xZHpnQ2E3OVNXbUNUbTU5eVRIVG1GTlFmREE4RWRtK1ZjbC9LVHJw?=
 =?utf-8?B?VWhXUVdzdlErV053MzBlaXF3cXZZNk53bFMrV1JHRUVWWnFIUXRPeVRibmxK?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0790D10B2EB53F408958DEC7DD75C1CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d003c66-087a-4642-3640-08da709d6a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 13:31:01.6821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUpLMOSS9zXYcdF3kMmU3VaBNOdj7ClWPdaFxE93XeoUulCI2GbYDsWHHKGbj3t1YtzoSRYDtoqV5XVyQ8ZBLz2P66wx2qOQ+qLkayev1Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2202
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yOC8yMiAxNjoxMiwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4+PiArI2RlZmluZSBTTk9SX0lEMyhfamVkZWNfaWQp
DQo+Pg0KPj4gSG93IGFib3V0IFNGRFBfSUQzIGFuZCBTRkRQX0lENiBpbnN0ZWFkPw0KPiANCj4g
WWVzLCBwcm9iYWJseSBhIGJldHRlciBuYW1lLiBJIHdhcyBhbHNvIHRoaW5raW5nIGFib3V0IHNw
bGl0dGluZw0KPiB0aGUgaWQgaW4gdmVuZG9yLCBkZXZpY2UgYW5kIGFkZGl0aW9uYWwgYnl0ZXMu
IEJ1dCBJIGhhdmVuJ3QNCj4gdGhvdWdodCBvZiB0aGUgYWN0dWFsIGltcGxlbWVudGF0aW9uIHRo
YXQgbXVjaC4gU3VjaCBhczoNCj4gDQo+ICNkZWZpbmUgU0ZEUF9JRCg8dTggdmlkPiwgPHUxNiBk
aWQ+LCA8dmFyaWFibGUgYXV4IGJ5dGVzPikNCj4gI2RlZmluZSBTRkRQX0lEX0ZVTEwoPG51bV9j
b250aW51YXRpb25fY29kZT4sIDx1OCB2aWQ+LCA8dTE2IGRpZD4sDQo+IDx2YXJpYWJsZSBhdXgg
Ynl0ZXM+KQ0KPiANCj4gQ291bGRuJ3QgbWFrZSB1cCBhIGJldHRlciBuYW1lIHRoYW4gdGhhdCBf
RlVMTCBmb3Igbm93LiBIYXBweSB0byBoZWFyDQo+IHN1Z2dlc3Rpb25zIDopDQo+IA0KDQpZb3Ug
bWVhbiBzcGxpdHRpbmcgdGhlIElEIGluIG1hbnVmYWN0dXJlciBJRCwgZmxhc2ggSUQgYW5kIGV4
dGVuZGVkIGZsYXNoIElEPw0KSSdkIGxpa2UgdG8gdW5kZXJzdGFuZCB0aGUgYmVuZWZpdHMgb2Yg
c3BsaXR0aW5nIHRoaXMsIGNhbiB5b3UgZ2l2ZSBtZSBhbg0KZXhhbXBsZT8gSW4gdGhlIHBhc3Qg
SSB0aG91Z2ggYWJvdXQgaW50cm9kdWNpbmcgc29tZSBmbGFzaCBpbmZvIG1hY3JvcyBmb3INCmZh
bWlsaWVzIG9mIGZsYXNoZXMgb2YgdGhlIHNhbWUgdmVuZG9yLCBpdCB3aWxsIHJlZHVjZSB0aGUg
bnVtYmVyIG9mIGxpbmVzDQpvbiBmbGFzaCBkZWZpbml0aW9uLCBidXQgbm90IHJlYWxseSByZWxh
dGVkLg0KDQotLSANCkNoZWVycywNCnRhDQo=
