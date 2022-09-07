Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AF95AFEA0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiIGILy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIGILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:11:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BA09DB40
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:11:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3caRRoK6v24/RudStwCie/Sn2y1VGz+UBd3p6fb/NJaDyYwWZJS0UoZ5XhuYIF7mNe1puS/6C+xFczf/WH6sjKVd5Nq09f+iHbyOJUSV8VBs0TKmaMVstY97FineGaXXNr4+y3DcXlmLUGX9Pbddp5Aglgqcu/bq6GmMrdoag8RyoI8ZCnzLaZd0wUWKpYuGPHMxnWxC2C0tsOJQYGevRvFU3kPk2Kgg4Ffz8n0QGC6kjS50sqOAiKtWvLsG0Qnj8owA3CaCn23yWPSkONey4SAXJUe+GRImQfT0MoEAHgVhdTv3NduASo5wkfI730PlptMfpS/YZ4qP8yGLEXdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFTvunNve1j0lPRv0MEfICqPXNnL0Yx+qONqeR2vsOI=;
 b=N0yOB1N3VhGPxBxQbzzZbAhuGXnRL1v3t2rRlmrLlGaNXjvTrtYA30ndZdy0cog8WTY+jwwpFUMW6R7UpEeVze2tUAU7asOXoGBjmQZBvNdxgCtDUG1U8eILQc2CsH50AC/IsHSMWP0jajMV9XI9b/72kR7lxRuVh1XJKJ8U4ros6KAJpyandbvNT44lKBOgkHRmrmkUFyKMI0AuQ4nzGz3QSFw31BCR3IQapxT61yBy0lKZELOmDNTO0Ht+M/ohfco1gYjRgAp5GeD9P+rWAPABiDbXD7z3qvSRMCaCd0UgdtKg+MZpjSTjkIdufTv7ZpRkgK/2L0gftk80WslzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFTvunNve1j0lPRv0MEfICqPXNnL0Yx+qONqeR2vsOI=;
 b=MEw5+J20xIlIIfuZqZYUrF8b3eALd9T2+w+o6llcGw3iY+AMzqfL+moM0olE9nv74HHhFnfoeFtmNWxLc+r2G3uDURR+UUNSTzR8uFceM7sKS2mo93kc7BDHS4zAA/X9Uk8YvDyaJZ95OYhvox+Pqbim7BdnaGcKcjWbYsimGGNtFK9TdWkPTL6I7IkWbCven0YaLkz35HP+2hzXFOokXdXfJXoimGmBY5qCx96N6X4rEFKM4GpDMp42EqkSJX7TP7iTd2KOiS0ZGpW+3/FwiQd0n+UTwGiEOlS/GBwRvl9cyQ8TQPyV5H0qklJu3PfSXVMcKb9uwmYQL1GUxsinJw==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 PH7PR12MB5999.namprd12.prod.outlook.com (2603:10b6:510:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 08:11:42 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357%5]) with mapi id 15.20.5612.012; Wed, 7 Sep 2022
 08:11:42 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] vdpa: conditionally fill max max queue pair for stats
Thread-Topic: [PATCH] vdpa: conditionally fill max max queue pair for stats
Thread-Index: AQHYwn9Fx1nXRznSXUKkLYwaO1Myaq3Te6IwgAAMZYCAABRPEA==
Date:   Wed, 7 Sep 2022 08:11:42 +0000
Message-ID: <DM8PR12MB5400209468A07467499B19BDAB419@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220907060110.4511-1-jasowang@redhat.com>
 <DM8PR12MB540034620ADF0AE749C2D099AB419@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEvjgyxs3HX_ZzUbMticntqnUxDQJMrr2MqTBwuRB7jCdw@mail.gmail.com>
In-Reply-To: <CACGkMEvjgyxs3HX_ZzUbMticntqnUxDQJMrr2MqTBwuRB7jCdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|PH7PR12MB5999:EE_
x-ms-office365-filtering-correlation-id: 7d85ddab-3432-473e-30aa-08da90a898f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: js/AgncSC5ftrW4Agi42IhYEmQXnRaFyoyAFzCyGQONwIfNoZTD9pm3a2Nsk6XbR13r3L6a2an0R+QgziT8weUz80Hs8pvb6QbYXscrJfAbVijt/C9kfR1OBiIjSipWiTNEiqP+f4CGvOn9VBzS40dLg1qCIcanm8EIJENIVBB57A+XaiyT0xWQLtB57ORPfJxPYISPNVC9yDVHjaogYEoqXkOjeqQICXYKxKfS9e/L7iMDc7EwecHC480O+RIT40oZfGbyHXYyBGp0+SfKLENuf5JVxPyi2D2Ue785ECUle06EvlODVgF9oaAYN6whdx72hyvhEH74KZkZ41Y4gyf1a93bD2Mwf56Wf42lj3usq/DsMYnzpTHPviKeom4vpxFKmlDsBYSM9cxlpgFoMmb2k1e+8FP7rusCgDGgegNaFJlw4UnV6De23SoNOVkTG1d4PlqTVFoGUHAg9wvHBp3KdxfZ7231QJtYPKnJIGMhmX4vstqnVNmjOCx9HjwCyKqUA6g/y7yUdoYde5AMX3c/nbALAPY9ZuNHcbIEbaUmSi+zN4ubkJ+Yhv5O/4sH4RQsYf9Mkj+3mRbiU1Y0gb/ai4V0lzh01sTJq8bqp/Uw/gSDDeQkDvbNG7ZM6dkkUrBXxksOnzyIJTZw1neym58dkB/sIbLhqMRAF2yMOcSeYWVysUCtq90kBCyR3gP/0gqCM2GXniUfvVyzAzkXwW8f+chQQirOl45UXaiSekDA0nmzdyqeXoCG9Tg8bK08RmNjDUBltJhwHDUZQgozBIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(8676002)(66446008)(66476007)(76116006)(66556008)(66946007)(38070700005)(6506007)(33656002)(4326008)(7696005)(52536014)(64756008)(478600001)(83380400001)(2906002)(26005)(9686003)(53546011)(5660300002)(8936002)(186003)(86362001)(41300700001)(316002)(122000001)(55016003)(38100700002)(71200400001)(54906003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDJISTV5VmpRL2pvYnErVFpGVjVTaDIvNDltS0pEeklyN3JBUkpFOTk3Zis1?=
 =?utf-8?B?dC9aalhUc0ZDM0p4b0RmakFSZzhnVisyQ0ZWMFBXYXdmeXloNWsxYktJT0Vs?=
 =?utf-8?B?cHAyMy9KREdtV1UvMElpR1BrTmNCSWxiS3VrTytwejZoZzBJSE0xR1FkT2xx?=
 =?utf-8?B?ZUVWbHhXNHE4OW4xcjU5dFY0a2sxYUN0LzhETWFKekdBa3JqYUVPVldRTW5W?=
 =?utf-8?B?NWo3VlJMallSSW5DWUpla2t3ZzlsVHdYL1pLaXBWQ01Hc1BCQ3JWS0h4eWlO?=
 =?utf-8?B?c296M0xydmhIOXE1WXBXeUtrQ21qamlaY0dvSDRPNlB4QnR6Y0d6NjdIMk1z?=
 =?utf-8?B?Z1hhYktuVC9jWDQ1MFZYMDdXWStISHJGWkZJNGU3R0dWb1dsRjhDbzdiRkZq?=
 =?utf-8?B?U0J2YWdxT0ZTQXBwenJLWTRuS3JNRDEwenowMTZYRWtUVmZwWHoxcExtbnVu?=
 =?utf-8?B?SmE4alc5TG1EVXNnYnV3bzVpcVFXbk5qUXhwNUN2bkNhNE9pWlhVOFNsZTE2?=
 =?utf-8?B?WVBiOHRDOGpaTGhxVHc5a3Bqemd1Zkp6Qng0K2J1QVNRbzBtSTZpMUZaTnpU?=
 =?utf-8?B?RTJDZEw4MG9ONy90bnRpcm8vcUh4ZlpFb1NXNlpuc3J0N0t2WlU1b2FkeUlo?=
 =?utf-8?B?VjNpOURVTnlMUGZ3TjZlbWhTOUFzSnZPQjZQN1BjQTBiaXhGZXgva1dvNXJM?=
 =?utf-8?B?aitRL0Fkd0FLMlY3blFMNGJQZzVIMmpjQVFkODd3OTRFcnZqOHREQzAvNkR0?=
 =?utf-8?B?MGVBdjl4OFJCMXoyRUZCdUdtTTIydHdyNm9UMDV2YmdRdnJDRVFzdFpZcXF5?=
 =?utf-8?B?c3Zha2w4THNQNWpGOXNTLzY5SHpuRzJhWlVUNmllbVlNWHFQYXdOalNWSDRx?=
 =?utf-8?B?QUFjenRRT3U0bzhTZTVLWjBrVFR5dzhGN2JyaGtJY2NhZk5jYmYrdEh4TE5x?=
 =?utf-8?B?TW0zcXVjSFY2YnQzMUVjbHJUVFhwTHFDK1JRMi93bDk3b2hxSGVBK2lZSkRm?=
 =?utf-8?B?RUkzMXV3M2grajZXb1NaeXY4YVhsMi9OeGtWR0NuY0JPOWYxRWtZajlLNklk?=
 =?utf-8?B?WmpVODEwTnBQbzhrM2JiMTU1bG5lUERvZFNqbWZpaUJCM2FBTzJmaHQzR0ho?=
 =?utf-8?B?ZWFaL2R6eThHUFRmalNYdk5NZmx2Q3lWdVVPM0wxZGJZMFlYOFZ6ci9OV01B?=
 =?utf-8?B?QTZDR3VzMnE1bnNaekRkVXd3LzE2NlY5NGJ5YzYyUTMwVXFyOGpTV1pTUytw?=
 =?utf-8?B?NFZYQk15a1NUSGNiQ0VIUllJNTVGdE5ra3E2UlYxZ1ZYQUxlZW4yTUVNbHVy?=
 =?utf-8?B?MUtwVVRYdUErVWlOUHQveUVaUlJrWWxCMG8zNW5UNWNVa3FXckU3T3RaY0JU?=
 =?utf-8?B?SHFoZm9UMFBIeFRXTUxqcG9hODRiMGZWSkNWTlc2VEYzSlV0WUNYSm5ZajhG?=
 =?utf-8?B?VlRaWjF4ckpJazYwc0ZNclEvRURFVFFMK29meFZvZUJHVEhQZlVyK09nZjNI?=
 =?utf-8?B?a1Roa0pxVC9VWkpIeVNqNmVpR1lvbU4vVTI0dGU3cThqMHE2eDlvN1JjVCth?=
 =?utf-8?B?RlRQdTIxM1FONE9hZTZzV01CNDZoMGY4ZG1yYlhxNmFzVE1pcVMrRGhPeTVE?=
 =?utf-8?B?NklLUUFSaWQ4QisybWdUUnN4cTNaSWxEMG82UGU2TjY4L0FpRzFkNWVUOU9o?=
 =?utf-8?B?eG5XNGtBVXNudnBTcEtDR0l3WXlLaVVkaWhYL0poZkI1YTE5Rkh5aXJtc2pl?=
 =?utf-8?B?Wk5jQmNjNFk4RHJqb24vWGsxejlSV2RvenQ4N05VUXN1cUxqMENZM29pU2lD?=
 =?utf-8?B?ZHA2OVBrdGRaOXN6Zmd3cUUxYWhnYVgzWHZNbTBnS3BvbXdwZ0pIcnVmbFlH?=
 =?utf-8?B?aDRnWnNrTmxIZ2MrbGwvcVlDc0Vpeld4OFh1VmR4Ni8rQ2Y4OWlPQ2svOU5t?=
 =?utf-8?B?eG5TWDQrNEpDWitQeEtnN2QweDkzVDFWN241SHppUHFwTE85KzQwbzRsV2ZH?=
 =?utf-8?B?cWRqVDZ3Yi9uMml6dWZ2dEVieU90eXVNeXVnYVhxZlNNRFFYTmhpbzh5VTBa?=
 =?utf-8?B?SjFLcjd6ZGNpdHNuZVNFSU1lNEVSWWdFUWlXWEFUWjFueEJ2RDdPYSsrdUJQ?=
 =?utf-8?Q?EuGA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d85ddab-3432-473e-30aa-08da90a898f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 08:11:42.0701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mviYnnykOhWanSXsUGzdAaJkTGfBneOisii9zVlCdZsDdSazGw9glhfLSM81ogD6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5999
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIDcgU2VwdGVtYmVyIDIwMjIgOTo1Mw0KPiBUbzogRWxpIENvaGVuIDxlbGljQG52aWRpYS5j
b20+DQo+IENjOiBtc3RAcmVkaGF0LmNvbTsgdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIHZkcGE6IGNvbmRpdGlvbmFsbHkgZmlsbCBtYXggbWF4IHF1ZXVlIHBhaXIg
Zm9yIHN0YXRzDQo+IA0KPiBPbiBXZWQsIFNlcCA3LCAyMDIyIGF0IDI6MTEgUE0gRWxpIENvaGVu
IDxlbGljQG52aWRpYS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiBGcm9tOiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCA3IFNlcHRlbWJlciAy
MDIyIDk6MDENCj4gPiA+IFRvOiBtc3RAcmVkaGF0LmNvbTsgamFzb3dhbmdAcmVkaGF0LmNvbTsg
RWxpIENvaGVuDQo+IDxlbGljQG52aWRpYS5jb20+Ow0KPiA+ID4gdmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
PiA+IFN1YmplY3Q6IFtQQVRDSF0gdmRwYTogY29uZGl0aW9uYWxseSBmaWxsIG1heCBtYXggcXVl
dWUgcGFpciBmb3Igc3RhdHMNCj4gPiA+DQo+ID4gPiBGb3IgdGhlIGRldmljZSB3aXRob3V0IG11
bHRpcXVldWUgZmVhdHVyZSwgd2Ugd2lsbCByZWFkIDAgYXMNCj4gPiA+IG1heF92aXJ0cXVldWVf
cGFpcnMgZnJvbSB0aGUgY29uZmlnLg0KPiA+IElmIHRoaXMgaXMgdGhlIGNhc2UgZm9yIG90aGVy
IHZkcGEgdmVuZG9yIGRyaXZlcnMsIHNob3VsZG4ndCB3ZSBmaXggaXQgdGhlcmU/DQo+IEFmdGVy
IGFsbCwNCj4gPiBjb25maWctPm1heF92aXJ0cXVldWVfcGFpcnMgc2hvdWxkIGFsd2F5cyBzaG93
IHZhbGlkIHZhbHVlcy4NCj4gDQo+IE5vdCBmb3IgdGhlIGNhc2Ugd2hlbiB0aGUgZGV2aWNlIGRv
ZXNuJ3Qgb2ZmZXIgTVEuIEFjY29yZGluZyB0byB0aGUNCj4gc3BlYywgdGhlIG1heF92aXJ0cXVl
dWVfcGFpcnMgZG9lc24ndCBleGlzdCBpbiB0aGlzIGNhc2UuDQo+IA0KSSBzZWUsIHRoYW5rcy4N
Cg0KPiA+DQo+ID4gPiBTbyBpZiB3ZSBmaWxsDQo+ID4gPiBWRFBBX0FUVFJfREVWX05FVF9DRkdf
TUFYX1ZRUCB3aXRoIHRoZSB2YWx1ZSB3ZSByZWFkIGZyb20gdGhlDQo+ID4gPiBjb25maWcNCj4g
PiA+IHdlIHdpbGwgY29uZnVzZSB0aGUgdXNlci4NCj4gPiA+DQo+ID4gPiBGaXhpbmcgdGhpcyBi
eSBvbmx5IGZpbGxpbmcgdGhlIHZhbHVlIHdoZW4gbXVsdGlxdWV1ZSBpcyBvZmZlcmVkIGJ5DQo+
ID4gPiB0aGUgZGV2aWNlIHNvIHVzZXJzcGFjZSBjYW4gYXNzdW1lIDEgd2hlbiB0aGUgYXR0ciBp
cyBub3QgcHJvdmlkZWQuDQo+ID4gPg0KPiA+ID4gRml4ZXM6IDEzYjAwYjEzNTY2NWMoInZkcGE6
IEFkZCBzdXBwb3J0IGZvciBxdWVyeWluZyB2ZW5kb3INCj4gc3RhdGlzdGljcyIpDQo+ID4gPiBD
YzogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy92
ZHBhL3ZkcGEuYyB8IDkgKysrKy0tLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZHBhL3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMNCj4gPiA+IGluZGV4IGMwNmMwMjcw
NDQ2MS4uYmMzMjgxOTcyNjNmIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGEu
Yw0KPiA+ID4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGEuYw0KPiA+ID4gQEAgLTg5NCw3ICs4OTQs
NiBAQCBzdGF0aWMgaW50IHZkcGFfZmlsbF9zdGF0c19yZWMoc3RydWN0IHZkcGFfZGV2aWNlDQo+
ID4gPiAqdmRldiwgc3RydWN0IHNrX2J1ZmYgKm1zZywNCj4gPiA+ICB7DQo+ID4gPiAgICAgICBz
dHJ1Y3QgdmlydGlvX25ldF9jb25maWcgY29uZmlnID0ge307DQo+ID4gPiAgICAgICB1NjQgZmVh
dHVyZXM7DQo+ID4gPiAtICAgICB1MTYgbWF4X3ZxcDsNCj4gPiA+ICAgICAgIHU4IHN0YXR1czsN
Cj4gPiA+ICAgICAgIGludCBlcnI7DQo+ID4gPg0KPiA+ID4gQEAgLTkwNSwxNSArOTA0LDE1IEBA
IHN0YXRpYyBpbnQgdmRwYV9maWxsX3N0YXRzX3JlYyhzdHJ1Y3QNCj4gdmRwYV9kZXZpY2UNCj4g
PiA+ICp2ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqbXNnLA0KPiA+ID4gICAgICAgfQ0KPiA+ID4gICAg
ICAgdmRwYV9nZXRfY29uZmlnX3VubG9ja2VkKHZkZXYsIDAsICZjb25maWcsIHNpemVvZihjb25m
aWcpKTsNCj4gPiA+DQo+ID4gPiAtICAgICBtYXhfdnFwID0gX192aXJ0aW8xNl90b19jcHUodHJ1
ZSwgY29uZmlnLm1heF92aXJ0cXVldWVfcGFpcnMpOw0KPiA+ID4gLSAgICAgaWYgKG5sYV9wdXRf
dTE2KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVAsDQo+ID4gPiBtYXhfdnFwKSkN
Cj4gPiA+IC0gICAgICAgICAgICAgcmV0dXJuIC1FTVNHU0laRTsNCj4gPiA+IC0NCj4gPiA+ICAg
ICAgIGZlYXR1cmVzID0gdmRldi0+Y29uZmlnLT5nZXRfZHJpdmVyX2ZlYXR1cmVzKHZkZXYpOw0K
PiA+ID4gICAgICAgaWYgKG5sYV9wdXRfdTY0XzY0Yml0KG1zZywNCj4gPiA+IFZEUEFfQVRUUl9E
RVZfTkVHT1RJQVRFRF9GRUFUVVJFUywNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBmZWF0dXJlcywgVkRQQV9BVFRSX1BBRCkpDQo+ID4gPiAgICAgICAgICAgICAgIHJldHVybiAt
RU1TR1NJWkU7DQo+ID4gPg0KPiA+ID4gKyAgICAgZXJyID0gdmRwYV9kZXZfbmV0X21xX2NvbmZp
Z19maWxsKHZkZXYsIG1zZywgZmVhdHVyZXMsICZjb25maWcpOw0KPiA+ID4gKyAgICAgaWYgKGVy
cikNCj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiA+ICsNCj4gPg0KPiA+IFNv
IHRoYXQgbWVhbnMgdGhhdCB5b3UgY2FuJ3QgcmVhZCBzdGF0aXN0aWNzIHdoZW4gTVEgaXMgbm90
IHN1cHBvcnRlZC4gSXMNCj4gdGhpcyB3b3J0aCBzYWNyaWZpY2luZz8NCj4gDQo+IHZkcGFfZGV2
X25ldF9tcV9jb25maWdfZmlsbCgpIHdpbGwgcmV0dXJuIDAgaW4gdGhlIGNhc2Ugb2YgIU1RLCBz
byBpdA0KPiBzaG91bGQgc3RpbGwgd29yay4NCg0KUmlnaHQsIG1pc3NlZCB0aGF0Lg0KDQpSZXZp
ZXdlZC1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+DQoNCj4gDQo+IFRoYW5rcw0KPiAN
Cj4gDQo+ID4NCj4gPiA+ICAgICAgIGlmIChubGFfcHV0X3UzMihtc2csIFZEUEFfQVRUUl9ERVZf
UVVFVUVfSU5ERVgsIGluZGV4KSkNCj4gPiA+ICAgICAgICAgICAgICAgcmV0dXJuIC1FTVNHU0la
RTsNCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi4yNS4xDQo+ID4NCg0K
