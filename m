Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7F5520756
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiEIWLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiEIWLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:11:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAF024310D;
        Mon,  9 May 2022 15:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF1d6FSKv5UNRYDfVJDU/F9sp+zsHRFkLfGpukMrdUjLk5exAWOf4yqXSDKpWbByCaZac/NW/oAtK3GCnGR9Fu0m8/BW57+mfc/8s21QbaHzayI5YUz5qSBszuNZiepG9Dc6kfIY0O7SBj41dbxo09knTkocSZnyS0CsGNh7kxULHlHxrk3P1NJ+oyerdSJNcuMj0Ua8uEJDr6UeUdRiiMT5oHGaRg7sTJGTfnqxrXP1duHmhCxu+WxJfOqduOpSevKTDODVduioRlk0D4NKuYcTTEcxWR6UFEK3J/urOSK1Ja/MDdTVNxfYkq+uZv07icpRN0Trrppnfo9q816R/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgtX/8P7dsUQ8vC2uTYi6Biavj3LKX+8kwuYiNazBBg=;
 b=RtxXc5UsWXOXBS5K9YojFA8kQPiNP0roG1LLy+XbaE9aLgmrlxuNAqmWnu5MDOHY1Yp3uxoXgUYgZtXgCeXFlNNpdmjx6OleT/35cEDhc4HpLa32sl+VQ6vCLQiu/wX8xGTTWNTtf5Mf3MLlfnkAiAZuf5lGfdYyfKgVgixvVskfAsiqyXRxQumJZUVxfdXanktjM+lKe1XrDMe3FJd6BQIQ0rfkoMf1F8+uEFybu/yEASss/pbcJs29nMQ2Dwc4uqt17nb/ID9BMjOTojFJkwVaH2q54KBvjU/j9UiYCODwWymNesNGKHiBlHGfQHjqEsLxFZChZaROA6manOWi9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgtX/8P7dsUQ8vC2uTYi6Biavj3LKX+8kwuYiNazBBg=;
 b=bOfJtMra7ZzVInN2y1B/DryPAo+P3PiratGCT2hIK50RGHHT4Z3VS+0Uhrpoi/5O68UqekwKQp512OsN6xxEwAmcaGJ10YfDexbNxW0mZWDcss7a6N39FKqCEqJ+r/PzYuhRre55VF9zwtwkauh4ofAPZubbUBt5FVTp1gtGDxVBx0ZsizTKxKzMWYNcj2mn0ceiFjvJmDs4men93oM5ZdSA+PFx1TaoC3B2miJP7csa9M2I2+PGIqhjAzOjhB+9tslX2gDeZnR2Nj7M5TbH7X+3Rw5dhqMnYxPbIiyZ+xfNV3mSIWRuk5ThVcjzgoGGe7rFtCmKfQHTCU5eWUdzJA==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by BN7PR12MB2787.namprd12.prod.outlook.com (2603:10b6:408:2b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 22:07:37 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::7526:b8f5:b10:1c4c]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::7526:b8f5:b10:1c4c%7]) with mapi id 15.20.5227.021; Mon, 9 May 2022
 22:07:36 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Michael Williams (ATG)" <Michael.Williams@arm.com>
Subject: RE: [PATCH 0/2] perf: ARM CoreSight PMU support
Thread-Topic: [PATCH 0/2] perf: ARM CoreSight PMU support
Thread-Index: AQHYYzu4AtKVUSpJ7k+AnLFkxMXOCq0WR+MAgAAJZ4CAAMQDMA==
Date:   Mon, 9 May 2022 22:07:36 +0000
Message-ID: <SJ0PR12MB5676B1231F10477AFC96D7BEA0C69@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
 <20220509092843.GB26264@willie-the-truck>
 <2e5e09f9-b71b-d936-e291-db8f94554b18@arm.com>
In-Reply-To: <2e5e09f9-b71b-d936-e291-db8f94554b18@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 617d6e5b-c241-446f-f298-08da32085379
x-ms-traffictypediagnostic: BN7PR12MB2787:EE_
x-microsoft-antispam-prvs: <BN7PR12MB278730FE9AD617A44502F3D8A0C69@BN7PR12MB2787.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 64yN9uFX1szQC4riDNaqgx+h/mjhKpLWE2DjBcOM2bFDtTz6lWWaDRRdJbqJLq5Q/jNNzchW9rEy/BY2UuLqp4c8gzN7NSqxi5XLIBoVHkPe8Gm5iS8QIojB+rKHrxeBeRu6pAgghZQGFXY7W5ykX8RB58HL5CkjOqLWqASLXEbojqiVqyccEHo6ANnk1SEhwGWJnv/BEup8NP6AA51pOiLq1APWAXHZxR4Hw/R4pL+t1KFV/weRt2CBJ+QMvKLl3FEcJoBYuJDbo++AEVRn7rPGrWIAT/VQQvvt0fWyxOuc+TtXrrwelLb11E6jOULW+EwBt0G/2GPs38n0AWoe5vvlbAATa4M0vC1FbqheBSPvEjLBzPt3k7kQvbsyHmegcbcXUaeLAdqXNU1RkH9AlIJZQFyuoxQ9Kyr82ukGgoHkFc10sf7IJ+Oz7HYfBUzW+zNHBu8PcpQQ4bcB7xZ/xSI3rQY941ePjdYBaRZK1ClBRevqBJ/tB4Bn7XAwWKsLu/V8NBnirj9qXbdabApSKvsXThJnVx0JiiIrYx6qy2JG5Jdb+vvU7ShgFvKzBBDne/WLD4n28Gh1L+pwdj/TndzSVa/UWnkd991rICS95PVoaJFlTkX9HU05xcIO/mRktgQk1Dpm1XSq36x/6iO0acxErb1CLlls1cmyJQKYtgwZmo+1OmihtCOfySqk+KL9W/6nUS4fODksS13OsqHxFy7Q8jeulkdQGgrYDxAp8eY3RbqatNtiM0dGWoZTu12xirfWnNols6tBSLkPG8+j6R2gKh1rOw9OyCycTmBBj/5MpREw90vI/gGDKKZle3N2rgaIX4KyjAr7KOZBBDALpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(71200400001)(38100700002)(38070700005)(122000001)(7416002)(966005)(86362001)(5660300002)(53546011)(110136005)(7696005)(316002)(6506007)(66556008)(66946007)(54906003)(76116006)(66446008)(66476007)(64756008)(4326008)(52536014)(8676002)(9686003)(33656002)(186003)(83380400001)(55016003)(2906002)(26005)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVFXU3l5ZHhnUDZleFBtdW9uOVV2SlJTdU9MeFdkdjZGT0dhWWFWSEwvd3My?=
 =?utf-8?B?c3oyMXVpblVFekVzWmd0Z0xVWlRYTTBqenlpRS9oRVNIUEdVbUhUc3VBN2pS?=
 =?utf-8?B?TzVuak1FM1ZCN2t2STJNQkZwbXlOOHZwUW5uQS9iUVg3dGE4UnB3VEtBdTVm?=
 =?utf-8?B?QWpSeEJVMFFWb1FyU29IK2Fab3ZxMHIxaThlNHFzRmRxbFRUOTZOTUZzQi9x?=
 =?utf-8?B?WkdxUXZUUGdBRm5Ld1NXTkFyajkxMWxrWGhjRE5nWUozQ0JtYjVBSk9UU09w?=
 =?utf-8?B?NlNadVJZa2hvOEFjclNGcEI0dVNCTjVkRDNzZzRtTFJWTm00RXJudkZlajZ3?=
 =?utf-8?B?RUxOREYzZDFlcXR5N29veHFRelpHbmVuZm1LaXZqNExqZmd5bGtGTU5BclZp?=
 =?utf-8?B?NXlCY3FIMFhGNVU1SjBoR296MzMwbFlGYzAwM2ZZZ3dSMWl4alZtVHgzRmR2?=
 =?utf-8?B?YVVLUUkrNkVEZVMxeFhMWmpTWjRHL2pwMnpTelBnbWVkemtBcU9mYk5SV3Iw?=
 =?utf-8?B?ZlRXcGdkamxUVlpucDNDOW5xTmlJSll0UldhOGo3N2NzQnVQWGllQTAwRG82?=
 =?utf-8?B?UEhFKzM2aGRIUHJjTHA2YVk4My9KQzVncmkwUDh6OE1nWkQ5bGw2L1VmZFhx?=
 =?utf-8?B?a2w5KzlGcGlRTlRFZkZqYmltSzFWWUpQWTB5K1FGVmNnR0p3UnlaekVoSVZv?=
 =?utf-8?B?c29FOUhocFQzNEZ0c2R0dTFkS2o5SS95MzRCUzFJc2pobEk4RklBY0FYdzRq?=
 =?utf-8?B?c2VIKys1NnFpdktkbCtJMVQva2VPeW1iRDB0U0NhWGs4MXdwcVo5VXArb01F?=
 =?utf-8?B?OW9PQ0NVb1FXaHVldlhCN0tyajJ5alBRUGU0eDAwMTBLNWVIYVpjYTFlMTJW?=
 =?utf-8?B?WnNEczFLOFp4TGZNRHdXcm5KUjUxOWJpS1B4UXdtblNSVkVMWm5NUzh1TUZX?=
 =?utf-8?B?dG45emJFcTMzQVJjcld0VC92VjdzdUtpeW9XMlhTVnd6SVpaaXZ6WFFsaXhT?=
 =?utf-8?B?U0kvUjV1UEhueStjOGZsYlUvcis3MnZTR2ZmTVFtNHlaODU4VFJMS2drY1pE?=
 =?utf-8?B?UkM1SFVydGNvdCtKN29CYTBkWHcvbEFScVVFT3VTamVOMkZQU1FQUldQU05T?=
 =?utf-8?B?UkVqWENwZ1VmaGpsUUJtRFdFcjl2dkNoZDJrSC9CMExsRkN5VkVMaWRzeVRV?=
 =?utf-8?B?SDZZaXVMTG9nRkNVUlQwVmpMYmRSRHBwNlF5M2hHdldHMmhzaWp2UXlOTUov?=
 =?utf-8?B?NFdhQlhxTXo3SWdzd1BUd1NyVXpwZEpGa1J3RzhzUGgwZjlGVHBCRUNab1lk?=
 =?utf-8?B?VGNNY01CVHlJRXptL1FXK2ZPZEpEWHkyWEp0WnBYZ2tiU2FVMGZ1ZnQ3d0FE?=
 =?utf-8?B?djk3Y1lCeXBZenhhVkFZK3oyRmpOWkd3Y1BtZXVibU5hNVk5d0dOMVhCajBx?=
 =?utf-8?B?RlBIZ2NnbTdJd0o0TW5ld0ptR1grNTZiZlVEa3BBVjhLOFVPamttT0xnVUh5?=
 =?utf-8?B?cXIvY2FOMk9aS3Byck1Qemp4Q1V0Lzc2SU0ramRCUkF1OGVDNEdnd1FtNDNN?=
 =?utf-8?B?MEZ4cE0xalcrU0ZsbHJJdmJkaFNPMDhVT0NidkVtdVhVb3hzWTVHKzVteFZX?=
 =?utf-8?B?bmt4TWdOOWs5Rnl4eTloN2IwQnZxcGNRc1dKR25YdnM4TzBMZGFmeXRnQ0pm?=
 =?utf-8?B?UGFwYkFOZnRFWHlBOE44SFdQSEErWFNaZDVHNHZJNWFqeDdER3BMYmdDRHB6?=
 =?utf-8?B?ZmxkU1N6c2VPdjVXbWhhUGR0Nkgzb0lvRGRETWJhZ0t5OEt2ZU5pb1hNS1JJ?=
 =?utf-8?B?SUFNSXNBYmVYcHpqVGZpR2VMM2F1TmVLTmhMd3dXZUJwcFFPTnRKNzU2QWVB?=
 =?utf-8?B?a1FmRWpnRnlpanZNd3hFNE0ybCtxSmpmQ2VNQ29hdGM3WkVjTUNINlZBTTJn?=
 =?utf-8?B?U25OaXVwK0o2WnRQQ2FRMTdvc0MwTVZQZW1hSUV3bXo4U0Ntd3pHSlI5V2I2?=
 =?utf-8?B?ZWFWdWk4dzJqcWZieEIxalU0Z0p1OE53aytjUHVmZGZqeE1kaVRUN01zS1U0?=
 =?utf-8?B?OUpWcXhaSzE4MVVReEJXWGJpTWtjRis4MnZSYXZaYzJmTlBGenNrVXBnVnR5?=
 =?utf-8?B?aE85ZmhrR1VSbDVtVG92SkFueTlvVEFVY0V3MEdZLzZBV0tnZG9ya3VibTBQ?=
 =?utf-8?B?WXNKUmxZTGZQUGtVakpiMWt2M2x0WCtvSkF1SFlFc3lFNzc2bmxCUi8xQitO?=
 =?utf-8?B?bW9CZW1hVFlWMHhaWGhjellQZFg5cnJxUTJ2Q1hSVWNncTI5VFpaMWQ0WFlt?=
 =?utf-8?B?L0c5Q3k0b3kxM2VPY3dZRksyN2FGQ05Sa0dZZm0zRUxuYS9mUXpiUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617d6e5b-c241-446f-f298-08da32085379
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 22:07:36.7349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74I1SDH3as8oV7JTH0nyvK+tEvk6yERAuvbjQ6MKb7ab+aYf2z/e7o0E5wroi1iu9pIdf4jO8+flfdCmLqMJtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2787
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3V6dWtpIEsgUG91bG9z
ZSA8c3V6dWtpLnBvdWxvc2VAYXJtLmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXkgOSwgMjAyMiA1
OjAyIEFNDQo+IFRvOiBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgQmVzYXIgV2ljYWtz
b25vDQo+IDxid2ljYWtzb25vQG52aWRpYS5jb20+DQo+IENjOiBjYXRhbGluLm1hcmluYXNAYXJt
LmNvbTsgbWFyay5ydXRsYW5kQGFybS5jb207IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiB0ZWdy
YUB2Z2VyLmtlcm5lbC5vcmc7IHN1ZGVlcC5ob2xsYUBhcm0uY29tOw0KPiB0aGFudS5yYW5nYXJh
amFuQGFybS5jb207IE1pY2hhZWwuV2lsbGlhbXNAYXJtLmNvbTsgVGhpZXJyeSBSZWRpbmcNCj4g
PHRyZWRpbmdAbnZpZGlhLmNvbT47IEpvbmF0aGFuIEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5j
b20+OyBWaWtyYW0NCj4gU2V0aGkgPHZzZXRoaUBudmlkaWEuY29tPjsgTWF0aGlldSBQb2lyaWVy
IDxtYXRoaWV1LnBvaXJpZXJAbGluYXJvLm9yZz47DQo+IE1pY2hhZWwgV2lsbGlhbXMgKEFURykg
PE1pY2hhZWwuV2lsbGlhbXNAYXJtLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzJdIHBl
cmY6IEFSTSBDb3JlU2lnaHQgUE1VIHN1cHBvcnQNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2Ug
Y2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gQ2M6IE1pa2Ug
V2lsbGlhbXMsIE1hdGhpZXUgUG9pcmllcg0KPiANCj4gT24gMDkvMDUvMjAyMiAxMDoyOCwgV2ls
bCBEZWFjb24gd3JvdGU6DQo+ID4gT24gU3VuLCBNYXkgMDgsIDIwMjIgYXQgMDc6Mjg6MDhQTSAt
MDUwMCwgQmVzYXIgV2ljYWtzb25vIHdyb3RlOg0KPiA+PiBBZGQgZHJpdmVyIHN1cHBvcnQgZm9y
IEFSTSBDb3JlU2lnaHQgUE1VIGRldmljZSBhbmQgZXZlbnQgYXR0cmlidXRlcw0KPiBmb3IgTlZJ
RElBDQo+ID4+IGltcGxlbWVudGF0aW9uLiBUaGUgY29kZSBpcyBiYXNlZCBvbiBBUk0gQ29yZXNp
Z2h0IFBNVSBhcmNoaXRlY3R1cmUNCj4gYW5kIEFDUEkgQVJNDQo+ID4+IFBlcmZvcm1hbmNlIE1v
bml0b3JpbmcgVW5pdCB0YWJsZSAoQVBNVCkgc3BlY2lmaWNhdGlvbiBiZWxvdzoNCj4gPj4gICAq
IEFSTSBDb3Jlc2lnaHQgUE1VOg0KPiA+PiAgICAgICAgICBodHRwczovL2RldmVsb3Blci5hcm0u
Y29tL2RvY3VtZW50YXRpb24vaWhpMDA5MS9sYXRlc3QNCj4gPj4gICAqIEFQTVQ6IGh0dHBzOi8v
ZGV2ZWxvcGVyLmFybS5jb20vZG9jdW1lbnRhdGlvbi9kZW4wMTE3L2xhdGVzdA0KPiA+Pg0KPiA+
PiBOb3RlczoNCj4gPj4gICAqIFRoZXJlIGlzIGEgY29uY2VybiBvbiB0aGUgbmFtaW5nIG9mIHRo
ZSBQTVUgZGV2aWNlLg0KPiA+PiAgICAgQ3VycmVudGx5IHRoZSBkcml2ZXIgaXMgcHJvYmluZyAi
YXJtLWNvcmVzaWdodC1wbXUiIGRldmljZSwgaG93ZXZlcg0KPiB0aGUgQVBNVA0KPiA+PiAgICAg
c3BlYyBzdXBwb3J0cyBkaWZmZXJlbnQga2luZHMgb2YgQ29yZVNpZ2h0IFBNVSBiYXNlZCBpbXBs
ZW1lbnRhdGlvbi4NCj4gU28gaXQgaXMNCj4gPj4gICAgIG9wZW4gZm9yIGRpc2N1c3Npb24gaWYg
dGhlIG5hbWUgY2FuIHN0YXkgb3IgYSAiZ2VuZXJpYyIgbmFtZSBpcyByZXF1aXJlZC4NCj4gPj4g
ICAgIFBsZWFzZSBzZWUgdGhlIGZvbGxvd2luZyB0aHJlYWQ6DQo+ID4+ICAgICBodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtYXJtLWtlcm5lbC8yMDIyLQ0KPiBNYXkv
NzQwNDg1Lmh0bWwNCj4gPj4NCj4gPj4gQmVzYXIgV2ljYWtzb25vICgyKToNCj4gPj4gICAgcGVy
ZjogY29yZXNpZ2h0X3BtdTogQWRkIHN1cHBvcnQgZm9yIEFSTSBDb3JlU2lnaHQgUE1VIGRyaXZl
cg0KPiA+PiAgICBwZXJmOiBjb3Jlc2lnaHRfcG11OiBBZGQgc3VwcG9ydCBmb3IgTlZJRElBIFND
RiBhbmQgTUNGIGF0dHJpYnV0ZQ0KPiA+Pg0KPiA+PiAgIGFyY2gvYXJtNjQvY29uZmlncy9kZWZj
b25maWcgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiA+PiAgIGRyaXZlcnMvcGVyZi9LY29u
ZmlnICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKw0KPiA+PiAgIGRyaXZlcnMvcGVy
Zi9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiA+PiAgIGRyaXZl
cnMvcGVyZi9jb3Jlc2lnaHRfcG11L0tjb25maWcgICAgICAgICAgICB8ICAgMTAgKw0KPiA+PiAg
IGRyaXZlcnMvcGVyZi9jb3Jlc2lnaHRfcG11L01ha2VmaWxlICAgICAgICAgICB8ICAgIDcgKw0K
PiA+PiAgIC4uLi9wZXJmL2NvcmVzaWdodF9wbXUvYXJtX2NvcmVzaWdodF9wbXUuYyAgICB8IDEz
MTcNCj4gKysrKysrKysrKysrKysrKysNCj4gPj4gICAuLi4vcGVyZi9jb3Jlc2lnaHRfcG11L2Fy
bV9jb3Jlc2lnaHRfcG11LmggICAgfCAgMTQ3ICsrDQo+ID4+ICAgLi4uL2NvcmVzaWdodF9wbXUv
YXJtX2NvcmVzaWdodF9wbXVfbnZpZGlhLmMgIHwgIDMwMCArKysrDQo+ID4+ICAgLi4uL2NvcmVz
aWdodF9wbXUvYXJtX2NvcmVzaWdodF9wbXVfbnZpZGlhLmggIHwgICAxNyArDQo+ID4+ICAgOSBm
aWxlcyBjaGFuZ2VkLCAxODAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IEhvdyBkb2VzIHRoaXMg
aW50ZXJhY3Qgd2l0aCBhbGwgdGhlIHN0dWZmIHdlIGhhdmUgdW5kZXINCj4gPiBkcml2ZXJzL2h3
dHJhY2luZy9jb3Jlc2lnaHQvPw0KPiANCj4gQWJzb2x1dGVseSB6ZXJvLCBleGNlcHQgZm9yIHRo
ZSBuYW1lLiBUaGUgc3RhbmRhcmQNCj4gaXMgbmFtZWQgIkNvcmVTaWdodCBQTVUiIHdoaWNoIGlz
IGEgYml0IHVuZm9ydHVuYXRlLA0KPiBnaXZlbiB0aGUgb25seSBsaW5rLCBBRkFJVSwgd2l0aCB0
aGUgIkNvcmVTaWdodCIgYXJjaGl0ZWN0dXJlDQo+IGlzIHRoZSBMb2NrIEFjY2VzcyBSZWdpc3Rl
cihMQVIpLiBGb3IgcmVmZXJlbmNlLCB0aGUNCj4gZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0
LyBpcyBwdXJlbHkgIkNvcmVTaWdodCIgc2VsZi1ob3N0ZWQNCj4gdHJhY2luZyBhbmQgdGhlIFBN
VSBpcyBjYWxsZWQgImNzX2V0bSIgKGV4cGFuZHMgdG8gY29yZXNpZ2h0IGV0bSkuDQo+IE90aGVy
d2lzZSB0aGUgc3RhbmRhcmQgZG9lc24ndCBoYXZlIGFueXRoaW5nIHRvIGRvIHdpdGggd2hhdA0K
PiBleGlzdHMgYWxyZWFkeSBpbiB0aGUga2VybmVsLg0KDQpZZXMsIHRoZXJlIGlzIG5vIGNvcnJl
bGF0aW9uIG9yIGludGVyYWN0aW9uIHdpdGggZXhpc3RpbmcgZHJpdmVyIGZvciBFVE0vU1RNIHRy
YWNpbmcuDQpJdCBtaWdodCBzaGFyZSBzYW1lIGF1dGhlbnRpY2F0aW9uIGludGVyZmFjZSAoTklE
RU4sIERCR0VOLCBTUElERU4sIFNQTklERU4pDQpmb3IgZXh0ZXJuYWwgZGVidWcuIEJ1dCB0aGVz
ZSBhcmUgbm90IHVzZWQgaW4gdGhlIGRyaXZlci4NCg0KPiANCj4gVGhhdCBzYWlkLCBJIGFtIGNv
bmNlcm5lZCB0aGF0IHRoZSAiY29yZXNpZ2h0X3BtdSIgaXMgZWFzaWx5IGNvbmZ1c2VkDQo+IHdp
dGggd2hhdCBleGlzdHMgdG9kYXkuIEdpdmVuIHRoYXQgdGhpcyBpcyBtb3JlIG9mIGEgIlBNVSIg
c3RhbmRhcmQNCj4gZm9yIHRoZSBJUHMgaW4gdGhlIEFybSB3b3JsZCwgaXQgd291bGQgYmUgYmV0
dGVyIHRvIG5hbWUgaXQgYXMgc3VjaA0KPiBhdm9pZGluZyBhbnkgY29uZnVzaW9uIHdpdGggdGhl
IGV4aXN0aW5nIFBNVXMuDQo+IA0KPiBPbmUgcG90ZW50aWFsIHJlY29tbWVuZGF0aW9uIGZvciB0
aGUgbmFtZSBpcywgIkFybSBQTVUiICAoVGhlIEFDUEkgdGFibGUNCj4gaXMgbmFtZWQgQXJtIFBN
VSBUYWJsZSkuIEJ1dCB0aGVuIHRoYXQgY291bGQgYmUgY2xhc2hpbmcgd2l0aCB0aGUNCj4gYXJt
djhfcG11IDotKC4NCj4gDQo+IFNvbWUgb2YgdGhlIG90aGVyIG9wdGlvbnMgYXJlIDoNCj4gDQo+
ICJBcm0gR2VuZXJpYyBQTVUiDQo+ICJBcm0gVW5jb3JlIFBNVSINCj4gIkFybSBQTVUiDQoNCkFz
IGZhciBhcyBJIHVuZGVyc3RhbmQsIHRoZSBBUE1UIGRvZXMgbm90IGNvdmVyIFBNVSBpbiBBcm0g
UEUuDQpJIHRoaW5rICJBcm0gVW5jb3JlIFBNVSIgd291bGQgZml0Lg0KDQpSZWdhcmRzLA0KQmVz
YXINCg0KPiANCj4gU3V6dWtpDQo+IA0KPiA+DQo+ID4gV2lsbA0KDQo=
