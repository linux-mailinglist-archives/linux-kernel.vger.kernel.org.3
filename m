Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6B4C50B0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbiBYVZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238782AbiBYVYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:24:54 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD778198D3F;
        Fri, 25 Feb 2022 13:24:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCTmbYJeu8Isi57jnqZTYL2vTm1przRTJcMKKId7LnF11+4E26ApRAdagK/vJAM8aMjEagjzX0i9yMystid9oqNWlmENqHw5b0sB+RpYmtffbb9wTWQejfio/J3QCee7J8v96wNRr8ig7GOuBUMBUfkzQkcpbgkUkkMNqOCQJ/8FhVWaGugGTe46r4WCXmPh1Jo+MpMOcPE+IEghMPw6lphLrfGR8CTztEAV76Wi6D6g9zJSRSNYwmX5qDY2UFQ0tUwOxAGXTq5q+1aK1UZnRtrQo0b44u5vEJhC4Plk022XW0bed5fb1Zleqp7+OL/JkNUA6vNDZb2ndOBDYY3WUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZM12r7cOsTJucfl4drcQQo1gnCFPLWHJ9FB6R+mN0g=;
 b=cL3hLfzvF6v/abpsohkqzDnWUjKw+6sWREAjwPddH8PAg5nh0hjYsXpy/lbX49jV1PvphCpTnwzP4l4kRWepZu8fsBNd7K4oWiUtII/fbyX8JdwwTCOM0m15HnhTkreaSDqs3KMC94snhKEQpAcLazUWKLHAxpFP3hO+OVvYKerZD937xsu0SASj5hyw+SMIhAIbEheI+AvGBwG7lR646EvgGB4EUJiGRK36uZXxq3a53JIwc3NaxdKkG8mQ2FqZc0b7gfP/AlahEVECThcCQFk2V61eahRZusGQ4MaMLYALrZDJMa1SzSIh1NCneDUHR6+JuIAsYM3eh5tVEZ8PvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZM12r7cOsTJucfl4drcQQo1gnCFPLWHJ9FB6R+mN0g=;
 b=E5z0qbCCKtqJ6kGD7gKANekJpqUZ2LX/T8xteXKWCXb7ESkNf7x5pYh3ZDGh84aMdj6R3k7Zwv0JY/oeuhKPoPnDnImPiLge+sdCTjKC1e88aTU//2tLTPCxyQ08IXTa4p5qS4zhPCW83RsjBs43gQmVWgj0Ff9Jrk+aCGpA7DE=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BN6PR1201MB0147.namprd12.prod.outlook.com (2603:10b6:405:56::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 21:24:18 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 21:24:17 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 2/2] ata: ahci: Protect users from setting policies their
 drives don't support
Thread-Topic: [RFC 2/2] ata: ahci: Protect users from setting policies their
 drives don't support
Thread-Index: AQHYKnNLwB0vCdHvZkmDpxaIeHyoGqykxgsAgAAA1LA=
Date:   Fri, 25 Feb 2022 21:24:17 +0000
Message-ID: <BL1PR12MB5157C0A33DC4484B6E5E6E91E23E9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220225181030.980223-1-mario.limonciello@amd.com>
 <20220225181030.980223-2-mario.limonciello@amd.com>
 <7381d145-ac6f-60f4-296a-7b191296964a@redhat.com>
In-Reply-To: <7381d145-ac6f-60f4-296a-7b191296964a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-25T21:24:16Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e51c9925-e20a-4ca6-bf36-cb2f2d64e74e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-25T21:24:16Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: b5248306-452e-41eb-bcb7-37ee47b5155f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 681aeb56-bc21-4077-e537-08d9f8a52e3f
x-ms-traffictypediagnostic: BN6PR1201MB0147:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB0147F24ED534402F7D4692EEE23E9@BN6PR1201MB0147.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ATSGRg70XRtHfWcBZMTgleUM0AtbKreKG7fksVv0b8EaMwlZ9szYlYObE13sfn1AgZLdkwDm1dGEID7jMx7JqLgjeWRsyZxcgfs9vr6v620lyF5ixy4greh3sEgvwpHMaQNh1Dx/dTS0V+NGdk9YqjmOZEO5WmBtwVsdWZ9EqENeWufMOZTUjiefs9milgv4Fm+NPIB6TUSuAc8NFFMzuLi91zB7Ydyu/fcsej8MykpVYOXeU/VEb0dnzssFuJ2uPtXWOAXSexL7NFAA0kjLv50LoaKMGlBcgn6Gk6B68cVhsPPVdYO6Vk3BumDnZy61Y2l4V/Tu0RShDSrSAazz3eth/loIgzPSNsDBztk1zMNjRCCyJIFlzYYXCDEa5W9MRiv20qoQnMKTBixQ09Q7Q5OEMcFrj53vH6Y+5WLFjRzwBKHDiHFeKNb3Qf56HDa7eIiZh24zx78aoHnObw4xfG2r1rlh/Ldo4j9BQeo/wA04SWYkQO8cp7WsB2wZ0HdonwgjyVyWz/2wuBp3tBwA94r6hBj4gQABLPZC2aT0BSuCPu8EH50ghQDKpbcVp5pzaN9A1Kg6KnJcjGKH8PVgpBbzoIdN6bAWtIvZB/ZaDTcvrp3/7jNJRQHqfFFMXp7xEdtCB16i2Pvxr2WM275I5a2EKiJp4WqLgzyzja+Po+XEptKdoDJBLMfLyZ9+xRMWItMxGmTAJtg5GcDa5shPvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(316002)(7696005)(53546011)(55016003)(6506007)(26005)(54906003)(38070700005)(38100700002)(52536014)(186003)(8936002)(110136005)(33656002)(83380400001)(5660300002)(71200400001)(9686003)(64756008)(2906002)(4326008)(8676002)(66946007)(76116006)(66476007)(66556008)(86362001)(66446008)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWtHRWJ2TjBKdjNZSlJCTUk2ZFRzck9DcUpNS2NNV1dKZndxQ1o2QTZBSytq?=
 =?utf-8?B?Vk50c1JDc3E5dzlyem8zTitJTGVyYURYSWpyd3Y5NjZ2Q3d5RlVvZGZXUW82?=
 =?utf-8?B?ODI5cThIdTNSaGlkaUE0U0VEK2xEM0o3ZFIvZDNYVmRVWnhVU1hrRzdLRjVo?=
 =?utf-8?B?a1V5L245MFBmaTZJak0wYm9ITlV2Z2JCM1dPU3ZyaVNvY05XWnA3U2xBeFNr?=
 =?utf-8?B?aG9KZVNEMWNaU1VVSGpDdjlaZ2U0OXFYcm9LL1B6NG8wdC9oR1VyYWxXUlhM?=
 =?utf-8?B?U3MyckxDUVVvUjZINXFETEFoRDFULzdQcFJ4eTlmUkNUS1NSb21CczhzT0t1?=
 =?utf-8?B?UTN5QXBha0hsbDE2UHVUdjAzb3RjSVl5YlVjYnRXanNBSkNMMGlDdmJBMElp?=
 =?utf-8?B?bllNbTNTR0dVUll4UU5RT0gwSG5sWjd4S1VGYkowQXhVQ0tUc3B1WlQrNkZ3?=
 =?utf-8?B?d3NMS3BjMVhCRHJRamlJL0V5QVZ4ZUlPTGJwT0o4by83RU1GRHJBWE1FN3BT?=
 =?utf-8?B?ZXFGRUFyT0g5OXJJOUEzTVMvQkdxWlJZNEt6NVBSSWpYQ2dOWnJObXp4dVRn?=
 =?utf-8?B?ck1kd05IRXFlTUxqa1ZaSnBxZU52OXFVNElLL3FhanBvNSt5NFpFZXUrWitQ?=
 =?utf-8?B?ZGUrZEc3c08xb3NDcSt0aU84WGFTb1ExSnhaUklsRERUSnpMUkZNSzlpQkpv?=
 =?utf-8?B?YXViSTlFN2s0Y1VvWE9qNjliU0pkdk5qelNDWTlCRTM3WTJwbXNUUjV2ZzJD?=
 =?utf-8?B?SVBDN2JlSHQzdzgvSjdMNFVtNFp3emt5OFhra1ZsTEdSTzltTVlFeGpCcStR?=
 =?utf-8?B?M2pOMFBlTXhpUFNRaUx4WFFESFA1N05seGltdWd3blUyOUphMTF2Vm1yMGRu?=
 =?utf-8?B?cmNSMVJMWXprZjdXZWt3bFl0Nzlta2xEUEZqdVFCSkVyQkw3bFVUWFNOT1Y3?=
 =?utf-8?B?ZjRoNEF0Q1dJang2T2lKRUlHck44dnAvaEpNU1hCRy9WcVlxYlpFSGdTRmQ1?=
 =?utf-8?B?b1FXRGJEb2FDOVlaWnVrVmZYVzFBaG4yVWM1djNxVEVvWjZvVFlhUFoyRkk1?=
 =?utf-8?B?SmRWTUUrQ2dWSmdjV2hzbTE4Vk1SeHN0dVR4M2lwb3ZnS1BUTXZsV0NIQ2VV?=
 =?utf-8?B?WEdLMDBrdnUwM2tnRkJLT3ZQajZQbUlWTEhwaW9ZY2VWdFJBaHdSVGxIQ3Zk?=
 =?utf-8?B?aGVVMi82MERaZGV4UmIyVWZ6TFBvUURHb3V6V3JtdmpzM2ovcmxsZ1ZZYU5H?=
 =?utf-8?B?ZWxNWjYzY2VGam90ekdBS0dIN3NvcUN4RzN4cFU2VGVnaDIzWDZWN2h5elJu?=
 =?utf-8?B?dHZmOTFYeVJVUjZ0OGduRnM2TU9lT3lkczJ4VU4zenowc1ZocnJ5Q1FZak9t?=
 =?utf-8?B?U1ovRmxtMEQ2WWZhUXpSZkFYc0ZUTmZZYWxkTzhPUitZN3ArSnhWU0QvN0lK?=
 =?utf-8?B?dlZXblAwL0l6L2NESjJia1k2azduQmRDT2x2Um9LU0d6NUJoT3NYempDZ0ds?=
 =?utf-8?B?T0k2clU1VDEyNnVRbWEvSFg2MUhNUHd5N1AycjlhUW11ZzExY2I0WVphQkI3?=
 =?utf-8?B?bXhMMkt4YmptUVlYVzVCeFFPNDZCV1d3cDM3dDl2UW1Kb3hDUjBrMG83bW4w?=
 =?utf-8?B?Q3NxTUF1WncreEJVdndNbGFxejhwWG9ESHU4WCtDNXY1YWE5cXAxVW9ZVTBY?=
 =?utf-8?B?U0laZXF3UkJlVEU1Nmo0aUJ4ekRNam5CVHIzMTdqYTJqelZZYXpRZVZXbFZ6?=
 =?utf-8?B?Q054QUVha3FycWIxM3AxbGYzNDB0Q1JVbEFvN2FFbnhFdVVvRHBOL21sdkEv?=
 =?utf-8?B?WHNGUmNseDk5QkhmRVo2ZXE1K3hwZVBEeEIvd1NyR0dqVi9QQXFMWjRiajNP?=
 =?utf-8?B?ZUNPaW5BNFVweHZ2aXN5cHVKVWZxb0RGQWlhZGNFaTBJTGlLLzlkMXROR0I2?=
 =?utf-8?B?cTV4TEFpNXg3VTh5c3pOUUVPYkpoakFqeVFpTVZEZ2FGRDRucFhwakdaVEdy?=
 =?utf-8?B?ZFVHMnl1eUtpcXFtMjBYSHpZY1p0TDgzdTJIOFVwWmVvSU9nYkxIeDJiRnB1?=
 =?utf-8?B?NGtTZ2FIMEZOQitMamN3a2t3a0VXUitjdHBwVUVjYTIzTWR0MXhmZFhjaThO?=
 =?utf-8?B?YzB1UCtidHFmUTVDS2x2d0lPQzNDS09zZWRmQ1Y1STVKVGsrbmxRWlRqYUpN?=
 =?utf-8?Q?ccRo06P+Z4oW/YF/XgsdFWc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681aeb56-bc21-4077-e537-08d9f8a52e3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 21:24:17.7617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1bSUxJQSS6dl8OK4wF8vo3tECRtpqzl3sF1mYTr2II29xSdZRggH2zAJzwV3ut2hMhwHyyuGMHjfOirxHY6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gU2VudDog
RnJpZGF5LCBGZWJydWFyeSAyNSwgMjAyMiAxNToyMA0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlv
IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgRGFtaWVuIExlIE1vYWwNCj4gPGRhbWllbi5s
ZW1vYWxAb3BlbnNvdXJjZS53ZGMuY29tPg0KPiBDYzogb3BlbiBsaXN0OkxJQkFUQSBTVUJTWVNU
RU0gKFNlcmlhbCBhbmQgUGFyYWxsZWwgQVRBIGRyaXZlcnMpIDxsaW51eC0NCj4gaWRlQHZnZXIu
a2VybmVsLm9yZz47IG9wZW4gbGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4g
U3ViamVjdDogUmU6IFtSRkMgMi8yXSBhdGE6IGFoY2k6IFByb3RlY3QgdXNlcnMgZnJvbSBzZXR0
aW5nIHBvbGljaWVzIHRoZWlyDQo+IGRyaXZlcyBkb24ndCBzdXBwb3J0DQo+IA0KPiBIaSwNCj4g
DQo+IE9uIDIvMjUvMjIgMTk6MTAsIE1hcmlvIExpbW9uY2llbGxvIHdyb3RlOg0KPiA+IEFzIHRo
ZSBkZWZhdWx0IGxvdyBwb3dlciBwb2xpY3kgYXBwbGllcyB0byBtb3JlIGNoaXBzZXRzIGFuZCBk
cml2ZXMsIGl0J3MNCj4gPiBpbXBvcnRhbnQgdG8gbWFrZSBzdXJlIHRoYXQgZHJpdmVzIGFjdHVh
bGx5IHN1cHBvcnQgdGhlIHBvbGljeSB0aGF0IGEgdXNlcg0KPiA+IHNlbGVjdGVkIGluIHRoZWly
IGtlcm5lbCBjb25maWd1cmF0aW9uLg0KPiA+DQo+ID4gSWYgdGhlIGRyaXZlIGRvZXNuJ3Qgc3Vw
cG9ydCBzbHVtYmVyLCBkb24ndCBsZXQgdGhlIGRlZmF1bHQgcG9saWN5IGZvciB0aGUNCj4gPiBB
VEEgcG9ydCBiZSBgbWluX3Bvd2VyYCBvciBgbWluX3Bvd2VyX3dpdGhfcGFydGlhbGAuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9A
YW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9hdGEvYWhjaS5jIHwgOCArKysrKysrKw0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9hdGEvYWhjaS5jIGIvZHJpdmVycy9hdGEvYWhjaS5jDQo+ID4gaW5kZXggMTdk
NzU3YWQ3MTExLi5hZjg5OTk0NTMwODQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hdGEvYWhj
aS5jDQo+ID4gKysrIGIvZHJpdmVycy9hdGEvYWhjaS5jDQo+ID4gQEAgLTE1ODQsOCArMTU4NCwx
NiBAQCBzdGF0aWMgaW50IGFoY2lfaW5pdF9tc2koc3RydWN0IHBjaV9kZXYgKnBkZXYsDQo+IHVu
c2lnbmVkIGludCBuX3BvcnRzLA0KPiA+ICBzdGF0aWMgdm9pZCBhaGNpX3VwZGF0ZV9pbml0aWFs
X2xwbV9wb2xpY3koc3RydWN0IGF0YV9wb3J0ICphcCwNCj4gPiAgCQkJCQkgICBzdHJ1Y3QgYWhj
aV9ob3N0X3ByaXYgKmhwcml2KQ0KPiA+ICB7DQo+ID4gKwlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9
IHRvX3BjaV9kZXYoYXAtPmhvc3QtPmRldik7DQo+ID4gIAlpbnQgcG9saWN5ID0gQ09ORklHX1NB
VEFfTFBNX1BPTElDWTsNCj4gPg0KPiA+ICsJaWYgKHBvbGljeSA+PSBBVEFfTFBNX01JTl9QT1dF
Ul9XSVRIX1BBUlRJQUwgJiYNCj4gPiArCSAgICEoaHByaXYtPmNhcCAmIEhPU1RfQ0FQX1NTQykp
IHsNCj4gPiArCQlkZXZfd2FybigmcGRldi0+ZGV2LA0KPiA+ICsJCQkgIlRoaXMgZHJpdmUgZG9l
c24ndCBzdXBwb3J0IHNsdW1iZXI7IGlnbm9yaW5nIGRlZmF1bHQNCj4gU0FUQSBwb2xpY3lcbiIp
Ow0KPiA+ICsJCXJldHVybjsNCj4gPiArCX0NCj4gPiArDQo+IA0KPiBEb24ndCB0aGUgY2FwYWJp
bHRpZXMgZ2V0IGNoZWNrZWQgbGF0ZXIgd2hlbiB0aGUgcG9saWN5IGdldHMgYXBwbGllZCA/DQo+
IA0KPiBBdCBsZWFzdCBJIHRoaW5rIHRoZXkgZG8gZ2V0IGNoZWNrZWQgbGF0ZXIsIGJ1dCBJIGhh
dmUgbm90IGxvb2tlZA0KPiBhdCB0aGlzIGNvZGUgZm9yIHllYXJzICAuLi4gID8NCg0KVGhlcmUn
cyBhIGJ1bmNoIG9mIGxheWVycyBvZiBpbmRpcmVjdGlvbiBzbyBJIG1pZ2h0IGhhdmUgbWlzc2Vk
IHNvbWV0aGluZywNCmJ1dCBJIGRpZG4ndCBzZWUgYW55dGhpbmcgaW4gc2F0YV9saW5rX3Njcl9s
cG0gb3IgYW55d2hlcmUgZWxzZSBmb3IgdGhhdA0KbWF0dGVyIHRoYXQgYWN0dWFsbHkgY2hlY2tl
ZCBIT1NUX0NBUF9TU0MuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBIYW5zDQo+IA0KPiANCj4g
PiAgCS8qIHVzZXIgbW9kaWZpZWQgcG9saWN5IHZpYSBtb2R1bGUgcGFyYW0gKi8NCj4gPiAgCWlm
IChtb2JpbGVfbHBtX3BvbGljeSAhPSAtMSkgew0KPiA+ICAJCXBvbGljeSA9IG1vYmlsZV9scG1f
cG9saWN5Ow0K
