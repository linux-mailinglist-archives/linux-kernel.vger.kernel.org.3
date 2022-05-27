Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511BB53632C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 15:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352137AbiE0NFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 09:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiE0NFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 09:05:43 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0025DA38;
        Fri, 27 May 2022 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1653656741; x=1654261541;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XEjwYG4jsO+siAlt98TUtkwB8a36s9CKHEkfIUQd/GA=;
  b=XyzIQldmH71zoXyZDNyQu9asjItOrATf8EeSIsmrdNiIry8Hg6sU/y3C
   oVKBszWNZgyyPIUXN7/sZxTEmE+C1djIQZi2dhaFSkKARHP5YBXMiRpXX
   5z5cWwwSIgw0FI0Uf+16FHh0TZKbFT69pLWmIIPFLRqliQnxY9MppPKu9
   Y=;
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 13:05:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RegVcGzijT5CKA2Sm1A3dT1mernS6tkk7kzNGV3dzyU8AYaiEg5WigHttWC9CnIp+drUaorpNpJIEWfbi04ohsLAqnGKTEP3sXblCBzAoTukbfuJf+7zLvzQNpLwt/sZJ+xwX+pmR/dZob3UUrDrYc3rNTD/jj+L6L3hmWjijqi3PnTsxotknGb7n9cUj/oKbgszcZlTmiIW0+McalpHZTKGLDQ3T+DUl+OhnN7/MdqszT7QHSEczxy0uadz5y1C8ve4C6xNyIhGQSnej2w/uH1Qh6kAs22Y8gJYJ2HXJ82l7gp4yoP7Q+4SoHr670JGCWtrH5z8Gr68bwRFBdmyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEjwYG4jsO+siAlt98TUtkwB8a36s9CKHEkfIUQd/GA=;
 b=lcXwVYM6gxzp09cDbkMelxmbMUB8idD/4BJFfz4ngFU4NpR3YfhlqQgWjk7VOQRa0/DEgCCSqBRhsmY2Jpgex1xOiErQVRRMqdW60savlq3AnbtH3pcQVj3nzPedjhB9ytunokCnd9U3GPvMP8sIhS4+vHhYm19+0n9sOSAgAPOqq0VKeVAi6eSrNxtQp4nM1NyBScmVzVP+LEvBoMnGnCYoTxlVMTIrCYDLs8nsz+xeHyGrAiE5Tsio7i7eqAAQLXeOHESsR6JowaKcWA2E6Nw8uFyGtoUnMrzIuGhKUQhEsSX0oZ+/6E36OhhiouJrRhq9hgFOQ2tbXIkYDFdlUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL0PR02MB4564.namprd02.prod.outlook.com (2603:10b6:208:4d::13)
 by DM6PR02MB7018.namprd02.prod.outlook.com (2603:10b6:5:259::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 13:05:38 +0000
Received: from BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::508d:2d15:ef0f:4f60]) by BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::508d:2d15:ef0f:4f60%7]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 13:05:38 +0000
From:   "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
To:     Doug Anderson <dianders@chromium.org>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Satya Priya Kakitapalli (Temp) (QUIC)" <quic_c_skakit@quicinc.com>
Subject: RE: [V2] tty: serial: qcom-geni-serial: Remove uart frequency table.
 Instead, find suitable frequency with call to clk_round_rate.
Thread-Topic: [V2] tty: serial: qcom-geni-serial: Remove uart frequency table.
 Instead, find suitable frequency with call to clk_round_rate.
Thread-Index: AQHYaREoIOR30NQ8REizIRGY5mvudq0xdBCAgAFNHIA=
Date:   Fri, 27 May 2022 13:05:38 +0000
Message-ID: <BL0PR02MB456404910AB2D32D0A6A9CCAFAD89@BL0PR02MB4564.namprd02.prod.outlook.com>
References: <1652697510-30543-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=WZQLpYAsdU4yTCGZCGp5+t+rJiadbSeppBaX0b6ZuUxg@mail.gmail.com>
In-Reply-To: <CAD=FV=WZQLpYAsdU4yTCGZCGp5+t+rJiadbSeppBaX0b6ZuUxg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2966782-b0df-4a09-b96e-08da3fe19868
x-ms-traffictypediagnostic: DM6PR02MB7018:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB7018A28DB0B8555C2D43347886D89@DM6PR02MB7018.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /o8gzI6Xos7NX77LXCzeatVtvEYNM+pkAfvL68Nsm4eVkkXQc3pby9v20IiothefxY1Ojff45nFbcrkiWeimhmUXUXOWzgaQCs0c52aTYcya3Rp9FcuErVdgGO4/b+BglLvKY7Gjsf5inG4IMZY1O88hHUq837F0KH6cIXnZSnvaV5YdzhQ0qPmUTx82/wR5EUwe/sEJrOFwPBN6OtTgf2PEo+78XVNk0s65Qj2eFytvP4sJLOII0POCLcC3DdLb8+4ghGsQk4zPCRmBZYRjNPjDGPDjDOP12VBf4Z9rRQUY67M2s28XpaaL082cFtmxABRhSH4/ndogs5m9RiD7mF9RrW+34BBcgEgu/ZtvT9Gp64rh6+YHjcesu47G3Vi4RXUrWjEZ5REHtdHSP7xNVLYR9VTrBRAv9tMyk0qc0RpEELD8oWrGN02y7D85HwgK1hwCWLK1ZY7nncmBgkrslVc/SS33/3oq8rNMT2Pq2UbQbE7Xs2slHgr17m0YcKb1XMGz+lE9Ie4p1iLrYLmZokdouS8zrjkq3339RGHu56wT2uhHIrRj5Ag3CCDD1BvludbX3DFC8gjzOCIl/Wq51UISYj1af7M30u2unC+ZPCwyyzj9xmKi4QbbEpTeypAtVVHayOFKGYarN2LRkEtuQ72+w6q+gjVL6bVybIVX8UoCCsI/Y2FYhXK71mUB6khXAbFOS5fX29QarDP8Izs1yA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8676002)(54906003)(316002)(110136005)(33656002)(508600001)(71200400001)(4326008)(66556008)(66446008)(64756008)(66946007)(66476007)(76116006)(38100700002)(52536014)(8936002)(26005)(9686003)(6506007)(7696005)(53546011)(38070700005)(5660300002)(122000001)(83380400001)(86362001)(186003)(107886003)(2906002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rmh1NjBKTUJTVnFieS9MYUFqSS9HVlhUN1FaenRTWXJzb1h6R3dHZW5xczdC?=
 =?utf-8?B?dDFPMVRRWGVadm5oSFVXdWF3REwvSWN4ekdtcUJSR2UyMUhDcENkTkd0VWto?=
 =?utf-8?B?Uzh5bFI2QnAwRE91NDM1UzlmSm9ydGovL3lqb1ZNQzdWK0xaRXpDQ2hSaklU?=
 =?utf-8?B?VkhQZ25IekpUUUxUdUtENDhMc2QyNjEvZU5VQmVBemFHV2FZeFArTWtQZC9p?=
 =?utf-8?B?N3JXVW9GNGE1Y3pnK1prNTNLa0o1K0tFOTZKV2l0WlcxRlpjSVV5U1lyUmli?=
 =?utf-8?B?KzVjMDdnMXFwKy9HOHBSeGhwelArWmRpTC9MN0VKTWpkYzFZRGZZUkJwb05w?=
 =?utf-8?B?UkcrV25HWCtkL1FwR1FFN1F2aUxibXBsVC92MnBUMGFtSUszWC8xR3djU1cv?=
 =?utf-8?B?dStkTSt4cFlWbnlTWjNBdWwyZjNnY1Nmb1I0VUk2bEJndnpoRExOS2wveVM2?=
 =?utf-8?B?VG9iUHBBMTFlQkYxcUhCN0tydjNPMHhTSXdidkVvbVhxZ2xiek81YmYxMWhl?=
 =?utf-8?B?OVlzTFRJYXpkcUR3dk5sTUR1S1N6aFR2VnIrYllTWHloTElmbGJ1cmhGMDBI?=
 =?utf-8?B?RnJvdW1VRTl1dUpoMWx6a1E4bllISlE0VkF2ckV5Vjc0bzZ3YXF6Y2Yvbita?=
 =?utf-8?B?VHJ4SFdnb3JCK2pOSHQwejg4L0prTFlFZVhGaWRrNHdwTHZNM0NJMklTREN6?=
 =?utf-8?B?WjNnTWJaV0tLU2t6R0RLTEJGbkpReTgveDJvWEFnd3ZEOGVSUGpJVWR0OEFn?=
 =?utf-8?B?eDlJWGpIZFpyV2dlMzBYanZnNmhaYzlqVnltK3lOTDVzS3c1OVVzMlU1OGFt?=
 =?utf-8?B?RDYzRFZWYk9GN1RLakhZM0NMditkRFhYdEdSWE9kMkNYZG1FQytleVQ1M25v?=
 =?utf-8?B?WEI5ZUFpbkRWZERKSlFSTnVORHdITFVDeFBwWVhTS2tKS25HdTY2NzJXcEtH?=
 =?utf-8?B?YndwVXAya2xISEN0QkttSnFEcUduME9qWXpNZkl5VE1iT1JsV1M3NCtEN1Rs?=
 =?utf-8?B?eU0xZk5sbFRtRkNyNW5WNm9vcTZKbmdwZ0l5cjgvWG0rditidUg3MWZpaWFi?=
 =?utf-8?B?Y3JJYkNuNEl3MVIwWFJ2QU9Wc1FXV1NUcXFtN2JVWFNOQ3dFVWoreFI1ZnVV?=
 =?utf-8?B?aVlHcCs3c0hWcHNKZThPbzlDS2w1a21uZUtrdFlJMUYyZGNabkNjaW9UQm1K?=
 =?utf-8?B?MW9iTGh3d3dOV2NzR2tBSXhESGtFdGR4RnJkeHlZaEFGYTVLd0FDQkdCWlM0?=
 =?utf-8?B?MHphT3cyUXNVTE10Q3pOc3BBaFNIRWlQZitYdmgzOFNabnQ2ZWNObVpqZ1Vp?=
 =?utf-8?B?emxtcDI4T01TVFpoQUtmR0NEMWprQ1ZJVmNEOHNBeDdBSTEzMTc1djlrVlJq?=
 =?utf-8?B?YmpDd0pPdnExNVJ0dmZnWS9MSFhzUFMxcUpHcTJ2T3RKZjhaVXk1OFEvSVh3?=
 =?utf-8?B?b29iQTgzdGg4eTNPM2FiTGRqTEprbml4RGxuZDBpU3UzKzlYcmdIV3llSU9h?=
 =?utf-8?B?aXk1Zi9KTXU4MWlCSjN5dkNUdmlibzluTk8vU1pEdUNJN1lZNVhFTDVzemMv?=
 =?utf-8?B?UFF6M3hFSHpjL1JSOU1Kci8wNnBvU2F2L1F4WnNPcHVVWGlGN3Z0Z29mZ0o1?=
 =?utf-8?B?Z0E3bzZrZGluaHR5NDRUZ0twWUFtSUFQUW5BclcyNWY1SjkrNjYwYTJ5VU5L?=
 =?utf-8?B?bDBHbUp2U2ZQdDJveDlkTjNNN1BwTTh2bGRmd2lrWjNWQ2pFTFIwUjlLK0R3?=
 =?utf-8?B?eGFvSUhmZG93Z0NBdGl2K1B5OUpNNkJ1Y2xWbEFNeU1scUY2UDdGNzRWeEVS?=
 =?utf-8?B?Ylc5L0dTMFFzaVRkU3FRM1JoaElnaVRLdmVYdCtkZ3NBV0o4bnM1WVArekZp?=
 =?utf-8?B?SEs3ejgweW9nSlJPNzdnUWN5cmdlS0RjRUIrMWltVEw5ZE80Y2NoekZRazJ0?=
 =?utf-8?B?TTJqdGRycittaGZEc01JaU92eUpJTnd1Qmk0c3MxQnRFTElMQ3pUUERQUzBQ?=
 =?utf-8?B?Y3B2ZHZWVlBoYldPQTZiL0hFTnA1VkhLaUdOT25obmFJUFRLM3NIa0ZDMTJn?=
 =?utf-8?B?c2NNUEFBTnY5dUl4ZVNYQWR5RlpIMFdCdStKNUYyeXZuMkJWL2NMb2ZuQ2k4?=
 =?utf-8?B?QVQxNGhPL0lHVEZidGtlZlNDbi9tamkvTkpYZFpaT3BqWEphZG4wajdvY01r?=
 =?utf-8?B?TktZQzQwUmk1UUM1aitLdjBtT3hNc2gwUzZTRUp6eVphNXJhMTI3VzMwYXF3?=
 =?utf-8?B?dmlvUGVZSDdnell1dTNPZ0NJbzRtUFVHa1M5SllMZ3FJYTBXRVRid1kzVVBl?=
 =?utf-8?B?SzYvbFg1NTdmYjFmYXZiQnpYM3JFcUZXZjJUV2dibkVCUEZqaWxXZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2966782-b0df-4a09-b96e-08da3fe19868
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 13:05:38.3225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZX2obm/99A89INyfXZcKufCYgpdzFAU85qlLHsEeWtTjHDSPrJkebnERzsmujkjg9k+AfFTs6/EDZKN0s9zVvraaqvhEmdl2Ma5kA6hggA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7018
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGEgbG90IGZvciB2ZXJ5IHVzZWZ1bCBmZWVkYmFjay4NCkkgc2VlIHRoYXQgdGhlIHBh
dGNoIGhhcyBsYW5kZWQsIHdpbGwgdXBsb2FkIGFub3RoZXIgaW5jb3Jwb3JhdGluZyB0aGVzZSBz
dWdnZXN0aW9ucy4NCi1WaWpheS8NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogRG91ZyBBbmRlcnNvbiA8ZGlhbmRlcnNAY2hyb21pdW0ub3JnPiANClNlbnQ6IFRodXJzZGF5
LCBNYXkgMjYsIDIwMjIgMTA6MzggUE0NClRvOiBWaWpheWEgS3Jpc2huYSBOaXZhcnRoaSAoVGVt
cCkgKFFVSUMpIDxxdWljX3ZuaXZhcnRoQHF1aWNpbmMuY29tPg0KQ2M6IEFuZHkgR3Jvc3MgPGFn
cm9zc0BrZXJuZWwub3JnPjsgYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7IEdyZWcgS3JvYWgt
SGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBKaXJpIFNsYWJ5IDxqaXJpc2xh
YnlAa2VybmVsLm9yZz47IGxpbnV4LWFybS1tc20gPGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwu
b3JnPjsgbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgTEtNTCA8bGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZz47IE11a2VzaCBTYXZhbGl5YSAoUVVJQykgPHF1aWNfbXNhdmFsaXlAcXVp
Y2luYy5jb20+OyBNYXR0aGlhcyBLYWVobGNrZSA8bWthQGNocm9taXVtLm9yZz47IFN0ZXBoZW4g
Qm95ZCA8c3dib3lkQGNocm9taXVtLm9yZz47IFNhdHlhIFByaXlhIEtha2l0YXBhbGxpIChUZW1w
KSAoUVVJQykgPHF1aWNfY19za2FraXRAcXVpY2luYy5jb20+DQpTdWJqZWN0OiBSZTogW1YyXSB0
dHk6IHNlcmlhbDogcWNvbS1nZW5pLXNlcmlhbDogUmVtb3ZlIHVhcnQgZnJlcXVlbmN5IHRhYmxl
LiBJbnN0ZWFkLCBmaW5kIHN1aXRhYmxlIGZyZXF1ZW5jeSB3aXRoIGNhbGwgdG8gY2xrX3JvdW5k
X3JhdGUuDQoNCldBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2Yg
UXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5k
IGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KDQpIaSwNCg0KT24gTW9uLCBNYXkgMTYsIDIwMjIgYXQg
MzozOCBBTSBWaWpheWEgS3Jpc2huYSBOaXZhcnRoaSA8cXVpY192bml2YXJ0aEBxdWljaW5jLmNv
bT4gd3JvdGU6DQo+DQo+IFJlcGxhY2UgdGhlIFVBUlQgZnJlcXVlbmN5IHRhYmxlICdyb290X2Zy
ZXFbXScgd2l0aCBsb2dpYyBhcm91bmQNCj4gY2xrX3JvdW5kX3JhdGUoKSBzbyB0aGF0IFNvQyBk
ZXRhaWxzIGxpa2UgdGhlIGF2YWlsYWJsZSBjbGsgDQo+IGZyZXF1ZW5jaWVzIGNhbiBjaGFuZ2Ug
YW5kIHRoaXMgZHJpdmVyIHN0aWxsIHdvcmtzLiBUaGlzIHJlZHVjZXMgdGlnaHQgDQo+IGNvdXBs
aW5nIGJldHdlZW4gdGhpcyBVQVJUIGRyaXZlciBhbmQgdGhlIFNvQyBjbGsgZHJpdmVyIGJlY2F1
c2Ugd2Ugbm8gDQo+IGxvbmdlciBoYXZlIHRvIHVwZGF0ZSB0aGUgJ3Jvb3RfZnJlcVtdJyBhcnJh
eSBmb3IgbmV3IFNvQ3MuIEluc3RlYWQgDQo+IHRoZSBkcml2ZXIgZGV0ZXJtaW5lcyB0aGUgYXZh
aWxhYmxlIGZyZXF1ZW5jaWVzIGF0IHJ1bnRpbWUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFZpamF5
YSBLcmlzaG5hIE5pdmFydGhpIDxxdWljX3ZuaXZhcnRoQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4g
djI6IGxvb3BzIHRocm91Z2ggY2xrIGRpdmlkZXJzIHRvIHplcm8taW4gcXVpY2tseQ0KPiB2MTog
aW50aWFsIHBhdGNoIGxvb3BlZCB0aHJvdWdoIGF2YWlsYWJsZSBjbGsgZnJlcXVlbmNpZXMNCj4g
LS0tDQo+ICBkcml2ZXJzL3R0eS9zZXJpYWwvcWNvbV9nZW5pX3NlcmlhbC5jIHwgNTYgDQo+ICsr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzYg
aW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3R0eS9zZXJpYWwvcWNvbV9nZW5pX3NlcmlhbC5jIA0KPiBiL2RyaXZlcnMvdHR5L3NlcmlhbC9x
Y29tX2dlbmlfc2VyaWFsLmMNCj4gaW5kZXggZjQ5NjEwMi4uNDczM2EyMyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy90dHkvc2VyaWFsL3Fjb21fZ2VuaV9zZXJpYWwuYw0KPiArKysgYi9kcml2ZXJz
L3R0eS9zZXJpYWwvcWNvbV9nZW5pX3NlcmlhbC5jDQo+IEBAIC0xNDksMTIgKzE0OSw2IEBAIHN0
YXRpYyB1bnNpZ25lZCBpbnQgDQo+IHFjb21fZ2VuaV9zZXJpYWxfdHhfZW1wdHkoc3RydWN0IHVh
cnRfcG9ydCAqcG9ydCk7ICBzdGF0aWMgdm9pZCANCj4gcWNvbV9nZW5pX3NlcmlhbF9zdG9wX3J4
KHN0cnVjdCB1YXJ0X3BvcnQgKnVwb3J0KTsgIHN0YXRpYyB2b2lkIA0KPiBxY29tX2dlbmlfc2Vy
aWFsX2hhbmRsZV9yeChzdHJ1Y3QgdWFydF9wb3J0ICp1cG9ydCwgYm9vbCBkcm9wKTsNCj4NCj4g
LXN0YXRpYyBjb25zdCB1bnNpZ25lZCBsb25nIHJvb3RfZnJlcVtdID0gezczNzI4MDAsIDE0NzQ1
NjAwLCAxOTIwMDAwMCwgMjk0OTEyMDAsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAzMjAwMDAwMCwgNDgwMDAwMDAsIDUxMjAwMDAwLCA2NDAwMDAwMCwNCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDgwMDAwMDAwLCA5NjAwMDAwMCwg
MTAwMDAwMDAwLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMTAy
NDAwMDAwLCAxMTIwMDAwMDAsIDEyMDAwMDAwMCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDEyODAwMDAwMH07DQo+IC0NCj4gICNkZWZpbmUgdG9fZGV2X3BvcnQo
cHRyLCBtZW1iZXIpIFwNCj4gICAgICAgICAgICAgICAgIGNvbnRhaW5lcl9vZihwdHIsIHN0cnVj
dCBxY29tX2dlbmlfc2VyaWFsX3BvcnQsIA0KPiBtZW1iZXIpDQo+DQo+IEBAIC05NDYsMjUgKzk0
MCw0MyBAQCBzdGF0aWMgaW50IHFjb21fZ2VuaV9zZXJpYWxfc3RhcnR1cChzdHJ1Y3QgdWFydF9w
b3J0ICp1cG9ydCkNCj4gICAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4NCj4gLXN0YXRpYyB1bnNp
Z25lZCBsb25nIGdldF9jbGtfY2ZnKHVuc2lnbmVkIGxvbmcgY2xrX2ZyZXEpIC17DQo+IC0gICAg
ICAgaW50IGk7DQo+IC0NCj4gLSAgICAgICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShyb290
X2ZyZXEpOyBpKyspIHsNCj4gLSAgICAgICAgICAgICAgIGlmICghKHJvb3RfZnJlcVtpXSAlIGNs
a19mcmVxKSkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJvb3RfZnJlcVtpXTsN
Cj4gLSAgICAgICB9DQo+IC0gICAgICAgcmV0dXJuIDA7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyB1
bnNpZ25lZCBsb25nIGdldF9jbGtfZGl2X3JhdGUodW5zaWduZWQgaW50IGJhdWQsDQo+ICtzdGF0
aWMgdW5zaWduZWQgbG9uZyBnZXRfY2xrX2Rpdl9yYXRlKHN0cnVjdCBjbGsgKmNsaywgdW5zaWdu
ZWQgaW50IA0KPiArYmF1ZCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50
IHNhbXBsaW5nX3JhdGUsIHVuc2lnbmVkIGludCANCj4gKmNsa19kaXYpICB7DQo+ICAgICAgICAg
dW5zaWduZWQgbG9uZyBzZXJfY2xrOw0KPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgZGVzaXJlZF9j
bGs7DQo+ICsgICAgICAgdW5zaWduZWQgbG9uZyBmcmVxLCBwcmV2Ow0KPiArICAgICAgIHVuc2ln
bmVkIGxvbmcgZGl2LCBtYXhkaXY7DQo+ICsgICAgICAgaW50NjRfdCBtdWx0Ow0KDQpXaHkgaXMg
Im11bHQiIHNpZ25lZD8gU2hvdWxkbid0IGl0IGJlIHR5cGUgInU2NCIgb3Igc29tZXRoaW5nPw0K
DQo=
