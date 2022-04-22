Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B235350B6B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447263AbiDVMEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346519AbiDVMEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:04:33 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88EC5620A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650628899; x=1682164899;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=06/r0/69KgnFvk575ElLDFwBtsy09Y1HUZcQqgHPHL0=;
  b=Ak5qEoBfE/QcOeUvEWjs3xYP/s0NYdwMm2wTM0AzpIcWZ/4+8m/H+YUi
   el1Ca/YCdLIKKFHBdq4uhGDb8cGElXlT5To6e8OsX41VVHBhigeaUQrao
   K3M8aLbOAWgNlxsrMMb6umrCTDWxHoiZUR72bufr+EUMGTxahP1WW03NK
   KSKKNbWF9jLLVuC5utc8YG9oPw24VdeD3XvWFalhwc11z9V4h3tkkf3dk
   CdMh64PdYBeaB4hhUgVI5bJlYgCDmvhmxavpQdDhkcGbrNUf8CEP12vyb
   5BU7IJBVFWpjUha70Bs53+2VogmXLGPvV5YTTjQ5/haL1G+OjM1xUYozc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="54446530"
X-IronPort-AV: E=Sophos;i="5.90,281,1643641200"; 
   d="scan'208";a="54446530"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 21:01:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj2NZP1ugmS+XIrNrcqQqbJkajJE3Yp9U01yRU/eWHOhr+yTCDDwxX5vZevO1uflK4EbNij5WG/4DvTU7WPLyRWIFrz1g3cVx+31We4qwYG2JL9vBUtWziXr3qcqMWxGX9HKw4N+tdkx2md3v+1LwYQtoVi4dKvQVZaN59ZnK+alVBtBRiHVSbZ4wuHw7n+RVD4CGokeB4rmkTMxpKk5IoY/5GbLOzDzkWyLNlq/XNAC5DfU/ETBi4r8HgE97xrUPiIvy6Gr/ZE+Lbw0oqqQKQbmU2PR/ijuMCYUwwz0u8UYGtFeYeVEG4ckyEUBPqIhamtjBpstkvmDxL3KU0XPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06/r0/69KgnFvk575ElLDFwBtsy09Y1HUZcQqgHPHL0=;
 b=mQjnjFXiKNkZXDDHf8uwg5IUM/WdfhFuYwZTd5BkEOvYfnNvDHjLjp5UrnyqnqdGX6BJeqQX3wvO8uVX6SuHQyBmwCW3Yhqr6ufJAQBoFBjgQrc/pximj6X3j1uU9OSjQP0x0uhKeY4j5xG4ZmwEiAIuAQMfUlIdmutTt5LZfL4rPojJ/yfAXZt0gdmCG5FeBG1ZhRhls+q/VtKiN6dUB8Szmgxa6zKtvSNWBKDShzmfV9JOKbrcuCgIcb+ZImCecg1cb7A5Er9/HePz87b2wWM5WC6PJ9/vy9BJCM7I3QCbi8FQyDSBZ07K+aJzo8F1QpckLgVZRxx2kqYDNqom1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06/r0/69KgnFvk575ElLDFwBtsy09Y1HUZcQqgHPHL0=;
 b=Y3tYGFVYOZCwDRT1+8vmZDFj8HnRgfZlBEgVPdLGGrf6oHJkf6Y/C0x/F+cbTSjuWUsng7knZWYYRbIco+pVzPLq2HdWR5Q02kV9LwYQ+7vgqX0+W+NeFI9EkQZSo9jIqfiutNceS9avH9cxJQHpCE8KNGo1sxiS9rbwYSPE61U=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by TY2PR01MB3660.jpnprd01.prod.outlook.com (2603:1096:404:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 12:01:31 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::382e:99b:f0f9:b18c]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::382e:99b:f0f9:b18c%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 12:01:30 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>
Subject: RE: [PATCH v3 6/9] x86: resctrl: pseudo_lock: Fix to restore to
 original value when re-enabling hardware prefetch register
Thread-Topic: [PATCH v3 6/9] x86: resctrl: pseudo_lock: Fix to restore to
 original value when re-enabling hardware prefetch register
Thread-Index: AQHYVGMQTggD3SnyckyLsQJZXsnuz6z5SVaAgAKMYRA=
Date:   Fri, 22 Apr 2022 12:01:30 +0000
Message-ID: <OSBPR01MB20375064F05D713766BF210D80F79@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
 <20220420030223.689259-7-tarumizu.kohei@fujitsu.com>
 <2eb705cd-8607-4b8c-2c0b-31265d503eed@intel.com>
In-Reply-To: <2eb705cd-8607-4b8c-2c0b-31265d503eed@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8eb4c60d-cd32-466f-68be-08da2457d693
x-ms-traffictypediagnostic: TY2PR01MB3660:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3660365EEB9D0F035BD9794080F79@TY2PR01MB3660.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V43jGpW6rr4ehdRV/wir5JNM8Jv6DX1vxx42+nZ+Kd8hRbFbEY8bLLFyQEszXi5bKKfaHX9yzjv7IM5WLTHysgrLmmj+SR79D3rujFiESXdq2JZgLUF8mv+xiX9ueOSgqk6xxePLluSiHfOmKVSGWXWfZ8WJlb6YuakpxW0TrQ+oJKLM2b4gajZ3mbNRUaELg35NB7FcG9FRxTE4YT3BZZDm2JrLdE6tKI6U51u3mi3G/O+kIDiReuIV41nrylKh3egXZhAkzJbCliCz5gGbL2VTOEQ0ggnG563hg0E7xC0l+qGA0l2HIvgYAV687NQefs3denda1fvpVeqt6/I/Nsy7yNTq2QWb+l6/mG6Qfmsv1XXpBybMPjU77PVgsHSbJ+k3XT90jMdeNkEf6QS8xYovOhl7gv3PmNVMsATigFDACWmJCqPafsX+Vz+ADgWkvdEJamfgWh7z8f4WweotGZRJ7vsxOPZuwOb6q40RQgSl6PFN8p9ySSCqHn5wv92yqm+7WTFvsPSMJo+TDpZVgbRtdBVf154Ys4k3iEyt/lXt1hKTihLz4rU8+He4tLGEs3+3lD1EsfOJ4MPTIU+SeUv/JXChNhskk0ky2ARH+gf24jwm3+mLGfOyIaZOrtaX7WGaXc9o7WB8QfFki8k1Z8+pBFFQJvMb9hQLdh6zYu69oL37kJCqazqjF/Pyz7dZbQ8mR7p+ZyuwClIIihNol+3FhcTGhcSPVOX5iiWMiq8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(186003)(7696005)(66556008)(4744005)(83380400001)(76116006)(26005)(64756008)(33656002)(8936002)(66446008)(66476007)(85182001)(8676002)(7416002)(9686003)(2906002)(66946007)(6506007)(5660300002)(55016003)(508600001)(38100700002)(38070700005)(52536014)(82960400001)(110136005)(316002)(122000001)(86362001)(921005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEhIakI0d3JtV091b25UeFlrd3dRY3JKc1FuUTIya2Vnd2tjUjFLRXBtWnVy?=
 =?utf-8?B?dUhoVUhxR0Zlb2pmSkZWcWZhOTk4NU5nTWZXRW5GNzJraVNGNXdkSEVHVkJX?=
 =?utf-8?B?U2NBeng3SVFBWExjVUN6VlR5QmxYdGhZMUd4R0xOUXNFS2tGMU5odjJidDZP?=
 =?utf-8?B?eGNjakxlcjlBKzZJbngyeE9kQ1FkcmhVRGJxeURXbGZSU1pVRHhKVldscVRE?=
 =?utf-8?B?aTViVTJmSmxGRkFGTm1QQ0djUkVxVWhUVlk5L3NSMnozU2REQXNQRXl4ZDFS?=
 =?utf-8?B?blZQSURxcmY2aEMwb1kxWHpFMmYwN01hdWVWMnFjODF0d2pRMHhveWtmV3VQ?=
 =?utf-8?B?Z2l6SVNwSW4yNjhraTZkOTlybDkvUU9LNVBUVjJaQkUwY2RRbHJ6UWJzSUpw?=
 =?utf-8?B?N1VnUVVpUUgyWmxoc0d0ZnZscENrcGNlNHhIOGd5bTVKZjRBTjNtblo1ZXl4?=
 =?utf-8?B?WndvSkFkRDFwaVJNQ09YL0JQZ2hXa214YXJ0ZXd3dDFwTHNOSnpyNGU0NVV4?=
 =?utf-8?B?bE9Ddy8vNEVLd0hGWWVOWk4xUU15ckhlcjJFT1lsRGt3SlNOSDRERk1NRDh3?=
 =?utf-8?B?ZjhMTUJKeERvUDZBWDFWczZKNEFGU0F2d0tJcU9GNWhWTkJKczFDZk4yZDJT?=
 =?utf-8?B?dW91OWUwSUI1eXZyQ0RvLytxTXRoeXNqUW9MUUpmVzRKZ0NPcXVDUzgxY2Z0?=
 =?utf-8?B?M28wV3pEb3o2QmJWUlVkSnFXTWNnc04xeU1ZVnlCLzdxSkhSYWZPZ3llTW1h?=
 =?utf-8?B?b3ZQT1dETUVpaVNRUXRtK2Z3RGlpNnhLS2paUVlqUEpHQ2ZhTm9oenJ4RHdM?=
 =?utf-8?B?Y2l6TkxyZkV5ZHptNms4dUhUNkgrZlFnTkFXNFIySEU4dFM5K2V1U1NKYm9E?=
 =?utf-8?B?Lzk1eGpaNFd3NXh1NXBEUHdzT0hoeXA1bXdtUXRpbXhZYloyZ1BRcnl3Mlow?=
 =?utf-8?B?REJQN3Q2Y3NBYnBmWThPWGhYSkR6dlloamZ1MFNyTlhvYWp2QTlneFZDSmhP?=
 =?utf-8?B?aVcxYmUzMyt4aGwvc1VRY1lycDVEa2JHbUErUVpsYnBzaVBpblh0TjNmaXFh?=
 =?utf-8?B?VGREZ2pScU5DS0dNeHJGVU5nRW9aT2YrTmNpNjhLM3Q4dW9ORCtjYjdVQnVv?=
 =?utf-8?B?eWUrVHprUnVjaXl3bU04dUorYURXbWYrbFNyU1FTVTVyZTAvRnVnTFZ3Znds?=
 =?utf-8?B?WE5ZdWw5MzJSQ2l2UmJwS1hkUHNkaENQaTVqN1pSclFpRmg3eDUxTXpiV3Z6?=
 =?utf-8?B?YVpuRE1zSm9uNEFnN1BZaUorRjNPcyttMkg5cFprMU0yd2JIamtqZ0I4RnpB?=
 =?utf-8?B?WVBMS0VIZUxoekRlRkVGS0xqT3orTmJEbzMwUzMybFVQVzNjaTg4R21GQ2xO?=
 =?utf-8?B?eXJ6aUMxZHZJZS9SbnUxOWc3SUsxaVN3SjN0N29lVFBMK3BWMTVoQWpTU0c3?=
 =?utf-8?B?ODZkRnpnQzJVMVpFNS9xcU8yVEd5Z0RWdDR3T1BjbnRGZ1E5T09wTmFJaGpH?=
 =?utf-8?B?VUxDL0twUUVFZlltVTZDSEZQcXhnajgxem40VHZjTzBwbWI4WTNSUTM5Nzcw?=
 =?utf-8?B?RkZNMDNlVmVoMDU5WXFObkJoTzZUeWQ3MGorL29XNDVXWVB4bVNBRUlJUUJ6?=
 =?utf-8?B?K2UvbW1VK1BBcG5MS1dBcGtWaEowVE5CZU9QNXBOUzRSOTlYVDVMcjVKZnZq?=
 =?utf-8?B?amRiTXkxK1pjK1JFM3NrYUlzNnp2aUp3VHhRRmlVTlh2MHVqSllmdFhmbDg1?=
 =?utf-8?B?M0hsY1cwdFh6aFlkVTRROFcrUmFCMHgvQnBzZUxyeEE4WEFMSTg0emE0ZTZJ?=
 =?utf-8?B?VitrZTM0bmt2VndxWHRaZG0zZFEzbFU3NW5QdGhmN0RxUlRPeUtlWU8wTnJB?=
 =?utf-8?B?RytXQ1V3bzJWcGxrRkkxelFrTmJxVDNUa3Nqb1huZkRkYnBoU0RmZnlteWFR?=
 =?utf-8?B?SGs0eElYcHZ4cG9WdzNITHFDRkhnempyMlhPdGFWVDB0RWNibnJLekYreHU4?=
 =?utf-8?B?WHlrYVRzSGF5Q1hvemN3WHFsWUxITjRMdDI5bVdRN0VHRndtTTN0V25wQ0FX?=
 =?utf-8?B?Z0xhQVpqbm1ERHFjZUtYNzlDNHN1Z1J2bmJPOGlKR0xxeTBqK0YxMWdjZGZI?=
 =?utf-8?B?eFlSUitvZWJjNzh0ajYxUFlaVEJXT1BqMG1sWmUxYlpram9LTDR1OXQxaTJ3?=
 =?utf-8?B?NGo5YjBKdXJWR3BzeVFGUnJYRGU0dFRsUGs2ZHNvTzZUNnlCdWhQbEdzcGFk?=
 =?utf-8?B?Q0JzSHJiUXZjMS8yQjkzL2lsNWNaZmlJcER1TFF6ak9YeE9qNE9zWmMyajJu?=
 =?utf-8?B?RG5NNDNSQldLYXhSQmFoNTEzaU9FV0lPSXNjZ0FzdlVIa3J0d0creEkvSkZ3?=
 =?utf-8?Q?qfcci5LKOfZ8C/hg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb4c60d-cd32-466f-68be-08da2457d693
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 12:01:30.6617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /k4+uiucPzjyr6uSkEhjit+8xlbybHw/6fBn9eiUJz88iHxqgAh4xQXqdhS0rvYMvIv11aleIM2MLEWgI7iUWmGH3AZBQX8bt6EKr7wgyB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3660
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB0aGUgY29tbWVudC4NCg0KPiBJdCB3b3VsZCBiZSBuaWNlIHRvIG1lbnRpb24g
dGhhdCB0aGUgd3Jtc3IoKSdzIGluIHRoaXMgcGF0Y2ggYXJlIG9ubHkgZG9uZSBpbnNpZGUgb2YN
Cj4gYW4gaW50ZXJydXB0LWRpc2FibGVkIHJlZ2lvbi4gIFdpdGhvdXQgdGhhdCBsaXR0bGUgdGlk
Yml0IG9mIGluZm9ybWF0aW9uLCBpdCdzIG5vdA0KPiBvYnZpb3VzbHkgY29ycmVjdCB0aGF0IHRo
ZSBzbXBfY2FsbF9mdW5jdGlvbigpIGluIHBhdGNoIDgvOSBpcyBjb3JyZWN0Lg0KDQpJIHdvdWxk
IGxpa2UgdG8gYWRkIGRlc2NyaXB0aW9uIHRoYXQgdGhlIHdybXNyKCkncyBpbiB0aGlzIHBhdGNo
IGFyZQ0Kb25seSBkb25lIGluc2lkZSBvZiBhbiBpbnRlcnJ1cHQtZGlzYWJsZWQgcmVnaW9uLg0K
IA0KPiBUaGUgeDg2IGNvZGUgaGVyZSBsb29rcyByZWFzb25hYmxlIG90aGVyd2lzZS4gIEl0J3Mg
YSBsaXR0bGUgYml0IG9mIGEgc2hhbWUgdGhhdA0KPiB0aGlzIGlzICpPTkxZKiBmb3IgQlJPQURX
RUxMX1ggZm9yIG5vdywgYnV0IEkgYXNzdW1lIHlvdSB3ZXJlIGp1c3QNCj4gY29uc2VydmF0aXZl
IGFib3V0IGl0IGJlY2F1c2UgdGhhdCdzIGFsbCB5b3UgaGF2ZSB0byB0ZXN0IG9uLg0KDQpUaGF0
J3MgcmlnaHQuIEl0IGlzIHBvc3NpYmxlIHRvIGltcGxlbWVudCBmb3Igb3RoZXIgbW9kZWxzIGJh
c2VkIG9uDQppbmZvcm1hdGlvbiBwcm92aWRlZCBieSB0aGUgSW50ZWwgU0RNLiBIb3dldmVyLCBJ
IGRpZG4ndCBpbXBsZW1lbnQgaXQNCmJlY2F1c2UgSSBjYW4gdGVzdCBpbW1lZGlhdGVseSB3aXRo
IEJST0FEV0VMTF9YIG9ubHkuDQo=
