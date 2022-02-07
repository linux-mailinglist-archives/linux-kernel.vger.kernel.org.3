Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0013E4ACB5D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbiBGVbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbiBGVbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:31:52 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3CDC06109E;
        Mon,  7 Feb 2022 13:31:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrpnwbU9h29O+0T+VjFWHD/yuiHg1JaEf3hWtFgBsVroDTUoV90mDJzmnmyofWDqa2B9++5bLTLRx80aF/8PicA92IMm5MuwwImbTPpBaw94IVMz9tmpC+RCEXReFN3yjubKFymBBxUfPpw+BRNiAQhVMBq6MzKs6ZeNCV24sNkYzuRcT+pIXs2SmRo17ySH7oR9gxq45qdCRhzzpIAYKEXFZH2QMrfL0lp1ggkVA+qQnOyEK4zFqgTZ/RhQIyg+mkPw4pDcHCSboXOYjIymehbvuYbOx6cLcGZ4txLxKt2z/KAdLC1Oe3gDVBGG7hUEFau6MFj4h+/T8dSHfesoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9noPkiQHytbWwbgqGSz272hiU7eCEDdWiMF3BowGacM=;
 b=RHe46uTVVWW/HTHrIEp0QiHkGHVUXF/R/dVirlAgo1fGNwFx/NhXR2vdj60I0v8DbVdt4Vi8WsPpgJ2ned/tZlp8eysMAF8UzvS89ncj4qYrN14lnwzwX7ShVNPh3PHoFloMmM0J4MmcZ7wsGx2Qxe7aHCnIGAYn0DarqrDxC1WrQGrnJ5JOB8/J2Ps8TMwHTSg1Br9EvKBpTkj/ukmkypV0Gzc4f3cFvYpvJoPjHGCswSkKiDWGxKgGiUOJaUBxjpOUZWTpn772yWDbqBOoYPowyrMm3crtzeML8+b3z0KfmW9EO3Ev6DU0fuXhSRFLpwG2bl0zMTLSLuVn0iVJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9noPkiQHytbWwbgqGSz272hiU7eCEDdWiMF3BowGacM=;
 b=KKLI9jtijOxMK9WMDQgytxyu+gaimYF9nfY9NExiI4Zs8kFxLKKj2+Vpwz4Hmoao9akWJQ9WrM0fW3XEs3gs7lF/r+WwX2S3XwNBuYUxVS1i/QSMtKfoYmYZTgy5xvOdn1YppesLIJLANSPAuBVCYH6OnolK3VnvhlHUQHgz+WA=
Received: from SJ0PR02MB8845.namprd02.prod.outlook.com (2603:10b6:a03:3d9::15)
 by DM6PR02MB5145.namprd02.prod.outlook.com (2603:10b6:5:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 21:31:47 +0000
Received: from SJ0PR02MB8845.namprd02.prod.outlook.com
 ([fe80::143d:2a92:4a65:8fa2]) by SJ0PR02MB8845.namprd02.prod.outlook.com
 ([fe80::143d:2a92:4a65:8fa2%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 21:31:47 +0000
From:   Sonal Santan <sonals@xilinx.com>
To:     Lizhi Hou <lizhih@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        Max Zhen <maxz@xilinx.com>, Yu Liu <yliu@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: RE: [PATCH V1 Create empty OF root 0/1] XRT Alveo driver
 infrastructure overview
Thread-Topic: [PATCH V1 Create empty OF root 0/1] XRT Alveo driver
 infrastructure overview
Thread-Index: AQHYEnhWGvk9dgcnykGkXpR8sLpuKax95k6AgArB4JA=
Date:   Mon, 7 Feb 2022 21:31:47 +0000
Message-ID: <SJ0PR02MB88458745494FFF5CF8576553BB2C9@SJ0PR02MB8845.namprd02.prod.outlook.com>
References: <20220126054807.492651-1-lizhi.hou@xilinx.com>
 <17d60142-c72f-1a11-45de-e9a2974abeb8@xilinx.com>
In-Reply-To: <17d60142-c72f-1a11-45de-e9a2974abeb8@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36269abf-fc22-40d1-fdea-08d9ea813ebb
x-ms-traffictypediagnostic: DM6PR02MB5145:EE_
x-microsoft-antispam-prvs: <DM6PR02MB51450EF46C980B7CD1ACB6D4BB2C9@DM6PR02MB5145.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xrVx96H6imatPBHTPsIH99ETfSxiKBiYtyAea0r3giWb8wxBS8orK1kztqnmatNEbRwfgWZtMiMRUxGLOY8vLbrbX4krtO3euOgDzaSjukcgyiMDb4+3sv9i5jDbelnmYgkbeEpPVTKaiUQGXqqGhlOLQabvn6yHd9zk2FoEOTkuMJZHipQ0ZMQu77nCXnLAjumuBElOvQ3nDkgG2yQWkUgZ5haS8+vprYmHAs92Ik8JXHqvUhMG6bL2nCAVpelGrxNBWCtmYyfKb7ulGbODgDEFR5AK4uKLGpkBa7lCPjW6nb6oYF/wBUG9T3t7N3xjAd7CtHtRoU+ZDQBv+S+NYoQlHOwB6bVXM1YMZlVDEPEeQRVYDgu+psY+PYbNy5NAVXss/OI/J8HhTxp0po6PYhU3M2Q/YfIGULOo73O1jjuuQEYAmY1gfh2Jb2i4CcLFbim0mgWppJ7lhmTJjrwe8jPS++sAygDbLInYlkFFlB6X4VK6IImabW/d1bDrUMt4B/QDdlEVTQf8VbHp90iTUvaUJMW7LMPypOXqaf3NNcVKMrtr4bw3Y5IqqLY7vU6AKGdVFQdxx/VxwPr4YBcdMtq1wGdvxHMgBeiqgfChPnClwny544Rh0JQeb8LLgEKRlQ7VfoUsPdbEqo8zStwun9QjFrn0YliqTP2zuPlGznWZfDz66P9VGF8ggP7A+ZqY5F+/RxFeWlVAKWmxl4rNOeqpQjSQhFFB+EQO2ZS3AREOLWdRWLzQmggBfAWBkx19e3GqN8ndHxo2VdOzr70TnD+Si8beNbd17CI53NM96AkpiQUyse8CAo2rp5w+4QVTOnLCm7dtK9bBxY42TE3p+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8845.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(83380400001)(38070700005)(54906003)(110136005)(316002)(52536014)(122000001)(86362001)(55016003)(9686003)(7696005)(6506007)(71200400001)(26005)(186003)(5660300002)(8936002)(966005)(508600001)(76116006)(66476007)(2906002)(33656002)(66556008)(66446008)(8676002)(66946007)(53546011)(64756008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFpoMUZkL3poaDE2RjYrbU1qQUo5V01qdXY0cnpOOVR5dHpjamVKQ1g4VW8z?=
 =?utf-8?B?anBuUEhodmxvYnQwRHc2YVdIck93Y2xnVFBzdWFjcmlBSkZ1SDRLR1gzeXhG?=
 =?utf-8?B?NGFLV29ZaEMrYnBEZUgxMkFoN3UxWUxISW9QS2Z6S1VZYitPTDZORDVVQzVi?=
 =?utf-8?B?UnMvejd4aHZadkNZclVSQ0lyV2pXUlZUd3RHdWtMVnVkNm5jaERkV3JMWXRj?=
 =?utf-8?B?ZlIxSmU1ZEJVR0F2aXRUR09BeEt3NVFJKzg0TDRtcS85OTF1VzJZQW9rOHds?=
 =?utf-8?B?Umttd0ZBNk9MenpXa3p5NStIeGVGTGNjUzVvRGU2elJGQjRYSkkvU1hacnZM?=
 =?utf-8?B?VjFRaWswMXRaRFI2dkwyaDd6VXBWNkgyejJMKzdNUmVqeWZiSlNsUnE3eU9l?=
 =?utf-8?B?cUVpeGVFcUY2eVdkK0NUbDRsM3Q0bjEzS0QwZTl0MkdQdGpHalNGZG5tWC9k?=
 =?utf-8?B?V2dUampLNEUycGc2S1JnSTFEaDV3MEFSUDZhVkhXYXJWZ2pYckNuRFFQeUYv?=
 =?utf-8?B?Nk1xcmpZVTRCSmlRQVo3NUR4dy9wanowbkFPcWNVSkFRSnZxRmgrZ0thS29p?=
 =?utf-8?B?NzRrdlY4RVFLdGRzM1JtNytaU2I2K0xzaFQzUmxTbEVNYnZCNFRmN2U2dnh1?=
 =?utf-8?B?U2NuQmFMcTRQbWMzZnhBQ21Fa3cwQS9OQ2pFSTBiZnFJRTN4R2pxbFhGZVlh?=
 =?utf-8?B?SmpSTDNaSEZvWi9oL2lnYytmNEF2bi83WnV1akZrNkkrTFMvemFpMXlKWTQ2?=
 =?utf-8?B?NUZSTGQ2Y04zTHFUdEF4VndyZjU0ZFZNWFpNQmZxaFlhU1NkK2JjQjZCQnFZ?=
 =?utf-8?B?MklsSnJYWjhwQ0xSUllBdWNOWWhETjFobDV1WFg0S0JIdlFPM0xHSS9LUkZV?=
 =?utf-8?B?NmpKNXNJZFBKV2hHRjd0bnVwMnhnS3ZQd25oMURjektmYlpOdjlRTUMyUENZ?=
 =?utf-8?B?MFVHRExkWFVNN214ak9qM3ZhTHlIMUhvQ2NjUm9FRVVJRUtCdUFFaTM5aXlr?=
 =?utf-8?B?bEF3eDN6c3FINGFDRDUrVzFSR0owMlkvOFZlVlZIb1ViUjZySXN1bEMyU0lY?=
 =?utf-8?B?TjVoOUVvTjBvdk5LbDdEc3hCYjFmRnBSY3doMnprMmc1WmNDMlR2akpQOUhT?=
 =?utf-8?B?SStuQmNDbklhcldCWmpYQ2t2c2N1R3JrdG5XcUVxdk9Od3NETS9JbncxeFZT?=
 =?utf-8?B?eTZXZkV6dFVyMjVFc2s0V1h1K0MzcVRRaEh6ZTRPczVSTE5PdHVuSEZyTzRN?=
 =?utf-8?B?dUJ4cmFvbEkyTGpib3MyNm1QV29ISEhPdCtXWTkwdy9YOHM4UUZkYjhrSStp?=
 =?utf-8?B?UEdiN3ZGNGNsaE1QNG5lTzR0VUVhdW1kZC9tK21nNThrVEYyNy9iV1FUbmhz?=
 =?utf-8?B?ajVyQ3V6QXFxTzJoRHo0b3JOOXNjUTFNQmQ4Y1E3TGFYSGtaV1VlZDNWbkRJ?=
 =?utf-8?B?eTRjT2phMDBkVGNsVThMRW0wNjhpUVZad0JRYjVNa05vaXhjNENUTlVlZ0hE?=
 =?utf-8?B?M2tQVUQ1THUyaUdsZGdiSUtYR0NTRFE3Nk92bSttK204dEdCRmF2RHZBUHhk?=
 =?utf-8?B?bjBvZWQvUHptUUxJWE1hYkdXcHEyRDAyaERPN0dVTDZtNDN2Z0R2L1dLWG5T?=
 =?utf-8?B?eXlTRWoyazF5Yll4cUxIL1hnMFN1ZDlpY0ZQK1NsUk80T3BMVmVPSlRrTk41?=
 =?utf-8?B?L0hPcm9LQmtITjNnYlh0M2hvZ2RyMTVwSDlmSVRTMkt6V20yY0wxNE1lYXRa?=
 =?utf-8?B?ZWc0MU1ydjV3a21yaDd2ZkxLalB6cW9lOFFNN1BEMldEaWpzNXNtTlJwbWRJ?=
 =?utf-8?B?MFlHVVNqc3FJVXZMUXk0STFmQzZkNFNvM1lZNGJzbW5LL2YxZEpKRjJEMVpI?=
 =?utf-8?B?TFgzNnd0QlB0UUtvS0FDU2s5a1BEUG9obnc2WHBOSm4zb3pmc1ZZQTJYdlpZ?=
 =?utf-8?B?SUMyKzhLOC8vakMyOE1yZ3VkamxxbFo3ejhxUCtjenkrNXJRa0VueGVyNmlU?=
 =?utf-8?B?cFR1SmF1RGFaalZHa1RRYjdGTWhrc1pwR0d1RXFwbHNyMEpSOEhZV3RxTlFn?=
 =?utf-8?B?c2RTaW1RVGQ1cHI1WlUrOHNydldEM1BHc1BWTFNKbHVOZHNFaTRyZTl6YVAr?=
 =?utf-8?B?cHNMbXg4VzlwUVdzUGlLOGtPenI5azlaQ2N6cDNyTXNLWlpaYWk5QTJXMXFV?=
 =?utf-8?Q?2UuY1axEd60E48bDat0t/1A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8845.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36269abf-fc22-40d1-fdea-08d9ea813ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 21:31:47.2730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1LZZ84nF3tXg1/0cC9sb4E4O1aZVWzLF6zZH4abKZ8IKjuoQYjeQe/TNf3Cy45guOwsIB4oQjAs5BGvfMaE16A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5145
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgYWxsLA0KDQpHZW50bGUgcGluZy4gQXJlIHdlIG9rYXkgd2l0aCB0aGlzIHNlcmllcz8NCg0K
V2lsbCBhcHByZWNpYXRlIGZlZWRiYWNrIGFzIG91ciBuZXh0IHNldCBvZiBwYXRjaGVzIGZvciBB
bHZlbyBpcyBiYXNlZCBvbiB0aGlzIGZlYXR1cmUuDQoNClRoYW5rcywNCi1Tb25hbA0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpemhpIEhvdSA8bGl6aGkuaG91QHhp
bGlueC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAzMSwgMjAyMiA0OjUwIFBNDQo+IFRv
OiBMaXpoaSBIb3UgPGxpemhpaEB4aWxpbnguY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7DQo+IHJvYmhAa2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgeWlsdW4ueHVAaW50ZWwuY29tOyBNYXggWmhlbg0KPiA8bWF4ekB4aWxpbnguY29tPjsgU29u
YWwgU2FudGFuIDxzb25hbHNAeGlsaW54LmNvbT47IFl1IExpdQ0KPiA8eWxpdUB4aWxpbnguY29t
PjsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+OyBTdGVmYW5vIFN0YWJlbGxpbmkN
Cj4gPHN0ZWZhbm9zQHhpbGlueC5jb20+OyB0cml4QHJlZGhhdC5jb207IG1kZkBrZXJuZWwub3Jn
Ow0KPiBkd213MkBpbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjEgQ3JlYXRl
IGVtcHR5IE9GIHJvb3QgMC8xXSBYUlQgQWx2ZW8gZHJpdmVyDQo+IGluZnJhc3RydWN0dXJlIG92
ZXJ2aWV3DQo+IA0KPiBIaSBSb2IsDQo+IA0KPiANCj4gV2UgYXJlIHN0aWxsIHdhaXRpbmcgZm9y
IHlvdXIgZmVlZGJhY2sgYW5kIGd1aWRhbmNlIG9uIHRoaXMuIENvdWxkIHlvdSB0YWtlIGENCj4g
bG9vaz8NCj4gDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBMaXpoaQ0KPiANCj4gT24gMS8yNS8yMiA5
OjQ4IFBNLCBMaXpoaSBIb3Ugd3JvdGU6DQo+ID4gSGVsbG8sDQo+ID4NCj4gPiBYaWxpbnggQWx2
ZW8gUENJZSBhY2NlbGVyYXRvciBjYXJkcyB1c2UgZmxhdHRlbmVkIGRldmljZSB0cmVlIHRvIGRl
c2NyaWJlDQo+ID4gSFcgc3Vic3lzdGVtcyBvciBlbmRwb2ludHMuIEVhY2ggZGV2aWNlIHRyZWUg
bm9kZSByZXByZXNlbnRzIGEgaGFyZHdhcmUNCj4gPiBlbmRwb2ludCBhbmQgZWFjaCBlbmRwb2lu
dCBpcyBhbiBoYXJkd2FyZSB1bml0IHdoaWNoIHJlcXVpcmVzIGEgZHJpdmVyLg0KPiA+IFRoZSBw
cm9kdWN0IGRldGFpbDoNCj4gPiAgICAgIGh0dHBzOi8vd3d3LnhpbGlueC5jb20vcHJvZHVjdHMv
Ym9hcmRzLWFuZC1raXRzL2FsdmVvLmh0bWwNCj4gPg0KPiA+IFRoZSBmZWVkYmFjayBmcm9tIHRo
ZSBwcmV2aW91cyBwYXRjaGVzIHdhcyB0byBjcmVhdGUgYSBiYXNlIHRyZWUgaWYgdGhlcmUNCj4g
PiBpcyBub3Qgb25lIGFuZCBhcHBseSB0aGUgdW5mbGF0dGVuZWQgZGV2aWNlIG5vZGVzIGJ5IGV4
aXN0aW5nIExpbnV4DQo+ID4gcGxhdGZvcm0gZGV2aWNlIGFuZCBPRiBpbmZyYXN0cnVjdHVyZS4g
UGxlYXNlIHJlZmVyIHRvIHByZXZpb3VzIGRpc2N1c3Npb24NCj4gPiB3aXRoIGRldmljZSB0cmVl
IGFuZCBmcGdhIG1haW50YWluZXJzLg0KPiA+DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvQ0FMX0pzcUpmeVJ5bUI9VnhMdVFxTHBlcCtRMUVpZTQ4ZG9idjlzQzVPaQ0KPiB6RHowZDJE
UUBtYWlsLmdtYWlsLmNvbS8NCj4gPiAgICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAyMjAxMDUyMjUwMTMuMTU2Nzg3MS0xLQ0KPiBsaXpoaS5ob3VAeGlsaW54LmNvbS8NCj4gPg0K
PiA+IFRoaXMgcGF0Y2ggYWRkcyBPRl9FTVBUWV9ST09UIGNvbmZpZy4gV2hlbiBpdCBpcyBzZWxl
Y3RlZCBhbmQgdGhlcmUgaXMgbm90DQo+ID4gYSBkZXZpY2UgdHJlZSwgY3JlYXRlIGFuIGVtcHR5
IGRldmljZSB0cmVlIHJvb3Qgbm9kZS4NCj4gPg0KPiA+IExpemhpIEhvdSAoMSk6DQo+ID4gICAg
b2Y6IGNyZWF0ZSBlbXB0eSBvZiByb290DQo+ID4NCj4gPiAgIGRyaXZlcnMvb2YvS2NvbmZpZyAg
ICAgICAgIHwgIDMgKysrDQo+ID4gICBkcml2ZXJzL29mL01ha2VmaWxlICAgICAgICB8ICAxICsN
Cj4gPiAgIGRyaXZlcnMvb2Yvb2ZfZW1wdHlfcm9vdC5jIHwgNTENCj4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0
aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvb2Yvb2ZfZW1wdHlfcm9v
dC5jDQo+ID4NCg==
