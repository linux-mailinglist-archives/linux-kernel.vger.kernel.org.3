Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6092656C828
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 10:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiGIIt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 04:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGIItz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 04:49:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30A85924B;
        Sat,  9 Jul 2022 01:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS5vS0sKhpHpm49bX0zUWtF0h3HNNGS5cWLhHUGiVxeTZDDE7cCvs7ekTsIvKryg6ku7Q7w5A1TzRiwfwzCUhcLtz8iHAk3nxa7WeHT9nbFxzCkeliS9I+pXXHkkIs429yHcsKQRlsil4p3UEWqd6PT9mmjEOHBnvBkXvcU5l+e3amgdkgJGduORTX9ZFPMx5Ne3UJmST0I/JK5v8B5XBCZIrcN4v/MgfnF4XJYny0rCyIhRpyhzUzcOxABw9IXN+T+mSatAeRVReZsBo+hitiSXfAcSLtCoBJhrHRBSbjbHIg+/S1BdkVcf3J7FE95CNiyJhrhisEQMJUHyVO/6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeFWY9vO5Ty3Wby/qJDC8DFKveUAIY9ffFLTWVLiLp4=;
 b=AnTuCsQj2SMHKXk8V52fVTwlKlDzaV5bG/jWsKLZFKuES28DoOTyJ6m8XH5/kqsQafUzRW5RKzneC4J8/VdWQQBsDjXx8KogETZoOYihdC6aLB2FKRr5xxxCOunQ/t/YCMjJ5nRisyeoQ+yY1XH/GZunOKNmFMaz68u6R0RGOeyus6W1FH/mCzrpbfFKVI317tu6hVY5hkOXLrZ+G7uMymBCx8A04r/X8244WG3K6b53tdhFe/zS3hu9ilb2q2LlaeHHDqo2g2+wJPswItMImvYx7OJm8FWVSqUU5+ghxWWWBkqI2ziNwDBunCiAl3Os7uQtovBgPpBRMlrTz9pbDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeFWY9vO5Ty3Wby/qJDC8DFKveUAIY9ffFLTWVLiLp4=;
 b=Jv9wzev6trDWv0Wk4Zq0FEBTTROaKN+sejMuYQDIK98xATPrsdyZBX+VB0dDpc0LU8//coMu0P9vnEuQBOY9wYa6cWH2ZJcg8+HHMNy5aFjCo6CkvmTjyrBREi3nVtbi7cnmx7oytltFJRjumVtvNLAcKlCD3xAhRC1y+BNoIRo=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Sat, 9 Jul 2022 08:49:51 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a%9]) with mapi id 15.20.5417.023; Sat, 9 Jul 2022
 08:49:50 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Subject: RE: [PATCH 07/12] cpufreq: amd_pstate: map desired perf into pstate
 scope for powersave governor
Thread-Topic: [PATCH 07/12] cpufreq: amd_pstate: map desired perf into pstate
 scope for powersave governor
Thread-Index: AQHYkiMY/MAFENa+RUS0FhnjdwE0I61zUygAgAJqDhA=
Date:   Sat, 9 Jul 2022 08:49:50 +0000
Message-ID: <DM4PR12MB52786E4AEE69C9AF9E3A975B9C859@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220707170022.216202-1-Perry.Yuan@amd.com>
 <c25cbc3f-11c6-aca6-af7d-a4d7aa91e1ae@amd.com>
In-Reply-To: <c25cbc3f-11c6-aca6-af7d-a4d7aa91e1ae@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-09T08:49:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ab0e80cf-bbc1-48ae-b258-6bc16fd04e86;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-09T08:49:48Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 437802d8-78f4-4ebe-9605-840b88118fe9
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47eec4b1-3188-47ee-b9ff-08da6187fc58
x-ms-traffictypediagnostic: DS7PR12MB5837:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xkZiUOBGPrnoYwmNCGtOsQ67PFRqkFemfHTx5vrW6HnrRT4I1rgjLxN3xb5JktHD7GmazmZynzPrSF8pquBN2LRVKF8YvdDjm8xcNFL1w9GW4PoDNs22t3hncXh2Tfvl4MuqwvrugfAaho0KpU8GpOgaTk9JfIpexzYAdtbRZiB58cv36MtAsy9mU61UObcoC4aKGXFRPhPHRwN2vfwmChzHXH5sstL25TeRX+Hcjg0y0Am+zeihxyHBtD90JRuxndsZ6n7kFTyEzs+eS3KzRy9XnzHw0ZsiBfrVvSZh0/we/hJB4+53QXXOqskGhvrEhxS3kvqvI708Gk0I8v6IR3vHxGlP6/QBoKUvpTAhzZtFI5u8c0GeDyd4qFTWaz0f57G5h+cfBlJ8nNwxFPR7lVpISj0T+8J/c1OKvKRbgr7bwUASYCVrt2KNo9f11uTlwAlggP3vYpExu0K9Uf1FK6sHqi9A04uVQ9B49mBWXThyLRWfEkUPDCUbKSu8pG7q9TqyPjN8sxKvUu28Ixr1pS20F7Ep8oM0N14VyrqfevcFKtfWDrq2r1MHFJrgg4LNkUwtSNn+q7vidbRQTh0iHTQS92fepbJTwMVqXtcb85cf4Wx3yC7dD5hbmmuIyKDUea+lcfwCYDSAAqtuZyXWl69jKHwa3233Zh+xkPbOKFxEwC4CEpxaog/nwfcRooWoxdt8LxHuher2eDeJ6PuHItHTegijI9TmtUtKH+kSCzFyTeGunutj3Vog10VmupZ/jtiAphxh2pucocOwocEibBdc8GIMGxOfQveSjxwzhnFsho+72DecJxTJrLerZ5ch
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(2906002)(76116006)(66476007)(71200400001)(478600001)(53546011)(55016003)(4326008)(52536014)(86362001)(54906003)(110136005)(316002)(41300700001)(26005)(7696005)(66946007)(9686003)(64756008)(8676002)(66446008)(6506007)(186003)(122000001)(38070700005)(83380400001)(38100700002)(8936002)(33656002)(5660300002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzBRNkFiNDVYWWxYck10SnNTUC9UM0FmS05hNUlsSHpGVGN1dW04alBTYVhh?=
 =?utf-8?B?eGRjd3RMWTQ4MXdJOVpweVVhcklsbkxZQktDWTZiRVFYVXh5Tkcra3ZPNkZo?=
 =?utf-8?B?OEdPci9STWY2L0JuSmVpYzRZOU51SlYwdUF2c21VQ1JxcHhoTUxZRWtjZGhz?=
 =?utf-8?B?TWFPZVRzcjJ2dUlXajFheWZ3S2xEQ1JNR09oUm11UTY1cHhSSFR3bHdmNzN6?=
 =?utf-8?B?N1pndXN3cUc2d2Zic2xHVWk1VlloaHF2RnpVUGdybHZoczRzV2RhaGtHSkdL?=
 =?utf-8?B?TGVwVjQ5N2lZVDIxcHdnR1pDTVJqdUl0M0RmZHo2cTEyR0huS0d2cGpEYmdt?=
 =?utf-8?B?R3JkVnRaMmt0enkveHRYV2d5L3MyLy90NDlzRCt5ajZ5SWhvM1NiMWNLUzZp?=
 =?utf-8?B?YWNja3BZRjh5UUlvTkRkQUtqN2J5YU1QT0JJN0hVQWlvZm9zU3ptR0tlbHVu?=
 =?utf-8?B?SDkzYnNzT1A5U1NKRENhTFZPQnltTWRCVFFMdXd1Z2V3bWxhbjdnQWtlWk9q?=
 =?utf-8?B?emU1a2ttT0cwZ3l3aUtIYXRUOTVwZXJGVlNNSnBnQ2tvTWZRMUNjU1lrSHVQ?=
 =?utf-8?B?K0VpRFdVbzFjR2RlS0ZwVFBXOHJlQWJ3UmNiMW5CZlRKMXZWKzROVjB1Rk0x?=
 =?utf-8?B?QzFzRkJLMnZzVzZCd0lQalltVDlzRHFEbXY2NWo3SG9IVGVxOUhURGt5RDdN?=
 =?utf-8?B?cWowN1U0ODV0NXdxdUNVVnZvUDBKUFNFQUdXNlprWFRoVEFxdkpTLzIwbSth?=
 =?utf-8?B?VmVrR2ViRzg5bk1vV01oeFNMUFgrNS9Zd09NdFJlVWNnNnQ0b2ZIL0t0WHBj?=
 =?utf-8?B?K0Z2ckFnYkUxekdEMVVQVWM3R0RZa0NvWFBWN05tTFJqVlZ4QmozdmdMM2c4?=
 =?utf-8?B?K0dxZVlOMEtLdDFFcTFxUytWUWRpRnZ3OUh0OTZFV04yVmM2RjFsM3UvbG1T?=
 =?utf-8?B?QlJxMHY0cWR3RzNOUjdCWGRWVGE1SExoQXAyRnkzQXJvVVpqQVI3cEV4ZW5s?=
 =?utf-8?B?ZnQ2THBXMVdEcDBHQ0pMNHpKUkRnUDVZWUJrN2pkTWpZVGxJVGFjTFdvUldG?=
 =?utf-8?B?OGk5Q01pNDQ1eXJEcGZ3ODFZYUU2YkcxR1kycFZHYkFQTmtNV1psMUJSZWVw?=
 =?utf-8?B?U2llRjExVktIdStsN3FXcXdxdm1UcWE3QkZ5TTFKc1ZTOTduMHFlZ2t6ODhX?=
 =?utf-8?B?WTA1TlVINDY1a0Y1MHBKMllvamJsVVVEUWNGTVhhdHlRYzdzTzFBMHlzb3dF?=
 =?utf-8?B?T1NwUjY3b1ZYTnVCWWQzczZVL2h1QWwvNUJTVTdIU08rSWg5bWh5UGZjODNS?=
 =?utf-8?B?djQvTm5sRnczblZpbjdiaEZPNkdEM3dDOE5LSW4rOG5yYisyWDZTSUFPNTFp?=
 =?utf-8?B?OEdZdXE4dkt0RGNCZWN6dXhDdWtNYkdENmJNNk9sSGhHQ0M2dXVjbFp4dkFQ?=
 =?utf-8?B?M0ZSWitPYzVIQ2liZDlTWU5FZk80VnV2RGJmeDRtU01kTDIxSkg3NnZtQUl3?=
 =?utf-8?B?eWRZeExIVWQzbS9LdW53L05nS0dNTi9xdC9pY1NramtlYWlZYzdHU29WcVdy?=
 =?utf-8?B?UTlyRnQvZENDcmZvR2VOaG9vTEhnbXdOWEc4a0p2T3Z1WUdObTEvNHFSM3pp?=
 =?utf-8?B?WXJKelFHUS9qRWV6TGpINCtYQlBlZTE4NVY1MGdkTGxqOU5IT3hCU2JYYkth?=
 =?utf-8?B?YUpTRm15bU9KTDgzOTdqT2V4MHpGa2xWM2ZiaE1ZUkxZbHRraFdkRVI2dVhW?=
 =?utf-8?B?cmQ0dG90T3lydHc0UkRQVUkzd2VycTZ6c1NNUFkrNHY3OGN5VzVNSkJSRkMw?=
 =?utf-8?B?dHBNWWQ2ODNiQTFtblJzQ3g2K3FvYlBtMTNaVjdsdjgxdnVBNGYyRWI5L1c4?=
 =?utf-8?B?aUdTUEpIc1ZlQWF2dnYrZVJHK0dNZGdKdVFucGQ1K2l2RXF4eEdaOGtFbW5z?=
 =?utf-8?B?dWJKMXQ0ZnFpNUYwdE55bEFjUW53cmlHSnJ3THhMRkc1Tk1hVTRXcnhNNzRi?=
 =?utf-8?B?UXZYb2JyNWNYRGlESElYM29pNjJ2R0V2UGFHekFnS0w3aEhKam94ZEF4cVZz?=
 =?utf-8?B?ejc0REJDQmNXNU5QRmRQVjNoK281cnJEcGF2U3RMVjNyT2R6UDhaZHpVVjB3?=
 =?utf-8?Q?A47A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47eec4b1-3188-47ee-b9ff-08da6187fc58
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2022 08:49:50.8185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3Ec1EYXFbqsLzNmxurJDTPYgkhKa8xl5YZJwakvbeHR6fObBa78LlwwHP2WtvnbCjgSixi1SHfcsohoggCQrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE5hdGhhbjoNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGb250ZW5vdCwgTmF0aGFuIDxOYXRoYW4u
Rm9udGVub3RAYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDgsIDIwMjIgMzo1NyBBTQ0K
PiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5qLnd5c29ja2lA
aW50ZWwuY29tOw0KPiB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgSHVhbmcsIFJheSA8UmF5Lkh1
YW5nQGFtZC5jb20+OyBSYWZhZWwgSi4NCj4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBs
aW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiBTaGFybWEsIERlZXBhayA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPjsgTGltb25jaWVs
bG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgRm9udGVub3QsIE5hdGhh
bg0KPiA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBTdSwgSmluemhvdSAoSm9lKSA8SmluemhvdS5TdUBh
bWQuY29tPjsNCj4gSHVhbmcsIFNoaW1tZXIgPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IER1LCBY
aWFvamlhbg0KPiA8WGlhb2ppYW4uRHVAYW1kLmNvbT47IE1lbmcsIExpIChKYXNzbWluZSkgPExp
Lk1lbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwNy8xMl0gY3B1ZnJlcTogYW1k
X3BzdGF0ZTogbWFwIGRlc2lyZWQgcGVyZiBpbnRvDQo+IHBzdGF0ZSBzY29wZSBmb3IgcG93ZXJz
YXZlIGdvdmVybm9yDQo+IA0KPiBPbiA3LzcvMjIgMTI6MDAsIFBlcnJ5IFl1YW4gd3JvdGU6DQo+
ID4gVGhlIHBhdGNoIHdpbGwgZml4IHRoZSBpbnZhbGlkIGRlc2lyZWQgcGVyZiB2YWx1ZSBmb3Ig
cG93ZXJzYXZlDQo+ID4gZ292ZXJub3IuIFRoaXMgaXNzdWUgaXMgZm91bmQgd2hlbiB0ZXN0aW5n
IG9uIG9uZSBBTUQgRVBZQyBzeXN0ZW0sIHRoZQ0KPiA+IGFjdHVhbCBkZXNfcGVyZiBpcyBzbWFs
bGVyIHRoYW4gdGhlIG1pbl9wZXJmIHZhbHVlLCB0aGF0IGlzIGludmFsaWQNCj4gPiB2YWx1ZS4g
YmVjYXVzZSB0aGUgbWluX3BlcmYgaXMgdGhlIGxvd2VzdF9wZXJmIHN5c3RlbSBjYW4gc3VwcG9y
dCBpbg0KPiA+IGlkbGUgc3RhdGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXJyeSBZdWFu
IDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY3B1ZnJlcS9hbWQt
cHN0YXRlLmMgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+IGIvZHJp
dmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBpbmRleCA3YzUxZjQxMjUyNjMuLjE1NGVlZDg0OWYz
OA0KPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4g
KysrIGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+IEBAIC0zMTcsNiArMzE3LDcg
QEAgc3RhdGljIGludCBhbWRfcHN0YXRlX3RhcmdldChzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kNCj4g
KnBvbGljeSwNCj4gPiAgCWRlc19wZXJmID0gRElWX1JPVU5EX0NMT1NFU1QodGFyZ2V0X2ZyZXEg
KiBjYXBfcGVyZiwNCj4gPiAgCQkJCSAgICAgY3B1ZGF0YS0+bWF4X2ZyZXEpOw0KPiA+DQo+ID4g
KwlkZXNfcGVyZiA9IGNsYW1wX3QodW5zaWduZWQgbG9uZywgZGVzX3BlcmYsIG1pbl9wZXJmLCBt
YXhfcGVyZik7DQo+ID4gIAljcHVmcmVxX2ZyZXFfdHJhbnNpdGlvbl9iZWdpbihwb2xpY3ksICZm
cmVxcyk7DQo+ID4gIAlhbWRfcHN0YXRlX3VwZGF0ZShjcHVkYXRhLCBtaW5fcGVyZiwgZGVzX3Bl
cmYsDQo+ID4gIAkJCSAgbWF4X3BlcmYsIGZhbHNlKTsNCj4gDQo+IFRoZSBjbGFtcGluZyBvZiB0
aGUgZGVzaXJlZCBwZXJmIHZhbHVlIHNob3VsZCBiZSBtb3ZlZCB0bw0KPiBhbWRfcHN0YXRlX3Vw
ZGF0ZSgpLiBUaGUgb25seSBvdGhlciBjYWxsZXIgb2YgYW1kX3BzdGF0ZV91cGRhdGUoKSBpcw0K
PiBhbWRfcHN0YXRlX2FkanVzdF9wZXJmKCkgd2hpY2ggYWxyZWFkeSBjbGFtcHMgdGhlIGRlc2ly
ZWQgcGVyZiB2YWx1ZQ0KPiBiZWZvcmUgbWFraW5nIHRoZSBjYWxsLg0KPiANCj4gLU5hdGhhbg0K
DQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCkFkZCB0aGlzIGNoYW5nZSBpbnRvIFYyLg0K
DQpQZXJyeS4NCg==
