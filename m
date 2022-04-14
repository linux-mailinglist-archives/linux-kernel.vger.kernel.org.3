Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD72A501A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbiDNSAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344225AbiDNSAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:00:45 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B24DEBB81;
        Thu, 14 Apr 2022 10:58:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcjViyzK3Lw5wW2AC01tc7WNhI3AvcU5/sdq7hIN+ThIa/9nlNaZQvi+yZXpUV1cifwvH0zTRWenzy4HF9V7wGrd7MhV7lUsbQjiQ3U21b+RR+zh6YW/30IGTWZ3mEQkafqKY53mQ99Hmf9CdEVkHJkvXETRBnT4Ct2C8CcjsPVhaCbw4q51zUyibEDJELtMe05KkVrxV2EVcx4UJF6H28lle5KEGsinSVS/j4HacKUilUMpwuRbpQ/lm0hntXDPHq1UPUZ63OScUxGBasudKGJBA7u2t79Ms0snEG7cwANbnfomPNEZhy8ku4uvd0cOJeHNNHQZbSP28nPqE/EPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjJCZ5R4dMouBjCXcATScZdxjK4mYe2hDUgf/wzyx+w=;
 b=UBWxLtLtOgojulN02x8GE6rdghOFi2cy5Zx+QRlGLJ8p4nwolG8NX/dZi19th7cjFYY8hnB/JozKYcFYzw/6hj1MYZhgS5EbOfFoVcjgXnTQpBH9+oVkP5FpmReyxmSLNbOBk5TYfnCqv9ACW3I8j0AGrreq3YHPNiZWndArUsFZWUNVo/WUT3DG6WDZsGZ2BT7Q/aXX/9nLDp+h7oyQnghhdpPuJpLOBIO9FnnWybi6QLqo7vqTmhv31k3vtR65zj/l4TC+8xqyWRLhPucUkmJxQ2HNoUzOlJuJEjv6aii8/SeWBsxz5dV8RQTe3HTyt9yTrAdiy3dlrQd5b96Eig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjJCZ5R4dMouBjCXcATScZdxjK4mYe2hDUgf/wzyx+w=;
 b=1/gh1wJHqgzCq/QUHg+/Rp7PVn66tkNclu0PDphUVvIbweUuHysoJuGcamnomtW0zeo4te6ipagQw7i40Le7EZmtCM01xqlAbtvYKs5w5Ooy2nV88NdgIoI7xlPXpN9cBbDJU+Z3nEdD1Wb+KctjfHbYAaXWQpfnxHW6YisBPCk=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB3662.namprd12.prod.outlook.com (2603:10b6:208:164::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 17:58:17 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::3157:3164:59df:b603]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::3157:3164:59df:b603%7]) with mapi id 15.20.5164.018; Thu, 14 Apr 2022
 17:58:17 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/6] cpufreq: amd-pstate: Allow replacing acpi-cpufreq
 when loaded
Thread-Topic: [PATCH v3 4/6] cpufreq: amd-pstate: Allow replacing acpi-cpufreq
 when loaded
Thread-Index: AQHYUB9u35kxUqwX2k+73oA6HPSCSKzvqxIAgAAD5nA=
Date:   Thu, 14 Apr 2022 17:58:17 +0000
Message-ID: <BL1PR12MB5157CC5E942986945F5EF088E2EF9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220414164801.1051-1-mario.limonciello@amd.com>
 <20220414164801.1051-5-mario.limonciello@amd.com>
 <64d7f4f7-3c05-7f37-d9eb-72d9d079f8f8@amd.com>
In-Reply-To: <64d7f4f7-3c05-7f37-d9eb-72d9d079f8f8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-14T17:46:47Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=12868ab1-f0b0-4519-8ed3-4d5eccea72b6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-14T17:58:15Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 2aa04e8d-cdcf-4132-94ef-0c21a8fc683b
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d663595-a917-4a1f-e62c-08da1e405adb
x-ms-traffictypediagnostic: MN2PR12MB3662:EE_
x-microsoft-antispam-prvs: <MN2PR12MB36620FA82A03838EF416F297E2EF9@MN2PR12MB3662.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: puVUthfp/HUoPTqvDVPJ1OPKOM+mxlWoWx6+RNtXrbg5V1dtOmsfHA45/fTvJ8fxlhHwuqb2nRSA4Zz9Y8BSZZdei1t+ZlL/CIfcwd9jSA9eXNbD3rDj/kgCF649DUqzDgPAd2NvsWfiFej51X43QxZx7ViI7NWQwZV8Rtqaveei6n3y9EtLmJOTNqhMCEOqDkehnQY5v16bmXTfIoXl9L1+/8b1qWwWy/j0Gjs+xXXH0VvNd/ZlQ3exiao5Ow3oHiq51i/ilYcrwWZo2o8q5mJA2r0Odi5r1/dKWiT+UFMuBF9O32NUZKW1220aEzf3q6S1GmgDJtxZBN63KPjXZmw+F6hRtOdvKlif45hpe82Y2NIkkjZmhq/XJlPOYcm6L9MXBrQifGhn0ipwHIl7b6oZTs2K02YfD/qTvXYppOt2NynriCk4L06FRzfQTBZttHF08aB6aAviMKwDZNjZf0uCFS6fz5rrBBMew+3VoG4w/SN9nYY31Ugkww3sIJO7JugStIhOCrKKfy4dpwHIL3wYgsqkc6PLi+wdmxSzK0Qrf0iw83d4DjB0nkZGHNDZtVqypf3/u7ySrbX+idwYFO0dnz3xopkgaEhXDY038cEJojItgUgyvouS1OjKPKJQnDhEgw+1RDtFWLW5iIxXC3Sk2JWt4vW5AJKBjPzoxKV6TEqL53beS6QQ5uB+e2YhtmubjogK5Ja1hAr7sJ3fzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(76116006)(66556008)(66946007)(66476007)(66446008)(86362001)(8676002)(9686003)(316002)(186003)(110136005)(54906003)(83380400001)(6506007)(53546011)(7696005)(71200400001)(38100700002)(4326008)(8936002)(33656002)(508600001)(55016003)(52536014)(5660300002)(38070700005)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmNzRHYyRzNocW5HTXZ1L2xZVzEva3dvcWNrK2loWnJFNXFYRXVHcVRoUFlX?=
 =?utf-8?B?dDBKKzBqYWk4M2lacVAxbk1hMjQ1NG9lZHF6OWVFb0Fyb3ZFbUpiYm9VU3BC?=
 =?utf-8?B?ZUp2b1gwRWp0WlBHRW5mMTFlUVNEVGxMdlQ2cHkxTUQ2U0IxOTNiM3Q3Kyta?=
 =?utf-8?B?RXBJYzAyNHZuOTZHckloM0tPNDJianNBNGdJUlFPY1g4dk9oUjlDd0RpK2cy?=
 =?utf-8?B?RTJTSkFobmIyYWtnMlVxcTQ0WlpIWWNyRG9EWisvalBnSXBYRXlDMVRvbW5S?=
 =?utf-8?B?ODFhWWg4dE1WcHRuWW9FWGswdlE4YkJ6Yk8yWUNBT1hGbmlreU0yOWxjeTJh?=
 =?utf-8?B?Wk0zS1lDaWRhcUhLWWkxNHZ3L3A0Y1MzQTdISlQ1Ui9DQ3QrSFV5MDFQLzNK?=
 =?utf-8?B?SEJOdFhhTHA2ZlhGdVRwLzZmTzZhbVpOY0hhbUxzUlBLRHpPZG1TUStxK3FZ?=
 =?utf-8?B?THByRkRTUVJnd2NwekwvZWxVMUtoZjJJK2hhQTU3czhaVDYxV0FKTWthQ1Q4?=
 =?utf-8?B?YzQ2SkdDYmdjZ1kyVml0NFV5ZGgxWEp6S0wzZ3NMaENqaFRlYms4bGhYNExU?=
 =?utf-8?B?QXkyRjVYQkxaNDBRRnFxZmNsUDBqSzA1LzFuOXVDandXWWtqTmZXTUw5TjN2?=
 =?utf-8?B?Q0Zia2ZYNmxjVzhUZ1JrVHZzOXdJRkdyOEdHMFVnUFpCNzlDRUNkZDdLdzZ4?=
 =?utf-8?B?NEdoeVRLd0JIUkFaRUhrdG1vQWZ0V3NOVnVNeGtqYTdEKytLd1Y5cHZtNno0?=
 =?utf-8?B?V2tHb3VxYnZRalNqZldDSGN5Z051R0ZackdPRFQ4WVY2UXljTXJhR09GNUZL?=
 =?utf-8?B?TEpYcllHc2RxY3A5eVg4dEpZNlR6WmV3YnA3cTBRcFJ1VHlFcVZwaEtPSGFV?=
 =?utf-8?B?VENYZGhMMUtmdm1pTGV3TmV5Y3pMcjJhcExqL2lEdDBraXdDYU5MU1pmZ214?=
 =?utf-8?B?SUx6UWtzK3V0T3dISGVqT1ZZTkdiK0ZWMDF1Smd3VlNETGk1N0Z0QjZ6eEpN?=
 =?utf-8?B?THdoU1NXZUJVZE56WDVzT1U1TkJUU3YydnVxZ2hiMG03cVl3dzNCUjlOdTUz?=
 =?utf-8?B?bFp2Nk5Ya0dEbll2Wks1T3NCTjNxcmxOYlpnUkh3TDE1OUJPVmJCM2Z1ZWVv?=
 =?utf-8?B?eGJKbTNUK1RrVVJqenBNSGtsNFAzWFVES01yUk5TNDlibFV5c1lZcUQyRVYy?=
 =?utf-8?B?UTFsRWtFd3Q1Z1I3OUFIc1pJYXQyZDJkRlR4VkcrOWVieXF4MEh1WWZNWm9J?=
 =?utf-8?B?S2tlVlhjeGpEWVY4M2tBSHNuMVZRaE5wSGR1TjVsemhGcGpFV2ltRHdDL3Nu?=
 =?utf-8?B?ZU51WDI4RVhHZlZWYzR3OEpkekZDaFJ2TE92ZzAvclFiZEJQZTUxcVJFR2V1?=
 =?utf-8?B?anFLQnBNc0grUjZLNzNOTzhrNDRXWFVTWTd1Sk9hWXNQem5wd3l4M1J5RXoy?=
 =?utf-8?B?YW9jOUdJdVptY1Z3enJmL0FDa1hCRWc1SlJMYWhLa0JVbjNWbUFwRk10emlX?=
 =?utf-8?B?MER6eTJhT3pyai9zTGpKSEV2RGRza3Jmc3VIVldwaXQ4Qy9WT25pZjRNSnNs?=
 =?utf-8?B?QWJEQ3BTZHJPV2E0dGJuQ0VxTVVuTUY5S1VZLzduSDU2RVBpekFKVWlPQlJY?=
 =?utf-8?B?R0FNb3pJWXBXSWNKaWZUU2ZJN0NIZURVWlhMdCtNU2pjZElSVEtSblFJa3Ar?=
 =?utf-8?B?bjAvNDhaTEZMbW9jdW1yT2U4VG5uS0xqMDJ0dFVvd2hWUldLS1RtVytNZjNF?=
 =?utf-8?B?SXlVRUZRWjFGdlBnSEc2VGdCa3E4azBJRjFzbjBIUWZHMjMraEdjYWtLUTJR?=
 =?utf-8?B?VTArc3ZWZVZyV28yeTZZVnlxRHl2OS9zRHhwNnRMNWYxL1YzQVBlUnA0Ymsy?=
 =?utf-8?B?U1N5eEQ0bFkxY2ZRTVg5TVZTejhQVk0vc0tydFZpRm96NkYrRlVwT3doZmxG?=
 =?utf-8?B?bHRNaTBiZkJSVWhYVWV4cEJKc1NRNWxWcGVTWE9vRWg2WWxKeWZoenFvaWF5?=
 =?utf-8?B?SFhwaUpwWFIrVEdOM1I0Yys2dy9TUVFkWkdCSk9zckhLbEF1T2sxWXBLM1dq?=
 =?utf-8?B?amhGRlZsSVN5QTN0MUxCRDU3cTBCZEtXVWtaTTJiak1Gb2ppaFJLWVFEZ05u?=
 =?utf-8?B?RGVPMHVySldQbms0emxkaG92aWVSRUwra3RKemRSdkh5L2FHQ0ppaTBGdmdk?=
 =?utf-8?B?UXlOWldZT1V3OC90WGhjdEwzSXFOV2szbVZoOFJlWkxlb29GOEJrNnB1MVJQ?=
 =?utf-8?B?Q1pLWFBhTkZTSzVHa21HWGJTclpHLzN6WTRiQmsvNUU4RGVjb3VNcVdxUXJy?=
 =?utf-8?B?eCtvaDBJR1FNdm12RU9ZdFRGeFNXMGhLcU9DYUN1UDE4WllwbDJvczczMDJU?=
 =?utf-8?Q?VW61XIs5y66TbTwyICREj74NQ0afsFo/vBnELFezrondz?=
x-ms-exchange-antispam-messagedata-1: czlXsbh87pYdXA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d663595-a917-4a1f-e62c-08da1e405adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 17:58:17.6978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0HZ3MOcwHhOFDSmIhk6zJHdF4PM+twDNnR5Pl1ydmdVCUZ8jPP2Qj+EhOOe70wa2kyWm46it3mivTopU4HgG0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3662
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRm9u
dGVub3QsIE5hdGhhbiA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5
LCBBcHJpbCAxNCwgMjAyMiAxMjozMw0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5M
aW1vbmNpZWxsb0BhbWQuY29tPjsgSHVhbmcsIFJheQ0KPiA8UmF5Lkh1YW5nQGFtZC5jb20+OyBS
YWZhZWwgSiAuIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgVmlyZXNoDQo+IEt1bWFyIDx2
aXJlc2gua3VtYXJAbGluYXJvLm9yZz4NCj4gQ2M6IG9wZW4gbGlzdDpBTUQgUFNUQVRFIERSSVZF
UiA8bGludXgtcG1Admdlci5rZXJuZWwub3JnPjsgWXVhbiwgUGVycnkNCj4gPFBlcnJ5Lll1YW5A
YW1kLmNvbT47IG9wZW4gbGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MyA0LzZdIGNwdWZyZXE6IGFtZC1wc3RhdGU6IEFsbG93IHJlcGxh
Y2luZyBhY3BpLQ0KPiBjcHVmcmVxIHdoZW4gbG9hZGVkDQo+IA0KPiBPbiA0LzE0LzIyIDExOjQ3
LCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4gPiBgYW1kLXBzdGF0ZWAgY2FuIGJlIGNvbXBp
bGVkIGFzIGEgbW9kdWxlLiAgVGhpcyBob3dldmVyIGNhbiBiZSBhDQo+ID4gZGVmaWNpZW5jeSBi
ZWNhdXNlIGBhY3BpLWNwdWZyZXFgIHdpbGwgYmUgbG9hZGVkIGVhcmxpZXIgd2hlbiBjb21waWxl
ZA0KPiA+IGludG8gdGhlIGtlcm5lbCBtZWFuaW5nIGBhbWQtcHN0YXRlYCBkb2Vzbid0IGdldCBh
IGNoYW5jZS4NCj4gPiBgYWNwaS1jcHVmcmVxYCBpcyBhbHNvIHVuYWJsZSB0byBiZSB1bmxvYWRl
ZCBpbiB0aGlzIGNpcmN1bXN0YW5jZS4NCj4gPg0KPiA+IFRvIGJldHRlciBpbXByb3ZlIHRoZSB1
c2FiaWxpdHkgb2YgYGFtZC1wc3RhdGVgIHdoZW4gY29tcGlsZWQgYXMgYQ0KPiBtb2R1bGUsDQo+
ID4gYWRkIGFuIG9wdGlvbmFsIG1vZHVsZSBwYXJhbWV0ZXIgdGhhdCB3aWxsIGZvcmNlIGl0IHRv
IHJlcGxhY2Ugb3RoZXINCj4gPiBjcHVmcmVxIGRyaXZlcnMgYXQgc3RhcnR1cC4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQu
Y29tPg0KPiA+IC0tLQ0KPiA+IHYyLT52MzoNCj4gPiAgKiBSZWJhc2Ugb24gZWFybGllciBwYXRj
aGVzDQo+ID4gICogVXNlIElTX1JFQUNIQUJMRQ0KPiA+ICAqIE9ubHkgYWRkIHJlcGxhY2UgcGFy
YW1ldGVyIGlmIGFjcHUtY3B1ZnJlcSBpcyBlbmFibGVkDQo+ID4gICogT25seSBzaG93IGluZm8g
bWVzc2FnZSBvbmNlDQo+ID4gdjEtPnYyOg0KPiA+ICAqIFVwZGF0ZSB0byBjaGFuZ2VzIGZyb20g
djEuDQo+ID4gICogVmVyaWZ5IHRoZSBkcml2ZXIgYmVpbmcgbWF0Y2hlZCBpcyBhY3BpLWNwdWZy
ZXEuDQo+ID4gICogU2hvdyBhIG1lc3NhZ2UgbGV0dGluZyB1c2VycyBrbm93IHRoZXkgY2FuIHVz
ZSBhbWQtcHN0YXRlLg0KPiA+DQo+ID4gIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCAy
MiArKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1
ZnJlcS9hbWQtcHN0YXRlLmMgYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gaW5k
ZXggZDMyM2YzZTM4ODhjLi44YWU2NWEyMDcyZDYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9j
cHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRl
LmMNCj4gPiBAQCAtNjMsNiArNjMsMTMgQEAgbW9kdWxlX3BhcmFtKHNoYXJlZF9tZW0sIGJvb2ws
IDA0NDQpOw0KPiA+ICBNT0RVTEVfUEFSTV9ERVNDKHNoYXJlZF9tZW0sDQo+ID4gIAkJICJlbmFi
bGUgYW1kLXBzdGF0ZSBvbiBwcm9jZXNzb3JzIHdpdGggc2hhcmVkIG1lbW9yeQ0KPiBzb2x1dGlv
biAoZmFsc2UgPSBkaXNhYmxlZCAoZGVmYXVsdCksIHRydWUgPSBlbmFibGVkKSIpOw0KPiA+DQo+
ID4gKyNpZiBkZWZpbmVkKENPTkZJR19YODZfQUNQSV9DUFVGUkVRKSB8fA0KPiBkZWZpbmVkKENP
TkZJR19YODZfQUNQSV9DUFVGUkVRX01PRFVMRSkNCj4gPiArc3RhdGljIGJvb2wgcmVwbGFjZSA9
IGZhbHNlOw0KPiA+ICttb2R1bGVfcGFyYW0ocmVwbGFjZSwgYm9vbCwgMDQ0NCk7DQo+ID4gK01P
RFVMRV9QQVJNX0RFU0MocmVwbGFjZSwNCj4gPiArCQkgICJyZXBsYWNlIGFjcGktY3B1ZnJlcSBk
cml2ZXIgdXBvbiBpbml0IGlmIG5lY2Vzc2FyeSIpOw0KPiA+ICsjZW5kaWYNCj4gPiArDQo+ID4g
IHN0YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9kcml2ZXIgYW1kX3BzdGF0ZV9kcml2ZXI7DQo+ID4NCj4g
PiAgLyoqDQo+ID4gQEAgLTY0Myw2ICs2NTAsNyBAQCBzdGF0aWMgc3RydWN0IGNwdWZyZXFfZHJp
dmVyIGFtZF9wc3RhdGVfZHJpdmVyID0gew0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgX19pbml0IGFt
ZF9wc3RhdGVfaW5pdCh2b2lkKQ0KPiA+ICB7DQo+ID4gKwljb25zdCBjaGFyICpjdXJyZW50X2Ry
aXZlcjsNCj4gPiAgCWludCByZXQ7DQo+ID4NCj4gPiAgCWlmIChib290X2NwdV9kYXRhLng4Nl92
ZW5kb3IgIT0gWDg2X1ZFTkRPUl9BTUQpDQo+ID4gQEAgLTY2Niw5ICs2NzQsMTkgQEAgc3RhdGlj
IGludCBfX2luaXQgYW1kX3BzdGF0ZV9pbml0KHZvaWQpDQo+ID4gIAkJcmV0dXJuIC1FTk9ERVY7
DQo+ID4gIAl9DQo+ID4NCj4gPiAtCS8qIGRvbid0IGtlZXAgcmVsb2FkaW5nIGlmIGNwdWZyZXFf
ZHJpdmVyIGV4aXN0cyAqLw0KPiA+IC0JaWYgKGNwdWZyZXFfZ2V0X2N1cnJlbnRfZHJpdmVyKCkp
DQo+ID4gKwljdXJyZW50X2RyaXZlciA9IGNwdWZyZXFfZ2V0X2N1cnJlbnRfZHJpdmVyKCk7DQo+
ID4gKwlpZiAoY3VycmVudF9kcml2ZXIpIHsNCj4gPiArI2lmIElTX1JFQUNIQUJMRShDT05GSUdf
WDg2X0FDUElfQ1BVRlJFUSkNCj4gPiArCQlpZiAocmVwbGFjZSAmJiBzdHJjbXAoY3VycmVudF9k
cml2ZXIsICJhY3BpLWNwdWZyZXEiKSA9PSAwKSB7DQo+ID4gKwkJCWFjcGlfY3B1ZnJlcV9leGl0
KCk7DQo+ID4gKwkJfSBlbHNlIHsNCj4gPiArCQkJcHJfaW5mb19vbmNlKCJBIHByb2Nlc3NvciBv
biB0aGlzIHN5c3RlbSBzdXBwb3J0cw0KPiBhbWQtcHN0YXRlLCB5b3UgY2FuIGVuYWJsZSBpdCB3
aXRoIGFtZF9wc3RhdGUucmVwbGFjZT0xXG4iKTsNCj4gPiArCQkJcmV0dXJuIC1FRVhJU1Q7DQo+
ID4gKwkJfQ0KPiA+ICsjZWxzZQ0KPiA+ICAJCXJldHVybiAtRUVYSVNUOw0KPiA+ICsjZW5kaWYN
Cj4gPiArCX0NCj4gDQo+IEEgY291cGxlIG9mIHRob3VnaHRzLiBGaXJzdCwgc2hvdWxkIHRoaXMg
YWxzbyBwcm92aWRlIGEgcGF0aCB0byByZXN0b3JlIHRoZQ0KPiBhY3BpX2NwdWZyZXEgZHJpdmVy
DQo+IGlmIHRoZSBhbWQtcHN0YXRlIGRyaXZlciBmYWlscyBkdXJpbmcgaW5pdCBzb21lIHRpbWUg
YWZ0ZXIgY2FsbGluZw0KPiBhY3BpX2NwdWZyZXFfZXhpdCgpPw0KDQpJIHRoaW5rIHRoYXQncyBh
IHJlYXNvbmFibGUgaWRlYTsgaXQgd291bGQgaW52b2x2ZSBleHBvcnRpbmcgYWNwaV9jcHVmcmVx
X2luaXQNCmFzIHdlbGwuDQoNCj4gDQo+IFdoaWNoIGxlYWRzIG1lIHRvIHdvbmRlciwgc2hvdWxk
IHRoZXJlIGJlIGEgbW9yZSBnZW5lcmljDQo+IGNwdWZyZXFfcmVwbGFjZV9kcml2ZXIoKSByb3V0
aW5lIHRoYXQNCj4gY291bGQgaGFuZGxlIHRoaXM/DQoNCklmIGNoYW5naW5nIHRoZSBBUEkgZm9y
IHRoaXMsIG15IHByb3Bvc2FsIHdvdWxkIGJlIHRoYXQgdGhlcmUgaXMgYSBmbGFnIHVzZWQNCmlu
IGNwdWZyZXFfZHJpdmVyLT5mbGFncyB0byBpbmRpY2F0ZSB0aGF0IHRoaXMgZHJpdmVyIHNob3Vs
ZCByZXBsYWNlIGV4aXN0aW5nDQpkcml2ZXJzIHdoZW4gY2FsbGluZyBjcHVmcmVxX3JlZ2lzdGVy
X2RyaXZlciByYXRoZXIgdGhhbiBhIG5ldyByb3V0aW5lLg0KVGhlbiBpZiBpdCBmYWlscyB0byBy
ZWdpc3RlciBmb3IgYW55IHJlYXNvbiB0aGVuIHRoZSBvbGQgZHJpdmVyIGNhbiBiZSByZXN0b3Jl
ZC4NCg0KUmFmYWVsLCB3aGF0IGFyZSB5b3VyIHRob3VnaHRzIG9uIHRoaXM/DQoNCj4gDQo+IC1O
YXRoYW4NCj4gDQo+ID4NCj4gPiAgCS8qIGVuYWJsZSBhbWQgcHN0YXRlIGZlYXR1cmUgKi8NCj4g
PiAgCXJldCA9IGFtZF9wc3RhdGVfZW5hYmxlKHRydWUpOw0K
