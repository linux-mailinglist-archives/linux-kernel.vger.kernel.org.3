Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5753B56475A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiGCNI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 09:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiGCNI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 09:08:58 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E70562FD;
        Sun,  3 Jul 2022 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656853736; x=1688389736;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=dsUbN/hhR7mN56d4+AOn03vA63z8qAd9mUN7W820Ik4=;
  b=TvXPJR+MwKTR1i4dCnBLaurxXAb53PzM+hRboUf5f2ebkQqxcUpTCc5F
   6xUUOh/SyJHwGohMnOd+URGBM34l815wDYZxjTnJJEbxmJH7xava35Ys/
   k7U6apBT2PLl4MfB9ey5j2gAP6ub/gNpmjF+3Quhdk9qSjbopiX0cctVq
   DUdZrDSLOS5ANYYKLryb4Ua9/PEKPMG415igFekH6IKvcK72z0rx3dxiR
   Tz4YB1BP+TZScpsu4TeOo9tJhupTdkoZC0ZXFEUmchH37Q6DMI0xFhrhk
   jwKJ/dhQXCECvlXTlIpq1cXe+xdHAhGvJBfqxvuLOdpAZ91omZd3OzPFh
   g==;
X-IronPort-AV: E=Sophos;i="5.92,241,1650902400"; 
   d="scan'208";a="309017274"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2022 21:08:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUVlKEzNCoRHiju+SaGBDGQS6DEzA1/8Yos5KuYZ9IaQRmh8oxk7P1KuEUiFAvsvDUxEAeQwZv8UMIJAPKZm/UkKT0ID+DTOiTDymv4P/W0smUuC8xdnt3Qr1bazEMYYAHV6FM4lPUyOc00Rznw6rMi5BpomeK7U+ie1VIFjJq13btfIMkVbd9uQsPwr3H/IxylYghetOsTuO7foYn41ZdQGv/DuwyL1HrgzQeKxqZwe7dEfJnWWM4YbF40tPend0FnKO/jVlOjFpwpPibUMQEiaafUAT6HxRYrBQqzqeTVFml7a96FIQ8x7sI3odbu4PCzM5c3Vi/YAwhnD2154IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsUbN/hhR7mN56d4+AOn03vA63z8qAd9mUN7W820Ik4=;
 b=IPuR3IlQdlqehAsCyPkXbWTfuO6/4vqxk50X5RVEQcvj+f9o0xo0DPv2/B5q3Fz3myowHQmdcWt/VKk67thevDS2JEOImSCBsGkvrA0atDTT9kQETVnK4PV4c4NWu79m0WTPO52MiCGunu4yK/KUAxAcSNWcUKLdlRmUEYxmfa3LquDTmYMug6EW15MHFgFOR9rVOrXYJbOeshxxvih8SzVN4YYjOoGUnHqMOIyWveVQJ+/6u02h33gZqi0QqK/KcGeM5js/A+h8FWT1eHFsKCA415QaHdmHmxP8Ky4MrxNN/noaw+MxtpFLNd9nnU7nfW9a6N2Q3VKi3dz+KHBBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsUbN/hhR7mN56d4+AOn03vA63z8qAd9mUN7W820Ik4=;
 b=rYFfsXZi8WfJZpYtAhJBMMKDHWJ76ZXE51j0/fdWyfnF2MwtqOe+7oHLT56FSIRqTFfUcQBAwaOJRJPTo6LxstrMRoNDYWpu2XIp5Q6MaKgq10UQZGr+qVKGl/sXJHbFeGs50bLbFuVy3GifM6sKGG1hVLE2f6Tkp6PerTZXZB8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7834.namprd04.prod.outlook.com (2603:10b6:510:d6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Sun, 3 Jul 2022 13:08:52 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%9]) with mapi id 15.20.5395.020; Sun, 3 Jul 2022
 13:08:52 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "j-young.choi@samsung.com" <j-young.choi@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] scsi: ufs: wb: Add Manual Flush sysfs
Thread-Topic: [PATCH v3 2/2] scsi: ufs: wb: Add Manual Flush sysfs
Thread-Index: AQHYjR7vQc9yCrLVOECzRQejBkGrnq1soYvQ
Date:   Sun, 3 Jul 2022 13:08:52 +0000
Message-ID: <DM6PR04MB65759980842FAB4A3C7D013BFCBF9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95@epcms2p4>
        <CGME20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95@epcms2p8>
 <20220701074814epcms2p8bfb6c00d7364aa704e2d6e60088e6a22@epcms2p8>
In-Reply-To: <20220701074814epcms2p8bfb6c00d7364aa704e2d6e60088e6a22@epcms2p8>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f7f5774-1310-4d8b-ec26-08da5cf52d2a
x-ms-traffictypediagnostic: PH0PR04MB7834:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HsKWH23xu6hkMYq/BuYQhFI5d3HCfSDeS8FRI60f4ifmMdnCU1v38kl6S8HBaM8yvDZsFUNdyvhQVceZN7jKwdoMNLfkTD7G8mLFRRQ94FyqyMyIw9j8j3SRRuoXzyXaFRul+kNdujsdYapxFNyBAtVFLtaiDuN/VwzWnkqoi+0ApV7KLtn/ahry2cIetuPBW3gYCpOetHPvl5oQaDKCSoQE8m9FpBJenpCbaooRjrVMd7YE2dX/Cn8aXtmCS0vAX0pFvM0DrlcGCE+z30hZrU0J5P6e6g2+A25kiJ2tbuAqJioheblopTz+pOhVWPoX2xFw8xNQ2gdSOEOdJPOP/8p09uXG0f+jOU2K4KYcXDHCjNMaeUsHQhn1GIsnHxkIUEVFy3dfjrrfPWvdGatcvZebPUdvPA60RYR7TgKkuv4I4JwvWdjbSpb6MH+RM2hxP/dC37byCJXmzZy2vZyWGEuHFg3Y4ae6lC9qLDEUM224rhnHsIjRthLVz3d+W06XsV/8aJoqnPX1yi8L3geYQKIPsg17egRqgx6OV86bhns7YpuW0m3d4V3pA3VIFWWcDpJ87Ry31ZI9wB5t5iutqI4etShpE1b5lVX5/V8pchaJ2mMqXffiB39Ler/NwJNwG5L5cJUyxUwwVYYvgMNj/jjYgasGYh/GUywBMoOEJ0ix+8+5JyBD2kUvucUwdkjnR5VW8JqAMF9GapwEPgbUIpud/BRnlqeiqXN6HL/JZK9dOeMtnD4HjFyt8D9k7HoZlXyVGKNtKmjPQRwB0ytbH92cWPNTR/3JPAiNKVUoR2kQ3qiL2WknsoduBCYxDc8v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(7696005)(6506007)(55016003)(110136005)(41300700001)(2906002)(26005)(9686003)(186003)(66476007)(66446008)(38100700002)(316002)(66556008)(66946007)(76116006)(8676002)(122000001)(4744005)(82960400001)(64756008)(38070700005)(86362001)(71200400001)(5660300002)(52536014)(8936002)(33656002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qmc5UXRVaENvcm03anQ2Uk9JK2w5NVpYQXQ5MXRjY240c09ZQWJ2NDNYMzZa?=
 =?utf-8?B?Vy9id3JLN0hRRlJFa0NJOUR6QW83WkdabzZweVBWdmg0Rkk4R1MvMzY1dDJm?=
 =?utf-8?B?ZGdWSlIvdXFHWHNBcW5DdlZOQkJST0EzbTVMT0VCekoyTjBvZE9UUlNDMTYy?=
 =?utf-8?B?SkJtUXZJREMvOWhMdXlEY2RtcE55RFFGbitRa2hBQ2UrUms0MjQ2a3E3dDFq?=
 =?utf-8?B?U1lkL2xMdmNpb1VKVFlDWHlBcmdwdWNaY1pWWFdhZGxrNjhsdzkrbElrSXhh?=
 =?utf-8?B?S2d0bkczK1ltbTlQbFQyc0FHRkVmTVJIZmZSd2RsbEZOb1UxYmJmM2haMVJS?=
 =?utf-8?B?SjdtdnZhOUw1Y2pHenl5c0hzRDExdDZwNVFXSTV2bEVacGRYbWE3c2FDQkoz?=
 =?utf-8?B?Tk5kR1owREh5a2lIbEdNQWlVRHFqL2JYRGpLSnZ5MC9HS0tqMlVqY1lyMlk1?=
 =?utf-8?B?ZFU2QW5rdTNpbVZZQ0F6dFQ4SkNDb0tpRmpBc1dDNmYzZjdFOHhNb3BaOUhD?=
 =?utf-8?B?NHZ4VDJzWFFJTVJVSGRYRDFrVXJTL215ekpjSm1TcVJ5ZlUyeE5ZcVZ6NW1O?=
 =?utf-8?B?OGphbmFXU1N6ckdvUW1yV0RCRlZINXpWQlV4VlQ1MW9DUVFVajZpL1h4WUcx?=
 =?utf-8?B?cEVOemJOTnRjeHIzWWJZd3FJVnFHM0tET3huSU5rMHYxKzljRDdIMGNYdU1v?=
 =?utf-8?B?ejQ1YXRSa3hmSm5GeU5QeE9NcDhIbzZtclJiaDBZNnQ2ekE5OW1DaXIwb2JC?=
 =?utf-8?B?NWdvb2pXdk1DS1JXaEo5TXZpY001MlBMMGRrSWg3Tkh3ZDRBdGNZSEVKdnpS?=
 =?utf-8?B?dUY1ckdKRGdFN0xmNmV1N1EzRjBTb1N0OU5pR1dVWGppMWJYcHh4V1BoZzNw?=
 =?utf-8?B?T3NMWklTNnpJcXF5alBUcWF3RHowN3V5OWJDOVh1ektXUm1qd3BZUURxQXZI?=
 =?utf-8?B?VERwWHZXanZqcmI2ejhjSmxPa3luWUg3OWUyWWpMbGpZYVc5MS9ybEtZTndS?=
 =?utf-8?B?MDU3Q3lGZDJsSnFiSzNmUG9DSkhvMk82Sm5Nb2hhLzllVVp3Z0x3V3ZCUHZX?=
 =?utf-8?B?dXM5ZDlGdDNaR3pHM1hmVzNhdVhLc0ZuRFVkNlhjSDlWZmhrVGIzTThHY1kz?=
 =?utf-8?B?VThvNlNYdXpMRXJqY2pwRjVNd0Q3RW5pOHFoTG1ieVpYclZxdi82M0IvUmR1?=
 =?utf-8?B?WHJaeENmOUg1WHBESTBmQXlob2tPQmdUTElQTjRyWkRQNnhOR2VUUytHNElz?=
 =?utf-8?B?c2J5ekJ2OVllc0dxdzFMemN4UnlBYTVTVW9FTlF2MEVXZHVDR1B4SXNTUXpK?=
 =?utf-8?B?NmtIVktVU21RYWRudzVRVUcvUWliNHpnajArT01oWlh4Z0tmejNhOTkvTFJ0?=
 =?utf-8?B?WFhiQ2E5VHlQeXJaaUlPVjNTRnJ6WHgxRWFhUFB6WlF4cW51dHJmbXpsdVRw?=
 =?utf-8?B?cUFWNGtSZ3N5a0JQbkN6ajNmVTVJTUhtYTBnQUN3ZTltZUdoeG1hbUZmNXdL?=
 =?utf-8?B?dGU0RHZEUW9uTEh0MVVlSnZzV2FnN1IvVWxwZVZzd3pCd291SHEzOXA0V2pH?=
 =?utf-8?B?K2t6ajlDcDhzMzdtZ3lSdFVqdnlvRUJlZnk2Y1E0ZVc5cm5qVXdxa2xxd3ZK?=
 =?utf-8?B?WG41V2RWUVBXcllwQXhkblZjS1pnaURURmxFR0d3VUlEVEdzVG9aaUs3MTVB?=
 =?utf-8?B?bVZwK0thZTVMZmp6S3ZsZVFSY3d5ZDNXOEoyR2lqUGVMRWJFWXZqbW51c1lF?=
 =?utf-8?B?RElzM2FyTmU5RnZXMlRobEtoTEE3UW9GZ1hiWHZSUW5IREozNXYzTDllaGtV?=
 =?utf-8?B?RGh6WGhndWx2SnR1eHdjVmo5WUZwU1RnZ1NxUktvZ25DVGNVVUJvSWpSWkpV?=
 =?utf-8?B?R3ZDY2lNSEttWkxnK0JsUXNmanlQRSttWWtBZGJteEppeHhFS0Q5a3ZHcUd2?=
 =?utf-8?B?a1UvTERtaFQ2eldxaWxYMGVWOENLeWgybCs5TUVYSjN3VVFkS3RONXVJUlJP?=
 =?utf-8?B?RDJGSVpxZFc1Yk1wQUdjM05mSW1pSC90RFpiQlJreUIzUlhxV3NVOVJNMXdQ?=
 =?utf-8?B?Z09EMEpNbTM3aW8xbng1WUdPMmdFQ1UvQU9vRDdpVDZZb2JrbUtpRjgvQWd5?=
 =?utf-8?Q?PW7PC8yJq890CkwBgjZN4yh68?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7f5774-1310-4d8b-ec26-08da5cf52d2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2022 13:08:52.0251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: geGpaJAW5FDc4kjSly+iUMqtJR/HL85tihc0ywgXPdnK6TI8N0DJr5yfiKcqUhj7nDObdPc2miywAwO0BUOlAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7834
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGVyZSBpcyB0aGUgZm9sbG93aW5nIHF1aXJrIHRvIGJ5cGFzcyAiV0IgTWFudWFsIEZsdXNo
IiBpbiBXcml0ZSBCb29zdGVyLg0KPiANCj4gICAgICAgICAtIFVGU0hDSV9RVUlSS19TS0lQX01B
TlVBTF9XQl9GTFVTSF9DVFJMDQo+IA0KPiBJZiB0aGlzIHF1aXJrIGlzIG5vdCBzZXQsIHRoZXJl
IGlzIG5vIGtub2IgdGhhdCBjYW4gY29udHJvbCAiV0IgTWFudWFsIEZsdXNoIi4NCj4gDQo+IFRo
ZXJlIGFyZSB0aHJlZSBmbGFncyB0aGF0IGNvbnRyb2wgV3JpdGUgQm9vc3RlciBGZWF0dXJlLg0K
PiAgICAgICAgIDEuIFdCIE9OL09GRg0KPiAgICAgICAgIDIuIFdCIEhpYmVybiBGbHVzaCBPTi9P
RkYNCj4gICAgICAgICAzLiBXQiBGbHVzaCBPTi9PRkYNCj4gDQo+IFRoZSBzeXNmcyB0aGF0IGNv
bnRyb2xzIHRoZSBXQiB3YXMgaW1wbGVtZW50ZWQuICgxKQ0KPiANCj4gSW4gdGhlIGNhc2Ugb2Yg
IkhpYmVybiBGbHVzaCIsIGl0IGlzIGFsd2F5cyBnb29kIHRvIHR1cm4gb24uDQo+IENvbnRyb2wg
bWF5IG5vdCBiZSByZXF1aXJlZC4gKDIpDQo+IA0KPiBGaW5hbGx5LCAiTWFudWFsIGZsdXNoIiBt
YXkgYmUgbmVjZXNzYXJ5IGJlY2F1c2UgdGhlIEF1dG8tSGliZXJuOCBpcyBub3QNCj4gc3VwcG9y
dGVkIGluIGEgc3BlY2lmaWMgZW52aXJvbm1lbnQuDQo+IFNvIHRoZSBzeXNmcyB0aGF0IGNvbnRy
b2xzIHRoaXMgaXMgbmVjZXNzYXJ5LiAoMykNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppbnlvdW5n
IENob2kgPGoteW91bmcuY2hvaUBzYW1zdW5nLmNvbT4NClJldmlld2VkLWJ5OiBBdnJpIEFsdG1h
biA8YXZyaS5hbHRtYW5Ad2RjLmNvbT4NCg0K
