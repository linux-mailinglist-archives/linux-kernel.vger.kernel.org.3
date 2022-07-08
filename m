Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7556B8C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiGHLng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbiGHLne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:43:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4864B2A71E;
        Fri,  8 Jul 2022 04:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVZ3lopTXUlMYH+IssEle8JTaFR1b8VUVYfH76XBhDJBnwnXjYx7j83wsIQaae50Z0UaIaXh+4527hG3z3UvOSwe8Sd4ePlljRj6MBrP5NxsqUQHQYKg/QFTpG7Sns0cgdVCck3Qm4xTytuPTj58PttGxcNS2u3v0jMRoEJpV9c6oKMTqCxeVNo7R9j4trvSVfTzJbcpGo3FOFaZwMBAx4ckOE4DjRvUGm4Yd1yMUhdQBifgQTc/uQNCLO14R6eRDkLAVwXI71349UNsR8LiDWrDQ3eAz9fX1R4O7rjmt4mEXM675G85+rKCTVJi2pPZRnj7At1ROj0yEdVPbPXU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FA929lZuPf5zAzKQVH54umnmQERrbNqOwDqpWiSNGh0=;
 b=F9xBK4cviQxvzUOiNJMrCNPjwtsXyS9lFcRywKGFQSZ7zCDTSXSRH2g4PWfGrVWiNaVkP6w+klZIAIlVhDV+9RlogXF2pRk8wqE6lx/DPM66lxB4p4fcyfwdj87Krp48FA//s72mVqCNVwg2jyCkjMMO3SkdMG4a+N5r2Q35BXfYw6SLLs+Etd9IqWHg9soHMrZ6BTHTtNPOPPyJodpiLSn4ggcSkmfmDntcIZ6zvdh40vJKHWyl1OMCuUtgL9NmAQEqaAs4n8yihF8CpGeRCHvTaviIOihpcuphymd7yLdKCAZA8mf8V6cDIMbP+CO7fUIWEGqA92y51BogK0Il0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FA929lZuPf5zAzKQVH54umnmQERrbNqOwDqpWiSNGh0=;
 b=xp7+/4a+KIk+3tjWpSWykwUGPCQ8R80Lfh9uuiyCLTEmP4Y2g0sr488Qu9Cx7b0bK3Miz6gVQzgD9F/FTec/h+VtBANrt42/S/2wrCdUWztvKmRf8HOAHbUJvJt0b7rzs0XCRBsV8ljqnYraka39jwfQMvWG6bmdmHL9Qyzk5Sk=
Received: from CH0PR12MB5265.namprd12.prod.outlook.com (2603:10b6:610:d0::22)
 by CY4PR1201MB2519.namprd12.prod.outlook.com (2603:10b6:903:d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 8 Jul
 2022 11:43:30 +0000
Received: from CH0PR12MB5265.namprd12.prod.outlook.com
 ([fe80::4c8e:9d96:2b0e:fc0f]) by CH0PR12MB5265.namprd12.prod.outlook.com
 ([fe80::4c8e:9d96:2b0e:fc0f%7]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 11:43:30 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Subject: RE: [PATCH 02/12] cpufreq: amd-pstate: enable AMD Precision Boost
 mode switch
Thread-Topic: [PATCH 02/12] cpufreq: amd-pstate: enable AMD Precision Boost
 mode switch
Thread-Index: AQHYkiJqVaTXUYCZP0+9z4XXGornD61zTCgAgAEOvlA=
Date:   Fri, 8 Jul 2022 11:43:29 +0000
Message-ID: <CH0PR12MB5265F997D3699E351264A7D09C829@CH0PR12MB5265.namprd12.prod.outlook.com>
References: <20220707165522.212990-1-Perry.Yuan@amd.com>
 <68a54575-c55e-e83d-ec25-7b0b516077de@amd.com>
In-Reply-To: <68a54575-c55e-e83d-ec25-7b0b516077de@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-08T11:43:27Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e0f3658f-cd05-4d68-8a5d-cece48868490;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-08T11:43:27Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: b94e9c35-a6bc-4eab-b3b7-f8f4dbc9b3af
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 487866a5-c8a2-42ad-90c8-08da60d71440
x-ms-traffictypediagnostic: CY4PR1201MB2519:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k2tDX8qslBZPiLczHLlZh6x4XZeGnaGZ5FcOam8w4k6bWwvlINZvb8eYivHErTYJK6c8pKxIIPRCQhdzrwwpLwA/06bkZTAaJjPll50IALbG3N8yznLkAJYYRXsyAAdsc/FvEmCFzrkZeGZFfoEzWRw5RJKzqk+2lAOo0PXIW5S7Ft2PiZOzDYTk0LVVKIT1HRGP4czIUPluQ/YM4N0BLlMuBVjQPiYLr5Zk9jc/7TCm1YwiIYlcrb+1wYgaoMWXPCirVZPzUyi5N1VPCa/W1rNJzO/cUsz9T1pGxVxogmNPXvWmtrtnqzeio7nbJw5LGLKa6zryM3ZYXptLXVwHlRxVXsBJ/k6elc5uIsN43NVPJu42Ec8UgL5neaCvlXJrjowLS+8LxaGq51S3NH6wJrchU9BnqpJdBdsuWtzxwiwggUzaSYd/POBN/czZBY7XeuplQFnF2lFme1bMufb7fYjAILS4SCT6bVlPSShDvWRRWiOE2Rt313gY6Smjczbp9/zgJxs0CiS7jnykRPrqHwnIC8w/chXe/NunaDiKwBfIpanT6Apbuk4AXlZP/0SCE3hci+zGF7zcv2F5zaXu4YGahj3IIlNfJHZIWpMg7XlwIoZPSlM3rQ2KclnA971azVo/UGIO2SG2647KabhcrMaKO2dyPuruHQDF+NtpceKjDLG6hWHaBHU9aonSJ1igEmmG6uvkN5gswwfCHIyHxWK5OWVMHbqX6B4B+Rh58C6AzXWjbCCsePlbo91NQVCzyW2TE9micU6rDfE0vY9lll9c1Pt9hZqsINzmHOvnP+X4R8heU8Kucq7qaEhhZocVKXoXEQcahruubGCdf/6dpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(4326008)(66946007)(64756008)(7416002)(186003)(38070700005)(7696005)(54906003)(110136005)(41300700001)(6506007)(71200400001)(55016003)(26005)(122000001)(53546011)(316002)(83380400001)(66446008)(66476007)(9686003)(38100700002)(8676002)(52536014)(8936002)(5660300002)(86362001)(76116006)(2906002)(66556008)(478600001)(33656002)(921005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODVPcnprTUd0dVoxVGZoUDZhSTFSdENSSlEvdEZkQjROQUpzKzZsWVlBNXVm?=
 =?utf-8?B?RTNER2plRVRUKzhySGFLaFZDMTdEVExXM1FzeThqYnBoQ2hWcGpOMmR4b2Fs?=
 =?utf-8?B?cXRTZ0NleWtFdWJaaVg1TUJUUVpBY2l4TENGeW51RjdPcEkzNFRESEhNK2pG?=
 =?utf-8?B?bU1VZ0lTcndPSld1S3A5NmNNTG9zVjFMZWNHdkJUUjE0ZUZBTkNMTUZTTUF0?=
 =?utf-8?B?WFR2OFRHZ0lrU3o1QXI4Wnc0TlRjWndJcnU2bXEvdUhjTVJmZHFndVQ1Q2l4?=
 =?utf-8?B?WDhCT2M3QjFGRTh5aFV5dytid1BRY0VEUURCN1A3djlEWGU2b2FTbk00MVY4?=
 =?utf-8?B?dEo4RHM5OWdCRDBVZ05oRzhXZjdjZUN5UmtMcUp4NWd3eVo4L29iRzlqWi9N?=
 =?utf-8?B?NDBmaHZLc1pyNWQreHBiSCtJTTMrSzkvcmZaV0NwMzVpZk1BNEZDOE9KVXVL?=
 =?utf-8?B?Y1liSTlyY0psWUtpVUFsRkZXbVRiL3Z6eHRjdWpaVlRFa3BER1VZRUhxMzJm?=
 =?utf-8?B?NUc0M2RGazUwS0hnSFl1R0ZRekFpS3ZhTVh5OGNIcmV4ZkNqRXQvUTlFTzZL?=
 =?utf-8?B?clpSckg4OVlQYXVtck9OYXF2dzVSMGxSeTlmbnYwaFJlZUQzTytnWGdNWG5U?=
 =?utf-8?B?djBzc0Jydjc1V2FMTVErS2hwTnBJSGJBVlM2OG00d0x6Qk1uL0tiMnlsRSsv?=
 =?utf-8?B?UmJoUHZZWXRZRG51M0Z3dVJ6RWdkRklTQ2tRb2t2Ulpaa0RCeGVIOW5ZOVZt?=
 =?utf-8?B?WHNwM2ZVSWJNc3JIaGFpcUp6cGE1NnlCK0hWS3NwVEVZRTFuRDZIOCszZVFH?=
 =?utf-8?B?VnZkUDBMSkk3VVNoUGdhKzJQeHF6endpczFYYUN0VUxFSG9RNW5WcGFMc25Z?=
 =?utf-8?B?VE9KMGhFejROVWVFUHc3M2ExN1RGNzNJUnRRVUxMbXA5TXhMcTJTNmVYcHIr?=
 =?utf-8?B?TVg5TjhPalpJeXY5UDB2dmk2b0pnTk9ZSS9KOW9KRUFCSzViSWFUam5vSUs2?=
 =?utf-8?B?YnV2cHE1T2RheVJVL1NhK3U4VkhnYXlidzkrTExib21nTUdMWENLSDJCTnlI?=
 =?utf-8?B?aHJRRGxEcFhYbWk1OGQ1U3lPVHpCQStKRjdsV0VvbzJPdk00VGhIZ2R2all0?=
 =?utf-8?B?S0dKY1ZFRnhRM1c1R2RVRDNYODlPdWV5MzlqcXlmb0FLQWdGSGJQVHQ4ZWVn?=
 =?utf-8?B?aUlMWUxQTGNIbEs1NXNzYjgyL3I3dUxlKzhoU2JpZkN1d2dPaHBZaFFxcUs1?=
 =?utf-8?B?WkpQWXZ1SitMazJlYzlWRWJzWlJjQTA4NGo5Wkc1SlljU1pEOVk5QmdITXhJ?=
 =?utf-8?B?bEJVR2hkdldxUXZ4NUt0YnUvbHp0Z2gwVUo4bWRFZytlMEMrL2ZnQkZNeVhF?=
 =?utf-8?B?Q25aMHVOS1VubjRTMWFNYjR5OU91Zk56ZHlvSGhWWDB6WUw0bTJSWlhDS3Y4?=
 =?utf-8?B?REJhUTdLcmtaYnR5amRmUUlzbXY4S3BVTyt0ZFVSd3pWa0U3SDhTVktRT3FL?=
 =?utf-8?B?QXlIdHlISHJ0K2xneFJDekt2R0J5eHBqaTRZV2E3NnVQeXo2Wi8rMFVMMUlY?=
 =?utf-8?B?N1lXUUNaamIzdzN6VmtKODlhMmYrRXhNRS8yM0JldE5aTWVyRndaaGNxZ1dX?=
 =?utf-8?B?MEp2Z2lFVnczR3EybWMvbjJ6SUNQeG5YNnpSdHdsTit1RkpnV1o5NU50ZFBY?=
 =?utf-8?B?YUxtVVZLcThNOWt6aVp5Z3dGcGsyRmxCUDBWNVlsNjlpNzg0dDF3TzJ5OTBI?=
 =?utf-8?B?MTVORGJDMURuYUd4UjNWem1pVDUzelVVME94YjdYS3NEZ1lWekpMcjJLamxT?=
 =?utf-8?B?MGlkcDZWd25pM1dLTlBYNXBYNWEvTEY4U0VsQlc5L3kxRGpjdm55SHlOdDNX?=
 =?utf-8?B?RktHZWVrK3VuMG42UE1TRklzTE1EVmJFb1VvTjlROUpYYm1RTDlVYWpzRXVt?=
 =?utf-8?B?d0U1RU9lK0ozOUl0STh3Rjg5SlozRmhydE9iVUVQZjZoVzlzRnpEZXl4NTBO?=
 =?utf-8?B?T01aWDRrbGZpKzl4V2hSZjg5VnN1MmlJQnZoUEJYMWwvQXZFdlpyNkJPSVd2?=
 =?utf-8?B?Q3h0cXRPeW1VdTFpMVhuSkVwS01HaEZGQm81Z3k3aXp3dGNTMWNZSVFXSGYy?=
 =?utf-8?Q?PaRslxNzyE0TM+Q9VFF9XQWZo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487866a5-c8a2-42ad-90c8-08da60d71440
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 11:43:29.9732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N9FGVD+WpkPWpZVWe+2TqNyQ1dbPIjC4k0ztxcYKVP+c6NHS8bLy7bBRGyuNzdGqOaJwk2LTQ7YVtj7r1oCZfg==
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE5hdGhhbjoNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGb250ZW5vdCwgTmF0aGFuIDxOYXRoYW4u
Rm9udGVub3RAYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDgsIDIwMjIgMzozMiBBTQ0K
PiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5qLnd5c29ja2lA
aW50ZWwuY29tOw0KPiB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgSHVhbmcsIFJheSA8UmF5Lkh1
YW5nQGFtZC5jb20+OyBUaG9tYXMNCj4gR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IElu
Z28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgQm9yaXNsYXYNCj4gUGV0a292IDxicEBhbGll
bjguZGU+OyBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsNCj4geDg2
QGtlcm5lbC5vcmc7IEguIFBldGVyIEFudmluIDxocGFAenl0b3IuY29tPjsgUmFmYWVsIEouIFd5
c29ja2kNCj4gPHJhZmFlbEBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPjsgQWRyaWFuIEh1bnRlcg0KPiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBQ
YXdhbiBHdXB0YQ0KPiA8cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgQWxleGFu
ZGVyIFNoaXNoa2luDQo+IDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPjsgVG9u
eSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPjsNCj4gU3RlcGhhbmUgRXJhbmlhbiA8ZXJhbmlh
bkBnb29nbGUuY29tPjsgUmljYXJkbyBOZXJpIDxyaWNhcmRvLm5lcmktDQo+IGNhbGRlcm9uQGxp
bnV4LmludGVsLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBw
bUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFNoYXJtYSwgRGVlcGFrIDxEZWVwYWsuU2hhcm1hQGFt
ZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+
OyBGb250ZW5vdCwgTmF0aGFuDQo+IDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT47IERldWNoZXIs
IEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFN1LCBKaW56aG91IChK
b2UpIDxKaW56aG91LlN1QGFtZC5jb20+Ow0KPiBIdWFuZywgU2hpbW1lciA8U2hpbW1lci5IdWFu
Z0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuDQo+IDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywg
TGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAy
LzEyXSBjcHVmcmVxOiBhbWQtcHN0YXRlOiBlbmFibGUgQU1EIFByZWNpc2lvbg0KPiBCb29zdCBt
b2RlIHN3aXRjaA0KPiANCj4gT24gNy83LzIyIDExOjU1LCBQZXJyeSBZdWFuIHdyb3RlOg0KPiA+
IEFkZCBzdXBwb3J0IHRvIHN3aXRjaCBBTUQgcHJlY2lzaW9uIGJvb3N0IHN0YXRlIHRvIHNjYWxl
IGNwdSBtYXgNCj4gPiBmcmVxdWVuY3kgdGhhdCB3aWxsIGhlbHAgdG8gaW1wcm92ZSB0aGUgcHJv
Y2Vzc29yIHRocm91Z2hwdXQuDQo+ID4NCj4gPiB3aGVuIHNldCBib29zdCBzdGF0ZSB0byBiZSBl
bmFibGVkLCB1c2VyIHdpbGwgbmVlZCB0byBleGVjdXRlIGJlbG93DQo+ID4gY29tbWFuZHMsIHRo
ZSBDUFUgd2lsbCByZWFjaCBhYnNvbHV0ZSBtYXhpbXVtIHBlcmZvcm1hbmNlIGxldmVsIG9yDQo+
IHRoZQ0KPiA+IGhpZ2hlc3QgcGVyZiB3aGljaCBDUFUgcGh5c2ljYWwgc3VwcG9ydC4gVGhpcyBw
ZXJmb3JtYW5jZSBsZXZlbCBtYXkNCj4gPiBub3QgYmUgc3VzdGFpbmFibGUgZm9yIGxvbmcgZHVy
YXRpb25zLCBpdCB3aWxsIGhlbHAgdG8gaW1wcm92ZSB0aGUgSU8NCj4gd29ya2xvYWQgdGFza3Mu
DQo+ID4NCj4gPiAqIHR1cm4gb24gQ1BVIGJvb3N0IHN0YXRlIHVuZGVyIHJvb3QNCj4gPiAgIGVj
aG8gMSA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdWZyZXEvYm9vc3QNCj4gPg0KPiA+IElm
IHVzZXIgc2V0IGJvb3N0IG9mZix0aGUgQ1BVIGNhbiByZWFjaCB0byB0aGUgbWF4aW11bSBzdXN0
YWluZWQNCj4gPiBwZXJmb3JtYW5jZSBsZXZlbCBvZiB0aGUgcHJvY2VzcywgdGhhdCBsZXZlbCBp
cyB0aGUgcHJvY2VzcyBjYW4NCj4gPiBtYWludGFpbiBjb250aW5vdXNseSB3b3JraW5nIGFuZCBk
ZWZpbml0ZWx5IGl0IGNhbiBzYXZlIHNvbWUgcG93ZXINCj4gPiBjb21wYXJlZCB0byBib29zdCBv
biBtb2RlLg0KPiA+DQo+ID4gKiB0dXJuIG9mZiBDUFUgYm9vc3Qgc3RhdGUgdW5kZXIgcm9vdA0K
PiA+ICAgZWNobyAwID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1ZnJlcS9ib29zdA0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiA+
IC0tLQ0KPiA+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaCB8ICAyICsrDQo+ID4g
IGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgICAgIHwgMjIgKysrKysrKysrKysrKysrKysr
Ky0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4
LmgNCj4gPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci1pbmRleC5oDQo+ID4gaW5kZXggODY5
NTA4ZGU4MjY5Li5iOTUyZmQ2ZDY5MTYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvaW5jbHVk
ZS9hc20vbXNyLWluZGV4LmgNCj4gPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5k
ZXguaA0KPiA+IEBAIC01NTksNiArNTU5LDggQEANCj4gPiAgI2RlZmluZSBBTURfQ1BQQ19NSU5f
UEVSRih4KQkJKCgoeCkgJiAweGZmKSA8PCA4KQ0KPiA+ICAjZGVmaW5lIEFNRF9DUFBDX0RFU19Q
RVJGKHgpCQkoKCh4KSAmIDB4ZmYpIDw8IDE2KQ0KPiA+ICAjZGVmaW5lIEFNRF9DUFBDX0VORVJH
WV9QRVJGX1BSRUYoeCkJKCgoeCkgJiAweGZmKSA8PCAyNCkNCj4gPiArI2RlZmluZSBBTURfQ1BQ
Q19QUkVDSVNJT05fQk9PU1RfQklUCTI1DQo+ID4gKyNkZWZpbmUgQU1EX0NQUENfUFJFQ0lTSU9O
X0JPT1NUX0VOQUJMRUQNCj4gCUJJVF9VTEwoQU1EX0NQUENfUFJFQ0lTSU9OX0JPT1NUX0JJVCkN
Cj4gPg0KPiA+ICAvKiBBTUQgUGVyZm9ybWFuY2UgQ291bnRlciBHbG9iYWwgU3RhdHVzIGFuZCBD
b250cm9sIE1TUnMgKi8NCj4gPiAgI2RlZmluZSBNU1JfQU1ENjRfUEVSRl9DTlRSX0dMT0JBTF9T
VEFUVVMJMHhjMDAwMDMwMA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBz
dGF0ZS5jDQo+ID4gYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIGluZGV4IDlhYzc1YzFj
ZGU5Yy4uMTg4ZTA1NWUyNGEyDQo+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9h
bWQtcHN0YXRlLmMNCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4g
QEAgLTEyMiw2ICsxMjIsNyBAQCBzdHJ1Y3QgYW1kX2NwdWRhdGEgew0KPiA+DQo+ID4gIAl1NjQg
ZnJlcTsNCj4gPiAgCWJvb2wJYm9vc3Rfc3VwcG9ydGVkOw0KPiA+ICsJdTY0IAljcHBjX2h3X2Nv
bmZfY2FjaGVkOw0KPiANCj4gVGhlIE1TUiB2YWx1ZSBpcyBjYWNoZWQgYnV0IEkgZG9uJ3Qgc2Vl
IHRoYXQgdGhlIGNhY2hlZCB2YWx1ZSBpcyB1c2VkDQo+IGFueXdoZXJlLiBQZXJoYXBzIEkgbWlz
c2VkIGl0IGluIG9uZSBvZiB0aGUgb3RoZXIgcGF0Y2hlcy4gRG9lcyB0aGlzIG5lZWQNCj4gdG8g
YmUgY2FjaGVkPw0KPiANCj4gLU5hdGhhbg0KDQpUaGUgYml0IHZhbHVlIHdpbGwgYmUgdXNlZCBp
biB0aGUgY29taW5nIENQUEMgRVBQIHBhdGNoZXMgdG8gY2hlY2sgaWYgdGhlIENQVSBwcmVjaXNp
b24gYm9vc3QgYml0IGlzIGVuYWJsZWQuDQpJIGVhcmx5IGFkZGVkIHRoaXMgcHJlZmV0Y2hpbmcg
Y29kZSBhcyBhIHByZXBhcmluZyBjb2RlLiAgDQoNClBlcnJ5Lg0KDQo+IA0KPiA+ICB9Ow0KPiA+
DQo+ID4gIHN0YXRpYyBpbmxpbmUgaW50IHBzdGF0ZV9lbmFibGUoYm9vbCBlbmFibGUpIEBAIC00
MzgsMTggKzQzOSwyNyBAQA0KPiA+IHN0YXRpYyBpbnQgYW1kX3BzdGF0ZV9zZXRfYm9vc3Qoc3Ry
dWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3ksIGludA0KPiA+IHN0YXRlKSAgew0KPiA+ICAJc3Ry
dWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhID0gcG9saWN5LT5kcml2ZXJfZGF0YTsNCj4gPiAgCWlu
dCByZXQ7DQo+ID4gKwl1NjQgdmFsdWU7DQo+ID4NCj4gPiAgCWlmICghY3B1ZGF0YS0+Ym9vc3Rf
c3VwcG9ydGVkKSB7DQo+ID4gIAkJcHJfZXJyKCJCb29zdCBtb2RlIGlzIG5vdCBzdXBwb3J0ZWQg
YnkgdGhpcyBwcm9jZXNzb3Igb3INCj4gU0JJT1NcbiIpOw0KPiA+ICAJCXJldHVybiAtRUlOVkFM
Ow0KPiA+ICAJfQ0KPiA+DQo+ID4gLQlpZiAoc3RhdGUpDQo+ID4gKwlyZXQgPSByZG1zcmxfb25f
Y3B1KGNwdWRhdGEtPmNwdSwgTVNSX0FNRF9DUFBDX0hXX0NUTCwNCj4gJnZhbHVlKTsNCj4gPiAr
CWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwlpZiAoc3RhdGUpIHsN
Cj4gPiArCQl2YWx1ZSB8PSBBTURfQ1BQQ19QUkVDSVNJT05fQk9PU1RfRU5BQkxFRDsNCj4gPiAg
CQlwb2xpY3ktPmNwdWluZm8ubWF4X2ZyZXEgPSBjcHVkYXRhLT5tYXhfZnJlcTsNCj4gPiAtCWVs
c2UNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJdmFsdWUgJj0gfkFNRF9DUFBDX1BSRUNJU0lPTl9C
T09TVF9FTkFCTEVEOw0KPiA+ICAJCXBvbGljeS0+Y3B1aW5mby5tYXhfZnJlcSA9IGNwdWRhdGEt
Pm5vbWluYWxfZnJlcTsNCj4gPiAtDQo+ID4gKwl9DQo+ID4gIAlwb2xpY3ktPm1heCA9IHBvbGlj
eS0+Y3B1aW5mby5tYXhfZnJlcTsNCj4gPiArCVdSSVRFX09OQ0UoY3B1ZGF0YS0+Y3BwY19od19j
b25mX2NhY2hlZCwgdmFsdWUpOw0KPiA+ICsJd3Jtc3JsX29uX2NwdShjcHVkYXRhLT5jcHUsIE1T
Ul9BTURfQ1BQQ19IV19DVEwsIHZhbHVlKTsNCj4gPg0KPiA+ICAJcmV0ID0gZnJlcV9xb3NfdXBk
YXRlX3JlcXVlc3QoJmNwdWRhdGEtPnJlcVsxXSwNCj4gPiAgCQkJCSAgICAgIHBvbGljeS0+Y3B1
aW5mby5tYXhfZnJlcSk7DQo+ID4gQEAgLTQ3OCw2ICs0ODgsNyBAQCBzdGF0aWMgaW50IGFtZF9w
c3RhdGVfY3B1X2luaXQoc3RydWN0DQo+IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpDQo+ID4gIAlp
bnQgbWluX2ZyZXEsIG1heF9mcmVxLCBub21pbmFsX2ZyZXEsIGxvd2VzdF9ub25saW5lYXJfZnJl
cSwgcmV0Ow0KPiA+ICAJc3RydWN0IGRldmljZSAqZGV2Ow0KPiA+ICAJc3RydWN0IGFtZF9jcHVk
YXRhICpjcHVkYXRhOw0KPiA+ICsJdTY0IHZhbHVlOw0KPiA+DQo+ID4gIAlkZXYgPSBnZXRfY3B1
X2RldmljZShwb2xpY3ktPmNwdSk7DQo+ID4gIAlpZiAoIWRldikNCj4gPiBAQCAtNTQyLDYgKzU1
MywxMSBAQCBzdGF0aWMgaW50IGFtZF9wc3RhdGVfY3B1X2luaXQoc3RydWN0DQo+ID4gY3B1ZnJl
cV9wb2xpY3kgKnBvbGljeSkNCj4gPg0KPiA+ICAJcG9saWN5LT5kcml2ZXJfZGF0YSA9IGNwdWRh
dGE7DQo+ID4NCj4gPiArCXJldCA9IHJkbXNybF9vbl9jcHUoY3B1ZGF0YS0+Y3B1LCBNU1JfQU1E
X0NQUENfSFdfQ1RMLA0KPiAmdmFsdWUpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4g
cmV0Ow0KPiA+ICsJV1JJVEVfT05DRShjcHVkYXRhLT5jcHBjX2h3X2NvbmZfY2FjaGVkLCB2YWx1
ZSk7DQo+ID4gKw0KPiA+ICAJYW1kX3BzdGF0ZV9ib29zdF9pbml0KGNwdWRhdGEpOw0KPiA+DQo+
ID4gIAlyZXR1cm4gMDsNCg==
