Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E954C0687
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbiBWA7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbiBWA73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:59:29 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1802D33A2B;
        Tue, 22 Feb 2022 16:59:03 -0800 (PST)
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 846344221B;
        Wed, 23 Feb 2022 00:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1645577942; bh=sxfE0WYI3dcpW939fnmlIVvHQtB066cvMkOjoyth1do=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MD/2qnGRWCbCoaHDxu1JW3Y3IPlItWKgvLJurlT2AKE1CsNAOgGPegr8ELviRCO3X
         C1FwXB5OojIs4YIvCWwLRsXdZQS6UZNK+lUN3Mr/cP5YKuqmL3LfBDCyZp0K2DU52z
         qJM9Of0H0RALIafLRrFKwK1qVa6Szg68wMd5QMgy9Qa8bjUJlZg7njJAOpWV+CWZjP
         vyJjkNs0Qvsbwor9zR5Y1IQKMtNxRFEYgAodPS8UOAzm4xUzhkdZc66eY2ljvn63KL
         jyeUbvqMok2xSisN4H0H4kJDKp086gZpIDGT8i4N5XMBNwKsSnj1WG0KD5/d3xfgwq
         qB94nRShneZdQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id DC030A0068;
        Wed, 23 Feb 2022 00:59:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 58FED40D48;
        Wed, 23 Feb 2022 00:59:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="vb9r1qNw";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcH3CkxsdiFXPKqoikCAWqvKlhHlJirM2aaveM8GFsrc9BqCpiC6ICCOU0XjNfw6xRrgHuXXGhdpoWDcn3Bv/BylMq/udUqSTga0JUKJxcgCgeljebF1LrOVb9/QLKjUsh9hF2Ms9V5W7+fsE8T9sqyl2/v/VGcYhtp57y85fvGnvYHtKaH7gYJZGJwHqiNix3/kiQnF1wRtAvXcQHl4EF3w0LLuPincVZ6HHOoA8GOU5tnxQXk7fd+wvNG1nT/bTu+GMFeov8CccPSjBXGihyhC4Yl3MdDUefmYV4Gi53zZ+wzTsTaEkhGYeYbd2vkFE6f2L+9+bPntKmm72lucEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxfE0WYI3dcpW939fnmlIVvHQtB066cvMkOjoyth1do=;
 b=XgukhWa9nLfK7C5jVDbAPurd+QdGhZNa6RJOi5j77uxdi1/aPWoKFOpjXtPuLFVk0u2K+qtwFhVGh6TkcSH+DgChOu4J7OtbUx7hoGqMXCNqGJygQ7RgKoQT441a50AP5W3nx9lsdyLPmA131C8FSBulm5ISKukGEcLDMDyi7JvnFYAVpT1sD03oOQF7jL0+3z+4V1HxZkbxhl3+61L4n55SPglzGpln5X7fH8fvrfCN1zAhSxzj3FR/vYvubbLF+fQQcYJMmPnwI+JlOBgDuUw5MN1UnSb4ltCDBnfsoF2nYIDXgkjZIczmamuw/qXn4nohwx99qRKkPo8wnqE8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxfE0WYI3dcpW939fnmlIVvHQtB066cvMkOjoyth1do=;
 b=vb9r1qNwsK6RvIHGKM+a7CLdN8rPH+Fsmqw5PvxQDn4Da2ToFPEY1tyVdzDwwWD7S0xbhn4MdxvPvlDlnUZKZcC4ADtMAIVkRrWWRhmfR+seZmaw6Mxw0QBJSM3rkZA5ErzhJmBMdDShZz6Fhg8VPcXKajh3W9DY40LV5y2P6dE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB3907.namprd12.prod.outlook.com (2603:10b6:a03:1ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Wed, 23 Feb
 2022 00:58:50 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 00:58:50 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v2] usb: dwc3: Don't switch OTG -> peripheral if extcon is
 present
Thread-Topic: [PATCH v2] usb: dwc3: Don't switch OTG -> peripheral if extcon
 is present
Thread-Index: AQHYJ1glEUWyK4idVUuF0ZVajlRNyqygUlkA
Date:   Wed, 23 Feb 2022 00:58:50 +0000
Message-ID: <b5a2bc30-f017-980e-83ce-f654ca6ae2a0@synopsys.com>
References: <20220221192020.346622-1-andrew.smirnov@gmail.com>
In-Reply-To: <20220221192020.346622-1-andrew.smirnov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fb61e99-3a65-43c0-eaca-08d9f667a7ea
x-ms-traffictypediagnostic: BY5PR12MB3907:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3907E708734C3D4B84ED5C08AA3C9@BY5PR12MB3907.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ovxD6ZUmyLcyyFNAaavrEMtUYyeD8V04+k2vJtar6wWsRWtH6JQkLPOE3we491qXNeMPexEyRASE+zMLxypZdloXMgDN7KKH46qDXfCvN6rU+JCRPwVIJ2SKMUnPwkTUjclQ7725YTIs3ejGVeZIUg1WcaTFigRvNrcnvNjztuBHP4OgU07R7DXlwYFwy8buEJPq4+oD/6ZdiizdNyIEQrbJg3eLZ+MasR0W/hdezEK3tn2ErW0HHTAbjGYbzYTV0iIvKDnbkDycoEuOPg39Oi0e4Mj0CPvipmjbii8ec1MVCHXC90smMt51cgmP4CqcsmroUNuWYV6NqGhv8RpH131qwCZG6lxkV9zQV7VuIiWiH4IrBsVFFBPHmBAMDub9HcBbWlAP35HFongOdDWQ6q6gDNS1RYQhfYKVr9eii25AaVRkp4AB0ccL+kkDc1+CwEue8IBx01aLoLE7zoc1Qarm10vZNAc//GxicwaN0DQfczhPndj61Gozf3Cb++c8F6zDSDFhI6Oaul1acvEd4EgPByZSLHbCFXrlBehd8M5vc/e6GRzKEwraHQAhb4rWg4+x8xSDxf4EXeWnVZr99yHDQMn+FP4bRpM/4DRv+IGBkmXFRQO8CnE8NyVyUEBQGjL2dl9HopbMsahWPH7/Cfd+xYMl4ik6Z2Gci2kgkQRIBVs+hk13tjbW7aBAj/XW1rnuIy5Z/tUT5MfQ0jZCPRKxbvEn0gL/Coq3w9LeRMehfsaZ4dIo/uO06j/BpqZai7DCBPDr5DQDjuX05SwXFbIZK6VhrABg4SlgF2As87FyaiGZvoALG9eAJ7aLp7x4smLfLp0S+MtPOErO/y4PYAiBUnsahEyXuUNKuN3Sl/vEbCZOKL2Bw6O3EanyEpZVNkwQXP6Xq0E63EkPJsZabQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(5660300002)(38100700002)(8676002)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(122000001)(83380400001)(38070700005)(186003)(86362001)(2906002)(8936002)(54906003)(6506007)(6512007)(31686004)(110136005)(31696002)(2616005)(107886003)(316002)(36756003)(966005)(6486002)(508600001)(71200400001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDVLQXY4a3ZybXpld0tNcENpVCtiK2I0N3VCek10TWFQZUIyb0lvVUt2Zkx6?=
 =?utf-8?B?NTNNSkVvL3lMdjY2UUQ5WHhCVnQ1QmJLMi9VbXFTdnlsS0loaEEwSkxkWkVQ?=
 =?utf-8?B?anlTRnF4MkgzbmlHaDVTcnNaQmxuVGpHbmZhRUtJUUdHaE82ZnRjVE10QUlU?=
 =?utf-8?B?aGxRbGN3OHg2NndSZEhRL1JHdEZCQzZwMGNuNHpqa21tOS8zMEFLcGdSeWZS?=
 =?utf-8?B?TzFjS0lVUzQwekxvQ09CYkx0bE42WjYyTVhqSllrZ2dyRDA3TVpEVmJ3NTFS?=
 =?utf-8?B?Q2oxYkRsdzBGY2pzS1NhVVRPbGppcVorQnBmdHZiK1hNd2V5bzhiWFdhKzZI?=
 =?utf-8?B?Q0NaVS9IOWk5SU1YelFldStYU09ETFh0NmZNdzI3RHVVTDlxYVdvSzVDenlY?=
 =?utf-8?B?dkFELzJvR0t2M2JmTWtWbGhDQUR4Mk9zY01NMUIxNUxOUGpPMHdUZ3Z6RGRG?=
 =?utf-8?B?NE5ZM2o2clcyU1B4R2hCK0VZVEloUWJjOWs5dExySHNaZzhvcmxGSGJIWC9x?=
 =?utf-8?B?VEQrSGFaeUpIQjJCVEVLVzQ4cjNSK1RnTjdyWnBHSHIxZmI5UU5EVlB5andi?=
 =?utf-8?B?OC9kd0RMdDZ4SENGU2xuOWwrOFRVSjd0czdsaVJnOFFmTkdaVjlLZFFZc3JR?=
 =?utf-8?B?NmpuYXFhNWxDZnh4RWNrUGxsZnRLTC93TEdESXJlZ1luQytKSUdGR1hDeXJt?=
 =?utf-8?B?bHYwdTVqUVB2TEY2UzU3VWRHU3AwRlR1YzB2alBySlJ0K1pSTFVIL1ZLSFhJ?=
 =?utf-8?B?V3JpbWJGM0MyRWJxK3B3WXQxZzBCUFBCK3N2SVBOdk9jQnBaL0RsejNiV25I?=
 =?utf-8?B?ZmlTREphbUhYcS9XVmpYYVJQWHpUOGtpaWRkbWFJMzhyZENKNEFqZFJESDNM?=
 =?utf-8?B?T01WS0lUMmc3REhEZVA0NVBwZkROcUV4THJQR1hVbVU3d0hKRitieXQ3eGRx?=
 =?utf-8?B?cisvZUlhelpEWW9WWVo5ZVc4MG1PS0dHay8xemdrT1RCL0hUd2xjcWV5d2ZF?=
 =?utf-8?B?bGJzOFNFYVlCZHRDQ0V5ZlJqclErbnpnUTNlSXZSenpzREdJZXBqQlc0dkdN?=
 =?utf-8?B?eVpNKzBpN2UwTCtTbzJJdm56TXJZcTljT1RnVDdwSGZ5dTdCNkx3NnByL05v?=
 =?utf-8?B?MVlwWFpKV2R5MUl2ZUtmTm5LdERnVjRTUG82cGxnVGx1MTIyNHUyc21LKyt4?=
 =?utf-8?B?M3NQZ2MwVWlXYkd0aDFNcUx0b2xiT1o1TGZkTlVGZ29mTEF5dmJ0OXBKaUdG?=
 =?utf-8?B?WndYVjBnMUsvUi8zWGxjQmpnOFJ5Yk5pUXArUHNUTzF5d2VyVWpYczNwajZo?=
 =?utf-8?B?bjFDbVlsRlhqeWRuRWF1ZEI2ZnJiUjRGYXhaNDByQmJhSHVDOWZVQmtMZjlV?=
 =?utf-8?B?NTh0MlJHdE5yQ1VsSTM5YnhWL0NDYkhBdXRNTDVsOEo1cGJld2ErRnE1R3pz?=
 =?utf-8?B?c0pEVWMrZGlMcG8waVJTcVU0U0E0SEE3bFNCRHJ1VC9HRFEzOHVOVzZ0RHRx?=
 =?utf-8?B?c2ZxTGxjU2VVUlVTQXVzUGFvajYwTlY5Wkx5ZnZtaU9ETnhsRFVUUXVRNitB?=
 =?utf-8?B?MGEvMDRlNXhYcjJGTWo2NUErTGZSemw3MkVhbWRHM3dMWmRwN3kwMFJ1WGVr?=
 =?utf-8?B?dDFLMklHazgrVmkyclkzVk9OdGlzNmRwQVhKVGdXUm9ObEx6QlRaRGlUMWtZ?=
 =?utf-8?B?QXhuZWp5bDN3Q3Q4d1M1ZFFpSDlkNVVZTDBzRlNkZXFrdHE2TGRDYjJuN1lB?=
 =?utf-8?B?MTZCL09EbURsWk9NZFRDVmJNZXlYSE9JUmlYTjVpaUZHZEtaUklTYlVVK2R6?=
 =?utf-8?B?bUJLWk5NSjdaMHNXWTE1emdoNWIwUGdwYXEzKy9PSGlVaS96aDJlNE9BdTdr?=
 =?utf-8?B?NFNOWU1oWEF6aDFsMU9mbjJwT2dWR2NJWVlsNmtTNDE3SUxqYzZzcS9hV2NV?=
 =?utf-8?B?MTFtSGFkaSsxN0hRUk5ZYmlwdjFBTXVzNFExRDZ2ODZJN050UyswZmh4ZXI4?=
 =?utf-8?B?WGhhNFRBUU5kTFd2Nk1wZmhzMkNiMjA1bmY1cDliQXM4QXp6c2VVSjJ1bzJq?=
 =?utf-8?B?TUQ1bXQwdjNsRks1ZkQvT3oyamFFemVvMTBlRDRLODl1THRjSjArcm9VYmpN?=
 =?utf-8?B?aE1GUVQ5eGpWSHVNWVlQNU9CM1JwaG5ZUnNWK2hXSzZaZ2hyeEFXVjdKd1Jy?=
 =?utf-8?Q?N6s80WulQtZ47AbtC5MJAdU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24516A31AD7AB74DBCEE69CB350548D8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb61e99-3a65-43c0-eaca-08d9f667a7ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 00:58:50.8422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UPge57tmFY4gjfiNwdrquGTn+T4Qyfy+w4dhy/xFoi6zUdXodNbjjEbuRG1J2bJLu+/M6bltbyp9DFocMuITQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3907
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkFuZHJleSBTbWlybm92IHdyb3RlOg0KPiBJZiB0aGUgZXh0Y29uIGRldmljZSBleGlz
dHMsIGdldCB0aGUgbW9kZSBmcm9tIHRoZSBleHRjb24gZGV2aWNlLiBJZg0KPiB0aGUgY29udHJv
bGxlciBpcyBEUkQgYW5kIHRoZSBkcml2ZXIgaXMgdW5hYmxlIHRvIGRldGVybWluZSB0aGUgbW9k
ZSwNCj4gb25seSB0aGVuIGRlZmF1bHQgdGhlIGRyX21vZGUgdG8gVVNCX0RSX01PREVfUEVSSVBI
RVJBTC4NCj4gDQo+IENjOiBGZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5vcmc+DQo+IENjOiBU
aGluaCBOZ3V5ZW4gPHRoaW5obkBzeW5vcHN5cy5jb20+DQo+IENjOiBsaW51eC11c2JAdmdlci5r
ZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFJldmlld2Vk
LWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IEFuZHJleSBTbWlybm92IDxhbmRyZXcuc21pcm5vdkBnbWFpbC5jb20+DQo+IC0tLQ0K
PiANCj4gdjEgb2YgdGhlIHBhdGNoOg0KPiANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDIyMDIwNjAxNDUzMi4zNzIxMDkt
MS1hbmRyZXcuc21pcm5vdkBnbWFpbC5jb20vVC8qdV9fO0l3ISFBNEYyUjlHX3BnIU1rQzBaSnJE
dzZUWW9Ua2Q2Q2NuUjBFQm84RC11dkRscUpEUkZkYVI4MkJYLTE2ajB5ZHpHejBGSlI0ejRWUXRk
S2haJCANCj4gDQo+IHByZXZpb25zIGRpc2N1c3Npb246DQo+IA0KPiBodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzIwMjIwMTMxMTky
MTAyLjQxMTU0NzMtMS1hbmRyZXcuc21pcm5vdkBnbWFpbC5jb20vX187ISFBNEYyUjlHX3BnIU1r
QzBaSnJEdzZUWW9Ua2Q2Q2NuUjBFQm84RC11dkRscUpEUkZkYVI4MkJYLTE2ajB5ZHpHejBGSlI0
ejRTeXh2MTdEJCANCj4gDQo+IA0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCA1NiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgZHJpdmVycy91c2IvZHdj
My9kcmQuYyAgfCA1MCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKSwgNTEgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYw0KPiBpbmRleCBmMjQ0OGQwYTlkMzkuLjA5ZjI4MzI4OGNlNyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
Cj4gQEAgLTIzLDYgKzIzLDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiAgI2lu
Y2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4g
KyNpbmNsdWRlIDxsaW51eC9vZl9ncmFwaC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4N
Cj4gICNpbmNsdWRlIDxsaW51eC9waW5jdHJsL2NvbnN1bWVyLmg+DQo+ICAjaW5jbHVkZSA8bGlu
dXgvcmVzZXQuaD4NCj4gQEAgLTg0LDcgKzg1LDcgQEAgc3RhdGljIGludCBkd2MzX2dldF9kcl9t
b2RlKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJCSAqIG1vZGUuIElmIHRoZSBjb250cm9sbGVyIHN1
cHBvcnRzIERSRCBidXQgdGhlIGRyX21vZGUgaXMgbm90DQo+ICAJCSAqIHNwZWNpZmllZCBvciBz
ZXQgdG8gT1RHLCB0aGVuIHNldCB0aGUgbW9kZSB0byBwZXJpcGhlcmFsLg0KPiAgCQkgKi8NCj4g
LQkJaWYgKG1vZGUgPT0gVVNCX0RSX01PREVfT1RHICYmDQo+ICsJCWlmIChtb2RlID09IFVTQl9E
Ul9NT0RFX09URyAmJiAhZHdjLT5lZGV2ICYmDQo+ICAJCSAgICAoIUlTX0VOQUJMRUQoQ09ORklH
X1VTQl9ST0xFX1NXSVRDSCkgfHwNCj4gIAkJICAgICAhZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9v
bChkd2MtPmRldiwgInVzYi1yb2xlLXN3aXRjaCIpKSAmJg0KPiAgCQkgICAgIURXQzNfVkVSX0lT
X1BSSU9SKERXQzMsIDMzMEEpKQ0KPiBAQCAtMTQ2Miw2ICsxNDYzLDUxIEBAIHN0YXRpYyB2b2lk
IGR3YzNfY2hlY2tfcGFyYW1zKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJfQ0KPiAgfQ0KPiANCj4g
K3N0YXRpYyBzdHJ1Y3QgZXh0Y29uX2RldiAqZHdjM19nZXRfZXh0Y29uKHN0cnVjdCBkd2MzICpk
d2MpDQo+ICt7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gZHdjLT5kZXY7DQo+ICsJc3RydWN0
IGRldmljZV9ub2RlICpucF9waHk7DQo+ICsJc3RydWN0IGV4dGNvbl9kZXYgKmVkZXYgPSBOVUxM
Ow0KPiArCWNvbnN0IGNoYXIgKm5hbWU7DQo+ICsNCj4gKwlpZiAoZGV2aWNlX3Byb3BlcnR5X3Jl
YWRfYm9vbChkZXYsICJleHRjb24iKSkNCj4gKwkJcmV0dXJuIGV4dGNvbl9nZXRfZWRldl9ieV9w
aGFuZGxlKGRldiwgMCk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIERldmljZSB0cmVlIHBsYXRmb3Jt
cyBzaG91bGQgZ2V0IGV4dGNvbiB2aWEgcGhhbmRsZS4NCj4gKwkgKiBPbiBBQ1BJIHBsYXRmb3Jt
cywgd2UgZ2V0IHRoZSBuYW1lIGZyb20gYSBkZXZpY2UgcHJvcGVydHkuDQo+ICsJICogVGhpcyBk
ZXZpY2UgcHJvcGVydHkgaXMgZm9yIGtlcm5lbCBpbnRlcm5hbCB1c2Ugb25seSBhbmQNCj4gKwkg
KiBpcyBleHBlY3RlZCB0byBiZSBzZXQgYnkgdGhlIGdsdWUgY29kZS4NCj4gKwkgKi8NCj4gKwlp
ZiAoZGV2aWNlX3Byb3BlcnR5X3JlYWRfc3RyaW5nKGRldiwgImxpbnV4LGV4dGNvbi1uYW1lIiwg
Jm5hbWUpID09IDApIHsNCj4gKwkJZWRldiA9IGV4dGNvbl9nZXRfZXh0Y29uX2RldihuYW1lKTsN
Cj4gKwkJaWYgKCFlZGV2KQ0KPiArCQkJcmV0dXJuIEVSUl9QVFIoLUVQUk9CRV9ERUZFUik7DQo+
ICsNCj4gKwkJcmV0dXJuIGVkZXY7DQo+ICsJfQ0KPiArDQo+ICsJLyoNCj4gKwkgKiBUcnkgdG8g
Z2V0IGFuIGV4dGNvbiBkZXZpY2UgZnJvbSB0aGUgVVNCIFBIWSBjb250cm9sbGVyJ3MgInBvcnQi
DQo+ICsJICogbm9kZS4gQ2hlY2sgaWYgaXQgaGFzIHRoZSAicG9ydCIgbm9kZSBmaXJzdCwgdG8g
YXZvaWQgcHJpbnRpbmcgdGhlDQo+ICsJICogZXJyb3IgbWVzc2FnZSBmcm9tIHVuZGVybHlpbmcg
Y29kZSwgYXMgaXQncyBhIHZhbGlkIGNhc2U6IGV4dGNvbg0KPiArCSAqIGRldmljZSAoYW5kICJw
b3J0IiBub2RlKSBtYXkgYmUgbWlzc2luZyBpbiBjYXNlIG9mICJ1c2Itcm9sZS1zd2l0Y2giDQo+
ICsJICogb3IgT1RHIG1vZGUuDQo+ICsJICovDQo+ICsJbnBfcGh5ID0gb2ZfcGFyc2VfcGhhbmRs
ZShkZXYtPm9mX25vZGUsICJwaHlzIiwgMCk7DQo+ICsJaWYgKG9mX2dyYXBoX2lzX3ByZXNlbnQo
bnBfcGh5KSkgew0KPiArCQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wX2Nvbm47DQo+ICsNCj4gKwkJ
bnBfY29ubiA9IG9mX2dyYXBoX2dldF9yZW1vdGVfbm9kZShucF9waHksIC0xLCAtMSk7DQo+ICsJ
CWlmIChucF9jb25uKQ0KPiArCQkJZWRldiA9IGV4dGNvbl9maW5kX2VkZXZfYnlfbm9kZShucF9j
b25uKTsNCj4gKwkJb2Zfbm9kZV9wdXQobnBfY29ubik7DQo+ICsJfQ0KPiArCW9mX25vZGVfcHV0
KG5wX3BoeSk7DQo+ICsNCj4gKwlyZXR1cm4gZWRldjsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGlu
dCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3Ry
dWN0IGRldmljZQkJKmRldiA9ICZwZGV2LT5kZXY7DQo+IEBAIC0xNTYxLDYgKzE2MDcsMTQgQEAg
c3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJ
CWdvdG8gZXJyMjsNCj4gIAl9DQo+IA0KPiArCWR3Yy0+ZWRldiA9IGR3YzNfZ2V0X2V4dGNvbihk
d2MpOw0KPiArCWlmIChJU19FUlIoZHdjLT5lZGV2KSkgew0KPiArCQlyZXQgPSBQVFJfRVJSKGR3
Yy0+ZWRldik7DQo+ICsJCWRldl9lcnJfcHJvYmUoZHdjLT5kZXYsIHJldCwgImZhaWxlZCB0byBn
ZXQgZXh0Y29uIik7DQoNCk15IGNvbW1lbnQgZWFybGllciB3YXMgbWVhbnQgdG8gYWRkICJcbiIg
dG8gdGhlIGVycm9yIG1lc3NhZ2UgYWJvdmUsIG5vdA0KYWRkaW5nIGEgbmV3IGxpbmUgdG8gdGhl
IGNvZGUuDQoNClRoYW5rcywNClRoaW5oDQoNCj4gKw0KPiArCQlnb3RvIGVycjM7DQo+ICsJfQ0K
PiArDQo+ICAJcmV0ID0gZHdjM19nZXRfZHJfbW9kZShkd2MpOw0KPiAgCWlmIChyZXQpDQo+ICAJ
CWdvdG8gZXJyMzsNCg==
