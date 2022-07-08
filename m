Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E242B56B8DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbiGHLs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbiGHLsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:48:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101267B363;
        Fri,  8 Jul 2022 04:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3383My+TvkOiraz4MHRCFv5tZ3aIqFA9sd1LHErOr8vyp9i5eAQFYsWDXmMs+O4QUoLYpKKcWBDweGSAGuSM8EvJnFLZ6ti0ZLJSycqII40bGGuFypAM2Zu1uhIsKTdDqkWQIypOfoaiP3TSS6XYIAb3c/3HWR/9QnLYwhhXAfhd26aAUn+Y4jFIoRn336YMWypBW8V99ra1FCjNWy/6TBcQ/UsXcV9Vr7c1RKX/QvfjY8bl3rJu1UktMk0vBWt/Dtv1CVUZDahFyaQSL73x01MRGk+0ncI44Ljvo+WL+wrHlceweBPypfYlWz3q9yY8YiKlMsLi/44YWm4CtRWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/yXuAzlazXwzKhXtJ8xFam9pVa1dMVK5usihwjdANo=;
 b=nkF74tsDySHxRFYD1jhXXnsumkF4ykX8PBJ0msZqjplx2L+ZbKdsMv/3ed+PjF7z61HugQC2Z29zRF8iORTMlkRDvizqHhi/8WvfcSR7tJuLa8APC4Nv2Smbrpcrk8aAqsRN+E4vEZzp1w10GejkTkG82Hk0hu8/Y/OG2lzYjkm495aXAHse2ld8OGtu7CjWDhUp2qbckdws0KTcEQN25oI9PvslWvBQQLMyIIKx0H85LRrPx4JkJH2LeJcwl774EB1Qsso7sLhvNI7/9tBkD2amMO6IO/bXRNU77xk+rNbsB0AK6o8zvhBuxhD31BdGabpSP9ta4WPo6RQA2paBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/yXuAzlazXwzKhXtJ8xFam9pVa1dMVK5usihwjdANo=;
 b=0oD9qSWS4RZg5NrF1FrH/Pda7/bAceM5PAqQvXacIKIcHQ1FQMhdV2k+7wa3W6QbG7hoMgPCMEfBvFNQVBL5g0W/gu3F3Km/ikEqTqUrqw+aYb+WQ3rqV2uYYoMwc3WszQR5paUNUNQSBvcTXSMpXoaS9Pbzdys+x08pxaMcB3A=
Received: from CH0PR12MB5265.namprd12.prod.outlook.com (2603:10b6:610:d0::22)
 by BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 11:48:50 +0000
Received: from CH0PR12MB5265.namprd12.prod.outlook.com
 ([fe80::4c8e:9d96:2b0e:fc0f]) by CH0PR12MB5265.namprd12.prod.outlook.com
 ([fe80::4c8e:9d96:2b0e:fc0f%7]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 11:48:50 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Subject: RE: [PATCH 11/12] cpufreq: amd-pstate: add ACPI disabled check
Thread-Topic: [PATCH 11/12] cpufreq: amd-pstate: add ACPI disabled check
Thread-Index: AQHYkiM2n3a7Df2Hu0mfhH7z72bhwK1zUCSAgAEMfPA=
Date:   Fri, 8 Jul 2022 11:48:50 +0000
Message-ID: <CH0PR12MB5265B5E589A4D91F981A4E4A9C829@CH0PR12MB5265.namprd12.prod.outlook.com>
References: <20220707170116.216912-1-Perry.Yuan@amd.com>
 <e07cfbfd-da96-1251-4d17-2e4bef64e355@amd.com>
In-Reply-To: <e07cfbfd-da96-1251-4d17-2e4bef64e355@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-08T11:48:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b4e845b2-a051-4055-bd3d-140fd8e6b18a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-08T11:48:46Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3eb410aa-3fcd-42aa-b49f-09a069d880e8
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbda73c7-6640-42be-1326-08da60d7d329
x-ms-traffictypediagnostic: BY5PR12MB4936:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ENEdWP9M+ySycqfZttzJ56YMgf8RaETzVfAbZMi7rCbFhhb3hnqG4Tf3Mrbv4RzyhuzhRHqz1yUfZm3UkGxtKzMixaGIUc7PSWD8A4Ym772oOT7xrsbVEX3SAvSuwLDgFX/+xDzmTPo+a0pMgtoToKoCHPnpRYIuStsJncZWQ7I1Wl+dpLv0WyI3ceDVnsZVGnL8fm/20QghX1bFUgfaMld7PvepWEMfg+JhBQvDtxEPNUC0PDytV/IsYQqgqmLkKLx5JIff2qB+uMwqxHR0qOFRDFT9o/L1tfYluVZPkPcRucDJNufzFCUv8z2HsDQXpCCYzUNj52UyjxC8cn1CArb+7ucBzOtIlvyyax43ejcm+5Rgi6nczYwsmz7OjpT1cEkHVqcarbXbzx8NB9CrVBvInvN+BXgdJuhzmEsAuQYpUsfHdzbnu19czl6ZmchW3fUMXwluOe+Zucrdf/l8UVk7ys3doGayc9g+C3xoOoIFAbkdDkWFxTMxuy6LeGJ3ksXwTWpUNTIAkJ+Z32ewCXYhSFlsSzJ35QuugRwY9ryXjKQlyHfN+oS0mNDDjS2tSBDwEq2YfkuTwfLtDhDfpv3iw9enMZK5YO9xB0ltwFNqgBT8MWPbo7J5yJGWWWOCoLSgqrWtTVgOnHYTYvFL+L6Dk/UkpZPiFjA7UAm0cSE3fstLmBOftE92Pfn6LwXADVSq3KQLY0bubUTyZTkSK2DXmBs1djktLSKU35ch8hFNioyWj5wB/mZcGJlNml7XPjX6FvVVX/e3lTiglg6gNyAvkpb36JWQKkzWwsW7OVzHk9dw8I6xkyYGEr3eVLqfnhpvTChHQRdtdRp7j+SaYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(76116006)(64756008)(66446008)(8676002)(38100700002)(316002)(66556008)(66476007)(26005)(66946007)(4326008)(52536014)(8936002)(86362001)(5660300002)(38070700005)(110136005)(122000001)(9686003)(478600001)(6506007)(7696005)(53546011)(2906002)(71200400001)(921005)(83380400001)(33656002)(41300700001)(55016003)(54906003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTVvVnRqY0RLSDhGajRaV21WeUJCMnZYbkFWblFjL1lOSFlZdlJSTFpDVWdB?=
 =?utf-8?B?TXZHazVyR0JwVUJsREV1VUljQWwvOVpGbmQxelQ1Vk9VSjJOcWk2eGtxZ3U2?=
 =?utf-8?B?cUtGTS9hWFU4ODBnZjN1ZEYvMU5nZjVSdHBSN3pKMmRuUUVkL0dSWlVxRzlo?=
 =?utf-8?B?ZVAzU2tlRGVXVHljRmhBTkFQaWMzTnJKeUdxL1FxTFBXTjVQYmovV2J6MTNk?=
 =?utf-8?B?QjFGTVdHT3NwU3p5RXd6UmZwMGE0bFZyQm5XT2VLS2tjeU9ScmpMbERMaUlv?=
 =?utf-8?B?c3VsVzNUYzdicEtUbG53cnhhVVhMNnJYTDc3U1NOQ1NHSDFoVi8xeXRVTTJp?=
 =?utf-8?B?V1U5NHhFWGxab3hOWTZpalI3eWg0VStPaW1odnp6NkRldm5zRldPRzAzZCtV?=
 =?utf-8?B?V3hHMVZHZERIK0V5UW00SzlmWEZvU0dSajJFeTN2RklzZzZuTkpBQktBYmQ5?=
 =?utf-8?B?N28wMmZCZU5QZ1BCWlc0VVdSYWRETjE4TDVwRHpFT2ZjT2FiVDQ3WldLM203?=
 =?utf-8?B?cVViQUN4aXN2aFF2OTF0QVdLclErQW1rZERFZ0VxOTlxMUV6NWtPdzFVck9V?=
 =?utf-8?B?QTZvaTdIT0FiTnRTclJ0cnp0VjF2MHhYdVBTNzdvckg0Z0tzQ2Y4RGpBUVV1?=
 =?utf-8?B?NG82OVV0TU1neW9VbVczN2RHRGdzMkNxMFRxeDBGKy9KU0d2SnBpWjZUd2NZ?=
 =?utf-8?B?L2RRdHJVNkNWci9xRW42andrdCtoZlQ3NUUyMEtheGNpdGdLTUpyazdOb1BE?=
 =?utf-8?B?eGNXaTNzNExPWitjOW9zL2JkdWk3QUlxTzZuUTdYenlWWXBaUWNyMXlQS0Qw?=
 =?utf-8?B?bzRrbGxkNHhDRTR0ZG5TeUt0RlpTTVFjRmpzL3RQWG83UGFkc3kzV2IxOHo5?=
 =?utf-8?B?ZFFQdi82c052eFE4dnlIVVZXSGZCSE9mb1FxVDcxeDBleFMwNjI0bmpERC9k?=
 =?utf-8?B?bExiak1DQjBhK0VrYVNTcDVwcXRuT0N0Wm5kREtycURiRGpwV3c3cWNENmhY?=
 =?utf-8?B?d0NhMk1NRStqbTdUOC9sdHc5ckJiSys1YWNMWFUxeExTN2YzTGQwMXFuZDhD?=
 =?utf-8?B?SmhxcUVrcThTQjB0OGVjaitxb0FlMWUrZGY5c0ZwMHdOTEJUYzZ6Rm9QRTR2?=
 =?utf-8?B?QjEvbTcydDlKd3BCSFl2TUNWb25rRFhzWkJXK0c3c1lnK1JhYlBSYTNyb1hQ?=
 =?utf-8?B?UlZoQkxoam9YNFRZNmZSNXJkT2MvMnJFV1F3dEhrbSs2RnhNaWNOZ25uQzR1?=
 =?utf-8?B?bDVOcVp2MlFYMXVLQnRPVjZXbWJFTVZKUHBIK0o0dE03UkZOS2doVHkyYStj?=
 =?utf-8?B?UE1KanMwVFRrTW51VVRJcFp0Z3lPeG55YnRkNkxBQWloc1JHVksyYXljNUtq?=
 =?utf-8?B?QkRNbGN3aVAzUzFTenEydXNja2d2TytKMWtZbTdiUTV4c2xyS0ZvZTBRdTRm?=
 =?utf-8?B?cHNGTllkbCtQeWkyc1J4L3RkL3M4ZWdLcGM5Yllra3ZzbkFMQUJqOTVaK1Ew?=
 =?utf-8?B?bjZmRjN5RU9uMUFCY2EyVEpLRllKQUlYRWpLbmUxUEo4Ky9sU0FLNWtjQTRs?=
 =?utf-8?B?WC9adWM0cE9pVFNNWitucWdOamZuWktKUzRYVklLT2JpNkNKSUxPczk3Unlm?=
 =?utf-8?B?MTUxdmkrNEREZzdmREhibWt0S1JjTUFjR3JVRDdwam9ZRmhZRTlwQWZranRj?=
 =?utf-8?B?VzY4Y3RPNVVKbXJwSmd5cE1ieVcrMUNaa29udzlsakViZllOYlI4MUV4WjdQ?=
 =?utf-8?B?TzhOTFdYaUFWZXpxSlQ2bzdERGJLY3NkSHhWUlZZamd4YytIOFUxTUhOUVdK?=
 =?utf-8?B?Y0V3SlJKeUdDTXZpdjE2dHJXakZXZ01MWHowVkhxU0RMUW5DWnNla0xTSlgz?=
 =?utf-8?B?QVZTSG5XYVgwSnlnUmlsZW5wcEZRSU5qY0JBZVpOemo4NE9iQm45WTBpUGZ6?=
 =?utf-8?B?SDNsRWtubzhHVFBBUzlZYmhYTmZSMWxXYWQwa1BvekVGc1dPNktmeDBhaTEy?=
 =?utf-8?B?Y2lXYXdyY01NemkzTURlMEJXU3Fja2xOYzZrOURzVXN3V3d0Q0s5V1FKOTJs?=
 =?utf-8?B?ZVIxQnQ2ZTRTTnFUb0lmbU95YUV0SFFWNHhwQnpTYStLcTVRY2psU3lwMW0r?=
 =?utf-8?Q?yY+cNcOx4RU2TDwvZULJf6qO3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbda73c7-6640-42be-1326-08da60d7d329
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 11:48:50.3109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZCLDeoobbldCy4BdKdqAQsBQ6QVVUUtO6Zs4J8in5InNwo/5HIsLm6K7L/+h2xx+oqmarD+Ta9H5Xp0I6saRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4936
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
Rm9udGVub3RAYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDgsIDIwMjIgMzo0NiBBTQ0K
PiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5qLnd5c29ja2lA
aW50ZWwuY29tOw0KPiB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgSHVhbmcsIFJheSA8UmF5Lkh1
YW5nQGFtZC5jb20+OyBSYWZhZWwgSi4NCj4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBM
ZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IGxpbnV4LQ0KPiBhY3BpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHBtQHZnZXIua2VybmVs
Lm9yZw0KPiBDYzogU2hhcm1hLCBEZWVwYWsgPERlZXBhay5TaGFybWFAYW1kLmNvbT47IExpbW9u
Y2llbGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IEZvbnRlbm90LCBO
YXRoYW4NCj4gPE5hdGhhbi5Gb250ZW5vdEBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgU3UsIEppbnpob3UgKEpvZSkgPEppbnpob3Uu
U3VAYW1kLmNvbT47DQo+IEh1YW5nLCBTaGltbWVyIDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBE
dSwgWGlhb2ppYW4NCj4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLCBMaSAoSmFzc21pbmUp
IDxMaS5NZW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMTEvMTJdIGNwdWZyZXE6
IGFtZC1wc3RhdGU6IGFkZCBBQ1BJIGRpc2FibGVkIGNoZWNrDQo+IA0KPiBPbiA3LzcvMjIgMTI6
MDEsIFBlcnJ5IFl1YW4gd3JvdGU6DQo+ID4gQWRkIGFjcGkgZnVuY3Rpb24gY2hlY2sgaW4gY2Fz
ZSBBQ1BJIGlzIG5vdCBlbmFibGVkLCB0aGF0IHdpbGwgY2F1c2UNCj4gPiBwc3RhdGUgZHJpdmVy
IGZhaWxlZCB0byBjYWxsIGNwcGMgYWNwaSB0byBjaGFuZ2UgcGVyZiBvciB1cGRhdGUgZXBwDQo+
ID4gdmFsdWUgZm9yIHNoYXJlZCBtZW1vcnkgc29sdXRpb24gcHJvY2Vzc29ycy4NCj4gPg0KPiA+
IFdoZW4gQ1BQQyBpcyBpbnZhbGlkLCB3YXJuaW5nIGxvZyB3aWxsIGJlIG5lZWRlZCB0byBiZSBw
cmludGVkIHRvIHRlbGwNCj4gPiB1c2VyIHdoYXQgaXMgd3JvbmcuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBQZXJyeSBZdWFuIDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvYWNwaS9jcHBjX2FjcGkuYyAgICAgfCAzICsrKw0KPiA+ICBkcml2ZXJzL2NwdWZyZXEv
YW1kLXBzdGF0ZS5jIHwgMiArLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9jcHBj
X2FjcGkuYyBiL2RyaXZlcnMvYWNwaS9jcHBjX2FjcGkuYyBpbmRleA0KPiA+IDZmZjE5MDFkN2Q0
My4uMTdkNjdlM2VkZWRmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9jcHBjX2FjcGku
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9jcHBjX2FjcGkuYw0KPiA+IEBAIC00MjQsNiArNDI0
LDkgQEAgYm9vbCBhY3BpX2NwY192YWxpZCh2b2lkKQ0KPiA+ICAJc3RydWN0IGNwY19kZXNjICpj
cGNfcHRyOw0KPiA+ICAJaW50IGNwdTsNCj4gPg0KPiA+ICsJaWYgKGFjcGlfZGlzYWJsZWQpDQo+
ID4gKwkJcmV0dXJuIGZhbHNlPiArDQo+IA0KPiBUaGlzIHNlZW1zIG9rLCB0aGUgb25seSBvdGhl
ciBwbGFjZXMgSSBmaW5kIHRoYXQgY2FsbCBhY3BpX2NwY192YWxpZCgpIGFsc28NCj4gY2hlY2sg
Zm9yIGFjcGlfZGlzYWJsZWQuDQo+IA0KPiBJZiB0aGUgYWNwaV9kaXNhYmxlZCBjaGVjayBpcyBh
ZGRlZCB0byBhY3BpX2NwY192YWxpZCgpIHRoZSBvdGhlciBjYWxsaW5nIHNpdGVzDQo+IHNob3Vs
ZCBiZSB1cGRhdGVkIHRvIHJlbW92ZSB0aGVpciBjaGVjayBmb3IgYWNwaV9kaXNhYmxlZC4NCj4g
DQo+IC1OYXRoYW4NCg0KWW91IGFyZSBjb3JyZWN0LiBJdCBuZWVkcyB0byByZW1vdmUgdGhlIHNh
bWUgY2hlY2sgY29kZSBmcm9tIG90aGVyIGRyaXZlciBmaWxlLg0KV2lsbCBhZGQgdGhpcyBmZWVk
YmFjayBpbnRvIFYyIHBhdGNoLiANCg0KUGVycnkuIA0KDQo+IA0KPiA+ICAJZm9yX2VhY2hfcHJl
c2VudF9jcHUoY3B1KSB7DQo+ID4gIAkJY3BjX3B0ciA9IHBlcl9jcHUoY3BjX2Rlc2NfcHRyLCBj
cHUpOw0KPiA+ICAJCWlmICghY3BjX3B0cikNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVm
cmVxL2FtZC1wc3RhdGUuYw0KPiA+IGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBpbmRl
eCBiNTRiM2I1NTk5OTMuLjZkODFhOWE5NGRkZQ0KPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3Rh
dGUuYw0KPiA+IEBAIC02ODQsNyArNjg0LDcgQEAgc3RhdGljIGludCBfX2luaXQgYW1kX3BzdGF0
ZV9pbml0KHZvaWQpDQo+ID4gIAkJcmV0dXJuIC1FTk9ERVY7DQo+ID4NCj4gPiAgCWlmICghYWNw
aV9jcGNfdmFsaWQoKSkgew0KPiA+IC0JCXByX2RlYnVnKCJ0aGUgX0NQQyBvYmplY3QgaXMgbm90
IHByZXNlbnQgaW4gU0JJT1NcbiIpOw0KPiA+ICsJCXByX3dhcm5fb25jZSgidGhlIF9DUEMgb2Jq
ZWN0IGlzIG5vdCBwcmVzZW50IGluIFNCSU9TIG9yDQo+IEFDUEkNCj4gPiArZGlzYWJsZWRcbiIp
Ow0KPiA+ICAJCXJldHVybiAtRU5PREVWOw0KPiA+ICAJfQ0KPiA+DQo=
