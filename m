Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBC94CD997
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbiCDQ6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240796AbiCDQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:58:37 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553D5574A0;
        Fri,  4 Mar 2022 08:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1646413069; x=1647017869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tqfrXH7IMrLBwOl05vuzyXZGhuoITjHbfTSAvuxsCVA=;
  b=1Tiv7JzMhhKMdM8QukMm6W+k+7nXts0MFli5sBwLiWf6MchimR7pqKGt
   xE2MXgkqpVuTNLZkxXfjGSlflHLooutr9ZQrV2lxxYJnrnEFDcETmd5Rh
   GyuffU23x5pHDWf4uHv/84Su1brqmFVUNGZXkU4mcBQtBZ3ORufNloO+Z
   I=;
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 16:57:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdVdjsUNzxTKBdSeVBwGnpTXaZy79JlzEv+F+Juu3hAywwS7QKXOzM6HNbTaCqzAhgTibEoxd7zhTv9hlRwZXj3Q8xBh7qPADDvas/NcVoQHp0/bFYIiUxRoKp9L8Hpp5UjW2MnCZRw9/NZGqjvVfDZ0Syb3UTTeYrw3Xhj+yW/8QlD9h7YHE4l3dUiipw4NP9u2Gk90e2Hl8u2e6N/tKmPQrsQLhYEdChO5iUfsfFsQ772DnZzOHIxFsAH0PZ5jvr9mZR3m5FOMcj0KaQtfMt3a40ZpUEWfYKn6bI4aa8v5NUOyhKClzxaoyCJBDA8sf9S27fVVS1RZl9GxPdju5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqfrXH7IMrLBwOl05vuzyXZGhuoITjHbfTSAvuxsCVA=;
 b=D4Kn8J3CoiOyffTyCloGr0yhEg/V3yDkckcZu/1sHaiIdRbJYU5auw/T8bdoFhRb0xtnBdrz3G16GDsI95DSwcUsKUw86FDuZN0OmF8zLVMDdr6QthjOHpTVMmQinY/9yYE4d16+uO/3Z/qq/PwHc7Bt1dGPYcjkPlpvGt3il/Q6Ni7ZjBjV8nA/EJxfe+YZIb01XcP/N8oduf+FMdlDFiuYot/vEb17+hDjvhMP2MhVYjDRoJ1xY4Ad8sWtCOP4blfgUngKi13gP4lBWB2gXmCZJrvp6P2Pk16ry7iEVK3anfLN7/wiGWP+nRbxzkGTQPmJJbuiyG+d1EHCfInyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL0PR02MB4564.namprd02.prod.outlook.com (2603:10b6:208:4d::13)
 by BY5PR02MB6148.namprd02.prod.outlook.com (2603:10b6:a03:1fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 16:57:37 +0000
Received: from BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::e856:962e:247d:8a68]) by BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::e856:962e:247d:8a68%4]) with mapi id 15.20.5038.015; Fri, 4 Mar 2022
 16:57:37 +0000
From:   "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
To:     Doug Anderson <dianders@chromium.org>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Mukesh Savaliya <msavaliy@qti.qualcomm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dilip Kammath <dkammath@qti.qualcomm.com>
Subject: RE: [PATCH] arm64: dts: qcom: sc7280: Configure cts sleep pinctrl to
 bias-disable for sc7280-idp
Thread-Topic: [PATCH] arm64: dts: qcom: sc7280: Configure cts sleep pinctrl to
 bias-disable for sc7280-idp
Thread-Index: AQHYIaNir99tB67bpEut/O2NV51De6ysZZ+AgAMmebA=
Date:   Fri, 4 Mar 2022 16:57:37 +0000
Message-ID: <BL0PR02MB456421F83B9C88139514399EFA059@BL0PR02MB4564.namprd02.prod.outlook.com>
References: <1644843828-20464-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=XtkXganjG=ddgaq4-p+cAK1c4jqG=8Ux_xxdUrPpXhVA@mail.gmail.com>
In-Reply-To: <CAD=FV=XtkXganjG=ddgaq4-p+cAK1c4jqG=8Ux_xxdUrPpXhVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c672d56-3adb-40ea-a580-08d9fe001636
x-ms-traffictypediagnostic: BY5PR02MB6148:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR02MB61487230DDC53600ABB3A48286059@BY5PR02MB6148.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5jmuHc3u3VPYrF4bKGP8qzUtYgTR9flAcMuD2gbIgPs/2jgMMX4l/N/LCv+r9fCNM4oWulZz8pG76mzzu1xbvJ97mAKIe7mRA9A1m8YSbgblWZxeuyoqDC2kk2nhoZubpU6hgn1Ajwrbq7K5dG7G6XMR8HtlC5xM3VLjPhzE9EwlDhqMt2tKdmeoBW3JWgvcUJpxlCpm6JTGLlC/4JbPWKLLglgoiCB7R6hGdszeuGJODzQARLbVa0MCQt3DMyUv+nWsq9HkZSka7l3hkZwV0OhHDK+GIiO7Cv2oqF99j758DFT4GZ3iB2Ugi6G0bDqBNFdF3qZPs8lQWvXZezfxQEdaJFdVchB9XWnWtP60YfOcTN8nxxXuBbsu0amWR8MkQ+1uNXyXh9v2XfbngN5rkFtcYduRH/Ql4S/X8SIBWYoB5I3kjuPJfG4h7/HwQVZyl+3vqryaf2EzjNzikYdqYMCH9cD6MWd7LWTBiOy40eD6ZTbbNMCu9y75MaomdpKLDh4qqz8ov3lj9wg/ekzqf1w+z+Q/aW5xTygCWg+WmrFaqw7ctWK8I9m+8LchSqlza5MjoXQbb3OHy6n/6mgJJDsJ5JaAn7RO8+YGc5hRAgAykeoyt/w+YR1dSMr3bTAGlyCD+VkoJ43hN8k7ItEotIRK1rDgFslK5ZDTHMPVBaE3DlY559muRMTlw9HWk+DzPUAJDXPAZsBNm24qtwpotg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(54906003)(83380400001)(38100700002)(52536014)(64756008)(508600001)(8936002)(8676002)(76116006)(66556008)(316002)(66446008)(66946007)(66476007)(4326008)(71200400001)(5660300002)(7696005)(110136005)(33656002)(186003)(26005)(107886003)(2906002)(38070700005)(53546011)(6506007)(55016003)(86362001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXNHakNMRU1aeDRiR1ZKckpMeHBpMnVDelNPTUZWdzdZMnlLNFJiOW4vOGZK?=
 =?utf-8?B?YjB3dXR3eXpNTndvS3I1NEpSZkF2Q1grVFdldnpwSW5wQUdKdHZyQWoxb1ZV?=
 =?utf-8?B?Y1dVZzQ0VVFCaWtNQUtvRVNTaE45UWZqQWhvK0Q2U0pSQmFvUnVvalBRTHNN?=
 =?utf-8?B?RDgrMGY0c2V5cXFkcWpMeXllcXVqS3B6WnBNWi91R0tLWDd2aXF2NnZndkpX?=
 =?utf-8?B?bUZCbXZ0aGl6WW1HYi9JSndOeFZBQWNubDhMTmlodWpVVkpocEVFZC9LKy9O?=
 =?utf-8?B?MWRZcHN1MmRHckg1OXk1YWtMbXhZOEc1R3hBU3Zxc2VCS3JmaFFkTEllbjhS?=
 =?utf-8?B?cmEvaFU5RDFsUUdQZ2p2ZnlIbXRiMEc2OGRlQ2xkNUowWlpCZUJPR1JlM2Iw?=
 =?utf-8?B?Q1V2b2NoTm5GNFllNHNMMVZoOWhmbVI5Y0JXcXZUOHRYTDQxNnAybFBSRTY1?=
 =?utf-8?B?ZHRkUWJxOU8zVkNjbGlTdXp1a2dFa05tR0xPVkJrc1dYRnVycy8zemFQS3NY?=
 =?utf-8?B?cnR4TDRQMUFQNEs2a1R5SVROeFM3R0YrUmxjSG1idVphRG5zMkVYNGNwSldQ?=
 =?utf-8?B?Q2FXRFI1ZUtWQTF5WndsUTRGVjBlYWdHODFBTVZEUWsvRlJLM2JKSExvd0dm?=
 =?utf-8?B?blNMV2NTNEY5RDF3NTRhWGNKR3ZlTmhPNGxkUWo1RC9xQWlaVTNvTE5CVFhR?=
 =?utf-8?B?d0VhTzFBTjFiZFAwVnYzSmZNVEtTYzZjbWkrOFhXQ09aaVJaa3lqYkJZOXNw?=
 =?utf-8?B?MUcvZTN1MzJZTzBPK2RRVHhmVXJ3UG5rd0tldUVOdDBMSlpYR3FsdkRjcGp6?=
 =?utf-8?B?alVwcEhldkdBdFJTTVp0VmFMQlNJbVFzTnNvdFFzNDkxMVBkSEpMQ2s3VWg4?=
 =?utf-8?B?Y2VwaTczSFlsRlNaSVdTZXVvODZ1NU5rY0krZTRFVjU0bVpVM3FvN1lSUldm?=
 =?utf-8?B?eGdvV1JGek9ON3ZLMkdoVmsyczhQNEtwVGppY0pmKzhTYmJRTlpDbmZwN1hC?=
 =?utf-8?B?Tzd6d0dQdlFOaFoxZ1c5Z1dZTnMwNVFNUlpTWGdlQVROb2c3cU02TGdGelQw?=
 =?utf-8?B?azhNZFhNUWplNDRSanZuRjYydm1pQUhLaWU0dFdaMjU2Z0gxVkZsS1FkTUts?=
 =?utf-8?B?Z3h2T0xRb0wybDdQNjV4aFM2V2kwaTJTaTVWR2ZoR0lHM1d5Nzh1TzJvQnB4?=
 =?utf-8?B?QzdETE0yWTl6S2VwMHBMbjhpRytwMjZGdGJtVmRuQUduWmp5ZGJUbmE3bTVY?=
 =?utf-8?B?RFg3dmhYZVQ0VmdxNmRHVTFhRllCbk94Y3laeGtlVHNPTnFVVWMvTXNyTXMy?=
 =?utf-8?B?bW9BMEdNRlBZbXdWYVhxY1VTNDN0MEllaVUwb09ONy9icC9LcnkySUh6R3A1?=
 =?utf-8?B?NnlYL3lZTHhVSThoQUdaNllxRkl3OXlkRzMycUpTTjBTWTBTMlZ5SVdTd050?=
 =?utf-8?B?M1FyYjd4MEZ2cnhkVWJ2NXArMHltdXdtM1FDNG4vOCtUdW9DamRZN20ySUpi?=
 =?utf-8?B?S2srWUxvWHFQSVdQZ3VzUGNkbXljU01jWWkzYjMvbGNtTmhBa2cyaHkycDBi?=
 =?utf-8?B?UWg0OGhuUW00UU1oWUhkbUtHb1hqK0liMzFnUGk2Smxudk1aeEUxZ3ZFdzFR?=
 =?utf-8?B?dG9JM1RTZFhDb1pOUzhNQXJXMWo4OVBYenR6YjhmczlhZmNvSHI3MnRUaVpC?=
 =?utf-8?B?WFl5SlNzMWxYWmR3aWJqVHoyV2tzTnhNNU5Nc1BvNWVYWkNRdm55OXNDU2p3?=
 =?utf-8?B?eG81V2NhMWFRYWhxUDJLT1JYbXM3T0NDb0R0SlY4cno1NkY0ZHoxeXFiZTgr?=
 =?utf-8?B?Y0tGdTQrbUEyZVFnbFF5ZnpxcklxaklTd3RKeDk5QUluRXpsOURqcnRVMG9P?=
 =?utf-8?B?bWQxeWp6Tkx5MmkycFBuSTR3c0RKSGZiaHUxZ1dVODA3SUVzbUxaUVFMYnU4?=
 =?utf-8?B?VGdoWHh2V054ZTM2Uld1TVNQdUZyWElkQ25BNUJrZmpsQVc5dnRPUklCWG9j?=
 =?utf-8?B?alp0M1FlbFdrY3p2R2tvQVAwOFNHd2ZVS1pUT2MvT0lYbkF5czhBaGhvdVdj?=
 =?utf-8?B?aFFNbE4xYWRYVytFR01MQVExRjI0RHpSZ3lMSDVkOUZTUkpzRTVEVlVzQVU4?=
 =?utf-8?B?eEpIMEt2QTlSbVN3RjdDZlUxYUNid1BNOVpzNURZZzBUUlZIUmtGT0ZXWmNq?=
 =?utf-8?B?UjdSdFVmN1YvSGNkUEJqVEtXZHZyUEtYVVFhWGRxQld3R2Jncm9ncEsyaVp5?=
 =?utf-8?B?bWhsS3RrMmRIRW5BbXVjUEhKRkhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c672d56-3adb-40ea-a580-08d9fe001636
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 16:57:37.4833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A8Y1wTTKZSxjrSNpWUbY2lvxsKRbPzli7UhNghCUHFQI6OLhxHF3HTRecYF1e9i7SOhU1mHY/ixz71UhTtIytMu4as5yNZzpTop9QyaBjok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6148
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgdmVyeSB1c2VmdWwgaW5wdXRzLg0KV2Ugd2lsbCBkaXNj
dXNzIGZ1cnRoZXIgYW5kIGdldCBiYWNrIGFzIHNvb24gYXMgcG9zc2libGUuDQoNCi1WaWpheS8N
Cg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEb3VnIEFuZGVyc29uIDxk
aWFuZGVyc0BjaHJvbWl1bS5vcmc+IA0KU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyLCAyMDIyIDEw
OjEyIFBNDQpUbzogVmlqYXlhIEtyaXNobmEgTml2YXJ0aGkgKFRlbXApIChRVUlDKSA8cXVpY192
bml2YXJ0aEBxdWljaW5jLmNvbT4NCkNjOiBBbmR5IEdyb3NzIDxhZ3Jvc3NAa2VybmVsLm9yZz47
IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwu
b3JnPjsgbGludXgtYXJtLW1zbSA8bGludXgtYXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVu
IGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdTIDxk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+OyBNdWtlc2ggU2F2YWxpeWEgPG1zYXZhbGl5QHF0aS5xdWFsY29tbS5jb20+OyBNYXR0
aGlhcyBLYWVobGNrZSA8bWthQGNocm9taXVtLm9yZz47IFN0ZXBoZW4gQm95ZCA8c3dib3lkQGNo
cm9taXVtLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFybTY0OiBkdHM6IHFjb206IHNjNzI4
MDogQ29uZmlndXJlIGN0cyBzbGVlcCBwaW5jdHJsIHRvIGJpYXMtZGlzYWJsZSBmb3Igc2M3Mjgw
LWlkcA0KDQpXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1
YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZiBhbnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBk
byBub3QgZW5hYmxlIG1hY3Jvcy4NCg0KSGksDQoNCk9uIE1vbiwgRmViIDE0LCAyMDIyIGF0IDU6
MDQgQU0gVmlqYXlhIEtyaXNobmEgTml2YXJ0aGkgPHF1aWNfdm5pdmFydGhAcXVpY2luYy5jb20+
IHdyb3RlOg0KPg0KPiBXTEFOIHJhaWwgd2FzIGxlYWtpbmcgcG93ZXIgZHVyaW5nIFJCU0Mvc2xl
ZXAgZXZlbiBhZnRlciB0dXJuaW5nIEJUIG9mZi4NCj4gQ2hhbmdlIHNsZWVwIHBpbmN0cmwgY29u
ZmlndXJhdGlvbiB0byBoYW5kbGUgc2FtZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogVmlqYXlhIEty
aXNobmEgTml2YXJ0aGkgPHF1aWNfdm5pdmFydGhAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgYXJj
aC9hcm02NC9ib290L2R0cy9xY29tL3NjNzI4MC1pZHAuZHRzaSB8IDYgKysrLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9xY29tL3NjNzI4MC1pZHAuZHRzaSANCj4gYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL3Fjb20vc2M3MjgwLWlkcC5kdHNpDQo+IGluZGV4IGQ2MjNkNzEuLmRl
MTgzMTkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zYzcyODAtaWRw
LmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9xY29tL3NjNzI4MC1pZHAuZHRzaQ0K
PiBAQCAtNTE2LDEwICs1MTYsMTAgQEANCj4gICAgICAgICAgICAgICAgIHBpbnMgPSAiZ3BpbzI4
IjsNCj4gICAgICAgICAgICAgICAgIGZ1bmN0aW9uID0gImdwaW8iOw0KPiAgICAgICAgICAgICAg
ICAgLyoNCj4gLSAgICAgICAgICAgICAgICAqIENvbmZpZ3VyZSBhIHB1bGwtZG93biBvbiBDVFMg
dG8gbWF0Y2ggdGhlIHB1bGwgb2YNCj4gLSAgICAgICAgICAgICAgICAqIHRoZSBCbHVldG9vdGgg
bW9kdWxlLg0KPiArICAgICAgICAgICAgICAgICogQ29uZmlndXJlIGEgZGlzYWJsZSBvbiBDVFMg
dG8gbG93ZXIgcG93ZXIgdXNhZ2UNCj4gKyAgICAgICAgICAgICAgICAqIHdoZW4gQlQgaXMgdHVy
bmVkIG9mZi4NCj4gICAgICAgICAgICAgICAgICAqLw0KPiAtICAgICAgICAgICAgICAgYmlhcy1w
dWxsLWRvd247DQo+ICsgICAgICAgICAgICAgICBiaWFzLWRpc2FibGU7DQoNCldoeSBpcyBzYzcy
ODAgZGlmZmVyZW50IGZyb20gYWxsIG9mIHRoZSBwcmV2aW91cyBkZXZpY2VzPyBEaWQgdGhlIEJs
dWV0b290aCBmaXJtd2FyZSBjaGFuZ2Ugb3IgYXJlIHdlIG1lYXN1cmluZyBhIGRpZmZlcmVudCBj
YXNlPyBJIGtub3cgd2Ugc3BlbnQgYSBsb3Qgb2YgdGltZSBjYXJlZnVsbHkgY2hvb3NpbmcgZWFj
aCBvZiB0aGVzZSBwdWxscyBiZWZvcmUgc28gYmVmb3JlIGNoYW5naW5nIHRoZW0gd2Ugc2hvdWxk
IHVuZGVyc3RhbmQgd2hhdCBjaGFuZ2VkLg0KDQpDVFMgaXMgYW4gaW5wdXQgZnJvbSB0aGUgQVAn
cyBwZXJzcGVjdGl2ZSwgcmlnaHQ/IEZyb20gdGhlIEFQJ3MgcGVyc3BlY3RpdmUgdGhlbiB0aGUg
Y2FzZSB3ZSBuZWVkIHRvIGJlIGNhcmVmdWwgb2YgaXMgdG8gcHJldmVudCB0aGlzIGxpbmUgZnJv
bSBldmVyeSBmbG9hdGluZyB3aGlsZSB0aGUgQVAgaXMgdHVybmVkIG9uLiBTcGVjaWZpY2FsbHks
IGNvbnNpZGVyIHRoaXMgY2FzZToNCg0KMS4gQVAgaXMgcG93ZXJlZCBvbiBidXQgaGFzIG5vIHB1
bGwgb24gdGhpcyBsaW5lDQoNCjIuIFRoZSBCbHVldG9vdGggY2hpcCBpcyBwb3dlcmVkIG9mZiBv
ciBvdGhlcndpc2UgY29uZmlndXJlZCB0byBub3QgZHJpdmUgdGhpcyBsaW5lLg0KDQpJbiB0aGF0
IGNhc2UgdGhlIGxpbmUgd2lsbCBiZSBmbG9hdGluZy4gSXRzIHZvbHRhZ2Ugd2lsbCB3YW5kZXIg
YXJvdW5kLCBpbmZsdWVuY2VkIGJ5IG90aGVyIHBhcnRzIG9mIHRoZSBzeXN0ZW0uIFRoZSBkb3du
c2lkZSBoZXJlIGlzIHRoYXQsIHNvIEknbSB0b2xkLCB0aGlzIHdpbGwgY2F1c2UgcG93ZXIgZHJh
dyBvbiB0aGUgQVAuIEVhY2ggdGltZSB0aGUgdm9sdGFnZSBvbiB0aGUgbGluZSBmbG9hdHMgYmV0
d2VlbiB0cmlnZ2VyIHBvaW50cyB0aGF0IHRoZSBBUCBpcyB3YXRjaGluZyBmb3IgaXQgd2lsbCB0
cmlnZ2VyIHNvbWUgbG9naWMgaW4gdGhlIEFQIGFuZCBjYXVzZSBwb3dlciBjb25zdW1wdGlvbi4g
VGhhdCdzIHJlYWxseSBub3QgaWRlYWwuDQoNClNvIGJ5IGRpc2FibGluZyB0aGlzIHB1bGwgeW91
IG5lZWQgdG8gYmUgX3JlYWxseV8gc3VyZSB0aGF0IHRoZXJlJ3Mgbm8gY2FzZSB3aGVyZSB0aGUg
QVAgaXMgb24gYW5kIHRoZSBCbHVldG9vdGggY2hpcCBpcyBwb3dlcmVkIG9mZiAvIG5vdCBkcml2
aW5nIHRoZSBsaW5lLiBJbiB0aGUgcGFzdCBJIGRvbid0IHRoaW5rIHdlIHdlcmUgY29udmluY2Vk
IG9mIHRoaXMsIHdoaWNoIGlzIHdoeSB3ZSBjb25maWd1cmVkIGEgcHVsbCBidXQgdHJpZWQgdG8g
bWF0Y2ggaXQgd2l0aCB3aGF0IHRoZSBCbHVldG9vdGggY2hpcCB3b3VsZCBkbyBhbnl3YXkuDQoN
Cg0KU28uLi4gSG93IGFib3V0IHVzaW5nIGJpYXMtYnVzLWhvbGQgaW5zdGVhZD8gVGhhdCBoYXMg
dGhlIGFkdmFudGFnZSBvZiBrZWVwaW5nIHRoZSBsaW5lIGZyb20gZmxvYXRpbmcgYnV0IGFsc28g
c2hvdWxkbid0IGNhdXNlIGEgY29uc3RhbnQgcG93ZXIgZHJhdy4gSSBiZWxpZXZlIGl0IHdhcyBj
cmVhdGVkIF9leGFjdGx5XyB0byBkZWFsIHdpdGggdGhpcyB0eXBlIG9mIGNhc2UuIEkgZG9uJ3Qg
dGhpbmsgSSB3YXMgZXZlbiBhd2FyZSB0aGF0IHdlIHN1cHBvcnRlZCBiaWFzLWJ1cy1ob2xkIHRo
ZSBsYXN0IHRpbWUgd2UgaGFkIHRoaXMgZGlzY3Vzc2lvbiBhbmQgaXQgc2VlbXMgbGlrZSBpdCB3
b3VsZCBzb2x2ZSB0aGUgcHJvYmxlbSBuaWNlbHkuIERvZXMgaXQgd29yayBmb3IgeW91Pw0KDQot
RG91Zw0K
