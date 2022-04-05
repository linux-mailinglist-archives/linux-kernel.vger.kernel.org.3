Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07D64F51EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848784AbiDFC3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377111AbiDEV1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 17:27:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D29FCBF6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:40:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2PVgiYRMXBZvs2FBzyxQJ6QASmeuLI6RJe3kDeOl6h4b0b2CMCBTH36GWm748pkiJDZ+QBGNHP9IFnGrjjay3MBWQPa8Iuqq49gK5p8TqZ78nWB2W/OHyKHLTL79xKGEiwt6WZ2glwrwssLlWB4vRBhqC+NEk8dphMpyoh/22fVrtwXH/oju1e4xVGzGeQq2KzBelXcDsSxQClFeK21lVPP6RYqSq3EFZ5ZT6AWBXkcz1TC5QLjawZIuKLMOLvgC56CC5wy6DAPHNFIW0aN4xJ8VtAc4wATqRCSr1JveyjXG5a3j0Y6towR4Z3t39FiH0lJBExQDQp6XvoEBrc9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B07l3yRsZoPFjLHGvopbuNpCTE5GNd32SeSc3bKRY8=;
 b=D87gNHjZJecdPy7ol+BoMvQxUgwrMjKHquOZPxPFYKVo/1SFzsOrMpup6mUIu1L27b9KLsAuQDyuD8Jlu59IJ6iEtTqT1CSgs25KUBR/Gqf+e+7lwbiJBxmIvIlvJhisCQRcqvZZJLLNo8cQyFMjEM3a2YP3CGTx5NWjdbNh3/3FxKYD9sI5yekCH8fUxrD4igo4YUmn+A1biT44TeI0ICcNY0VArRti8DOORxm0OM6wiSYKOdBC4D7DiICDvgPFP+cuyOg2BgjQhGVPvnklAd9IrB64SQESx1rW7t4gFz7mgah0SLRhLYXLgYag9cSSGn7L7eyWjB40PwPF0qWGJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B07l3yRsZoPFjLHGvopbuNpCTE5GNd32SeSc3bKRY8=;
 b=Vq1RQwu6rkg0cB+0Gn7uFDzB04lK11oh3F0cezaovdWCo2Msgg6cOiRH5EyrzgDpZLF2lyPeo5YSknMVttYeVpEDt3DkvKJ4gwAyGElbRbF3p8M4TnwFO3WQiCluTPYg8a5xIaF+Bu99MMmusG5eUpQrrqnHo3MtaXp4v/WvPR8=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB3852.namprd12.prod.outlook.com (2603:10b6:5:14a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 20:40:16 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 20:40:16 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Carroll, Lewis" <Lewis.Carroll@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Rao, Bharata Bhasker" <bharata@amd.com>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "metze@samba.org" <metze@samba.org>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: RE: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Thread-Topic: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Thread-Index: AQHYSO0si5fvSUiei0GnFDYbI7mXuKzhWxKAgAARiYCAAAWWwIAABNIAgABQN2A=
Date:   Tue, 5 Apr 2022 20:40:16 +0000
Message-ID: <BL1PR12MB515702C06E483DF4EB78A7ADE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxNFyXqC12nXyfM@hirez.programming.kicks-ass.net>
 <7cdc2103-c6d4-e1b6-9804-6739112eee4d@intel.com>
 <BL1PR12MB515745615F4C92627033CD5BE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5873a444-bb32-f0d5-27f1-173f469baf21@intel.com>
In-Reply-To: <5873a444-bb32-f0d5-27f1-173f469baf21@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-05T20:40:12Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6c53033f-deac-4f98-898c-c9f5adda0038;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-05T20:40:15Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5d651133-598b-486e-abf2-309b087db31f
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cd26ea9-625e-4477-5e05-08da17447e06
x-ms-traffictypediagnostic: DM6PR12MB3852:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3852A592CD4367A8298242B7E2E49@DM6PR12MB3852.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uP4YwczqAkbQ4J1B6+KmNFi41NHc03/a9Uuj8ytrxeipS/FmkaXEPtIem+APnnRUkK/1greEyS2v215KpS2ugrfawVR6KSqNo1akjZ+smPuyKdLMBScaw3UwZWScWzhZ+mmWlGMiF5MQK0sFT0jTAJ9naYQya6H5SvFGHQqn06nbuaLaFo6sjUiCmiZWzGaMerAnzuUEJxyI4eh9JBRhOZKjy28+x7HRTFkUc/BJyuKQM4920/Tl/btkflIL/+QKF/3TRWTGJ2laqfQGEc1UIlgE32vGP1zeQdfTmQd0L2mozGHYpEl0X1mlrsBexufX0mMA9GENUVnhZh0VHc47GDVNR0DiV6WZte9rSGlfMmb0O+GpG7wXArPjIf7H+IUYo0TUKYOKHvRTstxxinj72HYHmhZN3fZoQj0l16w4dtXxrvS0BMS3ldN3NTVCjvhWH43XYOenP7USR8Gu4hPZEM5N7TVphNZkfZD8aXwEtb9t5QSPxHIgF5RP101hMDBgJpMG75GAVMXjnGEV76VBAvmQMS7JjG5UGN9bn+RmxxjglHXsfY95xNX4s7rFfqYQSRtp3JKf3pspxoY8ncraUGO85nLy1gVpPrpw2ryhk4FIIJfWKmqRv3xcXGKZB6ch/AT/Lxs1D2dugN2MDZjtWsT4NZ/M17JwMTOZM8otuVVGj2KlRWoA/xrSp8mdEn1VMI04GYKJXVCMA5P5AtIBiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6636002)(54906003)(316002)(76116006)(6506007)(66946007)(66476007)(64756008)(110136005)(8676002)(4326008)(83380400001)(186003)(71200400001)(86362001)(38070700005)(66556008)(66446008)(7696005)(53546011)(9686003)(55016003)(38100700002)(5660300002)(508600001)(7416002)(8936002)(2906002)(33656002)(122000001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlJrY2pvNEorRnVUdHR3UE95Zko2MWZlNDkvZEhoU01UM2tyZExIaFdXV0c2?=
 =?utf-8?B?WXRtSGQ2ZCtzM2NvMnRVTHJvOCsrUXJpRStHTXJBY0dDdnRlNk9wdG5pL2Nk?=
 =?utf-8?B?YzVIb0JLbkVTdW9jbkU2ZWc3WUtFR25zTjV2Um1zN3VGTE0xbWViN0l2MUtO?=
 =?utf-8?B?QndDczludkdJc24wUlJFekhtaVFIcUhKQ201U0xjb01kekppN3RVVERHaUF3?=
 =?utf-8?B?bVBTR2o5cGYvK3VKOXVpdE1XY3lZb0lZUGgyRGt0SGF2eWRaUXA5MXY0Z3Nm?=
 =?utf-8?B?ejFIQllyNXYwelY4RFNJNndvMkZQVzBtcjRTWUdiS3ZHRExrWitZeTYwall3?=
 =?utf-8?B?NG5DYXlhNFArdWtHSGpwWllkZXBTb01WdnlGS3pjNFhodDBHVm1pZENidklp?=
 =?utf-8?B?YUlhRmtIOCtRbC9PM1hmWjluZE92Ykltc1FtNEZzZmVHeStlR3NPR0JqRXdL?=
 =?utf-8?B?ZHVGTXo3SFFPanBIcFpPYUdwMDZvYzNxSmptSXE1bXdsZnROTG51SVBydUNI?=
 =?utf-8?B?RTNwWkN0b21DZnlHUWdKR01sQ3dxNWJBTXhBeG1KY1Z4a0pFTVpRMkZ6V2pm?=
 =?utf-8?B?dXdrdmtGY2ptN1BIK0x1OVhSWU4xQXRPWlNkanRFdVVLUHlQZXZ3dWNGbmV5?=
 =?utf-8?B?MjJ2aFZ3OVF2RmcrWk5yTktKSjZYTEVFdXJSVEV5S2d5amVlR0c0bWtLNGdm?=
 =?utf-8?B?dU1TTmZBbDRoODd2cTVydVpJZEV0YnFJMGZiT3RTNktSZUpVUkFmV1J1NDd5?=
 =?utf-8?B?RGJSQmEzYVpxVk1ESEloeGhHaTRhTC9RMjVKTGgwald6d1NnVTQ5N0tEd29a?=
 =?utf-8?B?S1Axd1B0TTN4enpzSGRTekR0SUc2TGNwTndYRVZuM1BTOTFRS1lUeGVua2dr?=
 =?utf-8?B?bC9MNzlsaTEyRUtIV1U4RklKSHBiM0V2OEdIamQyT1N4UDdOcXBSNDhJaVpk?=
 =?utf-8?B?N0kxMUtiR0hQRmJzUmJoQ1c1d1B3d2l4bUgrdWZVQk9mNHZqbEozYkpZbHNF?=
 =?utf-8?B?bndYZjFsR2k2ZU8zT0MzMmxlRDZmdzB5SENqbGQrbnpnaFAvWjI5T2xFVTJB?=
 =?utf-8?B?eFcrcEZ3LzluRFlYK3RhSXBWUEpxWE01c3ZseG9DQnB1OGROWmFQcUhleU11?=
 =?utf-8?B?NUIzS3dFK3pOWkVSRnlNa01jWlk0TTR0cDl3LzlMWFEydmJHVFpnVHl1U0Rr?=
 =?utf-8?B?TDV3Y0FNa0drYjNuSkNWMWVETWIzUG93L0xraXlwOWtLT3U4akZYZUt6ODJp?=
 =?utf-8?B?V1RVYk9RcEdDVEkrMyt0Z1NvRlczVmlYZkdzVWZ3UmsvMEdHdDlPOXk2dStw?=
 =?utf-8?B?VzlmS3ArNE5BVXpBYUlCMXlaeGh2cXlPY1lwcVJhNWlSRnFpbTcycDZqSEUy?=
 =?utf-8?B?REZYZHo3cGptSzlzQTY0Ly9nYUhkcjlhQnNCRmV6QzJ3MWRrbU04Mi92UkE3?=
 =?utf-8?B?dldENGtJSmI4VGdxRkdLLzExaytCUmhmMVVnVjJrRXFrMTNhN2xzSEh6c2xI?=
 =?utf-8?B?ZnNpZHBweEw4TUh0RHNidGxpQi8rZFVrSHluY3RXa0pNWVpmWjgyaGVpRkUw?=
 =?utf-8?B?dG5MOER5V3NPRzZtTGpzOGY0bjQwcWludEF4cm1CaGd1aFhNY0VETlQzWVF4?=
 =?utf-8?B?WFRlRXNEOE5uL254TUMxNHl4SFVsZXdjWDNPTWlxNWJYYnhFR2JpY1ZEZWxu?=
 =?utf-8?B?c0llQjZWME1yUEJIMEVGMGFCaVM4ancyRmhETVdaUlMzQ0NkM1F4TVJocW1t?=
 =?utf-8?B?Mi82K0pDZHhnaGZrN3huNFRrOVF1ZjZKVXo3SUZrcGJGdDh4Q2dyUlZSWUpq?=
 =?utf-8?B?SUdyTGsvMFIyclhseUVON1ZQclhNdTM0alQ4T1o1KzJ5MCtWVkk1ZUZhandQ?=
 =?utf-8?B?b1EwZ2VWcm9mdDF0SkkyT282Q0hUdVlIbjdpdnZWYTVwaWtYT1lGNmdFems5?=
 =?utf-8?B?amRBVlViamdGY1FMS3VqOFM5aHhVV2Z6V2pKNk5LQ0dROFNUNG5kZGkvMFRN?=
 =?utf-8?B?SGlFOEp5K3Bkb2F6K0N3bGZ1NmQzRUVtQm5GdWpVRE8zeVRkR2FmREJVVExQ?=
 =?utf-8?B?bFhmdDZhWEt2Zk51L3RUUGlIWUtqTVdZWnFzMzV1TEF6WjRLK0xkWEdMRnlO?=
 =?utf-8?B?YjFNbU5EbCtEcXJXVWtoMXFrQnZaOXNhNmw1VmVSaVhjQ1k2dDhKSC9xUHFM?=
 =?utf-8?B?UVQzeDZYeWM5ZGtONFVKZEhabkgzM1ZoNi9XVmxzekJCaXdaN0o1Z3laejd0?=
 =?utf-8?B?YzJaR0p1TzZJbDFrMTVQdXVHSzF6TnI3L0tJYnF0QXdMQ3ZQYWFQejR4MXJQ?=
 =?utf-8?B?Vk5Ucm11dmR6NEpHdGtKN1pMR1JlcDEwb2tmVjl1T3M0ODROOHVrUU5NdzVW?=
 =?utf-8?Q?WTxMWX/+Lml6clGmKKhmfy3FsJtea3Juq5O8cE0p/XqLc?=
x-ms-exchange-antispam-messagedata-1: 1iFPIc52psSliw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd26ea9-625e-4477-5e05-08da17447e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 20:40:16.4189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgJyXfNWsdx9b0yITZcaq/v5mxcsnmN6M9M9wb4QxjUwWO86aEJu2xFz+KZOZYABipXrj/E1Ui80vrCmr1P7/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3852
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2
ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwg
NSwgMjAyMiAxMDo0Nw0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxs
b0BhbWQuY29tPjsgUGV0ZXIgWmlqbHN0cmENCj4gPHBldGVyekBpbmZyYWRlYWQub3JnPjsgS2Fy
bnksIFd5ZXMgPFd5ZXMuS2FybnlAYW1kLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IENhcnJvbGwsIExld2lzIDxMZXdpcy5DYXJyb2xsQGFtZC5jb20+Ow0KPiBTaGVu
b3ksIEdhdXRoYW0gUmFuamFsIDxnYXV0aGFtLnNoZW5veUBhbWQuY29tPjsgTmFyYXlhbiwgQW5h
bnRoDQo+IDxBbmFudGguTmFyYXlhbkBhbWQuY29tPjsgUmFvLCBCaGFyYXRhIEJoYXNrZXIgPGJo
YXJhdGFAYW1kLmNvbT47DQo+IGxlbi5icm93bkBpbnRlbC5jb207IHg4NkBrZXJuZWwub3JnOyB0
Z2x4QGxpbnV0cm9uaXguZGU7DQo+IG1pbmdvQHJlZGhhdC5jb207IGJwQGFsaWVuOC5kZTsgZGF2
ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOw0KPiBocGFAenl0b3IuY29tOyBjaGFuZy5zZW9rLmJh
ZUBpbnRlbC5jb207IGtlZXNjb29rQGNocm9taXVtLm9yZzsNCj4gbWV0emVAc2FtYmEub3JnOyB6
aGVuZ3FpLmFyY2hAYnl0ZWRhbmNlLmNvbTsgbWFyay5ydXRsYW5kQGFybS5jb20NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0geDg2OiBQcmVmZXIgTVdBSVQgb3ZlciBIQUxUIG9uIEFNRCBwcm9jZXNz
b3JzDQo+IA0KPiBPbiA0LzUvMjIgMDg6MzQsIExpbW9uY2llbGxvLCBNYXJpbyB3cm90ZToNCj4g
Pj4+ICAgICAgICAgaWYgKCFzdGF0aWNfY3B1X2hhcyhYODZfRkVBVFVSRV9aRU4pKSB7DQo+ID4+
PiAgICAgICAgICAgICAgICAgbXNyIHw9IHNzYmRfdGlmX3RvX2FtZF9sc19jZmcodGlmbik7DQo+
ID4+PiAgICAgICAgICAgICAgICAgd3Jtc3JsKE1TUl9BTUQ2NF9MU19DRkcsIG1zcik7DQo+ID4+
PiAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+Pj4gICAgICAgICB9DQo+ID4+IFRoaXMgc2Vl
bSBfYml0XyBhdCBvZGRzIHdpdGggdGhlIGNvbW1pdCBtZXNzYWdlIChhbmQgdGhlIEFNRCBTU0JE
DQo+ID4+IHdoaXRlcGFwZXIpOg0KPiA+Pg0KPiA+Pj4gICAgIEFkZCB0aGUgbmVjZXNzYXJ5IHN5
bmNocm9uaXphdGlvbiBsb2dpYyBmb3IgQU1EIGZhbWlseSAxN0guDQo+ID4+IFNvLCBpcyBYODZf
RkVBVFVSRV9aRU4gZm9yIGZhbWlseT09MHgxNywgb3IgZmFtaWx5Pj0weDE3Pw0KPiA+IFRoZXJl
IGFyZSBaZW4gZmFtaWx5IENQVXMgYW5kIEFQVXMgZnJvbSBmYW1pbHkgMHgxOS4gIFBlcmhhcHMg
YXQgdGhlDQo+ID4gdGltZSBvZiB0aGUgd2hpdGVwYXBlciB0aGVyZSB3ZXJlbid0IHlldCB0aG91
Z2guDQo+IA0KPiBJcyB0aGlzIGEgZ2FwIGluIHRoZSBkb2N1bWVudGF0aW9uLCB0aGVuPyAgSXMg
dGhlcmUgc29tZSBkb2N1bWVudGF0aW9uDQo+IG9mIHRoZSBhdmFpbGFiaWxpdHkgb2YgU1NCRCBt
aXRpZ2F0aW9ucyBvbiBmYW1pbHkgMHgxOT8NCg0KSXQgbG9va3MgbGlrZSBhIG1pc2ludGVycHJl
dGF0aW9uIG9mIHRoZSBkb2N1bWVudC4NCg0KTm90aWNlIGl0IG1lbnRpb25zIGluIE5vbi1hcmNo
aXRlY3R1cmFsIE1TUnMgZXhwbGljaXRseToNCg0KInNvbWUgbW9kZWxzIG9mIGZhbWlseSAxN2gg
aGF2ZSBsb2dpYyB0aGF0IGFsbG93IGxvYWRzIHRvIGJ5cGFzcyBvbGRlciBzdG9yZXMgDQpidXQg
bGFjayB0aGUgYXJjaGl0ZWN0dXJhbCBTUEVDX0NUUkwgb3IgVklSVF9TUEVDX0NUUiINCg0KQnV0
IHRoYXQgaXMgbm90IGZvciBhbGwgZmFtaWx5IDE3aCBub3IgZm9yIGZhbWlseSAxOWguICBZb3Ug
Y2FuIHNlZSBlYXJsaWVyIGluDQp0aGUgZG9jdW1lbnQgdGhlIG1ldGhvZCB0byBkZXRlY3QgcHJl
c2VuY2UgZm9yIFNTQkQgd2hpY2ggYXBwbGllcyB0byB0aGUNCnJlc3Qgb2YgMTdoIGFuZCAxOWgu
ICBUaGF0IGNvZGUgaW4gYW1kX3NldF9jb3JlX3NzYl9zdGF0ZSBpcyBvbmx5IHVzZWQgZm9yDQpv
bmUgb2YgdGhlIG1pdGlnYXRpb24gY29kZXBhdGhzIHdpdGhvdXQgTVNSIHN1cHBvcnQsIG5vdCBm
b3IgYWxsIFplbiBDUFVzLg0KDQo+IA0KPiBBbnl3YXksIGJhY2sgdG8gTVdBSVQuLi4gIEl0IHdv
dWxkIGJlIHJlYWxseSBncmVhdCB0byBpbmNsdWRlIHRoZQ0KPiBhc3N1bXB0aW9ucyBhYm91dCB3
aGF0IFg4Nl9GRUFUVVJFX1pFTiBtZWFucyBpbiB0aGUgY29udGV4dCBvZiB0aGlzDQo+IHBhdGNo
LiAgRG9lcyB0aGlzIHBhdGNoICpyZWFsbHkqIG1lYW4gIlplbiBtaWNyb2FyY2hpdGVjdHVyZSIg
b25seT8NCg==
