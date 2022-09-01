Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E645AA197
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 23:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiIAVjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 17:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIAVjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 17:39:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF72D75FC4;
        Thu,  1 Sep 2022 14:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZTcQeFFEucGP7tFfUqBTGhgQeESGAi17ZwIIH0asw6Uz+J12ZTUvLKw/4Fcku2oxHbwvyIhTna81E47R7CUpwP2cL+h3tnAIyFBwfa29yHjmbY7a8PB+IsPG6FiPFFXFG02npy1jNiKdHPTO5WVjT1wNhUXwd6maZ85I/myAArnuxAsM06KtdQWn/WcLn892zXggLnzo9R/o3u/+8FXe3vsRtN310qJGYX3llhVvE9NolejIDI5LMUNjPwBG+r4IM3JS8Svj5BB0Wzd+lAKYjkVB/4dHVLQIG9p5gu9yF6URR+nd4isu1mgitRhC3JbErGtULX0D66FOF348352Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItbnxUtamnPOclK+zorR7agmcGQrb/8lH8O08BKw0L4=;
 b=PZaixSTa6zonye905fBgWwi+fkvZ0AumzPu4RPPWqnK/9rPbXbXmefjJQn4jJ7zPileQ6iqVU3wRkxj6WQOJf7O7aLosReoqV0ZP2EB2NqS9PFn0ZWV/Jy+Skwv7IBXmDQ5euuEwP8skyfZ8H76fpij/n73K07oZlUu1C0OhWIiENY4vIaYyTyZFzaVPefoU1rRO/MfuYn1xWsfz8Zn/s49+CJcYey7yWHHGA0ylwdD4EqEVwGvhpw65QNMX1kV/MO7kpkx5SoRMA6h+hk/emA1E++WP/Ugssr9uyjjPr2blCDlacjWYbptqx/R7LzmPCnk2lhNAB51INS7gZHw2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItbnxUtamnPOclK+zorR7agmcGQrb/8lH8O08BKw0L4=;
 b=GKrXfVLFktmjAINg+ZB1KoIJbB5YHol6h9s53n0VBXn0cxDoqkiZ4UOcIFO7JwFrwTcDUaOvZ3LsgKHOyB6nOqYSWmDVv0xXCAeUzPQCb3/pU+W+lS6um2MuTbufcC8oTJoOEOSq14NMeeL/cJiOlOmruzwUPJSrpU32Rif52ag=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 1 Sep
 2022 21:39:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%5]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 21:39:37 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: RE: [PATCH v2] platform/x86: wmi: Allow duplicate GUIDs for drivers
 that use struct wmi_driver
Thread-Topic: [PATCH v2] platform/x86: wmi: Allow duplicate GUIDs for drivers
 that use struct wmi_driver
Thread-Index: AQHYu+QBF88sXsQdD0eeHhsaU4Pboa3K1WCAgABJC5A=
Date:   Thu, 1 Sep 2022 21:39:37 +0000
Message-ID: <MN0PR12MB6101441AA29CE815DCAD26AEE27B9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220829201500.6341-1-mario.limonciello@amd.com>
 <CAHp75Vc3v4a6=ZJnOYYFGHEomExxopuUy8axDL=M2tbxHqtXqQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc3v4a6=ZJnOYYFGHEomExxopuUy8axDL=M2tbxHqtXqQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-01T21:37:59Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d9ac9980-acfc-44f9-b639-5cd3c7c54269;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-01T21:39:35Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 37d75723-bee9-4f5e-8f75-39bf53b5dc1a
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b580c636-d5cc-41d6-744d-08da8c627812
x-ms-traffictypediagnostic: MN0PR12MB6319:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R6HQZo46PsV5x3sPsVrnx7oiCa+Tm1cLqw6b+1e7bjecGB9O5Q/52WCaOvSB3eNU6iTBmkGOMgxCkwmEB6mOYI5vyTZ2f5fczM8myDKJNjO9ONK/jFS75npTES3JmLZDBR4OKv7+VcWg/oy9QvWfG7XIkBcexz9dVOdxy80CyJTlgupVQTtWBowlV8Wj00n5t3TTWCqK6juwebljsuZRyU//g3NUeViRivEqCwNLcti29lbSEfBZqDYyNpFu8yLBS8A7tr/0RixFDWiAWPlQBC9QjKEU8AvnyTbGpJCM7XPYNO3McBXllCkHcjHVY4c/TO1AcE8D0VeLl+3+d+GdHnrdstQt+Z7gS03MRybNDDHJHBzI0JNzjnbqckfrZOMiz05DOZSg8hdpxJtLw9Wi5/ADXdaAuwcm/qJ/A41kkcfIF9qENrbIZWQcZI3tAL9Jg+JveY6xzwnQUXhdLeEj91ZnIpIpb+xrHN9Nh1dwgSkYXcT+3BjjnoSMv2yf4pDDzyEdPKypSy3sM9b4eH3CB61aOpyZFHLB7qgG1rYXbVXHOMt1tqvH68oXNX0LjwvHxCbbFnAPsD776C2qIEl69ZWB2t8LM4+i3kQdLfLjmmOxnpRnZktQVJkRXkPlxxc0xHfd2yln6Lih7+odq/FuD/0xpCU0GPv85MH68+XoTlbA02i/VJIrfQMXf+DhQaoWK3/QOYvp6dBvyfkcRdQM8Es1bQxPS52t7K75iTxzy09/I0EserRnbx3MqcknUyszfH9xjiXGkI71eUb9bgTU/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(6506007)(86362001)(2906002)(53546011)(7696005)(33656002)(478600001)(4326008)(66556008)(9686003)(8676002)(66476007)(76116006)(66446008)(64756008)(55016003)(186003)(8936002)(66946007)(26005)(38100700002)(41300700001)(52536014)(122000001)(38070700005)(5660300002)(54906003)(6916009)(316002)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUpWWFFFR2JNd1hIUGljLzBqeDVxbVZjRTZXWHhCZm5HRWxvT2dtRlZoSlcv?=
 =?utf-8?B?N2Iza0E4Q2NsWjEvYXBPR3NjL1BpcHY1TkxGS1N5M0dZYm96elJkVjRVV3lW?=
 =?utf-8?B?MERZK3hxRDE3QzZxazZHL3BGUlBkeTdzYmtFcmZqOXhjbzN5OEg5K1BMTkkv?=
 =?utf-8?B?b1BTYWZoK3VsWW1hOVFiUjdrNWQ3VVZEd01lQlAwY2ZrYnBHekVSN29TWU9w?=
 =?utf-8?B?bEhmSXdwekc1ZC9wMkFDZFY5alNOLy9pYXgyaVdDeWMzU3BBMGJ2Q0t6dU5w?=
 =?utf-8?B?TVN4aDRxYzkydFQzTUJ4T2JHUFJzM3l3TnBCdUNLV1BkMlpLeDc5ZE1xczJL?=
 =?utf-8?B?L3FoK3hXaytISnplTE5ENU1YcTRqTEM5eWtBQ2FCazlTc1FCUG5ISEEzWC9T?=
 =?utf-8?B?ZFFoNCtNLzZhUERON0FpZE5BdDNTQ1hvd0hEM3RORkZTalYrY0RHL3RHOTYw?=
 =?utf-8?B?QlJEVkgyVVBheUdkK1dUUVB0ckdWNnkwSlRndDhCc3orU2ZEVkVCTHVsLy84?=
 =?utf-8?B?alVCU3NDNEpFUm40bjh0clU2RTZsUC95UktlY1Z0YTFKTVVXUjhMVEFTSDY5?=
 =?utf-8?B?QVBNeVl4NXJSR3djTlA2cDY4d0xKNWV0cmlFSk9VUDdnclowdjdyRU1NclJR?=
 =?utf-8?B?MGI2Rk5lbXRDdEQ0WGZOeGJlckxhQzFJQkNHTFZNODd1N1pFSW9ZaU5NbTRB?=
 =?utf-8?B?N2s4V1JNRnVWTWdYUkxMNWpDMzJJcXNXNkN5YmhpS0lFMk9lT3hDRE81UlFk?=
 =?utf-8?B?eUVHdUh1ckZaQ3BNc2d6bk1yNGhxeXZFckRVbjJIUWovY3l5dFYxUWRuN2c2?=
 =?utf-8?B?TjBRaUQzR3ozbCtHYkZhVWd0eW04bzZIczdjelJjYmRYMHM1dy9sYk9PSG0z?=
 =?utf-8?B?VjM4d0N6dnhXeGNmUmU1azNKdkQwSG5UMGFvYjgzci9aRFNHYVlkemR0T3VE?=
 =?utf-8?B?dVk3TjI3WUJqdmkvTkxLb2lESEl6cDl2bmJjc0ZJUjA4WDNiMzZFNGt6aVI0?=
 =?utf-8?B?aVpZNktQcXRuQUtJNUpnRTNLUHVLRzM3ZEJKcGg2WiswSCt5TkhJbEk2d1Uy?=
 =?utf-8?B?ZEVSVTBmbndWZitDOWNyR3UxTU9EZ040OFI1U1c5bFhnY1pUWFFXQUl0WktC?=
 =?utf-8?B?b1JQTGZHSkZRTGFOcUtReGdybURaOG1uQlpXQ2tyb3RaL3lqelFmK0cvalJM?=
 =?utf-8?B?N3EyODJWditKTktId2JjS3VLRklOSGs2amFqbHVTMGF2RGNpOEZMQWVnT1Rw?=
 =?utf-8?B?cjZLTUw5T0R6MFJSSGVRVWtuNkNUTFN5MTZHNGJsTmRpOEZnMkh1Q2xCSXdD?=
 =?utf-8?B?VkNUZnFGVHBKU3ZROWJoN2dmQUhjQTVuVDlld1VIQzl0dmZCNFdjNFI4djhV?=
 =?utf-8?B?SmpBcitXekYxamdJTXk0S3JvK3RxUXVjZVRMUWhjU1QzbkpYM3RSS2t2NFpZ?=
 =?utf-8?B?ZlJjanQ2VzNVN1RQeE13VUxxUlM5bUdlaU0rWlpINDQ0YUk4Z0l5YXRmWW9v?=
 =?utf-8?B?Um9hak80UE1sajI2cHM5ckVtQ2srZDd1VXRKa0ZKazM3N2NwcmtKcmdTN2lT?=
 =?utf-8?B?ZVU5M05BTStKU0IwdFVPbUFyMUlua0lIZ2w2Y29XaFBRQ242NEZ3UVZ0a1cz?=
 =?utf-8?B?eldPOGtRODlXTHF2NEYyeGhES1Ywc01tQk9DdVE1WmhNMUhtdHljTFFqTVVI?=
 =?utf-8?B?UXJBSlhiOWhNaExtbGV3UFl1UmtEZWhtNEd1YkdBenRrQlZBQm1tTVl3bzJn?=
 =?utf-8?B?SjJURlg5UENjNlZyR1Byb0hCcUFWUWdQdGEwYWZocDJWY3YrYjFQUkNnL2I4?=
 =?utf-8?B?UDJKVUZQUWtxZ1pNMVBINWt1Vmhwb04xMDhBbHMwVC9PR3Nqd1dITm1NYzB0?=
 =?utf-8?B?RzhTSThRVlo2Rys2SC9wVUJOZkhOVjR0N3BkMlIxNTNuOVdWWVpBRWhuZXNq?=
 =?utf-8?B?blh4YWgvRTJGV2ZQTUZXcnJEL3lhRjNQSGo4N2Nsc0pKQ3I5Zmw3WndEaDIz?=
 =?utf-8?B?N3BtcWZZSEt3dVB5dVBNNks1VlNYdnRtUkRuTzUvNWdmaW02cXltclhFM1g5?=
 =?utf-8?B?QTN4QlBud1VBUlFoQmtZLzJRaHVsMUMzaXVrU04yZmhGdmxPM0FiTTRFOU85?=
 =?utf-8?Q?0cwY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b580c636-d5cc-41d6-744d-08da8c627812
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 21:39:37.5036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/UJqR5dK0t6cMcVYBNfyvsV3GOYmuPQLEfJNfRltNu0wsdujVig3Nv03DFUxIafOPBF82MF0i1XCpbHp/S3SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5k
eSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgU2VwdGVtYmVyIDEsIDIwMjIgMTI6MTcNCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFy
aW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJl
ZGhhdC5jb20+OyBNYXJrIEdyb3NzDQo+IDxtYXJrZ3Jvc3NAa2VybmVsLm9yZz47IFBsYXRmb3Jt
IERyaXZlciA8cGxhdGZvcm0tZHJpdmVyLQ0KPiB4ODZAdmdlci5rZXJuZWwub3JnPjsgTGludXgg
S2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIHBsYXRmb3JtL3g4Njogd21pOiBBbGxvdyBkdXBsaWNh
dGUgR1VJRHMgZm9yIGRyaXZlcnMNCj4gdGhhdCB1c2Ugc3RydWN0IHdtaV9kcml2ZXINCj4gDQo+
IE9uIE1vbiwgQXVnIDI5LCAyMDIyIGF0IDExOjIwIFBNIE1hcmlvIExpbW9uY2llbGxvDQo+IDxt
YXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBXTUkgc3Vic3lz
dGVtIGluIHRoZSBrZXJuZWwgY3VycmVudGx5IHRyYWNrcyBXTUkgZGV2aWNlcyBieQ0KPiA+IGEg
R1VJRCBzdHJpbmcgbm90IGJ5IEFDUEkgZGV2aWNlLiAgVGhlIEdVSUQgdXNlZCBieSB0aGUgYHdt
aS1ibW9mYA0KPiA+IG1vZHVsZSBob3dldmVyIGlzIGF2YWlsYWJsZSBmcm9tIG1hbnkgZGV2aWNl
cyBvbiBuZWFybHkgZXZlcnkgbWFjaGluZS4NCj4gPg0KPiA+IFRoaXMgb3JpZ2luYWxseSB3YXMg
dGhvdWdoIHRvIGJlIGEgYnVnLCBidXQgYXMgaXQgaGFwcGVucyBvbiBtb3N0DQo+IA0KPiB0aG91
Z2h0DQo+IA0KPiA+IG1hY2hpbmVzIGl0IGlzIGEgZGVzaWduIG1pc3Rha2UuICBJdCBoYXMgYmVl
biBmaXhlZCBieSB0eWluZyBhbiBBQ1BJDQo+ID4gZGV2aWNlIHRvIHRoZSBkcml2ZXIgd2l0aCBz
dHJ1Y3Qgd21pX2RyaXZlci4gU28gZHJpdmVycyB0aGF0IGhhdmUNCj4gPiBtb3ZlZCBvdmVyIHRv
IHN0cnVjdCB3bWlfZHJpdmVyIGNhbiBhY3R1YWxseSBzdXBwb3J0IG11bHRpcGxlDQo+ID4gaW5z
dGFudGlhdGlvbnMgb2YgYSBHVUlEIHdpdGhvdXQgYW55IHByb2JsZW0uDQo+ID4NCj4gPiBBZGQg
YW4gYWxsb3cgbGlzdCBpbnRvIHdtaS5jIGZvciBHVUlEcyB0aGF0IHRoZSBkcml2ZXJzIHRoYXQg
YXJlIGtub3duDQo+ID4gdG8gdXNlIHN0cnVjdCB3bWlfZHJpdmVyLiAgVGhlIGxpc3QgaXMgcG9w
dWxhdGVkIHdpdGggYHdtaS1ibW9mYCByaWdodA0KPiA+IG5vdy4gVGhlIGFkZGl0aW9uYWwgaW5z
dGFuY2VzIG9mIHRoYXQgaW4gc3lzZnMgd2l0aCBiZSBzdWZmaXhlZCB3aXRoIC0lZA0KPiANCj4g
Li4uDQo+IA0KPiA+ICsvKiBhbGxvdyBkdXBsaWNhdGUgR1VJRHMgYXMgdGhlc2UgZGV2aWNlIGRy
aXZlcnMgdXNlIHN0cnVjdCB3bWlfZHJpdmVyICovDQo+ID4gK3N0YXRpYyBjb25zdCBjaGFyICog
Y29uc3QgYWxsb3dfZHVwbGljYXRlc1tdID0gew0KPiA+ICsgICAgICAgIjA1OTAxMjIxLUQ1NjYt
MTFEMS1CMkYwLTAwQTBDOTA2MjkxMCIsIC8qIHdtaS1ibW9mICovDQo+ID4gKyAgICAgICBOVUxM
LA0KPiANCj4gTm8gY29tbWEgZm9yIHRoZSB0ZXJtaW5hdG9yLg0KPiANCj4gPiArfTsNCj4gDQo+
IC4uLg0KPiANCj4gPiArc3RhdGljIGludCBndWlkX2NvdW50KGNvbnN0IGd1aWRfdCAqZ3VpZCkN
Cj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0IHdtaV9ibG9jayAqd2Jsb2NrOw0KPiA+ICsgICAg
ICAgaW50IGNvdW50ID0gMDsNCj4gPiArDQo+ID4gKyAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5
KHdibG9jaywgJndtaV9ibG9ja19saXN0LCBsaXN0KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGlm
IChndWlkX2VxdWFsKCZ3YmxvY2stPmdibG9jay5ndWlkLCBndWlkKSkNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBjb3VudCsrOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAg
IHJldHVybiBjb3VudDsNCj4gPiArfQ0KPiANCj4gSSBoYXZlbid0IGRlZXBseSBjaGVja2VkIHRo
ZSBjb2RlLCBidXQgdGhpcyBraW5kIG9mIGFwcHJvYWNoIGlzDQo+IGZyYWdpbGUgYW5kIHByb3Zl
biB0byBiZSBlcnJvciBwcm9uZSBhcyBzaG93biBpbiBwcmFjdGljZS4gVGhlDQo+IHNjZW5hcmlv
IGlzIChhZ2Fpbiwgbm90IHN1cmUgaWYgaXQncyBwb3NzaWJsZSwgbmVlZCBhIGNvbW1lbnQgaW4g
dGhlDQo+IGNvZGUgaWYgaXQncyBub3QgcG9zc2libGUpIHJlbW92aW5nIGFuIGVudHJ5IGZyb20g
dGhlIGxpc3QgaW4gdGhlDQo+IG1pZGRsZSBhbmQgdHJ5aW5nIHRvIGFkZCBpdCBhZ2Fpbi4geW91
IHdpbGwgc2VlIHRoZSBkdXBsaWNhdGUgY291bnQNCj4gdmFsdWVzLiBUaGF0J3Mgd2h5IGluIHRo
ZSBnZW5lcmFsIGNhc2Ugd2UgdXNlIElEQSBvciBzaW1pbGFyDQo+IGFwcHJvYWNoZXMuDQoNCkl0
IHNob3VsZG4ndCBiZSBwb3NzaWJsZSB0byBhZGQvcmVtb3ZlIGZyb20gdGhlIGxpc3QsIHRoZXkn
cmUgZml4ZWQNCmxpc3RzIHRoYXQgd2VyZSBwYXJzZWQgZnJvbSBfV0RHLg0KDQpIYW5zIC0gc2lu
Y2UgeW91IGFscmVhZHkgdG9vayB0aGlzIGludG8geW91ciByZXZpZXcgcXVldWUsIGNhbiB5b3UN
CmxhbmQgZml4ZXMgZm9yIHRoZSAzIHRoaW5ncyBBbmR5IHBvaW50ZWQgb3V0IGJlZm9yZSBpdCBn
b2VzIHRvIC1uZXh0DQpvciBkbyB5b3Ugd2FudCBtZSB0byBkbyBhIG1hbnVhbCBmb2xsb3cgdXAg
Zm9yIHRoZW0/DQoNCjEpIFNwZWxsaW5nIGVycm9yIGluIGNvbW1pdCBtZXNzYWdlDQoyKSBSZW1v
dmUgY29tbWEgb24gdGVybWluYXRvcg0KMykgQWRkIGEgY29tbWVudCB3aHkgZ3VpZF9jb3VudCBp
cyBzYWZlIChpZiB5b3UgYWdyZWUgd2l0aCBtZSBpdCBpcykNCg==
