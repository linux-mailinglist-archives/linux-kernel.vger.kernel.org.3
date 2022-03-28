Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD8B4E98D1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbiC1N7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiC1N7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:59:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D325EDCC;
        Mon, 28 Mar 2022 06:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AC7lAEzpSkJ1cRQcu3aaaYn1OluJ4BC/VNsn4dU2TXfBw5sKWOQZJ98XTGIsqgU3o3+XGMuxBb2D2OeFzzE/57gtMn0NZT/HEwItn5o/ZKkBh8SkK5N6lr+mLSgMg2seJwvlGO5tEWiJ6DFAPStEBYaJmv8aqSB2NaebYRYGastei95WqEkKlviznNvhUhtW8lKoTBWfWRfRYfl6j8hc7vKZoQOKFL/+Le+fxpe61MWxpCNBPBv9OnEgIZKNWvzuee2GN0uEkRQJjzwaxKt1tqrGg0TdquwASvCVVd1IAOJrYytDuPS8x/nM0VKVHmgFKqj2Yn2A2A8cyKACROMHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRxtjey4lhrn9OftSbjCw3C6W2AY5+onfcyGyVSDTbU=;
 b=Pj6tqlJEL72zz1pdy/NazBKp5ecUw2/2Qu46vOj8ventgLQjlzKmLocV6fCLxA2kNPyZ/fqdVSJI12adPyJyCo2fjH2Wm67IwLPUpdmPUoKPV6/ZvzJiHP03htO26SaTdFyq43eQh5MgfOD80XNTdwVZ2KRv7kiDf1Qn/FXBcU2y6sCRuWztADqseLLlZhi9F6A6nD1CPZ28cqLlCLRa1bDbR9kd2U55M+wCT5otqZPrd6krRwebATTNJhk4GzjVc02eelORC9Hr2bg3bSxhUigE7aiO4bAphaA25toF5QFryMz7WpboqaCcACv6xQWdXkHicoVIQvJ9wu22D60xQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRxtjey4lhrn9OftSbjCw3C6W2AY5+onfcyGyVSDTbU=;
 b=QuIf0Qrsr1zNyayrd2BwGUmsJdEvLuglkrOw61gveMZHvAr3uGJZL+8eHfRSxbITPyM93exB36qjWz7DR1C+u7EtcIwE/4nYEgZq4eUL5Q3+V43pwNVdk/fCNPLBDg/LJupgMHt2dEB745H8HA33m+l6sxEYCtyq0gDnDcw0Z6Q=
Received: from MN2PR12MB3600.namprd12.prod.outlook.com (2603:10b6:208:c6::12)
 by DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 13:57:49 +0000
Received: from MN2PR12MB3600.namprd12.prod.outlook.com
 ([fe80::c174:f1f0:af55:8e61]) by MN2PR12MB3600.namprd12.prod.outlook.com
 ([fe80::c174:f1f0:af55:8e61%3]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:57:48 +0000
From:   "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] cpupower: Introduce a new unit test module for AMD
 P-State driver
Thread-Topic: [PATCH 2/3] cpupower: Introduce a new unit test module for AMD
 P-State driver
Thread-Index: AQHYPoXV7BGbwTw8rUC6WUHWLuSDQqzNA8SAgAeALPA=
Date:   Mon, 28 Mar 2022 13:57:47 +0000
Message-ID: <MN2PR12MB360098136C287C84D99FD9B6F71D9@MN2PR12MB3600.namprd12.prod.outlook.com>
References: <20220323071502.2674156-1-li.meng@amd.com>
 <20220323071502.2674156-3-li.meng@amd.com>
 <4c13d97e-1471-5642-39dd-d381fa441753@linuxfoundation.org>
In-Reply-To: <4c13d97e-1471-5642-39dd-d381fa441753@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-28T08:47:48Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c3676173-b7ef-48fc-8412-ac4433ff66ab;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-28T13:57:45Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: e0607d03-c8d3-4bb4-999c-1f41aa37c554
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 412ef712-5626-438c-1975-08da10c2f11f
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_
x-microsoft-antispam-prvs: <DM5PR12MB246976EDADB82998971406FDF71D9@DM5PR12MB2469.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r+BWpV6khIo7f3ON7fyARxa1QHsvfVv2fXne9y2KVpeij+k09m8Xk65CinxJREioug33M7YK8TQM8JNTFLhlRkpuo4I9rgzGY168Vav7vqec4p84qr/80kO6U/OOGSWgPkzOH2yaPqy1Y/+WdeWnVmuV6V+AaBVh4c1AvhpGCov4k7+ClV/S+UadyQpr+GQL1blebc14+uZQuleMdN/8cn3w04r6WCBq1Qt7FKSmzDINajPt3yYENSub1NlWsv88DaPUp8ulkL8b/Q++deGPYGemf7XlWE9Jlj+FupisrqDdLKDSYN7AilyUqYqZy8drTPrSqYChzw16CSud74Uja32kBUatlPnEvLQm5A0wpvnx84QhrRm7RhXRh1TvxOaiDajpgikTnK7gLQk6DrYXU7aEVmt8hIuI2kPjW9G/61b28+d7LEF2yXf8ByMlz8FP7aAlSzX1ZMapCaitkE3dVn8LRDDL322Xy4VrDXKVJ5P8UDfjC1j6RsGpnE/HKg9Pas7s6RpMJ+8hCilBvzbbwDIMISmZRrU2v/ZwcGliRSQEIzuItS7x67rrEaKwLRyjIuByA5baae8WSx/eT2bNjwZf0uMDQrUucN6f13PRgvjp5n/7sN83+ml2j0IhXpDyWwWriaR/2t7ihkvQZwiGln98YP5LN7/uHjHPeQqgR90NMKnM6wg6R4czNSc5ywUF4chlvUGAdYFGC1Vq4uRCHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3600.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(122000001)(4326008)(8676002)(66476007)(66446008)(316002)(66556008)(64756008)(76116006)(38070700005)(5660300002)(55016003)(2906002)(86362001)(8936002)(38100700002)(52536014)(6506007)(7696005)(83380400001)(53546011)(9686003)(71200400001)(110136005)(54906003)(186003)(33656002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0VJUmFkNm1ZWmJOaE0rVG04cHMrT2d2dGQ0eVhhVGs5d0V0VmRXZ0NqMmlj?=
 =?utf-8?B?ekpQRmw0ZklGMVJ6WWdTRkRFVEkzdXRZcFN4VVN3NTVYMkxsN01wTmswWUV1?=
 =?utf-8?B?WWpwc3dUa1gyZFB6SEVncC83Qk1YOW9uRjZQQk1iMmxUYUs4YXU1R1BWN2NC?=
 =?utf-8?B?MDJZdERleTl2SFZKYmhCa0FLcHpLYjdMa0NHeldGZHlYd0F0bnBCTW1hUG14?=
 =?utf-8?B?ZGIzZlpvdmhNS21yRXZ1dFdySFVyUDFCSHQxeVVCb2ZIODFmZkRScUFLaXQ0?=
 =?utf-8?B?R3dZRTJVelQvOUY0MllqMnZZc1h1Q1Ryb2ZkZG1LVkp2dkZ2c3JnK0ZDcFN3?=
 =?utf-8?B?NVdYM3ZUV210ZkhKTXJJeE1SS1ZjV2RIcHZLTUFXY3ZPU1FXeTl4citpdExo?=
 =?utf-8?B?ZVgzbTU0REFRSStQdk85N2NRN0hibUZ0TXVldkhLZW5WalVvUFlHY1M3RTVx?=
 =?utf-8?B?YjZOVFdYbHFvNE41bWZUOGpyK1A3RUhtbVN1K3pINjBERWJhSzZxK0JXMGxs?=
 =?utf-8?B?OEVvTWZPclFVNHBhSDdjZmNHNGJiNGkwWVJEN0RwTGxCaWNiTE1EVFZPOWNI?=
 =?utf-8?B?Yk5RTHRGRHZNVTdtUGt0cTlMYkdWU0RBUEU2OGEvT0RkVDlWZkZrRUI0MzZs?=
 =?utf-8?B?cDNNZzJ4MVBKbHUrRU1PYUpoZWp4eTBPZFRKbFB4MldFdG1icDd1UUxmVjBP?=
 =?utf-8?B?eEJzaWlhYVNyYTd0RVhwOWt1RGRPU3UydnQrUVRVSERONGQwVjVudkl3ckFk?=
 =?utf-8?B?Z2c0czdleEpFbDdRNk9rWW1FeUk4UXdCbVlmV1NsdnoyWW9HNXlnUmhWZnhW?=
 =?utf-8?B?SGdoSFNUZkFmdE5SSTBldDZLQ2dlZDFzS05hOGFMRnRvWGdGcUwwSkNkTW45?=
 =?utf-8?B?YStndy9GSnBvaHg3MkJvbHM4cC80blA2d2ZmcVkxWXJ4N1JXWW81VUoxV2N0?=
 =?utf-8?B?aTZvNTJWNlFHR3BJRzk1QnZCWjNnSW91Skk5TzhFaFV5M1NPT2dXcmN2Wk1x?=
 =?utf-8?B?L2JiL0JlSjBiemdsYUtabjd3eTNSWktreE8zTk9jYUZURHlFSnlXVzcxakxR?=
 =?utf-8?B?aHpMMk82WUFqSm5tM2Vrck5IbjY3L1ZmTEFGbmdVT2NteHdtUU0yemhpYXZh?=
 =?utf-8?B?NzNra3pnSndzRWJERU5HZ2xtSmFkWjMvUVNRRVpwRU5wQlhvUklIR3AzT3dz?=
 =?utf-8?B?OEF4elppSTNXa3I4Z2I5aXA3SzAxWUlDTlc4SzQyU1hCMzhHM3A3MVdsSmZm?=
 =?utf-8?B?bC9YSHNLZlNPVjhML09uc2hvRDFpTG5MMU1ndlpLUzBMSGpqRHRqclNQVGNJ?=
 =?utf-8?B?SVBHZ1d1L2QvQVh2M3U0bVAyMTM4T2JOcjU0Z294R0gzcjRnT0hTUFBYWkMr?=
 =?utf-8?B?dEx0bDc1VmIvbnNzWCtsbVdEUzhtdDBUdzZqUFJYd0ZITzByL3ptYWZjTFFn?=
 =?utf-8?B?bWMwSURDSnJOY2F0WGJtSGV4OUYzVVhDL2N5bGhUSXJOY2tkM0ViMFBkQXJE?=
 =?utf-8?B?KzVuSG1MZFZNZUpVT3dTVEZLZGVETDdxL3ZUTGFFZWkva0ZRZ0M0RkpucU9i?=
 =?utf-8?B?Q0xaMkJwWXIxckdBTEhvTGlna0hMWStaTDc3Z0lRblZYMFZuTEk4Z0VJV0ti?=
 =?utf-8?B?K3RKTWY2NjAxVzRXZUZXdlpWeTNKWHlxZjZjS0RETjFZYXpCZEtBN3NnamZL?=
 =?utf-8?B?OGpua3QwbDY4SyszVWpNV2lUaFhIbkRxanQ3WG1NcVVQUFBKQmtPZmNhaFdl?=
 =?utf-8?B?MmRFRmJuczVlYUQvY0xRaTJrT2U2RlcrSkZlZ0hWNk85Tmw3dEhVc2xtc2xw?=
 =?utf-8?B?TU1QclpYOVpmTWFDMzFBVlZNakU4cFl5dUxHRjl0bG5BWHo0M3RDMXY5ZDJx?=
 =?utf-8?B?T2hlUTNPTVBBWWhzdFRXbG5HVENTeXJWK3pnb0NOMktnNExtcWhTMGVsTGVC?=
 =?utf-8?B?MzF4QUFDa2RLUVp2R2VLZVpYSVBtbTJMWlJUM3Nwc0pwdUMybkk3b04xMEhT?=
 =?utf-8?B?bHloYXVrUGlzSCsxV1ZVT0lJdE1aS0MyWktwNHoyb2lZTmJJbkx6blJPT3Zm?=
 =?utf-8?B?UzhjaHU4NllVRGZISVhLT0piQTduTFMvNEp6Rk1nM283TnZWQmx3RHowdW9N?=
 =?utf-8?B?c204ZVZ4a0M3YlJkYXVNcUdMQXBrajlwazZVbmNUZmhNaUgwV2tmZVJYM2Js?=
 =?utf-8?B?aS8yTTA3SnFidHZmQmlUVTJ3VzdVNGVSOVZoZW80Mm4yZDR0OTlqbFlkOC9R?=
 =?utf-8?B?MC84R0YvSm1EOElHeGNSaVRDUWFoUFRSRW9CME44c1NXYlptY0NMM3gzZ3JS?=
 =?utf-8?B?dndvN21UZHBwbldjM1VsQS9tZzRPMGdmWkE5L0w4YkFIRm9IZWQ0RDhHcFVD?=
 =?utf-8?Q?dYv/ddErvAK2ZDlWEj6D+PCivWTBkEKy/TtSk0YmeXArg?=
x-ms-exchange-antispam-messagedata-1: f6e8+SfOpIusjQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412ef712-5626-438c-1975-08da10c2f11f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 13:57:47.8737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwlI/JEO13pWd/byDp03IKUo9EO2ReGxT152lLHV2o5OhzwrqnWnn6NECayQHYsYuTEg25pAuDMQ3uerzNJLxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgU2h1YWg6DQoNClRoYW5rIHlvdSB2ZXJ5IG11
Y2ggZm9yIHlvdXIgdmFsdWFibGUgc3VnZ2VzdGlvbnMuIA0KV2Ugd2lsbCBhZGFwdCBpdCB0byB0
ZXN0IG91ciBBTUQgUC1TdGF0ZSBkcml2ZXIuIEJ1dCB3ZSBoYXZlbid0IGRlY2lkZWQgd2hpY2gg
b25lIHRvIGFkYXB0LCBrdW5pdCBvciBrc2VsZnRlc3QuDQoNClJlcXVpcmVtZW50cyBmb3Igb3Vy
IHVuaXQgdGVzdCBtb2R1bGU6DQogLSBJdCBjYW4gYWNjZXNzIGtlcm5lbCBpbnRlcm5hbCBzdHJ1
Y3R1cmVzIGFuZCBmdW5jdGlvbnMgd2hpY2ggYXJlbid0IGV4cG9zZWQgdG8gdXNlciBzcGFjZS4N
CiAtIEl0IGlzIGltcGxlbWVudGVkIHRocm91Z2ggdGhlIHNjcmlwdCB0cmlnZ2VyIENQVSBiZW5j
aG1hcmsgYXBwIGluIGNvbmp1bmN0aW9uIHdpdGggdGhlIGtlcm5lbCBtb2R1bGUuDQoNClRoZXJl
Zm9yZSwgbmV4dCwgd2Ugd2lsbCBzdHVkeSB3aGljaCBtZXRob2QgY2FuIG1lZXQgdGhlIGFib3Zl
IHJlcXVpcmVtZW50cy4NCkNhbiB5b3UgZ2l2ZSB1cyBzb21lIHN1Z2dlc3Rpb25zPw0KDQpUaGFu
a3MsDQpKYXNtaW5lDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTaHVhaCBL
aGFuIDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPiANClNlbnQ6IFdlZG5lc2RheSwgTWFyY2gg
MjMsIDIwMjIgMTA6MTUgUE0NClRvOiBNZW5nLCBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5j
b20+OyBSYWZhZWwgSiAuIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPjsgSHVh
bmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCkNj
OiBGb250ZW5vdCwgTmF0aGFuIDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT47IFNoYXJtYSwgRGVl
cGFrIDxEZWVwYWsuU2hhcm1hQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxv
QGFtZC5jb20+OyBTdSwgSmluemhvdSAoSm9lKSA8SmluemhvdS5TdUBhbWQuY29tPjsgWXVhbiwg
UGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlhb2ppYW4uRHVAYW1k
LmNvbT47IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+OyBCb3Jpc2xhdiBQ
ZXRrb3YgPGJwQGFsaWVuOC5kZT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNodWFo
IEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIIDIv
M10gY3B1cG93ZXI6IEludHJvZHVjZSBhIG5ldyB1bml0IHRlc3QgbW9kdWxlIGZvciBBTUQgUC1T
dGF0ZSBkcml2ZXINCg0KW0NBVVRJT046IEV4dGVybmFsIEVtYWlsXQ0KDQpPbiAzLzIzLzIyIDE6
MTUgQU0sIE1lbmcgTGkgd3JvdGU6DQo+IGFtZC1wc3RhdGUtdXQgaXMgYSBrZXJuZWwgbW9kdWxl
IGZvciB0ZXN0aW5nIHRoZSBmdW5jdGlvbnMgb2YgQU1EIFAtU3RhdGUgZHJpdmVyLg0KPg0KPiBJ
dCBjYW4gdmVyaWZ5IHRoZSByZXF1aXJlZCBjb25kaXRpb25zIGFuZCBiYXNpYyBmdW5jdGlvbnMg
b2YgQU1EIA0KPiBQLVN0YXRlIGRyaXZlciBiZWZvcmUgaW50ZWdyYXRpb24gdGVzdC4NCj4NCg0K
Q2FuIHlvdSBlbGFib3JhdGUgb24gdGhlIG5lZWQgZm9yIGEga2VybmVsIG1vZHVsZT8gSXQgd291
bGQgYmUgaGVscGZ1bCB0byBrbm93IHRuZSB2YWx1ZSB0aGUgbWRvdWxlIGFkZHMgYW5kIHdoeSBp
dCBpcyBuZWNlc3NhcnkuIEluY2x1ZGUgZGV0YWlscyBvbiB3aHkgaXQgY2FuJ3QgYmUgZG9uZSBh
cyBwYXJ0IG9mIHRoZSB1c2VyLXNwYWNlIHByb2dyYW0uDQoNCkkgYW0gbm90IHNheWluZyBpdCBp
c24ndCBuZWNzc2FyeSwgSSB3b3VsZCBsaWtlIHRvIGtub3cgdGhlIHJlYXNvbnMgYmVmb3JlIEkg
cmV2aWV3IHRoZSBwYXRjaC4NCg0KQWxzbyBpZiB0aGlzIGlzIGEgZHJpdmVyIHRlc3QsIHdoeSBu
b3QgdXNlIG90aGVyIHRlc3QgZnJhbWV3b3JrcyBzdWNoIGFzIGt1bml0IG9yIGtzZWxmdGVzdC4g
Y3B1cG93ZXIgaXMgdXNlci1zcGFjZSB1dGlsaXR5IGFuZCBkcml2ZXIgZGVidWcgY29kZSB3b3Vs
ZCBub3QgYmVsb25nIGluIGhlcmUuDQoNCnRoYW5rcywNCi0tIFNodWFoDQo=
