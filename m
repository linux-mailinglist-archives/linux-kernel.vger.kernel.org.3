Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D1F576DDE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 14:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiGPMVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 08:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiGPMVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 08:21:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8E01D32C;
        Sat, 16 Jul 2022 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657974060; x=1689510060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MdUeCvCGExa51ndJKXSFw0O0Heb/dyPYYh1GNmcy4r8=;
  b=OqRv/HxnPIaN0gOaqDavsssxy6+J9WrDLeDt9686nbaKtFbNcTN092RW
   XQQIGlbpeoDwqI9Bfpf9Ve1uUDKX5ZypIWUNOC4ti9PqTqJXC5rzNogWi
   KBo2Od8pvmIVv04b3KmWJTlzSXry0lvCjI4m5uWgCp2rt7iaFiJbZra6b
   cfNXvA25tOvowKEJ1AF23nstt5N2Qk25bkqcLBj9On1oXdbdnEcAiWyTz
   VfYnEwdWbpfSubsfNX0uUD7bd+XkIOKuJMHqbKF47Cot/WAOC9eQicHDM
   iFQ8qUWBN3dATbaoSPC5wOKOM3PDIr7jn8r/iEs3kOqSbAL0QC4O88tr5
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="172392962"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2022 05:20:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 16 Jul 2022 05:20:59 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sat, 16 Jul 2022 05:20:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLZlHGEzG6Wp0T/2rD+4GcCiN3ZjeX5I7EwhpZHDiHbTDkr6KArNTxUS37jHF2+GXis06EySzS7DL7hYewP5i3MoUhTY2CNET5HFRmig2X+zDRulY/k85PLNlNrA1MGVYKG9DedlGuyAD7afqvZ9tUI3oFl/R6HcTgPyymQ7G1GEEV0oG/kX4Rz2aO4oiPQd77KTFFajXUsQjLdSvnsEqD4YNqRfroUIPdsw+mLcUX+mM5M8hMqHJWtJO7G5bx3aGu5zrW1DGv9TlTzx00VIcstDGf8MxsWxJ9aiVb48L+P2kavI8YFYP+xlGroriX1zEJwOo6miC/nzcV3+n+oK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdUeCvCGExa51ndJKXSFw0O0Heb/dyPYYh1GNmcy4r8=;
 b=hHmKoDMH0DaRazy5NzHUmjmTeBGkfvYzu6DXUG+hs3D2X3q2DBZMM+N77Fmz6arXuaf012sGNR1lEpwY9B6HP+jhZX7Ul53vr0ywE+22RURHpSgLj04RPGsK3Q46fcvsoHsHibNQDaTbcjnryGFHtKQTHHogv+dO2euJ24tiqn0AqNzUf5pulZ+JzsgB2VA7Fely13zMjl4V6SgDcPR15RSp6PQSdfXWCuK28LO2ISXb34uBuBso2HmULyMvGYnsXLntQiNXhSkS7kB0gCRTpwH6ao7U3le8UjPgPr1QF1wlapkuTxdHR/tRHAqab1VToHDiw4fA72nPB0AWPnFQiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdUeCvCGExa51ndJKXSFw0O0Heb/dyPYYh1GNmcy4r8=;
 b=UrOvqNu3fvegjGNCjFqvy15Fasy/pEZv3jeYHjcsX+mmSOxU8o6LjebgWLHaiYfK/y9Tc3b/VdRk0Gxtn3KlAzL8HS5tDygn2LHHHT+VjeVvi9QZSMjPNqr2ERO4Llvdx+CYofeBDJ/H8tA7thP1gMhg7zxqSJ0huoPj/XLF2Qw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1369.namprd11.prod.outlook.com (2603:10b6:3:c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Sat, 16 Jul 2022 12:20:53 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.021; Sat, 16 Jul 2022
 12:20:53 +0000
From:   <Conor.Dooley@microchip.com>
To:     <maz@kernel.org>, <Lewis.Hanly@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-kernel@vger.kernel.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v3 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Topic: [PATCH v3 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Index: AQHYmONENpwHvjgotEKXOSINBvKPca2A0EIAgAAa8gA=
Date:   Sat, 16 Jul 2022 12:20:53 +0000
Message-ID: <81f662a9-c820-9018-8dd7-f1f060ea0b54@microchip.com>
References: <20220716071113.1646887-1-lewis.hanly@microchip.com>
 <20220716071113.1646887-2-lewis.hanly@microchip.com>
 <87pmi549rp.wl-maz@kernel.org>
In-Reply-To: <87pmi549rp.wl-maz@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f3cea47-7c7e-4c3b-5b93-08da6725a0b6
x-ms-traffictypediagnostic: DM5PR11MB1369:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BmciQyMXIvpnHdBbkatEo5fbWyNNIlVfJDy3wqfiDs+Us0tfHnAH465xS2X9eBEfVM5rHjSypHg3lG2QQPd5dRN+WZ7CEARkwcYZI/C/JkvmK3gbnRqQdKtzEz93gueKWJ9YgfQjfiY4z8uVQOSxJqO+mxpxPhAJ22X257oWNGBg57VKd7KP9UC8X4Qpsf8SYtGGAjUbHe97bJLTUVFxaX1Palu0xm95P5sh+RSzKQGAfrckOYVaVXMeHDl+TPpQRvRoiijJekVf3eL0Vbajf1LJhoXaMrciY3919gMq3VUkgrt21FxsCZROiw7HCFaXlCAB5bMI10DuWSLgG8YdY8nHgbFOlelLIubLLmkNWYXxeByRJiSLbaaT4baQeqw6XISwAV88uQjCO8kONkgyxssHDDdbKXZ2kk5ijI/mAjXUYLIFdqIRvHgKEixqMrYRG+fHeAXg2UO9MWKa+BBW9MdcGmsDbe+s37ZuWeFRg9JkQMOx93Al6hFRzTVhHsf63snAO3395smcVRRz+icuU31K3YpfBD86KK0tyDuJtTtHN+/uupM4wlq/gaqY8nmin2QT9QRiY8bJZ/QoSHQv/oNO0sUaiN64nAQjom4fZnc8lwx+i84e9TV8nO1cQ7zj9nJDM0dBWlIk/evs3dadJ2pVVEjVpdtVIfjrTgK+TkF8fqSlAGAlTlFFqVANB5yQasE+QS5G0YkhHWR/60Yb2T4iqSOVv7jPqHWAwqtyj/wFdpiaDxpluDUnJOFZRoaVT9h00VSUe+mlX7JEgbPAd/qTzkqzIPtl444yLNkJegli5daZ+t1jCLEdmSB1oENj8MNV64PnSckuB/y9bFtJblscBbtwGta3KhS9KsKsvC/SC11K6Tk/gAhwlUFcJAIL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(396003)(366004)(346002)(39860400002)(71200400001)(54906003)(76116006)(4744005)(186003)(6506007)(478600001)(122000001)(66946007)(31686004)(5660300002)(66476007)(8676002)(38100700002)(6636002)(4326008)(91956017)(66556008)(66446008)(53546011)(38070700005)(36756003)(316002)(8936002)(64756008)(2616005)(107886003)(6512007)(86362001)(41300700001)(2906002)(26005)(110136005)(31696002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzFHbFZRNnU3WGEyeFdIQmE5YnhYMXU4M0laZ0E0MjZYemFhOTREOGpjWjRE?=
 =?utf-8?B?eVI0eVdNV2ZsSU1vVkc5KzJUMU9UWHFVeGM5QzdiWEMwS2xkT3drZDhVZjRU?=
 =?utf-8?B?Zko5dFJzQzVEa2hlNmNnRFd1d1hYT3BzWVE4R3c5dkhGejgwc09DTTdyVWNs?=
 =?utf-8?B?N0JFTFZSREkwVW10OEFqUEJGRS9rMkkxYlR3OXVPSjlqTUM0N2tWdmxFcE1F?=
 =?utf-8?B?NmYxT01OQVVrd0VsNWpYdGxZV3cyYWVkdy90U1JWQU5IRklhUm9ZdnkycDRU?=
 =?utf-8?B?NDdHQ1hNSG12TkdHc04xbElPaGNVMmc3UmNQU0w2RG5QVVFwdVoyYlhCcUtY?=
 =?utf-8?B?bW14NjgvWXFMbXVNNWlRbFpoWm0vdk9zMmtERE1rVk5veXlOQnkxbytOZ1NQ?=
 =?utf-8?B?N1JWaVRST0VSYnhSK25wU3VwZGIxaVdWak15YitXR0dZWEwrdWNwT3VESE5V?=
 =?utf-8?B?MnlZMDJrSXR2WU1PVVB6SDdGRnBiRjlZWnBZSmZHdS9Ldk5pQm9vcURBR0Ex?=
 =?utf-8?B?NTE1am51dFBhUVFMek5XSy9URnZRYlBCdXFlSGxIejZHUi9PVDYzaG13dm9w?=
 =?utf-8?B?NmpjcTE5d2lQNTAzYnQ4UzgrSUVBQTNGRDIydk5aWDFhY1hmU1RQK0tzcTRZ?=
 =?utf-8?B?YzFxL3Y1SUVuU0xuSU02ak1oSWlkdVNtRlU3K1VTRytlOE96NHNZYkNWV0hZ?=
 =?utf-8?B?UjN0YVBLeXlUVHByaFA5dk5kcTllN3gvSDZGMldYbU1DVjdjY013OVJEcncz?=
 =?utf-8?B?djZ6YWJRcy8xSDNTSGxORURjMkhiTE5JbGR2U1Y3d1VJUm82Q1JmNTViVnRu?=
 =?utf-8?B?Tyt4aUpPZ1ZQTE9HVTdsVUFmTGJNOVY5NVlUT3g5L2NSZ3JmZitYWGZ5WGVi?=
 =?utf-8?B?K2ZMZmVkd09LWHJleTZhZllsTGVDcnF0QjFpUlNQSkVxd0RSQUx6TC9XSXdD?=
 =?utf-8?B?ZGE5VFB6Mkc0OER5RFh0b2VFWElraUJpSy9aVkt4b05PbURQaXRNaFJSTE1U?=
 =?utf-8?B?RkhYQUtmMUhWZzRybGRtVElVcG83QU9NQ05QVTVQaDJNNDRHMWt2ZE1wby9k?=
 =?utf-8?B?UVplMEtZVTlpdXBIRlY4c3JIVXI4aGtDNElyVXdONnZ0MXdIeVBUeUR2dnkz?=
 =?utf-8?B?MENkY28vR2dicjNJK2pXZEV4QVNhT080K3ZTN3A1Wi9xbVRRTEc0bytNaGpp?=
 =?utf-8?B?WFBHaUc3SmVaUFhFODdVYTRkaDM5ZUpRTVdHeUVtNmdWUkRwVldQd1krWlJS?=
 =?utf-8?B?cEVXb1g0SUVZWHllZEllaGQ0SnY4TGVlLzFrYXFZMG5la3JqT1EzcGwvdEFI?=
 =?utf-8?B?Z2t0Q3hQTmZmUGdzZ0YxaXk1bFFHVmJieFNoNUdxYjAzRnN3dVFqN3Zwb2V2?=
 =?utf-8?B?UzA1eHpJbXlFUms5QWZLenZWMWtYcU52V1dWWktGZXFEelJ6L1l1SitpdTZz?=
 =?utf-8?B?a1Evc0RsN25kMXlld01lV3I1MEo4L2JNZmNnemE1VVRpKysxa01CMlpOUVJF?=
 =?utf-8?B?eHkyUWVSZ3VUQWRRVjNBR1FNN21adSt4NzZ2V0IzZENsRmtaY1lta0FCcEx6?=
 =?utf-8?B?YkkvZnRna2tkYWxGMGl3UDdFekRCT3MzMVJtWTFWNUp6d25yTCthRHhkUk1w?=
 =?utf-8?B?Q1QrNzcvVGsrQTk2ZU5pUnQzNWtxWE1BV080SjZwNDdPdU0wRlBaaHVybloy?=
 =?utf-8?B?VjFGSkVtYW8zejhxbTEvWnVpYnlPeGlhUzlMenVJM1RaVnpyVWViK1h1UERQ?=
 =?utf-8?B?cWo2L3QyRDZNa3k3YnM0bG1zWE5GYlB6ZWovVG9BU0w0akJWVkhTcVNpRllv?=
 =?utf-8?B?NHRlMXZaL0tIREVMYnl3NDZQczZJWjJIK0MzNHlNTVRET0Jnb2hUYi81cVVq?=
 =?utf-8?B?SDN5N1hMM01pQVZYcmFzVEVyQzgvNmJCV0dkb2VMdk9LVUkySFVnYThEVEdI?=
 =?utf-8?B?cE9zVDVzYkxuOHc5eTJqNDg2WGpiL3BKbjFNSE1yTk5TWXkybFRtQnpyNzND?=
 =?utf-8?B?WHpIOUMwemxwV1dsVEVNU3BxSmo3WUU0S1cyLzVnU0dmQVJOSnJjYjdSYVl0?=
 =?utf-8?B?ZE81OGkxNG5DTmRvaDNEQWhPakg3Z0E4ZExLWkNjL0FRclN0cFBSU1J1UFdu?=
 =?utf-8?Q?Wu5DqN2/CA35xmUrdCgMGO4FG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BAA5A679E95514CB8080F7A6C327BBE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3cea47-7c7e-4c3b-5b93-08da6725a0b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2022 12:20:53.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +QwQRJSCuSTE7bC+wFfJ5ubyOPlxjheshx+NJiF5bA2klLAAYYWrIrAqI4Pqyb2F2gNov1ncsvAE63ppzK3Sk4Aunz+Ng5r/AVrEAHJ5aoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1369
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDcvMjAyMiAxMTo0NCwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gQSBjb3VwbGUgb2Ygb3RoZXIgbml0czoNCj4gDQo+PiAr
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXBmc19vZl9pZHNbXSA9IHsNCj4+ICsg
ICAgIHsgLmNvbXBhdGlibGUgPSAibWljcm9jaGlwLG1wZnMtZ3BpbyIsIH0sDQo+IA0KPiBXaGVy
ZSBpcyB0aGUgRFQgYmluZGluZyBmb3IgdGhpcz8NCj4gDQoNClVwc3RyZWFtZWQgd2l0aCB0aGUg
ZGV2aWNlIHRyZWUgZW50cnkgaW4gNS4xODoNCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9ncGlvL21pY3JvY2hpcCxtcGZzLWdwaW8ueWFtbA0KDQpMZXdpczogbWlnaHQgYmUgd29y
dGggbWVudGlvbmluZyB0aGF0IGluIHlvdXIgY292ZXIgbGV0dGVycy4NCg0KVGhhbmtzLA0KQ29u
b3IuDQoNCg==
