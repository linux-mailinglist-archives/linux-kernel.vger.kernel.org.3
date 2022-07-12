Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D275711A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 06:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiGLE7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 00:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGLE7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:59:48 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140054.outbound.protection.outlook.com [40.107.14.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40B88C17C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 21:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfciOZ6ne4qpFf+nHhDBkSGp7X1XGfItB8yyLMYCJERCeGsSF12L2qWPbjexqsG3eynVEnaGo7hY4jvDWJf/MbA/wfYlp0TIH205rcOXfdweqNn7a2s1QXNjY30E9Lh3pxNJ5z2iiwDbxCPcADHEfUnlqfz6qG7F0ykCRkC1okZxqnzS4dbZt+JjeAjVEEBpjLXmqbjCqj1SaGEwmKTpG8BSyO9L7vnv4pVYSe8Afun30wTEUfDqLHu8QzB/YI5WXFrkBcZT+7zB6Q/F79lEvHgj4aTezOOjYwLK/0Topag9ydovk/+H0bQVcrky4ktunAHHcBC42UOzkkcdRpEGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWfaIuwEK2F5EFPVY0DvmuA1fnhxkzjKmXS+eH2CMKI=;
 b=cJ2BRxgGuw6Ty2jfe6N/DBUIMH/cWv/9UUVxXu95rdnb+/GO3yOjxreFcTFKzzz9YfLEwycesZWHoGbxZICh6V9MSsm+tf4E/DDjK64t4kaI7b18BzKZO+wFrJD3EvEgzvpnK32z6DNtSdmIyiffXv3kebG0aBc54AEHqg0uYm5ERdoL3LJPsYIgs6D5vn43IHWHhaQAkAudGfJWGiAzN2Wu3oqKqG2YIXfCQfSPPGBuYgQQkOEtvmilIdb06wEzngnn9xbGj33odo6SHmrDvczKgeLJzd4b5U02lshIvDqw2PfC8eB5MjBRq7Gvg/QdOXOKrtSTkYtPNx5d/5ub0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWfaIuwEK2F5EFPVY0DvmuA1fnhxkzjKmXS+eH2CMKI=;
 b=FoDIm2fFlrD1DLdMDUuXZCRKLTn4I9TB+TCGmhXIbL0FJ8eEptgqJDivUOlUHzDUZujomD8Riy5SxlrVO1VWzSLqGhLMiJ1xoZmLSjP3YNeWqIkTmTF2xtxFgn22Yc35UQbgknC5ngJYfwaDV4BVDpNrOecRFxHQxHkU3LuGPeQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB6PR04MB3079.eurprd04.prod.outlook.com (2603:10a6:6:a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.26; Tue, 12 Jul 2022 04:59:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 04:59:44 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tools/virtio: drop phys_addr_t typedef
Thread-Topic: [PATCH] tools/virtio: drop phys_addr_t typedef
Thread-Index: AQHYTUTkVp0WEhqmoU+wzqkaBpnO5azqaGoAgJBVHlA=
Date:   Tue, 12 Jul 2022 04:59:44 +0000
Message-ID: <DU0PR04MB94176F8C95FB297B4FCAD4D988869@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220411014039.3368218-1-peng.fan@oss.nxp.com>
 <CACGkMEtnXPBvv1W8SdT0Hv4riShQP3Du+EMv0XNgOGNmmfS6ng@mail.gmail.com>
In-Reply-To: <CACGkMEtnXPBvv1W8SdT0Hv4riShQP3Du+EMv0XNgOGNmmfS6ng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2fc0838-b2d7-49da-d9ba-08da63c3569f
x-ms-traffictypediagnostic: DB6PR04MB3079:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XlP7jcoosTNNrBp+5vPS4k3zsa9/Jp/rtz7kJc7cj71UAYEqXV2R3n+GIxcglaRo22EiAiI/ASB/6Of23k8zyFxAdtiaWemN5QnYtBlXEw5bp9UeLNE1Da4HaZMHvQ0TJ70u3JuJUByQaEthMMsPmYjHbSFBLrxb4ABfuffQfkOU0wjdD3x7VusavQ6IbE1ge5cmukWWfvmI+JW9ET9c8skcq9G4Olb7nvctrC1FVZJlxR1RDwZ+mFxFxiXFsUzM6d9YRGgXUu9ED8XKCHJvWO9ioPiPTkM9goWGldmJ0wYl9gITjMNJunEEv9kLuskF1iS75rbjPp1qSvK3EZxwcfUqBO0u+jj10VF6XqBDs/p0PHmm5esoaSv1aYtlKsTuapMddTJ0QzZwEiAU11EIQtUQYlnjGUx53ni9dPGWb+iTFi4Q2+ESX8YeTFb9IYioTlfS4itIBOqgYDtYAoHN/0RGYFbegxwt12jZ1PjqoC3z5hFuZsGjSx7dWOGoNMr1YxeZqC1QVqB9aIp8eHbAfQ9ymB25g0yCWT8UjuD/uXPE+Hq3r9C8qBmt0j13R2sRpoU0TA2N+RICb1QJAUXJtkdPW9UuUYQ2CR68iD/7L/4Bx/ThcvGXEyR5nw+3b7lGnUpw3uEqPMQ8jWyo32alZ1zbRogH5/LTIdHtQz5+GpcJnMMwABZ2uYbUdOkluYKJHQ5U2zMxAF5Ovz0SG9FOG93N4pIRYJUpvo+VsAG+IvaJhxNHyM7pkXxavj76jJRkC8OCWo6V1O89WSmELwA0xr3cgc780lhb0zE2jROMzu4EtbbSq8NE7tIfJjXU3Dxa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(53546011)(41300700001)(2906002)(8936002)(52536014)(186003)(7696005)(478600001)(33656002)(9686003)(44832011)(71200400001)(6506007)(5660300002)(55016003)(76116006)(26005)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(8676002)(38100700002)(86362001)(54906003)(6916009)(122000001)(83380400001)(316002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTBSN2xRMjR1d3dGVnh5ODdDTWw1THkrbUxQQVJseGs3YkxSMisyUEhPWlNY?=
 =?utf-8?B?dUhrWWtnUzBkSVFWWTdRcktPNmhyVk5BRmREU3d1c2g4TTQyK01SVk5MZjFK?=
 =?utf-8?B?cUNUc2llL3cyNSs4RHpXK1EzY0Jxck5uZnlwUlo1QWVCb1N4ZXFUNURLaHNa?=
 =?utf-8?B?TEFJK0lyZm11RlI1N1FyOG5tVjE2Z1VRQzNEVVlKZjZhbmk4YVVlNGNvQmQx?=
 =?utf-8?B?aWdlVUw2VlFORWN6VWxuc1hMMlVISWhtU0FhOEhHODRJRjdHcG1EYTR1ckdD?=
 =?utf-8?B?a0FxeEZNN0dyeWdIVSsxeG1RWHFZSGVpSGw3WDVvUHFuNXIycXR0blJLMnFG?=
 =?utf-8?B?MzBjWnFsclgzOGxFNXIvZElicWFPM1JkTE90ZzBlM0JCMU5FaU5nVU9rd3I1?=
 =?utf-8?B?MVIvd3E0VjBqMENVaFJhenM1MjZDdDNXSHdQQVRVQUFBbWc1UDhnWFRKbG1t?=
 =?utf-8?B?RU9WNjY0VTFtNllGam1VcU51SHNwK0JyNWZSK1B3ZnY3RGExdHl5blNUdCsz?=
 =?utf-8?B?NUtQU1RmRnRheXhvaTllSFNNVFRJdEhscmRCWTBWRlRNcnJEQ1JzSkJiSVp3?=
 =?utf-8?B?M3VCTGk5YTdZL3Z1Z2JoVG96OFpIcHpIL3RjcmRUMVQxQzBPQnJxRGdXS3B2?=
 =?utf-8?B?ZU9xdEMvVno5K212NDFEem1iWUh1UFpuMnluaTd2cUQ2RFIwb1B4K1piVmVQ?=
 =?utf-8?B?TTVGdXErRTNVeFRnTlFrQjB2UWwzenFDZCtjdmRWelZ6OHRqR3BXZ1BqQTg3?=
 =?utf-8?B?Y3gwQjRMSjhZNVF5K3BLQzY2SDJWM283NGVvVzYyMWlLVzArNlg4ZFJmUVly?=
 =?utf-8?B?MW1YTEMzZ3ZVRE5oWlVsT0prL3VUTWgxMDhTaHFQZnhxUnNIaGcvUHFoWmJm?=
 =?utf-8?B?d3lzVXZQNHlsRjVjMlpiN0k0eHdJeEdmeEkyaG84RXU3Q1ZNWm8yY2xVWHNH?=
 =?utf-8?B?OEQ1a1FzNnpBR3g1RzdIOGVKMkQzOERLZXBubjFWclFLQnl2MHVtUHpqMW5o?=
 =?utf-8?B?amFFeFpXOVpNVEZJcFhxak0xTFFjQ1BBN0F5MUtZL1BDQlFhTVZHWmJNaU84?=
 =?utf-8?B?S3Y5TUs3cUVjTlptNTJkNGg3QUVFN1ZjbGRXSDMybEdQa2xYQ0VBVkJoSUFa?=
 =?utf-8?B?K2xMTkI0SFVvVlFJb2lFd0YrTGxrQWV4dkE3QTlyNmVwdUplUkRrVGora3o2?=
 =?utf-8?B?UTB0L3B0VzN3bFQwTXpvNWs4Y25KbHpMVGtMNlY0NDlBVS81bmNtcGVudjdP?=
 =?utf-8?B?RmkvdzBDaTR4MGRVYTkwTG5sM3pnM0hDeG41RnF3QUZ1ZDAxdFpzT00wM0E2?=
 =?utf-8?B?RU9lWVM4N091b2dzMStRMFlsK3hEeHdKdTdqVXpjWjhRRHorSEJtT3Qzd1Zr?=
 =?utf-8?B?bGloaXB0NVc4Ull6ZCtDTTRickxBdkh4Wm40L3RwejlqTTRxTks4RW0wZktS?=
 =?utf-8?B?Sm9HbVAySE81T3RoRitDTFVGdlhDUERCUStzOWQrYndxZlNlNy82MDdlMWVD?=
 =?utf-8?B?aCsrUTZWMlhiL3ZoUTRvNEdKNXZjRXEzbWZobTkwN2xmOUZIaHUxendsZmxs?=
 =?utf-8?B?MHMrUlp2Umh5K2JFZlFHenBvUnRCSnc2N3RJOUpFYUhteWZPdzJONlZUYVFs?=
 =?utf-8?B?cUp1SWw1YUIxcG5zNjAxMzQ5YXE4a3ByNGlEajlmVnhBcUR2ZFU3SzFsKzhT?=
 =?utf-8?B?UU9ndXF6UmczRjQ5VENsKzZXSlE3YWNDNkJUWklTWWpUZWZ0Y0xEUlNIdW81?=
 =?utf-8?B?enpqSXJNeUtPRWtFNjhtWmV6TGpab3dPRVhxUUNPcThIYkZ0aFVJeDdvNHgy?=
 =?utf-8?B?QXB5eHp4TjJSbDl3RlFMcUh1R0x0SkZvTUZFZHJmeG9mbUJLV1h6bElWOHRl?=
 =?utf-8?B?MFZwZjBRbkJ6MDhvaWNwa0JpcWg5RzBNejhQZVhQRGlqMW4yOUU1TFBrSWFL?=
 =?utf-8?B?ZjZUa2JRT2prcHJVRjMzd0MvQ2cwalIxSEoycDZoTzZudVRYWGZMVm44Z1lH?=
 =?utf-8?B?S1ludG9TVG01WFkvN0R3VlBPRmpSVjJyY20yK1JTQmYyUlhZODdlQTUxVEN5?=
 =?utf-8?B?WXZRMVMxZ0xtMlZ5OTB1bWdrbmJqMnJGUlhOYmZvYVZCY0hUcFpOZVZBK2tJ?=
 =?utf-8?Q?M/Qc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fc0838-b2d7-49da-d9ba-08da63c3569f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 04:59:44.8810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KLhn8d0F8w4Wwd65e9a4/2jaaHcSHsMxnZJqvcrYwi3VEgMs4KeZVjFR8Fh7QjlpqFPc1ouZOMP0T8CCYu+O9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSB0b29scy92aXJ0aW86IGRyb3AgcGh5c19hZGRyX3QgdHlw
ZWRlZg0KDQpXb3VsZCBhbnlvbmUgcGljayB1cCB0aGlzIHBhdGNoPyBPciBhbnkgY29tbWVudHM/
DQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IE9uIE1vbiwgQXByIDExLCAyMDIyIGF0IDk6Mzkg
QU0gUGVuZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAuY29tPg0KPiB3cm90ZToNCj4gPg0K
PiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gV2l0aCBjb21t
aXQgODg0ZWUxZTU4NWNhICgidG9vbHMvaW5jbHVkZTogQWRkIHBoeXNfYWRkcl90IHRvDQo+ID4g
dHlwZXMuaCIpLA0KPiA+DQo+ID4gV2hlbiBidWlsZGluZyB2aXJ0aW8gdG9vbHMsIHRoZXJlIGlz
IGEgdHlwZSBjb25maWN0aW5nIGVycm9yOg0KPiA+DQo+ID4gIg0KPiA+IC4vbGludXgva2VybmVs
Lmg6MzI6Mjg6IGVycm9yOiBjb25mbGljdGluZyB0eXBlcyBmb3Ig4oCYcGh5c19hZGRyX3TigJkN
Cj4gPiAgICAzMiB8IHR5cGVkZWYgdW5zaWduZWQgbG9uZyBsb25nIHBoeXNfYWRkcl90Ow0KPiA+
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn4NCj4gPiBJbiBm
aWxlIGluY2x1ZGVkIGZyb20gL3Vzci9pbmNsdWRlL2xpbnV4L3ZpcnRpb19ibGsuaDoyOCwNCj4g
PiAgICAgICAgICAgICAgICAgIGZyb20gdmlydGlvLWl2c2htZW0tYmxvY2suYzoyOToNCj4gPiAu
Li9pbmNsdWRlL2xpbnV4L3R5cGVzLmg6Njk6MTM6IG5vdGU6IHByZXZpb3VzIGRlY2xhcmF0aW9u
IG9mIOKAmHBoeXNfYWRkcl904oCZDQo+IHdhcyBoZXJlDQo+ID4gICAgNjkgfCB0eXBlZGVmIHUz
MiBwaHlzX2FkZHJfdDsNCj4gPiAgICAgICB8ICAgICAgICAgICAgIF5+fn5+fn5+fn5+DQo+ID4g
Ig0KPiA+DQo+ID4gTGV0J3MgZHJvcCB0aGUgdHlwZWRlZiBpbiB0b29scy92aXJ0aW8vbGludXgv
a2VybmVsLmgNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPg0KPiANCj4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+
IA0KPiA+IC0tLQ0KPiA+ICB0b29scy92aXJ0aW8vbGludXgva2VybmVsLmggfCAxIC0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90b29s
cy92aXJ0aW8vbGludXgva2VybmVsLmggYi90b29scy92aXJ0aW8vbGludXgva2VybmVsLmgNCj4g
PiBpbmRleCAwYjQ5MzU0MmU2MWEuLjFkMzI0OGUzZjI3MCAxMDA2NDQNCj4gPiAtLS0gYS90b29s
cy92aXJ0aW8vbGludXgva2VybmVsLmgNCj4gPiArKysgYi90b29scy92aXJ0aW8vbGludXgva2Vy
bmVsLmgNCj4gPiBAQCAtMjksNyArMjksNiBAQA0KPiA+ICAjZGVmaW5lIFJFQUQgICAgICAgICAg
ICAgICAgICAgIDANCj4gPiAgI2RlZmluZSBXUklURSAgICAgICAgICAgICAgICAgICAxDQo+ID4N
Cj4gPiAtdHlwZWRlZiB1bnNpZ25lZCBsb25nIGxvbmcgcGh5c19hZGRyX3Q7ICB0eXBlZGVmIHVu
c2lnbmVkIGxvbmcgbG9uZw0KPiA+IGRtYV9hZGRyX3Q7ICB0eXBlZGVmIHNpemVfdCBfX2tlcm5l
bF9zaXplX3Q7ICB0eXBlZGVmIHVuc2lnbmVkIGludA0KPiA+IF9fd3N1bTsNCj4gPiAtLQ0KPiA+
IDIuMjUuMQ0KPiA+DQoNCg==
