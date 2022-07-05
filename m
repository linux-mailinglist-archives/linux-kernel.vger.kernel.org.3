Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D840A567670
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiGES2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiGES2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:28:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01DB96;
        Tue,  5 Jul 2022 11:28:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI5SmvD62t3cZztV3imOxWJDhDqeOV6K4LfeKIxSQuZqYeehj4v8ttacfpVmRcj5UPYf1PxhNkaHOfKdWI1Uy7WZG17RfXbdY0gWiEEqhnnfCX/sH+Oo8w8HxkyZ3aKOwktoQMgpfKCLPpIjQeeXzMhU/oSmlG7z57alXOD/+GaGyjcCYb5ixIkxE/MY2zAc4bAAi5/GsIw8Kjtlr9x6HRhIG/pAVNdkzFCH4b12y0/gcodRqQ1c0s+ArYpD9Zj8V8e2s5tdkKku8qRelC/JbVGy8gw/DBYUp4z2j6colAy+ZMBQH1jQQOx7sQPx7FoAwfXXlBVdCTv32Ev+ubqplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkJPe7tszfc0gLfFyh46WtBWYvK1InoUhr8BoplJZ1U=;
 b=Lqaqx0ILeMRemi8HTgyuveG1UGV1UB4I78OrHqv7M71tcLoluw9XVGYPIdZvUmb7PypuYEvBAkTWMEZ1p5P+24PMqU5OuW4/JCxydh2FwQfAJYzk6drRkNoB2o2kYyzE3m+jji5RRRA+lEuxNfFBQf1/suUyjqQuJMVK40unmAf42QNR1HRaXtypqHzH0BdrCG9CRuUfBrYCqAUCaByFwSz96+EkjxJOzznwm6HwQVCecKjKNdQURSO7IPRRCDe6HqjiWpoMZVqsQKlMeMPMSFPAKZ85Lb8dOyLbsvHWOSeQxdIRu4xuhvzMIm+kfHqBbPGyaAzoMyLCPcf65pKKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkJPe7tszfc0gLfFyh46WtBWYvK1InoUhr8BoplJZ1U=;
 b=a4eKONjsuRzWrts5I4qlAsHI/jpVBVN8AfkPHID1QrWf+BA3YofCijseUKySGH1fmpHgPtdpqEE5FeNyvapWzLLNeMkYQZqajIb228Q1O8KGr+LlZ8Pjmd1I6K7rEk7NvyIgg7JfgZbzAcnMiKq/cP2ElDvkswPFKpbb2BrvhcI=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN7PR12MB2740.namprd12.prod.outlook.com (2603:10b6:408:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 18:28:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 18:28:17 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Len Brown <lenb@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
 supported
Thread-Topic: [PATCH v2] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
 supported
Thread-Index: AQHYi/NyRLsqYTgMMkq63c0DFEs4Pa1wHWeAgAAEmGA=
Date:   Tue, 5 Jul 2022 18:28:17 +0000
Message-ID: <MN0PR12MB6101C15F6616EC0C6D37F43DE2819@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220629200433.6103-1-mario.limonciello@amd.com>
 <CAJZ5v0jtgWk6qDQFJQrzRJ9+H2eO+X9KgGFo+UTDmqGQcOgJXQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jtgWk6qDQFJQrzRJ9+H2eO+X9KgGFo+UTDmqGQcOgJXQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-05T18:28:09Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c14fc1eb-5b97-4a93-8aae-6fc71a8cc979;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-05T18:28:16Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 823064be-125e-470c-9c0a-f97eaeaa08f2
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf6f7c9e-6763-497d-4b63-08da5eb421a7
x-ms-traffictypediagnostic: BN7PR12MB2740:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ve0ddhsyvJA+1bsLNXpBaZ/kBwRuZHJL7W071uuR11dZlOASObUJP2eP+uqFNoai6KoSntKBn5pqtWBmTCm4q5aJEW8hFT+iKYvTmyd09b/0bB5EnwN2vW7QWCAbfGHQUp2c2KewxC+Ks/U6YETfaYCykfXJDC/TwEFDKOz2u4wx1/dUYkmuLUXiir+zWcX/feTz3rbQH2F2oz0AWnk2TMibzJTytdbqDUHtGPNEXL3Ul0m4sq4nuECt7zBbqWGJ9L11IDrjQ3WMxYxD6O44r7c5VSwj5OlV1xIKMrFZO8pfsQSFAmchSTp+ToS9muDFb+ZoDvvQ8+qjtRIKdpuL0Ap6jTpnG4xBnB3ebW2rS04G/0pkBvB/GYXuQSYHOwDBl47WJBmZnsJqdbFBomzS0HfXzmywdBlbI1538qxvRmpkRz5F6kW8IREzedkoWZzEG/wqDGJPCspTAn680L8VTLx6sRHhJKKMktlSuWPuQh5BgNKZQHxNSczIDv3s+s27AaljiLSbUHRyMsQUMSZdSht00is6OFwSU6pUhEntz97lOUYKYKhFCww0J3qB/Ssf3yNQ4D4NcAB7iC9xqexjdDs9cS0TzUpLJfvJfAuh91UBcDUHmoz49EqsoPAwGQYfwgs/H6zgGHD7ivXYagkaWo+rmW/MvHFpBp3UTwckAR4uuhGWqy2cZ2n002SblVIPARk9bhV9aEsqnBMwgtvJIJKxdAJB4eifvpEENEkXw3KdhWa/krXOACpNXMS1EgIGY93KoKgEOmmpDgIzLXP942PdMIZYOLv6jRE5mzIFOeVCMrkOUCs+Byt35/SA8hJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(186003)(54906003)(55016003)(6916009)(76116006)(66446008)(66946007)(4326008)(8676002)(64756008)(66476007)(66556008)(9686003)(53546011)(83380400001)(26005)(7696005)(6506007)(478600001)(33656002)(86362001)(71200400001)(38100700002)(52536014)(38070700005)(41300700001)(2906002)(8936002)(316002)(5660300002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmlTYW10SzNZQ2YxUVNyb1lnV1N3ODFZalFVOXg3bEdOdXNCaFFkK1Ixb3lu?=
 =?utf-8?B?STBuK1JEL2U0NVRWM0F0dVY2OEV0WG9oMmx2RHl4aHFsQWU0VUpRTDlrL01H?=
 =?utf-8?B?RFRRN2M3YmNSckkrWDE4MVRzWUY2RXVYOFZjQzV5Vlp6KzBmUlV3MUJqckd0?=
 =?utf-8?B?c0ZEYzROc3NGL01xSXhJQi9tNDFFZEltdEhFbkkzeEJEZnpEYU5zdHhlL0dG?=
 =?utf-8?B?TGtpTmZQeXVpbmpxMk85eWs0YnJyM1B6MFNFNXUwK0ZReU5xRHZhNUt0UDRR?=
 =?utf-8?B?Znhxa3RMYVBkamZRb2dSMkhGUDRjK3lpRTFkYm51QWRwOUk4THJvL21vTnQy?=
 =?utf-8?B?L2RNNXVSLzVYcXV6VzdYVm9YMTJjdzBRaUNaVjkrQ0t4T3RVVVAveU42aDZ4?=
 =?utf-8?B?RXVLUndvcnpGcTNmZmg5aEJDV3VWYkdubUpycHRSUTBuN0dOSmJLTGRHYkRJ?=
 =?utf-8?B?NWw2eVJjWm5kdDJIT1JCVDVHZXN1V3g5Qk54YlV4ajVHTEYyQXlrbStIZ0c0?=
 =?utf-8?B?akNrbC9RdUt4aG05QTVaQ0dhK3hZMlJCcVdqOHdvaGZLT0FESm11ZGwvR3dn?=
 =?utf-8?B?RDI1emdpcllPemxobWp2bmwrM2ZjSkxVKzErNVFYdk9YRHZrcEFTWmFIbkZa?=
 =?utf-8?B?QzRTZjVYOEt6MW5KU0J5Z2dXdU1hVU84em1FQ0FhWmdySDN1SkhiZEQ0VWRT?=
 =?utf-8?B?blZqVndQdW1DODZtMktjVUtnRlFvSGJCenQ2K0VxdjUvejV6eWZBK1FZZXlF?=
 =?utf-8?B?LzZZUWxKRFRwc1BMLzg2SWszeEVEZWVoSkNDQVpDS0EyYjB4dHpqVjRmZ0VV?=
 =?utf-8?B?TUZCUXUrQW9YRnYySnNFVXBRaHhublJGYzlwb1lReVFtN1JaQi9ncmJTQTZ4?=
 =?utf-8?B?K3VZSHJyL2dSYVFzdlZWZWxRcE1JUUpJN2MvdVI4WlNHNlp0cmdmd0EvdzJW?=
 =?utf-8?B?b0VGaEw3NE1tSXRPZGNyQURHSk5lam9ZYUNTaHlUckkzYmZhS3VYaWNhR2tm?=
 =?utf-8?B?Q0VUZVNiMGxlL0dCSXc1L3lJTGVSRWc2VWlwM3Q2VmlnaGRBZGk5OUVSS3Fo?=
 =?utf-8?B?TUtwOHVtcmxXQlU4OWVYYUpINkVjaGw2QTN1V0tyUGVHYVQ2aGVZZ2ZiSkVW?=
 =?utf-8?B?TXR0eVJSYXJYY2EzZG5aNytwUmlycWtaSkkyRjdURlBPejJDUVhwNEFIYmtm?=
 =?utf-8?B?cGIwc2p5bmNpamNobmd1Mk9VMWRncGNjTTBCQ0drajFQRXBvTU5nM21CRmE3?=
 =?utf-8?B?T2JtUDQ1elh5SGNjUHpTTVpyMjZKaGFHUlNBVEV6NUVnQ0x5b1NlN1VDclZ5?=
 =?utf-8?B?ZXBGdHlaZkZLbVZ4bk5yYkpwa2tleXJwZVFWUUZVbmIxVmpwcUkxc3E0NEJn?=
 =?utf-8?B?eW5mNEVEeXNxdzhPalgzNHJ0SENOa0FLalFKTWpWR0g0MGxobEk3SytoTkxY?=
 =?utf-8?B?NTUwNko1WVVYcHlYa3VPOTF0NERHbHUwUVpHai85V29BYVlHQTA5QTV1VFha?=
 =?utf-8?B?VmlLL2kyV3p2ZWYram9HbTRYTU5aMWdNdmxjY2pmQkk3WHFxa25URDNGV24z?=
 =?utf-8?B?MzZIcGM2NVZSRFRjUDNnRjlSMU5nT2o4TW1laEltR2I4aCtJMDNEVWM5cjEy?=
 =?utf-8?B?UUM1SmFmbHI1T0NjNXE3UWJ4OEFzUWpSR1lJZ1RzUnZmeTNSYkdqQlFtR2ts?=
 =?utf-8?B?ZnpQcnZCSVI2Q01qcWZ2S0QzNUcrd2gwNWZORUZuODBUOTI5RHNJOUtQMDRn?=
 =?utf-8?B?T3A3MjdmcFF5ejlCczJhVVJBUGdvWExVZ01SZlYvcFZrWTIxVDJnTktDY0lJ?=
 =?utf-8?B?ZzBvUFpPZkVkdnBwMWFNREU3bHptZGluWTR6c2RQSG1VcWNWRU11djl4ZU5u?=
 =?utf-8?B?RHdsY3VLcW0zWVFRNFVvNksyazVnR2ZLRXJCZDZabHMraGVDRjlPRWM2SW9T?=
 =?utf-8?B?Q25DanpVcEdWelhtR04vNTRjOWE2TUpJVTBiTmR3Zm5DNUw0SzNWZGs1Z0dT?=
 =?utf-8?B?SFR1VDhLT05qUWVSWHMzeEQvdjliRDJVV3RCUmplYU9weFYrbjJuMEd6dWJo?=
 =?utf-8?B?bitsR3RTTW1ISjJHb3VSVnoyaW9IRGdPaFZsUjJ4L09qQktXTkFCMGU1dGJO?=
 =?utf-8?Q?rsQc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6f7c9e-6763-497d-4b63-08da5eb421a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 18:28:17.7771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ulU39fQORo57n0e+1MKlOpQtuQbBmnXoKQBfeMS7NtuWODRZDYXChQ5d2hMrmi3CDrTirnJi0ZSSVDw9or8j4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2740
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFm
YWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5
IDUsIDIwMjIgMTM6MTINCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVs
bG9AYW1kLmNvbT4NCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47
IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsNCj4gU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9s
bGFAYXJtLmNvbT47IFBpZXJyZSBHb25kb2lzDQo+IDxwaWVycmUuZ29uZG9pc0Bhcm0uY29tPjsg
WXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IEFDUEkNCj4gRGV2ZWwgTWFsaW5nIExp
c3QgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlz
dA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2Ml0gQUNQSTogQ1BQQzogRG9uJ3QgcmVxdWlyZSBfT1NDIGlmDQo+IFg4Nl9GRUFUVVJFX0NQ
UEMgaXMgc3VwcG9ydGVkDQo+IA0KPiBPbiBXZWQsIEp1biAyOSwgMjAyMiBhdCAxMDowNCBQTSBN
YXJpbyBMaW1vbmNpZWxsbw0KPiA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiBjb21taXQgNzJmMmVjYjdlY2U3ICgiQUNQSTogYnVzOiBTZXQgQ1BQQyBfT1NDIGJp
dHMgZm9yIGFsbCBhbmQNCj4gPiB3aGVuIENQUENfTElCIGlzIHN1cHBvcnRlZCIpIGFkZGVkIHN1
cHBvcnQgZm9yIGNsYWltaW5nIHRvDQo+ID4gc3VwcG9ydCBDUFBDIGluIF9PU0Mgb24gbm9uLUlu
dGVsIHBsYXRmb3Jtcy4NCj4gPg0KPiA+IFRoaXMgdW5mb3J0dW5hdGVseSBjYXVzZWQgYSByZWdy
ZXNzaW9uIG9uIGEgdmFydGlldHkgb2YgQU1EDQo+ID4gcGxhdGZvcm1zIGluIHRoZSBmaWVsZCBi
ZWNhdXNlIGEgbnVtYmVyIG9mIEFNRCBwbGF0Zm9ybXMgZG9uJ3Qgc2V0DQo+ID4gdGhlIGBfT1ND
YCBiaXQgNSBvciA2IHRvIGluZGljYXRlIENQUEMgb3IgQ1BQQyB2MiBzdXBwb3J0Lg0KPiA+DQo+
ID4gQXMgdGhlc2UgQU1EIHBsYXRmb3JtcyBhbHJlYWR5IGNsYWltIENQUEMgc3VwcG9ydCB2aWEg
YSBkZWRpY2F0ZWQNCj4gPiBNU1IgZnJvbSBgWDg2X0ZFQVRVUkVfQ1BQQ2AsIHVzZSB0aGF0IHRv
IGVuYWJsZSB0aGlzIGZlYXR1cmUgcmF0aGVyDQo+ID4gdGhhbiByZXF1aXJpbmcgdGhlIGBfT1ND
YCBvbiBwbGF0Zm9ybXMgd2l0aCBhIGRlZGljYXRlZCBNU1IuDQo+ID4NCj4gPiBJZiB0aGVyZSBp
cyBhZGRpdGlvbmFsIGJyZWFrYWdlIG9uIHRoZSBzaGFyZWQgbWVtb3J5IGRlc2lnbnMgYWxzbw0K
PiA+IG1pc3NpbmcgdGhpcyBfT1NDLCBhZGRpdGlvbmFsIGZvbGxvdyB1cCBjaGFuZ2VzIG1heSBi
ZSBuZWVkZWQuDQo+ID4NCj4gPiBGaXhlczogNzJmMmVjYjdlY2U3ICgiU2V0IENQUEMgX09TQyBi
aXRzIGZvciBhbGwgYW5kIHdoZW4gQ1BQQ19MSUIgaXMNCj4gc3VwcG9ydGVkIikNCj4gPiBSZXBv
cnRlZC1ieTogUGVycnkgWXVhbiA8cGVycnkueXVhbkBhbWQuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiANCj4g
SSdtIHN0aWxsIGNvbmNlcm5lZCBhYm91dCB0aGUgcG9zc2libGUgY2FzZXMgaW4gd2hpY2ggdGhl
cmUgaXMgX0NQQywNCj4gYnV0IGl0IHJldHVybnMgZ2FyYmFnZSwgYmVjYXVzZSB0aGUgZmlybXdh
cmUgdGhpbmtzIHRoYXQgdGhlIE9TIHdpbGwNCj4gbm90IHVzZSBfQ1BDIGR1ZSB0byB0aGUgX09T
QyBoYW5kc2hha2UuDQo+IA0KPiA+IC0tLQ0KPiA+IHYxLT52MjoNCj4gPiAgKiBNYWtlIHRoZSBj
b2RlIGVhc2llciB0byBmb2xsb3cgKHN1Z2dlc3RlZCBieSBSYWZhZWwpDQo+ID4gICogVXBkYXRl
IGNvbW1pdCBtZXNzYWdlIHRvIHJlZmxlY3QgdGhpcyBpcyBvbmx5IGZpeGluZyB0aGUgTVNSIGNh
c2UNCj4gPiAgICBhbmQgdGhhdCBhbnkgb3RoZXIgYnJlYWthZ2UgZnJvbSA3MmYyZWNiN2VjZTcg
d2lsbCBuZWVkIGFkZGl0aW9uYWwNCj4gPiAgICBmb2xsb3cgdXBzDQo+ID4gIGRyaXZlcnMvYWNw
aS9jcHBjX2FjcGkuYyB8IDEzICsrKysrKysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2FjcGkvY3BwY19hY3BpLmMgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMNCj4gPiBpbmRl
eCA5MDM1MjhmN2UxODcuLmNjMTU0NTE5YzYwOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Fj
cGkvY3BwY19hY3BpLmMNCj4gPiArKysgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMNCj4gPiBA
QCAtNjI5LDcgKzYyOSwxNSBAQCBzdGF0aWMgYm9vbCBpc19jcHBjX3N1cHBvcnRlZChpbnQgcmV2
aXNpb24sIGludA0KPiBudW1fZW50KQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7
DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAtICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICsgICAg
ICAgaWYgKCFvc2Nfc2JfY3BwY19ub3Rfc3VwcG9ydGVkKQ0KPiA+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gdHJ1ZTsNCj4gPiArDQo+ID4gKyAgICAgICBwcl9kZWJ1ZygiRmlybXdhcmUgbWlzc2lu
ZyBfT1NDIHN1cHBvcnRcbiIpOw0KPiA+ICsjaWZkZWYgQ09ORklHX1g4Ng0KPiA+ICsgICAgICAg
cmV0dXJuIGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9DUFBDKTsNCj4gDQo+IFNvIGNhbiB5b3Ug
cGxlYXNlIGFkZCBhbiBhZGRpdGlvbmFsIFg4Nl9WRU5ET1JfQU1EIGNoZWNrIHRvIHRoZSBhYm92
ZT8NCg0KVmVyeSB3ZWxsLCBJJ2xsIHNlbmQgb3V0IHY0IHNob3J0bHkgd2l0aCB0aGF0IG1vZGlm
aWNhdGlvbi4NCg0KPiANCj4gPiArI2Vsc2UNCj4gPiArICAgICAgIHJldHVybiBmYWxzZTsNCj4g
PiArI2VuZGlmDQo+ID4gIH0NCj4gPg0KPiA+ICAvKg0KPiA+IEBAIC02ODQsOSArNjkyLDYgQEAg
aW50IGFjcGlfY3BwY19wcm9jZXNzb3JfcHJvYmUoc3RydWN0DQo+IGFjcGlfcHJvY2Vzc29yICpw
cikNCj4gPiAgICAgICAgIGFjcGlfc3RhdHVzIHN0YXR1czsNCj4gPiAgICAgICAgIGludCByZXQg
PSAtRU5PREFUQTsNCj4gPg0KPiA+IC0gICAgICAgaWYgKG9zY19zYl9jcHBjX25vdF9zdXBwb3J0
ZWQpDQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPiA+IC0NCj4gPiAgICAg
ICAgIC8qIFBhcnNlIHRoZSBBQ1BJIF9DUEMgdGFibGUgZm9yIHRoaXMgQ1BVLiAqLw0KPiA+ICAg
ICAgICAgc3RhdHVzID0gYWNwaV9ldmFsdWF0ZV9vYmplY3RfdHlwZWQoaGFuZGxlLCAiX0NQQyIs
IE5VTEwsICZvdXRwdXQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgQUNQSV9UWVBFX1BB
Q0tBR0UpOw0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCg==
