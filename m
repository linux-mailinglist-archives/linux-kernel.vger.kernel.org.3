Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C77F4DC240
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiCQJDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiCQJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:03:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C911D08CB;
        Thu, 17 Mar 2022 02:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpYJt4D872SkWrYugXetN6bz7FkAAlcp0f3Nq3ylynT0ptXPJ0z9Ouv1DgNF7yccTBDvAJsQjiEGMaFmuEqLxlo5pZlLu/PaLsZEkLxqUGA8nRL/t9Cs09G6j1sAdyrjosVNrlOUvh6m58FxF2KDs14faMWU8baR4XA3K/cVRz/zohwO6hqvaLVZn0K/fXeW3Tnb0KvHIBx4x8p0ynQYfQkUCzcnmZy8vp+XPtnMZwpV9+1/PeyoCaz/J1S1oNQs7xSbHyKzgjTTNUrUB8UMEX+MMk2b3pOX700qVy+RJIjzt1wHIUWfQyan4Vpixd0cJfpF9aTFAHPtsQ821WHMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFI78NywOZwwRqIclrudWHU4tkW0qM+K2GRQbFb7k5o=;
 b=FrrThX9SyEfWacU0cXaamWWEYCv73xVpegyk2zXb9iu/OPQXQKLv2bq3tjqEbqon0KxjtNv4EjeAxZZiRtluEYihI/YF5iuUXKvcVl2wkxh3wlLBDPl9V3qSz9KNxmq4PSrZNnIPEQA0jA6KAcoakXNC2S9f27/YnddcfaMGr/YNBeAWd+DzYtOA6+wa8H3Z3pYEcS4+bU5GO1gzCmyAI3+YqSycD+YPE1U8lBK4yCYWGc8sF43Cf5PepNjTod1rpb9EYQV1zQa7Im+W1ARC0HlogS66poH2Kd9osysMnBFUn7P5q1rl9Hc0coyGBfyKVvZ5SUQTX7Cq7tMjV2jGwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFI78NywOZwwRqIclrudWHU4tkW0qM+K2GRQbFb7k5o=;
 b=r0KstSP0j2eI0KIEhQ26I1jRkRGvWj8UKEUA+NdApXCitN8Xf33X3qc33VKcfv421xv5E6DmhCQS+Fb4R3xt2jEOdhwTHC5n5MX1vqtf1JEtmWySt919xH2tOOQuN69SfwVYdIVlBtyBZIeM09nJmxxW5mRpFa+X0At9KMeNl1P/y4ptQtOAAsfICdEgZl8T9+cQjYqrYXQcNan2lfr4Pn+dF2WfgPFz6HuT/gxRHNovqjE2lGOUse5jR5EecXDbzmUMAl7XcLZ82Uuw3nVoBFnSnRNM9fD6MlrTDjtAorFg5qYeNJKB3XxfaXBVwuD2FCNTOcltZpUpaFbYKGpd4w==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 DM6PR12MB3852.namprd12.prod.outlook.com (2603:10b6:5:14a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Thu, 17 Mar 2022 09:02:36 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::801f:6a57:dcf6:6229]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::801f:6a57:dcf6:6229%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 09:02:36 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Ashish Singhal <ashishsingha@nvidia.com>
CC:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] spi: tegra210-quad: Add wait polling support
Thread-Topic: [PATCH 2/3] spi: tegra210-quad: Add wait polling support
Thread-Index: AQHYOZ0zTorLfdRhBU606fY3d7aIxazDRiKAgAABqDA=
Date:   Thu, 17 Mar 2022 09:02:36 +0000
Message-ID: <DM4PR12MB57692EB17ABCA36E0515412EC3129@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20220317012006.15080-1-kyarlagadda@nvidia.com>
 <20220317012006.15080-3-kyarlagadda@nvidia.com>
 <391736bc-84c2-ec8b-9f04-614365953da3@nvidia.com>
In-Reply-To: <391736bc-84c2-ec8b-9f04-614365953da3@nvidia.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3eb8b18f-b222-4f3f-4f3b-08da07f4e1b3
x-ms-traffictypediagnostic: DM6PR12MB3852:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3852C38CAB049EFCBFD5685AC3129@DM6PR12MB3852.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xyW+61CMNwl383qWdiJpM7XDhzZ1IvWiKx2hm/KJWMF9Y2HTv/ht1Cu7gc5C+g1vgzGA5ZBjHGYplbNBEeCzx36j7v6f2YDojMyl8f4debz9MPhTqJllMYVsZl5K70BXPmPDzuYiapJ4nUbAAlCX5QqnpmpAB7FEv74lzCE/FiFyC9ngVGLKcVLU2KkOPSU+9gZQ2cZDrUQVvOWr3HcrhzqKj25jiXT/pNAF7iOLrWi5tATeRwk6yGcbSiiwGXjeJhbmHCYqP6kb9u1yE0tsKE+srS+Yx2DMVjQAFM6ekrVrK7CxTl4sZMlyzU7u90v4tl1TQvQ8+GxxcDbe5ugLHAD6fv49ZnnzwPDoEQycn7LR5AiqGwjBxv1JOGINYp0JFw8u5lDd2ljBipxc+ZqLBSH5o3wFENtR+0SotEPOhjIvkyH0ajm3mQINsj3NKTyA+Su8OBYAFfbmZ1Ir24dSyPlfVUS587P3MISpS0t7QjL0phUgTmMnkWzQJi8LoGZ3G/iXjNZlmvsEoNhfOUXa2pKCkm2pwbgjMGlbl5AnAdeJfD+lyO3oBckqYbe0StN5BJRef46sHhzVKwQ1XjHKR257HjcJIlGKACb5KCHnNkJtOfFfMe6KLGOr/laq5m+nLbqULkNj9GC5xcHhVH4puYgccXfpakJYZmF90ZU7FhCMY+9gxvWclcYGSJ6EWhVJc5urvXzCDmrU70p3+IoL2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(2906002)(508600001)(8676002)(66946007)(4326008)(55016003)(110136005)(71200400001)(64756008)(66446008)(66476007)(66556008)(86362001)(33656002)(6506007)(7696005)(55236004)(53546011)(9686003)(6636002)(316002)(186003)(83380400001)(122000001)(38100700002)(26005)(38070700005)(8936002)(54906003)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2VBU01Pd2N3Y2E3eWRDd1ZBbmJPQStqWVhkRWh6cG82eWd5dXNja3MzVlYv?=
 =?utf-8?B?UWRyUUdObk85emtGVS92Y0R6NWVPOTROeEFkN3VLQ2JFOEQxejFkNzAxKzJT?=
 =?utf-8?B?NnduTk50RXFEbGR6TzBPMjZsblM4RU5CRmVNODI5WVpLb0Y1Qmc1Z1RmT1hw?=
 =?utf-8?B?SU9HYWFGSExDVlF4bitjUDZtQ2E3YzRRb0l0Qk9mWXRDYzhnR2NvZnNQcXpv?=
 =?utf-8?B?TVd0STY4bWRGNmtjTGhHa0RiM3M4VnVkcXQ4TGxndGVwb3JRQ1NCZ1pWOFFQ?=
 =?utf-8?B?TGlOL2dERFJ1dStHa25OVUp6bGhYRktVV3hIS3VRZytHcTJYU29Pc0lCUHhr?=
 =?utf-8?B?dE1XRVBWYUQvYm42ckI0MENhSitpSStxQTVRMDVQQ1ljc2dlazF2TlpxNmhE?=
 =?utf-8?B?Mmx5d1VYVFBxNjRtYWszRzhleGRlVlY4REF4VDloWW9kL1ovQ25WeFIwMTNj?=
 =?utf-8?B?dVJ4UXE4UWtPUEd4N2dZUEpLdHljTWRZaU45YUxpMmcvQk5zVWtabjk3WWdV?=
 =?utf-8?B?M0F0SXNEQ05vZUg1Yi92OEh4dnFEaGgvcmdsRFIvQWZuY0tXaStZQWdLVnkz?=
 =?utf-8?B?MkZXSXNGbXZTNkY3ZVMySmxGTElhRkhKTlVjOHlGS01DQmtuRjNraEZhcFp6?=
 =?utf-8?B?U0dnMVRYcjM0K1Z6MWYxekVtTExrOUVWbC9kb0ZvdU5raHYydWw4V0p4Q0tT?=
 =?utf-8?B?T3IrM3hIMTlsRThUL1NEcnpuR1Y0L2czMUVLUzJURldOZERXOUNPaVpPSFVP?=
 =?utf-8?B?L3BmZjhVdk94MU1iNjQ1SEFNcEdWRlB4RFdFMEo0aVF0S1k4UnRVZHNsblpK?=
 =?utf-8?B?d2R0UU1Qemd1ODRrVWZCa09oTDFvODF5NitzcEdrTVEvRDhRL2ZxVWxIZnk4?=
 =?utf-8?B?dnh1VDM4bzI1SXBpc0drT3lQWFBES2R6a3NlYnEyQlJJbVEvZ01nUS9yZFZT?=
 =?utf-8?B?TldXWStQb3hKYlZPYlpnYTNlam0ySHkxdU9TU015am5reDNKVU9NV3F5STB0?=
 =?utf-8?B?TlNXTjhkZnk3ZWIrYjJEc3gzdnYvWG9UTHlvU0NRNmhULzVjWVgzc0pXTlow?=
 =?utf-8?B?MWhQUjZxd2ptWGVyVzN0ZjdIZ0pOUFJMM1JiY1RvM0NldVdyenV1a2ZUTHph?=
 =?utf-8?B?bWx6THUvanFKRVJYKzFnOEZEUFpDQ01XTVhwallRQlE5OEp0MFl5eXZ3dTFW?=
 =?utf-8?B?azNDK2dZSGQzM0wrQk80eUJHN1ZGMm03Y1BxakUyVDFMVkRVWXpCa3YrYWtF?=
 =?utf-8?B?SlZlRmkxWEFBM2xmTG9wbWo2QXpQbVNDQWQ2dGhFYUlQeUswc3VTa05kTzdD?=
 =?utf-8?B?NFNvcjV4TDdId3RuMGQ5UjdCS29CaUlJZWFIZWJ3VGFJMGZ3WDZpM2x0L3Iw?=
 =?utf-8?B?a0U2VFJDYkFkeTVQYjhTbzNrd0IxYWRoYno0TCsxS2tubEQ4TG03aWkva21n?=
 =?utf-8?B?NUNLSGpHZ0NuekxOenpMbXAwc2VBbzh2NGx2eHU5MTFGb1FWMEc3dlFaQmRm?=
 =?utf-8?B?TlQ3VzVGR0h3TWhJb0hQUTdCQXFCaEZMaUJmaHg2VUYzK2hOajFjUDhUa20z?=
 =?utf-8?B?Ylo5WFdSZm5XM1NyeEVlZDhWY3ZEQWRQS3pTRnVPZTFBMy9MdXAzSGh0bnJr?=
 =?utf-8?B?T2tMU0tpdnJ4VHhpY0ZLczF1U2hTOWN2TmFlSDdRdHkyTjdnUlJCNXhPa2Yy?=
 =?utf-8?B?bXJXNnNNWHkvOCt3aW52dmlWWUQ1ZHlIcHNjY1ZCUjJydDhWUWlCcEZvM01T?=
 =?utf-8?B?NmQ5UEs4Y2FNbWRMcGVxb2MwQ283WFBqcVoxeDBEU09BWXd2VUpTUWIrd2Jh?=
 =?utf-8?B?dWIrRGMwS3hYY0dMbXdPZ0RNZVNTcWVJVGJUNnBaVnU5K2VIbm5BWGhLS1BK?=
 =?utf-8?B?MzFJS0U4TUZqNHpZUkRhVWVNUGNGb2xSUWxQNitqTE1yRStUcm1BT1h5RWZP?=
 =?utf-8?Q?D1tM2yWAFblriuaF4lwKM8SEuD75Htni?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb8b18f-b222-4f3f-4f3b-08da07f4e1b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 09:02:36.4833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K29tl9eh/I/pih5X35CGf1gn4hTyYdwrLUr9W79lVFhSt61icPTANcAM4M+HvbindvczItempx9bnhNlmue3Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3852
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBIdW50ZXIgPGpv
bmF0aGFuaEBudmlkaWEuY29tPg0KPiBTZW50OiAxNyBNYXJjaCAyMDIyIDE0OjI1DQo+IFRvOiBL
cmlzaG5hIFlhcmxhZ2FkZGEgPGt5YXJsYWdhZGRhQG52aWRpYS5jb20+OyBicm9vbmllQGtlcm5l
bC5vcmc7IHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbTsgbGludXgtc3BpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+IHRlZ3JhQHZnZXIua2VybmVsLm9yZzsgQXNoaXNoIFNpbmdoYWwgPGFzaGlz
aHNpbmdoYUBudmlkaWEuY29tPg0KPiBDYzogU293amFueWEgS29tYXRpbmVuaSA8c2tvbWF0aW5l
bmlAbnZpZGlhLmNvbT47IExheG1hbiBEZXdhbmdhbiA8bGRld2FuZ2FuQG52aWRpYS5jb20+OyBy
b2JoK2R0QGtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBzcGk6IHRl
Z3JhMjEwLXF1YWQ6IEFkZCB3YWl0IHBvbGxpbmcgc3VwcG9ydA0KPiANCj4gDQo+IE9uIDE3LzAz
LzIwMjIgMDE6MjAsIEtyaXNobmEgWWFybGFnYWRkYSB3cm90ZToNCj4gPiBDb250cm9sbGVyIGNh
biBwb2xsIGZvciB3YWl0IHN0YXRlIGluc2VydGVkIGJ5IFRQTSBkZXZpY2UgYW5kDQo+ID4gaGFu
ZGxlIGl0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS3Jpc2huYSBZYXJsYWdhZGRhIDxreWFy
bGFnYWRkYUBudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9zcGkvc3BpLXRlZ3Jh
MjEwLXF1YWQuYyB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zcGkvc3BpLXRlZ3JhMjEwLXF1YWQuYyBiL2RyaXZlcnMvc3BpL3NwaS10ZWdyYTIxMC1x
dWFkLmMNCj4gPiBpbmRleCBhMmUyMjVlOGY3ZjAuLmVjZjE3MWJmY2RjZSAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL3NwaS9zcGktdGVncmEyMTAtcXVhZC5jDQo+ID4gKysrIGIvZHJpdmVycy9z
cGkvc3BpLXRlZ3JhMjEwLXF1YWQuYw0KPiA+IEBAIC0xNDIsNiArMTQyLDcgQEANCj4gPg0KPiA+
ICAgI2RlZmluZSBRU1BJX0dMT0JBTF9DT05GSUcJCQkwWDFhNA0KPiA+ICAgI2RlZmluZSBRU1BJ
X0NNQl9TRVFfRU4JCQkJQklUKDApDQo+ID4gKyNkZWZpbmUgUVNQSV9UUE1fV0FJVF9QT0xMX0VO
CQkJQklUKDEpDQo+ID4NCj4gPiAgICNkZWZpbmUgUVNQSV9DTUJfU0VRX0FERFIJCQkweDFhOA0K
PiA+ICAgI2RlZmluZSBRU1BJX0FERFJFU1NfVkFMVUVfU0VUKFgpCQkoKCh4KSAmIDB4RkZGRikg
PDwgMCkNCj4gPiBAQCAtMTY1LDExICsxNjYsMTMgQEAgc3RydWN0IHRlZ3JhX3FzcGlfc29jX2Rh
dGEgew0KPiA+ICAgCWJvb2wgaGFzX2RtYTsNCj4gPiAgIAlib29sIGNtYl94ZmVyX2NhcGFibGU7
DQo+ID4gICAJYm9vbCBjc19jb3VudDsNCj4gPiArCWJvb2wgaGFzX3dhaXRfcG9sbGluZzsNCj4g
PiAgIH07DQo+ID4NCj4gPiAgIHN0cnVjdCB0ZWdyYV9xc3BpX2NsaWVudF9kYXRhIHsNCj4gPiAg
IAlpbnQgdHhfY2xrX3RhcF9kZWxheTsNCj4gPiAgIAlpbnQgcnhfY2xrX3RhcF9kZWxheTsNCj4g
PiArCWJvb2wgd2FpdF9wb2xsaW5nOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgc3RydWN0IHRlZ3Jh
X3FzcGkgew0KPiA+IEBAIC04MzMsNiArODM2LDExIEBAIHN0YXRpYyB1MzIgdGVncmFfcXNwaV9z
ZXR1cF90cmFuc2Zlcl9vbmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwgc3RydWN0IHNwaV90cmFu
DQo+ID4gICAJCWVsc2UNCj4gPiAgIAkJCWNvbW1hbmQxIHw9IFFTUElfQ09OVFJPTF9NT0RFXzA7
DQo+ID4NCj4gPiArCQlpZiAodHFzcGktPnNvY19kYXRhLT5jbWJfeGZlcl9jYXBhYmxlKQ0KPiA+
ICsJCQljb21tYW5kMSAmPSB+UVNQSV9DU19TV19IVzsNCj4gPiArCQllbHNlDQo+ID4gKwkJCWNv
bW1hbmQxIHw9IFFTUElfQ1NfU1dfSFc7DQo+ID4gKw0KPiA+ICAgCQlpZiAoc3BpLT5tb2RlICYg
U1BJX0NTX0hJR0gpDQo+ID4gICAJCQljb21tYW5kMSB8PSBRU1BJX0NTX1NXX1ZBTDsNCj4gPiAg
IAkJZWxzZQ0KPiA+IEBAIC05MTcsNiArOTI1LDcgQEAgc3RhdGljIGludCB0ZWdyYV9xc3BpX3N0
YXJ0X3RyYW5zZmVyX29uZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLA0KPiA+DQo+ID4gICBzdGF0
aWMgc3RydWN0IHRlZ3JhX3FzcGlfY2xpZW50X2RhdGEgKnRlZ3JhX3FzcGlfcGFyc2VfY2RhdGFf
ZHQoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gPiAgIHsNCj4gPiArCXN0cnVjdCB0ZWdyYV9x
c3BpICp0cXNwaSA9IHNwaV9tYXN0ZXJfZ2V0X2RldmRhdGEoc3BpLT5tYXN0ZXIpOw0KPiA+ICAg
CXN0cnVjdCB0ZWdyYV9xc3BpX2NsaWVudF9kYXRhICpjZGF0YTsNCj4gPg0KPiA+ICAgCWNkYXRh
ID0gZGV2bV9remFsbG9jKCZzcGktPmRldiwgc2l6ZW9mKCpjZGF0YSksIEdGUF9LRVJORUwpOw0K
PiA+IEBAIC05MjcsNiArOTM2LDExIEBAIHN0YXRpYyBzdHJ1Y3QgdGVncmFfcXNwaV9jbGllbnRf
ZGF0YSAqdGVncmFfcXNwaV9wYXJzZV9jZGF0YV9kdChzdHJ1Y3Qgc3BpX2RldmljDQo+ID4gICAJ
CQkJICZjZGF0YS0+dHhfY2xrX3RhcF9kZWxheSk7DQo+ID4gICAJZGV2aWNlX3Byb3BlcnR5X3Jl
YWRfdTMyKCZzcGktPmRldiwgIm52aWRpYSxyeC1jbGstdGFwLWRlbGF5IiwNCj4gPiAgIAkJCQkg
JmNkYXRhLT5yeF9jbGtfdGFwX2RlbGF5KTsNCj4gPiArCWlmICh0cXNwaS0+c29jX2RhdGEtPmhh
c193YWl0X3BvbGxpbmcpDQo+ID4gKwkJY2RhdGEtPndhaXRfcG9sbGluZyA9IGRldmljZV9wcm9w
ZXJ0eV9yZWFkX2Jvb2wNCj4gPiArCQkJCQkoJnNwaS0+ZGV2LA0KPiA+ICsJCQkJCSAibnZpZGlh
LHdhaXQtcG9sbGluZyIpOw0KPiA+ICsNCj4gDQo+IA0KPiBUaGlzIGxvb2tzIG9kZC4gV2h5IGRv
IHdlIG5lZWQgdGhpcyBkZXZpY2UtdHJlZSBwcm9wZXJ0eSBpZiBpdCBpcw0KPiBhbHJlYWR5IHNw
ZWNpZmllZCBpbiB0aGUgU29DIGRhdGE/DQpTb2MgZGF0YSBzcGVjaWZpZXMgY2hpcCBpcyBjYXBh
YmxlIG9mIHdhaXQtcG9sbGluZy4NCldhaXQgcG9sbGluZyBzdGlsbCBoYXMgdG8gYmUgc2VsZWN0
ZWQgb24gc2xhdmUgZGV2aWNlcyB0aGF0IGNhbiBzdXBwb3J0IGl0Lg0KSSB3aWxsIGFkZCBvbmUg
bGluZSBkZXNjcmlwdGlvbiBmb3IgdGhlIHByb3BlcnRpZXMgaW4gbmV4dCB2ZXJzaW9uLg0KPiAN
Cj4gSm9uDQo+IA0KPiAtLQ0KPiBudnB1YmxpYw0K
