Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FEA5794B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiGSH6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGSH6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:58:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639AC2AE39;
        Tue, 19 Jul 2022 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658217529; x=1689753529;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9a4y1j3f/kpg/M064o1PUDMk9u2Kp7zYwGgu9j9cwf8=;
  b=dBxMFq+xu2wCxtjNOE76LGeeLV0lThOHsHZQkH3srKSa/2pgkF/IP2Zw
   ukt6N26wmiqi9I2s6owA8a/TPuv9WZO3YPw9ZlzU/CwQuw7PrK1wWnacn
   n6uCRQhU9BiZrW3QpISy6ZY/ice9fXK66TsrBJnTBmadG7NEgWqxEIBoy
   vDMB7wE35MI4tJzMO3+9Q/QTEvNNaJhz3n80E6Iu0KQL9u9ab5zqieMwu
   s6wX0/N9O6bK2+fb2p+dy6aIFbBbsg/FzLu2rcDfSe+HELRZyOiI22G8B
   xBAO0aoKT11iYaushVIkMUP2znAVYhjmQQ/IKHg2GGEFBOPP2kSjdwxCJ
   A==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="105086982"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 00:58:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 00:58:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 19 Jul 2022 00:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg5KPj0BF2nvZpUDTesOu8oUK3lKnjxWPOLtftvCcDKW13v9R40JNWfjLTyB7Sotmi8JDGdPIHF5p3oJSM1wi8n8bR0c9fNfNCNgiw9o5ox2HOtxxrws1SowMEl89hk7kFqiDcKFptMR4mSSsBiCWtDn25VqlzTAKF1gGauU8ckG82uGONbCFQIovTYWt/PHcE2ojJ2dXoDdQ0D9MmcJ7Z2en0orwwFDcHakWT1Bju72QbXGn9caLtK+fbCn3B8owN7biDk/HG5e2KIz78z/HeV+QvGaewxawbx71+1eqsrxvXuyn6qxcrqFWeAxDvuO3Hu3+rHK9Ckks9bxr3JdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a4y1j3f/kpg/M064o1PUDMk9u2Kp7zYwGgu9j9cwf8=;
 b=oOFTmLkX2A2P+4KdiB1sGvdGHeDNhqkcXx4b7M8KQuOjZLToni67SjrHTvjXAUskxSKzmXmaK2pDzTZA2HEaLFbKZeTAyv9eUjQAev8piaUcZ88iSyO1l/DvHLKtnjcvT0tSUpc5pKAC5mFczvZbCyoHXSCAvuJoW+rPS6X517l9wQZNY/B+Pn81XvLF4OXpZgZu/7xe6Cj0m9DILCHEHQEqvILnpoW9nMb5cNG7yEPU08keYtybXZwVz61mmHjxg61lNf03/nNz9fKTQTM4p4UoW8Zij/3wpNCCJJTUP0RYov7lK19v+4wz9ScDCunSdMeBXIiKbzr2TOYYFIOE4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a4y1j3f/kpg/M064o1PUDMk9u2Kp7zYwGgu9j9cwf8=;
 b=JXZPB5Qh5I7HPoIfe133ITVBUwNww7RRtQvLLFBnqXWy9NfbMgXcvT4oUMeYdLowbWlr1jCV4dIbdXdugVi28FhATuGVGS7CghPqpFjhALxIcqDsDdbDIEqkXBpPoNtWmNxBK7HWTSfzlybmrwz/FCDrIv+fgQdGX+sc+7hsHyI=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM5PR1101MB2156.namprd11.prod.outlook.com (2603:10b6:4:51::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Tue, 19 Jul
 2022 07:58:43 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:58:43 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 3/3] ARM: dts: lan966x: Enable network driver on pcb8291
Thread-Topic: [PATCH 3/3] ARM: dts: lan966x: Enable network driver on pcb8291
Thread-Index: AQHYm0VdtS3HYTtkbUuF7QbNK8FZfg==
Date:   Tue, 19 Jul 2022 07:58:43 +0000
Message-ID: <cfbe269b-998d-018a-2de9-824ef309301e@microchip.com>
References: <20220718212921.1506984-1-horatiu.vultur@microchip.com>
 <20220718212921.1506984-4-horatiu.vultur@microchip.com>
In-Reply-To: <20220718212921.1506984-4-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc90de5b-52c9-4687-9ca2-08da695c8025
x-ms-traffictypediagnostic: DM5PR1101MB2156:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Thd6h0KDPOj9uE53+gFiRU13Cty3Ely4YY7nsVUrD0yYsOF/JOLuZESy+7uNlrusmrVnQWh2ox1SiJ0OvDWZueu3f8OUZe75/4COKsvltI8L681DkQta8qRtq9pBuVcIGkTNOo4ntZFMFM7iTySSdksnYDzd8+ofNCL2NVDXkLk351+SyAB9hgcKa1cxIE/p967h8QEOuJDOuFU6oM21ouM92nSIkf/h8hzyLIDxag3/+wlwP9z2wA+jd7pezqQtm71yvCd33nGOXWSdE1HnK154VVpHP8tOlHvucUn7cT9Dr3uUTq/i7SlLGHdTlb28Y1sFgJv+bh5iOhT5DmjrFtofWpOu1jR5wKkJgeMFns86q23FKBS/pkgFQf3CNNWDUhsOZzDvmCXSD2KzZFOQXhCf6gvkubLh7FKbzA9bwVUVFPgYlVytS7BaAS00ac043K+derGsvrjtRGSuqSoQSRbrv7acpE7dbX2Wyaw1eV26BkaWXaTDaRo3ot1ervo4w6X6KKnYn4jsf+3+sdifgiulDSLP0HkyNLTPAa+kfA7rXqvvmTrJI1P//OnQRJYRtVTeukjlBb6d7wfc4VUbaTFFxiS5lyhYHzyFO0+3KXjFCZeI8PPLD+nFvNn5CS6frtOjmlslkEs6SIdUk+DP156TLettJfbjoGdYXcuphXd343Dsf6RCNTNP0BNenwCWvAWRtlLltpYLYezLXm9G8aEIc1ZCAHqDTZ845ukyKTlMuDNHhhh1f7HCZUFz8wwvXId5kyknUNfrrOGeD+lBBWlKk/x2KAdT5VI46q7Xui1CKSgBYuElw2OcDvZne0JB+IqK+X4qrtkdcupFTVvVCGQqiMK6gbN36heCSTmaPMXXNdlMJ2jJv9d9Fd7rol4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(346002)(366004)(396003)(39860400002)(4326008)(8676002)(76116006)(66946007)(66556008)(8936002)(64756008)(66446008)(66476007)(316002)(38070700005)(54906003)(122000001)(86362001)(110136005)(31686004)(38100700002)(36756003)(2906002)(91956017)(186003)(26005)(6486002)(5660300002)(53546011)(6506007)(41300700001)(71200400001)(478600001)(31696002)(2616005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkhGRGx0VjRKZjFZbk8wVTRCUEllZ3hSd3pXTXBoQjN6bUkzdWxEa2JxRThp?=
 =?utf-8?B?azlMYXRXQ1pnNjFPMVl0NzRwekJMVGRhWFRUdUd0NVd1VWhndjNIWnVnaURF?=
 =?utf-8?B?NmRuNFd4eXVmVnRudDkwMjBBbU9lekIrUEtFdXpybGpsZlZGTXVaOWRIWVRD?=
 =?utf-8?B?SnRYTVdoWG9kd0ppSXVldGljS3dDMUNkRDRCYUZCbzV2R2pENUQwK1B2K2pE?=
 =?utf-8?B?RlVsMEpyYkgyMzRsWHZ3VElvWlZOTVlUSEFhMWZyZnd5bE12QnVPeFM5bFlH?=
 =?utf-8?B?Q3lVKzY2M3pQM0NQbFVWWjhjd2crMTZ3cXh0RjRqTFpKUVo1MzRWb3J5S1Rh?=
 =?utf-8?B?TXA4ZE9lbHZVTGhIRVdBRzhxUjhRUkNUZHRKQkZocG1QWkMwcFdMMTBYUzU4?=
 =?utf-8?B?WnFHSE1teGIzSWxzbVhnZHl3K29mTEEyVkl4a1dKMnZDTHRONkFYMWEvMnpZ?=
 =?utf-8?B?aTFOMjNQR3lnbXNXZnR6bW5xaCsrZHB4MEtJQmRWUTQxdmpsc2pWd1hQVmF2?=
 =?utf-8?B?djRPSllTbUJQWERCWFBLdkJTRVVKL05URjBuSXlLdkJMRlRQV3FUaGhvV2lF?=
 =?utf-8?B?WHc4V1N6dCtncjdVZldTaGdUYUZZb1pNRXZNYnhadmVTQkZpTU92ZTBrenJ6?=
 =?utf-8?B?OFU0ZkYxSStjQnNKc3hON052ekJLcE13enhibUtnM2VRMHNzTGFNNmx1SGN5?=
 =?utf-8?B?eFFLMWUwMEVPMXh2UmNoSjJBU2ZweWV2M24zUGE1TW9ZbWNscTFDUjk0VTl4?=
 =?utf-8?B?dENsSVA1emdHaHVmSzZNQ0NzNXZjSElhMEd3eVBxNUQxYjQ1MDNDSkNOTGNR?=
 =?utf-8?B?NGlFbk9hdTAzdU1IajhtUFVLamFsdXB2RDJHeE82UkhrZEJoa1QzSzZFSGF3?=
 =?utf-8?B?c1JxdkVMY3VUUjhHR2tqUUp2aTgrTlVvSExIa3V3ZVJ3cjZBSDZkR0E4ZjFX?=
 =?utf-8?B?WG0zQmYwU3pWK3Q5U3NFdUZ1NCsyazYwRlErZ3R2azBJMVBCaW00YUhWdlBV?=
 =?utf-8?B?WEdNT1RKREgxcFE0QUFSRVFWT3MzWVBvSFJ4aFI3Qk1Lc29RbG1kNnJKQmZz?=
 =?utf-8?B?NjdpaTFhWE52NUdmdFN4WlJ6V21BUjdjWW5PVEd4L1JGem1idzhrbzUrOUcy?=
 =?utf-8?B?NnZnV0Zxc0dKSmg5Q3J1SnhhN2VjRVhiN0FFTU5BN2ZCVzhlL3NYbEhnYWZE?=
 =?utf-8?B?TGNRano2Ym5uUjR2NERpRWx5cmRpTng3c044NSswQUdzV21SbmZrSHEzOVZi?=
 =?utf-8?B?dVE2bHNycVlaek9zV2FOOENnV2VyVzN1d2JiVFV1ekg0ZStTWDNVekNBUFpx?=
 =?utf-8?B?MGgxVldoeHdGbjg4Ty9oN1RONk5TVWQrTjltcGFBRU9yaHFzZkpPTVRaTWE2?=
 =?utf-8?B?UmJkR1Z5R28xVEFJVVhTYllzOWxDOHh4MGs4ai9yOEtiZklra0Zzd3F0Nm5u?=
 =?utf-8?B?NDZySmxJRi8xa2Y3RHBuYXdlT0MrMWE5RFAxVWswUUIzUjd5SnNGWkVTSy9l?=
 =?utf-8?B?enJ0OHRNY09xUVdpUHNFR1gyWXl0Z1NzVC9jOHlMcEJXNGE0MXo4eTFsWEEz?=
 =?utf-8?B?a3BUWGY2QnFYSkVSWGR0M29kSFJBb2lyZkVJWHB4OG5aNHdFVjd3eHppdHNN?=
 =?utf-8?B?MGJjbU9LZ3N4eDVvU0laVHZIelNjV2prWmV4MXJmVVdkWWNiUUVBcm5iRklN?=
 =?utf-8?B?NTJzeVlqaTVRaGU5OFUxQ2pVZzRrZGxwOUZybjBOVWwrUGVNMktiRkhSRUUw?=
 =?utf-8?B?MTNEZmdDN1U2Zk9xNkJ3ZWtvNTV2TGdjNGpmaEo3YlAwbEtkMkU4VU9LQVRD?=
 =?utf-8?B?cFM4VTIwUENPdkpLR05ocVc1NWwyeXdzMDJXM2xyN2hiZUxzbk9GVjlMMnpF?=
 =?utf-8?B?SVc0QTBXeWpuV3JQbDcrTHJCSUR6VjRpVVpNWWdFcUJZaG5tQmVlazJkQmdL?=
 =?utf-8?B?ZmhydDFwZjNiYk1nZkU0QWROOFVxWVNzY0VNK0VPa2RLNHg2U1MyT25RMlly?=
 =?utf-8?B?azNvTkNwZmZjRTBqdXl6em1JM0x2dG1SZVRSSVU5NU8rSGt6VTRESGJFNEJn?=
 =?utf-8?B?enRxYXZxU2hTMTVDWHcvdkJ1Nkpaa2g2ajVZV0FYZFJjN3B1eUZYcEV3Njdl?=
 =?utf-8?B?TU5kMFJyYXJ4azFNS2JCakRKZ0k0WnNDWmt5QVd4OUVkTHNvVzZxSjY5SzZo?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DFDC436C2F8864CA3736E151BF95535@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc90de5b-52c9-4687-9ca2-08da695c8025
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 07:58:43.4046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xN3JYSEVrhdk9B3XzKwDgYPsDUVQEB1gU+B4YTojp8Cme5Q7lo1gtpUPQflI/KXQDwD0GJgoruCyUX9dzMuRdOecMD8Gc0e4xx2T37TG8AE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2156
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMDcuMjAyMiAwMDoyOSwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+IFRoZSBwY2I4Mjkx
IGhhcyAyIHBvcnRzIHRoYXQgYXJlIGNvbm5lY3RlZCB0byB0aGUgaW50ZXJuYWwgcG9ydHMgb2Yg
dGhlDQo+IHN3aXRjaC4gRW5hYmxlIHRoZW0gaW4gRFQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBI
b3JhdGl1IFZ1bHR1ciA8aG9yYXRpdS52dWx0dXJAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBh
cmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRzIHwgMzUgKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODI5MS5kdHMgYi9hcmNo
L2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRzDQo+IGluZGV4IDJjYjUzMmFhMzNmMC4u
ZDg5MGU2ZmNkYmFlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBj
YjgyOTEuZHRzDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODI5MS5kdHMN
Cj4gQEAgLTQsNiArNCw3IEBADQo+ICAgKi8NCj4gIC9kdHMtdjEvOw0KPiAgI2luY2x1ZGUgImxh
bjk2NnguZHRzaSINCj4gKyNpbmNsdWRlICJkdC1iaW5kaW5ncy9waHkvcGh5LWxhbjk2Nngtc2Vy
ZGVzLmgiDQo+ICANCj4gIC8gew0KPiAgCW1vZGVsID0gIk1pY3JvY2hpcCBFVkIgLSBMQU45NjYy
IjsNCj4gQEAgLTMyLDYgKzMzLDQwIEBAIGZjM19iX3BpbnM6IGZjMy1iLXBpbnMgew0KPiAgCX07
DQo+ICB9Ow0KPiAgDQo+ICsmbWRpbzEgew0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gK307DQo+
ICsNCj4gKyZwaHkwIHsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICsmcGh5
MSB7DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnN3aXRjaCB7DQo+ICsJ
c3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnNlcmRlcyB7DQo+ICsJc3RhdHVzID0g
Im9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnBvcnQwIHsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+
ICsJcGh5LWhhbmRsZSA9IDwmcGh5MD47DQo+ICsJcGh5LW1vZGUgPSAiZ21paSI7DQo+ICsJcGh5
cyA9IDwmc2VyZGVzIDAgQ1UoMCk+Ow0KPiArfTsNCj4gKw0KPiArJnBvcnQxIHsNCj4gKwlzdGF0
dXMgPSAib2theSI7DQo+ICsJcGh5LWhhbmRsZSA9IDwmcGh5MT47DQo+ICsJcGh5LW1vZGUgPSAi
Z21paSI7DQo+ICsJcGh5cyA9IDwmc2VyZGVzIDEgQ1UoMSk+Ow0KPiArfTsNCj4gKw0KDQpBbHRo
b3VnaCBncGlvIG5vZGUgaXMgbm90IHBsYWNlcyB3aGVyZSBpdCBzaG91bGQgYmUgd2UgdGVuZCB0
byBrZWVwIGFsbCB0aGUNCm5vZGVzIHNvcnRlZCBhbHBoYWJldGljYWxseS4gQ291bGQgeW91IHBs
YWNlIGZvbGxvdyB0aGlzIHJ1bGUgZm9yIHRoZXNlIG5ldw0Kbm9kZXM/DQoNClRoYW5rIHlvdSwN
CkNsYXVkaXUgQmV6bmVhDQoNCj4gICZmbHgzIHsNCj4gIAlhdG1lbCxmbGV4Y29tLW1vZGUgPSA8
QVRNRUxfRkxFWENPTV9NT0RFX1VTQVJUPjsNCj4gIAlzdGF0dXMgPSAib2theSI7DQoNCg==
