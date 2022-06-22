Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269035547FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiFVInG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiFVInB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:43:01 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AE327159
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:43:00 -0700 (PDT)
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AA62B4671B;
        Wed, 22 Jun 2022 08:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1655887380; bh=nLPWychPYakiU4J3CSBFhqKKqFNGddVBjHbgzj+dnas=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OTbXssesooeeCIFKx/Zr3FYuP2eLd+NzaYNFZHVXyqOAkG2fL15qpt/e/N1MLnObd
         /oCy4o9QcZPOfnhe8kibVofwxokClTixxhIg5vkfv1YcYhetj0zAuygIdZW825WnQ7
         SVbSccblnU50K4pXXn/62lMQ5HTVs6ApAlZHksDf0ha6zNa+fxtnWOxJ/bTv0tVdB3
         cPkNk9QRuoEITL3WC58DAzB5aRTO16ntt7SALdpEw9ZL8uovHZEwXhGl+wBjsKnN0x
         6ahDNLXGvWGLt/IaFdlxB0HtrgxzF6ApXtAr7r3y4Gfzu/gpCjIv0dDPDiLg+q84K/
         0HZHLN6suWzwg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 486CBA0077;
        Wed, 22 Jun 2022 08:42:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3DCAF4008B;
        Wed, 22 Jun 2022 08:42:54 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=shahab@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="a2KneZUN";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTFgJkLwwhj2v7goc9S49OK7K1EKydLhsnhChMTibMd1IuIB3aHk+ORxplChLjqtlEZSNBQNJqKjGl8VBM0QFVEvmubWQQ+3oHB3nDayjt+OhuSPAz+KT8IoeBAJsYrXegxAqHklzV7eM+47LAbjym23Xy+mCrOU8zsAkOjAP+GDWLqH7Cnnd9GOZ+AscWx7lm9Bv1W6Wz2ncqbFF41HSUnWnRiwAN4f2Fgrnpt4SgciTNb9XqEVKQOdWuASLjcstCFMGneSq2fG5A8Hn/mJqyPUNNQkpDGoAxJNCcTWdx+A/DYeiSQF2WRuoV6swg2HvqEQZt4zw/M2nzDKqAcS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLPWychPYakiU4J3CSBFhqKKqFNGddVBjHbgzj+dnas=;
 b=MmACHeCrDzHjDNjRo3qTf27/jaXzz3mXRQcS0RIPb335TZU2mu2OHgv45rOlNsUMGAshHB7mfWBWaRx+TZcwb9V4Reh3X5FtjIBNwBGZoUHolsf3ZSa93yJsLXt2xd/oOnJ3PwPLL+9yJ7qyGc+5XXt2UjRwMxHE0uXhe8XAlfTttYczkcMwDPQrrITD3fNx1g29EoeK1255ToPPNVz4jo1qi3BPHR7FbtD5k7rrA3qrj2PXAoVcf3KkBi67mhPHcI+2V99WkuAaVJ6lf2x+TE6QVQTqdc3+eUVV5DhHgVzAdKvbo4PlUWCxbBJgGSkbTkO+/zaSB4xdfzSb/7emzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLPWychPYakiU4J3CSBFhqKKqFNGddVBjHbgzj+dnas=;
 b=a2KneZUNRdgbEDH1AuhvwpSsiWqpE9LxFgC5UMB7AX9ZXL1sjEL09UWjWlRs2weohCzccvAlBJ8uE1BZE7sRzbSqlxceSgg6yIBNVTa4C3eB8mVoewChQTu6SxMGhPNrkoPdhKKSc65bL+Y2J+cOnPAFWAFWY8CQQ/8jwqgf5m4=
Received: from SN6PR12MB2782.namprd12.prod.outlook.com (2603:10b6:805:73::19)
 by DM6PR12MB3979.namprd12.prod.outlook.com (2603:10b6:5:1cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 22 Jun
 2022 08:42:52 +0000
Received: from SN6PR12MB2782.namprd12.prod.outlook.com
 ([fe80::8531:7f90:c11f:2fb4]) by SN6PR12MB2782.namprd12.prod.outlook.com
 ([fe80::8531:7f90:c11f:2fb4%7]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 08:42:51 +0000
X-SNPS-Relay: synopsys.com
From:   Shahab Vahedi <Shahab.Vahedi@synopsys.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>
CC:     "vgupta@kernel.org" <vgupta@kernel.org>,
        "Julia.Lawall@inria.fr" <Julia.Lawall@inria.fr>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC:mm:Fix syntax errors in comments
Thread-Topic: [PATCH] ARC:mm:Fix syntax errors in comments
Thread-Index: AQHYhg7kChJoJXHknkW9YJewO4LLpa1bGGmAgAADmgA=
Date:   Wed, 22 Jun 2022 08:42:51 +0000
Message-ID: <4cef89c9-3b27-11e8-2971-66b93b847ede@synopsys.com>
References: <20220622080423.41570-1-yuanjilin@cdjrlc.com>
 <YrLTCXLrr3HB39lv@debian.me>
In-Reply-To: <YrLTCXLrr3HB39lv@debian.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff75043b-b2f5-45a5-352e-08da542b3179
x-ms-traffictypediagnostic: DM6PR12MB3979:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3979D5E4F79FBD052C81EDABA6B29@DM6PR12MB3979.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9oIcr8ME5k54FK+MB/RHkiNrAed5h/tp/B6UWQpSbpVD/2dkUU6N67P2PhnZo9csPklzlJJ5wa5rlZvc0O+RXvqq7UeXfca6Ja3bW2JYVBz5FAO4pyWUWl7FstYoajrsEU5O3LTwcfmKmCUaqOFoc40C2g+t6erpT0DnTpX1merI/vBl69tDUt0KLplPDVp3SXlAtapTigeaNnIwemm04RYZKTVjXBdawt9mLvaAQ+q/KXOSLfKRhHhE82gR8Bv6LP8lNky5my40abA6aEfgU1oMOPop6G3UtBrT+F74NW9/E5ADjAWNIV4yivW0r0qVeqf9FP5CERQWgjO5/u52DFEoz3G263fG8GorT19mss2vQ0+gCjevGq34HXN2XGhgI0lW4PxfC4AgV98fpqJt4yiAA54tuLsgWyQWbdnV45FW3ZGk8XUADMqsERbelvAaJaar9bqFRrCkcc5ePMFK9rwl8/QVwpuyXC93zqUtj1agS/G+tv5njWaj1yZ8rpvgdjY79lFcsp05svI/oZXiPWqQ4mE+ajIUBRVyS3X7+gq4F4KXKdAwpiu+ytZVQt1P3b2eN8Sndlm5cud+NjdW+amTiKquuzDBCAl3/MlNcRgjCPRanPUiAES3Az9qfdYwbZPSXKLjHBsKSCxKCgz1eONJL7DOEkR/EuwwagdAQvcDJdAYrttisMxvj5YJLjZ+luGcOpp5PfQ+I04QGMSXxp+iM4uM95PiZ4yftqvQ5tIGoB6v0w20IquEaWlK6mWt7kvQOCLDqGQxAEQa0zy5OH3i+KnXrLx+ruauue9jFY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2782.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(366004)(136003)(346002)(91956017)(36756003)(66946007)(31696002)(66556008)(8676002)(558084003)(4326008)(38070700005)(2906002)(66446008)(316002)(6486002)(64756008)(110136005)(71200400001)(478600001)(8936002)(186003)(66476007)(31686004)(41300700001)(6512007)(76116006)(38100700002)(5660300002)(6506007)(54906003)(86362001)(2616005)(26005)(122000001)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEZaN3ExNnRLbEFBbWhiKzNkV0RkVjR4ZEhUb0ErR2dMS3B6OXNNSzhJU0Ji?=
 =?utf-8?B?MGU0RG5NNjNMd21zMG42RW15S3Z4V0NXczl6cVRDL1NjTVU4cTVocCt0eUtW?=
 =?utf-8?B?YkgvMWF1cDZ6YnJFYUEvQnFtaGVKVDBPSU1MR0FDK3BkcTN4a09VUFlPb1ov?=
 =?utf-8?B?ZWU4L2tDZHNHZWFueDJTbGZlcXBrQUFNWTdxckE3OURPb3dEdDcraHZYRkl3?=
 =?utf-8?B?bG5laXdwV1Z2ZWF4MmQ4K3V6SVZ6NUp6TzYxNEFSRVB6d0paNVRZQTJEL2Zy?=
 =?utf-8?B?ZUIrVHJSUnlmTnFaUlUwL24rbzFDbmlkRFFwMitkNVp3OXdsZFQ5OWFlN1lv?=
 =?utf-8?B?amszZUxXazRxSEl1MFkzV1BCdlVhb0JUemhSMncza2RUQm5OK1doQVMvV0xN?=
 =?utf-8?B?ZjFxUUI2SWx2VnV0bmhiM21md2VhL3dncllEUExIVXo4MkU4OHpvSnVXb2JL?=
 =?utf-8?B?V2UwMlRuclZMOUl5TUlLY0VnU0VRU1FQVm1ZdENKMnZyOTNtQTZNeFNNVTRY?=
 =?utf-8?B?U2lyaHdnRENpcE1pR3Zub0lkcytRcTZmMWQzNlEwdzBBQ2ROamsxU083L2FT?=
 =?utf-8?B?bXV5MGRVeC84VG1scDVjNHBneHdSZTB3d09TOS9JOEYxU1Nld1JoSHdsWGox?=
 =?utf-8?B?RGFzWThRMDE5TlA4WGdScGxxUjNEQmZBMmFrNmRjaS9JUDUyaWFqOEJ6RVgz?=
 =?utf-8?B?ZWZRNFM5bFBsNW1GYXNOdW94Tlk5U1pvakdnd3h5WHVWQ3JQQVlpekd6ZU1U?=
 =?utf-8?B?RDdwSW9rT1B3dHEyVklhV3U1VEZrdFlSdGJYbHU3RHFxR0ZOL2dOR1kzR2Jn?=
 =?utf-8?B?VDVlaURTb3RPMWtuSERiYWNBMmFSMGNNTS9RbTI1WWF3SDhCeXZ6RlBjeTRN?=
 =?utf-8?B?b2wwZmNrVWdtdkFlaXNDMTlBSzNPSmlsQ2hrVUdaalAyVUZVU2sza0lQc3J3?=
 =?utf-8?B?SzZMWjNXZDAwUFYrbG9BZG8vU2YyMVVSUXU2ZmZjN09xMSs4eXZBZUhzcUdM?=
 =?utf-8?B?ZUpNdlBWNUhDdlc0bE82RGZMb3Jmd0pzQlBQeEloM1BvazRsYmhFc2Rqc21k?=
 =?utf-8?B?SVJ4QjJuWnd3ZFQ5VkhOYkxUZ3pkWFRvdE92K1dKZURJWCt3aWc5MmpCaHh6?=
 =?utf-8?B?VjFIbXNRR0Y1SnBXVTROTWdFdEM3NmNDcDdWZ1Izb3VsVXRzcStUR3h2NDA1?=
 =?utf-8?B?UXB0cTN4SWhNQWlJbkxLM2lSMTYrU0UrR0oyckhhN0dSSFV1czhtelgxSnVG?=
 =?utf-8?B?SkEvL1l2T0FPYzlYMXVlOGxWNFJ4UGMwNmdDQUdvY0FlME1sQlpMQ1ltRjU4?=
 =?utf-8?B?cXI3ZWRjTVI0cE1tM1JPVFV4eWJEdjlWUlFqRUxWVm9OYm81OGZmc1RUSFQx?=
 =?utf-8?B?bndIdGVKRHo2V2pKOVFodFdjcWQzczBONktaNnJWS2Ftb0R1R0ZsTkpSeFJw?=
 =?utf-8?B?L1QvUzdyempLZzdFZEg5TE5zem9PaGQ1L3FpTDVMOEFHRi9FZVI3c1g5R3Va?=
 =?utf-8?B?NDBMUGhvNDlBSFc3WUJxVGZuL3JhT0xHR0JGdkJIUDczQ0JXNjFjV3orZVFr?=
 =?utf-8?B?NVMxWmhCelJIWW9lN3ZFbk5mWG1EazBkY0wwZms2NHhYVGtJejNOeE4ybFdF?=
 =?utf-8?B?ODQvcmx5RU1YUVZpaEw5WEdnYjdIcjlmdFpycUhoR2lHTnRRRlkvM2UzK3BW?=
 =?utf-8?B?eXBEWUtpdUYyVXBxQzBmVGZLcHJ5UlFBVFpsbkhMMTN6S1Q5L3V5cGVza29j?=
 =?utf-8?B?NXVpczVVTnVLVUtpRHhVcGgzTlorc0JqQ0YzZlB2V1lsa3BUYVh5b2FMajRX?=
 =?utf-8?B?R0crMTgxbzN1VXVVRUxPbTNVeWp6aUJOUEZCSWUyenpPWGpiVzROay8vczhw?=
 =?utf-8?B?d1I5K2tJRHpjUURQSGcyWnZFYzJQclVMalNxbzNhbTd5STkvUzRNdVJuZVl0?=
 =?utf-8?B?cS9Pc2oybVJzNGgzdzMyZnFsT3F4UTljQmlUcnFneFNBczNyTUVWWGluN3gr?=
 =?utf-8?B?ZmdxYWx6VWJ3cXpSUlM3Y01tUlgyb2VxR0xmV2phOUw4emtzSE9FOTdnWHd4?=
 =?utf-8?B?a0ZJOENxTHpLYzB6Tk9vOW1lRDJjb0kxODBtTFNub1pJelM2aThkUTJ5RFcy?=
 =?utf-8?B?cG9US2VwOGtGdHhGSjZrS2g0V2pzdjBORURYVTFzL2JWcTNWSkpkSjFwSEha?=
 =?utf-8?B?NzZHZTlqYzRoNlZnNHBOcmJoVTdZKzQ0TU13cXFhT2JLV2NBanhIeXVqOWpF?=
 =?utf-8?B?OUtlQ3k5QktDOXNHeHFpTXBwNVNpUmhOZkcraXArRm1mZW1FWHFqUnJZKzVS?=
 =?utf-8?B?U2pHVzdVdXRqcW9OeXN2aUt4MlU2dHUxKzhJU0tOcE16RUkxTjRyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DA5118B0E47B14A895BB829A27C9A54@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2782.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff75043b-b2f5-45a5-352e-08da542b3179
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 08:42:51.6075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YE4DNvoMY/eYlgOA6DR9CHheSgkYn391u66317Us6cDJZhkHNRkK707iGLc6zpNxyCLir1wYr8N2lwXtWFThDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3979
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yMi8yMiAxMDozMCwgQmFnYXMgU2FuamF5YSB3cm90ZToNCg0KPiBJIHRoaW5rIHRoYXQg
dGhpcyBraW5kIG9mIGNsZWFudXAgcGF0Y2hlcyAodHlwb2ZpeGVzKSBhcmUgYmVzdCBkb25lDQo+
IGFzIHBhcnQgb2YgKiphY3R1YWwqKiB3b3JrIG9uIHRoZSBjb2RlIGluIHF1ZXN0aW9uIChmb3Ig
ZXhhbXBsZQ0KPiByZWZhY3RvcmluZyBvciBmaXhpbmcgYnVpbGQgZXJyb3JzKS4NCg0KQW1lbiEN
Cg0KLS0gDQpTaGFoYWINCg==
