Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7576C5A288A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344340AbiHZN3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344343AbiHZN3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:29:21 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C3D9D69;
        Fri, 26 Aug 2022 06:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdqqTI4X9P/5DiEm94ASbnSCjIvBA6/2Xr1yrUfGWXSg0hKjwjONpuLz+YH2tMUnB03Rat67TRJTK15QRyHbc6Hlm8r0Hd/xVmTTQFgwjKsAedeuPxCN1Iqy4cRQzQ5SlYAhZLLAHDQm8eqdJ113LeHuurqgCRex6Iy1SXr2a2BYdXGfiinaufmVEpKKz8ZasIoOU402mu9l30xaHe5ABfEjAJZt+StKr0NrpbbfOCAAY9G8WH6BBz4mX3Mi2OorsxbQpYmRN6oKyhVfLhlgzjrQiz1GsSoDKzIZMnjW5kT7xe/ecr3/DoAmqFvl1onqlZO4GN0A34g1Zi0FpKx4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/Re0ir0ubCQjjPVpqhLy26R/b0EAy4hzv54MiZqV5A=;
 b=jwfVeG3RQSKQDfS2xPacrrT7PhhxS1GIGDOkChSR+7SuQ7Fz0dh33ZYazW5yuQBPuA8hl9Nux5UNHGC6XidZMGrQr6AAkJH5u0wuqdquUKVTBsrcfKrm3Qdz0/RgYfXdgDgHdnXAOthnHpuWR86nxBSbFTLqiRjx0nz/0NcNofk7aX4EB43f+i2vfo41BbUo1dYFgLoK2zfi9HUY59ps7V75hGIElWmcM8Ypn70+ckgAlBEx/1zypMJL8FaFjdmiZsiQDBz1IqZTKhgje4/uT0qjyqkqXDgC9jkZEU3UJcCsLqDesWgkCl50HOGE3uWB8OkztB2uQlb2ijWQ3RkucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/Re0ir0ubCQjjPVpqhLy26R/b0EAy4hzv54MiZqV5A=;
 b=vTnUW0f35mMS7747s3tOlYLTbmJ01OaySEteFKkSbtNjv5uC4lTY65Py2J1/r0ERZAUkkPevgNgx3hTANJrnk60awJkdIUM2PdA2LjEmVAfZVC0XWVY434KHQUQXismxFOEE2vccD2V+wdJ9DCBaN50q7to5F+DSzjJ53yaCY98=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY4PR12MB1447.namprd12.prod.outlook.com (2603:10b6:910:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 13:29:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%5]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 13:29:15 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        David Laight <David.Laight@aculab.com>
CC:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Kent Gibson <warthog618@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pinctrl: amd: Pick some different unicode symbols
Thread-Topic: [PATCH] pinctrl: amd: Pick some different unicode symbols
Thread-Index: AQHYt0UkQltatHPOeUijOEPCg1iOqa2+EsOAgAMdLYCAAAB5oA==
Date:   Fri, 26 Aug 2022 13:29:15 +0000
Message-ID: <MN0PR12MB6101CCB2687924298CEDBD99E2759@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220823230753.14799-1-mario.limonciello@amd.com>
 <6ffb775a97384ff59676d9c4337481f0@AcuMS.aculab.com>
 <CACRpkdZoX806ZbhHWptX6b3D-7p0Hsa6HXW5XsSj1Y2WFR3K7g@mail.gmail.com>
In-Reply-To: <CACRpkdZoX806ZbhHWptX6b3D-7p0Hsa6HXW5XsSj1Y2WFR3K7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-26T13:29:13Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6e0880a5-403e-44fa-b4f1-5a45c467baa7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-08-26T13:29:14Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: ab5b9ab0-851e-4dfc-af42-c51b328fa41b
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 674e808f-4dcf-4b10-e1bd-08da8766f8ce
x-ms-traffictypediagnostic: CY4PR12MB1447:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8sROqLKyo+cdU9jqEZq9ym06XeFKvsqFoPMX1pbBA7DDqLdYGU0f/Y+dYRMw22GoTRSPTSfa51C1160rabMna3HsAU+FTyYZpRYEEtsSgCNoNxC9Qbn8akPPmslzCTiZJiCQFGhzqa3YxNO4wg47hENdneDo1MLlSqRA4+8zzz3gkh8uFmwRvKFR3uvA/2rt5IyksEYYAKYJjhblGE+UGAJ5uMXe48pU0OK5H2mvOihVtfzKBOCHauC9xOIYunj/etYqgBsqDjcNLeETn8QEVKFtjUQEa8r4wedMPIdDX4Mnh83i7sLHNlzLmwgzm/xqUwFn5dbp6XYTYvAxTCSEYGGUpvXiP4B7DzqxhxoNuZcUnkUNo0pn89yLW2W+e9S7+yLORqIIt/Z05KZiSPLd7bqftW797kyeFFQR6ij4uprIrdfaXCfMI3ua0TobEvdtOEIu0jtG0+vCyAILNGkYv8cV/LUUZ3/UhsunnsEAB1IRgZK50ew2sE9V/VFeWtbK8jaVJuMErLXxbYoacrCXQ3JwpQWiRtIH6S8KkqPuJqJ6u6rAy+vda+qxzs5ol1OTiaqbArvEirS497FGzElhl1xSqtJP1s5g3A2kcSkoLSWvuPFHiO+gqmsHvktx9uqZZ3qha2pYlMORkjJHwwIQeWOrRjwC88D+/g2+/Iz5R1STy2S5jmW4Bt6LQbgDF1xDHBaFhQzrWo+8J2LukCZJlEcip7nFu/f1x8nwLTen/KUW+OyHInBGkbS9BZZQIn5XSxBKM+oD0JPt98YbMywpWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(52536014)(8936002)(83380400001)(478600001)(38070700005)(2906002)(110136005)(86362001)(33656002)(316002)(5660300002)(186003)(54906003)(4326008)(66946007)(66556008)(8676002)(38100700002)(66476007)(64756008)(76116006)(122000001)(53546011)(66446008)(71200400001)(7696005)(6506007)(55016003)(9686003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MURrb1hVblp4TG9ESTNzOUx6Ty9tdGxJSitZNW9zWnJVaFRCT1g2cnFVeUF5?=
 =?utf-8?B?SEcwbVM3QjNpUlpaRWlWYmlhK3h3VmVQVVF0R0kwU0d1WStOL1N1VDUxTTFO?=
 =?utf-8?B?dDRzbUYwMHV2dkEwVkhXd2RPYkVHNDIwb2JLVGN0MUt4QlRIaHB2UzNMRTd6?=
 =?utf-8?B?dGsxN2JxOG1yQy83ZWJMc2pDOG5GY2lWNHB6U0pUeFJDc3B3UEhEVjdzMmpM?=
 =?utf-8?B?SVJEbTFnUFFWWncxSVE5Y3VKbmJlVmdmcUVqSVNQWTdrZXhEL3ZDVWN0bktr?=
 =?utf-8?B?cnUwNHdSMDBiazJmRzhmUzczN0Vid3R0aHE2MFFMaWFESHYrVGJWTGk0bTFw?=
 =?utf-8?B?YTJiN3liWTlKdEJZdmpxVkgzVlAvbExsbDlqWWpGNjZxanJNWllPeFpDamdh?=
 =?utf-8?B?R2dkNnNRVE1PTGhRRTdWZWcxcGdOaEhrSis2eVFLdXMxUzJxSk1EOUtTYlhU?=
 =?utf-8?B?RDNTclNCcGloYklRMzVRblEvU2s1OXpuWTJxUFppR3JWUFJ0YnpQQ0x3TW1r?=
 =?utf-8?B?SytxUGxHNk42NkJ2ZVZmQ0t0cVdjVlhsNis1TTh3ckpKdEJ4ajYyd3E3UkFu?=
 =?utf-8?B?YXFNdW5DRWNSanhDNlpYKzlSRTJWSjFlVmgreGxOTzFEMTRMYzFEZnVDaFdY?=
 =?utf-8?B?R0xzaHlzS2ZVL2Qwb0pmV0ZTNTdPK2RnbXNVQzVTZzYyZjZ1a29YTjVWcElZ?=
 =?utf-8?B?Qm1YWEhkZVY2SFd1QmhPUFdud01wS2ZKY2s2SE5MQ1p5NEI1MXNjdElORXR1?=
 =?utf-8?B?cmFQVys3UnFQZ1c5Q0xLSm9RUVF6MlBjM0NlMDB4WEU2aTh4b0pRbjdJZE5w?=
 =?utf-8?B?WVlJbGhjU1pvTnYwYkZMSk1uNlVQa1RBbi9DMEhDd1VRYWRNSEhkZkwxYndv?=
 =?utf-8?B?d0VPYUszNXd4ZHBBZmFTdlY2NXlzWE1wWE5uYjNiNGlTYkJ6N2dWaFIzQWtR?=
 =?utf-8?B?NG9ZNkNQdFFqRTZMMlN1OUFVMzcrVVZabVJHdUt2cVFZaDU0M2hKQU5xLzFy?=
 =?utf-8?B?Sk9rUHBDQ29EcnRMY3pRRXNZNFFsZlRoTUhNMlBvRWRxTkl6b0h0TTJJbjNW?=
 =?utf-8?B?YzF6b1BDZWVaQkd2endwRWMyb3RJSnQzZDFkaUpibzl1TlhoRkxUa0g4VUJl?=
 =?utf-8?B?bUZxMTRJTlYvdTE2Y2wybjJTYUFsSkpKTFNwdTVWZEtiWmRHVWdhUm90aWky?=
 =?utf-8?B?UTZGR2NEUElyRXdTOHFEWk0yaGZaYURaWnBBYjlnRGFXYXpNWUU5QmNPYXcy?=
 =?utf-8?B?Ly9ocGNyclVBMFdEY3pDS2o1NWtudkl1VHBzOXRnMCsveE14ckVrM1pxNWRF?=
 =?utf-8?B?WktMWHhCQld5RmRkT2gvVzZ6WnVJM090ek9aOThRTy9QV0h3ODhoQ3A5dGdC?=
 =?utf-8?B?ZmRIcE1uRFFlT1I2Ly9YcmxQUFBsclY2eThtKzVUYVRxZU1oa2tpaEtKaEk1?=
 =?utf-8?B?alZuVzFIaVZseEdCNHE3UnJpMWVqdXc3ZDhsd3RmeXNLNjZtWkhsNlR6OGpZ?=
 =?utf-8?B?TVU0NUY5U1I1QWlCZ3FtT2t0anBZNnprS3BPMzBjNUdaUWRmREtHSHlkZmEz?=
 =?utf-8?B?NHNwRGY1U2E4UkpuMEJ1WEpTM2FzcTN5bVBNZ0tPdENLYjNLL0oweGhkWDJR?=
 =?utf-8?B?ZUwxVjVScEplR3dJdXU2UGtPVStjbGQrQng2WjhaSmpyVDFXUDZjSThLMXlz?=
 =?utf-8?B?UGk5a2FIaG5CcFVWbEJMVkc4SmNKY0R3enFjVFdTRlhzTUlWRzlIYW1rVlo5?=
 =?utf-8?B?a0g4dFZKZ0RPQ3VHcngyUXNkU1dZRGVkTWhDeVFYVERqMnRoQWR0L3gvdFkw?=
 =?utf-8?B?MXRZSS8zRUd3SHBoNW5tZWhid0lGL1FQcFZPSDhWUzM5VnY5ZVI3VFFvM0FS?=
 =?utf-8?B?L0pXVWI5d1dZQmRuazhhVmtZbGJkRkZSMXJMejB3ZmEreXNJcER5M01FU3pO?=
 =?utf-8?B?bWpiTUxTNkE5S05TSklsajRaTklDOTVHd3JVd0toUW9Da3JLcDI3b3pPWE1I?=
 =?utf-8?B?Q2l2LzYrWTVaODdwZXQ0WmJ4c3czdmFmdit0WWxFT2M5MElabkdFOVJhZk1w?=
 =?utf-8?B?eWU3bkh4MzJzRGQ0LzBabDJRL2RRQThVTDRhRUpNckVOOEN4aXg2d3hUODVI?=
 =?utf-8?B?OHdDZE1qcFE2dUJSbk4vaHp5NjNualhrbi9zSVlmdFFYdkV0VURPSFNaQ3Ja?=
 =?utf-8?Q?rXnPIFy3NLyXTwiooUeOSc4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674e808f-4dcf-4b10-e1bd-08da8766f8ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 13:29:15.6443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aikYrzm4kD1xt/TfXJ/DfFaG1Jj5YkggsRIkMWFtrTbO1HADBgERvzDS0MT21Y3R8yVw6i1rx9WKNP68OLDUjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1447
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBX
YWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0
IDI2LCAyMDIyIDA4OjI1DQo+IFRvOiBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBhY3VsYWIu
Y29tPg0KPiBDYzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29t
PjsgTmF0aWthciwgQmFzYXZhcmFqDQo+IDxCYXNhdmFyYWouTmF0aWthckBhbWQuY29tPjsgUy1r
LCBTaHlhbS1zdW5kYXIgPFNoeWFtLXN1bmRhci5TLQ0KPiBrQGFtZC5jb20+OyBLZW50IEdpYnNv
biA8d2FydGhvZzYxOEBnbWFpbC5jb20+OyBsaW51eC0NCj4gZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcGlu
Y3RybDogYW1kOiBQaWNrIHNvbWUgZGlmZmVyZW50IHVuaWNvZGUgc3ltYm9scw0KPiANCj4gT24g
V2VkLCBBdWcgMjQsIDIwMjIgYXQgMzo1MSBQTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBh
Y3VsYWIuY29tPg0KPiB3cm90ZToNCj4gDQo+ID4gSSBob3BlIEknbSBuZXZlciB0aGUgcGVyc29u
IHlvdSB0cmllcyB0byB3cml0ZSBhIHRlc3Qgc2NyaXB0DQo+ID4gdG8gY2hlY2sgdGhlIG91dHB1
dC4uLi4NCj4gPiBPciBkZXNjcmliZSB0aGVtIHRvIHNvbWVvbmUgZWxzZS4uLg0KPiANCj4gSSB0
aGluayB0aGVzZSBhcmUgdGhlIHBlb3BsZSBkb2luZyB0aG9zZSBzY3JpcHRzIGF0IEFNRC4NCg0K
Rm9yIHRoZSB0eXBlcyBvZiB0aGluZ3MgdGhpcyBkZWJ1Z2ZzIGZpbGUgaXMgdXNlZCBmb3IsIGl0
J3MgdHlwaWNhbGx5IGEgaHVtYW4gaW5zcGVjdGlvbi4NCg0KVGhhdCBpcyBjb21wYXJpbmcgdGhl
IG5ldCByZXN1bHQgb2Ygd2hhdCBpcyBwcm9ncmFtbWVkIGJ5IGZpcm13YXJlIGFuZCBpbnRlcnBy
ZXRlZA0KYnkgdGhlIGtlcm5lbCBhZ2FpbnN0IGEgc2NoZW1hdGljIG9yIGRvY3VtZW50LiAgSXQg
ZG9lc27igJl0IHJlYWxseSBsZW5kIHdlbGwgdG8gc2NyaXB0cywgYnV0IGRvZXMNCnRvIGZpdHRp
bmcgYWxsIHRoZSBpbmZvcm1hdGlvbiBvbiBhIHNpbmdsZSBzY3JlZW4gaW4gYSBjb25jaXNlIGZv
cm1hdC4NCg0KPiANCj4gPiBUaGUgYmVzdCAnZml4JyBpcyB0byByZW1vdmUgYWxsIHRoZSBzdHVw
aWQgY2hhcmFjdGVycy4NCj4gDQo+IEkgbGV0IHRoZSBwZW9wbGUgdXNpbmcgdGhlIGRlYnVnZnMg
ZGVjaWRlIDpQDQo+IA0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0K
