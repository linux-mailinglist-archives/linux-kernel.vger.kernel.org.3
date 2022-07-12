Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27CE5715AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiGLJ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiGLJ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:28:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6023D9FE17;
        Tue, 12 Jul 2022 02:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WooiOqU5h1Uno+rF65aH9DhHyq9Qe1CvWGF1+eLLIoB3YhzFgSjxkvykHiXl9qIg/xsrg/nCtKGz3io/6q3zfKBUdoBuW2hJMQ7goPV5XyedIMjMV12UZ7hW7U9y69Pf3B2bcjNq+0H0MPDC5P5Vh9OkAMp+xOt91WeeyQxYYE/79vqqGKJluxqdoi6xkP0bH+zBojRq5SkIe3rSlSZTlp3pe7P1fCXuSqN9GHDzse+1qaKIyxWZHjgcrXv0wYPpcYAFHJz9gBPCLG8YxWqtYaJ7JF0r+WI+5I9CV/4QL+95vVDInQPSYaA6mFRGZUIkCrKq1r4xJDEWsMuKSzPIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qn4aIIVxVLhWsVNoVxXbddwWH88vKIJy90yeOciVXs8=;
 b=KOel3NwpVGONkFVSQfICFiaoj/w44fVuLk2f9BGLGFT2VAGyGJCAce9D7AqGwXw8PaoEuWz0DJKQiT81aQaSZW+ikLVtWL5CIgRw427SsKZtbafS5Cp2Jiv/hHBFzUwrBHvA8DdsPJmUMF2fmZfNJ/pBmZNUXGjG5cXTS1FSmeERXmbZeif4nuNpVMTQYLvhasIPT3y3QGWxAaLL7aMHaea8hK9jQ4wMwwJ1nkZIwaNQ462Fogb577Q+VUei9igBxOhGKaioTCMJ55x8CAgyCcGhwOcowVZzpzTx7K/S/UTcg0t/UzZdLnvE9H2RHpsvhHCzkV+0tp2mZLfWyQ5/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn4aIIVxVLhWsVNoVxXbddwWH88vKIJy90yeOciVXs8=;
 b=GfdzGFtQC2P6FXLcx0IAHltLK7lNSlkSnXTtn94Pdj4fe8bb90CXLGP/2ZEU03112oJVuMnKEm8EB0kJVUIbq7JZhYPuOCDj9gthkLtiaAnJhBH/6rGIQyD1yfnA602Z91Qu04vfWxfmfGPrmgletILE1WD1alcuk1DIM4bdlsw=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 09:28:23 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a%9]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 09:28:23 +0000
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
Subject: RE: [PATCH v2 07/14] cpufreq: amd_pstate: map desired perf into
 pstate scope for powersave governor
Thread-Topic: [PATCH v2 07/14] cpufreq: amd_pstate: map desired perf into
 pstate scope for powersave governor
Thread-Index: AQHYk57i2r4aTdgb506eXFcSn0/HnK15kwoAgADo7GA=
Date:   Tue, 12 Jul 2022 09:28:23 +0000
Message-ID: <DM4PR12MB52788EDE6858849143B05F749C869@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220709141901.835903-1-Perry.Yuan@amd.com>
 <359a0e0a-b118-450e-67d8-a784d1a43cca@amd.com>
In-Reply-To: <359a0e0a-b118-450e-67d8-a784d1a43cca@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-12T09:27:27Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=499f41ee-9027-4803-b2bf-992f75927aa1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-12T09:28:20Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 98641d82-19e8-4365-9d97-a3c23031a223
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62f601f1-9f75-4f59-adc9-08da63e8ddee
x-ms-traffictypediagnostic: SJ0PR12MB5661:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t2vn2Dh23KGQFhY02MvPk4gG9JnPwpxGmEpGuAMZ3S5aif0WWTCdhFes8clTdYGawt0VntajoE8L1OjO7qUcUt00oB2lIWlA4Kc4M0jakFvLb6wIhaM69QvqDa/74wXPJ6XGg96CM/KWpm7ZfBsYZDrbOpB2mOH3QGAZGkEHQsJqMEPnZTgXzXqblznaeVylSS3TaEuacrybwMGZQAf/yDzCLbd4GlUbIrQuDcWjE4XQLKzXwHN0FzcybqzySSqc9YJPRbBGtb+Vw56FYlWZVQe7jTObqQsedXvQ/FnvfIF8bq2MEQSfX9ifQImVuvu8LLMTFQRqnR5DzrEYQ+OKENgA3ak0UBMETlNu1MzO5zOHps0y5+VtbE43+SeTXDxmf9WHdRxU4IaNucez5JTCoD4wnjqsaci6sgnb1ygtfoLV5Xx8+MniKSS1uKjmVDHODMbR8208KW8it8cTd4kBiEiWgpxbpoxoSwPPBg55yaLPv39GVvfL5imG/ZxYt9t+f9m9RbCDaaXBD424x7Kve2HNIiqosTVDPZj/QnJqjI1luaNWvfF4JPwbcf18cvCv0vSuen5nFaqwjMKmnYpqHDAMu8eW8UMJecGocg/Qr6d9ILRRYlt248UBvEE2SLPNryNpCqcxpI0LKetUJAWAq/fN2Ruk0CcPio6GHPhrBmRgid1+z7ri6V+ghnvaqAJcsl12gT0gpsOP4ujsp08VClnzcRGjJvB3Nzv8cAigQUnIdRsoRi6w1QWW8DkBZ5F/r0/D01iOJzldIuNZHd+Odgfg4KYcZTTNVueajI99PpfsTYVXlSF7y4ORpagKbSPp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(55016003)(83380400001)(38070700005)(7696005)(86362001)(122000001)(38100700002)(5660300002)(8936002)(52536014)(71200400001)(2906002)(41300700001)(66556008)(4326008)(54906003)(316002)(110136005)(33656002)(76116006)(66946007)(66446008)(8676002)(66476007)(64756008)(9686003)(53546011)(6636002)(26005)(478600001)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTNROFBkRklPZmVyZ1lNTXNQeEtIQ0FLdFhmLzNsTEtCVnE3eG4rQ1ZTVDM3?=
 =?utf-8?B?VVhPS1k5WEl2eDdMZHhXOVUrNzBHUWlUdC9VcUpac1JoTk16MlMra0ZzK253?=
 =?utf-8?B?dEN2cVo2RVgyZ294a0o4NTk3bmhvTFc3Z3Awd3JkVG9UTHJKWU9pT1dKakpC?=
 =?utf-8?B?b2Z5dURuVTFjUnpYaC9MNTBCVlJaRGs2VWRacmh4dHZuZ21KUVlmc25hbm45?=
 =?utf-8?B?MG1ncUI0S3E5aVp5eG9kbUU2NW5YYVJTa3B6MUtGZ3RyaWQzWEdOdHNudEZB?=
 =?utf-8?B?ZUU2YUUvcUNMQThvaFJUK3dBaENhSmhnUWFTU2UwcXh6NFk3SmdPTG9lRmM5?=
 =?utf-8?B?SGJtM3VkcCt4b2s5WjQxUFMvQWlxbG5GTHZFeUdRM2lMMEptaUQzWUlJdzN1?=
 =?utf-8?B?alhpUnZGRllPTWEvUFFKVG8vbFlxaGFJSmRzNTNrcUF2Y3ZHVXJzc3drZ1Vl?=
 =?utf-8?B?OXBoZHVlYTZISWlWSkR3Z1EvZWFhU3JmcnoreElaa0cxZkJPT2NWQ0NyUUFa?=
 =?utf-8?B?U1dva3Vhb3BHSktMM2xLbGlNaDkxRDBaZEl4dmY3alZzN0phWWEzakZpWDB4?=
 =?utf-8?B?cnZHTU9GRnpzbytxUEFaR3h4U0F5SGF5VzlQSG1iK0JGWGFNYWZYVFF0SWRS?=
 =?utf-8?B?RmltNWpxYnRIZXhXSUhnS0JkWnZURzRQN3JBV2FiTW91aFR1RXc5bk1xTmp0?=
 =?utf-8?B?dW9VZDlFU3llMi9lWCtCQVRGZEdONDdOU1gyc0xTMnFhQVIxMzVlVHBMM1pT?=
 =?utf-8?B?ZVhoNTJ3MlZYbW5MQ2twT09ZcU1JaTkwTkVlRGZJOUlhb1U3ZGZQRno1RFpH?=
 =?utf-8?B?WDNYZ3BBSWdzK2F4UEJaNHV0eWE0cmYzRTBOd3VQdHdXYzdXUFZ5ZmNLMmZ2?=
 =?utf-8?B?Y2FwaFNDZUhjOVJrZXpzT1FVU0o1cTdCb1kwT1hSN28vdHoyTXZZSGRoc2FJ?=
 =?utf-8?B?YVViUHlYYmVFZGJJNkRXb0dwVEgxdnRvZVJYTk1veWkzcTgzM2tpR1pKdkJ4?=
 =?utf-8?B?aktuazNMVnNHblU3V1dlZmZiU2I4dVhTek5QQzlaR2RiemlzczdyeWJGN3dy?=
 =?utf-8?B?V2xhWnJ2eEliOXcwUk1NSzMzYkljVUpWZkszblZxNURFUG00L3JkdHBPMTBx?=
 =?utf-8?B?SnZtT0g2dUwyeWxHTmZubTEvbUFMaHhuVFNCbzVCNkN6QUM2a0V0bWh4VUxL?=
 =?utf-8?B?czZZSWN3NnVxSEJNWkN6YjZ0UFJKM0dPMnJSbXpRSmVhY2tWYkFXNlZHb3Ba?=
 =?utf-8?B?Q2MyZXNsNnJwQmNpUmtTYllUQlBXT2x6ckpueEdyWGxaUFdaK0xPdkhUeFhk?=
 =?utf-8?B?QkRJSXVKYVZ4MFZrUXBMWTVya0daVG9hbUVsaEMwSkpESWdjd0NLYjJMTmVk?=
 =?utf-8?B?ZjY1dXhpc3dyVFQzeWc3ckV4UytVY05vRElVUXFKZHBGTUFoL2RkVFdEMWht?=
 =?utf-8?B?TGdocGNURG01NUs1YXBTYmpQSGdmRXA1MVZLNlNsYTgzTEdFdnpYZi8zb3ZX?=
 =?utf-8?B?SjhFNXZ1aHhhWEl1dmx0Uk1ZWlF6ZWlpNW93UVhuVk1SeHQ4QlJ1MUhaME4z?=
 =?utf-8?B?YzhXZGU5a3ErZHJtck5FTW4xMGtaQk9GYzRkeld3Qmx3SEpIV24zOUd6UzJU?=
 =?utf-8?B?emkzMVZvVGVEenpXZmVONi9HQVZIMlcxd3lRMVE2WjJYZ0d4RERUSk1jTzRn?=
 =?utf-8?B?ZHMzM3AvWHpyMTZOcEFZNjRNT1hOV1IyOHJqbUNESnVQVFgxR0NiUllNQW5E?=
 =?utf-8?B?TnRFWmRKQXI4K0Fkdnd1ejRZZ084Q1BKNWlGMURJNHVoQnplRk5xaG5veVE3?=
 =?utf-8?B?d3VqbW9WWmhRaGt6SWxHdktxZituOXhicGVMYWNtWG9UbWZlcE1OZkRZbndZ?=
 =?utf-8?B?TnVFUXBhUFBGVk1XYXV0Zyt6dTFGRkg1dDhCTFBFK1B0Q2NlMyt0bU1UWTdk?=
 =?utf-8?B?dkJ2V3ZwRDJTZmd2bVBjUkdmK0lyNXlZdFBvcUk5a3FJcCtpM0pQMG9GYXc4?=
 =?utf-8?B?UjR6UDAzSW8zSDY0VlhVbHN2aWxIYmoyVTNKRnpLY21BTkR1Mnhjak1aWlFL?=
 =?utf-8?B?dTVVeENSelV1ejVGcjBHM29ZOWF1Q3FoeEhMZ3F1VzdRbHZNZFRPVlFIZGVp?=
 =?utf-8?Q?+x4DpvJ7iZ8rxit2ShGGRyJaA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f601f1-9f75-4f59-adc9-08da63e8ddee
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 09:28:23.2678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yYJKxBgqVP1qad3mJvYdukZgErZ01xNB3P+3PWT0Pn7yGprcJYQNMlWyiFthNqzxhDLkKkQY+irrWy5XHL5odw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE5hdGhhbi4NCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGb250ZW5vdCwgTmF0aGFuIDxOYXRoYW4u
Rm9udGVub3RAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVseSAxMiwgMjAyMiAzOjM0IEFN
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
IDA3LzE0XSBjcHVmcmVxOiBhbWRfcHN0YXRlOiBtYXAgZGVzaXJlZCBwZXJmIGludG8NCj4gcHN0
YXRlIHNjb3BlIGZvciBwb3dlcnNhdmUgZ292ZXJub3INCj4gDQo+IE9uIDcvOS8yMiAwOToxOSwg
UGVycnkgWXVhbiB3cm90ZToNCj4gPiBUaGUgcGF0Y2ggd2lsbCBmaXggdGhlIGludmFsaWQgZGVz
aXJlZCBwZXJmIHZhbHVlIGZvciBwb3dlcnNhdmUNCj4gPiBnb3Zlcm5vci4gVGhpcyBpc3N1ZSBp
cyBmb3VuZCB3aGVuIHRlc3Rpbmcgb24gb25lIEFNRCBFUFlDIHN5c3RlbSwgdGhlDQo+ID4gYWN0
dWFsIGRlc19wZXJmIGlzIHNtYWxsZXIgdGhhbiB0aGUgbWluX3BlcmYgdmFsdWUsIHRoYXQgaXMg
aW52YWxpZA0KPiA+IHZhbHVlLiBiZWNhdXNlIHRoZSBtaW5fcGVyZiBpcyB0aGUgbG93ZXN0X3Bl
cmYgc3lzdGVtIGNhbiBzdXBwb3J0IGluDQo+ID4gaWRsZSBzdGF0ZS4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvYW1k
LXBzdGF0ZS5jDQo+ID4gYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIGluZGV4IDdjNTFm
NDEyNTI2My4uOGEyYjZhZDliOGMwDQo+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJl
cS9hbWQtcHN0YXRlLmMNCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+
ID4gQEAgLTI2NSw2ICsyNjUsNyBAQCBzdGF0aWMgdm9pZCBhbWRfcHN0YXRlX3VwZGF0ZShzdHJ1
Y3QNCj4gYW1kX2NwdWRhdGEgKmNwdWRhdGEsIHUzMiBtaW5fcGVyZiwNCj4gPiAgCXU2NCBwcmV2
ID0gUkVBRF9PTkNFKGNwdWRhdGEtPmNwcGNfcmVxX2NhY2hlZCk7DQo+ID4gIAl1NjQgdmFsdWUg
PSBwcmV2Ow0KPiA+DQo+ID4gKwlkZXNfcGVyZiA9IGNsYW1wX3QodW5zaWduZWQgbG9uZywgZGVz
X3BlcmYsIG1pbl9wZXJmLCBtYXhfcGVyZik7DQo+IA0KPiBZb3Ugc2hvdWxkIGFsc28gdXBkYXRl
IGFtZF9wc3RhdGVfYWRqdXN0X3BlcmYoKSB0byByZW1vdmUgdGhlIGNsYW1wX3QoKQ0KPiBjYWxs
IG5vdyB0aGF0IGl0IGlzIGRvbmUgaGVyZS4NCj4gDQo+IC1OYXRoYW4NCg0KSSBtaXNzZWQgdGhh
dCwgY2hhbmdlZCBpbnRvIFYzLg0KVGhhbmsgeW91IQ0KDQpQZXJyeS4NCj4gDQo+ID4gIAl2YWx1
ZSAmPSB+QU1EX0NQUENfTUlOX1BFUkYofjBMKTsNCj4gPiAgCXZhbHVlIHw9IEFNRF9DUFBDX01J
Tl9QRVJGKG1pbl9wZXJmKTsNCj4gPg0K
