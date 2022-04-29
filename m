Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A062F5143FE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355640AbiD2IYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355670AbiD2IXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:23:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63526D8F;
        Fri, 29 Apr 2022 01:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651220434; x=1682756434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YEy66dqIvVt554CXlGGwT02HRskcbYjqiaqCrLgSDXc=;
  b=uDewBHxbLzwQK287LD7poh/flhxdSfXrQimDI/+EDeFt/qqA7TxuFI3b
   79tLQ0aoYCLxQvoWJuxzXCpsOSXR8Dx4hhD65v09DOjRiI1cXcClsPqtK
   33nHDmXuWT/nCii/LYL7EqZipBwEXq0pQAHW1992MgKoWooeZThTxJMmb
   FOLtXrM5sZKnOTK8UimQqVK44Yrj4k1nivwUwXEIc7ugqGvTn28xgH5fR
   1gwF1lybZ1EpNZ7Fme0+O/h90aUUq+8idzchPom8NHrWjnfkUgh+5R5xS
   b0Lit8oM3ugVH5VeeYA/0dgKcKIseoSO3hOuPBYa/OVXBq41hgEor8A6P
   A==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="157267357"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Apr 2022 01:20:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 29 Apr 2022 01:20:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 29 Apr 2022 01:20:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjTtOumaZa9lVcgbQ7+C7XfAEce/yZgiCA9GklrwUcUaKFuTzWZvOjM9/wHVTyioOBsR/kq8ssQVNpm08Rtq0bIS8GjzpsWaRNA7s/7PCDMBES4KKwSzWB/x66Wr9F31All49+LA2Lobly0Z7P7GU6I8LVuFCXQe92qhQ/L4op1whGIaCc0s48icjhoSK8G/8LMEo7ZZPNU6UqQB77x92mAUjPVPveK3Ya/BGR6iFqN3oRioFmUXG4o/+z8kShUu7Hz/cg3p5FJ1zI47u5JCXRNCVzqsEqq3vTHcTqPOSPCu0L+IlYHdN8cYU35XKUEaVgx/YBjC6mvLL1lwQmI9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEy66dqIvVt554CXlGGwT02HRskcbYjqiaqCrLgSDXc=;
 b=H5iNMElF1T7Zk0LSZKOtMDRjw7nOc2X9DyAboKPnEmXtTDdBpOg2J2ZYzFtFP8Q/qk9LhVy8Tgp08KFAl9s2QgLCi0tr9FnbpkUwvnKQwgPqK858q043TzjbIUdzLi1YKIaB66lRpENsFcr3o9Cl65lBh0qb+dXJ6XeaIlfZ8TmsX5kWDR6w8Ez3Xp77euwfpJ2XJ7O1ncVtPB9J+th1baTUWqs1n57Ztd9p0U6vathUNp6CP19p9h+g5TasrF+827YvTsbsXlnGeZkZrWn/4O+pqoBd/VZiCCQUseP875DLDyF51Uqy+FYWfvx7wpr/bsMbVFWEgO2ZLxDZsMkMrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEy66dqIvVt554CXlGGwT02HRskcbYjqiaqCrLgSDXc=;
 b=nvhTynSVh/YF7Qo5IIBeD7QSTyedTN0m3YTSuB1QwOGXQVTwkXSNLFAk/UpbOSg031jDk/x8T6T9fbGPfWt4GO84mUZVvT73VZFY1Rx3kVD1J5rpj5KusgKw5IJYFUQmJXmFrz7b8OT+Zzkh2q4EbAFmvJzwLZovRkPv5SSy/pI=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by DM5PR11MB1305.namprd11.prod.outlook.com (2603:10b6:3:13::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 08:20:25 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::39cb:eae2:1dbc:a5f2]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::39cb:eae2:1dbc:a5f2%8]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 08:20:25 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <hverkuil@xs4all.nl>, <linux-media@vger.kernel.org>,
        <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v9 00/13] media: atmel: atmel-isc: implement media
 controller
Thread-Topic: [PATCH v9 00/13] media: atmel: atmel-isc: implement media
 controller
Thread-Index: AQHYNGSL7RD2tHVvQUiepBZFYhl0460G1v0AgAAEK4A=
Date:   Fri, 29 Apr 2022 08:20:25 +0000
Message-ID: <9111ee7f-9eb9-5da5-f65b-6e868f2e72f4@microchip.com>
References: <20220310095202.2701399-1-eugen.hristev@microchip.com>
 <d76bab1c-6547-5b9a-ad17-25a73bcc899d@xs4all.nl>
In-Reply-To: <d76bab1c-6547-5b9a-ad17-25a73bcc899d@xs4all.nl>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd14c0cf-20eb-4c15-e587-08da29b91c8f
x-ms-traffictypediagnostic: DM5PR11MB1305:EE_
x-microsoft-antispam-prvs: <DM5PR11MB13053D9B5AC4D8D84BB9D8DEE8FC9@DM5PR11MB1305.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IbnxGNp8xQ2+dReBAbFvoSXlcHI5dkPD7Fvt+4raBaz5f0/+i9Idxr2pwnHm9iMJWQZqaE/JhXDp7dlAFxMEBBrp1wRhLyGPeZ5gsg94jUhi+hfVrG2ofkwbnnfVI8lPgTziNe1AQAsfPH24lZSMqIptnStpzSJ39hbTjxfTqkq95xqjOzva4hmUwvcgIb2TJEYhyNL/SooQ/DVmPUkDb1vOzoGWl9ZyzYa0SfzZgQ8UIV5Zichb9wGWTXC7/pkN4wN8XwK15ZBT2/Kad7MTBFL3Ydga5DsxmiieuJd1mV65TCV87PO/EgplF//IkWErXVxCPBVFYLHyVCVxwYW4XsrJpToiHKmdgf9BCTvmd1yEdu9XhtJa4deVtnrrSJk75+Gfekeg/xbJMR0rXKT05HmBXRejvTCn4Tp7qWvtIzp1ZJlu1s7z0Gc4+iT/AA59eYtXj7GvgzqO8DfvBvifA+3TQQSO8wbJCHT7cHPwODaUJni34wucnSbERNzKAnF/taf+6dhEwneLNtoKnL/PldIWF0iZVuw6AyehkDU19vsTr+B7g+732tYtfBr83liCLenGzLWx2theae4+2K8ZDJ9GbXInamzc9yFto+nanPstVGLq/fOGPsZf8jlYFd1UvRffrDf+FnHI/39XRjKV14Wp+iWPs+9tu4UAfZpJb11K9D3nrgpVuNAMB2B2IHQW6u7hiVrBNsk9Jmzqd22NA/5OIFseF3sD9sP3XtKK7UqOV/ZzxXfxZVyxfbRqefmr/M247lu7iT/k3F43eDEWaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(122000001)(38100700002)(107886003)(38070700005)(83380400001)(54906003)(66946007)(31686004)(4326008)(8676002)(91956017)(66556008)(76116006)(110136005)(64756008)(36756003)(71200400001)(66446008)(66476007)(316002)(26005)(508600001)(6486002)(31696002)(53546011)(6506007)(6512007)(86362001)(2906002)(186003)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0RleDVTTXZsSDBLY2tWZlIzUXJWOUZnMFdHSkxLZ1hWKzRnTU83cFpDa1ZG?=
 =?utf-8?B?a1VoNnJxbzFnNWlDQW4waVdWQUZ4VmRmWWlYQzhZSDdldkk2NS9jZDRXOENU?=
 =?utf-8?B?OU5PS2ZObk10b0toSFNISUtVR3MyYUpDREdvcUFrbE9Ua1VzSXZvS3kxT1Jz?=
 =?utf-8?B?bHl4S1ZtNndWNnhMRVpVN0V6RVlPazZxek5ZT0sxK1VFeEpLVUhEUnozand0?=
 =?utf-8?B?MFFPUzdGbDBVbHVOV203bEZ1R05lNVJKYjRBeEpqdi9jT1A3dEpydGZtQVFR?=
 =?utf-8?B?clB6NkxiMTlYRlpjb3dKUVVjYWJQMW9wM1VtNjVjSDgvM1RxOWFmSHhvaHR3?=
 =?utf-8?B?WnZyMWxHaFhIbU5mK0xkbytWcVEzalVaU2hYeXd1UzlDWXZwd011bUJhSStt?=
 =?utf-8?B?Nko3eXNCTTlLYlk4U2gwUDVoTzF0dzJWRXpBY1VXUHZyUXVMOWtpUUpWZ3VX?=
 =?utf-8?B?c2cxYzlJWnQzS1NLb0RlVm5kTmdNT2d4Q0lydERnY3hJbTc1U1hUSktHLzV6?=
 =?utf-8?B?L0hoejdPRlZ0TTJjWlFOR0c1YWkzaCtnK08vSEpBYUV3ODl3eUpFMnd1LzNW?=
 =?utf-8?B?ejRteFdlNEFwMVJBL1BsSDZ0b2VuMkZpbXBtdktDSHNHQks3dG1pZmM3WnVm?=
 =?utf-8?B?enZvUWMzM1NFb2c5a1VZaGMxYVQ2OEZ4T2poWkxPSEw3VEl5NG5COUd1b3Nh?=
 =?utf-8?B?b09OOG5DakdCRkdLeGhGcjJ1VTBkOGIwUnQ1bXZOT1hxQlhTZXZJYzlQNE5Z?=
 =?utf-8?B?dVVjRGtpMlFMV1VCNlowL2VkSk1IQlRCdWd1OG02MUJKTFBRTndBRVVsNFFX?=
 =?utf-8?B?N2FHUUtUZTNvRDNWcVlJUkFqVVZINCsvNHp0VTJweWNURjFCb0Q3aVdJV0Fy?=
 =?utf-8?B?UExrTERtbnF5YllJSGhFZ1cycjZWVlUvQ2RLUzZOUU5lZ3ErUFhUZzhGNXg5?=
 =?utf-8?B?Z3FycEZWc1RsRkdSS093YU15TVBzN1g0YzdkVXRNeHRtNkhGbStFMlR1UmtV?=
 =?utf-8?B?OG00cGEyYytUMnJwTWNWMEdnT0RxcWJFOElrV3ZMT0NDSXhGVEh1eThxcU1Q?=
 =?utf-8?B?SU5NSXMxZ1NOOGp4ZGZoUmN3dG1uOVZEdk5kWC9iaTVNcTFMa1R0ZEtQN1JK?=
 =?utf-8?B?WjZEVVBnUkNpY1paRjViYzNhakl3OVhGSm1zRmY3NWJNY0NacWd0SGo5RE1y?=
 =?utf-8?B?djhGT0IvdFppYVlyRmExTUdONXA4QjBvblVpVVhhcFJwUXQyNGRqellTMzRn?=
 =?utf-8?B?WExJVzhmQXUxbFJFWGdRemtreEFuZWhIa3I0eURFRGpFUncxOXJrNzUyQ2Rh?=
 =?utf-8?B?SFU2ekx5VGpPQ2tXOTFnZGhBbTJKdEpiY0ZmNElNcTBybWdrZ05zdk5rQVNF?=
 =?utf-8?B?UzNlcFd5NXhLV29ZUFVZSExURUJGR052L3c1QkhJYTlKbnVuY2N5VDBXOVF6?=
 =?utf-8?B?WXZBOU1qNGlNeUFzS2FSVFNQaytZL3pvaHEwOFFzb3JpVHJHbnAzVVhVSDhJ?=
 =?utf-8?B?ZUtZc3pCano4WlEzVW45VytDMGExa1U3a2FHNXM0ZmtXMW1wR2EvTzJOTlFa?=
 =?utf-8?B?QmM0b3l0RHR5Q2xFV2JtUkhCWmhXclM4SHhjVHNnK0FSOHdENjhua0xVd2xo?=
 =?utf-8?B?YkcwWHpKQ0szU0hnRHZZTTFRcUFTWXlvcmNHUUZ1aVVFQklhUStJZFpFckZa?=
 =?utf-8?B?bjFIRzlmS1ZkNDJZeW1DSHd2YmFScHRmNGpQclIwWnJ5eXcwOFBmeitBbFpz?=
 =?utf-8?B?eithcllmVHVOaWZkYnI3NGtVYzllc1pMNEMxR3l5cHJocXA2eWF6ZWxBcmZk?=
 =?utf-8?B?SWtab2loM3V0QWxNNFN2MTlNcFVMSFhVSUdSTG5aaE9uNGhZbndVYjRlbWdZ?=
 =?utf-8?B?dWRrNWQ3QkszRlZiUHVycDZHa1Y0NXFNZDVtWDNCSjFmT28zTjU1S0g4eXVr?=
 =?utf-8?B?djl3dko2NFhYN3FTZUZGbEtPWEJaMytwY0svKzdpTU8vbzRxcG9xUGxlT0wy?=
 =?utf-8?B?T3ZYQnpMNnVweW5GbUExVUZYemdhTFFQakNkZ0l2d0NKRzJPMTdGYmVjdEkv?=
 =?utf-8?B?UWlsVzd0QWIwY3BkckNsOCtKV05IZEh3L0N2dHVrcWI4Q1BnaWZiMEJVSVI4?=
 =?utf-8?B?a0dUV0pzVElYcEUzZGZyS2U5TUhyaE10U2R2Mm5BRG9OMXhkeHlvWmxFRkdU?=
 =?utf-8?B?Zy8wOHhvaDF2b2l2OHV1N0hjNXJwS0xvU0lxV1ZUTWVhKzd2R3d6aFBuQlhP?=
 =?utf-8?B?bFlFTUk2SjJsOG4wVGhIQkYvQjh4aHNzN0xDVUllRVRGaElteFk4UGRQSitq?=
 =?utf-8?B?WWxtNzNqQ3Rlem9EYzlYcEVIVUVIUU9DaExIWFc4M1BzbWxUOGZNWTZmcVpI?=
 =?utf-8?Q?Gv60we22CIUZQ6tY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C6FE96EAF84AD43827699B90A045E34@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd14c0cf-20eb-4c15-e587-08da29b91c8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 08:20:25.0758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WyWN1k/TdYc0MuTRVNTdirdWwZrUq23dBxWMQwEEVmcvAHpP7RMev3L3m8bmfs7A/2dpIcFG1aFHcNdO12d1hjKuMGOkMYmT8gFw8juwB4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1305
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yOS8yMiAxMTowNSBBTSwgSGFucyBWZXJrdWlsIHdyb3RlOg0KPiBIaSBFdWdlbiwNCj4g
DQo+IE9uIDEwLzAzLzIwMjIgMTA6NTEsIEV1Z2VuIEhyaXN0ZXYgd3JvdGU6DQo+PiBUaGlzIHNl
cmllcyBpcyB0aGUgdjkgc2VyaWVzIHRoYXQgYXR0ZW1wdHMgdG8gc3VwcG9ydCBtZWRpYSBjb250
cm9sbGVyIGluIHRoZQ0KPj4gYXRtZWwgSVNDIGFuZCBYSVNDIGRyaXZlcnMuDQo+PiBUaGUgQ1NJ
MkRDIGRyaXZlciB3YXMgYWNjZXB0ZWQgdGh1cyByZW1vdmVkIGZyb20gdGhlIHBhdGNoIHNlcmll
cywgdG9nZXRoZXIgd2l0aA0KPj4gb3RoZXIgcGF0Y2hlcy4NCj4+DQo+PiBJbXBvcnRhbnQgbm90
ZTogdGhpcyBzZXJpZXMgYXBwbGllcyBvbiB0b3Agb2YgY3VycmVudCBtZWRpYV9zdGFnaW5nIHRy
ZWUsIGFzIGl0DQo+PiByZWxpZXMgb24gcHJldmlvdXMgcGF0Y2hlcyBpbiB0aGUgc2VyaWVzIHdo
aWNoIHdlcmUgYWNjZXB0ZWQuDQo+Pg0KPj4gVGhhbmtzIHRvIGV2ZXJ5b25lIHdobyByZXZpZXdl
ZCBteSB3b3JrICENCj4+DQo+PiBFdWdlbg0KPj4NCj4+IENoYW5nZXMgaW4gdjk6DQo+PiAtPiBr
ZXJuZWwgcm9ib3QgcmVwb3J0ZWQgaXNjX2xpbmtfdmFsaWRhdGUgaXMgbm90IHN0YXRpYywgY2hh
bmdlZCB0byBzdGF0aWMuDQo+Pg0KPj4gQ2hhbmdlcyBpbiB2ODoNCj4+IC0+IHNjYWxlcjogbW9k
aWZpZWQgY3JvcCBib3VuZHMgdG8gaGF2ZSB0aGUgZXhhY3Qgc291cmNlIHNpemUNCj4+DQo+PiBD
aGFuZ2VzIGluIHY3Og0KPj4gLT4gc2NhbGVyOiBtb2RpZmllZCBjcm9wIGJvdW5kcyB0byBoYXZl
IG1heGltdW0gaXNjIHNpemUNCj4+IC0+IGZvcm1hdCBwcm9wYWdhdGlvbjogZGlkIHNtYWxsIGNo
YW5nZXMgYXMgcGVyIEphY29wbyByZXZpZXcNCj4+DQo+Pg0KPj4gQ2hhbmdlcyBpbiB2NjoNCj4+
IC0+IHdvcmtlZCBhIGJpdCBvbiBzY2FsZXIsIGFkZGVkIHRyeSBjcm9wIGFuZCBvdGhlciBjaGFu
Z2VzIGFzIHBlciBKYWNvcG8gcmV2aWV3DQo+PiAtPiB3b3JrZWQgb24gaXNjLWJhc2UgZW51bV9m
bXQgLCByZXdvcmtlZCBhcyBwZXIgSmFjb3BvIHJldmlldw0KPj4NCj4+IENoYW5nZXMgaW4gdjU6
DQo+PiAtPiByZW1vdmVkIHBhdGNoIHRoYXQgcmVtb3ZlZCB0aGUgJ3N0b3AnIHZhcmlhYmxlIGFz
IGl0IHdhcyBzdGlsbCByZXF1aXJlZA0KPj4gLT4gYWRkZWQgdHdvIG5ldyB0cml2aWFsIHBhdGNo
ZXMNCj4+IC0+IHJld29ya2VkIHNvbWUgcGFydHMgb2YgdGhlIHNjYWxlciBhbmQgZm9ybWF0IHBy
b3BhZ2F0aW9uIGFmdGVyIGRpc2N1c3Npb25zIHdpdGggSmFjb3BvDQo+Pg0KPj4NCj4+IENoYW5n
ZXMgaW4gdjQ6DQo+PiAtPiBhcyByZXZpZXdlZCBieSBIYW5zLCBhZGRlZCBuZXcgcGF0Y2ggdG8g
cmVtb3ZlIHRoZSAnc3RvcCcgdmFyaWFibGUgYW5kIHJld29ya2VkDQo+PiBvbmUgcGF0Y2ggdGhh
dCB3YXMgdXNpbmcgaXQNCj4+IC0+IGFzIHJldmlld2VkIGJ5IEphY29wbywgcmV3b3JrZWQgc29t
ZSBwYXJ0cyBvZiB0aGUgbWVkaWEgY29udHJvbGxlciBpbXBsZW1lbnRhdGlvbg0KPj4NCj4+DQo+
PiBDaGFuZ2VzIGluIHYzOg0KPj4gLSBjaGFuZ2UgaW4gYmluZGluZ3MsIHNtYWxsIGZpeGVzIGlu
IGNzaTJkYyBkcml2ZXIgYW5kIGNvbnZlcnNpb24gdG8gbWMNCj4+IGZvciB0aGUgaXNjLWJhc2Uu
DQo+PiAtIHJlbW92ZWQgc29tZSBNQUlOVEFJTkVSUyBwYXRjaGVzIGFuZCB1c2VkIHBhdHRlcm5z
IGluIE1BSU5UQUlORVJTDQo+Pg0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+IC0gaW50ZWdyYXRlZCBt
YW55IGNoYW5nZXMgc3VnZ2VzdGVkIGJ5IEphY29wbyBpbiB0aGUgcmV2aWV3IG9mIHRoZSB2MSBz
ZXJpZXMuDQo+PiAtIGFkZCBhIGZldyBuZXcgcGF0Y2hlcw0KPj4NCj4+DQo+Pg0KPj4gRXVnZW4g
SHJpc3RldiAoMTMpOg0KPj4gICAgbWVkaWE6IGF0bWVsOiBhdG1lbC1pc2MtYmFzZTogdXNlIHN0
cmVhbWluZyBzdGF0dXMgd2hlbiBxdWV1ZWluZw0KPj4gICAgICBidWZmZXJzDQo+PiAgICBtZWRp
YTogYXRtZWw6IGF0bWVsLWlzYy1iYXNlOiByZXBsYWNlIGlzX3N0cmVhbWluZyBjYWxsIGluDQo+
PiAgICAgIHNfZm10X3ZpZF9jYXANCj4+ICAgIG1lZGlhOiBhdG1lbDogYXRtZWwtaXNjOiByZW1v
dmUgcmVkdW5kYW50IGNvbW1lbnRzDQo+PiAgICBtZWRpYTogYXRtZWw6IGF0bWVsLWlzYzogaW1w
bGVtZW50IG1lZGlhIGNvbnRyb2xsZXINCj4+ICAgIG1lZGlhOiBhdG1lbDogYXRtZWwtc2FtYTVk
Mi1pc2M6IGZpeCB3cm9uZyBtYXNrIGluIFlVWVYgZm9ybWF0IGNoZWNrDQo+PiAgICBtZWRpYTog
YXRtZWw6IGF0bWVsLWlzYy1iYXNlOiB1c2UgbXV0ZXggdG8gbG9jayBhd2Igd29ya3F1ZXVlIGZy
b20NCj4+ICAgICAgc3RyZWFtaW5nDQo+PiAgICBtZWRpYTogYXRtZWw6IGF0bWVsLWlzYzogY29t
cGFjdCB0aGUgY29udHJvbGxlciBmb3JtYXRzIGxpc3QNCj4+ICAgIG1lZGlhOiBhdG1lbDogYXRt
ZWwtaXNjOiBjaGFuZ2UgZm9ybWF0IHByb3BhZ2F0aW9uIHRvIHN1YmRldiBpbnRvIG9ubHkNCj4+
ICAgICAgdmVyaWZpY2F0aW9uDQo+PiAgICBtZWRpYTogYXRtZWw6IGF0bWVsLXNhbWE3ZzUtaXNj
OiByZW1vdmUgc3RyYXkgbGluZQ0KPj4gICAgZHQtYmluZGluZ3M6IG1lZGlhOiBtaWNyb2NoaXAs
eGlzYzogYWRkIGJ1cy13aWR0aCBvZiAxNA0KPiANCj4gSSdtIGEgYml0IHVuaGFwcHkgd2l0aCB0
aGUgb3JkZXIgb2YgdGhlc2UgcGF0Y2hlcy4gTW9zdGx5IHRoZXNlIGFyZSBmaXhlcywNCj4gZXhj
ZXB0IGZvciBwYXRjaGVzIDQgYW5kIDgsIHdoaWNoIGFyZSB0aGUgbWVhdCBvZiB0aGlzIHNlcmll
cyBhbmQgYWN0dWFsbHkNCj4gc3dpdGNoaW5nIG9uIHRoZSBNQyBzdXBwb3J0Lg0KPiANCj4gQ2Fu
IHRob3NlIGJlIG1vdmVkIHRvIHRoZSBlbmQ/IFRoYXQgYWxzbyBtYWtlcyBpdCBlYXNpZXIgdG8g
bWVyZ2UgdGhlIGVhcmxpZXINCj4gcGF0Y2hlcyBpZiBzb21lIG1vcmUgd29yayBpcyBuZWVkZWQg
Zm9yIHRoZSBNQyBwYXJ0Lg0KPiANCj4gSSdtIGFsc28gbm90IHN1cmUgd2hldGhlciBwYXRjaGVz
IDQgYW5kIDggc2hvdWxkbid0IGJlIGEgc2luZ2xlIHBhdGNoLA0KPiBzaW5jZSBwYXRjaCA0IGxl
YXZlcyB0aGUgZHJpdmVyIGluIGFuIGluY29uc2lzdGVudCBzdGF0ZSBzaW5jZSBpdCBpcw0KPiBt
aXNzaW5nIHRoZSBsaW5rIHZhbGlkYXRpb24gY29kZSB0aGF0IHBhdGNoIDggYWRkcy4gVW5sZXNz
IEkgbWlzc2VkDQo+IHNvbWV0aGluZz8NCg0KSGVsbG8gSGFucywNCg0KVGhlIGRpZmZlcmVuY2Ug
dGhhdCBwYXRjaCA4IGlzIG1ha2luZyBpcyB0aGF0IHRoZSAnb2xkIHdheScgb2YgDQpjb25maWd1
cmluZyB0aGUgSVNDIGlzIG5vIGxvbmdlciBwb3NzaWJsZS4NCg0KUGF0Y2ggNCBtYWtlcyB0aGUg
SVNDICdtYy1yZWFkeScgd2l0aCBhbGwgZW50aXRpZXMsIGxpbmtzLCBidXQgdGhlIG9sZCANCndh
eSBzdGlsbCB3b3JrcyAobWVhbmluZyB0aGF0IHRoZSB0b3AgZHJpdmVyIHdpbGwgY2FsbCBzX2Zt
dCBkb3duIHRvIHRoZSANCnN1YmRldiApLg0KQWZ0ZXIgcGF0Y2ggOCwgdGhlIGRyaXZlciBubyBs
b25nZXIgaGFzIHRoaXMgc3VwcG9ydCBhdCBhbGwsIGFuZCANCnZhbGlkYXRlcyBsaW5rcyBhdCBz
dGFydF9zdHJlYW1pbmcsIGFuZCBubyBsb25nZXIgc2V0cyBhbnl0aGluZyB0byB0aGUgDQpzdWJk
ZXYsIGp1c3QgdmFsaWRhdGVzIHRoZSBjb25maWcgdGhhdCB0aGUgc3ViZGV2IGFscmVhZHkgaGFz
Lg0KU28gb25lIHJlYXNvbiB0aGF0IEkgaGFkIHRoaW5ncyBpbiB0d28gcGF0Y2hlcyB3YXMgdGhh
dCBwYXRjaCA4IG1ha2VzIA0KdGhpcyBiaWcgY2hhbmdlIHRoYXQgYWxzbyBtYWtlcyB1c2Vyc3Bh
Y2UgYmVoYXZlIGRpZmZlcmVudGx5IGFuZCBoYXMgdG8gDQpjb25maWd1cmUgYWxsIHRoZSBzdWJk
ZXZzIGFuZCBtZWRpYSBwaXBlbGluZS4NCg0KSWYgeW91IGZlZWwgcGF0Y2ggNCBhbmQgcGF0Y2gg
OCBzaG91bGQgYmUgc3F1YXNoZWQsIEkgY2FuIGRvIGl0LCBkZWZpbml0ZWx5Lg0KDQpMZXQgbWUg
a25vdyBob3cgdG8gcHJvY2VlZCA/DQoNClRoYW5rcywNCkV1Z2VuDQoNCj4gDQo+IFJlZ2FyZHMs
DQo+IA0KPiAgICAgICAgICBIYW5zDQo+IA0KPj4gICAgQVJNOiBkdHM6IGF0OTE6IHNhbWE3ZzU6
IGFkZCBub2RlcyBmb3IgdmlkZW8gY2FwdHVyZQ0KPj4gICAgQVJNOiBjb25maWdzOiBhdDkxOiBz
YW1hNzogYWRkIHhpc2MgYW5kIGNzaTJkYw0KPj4gICAgQVJNOiBtdWx0aV92N19kZWZjb25maWc6
IGFkZCBhdG1lbCB2aWRlbyBwaXBlbGluZSBtb2R1bGVzDQo+Pg0KPj4gICAuLi4vYmluZGluZ3Mv
bWVkaWEvbWljcm9jaGlwLHhpc2MueWFtbCAgICAgICAgfCAgIDIgKy0NCj4+ICAgYXJjaC9hcm0v
Ym9vdC9kdHMvc2FtYTdnNS5kdHNpICAgICAgICAgICAgICAgIHwgIDQ5ICsrDQo+PiAgIGFyY2gv
YXJtL2NvbmZpZ3MvbXVsdGlfdjdfZGVmY29uZmlnICAgICAgICAgICB8ICAgMyArDQo+PiAgIGFy
Y2gvYXJtL2NvbmZpZ3Mvc2FtYTdfZGVmY29uZmlnICAgICAgICAgICAgICB8ICAgMiArDQo+PiAg
IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvTWFrZWZpbGUgICAgICAgICB8ICAgMiArLQ0K
Pj4gICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1iYXNlLmMgfCA1MTgg
KysrKysrKysrKy0tLS0tLS0tDQo+PiAgIC4uLi9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1p
c2Mtc2NhbGVyLmMgICB8IDI2NyArKysrKysrKysNCj4+ICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9hdG1lbC9hdG1lbC1pc2MuaCAgICAgIHwgIDU4ICstDQo+PiAgIC4uLi9tZWRpYS9wbGF0Zm9y
bS9hdG1lbC9hdG1lbC1zYW1hNWQyLWlzYy5jICB8ICA4NyArLS0NCj4+ICAgLi4uL21lZGlhL3Bs
YXRmb3JtL2F0bWVsL2F0bWVsLXNhbWE3ZzUtaXNjLmMgIHwgIDkzICsrLS0NCj4+ICAgMTAgZmls
ZXMgY2hhbmdlZCwgNzU0IGluc2VydGlvbnMoKyksIDMyNyBkZWxldGlvbnMoLSkNCj4+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLXNj
YWxlci5jDQo+Pg0KPiANCg0K
