Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6273E4DA8A1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353340AbiCPCw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbiCPCw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:52:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D0151E61;
        Tue, 15 Mar 2022 19:51:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0geJTLwmEBvmqMN+KndYoDCebs41j81G/79lUfhDYMVX+NKGxvWi6H/CYDnb1A29pgrOVSSdkW/dKd6rmFwIgNAuUeBJp2RZe4WhTgc7b03d3bFJ15tO0J+Ek8YEu4PSVQcHorlH7gbjObtwain9VR4gp7CX27+SZydLDWvEHu2Yt0C2jLGdNux1exR5rITCD4mBcLOcOwdc3pe5zvxJsAvbNaRrOCpzvpiG2Yab87Ro+jo7aiDlpJpcY3PFw8kg8sOFd2OUmqmgHoU8axmLJj/qdgTBkn/fgNWEF4KqvGNDp0JjDBFCSSQWW8cteDb84zP5+eyn6wsj5UBdebWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2i94bk29fSuS4BJYWOpwZbv5SSinm3ZMdCKRk/O4oc=;
 b=jH/NSQta98y0aR/4L0OCEyTH9TqPT1VLXontO46NGQKReKLYuikORbc2N3OvLovTk7BL0AJ/8u1XYq2nbXBS1Is2KlH4Lu1pV6IUwBIVD/anNOjeUQ9YK92rXoMONXrXPegldV85Aopc2/++eBD+RU8++BLLRcsg29pRVWO0ZATcJQRAZE9tk17KAjzOzvJzK01WH2VYJKkAdKBgxV0pNuCIxPxEZHJYJgqTXYV35wZUtzpn3nyMgW5ZUUtHga0d+8QHJ7/0q3l14u9/5/e2LhIMCLSfP+oOGJEAO08SeVREL+McZNMmVHWZ5RYza3S0mtQhHRRyy2w1E8VFCF7g+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2i94bk29fSuS4BJYWOpwZbv5SSinm3ZMdCKRk/O4oc=;
 b=DrNuMknmESwttlbDeQRhtJ90lqGccS3lB17+TfZ2Wcr3ac3bzkGC3GD8fddGDr1QYsmAVUCZEsXXw2kfrTskTd8XqVj5WBLepJvstWqxHeWAvMxCT4Vwf/Bh4QCAPcc79hmIuyfP9WSfUnPibtRB0i/O/kfH9taMyOfxnVLTtdEpOX/Few/4W1yhzvRpBmxg5FeQkdReLA4j9DQ2Fl1TsBKy2M17aQD1GfKeqQ3l+FK/FMtUK3zxI3IUI2BU0tGFlx3DP6IBbxH/nR+W32QLAjJ4wUrkwmPzQwt/Y2sGtfSqbD0yqm7WaNtHU9JfwSxVgbPD+elIfdiNTZMD2mL/aA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BL0PR12MB5555.namprd12.prod.outlook.com (2603:10b6:208:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Wed, 16 Mar
 2022 02:51:42 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::f8dd:8669:b6e0:8433]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::f8dd:8669:b6e0:8433%4]) with mapi id 15.20.5061.026; Wed, 16 Mar 2022
 02:51:42 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] block/bfq-iosched: Fix spelling mistake "tenative"
 -> "tentative"
Thread-Topic: [PATCH][next] block/bfq-iosched: Fix spelling mistake "tenative"
 -> "tentative"
Thread-Index: AQHYOLo6uX/Kio0aP0qj3aYfRMDHMKzBUBMA
Date:   Wed, 16 Mar 2022 02:51:42 +0000
Message-ID: <c1bd442e-b926-4b06-cb0c-ada5fc457fd7@nvidia.com>
References: <20220315221539.2959167-1-colin.i.king@gmail.com>
In-Reply-To: <20220315221539.2959167-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1e68302-af70-4f30-a155-08da06f7e6bb
x-ms-traffictypediagnostic: BL0PR12MB5555:EE_
x-microsoft-antispam-prvs: <BL0PR12MB55554B5B5AF30CD25282C85BA3119@BL0PR12MB5555.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1qZzLMT9i5dCJ7ArrEfJCLYoZUVuLz/7j/7dctwoXDvwiqdM/a7d8AVvTHHtaaen5AUziilzaLPfScB78wx5VbFKW6ni+dN7HI7zxLv8nKsa96N2wqEACinIBsmOrvmzsI3YdZ5Ij5xSXMnTlF8ZnTdIi6F+MluHbEejMk0l6sotjKjFyISu7clGp10VsOPg4/pBCkdZlG3W1nHM9Lxl3brZQR4YJ7jfE+XlGU+PdptaHaZDvLAams2PO0krXAs5Oz5XIratGZ5sqVnQohkPQ9unyn+VHBe57nbWA1vm2jKvq7Am/XuJbQVCHgaNxmXNIleuqt5d37988U3DQ27dorYDDs1VRFDIU7Vrg8EIKzYHKZMa4m9tN3QvvgHbxFWFbZt61WaqVuW+b2B9CRGmAiyQsrlLhxRrvArPeNiipLrhv7Awq6i80pKNBofk6qNthpSB09WJC09g6wHPpirRKtUnj8Lje7u6TLgZNbBvxE7iUgqfbVuLlLjf0In4Jwt/LmffCxtsXLeuybHjH6Pf6Nie/Ioif87OfzNca5BxdN1KQFNO628KOZiCheLuxYepeqp3QpQ7f/BQE3mEb1ZaIVZBZAzxbjRYpNVmctRHSQLI95KcUuwzEdzqTMoyorQVgFgJ18iCz7FZmRjaGPh7Fsw/dpmR7p+BiuMkhtxzRk717DZlAge2kkeDyx47KKMPu54J7A/qllWYT3R4rgFdKpgRgPQTZG6mxIaq2KQFTpRB58AE6D+vlnpnQlVqigPn9W1194SHkrK2NogZ9A466w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(122000001)(2616005)(558084003)(6506007)(8936002)(5660300002)(53546011)(6512007)(86362001)(31696002)(186003)(83380400001)(31686004)(66946007)(54906003)(110136005)(66446008)(66476007)(316002)(66556008)(64756008)(91956017)(76116006)(6486002)(36756003)(8676002)(38070700005)(4326008)(508600001)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U090ZDJsQ3NzT1RIUmw5c2xzS2hYdHY0TE5ML1dZeWZiV2UxYzdOeWJ3SEJo?=
 =?utf-8?B?cEo1aTVKbTQzUzJ6WGU3a2c3SVA1a2NhTzhkNnNCVDlCQUhpKy9KQjBudjM0?=
 =?utf-8?B?TXI1NTJoVHZKY2hCa2hna0wrZ2JpNGEwSGhnT3dCamFpc0JRU0R5Z1pkSFdz?=
 =?utf-8?B?blpMTWd3clY1VC92RVlpb1pET0FQdGY2aWJOMUs2NzNvakpUV1kvRW9qdHZW?=
 =?utf-8?B?RXhIUUhtc0JIWEFWL3h0Z0k5dGNMYVRyNHoybXM2Z0xyWVBYeE1LMWxvSnhi?=
 =?utf-8?B?aUlqMHYzVmliSUwzeDNnY1FJQ0ozN0h0M3BDWk8wTWxndTZkRnMvczdaN2FT?=
 =?utf-8?B?R0EwUDVQbUJZbklMdXRmenliRmo4UnhuQ29KUDNLNEFYa1VIUWU0Y0RBS0FV?=
 =?utf-8?B?eGFMdEZJbDdzaGEzS2JXY3dGYWpibXh3bk1tZ3BqbmhETDV1VVNzS1V0cFFP?=
 =?utf-8?B?R1lSMGdOcVc1K3VlZnV2Z0djeFNHWGhXdnEwTHNKM2J6YnVoT3laVWs5ZU1H?=
 =?utf-8?B?V1Bmdm1mRVprMDJVQ05Ba1RpUXhVeitjcE5KN00vR2JWRFZaZlpJeENZS092?=
 =?utf-8?B?bWN1KytzNDFQM1Rld0NlQi82clYrTG1taytQckZQaDg4QmJmaWYydnd4TjJw?=
 =?utf-8?B?TG5RYTFpNUVYTmN3OTdyMHA0RjJ0VE1xQnF0WGpaWStDMUpESXQ4bFlDV0Fm?=
 =?utf-8?B?MXp0Z2R3cXBSaFdvTmZpbE8xcDc0V0VJNWdNU0VoYlArWW5oeTVGMGI5ckZ6?=
 =?utf-8?B?ejRJZDMzNFQzWEY0ZGJmTjB6N1FMMXBrRkUxMGJraitHUkl3cEZENlhsUEpD?=
 =?utf-8?B?SXpMZ1ZDcnUwOFR1LzFMVW1Zbzh3NWo1di9tWG15S25nRC84T0JYRUc2V2o1?=
 =?utf-8?B?ZE8xZnRBZWdWNTI4N2w4UXQwUEJsMm1BbE1JTHZqZ0pOUDdla0t5d2d3NUlI?=
 =?utf-8?B?MlJZRG9zNy90c2tWY05TTGF6MjljSXlGS2tuTHp5SG9wb1dGd0hKWjFvQ0RY?=
 =?utf-8?B?U3k1RCtLTWdGcXk0YTNTYXBFZ05ldzFRM3kwSTI4anlVcStvK3FtNXNaSmo4?=
 =?utf-8?B?NCtCWU5jTTZVVzNqdUUzU2loTHdBd3VXOGNmUE1DSkZYR2xJcnp1c01ES1l5?=
 =?utf-8?B?cnhKMXNaV3BJaUV3QlB5dzBNNHF2NzAvcSs4Q0laQVV5eUFXY2UrZmlNOUY0?=
 =?utf-8?B?SnBRT0pTaFY1S0lDNm8rYlFHaDZ1bVpvcEoxSEI4dFJJMG5hVGJxcld3Wmgr?=
 =?utf-8?B?WVVFTEpJMWl6a1h1N1VtY285MVNaR3ZZdXRkSUhpdWJJNU94UzVzbU1TNWJH?=
 =?utf-8?B?SCtsQ3hEZHZucnZlTDBQaFozejRUeU8wSEorZnhydWlYUjZqZW82VGpjMzl2?=
 =?utf-8?B?UWU2c0d4Y2VRRldzdEJlckNsSElRY1VyMGpJUjlOWUUzUloxWXRFeVZ1b29S?=
 =?utf-8?B?dVNFM0xWVCs0SGVRMEY2VkY5NnJ5MUdSZnkwS2tlc0RlWmZUc0lkRHNSbTJp?=
 =?utf-8?B?NlA3eHR0MFFQQkVXRjFZYStzbHRIZ0RpZzBkazNsenpsYW16N28ycjQyRE5m?=
 =?utf-8?B?ZmlHNVVvM1dUODhuQnZUZjhBRDcrMzVSMG9ZVGNjcTB5THNjZjNhVHNYNG0w?=
 =?utf-8?B?bkV0MndGTDhZcWlyWXZFV0tZNkJ3cGpJNU9XVklXOGlOY08vWE1jU3NYQ1Jh?=
 =?utf-8?B?UllGL3ZFbnlNUnp5SzlRN0RCZmJJSFpFc1NmR2d2RzQ2L1laOElWdnpXNVBY?=
 =?utf-8?B?Z0t2d3hLaTE1OWMvelQ4WVo3bzF1Vmp3UWFwVmNEQ2c0aFNmTllzMisrTkNF?=
 =?utf-8?B?cWVjV2tTNGwzbEQvSTFDYlBjanRrK0JoQklJQ3BGQWMyRGp6OHZPR1c2UFFU?=
 =?utf-8?B?bXd6YXJLQ3lvZzlrUUVnVGhKMTRYa2RYVDQvY1hWNWFoWlBucnZOdGs3clVF?=
 =?utf-8?B?VUlIeEluOUZRbERHZlVWYmtuQXZVU2RSbHhhV2NLeVE0ZzF3Zkp6MHlwRmNv?=
 =?utf-8?B?dlA3b1lSSUIvelFWMElJZEluOFVUdUI5a0FiRUVIL3BvRWt3UmkxSktVMm9j?=
 =?utf-8?Q?Ji8gW2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86952F7ED30444439E460658C8047B11@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e68302-af70-4f30-a155-08da06f7e6bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 02:51:42.3154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSz55iGPbFY1O4EXuaxcgB77b7gLodHCYgmR6SJJ61D0LpdbuDzd0jwpzeOFigvqsEzetsYYNJ03ZWjmd8SHeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5555
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNS8yMiAxNToxNSwgQ29saW4gSWFuIEtpbmcgd3JvdGU6DQo+IFRoZXJlIGlzIGEgc3Bl
bGxpbmcgbWlzdGFrZSBpbiBhIGJmcV9sb2dfYmZxcSBtZXNzYWdlLiBGaXggaXQuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT4NCj4g
LS0tDQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8
a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
