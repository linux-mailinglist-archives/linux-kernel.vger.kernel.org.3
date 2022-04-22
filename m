Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E11550C0EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiDVVO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiDVVO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:14:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0F135C5E5;
        Fri, 22 Apr 2022 13:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz31HMuhRHO79iRsa+CIDl5EbuQI6yHrLqUZED6CR5D0RgT3qVEMScvV+UAZQjM8AfqHs1qBOfTQIqv1lLKk//C7HavjE5mleHyzhLEoI3etwvcP869/tmwj+6fb0vqh8LQh453PscoVllTlSu39YEmkXP2K4Cql5vHXi2dtMwc+Wii/58CjYFACUmsZPYILiE+6RM3HGMxtCRYejq3qnAQOZriW0zDRDc9PylQzM/WX75OC9ZkPeolgN48c2XFW8Xc9IOoX00p8HCEH7zwO7bCSNrRNUrThrG2cmqMiDRdDecaIpeBid7v4GIet8d57B321VvioIq5zq7ZjzMZ5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=350S4fAC5KifeQLT8wgKi1XDeI/q6eapxAcnFsmjnZk=;
 b=lyNlM0WgQK8S94tvU9A2OhVOkhkfE6d6oXEv87Y0a1zlr2d3V+QLSO70eplmhvmiGnY4D5il1lJmfYV13HMR5mp0Gy2Wzdr70jZlcUT5Miied+lsKoULMeYKb7Z+eTf9UHYv6Uvm4Wm/AhtbmtTAy9ps0hKuxS3OzA3GJ6EyPOeswKBsXvuCL0cKLglA1PpvcylYoaY1K5c/D436TEQkIHyK0XYG1BGRRI6ne7XLRmgxwiV+T1TCmhXp2zNVZan6As986CHB3Op4mRK4EgBV8w/JMj0QsnzS+mNM47r5MmBMA1l2Z/jqXA0JoufxTypnJ12s0PxdMXIgKC2DX+D1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=350S4fAC5KifeQLT8wgKi1XDeI/q6eapxAcnFsmjnZk=;
 b=x+xradlnM4GwmkGBrSssIkfNU1HGJzslizPqcFtAZtfgV0p6iL6dL4chhdcbLYjc8gPjGFD46XfCcYwiCdCJNlyqfFVDLjLcBbWXbqrdtjGu6cnamByzDBUvhhOamVBS+QIuCnKTv130/xib38ZJ1mcDllGn+oRXju4Ye/sPyY4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 20:05:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::98b8:8b06:2069:c838]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::98b8:8b06:2069:c838%7]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 20:05:25 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Hegde, Vasant" <Vasant.Hegde@amd.com>
Subject: RE: [PATCH v4] Documentation: x86: rework IOMMU documentation
Thread-Topic: [PATCH v4] Documentation: x86: rework IOMMU documentation
Thread-Index: AQHYVnILoAEZrZOhO0iIGelLt1T6q6z8VO2AgAAGhrA=
Date:   Fri, 22 Apr 2022 20:05:25 +0000
Message-ID: <BL1PR12MB51447D05D90FC2B25A43F55AF7F79@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220422175423.44491-1-alexander.deucher@amd.com>
 <a9e09125-c61b-4a2a-f87e-1ba8147f659f@arm.com>
In-Reply-To: <a9e09125-c61b-4a2a-f87e-1ba8147f659f@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-22T20:04:34Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7a90ea29-c470-4af1-b0c1-774300e3b2e2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-22T20:05:24Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 9f7369ea-37b9-4011-a72c-fea01db05cac
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1cdf9ce-cdcd-4258-25eb-08da249b70b4
x-ms-traffictypediagnostic: MN2PR12MB4126:EE_
x-microsoft-antispam-prvs: <MN2PR12MB412613CD41EBF004FCF1B3BAF7F79@MN2PR12MB4126.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iNxSFElRQjBMPyCNpFU1dXAVfk7t/fCVAgw3dBInI6a3+dwxlpKthreQCOnWUglZFOmHU2r9Htio/635UCXKrnN3vMjoO3dqs68InnL1eMbp2pTSsEf5lVmZRqECRxMrClhebSupR1IuD6yF/4Gyzdu69NPlwm3POhKptwQfMmt/NMrMFyvUMOF7Ay/ramnbhZBghPlSClnHSJH5nY70x14QAQwMe8jPhHw75pC7FRH0unXZV+iJsyd8l9sDe5VEMwMGbPNVI1GSIbAaeEsZYvaUSoZxzg/lNSjYDg5QsgU1bFS+SuyEPojNGOHtaBiCE0z5lVTTFXrXzLIz7ZVjvlJrWCVk6FM06UqjgQP4oZIuH/syMl+xJAkO6LwDWcg5kuItu93RyUXYtbrLpx2mhibKHyXnfmx/IlvXaywoPYhqoom6CH/1V5sQpulOBRJIBM1PvorOQJD5ZoAtOyX4ZTBOYjy/G7YS+V3CfdK2emIQKyXsV57AG+X/xMlIi2piYM9l6oZDVDVzrxcWxhq+GQ3IN0HWQ5q57zVtk8HKDSDYkWk35hOZXA36+C9NY12Dv/DGjSk5PTLa9fmzKSvCQ8LPYrTnwCMrKp+dKD8GWjMpDPZY4IrzZGEUjeJJnhjzUT90dNi0bjyIJHfNi7dqZaSY3p1simuCpHNRgqHXQlMI6sVw7Gd+e504txffv70gB1Vq8vzeTNTOuPRHCwH8AQOyD0fRlVcOj1TTC9Czp00=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(64756008)(66556008)(66446008)(52536014)(83380400001)(71200400001)(122000001)(76116006)(66476007)(7696005)(110136005)(8676002)(921005)(6636002)(86362001)(2906002)(316002)(33656002)(8936002)(6506007)(38100700002)(7416002)(53546011)(38070700005)(5660300002)(55016003)(508600001)(186003)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1gwYThjQVpiVmlRMklkN3VhaFEwTkdmREozTEdCVURQQjJ3Z2JiWDlneWpP?=
 =?utf-8?B?L29PZmd5ODEvZUQyZU1GamdGamxFSFdJazRES3hqQ3IyVWZ5aU5vb1ByN3ZR?=
 =?utf-8?B?eGxVNmdNVVZueUQzUHVoR1hwQktTMG9JZmt0S1VNUktkeFNvZnVoc0wzMnJx?=
 =?utf-8?B?K05JbnR2OWVaV252UmplczFGWW9Nak8wNFhLM25VOE1KWkpTTVNRS2xScXUz?=
 =?utf-8?B?MTl3Z2tpVWhmUzVxQWtJRTY2ZUg3RnhWbThnZGFTOWhpbGJzcFF1dEpKNEJy?=
 =?utf-8?B?ajdBUEIyWWtaTHhQRGRCd2xtZkd2YXRXNkhGSC9VK1ZyYTZIeGJqNjJ4c0ZM?=
 =?utf-8?B?aFQwMUN1bVJHaVlmMmNvRGFMR2VGYUpvbitHcWFWZ3ZsdmxGdnBZc243TkQx?=
 =?utf-8?B?b2Y5Z1AzSGpqdjRFcENCbW5YV050b3A5TEt0ZWt0NllPWFVFaG1RdTluTjcz?=
 =?utf-8?B?SkFCYzNiZ3lIWXpnVVBjWkFTM1VRcm92SGl5ZzdnYTd1aGwxcWl5dXIzdTE5?=
 =?utf-8?B?UURJL0NGMHo3OHZIeGtTTlFGVTV2ZjNNMnprMkVUWmMwS0FJSm84Tk1CVzNP?=
 =?utf-8?B?QU1qREhVWFRMWVdzYUUyOW96QXJVUWQzUmJ4cU95WW4xK05ZU05kcERPOERi?=
 =?utf-8?B?Wlc4KzhlR0VUUUFYQ0dNeDVnbXpPZnRsYnEvLzdqOFRtY3dCZjJCRTVuZ3ZE?=
 =?utf-8?B?ZUhqRjRlUnhLRDlNckJHQUFuQ2VvMG15WFcrdUUvTGo0YVBuOUlBUDV1bUdX?=
 =?utf-8?B?a3lBWE5pY01DTTJuL1ZtWkhmR3NBQmE2bU1VaFI1TWJuRWJXZEFYK2Yyb3B6?=
 =?utf-8?B?RjMzOEdtM2pHUVFTbzV4cGV6bnhRaTcwM3Z6cGs4OTY2dkUyWktqUWQzbDNM?=
 =?utf-8?B?MndBRHkyWS9kYTdKd3FxZ3orazV4WWRPSGRGWFEvNnFCa09RTTRTMmZxTXdO?=
 =?utf-8?B?dHc3U1Y1R2cxSituVU9xN05ORXEwTy9xSURMZnU2R3lURENVNEdqOUcvc0Vx?=
 =?utf-8?B?REh3dmxnWlR1OWFMVmFoc2JXckF5OXhTQW11MWFBbGw2QmFoTHY5d3JvL3RJ?=
 =?utf-8?B?ekV4ZHczRFltbWRqQitxbS9NQWJXK0MwaWdWK0R5M0x5SnJORlJiVlRZSFBi?=
 =?utf-8?B?RDVCM3Rnb29UL2NYencrNGttNlR0ZFkrMkl6M0dlc21CcXk3TVBtYmxZYm1Z?=
 =?utf-8?B?MEFSQzBSVlJHSFRwWTEwOGNybFRWbm4zV3g5d05wTTYxdFVzZ01wNnlYeFov?=
 =?utf-8?B?VEFCaU1WVXAzZWxLRHV6NXB6K3V5Z21kVlNGYmhma0RhTU9qTCs1MEJUaDNm?=
 =?utf-8?B?V0lIdXZXalo2amRyYUNYaTZJbDZicGVmRTFacEFWa3JCZ1RCWHdIZGtoWU1G?=
 =?utf-8?B?TDNBeDEyTkd3S2ZRYktHZnlob2NodUtMWXhoKytaU0N2V3RvMmNWSTlYcTFK?=
 =?utf-8?B?NDZwK3VXN0NBdjg4RC9hVUtyLzJtVEVpYklKRUdUU1d4ZlJuckQ5bWsyQ0Y2?=
 =?utf-8?B?U2xIdUIvZHlaSmVkZDNhS0MrRHp3QUF0eVVLUVpoS1ZwZlJlWTlVY1NlWmhC?=
 =?utf-8?B?c3pIbXcvTzNVNG5kUlcvMVoxMmtuSW9nVFpyMGU2SkttL2NRSlhEY3F1dnJH?=
 =?utf-8?B?OGw1VTBIS0VKMnY0NUQ4Z01GbFJRQXlxUytUMTJqMmNEODU5YzJESWlDOU02?=
 =?utf-8?B?ZjloNm5nenRWNzhEL2x5NTRaa3V0cHNTM1U0SEZzTHUvVUhvVmZSVkpEYkJO?=
 =?utf-8?B?d05rOVlwRFI5L3Fwb01TWFhTZHptRTlGRm5xS2pUOXJrVmhhQUhYdnpCMGx5?=
 =?utf-8?B?SnNndDFlNU1ZRGVSNGVvWFVUOUo0bno1UWlFU0k1K2huak5iZy94SG44WnlI?=
 =?utf-8?B?S2toZUdKQ3JCREFpUnVPWDRYMHpqd0tFRGxKVU9aNXlzZlEwdnBhOWR4a0k0?=
 =?utf-8?B?dmZmQ1hpd0ZPc3ByYmg3bXVKZTM5VDhRNUpZMGtjYmVLLzFDd1lHaG1DdkNE?=
 =?utf-8?B?dndwYkYvcm15N3pBMXZSWS9qMHZUZzRFWWNsN3FEUVFpM3R1VzhvREhNSWgw?=
 =?utf-8?B?T1RPOEw1TC9GdnVIQnY0WWdUYkdUeDk5UnV5VXlHV01Nb0JWdGlucU94SGdq?=
 =?utf-8?B?Y0NJNTdHSS83Z1BCOVdFRFNmeDNoRjZOcms5aWtxSzRheE1pTldubzJ5a2Nw?=
 =?utf-8?B?TjJwSCt4QlA2ME9RMkdaUVBpNFQwaU5OZ2xuNkNlZVNVNFQ0VUhiejNYVVk1?=
 =?utf-8?B?YnNheW1MQllMdkF0VWtuUFpHYTVEMHlqQ1RwWnhkcHh5V0N4SEdFZ25Wd2dM?=
 =?utf-8?B?WXVzQTk5RG9OcS96amtiQnk1ckkvTmo1aWFRY3BMcDFaSVZCRVdmdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cdf9ce-cdcd-4258-25eb-08da249b70b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 20:05:25.5575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3U7dxhCiTCy+RniTO3mW0/hork5A8XuA61xNjlvQLD3KEbjreCAqcO09OKGWiVPgRV5A1/Bx3rV0BqV93uY+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2JpbiBN
dXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBGcmlkYXksIEFwcmlsIDIyLCAy
MDIyIDM6NDEgUE0NCj4gVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT47IGxpbnV4LQ0KPiBkb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBjb3JiZXRAbHduLm5ldDsNCj4gaHBhQHp5dG9yLmNvbTsgeDg2QGtlcm5l
bC5vcmc7IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsNCj4gYnBAYWxpZW44LmRlOyBtaW5n
b0ByZWRoYXQuY29tOyB0Z2x4QGxpbnV0cm9uaXguZGU7IGpvcm9AOGJ5dGVzLm9yZzsNCj4gU3V0
aGlrdWxwYW5pdCwgU3VyYXZlZSA8U3VyYXZlZS5TdXRoaWt1bHBhbml0QGFtZC5jb20+OyB3aWxs
QGtlcm5lbC5vcmc7DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBIZWdkZSwg
VmFzYW50IDxWYXNhbnQuSGVnZGVAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NF0g
RG9jdW1lbnRhdGlvbjogeDg2OiByZXdvcmsgSU9NTVUgZG9jdW1lbnRhdGlvbg0KPiANCj4gT24g
MjAyMi0wNC0yMiAxODo1NCwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPiBbLi4uXQ0KPiA+ICtJbnRl
bCBTcGVjaWZpYyBOb3Rlcw0KPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICsNCj4gPiAr
R3JhcGhpY3MgUHJvYmxlbXM/DQo+ID4gK15eXl5eXl5eXl5eXl5eXl5eXg0KPiA+ICsNCj4gPiAr
SWYgeW91IGVuY291bnRlciBpc3N1ZXMgd2l0aCBncmFwaGljcyBkZXZpY2VzLCB5b3UgY2FuIHRy
eSBhZGRpbmcNCj4gPiArb3B0aW9uIGludGVsX2lvbW11PWlnZnhfb2ZmIHRvIHR1cm4gb2ZmIHRo
ZSBpbnRlZ3JhdGVkIGdyYXBoaWNzIGVuZ2luZS4NCj4gPiArSWYgdGhpcyBmaXhlcyBhbnl0aGlu
ZywgcGxlYXNlIGVuc3VyZSB5b3UgZmlsZSBhIGJ1ZyByZXBvcnRpbmcgdGhlIHByb2JsZW0uDQo+
ID4gKw0KPiA+ICtTb21lIGV4Y2VwdGlvbnMgdG8gSU9WQQ0KPiA+ICteXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXg0KPiA+ICsNCj4gPiArSW50ZXJydXB0IHJhbmdlcyBhcmUgbm90IGFkZHJlc3MgdHJh
bnNsYXRlZCwgKDB4ZmVlMDAwMDAgLSAweGZlZWZmZmZmKS4NCj4gPiArVGhlIHNhbWUgaXMgdHJ1
ZSBmb3IgcGVlciB0byBwZWVyIHRyYW5zYWN0aW9ucy4gSGVuY2Ugd2UgcmVzZXJ2ZSB0aGUNCj4g
PiArYWRkcmVzcyBmcm9tIFBDSSBNTUlPIHJhbmdlcyBzbyB0aGV5IGFyZSBub3QgYWxsb2NhdGVk
IGZvciBJT1ZBDQo+IGFkZHJlc3Nlcy4NCj4gDQo+IE5vdGUgdGhhdCB0aGlzIHNob3VsZCBiZSB0
cnVlIGZvciBib3RoIGRyaXZlcnMuDQo+IA0KPiA+ICsNCj4gPiArQU1EIFNwZWNpZmljIE5vdGVz
DQo+ID4gKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICsNCj4gPiArR3JhcGhpY3MgUHJvYmxlbXM/
DQo+ID4gK15eXl5eXl5eXl5eXl5eXl5eXg0KPiA+ICsNCj4gPiArSWYgeW91IGVuY291bnRlciBp
c3N1ZXMgd2l0aCBpbnRlZ3JhdGVkIGdyYXBoaWNzIGRldmljZXMsIHlvdSBjYW4gdHJ5DQo+ID4g
K2FkZGluZyBvcHRpb24gaW9tbXU9cHQgdG8gdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUgdXNlIGEg
MToxIG1hcHBpbmcNCj4gPiArZm9yIHRoZSBJT01NVS4gIElmIHRoaXMgZml4ZXMgYW55dGhpbmcs
IHBsZWFzZSBlbnN1cmUgeW91IGZpbGUgYSBidWcNCj4gcmVwb3J0aW5nIHRoZSBwcm9ibGVtLg0K
PiANCj4gQW5kIGluZGVlZCB0aGlzIGlzIGEgZ2VuZXJpYyBvcHRpb24uIEkgcmVja29uIHdlIGNv
dWxkIHNpbXBseSBtZXJnZSB0aGVzZSB0d28NCj4gc2VjdGlvbnMgdG9nZXRoZXIsIHdpdGggdGhl
IGZpcnN0IHBhcmFncmFwaCBiZWluZyBzb21ldGhpbmcgbGlrZToNCj4gDQo+IElmIHlvdSBlbmNv
dW50ZXIgaXNzdWVzIHdpdGggaW50ZWdyYXRlZCBncmFwaGljcyBkZXZpY2VzLCB5b3UgY2FuIHRy
eSBhZGRpbmcNCj4gdGhlIG9wdGlvbiAiaW9tbXUucGFzc3Rocm91Z2g9MSIsIG9yIHRoZSBlcXVp
dmFsZW50ICJpb21tdT1wdCIsIHRvIHRoZQ0KPiBrZXJuZWwgY29tbWFuZCBsaW5lIHRvIHVzZSBh
IDE6MSBtYXBwaW5nIGZvciB0aGUgSU9NTVUgaW4gZ2VuZXJhbC4gIE9uDQo+IEludGVsIHlvdSBj
YW4gYWxzbyB0cnkgImludGVsX2lvbW11PWlnZnhfb2ZmIiB0byB0dXJuIG9mZiB0cmFuc2xhdGlv
biBzcGVjaWZpY2FsbHkNCj4gZm9yIHRoZSBpbnRlZ3JhdGVkIGdyYXBoaWNzIGVuZ2luZSBvbmx5
LiAgSWYgdGhpcyBmaXhlcyBhbnl0aGluZywgcGxlYXNlIGVuc3VyZQ0KPiB5b3UgZmlsZSBhIGJ1
ZyByZXBvcnRpbmcgdGhlIHByb2JsZW0uDQo+IA0KPiA+ICsNCj4gPiArRmF1bHQgcmVwb3J0aW5n
DQo+ID4gKy0tLS0tLS0tLS0tLS0tLQ0KPiA+ICtXaGVuIGVycm9ycyBhcmUgcmVwb3J0ZWQsIHRo
ZSBJT01NVSBzaWduYWxzIHZpYSBhbiBpbnRlcnJ1cHQuIFRoZQ0KPiA+ICtmYXVsdCByZWFzb24g
YW5kIGRldmljZSB0aGF0IGNhdXNlZCBpdCBpcyBwcmludGVkIG9uIHRoZSBjb25zb2xlLg0KPiA+
ICsNCj4gPiArDQo+ID4gK0tlcm5lbCBMb2cgU2FtcGxlcw0KPiA+ICstLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiArDQo+ID4gK0ludGVsIEJvb3QgTWVzc2FnZXMNCj4gPiArXl5eXl5eXl5eXl5eXl5e
Xl5eXg0KPiA+ICsNCj4gPiArU29tZXRoaW5nIGxpa2UgdGhpcyBnZXRzIHByaW50ZWQgaW5kaWNh
dGluZyBwcmVzZW5jZSBvZiBETUFSIHRhYmxlcw0KPiA+ICtpbiBBQ1BJLg0KPiA+ICsNCj4gPiAr
OjoNCj4gPiArDQo+ID4gKwlBQ1BJOiBETUFSICh2MDAxIEEgTSBJICBPRU1ETUFSICAweDAwMDAw
MDAxIE1TRlQNCj4gMHgwMDAwMDA5NykgQA0KPiA+ICsweDAwMDAwMDAwN2Y1YjVlZjANCj4gPiAr
DQo+ID4gK1doZW4gRE1BUiBpcyBiZWluZyBwcm9jZXNzZWQgYW5kIGluaXRpYWxpemVkIGJ5IEFD
UEksIHByaW50cyBETUFSDQo+ID4gK2xvY2F0aW9ucyBhbmQgYW55IFJNUlIncyBwcm9jZXNzZWQN
Cj4gPiArDQo+ID4gKzo6DQo+ID4gKw0KPiA+ICsJQUNQSSBETUFSOkhvc3QgYWRkcmVzcyB3aWR0
aCAzNg0KPiA+ICsJQUNQSSBETUFSOkRSSEQgKGZsYWdzOiAweDAwMDAwMDAwKWJhc2U6IDB4MDAw
MDAwMDBmZWQ5MDAwMA0KPiA+ICsJQUNQSSBETUFSOkRSSEQgKGZsYWdzOiAweDAwMDAwMDAwKWJh
c2U6IDB4MDAwMDAwMDBmZWQ5MTAwMA0KPiA+ICsJQUNQSSBETUFSOkRSSEQgKGZsYWdzOiAweDAw
MDAwMDAxKWJhc2U6IDB4MDAwMDAwMDBmZWQ5MzAwMA0KPiA+ICsJQUNQSSBETUFSOlJNUlIgYmFz
ZTogMHgwMDAwMDAwMDAwMGVkMDAwIGVuZDoNCj4gMHgwMDAwMDAwMDAwMGVmZmZmDQo+ID4gKwlB
Q1BJIERNQVI6Uk1SUiBiYXNlOiAweDAwMDAwMDAwN2Y2MDAwMDAgZW5kOg0KPiAweDAwMDAwMDAw
N2ZmZmZmZmYNCj4gPiArDQo+ID4gK1doZW4gRE1BUiBpcyBlbmFibGVkIGZvciB1c2UsIHlvdSB3
aWxsIG5vdGljZQ0KPiA+ICsNCj4gPiArOjoNCj4gPiArDQo+ID4gKwlQQ0ktRE1BOiBVc2luZyBE
TUFSIElPTU1VDQo+ID4gKw0KPiA+ICtJbnRlbCBGYXVsdCByZXBvcnRpbmcNCj4gPiArXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eDQo+ID4gKw0KPiA+ICs6Og0KPiA+ICsNCj4gPiArCURNQVI6W0RNQSBX
cml0ZV0gUmVxdWVzdCBkZXZpY2UgWzAwOjAyLjBdIGZhdWx0IGFkZHIgNmRmMDg0MDAwDQo+ID4g
KwlETUFSOltmYXVsdCByZWFzb24gMDVdIFBURSBXcml0ZSBhY2Nlc3MgaXMgbm90IHNldA0KPiA+
ICsJRE1BUjpbRE1BIFdyaXRlXSBSZXF1ZXN0IGRldmljZSBbMDA6MDIuMF0gZmF1bHQgYWRkciA2
ZGYwODQwMDANCj4gPiArCURNQVI6W2ZhdWx0IHJlYXNvbiAwNV0gUFRFIFdyaXRlIGFjY2VzcyBp
cyBub3Qgc2V0DQo+ID4gKw0KPiA+ICtBTUQgQm9vdCBNZXNzYWdlcw0KPiA+ICteXl5eXl5eXl5e
Xl5eXl5eXg0KPiA+ICsNCj4gPiArU29tZXRoaW5nIGxpa2UgdGhpcyBnZXRzIHByaW50ZWQgaW5k
aWNhdGluZyBwcmVzZW5jZSBvZiB0aGUgSU9NTVUuDQo+ID4gKw0KPiA+ICs6Og0KPiA+ICsNCj4g
PiArCWlvbW11OiBEZWZhdWx0IGRvbWFpbiB0eXBlOiBUcmFuc2xhdGVkDQo+ID4gKwlpb21tdTog
RE1BIGRvbWFpbiBUTEIgaW52YWxpZGF0aW9uIHBvbGljeTogbGF6eSBtb2RlDQo+IA0KPiBTaW1p
bGFybHksIHRoYXQncyBjb21tb24gSU9NTVUgQVBJIHJlcG9ydGluZyB3aGljaCB3aWxsIGJlIHNl
ZW4gb24gYWxsDQo+IGFyY2hpdGVjdHVyZXMgKGxldCBhbG9uZSBJT01NVSBkcml2ZXJzKS4gTWF5
YmUgc29tZSBvZiB0aGUgbWVzc2FnZXMgZnJvbQ0KPiBwcmludF9pb21tdV9pbmZvKCkgbWlnaHQg
YmUgYmV0dGVyIEFNRC1zcGVjaWZpYyBleGFtcGxlcz8NCj4gDQoNCkFsbCBnb29kIHBvaW50cy4g
IEkndmUgaW50ZWdyYXRlZCB0aGVzZSBzdWdnZXN0aW9ucyBhbmQgd2lsbCBzZW5kIG91dCBhIG5l
dyB2ZXJzaW9uLg0KDQpUaGFua3MhDQoNCkFsZXgNCg0KPiBDaGVlcnMsDQo+IFJvYmluLg0KPiAN
Cj4gPiArDQo+ID4gK0FNRCBGYXVsdCByZXBvcnRpbmcNCj4gPiArXl5eXl5eXl5eXl5eXl5eXl5e
Xg0KPiA+ICsNCj4gPiArOjoNCj4gPiArDQo+ID4gKwlBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9f
UEFHRV9GQVVMVCBkb21haW49MHgwMDA3DQo+IGFkZHJlc3M9MHhmZmZmYzAyMDAwIGZsYWdzPTB4
MDAwMF0NCj4gPiArCUFNRC1WaTogRXZlbnQgbG9nZ2VkIFtJT19QQUdFX0ZBVUxUIGRldmljZT0w
NzowMC4wDQo+IGRvbWFpbj0weDAwMDcNCj4gPiArYWRkcmVzcz0weGZmZmZjMDIwMDAgZmxhZ3M9
MHgwMDAwXQ0K
