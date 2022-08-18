Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E0A598686
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343739AbiHROwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343708AbiHROwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:52:34 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A36BC831;
        Thu, 18 Aug 2022 07:52:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Roi7654wtdjZEZNE9bFPaM+p/2QbBwJdr3RSnDS9OL6CeLbYFiD35ewYMZ+U88I6RccHyqcR3ptMmOvTZjk5EAts0dXfQEBDOG/3qtsiGeAftZqO8v+UHmiJvJyHzI5ecF9cpfeWq4vxG7hyPHOq/Vm3C9+izWrj5sFUkhELws06hBXNF1No3HuC0u7RL+WDCNGCKlzQgQvHyjj2C3fC7fAk/2h6KZh2NV9G4jWxNRDRix19pXfoapbJ7TfpekBQ3Gz9zaMcbBAyk1WGoXL8NjYmqOTn4VyyYvqy655yyOFIs32kv8XD8SudjtLUUJYD+Ju8aU8bFSrdpi2I/FKLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLWlPdwS9JwXBtNYTWDXHvH3O4J8+x+puuVXpbalsv8=;
 b=WrFx3gd0IdD0nJbeP3Ni2YqITISr57Rf4bOhHl4qsGa+KZ/ryb7n6hQQoYiSU/0DNcpJcrsQoNdKwowKnHKjbJZb42+WjkV6fvpcaeZTxYN+mof1988lOsh/+NNgPAHz8nEe3SSoTFeLZsYsLleD4ItHUUJI9dBN++dmk0uY8WU22+fMAOUQ383W4OPuTF/5Xh1wMg2BFuh+8KDo1PAPRPgbc+hkJr8cfGXaJqTKlXBOsXLUOzsRNAppxl6aCOYbxml0RaH/itntjcdyzhQIwInyO+zbnoYuMQnzI7YUzuBp6D2FlbSuVQJDu+qsgA74l2U/mVUVu6D7DrzjzJ1AXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLWlPdwS9JwXBtNYTWDXHvH3O4J8+x+puuVXpbalsv8=;
 b=k5DTGOKSDdxoyU4APcU0hZ3WCUuhgWwHXds1o8/F39+tOm7/71N9+lF9SLt2Vz8UNCADjBStiv0PZMXz717yDB8LoC6wzRUbXCUfguhNJTHRsBRRBPiu1Q08jYnDDEWXPdGx0OpYHlTO9c4phtMZrk5k67NTICULOAMrB4E02sc=
Received: from BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 14:52:29 +0000
Received: from BY5PR12MB4033.namprd12.prod.outlook.com
 ([fe80::ed39:947f:6d95:63fd]) by BY5PR12MB4033.namprd12.prod.outlook.com
 ([fe80::ed39:947f:6d95:63fd%4]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 14:52:29 +0000
From:   "Neeli, Srinivas" <srinivas.neeli@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "shubhrajyoti.datta@xilinx.com" <shubhrajyoti.datta@xilinx.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "git@xilinx.com" <git@xilinx.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "sgoud@xilinx.com" <sgoud@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: RE: [PATCH] dt-bindings: Convert Xilinx watchdog bindings to
 json-schema
Thread-Topic: [PATCH] dt-bindings: Convert Xilinx watchdog bindings to
 json-schema
Thread-Index: AQHYsv/2CVH3Hn4sqECP9+/6z78ynq20qc6AgAARxVA=
Date:   Thu, 18 Aug 2022 14:52:29 +0000
Message-ID: <BY5PR12MB40338603CB399B516C1F2FCC936D9@BY5PR12MB4033.namprd12.prod.outlook.com>
References: <20220818124207.61313-1-srinivas.neeli@xilinx.com>
 <7f8305ee-d706-a5a3-0691-1aa296a65125@linaro.org>
In-Reply-To: <7f8305ee-d706-a5a3-0691-1aa296a65125@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37c60e5e-4e51-4b8a-8e42-08da8129461a
x-ms-traffictypediagnostic: DM6PR12MB4369:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2KSpLmzhidXRXC6SAn4ZBDjq6LITLWWNsotDj/nWjSj5BNjF7uHVEy8cjoqZq1IU4UkniHvmzmVAlEDOE72ypUtu0IpgW9uBM2O6FXAjFmmLwWjn+hiFKRUBSorAYi4vgwNwGvdARQKkb+pGhPUqJpykXOBxoVpM9aTL7pYSTYbquTWP/T8sjt5rqQ6oXf8MQfp7Y/JMTiRqh/grkYZqMYhlodAJjO/rykQhJ1pkXtffZxF+U0ZLnWMaEi8I5nZa89egXIdyiZNumr9Ba1BKCn4AawoUiNU/igM4t/fmvXiIvGfQy6rvDgBfDtAOBVVb1/lcNSTzGjNE/1L8sxXDtQzcBYRb/jStU0DJKci5I+rFmE8nAGN2eDZCiB7hFCeXJd/45KEwAHmtp+sI0Id9ZRpHDr4ivcm5j5xWpKXvuFEI8mZpRiX2xhweGV6cOAyJEnDdmmJ6h6SPGa/s41zq8WsmEgA7j9uOzZnFx6OqbbgVSesJVxqCujZUPH4NA5CHBg+meQYYWFHQdtdrJszNxKahGCL181v6jSS/1VfLR73JmN7+lfErGzfd9yDKpP4xT1Lbng1oPIhvUGkG0buYNqDCD5GDy4SxeqmM/VUxcrdrx7nCbGj1KmbjPrcfTMaQw7EGqHMJ4aBIVEtL7V9THOfllpQ+Xu9oGgnguBEDIi4JQobVa7vsLgCOsyoBtBXAFNCQUM7FCN/k4WEtrrBmIacRqzW3AdFL2ZVxr3UL2VyrGS6YMJ6H0cmxbL3HOZjSPraUSs3VD4YwOIEHWUJX+Ip2sp+OrZwyRBm6ce44BRiU5hHX+r+eH4bjJB4ftbkgDN8gbBNDyqwXzL18ay5BUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4033.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(316002)(2906002)(71200400001)(76116006)(8676002)(66946007)(38070700005)(66556008)(107886003)(66476007)(66446008)(38100700002)(64756008)(54906003)(86362001)(110136005)(122000001)(4326008)(55016003)(5660300002)(52536014)(8936002)(478600001)(83380400001)(966005)(26005)(9686003)(41300700001)(33656002)(186003)(53546011)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGNTMDZoNzRnR2lWOFVoSnA5cVBhOGlGTCsrWHVIRmZVNysrNmJKTU8zQlVI?=
 =?utf-8?B?QmJKRHhZU1NWVTVYTWVveXY0b2hRN08vaGg3bkNVdUZ2SWdDOUlIUThacFBr?=
 =?utf-8?B?aEtiMGVaMVBFeDhoWldlTEt3dEg4S1RhUHV4Z0VNK1VoWHk2ZWxjK1hmMFVU?=
 =?utf-8?B?RW5ud3NVaDg3OFB0TTFVYzlzeXJVaDJ1YTBHRS9tbTJ2OFFPeUxWdDVDVk90?=
 =?utf-8?B?UC85ODNuaWo3djlmemdabHByKzlUS1VXQzVVR1VzZ2NWc3NFc3FRNWpxYkFY?=
 =?utf-8?B?SHF2ZzdpWEZiNmFSSzdMak1KVHFuaTBBMnViZTVnWnZGbFZ6OVdldC9NSmdm?=
 =?utf-8?B?RkZQZ2NXaVhYZU1TQncySVpUaWNkRi95NHd5THQ0YTEzWlhwem5Kd0JZVFlG?=
 =?utf-8?B?bWxJc2FGeDlvZzA3dFN1TExVY2M4c1FHZDBxVDUraWxDMyt1MXRTdkpRSkVz?=
 =?utf-8?B?aW9LeVNRV3JhVUVUWUVLeENYaWtTaXkrYkdXb3g3QzZ4R1JyVjhKeGxqVnFB?=
 =?utf-8?B?cEh5NElvblQ0Q21IK3p2QzVHZHZOdCtiMDhlMVZ0MmZuem5VS2FyT1A5R0pr?=
 =?utf-8?B?ZGU1MkREc0VjS2hrek9jTlVFSjVUR1JHcDdFZTVmaEdxRElwTFZ0SWd6bXZP?=
 =?utf-8?B?aDV1dHZHUnFuWVdpUjNOT1QrNVN3bFFFUm8vSTF4aEc5VVByZXRORjQxUXg3?=
 =?utf-8?B?Nnk3eWEvd3JiMk82emdsQzNmTWcvY1hPTnNQa0x5ZUdQNElENzY5WFcrSkxF?=
 =?utf-8?B?bm90S00yV054bmQzaVMxdjRReTRrWnNJbTlQWDUwZUcya1ZFVUhXRzlGRW93?=
 =?utf-8?B?VkJSU2VsVlF3RENabFB2eHUzK3J0WGNYYVJ0VTdudjZNME5Eb1d5em54NzM5?=
 =?utf-8?B?cFNjaC91ak95dXNjdklYbGVLUXhsRTcybDUyZjJ0S3dTUHdCK2pvOXgvZXpP?=
 =?utf-8?B?MXplRG4wZWk5UjlrMmZ3d3c3N24zeDgxN092Z3lwdEt1cDNrQUQvS0Q5aFdF?=
 =?utf-8?B?SmprN1lSNUFTaDF2VkVlNEp0YTdoZm81WDM5VW05RWRKL0JpMFhyQWp2QW14?=
 =?utf-8?B?dGgwSGxTcUxCMzRZS2dHSk83WEk1TkllOWNHcUp1Znp4MTZPWFBISEFkV0Fy?=
 =?utf-8?B?bXF1U3pKWGxYRnpKekszMytOVnZLZ3BITXBRRFUzdkxtRi9xeWJkZEpsdTdy?=
 =?utf-8?B?aDdEZEozdU5kZ3ZHSHJhY05ENFBTWjZENS8yeFpMeWFCakhKNzZxNXhzTGhR?=
 =?utf-8?B?SnVIREVtVzAxWG1zUGM0VkZBZjhQSDI0SjBIdkJXT2RPRm9mcjNkS2ZoMmJU?=
 =?utf-8?B?eWxpVkZwbStCZSswWGJXZUNES2VyU1FyU09uZnFIODNod0c4dm1KR1F5Z0dm?=
 =?utf-8?B?RjRSRGQzclNTQUkvM1ZaRkFaR0YrVnMzTktpNHN3OFZFbCtQVVkvb0p6eCtt?=
 =?utf-8?B?azZOWUxHOWlrbW81K0JCV2huMGZaY0t1c1N1dHpTL3RFc1crQWJQZ3cyVDE3?=
 =?utf-8?B?T2ZwNlhmT2RIYmZkREFFQnVWdDcvSEtXTkNIWGFVNHVtd3ZSRkVoUHFEb0hU?=
 =?utf-8?B?SWRKWE8wVER3RXY0anpzb2VSYStTcGJLTUFHUkFkQmFSV2srbUJKZmdKWmpl?=
 =?utf-8?B?OEgrSlFQTXVzOGdSMmU3c1Q3RFZxdi9WZmNlZDFSLy9uNG1mTHJaV1ZOUlNC?=
 =?utf-8?B?TUZDZ3B3MVVNNjBDaGo5a005OU11WTM3Qzd6VW9VNVJ2VnBTSGNBR3RsU2J2?=
 =?utf-8?B?Nm1JajE4UTRFMXhaNXhyWHM4Mm8vTWkwdFFneWt0eDJYclkxbVZ0WmlINzdk?=
 =?utf-8?B?RWU3K3o2eFhXNWxrb0xWdTJ0M3dpTXVxbTZmNVhlcitrQXpwR3BrdTdpbkdF?=
 =?utf-8?B?elRnY3FtN1NPdHA1aFdEOHVXZi9KOGgwM1ljR3dZSTBTRkJ6S25MSzBUT0RB?=
 =?utf-8?B?SG9jcTg1Zy9oNVlLTHRrZkM4UDRPeG1EYXFJY3pQK24rUjFsaGF3WVlDSDVM?=
 =?utf-8?B?RXBqM1RBTFpiWG5Zb0MvWXRyWHUzQ2p5Vjg1UFk0dmpLMmhmV1ZTbGhURGRn?=
 =?utf-8?B?Y3pNdHZBcFZWSTRMU3U4cG5meVRtMUUxK1Rxbjh6enZIWnpsbG5ReXVmWmpH?=
 =?utf-8?Q?6fHM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4033.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c60e5e-4e51-4b8a-8e42-08da8129461a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 14:52:29.5973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqU3H44kNCh22Elzk3ZwGGMYVfu1OVhHho6Eqq5gGl9rPWfAHCxKQIRQOMySTufY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtv
emxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2Rh
eSwgQXVndXN0IDE4LCAyMDIyIDc6MDkgUE0NCj4gVG86IFNyaW5pdmFzIE5lZWxpIDxzcmluaXZh
cy5uZWVsaUB4aWxpbnguY29tPjsgbGludXhAcm9lY2stdXMubmV0Ow0KPiBrcnp5c3p0b2Yua296
bG93c2tpK2R0QGxpbmFyby5vcmc7IHdpbUBsaW51eC13YXRjaGRvZy5vcmc7DQo+IG1pY2hhbC5z
aW1la0B4aWxpbnguY29tOyBzaHViaHJhanlvdGkuZGF0dGFAeGlsaW54LmNvbQ0KPiBDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtd2F0Y2hkb2dAdmdl
ci5rZXJuZWwub3JnOw0KPiBnaXRAeGlsaW54LmNvbTsgZ2l0IChBTUQtWGlsaW54KSA8Z2l0QGFt
ZC5jb20+OyBzZ291ZEB4aWxpbnguY29tOyBSYWRoZXkNCj4gU2h5YW0gUGFuZGV5IDxyYWRoZXku
c2h5YW0ucGFuZGV5QHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGR0LWJpbmRp
bmdzOiBDb252ZXJ0IFhpbGlueCB3YXRjaGRvZyBiaW5kaW5ncyB0byBqc29uLQ0KPiBzY2hlbWEN
Cj4gDQo+IE9uIDE4LzA4LzIwMjIgMTU6NDIsIFNyaW5pdmFzIE5lZWxpIHdyb3RlOg0KPiA+IENv
bnZlcnQgWGlsaW54IHdhdGNoZG9nIGJpbmRpbmdzIHRvIERUIHNjaGVtYSBmb3JtYXQgdXNpbmcg
anNvbi1zY2hlbWENCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNodWJocmFqeW90aSBEYXR0YSA8
c2h1YmhyYWp5b3RpLmRhdHRhQHhpbGlueC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmFkaGV5
IFNoeWFtIFBhbmRleSA8cmFkaGV5LnNoeWFtLnBhbmRleUB4aWxpbnguY29tPg0KPiANCj4gVXNl
IHN1YmplY3QgcGVyZml4ZXMgbWF0Y2hpbmcgdGhlIHN1YnN5c3RlbSAoZ2l0IGxvZyAtLW9uZWxp
bmUgLS0gLi4uKS4NCldpbGwgdXBkYXRlIGluIHYyLg0KDQo+IA0KPiANCj4gPiBkaWZmIC0tZ2l0
DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cveGxueCx4
cHMtdGltZWJhc2UueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3dhdGNoZG9nL3hsbngseHBzLXRpbWViYXNlLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZmQyZTNmMmRmNTRjDQo+ID4gLS0tIC9kZXYvbnVs
bA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy94
bG54LHhwcy0NCj4gdGltZWJhc2UueWFtDQo+ID4gKysrIGwNCj4gDQo+IHhsbngseHBzLXRpbWVi
YXNlLXdkdC55YW1sDQo+IChuYW1lIHNob3VsZCBiZSBtYXRjaGluZyBjb21wYXRpYmxlcykNCk9r
LCBXaWxsIHVwZGF0ZSBpbiBWMi4NCg0KPiANCj4gPiBAQCAtMCwwICsxLDcxIEBADQo+ID4gKyMg
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIgT1IgQlNELTItQ2xhdXNl
ICVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2No
ZW1hcy93YXRjaGRvZy94bG54LHhwcy10aW1lYmFzZS55YW1sIw0KPiA+ICskc2NoZW1hOiBodHRw
Oi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiArDQo+ID4gK3Rp
dGxlOiBYaWxpbnggQVhJL1BMQiBzb2Z0Y29yZSBhbmQgd2luZG93IFdhdGNoZG9nIFRpbWVyDQo+
ID4gKw0KPiA+ICthbGxPZjoNCj4gPiArICAtICRyZWY6ICJ3YXRjaGRvZy55YW1sIyINCj4gDQo+
IE5vIG5lZWQgZm9yIHF1b3Rlcy4gUHV0IHRoZSBhbGxPZiBqdXN0IGFib3ZlICJwcm9wZXJ0aWVz
Ii4NCk9rLCB3aWxsIHVwZGF0ZSBpbiBWMi4NCg0KPiANCj4gPiArDQo+ID4gK21haW50YWluZXJz
Og0KPiA+ICsgIC0gU2h1YmhyYWp5b3RpIERhdHRhIDxzaHViaHJhanlvdGkuZGF0dGFAeGlsaW54
LmNvbT4NCj4gPiArICAtIFNyaW5pdmFzIE5lZWxpIDxzcmluaXZhcy5uZWVsaUB4aWxpbnguY29t
Pg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246DQo+ID4gKyAgVGhlIFRpbWViYXNlIHdhdGNoZG9n
IHRpbWVyKFdEVCkgaXMgYSBmcmVlLXJ1bm5pbmcgMzIgYml0IGNvdW50ZXIuDQo+ID4gKyAgV0RU
IHVzZXMgYSBkdWFsLWV4cGlyYXRpb24gYXJjaGl0ZWN0dXJlLiBBZnRlciBvbmUgZXhwaXJhdGlv
biBvZg0KPiA+ICsgIHRoZSB0aW1lb3V0IGludGVydmFsLCBhbiBpbnRlcnJ1cHQgaXMgZ2VuZXJh
dGVkIGFuZCB0aGUgV0RUIHN0YXRlDQo+ID4gKyAgYml0IGlzIHNldCB0byBvbmUgaW4gdGhlIHN0
YXR1cyByZWdpc3Rlci4gSWYgdGhlIHN0YXRlIGJpdCBpcyBub3QNCj4gPiArICBjbGVhcmVkIChi
eSB3cml0aW5nIGEgb25lIHRvIHRoZSBzdGF0ZSBiaXQpIGJlZm9yZSB0aGUgbmV4dA0KPiA+ICsg
IGV4cGlyYXRpb24gb2YgdGhlIHRpbWVvdXQgaW50ZXJ2YWwsIGEgV0RUIHJlc2V0IGlzIGdlbmVy
YXRlZC4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiAr
ICAgIG9uZU9mOg0KPiANCj4gVGhlcmUgaXMgbm8gb3RoZXIgb3B0aW9uLCBzbyBubyBuZWVkIGZv
ciBvbmVPZi4NCj4gDQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+IA0KPiBZb3UgZG8gbm90IGhhdmUg
aXRlbXMsIGp1c3Qgb25lIGl0ZW0uIERyb3AgaXRlbXMgYXMgd2VsbC4NCk9rLCB3aWxsIHVwZGF0
ZSBpbiBWMi4NCg0KPiANCj4gPiArICAgICAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgICAg
ICAtIHhsbngseHBzLXRpbWViYXNlLXdkdC0xLjAxLmENCj4gPiArICAgICAgICAgICAgICAtIHhs
bngseHBzLXRpbWViYXNlLXdkdC0xLjAwLmENCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAg
bWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgbWluSXRlbXM6IDEN
Cj4gDQo+IGluc3RlYWQgbWF4SXRlbXMNCk9rLCB3aWxsIHVwZGF0ZSBpbiBWMi4NCg0KPiANCj4g
PiArDQo+ID4gKyAgY2xvY2stZnJlcXVlbmN5Og0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlw
ZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+IA0KPiBObyBuZWVkIGZvciByZWYuIFRoaXMg
aXMgYSBzdGFuZGFyZCBwcm9wZXJ0eS4NCk9rLCB3aWxsIHVwZGF0ZSBpbiBWMi4NCj4gDQo+ID4g
KyAgICBkZXNjcmlwdGlvbjogRnJlcXVlbmN5IG9mIGNsb2NrIGluIEh6DQo+IA0KPiBXb3VsZCBi
ZSB1c2VmdWwgdG8gYWRkIGNvbnN0cmFpbnRzIChtaW5pbXVtL21heGltdW0gYW5kIGRlZmF1bHQp
LCBidXQNCj4gdGhhdCdzIG5vdCBhIGJpZyBkZWFsLg0KDQpUaGVyZSBpcyBubyBsaW1pdCB0byBt
aW5pbXVtIGFuZCBtYXhpbXVtIHZhbHVlcy4gU28gbm90IGFkZGluZyBjb25zdHJhaW50cy4NCj4g
DQo+ID4gKw0KPiA+ICsgIHhsbngsd2R0LWludGVydmFsOg0KPiA+ICsgICAgJHJlZjogL3NjaGVt
YXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gKyAgICBkZXNjcmlwdGlvbjog
V2F0Y2hkb2cgdGltZW91dCBpbnRlcnZhbA0KPiA+ICsgICAgbWluaW11bTogOA0KPiA+ICsgICAg
bWF4aW11bTogMzINCj4gPiArDQo+ID4gKyAgeGxueCx3ZHQtZW5hYmxlLW9uY2U6DQo+ID4gKyAg
ICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAg
IGVudW06IFswLCAxXQ0KPiA+ICsgICAgZGVzY3JpcHRpb246IElmIHdhdGNoZG9nIGlzIGNvbmZp
Z3VyZWQgYXMgZW5hYmxlIG9uY2UsDQo+ID4gKyAgICAgICAgICAgICAgICAgdGhlbiB0aGUgd2F0
Y2hkb2cgY2Fubm90IGJlIGRpc2FibGVkIGFmdGVyDQo+ID4gKyAgICAgICAgICAgICAgICAgaXQg
aGFzIGJlZW4gZW5hYmxlZC4NCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0
aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKw0KPiA+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZh
bHNlDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgIHdhdGNoZG9n
QDQwMTAwMDAwIHsNCj4gPiArICAgICAgY29tcGF0aWJsZSA9ICJ4bG54LHhwcy10aW1lYmFzZS13
ZHQtMS4wMC5hIjsNCj4gPiArICAgICAgcmVnID0gPDB4NDAxMDAwMDAgMHgxMDAwPjsNCj4gPiAr
ICAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDUwMDAwMDAwPjsNCj4gPiArICAgICAgY2xvY2tzID0g
PCZjbGtjIDE1PjsNCj4gPiArICAgICAgeGxueCx3ZHQtZW5hYmxlLW9uY2UgPSA8MHgwPjsNCj4g
PiArICAgICAgeGxueCx3ZHQtaW50ZXJ2YWwgPSA8MHgxYj47DQo+ID4gKyAgICB9IDsNCj4gDQo+
IE5vIG5lZWQgZm9yIHNwYWNlIGFmdGVyICc7Jw0KT2ssIHdpbGwgdXBkYXRlIGluIFYyLg0KDQpU
aGFua3MNCk5lZWxpIFNyaW5pdmFzDQo+IA0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6
eXN6dG9mDQo=
