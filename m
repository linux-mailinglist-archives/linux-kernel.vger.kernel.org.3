Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C1A5A10A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241880AbiHYMfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241856AbiHYMe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:34:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18BBF54;
        Thu, 25 Aug 2022 05:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3K1vi8nWJAUCivI9Zxy2XJYOGEbDYx/OJ/iCjgEhf5H9IgExj8pgKOgISKaFVyMdLoB2OB2d7W8d8ZdevZwFL/g66xomCvKlgJ7xXTK6mFBSpBBxLNTDmInZTbBeZEsrZ3/+qKzT3ESnu2/0Xn/rdaNzC8GRvZ1CrxMPCm3EBGOU0PEP/4SzQmZ1u/RmcEsiECX8psPwKpLapLiNVMri+QWvN6eXGXSSqrEEUGhtjZyxbhQdfHp7ky+iAUBAI2xCp1LiZ5bhrAmv4S2mk+C1zxzNSoeH+DxIn9LHPL2ekYNiH/oRFeRcuNmwJLXadBrUlEdZE+V3/Mbwxi9sXObzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVMMvuI+bTUyjpVEBBR0yag4fdc/Qb+lvg1Z1mdbf00=;
 b=De0/EYelf/tRFTkPCKjquxwPAy0UITTPtFqeCl3dvUesL8BFxv+YEwNdLP3AW+EuSYgsjEuRr8HTUtLeNyj6INcW+HV0rDK+MYuKTwghnJyhQA3DYy2BrZA4xjjeansNEfarGVjDusUJEpytvHstDLh0hFDapHUB1xGkLfkf2mc1TtILElh7vsHDqVWPE/oHMaHZHacmKM35VUTucZwNUNRh4zi8sJJDd2hlG6jblSJFYPUOluQ5YXHhZ8HS3UpDJNzp0tpSieFqKOHlB3nSjk2C/fKS4XWsJevwmj/UPdhOB45dZLGTam3VkJIC22719wPQA74Qi3XyEw9oP5/0Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVMMvuI+bTUyjpVEBBR0yag4fdc/Qb+lvg1Z1mdbf00=;
 b=2/55X5bBDAtseUdr7PVtl4t10/wQexwqA4o2tb/4Er+Ao59WSuLMK67rzTVRrPstdmfeTCRDtRt1qy3iYP39XPIG4dJ2Z+2Sd+Mi9NdJp35lpThZM3qR+ANhpZWMfZMTfwWfeUymssJi7VdDTqxgmRVP1Est8UG5i/D8aLoUUCc=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 12:34:54 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::a970:8eb0:b1f7:5e7c]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::a970:8eb0:b1f7:5e7c%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 12:34:54 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: amd_pstate: Fix initial highest_perf value
Thread-Topic: [PATCH] cpufreq: amd_pstate: Fix initial highest_perf value
Thread-Index: AQHYr/1oNZjThL11hEumtiR+22VBlq2/lB+AgAAJskA=
Date:   Thu, 25 Aug 2022 12:34:54 +0000
Message-ID: <DM4PR12MB5278CCE07E02DB88212CED819C729@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220814164421.330891-1-Perry.Yuan@amd.com>
 <CAJZ5v0gdHvLLPrvj7cq2ki6xDH=X6qpXBfyVTFNa5wNqY7Sh5g@mail.gmail.com>
In-Reply-To: <CAJZ5v0gdHvLLPrvj7cq2ki6xDH=X6qpXBfyVTFNa5wNqY7Sh5g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-25T12:33:38Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d39ec1d1-81da-420b-977b-88d09af7eaaf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-25T12:34:51Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 6ea7055f-f9a8-4687-a152-a02b2e338c75
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 009e1744-f968-4da3-c8c3-08da869636b2
x-ms-traffictypediagnostic: MN0PR12MB6003:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Qqn7orExMw635kaQn/B7M6CUmmQRHDi/hcRamZ0tLKF09mB22XZoJiK7FEOVTFDVyYT99vk1ofiJjMQ+JFMlU8ZEcL71TeWwWFDOqnn45TWidYgZp1dPnysI/qG1wfWIQwO3xA0j96gepaup3/jJMuWpUYcYI2XkVY0nihLjybuEjU5rfUoiGlx6T2aJ+s3Go5RjhvyUR47r6OiEnrnytgL/uYPyUimatyRmE63NfDpklcl4ZEZNQI1nRMe3KGTIKCf8zregEnZH6aoOIq2QJ7aIF+s8DFPO0Ip19cwbHu58iuof4QSbfEKaAo0amr7E3cGv1PHI1/BA98a5vJYzNUcv8uNnK8Fgln0qaye8yJwRCMUayayZ6461F4DSKc7Hcm6ZN7QA8pVQ/7EGaLcyZuAPi5F2nkw0PhiORXaGh35dQO6A1zB4GpWna/m/skDOaV+6w9H2H8g8hZQrTVGHs5TT09uToFAq2M4s3AQ2WwBwwr7+9aCp81FajiGPWtvV/K6aeVe4+nJSPYfQStyYguN0tK+K7+CcUxtgFOF4mWmdUgtEuNOmydKHCmsq1hxiiHIi9RQlGGA7I68FiKc3YXM2USM0CUOT6XvG+2R926pDv0mREpYS51pPcLLNGnddmCwqylWBWdESJjfvgcPBFgfcd3o97X/mW95ZMCXqrpOphP0JOpHiRy24KlpqIxeHgYaXoA3IvpMMFseTSB3LslJ0h5Qjtk3iBJ+bhtXd0ZBXGkvYsIB6hRQB1FErpUS8M+ApGVd1ebANDKgGhPvgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(38070700005)(4326008)(8936002)(5660300002)(478600001)(38100700002)(83380400001)(41300700001)(122000001)(186003)(52536014)(33656002)(86362001)(9686003)(26005)(6506007)(53546011)(8676002)(55016003)(7696005)(2906002)(64756008)(66446008)(316002)(76116006)(54906003)(6916009)(66946007)(66476007)(71200400001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azNzVjBUQ1h5VzZaUGpjeDA4MTJtVW5hTVNWVGRPMnBTdjFwenlqNkIyWE50?=
 =?utf-8?B?Q2cwSDRSVmNvcW5KWW5JNXpTRG1YQ0s2aEo0WFBzVHU3TXVxTVliTTRtcjdR?=
 =?utf-8?B?dElaL1F5VDg1dXlWSTFNTXpxYTFvTzdwQmVsL1hvSTFRMVdUSnM4SUgvYVVu?=
 =?utf-8?B?L3FoZGt5WVFaNHRjd2w3Zy9Ha3Z0TXlWVkVTaEEwd2ljREg4eE1FMGhFblQ5?=
 =?utf-8?B?SHkxTVZ2ODZvQ1pwWSszR1hVZEdZalAwZHVKMTh6TSs5ZjBBWlJ0Ym1teURV?=
 =?utf-8?B?NzI0SU9qdFlrb1hCYkEyNEJvTDVzUDRKMmxNb2l6T3NESm5jRnNVbDVoS2lv?=
 =?utf-8?B?a2c5WXNnY25RN0ZudEYzMWFKcC94eWs5R2M3Sm9adTZZWnZxVFZwcVp0bGkr?=
 =?utf-8?B?QVMrVUJWdU1kcjV0c0hFankwczhDWkRZcU14S2M2QjdCR0VNaVhPRHdSWlVE?=
 =?utf-8?B?bGYvZ0VweFVJWkpIRnFxZThXenJndGFabGdNVDJ0aFB6QzF4dmVNWllLUC9t?=
 =?utf-8?B?RFJMbmUwVmVuWnN2SDFMVUZxT0JFcmJubG1aaDJyN3hwMERKY3JoeFo0Vk9y?=
 =?utf-8?B?OFJWR3NPQmw2bzlKbjlHcmMyUW5weTZWSGwvbk5GaXc4czNHV2xqYlhDWkoy?=
 =?utf-8?B?Y0RveUwwa1FqV3lIR2RPaERtTXVDSDRQN01ldTc4U0dMcDRWQUFROTdJYXZG?=
 =?utf-8?B?dUNiRkR1MzlTemgxUENkRWl4YVVlbnJ0V2NWNWExVnR3MnZhTzN2ZEg2UUNY?=
 =?utf-8?B?NkE1M1VhclB2cisrTkh1eUN6aFdZMzFsS0Z5QTM0TGhGMFFMelJIMis1b0VH?=
 =?utf-8?B?Nk5Ga3UrZytkcGRBZDg5NjM0S1JrMGpLN1FiTmU1a083V1U2VkJpZ1ZERXA2?=
 =?utf-8?B?aVJDWFNZT1lld25QU3hpd2gyMTdheStZK1FpK0RoNGhLemxyS1NGbVZNOHJ0?=
 =?utf-8?B?TE5DRkhpSWpLUlpsVlRRYWlGTU5SSG1MaGVNMjZIc1pIMFp4MFNvTHU4YjU1?=
 =?utf-8?B?b0xIM3hnc3lMN0l5RzhvbEMzdnZka1VRalFldUgvVkEwbGltNW5uZEpMVHYw?=
 =?utf-8?B?KzZycE90bXd2a0RUTTA4U2hxdysyaGhlMXIrSlUraGNqUmxsNU1BRkZEdjBu?=
 =?utf-8?B?cFhuZ1ZJR1F6cGM1T1p1RzR3ZGlUU0dGbWxUcm9Lc0xLVndUNnNzS1lGbU8r?=
 =?utf-8?B?d2VDcFhENXVTY0sveGZKOTVvYXZZTjZjMmdaMVl2TzVVYU9lSE5Ka01iV0Yw?=
 =?utf-8?B?cHhuU0k2ZG1qVit4bGk3eXgxTjVpN3ZvOHVRaXVibytITDMwMWN2ZUJnSFI1?=
 =?utf-8?B?WWhwUEc0bVdYK0RsM25WQ3NpVGI5aUhTWWlscVQ4Qld3bS8zbGEwUWhWVWd0?=
 =?utf-8?B?dWtoMGcxWWE0K2xtSDZCcEVhcmhMOXVFbnp4WW5oWE9MS1drV1JFeW1SMWY3?=
 =?utf-8?B?VDZMTGZxZkg2aVVzb1NuUW1tQkFlLzRVWTJmTlFTWGJka1NRdHZlczUrOWVW?=
 =?utf-8?B?U0d2ekUvZEFPb0k2SlE1bm0xS0hSQ2pINEM5MzlYSlgwMUE4ZnVSRGZDUHBV?=
 =?utf-8?B?NVh0czVpdU85SFdhd2ZpaEd2MjlSMkNkQnhEK1JXWXBsQmtEUnVKUURqVGVG?=
 =?utf-8?B?RXpUZzQ5TForREVDZ1oxRWJLRVdOTWNZKzZnV1FwUlBrRTVnUDkvaWVocitu?=
 =?utf-8?B?WDlvMjlZRW9UQTZDMXVsWWtuT3J6ajUrS0ZhM04vWEk0dm51WkM3bWROaThL?=
 =?utf-8?B?RG9kc05ieTlTWHFYWGwyQnhmMXVJR1ZHUEtjbVRVLzNxN3B4QUptTmdHZW5w?=
 =?utf-8?B?dDlLREo1aEFqbDdvakZ5MXhmZnFkU3ZUTy9MR3RlRklYSWhxTk9GNHBHWHdN?=
 =?utf-8?B?aE9HZG9oVC9NemdFTUFRMjBVM01XZEt6NS96ZXJPNzNmWGZCNkFqRERUci9X?=
 =?utf-8?B?L2lSS2lwL2xjcGRFVGhsQVd4azZrM0EzbnlZNVpVNXJyMjZ1UHVlRWY0Tm8z?=
 =?utf-8?B?b2JaNlNUeEQzbDdMc0xQYmRnTldncEl4OU9zQXNPWWQ4d3lmdmFvU1V5VlVV?=
 =?utf-8?B?ZXJHNnMzT096REtxM0hWSFo1dXpQREczTVZaMmdqeTJSaXFoc2l3Yjl0dkx3?=
 =?utf-8?Q?3m3HBbFZNozxhKzJk+WmOPIAc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009e1744-f968-4da3-c8c3-08da869636b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 12:34:54.6780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19MqvqOK7QGNh+SliVmFqarL06lhc2P714pU6hPhyVcvBFYVGT6CUdzRWblt4btuu1gmbxoWENEzKVcZD59pLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJhZmFlbCwNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVs
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjUsIDIwMjIgNzo1OSBQTQ0K
PiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gQ2M6IFJhZmFlbCBXeXNv
Y2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT47IEh1YW5nLCBSYXkNCj4gPFJheS5IdWFu
Z0BhbWQuY29tPjsgVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz47IFNoYXJt
YSwNCj4gRGVlcGFrIDxEZWVwYWsuU2hhcm1hQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8N
Cj4gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBGb250ZW5vdCwgTmF0aGFuDQo+IDxOYXRo
YW4uRm9udGVub3RAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT47IFN1LCBKaW56aG91IChKb2UpIDxKaW56aG91LlN1QGFtZC5jb20+Ow0K
PiBIdWFuZywgU2hpbW1lciA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuDQo+
IDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywgTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQu
Y29tPjsgTGludXgNCj4gUE0gPGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz47IExpbnV4IEtlcm5l
bCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBjcHVmcmVxOiBhbWRfcHN0YXRlOiBGaXggaW5pdGlhbCBoaWdoZXN0
X3BlcmYgdmFsdWUNCj4gDQo+IFtDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbF0NCj4gDQo+IE9uIFN1
biwgQXVnIDE0LCAyMDIyIGF0IDY6NTcgUE0gUGVycnkgWXVhbiA8UGVycnkuWXVhbkBhbWQuY29t
PiB3cm90ZToNCj4gPg0KPiA+IFRvIGF2b2lkIHNvbWUgbmV3IEFNRCBwcm9jZXNzb3JzIHVzZSB3
cm9uZyBoaWdoZXN0IHBlcmYgd2hlbiBhbWQNCj4gPiBwc3RhdGUgZHJpdmVyIGxvYWRlZCwgdGhp
cyBmaXggd2lsbCBxdWVyeSB0aGUgaGlnaGVzdCBwZXJmIGZyb20gTVNSDQo+ID4gcmVnaXN0ZXIN
Cj4gPiBNU1JfQU1EX0NQUENfQ0FQMSBhbmQgY3BwY19hY3BpIGludGVyZmFjZSBmaXJzdGx5LCB0
aGVuIGNvbXBhcmUgd2l0aA0KPiA+IHRoZSBoaWdoZXN0IHBlcmYgdmFsdWUgZ290IGJ5IGNhbGxp
bmcgYW1kX2dldF9oaWdoZXN0X3BlcmYoKSBmdW5jdGlvbi4NCj4gPg0KPiA+IFRoZSBsb3dlciB2
YWx1ZSB3aWxsIGJlIHRoZSBjb3JyZWN0IGhpZ2hlc3QgcGVyZiB3ZSBuZWVkIHRvIHVzZS4NCj4g
PiBPdGhlcndpc2UgdGhlIENQVSBtYXggTUh6IHdpbGwgYmUgaW5jb3JyZWN0IGlmIHRoZQ0KPiA+
IGFtZF9nZXRfaGlnaGVzdF9wZXJmKCkgZGlkIG5vdCBjb3ZlciB0aGUgbmV3IHByb2Nlc3MgZmFt
aWx5IGFuZCBtb2RlbA0KPiBJRC4NCj4gPg0KPiA+IExpa2UgdGhpcyBsc2NwdSBpbmZvLCB0aGUg
bWF4IGZyZXF1ZW5jeSBpcyBpbmNvcnJlY3QuDQo+ID4NCj4gPiBWZW5kb3IgSUQ6ICAgICAgICAg
ICAgICAgQXV0aGVudGljQU1EDQo+ID4gICAgIFNvY2tldChzKTogICAgICAgICAgIDENCj4gPiAg
ICAgU3RlcHBpbmc6ICAgICAgICAgICAgMg0KPiA+ICAgICBDUFUgbWF4IE1IejogICAgICAgICA1
NDEwLjAwMDANCj4gPiAgICAgQ1BVIG1pbiBNSHo6ICAgICAgICAgNDAwLjAwMDANCj4gPiAgICAg
Qm9nb01JUFM6ICAgICAgICAgICAgNTYwMC41NA0KPiA+DQo+ID4gRml4ZXM6IDM3NDNkNTViMjg5
YzIgKHg4Niwgc2NoZWQ6IEZpeCB0aGUgQU1EIENQUEMgbWF4aW11bQ0KPiBwZXJmb3JtYW5jZQ0K
PiA+IHZhbHVlIG9uIGNlcnRhaW4gQU1EIFJ5emVuIGdlbmVyYXRpb25zKQ0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gDQo+IFRoaXMgbmVlZHMg
dG8gYmUgcmV2aWV3ZWQgYnkgdGhlIEFNRCBQLXN0YXRlIGRyaXZlciBtYWludGFpbmVyLg0KDQpU
aGVyZSBpcyBvbmUgc21hbGwgY2hhbmdlIGZvciB0aGlzIHBhdGNoICwgd2lsbCBzZW5kIFYyIGZv
ciBmdXJ0aGVyIHJldmlldy4NCg0KUGVycnkuIA0KDQoNCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCAxNCArKysrKysrKysrKystLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gYi9kcml2ZXJzL2NwdWZy
ZXEvYW1kLXBzdGF0ZS5jIGluZGV4IDlmNDM3NWY3YWI0Ni4uZjc3OGFiMzdlNDM2IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiArKysgYi9kcml2ZXJz
L2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gQEAgLTM1NCw2ICszNTQsNyBAQCBzdGF0aWMgaW5s
aW5lIGludCBhbWRfcHN0YXRlX2VuYWJsZShib29sIGVuYWJsZSkNCj4gPiBzdGF0aWMgaW50IHBz
dGF0ZV9pbml0X3BlcmYoc3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhKSAgew0KPiA+ICAgICAg
ICAgdTY0IGNhcDE7DQo+ID4gKyAgICAgICB1MzIgaGlnaGVzdF9wZXJmOw0KPiA+DQo+ID4gICAg
ICAgICBpbnQgcmV0ID0gcmRtc3JsX3NhZmVfb25fY3B1KGNwdWRhdGEtPmNwdSwgTVNSX0FNRF9D
UFBDX0NBUDEsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZjYXAx
KTsgQEAgLTM2NSw3ICszNjYsMTEgQEANCj4gPiBzdGF0aWMgaW50IHBzdGF0ZV9pbml0X3BlcmYo
c3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhKQ0KPiA+ICAgICAgICAgICoNCj4gPiAgICAgICAg
ICAqIENQUEMgZW50cnkgZG9lc24ndCBpbmRpY2F0ZSB0aGUgaGlnaGVzdCBwZXJmb3JtYW5jZSBp
biBzb21lIEFTSUNzLg0KPiA+ICAgICAgICAgICovDQo+ID4gLSAgICAgICBXUklURV9PTkNFKGNw
dWRhdGEtPmhpZ2hlc3RfcGVyZiwgYW1kX2dldF9oaWdoZXN0X3BlcmYoKSk7DQo+ID4gKyAgICAg
ICBoaWdoZXN0X3BlcmYgPSBhbWRfZ2V0X2hpZ2hlc3RfcGVyZigpOw0KPiA+ICsgICAgICAgaWYg
KGhpZ2hlc3RfcGVyZiA+IEFNRF9DUFBDX0hJR0hFU1RfUEVSRihjYXAxKSkNCj4gPiArICAgICAg
ICAgICAgICAgaGlnaGVzdF9wZXJmID0gQU1EX0NQUENfSElHSEVTVF9QRVJGKGNhcDEpOw0KPiA+
ICsNCj4gPiArICAgICAgIFdSSVRFX09OQ0UoY3B1ZGF0YS0+aGlnaGVzdF9wZXJmLCBoaWdoZXN0
X3BlcmYpOw0KPiA+DQo+ID4gICAgICAgICBXUklURV9PTkNFKGNwdWRhdGEtPm5vbWluYWxfcGVy
ZiwNCj4gQU1EX0NQUENfTk9NSU5BTF9QRVJGKGNhcDEpKTsNCj4gPiAgICAgICAgIFdSSVRFX09O
Q0UoY3B1ZGF0YS0+bG93ZXN0X25vbmxpbmVhcl9wZXJmLA0KPiA+IEFNRF9DUFBDX0xPV05PTkxJ
Tl9QRVJGKGNhcDEpKTsgQEAgLTM3NywxMiArMzgyLDE3IEBAIHN0YXRpYyBpbnQNCj4gPiBwc3Rh
dGVfaW5pdF9wZXJmKHN0cnVjdCBhbWRfY3B1ZGF0YSAqY3B1ZGF0YSkgIHN0YXRpYyBpbnQNCj4g
PiBjcHBjX2luaXRfcGVyZihzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEpICB7DQo+ID4gICAg
ICAgICBzdHJ1Y3QgY3BwY19wZXJmX2NhcHMgY3BwY19wZXJmOw0KPiA+ICsgICAgICAgdTMyIGhp
Z2hlc3RfcGVyZjsNCj4gPg0KPiA+ICAgICAgICAgaW50IHJldCA9IGNwcGNfZ2V0X3BlcmZfY2Fw
cyhjcHVkYXRhLT5jcHUsICZjcHBjX3BlcmYpOw0KPiA+ICAgICAgICAgaWYgKHJldCkNCj4gPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPg0KPiA+IC0gICAgICAgV1JJVEVfT05DRShj
cHVkYXRhLT5oaWdoZXN0X3BlcmYsIGFtZF9nZXRfaGlnaGVzdF9wZXJmKCkpOw0KPiA+ICsgICAg
ICAgaGlnaGVzdF9wZXJmID0gYW1kX2dldF9oaWdoZXN0X3BlcmYoKTsNCj4gPiArICAgICAgIGlm
IChoaWdoZXN0X3BlcmYgPiBjcHBjX3BlcmYuaGlnaGVzdF9wZXJmKQ0KPiA+ICsgICAgICAgICAg
ICAgICBoaWdoZXN0X3BlcmYgPSBjcHBjX3BlcmYubm9taW5hbF9wZXJmOw0KPiA+ICsNCj4gPiAr
ICAgICAgIFdSSVRFX09OQ0UoY3B1ZGF0YS0+aGlnaGVzdF9wZXJmLCBoaWdoZXN0X3BlcmYpOw0K
PiA+DQo+ID4gICAgICAgICBXUklURV9PTkNFKGNwdWRhdGEtPm5vbWluYWxfcGVyZiwgY3BwY19w
ZXJmLm5vbWluYWxfcGVyZik7DQo+ID4gICAgICAgICBXUklURV9PTkNFKGNwdWRhdGEtPmxvd2Vz
dF9ub25saW5lYXJfcGVyZiwNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
