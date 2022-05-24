Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827C85329E8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbiEXMCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiEXMCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:02:53 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2F55DBD8;
        Tue, 24 May 2022 05:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1653393772; x=1653998572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xPRS7XXn1x1slgMeSnWyvzKSzfbnWRs0Jo0NHzF694E=;
  b=ez5d3ttXBScbtp1B/W97pkFCqSErfIXpE+NITRccuLJdEhqu7j8ezvXB
   kKSYouRagM3+YK1NRU7Nk4bDDhAobdhcqeuMkbGuWYNJmzE+sJaqURbN0
   ci6tFVh1wFgh7cF4C+2amdULDiDlkjxQGsEPvfeyXKOM16uMkbrpCW8Sa
   w=;
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 12:02:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOH5rIK0dsIB1eyp32g19hqF6ueL6QVBaHs5LyMYQKGrf+px9geTNh8+CubXaYIPUpeOO4nHwnYBPujl/8vK7MFt8Vtoxa/v4pywWQc/cy9KTvIgBOn8xUCEPyHTcgioHC4PbWxsK9KjRPkJ7lbNYCBd/UfkODGeCR9dnutIgWEjNHy17gXmABRPF+UY3r5qEiZWHfekaNQFypB7e81s/nWisXazPJwB5Np/cV16jwOzUK1+TqyAJm0ENFTEG9HvL3MUyOf2Cynr+YsrGfDz85ObcanKcI+M6pvcObLNSSXxkhFDed9Vi5Cil5Qdzarco+GRHpdyGtv4DfZNskABXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPRS7XXn1x1slgMeSnWyvzKSzfbnWRs0Jo0NHzF694E=;
 b=UYqp1NSVqGCq97gfWhNvMaqv8CBpsOoBZHwSAhTqxyQyLUQvtt/T3RhizQPjPc3k70GbnFcqNGZCPdPvvdlnt+Ju/p6kkL6D8DJAbJOFy1bgUkXXSxvlSUgJ3CELeDnwcWiXUNBjn2NLSEE1vgC/GkanTb5WKmmgorF3Sgnv6yAq6NoBE0jpT/hsQH7mMPqP7Hsi1KkdPeNXYO7qzmm73F2s+n33ClEanvHxQnWsmiA84+QZAO8+Q6Lqev/soP2lwriPjpn1L4RJwVyDbkla8NjLoQg69LN+bbO0oKJehnJz8CJ/+PLx9pF3oQx1u5olEOEMOjPYo6hzQVtSb5uT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from MWHPR0201MB3466.namprd02.prod.outlook.com
 (2603:10b6:301:7b::26) by DM5PR02MB2555.namprd02.prod.outlook.com
 (2603:10b6:3:48::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 12:02:47 +0000
Received: from MWHPR0201MB3466.namprd02.prod.outlook.com
 ([fe80::9cea:75bd:9c0c:2865]) by MWHPR0201MB3466.namprd02.prod.outlook.com
 ([fe80::9cea:75bd:9c0c:2865%5]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 12:02:46 +0000
From:   "Kamasali Satyanarayan (Consultant) (QUIC)" 
        <quic_kamasali@quicinc.com>
To:     'Adrian Hunter' <adrian.hunter@intel.com>,
        quic_spathi <quic_spathi@quicinc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>
CC:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Subject: RE: [PATCH V1] mmc: core: Enable force hw reset
Thread-Topic: [PATCH V1] mmc: core: Enable force hw reset
Thread-Index: AQHYWUgDeSo2V0TNA0e+gb7Em5ZSiq0Ds3AAgCpmXG4=
Date:   Tue, 24 May 2022 12:02:46 +0000
Message-ID: <MWHPR0201MB3466CC9C676988E90D5D7D6FE3D79@MWHPR0201MB3466.namprd02.prod.outlook.com>
References: <1650961818-13452-1-git-send-email-quic_spathi@quicinc.com>
 <7db46c19-a92a-a13a-eb63-38e5ed31580f@intel.com>
In-Reply-To: <7db46c19-a92a-a13a-eb63-38e5ed31580f@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 390a75e9-ca6c-401a-9de4-08da3d7d512a
x-ms-traffictypediagnostic: DM5PR02MB2555:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR02MB2555BF0D83D0F37C618A2A0C9FD79@DM5PR02MB2555.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMNO5sy7KvnZIVJ3safW8+0EKWvmk7KsfC+Wn+LqA/W8s5EuyiepqpTd5wnlNcLPT7O0/A9dH24Vj6P7d1VH7BjaTm+i5UYiuieufKVtWW7QmuQzitiRWxLMlyLdRvnvyO6A20bV6VIxLgwQmCou41hMSCjwKPMHrCJDH0wyvgwKYcvg8qG8CbRqGteyTTQviOSwVex7uIiPjh0xsAkV8HzrCCVWjz7Vq8tM5uHerkjvo8wS8BOf7dm4l5+n+P6YupHpPQuwif6bsSlhRXfmbKamrlhqw+8DEr25kHgqKJ0Epb465bUcltGY/CJ/V4/swVz9XBSDiw2E97yGiKINK6CRkQnt/BXSWwt8H+QcF/Gj5DxazP1fEVPmzqmRUwDF+cBDTzFfH/7rVTFXib4qMeQO0TqthYCEtSGlilc+L7uCMrhKsQEP7xloB19lUbU8YjKQcCxLfUDYMCQugR4MN79zYavwiM1qZlRFVeiAaKBDHFlR6IzcjynwA84pyHEAcPi5FVogXMw1CaQk9RD/wkDqkn5ck98yaZaYH/XueKsZec8wuD7zv49PfcUv9ZvgSUfmOXThIQ1JECwWqTGN1hFt66FptEhpnm8psQtD79/jCF2KQoC8XyRLBuInIMLIBXO6tjtjSDH1fgtHaFnRcmbBUX/wCYsUVNcU+ud6zPbH4+xD9i4VevGejmyCkpFbYRKv8rkF1WRDYPoif07AK/azLETCQ8FMhiHKy/QydxU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0201MB3466.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(83380400001)(76116006)(921005)(55016003)(38070700005)(38100700002)(122000001)(6506007)(7696005)(66946007)(110136005)(71200400001)(64756008)(508600001)(66556008)(316002)(66476007)(6636002)(66446008)(2906002)(8676002)(4326008)(26005)(5660300002)(53546011)(7416002)(9686003)(52536014)(33656002)(8936002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZG5xWk4wUTh0ZlBsUS80SGllejM2enVUdDlWWW5vQlFrTGVZakp2SjNLRzBz?=
 =?utf-8?B?MTk1eFhGRS82aURsUzBINzNHVjVDWkJGanE2OWUxKzFEQ0NDNjJTbXZ0RlNP?=
 =?utf-8?B?QzE3S0VDUmZMT2pGVlJRdXp5NnZnTEh5OW8xVmJhZkhqbGdyVzhORWhDelk0?=
 =?utf-8?B?aG4xbGxJWGtYN1cxK1B4NmRUM25KdFF2OEwydUxLZDlJVnNKaWRuVHZEeFdQ?=
 =?utf-8?B?Q0hHMmNNdUkvNnlCK2w5Sk5JYW5kT0wwRm1EZzZXR1FKMHUxUTJGai9zZ2pX?=
 =?utf-8?B?YmJMUjl0U2pVMlB4VFYzUlVLbDkvaWhWWkFqTlFrMnYydytrU29MbHZBdUYv?=
 =?utf-8?B?QkFHaGsvTmZlcXphL0lwb1pyYTlCL3JKakhSTytRbnRFcDdlYmZPcG85bGx6?=
 =?utf-8?B?TVpRL29LM2JlRFBFVWdGeXdaa1VkZnhWMFFGT2d4TmJnd2tiOWYxUnJrbnhP?=
 =?utf-8?B?czFhVTQraEhEK0cyQ3E0MER4RTV3TU5tVFdaMmxid1R6N1RwNW5pb1ZtZmlR?=
 =?utf-8?B?Nzk2aG1MMWZpRFdvc0RWWHMrM0JoN2N6N2d1VFNGUTgvRTVJNmowQUNKM2w5?=
 =?utf-8?B?UWx0QlplN3podXduQVZSMFBpWjJTakRKWnBhVUMxNFkyUXlaMVBJRWpOU1dI?=
 =?utf-8?B?V0dzRlNmdWJZVmtDYU9lWHFlcmZnVzlJLzFnM2J6VUNiWm9kQUJBWkI4a3o4?=
 =?utf-8?B?K2k1S1VUN1IyMGdUR3NsRXNXeVBHNHVzRUs4U2Jid0w3YmNFUFBQZHBIenIx?=
 =?utf-8?B?bmhBT2tTZnRkcjROMGVibXhVS0pKNlAwdit3bG1NR1hkY0hYNitFSEF1MmNU?=
 =?utf-8?B?STVSaW9McUJDSDRWSVlST3pDZ2xTc0JBdGZTQ1NUM0J4WGRuWndkR05OZWRn?=
 =?utf-8?B?blpzeTRwVXhZR2FQSWh6WWNiSmRVYkdiZUtHcGhCaklaQzdLdXEyVEhLSmIv?=
 =?utf-8?B?SSsvSk9sQ29RMkdMcXd6UWJkVGF6RVNFK3UvcG92blk1aFlYYmVrVytrdVB4?=
 =?utf-8?B?VnFVVzgwcUpwUnh6OGFFbExZTkt0U3NiTFN2dU5WSERPRTU0blI4eGFudG41?=
 =?utf-8?B?L3pNV0x6L2x4RjZxTUl1cWwwRktSb2VScDQwTVVFTHlsZDVkd0ZmWXRkMElX?=
 =?utf-8?B?SzlzUFNiYTFVdEw4NVBBSktCZ2c5SkhPMzlyell1cnFMWVpCUkpYM2hYVXF1?=
 =?utf-8?B?clFiMzN0RVkvWkxYSm94Ukd2ajVES2xCTXV5azBlWlpiY0hkRzh0UkI1OGRS?=
 =?utf-8?B?ZnE2RmlkM3d6RUVWWXIvVmlWK21IQ1FHdDBuVkNlWnBBcHh6bjV3aVhjL2tk?=
 =?utf-8?B?cVhKOWZJODJNa0xmZWt1ZTJkampBOTFORmFxb05FRmdEb0RwVTdFREhvWVl2?=
 =?utf-8?B?cWFxUitCWjJFUXdYOGlGNmQ1UlV2d3hSbjY5OUV2UWVMa21IMHJuWjNxczVZ?=
 =?utf-8?B?dGpqNWd5M044S3hCUmhSUDlsOGRwOW5PL2lVU0tQVE0yclU0KzF3YStIWmZ5?=
 =?utf-8?B?T1M4akJRaFF0KzVKS0s2Qk9VOHhlK1h3SlZQVzk0T3NNNjV4U0xXSkIwczB3?=
 =?utf-8?B?UngxSSt3OU5UVGNyVjJzTDlJNHEzTWpLUjh4Z253VzJMQVdvV0JncEpFdEVP?=
 =?utf-8?B?NExUeXlhbHVEVXhLRndBRGRDWmNxc3hDQnJVRmVDVUFuRHQxbnUybVo2cUxr?=
 =?utf-8?B?cFZrOE83S3dCQmpTK0p1Ry9mYitFZnVJOFlwUnRvbktjWnl5ZVNHSnNBUHpG?=
 =?utf-8?B?aUpoWmVocy83YzZwd21FclU2ZDJ3bjFDL3dBREVPUklEbVhFVGtPRmlSZWZS?=
 =?utf-8?B?Z3MxcUhFS0NDUUNNUkFURExxczFSRHJVanBVQWhBTXRHRFBOVlFtZGFYT0p4?=
 =?utf-8?B?cnEvODYvSjNBN3ZNZzV6T250b2k1WmxXMGt5TERJcnNxVjg1eWJQNFJGWXJN?=
 =?utf-8?B?aTEyeDNpNXVUN1I5bHR0bUt1aDdlTGFKbThSM3VROUgrOExxcDFublE0cnd6?=
 =?utf-8?B?b3lOS3ZVeksveklqUklLd29WMjQxVzJ6b0lPODdmblp6NGh0TklMcENDT2lJ?=
 =?utf-8?B?dnNkT0lmdlRLR21oa25hTUxJSUlPUFEweFhUQ2NvRSs2NUxOVWpjUnoyWTZV?=
 =?utf-8?B?TFpBSk14ZmpmT3pkeHB2Z0FOVTZVR3ZOUXBwV0hZeVM0NmxwVkFTUStrZndW?=
 =?utf-8?B?UWVBeEl3QzZqVVRSM09NdjRMNFE5RkJ6eW1scDYxVEpvYS9RWUFSKzArS3Bt?=
 =?utf-8?B?cmYzNUtib2tqbG5wZEdwSVlScHFBUGFmdERVb1VvaFRycGFXNk0zb3R6bmJu?=
 =?utf-8?B?NmhvWkdPMjFjUkJsNlFHZEhKaHUyakRveFFibFpzUjEwVjUzMVFOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0201MB3466.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390a75e9-ca6c-401a-9de4-08da3d7d512a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 12:02:46.7831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xy2NJ8Q2kog8SVu+PU4akL21F5/wsiQLboLxjTwcTwVq1tBhNyTXVHgQ82WYlzt5P6d3pyiy3sqzp1D+F9sS/Z1KPMfjHaVD/odEM8/3o0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2555
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpUaGVzZSBwYXRjaGVzIHdpbGwgYmUgZnVydGhlciB0YWtlbiBieSBTYXJ0aGFrLg0KDQpU
aGFua3MsDQpTYXR5YQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWRyaWFu
IEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBBcHJp
bCAyNywgMjAyMiA2OjA0IFBNDQpUbzogcXVpY19zcGF0aGkgPHF1aWNfc3BhdGhpQHF1aWNpbmMu
Y29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgcml0ZXNoaEBjb2RlYXVyb3JhLm9yZzsgYXN1
dG9zaGRAY29kZWF1cm9yYS5vcmc7IGF4Ym9lQGtlcm5lbC5kazsgYXZyaS5hbHRtYW5Ad2RjLmNv
bTsga2NoQG52aWRpYS5jb207IENMb2VobGVAaHlwZXJzdG9uZS5jb207IHN3Ym95ZEBjaHJvbWl1
bS5vcmc7IGRpZ2V0eEBnbWFpbC5jb207IGJpZ2Vhc3lAbGludXRyb25peC5kZTsgbGludXgtbW1j
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KQ2M6IFNoYWlr
IFNhamlkYSBCaGFudSA8c2JoYW51QGNvZGVhdXJvcmEub3JnPjsgS2FtYXNhbGkgU2F0eWFuYXJh
eWFuIChDb25zdWx0YW50KSAoUVVJQykgPHF1aWNfa2FtYXNhbGlAcXVpY2luYy5jb20+DQpTdWJq
ZWN0OiBSZTogW1BBVENIIFYxXSBtbWM6IGNvcmU6IEVuYWJsZSBmb3JjZSBodyByZXNldA0KDQpP
biAyNi8wNC8yMiAxMTozMCwgU3Jpbml2YXNhcmFvIFBhdGhpcGF0aSB3cm90ZToNCj4gRnJvbTog
U2hhaWsgU2FqaWRhIEJoYW51IDxzYmhhbnVAY29kZWF1cm9yYS5vcmc+DQo+IA0KPiBEdXJpbmcg
ZXJyb3IgcmVjb3Zlcnkgc2V0IG5lZWQgaHcgcmVzZXQgdG8gaGFuZGxlIElDRSBlcnJvciB3aGVy
ZSBjcWUgDQo+IHJlc2V0IGlzIG11c3QuDQoNCkhvdyBkbyB5b3UgZ2V0IElDRSBlcnJvcnM/ICBE
b2Vzbid0IGl0IG1lYW4gZWl0aGVyIHRoZSBoYXJkd2FyZSBpcyBicm9rZW4gb3IgdGhlIGNvbmZp
Z3VyYXRpb24gaXMgYnJva2VuPw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaGFpayBTYWppZGEg
QmhhbnUgPHNiaGFudUBjb2RlYXVyb3JhLm9yZz4NCj4gU2lnbmVkLW9mZi1ieToga2FtYXNhbGkg
PHF1aWNfa2FtYXNhbGlAcXVpY2luYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYXJh
byBQYXRoaXBhdGkgPHF1aWNfc3BhdGhpQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
bW1jL2NvcmUvYmxvY2suYyAgICAgIHwgOCArKysrKy0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9j
cWhjaS1jb3JlLmMgfCA3ICsrKysrLS0NCj4gIGluY2x1ZGUvbGludXgvbW1jL2hvc3QuaCAgICAg
IHwgMSArDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIGIvZHJpdmVy
cy9tbWMvY29yZS9ibG9jay5jIGluZGV4IA0KPiBiMzVlN2E5Li5mNjNiZjMzIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMNCj4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9i
bG9jay5jDQo+IEBAIC0xNDgyLDEwICsxNDgyLDEyIEBAIHZvaWQgbW1jX2Jsa19jcWVfcmVjb3Zl
cnkoc3RydWN0IG1tY19xdWV1ZSAqbXEpDQo+ICAJcHJfZGVidWcoIiVzOiBDUUUgcmVjb3Zlcnkg
c3RhcnRcbiIsIG1tY19ob3N0bmFtZShob3N0KSk7DQo+ICANCj4gIAllcnIgPSBtbWNfY3FlX3Jl
Y292ZXJ5KGhvc3QpOw0KPiAtCWlmIChlcnIpDQo+ICsJaWYgKGVyciB8fCBob3N0LT5uZWVkX2h3
X3Jlc2V0KSB7DQo+ICAJCW1tY19ibGtfcmVzZXQobXEtPmJsa2RhdGEsIGhvc3QsIE1NQ19CTEtf
Q1FFX1JFQ09WRVJZKTsNCj4gLQllbHNlDQo+IC0JCW1tY19ibGtfcmVzZXRfc3VjY2VzcyhtcS0+
YmxrZGF0YSwgTU1DX0JMS19DUUVfUkVDT1ZFUlkpOw0KPiArCQlpZiAoaG9zdC0+bmVlZF9od19y
ZXNldCkNCj4gKwkJCWhvc3QtPm5lZWRfaHdfcmVzZXQgPSBmYWxzZTsNCj4gKwl9DQo+ICsJbW1j
X2Jsa19yZXNldF9zdWNjZXNzKG1xLT5ibGtkYXRhLCBNTUNfQkxLX0NRRV9SRUNPVkVSWSk7DQo+
ICANCj4gIAlwcl9kZWJ1ZygiJXM6IENRRSByZWNvdmVyeSBkb25lXG4iLCBtbWNfaG9zdG5hbWUo
aG9zdCkpOyAgfSBkaWZmIA0KPiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2ktY29yZS5j
IGIvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS1jb3JlLmMgDQo+IGluZGV4IGIwZDMwYzMuLjMxMWI1
MTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2ktY29yZS5jDQo+ICsrKyBi
L2RyaXZlcnMvbW1jL2hvc3QvY3FoY2ktY29yZS5jDQo+IEBAIC04MTIsMTggKzgxMiwyMSBAQCBz
dGF0aWMgdm9pZCBjcWhjaV9maW5pc2hfbXJxKHN0cnVjdCBtbWNfaG9zdCANCj4gKm1tYywgdW5z
aWduZWQgaW50IHRhZykgIGlycXJldHVybl90IGNxaGNpX2lycShzdHJ1Y3QgbW1jX2hvc3QgKm1t
YywgdTMyIGludG1hc2ssIGludCBjbWRfZXJyb3IsDQo+ICAJCSAgICAgIGludCBkYXRhX2Vycm9y
KQ0KPiAgew0KPiAtCXUzMiBzdGF0dXM7DQo+ICsJdTMyIHN0YXR1cywgaWNlX2VycjsNCj4gIAl1
bnNpZ25lZCBsb25nIHRhZyA9IDAsIGNvbXBfc3RhdHVzOw0KPiAgCXN0cnVjdCBjcWhjaV9ob3N0
ICpjcV9ob3N0ID0gbW1jLT5jcWVfcHJpdmF0ZTsNCj4gIA0KPiAgCXN0YXR1cyA9IGNxaGNpX3Jl
YWRsKGNxX2hvc3QsIENRSENJX0lTKTsNCj4gIAljcWhjaV93cml0ZWwoY3FfaG9zdCwgc3RhdHVz
LCBDUUhDSV9JUyk7DQo+ICsJaWNlX2VyciA9IHN0YXR1cyAmIChDUUhDSV9JU19HQ0UgfCBDUUhD
SV9JU19JQ0NFKTsNCj4gIA0KPiAgCXByX2RlYnVnKCIlczogY3FoY2k6IElSUSBzdGF0dXM6IDB4
JTA4eFxuIiwgbW1jX2hvc3RuYW1lKG1tYyksIA0KPiBzdGF0dXMpOw0KPiAgDQo+ICAJaWYgKChz
dGF0dXMgJiAoQ1FIQ0lfSVNfUkVEIHwgQ1FIQ0lfSVNfR0NFIHwgQ1FIQ0lfSVNfSUNDRSkpIHx8
DQo+IC0JICAgIGNtZF9lcnJvciB8fCBkYXRhX2Vycm9yKQ0KPiArCSAgICBjbWRfZXJyb3IgfHwg
ZGF0YV9lcnJvciB8fCBpY2VfZXJyKXsNCj4gKwkJbW1jLT5uZWVkX2h3X3Jlc2V0ID0gdHJ1ZTsN
Cj4gIAkJY3FoY2lfZXJyb3JfaXJxKG1tYywgc3RhdHVzLCBjbWRfZXJyb3IsIGRhdGFfZXJyb3Ip
Ow0KPiArCX0NCj4gIA0KPiAgCWlmIChzdGF0dXMgJiBDUUhDSV9JU19UQ0MpIHsNCj4gIAkJLyog
cmVhZCBUQ04gYW5kIGNvbXBsZXRlIHRoZSByZXF1ZXN0ICovIGRpZmYgLS1naXQgDQo+IGEvaW5j
bHVkZS9saW51eC9tbWMvaG9zdC5oIGIvaW5jbHVkZS9saW51eC9tbWMvaG9zdC5oIGluZGV4IA0K
PiBjMTkzYzUwLi4zZDAwYmNmIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tYy9ob3N0
LmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9tbWMvaG9zdC5oDQo+IEBAIC00OTIsNiArNDkyLDcg
QEAgc3RydWN0IG1tY19ob3N0IHsNCj4gIAlpbnQJCQljcWVfcWRlcHRoOw0KPiAgCWJvb2wJCQlj
cWVfZW5hYmxlZDsNCj4gIAlib29sCQkJY3FlX29uOw0KPiArCWJvb2wgICAgICAgICAgICAgICAg
ICAgIG5lZWRfaHdfcmVzZXQ7DQo+ICANCj4gIAkvKiBJbmxpbmUgZW5jcnlwdGlvbiBzdXBwb3J0
ICovDQo+ICAjaWZkZWYgQ09ORklHX01NQ19DUllQVE8NCg0K
