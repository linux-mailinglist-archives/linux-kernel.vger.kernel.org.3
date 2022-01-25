Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5626749BB68
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiAYSkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:40:51 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:39394 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiAYSki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1643136037; x=1643740837;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3CtnXFxKrJydrLd4ZvFNuzGMunhCQ+vYgFscXeM+sWs=;
  b=z0byuAPcbXmix8w99mdkljdCk3zUZX3388K/MhjNeto/+VPQiwQll5QR
   QWPEpQj8V8I7Jq0ZLR6l/JAAVT6AY/YSymqH0tXsxsm1EgSpx+uqJXRQ9
   VZdOwrOtTefRJjL/CYCi8WfVD4Y0hmFOyLnhdC0C5sUTlul8NDdXcmW72
   k=;
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 18:40:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+Mntt6/6ndHV1clRqNDICQV5cBJjukQQKZFmMneWRywzDMy2gcazVP3nOikIzYLyUSNOBQlqPl5LuUVSTnndnnu86AUBD8x/eGv8bhpjj2ltWUU16XrpfvoFQZQQejAvMzlwim1KyOoQx+ds8Vq3QubBPrBcB87e5fqZINTnl+95mV5cj0soeFEB+rlTzSMzAX/3aBbbk04hDMwfw8zfoDocYkDQEfdoCWw9g600JaSvtS1NQ7/xysV/luC86i0qNAKQAAkMeEwd1HZ/V5JnTXMRJRQu2DRSwiFNhu1wFyGrq340lpnUgXGjP4DnSdK486tYhgNFuH0LWCAMtOf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CtnXFxKrJydrLd4ZvFNuzGMunhCQ+vYgFscXeM+sWs=;
 b=ExsSsF8Ft69ZDiBNuOgl1FM0AGClo0ZmLYCbV0+0WtnY9f3GKKK0h7VMrJ+zghjL28HLnIt0nZRgLnatumlXd/K5C9iHRPEixCaRfp9XEC9snnptllG753IGH8ZOcBHSR+/tCUZu2lCSppcIngdc7lfsfJkgk0Ym83eJg+JgTGkCgKa7zCyuZi9mYZupgvr89LDS4KqA7tJKGNGBnQiaTpvPsIMmafVtQ90Gy+i67fOY2LfCk1nRj4IdmWDzcy/o67In9i4iQGgw8YsRccA0EhvhploptCTdSWMteQjhWJnK9ja6yM0Bqc02ry8mAOK8dXoVyU3Q5H/cdeoeAa/oyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by BL0PR02MB3633.namprd02.prod.outlook.com (2603:10b6:207:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 18:40:30 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%5]) with mapi id 15.20.4909.010; Tue, 25 Jan 2022
 18:40:30 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "Asutosh Das (QUIC)" <quic_asutoshd@quicinc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "sartgarg@codeaurora.org" <sartgarg@codeaurora.org>,
        "nitirawa@codeaurora.org" <nitirawa@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        Liangliang Lu <luliang@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
Subject: RE: [PATCH V3 3/4] mmc: core: Capture eMMC and SD card errors
Thread-Topic: [PATCH V3 3/4] mmc: core: Capture eMMC and SD card errors
Thread-Index: AQHYDiME1vjFJFfvLkaJl8D4nn9FZ6xtIyGAgAb2pNA=
Date:   Tue, 25 Jan 2022 18:40:30 +0000
Message-ID: <SJ0PR02MB84491999BFE61B2E8BFE0212CD5F9@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1642699582-14785-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1642699582-14785-4-git-send-email-quic_c_sbhanu@quicinc.com>
 <2989ff51-374e-3ab5-f8d4-19e0a1873a66@intel.com>
In-Reply-To: <2989ff51-374e-3ab5-f8d4-19e0a1873a66@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec01189b-8743-4129-c198-08d9e0322a07
x-ms-traffictypediagnostic: BL0PR02MB3633:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB36337504194525F6E9CA75F0B15F9@BL0PR02MB3633.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ATeRGZwj7ziEwcTN3l1TawHrSGpmTOqAVRxStUUjSC56Ds3o28ow9JcbNpjaX02v+tyRVmIIXsceCCOR/z36h9yFlQzLX+dp+qHXoHXIzVPDL7LbS0rkc/9jzqr6fUYWnsYG7oCn66YYtwGsgnYnzFWoiUhzd5FynX+LhdwphjOQJUyhMPO37NUGrUcyiYqgnZkgRsLLBMGQxMkVhJrGG6Z22JqRwhUEkKZQARxZqJ3zLialbQTPgWO+bylpZi6CmnWX7B0CYm/pplVBkbRSGKZeGVpY4DINakCZV08BbcAXbKPRaTsj8FZoeOY1/wy9uOaMLabH8Yd1u0weFvDZQZkdtp5pyBJd7MdnTbjdkQcqmw6zEnHxEE8NFTKf+nZ993clbkaa/xgN4nHUre+w3fCDmRlkx77rhfI94IhCGtH3b33Gbhh2wZgQDyH8dGLu2WBPg+G6mHD82lkZEb0oo4N8C9cjTEPPaXwLU8+0GJprA07RGyZ5D7erlX2N642GyjK+6z30zQ+4Yl221nESoYw81nP82bdK0c20691lGQdK+Llfu++iaWCe2ab7aDUr6XfU81oS8xZ0hD0Y2L0S1xEFBV5iZLbuQghVi1P9MjVlQIgfYaojn6utd0G4qOFD+7J78X/3UaaxloQeoSNOxKRwp+9DW++NaL6hDWxd4QSRSpZJvGOViY1BcXf30pAAKok6ZmBgq9I0XUZapqX+0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(7696005)(122000001)(9686003)(7416002)(4326008)(8676002)(52536014)(5660300002)(53546011)(38070700005)(55016003)(86362001)(2906002)(38100700002)(8936002)(110136005)(83380400001)(508600001)(54906003)(76116006)(66946007)(64756008)(26005)(66556008)(66476007)(66446008)(71200400001)(186003)(316002)(33656002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnFtNllwWit1MXdGL1pFMkQ3a0pFNjZYVExhMHl0MmlhN2Nldmg4bnp2bmVY?=
 =?utf-8?B?TkxreGtYMnJTN0VybVREUkdqYTByN25FNk5zT1I0MU1oUEdBNmY5NTlUcW5J?=
 =?utf-8?B?d2trZFRZOUI1QldPWGo4RGs4Y0o3ZXU5bnR3YjBNR3lHMi8yQ0xhS2tBblJz?=
 =?utf-8?B?SlJUTXZYN3B6b0Y5VTd0MFhCKy9pcnRCZWxnZEZHL2tOOTBFVVRKZUhEMDhx?=
 =?utf-8?B?VFUvRThwRDRBeEpBSHJlYmpFOG1hTmVFK2FDS3A5UGpwVWxjSUxzZy9sMXdz?=
 =?utf-8?B?ZmhMRDZablZGemFLL1pNbythRFRYTVVJQjloREhaNFJQOEpDSlB0VENjOUF5?=
 =?utf-8?B?NG9HSWJaNzFNOHltNlBkV3lVYU9SMGJqQVc4aXRMWWNKTUd4U1BYRldlbDNQ?=
 =?utf-8?B?dk5MVkJuNlRJQmJxOHlKZDErcFJ5SUpXWnhra0MxeXNrbmZ5RWl3OXR6UXRm?=
 =?utf-8?B?UlZhRytubTI1dzVEQzZEWldYMjN4ZnphRXF4V3BDcjNVTHQ1eWNLK3ZMaHdQ?=
 =?utf-8?B?aTJuTEtRdE5nYkp2N1I0dld2LzZLa3J2TDdEazFDMEVBVFBBeTBXOFI4aHd4?=
 =?utf-8?B?dGJ1ZEdrWGJ3VUVneklYa24yM0lSM21laElzVjF4cXVwSll5Qjh3QmhaVGk4?=
 =?utf-8?B?OFp0QmdLd3N6SUdoL2pueTYzU1Z4YkdzQlZndHBXVE5XVkIwYWwwNDZrVWt0?=
 =?utf-8?B?bWRScURDU25qM1dubFJJVGRRWWFyaDduQkprOXBUV204clRKOFBVM2ZZbjBO?=
 =?utf-8?B?eUVmallWRVRhRlJ3REdVd01TV3NwM3cydVFFc0ZmSDFReXRuOFg5dXZOTFlI?=
 =?utf-8?B?dGJSd2FUTWhEdklEVVI5eFZpdFVyZnRDbklieVpiM1JkVzBUMEplV0c1Slh5?=
 =?utf-8?B?NThmTzdvNG9IVVZWaktKWldUK0xEMjFNQUliMElaTndWdkFUTWgySXFicS80?=
 =?utf-8?B?S3U3Mnd3WDVUQjZQc3NCRXFwc2V0NnR2SHN6RG5sSWQzeG50ZDA2RDI3VkNS?=
 =?utf-8?B?TWJNbS9HSk9jTEhGQjN3aG1hQ3BKODRhWEhhTW94Vzg5UDJadStscUk0eFVz?=
 =?utf-8?B?aUtxaEFCUTlYelVXMGFsVWpkUFJILythSnlxVXM5MU5raEhROHlqYSt1aHps?=
 =?utf-8?B?dTVNRE1qMU8ydTRpK044a3hFR29QYnkxUTZUbHNvRXZLek9HMDlHZEVyRXp6?=
 =?utf-8?B?SHpvcTNaTmRhOEM5aHgwbGNtVm4yRWFhajRIcnFtMVpPUGFKV2tSM1ZLcVcz?=
 =?utf-8?B?Z3BxN3VqQjN0aUpPcWNwenVsMDVtNFRINDRrdGVYcjVLaHY0b3dKWlpvZ3JZ?=
 =?utf-8?B?YWxZQStZKzEyL0VUYTR0M0xyWVpZZXc5WTFRQ1FWY0hsZjcyZE5GeUxZUUFV?=
 =?utf-8?B?Q2NpMnpyZjhjN2FLTTZGV3BsT2RDT0FZQmFPUzhucUkwaGpGbHF6T3pCQmt6?=
 =?utf-8?B?eXFrRjk5QjFGZno2SkRsYnU5MkJzQXNSMkpwZ0xyaVZZNDNJMWRXdFV6emRT?=
 =?utf-8?B?WHoxWlhxSVhXSWFxZnFhTys5STI0cHF4Q3dscDZxMjJqZ0tBVnpiVzNnTXhE?=
 =?utf-8?B?S0hLaDdJUzhoRWVNLzJIcFFSNGtSNFl3ZnU1K3orY3VNdWZ4a0lFWTlhTFFr?=
 =?utf-8?B?WGZZdUFNYlN6VWlEbzFPamFqTS9oWU1nRFJNRGx4UlY4NDFvMVI4M1N1THRG?=
 =?utf-8?B?ck5MWjMycVJVRFJTQ051RGhEaHhKMVduK2tuNGo4UzdOQnVJaUxaR3V5amJw?=
 =?utf-8?B?ZHVmSG9DWXJ6QmtkR3FoM0pzVEZveFkzQmxVTWpVRzU4TVRCZGVZSEVCNmlL?=
 =?utf-8?B?T0IwQ2wxTkVhVjhVY3RKWkptbjdzb3o0SysycDlkaDBvSHluUCt0ZW52TWpH?=
 =?utf-8?B?b1hxc2tsbFNFS1ZMdHlhTlM2eGFubnBFbjcraUhuWFZYV29laWpXOFQ0Snhx?=
 =?utf-8?B?cTZNelpwMTIvS1h1STBiNkNxeG9xM3pzMEpRb0hYMWFoOXRyZW9nTG1aRjBU?=
 =?utf-8?B?QUF1bzUyajk3a1lDN2JHTHVtSDVQNkttZVo3NmM1Qk0yNWt2ZlY3SGwwbnVj?=
 =?utf-8?B?cmFVZEJYczZRa1YzS2ZWaEhGQjVJVnZuQzZmaUhHS1d1QTlaRGJCeUFFTThU?=
 =?utf-8?B?eHNpeEgyRUkxdUV1NGZPNHJ6dmljUFNKNGpYVWhoWUZSVUUvNWU3aXgwSzk4?=
 =?utf-8?B?M2h4Q1F6VWdjSFdEWEJ2ZWlES2EzVEp0dWVQb2l1VTQrNFlTdnNEeXBwOFdQ?=
 =?utf-8?B?eFNGeFVpajc3ZDh1bWFGeGIwK3NBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec01189b-8743-4129-c198-08d9e0322a07
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 18:40:30.5899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/6GMoZWSZa18m5JuE5KWN296y6QIEAnbKVM+4LDQyFvrOtqsU6WpMxhQxI9+g+9LiNJe8oH1Jh9aH6lyEF+FNRL30ARTR4Akeh4dgqGEUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3633
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KUGxlYXNlIGZpbmQgdGhlIGlubGluZSBj
b21tZW50cy4NCg0KVGhhbmtzLA0KU2FqaWRhDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4gDQpTZW50OiBG
cmlkYXksIEphbnVhcnkgMjEsIDIwMjIgMTo1MCBQTQ0KVG86IFNhamlkYSBCaGFudSAoVGVtcCkg
KFFVSUMpIDxxdWljX2Nfc2JoYW51QHF1aWNpbmMuY29tPjsgQXN1dG9zaCBEYXMgKFFVSUMpIDxx
dWljX2FzdXRvc2hkQHF1aWNpbmMuY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgYWdyb3Nz
QGtlcm5lbC5vcmc7IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBsaW51eC1tbWNAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KQ2M6IHN0dW1tYWxhQGNvZGVhdXJvcmEub3JnOyB2YmFkaWdhbkBjb2Rl
YXVyb3JhLm9yZzsgUmFtIFByYWthc2ggR3VwdGEgKFFVSUMpIDxxdWljX3JhbXByYWthQHF1aWNp
bmMuY29tPjsgUHJhZGVlcCBQcmFnYWxsYXBhdGkgKFFVSUMpIDxxdWljX3ByYWdhbGxhQHF1aWNp
bmMuY29tPjsgc2FydGdhcmdAY29kZWF1cm9yYS5vcmc7IG5pdGlyYXdhQGNvZGVhdXJvcmEub3Jn
OyBzYXlhbGlsQGNvZGVhdXJvcmEub3JnOyBMaWFuZ2xpYW5nIEx1IDxsdWxpYW5nQGNvZGVhdXJv
cmEub3JnPjsgQmFvIEQgLiBOZ3V5ZW4gPG5ndXllbmJAY29kZWF1cm9yYS5vcmc+DQpTdWJqZWN0
OiBSZTogW1BBVENIIFYzIDMvNF0gbW1jOiBjb3JlOiBDYXB0dXJlIGVNTUMgYW5kIFNEIGNhcmQg
ZXJyb3JzDQoNCk9uIDIwLzAxLzIwMjIgMTk6MjYsIFNoYWlrIFNhamlkYSBCaGFudSB3cm90ZToN
Cj4gQWRkIGNoYW5nZXMgdG8gY2FwdHVyZSBlTU1DIGFuZCBTRCBjYXJkIGVycm9ycy4NCj4gVGhp
cyBpcyB1c2VmdWwgZm9yIGRlYnVnIGFuZCB0ZXN0aW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
U2hhaWsgU2FqaWRhIEJoYW51IDxxdWljX2Nfc2JoYW51QHF1aWNpbmMuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBMaWFuZ2xpYW5nIEx1IDxsdWxpYW5nQGNvZGVhdXJvcmEub3JnPg0KPiBTaWduZWQt
b2ZmLWJ5OiBTYXlhbGkgTG9raGFuZGUgPHNheWFsaWxAY29kZWF1cm9yYS5vcmc+DQo+IFNpZ25l
ZC1vZmYtYnk6IEJhbyBELiBOZ3V5ZW4gPG5ndXllbmJAY29kZWF1cm9yYS5vcmc+DQo+IFNpZ25l
ZC1vZmYtYnk6IFJhbSBQcmFrYXNoIEd1cHRhIDxxdWljX3JhbXByYWthQHF1aWNpbmMuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvbW1jL2NvcmUvY29yZS5jICB8IDggKysrKysrKysgIGRyaXZlcnMv
bW1jL2NvcmUvcXVldWUuYyB8IDMgDQo+ICsrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMgYi9k
cml2ZXJzL21tYy9jb3JlL2NvcmUuYyBpbmRleCANCj4gMzY4ZjEwNC4uYzU4NmQ2OSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9tbWMvY29y
ZS9jb3JlLmMNCj4gQEAgLTIyNDIsNiArMjI0MiwxNCBAQCB2b2lkIG1tY19yZXNjYW4oc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgCQlpZiAoZnJlcXNbaV0gPD0gaG9zdC0+Zl9taW4pDQo+
ICAJCQlicmVhazsNCj4gIAl9DQo+ICsNCj4gKwkvKg0KPiArCSAqIElnbm9yZSB0aGUgY29tbWFu
ZCB0aW1lb3V0IGVycm9ycyBvYnNlcnZlZCBkdXJpbmcNCj4gKwkgKiB0aGUgY2FyZCBpbml0IGFz
IHRob3NlIGFyZSBleGNlcHRlZC4NCj4gKwkgKi8NCj4gKw0KDQpQbGVhc2UgcmVtb3ZlIGJsYW5r
IGxpbmUgaGVyZS4NCg0KPj4+PlN1cmUuDQoNCj4gKwlpZiAoaG9zdCAmJiBob3N0LT5lcnJfc3Rh
dHNfZW5hYmxlZCkNCg0KVGhlIGNvbmRpdGlvbiBpcyBub3QgbmVlZGVkLg0KDQo+Pj4+U3VyZSAu
DQoNCj4gKwkJaG9zdC0+ZXJyX3N0YXRzW01NQ19FUlJfQ01EX1RJTUVPVVRdID0gMDsNCg0KUGxl
YXNlIHB1dCB0aGlzIGFmdGVyIHN1Y2Nlc3NmdWwgY2FsbCB0byBtbWNfcmVzY2FuX3RyeV9mcmVx
DQoNCj4+Pj4+U3VyZS4NCg0KPiAgCW1tY19yZWxlYXNlX2hvc3QoaG9zdCk7DQo+ICANCj4gICBv
dXQ6DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL3F1ZXVlLmMgYi9kcml2ZXJzL21t
Yy9jb3JlL3F1ZXVlLmMgaW5kZXggDQo+IGM2OWIyZDkuLjdkYzlkZmIgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbW1jL2NvcmUvcXVldWUuYw0KPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL3F1ZXVl
LmMNCj4gQEAgLTEwMCw2ICsxMDAsOSBAQCBzdGF0aWMgZW51bSBibGtfZWhfdGltZXJfcmV0dXJu
IG1tY19jcWVfdGltZWRfb3V0KHN0cnVjdCByZXF1ZXN0ICpyZXEpDQo+ICAJZW51bSBtbWNfaXNz
dWVfdHlwZSBpc3N1ZV90eXBlID0gbW1jX2lzc3VlX3R5cGUobXEsIHJlcSk7DQo+ICAJYm9vbCBy
ZWNvdmVyeV9uZWVkZWQgPSBmYWxzZTsNCj4gIA0KPiArCWlmIChob3N0LT5lcnJfc3RhdHNfZW5h
YmxlZCkNCj4gKwkJbW1jX2RlYnVnZnNfZXJyX3N0YXRzX2luYyhob3N0LCBNTUNfRVJSX0NNRFFf
UkVRX1RJTUVPVVQpOw0KDQpEb2Vzbid0IHRoaXMgZ2V0IGNvdmVyZWQgYnkgdGhlIGRyaXZlcnMu
ICBJdCBzZWVtcyBsaWtlIHRoaXMgc2hvdWxkIG5vdCBiZSBuZWVkZWQuDQoNCj4+Pj4+Pk9rYXkN
Cg0KPiArDQo+ICAJc3dpdGNoIChpc3N1ZV90eXBlKSB7DQo+ICAJY2FzZSBNTUNfSVNTVUVfQVNZ
TkM6DQo+ICAJY2FzZSBNTUNfSVNTVUVfRENNRDoNCj4gDQoNCg==
