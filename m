Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552804AB728
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343932AbiBGIyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245134AbiBGIvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:51:18 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD121C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:51:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6jUdR10csMOJyRlQxAXnlgAmJP3s4nZ0+sNXuEJ4B7aHpqgfSiwSND9TM//NqeONnMtsbiHu1KQUQgo+xwEis+bw1Bx0svcQ+KZUCiofKiFnLGkTS06Yp8g/8aF99vXGWxrKlopHzxUfccCPoIy6qAU7DJaLyoKEqa16QHv+9nGK7jx1aU3im9BJ465flL5agd/a2UPiv3jJ2vpy5T0xj/terQSFvOlaW48FomcdHrTI+RoDmnWVd41QPcHsN+OBV4hO4UkIfATC7ERmmzMCCDN/jXf2lRFGqVLk6irScfswQhl4yPqeSbAGN6PV+m5/WwUExtYwVc2QA6jOdM/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrLjwptCWrTVz7oJPJbCykPD4YlT9fbvvkmkv25SYYg=;
 b=BSjA0f+CTR9MrKBan6DV1T/8U+g2m9JNLFUcDpIw3BxcyZtu6KRqob8tLwwofcVsSimTEpG+QLtti9fIug7zY5eEH2/wwznZx0OeHem3WprYPWeKlh63+HQVEIkycmkcf+eg4cQWluw9JUp7Vbsz817i+Xt9OwLDOucgYhZ8Y600W2+ELMj6bUuIWno/G5qm4K34XbEbDZnBv8AX+Y9F8b/bRgwEe2xD7PYFu/J7FRgphmhinaCMbw5jtQc3zdMY3rh5GzdvSRGqZx1ZYBy1L8MVgFZYhyEKm0urP28BzHMbkwOdyIYEIQ5ePeTEUajKr7mlARG1dtM6zgZ8ulipJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrLjwptCWrTVz7oJPJbCykPD4YlT9fbvvkmkv25SYYg=;
 b=nwd6dUkcGNSrINAiFAI6PX6S5ME+qwLm2EVRowifeo0hjpalpnMdL3aroufPHz4UzZoCaiJ6kwA9vxgOjV5ZkC9vjC4oA+BRroHPM0yUciGOd+TK1zRU9E2VewMktDQs2DSzzl7pi9jjAr0daO4Xe3WY49yVHKuflwnupMtT5S8=
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by MN2PR05MB6015.namprd05.prod.outlook.com (2603:10b6:208:ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.10; Mon, 7 Feb
 2022 08:51:15 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8%7]) with mapi id 15.20.4975.010; Mon, 7 Feb 2022
 08:51:15 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [PATCH v2 2/8] VMCI: dma dg: add MMIO access to registers
Thread-Topic: [PATCH v2 2/8] VMCI: dma dg: add MMIO access to registers
Thread-Index: AQHYGQCA7ht5HaScOUixUVSp05CcoayDgTyAgARMe4A=
Date:   Mon, 7 Feb 2022 08:51:15 +0000
Message-ID: <58BCE45B-E4FE-42BA-8A0C-32FFEA991B86@vmware.com>
References: <20220203131237.3380-1-jhansen@vmware.com>
 <20220203131237.3380-3-jhansen@vmware.com> <Yf1CW3EyGkTm7H14@kroah.com>
In-Reply-To: <Yf1CW3EyGkTm7H14@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45de8ce7-13f6-4718-1d7e-08d9ea16fff0
x-ms-traffictypediagnostic: MN2PR05MB6015:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MN2PR05MB60158917B2D37A9E58436367DA2C9@MN2PR05MB6015.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R7vqpcODhXja0wLvQVApLDV+QOa3j7iW5U2vVLkPPKZBuOxbEtpxykePXhU6m1Ho2fwk2wXBn2QvlUn2hCWIov7voEIvt6XgiFJnlv2QDRR24sQuNhGhDbQ10JyZ6Rv1tIE1VSO3BqajeJ9MPK2hFVZ9uZYGzeR8MtjRqPxA0CjDupotRJoBQ/5dd58YREI0rKZUJULB7rNj6X3NfN361jSQ7mj0PlMeTi3qPQhS47xNqi5Ap03s8S7/O+Vhvbf4fF+4GkQUcZR8DqBSLpKTnSlvkxhXwsWCpk99LW+HPvKuqFPf6B5P1xMa/WlF/Z1cEBycRZ7TeFayITLI/fgNLpCbYJyBw/6B+G+wlL1WrosEEtWldlgyaoIrzggQQIgzxpNvIf1jYhndwozrRyuoeHvNGfHVpzSz+etUJ/7/dSjo7DCGe9T2XLAapg1/aKYezotzMMps7p5Z0T7N/kDItW9ucI5CH3vVzYiNEaHW9UAZzWTPB6PD6kuROlq6WeoDyHtEOU3bbS/QITnCIpCotMTaKET14RqI0XpzME9zjFv+J/xXcshfeVPs+G0X5CWJC8y0yDdDyxZXZBTRSTDdAbzBM2eMFCNT6GEMOJa931A6loVKUoJeb66fgwiOjO4tPdIZbWSaWDIJ9MJ6F4B6aYRAqXB/ZjGX6VkP+YMrw6yd9wbvd7dIlAneTa04sFaoaYbNaOsGE00Gnsr0lcdYsfDrpk9c5pZ1vUDg97ucXVgcyvx1StNyJZASDLyS2j3H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(2906002)(83380400001)(38070700005)(316002)(6916009)(54906003)(91956017)(86362001)(4326008)(66946007)(76116006)(66556008)(66476007)(66446008)(33656002)(64756008)(8676002)(122000001)(38100700002)(5660300002)(36756003)(71200400001)(26005)(6486002)(2616005)(186003)(508600001)(6512007)(6506007)(107886003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG5KSnpLZTZ2VHh6TlhVT243WVNHOW9XZmxkamxvLzVhdHEzd2FCNEVUSTZ0?=
 =?utf-8?B?czJrQUU1Qzd3ZmF6QmcwMjFxU1hZeWdQQUxwSEtNOFV0T3F4cFg3d1ZmS2N6?=
 =?utf-8?B?VzJNdFpsUmxhRjRmdG9BZ3g5VXgxS21OUForNzd6RUdmWmlBKzUzVTVMbVJn?=
 =?utf-8?B?emVCd1NiYzYrUENHMzYrMnZFOHVod2UzdmFIWXdTb21vOGlsSkM5dnFscVdo?=
 =?utf-8?B?SUd0KzNINURvTldrZUdXamRaK0F2NklodHp1SEU3Ly9Ca3VRc2xHMVFBK1BN?=
 =?utf-8?B?ZGVqZkVrQS9XemFTa3NMcWppYWgvcWdCdXptS2Vjcy9VbEhveUpiNk81S1Yx?=
 =?utf-8?B?d09kcTVucWdEUUxYUGttKzE4UlFYTmJiUCs5R2ZqMXViY3NKV3hmMFpVYzJN?=
 =?utf-8?B?dE9VQ1dXYnBRWW1maFVLVEF3eXFSeE5tbk9PaEFYL05ZTUV1VVc4bGt5WEt2?=
 =?utf-8?B?WDErclVrT1c2WE94YjdzMjFjTnlkL0NyWGlqdTI5Ukk1cWRDNkkwYUp5Zi9R?=
 =?utf-8?B?amYrQkRUSDhldTEzMVJNSlRrU3pzSVZHZU1jbVBkaXhwY1NxTmxGY0l6RW5M?=
 =?utf-8?B?K2RrUjZjUUh5RC9GTnN3Tm1OU0JhTjJOeXN6dERIbTFsakpuQWFON1NreFVY?=
 =?utf-8?B?ckZHNmd0WXU2dmZUVUhrbGFVMXl5ejZBK1g1QjkrWnNpUTZkVzhZNG5UMjBU?=
 =?utf-8?B?WTdJdVViQkJvZDRJNVZjeWNxSUt6Q0U4K3ZoNmMvckpKYnIrUkdzcStWVkdH?=
 =?utf-8?B?MkdaK0U3dTFvQkYrWCtZa1A2UUtkNGNDNkR3ekU5MFpzSndWTStWRlRvbWU1?=
 =?utf-8?B?QWlwNDJMSkxqN0FROGVsNDhIT3dUVFkzVkRsZ3FCYTUvd0ZHeGR2SkNmZCt4?=
 =?utf-8?B?VkZoUDdUWVhJRWtqYVNLbUlaVExNeXNoOFVzT3hEUTJUTXF0Yk8vU1VQTTQx?=
 =?utf-8?B?UzVpS0VRT0plclJtRkxrQ0YzTVQwTWhRbWJhYzkxVzBnV0x6eFlPNHBsWVRM?=
 =?utf-8?B?WElkclJaZFppa0swRTBWS3ZGdDVLYlE4dlhSTlhnd3Zpd1ZRa0tnWlgrUk1y?=
 =?utf-8?B?blRDSk1mMFRoSG16S2NXMU1ybTFraGRBSGNtUkpZeURTcmxDOVo1dEIveWM5?=
 =?utf-8?B?ZlRheEVUdEhhdDVrbCtoUzhZb3lRdCtOYlIyWkg5THgxRXNlVW5nYzArMnpp?=
 =?utf-8?B?Y3ZFTlNoR0JyaE9oQlhDc25RM0dGT3VPZStGMXVWWlVqLzRIMjFFOTREUWxs?=
 =?utf-8?B?SEhUNHVJVDJVRktVRUVkeHltbzJqam9hUGJhMVY0Sk1vQ2h5NUVNNGlKdVdW?=
 =?utf-8?B?YTlTT1lsVmxudEcyTGtOSytLb1k4Wk5kQlhzQU5oN2s0ZE1Fc0hDcXJMRFh6?=
 =?utf-8?B?Rk5IYi9kZE02UDJZT3hEL0RQSzhLcERMRTBmeU5hOGIzcmp4K2FFSldRNzdY?=
 =?utf-8?B?RE9BZmhuczFabHNJZUwwSEp0elZsMm1pQ05PdmpvQktzcWFHQUU3YitPRUFY?=
 =?utf-8?B?QkxLalo1cHlreXE5TE1JVWMyRWtIY0hPWnI2LzBPQ200RTJSeE5qTVQ4VjZK?=
 =?utf-8?B?NmRKaVBaOEl1Q3hHV1VFekZXa0tmcHJla3VPd0ZUOUY3djhhUGZ3VlI4N216?=
 =?utf-8?B?RFd0YzFNYUovWld1UTcyckZTd1dYV2pzaFVOZXdIc3pVSnJ3dE1SS05iM0pV?=
 =?utf-8?B?Wm5lYXR2cHNMRGZMMi9UbnF5THBaYUE1eXZ2SFNiU0hrTWFxR0V1bDcyallH?=
 =?utf-8?B?RHZJekVvbmdVQkJOVGVuTktYczBsd05GekZjTjBuWDg5d0phUEtnRGZDMk0x?=
 =?utf-8?B?N2VINDFXQUZTL2ZVUGgrVG11Zll2RnM4U3FCUmIxNkFyOFNYQnRhTHhIZWo1?=
 =?utf-8?B?VDlPUlJyalJSQjRsTkFpTkp2bjlzZ2JPblQ0S3hLNEc5ZjEvZk9MamQ4MGVu?=
 =?utf-8?B?YjRTbm9BOC9tUEMyVjVYYmZZbzZITm1QWnNyV282UGJ3ZkV5empqaCs1czdq?=
 =?utf-8?B?UlhFWUdNYmtUNDhmOTBGcU1QQVF6RWViVTFJMjg1bmhSRXBwTVY2S0dPbmhL?=
 =?utf-8?B?a0ZpSkttRklKODV6Z2lqWGFxTHhIZkNmSzFVeENsRHBGU1ZreUJwTGRYc1gv?=
 =?utf-8?B?MGxHc1Y0cXB2S2IyVStWWWpzNDRuNkVwQ2FUeHZlVDErQ0x6Vi9yZnY3QUVN?=
 =?utf-8?Q?w+ZNxphxHCbAd6Mw72Rbjvw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FFB7E7F92D8174FAB193EEA0F8CBF6A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45de8ce7-13f6-4718-1d7e-08d9ea16fff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 08:51:15.2336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTIIqk68VpJimeip598GoySoSVvTv7qlUAer8H1ZsRh1BxxG8F7OpBDSq8rA/Gitxa9RPORGstsQbNXlwYXiCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6015
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gNCBGZWIgMjAyMiwgYXQgMTYuMTIsIEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgRmViIDAzLCAyMDIyIGF0IDA1OjEyOjMx
QU0gLTA4MDAsIEpvcmdlbiBIYW5zZW4gd3JvdGU6DQo+PiBEZXRlY3QgdGhlIHN1cHBvcnQgZm9y
IE1NSU8gYWNjZXNzIHRocm91Z2ggZXhhbWluYXRpb24gb2YgdGhlIGxlbmd0aA0KPj4gb2YgdGhl
IHJlZ2lvbiByZXF1ZXN0ZWQgaW4gQkFSMS4gSWYgaXQgaXMgMjU2S0IsIHRoZSBWTUNJIGRldmlj
ZQ0KPj4gc3VwcG9ydHMgTU1JTyBhY2Nlc3MgdG8gcmVnaXN0ZXJzLg0KPj4gDQo+PiBJZiBNTUlP
IGFjY2VzcyBpcyBzdXBwb3J0ZWQsIG1hcCB0aGUgYXJlYSBvZiB0aGUgcmVnaW9uIHVzZWQgZm9y
DQo+PiBNTUlPIGFjY2VzcyAoNjRLQiBzaXplIGF0IG9mZnNldCAxMjhLQikuDQo+PiANCj4+IEFk
ZCB3cmFwcGVyIGZ1bmN0aW9ucyBmb3IgYWNjZXNzaW5nIDMyIGJpdCByZWdpc3RlciBhY2Nlc3Nl
cyB0aHJvdWdoDQo+PiBlaXRoZXIgTU1JTyBvciBJTyBwb3J0cyBiYXNlZCBvbiBkZXZpY2UgY29u
ZmlndXJhdGlvbi4NCj4+IA0KPj4gU2VuZGluZyBhbmQgcmVjZWl2aW5nIGRhdGFncmFtcyB0aHJv
dWdoIGlvd3JpdGU4X3JlcC9pb3JlYWQ4X3JlcCBpcw0KPj4gbGVmdCB1bmNoYW5nZWQgZm9yIG5v
dywgYW5kIHdpbGwgYmUgYWRkcmVzc2VkIGluIGEgbGF0ZXIgY2hhbmdlLg0KPj4gDQo+PiBSZXZp
ZXdlZC1ieTogVmlzaG51IERhc2EgPHZkYXNhQHZtd2FyZS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBKb3JnZW4gSGFuc2VuIDxqaGFuc2VuQHZtd2FyZS5jb20+DQo+PiAtLS0NCj4+IGRyaXZlcnMv
bWlzYy92bXdfdm1jaS92bWNpX2d1ZXN0LmMgfCA2OCArKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0NCj4+IGluY2x1ZGUvbGludXgvdm13X3ZtY2lfZGVmcy5oICAgICAgfCAxMiArKysrKysN
Cj4+IDIgZmlsZXMgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+
PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2Mvdm13X3ZtY2kvdm1jaV9ndWVzdC5jIGIv
ZHJpdmVycy9taXNjL3Ztd192bWNpL3ZtY2lfZ3Vlc3QuYw0KPj4gaW5kZXggMTAxOGRjNzcyNjlk
Li4zOGVlN2VkMzJhYjkgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21pc2Mvdm13X3ZtY2kvdm1j
aV9ndWVzdC5jDQo+PiArKysgYi9kcml2ZXJzL21pc2Mvdm13X3ZtY2kvdm1jaV9ndWVzdC5jDQo+
PiBAQCAtNDUsNiArNDUsNyBAQCBzdGF0aWMgdTMyIHZtX2NvbnRleHRfaWQgPSBWTUNJX0lOVkFM
SURfSUQ7DQo+PiBzdHJ1Y3Qgdm1jaV9ndWVzdF9kZXZpY2Ugew0KPj4gCXN0cnVjdCBkZXZpY2Ug
KmRldjsJLyogUENJIGRldmljZSB3ZSBhcmUgYXR0YWNoZWQgdG8gKi8NCj4+IAl2b2lkIF9faW9t
ZW0gKmlvYmFzZTsNCj4+ICsJdm9pZCBfX2lvbWVtICptbWlvX2Jhc2U7DQo+PiANCj4+IAlib29s
IGV4Y2x1c2l2ZV92ZWN0b3JzOw0KPj4gDQo+PiBAQCAtODksNiArOTAsMjEgQEAgdTMyIHZtY2lf
Z2V0X3ZtX2NvbnRleHRfaWQodm9pZCkNCj4+IAlyZXR1cm4gdm1fY29udGV4dF9pZDsNCj4+IH0N
Cj4+IA0KPj4gK3N0YXRpYyB1bnNpZ25lZCBpbnQgdm1jaV9yZWFkX3JlZyhzdHJ1Y3Qgdm1jaV9n
dWVzdF9kZXZpY2UgKmRldiwgdTMyIHJlZykNCj4+ICt7DQo+PiArCWlmIChkZXYtPm1taW9fYmFz
ZSAhPSBOVUxMKQ0KPj4gKwkJcmV0dXJuIHJlYWRsKGRldi0+bW1pb19iYXNlICsgcmVnKTsNCj4+
ICsJcmV0dXJuIGlvcmVhZDMyKGRldi0+aW9iYXNlICsgcmVnKTsNCj4+ICt9DQo+PiArDQo+PiAr
c3RhdGljIHZvaWQgdm1jaV93cml0ZV9yZWcoc3RydWN0IHZtY2lfZ3Vlc3RfZGV2aWNlICpkZXYs
IHUzMiB2YWwsIHUzMiByZWcpDQo+PiArew0KPj4gKwlpZiAoZGV2LT5tbWlvX2Jhc2UgIT0gTlVM
TCkNCj4+ICsJCXdyaXRlbCh2YWwsIGRldi0+bW1pb19iYXNlICsgcmVnKTsNCj4+ICsJZWxzZQ0K
Pj4gKwkJaW93cml0ZTMyKHZhbCwgZGV2LT5pb2Jhc2UgKyByZWcpOw0KPj4gK30NCj4+ICsNCj4+
IC8qDQo+PiAgKiBWTSB0byBoeXBlcnZpc29yIGNhbGwgbWVjaGFuaXNtLiBXZSB1c2UgdGhlIHN0
YW5kYXJkIFZNd2FyZSBuYW1pbmcNCj4+ICAqIGNvbnZlbnRpb24gc2luY2Ugc2hhcmVkIGNvZGUg
aXMgY2FsbGluZyB0aGlzIGZ1bmN0aW9uIGFzIHdlbGwuDQo+PiBAQCAtMTE2LDcgKzEzMiw3IEBA
IGludCB2bWNpX3NlbmRfZGF0YWdyYW0oc3RydWN0IHZtY2lfZGF0YWdyYW0gKmRnKQ0KPj4gCWlm
ICh2bWNpX2Rldl9nKSB7DQo+PiAJCWlvd3JpdGU4X3JlcCh2bWNpX2Rldl9nLT5pb2Jhc2UgKyBW
TUNJX0RBVEFfT1VUX0FERFIsDQo+PiAJCQkgICAgIGRnLCBWTUNJX0RHX1NJWkUoZGcpKTsNCj4+
IC0JCXJlc3VsdCA9IGlvcmVhZDMyKHZtY2lfZGV2X2ctPmlvYmFzZSArIFZNQ0lfUkVTVUxUX0xP
V19BRERSKTsNCj4+ICsJCXJlc3VsdCA9IHZtY2lfcmVhZF9yZWcodm1jaV9kZXZfZywgVk1DSV9S
RVNVTFRfTE9XX0FERFIpOw0KPj4gCX0gZWxzZSB7DQo+PiAJCXJlc3VsdCA9IFZNQ0lfRVJST1Jf
VU5BVkFJTEFCTEU7DQo+PiAJfQ0KPj4gQEAgLTM4NCw3ICs0MDAsNyBAQCBzdGF0aWMgaXJxcmV0
dXJuX3Qgdm1jaV9pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqX2RldikNCj4+IAkJdW5zaWduZWQg
aW50IGljcjsNCj4+IA0KPj4gCQkvKiBBY2tub3dsZWRnZSBpbnRlcnJ1cHQgYW5kIGRldGVybWlu
ZSB3aGF0IG5lZWRzIGRvaW5nLiAqLw0KPj4gLQkJaWNyID0gaW9yZWFkMzIoZGV2LT5pb2Jhc2Ug
KyBWTUNJX0lDUl9BRERSKTsNCj4+ICsJCWljciA9IHZtY2lfcmVhZF9yZWcoZGV2LCBWTUNJX0lD
Ul9BRERSKTsNCj4+IAkJaWYgKGljciA9PSAwIHx8IGljciA9PSB+MCkNCj4+IAkJCXJldHVybiBJ
UlFfTk9ORTsNCj4+IA0KPj4gQEAgLTQyOSw3ICs0NDUsOCBAQCBzdGF0aWMgaW50IHZtY2lfZ3Vl
c3RfcHJvYmVfZGV2aWNlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPj4gCQkJCSAgIGNvbnN0IHN0
cnVjdCBwY2lfZGV2aWNlX2lkICppZCkNCj4+IHsNCj4+IAlzdHJ1Y3Qgdm1jaV9ndWVzdF9kZXZp
Y2UgKnZtY2lfZGV2Ow0KPj4gLQl2b2lkIF9faW9tZW0gKmlvYmFzZTsNCj4+ICsJdm9pZCBfX2lv
bWVtICppb2Jhc2UgPSBOVUxMOw0KPj4gKwl2b2lkIF9faW9tZW0gKm1taW9fYmFzZSA9IE5VTEw7
DQo+PiAJdW5zaWduZWQgaW50IGNhcGFiaWxpdGllczsNCj4+IAl1bnNpZ25lZCBpbnQgY2Fwc19p
bl91c2U7DQo+PiAJdW5zaWduZWQgbG9uZyBjbWQ7DQo+PiBAQCAtNDQ1LDE2ICs0NjIsMzIgQEAg
c3RhdGljIGludCB2bWNpX2d1ZXN0X3Byb2JlX2RldmljZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwN
Cj4+IAkJcmV0dXJuIGVycm9yOw0KPj4gCX0NCj4+IA0KPj4gLQllcnJvciA9IHBjaW1faW9tYXBf
cmVnaW9ucyhwZGV2LCAxIDw8IDAsIEtCVUlMRF9NT0ROQU1FKTsNCj4+IC0JaWYgKGVycm9yKSB7
DQo+PiAtCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gcmVzZXJ2ZS9tYXAgSU8gcmVn
aW9uc1xuIik7DQo+PiAtCQlyZXR1cm4gZXJyb3I7DQo+PiArCS8qDQo+PiArCSAqIFRoZSBWTUNJ
IGRldmljZSB3aXRoIG1taW8gYWNjZXNzIHRvIHJlZ2lzdGVycyByZXF1ZXN0cyAyNTZLQg0KPj4g
KwkgKiBmb3IgQkFSMS4gSWYgcHJlc2VudCwgZHJpdmVyIHdpbGwgdXNlIG5ldyBWTUNJIGRldmlj
ZQ0KPj4gKwkgKiBmdW5jdGlvbmFsaXR5IGZvciByZWdpc3RlciBhY2Nlc3MgYW5kIGRhdGFncmFt
IHNlbmQvcmVjdi4NCj4+ICsJICovDQo+PiArDQo+PiArCWlmIChwY2lfcmVzb3VyY2VfbGVuKHBk
ZXYsIDEpID09IFZNQ0lfV0lUSF9NTUlPX0FDQ0VTU19CQVJfU0laRSkgew0KPj4gKwkJZGV2X2lu
Zm8oJnBkZXYtPmRldiwgIk1NSU8gcmVnaXN0ZXIgYWNjZXNzIGlzIGF2YWlsYWJsZVxuIik7DQo+
PiArCQltbWlvX2Jhc2UgPSBwY2lfaW9tYXBfcmFuZ2UocGRldiwgMSwgVk1DSV9NTUlPX0FDQ0VT
U19PRkZTRVQsDQo+PiArCQkJCQkgICAgVk1DSV9NTUlPX0FDQ0VTU19TSVpFKTsNCj4+ICsJCS8q
IElmIHRoZSBtYXAgZmFpbHMsIHdlIGZhbGwgYmFjayB0byBJT0lPIGFjY2Vzcy4gKi8NCj4+ICsJ
CWlmICghbW1pb19iYXNlKQ0KPj4gKwkJCWRldl93YXJuKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8g
bWFwIE1NSU8gcmVnaXN0ZXIgYWNjZXNzXG4iKTsNCj4+IAl9DQo+PiANCj4+IC0JaW9iYXNlID0g
cGNpbV9pb21hcF90YWJsZShwZGV2KVswXTsNCj4+ICsJaWYgKCFtbWlvX2Jhc2UpIHsNCj4+ICsJ
CWVycm9yID0gcGNpbV9pb21hcF9yZWdpb25zKHBkZXYsIEJJVCgwKSwgS0JVSUxEX01PRE5BTUUp
Ow0KPj4gKwkJaWYgKGVycm9yKSB7DQo+PiArCQkJZGV2X2VycigmcGRldi0+ZGV2LCAiRmFpbGVk
IHRvIHJlc2VydmUvbWFwIElPIHJlZ2lvbnNcbiIpOw0KPj4gKwkJCXJldHVybiBlcnJvcjsNCj4+
ICsJCX0NCj4+ICsJCWlvYmFzZSA9IHBjaW1faW9tYXBfdGFibGUocGRldilbMF07DQo+PiArCX0N
Cj4+IA0KPj4gLQlkZXZfaW5mbygmcGRldi0+ZGV2LCAiRm91bmQgVk1DSSBQQ0kgZGV2aWNlIGF0
ICUjbHgsIGlycSAldVxuIiwNCj4+IC0JCSAodW5zaWduZWQgbG9uZylpb2Jhc2UsIHBkZXYtPmly
cSk7DQo+PiArCWRldl9pbmZvKCZwZGV2LT5kZXYsICJGb3VuZCBWTUNJIFBDSSBkZXZpY2UgYXQg
JSNseCwgJSNseCwgaXJxICV1XG4iLA0KPj4gKwkJICh1bnNpZ25lZCBsb25nKWlvYmFzZSwgKHVu
c2lnbmVkIGxvbmcpbW1pb19iYXNlLCBwZGV2LT5pcnEpOw0KPiANCj4gV2h5IGFyZSB5b3UgcHJp
bnRpbmcgaW9tZW0gYWRkcmVzc2VzIHRvIHVzZXJzcGFjZT8gIEFyZSB5b3Ugc3VyZSB0aGF0IGlz
DQo+IG9rPyAgV2hvIGlzIGdvaW5nIHRvIHVzZSBpdD8NCg0KSeKAmW0gbm90IHN1cmUgaWYgdGhl
cmUgd2FzIGEgc3BlY2lmaWMgcHVycG9zZSBiYWNrIHdoZW4gdGhpcyB3YXMgYWRkZWQgLSBtb3N0
DQpsaWtlbHkgdGhlIGludGVudGlvbiB3YXMgc2ltcGx5IHRvIHJlcG9ydCB0aGUgcmVzb3VyY2Vz
IGFsbG9jYXRlZCB0byB0aGUgZGV2aWNlLg0KSSdsbCByZW1vdmUgdGhpcyBvbmUgdG9vLg0KDQpU
aGFua3MsDQpKb3JnZW4g
