Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6C64DE6BB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 08:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242389AbiCSHaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 03:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbiCSHaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 03:30:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69F27D01C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 00:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPo194ITiBgMAIrqFIfSrDxulc0S6cc4mOY5VDxfiNXN8vNUgPjdi47EKsN4c/u71XHOM0JbXHLAkkDGOQzXkAJA7Unn+7IHsliNj7Sdu2wXqqyt++w1X6ySDs79lrMHm5Vd5izcaWNX9T8+UttE2e0298cYLsCLsx9ZI9ezPdv04Iovpdncyu9kW/Mj8qJlqDcdPZF+hqAntPS1ycb2HCHHdzfvFN7wlI+uDn6jgtO4Y8OOEph6RArqOSVFxeAd2bX9B9h4lbhUoXUNfP+O4GC+qyzU1wbywEyuR7LuoFMtPmPmrTRpgvmR6uyAyWbxBX99AoS1pAvzcPG6NItQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzidFv4QXL6zfxnHONaT/vB060gAO44olSN5FaRdFuI=;
 b=RpJQlRx2ekymwv0zpjiox9inZTQW6Tt4RBAAI3YtPYlGlufRedi5X+u3umxdoPF5pAv75afqkrxsBCkyHRWCa6pvFO+QBMCCdDHk7jMxT5gKQz1rsUM+3gZ22TsfAIm0cOfd1KFRxfC1cbfEs0WCCwTV75TuCSFUFqnr5a2CC/QY0CrmDsZuJe7cP6W4U0moOOooyyW6vc6omVFLDtzZ+7pN+g4CgLEO+ceaWhhR9GfPKZdd7WncvxOQhzWp/DW9/ZuSun7kHFdvc9DwiGh24QL/0xW9Ovb6TUhswdIqxVByWLxLRVnTi0hwqvh7cDpL1gj14XlE9Pmms40QAv0hJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzidFv4QXL6zfxnHONaT/vB060gAO44olSN5FaRdFuI=;
 b=NMc0tWUZVmfXy6TEw3zrja+lKfTjbXdqkwWmY0n9jzHXPOxPFuDQ7U9YF6jPhutb4d3SD5P912oJZzsXveOmyHYXtf6BzRf7aMIJ6F39N3f6cLnHyleBGYTFK5IWm6vwg93gCRszWr4daTV+1/zq8jNc/CbgHTwKyLmv58DS5lM=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by MN2PR05MB6510.namprd05.prod.outlook.com (2603:10b6:208:d6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7; Sat, 19 Mar
 2022 07:28:54 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6061:706:1081:df8b]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6061:706:1081:df8b%7]) with mapi id 15.20.5102.012; Sat, 19 Mar 2022
 07:28:54 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH] x86/mm/tlb: Revert retpoline avoidance approach
Thread-Topic: [PATCH] x86/mm/tlb: Revert retpoline avoidance approach
Thread-Index: AQHYOuXrigMuAXPe5kGi5Og255v/tqzGTeSAgAACSIA=
Date:   Sat, 19 Mar 2022 07:28:54 +0000
Message-ID: <C0EED8ED-3F11-48E0-A7E7-5EC016563E43@vmware.com>
References: <20220318163304.2128897-1-dave.hansen@linux.intel.com>
 <D2017D89-2DE1-4DEB-BF5C-9A124D5C7905@vmware.com>
In-Reply-To: <D2017D89-2DE1-4DEB-BF5C-9A124D5C7905@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 894f905b-1acd-46d3-5ae8-08da097a1f5f
x-ms-traffictypediagnostic: MN2PR05MB6510:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MN2PR05MB65100714A5FAD357586E98D8D0149@MN2PR05MB6510.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8S2XgGEN9kLNGCSLVZQjD8XAAzse/U8nzyPbteUMytT6QsUrwjCUT8RIY8YqK8yCATGm1gVNtmbt57s47XXMu4S79kYJJTwupsytr9MguXiMhv0VdlgMa/aJ4yQIvhSRQlkrWdSsh81ayg9zZXwOphWMJRJAVwZvxIsOVxgNspnEtqTrlgFENn0f2UnTpyQMshnj+hu+HhNCVMtPK8CHD9ZFz3CYZPOaVvWQHrP/PeCeM79mX3wECEM+hzy+f4+MAmRCknOqGOuI4ebofcg27AMSaiaEe0xLVrMcBd0TUblJW6+LGqxybKC7YAjcgUJgIKWi6yXCHK7Zka60ifQNqXBeL12ySs7KbvrvNFaMLKoHBcxVqfB/vunIHNeP8zZoVZ6cmk8hOEKqu9fYbsWeKr7jVaZERrUrHSB706koF76kPhkqENzKz4p2mgAGIRKjaMz8iuLAQUyP2ZGvlIrnpJ71icKdVYdSVNv1pnVeYc/cGpsu9mTOVR4LH2I6lg3wmz49kfqHlox7+lUUeu7zbFfqEF56KLxWGFie6oEObgN3EIUCgexxr1oKfGiI89rQxoP9ybbF4UuiJXFj+Ly+9sYXQ/bsn4uhShxvvijcuMCnlg51zE1CcdeEHfQdOdCuwY0xPmFO2ZRbCUCA3oDBCdGzaz2s377nVPK1tG2/iEkTQSzLH1jvi1wmlAs0c/o+bHD24LI6EHrPYlCB+XytSsolYHoOCOhurxsry9kJqADfgF6yLbxomfu08tzA+8QKPrv3uXuf0vTUShYwD5N4+KGyMdxIRatn206/vgrWO57iteVXVs3oXCa+53Sn8TekCkpiqCg/QYxcbc5Ft76kFzbtW442cAZJ4Gw+aAEkkPqy3qtpdPEzf4te4TbbuOM6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(36756003)(8676002)(5660300002)(86362001)(4326008)(6512007)(508600001)(6916009)(66946007)(38070700005)(54906003)(76116006)(2906002)(45080400002)(316002)(53546011)(64756008)(83380400001)(66556008)(66476007)(8936002)(6506007)(66446008)(26005)(186003)(2616005)(71200400001)(6486002)(966005)(33656002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjNsMCt1OHB3eTZwU0RydTZZQlBvZC9MQ3BaWjBEaSt5bzZJdTR5RHFsUnI2?=
 =?utf-8?B?SzI5RTFwaWNCRlM3ek10MXdVcXk5KzY5Q0UwTWJJWWVjdzFXZnRyWTNpSjhF?=
 =?utf-8?B?Ukxzb3NsV09XS0hLWUpDSWVia1R0dEdDWVd0b2ZXaXFUc1Z6YUp6WHA4QnZ3?=
 =?utf-8?B?VnpIVXJIb1JJN0N1NUd1RlpqR052TE1FUWs4WjF5WjJRSmFndkdoZ2t6ZCtt?=
 =?utf-8?B?blBrQTYxUXhHaVQrMS85OEhvL1hOMHI1QnZvbWJBNkQrbzdrWDFCZHp0Sk8v?=
 =?utf-8?B?UEd6TnlySEsvQmdjcGpaWFVNNzArNGcydGdRUThzRW1yOFB1Wk4xSHlpWDI5?=
 =?utf-8?B?cjJlNXFKQVhOdkdUN21UaC9sSER0dks5bUl5UWYzUzFwNm1Tc0t0amo5RjVx?=
 =?utf-8?B?eEM5NTc4Y0VLNjkrN1RFWjd6eG44VGtNNXdKc3JzWDF1YTgyTmdNejcvbXNB?=
 =?utf-8?B?VlozaXJEdkVXRU16UTVNbHBRMW9BeTJORW92SzBUMzV3ODc0cHFRNmQ2SHVz?=
 =?utf-8?B?cEF0cHhucm4zajJ5dHB5bURaODRaYnFOdERTWnFRZVZUdDRFTkFTK01KSU5u?=
 =?utf-8?B?ZnVpdzNzVXFUU0Z5bXJRSDNlRkd1VW5tYmVFd0VtSDFZMzRxY2VGNEEvc2k1?=
 =?utf-8?B?OTIyajNnMVcvVnVKMWU5WXA3YmRZNWxmdm1IeENlcjc4R21rdFVpRUhoaTRG?=
 =?utf-8?B?ZVlCdHdHelA3bzVlc2kwNFFiTkNnUSs1d1l4a1l3S1d5UU0zdjhGcFo4OVlE?=
 =?utf-8?B?eURGZlZOeERISS9RZUtjSytUSXZ3dkphS0hlRnFxNGNPMnJuOXVVbGhCYjl3?=
 =?utf-8?B?dWdQTDgrRGxzVE1YNmFxa055QzNZMWx1RlIyVTAyN2NlMmxDVll2YzZvLy9i?=
 =?utf-8?B?T1cvWFEvSFBSWHpIV1RIWlgvcGlwQU1EZGhhUlBKVUltUDZWR3lSTzdockRW?=
 =?utf-8?B?QUJwR2pFRjRVdW5Ec1JnUEwvNW83cUlVYUdVZnc4K09uQjkyOU84SnNyMVpV?=
 =?utf-8?B?RzBoendmK3RTVStUUmNjSWVqV2RJdk1zQUd3R1VjSXVEL1kxK0lKWjV2emFN?=
 =?utf-8?B?K3VYdFdDR0lqMlpUamJIcGd6WFoyM1hsYzB6cjNNQ04vVmR0NC95bEpDNUQw?=
 =?utf-8?B?SkhtQXl2M1ZUa1lpUy80bzh1cnE1S241Y0hvWmVGTVZmS2svU1ZUUWoxZnBj?=
 =?utf-8?B?SzY3QytrYm9lUTFRYVp5bDROYjBsWDZzaThvNkJRcjYzWGFDb05zSTR5a3RK?=
 =?utf-8?B?Y1dGMEVmN1JaeTQ4LytzQWNuSmkvMW9jbkVKZEVpSys2TUhsaWlMcTR2WUNM?=
 =?utf-8?B?amVVYTd2RllsUW5aaGw4SjVlaGJKdkVENUs2REZMN25kVCt0dTZEMVc4dGpF?=
 =?utf-8?B?ZDU2ckdRSlUxeTJvbUtxV0pUSjR1OHdwTmZJU2RhaGtTQWtYUzcycXIvQUkv?=
 =?utf-8?B?YXd3OVV4MHJ0NHYrQUc5ZnlvMGJlbXRPT0RXaFh0OGhydkVrUmFhSjMxbDA4?=
 =?utf-8?B?YTk0VWZ0OVNHN2dIYUR4ci9pbGFDNEZUcUlESXkwcElmclNSeG4xeDY2K0U2?=
 =?utf-8?B?dWsvOW1XWkUyR09oeHJjOWd6YnROOVFmeHQ1ZCtucDIvUjdMV0syMVBwcmlh?=
 =?utf-8?B?eWwrblBRdkZBemdEdFFtMjJQNUwvdzVmbHcyemZmNWpOc0F6UzBjbkxGaUxr?=
 =?utf-8?B?MTVObkZxUjdYdmdpZzQ1WU53RUswRVNoQVdsUWdDQkpOL2gzcmhKc21nMnBX?=
 =?utf-8?B?ZTdsWWYxK0tiWW5NTTFHcGVJTFdQU3RQZmtXNVlGU24vK3k0RDRuSkN6cmhZ?=
 =?utf-8?B?eWcrTzRCS3pBVGlTWmM2RmwrS3lra3ovcUZBb0wxTWttUjZJQkcrV0RpNlJa?=
 =?utf-8?B?MHY1a0NOZFROUE1IZlNJekxmRFc0ZXlFVTZpSHp4N1VnUEloUENlNG1hVlM0?=
 =?utf-8?Q?nvt+EJvFXXYmJF8L7g77l+O9kzwvAc5K?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2E9D7E3552B6745A8B304A483591C51@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894f905b-1acd-46d3-5ae8-08da097a1f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2022 07:28:54.2255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQEPtYMuf2NV6CRe0hozMGVLn6T7+twYdzdkg4S/ifJYlCUXVx/c8Xi8pJG0OHBKpRJU080NFT9rPsZWucuycw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6510
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDE5LCAyMDIyLCBhdCAxMjoyMCBBTSwgTmFkYXYgQW1pdCA8bmFtaXRAdm13
YXJlLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4+IE9uIE1hciAxOCwgMjAyMiwgYXQgOTozMyBBTSwg
RGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+PiANCj4+
IOKaoCBFeHRlcm5hbCBFbWFpbDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBv
ZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyLg0KPj4gDQo+PiAwZGF5IHJlcG9ydGVk
IGEgcmVncmVzc2lvbiBvbiBhIG1pY3JvYmVuY2htYXJrIHdoaWNoIGlzIGludGVuZGVkIHRvDQo+
PiBzdHJlc3MgdGhlIFRMQiBmbHVzaGluZyBwYXRoOg0KPj4gDQo+PiAgICAgICBodHRwczovL25h
bTA0LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZs
b3JlLmtlcm5lbC5vcmclMkZhbGwlMkYyMDIyMDMxNzA5MDQxNS5HRTczNSU0MHhzYW5nLU9wdGlQ
bGV4LTkwMjAlMkYmYW1wO2RhdGE9MDQlN0MwMSU3Q25hbWl0JTQwdm13YXJlLmNvbSU3QzRhMmMz
ODJiNWVmNDQxMDU0NzQzMDhkYTA4ZmQwYzdmJTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgzZDlk
ZDYyZjAlN0MwJTdDMCU3QzYzNzgzMjE4MDE3ODc1MTQ5NyU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENK
WFZDSTZNbjAlM0QlN0MzMDAwJmFtcDtzZGF0YT1UQTBpQVRRQ25mRGpJWjFsRzNZZGhqTVpqZWxY
clZhdEJqQkU4SHozQWZFJTNEJmFtcDtyZXNlcnZlZD0wDQo+PiANCj4+IEl0IHBvaW50ZWQgYXQg
YSBjb21taXQgZnJvbSBOYWRhdiB3aGljaCBpbnRlbmRlZCB0byByZW1vdmUgcmV0cG9saW5lDQo+
PiBvdmVyaGVhZCBpbiB0aGUgVExCIGZsdXNoaW5nIHBhdGggYnkgdGFraW5nIHRoZSAnY29uZCct
aXRpb24gaW4NCj4+IG9uX2VhY2hfY3B1X2NvbmRfbWFzaygpLCBwcmUtY2FsY3VsYXRpbmcgaXQs
IGFuZCBpbmNvcnBvcmF0aW5nIGl0IGludG8NCj4+ICdjcHVtYXNrJy4gIFRoYXQgYWxsb3dlZCB0
aGUgY29kZSB0byB1c2UgYSBidW5jaCBvZiBlYXJsaWVyIGRpcmVjdA0KPj4gY2FsbHMgaW5zdGVh
ZCBvZiBsYXRlciBpbmRpcmVjdCBjYWxscyB0aGF0IG5lZWQgYSByZXRwb2xpbmUuDQo+PiANCj4+
IEJ1dCwgaW4gcHJhY3RpY2UsIHRocmVhZHMgY2FuIGdvIGlkbGUgKGFuZCBpbnRvIGxhenkgVExC
IG1vZGUgd2hlcmUNCj4+IHRoZXkgZG9uJ3QgbmVlZCB0byBmbHVzaCB0aGVpciBUTEIpIGJldHdl
ZW4gdGhlIGVhcmx5IGFuZCBsYXRlIGNhbGxzLg0KPj4gSXQgd29ya3MgaW4gdGhpcyBkaXJlY3Rp
b24gYW5kIG5vdCBpbiB0aGUgb3RoZXIgYmVjYXVzZSBUTEItZmx1c2hpbmcNCj4+IHRocmVhZHMg
dGVuZCB0byBob2xkIG1tYXBfbG9jayBmb3Igd3JpdGUuICBDb250ZW50aW9uIG9uIHRoYXQgbG9j
aw0KPj4gY2F1c2VzIHRocmVhZHMgdG8gX2dvXyBpZGxlIHJpZ2h0IGluIHRoaXMgZWFybHkvbGF0
ZSB3aW5kb3cuDQo+PiANCj4gDQo+IEFja2VkLWJ5OiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUu
Y29tPg0KPiANCg0KRGF2ZSwNCg0KTm90ZSB0aGF0IHlvdXIgU09CIGhhcyBhIHdyb25nIGVtYWls
IGFkZHJlc3MgKGludGVsLmNtKS4NCg0KSSBub3RpY2VkIG9ubHkgYmVjYXVzZSBteSBtYWlsIHNl
cnZlciBjb21wbGFpbmVkIGFib3V0IHdyb25nIGVtYWlsDQphZGRyZXNzIGluIHRoZSByZWNpcGll
bnQgbGlzdOKApg0KDQoNCg==
