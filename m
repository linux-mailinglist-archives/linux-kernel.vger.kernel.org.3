Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991B456B8DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbiGHLqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbiGHLqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:46:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97B0904D9;
        Fri,  8 Jul 2022 04:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKpu5Qcz1WZt6AIEeZapN25Wx+OTHSCscIOwW91yt2sqxo9dTNWs30PuG/THYqO0efZ4IE+WhE4PboxJQjlAENU0IcOWQqIScHevhUhOdz7E10iUPg3mBNby1vrKTTgwKRShupd5G7q+tKujYjaTAR8goxZbHatE6YyZCDOIZbX3C2t7syIa63D1hTAUgVArOIXBJSQoXBxazHxhjvtrxwhdu1aSAa5tEGI/dnMMkfV2GV47ZhPcty7+igYvRVYLk0biqP43E/8tBzY7a4LMFdSbpmHpnaNMflL4l5XzIXU5HxdgpbQO9DPnF2CXcCYvkoUfoiJyir1qHDAkE2ZxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oM+V1tu14v1E8B1TRjkqZuA7W5b3RQAL99H4GFG5KF4=;
 b=N4MNagsr+NSNDhNKGim1a3+sShBMw1BYuVFgWcPIA1IjSOdeUmK4cMzv2NSi4yOSckSMZ1T+UALcnj0Uv5ky+nngWJRDM78DqWkiPnSGt2R6jPheLJekvjMYTAfSBULvWzyAKcELsX8snCe/FV+jxMvSd4SZmUoM/GTzo/ExWs9qzSGcEMqMXilIzNwkIu3y8xOkcVNYuJo84IRjx6/2wrKtj7e6hX56jbl1yYt1rYuNvuScm/8z3mBttNxIF86iUWaXH+gQqnE6PaO+P+e+fEUddx13uBKQfCCcjocF5Luo5mXW+9gsscskjMFH9L2IN8Y2Gnj8Ltdz+dqsiIol3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM+V1tu14v1E8B1TRjkqZuA7W5b3RQAL99H4GFG5KF4=;
 b=pqmr7+W5ma6pdAaWf+wqukvgNIPxEBcpPVd55TGD/HmsPKvRQgqlUYzS2nE7OkCOy+xDmHlaAHI44EjtEb3aWtqtvL0X9406YwNLvbn48zIJABQJyd3qx3jZOUknMUMg3eZaMylr3TxVVU0VCs0iQ9yPB5ifCi1kk2H5Axs56bY=
Received: from CH0PR12MB5265.namprd12.prod.outlook.com (2603:10b6:610:d0::22)
 by CY4PR1201MB2519.namprd12.prod.outlook.com (2603:10b6:903:d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 8 Jul
 2022 11:46:47 +0000
Received: from CH0PR12MB5265.namprd12.prod.outlook.com
 ([fe80::4c8e:9d96:2b0e:fc0f]) by CH0PR12MB5265.namprd12.prod.outlook.com
 ([fe80::4c8e:9d96:2b0e:fc0f%7]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 11:46:47 +0000
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
Subject: RE: [PATCH 10/12] cpufreq: cpufreq: export cpufreq cpu release and
 acquire
Thread-Topic: [PATCH 10/12] cpufreq: cpufreq: export cpufreq cpu release and
 acquire
Thread-Index: AQHYkiMt1Hx3em0pB0WRD43QktKRLq1zTosAgAENKlA=
Date:   Fri, 8 Jul 2022 11:46:47 +0000
Message-ID: <CH0PR12MB5265A2BD890DDA357FD7969D9C829@CH0PR12MB5265.namprd12.prod.outlook.com>
References: <20220707170103.216736-1-Perry.Yuan@amd.com>
 <2a08a95d-6524-4f54-e6d2-76b43696ec0b@amd.com>
In-Reply-To: <2a08a95d-6524-4f54-e6d2-76b43696ec0b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-08T11:46:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fe4c9f36-de71-4dca-a012-94b70d0534a0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-08T11:46:44Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: dead4f3f-7737-4495-ab05-36ecbdc15806
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35fa520f-99bf-4443-6214-08da60d789c8
x-ms-traffictypediagnostic: CY4PR1201MB2519:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vq6sStvX9088eCydOarNEh2BM6a7tSkUA3kxamctWXFeJTIh3LjrzNOlRQRG7FLAwHL5DTFegjCVdMR8cXaiR+mGsWoUdpKbfvAgaMQs2qvvbR3bHGY25AWLJxJpd+pSzt7x4wShuTqF8EV9C0GzcPuhsitTL8dUJ8WvCapzDknW1MElFCTukz2bEboWzlWnm6+N8GZoazRCB1TFzjCnlwmQO0ErYipEG/Kd5XdjTL2BUtWDJpzP7mqlMp/j01bnsbNWqo6PCx0ufXjHd9cwEIldc2IZpDbxhpSZHQe68Z5zQnwbc86Japz8cJaoE4ch11mwgImOCH0x/TarPlxF4PZrfkCzT3E6l5e6x2rspIXq2zsa86/SLAAYV/lRGiawCAaWtVr4tQIjRHVXAi7bKrgNla/QJR8rbWA8a2Hc+KITYLLEHO+cQPF4LvnK7XrbDmDX0WgNJlBBpYZi97+XhMZq+mfdtGTOG6SELhTbHw7pmhA2z6/vPpVFrmL+4z6qVyEBhbsufxWNqYAwL3KwZ1BllXdgaFfG4mKrv8bztz32kr67HsICyDwODgUlkn73LA1/UUXZ64RgORrL7mtCdZn3wc22GoXh8z2XxK8AVIsXAi4nt4exOdYMwjHhkFsnOostwSwJgd0pvnLG2bNLezBB/ZpeOOnVhEWOYxxBTfgyqQTFRlhHGplnDRScyWmtpV2OJuPZGJvjgQleBxueUvpU49W8GpZoYKWy2w6HsrS+iVIBycjpXHzhYzBU03IJHj7Wx/QxzDuIAf4S+6/6Hlb3geRwy6viX8/3I2A3haDRWFPcMxEnlOjsXOF2vViW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(4326008)(66946007)(64756008)(186003)(38070700005)(7696005)(54906003)(110136005)(41300700001)(6506007)(71200400001)(55016003)(26005)(122000001)(53546011)(316002)(83380400001)(66446008)(66476007)(9686003)(38100700002)(8676002)(52536014)(8936002)(5660300002)(86362001)(76116006)(2906002)(66556008)(478600001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUtyN3BoS05xZGRpUi90UEkrWHQ0TlJjaEJmTEt5UUdKMXYzNHZOR3RycUZl?=
 =?utf-8?B?VHJLNWJ1eTgrSk5LejhQSG00b1BqRVk2T2tUckdhVm9GeEJPcUQ1YVNISDVy?=
 =?utf-8?B?MEEvRUFjTGozQ3M4S1BhMUNaUTlZRlQvZUdQV0ZkNjVrM0toY1FyWGRxMEZJ?=
 =?utf-8?B?MzlhMFErckpiRWs0cHc1Qi8zeFR1U0JudHJDWGIxb3d2TnEwZ1VURE9BeVhl?=
 =?utf-8?B?d0Z6UlFrTmRQbXBGZmhDcnRWYzJiVFJhRFVKT2lLVTBIOGRWeUtYdC9mUSt1?=
 =?utf-8?B?cVZYcytIRU9JeTl3RitDbzMwZ2JZWHVtOEdaTDdWeVRZMDFLSkExNGdHNFoy?=
 =?utf-8?B?K0JIZU8rQ0dzaDdacUp4RlVjTVNvWXQ0NWN2UzBCelVIb0NaZHlEbmZ4dmhW?=
 =?utf-8?B?VUdvR3JjRmE0c3pHdkF0YURVSUs2aWMybmJyTVhmcUpaRS9zV0VGREJ0dkZ6?=
 =?utf-8?B?dkQ3U0R2RWs4ZXA5NmVlZlZJcFJpZWg2OVovcExMcmk1cTM0dGdYWVVJNWpH?=
 =?utf-8?B?UjQwMHZ3UXh3LzNMbVpJK1doWWQvaHU3YVMxa09wanlsTzhZMmQ2Q1ZHdEVi?=
 =?utf-8?B?YURvN3JUZlZuN2RhbmNJMDlPeng4QUhuN1Bvalo0QThuS2Joa1JoRnV6Skh3?=
 =?utf-8?B?V0dUeGozVWdGbHZVNVJqTXRiTy9CdjQ3czVidGdXcmZMS1B0Ri9XT09jRVY1?=
 =?utf-8?B?YkhGWmNvWnY2OEE5RVQrWG5UakpsSUdDSUZFMS9zQ0o1T1Z0RlYwcUFVZTJQ?=
 =?utf-8?B?aDNKMjJHSW43b1UxS3dvUEcvcU9QMzNDOWY2RGw0eXBCVmxoNHc5dENLeC9O?=
 =?utf-8?B?TjI4QkhLNmRFcU1VUVplc01aTkFjY3JQNEh0QnJBTzEvSURuZEZGakIwY253?=
 =?utf-8?B?NE1tWkE5ZlRaTTF6VlVDM1RNSjhLOVQ0VUVnUGFoQ3I2d1hSUHU3QitTZDhR?=
 =?utf-8?B?dXhzWENDWUxUMUVxS0ZnRHhmWHZ0YXA0Q1ZDQlROZU1ERjBsWDQ3ZFdzV2hO?=
 =?utf-8?B?SWJhVW5keHpoYlVXeEtMSU1EeE13R0I0Tjc3YVZURHJGaDdqYWZSbys2Vm5h?=
 =?utf-8?B?cVNRR1hsZGdlMXV2QWN2UFZpcFBGMnR0eU54d3B1bk14Q3lIU1hHVmhiQ0U1?=
 =?utf-8?B?YThvOVNLcFNTelVsNlNaZlFlU2tkUTNnZzJHaG92YjJmSmNpKys1OGNkRHVX?=
 =?utf-8?B?VnI2R3BuS3ExdHJlaXJuWUFGWHlmK1RKMlVFT0V0bWRjTXBEMFBZSVhGT2lU?=
 =?utf-8?B?VkRWTHQycDRveHg5RnFqMjFOc2Joek1kcVhhN3R3SEZGcjlEUzJQUXBXdUFh?=
 =?utf-8?B?c0hOUW5mdFBERjVRZWEzT0UzV2k1SDVwaXI5RjluaXlrY0lTRUVoajlwSCtJ?=
 =?utf-8?B?SGx5MkdseGV6eG5RV0FINDV6RnBpVmEzUElpSUk4OUFQanhxMWsreUZ2Zytw?=
 =?utf-8?B?Sm9YcUZnRStxd3VrUkU1Nk9BNVV3SFBLVk9UQ3RVZjU4bUw4V3gxN1RhRjdG?=
 =?utf-8?B?ZFJXOG02NlFqQ01ST1IyR01NNDZpbVpPaUVkZUs1OTdkS0cveDR0WER2SVhP?=
 =?utf-8?B?RU5BaTNSL01mWkxOZFJrTktLcnNXTTA0WHdqMzJob0hacWhsTmZHVXFnbnpH?=
 =?utf-8?B?MmNQUXhtaGpCSXFVL2NjOHdmVDI3WE8yVXBweU90MFpGYURZcjArTkVycnlJ?=
 =?utf-8?B?OE96WGtVRWp0WnNlU2VTazV3VHRIaVJzOHM3ejV3NStQR2pBZ0dxRDNxRWUr?=
 =?utf-8?B?aEM2YlR1dzBidS9KVFB1a05MREM4QzBjd2JFZVBYMUNqaEk0akxIVEpqS3M3?=
 =?utf-8?B?VU81cWFZM0VNQVE1ODdjTzNTQkdQWXA5NVM1TEpEcmVQalZaWC84NU4xR1Vi?=
 =?utf-8?B?MHgycUZsRDBPK3pPOVFjU01sbXRya0Y0TS9Hd0ZWQXdUOEQyY29meHlORFBx?=
 =?utf-8?B?UDAzekU2dDFtK2IwQ1JTZlZHbFZzTjJLNkVhbXhlVm0xSDJjU2JvQ2FVcDJn?=
 =?utf-8?B?TmkwNFlDWGs0SDk2NytFclZzYmNrZi9EclkxS3lBR0NpNW9DTDlRdnBiaWJw?=
 =?utf-8?B?UlRSMmNpM2V3RmZTU2hkVXMzaGQ2OXBVc3dha1Jid3ZlcjFSYmN1RmtiVFpO?=
 =?utf-8?Q?C7fyounKD5KqNr2nFD/bEpzty?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fa520f-99bf-4443-6214-08da60d789c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 11:46:47.1724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eocDJyXxjJdVP53NDySFdYZvvzWxVdBGHdb5WGcisMNd0biZfAL3Ws9mOtkJ5UT+uUKu87JRzQGF4/wlHw780w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2519
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE5hdGhvbi4gDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRm9udGVub3QsIE5hdGhhbiA8TmF0aGFu
LkZvbnRlbm90QGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSA4LCAyMDIyIDM6NDAgQU0N
Cj4gVG86IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyByYWZhZWwuai53eXNvY2tp
QGludGVsLmNvbTsNCj4gdmlyZXNoLmt1bWFyQGxpbmFyby5vcmc7IEh1YW5nLCBSYXkgPFJheS5I
dWFuZ0BhbWQuY29tPjsgUmFmYWVsIEouDQo+IFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsg
bGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBDYzogU2hhcm1hLCBEZWVwYWsgPERlZXBhay5TaGFybWFAYW1kLmNvbT47IExpbW9uY2ll
bGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IEZvbnRlbm90LCBOYXRo
YW4NCj4gPE5hdGhhbi5Gb250ZW5vdEBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgU3UsIEppbnpob3UgKEpvZSkgPEppbnpob3UuU3VA
YW1kLmNvbT47DQo+IEh1YW5nLCBTaGltbWVyIDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwg
WGlhb2ppYW4NCj4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLCBMaSAoSmFzc21pbmUpIDxM
aS5NZW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMTAvMTJdIGNwdWZyZXE6IGNw
dWZyZXE6IGV4cG9ydCBjcHVmcmVxIGNwdSByZWxlYXNlIGFuZA0KPiBhY3F1aXJlDQo+IA0KPiBP
biA3LzcvMjIgMTI6MDEsIFBlcnJ5IFl1YW4gd3JvdGU6DQo+ID4gY3B1ZnJlcV9jcHVfcmVsZWFz
ZSIgYW5kICJjcHVmcmVxX2NwdV9hY3F1aXJlIiBhcmUgb25seSB1c2VkDQo+ID4gaW50ZXJuYWxs
eSBieSBkcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jIGN1cnJlbnRseS4NCj4gPiBFeHBvcnQgdGhl
bSBzbyB0aGF0IG90aGVyIGRyaXZlcnMgc3VjaCBhcyB0aGUgQU1EIFAtc3RhdGUgZHJpdmVyIGNh
biB1c2UNCj4gdGhlbSBhcyB3ZWxsLg0KPiA+DQo+IA0KPiBDYW4geW91IHByb3ZpZGUgbW9yZSBp
bmZvcm1hdGlvbiBvbiB3aHkgdGhpcyBpcyBuZWVkZWQgZm9yIHRoZSBhbWQtDQo+IHBzdGF0ZSBk
cml2ZXI/DQo+IA0KPiBUaGlzIHBhdGNoIGV4cG9ydHMgdGhlIGFjcXVpcmUvcmVsZWFzZSBmdW5j
dGlvbnMgYnV0IEkgZG9uJ3Qgc2VlIHRoYXQgdGhlDQo+IGFtZC1wc3RhdGUgZHJpdmVyIGlzIHVw
ZGF0ZWQgdG8gdXNlIHRoZW0uDQo+IA0KPiAtTmF0aGFuDQoNCkl0IGlzIHVzZWQgaW4gdGhlIG5l
eHQgQ1BQQyBFUFAgcGF0Y2ggc2V0IHdoaWNoIHdpbGwgYmUgc2VudCBvdXQgc29vbi4NCkFzIHRo
ZSBhbWQtcHN0YXRlIGlzIGJ1aWx0IGFzIG1vZHVsZSBkcml2ZXIsIHRoaXMgcGF0Y2ggZXhwb3J0
cyB0aGUgc3ltYm9sIHRvIHBzdGF0ZSBkcml2ZXIuIA0KDQpQZXJyeS4NCg0KPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBQZXJyeSBZdWFuIDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMgfCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvY3B1
ZnJlcS5jIGIvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYw0KPiA+IGluZGV4IDczNDMyMzYwZTZl
OS4uNGQzYzgzZGEyOWI3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVx
LmMNCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jDQo+ID4gQEAgLTI2Miw2ICsy
NjIsNyBAQCB2b2lkIGNwdWZyZXFfY3B1X3JlbGVhc2Uoc3RydWN0IGNwdWZyZXFfcG9saWN5DQo+
ID4gKnBvbGljeSkNCj4gPg0KPiA+ICAJY3B1ZnJlcV9jcHVfcHV0KHBvbGljeSk7DQo+ID4gIH0N
Cj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoY3B1ZnJlcV9jcHVfcmVsZWFzZSk7DQo+ID4NCj4gPiAg
LyoqDQo+ID4gICAqIGNwdWZyZXFfY3B1X2FjcXVpcmUgLSBGaW5kIHBvbGljeSBmb3IgYSBDUFUs
IG1hcmsgaXQgYXMgYnVzeSBhbmQgbG9jayBpdC4NCj4gPiBAQCAtMjkxLDYgKzI5Miw3IEBAIHN0
cnVjdCBjcHVmcmVxX3BvbGljeQ0KPiA+ICpjcHVmcmVxX2NwdV9hY3F1aXJlKHVuc2lnbmVkIGlu
dCBjcHUpDQo+ID4NCj4gPiAgCXJldHVybiBwb2xpY3k7DQo+ID4gIH0NCj4gPiArRVhQT1JUX1NZ
TUJPTF9HUEwoY3B1ZnJlcV9jcHVfYWNxdWlyZSk7DQo+ID4NCj4gPg0KPiAvKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCj4gKioq
KioqKg0KPiA+ICAgKiAgICAgICAgICAgIEVYVEVSTkFMTFkgQUZGRUNUSU5HIEZSRVFVRU5DWSBD
SEFOR0VTICAgICAgICAgICAgICAgICAqDQo=
