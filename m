Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C564DB51E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbiCPPpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242606AbiCPPpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:45:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B2C35DF8;
        Wed, 16 Mar 2022 08:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLNTt38Y4JApS8O4ntMwm/5UJ0bpgOjZpQ+YItd2/QCSc6a3fl3meY9DOK2IPbTjlAgvtSvALtay+n+dobIvx573qN9GRk8rn+01IjBfvWTEcBaFRFHNTURoTjh6SjfmPn5YB/5FLfKPTpwqPNSmRgEAkUvq/2wspNKkFWuJSM5H1HwL3X+TwjkivNBYQOzehCjTYcz/bdBvCykkyh7AqfhS+iCYT1bINx22PBmUyfdQ52H8ehAopbwNSevnvVNDXaB8jcE/0NtJe6cWbTDf/pZeir7zbsTg8+wF9uEPbIHP17lEuMmIqtucsBk2z62w3ueyszwISgEP54c80cNhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=765mrgy6q3kvSy7sQIhzPbOAkp6SbpDvlZREJPhk2Y4=;
 b=ObPdrOWzm686mL30AhCW4KlIdAwBnUej7XbsQ5swiYpAc7+Zh40NmkuIDwi1RI4ti4LhJpieGlmcx4DGu4jp3wg/hemophD9Vs12WfvOHm6U+bRhk03OMQpDAefBpYiCgjtP3WDSIFZAGOfLVtujEj55cxnStkeEvcr+blNgElEhaS8MxjiqY8lSaPAzwbncTTRuE4Q9nigRx6FOZ3k57cRhuJBfdkYdMaGLOVOM/sooGB3PG13pPeQa9ZyI/xwP+YwHLXYykQV9AakdKpqAu1Ka04Sx8IL+zf4qMceuijqXqTeqy0SocZr9PxuiZYUHOWyxRsZ+aj1aV/2cgCKNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=765mrgy6q3kvSy7sQIhzPbOAkp6SbpDvlZREJPhk2Y4=;
 b=R0eKeApwuDf/Lp+/GlQqo1jBXQY8FxLw7Ko2KHB8reeKxxMDAw8RbCPe+Q5HAW6jQX+08DHAmyGSqT7zwMB7jdD0oubTQGW5m7j8R2CnjrIYc7FQKKXznY9deJC1gnTehT8GiciX3nADvjjnNMbYSOpn0A1nSwviAEqKJywwyY0=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MWHPR1201MB0206.namprd12.prod.outlook.com (2603:10b6:301:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 15:44:29 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 15:44:27 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH v1 0/2] ACPI: bus: Fix platform-level _OSC handling and
 avoid CPPC is not supported
Thread-Topic: [PATCH v1 0/2] ACPI: bus: Fix platform-level _OSC handling and
 avoid CPPC is not supported
Thread-Index: AQHYOTLfRqc3AQ/R4EmdNhsHAdiQyazCHI3Q
Date:   Wed, 16 Mar 2022 15:44:26 +0000
Message-ID: <BL1PR12MB51578B948F4C30907912FD6EE2119@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <4734682.31r3eYUQgx@kreacher>
In-Reply-To: <4734682.31r3eYUQgx@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-16T15:07:13Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=63832360-2f51-40a3-a126-7758d3b91972;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-16T15:44:25Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: d9527d25-273b-451a-b551-51a4da72db04
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b45b85d1-feb7-46f1-d378-08da0763da39
x-ms-traffictypediagnostic: MWHPR1201MB0206:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB0206BDCA88E069A765B4E8A9E2119@MWHPR1201MB0206.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3gKr4Fgo1MbGcmpWZvX71V6Je9T9lHh5EREUxKsrxYs4yGfqTQKYh4lQBuWpeKNHkePS+7/D7YjSVZMc1WE31RmmKasJNkMjJFQkAQNhYsk8UMUA46SCfj3lNI6dfmXvu36Onp10cLJfacYwa/Pg3leJdxxu0NYWefY7sx0B1jS3edMmcJtFroSXlHtyYKeavSnBh+GJgBLcljrXyTilaGRUMUmnr+uGP8dytZ7cruuyIgsSpPTWD6IxNO/Vi+0SSbKg+Pzb9AacOEf9YTb1RQzck2CNM9Qq1UiUQfeXtV81/bOfcwWvfrMWwp22DEQNkaADMSE14qps15rxVV59sQaXaS1gmCwhbkCrTJQjbI7xOYuxbL9w6ZYySG1DohxiQm9TSEh8q1BPi1Tv7DBt8ptZSCOrSgd6h+W84shb9DJRJgDWVxXOm9dcvdMLYcck9s2tf5COIASWQPveUomoUj5/kCqJjmTLJtthxxnbpd1SOcIWEpPo2F2LK3mWmiSIJx0aRoSnzvVN2WS1CbFVDIUmMY9HVVqOvF4R5k048BbXHLeeGs0zTKHTpk0yGOfxwd5kPvsy7i2S0+wPIePeOZvWJcFEIWRNGf5zVcD16SZRevYfYTR+NF7LTOyS5WRTtuqKf/B/aDdDQElMwicVsKGBIa1qKnzlwapjaeNb9T9xpDSZ5KLJP1PjTvQKM2zQoDXAPQUcUDGSwrzzciRKMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(2906002)(33656002)(83380400001)(9686003)(7696005)(6506007)(508600001)(71200400001)(53546011)(8936002)(5660300002)(66946007)(4326008)(86362001)(186003)(52536014)(4744005)(122000001)(8676002)(38100700002)(54906003)(110136005)(55016003)(316002)(76116006)(66446008)(66476007)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVFaZ1o4bDBBWFl2eStNNGh2dWM5bE9kNktReENhOGNQdWMrUk5IZmhvTEVD?=
 =?utf-8?B?ZW02SEMwditYckRnUGxCMmVEbzFvNDBrWnZVMUFma2NialR2TmRpT280MGdz?=
 =?utf-8?B?VzZ1N3BmeDlLRnc0TVQyUFV3MGw5T2VDcklHcyticXpuSU9mcmdwREExM0N6?=
 =?utf-8?B?R25mZWNoOHRQZXQ4U0pUL0hxWG1tNlNBT0Zmd3FjUlJveG1NRC96UmlqSGFQ?=
 =?utf-8?B?RkVzMWZxc0k5dnY2QXM4bWVYaUNRL01CcElyenZob2paSGl4SUluSUNxSEhr?=
 =?utf-8?B?eTRJeGV5NENQVis5bFdJcTVTYm5lbWw1eWgxR29ydzdGRkxOU0xmTWx4dlY5?=
 =?utf-8?B?REZST0x4cjRjdXFNZnlKTzArb1lJSHhZZ0orRmp6RUVBZmE4VmZmdzJybXNs?=
 =?utf-8?B?MEVNZmw3bld4SDJrV1ozK1Vid1d1Rndma0pNckZEMlZNS3BjLzIvTTZvUUpD?=
 =?utf-8?B?eEg3QnRwSkNRZnpXc04wZzJHRkNVcVR6NU9IRFN0UTl2a3NFcW5hb0V5cGF3?=
 =?utf-8?B?aHUxZEs0VGE4OGlSTVZJT0YwU3Zrbnl5VlB0dWxsbSs1NnJYQ2c1KzdPUUpI?=
 =?utf-8?B?ekl4enJSVXZtRzhHeE5NNW92cWJHZHFteWEwQlNJUWxBL0xnS3BybkxnL0NM?=
 =?utf-8?B?VGJOdTNQSVhKeDZINzhJaTVuMEpVMm0rWmU0UjlRVm9iTmxwQ1dNeVczVm0z?=
 =?utf-8?B?ZnpMdlJhdFV4dWhYWHdCRnBoaVFGQS8xdnFEdEVZeGpaRXVib3lzVkJVNjBE?=
 =?utf-8?B?UnoyYmNBMS81VzlHcXBMNlZmVFJxdXpLbHhmbGJETmZSZVY3Tko5Z0FSOG45?=
 =?utf-8?B?Qmt0ZGtmV01rOWl2Z09tWEdER3FwcXl2R0ZqZnFubUxDMEJpZ2xQR1c4Umdy?=
 =?utf-8?B?SXVnRFRYRlBjNlRaei90QzZhWTBnYVFTbHB3SEpjM1d1VHJTZjZSNk5DS2Nl?=
 =?utf-8?B?TkVuL1FEMk9MK1ZTdklJNlNrM21Ua1A4STdGYk5qZGZUbTNFVHNRZGdGaWhM?=
 =?utf-8?B?ZVdGWWlFcGduQVlYUzFmRHVrSXNldTJxckoxS2tZNHI1TmJuREtKUE1zYVIy?=
 =?utf-8?B?eXpQQThiMDJRWXFjUkpEMUF3ZGg2NGREMUtMNlRwQkx4d2YzWk5EK0FPVkJ5?=
 =?utf-8?B?Ti9ZVWIwa0pHd0JFK24wSjlQMmszbFJnQXcrV0E3VWdMZ2VoVUFKbXgzMTZh?=
 =?utf-8?B?UU9MNGVONzBoUWZtRXZEOU9oY0J3SytXbTJjYlZZbnY2N0pJRHJVeTNadS9y?=
 =?utf-8?B?QkorM0ZUV1pOUjgvUnNaRlpLTmRYeTZCNEZpMVRRZEtKNDU1Y1dLRFNGTEsr?=
 =?utf-8?B?U0xISGE3WWx0UjdFZE9MTlJ6NjVxTU02S200N1JnbDd4eEhXL0pQTm5XajdV?=
 =?utf-8?B?QmxrTERtNDM4OHRwMFNxOGYzQ0dJSmtWbU9xcWRlUW1xbHg4bnNOQ1VjajZJ?=
 =?utf-8?B?TXJIb1lLT2FHempRd1Q4QWdtbFJCcVRWNDZ5OXRnWWZqQTVkNzRiVWkwQ0tK?=
 =?utf-8?B?NUZtWWMxVHFFSFJITUFaMFpEdm8yVWE2TlNlNmlZaUgvUmxKVTQyNmU3WEtO?=
 =?utf-8?B?eG90c3pORnU3d2FGblBUSEZ6ekdYK1JaUFpsTWZXT3RYd2xtMGswMzNYRXQ2?=
 =?utf-8?B?eXFUSzI4L3ExQWFhSlRQYmwyTXNBam8wMVFEK2VsNkJCcFlhbUdDU3M0MVdY?=
 =?utf-8?B?YWUzdDZrNy9TVjF3MURxcE9SdElYKzdMYmtaTGFZeHZYNDVmcjhPRERtSmxy?=
 =?utf-8?B?R2xpT3N1SmxyTlRVcEFvR0NjczMrVVRJMUNWOGQ4QnQ4MDExT2xWNGhpeUM2?=
 =?utf-8?B?SXA3dVo3OG9ZNXVmeHJCOGkyR3o5VUhFL3lmTkYwWDhtQTczaW5jRzNMNXpO?=
 =?utf-8?B?YmhRT1RwOWUzOGh4V1NxNGhiKzg5UnZvN2I0K0tUcmVXQ2JiQ3dKZkJMM0Z3?=
 =?utf-8?B?eWxyYTM1Q1IzdHFCOGpRRmlKTXZGOUlQQUV6aWp4N0NTT21XU0ZSbzl2K0ox?=
 =?utf-8?B?aGtVcGd0U2V3L0t6ZUpSbE4vM2FmYmI1MTBkN3A1eVZ1Y2Yvc1ZxdU1qOEpN?=
 =?utf-8?Q?KF1ZUW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45b85d1-feb7-46f1-d378-08da0763da39
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 15:44:26.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V7n7j+k5jOcmcWt2QKcS/Q0MzEckXauPc1EdLeezWRga8ismDEUwjQoqpyK8bD/nDk6umcKdBBnlfrmp2PuDVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0206
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwg
Si4gV3lzb2NraSA8cmp3QHJqd3lzb2NraS5uZXQ+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2gg
MTYsIDIwMjIgMDc6MzUNCj4gVG86IExpbnV4IEFDUEkgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwu
b3JnPg0KPiBDYzogTGludXggUE0gPGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz47IExLTUwgPGxp
bnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgTWlrYSBXZXN0ZXJiZXJnDQo+IDxtaWth
Lndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tPjsgSGFucyBkZSBHb2VkZQ0KPiA8aGRlZ29lZGVA
cmVkaGF0LmNvbT47IExpbW9uY2llbGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1k
LmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYxIDAvMl0gQUNQSTogYnVzOiBGaXggcGxhdGZvcm0t
bGV2ZWwgX09TQyBoYW5kbGluZyBhbmQNCj4gYXZvaWQgQ1BQQyBpcyBub3Qgc3VwcG9ydGVkDQo+
IA0KPiBIaSBBbGwsDQo+IA0KPiBUaGUgZm9sbG93aW5nIHR3byBwYXRjaGVzIHJldmVydCBhIGNv
bW1pdCB0aGF0IGNhdXNlZCB0aGUgaGFuZGxpbmcgb2YNCj4gcGxhdGZvcm0tbGV2ZWwgX09TQyB0
byBmYWlsIGluIHNvbWUgbGVnaXRpbWF0ZSBjYXNlcyBhbmQgYWRkcmVzcyB0aGUNCj4gQ1BQQyBo
YW5kbGluZyBicmVha2FnZSB0aGF0IHdhcyB0aGUgbW90aXZhdGlvbiBmb3IgdGhlIHJldmVydGVk
IGNvbW1pdC4NCj4gDQo+IFBsZWFzZSByZWZlciB0byB0aGUgcGF0Y2ggY2hhbmdlbG9ncyBmb3Ig
ZGV0YWlscy4NCj4gDQo+IFRoYW5rcyENCj4gDQo+IA0KDQpUaGFua3MhICBGb3IgYm90aCBwYXRj
aGVzOg0KVGVzdGVkLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1k
LmNvbT4=
