Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC79B4DA96D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 05:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353550AbiCPExw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 00:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiCPExu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 00:53:50 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8229D5F8CB;
        Tue, 15 Mar 2022 21:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1647406355; x=1648011155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k1b7p39rkG8X7ICFTJr/zZVOiHiD72wP4A717MOIr4Y=;
  b=bkMI0Ma/Z0Tb5Eu2yj95LJZa2uuV8QZ8YWIfc9ZtY0zFty3NhWoVLL2B
   gW/7BB5UhH5m6NaNUt0iQLvYWAMFh2ij3RvoqK0ICZNm9UDWq8ng0Rsen
   onaIeSjMIjFJIsgHsgy2Q5RX+on+Zg4n3oscwhxKXmrfDRPwBEbU+0aGh
   w=;
Received: from mail-dm6nam08lp2043.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.43])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 04:52:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/V8neulaoqgbI41/lwIMPvS+6rZIiI24cClgLS9TvMzf2/UuBrhqxbL5UimdYU0yrrQ6ik4iOarn9YJnYeisJLAHdeHRwsNtaQ124xLz7yLEH8k4G8YhBu0lKyA8I7spe5Qx4oGig0KfKlIqIXNvZK1NFXwYjHse12nhVtnFMI9WHomm7dTmUTSzLIqQ4tgzmm0KYAVuGTYI45TKqvtDdz1pOdGRxadHyTABWfbdbdeqwOiIm7NEdBj4DDcs+pF0678hA1ugGHI+72pux8v6jWvvrCEhkzkDkIjwvkkDGqGIkw6zOL2Sbo3JdRvD2ZDK+udn3dtrR5AIT+3Lm1JKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1b7p39rkG8X7ICFTJr/zZVOiHiD72wP4A717MOIr4Y=;
 b=OFTMzyrR7GuPjY99d6rLIqLJ7lsdqyzwLqq1xT9+ptYLXIqr+sU1nEYm3T/2ZWAG7KftWWDK7X3mUaasqAxq7PIRO6ItQ4NqKsQgupmRn1XMj8Ys04CLphyAIx5m3ev1OvuNVn2cEivXiviUTjguHmjq0eERFqYkchJdHUfM1ApjxiBAw4LcQK/LXhdQoaQdl/gXPkiakT2zOyF+x/h7CKPIX1c1IGQlQA03B+10JH8mEXwzHm6kCWDzw2NSJWpq2v9qJ1KtRZWLFWU/tI221DvcAkal5Uacz0BusExgQKRga8QwwY1xf2tONgsEQ2RIIs1a0T1+34Ge16f95ayPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL0PR02MB4564.namprd02.prod.outlook.com (2603:10b6:208:4d::13)
 by SA0PR02MB7500.namprd02.prod.outlook.com (2603:10b6:806:e9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 04:52:31 +0000
Received: from BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::9c32:a1d2:b88b:466d]) by BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::9c32:a1d2:b88b:466d%6]) with mapi id 15.20.5061.029; Wed, 16 Mar 2022
 04:52:31 +0000
From:   "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
To:     "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>,
        Doug Anderson <dianders@chromium.org>
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
Thread-Index: AQHYIaNir99tB67bpEut/O2NV51De6ysZZ+AgAMmebCAB6PVkIAKbUjQ
Date:   Wed, 16 Mar 2022 04:52:30 +0000
Message-ID: <BL0PR02MB456419577460FFDE351AE7B7FA119@BL0PR02MB4564.namprd02.prod.outlook.com>
References: <1644843828-20464-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=XtkXganjG=ddgaq4-p+cAK1c4jqG=8Ux_xxdUrPpXhVA@mail.gmail.com>
 <BL0PR02MB456421F83B9C88139514399EFA059@BL0PR02MB4564.namprd02.prod.outlook.com>
 <BYAPR02MB45650334FEF776E0C6CBFF1AFA0A9@BYAPR02MB4565.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB45650334FEF776E0C6CBFF1AFA0A9@BYAPR02MB4565.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f60e852e-98a3-4746-80b0-08da0708c748
x-ms-traffictypediagnostic: SA0PR02MB7500:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SA0PR02MB7500D109A9B21FE3B109D9E786119@SA0PR02MB7500.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h4rVvKnx/eY9P6EjT6kt+IPxFyRZIdOvqhhj1mcP3xZaYu6EEPssw5JOYGqMg4Ch38lzI1oWv/cpLF8dQGrs5T2tFIm46LTFth+LHLRaXxjoyX8H6aYDue43PL41OvvFOWzT7Fa4x8fOi+LWYc9IBi72A1lZ5kS0Td9iC0bDmUfTxyJMEKqekfRMQ6zbh4cmaoDAUvAYPCSV1YRo2oHd7puZG9Qy9U3l3n9nUAwNCjCfEDUrfeMy+dqdjYKKCtyWmtlJeiEd9v/kfj7N05AnnAWHW4dMtN7mHg0I+Kw5ovrQfBQJiqLcLhlHPGz/PrT4Oa1dMbDFQpve4G3CQRiwq7NTI7lGap9IRpBmDszMM1Dsam4DXVqvG+df06Zvuq2kRG4ebTRwVNCU0ZMbdYKsaN2Sw4GtSc/XB9PrcZRJHsRycXaCBgBFbet3hUNtDFkkvyluuz/FLMpnG4IhcBT9dBHAxX+RN7W3pfD+fIABpTs9gWnXq5LDssdYyFmyPE2UOmSNy1+ZH+iVx7V3dQNOXNqtnlx153ezDbHDkCbk6F2AlRwMPFITCKJj5xW0zP0X/edgW09YyCKsmoThDBg/KoK4+QDO4CIQhYjBYZlXXYkfaAtcdr2wKycbDx3rdJdOjywMpNySCcTAcqSRYoK6LHZv8F8Q8E9QtE65bZI1tnZA5k9VW3EgZ2jmCW2K1dCkTkoMSNhopuEtuSLVMICySA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(4744005)(52536014)(86362001)(5660300002)(38100700002)(107886003)(55016003)(122000001)(26005)(186003)(110136005)(83380400001)(9686003)(7696005)(6506007)(53546011)(38070700005)(66946007)(508600001)(66446008)(66476007)(66556008)(76116006)(64756008)(8676002)(4326008)(54906003)(316002)(71200400001)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWdIbEdnMU96WC9BSHkxQUZwSTlNNHBRckpRanRydG9hRCtzYlhITlo0RVVY?=
 =?utf-8?B?bnNnUVczejlOTHFDMG1VREtvakFIb0xJK2kxbDZodGdrZ1dwVVRPZTFhZDRM?=
 =?utf-8?B?NFJyblNjT0NFZ2NsWU43WFVvTXh1cTJoUW81YmVDVFBtZVdFSDk5cWxScHZH?=
 =?utf-8?B?dDZEOGxFSlZKTEFxL2YrVG1jS1lzNHhSaGIyQS9RNW8zUHVhM2EyVlFmbWIx?=
 =?utf-8?B?UUNkZHk4Yjh6R3cxckV4SnlXWlA4RmRwajlUYjhIUFNxNENJVnJFUGxLMmhh?=
 =?utf-8?B?NkV1bnpzKzBJM0lWQlN0Nk5uV3hxR3RuTmZQR2dSZitmTkNBbnFiUGoxaWgy?=
 =?utf-8?B?Yy85NURicENUMkJMUXdMKzB6VEpJVWVHUU8wdElHYVp6b3RtTTRwdk5hM1ZS?=
 =?utf-8?B?aHJjdnF5dUwva0xVTnFKWThyQ0d5ZjdhMjcvU1IrYk1abWFYOE9hMmVINStB?=
 =?utf-8?B?eEFzR2tyUVFXUFFHUlRvSTdrekxuQXkvaDBNdnlRVnc4R0tGb20yTmJ1Z0M1?=
 =?utf-8?B?YUIxVS81MERBN0JpRFNkd1M1RHo1aldQV0dFTTh2SDFtRFk4MHIvQ1J6VThJ?=
 =?utf-8?B?MWtWa0t0eFd5YVFRbkVtMm5PdDlBZWF1d3hBWnYvT0UyUVBDRU5tWHdld3RZ?=
 =?utf-8?B?V09ZSkNvaWRSSDFxa0wzZVpUYUpCSEdoKzBLbnNuRGpCMFNTVUVOcHowMEFV?=
 =?utf-8?B?OUVjWVpXREw3dWZmYldmclpOOWFyZ1dENmIzbldzbVZCUWVNbWIvckw1d0Nm?=
 =?utf-8?B?OU1FYUJFeFQ2c0g1ZWw0aW1WcmJFcWdtSjFGWHpvdXpGVERuNFEyZGNYRDZ4?=
 =?utf-8?B?L0VuS2FId04vbkgwY29XKzJ0aVVPeVAwVFZGdjFSRlh5aDhBVGRsOFo3NGVD?=
 =?utf-8?B?NXYyL1RwT2JWYkh6eEViT1lkMFdYZmZlVVYwaXpONHF0TUxNaGd1SkltbmVj?=
 =?utf-8?B?dlFNd1FYVnh5Vk5TZFJRK0lDSGZXeUxQcTNsQUFCUzdyR0pUMkRpUUFsOUJS?=
 =?utf-8?B?RnI1SC9yOTdyUzB1UnVzZ0s2THlyRHpyaTBib2NyOUNCL29Ddmd6NE5vd09C?=
 =?utf-8?B?bXViVXB2WkJaeWs1anByTVJ1UGdVeUF0WFpObHE0amlIcENJdHcrYUVYUjlu?=
 =?utf-8?B?N3kyTEw5OVpUSkNiVENCdE43REF0c3lmSTVPZnpzVEZ2TWlQUGxKcncxY1dn?=
 =?utf-8?B?WVAyN2xjUmdjNnZqSkpzV2JUcHlhbVg2VjdOdUc2NndNWTZlUW1MOE0xcGdz?=
 =?utf-8?B?Q3B1Q1RYNE5OeHgvdVI2bGxTUEZITVB4aEdLZ01nSGdlNUpybjFJMXVmRGFj?=
 =?utf-8?B?Qlp6K3lZcml1Sm5GcmhoZjhZMEdtUVZ6cTQ2RzJWaGI0OGFHUW9pTE5hWk40?=
 =?utf-8?B?UmJ2dHB2OVp4VVluZEMzWTd0NGZwM1QzOGdpR1N1Zzk2aWdCb3dYTGhrV1Bi?=
 =?utf-8?B?Zm0zYlhLN2cxcHZkRWZ3aWlQOXBLeHI2QXhNOXc5WWlYZG1PKyt1Y3NKQWhX?=
 =?utf-8?B?Zk56Q2hKeWRVcDBsNU1rdU1CQVk2cEl2MHMxSWV0cmE2ejVrTExseFZHVUpj?=
 =?utf-8?B?eTZLWU5SZXdCVjZ6bmsyM0F2cVlCdmNTaTd5NlJqU0xVanRuWjNXV09WMEUv?=
 =?utf-8?B?NkUvNXdwaDc5TWJGT2hJeGFwSzdMRnVPaGwxcENiZm95cVY4cGtBbmlIeUtp?=
 =?utf-8?B?eDdsZnA1TXVLT1VVZjRpQkZMaEFRUkJxMmRxdzEwa2NMUmY1NXFQai9JWXAv?=
 =?utf-8?B?eWZxbUdIeXBPMFN3R0NmTTI4RFY4MUdqMFEwQVBlRjgyL0g2U2JTd2FIT3NM?=
 =?utf-8?B?MWVBTnB4SFBVNUpILzREWWFQZFR4U2dFb2xrRmlvblNYckpwMnNMSUVGUDk5?=
 =?utf-8?B?Mk1VcWwzdDRMNnQ1d20xT0oyNENaTmtuTVhXVnZmcXQ3eXM4Qjhpb1lCOW5w?=
 =?utf-8?Q?ln3b/XzAXWjJMYrH5ur6G82n61xc9am1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60e852e-98a3-4746-80b0-08da0708c748
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 04:52:30.9178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uo12WbJVMc3Qht2gwAof5fsMWcgdbUA2brCS1cbZTxMFvemCPeyRafUtomNRs2ElSwWumX7cQTSOUmVvEBjJ/26qbmZJ/t3xUaUFzgJIXg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGVzdCByZWFkaW5ncyBoYXZlIHNob3duIHNvbWUgZGVncmFkYXRpb24gd2l0aCBiaWFzLWJ1cy1o
b2xkIGNvbXBhcmVkIHRvIGJpYXMtZGlzYWJsZSB3aGVuIGRldmljZSBpcyBwb3dlcmVkIHVwIGFu
ZCBCVCBpcyBvZmYuDQpXZSBhcmUgZG91YmxlIGNoZWNraW5nIHdpdGggdGVhbS4NCg0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVmlqYXlhIEtyaXNobmEgTml2YXJ0aGkgKFRl
bXApIA0KU2VudDogV2VkbmVzZGF5LCBNYXJjaCA5LCAyMDIyIDc6MDIgUE0NClRvOiBWaWpheWEg
S3Jpc2huYSBOaXZhcnRoaSAoVGVtcCkgKFFVSUMpIDxxdWljX3ZuaXZhcnRoQHF1aWNpbmMuY29t
PjsgJ0RvdWcgQW5kZXJzb24nIDxkaWFuZGVyc0BjaHJvbWl1bS5vcmc+DQpDYzogJ0FuZHkgR3Jv
c3MnIDxhZ3Jvc3NAa2VybmVsLm9yZz47ICdiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZycgPGJq
b3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnPjsgJ1JvYiBIZXJyaW5nJyA8cm9iaCtkdEBrZXJuZWwu
b3JnPjsgJ2xpbnV4LWFybS1tc20nIDxsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZz47ICdv
cGVuIGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdT
JyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyAnTEtNTCcgPGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc+OyBNdWtlc2ggU2F2YWxpeWEgPG1zYXZhbGl5QHF0aS5xdWFsY29tbS5jb20+
OyAnTWF0dGhpYXMgS2FlaGxja2UnIDxta2FAY2hyb21pdW0ub3JnPjsgJ1N0ZXBoZW4gQm95ZCcg
PHN3Ym95ZEBjaHJvbWl1bS5vcmc+OyBEaWxpcCBLYW1tYXRoIDxka2FtbWF0aEBxdGkucXVhbGNv
bW0uY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSF0gYXJtNjQ6IGR0czogcWNvbTogc2M3MjgwOiBD
b25maWd1cmUgY3RzIHNsZWVwIHBpbmN0cmwgdG8gYmlhcy1kaXNhYmxlIGZvciBzYzcyODAtaWRw
DQoNCldlIGFyZSB0ZXN0aW5nIHBvd2VyIHJlYWRpbmdzIHdpdGggYmlhcy1idXMtaG9sZCBjaGFu
Z2UuDQpXaWxsIHVwZGF0ZSBwcm9ncmVzcy4NCg0KDQo=
