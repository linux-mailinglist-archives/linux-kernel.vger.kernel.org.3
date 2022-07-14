Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8594857560E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 21:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbiGNT7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 15:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiGNT71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:59:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5BD1EC5B;
        Thu, 14 Jul 2022 12:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2T1TinteRkQLXvM1SNgyJEO57htI7M0QxqLT2CtRPmVD5aNjfWU2M7TynU8MMzGSNVNDkx/uXEQi3Oc3RfV9sddUllAW36qJmC/wTO3SDZJEWvPP/RpqqteuPqpsxivmqyPNcHva2CzFfNdNn32edWUgNF5aW7TDLMW1Igh/u8H5T8K2QfCLdhccDMPqN9bu+wc0WkaLvXQG4TF+GV5L0tMqmJ8rb0kRols+gJHq9F1JBGbNBDNntprjk6wJK1s4ckx+cE+yNEFaPKjqTnJtOciZKRZVDKrL1BBA/70X5cSTxiRHFFupKZ2GkH8JH6RXwrxC2iBXwGMa0dQAheaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JgHyZGSRj/bsKn7hyiIjy+JOMMCVeDW4tsalMhn59Y=;
 b=PAKehSC2jnn5ADvXr8igP0HbbccQX66UKeUjctaep+D9poSTWe9Po99CoFapwNnuJqjso045HONNRmfN/FzFC38cQRySC5pxfA3RBdnHgkJ+AJJdHab8vYTIDAPSTBQ0SznYMOJGZjZN+siKk8yHWV6QtXiT9SOPKIdecC4ZHnxhr7l+82rOO3E89cegAf0G6qOHAwebm1XB+/dLsMmFnft7IvCSNlb6fDJI41xXKl7LNoMeuAOLTFQ5JnHVGPRizpbZRvLE+lhaEDzcy/2bOm947uB3M8opbcrkvACFCR7RPoNJoqz3C00YeL+3cmRHeRuahFELMUG8EpZcwdjk9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JgHyZGSRj/bsKn7hyiIjy+JOMMCVeDW4tsalMhn59Y=;
 b=V5lrDDV+won6ftt/p6PRgYXmGfC23c1+4mg04+Mu+BQVmUq9d+prswzfxSQwk38cVHJzy+HRpR0X/FSrIJoZAElOeKH/+ocH3G7DGnsfHnrroCibOI6FLmqzwYWT+WyyL0aFwpaDCKuE3LKBrSgDLXieAd5WuNze6TKVnZxzdOQ=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB5564.namprd12.prod.outlook.com (2603:10b6:610:65::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Thu, 14 Jul
 2022 19:59:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 19:59:25 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6] ACPI: skip IRQ override on AMD Zen platforms
Thread-Topic: [PATCH v6] ACPI: skip IRQ override on AMD Zen platforms
Thread-Index: AQHYlZNQUBz3L+ebLkW/6W0BroV+ra1+NeGAgAAW3aA=
Date:   Thu, 14 Jul 2022 19:59:24 +0000
Message-ID: <MN0PR12MB6101B53D92737C8021E7ECB8E2889@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220712020058.90374-1-gch981213@gmail.com>
 <CAJZ5v0jjyvWniC8ReZqAgnaoaRm4cr_Vs3pXhddKf9B6+zONLw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jjyvWniC8ReZqAgnaoaRm4cr_Vs3pXhddKf9B6+zONLw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-14T19:58:55Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8c768e20-9576-485c-aef3-cd4101b2de93;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-14T19:59:23Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: d679a2e3-3080-42ce-92da-1df4e8e43524
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 303dcb10-f7cc-42da-f30c-08da65d35a14
x-ms-traffictypediagnostic: CH2PR12MB5564:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Ao1TcCIZl+htSbQBbBRS0md+oM0fkK2j8QKzjXpcV7p4e8mZnM3IXtv41fcdl9wWn33nU3pJE0/ah5eWKWVQOXOo/uBE1FLSqhxYBXrW/TjC5eatX9dFiqxRtGQfXUUnenezC7H+ZVNnhmZ4cpxZHRpTo8Cz8jHmaNbfgvckIfEqwulemn3RbGwqsD64ofgZiSthHGUVyuKZLgP4UOjy0W/yWAcSW627tYfPxjWU7K4RkC8/OKyIp4B9OtASDRDMtUUytwH2XW/EOi8Aj4Q0vrti51lA/qiUyaJBIcunf841ynKf21OQUqWIP3gfpeYx2n0tjfIeEwz10cy0yeJjJLisYW4JehL92J+RlnTM/7zcXgjCMlns+Wp7tmU/4C7OZ+LwLZL4Lyv2BzDyePkep+o+zw+6r9oLhQNE1qqGjQSUISHyHtEJ19aZvRt8aW62GfgpQ57DfVxsEbDx0xLx5jY/DSara9Cf8Fku5AJMVQopGa/CRc0RJvSvsz3tTf9B6Og0DOl9iIo3MxCMxv481lIFuMnZS69/01eYU4UCR/8d58ysE9X1KkEGNM3EV8lZlULKk3a4ww6F1JHnzo4Nw9lheUhk9JzIrGp0Z3xuGx3rCeSkEgnGTE+llWGOFirZscrSVjCCn0Q5qDYt5nj7922V0J7X/Cwa/H1hPzZJpGxRz4IMWi36YW9AZ64NCKtcba/QZnlSV/1VH+4MVXUKJxX9+Uq8vBybClhnNM/p4jqZJPmSismvcutitaoMoVhTikmdCD0QwJffybXewWKrb4jQnXGELQpQzSG9KlRw3jnR5HzudQvTq6+KQGiQDXX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(54906003)(316002)(55016003)(5660300002)(6506007)(7696005)(53546011)(8936002)(186003)(9686003)(52536014)(38100700002)(38070700005)(2906002)(41300700001)(110136005)(33656002)(478600001)(83380400001)(8676002)(66556008)(122000001)(66476007)(86362001)(64756008)(4326008)(71200400001)(66946007)(66446008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk9PdFdyU0tMWHV6Y1czK0plcFpkbXZjT2FhVitMVkNvRTRuWk9FdWQvSGd3?=
 =?utf-8?B?K1IzY2ttdkhLUjdUUGplcUh0c0srQmhRUHpqbUpqZThwUFdYdkFoRjljTmUz?=
 =?utf-8?B?UElRUnY0UGgwMXJHZ1hNQk5EZHJkbmFsL2gwc0xvc2VLeU5ucjFuTmhxSkdE?=
 =?utf-8?B?QnZ1bzZVblpxZDMxS2hiL01ueXRMODA3amFGTG1PcG1URTFaSnR3VTZzTTIw?=
 =?utf-8?B?aGdwT2VVNGVjbWw4WjU2azc3bzl4UmFHOTFVcXNhd3pueE1LY05FdTdiUk5J?=
 =?utf-8?B?MXBWRjhoc0dPNjZXSjU2RWM3V3E2RllNcTN3R0VXZjhpS2NKdjFDQkxVRnd5?=
 =?utf-8?B?ejhxL3ROcEZJaWpTNWZYalhYTFJORUNqRjU2aFVnVFl2enpZWnFHa0lhcGhY?=
 =?utf-8?B?ZGVaN3VrQ3dKTzNEMWZlWHFkUGRERUp0S1lWbzNHd3Z2L3YyVkVSNGY1TFh4?=
 =?utf-8?B?cHhEQ3MzR1pMaVVmNlF5RzBvLy9ETnZXOTNTbGtmNlM0QjkybnNmWElPWjIy?=
 =?utf-8?B?cHUyekpGRjFTWHhKQW5ySEVnZzBaU0Y0V1V0d3MwSUQvaUJ2aUtjSXh0dWRN?=
 =?utf-8?B?TkEwdXZLUm43eFk5Rk5pdHBpZmlPT3l0T3ZSdG96KzZpaTJOdEVSRm8reUZq?=
 =?utf-8?B?RE50SHlkRzRxZVJKUXZ4REJrZ3FZM3pjMDdicjloVlhrRDBjajg1U3d3OFFP?=
 =?utf-8?B?MlBVblRXeFc1WEE1T3pSYklSRnM0Ly82Qmh5VE5YbVJFZ0c1MWQ5bkpFV0ox?=
 =?utf-8?B?SVQxUmpqUUI5bWlEYmorcUpPcEpvWXpwWjN4V1RUQjBpSXZYK0l6Z285dUpO?=
 =?utf-8?B?eHE4cG1SRnlQVjJ6dDV0VHVTYlYxemZic0dnM1FYTGhUQ1hxUFBGcWdEYUhq?=
 =?utf-8?B?ZjlGOXR6MEQ2T3VlaUpoOFV2a0M4bzY3VzJlbE8rVXVjNnp6anZXK2w0Umxt?=
 =?utf-8?B?WlZDY0NxL0F0TkFQeGxESGM3Z1VjdGlycXk4am02d0tuSU5Kdjk3L3ZCbUNr?=
 =?utf-8?B?b3RKRk56RjdCdEI3eEwyVU9PQ25qdkgrS2kyM0htaFhLMzNUejloNllVYjVt?=
 =?utf-8?B?Z0s5bzlKc0txMmhuZSsvcXJxVGdDWFhaMlJiaWxSRHEzR1JzRTB2Z2tPck5D?=
 =?utf-8?B?ZzRYNGQrMnE2eVNlSHFENU1uZ3hOb1drblpCM3U5djZNNi9wb1drVVhhdTAv?=
 =?utf-8?B?ODN1TENvbmNyeGErc1ZCOTZhUEJuL0haU2dLcXlYMUxsc0tLSU5mQTJEdCtW?=
 =?utf-8?B?ekQxbm84azBhcXF5dEExTHJneWk1cUd5WDlydGtuMkF1UUlZM045UFFSejJw?=
 =?utf-8?B?d0dqRDE4SFd0eStLemhoenhHNTJWREZ0UHF6a2plcVZFMExsVVY3dFkyMVVN?=
 =?utf-8?B?ZzBJZHN6OTFoYnlVeHVUSjYzN3M2eDBWaHJCYk9od2RiNk1iYldKWDV6YkRL?=
 =?utf-8?B?cnRxNkxCaTN2M2lnR09pUTZmc3o2Z1NlMDJLdmNaZk81aHYxMHVOYWg2Vzc2?=
 =?utf-8?B?STRHeEk3bndNNkNBRVM5UzZzT1R4TjhhbDRzTUloVXpNZGk0b2NFU2d5UzlU?=
 =?utf-8?B?RXFZOG5ZMHYxMU9keVowS1JmTUNnL01LSGRmQzVvYWxtejFQTWVFVEtQNWFr?=
 =?utf-8?B?V3FEMkoyKzVDbkIzNUtwWDJYL1Rtenowd2hETGJScXNnWGVzNXFYNnVsWmRZ?=
 =?utf-8?B?MStOc0dOTllubStINzlKS1BFV0NQZ2x4N2hVd2IwZTdVamRRYnRvOWVMR1I2?=
 =?utf-8?B?dHFzeEdmKzhKQWp5TGpVczUvODF6RkhiZzArVE9SaWRWY2pOdVc0N2dhbmRE?=
 =?utf-8?B?dUhjclc5NjBLZFJlNHBvTWkrS1VCR3ZJU255ekNKeG9jRlNLOHpWOTIreWJR?=
 =?utf-8?B?Yit3M0Ntd2gwOTN4MGtpRlg2QU1zYXdnS3A2N3MyL1Y0Tk1JaTlmc0ZVQ0Jm?=
 =?utf-8?B?cXVlZHlUUE04Wm9Sb2ZDbnAwYWw0QzBWM1Irb1U3WUFvZFFSdExhd1Blbi9k?=
 =?utf-8?B?Y3pDNXNKK0pzM3FqV2U1d2E3ZTd6RnVqV0NIM1RpcXR4eGNVUW14NHBsSVZr?=
 =?utf-8?B?WXFzc0Fndk43c1V4Q2NwYUVUUjZOSzdQOXBLRjBBZVBhUEhybGI3NC9CZmJQ?=
 =?utf-8?B?UXpLcm8wLy9Wb0Fad2h6eCt4azQ2QlFrb1JpWEhrZ2pkM2k4Y1ZzSzVWQTFY?=
 =?utf-8?Q?r1TZZHf/gMbIVysJ9cndikY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303dcb10-f7cc-42da-f30c-08da65d35a14
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 19:59:24.9861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifvhC7M5IugDo305XU1L2JAUp4n/8L5yA7U5AdIdcmbf3+ym9XXmjRrNX2wqbW9loIsGJrkgjKaFJ0ZBHUHK0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5564
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
YWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSnVs
eSAxNCwgMjAyMiAxMzozNg0KPiBUbzogQ2h1YW5ob25nIEd1byA8Z2NoOTgxMjEzQGdtYWlsLmNv
bT4NCj4gQ2M6IEFDUEkgRGV2ZWwgTWFsaW5nIExpc3QgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwu
b3JnPjsgVGlnaGUgRG9ubmVsbHkNCj4gPHRpZ2hlLmRvbm5lbGx5QHByb3Rvbm1haWwuY29tPjsg
TGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgUmFmYWVs
IEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgTGVuDQo+IEJyb3duIDxsZW5iQGtlcm5l
bC5vcmc+OyBvcGVuIGxpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjZdIEFDUEk6IHNraXAgSVJRIG92ZXJyaWRlIG9uIEFNRCBaZW4gcGxh
dGZvcm1zDQo+IA0KPiBPbiBUdWUsIEp1bCAxMiwgMjAyMiBhdCA0OjAxIEFNIENodWFuaG9uZyBH
dW8gPGdjaDk4MTIxM0BnbWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSVJRIG92ZXJyaWRl
IGlzbid0IG5lZWRlZCBvbiBtb2Rlcm4gQU1EIFplbiBzeXN0ZW1zLg0KPiA+IFRoZXJlJ3MgYW4g
YWN0aXZlIGxvdyBrZXlib2FyZCBJUlEgb24gQU1EIFJ5emVuIDYwMDAgYW5kIGl0IHdpbGwgc3Rh
eQ0KPiA+IHRoaXMgd2F5IG9uIG5ld2VyIHBsYXRmb3Jtcy4gVGhpcyBJUlEgb3ZlcnJpZGUgYnJl
YWtzIGtleWJvYXJkcyBmb3INCj4gPiBhbG1vc3QgYWxsIFJ5emVuIDYwMDAgbGFwdG9wcyBjdXJy
ZW50bHkgb24gdGhlIG1hcmtldC4NCj4gPg0KPiA+IFNraXAgdGhpcyBJUlEgb3ZlcnJpZGUgZm9y
IGFsbCBBTUQgWmVuIHBsYXRmb3JtcyBiZWNhdXNlIHRoaXMgSVJRDQo+ID4gb3ZlcnJpZGUgaXMg
c3VwcG9zZWQgdG8gYmUgYSB3b3JrYXJvdW5kIGZvciBidWdneSBBQ1BJIERTRFQgYW5kIHdlIGNh
bid0DQo+ID4gaGF2ZSBhIGxvbmcgbGlzdCBvZiBhbGwgZnV0dXJlIEFNRCBDUFVzL0xhcHRvcHMg
aW4gdGhlIGtlcm5lbCBjb2RlLg0KPiA+IElmIGEgZGV2aWNlIHdpdGggYnVnZ3kgQUNQSSBEU0RU
IHNob3dzIHVwLCBhIHNlcGFyYXRlZCBsaXN0IGNvbnRhaW5pbmcNCj4gPiBqdXN0IHRoZW0gc2hv
dWxkIGJlIGNyZWF0ZWQuDQo+ID4NCj4gPiBTdWdnZXN0ZWQtYnk6IE1hcmlvIExpbW9uY2llbGxv
IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENodWFuaG9u
ZyBHdW8gPGdjaDk4MTIxM0BnbWFpbC5jb20+DQo+IA0KPiBJIG5lZWQgYW4gQUNLIGZyb20gTWFy
aW8gaGVyZS4NCg0KSSBiZWxpZXZlIHRoaXMgaXMgZmluZSwgYnV0IGdpdmUgbWUgYSBmZXcgZGF5
cyB0byBjaGVjayB3aXRoIG90aGVycy4NClRoaXMgaXNuJ3QgNS4xOSBtYXRlcmlhbCwgYW5kIHNv
IEkgdGhpbmsgYW4gYWNrIG5leHQgd2VlayBzaG91bGQgYmUgZmluZSBmb3IgaXQuDQoNCj4gDQo+
ID4gLS0tDQo+ID4gQ2hhbmdlIHNpY2UgdjU6IHJld29ya2VkDQo+ID4NCj4gPiAgZHJpdmVycy9h
Y3BpL3Jlc291cmNlLmMgfCAxMCArKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3Jlc291cmNl
LmMgYi9kcml2ZXJzL2FjcGkvcmVzb3VyY2UuYw0KPiA+IGluZGV4IGMyZDQ5NDc4NDQyNS4uNTEw
Y2RlYzM3NWM0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9yZXNvdXJjZS5jDQo+ID4g
KysrIGIvZHJpdmVycy9hY3BpL3Jlc291cmNlLmMNCj4gPiBAQCAtNDE2LDYgKzQxNiwxNiBAQCBz
dGF0aWMgYm9vbCBhY3BpX2Rldl9pcnFfb3ZlcnJpZGUodTMyIGdzaSwgdTgNCj4gdHJpZ2dlcmlu
ZywgdTggcG9sYXJpdHksDQo+ID4gIHsNCj4gPiAgICAgICAgIGludCBpOw0KPiA+DQo+ID4gKyNp
ZmRlZiBDT05GSUdfWDg2DQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAgICogSVJRIG92ZXJy
aWRlIGlzbid0IG5lZWRlZCBvbiBtb2Rlcm4gQU1EIFplbiBzeXN0ZW1zIGFuZA0KPiA+ICsgICAg
ICAgICogdGhpcyBvdmVycmlkZSBicmVha3MgYWN0aXZlIGxvdyBJUlFzIG9uIEFNRCBSeXplbiA2
MDAwIGFuZA0KPiA+ICsgICAgICAgICogbmV3ZXIgc3lzdGVtcy4gU2tpcCBpdC4NCj4gPiArICAg
ICAgICAqLw0KPiA+ICsgICAgICAgaWYgKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9aRU4pKQ0K
PiA+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4g
PiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHNraXBfb3ZlcnJpZGVfdGFibGUp
OyBpKyspIHsNCj4gPiAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IGlycV9vdmVycmlkZV9j
bXAgKmVudHJ5ID0gJnNraXBfb3ZlcnJpZGVfdGFibGVbaV07DQo+ID4NCj4gPiAtLQ0KPiA+IDIu
MzYuMQ0KPiA+DQo=
