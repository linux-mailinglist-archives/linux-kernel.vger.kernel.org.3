Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4D25A99B9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiIAOJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiIAOJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:09:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961C3263;
        Thu,  1 Sep 2022 07:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662041377; x=1693577377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LdjbKvFUQYEbkvW+xets7lmi8LjLc97P9E1aKkct+tw=;
  b=bmKv2pYaW4piQ/+vKY4R0f09iQIBj6K7yeqgKw+uCys6pPWxYIxB7RnP
   5CXdCFox6+L8bH+A5KUMIX8iptvh4U9SGaSK77uZCDIRGdBq3r6MrmXWV
   io7NwGc9brIm0FFFem1WOwUEroOccSKYBBgGjctPecYmV6syr9ktFwTIX
   GwiKCQNQCUNI2Sl6S93FnNzYYHNUzEefw4yTVptWaHmQHxDX//L5HoG/s
   8qIfjux+qbRevwIlrHn9WyQyA8uUCd5R5XBvSSfIzu8QGBx6VCpppXJRA
   cjdtlChN3YRbML9lrnz0SmzZs0RSiDLyz33UPkjz2NJBqltGgZOtQwVPt
   g==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="178777235"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 07:09:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 07:09:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Sep 2022 07:09:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctjRDjF9K/E8+4yMAImkBwQEtN0alH9nUckSiAzt3UiKmhHZLvyyMUWuxWMZuVvk/Si+xgPjqfHtnh+/JrlBgaL13SFnHMHzaF4Dyv/oTBy0vAXxqCucUWkrppVQFrNqjP8Kaf9eLm+4M4swtR/ZWdAOgd9x+EFOKINh/obp1zAwIfIcjAjY2VnV+dcrZVn6Dj+WUse8WRGengtt5R9oO1zgN/ofuh9BLykOgQRpBZSUytLp05co6dxbNHV77bjZGU2NS1k/HYMApwuHVxlsCZLkHj5vi8wuuLhYRWdOAdOazczW2MH7nlPhFqQUCHt2RCOuwSvdhoEBN+44Oq8DuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdjbKvFUQYEbkvW+xets7lmi8LjLc97P9E1aKkct+tw=;
 b=OR0iJfiit5CCiNJxcH+7sCCKO0HHkc/eMX28JhEocgfna2/WBK60FvxkTkLjFsu3T6Q8khOs5KRthc3R0PoMa4+Ac/dWsVpkblq1WTkP9SJS8fMM+L4qkUQKoj69e3REUBLlucq1WyKGQnR/iQg5oOyFqaY+P8CukGP8wbV8b2pAm17qRAwV4rNdm95Cslmpuwv3w3nrFOKiHZOjvSfFvWvzSsatXpZAc3l0vrIpnxlEUseoBz8FDAIPDqaf3lTv4amGE7MsoC5UqKJ8SgDpRc/31gIDaRS9pP6fOeZG2VlnKqmUMZ0f9QVI354ZThfld3pT/jJ+U35BF+BeBs6quQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdjbKvFUQYEbkvW+xets7lmi8LjLc97P9E1aKkct+tw=;
 b=JWayqo7yiLSmLc8ZRYHBOJiVO5keuHMl970F5mhWfhk6PE1Wf6Ze7FAAsVsV4GaUtv2YilHEKkLvce6Gpyp//teMVMztofsnSufmF8MJPIRcc2cIA0E2i1ZgoLuaP3riBJTqBTOWKe42VHfZRQPEKI61Icg7tfAvx9nWacwJjnU=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by PH0PR11MB5676.namprd11.prod.outlook.com (2603:10b6:510:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 14:09:26 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::8846:b62b:5a61:746f]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::8846:b62b:5a61:746f%7]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 14:09:25 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <geert@linux-m68k.org>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <andy.shevchenko@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <johan@kernel.org>,
        <wander@redhat.com>, <etremblay@distech-controls.com>,
        <macro@orcam.me.uk>, <jk@ozlabs.org>, <phil.edworthy@renesas.com>,
        <lukas@wunner.de>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add driver for
 the quad-uart function in the multi-function endpoint of pci1xxxx device.
Thread-Topic: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add driver
 for the quad-uart function in the multi-function endpoint of pci1xxxx device.
Thread-Index: AQHYvKr0eoJFropQtk+/08vGkycaWq3KnyrQ
Date:   Thu, 1 Sep 2022 14:09:25 +0000
Message-ID: <BN8PR11MB36681DAF0F396AA407323A0AE97B9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com>
 <20220830180054.1998296-2-kumaravel.thiagarajan@microchip.com>
 <CAMuHMdXePs4tE4xGT3uqe=Xrs4kr75BtUR2ueu8tJW+vx6WL0g@mail.gmail.com>
In-Reply-To: <CAMuHMdXePs4tE4xGT3uqe=Xrs4kr75BtUR2ueu8tJW+vx6WL0g@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3190b073-bc41-4531-b285-08da8c23938d
x-ms-traffictypediagnostic: PH0PR11MB5676:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yegc40mt9/oMXHCcPRfpbIjSGTvWFdMciHMOJoYMRkojT/HQ48wh1GcUWzNLpcksBFgnaTyI/B7foyxerWVy5IZolj/elwuK8EVl/AFr6JeVIM3tfypIZUuRTtJ3kqEF7gETtIRFKcFSt7p7/qjg73Xl/PUzLoAfueKix8L3WwuGep/xNEycW9IfdoaTTRY2Kyk2fhtOjPR8uadgF6DtHhaHsdQpuMK9QXtVlUTEg0vqKrFfNoVqgf8ZQ7Ss4kFGffzDrVkjy+k8C8zVhju7WqaoYkW1ezaET397FflpptFpal959ySOgErVTGFsntYg6CvwhE+6cpWuYaAQBag1QGu7+oyMFc8lnHlCaC/YxGZwR78cX6nprgx3ue5LJSjaJH5dgUmxPddMGHhTkYS8eC+60D1Y8Aw5GWytL4905UqjWjL/Ib4XxMTwWrw9FmPjde2UkBuHLt3QYF83vURWcdRIiKiaX9tzAU+gDn0pFRs1E0fABVtwyZsZkSvWzhS4GhV3kDtUyIz7e/iB2Deq1igMC8r/CC08qeCq08qqhMiokyb/ATkLx6A8UdE181xDgrLpE8ZE7wh87rhyZFWuSnWhJrOFjcQs3Eb/oC3K92B0HNNi7JRQORUCW6+r1rKVDZWS0EBnwB/LsWkDSzT44ktYlmSvyPDBXNL7/2eGEcMvdXWQ7SOuoCd9ASEG/wt/2JgNcgsUCJH8jDjFLhstmBm1+q4oygZKTUUQIzZ1ONMJ+PJb07DJhq4b0+QK2UEQePzqJ1QU371ckQ7cMI0OpZ31RqLYV0RCVl184hV2/Ui2KmD6Ifwd0OESAoqgDqtecAwcG+lXba8ErX2iTGm/mnxsrDzCJiqJJOcJc6kTYc8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(366004)(136003)(39860400002)(54906003)(66556008)(76116006)(64756008)(66476007)(66446008)(8676002)(66946007)(4326008)(478600001)(55016003)(71200400001)(316002)(6916009)(52536014)(8936002)(5660300002)(2906002)(7416002)(38100700002)(122000001)(33656002)(86362001)(38070700005)(41300700001)(7696005)(66574015)(186003)(6506007)(53546011)(107886003)(9686003)(26005)(83380400001)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RE15Y2xVRzVHSmc0U1QzQWF0RHdjTnptS0ZRdEk1VEdxZTRUUUdaNTdsVkdF?=
 =?utf-8?B?OWlFR3FMSWRNeWZMVG0ySVJ3UWo3RVBKejlXbkpsem1qWDA2NHN5MTlTQ2ds?=
 =?utf-8?B?bFJ3bTJjQzh1NFhLYzdIbzdwYlBoTTB2M2I5bFl3SDgwcHRvN1pCUmQ3QXRL?=
 =?utf-8?B?OHJ5dzVESjlFSElKck5IZGUwL3UyU3lmb0VHelBHOGd4V2FyMWh1WllrRGtU?=
 =?utf-8?B?OTBQdWY3dFhvazlVWXBUSnVnYXNSQjZselpPc1NGd1QwS1dmeW53aVI3U0JO?=
 =?utf-8?B?V0I0MTlyakgvVkVIOCtWYVk1WEI2S3NaWlM1cUIvUU1DZitDS3lFMnpmZ1lO?=
 =?utf-8?B?bHpCcUVjVzZFUjNsVy9yVE9lVHp0akI0d1ZyRnk2am1PN3VVcmoxaVErNnpp?=
 =?utf-8?B?VktueUhwTVpHZ09hNmFqdHc5WnVoaDU3bkYzVkNXeWJZbElidTJGTUFHbmd0?=
 =?utf-8?B?T3ZJajdpOFBzaklmRis5YmFxYUJFdEYxd2swL0ZqR24zenB1THAxUTZDWXE3?=
 =?utf-8?B?UFRGcTdZQisrU0NtZkFuNkNEUmlLL1lMYVJDeHhWSDgvYno0ZUZkS1l3ZFpv?=
 =?utf-8?B?MDAyY0prYiswMWw0T2x5bCtHYm56Q3l5eUtoRVdZSHo5YnhObmNyU0ZCWCsv?=
 =?utf-8?B?bm1IOHAzQUZJUWJjcEhqL2cvVEExd0RiK21WSlBxd0UzbnZIRVEyREROMVNR?=
 =?utf-8?B?dCt0eXRCMUkya29jaFc5TTJmUjFLcS9hNnl3ZTZxbXJnZzRXSFc0dUIvdVN2?=
 =?utf-8?B?YXlZdHJiTTYvdWY1UnRaRFgrdTYyYk5xZzVia0RSV210YnZQUkM4dS9YZ0Y2?=
 =?utf-8?B?czFta093ZENOL0dUSW12NnZvQ04vZlc4Zlp2TWRJNkc2R0poUmdYakhZVHAz?=
 =?utf-8?B?bE5XZ3dzVWF1OFBTd1dhenVEbHJqbUdjNlFxWFVZWmZMQ01CeWI4enVibUFW?=
 =?utf-8?B?a2NzR1k4SVJ1YVNLN013Mm1meDBZUFJEQXZWM3FwVnpyTHpKQlozcll4Qmsx?=
 =?utf-8?B?UUxBbDYwVHNwTXZwTUtHVnM5TjcvODNHRHF4K0NFTFRPRHVkaW5HcUJKZit0?=
 =?utf-8?B?bTlaRS9FeXNFckNWUHQ2Y09LY0hrcWR4ZHpWTnE2YlF3T0JHUjFxSDAySFRM?=
 =?utf-8?B?YVJBeEJvcWMyTlNuVWwvY2dtRm5ka2lncjUvWURET0xpbUU1QWZLNjlld1RP?=
 =?utf-8?B?VW50c05FZ2FZYWlaNzFBWXVWZmpzaUhWWTZ6eThTZ3lwSlQyRG5uZmxTM295?=
 =?utf-8?B?U0FuZ08xL1ZEVklBb1ZMS2IzU3hWMlMyUGQ2YXNQd3J5VTFobUwxOHRTekZn?=
 =?utf-8?B?RFFoSjhoaVVzZHoyWlJCOFh6YVRuL3BtK3VTSXQwZUNFUGUzbitGOXJXbjJN?=
 =?utf-8?B?Q0dqcm13eXJUWFc3R3NVSmdkUFFyV1AyakRIV0VGVzJ6MXFtZ1BOaXhoL0tv?=
 =?utf-8?B?Qmw2b2h6N25yQXBsdG0vSU9jU0Nsdkkycnc0NkpJYmY5UXFxc2tTV2VzQW1E?=
 =?utf-8?B?UWFadFM0bWdlMHdqT01XYmJubzhFa05YYmwrTC8wZ1lCQ3FacCtkVUdyT3B2?=
 =?utf-8?B?MHFveHJpbGhiak4rUU01QWdhRmVVUTJ6VXJNY3NxaDRUdWorWGRicXZLRlcy?=
 =?utf-8?B?T3MrMjk5UTVaaDAvZHpaMHJYeW1lZWNwSDJFaFdxZnAwb1pXWjFtVXVBcXMv?=
 =?utf-8?B?eGFtei9RNVBhVUhsNW1nWEVvRUV2bzdMRWJaMk1CdjNrbXZkWUkxWGt0L0tI?=
 =?utf-8?B?dlhDdlJ3aXVybGJhQU1Lazk0YVZlTDVJZGNaaUNDUkRjeFBveHN3Mmc2NXNa?=
 =?utf-8?B?ZFR4aThVYksvSVJrVVh5TGRQNFVHc3N5d0ZucUlqSm1mVGJ6UE11QldHV3ph?=
 =?utf-8?B?R01MYk5CQkdMV3N2bDR4R0pES3VlYTMvZGxtTk9yWnArUU8zVXR6UlRTZ01Z?=
 =?utf-8?B?d0E5SG5BWXVEc3FYZkg5Q2VqN0NnaGI2SFJYc3MvZS9ac2xxNlFhdjNJSmlY?=
 =?utf-8?B?TFE1S1BTUXFUMmhkSHRUZEZvTjd4bk05MjAvK3B2SVNkQkxrU2hna1l2aFJQ?=
 =?utf-8?B?TVFXbld4ZmVVd0pYOWNKTXJvMy8vbTlVcUpJbk0ydEZFM1d6NWRRRDBFVGl1?=
 =?utf-8?B?RjVtRnNKWkswb3BROXNCeWtkdjFLSDFaNU9JRFBkL2huMEdXN2dTRU1qcjFG?=
 =?utf-8?Q?dDxs0n5NrAqP4X6uEJhTTyE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3190b073-bc41-4531-b285-08da8c23938d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 14:09:25.3315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6q9BWnG6Ae9zvjybwYXmAKEifHYoObZi23hS0aRqV3igGWGdLmSPfo1CnpOnxesZRmQ39hq3teUQY2v6f9jLvcGgoWWy+SUnjD/QQRAIpJEJsGOAnnWYLswxhZXvBoHj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5676
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4g
PGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAzMSwgMjAy
MiAxOjI4IEFNDQo+IFRvOiBLdW1hcmF2ZWwgVGhpYWdhcmFqYW4gLSBJMjE0MTcgPEt1bWFyYXZl
bC5UaGlhZ2FyYWphbkBtaWNyb2NoaXAuY29tPg0KPiBDYzogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+OyBKaXJpIFNsYWJ5IDxqaXJpc2xhYnlAa2VybmVsLm9yZz47DQo+IEls
cG8gSmFydmluZW4gPGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPjsgQW5keSBTaGV2Y2hl
bmtvDQo+IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPjsgVXdlIEtsZWluZS1Lw7ZuaWcgPHUu
a2xlaW5lLQ0KPiBrb2VuaWdAcGVuZ3V0cm9uaXguZGU+OyBKb2hhbiBIb3ZvbGQgPGpvaGFuQGtl
cm5lbC5vcmc+Ow0KPiB3YW5kZXJAcmVkaGF0LmNvbTsgZXRyZW1ibGF5QGRpc3RlY2gtY29udHJv
bHMuY29tOyBNYWNpZWogVy4gUm96eWNraQ0KPiA8bWFjcm9Ab3JjYW0ubWUudWs+OyBKZXJlbXkg
S2VyciA8amtAb3psYWJzLm9yZz47IFBoaWwgRWR3b3J0aHkNCj4gPHBoaWwuZWR3b3J0aHlAcmVu
ZXNhcy5jb20+OyBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT47IExpbnV4DQo+IEtlcm5l
bCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuIGxpc3Q6
U0VSSUFMIERSSVZFUlMNCj4gPGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+OyBVTkdMaW51
eERyaXZlcg0KPiA8VU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MSB0dHktbmV4dCAxLzJdIDgyNTA6IG1pY3JvY2hpcDogcGNpMXh4eHg6IEFkZCBk
cml2ZXIgZm9yDQo+IHRoZSBxdWFkLXVhcnQgZnVuY3Rpb24gaW4gdGhlIG11bHRpLWZ1bmN0aW9u
IGVuZHBvaW50IG9mIHBjaTF4eHh4IGRldmljZS4NCj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlDQo+
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgS3VtYXJhdmVsLA0KPiANCj4gT24gVHVlLCBBdWcg
MzAsIDIwMjIgYXQgODowMSBQTSBLdW1hcmF2ZWwgVGhpYWdhcmFqYW4NCj4gPGt1bWFyYXZlbC50
aGlhZ2FyYWphbkBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gPiBwY2kxeHh4eCBpcyBhIFBDSWUg
c3dpdGNoIHdpdGggYSBtdWx0aS1mdW5jdGlvbiBlbmRwb2ludCBvbiBvbmUgb2YgaXRzDQo+ID4g
ZG93bnN0cmVhbSBwb3J0cy4gUXVhZC11YXJ0IGlzIG9uZSBvZiB0aGUgZnVuY3Rpb25zIGluIHRo
ZQ0KPiA+IG11bHRpLWZ1bmN0aW9uIGVuZHBvaW50LiBUaGlzIGRyaXZlciBsb2FkcyBmb3IgdGhl
IHF1YWQtdWFydCBhbmQNCj4gPiBlbnVtZXJhdGVzIHNpbmdsZSBvciBtdWx0aXBsZSBpbnN0YW5j
ZXMgb2YgdWFydCBiYXNlZCBvbiB0aGUgUENJZQ0KPiA+IHN1YnN5c3RlbSBkZXZpY2UgSUQuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLdW1hcmF2ZWwgVGhpYWdhcmFqYW4NCj4gPiA8a3VtYXJh
dmVsLnRoaWFnYXJhamFuQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0
Y2ghDQo+IA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwv
ODI1MC84MjUwX3BjaTF4eHh4LmMNCj4gDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcGNpX2RyaXZlciBw
Y2kxeHh4eF9wY2lfZHJpdmVyID0gew0KPiA+ICsgICAgICAgLm5hbWUgICAgICAgICAgID0gInBj
aTF4eHh4IHNlcmlhbCIsDQo+ID4gKyAgICAgICAucHJvYmUgICAgICAgICAgPSBwY2kxeHh4eF9z
ZXJpYWxfcHJvYmUsDQo+ID4gKyAgICAgICAucmVtb3ZlID0gcGNpMXh4eHhfc2VyaWFsX3JlbW92
ZSwNCj4gPiArICAgICAgIC5pZF90YWJsZSAgICAgICA9IHBjaTF4eHh4X3BjaV90YmwsDQo+ID4g
K307DQo+ID4gKw0KPiA+ICttb2R1bGVfcGNpX2RyaXZlcihwY2kxeHh4eF9wY2lfZHJpdmVyKTsN
Cj4gDQo+ID4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvS2NvbmZpZw0KPiA+ICsrKyBi
L2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwL0tjb25maWcNCj4gPiBAQCAtNTI4LDYgKzUyOCwxNSBA
QCBjb25maWcgU0VSSUFMXzgyNTBfVEVHUkENCj4gPiAgICAgICAgICAgU2VsZWN0IHRoaXMgb3B0
aW9uIGlmIHlvdSBoYXZlIG1hY2hpbmUgd2l0aCBhbiBOVklESUEgVGVncmEgU29DIGFuZA0KPiA+
ICAgICAgICAgICB3aXNoIHRvIGVuYWJsZSA4MjUwIHNlcmlhbCBkcml2ZXIgZm9yIHRoZSBUZWdy
YSBzZXJpYWwgaW50ZXJmYWNlcy4NCj4gPg0KPiA+ICtjb25maWcgU0VSSUFMXzgyNTBfUENJMVhY
WFgNCj4gPiArICAgICAgIHRyaXN0YXRlICJNaWNyb2NoaXAgODI1MCBiYXNlZCBzZXJpYWwgcG9y
dCINCj4gPiArICAgICAgIGRlcGVuZHMgb24gU0VSSUFMXzgyNTANCj4gDQo+IEFzIHRoaXMgaXMg
YSBQQ0kgZHJpdmVyLCBJIGd1ZXNzIGl0IHNob3VsZCBkZXBlbmQgb24gUENJICh8fCBDT01QSUxF
X1RFU1QpPw0KT2suIEkgd2lsbCByZXZpZXcgdGhpcyBhbmQgbW9kaWZ5IGFzIHJlcXVpcmVkLg0K
DQo+IA0KPiA+ICsgICAgICAgaGVscA0KPiA+ICsgICAgICAgIFNlbGVjdCB0aGlzIG9wdGlvbiBp
ZiB5b3UgaGF2ZSBhIHNldHVwIHdpdGggTWljcm9jaGlwIFBDSWUNCj4gPiArICAgICAgICBTd2l0
Y2ggd2l0aCBzZXJpYWwgcG9ydCBlbmFibGVkIGFuZCB3aXNoIHRvIGVuYWJsZSA4MjUwDQo+ID4g
KyAgICAgICAgc2VyaWFsIGRyaXZlciBmb3IgdGhlIHNlcmlhbCBpbnRlcmZhY2UuIFRoaXMgZHJp
dmVyIHN1cHBvcnQNCj4gPiArICAgICAgICB3aWxsIGVuc3VyZSB0byBzdXBwb3J0IGJhdWQgcmF0
ZXMgdXB0byAxLjVNcGJzLg0KPiANCg0KVGhhbmsgWW91Lg0KDQpSZWdhcmRzLA0KS3VtYXJhdmVs
DQo=
