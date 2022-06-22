Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931F255444A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351837AbiFVH1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFVH11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:27:27 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3620937015;
        Wed, 22 Jun 2022 00:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1655882846; x=1656487646;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0H9B4eRyQTChaF9mT/EOw18yPgEQY7GwJ6KPX1fijuk=;
  b=fJNRycYz+Nu/hY1QK2A+zBWaDCdQnbox/6psCiMtBl8oQCs9mTZry/D4
   RW5MSpgEyuuKQlp8fALLrtIGS+t8dwOfMDGGaEM0k4BkSL0vn6z9O0c7+
   JdG4pRAE2tXJj+pNP8gNm8tLwWfp7i0Ip0U3ol3FWWLTPT8pVOfPiBu1k
   0=;
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 07:27:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTZiYeXb/NTBr4sTAfqEIQ3SXkG4UYPfK2dV4sKi3fvs1hf9sYFYc/fSgmL835iiUA/gd9B43fYPAsmg/oKqAXxFnrlLp6HJ8MDkwawLPqPhCAPLK1XhrkAVgG1Nrqs0vNx7wAWdIaJMYKj9l/6DVyu4s5rSV1F2h2S1UlwN0KvQJGhkDjt/K17cLLSZjDN1g6zvL2JP2es4GZQTq4+WRshxAo5O83AfoxKv+uW6jYWovDhkRm5Ew0PHRE67hT7oy+1fgbWfNfS7f0u+B3NA7UAFkt7cKr7ctWcyD4PQfj5L0FfUXfPYRdJ/Sgddw0UhHGzQZTiR+OH+OgLyhhWAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0H9B4eRyQTChaF9mT/EOw18yPgEQY7GwJ6KPX1fijuk=;
 b=gAKBTc6Y/Rn55NggVfLSIOsqIWauIlEeDXIWsnvrZ/hvrqT8wXt3ZYu/J0Ws+zkDOChG8nJ6oWC2ZJbRinyUuaOWGd4mFshNzaUisvDyicgOyOERmYGtU+0d5RBQMOU5lOoKuJPjzETgB7xqL+AIHercIsC47a2x6Kof5I8+IiiztL8i681e4HSkQLqKfHMk9RCFJY2VEdqVkTSgvtHi7QrXjIhy5jw9haUDJKcrD+lBCLZKBMDDdWojEYg5rvA+OaGWhaQxKUcM0I4EewkobDhTSBeM4OqwDSqiY/kOkdHtQEDtfzZewy6uOFDPHXGtDPZb9LoBEOOXKy0ZV6YzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB7135.namprd02.prod.outlook.com (2603:10b6:a03:298::16)
 by BN7PR02MB5204.namprd02.prod.outlook.com (2603:10b6:408:2a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 07:27:21 +0000
Received: from SJ0PR02MB7135.namprd02.prod.outlook.com
 ([fe80::d4de:5d0c:a1b0:8dbf]) by SJ0PR02MB7135.namprd02.prod.outlook.com
 ([fe80::d4de:5d0c:a1b0:8dbf%7]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 07:27:21 +0000
From:   "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>
To:     Miao-chen Chou <mcchou@chromium.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        Andy Gross <agross@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>,
        "Rocky Liao (QUIC)" <quic_rjliao@quicinc.com>,
        Alain Michaud <alainmichaud@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: RE: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750 HW issue
Thread-Topic: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750 HW
 issue
Thread-Index: AQHYW7ySCA0NvGHfjEC8q8sCBgrRua0G+o+AgADNSyCAD7mPgIBD2h+w
Date:   Wed, 22 Jun 2022 07:27:21 +0000
Message-ID: <SJ0PR02MB7135746D204F13550E9BAE77F8B29@SJ0PR02MB7135.namprd02.prod.outlook.com>
References: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
 <1651228073-1999-4-git-send-email-quic_bgodavar@quicinc.com>
 <0D3D8346-0F64-4CAF-8BED-940F189A3E97@holtmann.org>
 <SJ0PR02MB713538E5BBB40CDEF2E050A0F8FF9@SJ0PR02MB7135.namprd02.prod.outlook.com>
 <CABmPvSFiAC474WthmMX0nE20UEOxUD5dEYBVbiKh7HOovCnCkA@mail.gmail.com>
In-Reply-To: <CABmPvSFiAC474WthmMX0nE20UEOxUD5dEYBVbiKh7HOovCnCkA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b708ef3-5a27-487c-f046-08da5420a515
x-ms-traffictypediagnostic: BN7PR02MB5204:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BN7PR02MB52041226CD1C854D6175005984B29@BN7PR02MB5204.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XZEmtZqQ9dWNyc0wlTfPFFd7OFXdKiEXEKJoaf/RuwN6w/0bhyR8OzOpLilLTVhnE4JggecqaxSGXPdIvt+XIlBao3xKKhhQns2QCn19ItyqXCT92ZGMpJPCei3c8aoGGW8eBdVvlcV/Wh1mbZm5ZWCWpX6feJ6yx+2ysOHpkLuuBSzzCpG6q9zAwrjCoT9VB5h4oicdaf6j4UoHWKG5kuoqPRfSEoQrq9h29iv4k12BkykT18OdMqIS+ICkqQqmhWuQ7Ow6kmST9oxtizcWPSO3yo+3BRJr/Wq5jGvcNB590e7yc6z6504IrdyjvJdZ0b8FissZ9Qw/z5RQDizYoKp/RTW/j3tgXMUcUlDGHz0oGht3gzgE73yRG+38kz7rglkIaXVpNEtebRqGPysQetBmzZ10ktNf4MnUBeeBLk8Q9ZzLfWJC0wcDYEXz+iI24/Y3WOTbzfDXQENvYYjV0dX18XdO4FQFXSHNSvqRtX4jv7pCPH7O6Ou69xmlMGUSeapfGpojDqxkSO2VIYQIn6ANKh3XWxY/kjg4uPvFWO5CRpAKj5YLG69iYUjErOG/+sEKj6VgktvKI+MLyWPPDx4o1W0d4Wr7qi8izKVnO6JQvrwFP7S71RmqtKHH5BgPr4g6cL28eNGz19nOOzn9Gb9+IgEdenSFAtWl30uBoUOS2+gPqJGk2WJmA+gEK/YL6usqc5XT+iicI6B+kf0JbhELDIdfG5Fx6r15LzMU5XLT4Vsi4rOcIa/aI5ddvfIW7vgPOesjaFi8Z43KvgZ4rQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB7135.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(33656002)(52536014)(478600001)(83380400001)(8936002)(7416002)(66946007)(66476007)(38070700005)(53546011)(55016003)(5660300002)(9686003)(71200400001)(186003)(41300700001)(64756008)(7696005)(54906003)(86362001)(2906002)(122000001)(8676002)(66556008)(66446008)(38100700002)(76116006)(26005)(6506007)(4326008)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2VSeGNVRUR0ZGdzS1FTRUU2eGNUWHpjRGUxMGljT0VkUmlVdTNvNys3MHJz?=
 =?utf-8?B?K3ZYSC9vUnpLZEVJOFh6NGRXWUVGdThHeTZ4NzI0bnBFcDVNSnhiblRXdXkx?=
 =?utf-8?B?RmhaZFovQWV5MTU3T2ZCNWxSdUtZWUk2ZXpDMkJ5YkJqTmttYXNsV1JoWWVz?=
 =?utf-8?B?cUVYOTFKWXQxaC9TdmtTMzhFTTBzSGJHaHZXMmxVdTNXV2hDYjE1R3JTUjZy?=
 =?utf-8?B?eDJQMjkvSy9BNGJzVFBjVTlqaytpSVBNM2FaVzRoZUpFSDZBVW5USDRuQkda?=
 =?utf-8?B?VTE3SklCTlBQenRMTkNTSDd3bHQ1UGZpbmlRNVFlYmR2aHhZVzNpdjJkS3hz?=
 =?utf-8?B?cmFQZ29MWmdhTTZBTys2SVV3OExwRjRHTUlyT1p1Wm53QnhVRFZBbzlpaFNX?=
 =?utf-8?B?TEpnTnhmVHpMaGxUTFNvWndpeUNkdGpoNFNtT01hL3ZUS21ucUlqbFFBZWhY?=
 =?utf-8?B?dlY4RjVoaDFmUlV4NUFicUlhS3Z6TmRMMStXdWswNm1nL0NRNG1rREthSFpn?=
 =?utf-8?B?VjlEUkc4TmpYRmV1Nko3clI5QlA1NEcxNDRNRG55MDJLOTl3czkzZWZNbkxw?=
 =?utf-8?B?VmNNQnlBWGpCWC9FTjBxdTJlcktKYUYrb3dXNnNHaS9HbFZJL1ZWanM4cGpE?=
 =?utf-8?B?Y0lRdGxGOVE1UHppTEV0M1hVNDhLT1piOVhrc0JrUEN5Q1g3Y3ByQmN4WjJ1?=
 =?utf-8?B?eEF4SEZGNk9GQnh5M3I1NjExMXYya2tsdURjeWJGRmMza2FYaWNLYi9Ddld4?=
 =?utf-8?B?YXF6S3JYWWdQcHJlVGpJNHZhSkg5V1R5U0tzd3dURi9HMTlPUUJERnlJcy8x?=
 =?utf-8?B?MHJWQjVKenpobnY2c1AvYmt6R2Y5TnRTbmxYbWtOYlhhd0IwWTVBQ0h3V3BR?=
 =?utf-8?B?elZ2eVlvekZENGphNUJkYy9DNzlzekxqNy9uOUFzcm9NcXhWU3pDZkQ2Qjlo?=
 =?utf-8?B?SnEzc2tSdjRFb0xHUnBuN0hNMkVPK1ZhYlhxUU42YkFzdnpKaDB6cVdmSklp?=
 =?utf-8?B?U0psT3RYWS9neGRqYUJZTVE3VVVBLzdXeGhsNWRzR1haQ2NnQTRWSlhCMnlN?=
 =?utf-8?B?UitRbjhYM0RQbWtxZ0NNeGo4VVRlSmswSTJKaU9tZFVNc3BsYnBMNEdydEd2?=
 =?utf-8?B?TXlOc0VmUFFFWDBZTkxYNFdjMnd2R3l4SFFpZytRSEc4RGQzZTl2bDNDZnda?=
 =?utf-8?B?Q2prNXpiWEZLaDlRUWFxbWNTSDlEcE9IZnE2bGc0QU9saHNRMTgvZFExSXVk?=
 =?utf-8?B?QlgrUm95b0E0elJrRTRVczdjTzhCQXp2OENCSWM5VHhvWkloZG9DTVJ4VjZm?=
 =?utf-8?B?Q0JrOXd5UGhyYVg1cW5RRmtjaExicEt6Tm11NTFKSUowMGprR0xaUWYzVFQy?=
 =?utf-8?B?MCtXbXFwRFVEcDkrZWVEclhNMmRZUkxaek5ZdUZpbURpYTlnUXAxRERJOFF0?=
 =?utf-8?B?QWhvTm1QTWtXV1dkaUJaS0FudUsyU2ZRY0pteFptVll0bUoyc2ZwRjcrUFd4?=
 =?utf-8?B?eXRVdkpxUTFGTWIrdDBBaTYzek5yOFRoU1pUV2FHOUh0Z3lHZnFkQ25NL2JL?=
 =?utf-8?B?VTNsWWxteE4raHZUci9USmNsTW1uQVJWZWlXQ0daRHgwUEtPVGt6ZWRVSGc4?=
 =?utf-8?B?eWIyS1B5ODBCOC9mTXJKM2NvYk9SdzJobzJiaGQra2gvS1FPWTNYMTQrSW5Q?=
 =?utf-8?B?d0pVTUlVeXUxbDl0MU9pRjc2Mi9XVm5ZajNVVnhBRXdpZldkQUhUaWZCbkFG?=
 =?utf-8?B?YXlTT1NCRkV0L2pOTmhGeEpBaU1SRy9ycHNFVE9zWGdBWjR5Q3o3ejF0WE5P?=
 =?utf-8?B?ZDR1RUZ4cEF1NFdjY1dzTkpNSXV3Tm04aGl6MUlGSnNLRmhKVkU0bS8xZXFU?=
 =?utf-8?B?djZnWXVxazBweVpaVTlwYk9Dbi81RllJOUR0elg5Nnp4dE1jVWNubkhkZFBw?=
 =?utf-8?B?SEd1d3hTTjB3WEREdXAxQmRJVkEzVEJuMUhJWkJjb3IybnRTbWR6d2s2TU5h?=
 =?utf-8?B?dkw0MDY1ek4vMitndEI0cHFiNUdlREswdVdNNkNSTURpUzNIdWNEdDBxOXdG?=
 =?utf-8?B?Zm5WSkt1Z2N0M1lYOWZUMUpuVGZiMnkvMXczNHhEc0J0di8vRTJyUUwwbVlR?=
 =?utf-8?B?UlU5Z2NvOXNGenloMkVxbDIycTl5UFkxMk1uTlRwRENIMk5IK1krOEprZWpH?=
 =?utf-8?B?eFdWbUtvY1h2b1JNcjFQSlZsRVZORTRlc0FYWm1tVGxaSVUyQ0lRSE1YeFdM?=
 =?utf-8?B?V1hJdTJBRnh4a2tWNjJ0R0x0YmF2b09lcDZzUG1BSHVIMVBhd3hNOXdleTIy?=
 =?utf-8?B?SDZzQ0JHcTJ5Y2Mxa1h0RjlXQ3cyeXIybmFjZjNrRTNGZEw2Mm1DZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB7135.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b708ef3-5a27-487c-f046-08da5420a515
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 07:27:21.1086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCFG6ol5iz764Yd3kTHVDT8pSvAnOJnM2ywVa8byI1t2CiEj5jjBhJSMdC4HApxJS1JsIdMuDOzWKRRlaWyQuZQ6Ohgb2y9s6T6IkmhlQ4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5204
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyY2VsL01pYW8sDQoNCldlIGFyZSB3b3JraW5nIG9uIG5ldyBkcml2ZXIsIGJ5IDcvMjkg
d2Ugd2lsbCBzdWJtaXQgaW5pdGlhbCBwYXRjaCBmb3IgcmV2aWV3Lg0KDQpSZWdhcmRzDQpCYWxh
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWlhby1jaGVuIENob3UgPG1jY2hv
dUBjaHJvbWl1bS5vcmc+IA0KU2VudDogVHVlc2RheSwgTWF5IDEwLCAyMDIyIDg6NDcgQU0NClRv
OiBCYWxha3Jpc2huYSBHb2RhdmFydGhpIChRVUlDKSA8cXVpY19iZ29kYXZhckBxdWljaW5jLmNv
bT4NCkNjOiBNYXJjZWwgSG9sdG1hbm4gPG1hcmNlbEBob2x0bWFubi5vcmc+OyBBbmR5IEdyb3Nz
IDxhZ3Jvc3NAa2VybmVsLm9yZz47IHJvYmgrZHRAa2VybmVsLm9yZzsgYmpvcm4uYW5kZXJzc29u
QGxpbmFyby5vcmc7IGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSm9oYW4gSGVkYmVy
ZyA8am9oYW4uaGVkYmVyZ0BnbWFpbC5jb20+OyBta2FAY2hyb21pdW0ub3JnOyBsaW51eC1ibHVl
dG9vdGhAdmdlci5rZXJuZWwub3JnOyBIZW1hbnQgR3VwdGEgKFFVSUMpIDxxdWljX2hlbWFudGdA
cXVpY2luYy5jb20+OyBTYWkgVGVqYSBBbHV2YWxhIChUZW1wKSAoUVVJQykgPHF1aWNfc2FsdXZh
bGFAcXVpY2luYy5jb20+OyBxdWljX3JqbGlhbyA8cXVpY19yamxpYW9AcXVpY2luYy5jb20+OyBB
bGFpbiBNaWNoYXVkIDxhbGFpbm1pY2hhdWRAZ29vZ2xlLmNvbT47IEFiaGlzaGVrIFBhbmRpdC1T
dWJlZGkgPGFiaGlzaGVrcGFuZGl0QGNocm9taXVtLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0gg
djEgMy8zXSBCbHVldG9vdGg6IGhjaV9xY2E6IFdBUiB0byBoYW5kbGUgV0NONjc1MCBIVyBpc3N1
ZQ0KDQpIaSBCYWxhLA0KDQpXaGVuIGlzIHRoZSBlc3RpbWF0ZWQgc3RhcnQgZGF0ZSBhbmQgdGlt
ZWxpbmUgb2YgdGhlIGRyaXZlciBkZXZlbG9wbWVudD8NCg0KVGhhbmtzLA0KTWlhbw0KDQpPbiBG
cmksIEFwciAyOSwgMjAyMiBhdCA4OjA5IFBNIEJhbGFrcmlzaG5hIEdvZGF2YXJ0aGkgKFFVSUMp
IDxxdWljX2Jnb2RhdmFyQHF1aWNpbmMuY29tPiB3cm90ZToNCj4NCj4gSGkgTWFyY2VsLA0KPg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjZWwgSG9sdG1hbm4gPG1h
cmNlbEBob2x0bWFubi5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMjksIDIwMjIgODoyNCBQ
TQ0KPiBUbzogQmFsYWtyaXNobmEgR29kYXZhcnRoaSAoUVVJQykgPHF1aWNfYmdvZGF2YXJAcXVp
Y2luYy5jb20+DQo+IENjOiBBbmR5IEdyb3NzIDxhZ3Jvc3NAa2VybmVsLm9yZz47IHJvYmgrZHRA
a2VybmVsLm9yZzsgDQo+IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBsaW51eC1hcm0tbXNt
QHZnZXIua2VybmVsLm9yZzsgDQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKb2hhbiANCj4gSGVkYmVyZyA8am9oYW4uaGVkYmVyZ0Bn
bWFpbC5jb20+OyBta2FAY2hyb21pdW0ub3JnOyANCj4gbGludXgtYmx1ZXRvb3RoQHZnZXIua2Vy
bmVsLm9yZzsgSGVtYW50IEd1cHRhIChRVUlDKSANCj4gPHF1aWNfaGVtYW50Z0BxdWljaW5jLmNv
bT47IFNhaSBUZWphIEFsdXZhbGEgKFRlbXApIChRVUlDKSANCj4gPHF1aWNfc2FsdXZhbGFAcXVp
Y2luYy5jb20+OyBxdWljX3JqbGlhbyA8cXVpY19yamxpYW9AcXVpY2luYy5jb20+OyANCj4gbWNj
aG91QGNocm9taXVtLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDMvM10gQmx1ZXRvb3Ro
OiBoY2lfcWNhOiBXQVIgdG8gaGFuZGxlIFdDTjY3NTAgDQo+IEhXIGlzc3VlDQo+DQo+IEhpIEJh
bGFrcmlzaG5hLA0KPg0KPiA+IFRoZSBwYXRjaCBpcyB3b3JrYXJvdW5kIGZvciBoYXJkd2FyZSBp
c3N1ZSBvbiBXQ042NzUwLg0KPiA+IE9uIFdDTjY3NTAgc29tZXRpbWVzIG9ic2VydmVkIEFPTiBw
b3dlciBzb3VyY2UgdGFrZXMgMTAwbXMgdGltZSB0byANCj4gPiBmdWxseSBkaXNjaGFyZ2Ugdm9s
dGFnZSBkdXJpbmcgT0ZGLiBBcyBXQ042NzUwIGlzIGNvbWJvIGNoaXAgZm9yIA0KPiA+IFdMQU4g
YW5kIEJULiBJZiBhbnkgb2YgdGhlIHRlY2ggYXJlYSBPTiBpcyB0cmlnZ2VyZWQgZHVyaW5nIA0K
PiA+IGRpc2NoYXJnZSBwaGFzZSwgaXQgZmFpbHMgdG8gdHVybiBPTi4NCj4gPiBUbyBvdmVyY29t
ZSB0aGlzIGhhcmR3YXJlIGlzc3VlLCBEdXJpbmcgQlQgT04sIGRyaXZlciBjaGVjayBmb3IgDQo+
ID4gV0xBTl9FTiBwaW4gc3RhdHVzLiBJZiBpdCBoaWdoLCBpdCB3aWxsIHB1bGwgQlRfRU4gdG8g
aGlnaCANCj4gPiBpbW1lZGlhdGVseSBlbHNlIGl0IHdpbGwgd2FpdCBmb3IgMTAwbXMgYXNzdW1p
bmcgV0xBTiB3YXMganVzdCANCj4gPiBwb3dlcmVkIE9GRiBhbmQgdGhlbiBCVF9FTiB3aWxsIGJl
IHB1bGxlZCB0byBoaWdoLg0KPiA+DQo+ID4gRml4ZXM6IGQ4Zjk3ZGExYjkyZDIgKCJCbHVldG9v
dGg6IGhjaV9xY2E6IEFkZCBzdXBwb3J0IGZvciBRVEkgDQo+ID4gQmx1ZXRvb3RoIGNoaXAgd2Nu
Njc1MCIpDQo+ID4gUmV2aWV3ZWQtYnk6IE1pYW8tY2hlbiBDaG91IDxtY2Nob3VAY2hyb21pdW0u
b3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNhaSBUZWphIEFsdXZhbGEgPHF1aWNfc2FsdXZhbGFA
cXVpY2luYy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmFsYWtyaXNobmEgR29kYXZhcnRoaSA8
cXVpY19iZ29kYXZhckBxdWljaW5jLmNvbT4NCj4gPiAtLS0NCj4gPiBkcml2ZXJzL2JsdWV0b290
aC9oY2lfcWNhLmMgfCAzMCArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4gPiAxIGZp
bGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9oY2lfcWNhLmMgDQo+ID4gYi9kcml2ZXJzL2Js
dWV0b290aC9oY2lfcWNhLmMgaW5kZXggZWFiMzRlMi4uYzM4NjJkMSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2JsdWV0b290aC9oY2lfcWNhLmMNCj4gPiArKysgYi9kcml2ZXJzL2JsdWV0b290
aC9oY2lfcWNhLmMNCj4gPiBAQCAtMjE5LDYgKzIxOSw3IEBAIHN0cnVjdCBxY2Ffc2VyZGV2IHsN
Cj4gPiAgICAgICBzdHJ1Y3QgaGNpX3VhcnQgIHNlcmRldl9odTsNCj4gPiAgICAgICBzdHJ1Y3Qg
Z3Bpb19kZXNjICpidF9lbjsNCj4gPiAgICAgICBzdHJ1Y3QgZ3Bpb19kZXNjICpzd19jdHJsOw0K
PiA+ICsgICAgIHN0cnVjdCBncGlvX2Rlc2MgKndsYW5fZW47DQo+ID4gICAgICAgc3RydWN0IGNs
ayAgICAgICAqc3VzY2xrOw0KPiA+ICAgICAgIGVudW0gcWNhX2J0c29jX3R5cGUgYnRzb2NfdHlw
ZTsNCj4gPiAgICAgICBzdHJ1Y3QgcWNhX3Bvd2VyICpidF9wb3dlcjsNCj4NCj4gSSBhbSByZWFs
bHkgYWdhaW5zdCB0aGVzZSBpbnRlcm1peGluZyBvZiBCbHVldG9vdGggYW5kIFdpRmkgZGV0YWls
cy4gVGhlcmUgaXMgd29yayBvbmdvaW5nIHRvIGRvIHNvbWUgc2VxdWVuY2UgcG93ZXIgcHJvY2Vk
dXJlLiBNYXliZSB0aGF0IGlzIHNvbWV0aGluZyB5b3Ugc2hvdWxkIGxvb2sgaW50by4gVGhpcyBp
cyBhIG1lc3MuDQo+DQo+IEFuZCBhZ2Fpbiwgd2UgYXJlIHN0aWxsIGhhY2tpbmcgYXJvdW5kIGhj
aV9xY2EuYyBpbnN0ZWFkIG9mIHdyaXRpbmcgYSBjbGVhbiBzZXJkZXYgb25seSBkcml2ZXIgZm9y
IHRoaXMgaGFyZHdhcmUuIEkgaGF2ZSB0aGUgZmVlbGluZyB0aGF0IG5vYm9keSBsaXN0ZW5zIHRv
IHJldmlldyBjb21tZW50cyB0aGVzZSBkYXlzLiBJdCBpcyBqdXN0IGhhY2tpbmcgcGF0Y2hlcyB0
b2dldGhlciB0byBnZXQgaGFyZHdhcmUgZW5hYmxlZCBzb21laG93IGFuZCB0aGVuIGRpc2FwcGVh
ci4NCj4NCj4gW0JhbGFdOiBXZSBhcmUgd29ya2luZyBvbiBzZXJkZXYgbGlrZSBkcml2ZXIgZm9y
IG91ciBRQ0EgcGxhdGZvcm0uICBXZSBhcmUgaW4gaW5pdGlhbCBzdGFnZXMgb2YgZGlzY3Vzc2lv
biwgYW5kIHNvb24gd2Ugd2lsbCBzdGFydCB0aGUgZHJpdmVyIGRldmVsb3BtZW50IHdvcmsuDQo+
IEluIG1lYW4gdG8gc3RvcCBzdGFiaWxpdHkgb3IgZnVuY3Rpb25hbCBpc3N1ZXMgd2UgYXJlIHRy
eWluZyB0byBhZGQgdGhlc2UgSEFDS3MgaW4gUUNBIGRyaXZlci4NCj4NCj4gUmVnYXJkcw0KPg0K
PiBNYXJjZWwNCj4NCg==
