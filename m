Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33B74BFF2E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiBVQsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiBVQsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:48:33 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA38160FE9;
        Tue, 22 Feb 2022 08:48:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFxES0IDLl2NNxyGoDQrwiU3so6cxXcEEq2Hrx3R0fS+XcRL6hl050X+wfvsLLe2oMeGhdI8DpL0+hSPl7qxSM/8YWYpp8pl2KAtxRCfIxzb6pVm8pJlLEgOEmCVoZe95OBiZI+JuoaXZ5699yXpuCf60hzkoXSfAfh2h84yu9HAGEFYSIFX5jzLmMGAj526ZHZPXqWSDl87cGwXE19Z09cORTEDcHfyTzoGwL38j9WFCnL2a0Pi/fA3FlUlhJiTFlx6+NE8mHucHzQcIv7fCK7kx4yerRIT7qgWIYXU91fz6eSDAiGQg7AtWEVRpfDKonyoPINX9qU7QO1ooeiAbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVZG/eMxN+YB3U4Vv72atrAFc1Tax9fpKjBSpdxt84g=;
 b=PN5SV7Ir92Vg0Us32uYvHBmUWzt+Mtsac/WOwWRe2XVaQaOY6cUI0nEROsrf74qvB9jrfUe6YO/41/LkoGZid3BFvodne19AxfZ664hnIu+JGINWaSil2UCGMsxKYlxGxB4XtPxU+7SFyCR9/bC7S9zWZmaPgc6/n133lhhjkmrB22h8B+0ruDxTyiLH6Qy9szAn5mRhXv82osW4iH7jP9bfLfMG01U697stQ96BvUdp07ZKRmXsQMplAYcVTyuaiI4OfM1hwCFO2n6kwyyIIekli2v1IakBWTWOhYvNOBZ3d4mF38MMEbGdQ+PLAAhzFBOFXragF/Erc33cyZrUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVZG/eMxN+YB3U4Vv72atrAFc1Tax9fpKjBSpdxt84g=;
 b=r8FvhtJ4Ul9sxfz+Vpil9wJ4GNkVw5XqS5LmeJsHmLelr9LFlVTs2dXfQarcsc0kVwSOgmuBAf8QKI30qaRj4eU2JP5Y0EgGpaZ3c6ncxrSIoysZ2jVuISqAEuCuYHKEPU4LJP24awRhyDVjNpBXJEPPu9KHviGzjsPxSFbUK3VOGYwJo7hfKtQS7Ho441Z0uG5Hbn/c/mwYglVjg8GXnsWTC4cz8KmLtj1ECAvFAcNDGQ2ASkTtpIx6n7vkBOT6ZRWmB9rIvDw6gF2oZZnO3mV+ZxtlafZL53C07xFUuIcIcyiK8E3YbjMjhZcOxgPKzbEXQ9N1dleqtm9C5H654A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN6PR12MB1204.namprd12.prod.outlook.com (2603:10b6:404:1b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 16:48:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 16:48:05 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "colyli@suse.de" <colyli@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Thread-Topic: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Thread-Index: AQHYKAnT3qhQXFzrb0qMggW0v7q9UKyfx9mA
Date:   Tue, 22 Feb 2022 16:48:05 +0000
Message-ID: <c3eb843b-1c33-4098-eba6-4680e820e924@nvidia.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-5-kbusch@kernel.org>
In-Reply-To: <20220222163144.1782447-5-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebc78c07-1bc0-4d01-150b-08d9f6231948
x-ms-traffictypediagnostic: BN6PR12MB1204:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1204964EA57ACF9CD469D667A33B9@BN6PR12MB1204.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sMYpmfZOWE4P1dHcoGBW9fQlian5+O2mtG6vGv0BdeFFNVxaRV65nC+nmpi826VCpIEQwI2CN/+jHoDWTC0PI82w1AufuL6YQhmsNv4iVDrWz791k2GQwzfpi+pveVhOoXg3QHzIWCCEnIabhKcEq/zdvcAlE32v/vmTTUWgFu5hgXfSo3bIL5QOzEcOoBVUEJrYlPQM+b1Pb4lutw+3Zqbq9Ek+3blUBCtl1v1lXfw/D/vBl7OWoI8TRsb/RIJnChaauMctMKhJn3wSMOh5y1RFsiMZ9rgLWcskvz1BtVSkbwCa3eCUn1QelUZ5rD+VG98chenLG8JfUItg+Zx+pgp1DC9xNEx0lOvmFekrwTB0XTIJ2CbnCZf4xeWGMFBsttCuixulIexoz/Kd0Z6xFYEwQUnappNIRulObS/8h7ZBiOc//06N90nlxkdy+xd2UxzK6+wzHAFGUxTOotylU+9bXVA1hEcoTQjYtY9HR2WgWx2pRWmP5VeR6rP4iaR5hkp8VitQ3hy0F5Y1OczK7mmh6XzSnwu81bAXajfHiMVGQTVhLlVz0tmP/iWj5OdwT2iSkYv7rHY+e92cS083lBJk+UCB2pRAF8iIMeIuTJ8/ZmWZkH6GDqrSEVhtmItdoXh0jXgqNS4RJoRigT6zflmgx4TtQbLaQ8eziEBqFQgWbRZICCy4D7D4E4wRi/JlRC7p3IfM4TgKKeurMc55gDAxHIMx1nHK9JvhpXtVutLhkjwVT2pzDwqIwdYm6R+C+cN93r/hIGS6TTRoQggy4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(558084003)(38100700002)(36756003)(122000001)(508600001)(6486002)(5660300002)(86362001)(7416002)(8936002)(316002)(54906003)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(76116006)(2616005)(91956017)(186003)(6512007)(6506007)(2906002)(53546011)(31696002)(110136005)(71200400001)(38070700005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEFsc0x5cnVOeDN3L21lc0c5SmdyYkpEcmtZVk5rWXQxekFYTmR3dkF4R2lQ?=
 =?utf-8?B?ZUI2cnMyMFlkQnY2R3Y0dGEzVEJqTC9SdC9CUEh4b0RTYlNsNWZ0M01DbVcv?=
 =?utf-8?B?clpVTktxOW9SY2I2cFAwRkcvYWdiYlpuSlJFSmVIcVBtZWFKdDJrSVJCMHdE?=
 =?utf-8?B?cHI4c042SVNPQmFQVW11ZEZGdTBLNlhvVi8yNGQ0Nmdub0xsWFBFWFF2Y1k2?=
 =?utf-8?B?V3duZmRtQk1UaXVJUyswQ0UrRy9FZTZrZHMzYUVaTFJVQ3JTVDIydGduUmJa?=
 =?utf-8?B?K0xiSHlBNkJYOGtvbXVrTUhYNDVCanF6TnFQeHE5RmdPSmtNVHJ0K2dLM2Ex?=
 =?utf-8?B?aDFVSWVmOFdWNkQ2azl3My9RdEtjajdOM0dSRGozdGFPZWRWYVk5VjA3Zm91?=
 =?utf-8?B?Zm1uYkFzc3BYYUM2L1VXeEs1TzJCdDNsNlpNbDdRem40cThSRzdUUm9hZGN5?=
 =?utf-8?B?eXgxMzlrcmVTalJuU3Z1TE5TNlVJdHBKaVNqL0hvZVZIcnRJTHBBc3AveFh6?=
 =?utf-8?B?MjZXN1hlRTFzZzNQbzlYUEdDc1RhZkwyTlduTjhweUdkeUFSNmdsc3laeVB3?=
 =?utf-8?B?ZW9QbnNvenRObDRVc1ZzWmNZcFRqbnRRdHVqRFNuUGFmNThUdGMwRW1KdUxj?=
 =?utf-8?B?SFArNmhELzliQjgrZ3RjNUVwd3FFUnhLcU1VdHQvZG53WWE5emRHWDYxa1BX?=
 =?utf-8?B?RmUrdGtjVTdSazVBVVpYaXhlU0dSZ2Fjd1lqbE1ueVNzK0diZWpMQWxJTlNw?=
 =?utf-8?B?S2dkUXZ2eGFaZUpsUW04WGZTMXFEODVocVF1UFRUSDEya3hzd3ppMFVqdzk5?=
 =?utf-8?B?Ump0RjQrdlhqanBRZ3lOUUtaWVB2OUpVTWt1TllRRnpDSjFxYm10enVjdUpz?=
 =?utf-8?B?S1oxNTR0WldxWmV0UTR1cEsyYkt0UkVaeG5FNW14MHRsckg3a2Y1MzZ6VURj?=
 =?utf-8?B?MDloSVFXdFEvWjFZLzcvckdLQXNvUXRRUmdBL3pBQ1didVI2L0pKdi9JUlRz?=
 =?utf-8?B?SHdITytaUW1yZFZXRlo5VldqUXBBNW40QzJlWnZaYWlZUXlBb0p1b1Bad3Vl?=
 =?utf-8?B?VitlRG1JYzBKZWlIeTRTZURnR0NvQUR3cm5ZZXhXakNHeWlQSjdPM0JsMFNr?=
 =?utf-8?B?Q1MzOGpSMjM1bXcybENiS2RFeWpKZ3Z0Z2VCWGVSWmxyZkxvbFUrT0ovNk11?=
 =?utf-8?B?ZHU5UUlic0wrcm4xcDZZdnJWa0ZzNitUaktUblA5ZE5pcVZQSVBObm5QOTFs?=
 =?utf-8?B?SENhNDJKeUxrWTd5cEJGa0JsbzRwQ2ZQNlpkWnNMcW4rMDgrbzZHTzQvOTZy?=
 =?utf-8?B?dk9KekJPaTh2c0o1d2VFT2pNR09YS29hOWFLL04rc0dERUUvY0V1TVRleXBx?=
 =?utf-8?B?dGJWYlUydWdJZjIyVWx1ZjhKTzkydHUvZnpSaEc3cnlnYitwQXcybXlVMFlx?=
 =?utf-8?B?d0Z3dWtnUUgzQiswOG1MZGtZS0ZCakNYTlQzeGVZdFczQ2pmRHBGdnlwVS9F?=
 =?utf-8?B?TllRUnhrNTh0WUEyYnBhSnZpeXUzMmRpN0ppOVNXUEl6REtzd094bU1FVDNs?=
 =?utf-8?B?T3pMNTZtTlJnK0lyK1ZpbEs5aERiSzNIUTcwUDV2RnNyb2tTK1laSSt3cWxK?=
 =?utf-8?B?QnVsVmE3WHZrVmdSWThXakZzNzVEMFd1ZGRTRG10MVRSbXljQ3IxVGxlVU9m?=
 =?utf-8?B?V1B4alh3Snl2RVFXdmtJTGtOTzlNTXMrYWdINXhTV1doSGZjZWIwbFdQZXlp?=
 =?utf-8?B?NmhiQlRPSkhCQ2VLL2JJZ1hXYWFYcXNwaWFtQTRzSnp3WjlNWHhVU0twYzI2?=
 =?utf-8?B?aWNleEpubG5EKzVKYi9lbHlsTEgyTTVSOWFmb3hxRUM2bW5RcXFVME1EVTVG?=
 =?utf-8?B?T1dxN2xsMGp4ZjFHQ3c1SWxvU2ZPcUFTVWhIY1lMcVdwS1hsaVBFSFhvejQv?=
 =?utf-8?B?ZVRrbmR5dngyVTFDNHhvbDVJekw3UGl2RUE2QW5Gc0cvL0FjMTdQSjZ2bVdS?=
 =?utf-8?B?a3FZdUlLTDlUbkxlck01MkZ5YW1udGcvTmtlTHJwVm1JZzFJT09JTmY4eXNp?=
 =?utf-8?B?cjZoVVZrRkZhcjBqNERQNGFBU1hEYTBWY3FseG5jUGJ0UzMvQllPQUxRbkth?=
 =?utf-8?B?dnppdkpjY3VVVFZWVGIyV0NWNVdKVDNmNXR3a1BuZmpGZ1BkTHJsa09PK2c1?=
 =?utf-8?B?TGZQNVRiSE1rWHZxWFBsTVRpWFhVcjFaYlRaZERTRm1aT2s1TEYxZFdmdDQy?=
 =?utf-8?B?ejdreHdKRm9iZHZyL1dPa25jVkJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA5AB886AFF664498FDA6522CF650FD7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc78c07-1bc0-4d01-150b-08d9f6231948
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 16:48:05.7453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4oiWAN0YjpesBmHhUIJvLbKD4zmMq1oauW6nqtasI+Ulu1LdYV/1SpY6tH1fVEn8sBp8TPL1SMGIb+TSbc0lHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1204
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yMi8yMiAwODozMSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IFJlY2VudCBkYXRhIGludGVn
cml0eSBmaWVsZCBlbmhhbmNlbWVudHMgYWxsb3cgNDgtYml0IHJlZmVyZW5jZSB0YWdzLg0KPiBJ
bnRyb2R1Y2UgYSBoZWxwZXIgbWFjcm8gc2luY2UgdGhpcyB3aWxsIGJlIGEgcmVwZWF0ZWQgb3Bl
cmF0aW9uLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVA
YWNtLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3Jn
Pg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQoNCg0K
