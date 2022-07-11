Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA04756FFF3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiGKLPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiGKLOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:14:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6C513E24;
        Mon, 11 Jul 2022 03:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657535609; x=1689071609;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jQJ0PsLAVVMGpecHIYsJ66cU3yPvOicuCMQl00Ndhyg=;
  b=GspE4IoHUHByP5RVuMQoVEPtfvj/UBVxSEoYRvdoJZINlYhRiKG0lS5Y
   ag5kWrOqiWlLbRfX2hb3zFJcmhvpUjoGZ8rnLXbbPAOjHBndPGiLIlP48
   MoKEEjZYYcOknT5/F7Bp/yUiF296q1T2dYAfyoBF9gS9oSbrcFk5jWPSx
   ZfQJXo0D3QVqobHKVBGY8lo3LH8f5QqShNdmT8BAQEERKvjSPEvanEkLu
   kOdpdq+z8X9VBy+3tWyrflo2VR/iw7VCRj68EPSAD6YKwrFhAqiihpCtM
   /FOzewb4umkQ7wU1hOHyQmPM7MHpnB6ZeDZgJ9N9oi9KdFXO02ec52bOf
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="103895437"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 03:33:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 03:33:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 11 Jul 2022 03:33:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1+i4HDCIOUOZFckJa5JAnNnfPcUfQuESbIkU+uI0s+b40Sy4GPgoZ6Ea3xhlrApXcHC3LB5B94jSKSxYoqNNYsJQO18KcmLuIPNH+vkeew/8b/5buMsQJaxl6knkHyuzOW7Qj30NxRFsqnQibUDcMrfyVACq2Q5upu5pQz24YNIbWTEPq3rHru0/xWljN+U3Bv7bmPk7Wotp0EpSeGNHLNheJ3Miy9lxMD9o6i6dGhLVhdFb2uLe5IpXMA97ywteNivpHztFWHl9rPCQcbUH0fZlL2Bz/ch3I48mnPUHDmofPWvuJ+ep071RXeAhmqDPpDPEz1NULICtGqMtqafKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQJ0PsLAVVMGpecHIYsJ66cU3yPvOicuCMQl00Ndhyg=;
 b=NMm4YG7Elx2NzqXaHvjKEHoxLvSX8YhMvYauQRyvqlimtGkH7FEDRWrEsVOkt1aJxqEBotKF4R1Zko83ja+aCKFLFkn+rpKn5H80fVHjSP1ap9GzxTqgPz3MUfDHv5T5swvhkkvf+Z3N9l78HpsVSP8Kc4fWdiEeYoFFyc84/cLFKYyhCYFzkCkIleInnJmQNRSCQNcz/nug06zxsnvYIcYdu81EDx6Zu+WUqhLpumjdWFBzLdV5lpRoYx2iCbVuae74OW5z4vP0xZoRRpECF/AfZ8yOvLQR4z4ANO3iVoL0VlCuPMiJej8JeMDp/mhKMdl+O6Gn3qURmrm/njDW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQJ0PsLAVVMGpecHIYsJ66cU3yPvOicuCMQl00Ndhyg=;
 b=YF7Md8komi6khW+QUD3Tn/457KolPdTaQ9spqsS8eF3Hl4RqrgpMGqNC07gOA15NQCXKwf0kF1e3frFQKColHGStDWTVZD96aea2kwW8ZXAhKnDgHF0ZquAE/W6KLh+bHkF7sQ5+PSL+TnN73N08P7/LqywwhP9+YQoB0sJ+1Tw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB4052.namprd11.prod.outlook.com (2603:10b6:405:7a::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 10:33:22 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 10:33:22 +0000
From:   <Conor.Dooley@microchip.com>
To:     <geert+renesas@glider.be>, <broonie@kernel.org>,
        <Daire.McNamara@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: SPI_MICROCHIP_CORE should depend on
 SOC_MICROCHIP_POLARFIRE
Thread-Topic: [PATCH] spi: SPI_MICROCHIP_CORE should depend on
 SOC_MICROCHIP_POLARFIRE
Thread-Index: AQHYlRDscDs8Hw01AUS3IkiKDybfsa14+TKA
Date:   Mon, 11 Jul 2022 10:33:22 +0000
Message-ID: <373b74b4-657c-b6b7-9532-f6602d6b2a8e@microchip.com>
References: <4e78693a87d6b83847056d22468c370e7232f390.1657529125.git.geert+renesas@glider.be>
In-Reply-To: <4e78693a87d6b83847056d22468c370e7232f390.1657529125.git.geert+renesas@glider.be>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e28c752f-ea6e-464b-c8a4-08da6328c7a1
x-ms-traffictypediagnostic: BN6PR11MB4052:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0+CC1lP7lFQcArCOIAb25W7RxUBvClN7HQ/Bww8zZn0rrdSljb5F36jRUMEJ39qmYv/hS0w7zh8dgU+ONuw1UTpM7B9o46aA0UAqxjsBn7d75H4r4Msg8mIa8ZiLJIx4I3Y44nHk1+5FRO1XYsUafCg/1e1ohWYbOUORCpdMEJ9+BUsL9nP5yyaNGt6tep7S89xWSWTke8v9+XbTqfib5Sn7Hro3cdFookS2ffdWytnUmW9ffUEbZbCkvVnBlR2yW+594dksfHdQ6SH8s64jMFJ/VYAtB0Rf9WbHJsTUzcjGfbtszkLKkpYd9rKpt5paZn//nsNkka2QYSU78EH+mJRUgeri069vK2e/1uS3pien0/bG1XQ6Qqg/QvSd2hqoZzCZv33f/EfE8zDlgGF87dpZ2jXb+kHItW6/+Eucrb2HTNMViRs+T6GUFjFzRGLQ1os+g25vUhaWIRIiZ3GsLE8Pp4pukc0H5U5AZIkHIq0LAq4LZ0Qd+YYXMvZ7T9RE4OFx6JfGyb2q/V/g3iA+x1sj+NdevUz+Nrrm7dGwJWUVwcirbjK/5CCEpx04U+99U27tIUSv6hG+C77CMhoYcimrhTNGSDitQcQMfEhDVS2C/BpoInXK5eyTIrF778stgGWFTHIzsSpe8f9GIr9f5r/vEadZK/5DOdczcN6OPh58c/2J5o2NBHNBDMX1IwYnhRvdo3+pG1J2HjEPU2Hz+BIeIuoYOxSW1/7AQu7m8FXxdaOJ3Qq59kWQSfblrdIwx3+1VeGh6AP8eBPVAvnw4VhV6UotXRM4g34lknS8n2UvzzzUuGqMw9yD46QXmi0OrKGQFYNoloUCMVq0LOhteL3EzWPwVWhQmSOO3rQfZ1kqu109hjDk2k3hblxFGlKH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(39860400002)(376002)(366004)(316002)(110136005)(71200400001)(4326008)(2906002)(31686004)(41300700001)(478600001)(6636002)(54906003)(36756003)(53546011)(6512007)(26005)(2616005)(6506007)(91956017)(64756008)(66476007)(66946007)(76116006)(66446008)(8676002)(66556008)(186003)(122000001)(31696002)(86362001)(38070700005)(8936002)(38100700002)(6486002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmcyWlpHVXovcXlMWnFQVHFyam1NcXdOVGpVSWF0K0xOeTZsSmxvTjlhTjNj?=
 =?utf-8?B?bllPUlByVGtwaWx4dDRvdS9oTFVqcGV0QlVxaGJ4b0NqZ3Nsc1BjUHQ4SXhn?=
 =?utf-8?B?T292MjhQMThoaW9BTzR6eDlsMkE0Z2lHY2QrQVlTclBTSHBKdlJ4bDhzZTMr?=
 =?utf-8?B?NFdPVXlYbEU3cmd1WDNwMVFra1ZORTkxUUJjOVdOWldaTFdNVkxzZXJKL1J2?=
 =?utf-8?B?UFE1a2ZpQTZwR3M4dGsyS2J3MXhwYlBwaGRpS3A1c2ZVa2lmekJGNzJZTURK?=
 =?utf-8?B?c3hCOWFPalFtaVhXN3RDVUNSNjlYTUthWWlJTDBGUk9NRjVyNjFHeURmUHE2?=
 =?utf-8?B?OFZSYk9xVUdmWG8vTWp1OHlvdGN0ZGFpeUpLZVdZL2JnQW5BV1MwUnoyRWhK?=
 =?utf-8?B?RytzN1hMNVQyY2pXNjRIZThLTmpnM3MzNk1vUEFRNGpiM25wUU9BdU9Uc0pl?=
 =?utf-8?B?eWFvSzQxWmJFWHZDbVhNeForbzZPWXM0UE5CMHJRbVJBY1dHYzdYVFZ0ZDRZ?=
 =?utf-8?B?KzcyZ2E1eWRnbTE1bVVnMnJJQU9VWkFyWXJPQ2cvRm82YzRpaTdXcXJpYjdn?=
 =?utf-8?B?SzFSeDQ1bEpLZVRyK3BXV0hOVlpmZjlUWUttUGNWblAvekd4eEtzTTFlVm9w?=
 =?utf-8?B?K3ZLU1EvVi9EZWRCc2RMRm92ZzM5bHQwbzVCMDI3S2lMZWluajJETGNGSW50?=
 =?utf-8?B?TjgxdXU2N1NQYzI2Q2tnTG96NWF6eERvQU9uek5YRktYUU9XT0s5RW1VWk5W?=
 =?utf-8?B?U3JxYW5xRVBRYk15d1Job2psaHVzeFJ1MVE3dWZpcTRLMXVlT29QRk14L2Rk?=
 =?utf-8?B?NUZXeXJIWk9ScUZFUDFid3c2cEtWTU8yQ0dETVdvYVpIclNORld1RW42VW5M?=
 =?utf-8?B?WEpDQXFrQ2d2NzFCV0VRejA4c3lEVU9zZWxTZDc0SFZzTytDRlg3a0pwSlBN?=
 =?utf-8?B?Mi9maElwUUZCRG1HcTBqSzdINkZ0L2YxMHN6YWhObjhMWUhSdkd1bExaZE1p?=
 =?utf-8?B?enpuckZvYTdxT2MzNFZWVXNGNlpXTTV3d3lCREVxeURaUmRJS3NNZkJxZWU0?=
 =?utf-8?B?UTZ6aEM5djlEUk1ZZis5Q2ovSHBWcnFTMGRHSDdDNEtIOThaN3JFWis1OEtJ?=
 =?utf-8?B?djVPalg1Mk1VREhTcGxtOUFJcUc2cEs3YmtHUDA1YW1VdjFOL3lsMEhmY1Ay?=
 =?utf-8?B?MnMxOXJpQW1KT1VaNE5kaVFQR1ZCTzV4VHFFQ2JEOXpSZC9RM0RCU3UvTDV5?=
 =?utf-8?B?VDhPc1R5NGR2bUw0VkJIQTVBT0h1ZEphMUFucHZMVG1FMXlua2JwOXZRY0JQ?=
 =?utf-8?B?UmkxQUE2QlVNcjByakJJRXRsZ3BrK2dHbFVuTGFoTEdkdEljZ3hVZTQzTEtU?=
 =?utf-8?B?ZCtja24raTlkRC9SUlh4UmVRcUxLdHhlL3R2cm4rVEc5Zk5nNnpmOGxLWmlr?=
 =?utf-8?B?R3ZWTjY3OWx2ay9yWlZJUDdrWi9KTEdzYlovNkRkZm1zL0paS3Bhc0V3VzdE?=
 =?utf-8?B?eHlURmFzaVU2bkROMFpMTVg5SmtQUTI5NUpNbVNPbzEva3V5S041L3ZGT1Rs?=
 =?utf-8?B?VzJuUzMzRG9hNjhlSGptV2VGR25Ca2xvT0gzNzhTVGJMYnhsVGtiVUJrT3RF?=
 =?utf-8?B?TWxaMG1VZkNsais5SE85THptZW93dkk3bHdQakJrRDVxYTNnbmNueWE3K3N5?=
 =?utf-8?B?bHpTUHpqb05ScEh2V3BIYUYvSW1VWkltV2lxKzZIL0ZBQ3NtUUlGakh2aTdE?=
 =?utf-8?B?aElHZ01KR1kwMXZnVVpZcmZlclB1ZFBZd0VXV2pCbzV5OUJvMWNnbEZ5YzUz?=
 =?utf-8?B?bDk4MXpWMkdtSzN0RjErRzQ0SzhGUHYwUStobjdFZ01uemEvVE5qNVpxUEFz?=
 =?utf-8?B?YnFrcG5EME1VRjRFUXlobFhCK0JPdE43R2tsSkw0R2RiVWF0VmJFaVlJbm81?=
 =?utf-8?B?dFkzQWZLTWxEZ05CMzdTa0txeHNOVkJzN0RZYTA1dE1KSkJxeHpRemdVVlQx?=
 =?utf-8?B?TjJHSGljT3ZlMytmZGhlTmNzTFdWeGJ5VFhBd1Nja2pJYU8rUDBvWnozYnEw?=
 =?utf-8?B?WTJqa0pkSU9vd2FHT3RvVUI5Qk94OW54MXRJS3J6akRyblNsUi85U2tuOVpm?=
 =?utf-8?Q?yZVpXYi0U3AwSdkYkAZ1mg4tj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC3F3A040381B0419D3EF733627BA1A2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28c752f-ea6e-464b-c8a4-08da6328c7a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 10:33:22.4832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEgJx7hhK9fCgKw/Nx534eEGyMtZ8ckXd/DPCMUCrhWbz+Fb4ow0sLISwMVERrCVHDMKpBAJUx2ca1rLYo4eSIX9uAEnpP2ULSB8AY30NVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4052
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDcvMjAyMiAwOTo0NSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBNaWNyb2NoaXAgImhhcmQiIEZQ
R0EgU1BJIGNvbnRyb2xsZXIgaXMgb25seSBwcmVzZW50IG9uIE1pY3JvY2hpcA0KPiBQb2xhckZp
cmUgU29Dcy4gIEhlbmNlIGFkZCBhIGRlcGVuZGVuY3kgb24gU09DX01JQ1JPQ0hJUF9QT0xBUkZJ
UkUsIHRvDQo+IHByZXZlbnQgYXNraW5nIHRoZSB1c2VyIGFib3V0IHRoaXMgZHJpdmVyIHdoZW4g
Y29uZmlndXJpbmcgYSBrZXJuZWwNCj4gd2l0aG91dCBNaWNyb2NoaXAgUG9sYXJGaXJlIFNvQyBz
dXBwb3J0Lg0KPiANCj4gRml4ZXM6IDlhYzhkMTc2OTRiNjZkNTQgKCJzcGk6IGFkZCBzdXBwb3J0
IGZvciBtaWNyb2NoaXAgZnBnYSBzcGkgY29udHJvbGxlcnMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBH
ZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KDQpVbnRpbCBJIGdl
dCB0aGUgInNvZnQiIHZlcnNpb24gc29ydGVkLCBtYWtlcyBzZW5zZSB0byBtZS4NClJldmlld2Vk
LWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0K
PiAgIGRyaXZlcnMvc3BpL0tjb25maWcgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9LY29uZmlnIGIvZHJpdmVy
cy9zcGkvS2NvbmZpZw0KPiBpbmRleCBlMDNjZDE2ZjQ0NjkwNzllLi5iMWNiN2ZlMTI5ZmY4NmRh
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvc3Bp
L0tjb25maWcNCj4gQEAgLTU4NSw2ICs1ODUsNyBAQCBjb25maWcgU1BJX01FU09OX1NQSUZDDQo+
ICAgY29uZmlnIFNQSV9NSUNST0NISVBfQ09SRQ0KPiAgICAgICAgICB0cmlzdGF0ZSAiTWljcm9j
aGlwIEZQR0EgU1BJIGNvbnRyb2xsZXJzIg0KPiAgICAgICAgICBkZXBlbmRzIG9uIFNQSV9NQVNU
RVINCj4gKyAgICAgICBkZXBlbmRzIG9uIFNPQ19NSUNST0NISVBfUE9MQVJGSVJFIHx8IENPTVBJ
TEVfVEVTVA0KPiAgICAgICAgICBoZWxwDQo+ICAgICAgICAgICAgVGhpcyBlbmFibGVzIHRoZSBT
UEkgZHJpdmVyIGZvciBNaWNyb2NoaXAgRlBHQSBTUEkgY29udHJvbGxlcnMuDQo+ICAgICAgICAg
ICAgU2F5IFkgb3IgTSBoZXJlIGlmIHlvdSB3YW50IHRvIHVzZSB0aGUgImhhcmQiIGNvbnRyb2xs
ZXJzIG9uDQo+IC0tDQo+IDIuMjUuMQ0KPiANCg0K
