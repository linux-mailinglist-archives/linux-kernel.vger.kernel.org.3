Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC9454E000
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376821AbiFPL04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376833AbiFPL0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:26:53 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E975E763;
        Thu, 16 Jun 2022 04:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1655378811; x=1655983611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e7OiPqa+7RVecTygEgYBCsgfbsWuw5iLwRTNGRV+1W0=;
  b=p7bzPvb+L8QFR130oQLDnrR703NFRJVtAk9jCf5l6foDC5d1a1RE8VaI
   43UGIkjTcEORRnc37NftpZ6qplRGxYeQFvUPtOusC/JHJpMnFJyK4WLu8
   Gsknzh/wl96Bin7Ktjd5XtN/P3Xcw8So4am4/YBNeXYKAVpj6Jds9DH3a
   o=;
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 11:26:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaV7HIw0NkJOj7pkcAyiE4rvDk2QeifLlO8ee5fluTprT6/ou102ZYDuKsrKPEjVzSlNsGWf+l4Zr6an55g/84rwycTTnhHljomiWjDl9S2cmcI+rZDHg77oojPXqm39cFUMlEB+z7dlAlvVGmbxEnt39cAwZWaTAXO/wW2gQg0zZUHyoac3jHpWX8aO/w03RIzaiHd8BkKfa8B8+uGa27Zlc+TTcw2FHao2DJ/r73b1agjFCTPhXmEohku6Ji+9cwzYOGRR839TPqHYSUvor6++6/F/3TdUY3cOeXlmlUqemFTH7p6RWo1OfbjRq+JxMFPh9my5PH5SvglYgKNj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7OiPqa+7RVecTygEgYBCsgfbsWuw5iLwRTNGRV+1W0=;
 b=j/OchFky8OUx1Wbre1xMeoso1BN7iXi8+rgoLRlfnUUXcHp48ZsQTBC5RkeMaMEmW7BHYybi1KaOtc6Fo6Dn0+jquEo4SHskeKh01ljyMf6I35sKiTfq+ua3you1E+4p4NM3n+Zc9hNMOxHaw8T1juw5b3V2IVowqvAABd2e+L+u4C7JosS3fzDzPa96CLws5yS/qdf+BCxFBMcCnXVCZQ5qnpA11/6sC751+D7azEO+f3IsFgO1UzCmXfzuhiFluJUA3Bag9XXXiij5ckSGEotdNOK4tzOG9/GnUiWWDjMe8ZgZO9PbJYIJWRrytbybRwNNIWC/G5r4r/C/dWAXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM6PR02MB5148.namprd02.prod.outlook.com (2603:10b6:5:48::21) by
 BL0PR02MB4292.namprd02.prod.outlook.com (2603:10b6:208:4b::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.17; Thu, 16 Jun 2022 11:26:47 +0000
Received: from DM6PR02MB5148.namprd02.prod.outlook.com
 ([fe80::44a5:24fa:db60:5900]) by DM6PR02MB5148.namprd02.prod.outlook.com
 ([fe80::44a5:24fa:db60:5900%6]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 11:26:47 +0000
From:   "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>
To:     Stephen Boyd <swboyd@chromium.org>,
        "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
CC:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>
Subject: RE: [PATCH v2] venus: Add support for SSR trigger using fault
 injection
Thread-Topic: [PATCH v2] venus: Add support for SSR trigger using fault
 injection
Thread-Index: AQHYgJqN30RVX3txNUygQJcPmes0Eq1RRTAAgAChhcA=
Date:   Thu, 16 Jun 2022 11:26:47 +0000
Message-ID: <DM6PR02MB5148DEBF07F2F6C7BF7A1BE0F3AC9@DM6PR02MB5148.namprd02.prod.outlook.com>
References: <1655285409-19829-1-git-send-email-quic_dikshita@quicinc.com>
 <CAE-0n53O7gb9C2uPOiHjyDuAZmxMQyUL9MtLoRa-8Lr666PENw@mail.gmail.com>
In-Reply-To: <CAE-0n53O7gb9C2uPOiHjyDuAZmxMQyUL9MtLoRa-8Lr666PENw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d26c7819-6023-446a-456d-08da4f8b19c1
x-ms-traffictypediagnostic: BL0PR02MB4292:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB4292C8B9FF8482CEFD3AA6378FAC9@BL0PR02MB4292.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4JnBuwRF6u/n6BWYLkF3fdV21XDR8JEcnN/hVIiTP9dQJ7l/zT8uPx6GJz5fbFVJT0ELCy/8o/2lpYNG1gnb4b3TejJdFw8yRVMeSGtUKIlHzuEJPUPasdulhdrM3QY1wIDlAgGewM5TJpRix3EqNxYEHuS8xpFcOCKkgHao4uGzxXdORcg6RBgOGEH/PfNYBaFYDVJGM2sdvBlRG7gOeACyuaA5wyem5qUuX/geMEgEJaDOS+eTKkR76l4gm6y3KpUJu17ShCCecOJ/eN3hzOg8yQNdsbt7hl3EPowKhFzzCz82v2UMGKBLEPIcCOTRh+cbcxEvr2orL26XfDZGM9uaXrh6QzaZFb5R3nRZgIbKzi8V8fvT2n2rN4lsNwUUJ+hT+e3uS9gl4+ZaUj8pHLbyv7AMFXwUs6ZA+IFXYHZylgnBSWnM2oCb9Xua8hoRV2uO8RhxbXlRct5gIY5v1Fpif05iUsr+T3N5HNVPJJ1va24DNQyOZ6uJ7aZBvyJUVh7zWXzlT4aw7uSDGiq6B+fdwlv8wfI98F2SFX4TudkjE4eNimY22F/yPalywdxYNR3aBVOTr63AwK5oWyO85SlrsWv98ybnqqvawPyNN97lgH5lofOJH/Exm9dDh1C8+tAqW16aE1gBVyxVGKqJR9jdtuuVyHws4baFfu44Hm2Xz/UPOX3sbTe6hBMX5V0hkiL6ZUECdYE2sxXjPve5dA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5148.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(316002)(508600001)(52536014)(7696005)(76116006)(53546011)(6506007)(122000001)(66446008)(66556008)(66946007)(26005)(64756008)(33656002)(66476007)(2906002)(38100700002)(110136005)(9686003)(8676002)(8936002)(71200400001)(107886003)(38070700005)(55016003)(5660300002)(54906003)(83380400001)(4326008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDFkTE9uWWtZYVUxOXBrUnFlR0phTktOaFcxOW9CM3JXSnJ1Sy9UNWNnemlV?=
 =?utf-8?B?M3NkN1VuQzZNWGRqbjllUkhyUVNLcXBFeDJxQkFKV2JHZlEvL3l0Z2YyaW5w?=
 =?utf-8?B?RG9taUkxTkRZcEMwL2FJdjQvT1lZZkpMczJ6aDR2d1YxWTFXTDV6Y2JBY0d2?=
 =?utf-8?B?KzJVa1hXM2s1Mk14RW9PWUF2anZpSHdHNy9CMXVyTTl5ZE5PeHpua3ViakNQ?=
 =?utf-8?B?N0dPeC9ZVUxUN29aOWcvUkNqdEFhVWZQdi9VMXFjRFhOUC9KR0hCa3UzdE5z?=
 =?utf-8?B?VjVKK0xCR0xZazlmQzVwai9aUTdkb1g4Tlgwei9kODFIaU0vRm94K2M3NytK?=
 =?utf-8?B?NCs1UkZnUzdaYitqRGhraFVUKzYvNEZUZndoSVJZRnBEdldBWjU1c0JFdmsx?=
 =?utf-8?B?dS9yMEYrbHo3T2k0NEwxdmN6eDNFcTQweE10eEFQRisxOTJsdDIvaFlzSjFE?=
 =?utf-8?B?RlNHQVBYVjBxOXVFeHJxTnEzVFgvVDNiY0dzWFcxSlRodCt3bUVIaEFuMUxJ?=
 =?utf-8?B?Tk1yZGIvMkdVNmZXRGdLWUFIWk1JY0NhcklnYW1DcmJ2NmJWY2dwVVNrUVZM?=
 =?utf-8?B?bWs2VzBhS1ZUenJEaEdCOVhJSWNXdXZHRGZLVTQ2MWlrcGpBVURmRHpoaHhv?=
 =?utf-8?B?SjJTUTdTVUNYU2VML1B2aUxjSjFNRmZsRlFnTkdEKzM2L2wraHkwNnUrTWt3?=
 =?utf-8?B?TzBlR3FpUnM5dklNMnQxcjZrRFRWdkxVL0M3Vm9uUDVFNnRuTXd4OFMwakFP?=
 =?utf-8?B?VmJpTmVXYjh5OHVqT09mU012aTArbUdOdzI1ZmN1VkhyK3dZWWxkbHZtRStB?=
 =?utf-8?B?OGlNWUltUTJwanh6MjI3VXQxbHVpWHBkZlFJSU1PMEdpcFpxNFBCV2JLQ1p5?=
 =?utf-8?B?R3EwcjZqZW9rV2hYYWFWU2V2OXRYR1RSb1B5MHBQazdwZ0pSOVRkOUYrY3pO?=
 =?utf-8?B?YnRhQ3g5TENjT2tFbU1uQ05aWWwyU0FWV2NwcEVwb01WajVhS3M5NkhETlZ2?=
 =?utf-8?B?dU9xOWNici9jdTg3LzlPM0pKbnJ3MExFdlh6MnhrcUJscWtvaEdJZGdiSmVJ?=
 =?utf-8?B?bkllZlNucGhpYTl1OEZrTUZPMTY4N1ByLzN6UnB1a1RuK2RndnBYanlzOWJ2?=
 =?utf-8?B?Q3JrNmUyeUtKRTJ3M0RTQWFxeGJrWFk1SE5iWEpUeDd6Njk3Nlh4WHJXTkNL?=
 =?utf-8?B?Kzh2cXdHR0ZEaEpqeFV6K1R4YnYycDh0c3hjK2d4NlVaWlUvN1htVk5Sby90?=
 =?utf-8?B?WVFwSHlEbWwxUnhLOFIzVG9TYXVTVWlWc2tQSWdKNWI5dnNnL2lEc09sNDd6?=
 =?utf-8?B?a2dqSkhoK2x6azd0bWt1SnUyYUorbzNlTlFmMWM3THo4YndMRkMvWXcvdit2?=
 =?utf-8?B?OUpFYjlmZFhVMmo4djJSemhON3FLMHpwYkRKU2JCWWdtU2RKa3VOaWUvL0Nq?=
 =?utf-8?B?Q3o3QzBwa2h6dDZmeDlUQnlEdkJWdGRBVjdLSzhjRURqTmxxbWJBQmMvcW5s?=
 =?utf-8?B?d0hMQzF1bUNsbHJMbm5PdXZ5d091Mk93MitwTDN2Zkl4T0dabUlsNm91ZDBp?=
 =?utf-8?B?eFcxNjVpa3N6RDRnTGtnSFFINlVFejlQZkRuckpZVm1kOHZUUmszMzJPaldV?=
 =?utf-8?B?ejZBNkNBMXNQWFBLSEFMUUIxY1RmVStKSXh1QksySzJ1cW5lemcwNGlROUUx?=
 =?utf-8?B?cVdzdTdrd2g0VnVETEh6MDdqQkx0MFVRWXBxSXdUc21PRVBuQWZLT0JYaWlE?=
 =?utf-8?B?dmNFMlQ3YmtMcjVUTGZpLy95RXJRWk1GWVQ5NS9MZ2kzUmFEc1RkdStRWE9j?=
 =?utf-8?B?UkdTUjZkQ0JYZXNzZVRMV0h4L2lEWDNMRVNFZENiN2pJRUNyNkI3Rkx4Nmxu?=
 =?utf-8?B?Yjl0b21hallEWlpJb2Z0VzN1MnNFbWdVbE13ZENxbS9NMWhxMUFhZVRxbjJZ?=
 =?utf-8?B?aS8rZzR4c3lwaVR5RWRYSUNoOHZ1amlqamY0WVRWM09KODVRZDRVQ1ZUNXcw?=
 =?utf-8?B?RHlqTmJKbGk5elprYlhaVlIrNWhjRTlLSWdsTkQ5VUtiLzJTanNES2VOc04y?=
 =?utf-8?B?eGZROGtBRXcyZnN3Rjg5TUp3emZLQjlEVVhFZXFPa1ZSSFFKUEtjZGRFV1Fr?=
 =?utf-8?B?K0oyWjRxRzE0YnFzZlYyanljZkRsSVNlNXFTcHY5dWFWQmozc1VOdWRVbzQ3?=
 =?utf-8?B?cy9JcSswcm1PS0U3UzYrSlJVMnJpM3gxNnhhSGQwaHo2R3JsZ1F3Uk1kQkJD?=
 =?utf-8?B?N2hBSWM1VjBUWThCOHNwUDVQdjNTNzRNenJlVmxNenlob05GMTluSmNVREky?=
 =?utf-8?B?dXZWUEpPenBBaC9rdFlJZjBRT3JJcG03RmFabWN5YmlNZXdxUFNsdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26c7819-6023-446a-456d-08da4f8b19c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 11:26:47.7335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXLWaHpasv3XmWx0EMhYYSU1gwr5ml2Hc0TP3pad5e8og5SeDhYuQ/Axw+8au6LVcwhWyB9lgGcZLXaLBv95dea5d+qWh/gjp2w8wgRWB90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4292
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIFN0ZXBoZW4gZm9yIHlvdXIgcmV2aWV3Lg0KQWRkcmVzc2VkIGFsbCBjb21tZW50cyBp
biB2My4NCg0KVGhhbmtzLA0KRGlrc2hpdGEgQWdhcndhbA0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogU3RlcGhlbiBCb3lkIDxzd2JveWRAY2hyb21pdW0ub3JnPiANClNlbnQ6
IFRodXJzZGF5LCBKdW5lIDE2LCAyMDIyIDc6MTkgQU0NClRvOiBEaWtzaGl0YSBBZ2Fyd2FsIChR
VUlDKSA8cXVpY19kaWtzaGl0YUBxdWljaW5jLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZw0KQ2M6IGxpbnV4LWFybS1tc21Admdl
ci5rZXJuZWwub3JnOyBzdGFuaW1pci52YXJiYW5vdkBsaW5hcm8ub3JnOyBWaWthc2ggR2Fyb2Rp
YSAoUVVJQykgPHF1aWNfdmdhcm9kaWFAcXVpY2luYy5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENI
IHYyXSB2ZW51czogQWRkIHN1cHBvcnQgZm9yIFNTUiB0cmlnZ2VyIHVzaW5nIGZhdWx0IGluamVj
dGlvbg0KDQpRdW90aW5nIERpa3NoaXRhIEFnYXJ3YWwgKDIwMjItMDYtMTUgMDI6MzA6MDkpDQo+
IEhlcmUgd2UgaW50cm9kdWNlIGEgbmV3IGZhdWx0IGluamVjdGlvbiBmb3IgU1NSIHRyaWdnZXIu
DQo+DQo+IFRvIHRyaWdnZXIgdGhlIFNTUjoNCj4gIGVjaG8gMTAwID4gIC9zeXMva2VybmVsL2Rl
YnVnL3ZlbnVzL2ZhaWxfc3NyL3Byb2JhYmlsaXR5DQo+ICBlY2hvIDEgPiAgL3N5cy9rZXJuZWwv
ZGVidWcvdmVudXMvZmFpbF9zc3IvdGltZXMNCj4NCj4gc2lnbmVkLW9mZi1ieTogRGlrc2hpdGEg
QWdhcndhbCA8cXVpY19kaWtzaGl0YUBxdWljaW5jLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Rh
bmltaXIgVmFyYmFub3YgPHN0YW5pbWlyLnZhcmJhbm92QGxpbmFyby5vcmc+DQoNCldoeSBpcyBT
dGFuJ3MgU29CIGhlcmU/DQoNCkhlIGlzIGNvLWRldmVsb3BlciBoZW5jZSBhZGRlZCB0aGUgc2Ft
ZS4NCkFkZGVkIGNvLWRldmVsb3BlZC1ieSBhcyB3ZWxsIGluIGxhdGVzdCBwYXRjaC4NCg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9xY29tL3ZlbnVzL2RiZ2ZzLmMgDQo+
IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9xY29tL3ZlbnVzL2RiZ2ZzLmMNCj4gaW5kZXggNTJk
ZTQ3Zi4uZWMxNTA3OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9xY29t
L3ZlbnVzL2RiZ2ZzLmMNCj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9xY29tL3ZlbnVz
L2RiZ2ZzLmMNCj4gQEAgLTQsMTMgKzQsMzQgQEANCj4gICAqLw0KPg0KPiAgI2luY2x1ZGUgPGxp
bnV4L2RlYnVnZnMuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9mYXVsdC1pbmplY3QuaD4NCj4NCj4g
ICNpbmNsdWRlICJjb3JlLmgiDQo+DQo+ICsjaWZkZWYgQ09ORklHX0ZBVUxUX0lOSkVDVElPTg0K
PiArc3RhdGljIERFQ0xBUkVfRkFVTFRfQVRUUih2ZW51c19zc3JfYXR0cik7DQo+ICsjZW5kaWYN
Cg0KVGhpcyBlbmRpZiBpc24ndCBuZWVkZWQuDQoNCj4gKw0KPiArI2lmZGVmIENPTkZJR19GQVVM
VF9JTkpFQ1RJT04NCg0KYW5kIHRoaXMgaWZkZWYgaXNuJ3QgZWl0aGVyLiBUaGUgdHdvIGNhbiBi
ZSBjb21iaW5lZC4NCg0KPiArYm9vbCB2ZW51c19mYXVsdF9pbmplY3Rfc3NyKHZvaWQpDQo+ICt7
DQo+ICsgICAgICAgcmV0dXJuIHNob3VsZF9mYWlsKCZ2ZW51c19zc3JfYXR0ciwgMSk7IH0gI2Vs
c2UgYm9vbCANCj4gK3ZlbnVzX2ZhdWx0X2luamVjdF9zc3Iodm9pZCkgew0KPiArICAgICAgIHJl
dHVybiBmYWxzZTsNCj4gK30NCg0KUHV0IHRoaXMgcGFydCBpbiB0aGUgaGVhZGVyIGZpbGUgYW5k
IG1ha2UgaXQgc3RhdGljIGlubGluZS4gVGhlbiB0aGUgY29tcGlsZXIgaXMgZ29pbmcgdG8gaW5s
aW5lIHRoZSBmYWxzZSB0byB0aGUgaWYgY29uZGl0aW9uIGFuZCBvcHRpbWl6ZSB0aGUgZW50aXJl
IGJyYW5jaCBhd2F5IHVubGVzcyB0aGUgY29uZmlnIGlzIGVuYWJsZWQuIEl0IHdvdWxkIGFsc28g
YmUgbmljZSB0byBleHRlcm4gdGhlIHZlbnVzX3Nzcl9hdHRyIHNvIHRoYXQgdGhlIHNob3VsZF9m
YWlsKCkgY2FuIGJlIGRpcmVjdGx5IGlubGluZWQgaW50byB0aGUgaW50ZXJydXB0IGhhbmRsZXIu
DQoNCj4gKyNlbmRpZg0KPiArDQo+ICB2b2lkIHZlbnVzX2RiZ2ZzX2luaXQoc3RydWN0IHZlbnVz
X2NvcmUgKmNvcmUpICB7DQo+ICAgICAgICAgY29yZS0+cm9vdCA9IGRlYnVnZnNfY3JlYXRlX2Rp
cigidmVudXMiLCBOVUxMKTsNCj4gICAgICAgICBkZWJ1Z2ZzX2NyZWF0ZV94MzIoImZ3X2xldmVs
IiwgMDY0NCwgY29yZS0+cm9vdCwgDQo+ICZ2ZW51c19md19kZWJ1Zyk7DQo+ICsNCj4gKyNpZmRl
ZiBDT05GSUdfRkFVTFRfSU5KRUNUSU9ODQo+ICsgICAgICAgZmF1bHRfY3JlYXRlX2RlYnVnZnNf
YXR0cigiZmFpbF9zc3IiLCBjb3JlLT5yb290LCANCj4gKyZ2ZW51c19zc3JfYXR0cik7ICNlbmRp
Zg0KPiAgfQ0KPg0KPiAgdm9pZCB2ZW51c19kYmdmc19kZWluaXQoc3RydWN0IHZlbnVzX2NvcmUg
KmNvcmUpIGRpZmYgLS1naXQgDQo+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9xY29tL3ZlbnVz
L2RiZ2ZzLmggDQo+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9xY29tL3ZlbnVzL2RiZ2ZzLmgN
Cj4gaW5kZXggYjdiNjIxYS4uYjBkMDY4NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9xY29tL3ZlbnVzL2RiZ2ZzLmgNCj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9xY29tL3ZlbnVzL2RiZ2ZzLmgNCj4gQEAgLTgsNSArOCw2IEBAIHN0cnVjdCB2ZW51c19jb3Jl
Ow0KDQorI2luY2x1ZGUgPGxpbnV4L2ZhdWx0LWluamVjdC5oPg0KDQo+DQo+ICB2b2lkIHZlbnVz
X2RiZ2ZzX2luaXQoc3RydWN0IHZlbnVzX2NvcmUgKmNvcmUpOyAgdm9pZCANCj4gdmVudXNfZGJn
ZnNfZGVpbml0KHN0cnVjdCB2ZW51c19jb3JlICpjb3JlKTsNCg0KI2lmZGVmIENPTkZJR19GQVVM
VF9JTkpFQ1RJT04NCmV4dGVybiBzdHJ1Y3QgZmF1bHRfYXR0ciB2ZW51c19zc3JfYXR0cjsgc3Rh
dGljIGlubGluZSB2ZW51c19mYXVsdF9pbmplY3Rfc3NyKHZvaWQpIHsNCglyZXR1cm4gc2hvdWxk
X2ZhaWwoJnZlbnVzX3Nzcl9hdHRyLCAxKTsgfSAjZWxzZSBzdGF0aWMgaW5saW5lIGJvb2wgdmVu
dXNfZmF1bHRfaW5qZWN0X3Nzcih2b2lkKSB7IHJldHVybiBmYWxzZTsgfSAjZW5kaWYNCg==
