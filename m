Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F5D4E2110
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbiCUHSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244523AbiCUHS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:18:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6961947AD6;
        Mon, 21 Mar 2022 00:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBqf+EJK128Ox4vXBEQUv6mkbBhY2d4oQUoOY50J2vfjt/erstq2KWj74OAFGEs8vCzkmurkHHfFZRP3TEFyGcCnG4be90ubwsjxBN9+9EWcB4YLLndv4cEFBgnWu8JCmu4ZMgGHBzbkzGcXfEj6P3JyhEwylPfeZZ4EUAgXOpDwwayVSjakAEujNItpdohcPP5N3xkbf3dnSlmp/TDwk06HAwwxFZAuy8slArr7ybz5O1zughhY6EfWTzhv9RxK4+AFIM9ZG67FUWfr1ib1eq03MFwnp5MlIf5DQi3xARcMsAHYovobq12ZD8/ay6Kxw3sUPxOdJNblKp+eE/hVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1HAmlvZEqAYf19qNwDPZQe5/exj9MDV6Ur4PkiESRI=;
 b=iXVLGjZj4xnKPM9ojF9qW24RhyZHLPl3vhrx3WNrWhRpqvDieZeM04+CJcSQxIMu1OPI64zAaa21bGNz/AwGxpMXZhsyjIC634VniDSHac2A9f5ND/eEs4Rb5ipymj8Ymz0qwejr/lT9EOUFWkPL/p5XpwU3OC5Civu7hYhT+vtzo8A9U0w0y6Onuqt02yZttGi2mfPEyLOUXK/dIfRPFqzLiTKwnpkoZ+CX3AAQcSSDPN85HtqNK/KQaw/0VStCDw3iuPqzjhzR28bJ+FGmQbfeKelU8agNGaJwZbRn0Ai0kQ45nMKG8J7+pqV82MEHB0ufpYzxhMCUGsFpBunnXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1HAmlvZEqAYf19qNwDPZQe5/exj9MDV6Ur4PkiESRI=;
 b=sDuDJ/YQXyBqqWMHKmPk+qsP4Qcec6NtP7dBN+DDoiB+fhdfpErx/p+mWzNEGYqVk4HwJhba0/2UyFS+4DjSc0LJXdOFXAyOOGT/Kh7+6n+t6mt6x1rebbCuK0ghVvDeCTFKQXSxLXlqdO541gKDQLMfctf6c9e0Jeu6Xh2PArSIibLDgAmc7Oq/6dgG2dznmZP1duETdTjIIAJb6BimBr7HR78Q9DdVH0n6cvQ1G+oBElexMQawund6VpQBwpw5bFWnu1qYGg+NKDRZamwo+m1s7Vo6p+moHAjZb5Wb8SnN51b4cr7stCdazzo+A/PMnP1IXXsV94PoBF5/eZ+vmg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1725.namprd12.prod.outlook.com (2603:10b6:300:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 07:17:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 07:17:02 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Colin Ian King <colin.i.king@gmail.com>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH] nvmet: remove redundant assignment after left shift
Thread-Topic: [PATCH] nvmet: remove redundant assignment after left shift
Thread-Index: AQHYOme6Koi6Bh5pvUi0R10GabR+9azJcoGA
Date:   Mon, 21 Mar 2022 07:17:02 +0000
Message-ID: <2dc14dce-94cd-6ef6-bf6f-a06842d27fab@nvidia.com>
References: <20220318013014.90698-1-colin.i.king@gmail.com>
In-Reply-To: <20220318013014.90698-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 563d901c-ca36-4eaf-eb2f-08da0b0acbca
x-ms-traffictypediagnostic: MWHPR12MB1725:EE_
x-microsoft-antispam-prvs: <MWHPR12MB172501E173FEDF790ECC8B36A3169@MWHPR12MB1725.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dfm7EWKmZ8ttj1CbKavVZzoliR6P3n1NVDB8Sk5ymtvWRbyendjL/k51/n0A5SNSNweIU3gj5+xvOOrdNKUZZ7OOBWBO4bvbcm1V+FMzonQ8s6TNVFYrBzfo4J8hW/Wi11GGcmm7S/BMVUOHnv0lAue8XMl/lmXPf1AOl9UvvU+oQhBCLHOfFhabQNYRbMpCbIrgGmcwEdSuW/wviXtlhoVbKG8X0HdUH8Ot9Hb5SwhSYj+DyDvfvRa/0I88JvBNgGRy2F0rMDd3HDOkQHRE4CLwzdDqbjrKgzf1xNszdWKTP70j6iCCWrNCScWW9vG928H2S97oUuG/cei00HqWvEBpHvFTUsxZ3sOp+4GALsHtpcentNDPR35fQVkThzbZLDezZB30oeeuOAFVdDrnij6+Q11CijpyqIbFTvaJRlEJjugUxpL8h34idwG/0Bwrk5BuE7J76JVguQu6IkeCDMoGhPYCC/ALB6uUJPWGRfj5/p6IC7yHU5S2rh9Nzy30eTMKDJQ2eDbHMEFb1qXc2N5vhSrSpeULmMw6bF2TJyHN/rV54vBvDFO45U70i7/ilZ5GnZVi0Zde165Dn8p6nAFsRKpNz6cYTVR2aPppSO5r+1h4qVZJc2xkg/Klcq3nB5jGeEV/ejskI2z1kDGZFRb1ZEJ2y8+GgOZjTOSbu5giu07nkR+FaAWv2K1NGpVcPXqWuZp3CQPbknEArXZAgY3mhqycckin8u+5RQv2bePG1GrGlMy4JtNWsFBQhGH6Nde1N/1Wf6b3wC2sv7FDow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(4744005)(5660300002)(186003)(53546011)(6512007)(83380400001)(31686004)(36756003)(66446008)(66476007)(64756008)(66556008)(2906002)(66946007)(8676002)(91956017)(76116006)(4326008)(6506007)(86362001)(31696002)(122000001)(38070700005)(71200400001)(316002)(2616005)(508600001)(6486002)(6916009)(38100700002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUJpdUJQdG1tRE5IbWVKdlhuQ0xTMHE4Y2VzT0xPcjlaU3Y1VFBJQ281eXlJ?=
 =?utf-8?B?UDA0Q0lJSlk1RWtXcXRsSTFiUDBmTExBcHdORE9ZTlBpaWpIY2N3amFxU1Av?=
 =?utf-8?B?M0F2VXVoSzBiUUV4QVJGcndlQzhKN1d6SzltZ0hrM0szTnJJTzNhRERqOFRS?=
 =?utf-8?B?SmtnVkFrWDJ0V2d5bmxhSElmbzBRaVJPM000YTVBbTZYT09laVBnMFljWEFo?=
 =?utf-8?B?NWRIR3FSb1VJV2FFWXlkcGZrUlFVMW9GaEFVMU5BSE9Bd3BGZEhCRjAvUFVC?=
 =?utf-8?B?UUdQVTJSWGw4WGdBdVVDSlFMOVJoR0xMZjdWKzlPRFlSUnFMTmN4Sk44aUdw?=
 =?utf-8?B?eDlOcGpPb2VNaHZVYzA5YUZsOGp5NGs5K0VpRWZiTE5abjBVdG9LdnJFdlhY?=
 =?utf-8?B?blVVODRrTVM2VkhhU0ZaeFNmL3NjTXAvWlZ1MFlqUWM3UDVSaDNyTTV1Nkhy?=
 =?utf-8?B?WkpBYk1mUmJqU3YzMTlkZ1ZiU1FUZERLUUl3aDdCTzFmNjZUOWtjRWhRWmlU?=
 =?utf-8?B?c3EyL3pEMy9QRGx5SUZIWGFLR2NVUkhpQ1lQYThrYzU4TGxUQnYybTkvZVUr?=
 =?utf-8?B?bTdxNE5XZnFyaTNTL1VFeWpRVWd4cDVBekRMb2pGcFl6V3VDSDhaQlFPeVQz?=
 =?utf-8?B?alY3YnVLVTJoWmx0RWUyQlRzeHpWRmFKTnVic0l3d1hWMXFMVWhUZnZOVUZ6?=
 =?utf-8?B?NlFmY28yT0xBR3JhdS9lV1RzL1RGV1pKbVFXWGJBRHV3ZE54OWlqRjU1K2sr?=
 =?utf-8?B?RTNvNkVjYmVRTERBNDBSZUt4Wnk5VktPTFc4NUR0QUErbWRlL09QTU13Zm1h?=
 =?utf-8?B?UzNNeHo0eGFNYWdQM1dkMHhVYVY1QWkrSUJ3UFdpSGpqSkFsY2w4aGlmZFVz?=
 =?utf-8?B?N3ZBTTlteGg5RHhiQ2ovRnNsTVp0NkRxSFBzR3lJaTFLckp1SXY1Zkl0QmpB?=
 =?utf-8?B?WHRmVUFLUDhDL20zekxoYVVTdVJFNmJOdjNtRjZoUVlRZlJaMkEzVTJvQXln?=
 =?utf-8?B?Y2RGakhkdEFnYy80ejhYMGpkQVNaR05qSStJMndZa0p2NkhTQnJZY1JLbHJm?=
 =?utf-8?B?VWZFMU9zRzhEMUxLczhPc1dnWjFmSlo0OHIrZmtrOGNwYjJHUXlsOFVSUGtj?=
 =?utf-8?B?WG4wWWsvaytuVWNtb2ptaXJjeUl2TVl2clZiQzdNYzVJdjBkTjk3dDkyZzlQ?=
 =?utf-8?B?My9mS0dMZ1VMSVdybnBQeGtSMU5FZ0p1dk11anhmV2VTZVB5bDAxME9Oangz?=
 =?utf-8?B?L2JTUHJBQXh0eTdDRTV2Qy9kY0NBaVFNUC8ydkFXTGx4Z0hlUk12SlJRWGVy?=
 =?utf-8?B?ZjFWeEJyZTloY0VwNlJUSUlZbmkzSk1sQUl3MTVodEgxSDVhRnp0YlU2SWxW?=
 =?utf-8?B?eXFISjhJNW0xNVBpODVUVGZ4OU1qMWhzT3VON3Z5M29HT1ZIY0lxbmdnM3NW?=
 =?utf-8?B?ZlJPUFZHMTZLWjVSamIvUTllbk95d0ZQWGsvOWV0U3pSQTFVYnc3TTZUOGIz?=
 =?utf-8?B?UVltejZQWmdXVjFqSEx0K3c0K0VLR3FlYzlFMUVhOCtxRTlLZDdSUUVDb0NM?=
 =?utf-8?B?eWhaaytuTm5rd0N2RVdjeVozNkUyQzJlTzl2TUFlQjFkQnRKcDVsdm1hR3ZH?=
 =?utf-8?B?bzBTaUliaTgvK2M4bVVESk0xUUtqTi83ZWVPRnl5Q3loMHc1U1p2R21wTzhr?=
 =?utf-8?B?YUhlWG01R1hCdzZSNFlwUWtEaXh6M2IrajB5Z2k0ZHl2eWVQalZPblB0YkF3?=
 =?utf-8?B?eFpxWUVQZXdDb0t2L1FQeVZUL0RPRGUwUE1pMWtJaWwyRTM1U0ZNQXBDNjZs?=
 =?utf-8?B?SXpwd3NKcnFPc1JmVE1MNVV1Z0dIdVlHdzF6R08vSlB3alRROUpnZFlwM3d3?=
 =?utf-8?B?QWpLb00wekhyY1d3ZnU0N2pmSUlkZHp4dWkyTjZheDZEUXdOSFBTdXF3ZFZO?=
 =?utf-8?B?K2VxNmJvRmJ5STQ5ZlB6cm5tNHl6VmV6WTBYUTNmU25EdG1xU0JwQTRhWUJE?=
 =?utf-8?B?WEt1Q2hnREQ5bzcrczBEeUxkRExKbVJwNXRoT25qSTRsZ1VoNDJ0UVZkUUVY?=
 =?utf-8?Q?cmQpOL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <812BFC05848F7241BC587FBD0A9F25CF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563d901c-ca36-4eaf-eb2f-08da0b0acbca
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 07:17:02.2060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ynplhcH/Nm+XI7fFEpJKNsQO19kwagrrYq9x90IYYiCeaW9cNwd3j/Ti+I+l3SA5P5Hr0d8bkS6LAWHscSPnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1725
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNy8yMiAxODozMCwgQ29saW4gSWFuIEtpbmcgd3JvdGU6DQo+IFRoZSBsZWZ0IHNoaWZ0
IGlzIGZvbGxvd2VkIGJ5IGEgcmUtYXNzaWdubWVudCBiYWNrIHRvIGNjX2NzcywNCj4gdGhlIGFz
c2lnbm1lbnQgaXMgcmVkdW5kYW50LiBGaXggdGhpcyBieSByZXBsYWNpbmcgdGhlIDw8PQ0KPiBv
cGVyYXRvciB3aXRoIDw8IGluc3RlYWQuDQo+IA0KPiBDbGVhbnMgdXAgY2xhbmcgc2NhbiBidWls
ZCB3YXJuaW5nOg0KPiBkcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYzoxMTI0OjEwOiB3YXJuaW5n
OiBBbHRob3VnaCB0aGUgdmFsdWUNCj4gc3RvcmVkIHRvICdjY19jc3MnIGlzIHVzZWQgaW4gdGhl
IGVuY2xvc2luZyBleHByZXNzaW9uLCB0aGUNCj4gdmFsdWUgaXMgbmV2ZXIgYWN0dWFsbHkgcmVh
ZCBmcm9tICdjY19jc3MnIFtkZWFkY29kZS5EZWFkU3RvcmVzXQ0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmkua2luZ0BnbWFpbC5jb20+DQo+DQoNClRoYW5rcywg
bG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCi1jaw0KDQoNCg==
