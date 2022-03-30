Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F454EC61C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346527AbiC3ODP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346551AbiC3OCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:02:48 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BD51168EB;
        Wed, 30 Mar 2022 07:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjugiOUNZNCPRe3Pgjgp9T71DZKoP2l6ekaYjmt38RRehgUpsNQ+h+gpJAwUO9YCJK15wGuOOp6/TkVFE7+g2pTpqM52Sc8sbrhJfzxLTGqjc8LRcyC1MDn5de/5/my7Dy6zQW1Ox3+PZcJGTyLcIwk2rfEpuVB2euJG+k/qVURXxakJKrTyR8e7cut3lDhFRAO2NPByuWN8v6l1HEH4ibR0AjLazi//IGWn/sBFnW2gqrB57CUyl8TVO4YLZvOag1995fonoTghVKR6/+9AsKwA+mKKnkwPuRT6IpBf9rO07fAXHVAwByclud/ZJT54pOYYZDrpv5CWGnndC420QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pb/jmlrY7sr6Tb9ZcbJvD6hALEgabCQCan9f4Lk6HE=;
 b=lCB+RWjZFZ4r78mD7Z9uXsncIj4hppwBX6Rd6s9S2xs6gdcikEPuHydsNe3Ci1dOz0E52QDLdMZNfLXXnJ7TV0Czb3hMh5iMgYiqQNzHFbVf9LWwoxX9a/355wVvYKxtyLvjMGddzJ9JuNkp5eRDK4mxs06GN/LZNAgxIPdIi4b8n7EeEnt1dqV3FJ7FCm/emykl8jE7e/CWDjLejxZLUuARmQJB540afVqikQApiRmkAoh3jv1odzAEEAqZrYMgAr/bP8+0KNO45Q7vQqkfBt9wCOdo8hKnGq8ltWTTKYyO60eckR6Lb0DbZ2zY+JXgxppxlEmWTLIP+blSQTsYjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pb/jmlrY7sr6Tb9ZcbJvD6hALEgabCQCan9f4Lk6HE=;
 b=i0gtK6t5nmvZPkNUGuKu57ihM12j8LpC5CGm43LeMPgSCMf0D3kZkmsD1kpD/3djR/iw/sjKCJZtoSavkDvJMqszQHJSDyH8jrKCrNFs7/DzPzUZhy9RuQ+zWrnGO7x1gBn/XuNk8wBs9ZKtDKarUBBcTDXbQhYMSribREm6ZCg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SN6PR12MB2736.namprd12.prod.outlook.com (2603:10b6:805:75::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 14:01:00 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::4566:560c:e193:d210]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::4566:560c:e193:d210%6]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 14:01:00 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Hegde, Vasant" <Vasant.Hegde@amd.com>
Subject: RE: [PATCH V3 1/2] Documentation: x86: Add documentation for AMD
 IOMMU
Thread-Topic: [PATCH V3 1/2] Documentation: x86: Add documentation for AMD
 IOMMU
Thread-Index: AQHYQslLqpWUeg5qeEmTRh77YLEneKzWfJmAgAF6XmA=
Date:   Wed, 30 Mar 2022 14:01:00 +0000
Message-ID: <BL1PR12MB5144C7172FCB8ED2C1AB013AF71F9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220328172829.718235-1-alexander.deucher@amd.com>
 <20220328172829.718235-2-alexander.deucher@amd.com>
 <b3998af9-24bc-6191-a8ed-de747e895799@intel.com>
In-Reply-To: <b3998af9-24bc-6191-a8ed-de747e895799@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-30T13:58:54Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=827e65ef-7505-4c1b-8d76-7aeedc3eb3b4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-30T14:00:58Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: da794e31-0788-4ca0-bc57-cd53cce220fd
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abe5420f-8898-4e92-1dbd-08da1255b882
x-ms-traffictypediagnostic: SN6PR12MB2736:EE_
x-microsoft-antispam-prvs: <SN6PR12MB2736F3974ECCBD319C2E7EE9F71F9@SN6PR12MB2736.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9MB+EzelkOMwT9p0wFkWNd24cMPkcbaqOMwUQBeMG+xlLFLXvOdRknSuhurz+z/F9xogoJ2mg31O5vlWqlLHo+sj0HEPhdb3JAok9RX1CI2j31cALqBhHMh2jIhycK2kWfd4qjx+8dJ9Bfx715POXur7bvQtWWi+iBZEKl7sCC+BKP9GugQ0kAHXh6d1i/rCF7odIUSNmh3rQo1L9ZQbGw1xsxKztReOA5MV2sgMP/AcEAxuMucJJuhG99PlXjOK2HKGTGjI0v1jXm/xyVIyZSxDOySgBM+lb8HQXHEK+ve4kgu9xq9/lLA9Ub9XWB/NB2R1B1LJkT+DhPuZ7TYJcpPCRve3xkCt89VgfJhcFgupzt5n3EiUCWsOCPXNcaPAdyeIxpizmK7EIHRN/F3ojgdzuvtVil9SsWxOjIWpWs0Q+AHfDMvEtAZmWpRAjujsTd/jNXzl0gh7Y23PqvZBTiAPkgv33QnSu3sdRnJXJ79gSihZE+5JqOlF/fpi/BxXgX2uah96Wz07PD+TG8jr2e/nImPT83VSTYSv4RAWEJnQ0Qv1C2iwGdAiDS1nb506av+tg+qw7E/INBakrfSS9v+EWG6PXIFH6sgyJ6VxTDWSzlL+voDLK8DLRcQJySKiRqVsAL6EEqMg8jrott9ZWIqspxXgMjubWkp6c9vLpdh0MtYQCPd7RB8DPb4KelNPKDpdsJbFDdYT9roC+tYRQN9xz7qoW3yygvm3MzpuubI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(71200400001)(6506007)(7416002)(66946007)(5660300002)(2906002)(76116006)(7696005)(9686003)(53546011)(38070700005)(83380400001)(66446008)(921005)(66476007)(122000001)(66556008)(110136005)(508600001)(8676002)(86362001)(52536014)(64756008)(33656002)(316002)(6636002)(55016003)(186003)(26005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3k1NmlkdDEwRUh3WTRnY3BoUnliMTg5cWlHM2NONGxTemhBLzlWVEZKTnVQ?=
 =?utf-8?B?UHh2endheGtuZmh1VlB3OUgvUDY3bW1RaU1qTXlRSDV3b1k0dDVpaVFvYXBl?=
 =?utf-8?B?VDRxZGpqcTQ2dW1BQWRtM21uMk5hbFIrZTU1SzdCWUthWm5QNDg5L1VweFNY?=
 =?utf-8?B?WWs4QTlPSEdSa1Jwa2ZNNWVrUjJuZnFYdHEzV0d0MGtnSHo1SFM0anF3M2Yy?=
 =?utf-8?B?U1JJZktpeXpyZDcxaWY0Vmswek1CUnBZS1k0dDg4c0Z1YWhQOU9NZzlBaGtG?=
 =?utf-8?B?YXRDdWNVMUJsVlhQb2NvekE0Q21NWnJpOUdkUWU2bTRyTld6WG9HTlJIb3Rm?=
 =?utf-8?B?UlZtNzUxNk9KclN3am1JdE1vUVpjQ2NEN2VjcThlcmtWZ042ZFpXdEcwYkV0?=
 =?utf-8?B?aEpnQ1Qyekd6amE4VGxyUW9Pb3VUOUU4VEo0WlYvUkVncXpXaFdmSDFjdVJK?=
 =?utf-8?B?SzZJdlVmLzFIOGd5dU5XUEdJeUZxcFlRcUdqZXpXY0V5T1gxTVQ1YkhBUXJ6?=
 =?utf-8?B?ZUNzMUZYM0NqazBmdDZVaUtabXl3ZjMwajRIVElSQm9QQWN1Mmt4bzBoandN?=
 =?utf-8?B?QzhVTmdsZmhaUlZIOXJwVmNQamlZMUp5YkN4Q0RGVlo5bmhLQXo2b1g5Y0FT?=
 =?utf-8?B?VnloazVsNXZVdytIbHFpQW9uMWdUTE1SOCs5R3F0OXFCekdrSjFxTkZHd0w4?=
 =?utf-8?B?UWM0SHc3YTI1V3Zqakd4WWV2YzU3NWhOZFJqQTNUUW1EcDZkYVczR3NyQi9W?=
 =?utf-8?B?OFJFZDZhZUQyMTFMc0JVbUpWb2FubUpEakJpTEVIRU5RYkVqdmdUQS9RcWJF?=
 =?utf-8?B?TXBUbWttam9QMTJjcENWZjJabTFiQXhwRTlXc1F4MmhnRHhmK0w5MlRnc0lP?=
 =?utf-8?B?ZlB1aDRQN3VGeXdKN24yNmFGOHJzL01NTy9jZ2xmRnBQUDNXbGdaSVBTTGZS?=
 =?utf-8?B?dVE3bTMvWFA4QkdBZms3cWcrZnF1M204N2FPbysyVWdXUjNVV0ZUYUV1Qnln?=
 =?utf-8?B?VTR6RFRUQ0RYRjJOam9Ga1FuVzIwTW9ZNGZ1Z05jME5sNzlTajJ0c2hHWlZV?=
 =?utf-8?B?bENXRlNVL2RDNkVaV3dZaDZRWHRNRnR3YXcwanc3M3NYeGlIMjR5amV1VGVP?=
 =?utf-8?B?a2VrZTN1SkhuRzJoeVFyVE9oaEdTTU9RY2JOVTg0N0JTNytaSDZxTDQxQVNP?=
 =?utf-8?B?c3NPUUg2cHM2VTRsblh6S2M2dmt1WmU2WTZScnlEUE9DQTJrUCsrdUxsQ1RY?=
 =?utf-8?B?OXNHME1WM0pWdzM5U3o2dFNiNTRTQ3lyTDlqaEw2L1FhU0VpcHJBa0lKOXdx?=
 =?utf-8?B?ZW0vQVU0ZkN1WFBXRzNoV2dYTFV0aDRLbGlQZGhJbWlrcDVrczlLbDhxY0Jp?=
 =?utf-8?B?TUFWQlZPSXRqaHAzTmxhWEtZZkloSks5V3E1aXpMVks4M3ZiQWY0WHZCVk55?=
 =?utf-8?B?VHN4RnV1K0p6NE1XN0h5YjcvQ2J6QTByczA1YzhXSTBkTElkdEdqZ2I2b1cw?=
 =?utf-8?B?UFdlWDQvUzBkK0g2SUpoa0w0cFdtRzJHdDFJdEFGT2JOMVdzbUJSOXBXWE14?=
 =?utf-8?B?VnFIN1hCUEUwZHV1Ykt1ZEZZNDRlYVIvWWZzSDZaMCt3MlBySUtuMkpGNVlN?=
 =?utf-8?B?K1k5ZmlkeWFOcm81bDVJdC9xS0JnVTdEckZ6ZFdxd2J5dEtYajA3TEdBTnVl?=
 =?utf-8?B?eGJ5V1MxL0tUQUMzR0F1T3lVOWlveHZPZ0VvNXprdzhTMFBVOUs5U09SQ0dl?=
 =?utf-8?B?amVnMkM2T21tWW5hY2E2a2JIZHh1bk9sZWFJc1RneG0rVE1uVVhaZ094Qmsw?=
 =?utf-8?B?TGducXN5eiswcFl6SFcrT1lmMmZ4aklPeDdvVlZhZnFXaGZVazY5WHNnVkxx?=
 =?utf-8?B?Y0N6Z1hDZ1FUSW43WkpLTVpySHVlQUxBMU11eTdSckFsSy84Y000YzhVZXBB?=
 =?utf-8?B?clorcVAxVGNMa1dNcW11dTNlWUVmMjg1NEZKZWx4ZWZZR05kTWtkYVUrV3ZH?=
 =?utf-8?B?ZXFCOXNPeU1jVmt2anNtM2MrTVBVemxDdTNZRW01blNjU1ExN0Q1QXcwSnJG?=
 =?utf-8?B?dWNlWWJpVzllRnBvVHljUndMaHArUWxaV0J5c0FjcEM5M2JLYTFUcUR4alpE?=
 =?utf-8?B?T1hYalgwdDFNWXZqZEZrSmNuR0tvd2labk9LektPKy8xeisvbE1MTXZzWXRy?=
 =?utf-8?B?RTFwRlQ3dG5FenYwd0dEN0dxekl3YXFpRExwcThSMFdnbmtOVE9STzd1VERB?=
 =?utf-8?B?azFrNGZIcFNRTVhXbFFVbGk5MzBBcXRBWGFpbW5oS1ZCY2lnOXlMbUlLME5W?=
 =?utf-8?B?eHlnNTJ5K2tqUXJ0Vld6R3FwT2UzUHJWZklOODVSVE1nN0ZVa0JFQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe5420f-8898-4e92-1dbd-08da1255b882
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 14:01:00.2151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qqx3/LPPzN+aLAbZCSz2CL9MoFz3OR7oVvG2u8jXLI/qqLCqmSjO5mAPqBRckNE9+M7OCxTSBxbODtB9mhzmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZlIEhh
bnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAyOSwg
MjAyMiAxMToyNSBBTQ0KPiBUbzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPjsgbGludXgtDQo+IGRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGNvcmJldEBsd24ubmV0Ow0KPiBocGFAenl0b3IuY29tOyB4ODZAa2Vy
bmVsLm9yZzsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOw0KPiBicEBhbGllbjguZGU7IG1p
bmdvQHJlZGhhdC5jb207IHRnbHhAbGludXRyb25peC5kZTsgam9yb0A4Ynl0ZXMub3JnOw0KPiBT
dXRoaWt1bHBhbml0LCBTdXJhdmVlIDxTdXJhdmVlLlN1dGhpa3VscGFuaXRAYW1kLmNvbT47IHdp
bGxAa2VybmVsLm9yZzsNCj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IHJvYmlu
Lm11cnBoeUBhcm0uY29tOyBIZWdkZSwgVmFzYW50DQo+IDxWYXNhbnQuSGVnZGVAYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMyAxLzJdIERvY3VtZW50YXRpb246IHg4NjogQWRkIGRv
Y3VtZW50YXRpb24gZm9yDQo+IEFNRCBJT01NVQ0KPiANCj4gT24gMy8yOC8yMiAxMDoyOCwgQWxl
eCBEZXVjaGVyIHdyb3RlOg0KPiA+ICtIb3cgaXMgSU9WQSBnZW5lcmF0ZWQ/DQo+ID4gKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPiArDQo+ID4gK1dlbGwgYmVoYXZlZCBkcml2ZXJzIGNhbGwg
ZG1hX21hcF8qKCkgY2FsbHMgYmVmb3JlIHNlbmRpbmcgY29tbWFuZCB0bw0KPiA+ICtkZXZpY2Ug
dGhhdCBuZWVkcyB0byBwZXJmb3JtIERNQS4gT25jZSBETUEgaXMgY29tcGxldGVkIGFuZCBtYXBw
aW5nDQo+ID4gK2lzIG5vIGxvbmdlciByZXF1aXJlZCwgZHJpdmVyIHBlcmZvcm1zIGRtYV91bm1h
cF8qKCkgY2FsbHMgdG8gdW5tYXAgdGhlDQo+IHJlZ2lvbi4NCj4gPiArDQo+ID4gK0ZhdWx0IHJl
cG9ydGluZw0KPiA+ICstLS0tLS0tLS0tLS0tLS0NCj4gPiArDQo+ID4gK1doZW4gZXJyb3JzIGFy
ZSByZXBvcnRlZCwgdGhlIElPTU1VIHNpZ25hbHMgdmlhIGFuIGludGVycnVwdC4gVGhlDQo+ID4g
K2ZhdWx0IHJlYXNvbiBhbmQgZGV2aWNlIHRoYXQgY2F1c2VkIGl0IGlzIHByaW50ZWQgb24gdGhl
IGNvbnNvbGUuDQo+IA0KPiBKdXN0IHNjYW5uaW5nIHRoaXMsIGl0IGxvb2tzICphd2Z1bGx5KiBn
ZW5lcmljLiAgSXMgYW55dGhpbmcgaW4gaGVyZSBBTUQtDQo+IHNwZWNpZmljPyAgU2hvdWxkIHRo
aXMgYmUgaW4gYW4gQU1ELXNwZWNpZmljIGZpbGU/DQoNClRoZXJlIGlzIHNvbWUgaW5mb3JtYXRp
b24gYWJvdXQgdGhlIEFDUEkgdGFibGVzIHVzZWQgdG8gZW51bWVyYXRlIHRoZSBJT01NVXMgYW5k
IGEgbGluayB0byB0aGUgQU1EIElPTU1VIHByb2dyYW1taW5nIGRvY3VtZW50YXRpb24uICBXb3Vs
ZCB5b3UgcHJlZmVyIEkganVzdCBjcmVhdGUgYSBjb21iaW5lZCB4ODYgSU9NTVUgZG9jdW1lbnQ/
DQoNCkFsZXgNCg==
