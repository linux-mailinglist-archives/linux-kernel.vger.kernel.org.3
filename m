Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5950D571122
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 06:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiGLEPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 00:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLEPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:15:17 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214CC2F003;
        Mon, 11 Jul 2022 21:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cqo6FUISHCkY45WKXwbYfJExt9r+rIqlb+8KTOeyBU0ypzavZz6HBl6EqNG0tews8kyI1DeGXFX3rnnZ+rObvYT+QU925XFusayxh9pErHDC5h8cTzG3okuvCoB/HwoW6+q/kFRn1mMgyumK2imA9gGW47gXxwtuSyDt8IOkjXqJKqhlRBCcqxJ/lLTGGvAsixT+2q9SEpHtdx/7x3bgCzTYTyOWoX+wzTRcFs+pYo1qjW0G0WVVxMgT9uyIkI1V9HIUm6GPbTewGcwefyxoLo0Xs3EwLkRPnakAARyT7VeZcaDfF+7vn91UqwFlJNzeEDvjv1PEM/2N2WFDizcJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gvYYZl9rGOq8hGf0kjLWk8sEdpC8Saz36IUuv9kgOg=;
 b=Nj4FFt8Z3DmNbw3vHsEtuhdycePqRedawAJEcBK3CRev599iuu7gVwTDgRgwa2ZLzOmrMAj0lPQGvDt876anNiDL5TTJm3CfsqjCoC7JzrJJwvpGqAEeCY/kgmY0tI5LRATzGOucydSoN1/nd/SAOX25Wyqzm3jpzuhgqxuS8zBE6ITlEZ8T0ntR9fj4ZxPEbpRg4Th2BEeSrY2XDYwC9DKi3GmBDjonLOuYu7JyxXoS1EQiNhR9eSYztb7cHwSt0GXw/7rdBcK65VVMAbLkTfE6lSZk7TSQZONDxkjAtAkwOkp+lPRyA8JsGZiDHycJI0+Dy0Tb9s7ZFo5jJRz0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gvYYZl9rGOq8hGf0kjLWk8sEdpC8Saz36IUuv9kgOg=;
 b=pxyJTgM9yM/dtTQh1IoP2/TyUsR6pGI24PcplPvZCyt/I3n0w2c45GOsvbI2/7+Nbr00P+SYDNM+gfUiubkETyDMzWqDcr+4HsLfm685jNGer34u3OpCiwd1BhggXv5LF+x5jU0SvgHWR3LZ9duO9fYWw43z3rTEBkpWD8HIjBw=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DM5PR12MB1194.namprd12.prod.outlook.com (2603:10b6:3:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 04:15:13 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a%9]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 04:15:13 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Huang, Ray" <Ray.Huang@amd.com>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 02/14] cpufreq: amd-pstate: enable AMD Precision Boost
 mode switch
Thread-Topic: [PATCH v2 02/14] cpufreq: amd-pstate: enable AMD Precision Boost
 mode switch
Thread-Index: AQHYk560lIvujgnT0EuuWczVmO3sba15kRYAgACSf9A=
Date:   Tue, 12 Jul 2022 04:15:12 +0000
Message-ID: <DM4PR12MB527807833BAE794396B4B6149C869@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220709141739.834950-1-Perry.Yuan@amd.com>
 <39717316-281a-6c3a-4228-54210e5320dd@amd.com>
In-Reply-To: <39717316-281a-6c3a-4228-54210e5320dd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-12T04:15:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0a119bf3-5f4b-4cfb-be45-fc5169db09b0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-12T04:15:10Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: c93744e3-53c2-4fcd-aae3-23a206d08efc
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c16e1fa-a10f-4b52-12f6-08da63bd1e05
x-ms-traffictypediagnostic: DM5PR12MB1194:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n4OiqU8d32IOrE97trW1VNsfScTUQ8dXadxj+zFe5liTXZk/0SMaJl9e7JMFectikLYWmRw0Vq0O4s0iLfquHyrh41SORHq+teychaj7cX0Ol/s4SSc7sL8wcun1NurUGvJUcVgFTs7T3Hcx7JTHk5dLD1pHRIZWuOvoiu66ZvJ96ZTFtHzKF+0q+QoU3p38e6sZcK0HkOS2l8A/Nl/dhDPPGrLkeHAL0NwzSk/zsMXgRlGuHkTQzRSVaG2wE0o6s7UcVvp4jD551OOQOESZ2UFcZphFN/T1YR4G486r66K9zOCDA+Udn5HYC7pua/FAuPJv+CDkBLfleJv81WgBKsKP2MFOiaC0Swv8v9SL5yJi5yoipWq3Zfgx4c/x5cdD7Fq7bjXUYtnnS2od7Z19Qn9Pe4pVnNHWeFxb3O7lrDvN6rsG1QQrYyko5HUelqnZkzq8wwaYX1EnXYeyiE8nOKgAJoM7LoIYrsstLHOLG0hBYASmwThqUqvB5T9Ydfw5dNQ+nabVqW9CP9T8Yu7JqmWgHx33IGiei+ymzMnP2HCLEvqOo5BYX+Dt+/zZ13eplng98lpJBGgucg9tKuGQnhoabUUEi3QqhmLjIG2aSUdG8CDRB3rW0CV2BAb9T952EZfdbxnm86SMrw4VrI8aG1uE9GiMkX/gMe/3NmjhkBdEUt4k61UQbiTs34h2XjM203KV9bIT3QkCoFMJzHidI8F62AgpS/KssNYvZzL4saEh0lPPr2uRohIyb0cVfRh0TN4lfIBgeQpKVuVn/ZZX+ZinTkrWG5WRES99jfEUJ9y6gfavwGGAeo5Xzv51YDtV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(6506007)(9686003)(186003)(53546011)(26005)(7696005)(66476007)(83380400001)(41300700001)(66946007)(38070700005)(38100700002)(8936002)(76116006)(478600001)(52536014)(2906002)(5660300002)(33656002)(64756008)(71200400001)(54906003)(86362001)(110136005)(55016003)(4326008)(6636002)(8676002)(122000001)(66446008)(316002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWVkWnJwajJSYWdLNFNpajdBUGlqYkR3ekFTODFnYmJpZWFWUFhOeE9kTUxH?=
 =?utf-8?B?ajdrY2g1ME9sYlNBTFNlbEQzaS84THM0SEZxR0pYYUFGUTVwaDhBcE1jNEVJ?=
 =?utf-8?B?bGE0U2dtN2luRGQxOGFJdWVHOVJvRjZFYS9aNEx1WlloUWNLelM5ZEZZWHZQ?=
 =?utf-8?B?OVIwVHhCMmF2UDdsdEczQkNjVlV0VlFxUjZHR1FXdXJxamk1SEVleFV2MWZB?=
 =?utf-8?B?YmhiK1BjOVJORjhzQkttY1o3UWo3K09LK3ZYVmpDcVhhemYvd2pucHp3WWRj?=
 =?utf-8?B?R2l6Sno5dTdid3lsZXlIL0VrUHlVa3ptUklOZzNYU3prck9hS0JRQzlic05Q?=
 =?utf-8?B?OE5GL3BWWGlBVG16T3VTV0dnL21rYmlqSFV0aUNqNVlVYTNhK0k5bWhLUDc0?=
 =?utf-8?B?NTZISmIycy9hK1hDTk5VSllYbkwvNW5SS2FDMjZWOGJtMkRERXRIdngvQ3p2?=
 =?utf-8?B?dFdIcmRSZzlrc2hKbmp3T0NrVVRwRXFtUXJQSDZpc2hQMkcwQnRBb0djMkF5?=
 =?utf-8?B?cXZKRGFvbGs1ZzNMd0pGZlZTYmx6TlRuR0xma2FvMFdJMXU4N3lPUFhOL1Zp?=
 =?utf-8?B?SHJFWm15bjdad2NtL1hCMXpwUjg5U0paRjJhSlNXeURwOHhpZXF3b3dnempQ?=
 =?utf-8?B?L2xQOXQ0aTMwTlFSS0lHY2ExVFNCMDAwMHpJeTlGSmhkY2ZBenpXSWhtSWRm?=
 =?utf-8?B?citwNUZLb282bURtM3JIMVJSTDludEFlanpyazNUZlhsMHdtTk9mM2ZYRWtT?=
 =?utf-8?B?NktlQnd5VHpLeXZ0MFIwWEc1VExRRFgra2g2RzVQbHdtWTRFZUpNVmNTdFBh?=
 =?utf-8?B?Ly93eFg1a2htbmVldHE0RCtUYlpva1MwSVZCWUhtVnpnYVR0ZUYwV0pzeVZr?=
 =?utf-8?B?UmxmT1RWdVRkdEpQcjJ3bUZDSVYwQTk2Znhma1gxZmQ3aVNrS045UmtNOU51?=
 =?utf-8?B?RFgrNkJoUEdYVG53eTd5OWttMC9KVWdCWjFLWkRWWVVmNHZXRUFKTTlxM2V1?=
 =?utf-8?B?cTl3eDE5a0k4VDBZdEFrUTNjWEhld2U1czJ6SzBjNWx2akNkUHlkaGFicjNG?=
 =?utf-8?B?WSt4OWViRVhpeXBGeHpjRVVZdHVtclVHemhxWndxSjNMVmVoQVcvdko2QUtI?=
 =?utf-8?B?ZElic3FHRlRMTDk3VkJ5amh4eCtvaUNVTTJwaVM0dFVXdCttVjdzZXJKNGJa?=
 =?utf-8?B?UTV1cmNxYXdibUkwZjl0TzdIOStyRUF5YkRyUHNzMDBsWXE4NjV4KzRNSzJu?=
 =?utf-8?B?OTN1eTZvb2xsRGVndGtIOTZuL25wRW5ucXhqQ3pwdUpCY2l6U1VrUkxXZ0th?=
 =?utf-8?B?OG4yOGJGQnJxUUhHa1hsem1RdmU3Skk2NFlnZytuaTNQNmlTZFduZDRreXhC?=
 =?utf-8?B?R3dpTDhtS1hXelR6emR2SUlKSjJoRGJIWTR4YXFSNEgvaCtKM2xRZ2xyZEw3?=
 =?utf-8?B?RTV2ZnRmRGpmdGs1YWVXbU5Eb3RJbncwNzBIMDNxdVNxT3RzNDNOT1JJUUhK?=
 =?utf-8?B?REdSUEpHYWVXMTJWeGI5dHFpZzdWNDlZWkt3QytyMjJadGh6V25xRDdaQThB?=
 =?utf-8?B?djlaMm5DU01JU0pJellsdDZSRFAyKzdxa3dWN3NSemg0RUM1QWdZQWdrTWJ5?=
 =?utf-8?B?c3dudmZta1NLSlJWRGZGa05uSFVVMDJZSWUzVHFLYStpV3RIZnd3bTRSbU9t?=
 =?utf-8?B?YlAwWXhNSmM0c2xYNkd4TjI2OXpNNElTSzN6dXcwRW4vNytRUFU2TlNEVlRG?=
 =?utf-8?B?OFcxMXYyY29wVnlZRWN2RTBVTVpEd0p6VklHVi9TMkZEcEd5SE1nbFFoeDh2?=
 =?utf-8?B?aU5HcVZiak05Z1hTMEVhTkpCcCs5OUdtUVFoSDRYOC9qQytJdllYNFJuZmRJ?=
 =?utf-8?B?OG9STTRHMXBPbzZNSnZDbkxTRjZnZkwwTXdxdjU5N2tBaDBMci9iZjdiUzRk?=
 =?utf-8?B?d0hWNENoZWVGbHViMEUrckMwTW1tUm1vL21jcGloancrbDJ5WHpyZVpaUy9Y?=
 =?utf-8?B?WG9SaDdHOWwwWkFnVE1ZZTZjVmVDMnFVYjlROGNkZ1NXYlAwMnQrNjV5Mmhn?=
 =?utf-8?B?OURVdUI5RldyZ2phRjRoVjJ2NnZqeTdMcUs3Vy9HYUNRODJWK0cvRWx2SjhT?=
 =?utf-8?Q?tedw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c16e1fa-a10f-4b52-12f6-08da63bd1e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 04:15:12.9651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +n+BV6bH4gPK2Ui5veVl9Z/KqziYHtvZL1luhCdBZvjObiSsmGYCO3UV2jPXgx5facXkNJYkrtn3lIvEp/R1Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1194
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
Rm9udGVub3RAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVseSAxMiwgMjAyMiAzOjI3IEFN
DQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgcmFmYWVsLmoud3lzb2Nr
aUBpbnRlbC5jb207DQo+IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBIdWFuZywgUmF5IDxSYXku
SHVhbmdAYW1kLmNvbT4NCj4gQ2M6IFNoYXJtYSwgRGVlcGFrIDxEZWVwYWsuU2hhcm1hQGFtZC5j
b20+OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBG
b250ZW5vdCwgTmF0aGFuDQo+IDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT47IERldWNoZXIsIEFs
ZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFN1LCBKaW56aG91IChKb2Up
IDxKaW56aG91LlN1QGFtZC5jb20+Ow0KPiBIdWFuZywgU2hpbW1lciA8U2hpbW1lci5IdWFuZ0Bh
bWQuY29tPjsgRHUsIFhpYW9qaWFuDQo+IDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywgTGkg
KEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtDQo+IHBtQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDAyLzE0XSBjcHVmcmVxOiBhbWQtcHN0YXRlOiBlbmFibGUgQU1EIFByZWNpc2lvbg0KPiBCb29z
dCBtb2RlIHN3aXRjaA0KPiANCj4gT24gNy85LzIyIDA5OjE3LCBQZXJyeSBZdWFuIHdyb3RlOg0K
PiA+IEFkZCBzdXBwb3J0IHRvIHN3aXRjaCBBTUQgcHJlY2lzaW9uIGJvb3N0IHN0YXRlIHRvIHNj
YWxlIGNwdSBtYXgNCj4gPiBmcmVxdWVuY3kgdGhhdCB3aWxsIGhlbHAgdG8gaW1wcm92ZSB0aGUg
cHJvY2Vzc29yIHRocm91Z2hwdXQuDQo+ID4NCj4gPiB3aGVuIHNldCBib29zdCBzdGF0ZSB0byBi
ZSBlbmFibGVkLCB1c2VyIHdpbGwgbmVlZCB0byBleGVjdXRlIGJlbG93DQo+ID4gY29tbWFuZHMs
IHRoZSBDUFUgd2lsbCByZWFjaCBhYnNvbHV0ZSBtYXhpbXVtIHBlcmZvcm1hbmNlIGxldmVsIG9y
DQo+IHRoZQ0KPiA+IGhpZ2hlc3QgcGVyZiB3aGljaCBDUFUgcGh5c2ljYWwgc3VwcG9ydC4gVGhp
cyBwZXJmb3JtYW5jZSBsZXZlbCBtYXkNCj4gPiBub3QgYmUgc3VzdGFpbmFibGUgZm9yIGxvbmcg
ZHVyYXRpb25zLCBpdCB3aWxsIGhlbHAgdG8gaW1wcm92ZSB0aGUgSU8NCj4gd29ya2xvYWQgdGFz
a3MuDQo+ID4NCj4gPiAqIHR1cm4gb24gQ1BVIGJvb3N0IHN0YXRlIHVuZGVyIHJvb3QNCj4gPiAg
IGVjaG8gMSA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdWZyZXEvYm9vc3QNCj4gPg0KPiA+
IElmIHVzZXIgc2V0IGJvb3N0IG9mZix0aGUgQ1BVIGNhbiByZWFjaCB0byB0aGUgbWF4aW11bSBz
dXN0YWluZWQNCj4gPiBwZXJmb3JtYW5jZSBsZXZlbCBvZiB0aGUgcHJvY2VzcywgdGhhdCBsZXZl
bCBpcyB0aGUgcHJvY2VzcyBjYW4NCj4gPiBtYWludGFpbiBjb250aW5vdXNseSB3b3JraW5nIGFu
ZCBkZWZpbml0ZWx5IGl0IGNhbiBzYXZlIHNvbWUgcG93ZXINCj4gPiBjb21wYXJlZCB0byBib29z
dCBvbiBtb2RlLg0KPiA+DQo+ID4gKiB0dXJuIG9mZiBDUFUgYm9vc3Qgc3RhdGUgdW5kZXIgcm9v
dA0KPiA+ICAgZWNobyAwID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1ZnJlcS9ib29zdA0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8UGVycnkuWXVhbkBhbWQuY29tPg0K
PiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaCB8ICAyICsrDQo+
ID4gIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgICAgIHwgMjIgKysrKysrKysrKysrKysr
KysrKy0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWlu
ZGV4LmgNCj4gPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci1pbmRleC5oDQo+ID4gaW5kZXgg
ODY5NTA4ZGU4MjY5Li5iOTUyZmQ2ZDY5MTYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vbXNyLWluZGV4LmgNCj4gPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3It
aW5kZXguaA0KPiA+IEBAIC01NTksNiArNTU5LDggQEANCj4gPiAgI2RlZmluZSBBTURfQ1BQQ19N
SU5fUEVSRih4KQkJKCgoeCkgJiAweGZmKSA8PCA4KQ0KPiA+ICAjZGVmaW5lIEFNRF9DUFBDX0RF
U19QRVJGKHgpCQkoKCh4KSAmIDB4ZmYpIDw8IDE2KQ0KPiA+ICAjZGVmaW5lIEFNRF9DUFBDX0VO
RVJHWV9QRVJGX1BSRUYoeCkJKCgoeCkgJiAweGZmKSA8PCAyNCkNCj4gPiArI2RlZmluZSBBTURf
Q1BQQ19QUkVDSVNJT05fQk9PU1RfQklUCTI1DQo+ID4gKyNkZWZpbmUgQU1EX0NQUENfUFJFQ0lT
SU9OX0JPT1NUX0VOQUJMRUQNCj4gCUJJVF9VTEwoQU1EX0NQUENfUFJFQ0lTSU9OX0JPT1NUX0JJ
VCkNCj4gPg0KPiA+ICAvKiBBTUQgUGVyZm9ybWFuY2UgQ291bnRlciBHbG9iYWwgU3RhdHVzIGFu
ZCBDb250cm9sIE1TUnMgKi8NCj4gPiAgI2RlZmluZSBNU1JfQU1ENjRfUEVSRl9DTlRSX0dMT0JB
TF9TVEFUVVMJMHhjMDAwMDMwMA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvYW1k
LXBzdGF0ZS5jDQo+ID4gYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIGluZGV4IDlhYzc1
YzFjZGU5Yy4uMTg4ZTA1NWUyNGEyDQo+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJl
cS9hbWQtcHN0YXRlLmMNCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+
ID4gQEAgLTEyMiw2ICsxMjIsNyBAQCBzdHJ1Y3QgYW1kX2NwdWRhdGEgew0KPiA+DQo+ID4gIAl1
NjQgZnJlcTsNCj4gPiAgCWJvb2wJYm9vc3Rfc3VwcG9ydGVkOw0KPiA+ICsJdTY0IAljcHBjX2h3
X2NvbmZfY2FjaGVkOw0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyBpbmxpbmUgaW50IHBzdGF0
ZV9lbmFibGUoYm9vbCBlbmFibGUpIEBAIC00MzgsMTggKzQzOSwyNyBAQA0KPiA+IHN0YXRpYyBp
bnQgYW1kX3BzdGF0ZV9zZXRfYm9vc3Qoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3ksIGlu
dA0KPiA+IHN0YXRlKSAgew0KPiA+ICAJc3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhID0gcG9s
aWN5LT5kcml2ZXJfZGF0YTsNCj4gPiAgCWludCByZXQ7DQo+ID4gKwl1NjQgdmFsdWU7DQo+ID4N
Cj4gPiAgCWlmICghY3B1ZGF0YS0+Ym9vc3Rfc3VwcG9ydGVkKSB7DQo+ID4gIAkJcHJfZXJyKCJC
b29zdCBtb2RlIGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhpcyBwcm9jZXNzb3Igb3INCj4gU0JJT1Nc
biIpOw0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ICAJfQ0KPiA+DQo+ID4gLQlpZiAoc3Rh
dGUpDQo+ID4gKwlyZXQgPSByZG1zcmxfb25fY3B1KGNwdWRhdGEtPmNwdSwgTVNSX0FNRF9DUFBD
X0hXX0NUTCwNCj4gJnZhbHVlKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsN
Cj4gPiArDQo+ID4gKwlpZiAoc3RhdGUpIHsNCj4gPiArCQl2YWx1ZSB8PSBBTURfQ1BQQ19QUkVD
SVNJT05fQk9PU1RfRU5BQkxFRDsNCj4gPiAgCQlwb2xpY3ktPmNwdWluZm8ubWF4X2ZyZXEgPSBj
cHVkYXRhLT5tYXhfZnJlcTsNCj4gPiAtCWVsc2UNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJdmFs
dWUgJj0gfkFNRF9DUFBDX1BSRUNJU0lPTl9CT09TVF9FTkFCTEVEOw0KPiA+ICAJCXBvbGljeS0+
Y3B1aW5mby5tYXhfZnJlcSA9IGNwdWRhdGEtPm5vbWluYWxfZnJlcTsNCj4gPiAtDQo+ID4gKwl9
DQo+ID4gIAlwb2xpY3ktPm1heCA9IHBvbGljeS0+Y3B1aW5mby5tYXhfZnJlcTsNCj4gPiArCVdS
SVRFX09OQ0UoY3B1ZGF0YS0+Y3BwY19od19jb25mX2NhY2hlZCwgdmFsdWUpOw0KPiANCj4gRG9l
cyB0aGUgZW50aXJlIE1TUiB2YWx1ZSBuZWVkIHRvIGJlIGNhY2hlZD8gV2Ugb25seSBjYXJlIGFi
b3V0IHRoZQ0KPiBib29zdCBlbmFibGVkIGJpdCBzbyBpdCBtYXkgYmUgYmV0dGVyIHRvIGp1c3Qg
Y2FjaGUgdGhhdC4NCj4gDQo+IC1OYXRoYW4NCg0KSSB0aGluayB0aGUgd2hvbGUgTVNSIHZhbHVl
IHNob3VsZCBiZSBjYWNoZWQsIGJlY2F1c2UgaXQgaGFzIG5vIGJhZCBpbXBhY3QgdG8gdGhlIGhh
cmR3YXJlIG9yIGRyaXZlciAuDQpBbmQgaXQgaXMgc2ltcGxlIHRvIGRvIHRoYXQsIHdoZW4gd2Ug
bmVlZCB0byBjaGVjayBvdGhlciBiaXRzIGluIHRoZSBoYXJkd2FyZSBjb25maWd1cmF0aW9uIE1T
UiBpbiBmdXR1cmUsIHdlIGNhbiBzdGlsbCB1c2UgdGhpcyBjYWNoZWQgdmFsdWUgYXMgd2VsbC4N
CkRvc2UgaXQgbWFrZSBzZW5zZSA/DQoNClBlcnJ5Lg0KDQo+IA0KPiA+ICsJd3Jtc3JsX29uX2Nw
dShjcHVkYXRhLT5jcHUsIE1TUl9BTURfQ1BQQ19IV19DVEwsIHZhbHVlKTsNCj4gPg0KPiA+ICAJ
cmV0ID0gZnJlcV9xb3NfdXBkYXRlX3JlcXVlc3QoJmNwdWRhdGEtPnJlcVsxXSwNCj4gPiAgCQkJ
CSAgICAgIHBvbGljeS0+Y3B1aW5mby5tYXhfZnJlcSk7DQo+ID4gQEAgLTQ3OCw2ICs0ODgsNyBA
QCBzdGF0aWMgaW50IGFtZF9wc3RhdGVfY3B1X2luaXQoc3RydWN0DQo+IGNwdWZyZXFfcG9saWN5
ICpwb2xpY3kpDQo+ID4gIAlpbnQgbWluX2ZyZXEsIG1heF9mcmVxLCBub21pbmFsX2ZyZXEsIGxv
d2VzdF9ub25saW5lYXJfZnJlcSwgcmV0Ow0KPiA+ICAJc3RydWN0IGRldmljZSAqZGV2Ow0KPiA+
ICAJc3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhOw0KPiA+ICsJdTY0IHZhbHVlOw0KPiA+DQo+
ID4gIAlkZXYgPSBnZXRfY3B1X2RldmljZShwb2xpY3ktPmNwdSk7DQo+ID4gIAlpZiAoIWRldikN
Cj4gPiBAQCAtNTQyLDYgKzU1MywxMSBAQCBzdGF0aWMgaW50IGFtZF9wc3RhdGVfY3B1X2luaXQo
c3RydWN0DQo+ID4gY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkNCj4gPg0KPiA+ICAJcG9saWN5LT5k
cml2ZXJfZGF0YSA9IGNwdWRhdGE7DQo+ID4NCj4gPiArCXJldCA9IHJkbXNybF9vbl9jcHUoY3B1
ZGF0YS0+Y3B1LCBNU1JfQU1EX0NQUENfSFdfQ1RMLA0KPiAmdmFsdWUpOw0KPiA+ICsJaWYgKHJl
dCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsJV1JJVEVfT05DRShjcHVkYXRhLT5jcHBjX2h3
X2NvbmZfY2FjaGVkLCB2YWx1ZSk7DQo+ID4gKw0KPiA+ICAJYW1kX3BzdGF0ZV9ib29zdF9pbml0
KGNwdWRhdGEpOw0KPiA+DQo+ID4gIAlyZXR1cm4gMDsNCg==
