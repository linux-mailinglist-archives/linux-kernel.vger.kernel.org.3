Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C2A4DD4D9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 07:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiCRGnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 02:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiCRGnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:43:41 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 23:42:19 PDT
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68B12CA47C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1647585741; x=1679121741;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=AxhcmIw5ltEnTOGwdnzKkMU58RwIOqI2Uxy7KHZTwo8=;
  b=uammHyp3vn749rFDTHq7fa5ZImdcLwI90d1oDosZcG0jSVLTb4mdA2fz
   15tUAvsByHWQ/dKAq3KkLStV9Rm8NmRdUyhvdu+CgLXpFF458HeIujWSZ
   qh3XKBeMtbCQJjmVfxf22ioLXVBqP6Xwh8MxFA6dtb2GbltU2YLsYUO0A
   GyvfLwwPngij839ogambpHoKffpwl4Gkg35jmtBx9Lhe70P9iWnROp9GC
   YJRj8QYRKlCjl6oTMLN7LZYnR+l4jh4w2pZlyhlVy6bantyj7eruq/liL
   6LIIGrD/MhT6izL6aRtShewxb/Np1DUHzHCQejgHY+eo99kEiJMtr8r3w
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="53154385"
X-IronPort-AV: E=Sophos;i="5.90,191,1643641200"; 
   d="scan'208";a="53154385"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 15:41:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGRkjohipo3n5u1IggSLPK8+DpQLpcVH9tdmzWeahFQ4bRifw++Gec5sJxlx8wbvJejXg/Y10gV+rJuEkxoQ8Y1c0U0f1xZkZnZn3sKMGMulooI7iKGl5IHCpz9KJWQmgCe6tAZ/HKpS8IWA0L4RI5Xmkqz1wReNB1xS2LeZiIpgpQqJXn+Siv3w/vvqAVLmdC7RnXgP4tRcRiQoEzg1SVNGzb0u9eJwPTyBbBp1daTMITVWgx9bGcf2fCrlLVQEaedEO4j+UV/HSW0oETN5WKpalInFZyAtusrC2vrfC98SRXm+6o8ZmNBhN3qZqsElFM8DUp6vZe+jTKwUKPMvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxhcmIw5ltEnTOGwdnzKkMU58RwIOqI2Uxy7KHZTwo8=;
 b=IARPo9m4aFMshqEUYQxcbBA4wo8+2dJqwsBECzjCc+uKg5/nq/wu3lC4apjseAkyBLpR17gCBJsozQljV5jMSBCACChrQTLTPHYA2SycIXN9G/4hxgSVOpLZHIA/09dQhvvR94rty4EmOODYcg0xJuWQJKAHIdLg6Ixw0p3mvt5hzqz5yWWx4B+6mLXvdRXmX0qR7cyPBmgqn5cAjc/cw4iYKarW4+hOWb384wsmVsRPEPU4JEYh3xMSUZWvECCOf3Jite0AJGWpR4Gq4KUq3MXTJOYt9ROYtfAZ/mOYD7hVCXFf49JItbezcwffokY3slcWUcYJOFthGUVcdv/Pfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxhcmIw5ltEnTOGwdnzKkMU58RwIOqI2Uxy7KHZTwo8=;
 b=n5u6HmmnPWYbZTC0VyAF5UX442zf2J1MZelncCuwdFxyNU3svGXMh6O5iMyCxM81951hci2461DYlFOjr7/e5j712IhTnjNrq4PDIF97hDGNG6Mro8WqW4kuX5UvPT/yFHfXkKKUNUIAFASr0Y5guLRK7aH8gIt4rWnBG7xexrY=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSBPR01MB4437.jpnprd01.prod.outlook.com (2603:1096:604:7e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Fri, 18 Mar
 2022 06:41:05 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::885a:78d2:af39:629f]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::885a:78d2:af39:629f%4]) with mapi id 15.20.5081.014; Fri, 18 Mar 2022
 06:41:05 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/8] x86: Add hardware prefetch control support for x86
Thread-Topic: [PATCH v2 6/8] x86: Add hardware prefetch control support for
 x86
Thread-Index: AQHYNTHKnPZAXhwibUmU6A4/NMvycay/ZDQAgAVV22A=
Date:   Fri, 18 Mar 2022 06:41:04 +0000
Message-ID: <OSBPR01MB2037E49B416A30182901F70C80139@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
 <20220311101940.3403607-7-tarumizu.kohei@fujitsu.com>
 <6b28a6f3-8d3d-76f4-d517-62260ac5b337@intel.com>
In-Reply-To: <6b28a6f3-8d3d-76f4-d517-62260ac5b337@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6b210f1-c066-42de-d4c7-08da08aa46bf
x-ms-traffictypediagnostic: OSBPR01MB4437:EE_
x-microsoft-antispam-prvs: <OSBPR01MB44373475308B1B3076E7277380139@OSBPR01MB4437.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b+etni7Xu3NS/ejgRN6094jkyN57kkACYwXZk65ls8FPAWLqhZoRjp6rY1MdoqVkVD4qW/WkB6JfKHi8xvs5t/zG923wnl61Y/yQ1BgSDyMi4II6UcOLkmNlMuRdFOUe0NQA1cvnBHio6gl0jOZ245N8dgZgsJrBzJsZY2h69NpNv2BGSzRobKfHtNPJ1BPdQbZRb38ihHiUpw7NKMQbtcBK1/Q0OsNZsUieO6z9yQ4jKUmdJJz82lO1VkARiCp+uegzIEmeVwcFVJO1ybP4zHiWOxTjLXOotx6bcb4lObbIBVjn38J7OxWcfRL6rwDB2o9JqhHEjTppq9oL3YzivCLy6c82EJxY2PQZn0QmrcJy4RKLQYPmcMcagGhspch3lFk24OOVBb+T74gUfNyNKV3nwNUpPx79wVD98ls9kI7frpyTDs6fgp6gzmgrmvjbyH0Qc6XEyHcwjpMCj3Ui2Xfy1uhCMXn3ac2k2Y0oPtoAQl+DoVq6JBrsCPfSKhiGNUnMnsgfYL3/jezyvqI1YZzT3ScQE26qZBsf4SCpIxfCbpHa3tpfpSArl94K4i+wnrW+3pvGRh0zSQVqwf3Pe/G2KtT/+f949OagZkuZItTbN6BZJMeU5g1QsjagGsBPSXXx/oM4QHVnct1rmDyTyYhXk3BHyJNdm50pvgOtrzgJG0J62oJTKM1QY58D8KJ5JvPlK40FYLG0LbfvyctTuVnpu3LLVIJxsh/xoDdSSUg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(122000001)(921005)(64756008)(9686003)(38100700002)(7696005)(38070700005)(6506007)(76116006)(71200400001)(66556008)(2906002)(66446008)(66476007)(33656002)(66946007)(8676002)(4744005)(8936002)(508600001)(86362001)(7416002)(5660300002)(83380400001)(186003)(55016003)(52536014)(316002)(26005)(85182001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0tmSnI2c0NpbEZPZkF0dUFYcE5ieFpyeHVFbVp6NW03N3Z2bUVzUm5ZRjZq?=
 =?utf-8?B?Q2lwKzJTQmM1QUp3Ukh1NU92b1diRDVuWFo5NVh0SlRKLysxQlJ4Skl0K2JC?=
 =?utf-8?B?OFk2aXNRZ3RZZEpvUlZmVWhQV1IwZkttclY2UjNyekMvYW5vYXhZZmI4Lzk1?=
 =?utf-8?B?YWdQWWsvQ2RCYjBlKzdmOGgvRjJqUTR6SXVIUXowcEYvU040WlN3VUV2VUhn?=
 =?utf-8?B?bVBJMFpnSWcva2sxbkZFSWxhUUNnUGNrdGdzT1JjSnBQTEhET1dxblRZNEFj?=
 =?utf-8?B?WmFEZVE1S2ZlRDlpWXNNb040QzNqelNaVjBUOTI4UkpYZGNXZWhNR0RRMEJz?=
 =?utf-8?B?KzJ0ZlFrdFdMOGxCNFhmME5uTTRZZ2xLWGRneWVaVGE5bnRwQXFIK3oyVENw?=
 =?utf-8?B?MzhONUtoZEpZbUNQVzFWcnV0WDFVQVRtcFZWZ295TDRsbjNrdGFzUlNQb0dw?=
 =?utf-8?B?eWVZaS9walpXZTF1TnQ2Y1YvNi9zeWZGZWdXL2J4TExJTzF5WFlES1pjZWhV?=
 =?utf-8?B?elVKbTlqTDdBQnR3cHAzbUdmUHlkNHFZTHVlc2xRL2dtVWg4blkvWDNZV2pI?=
 =?utf-8?B?UHcwM3IzTlJBaE5RVktObjdMVDF3dXVJMWIrMVVUNFdDK3pyb1hVN1ovUk5O?=
 =?utf-8?B?T1NNZm1WcVkrTVMrZzlDSlpYM0E4bGZaZlBsbytPblo5UVRpVlJZSURFQy85?=
 =?utf-8?B?Ris3aWFTbDVYb0tYTFk1U2Z2MjFOMzMxVUJ4Zk12c1FtZmFJYmMyZjlGSXZ1?=
 =?utf-8?B?RVhKbEVrNVl6TVloS2hFWStDY2lIMlZHOWZkNTNFd3hDRUVwTy90RGV4VTBk?=
 =?utf-8?B?M3VMZksyRmppUUViUU1TQitnUzRCRTBPS2JsUXFEaHp5ckVtSk9KRW83Uit2?=
 =?utf-8?B?ZjIzV0o2V3RPWkRhMlNaUkRjNzBzQytVanJLZ0xxZXUwcEk1VWEwbHl2SGNM?=
 =?utf-8?B?VzBMRlZLczhLMXRqanFaY1FWdEY2WEhSY0dIRVBKQ0NhNDZCRXFQMlhkTVdF?=
 =?utf-8?B?NzR6MHpjWHdJdVQ3MGY4emdUT0JPRVFZcm5tZzEzL3BYS0lwenpINjJYd05s?=
 =?utf-8?B?UGMwaVN6OXMyNDFDc2dVNWlBTnZscjU0WTdlZkFRNVduWnV0VVZpbGNwTHVH?=
 =?utf-8?B?MDVmOTladVZ5VWtCaUpnSnpUbm14dmdZOENkdWMxT1RCSDhQQ1RyQmRkOTJt?=
 =?utf-8?B?R2RKMXJBaVdOSjVoOS9Yczh0ZkdWcFNkVU9VSXMyaW5iUmp1RjRyK1hPMjBt?=
 =?utf-8?B?VzBWNWs1UHlHdzY4QnA3ZnpvTzJrY2puOGJnMFVudTVTeWJDU3B3R2ZRT1Vi?=
 =?utf-8?B?K0pzRWxWVk1WODYwQkxmNEs0cjJuL2VnSTl2WlNicTVRVVhCNHF1TGlEQU0r?=
 =?utf-8?B?RkZiSEZCenM5aUZRU1RFQVZFSUJoVlc3OXhmN1laWmF3VktJRlpsbmlqanJ0?=
 =?utf-8?B?ckplUGp3bkdnUzVkMHVpRmllejJtWTFnUVhoSFpIZFJsQWc0M25uTWdabUI5?=
 =?utf-8?B?WFpSY1hWWklQdDZPQjU0QWVqOFk3Y0tKR2VrK1U4emtwb1Ardy9WTWZOcHpV?=
 =?utf-8?B?VVJlOWx4N24raGduZkY1d3krK1lUcVpDdVB2L29aNkhnN0RrbTZ6alJXVEI0?=
 =?utf-8?B?a3VxQ1NQbWo5dTZZb1g1VlNCeWRmMCtHR3BCQzRSc1ZmNVJEL2FMZzcyTHdY?=
 =?utf-8?B?VlcyZnEzczQ2R1JXNGZGYjhXZ1VkckE5b3Q3d0tha0hscHNKU2hMTnpsT2ND?=
 =?utf-8?B?dkFmMGVTMmxGcnJmRS80WkNNcWh0ZWdyNmZURkJWYm5UMFloZnd5UTQwdlpK?=
 =?utf-8?B?d0Y4SXo5Z2d6MjQ0V1dNL3pJbjc2NXRBWEdBUDB0MktwdjdnWHo3dlVrcFFj?=
 =?utf-8?B?SmduTExxQzZEakFmVlR1bkw4cW5zNDBvVzlZY3pwYWRxb3hHM3lLeHY2WThP?=
 =?utf-8?B?QkFXN2R6SlJzMG5UNXAvcENPMUdGZDE5djNhMThMNDVzR1piK1BtWlZMMngz?=
 =?utf-8?B?UjMwWWZZRUd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b210f1-c066-42de-d4c7-08da08aa46bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 06:41:04.8911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E0YDK3RhGQGx1s0L21ZegFsn8Nq1S1L3c1m+TOBdb4ntTBgkXvzyoM9Y/EZAqTkRDdJ61fy/g+dKm3xQMCpYbSTvCmCVYwJCSG3/OmS0j5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4437
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICtzdGF0aWMgaW50IGJyb2Fkd2VsbF93cml0ZV9wZnJlZyhlbnVtIHBmY3RsX2F0dHIgcGF0
dHIsIHVuc2lnbmVkIGludCBjcHUsDQo+ID4gKwkJCQkgdW5zaWduZWQgaW50IGxldmVsLCB1NjQg
dmFsKQ0KPiA+ICt7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsJdTY0IHJlZzsNCj4gPiArDQo+ID4g
KwlyZXQgPSByZG1zcmxfb25fY3B1KGNwdSwgTVNSX01JU0NfRkVBVFVSRV9DT05UUk9MLCAmcmVn
KTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwlyZXQg
PSBicm9hZHdlbGxfbW9kaWZ5X3BmcmVnKHBhdHRyLCAmcmVnLCBsZXZlbCwgdmFsKTsNCj4gPiAr
CWlmIChyZXQgPCAwKQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0ID0gd3Jt
c3JsX29uX2NwdShjcHUsIE1TUl9NSVNDX0ZFQVRVUkVfQ09OVFJPTCwgcmVnKTsNCj4gPiArCWlm
IChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiAr
fQ0KPiANCj4gVGhpcyBuZWVkcyB0byBpbnRlZ3JhdGUgX3NvbWVob3dfIHdpdGggdGhlIHBzZXVk
b19sb2NrLmMgY29kZS4gIFJpZ2h0IG5vdywgSQ0KPiBzdXNwZWN0IHRoYXQgY29kZSB3b3VsZCBq
dXN0IG92ZXJ3cml0ZSBhbnkgTVNSIGNoYW5nZXMgbWFkZSBieSB0aGlzIGNvZGUuDQoNCkkgbGFj
a2VkIGNvbnNpZGVyYXRpb24gZm9yIHBzZXVkb19sb2NrLmMgY29kZS4gSSB0cnkgdG8gaW50ZWdy
YXRpb24NCndpdGggdGhhdCBjb2RlLg0K
