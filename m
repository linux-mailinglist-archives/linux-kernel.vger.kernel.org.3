Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD92B5442DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbiFIFGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbiFIFGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:06:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E374265F82
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOQm5CEBkCodZz7NOPDHzsTtC64ZtCeEPpO/LGf0SWd9u+aC/AjYDaPrnTKFDpLo+J+JopMWYcw2gdme1PeNF8r8zRBm7UokEzg3yErHPdaJzvO6XNq8Mcd0zFzze9/d55113SP4olSwWQfMdGLujhcCjQJhnvwW/LzWPszLiGA3CTnGDsm0n2HXqD3MTNBWg8VGaihrvIdM6PXRNzKHcoW3TVtHlzZGDTV4QfaW0E34x0AAtkzAYIEuoctVjHItzllVhRwVJAOfdaRmmh2YhuXxjwIkJkkW5rLchUlm3c+/bI/qI6XqdtspIUIKhHh0Vtw1596UpStO2Xg6UeYdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g46kICK0Tro+DJUmdkIPWHza2olXjCC2DJ4i6TsKI8=;
 b=QCdpVf8U7uUUXjPXqhUuPYsx9as++WSvPAWQKkLW776YnLwnGKSKNXhsBIHRbpWqjQaAqJQ+QTuPpLPuDzAvlv+5wRn/gjlgwWGooS6Q9JLCF2p5995nBFz+aXqldkFFWwGX2qkb0On6FLnZBuRRQDYL8RyZaqUOZb9mD4XAz7qJH6Q05YyzHQJHUHQt83r0OlCq4c7ryT5+R9sLY3gcDWjlSFTB/pHZl/2Gp1uryMAolBTrCWImWhfN7cUFqMVqYt7hBdCJHlsgI7Jogin+u5BFVYaKnq8kVpx4bRJGG/L72rVYEBzDj/g5kmII5rfaLaM9wlFJsJTFJcle/4Zp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g46kICK0Tro+DJUmdkIPWHza2olXjCC2DJ4i6TsKI8=;
 b=abcZzcoqTJBu2Z/x/ShQiIlW0v6KSdmhQpiyFeP7ngRv+UJGHT6sYo45HdLv0F7hNytRGYmEKk49NG98lNcoyn3RP5NgbXL9DD4gjkYyQaTvL49nZr7ma402tt2d0NzIYXxRiDtl4iPoChVW8+nl0vz4R5LiLZnnCT+ZwhE3KBZqLdkV6epCA0WFGwGCVBPNjk4xQmdgGpS6MAPU2zY9wPsBmF+ggbzXK9VcMXphv0My1pneQ4g2VxmsH5k9TNmzKeMx0sJ0dRQmXTP/7kMzRSX2OskCwR01xzTJD91e9s3obncuvhZSs/AA7GQeWIcirwcTD9fAiggmlYRENkLkeQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (52.132.153.28) by
 CH0PR12MB5169.namprd12.prod.outlook.com (13.101.1.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Thu, 9 Jun 2022 05:06:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 05:06:02 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     Caroline Subramoney <Caroline.Subramoney@microsoft.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        Richard Wurdack <riwurd@microsoft.com>,
        Nathan Obr <Nathan.Obr@microsoft.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v4 1/1] nvme: handle persistent internal error AER from
 NVMe controller
Thread-Topic: [PATCH v4 1/1] nvme: handle persistent internal error AER from
 NVMe controller
Thread-Index: AQHYe2kcP72pVk+OVk+EwBZ9BRmAeq1GN0KAgAABgwCAABFkAIAAPD8A
Date:   Thu, 9 Jun 2022 05:06:02 +0000
Message-ID: <4a0b859e-8e2f-8ae0-1485-0f1ddec190ed@nvidia.com>
References: <1654714341-41189-1-git-send-email-mikelley@microsoft.com>
 <0e57d8c2-9a30-f15e-dc38-da397ac81c34@nvidia.com>
 <5a27e5a5-74eb-6c65-eb68-c655c3b5ae6e@nvidia.com>
 <PH0PR21MB30254824A4CC8CF6FD5EAD96D7A79@PH0PR21MB3025.namprd21.prod.outlook.com>
In-Reply-To: <PH0PR21MB30254824A4CC8CF6FD5EAD96D7A79@PH0PR21MB3025.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4e74f8e-846d-45b9-cd3e-08da49d5c026
x-ms-traffictypediagnostic: CH0PR12MB5169:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5169B1FB490FEA2C17D672A6A3A79@CH0PR12MB5169.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hKJ5QROa8Kkx3ObxmDFmEXH8z3DtXMDAvZjRC/ut8G2bdfIVX5/KUSL94pDZDWX932KOSTpJLySXMMuMGc4TtDoMzRMGgIyHhY+v+OhVIhin4ziDtAKQU+60b2GJwUiDVzS2VIY1yk58i+GwYWgpzC5ZGL1lapI4cEkKBRalQEtDFlJsL8BTln3ZZPCiRhU2OE0Psgx2DHBGi0ISC3gfdSer4ikL6E2GQghW8maRwFr58lRGkLVua+oEHvFU3L5EtJQiVwxv2Wz0qAGIIEOQwdaKSEV/pXeI8EG1w/zQPwvq2Xo9CpBQyc2FrHDuhlPZRL9WgT1FoiZwib5qoquKg/BNqeufotDIzhBe2s9KtdmDI08ogJLOfar7/MXJ7xxIjJ4s0RAX3CxMEGs8oUGUFGx0jwQf4JfWPJzM8kNjJDEmdo3478WywuLTFOjOxfXEgefLipL5LCbIWDZD72yQm4VgjGgh5KcosRUtkx+29+h72vdzmUVJmGq09/NGtnlQmMWq2wY/X3/904Lv+EiYQnAZ6j3Y9PnqRQJfOB1tT81W6yGQ1M5+bbrM/8Rpu03iF4TOtS+xlDRWsy1X3Cgbg5VBCDWpuh6NU+iY4KN+8bitpkluXjxDUz+mzKWCklFITyqfyQ+bekTitG8l2suaJTB1XXPs7cDzxASNpR5eGAZwoap0ihNefXSJVr7+IAD7MA9dBHj2nnmk40opkHdCvK2wdt+NtIUxBK3KxQyDkkNn98eVm8pc/gecYqP4qCx0i/VEN7i0WMIGbUzHjlkIeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(83380400001)(38070700005)(122000001)(38100700002)(6506007)(6512007)(31696002)(53546011)(71200400001)(54906003)(91956017)(6486002)(508600001)(316002)(76116006)(2616005)(6916009)(2906002)(64756008)(66946007)(66556008)(66446008)(4326008)(66476007)(8676002)(5660300002)(7416002)(36756003)(8936002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW4ybzBZaUJxOTV1MDRyL3k2QUttQ1Z6cjRMb0p1bWNscXhVQWRSSk5nR2hu?=
 =?utf-8?B?dHlaYlkrckVuS1BaL3JSeTZPK1hWWGhqTHZoWWJKQnNuZk1ZeU0wdjAwaGZM?=
 =?utf-8?B?QXYzKzROSDBxR2hNMTNHRjhBMno3Nm9uQ1V0bjZYbnBYVXFta1lTam1odUJH?=
 =?utf-8?B?b0QzdEJBb2d6RmU1MnZTcFFnRm5uQXdVTmNDZE01bk9ONndLS0t1RnZDKzkw?=
 =?utf-8?B?U3RWQnNFcTBGOHFIVWFONGE1QWtDRlRFUUZhbkdMdDFaMDJkNUdweWN4R2Y4?=
 =?utf-8?B?bkF3VkhHckdBQ3k0Q1BQVm8wcE5QdGloMmYzaGtDTlFlM1lLcm5VanM3dDVZ?=
 =?utf-8?B?RXkzVmpROGtVVWpyQXhVam43cWRoVWprcU1nNWhXc2pQSTRXb0FzbTFhelRN?=
 =?utf-8?B?TSswZlNNY3BOaG83MUlxd3VFQ2JxdVpUYVpjTkFIRkUwS0RlSFJmTDhpTk43?=
 =?utf-8?B?UDZNbjZvWlZVOWFNREdlZ2lWRUlRSCtqOEVMNEJYR25OTVpZcVBMVjJzK3hJ?=
 =?utf-8?B?SkFDemFibVBqQjdMaGJ0Lzl1RzFTU0NFa29KWGhIM2ttdmplWmZndGJYbjZQ?=
 =?utf-8?B?cmRzbm9ndWtueDlxeWtXdWZMWE8xdTNHWm1UeEp3Nno5S0NOTzVVcVcwY3Jy?=
 =?utf-8?B?WHE2cXlCQW5RajhnMEhpUnVVRlUyTFFiZlBRMXJSMG51dDRLNTZKMWVsTG9G?=
 =?utf-8?B?TVRmNnhjWmdUMDRMS0xOTWF0MCtJcmJPNElUeDZRcEErVWgxQTVQYVgwdWl5?=
 =?utf-8?B?eVNFS0hYV25kajFvc2JtYzMra1ZHWjN0b3FKdkdBc2I0WTNkQ0o4Uk9ncDJa?=
 =?utf-8?B?UDd3Sk5mQ0lQRE9FSDdjdkl0OGYvbGdOL3dPSlBqMDd3REpHL2RnRjlxTS9E?=
 =?utf-8?B?TitCRXF6RmROeXpGSFFsWCtDWkQ2TEpRSlY1K0NiNFlBejZuRXE0MlBPWW9D?=
 =?utf-8?B?akNYOTBGc0ZCNWF6UEU4UlFoRldnZGtmZXVNVGxzVVNoNllpZmp3VHROVi9v?=
 =?utf-8?B?aTc1NGI5TnVTNWk3U2lERDNUNlNvQWxPblphTG9GbVVUZDRSTEN3ZGs4K1FF?=
 =?utf-8?B?Ymw4V1I0MmFyZC9KNXdOdTRqTUpPd2hlTy9tcnpkdElYVjI5anEvMGlGK0pu?=
 =?utf-8?B?YnZqdHRKNHhRSnp6MTdtRXF6ZTVaZi8veFM1Nkh4ay9zVFJnMjdEeHEvK3Qx?=
 =?utf-8?B?RFJsVnllb0Urd2FBT0JVRDFiL0dYTkVWVEdEcHdNaWlYdUhZaEZRT3dkK1lz?=
 =?utf-8?B?djZ6Mis5MmFoaVQzYmpOVXdkUjJRT2JzeWRhQnVVOEZWTkdmMmxIOWRQZjhH?=
 =?utf-8?B?UjFXZlVNdnhnclZ5aUM1R0dkZzY5TjRZV3NpOWdERUlpNXhwWVpjajN2bUNT?=
 =?utf-8?B?elRlZzh0VmVuZXdYTUp6QTI3aWV3MmM5L1gyR05WeTNFRDJVNm54eFZzTzQr?=
 =?utf-8?B?M2pySzIzam12d0M2Nm9zSC9NdDkyZ1BaYy9CS0wvQlFoUENyMm9Xd0FVQlhr?=
 =?utf-8?B?c1h1dkJXbXNtV2w2TUpiMmVmZnpuczVlNmhvTHQ2TWxrQ3hsbFJ0eXJnalcr?=
 =?utf-8?B?QTVCVnI0NENDWXFNSUZnUy9vc2pHZUU0czAzbVd4MGg4V29ia2diSlRtVjVY?=
 =?utf-8?B?NGZDdWxXZHpGRnp5Rm14cnpzT0RQaEcyVzZYRllNcVlkRTNJcm1UV2d1NWE3?=
 =?utf-8?B?RkR6YUJLMHNqUDFiRlppMjBlMWZZRDRVZTZuVTFrSjRyL1l1OVROTm0xNWM5?=
 =?utf-8?B?L0p2UDR1STlPSno2SFhES296UUhMMXk2NlUwQlRxdXFOemRqUE1qcmtUNWhk?=
 =?utf-8?B?akJveHZlSGtIM2VnbzMrUTJHdkVoNzdwT3ErQWJBd0ZHay93cUp0cXZKeC9L?=
 =?utf-8?B?NFlNeWNxcEpzNjNSUll5dzk2SThCWFlwUTk2bmk0bUJGMnJ4WnFUTlBQMnNl?=
 =?utf-8?B?WWxlVlZDWWxrbG5RVlZibWZ2eVZnQ0VtcnhWT3htQytOUWp1QnZrUzZBRnhz?=
 =?utf-8?B?V29rcDVOSmFzSGxRRWZGcTJyMjYrOFVNd28vWGk3eVlJTmgxNnhxTjFNS0Fw?=
 =?utf-8?B?ek9zRFB0eUZOWXBWbnB4WWR4ajM1dXZVeHlmdkk2WURGSEpWK0Z3cVVJWG9j?=
 =?utf-8?B?OHJHNXBOQVREY3BUN2x5VDhzbXU1Z3I2ZXJUUGVmb3gyU0Z6L2p5TTI2SFdx?=
 =?utf-8?B?Yk1sWU9aaG1aQmx4VnVxbUxsamM5Z1VMYjRidGxYOTdNdTNZcHFOOUtTL25n?=
 =?utf-8?B?bndiVjNGTnY4eFkxenMwVUtUc1QzRkpUV2hjak5qa3RUNndaNFVhUHBwT0Zv?=
 =?utf-8?B?V2RFM1lEalJZblhubHovem85QTduQThhMGFQbU1vMWZxK0Z6b1BhWUhqMzZS?=
 =?utf-8?Q?PFHPqBjzOz2l9pZ/9IDByBj65oaR1ix0JkH30A8RVRxxj?=
x-ms-exchange-antispam-messagedata-1: ZMzhhGb78bRMiw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <58153A98DC089747A098B9920AA21037@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e74f8e-846d-45b9-cd3e-08da49d5c026
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 05:06:02.6507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JnNDYJEpCpQB2753srj+kL58Li9y1EtSvkzp6as9CtoQB5r73seq8cWDyWtFk1Zd8X0HGKL2Z57vH/PfZasEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5169
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi84LzIwMjIgNjozMCBQTSwgTWljaGFlbCBLZWxsZXkgKExJTlVYKSB3cm90ZToNCj4gRnJv
bTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWFrQG52aWRpYS5jb20+DQo+Pg0KPj4gT24g
Ni84LzIyIDE3OjIyLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+Pj4gT24gNi84LzIyIDEx
OjUyLCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4+Pj4gSW4gdGhlIE5WTSBFeHByZXNzIFJldmlz
aW9uIDEuNCBzcGVjLCBGaWd1cmUgMTQ1IGRlc2NyaWJlcyBwb3NzaWJsZQ0KPj4+PiB2YWx1ZXMg
Zm9yIGFuIEFFUiB3aXRoIGV2ZW50IHR5cGUgIkVycm9yIiAodmFsdWUgMDAwYikuIEZvciBhDQo+
Pj4+IFBlcnNpc3RlbnQgSW50ZXJuYWwgRXJyb3IgKHZhbHVlIDAzaCksIHRoZSBob3N0IHNob3Vs
ZCBwZXJmb3JtIGENCj4+Pj4gY29udHJvbGxlciByZXNldC4NCj4+Pj4NCj4+Pj4gQWRkIHN1cHBv
cnQgZm9yIHRoaXMgZXJyb3IgdXNpbmcgY29kZSB0aGF0IGFscmVhZHkgZXhpc3RzIGZvcg0KPj4+
PiBkb2luZyBhIGNvbnRyb2xsZXIgcmVzZXQuIEFzIHBhcnQgb2YgdGhpcyBzdXBwb3J0LCBpbnRy
b2R1Y2UNCj4+Pj4gdHdvIHV0aWxpdHkgZnVuY3Rpb25zIGZvciBwYXJzaW5nIHRoZSBBRVIgdHlw
ZSBhbmQgc3VidHlwZS4NCj4+Pj4NCj4+Pj4gVGhpcyBuZXcgc3VwcG9ydCB3YXMgdGVzdGVkIGlu
IGEgbGFiIGVudmlyb25tZW50IHdoZXJlIHdlIGNhbg0KPj4+PiBnZW5lcmF0ZSB0aGUgcGVyc2lz
dGVudCBpbnRlcm5hbCBlcnJvciBvbiBkZW1hbmQsIGFuZCBvYnNlcnZlDQo+Pj4+IGJvdGggdGhl
IExpbnV4IHNpZGUgYW5kIE5WTWUgY29udHJvbGxlciBzaWRlIHRvIHNlZSB0aGF0IHRoZQ0KPj4+
PiBjb250cm9sbGVyIHJlc2V0IGhhcyBiZWVuIGRvbmUuDQo+Pj4+DQo+Pj4+DQo+Pg0KPj4gQ2Fu
IHlvdSBwbGVhc2UgY2xhcmlmeSB0aGF0IHdoaWNoIHRyYW5zcG9ydHMgeW91IGhhdmUgdGVzdGVk
DQo+PiBzdWNoIGFzIFJETUEsIFRDUCwgYW5kIFBDSWUgPw0KPj4NCj4gDQo+IEkndmUgdGVzdGVk
IFBDSWUgb25seSAtLSB0aGF0J3MgYWxsIEkgaGF2ZSBhY2Nlc3MgdG8uICBJIGNhbiB0d2Vhaw0K
PiB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gYmUgbW9yZSBzcGVjaWZpYy4NCj4gDQo+IE1pY2hhZWwN
Cg0KSXQncyBva2F5IHdlIGhhdmUgaXQgZG9jdW1lbnRlZCBub3csIHRoYW5rcyBhZ2Fpbi4NCg0K
LWNrDQoNCg0K
