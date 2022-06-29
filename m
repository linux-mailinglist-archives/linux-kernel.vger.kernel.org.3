Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9E155FE38
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiF2LGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiF2LGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:06:21 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2050.outbound.protection.outlook.com [40.107.113.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4963BFA2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvWqITgd1zKoBmOpJOEyxtTwJ1IoEoTZKTQmnTf5xrg3LAjJD+zGVDGKpqGd7nQ0ZR2u8sL9nLqmgzBUHVTrzcumpgDCv4F3e5VC1x+6YV6fOhEyW8SpU5oZ5VO8LwPOl4D610im5TU5jHUN9hsh5FLvVwpUyG1zVF8nnsyRJKPYq8xA4n9F6NHKh2K5cXuAZtxljGNya+icaFqgZMEkHiUwSWpEht9KtijUhEHVyip5ju7VYbCDx0k2vRoHypFRYNBfy7kmdxqBO31HJ4knYRWjkbM6rD+vKbsmHjncNhmDbaqKI3+5rVTnipeVwV/wTZkw2jApUr8Ck2+FZCSpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=115KsyQ+iU6sKz1ABnDoKe7pvwwzYbUKUXaAN/Q4Xpo=;
 b=kxhDk2AxGQUzSX17b3rercjWfwtIG4+ZKKq02pZi59Ghbxb5kU8k5s1SyGC9ogl1Xfe+DYK8jRs3cGPNO7tBN8R2BqsyA2LJJKS+BJ7tBnsarpmfyuG+hKNFyNkvy4Cp8fG3x2B9Ge5cXVKSv0SdoMqp+Cj+jPcs1PP2uhS32vfj03YiTeCTF+IytUg9NkEcpj8QPkJJjx3GZX7bSNbET4vSnJOLmT/dPsSIsJ3Jn19vuvPX8Iaj0uPl2WhJmtqdr37st3k06p4aBidLINYtt2U7WYvTtvOiOcyLTBEZ8/uY9jbNJcfcSm2kwsU0LPms7bDstLx90/YPYPCHEf09bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=115KsyQ+iU6sKz1ABnDoKe7pvwwzYbUKUXaAN/Q4Xpo=;
 b=JbbwOJFIKgco3j8yKK52r8+C+RsB++K9MnHLF/aIrsFnQCP8P6uUmXt76CUF+4mVqS+mISBjNhyxjss+XRdXBFbrwTKHXCOr3lxfnoOvq1F0x4HdymB/OE7zun0t9Vnd5iPia3XQfEhhHT110NBqxKq/IqyHW5N9JMiXa6wzq/M=
Received: from TYCPR01MB6948.jpnprd01.prod.outlook.com (2603:1096:400:bb::13)
 by TYAPR01MB4736.jpnprd01.prod.outlook.com (2603:1096:404:120::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Wed, 29 Jun
 2022 11:06:00 +0000
Received: from TYCPR01MB6948.jpnprd01.prod.outlook.com
 ([fe80::41c1:d812:3e8b:87f9]) by TYCPR01MB6948.jpnprd01.prod.outlook.com
 ([fe80::41c1:d812:3e8b:87f9%6]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 11:06:00 +0000
From:   =?utf-8?B?Tk9NVVJBIEpVTklDSEko6YeO5p2R44CA5rez5LiAKQ==?= 
        <junichi.nomura@nec.com>
To:     Borislav Petkov <bp@alien8.de>, Michael Roth <michael.roth@amd.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [Regression v5.19-rc1] crash kexec fails to boot the 2nd kernel
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Thread-Topic: [Regression v5.19-rc1] crash kexec fails to boot the 2nd kernel
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Thread-Index: AdiHYUeDOBniciIDTZqhkiEHijhZ1gD76gIAAAS1nTAAC1QagAAE3yZA
Date:   Wed, 29 Jun 2022 11:06:00 +0000
Message-ID: <TYCPR01MB6948029FAACBC313063EE49283BB9@TYCPR01MB6948.jpnprd01.prod.outlook.com>
References: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
 <20220629004114.zn5rurrmqdkiceun@amd.com>
 <OSZPR01MB6953EEF3F8E63330547E031183BB9@OSZPR01MB6953.jpnprd01.prod.outlook.com>
 <YrwLS8qRDhjmeD5Z@zn.tnic>
In-Reply-To: <YrwLS8qRDhjmeD5Z@zn.tnic>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fabcb29d-78b3-46fd-a486-08da59bf59bb
x-ms-traffictypediagnostic: TYAPR01MB4736:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p3o7QS87JGuEgrUVWvLxrt57omjnhKTZvDVoAmGRefmsuz0A9KdiGTbGy6VAL5qqg8u2Lq5mCbRO9h3Plh5c2vq9pX2GHBM2dH8a1zUgDgQHto07+QHEZEzQ9QhZzkTmTw73fBnPugZIqzGik4hLDzBsds9Hla5P4lSXIZjB+pofcy6m30SxE/5uBCApFHfSIWHpiiobqSnFr2PxGouGC6vKM6h4KoSSsY3raz+NFZHp3rny2B1kjy35T3gYx9RagDPIFUupuYb8p/gFsqWNIc5IWafNbjKoAb+cSpQjB9nsqsjWzl7ZWJ/BWr3dJiLTVEaBNZkAsD1PG/IhXr5gvtBH8bpHLAGmvpdMJEMNCuGd8n5+mmM8NpOGRpvpxx7OYCIpNluP2peNCQBw+snEDXUGJbV7PQMimMppFizxR+aQ6uzedi1nBbe/0T/eCGYtT6UnxQoisAlkOorpqSwNcjX8r26+EIily/FAHKLSz9ByKREoNzJrj56IGmNHJtI0JWUYYtkvijdbRNW6c739fwANnKQyaHB0M/d/Npqv3IUrsT//YFX3kbtwYq2IrsaImsGDkS4Jx0gciO9PkFM3cRc+xPeUX1FHQYlvaAlvhCVVAkv+yu7h6FE+Mdt3ZxfCWVvOA+2LbV99e2t5zJdaNTWhy+nqVlqM3+bDoul43HnDXYVt+2eKqngz3TcazI9KU9T0bv7EyYNX2rMtmThR5hpSZ706kVGMZUvhQYnHJi7ccJClEQav9OzspBstYbEIXBo++Z35Ff2BoySgJPyHR4CHZAZheae4Smhiaz2A2TgSkFcwMUxuWPqyHcD7YdH5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(5660300002)(85182001)(478600001)(7696005)(8936002)(52536014)(82960400001)(66476007)(66946007)(99936003)(64756008)(4326008)(66446008)(76116006)(8676002)(66556008)(122000001)(38070700005)(38100700002)(4744005)(2906002)(316002)(55236004)(6506007)(33656002)(54906003)(110136005)(55016003)(41300700001)(71200400001)(86362001)(9686003)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SElGcGVqNWtlMnh4TUQvZW5INXp0S2xYQzBydHNpTFoydUFIWjdBdURQWEJ3?=
 =?utf-8?B?WXY1eG4yYlRvUXh3dzBCcDZ4STJrN3RoZG9BMUJac3FwQTZHd3ZBQTlDVWtK?=
 =?utf-8?B?UnlZRXRqNDJwZFBEU29IdTVpSjJmSTFCL05RMWVwcjhXcUtSajZYNFFJa3ZZ?=
 =?utf-8?B?eFBjSmVuNkxaa3U5UW1OWHljYjg5OW83WHMvK1lzTzFYRnM3eEZQbHRYWncr?=
 =?utf-8?B?eVo5TFI3NCtpZHRSZVRvcTY5MGdPRnNYZHZPUjVRMWlzZzBnazBtdlNtRlNZ?=
 =?utf-8?B?UkI4QXdNN09LTUkwSkRHUmtLL3g5WG1lWVZDM2JpNEtMMCt0Mm5mY3A2MWtz?=
 =?utf-8?B?c2Z1RXFvRHZ6NnFVSDlFeVk0RjB4YlErNis4bTloYW9VUDh1N0JsNmhkSHBn?=
 =?utf-8?B?Q1JMS1VzUHJubFpmK2xjMGNlYTV3cGlMRTAzaldKbEY5RXpWVWZkTlNLSUNR?=
 =?utf-8?B?RkFuR3VtYUY1Mi80Rm10bTFjR21oSkF3b3FBamFmV2h4RWZRNkgvMFNWc3lM?=
 =?utf-8?B?blpYeXVOc0hxd3pjeURkelI1OFZWMDZtRWpqRjkrLzdLSkFNVG5rbnlHNlQy?=
 =?utf-8?B?QW16YlZObkR4eXZhV3VnS0tvMGRLZm5VSlIvUWhqYzF6NTJZQ1ZVSGFEVTYx?=
 =?utf-8?B?YW9LT09YS1BNYm9lY3NnNzk3K0pUblhGVTFXWm40VkwxSUdXUlFkYWJybWZI?=
 =?utf-8?B?TWptZVBVaTVZajdDQXowTVpVaHNuZHVTZFpLaHNLNzlIck9CY25LWjNtRXR0?=
 =?utf-8?B?bFk2bGNDNUxVOVE3M2JOM2c4T3ZnT2J2dmtHTm13c2pYK1VML2Z1ODVVamJG?=
 =?utf-8?B?b3dFVjFlUTB3WU1ka2ZzbThYK3FWbmVPeEhhMmdCdmd4eXVuMGtEcmxlaU9L?=
 =?utf-8?B?cnVocDh1KzNMTm94QzlYemU2WDZaalhnSUVsalZTTVNTaGRQa0xuNmZyZnF5?=
 =?utf-8?B?VVlPMWcvUCsycG52cDIrZTRUb041MngwZ0dZVVptSHlXdlhBT2Zrb00yMU9k?=
 =?utf-8?B?Q0ZudEp1a2hKeG9XaFZscEU2djZaU2FqQitncUxoakRYM0hXOU5lOCtQSTE1?=
 =?utf-8?B?T1VQTWVGRzZPa3BqR2MxLytNMDNYU0tkM1RFTWwwOGU1aExiRXVPVjh4eENw?=
 =?utf-8?B?dXluYUNjVGdpSld2TmtJaFhMK0RyQWI2aElVaStHUXBINFFRVUxtc2p5U1I0?=
 =?utf-8?B?cmtuR0ZnTFUyMmtyNk41UzJLS2lUcHZOeTN2SFJybVArdFNuM3hzRTlMT29B?=
 =?utf-8?B?djRaZWhaNGxpOUg3L3NyT1BocS9xcEtINTlNY3lSK1hCU1N4NUpDbzZvZk42?=
 =?utf-8?B?ZGdkM0lPK3RxbWVGV0tyeWQ0cnpJTVNwZmVjS0VJMFp0S0xxc0g4VXJVK3pa?=
 =?utf-8?B?UUxpdlhkMmMybUtWNVoxL1BJYVlmZ2R4NkxXRTVCODhiRHh2OU9vaXlRTGpi?=
 =?utf-8?B?MHhXU0tOTit5SWRoaWVFS1YyQk50Sytmd2ZpWGJlRWp2WjNnNjRlN1FEMk9v?=
 =?utf-8?B?SnNpWWRpTktJQ3BEZlpCejE1MlptZmJ0UXFnT21SaEVPdlNYRjZ2RVV3bG52?=
 =?utf-8?B?MTNFNTRtNXJOOG1LbGhrWkJFWmZwZHhXWXJHSlpzYjBsV2tqREVqbG9xT3Nt?=
 =?utf-8?B?aVFQWHcxTHV1N2xsRy92MVNMYlp1VW1TcXF2bUJPZTRPWmUybkNYamRGMjhk?=
 =?utf-8?B?MlNvQzU1V2t2VWF1eisrUGRGdFU1T1RpMWVPTlZBZGQ4TTQ3Rkp0R3BLK2xD?=
 =?utf-8?B?cGp5dFFpWFNhNERTOXJ0UmR2VmgzOTY0WEFlNmVGbDFEYTlSQTlkRklFcGJ4?=
 =?utf-8?B?T2duL2NpdDlPSTliaElranQ0MUV4KzZBb0lmWjd4SzhjOVFBUEwrMlIwWWxh?=
 =?utf-8?B?NlpLNUovMzVwVzRETzBXVGZPUktUMnhkMTBpZGhMR0pVeDdPN21ZejB0WFhR?=
 =?utf-8?B?cnNSMWNZNVJsZVpQZ2Z0WXRxU1QxVi9SOWpFSWV4eWFLcWpjdG15Q3VYSTh4?=
 =?utf-8?B?a2kyKzRhYldtU2U2MzJUTUNMOXAwNnlGOVhxV3grRHJ4UXYzL3BFY2orbnZ4?=
 =?utf-8?B?YjJtaDVyTThKNWdaSkpQQzhTNXppTGlSVG1LVnV5dFo1cUEveVdpeS92STlo?=
 =?utf-8?Q?1k504hfKtI2PLJv2QdHF9t7a6?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_02A9_01D88BF3.A5DABFC0"
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabcb29d-78b3-46fd-a486-08da59bf59bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 11:06:00.5129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKl6Zo0QImS8Qwfw+y+ewGgnDkT0z04+Fu6f9LAZv+cCnGOGFNcG0uCYH7o3G/KyVgmnxvBwKCgcssB57O4psw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_02A9_01D88BF3.A5DABFC0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Borislav Petkov <bp@alien8.de>
> I still think the proper fix is to not execute that cc blob code on
> anything but AMD...

That will solve my case but I'm afraid there may be people with AMD who
hits the same problem.

Isn't it possible for boot loaders to pass cc_blob_address via boot_params?
Information included in struct cc_setup_data is just 'u32 cc_blob_address'
and it seems struct boot_params already has a place reserved for it.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.


------=_NextPart_000_02A9_01D88BF3.A5DABFC0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIISxTCCA3Uw
ggJdoAMCAQICCwQAAAAAARVLWsOUMA0GCSqGSIb3DQEBBQUAMFcxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMRAwDgYDVQQLEwdSb290IENBMRswGQYDVQQDExJHbG9iYWxT
aWduIFJvb3QgQ0EwHhcNOTgwOTAxMTIwMDAwWhcNMjgwMTI4MTIwMDAwWjBXMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEQMA4GA1UECxMHUm9vdCBDQTEbMBkGA1UEAxMS
R2xvYmFsU2lnbiBSb290IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2g7mmY3O
o+NPin778YuDJWvqSB/xKrC5lREEvfBj0eJnZs8c3c8bSCvujYmOmq8pgGWr6cctEsurHExwB6E9
CjDNFY1P+N3UjFAVHO9Q7sQu9/zpUvKRfeBt1TUwjl5Dc/JB6dVq47KJOlY5OG8GPIhpWypNxadU
uGyJzJv5PMrl/Yn1EjySeJbW3HRuk0Rh0Y3HRrJ1DoboGYrVbWzVeBaVounICjjr8iQTT3NUkxOF
Ohu8HjS1iwWMuXeLsdsfIJGrCVNukM57N3S5cEeRIlFjFnmusa5BJgjIGSvRRqpI1mQq14M0/ywq
wWwZQ0oHhefTfPYhaO/q8lKff5OQzwIDAQABo0IwQDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/
BAUwAwEB/zAdBgNVHQ4EFgQUYHtmGkUNl8qJUC99BM00qP/8/UswDQYJKoZIhvcNAQEFBQADggEB
ANZz53xPdtCNv+y6or40xSgytXz8bJwsK70JnlO/a16qEUi25Qijs8o9YU3TRgmzPsOg42NVG/K6
76054UO5OKPmL4omO++gUFb5xgr9OM3EC3BRlJeYBN/DX5TVFckUQZzEXXVkFQ3/VTDsho//De8s
uWNG9qr837xp/S4SSGSa4JXwpu8pjwGxFbUMHaX+aSxpJHges6cccWLuysiXrBddisL4R4ZuKsRW
MZXQZ4mFK/lspl1GnQyqguSZUd1wt9tWPWHkauFc1vb+Pd5BzAeuY1K/U1P0K+nH/bb3gl+F0kEY
24GzBBzFH6SAbxUgyd4MiAod1mZV4vxIySkmaeAwggROMIIDNqADAgECAg0B7l8Wnf+XNStkZdZq
MA0GCSqGSIb3DQEBCwUAMFcxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MRAwDgYDVQQLEwdSb290IENBMRswGQYDVQQDExJHbG9iYWxTaWduIFJvb3QgQ0EwHhcNMTgwOTE5
MDAwMDAwWhcNMjgwMTI4MTIwMDAwWjBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
MzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aEyiie/QV2EcWtiHL8RgJDx7KKnQRfJMsu
S+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5uzsTgHeMCOFJ0mpiLx9e+pZo34knlTif
Btc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bLyCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7
v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8
rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkWqQPabumDk3F2xmmFghcCAwEAAaOCASIw
ggEeMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDAfBgNVHSMEGDAWgBRge2YaRQ2XyolQL30EzTSo//z9SzA9BggrBgEFBQcBAQQx
MC8wLQYIKwYBBQUHMAGGIWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL3Jvb3RyMTAzBgNVHR8E
LDAqMCigJqAkhiJodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QuY3JsMEcGA1UdIARAMD4w
PAYEVR0gADA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0
b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEAI3Dpz+K+9VmulEJvxEMzqs0/OrlkF/JiBktI8UCIBheh
/qvRXzzGM/Lzjt0fHT7MGmCZggusx/x+mocqpX0PplfurDtqhdbevUBj+K2myIiwEvz2Qd8PCZce
OOpTn74F9D7q059QEna+CYvCC0h9Hi5R9o1T06sfQBuKju19+095VnBfDNOOG7OncA03K5eVq9rg
EmscQM7Fx37twmJY7HftcyLCivWGQ4it6hNu/dj+Qi+5fV6tGO+UkMo9J6smlJl1x8vTe/fKTNOv
USGSW4R9K58VP3TLUeiegw4WbxvnRs4jvfnkoovSOWuqeRyRLOJhJC2OKkhwkMQexejgcDCCBQ0w
ggP1oAMCAQICEHhKqRA/pb++3nUIsTSTHQAwDQYJKoZIhvcNAQELBQAwTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wHhcNMjAwOTE2MDAwMDAwWhcNMjgwOTE2MDAwMDAwWjBbMQswCQYDVQQGEwJCRTEZMBcG
A1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29u
YWxTaWduIDIgQ0EgMjAyMDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL2wplwnLG2f
2tH0SEDAcaeICZ58np3hWKRLTcna2WfhnikjHR4g4Fw9VJ0UiLnSqPpqEOmJQjruLa1VjvxIl32J
yu83qKduq8tUaSraIAe/ztdec7pbQM+uMnUGC3vmtXv3M5AC4N7IE3DjnBWU15N/HmqrF7IqaF9b
7Dbq6j7Zwtu01rAO6ZOLil7HBY5HlBPCWbvQQymrMGcoMQTjwUAcKwOfttFsZZOpNXuhCmmjWjWV
Mt9KtwKxH99GQ6V8nwrYl57qY0ivFlNnCuKrBLY9PSUuPpoYtAkwqwp1wM7pt7YHB3B0YNKa3Es8
xFA0FqBccrqsIsIR7t7D0DZhTjMCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQEAwIBhjBgBgNVHSUE
WTBXBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcUAgIGCisGAQQBgjcKAwQGCSsGAQQBgjcV
BgYKKwYBBAGCNwoDDAYIKwYBBQUHAwcGCCsGAQUFBwMRMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYD
VR0OBBYEFJYz0eZYF1s0dYqBVmTVvkjeoY/PMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i
3Ru8MHoGCCsGAQUFBwEBBG4wbDAtBggrBgEFBQcwAYYhaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vcm9vdHIzMDsGCCsGAQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2Vy
dC9yb290LXIzLmNydDA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29t
L3Jvb3QtcjMuY3JsMFoGA1UdIARTMFEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIBKAowNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDQYJKoZIhvcN
AQELBQADggEBAHQF5P1wpw3gDnfZzRFL1j8W5TkP+aP6ujiHk2L6BL1FItqh1DrW34wRnU6bRbF1
3uEYI1RfW+g7os4GH8vnCC5r4uYX5NyKvDAGbILVvgP6LULCbytsEWrSxOtUW85F/PfzlxGdc0+7
f6tkYias6b1fDQocSI/j+1k7XqT5vQCI9CnrnvoEtqr8wGQGN+GWXkR4AO4OTuEzyf6E3fuK4IlP
vsCw5XGWHf7JRZGk98YOKlg3qRDI0+E9ahTkCC/oo1AK2EuKMKT4PTSEkymtaqiliYxaMprNHdBs
Dp4iCGwb4SNjCewUmPTGLVlU+YyTt7bFR8I+HKfdgkhbhsLpxTMwggXlMIIEzaADAgECAgwO+efB
Kgmslz77fEQwDQYJKoZIhvcNAQELBQAwWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNp
Z24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBlcnNvbmFsU2lnbiAyIENBIDIw
MjAwHhcNMjExMjA2MDUxNzI2WhcNMjIxMjA3MDUxNzI2WjCB7DELMAkGA1UEBhMCSlAxDTALBgNV
BEETBDExMEExGTAXBgNVBAwTEE5FQyBHcm91cCBNZW1iZXIxDjAMBgNVBAgTBVRva3lvMQ8wDQYD
VQQHEwZNaW5hdG8xGDAWBgNVBAoTD05FQyBDb3Jwb3JhdGlvbjEnMCUGA1UECxMeTkVDIEdyb3Vw
IFN0YW5kYXJkIENlcnRpZmljYXRlMSgwJgYDVQQDEx9DQy0yMTQ5MVAzMjEyMzAsIE5PTVVSQSBK
VU5JQ0hJMSUwIwYJKoZIhvcNAQkBFhZqdW5pY2hpLm5vbXVyYUBuZWMuY29tMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4Xk01AQsJLT0nBNqyIrzkwP2bWrpCq74yoIHLzvyqQrgEU2C
VYazZwQR2dRDP6tLhz83LrgJpIke1INa49/BLUJp9FAfPVTCZb0j4kftbCj5R3O/JHFpDy//9Cx4
9osgejC+Y0HmP5onVmEe4tKxG3hBFoVhLyUU+LhusvQ7SRrjYU4Bj4qjv1rhUZLzAas69+B73ehF
dA0c+fBZ3V+eAWQILmGSkbWc3uXZWK5pR0cB2ZJxC2eLlMCMdWNVyZxbt+aTC2R4Sw0FQ/iuf/4F
Ar8qFoBevR4qmyZq11asIidufyscWOhplGshENi7+rzYTd1HioynChC67q+rL0K86QIDAQABo4IC
FTCCAhEwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0
cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIw
MjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVy
c29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8E
QjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwLmNybDBJBgNVHREEQjBAgRZqdW5pY2hpLm5vbXVyYUBuZWMuY29toCYGCisGAQQBgjcU
AgOgGAwWanVuaWNoaS5ub211cmFAbmVjLmNvbTApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYBBQUH
AwQGCisGAQQBgjcUAgIwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYE
FLri8sCe/FVMIHLIr512r1mpmJmEMA0GCSqGSIb3DQEBCwUAA4IBAQCMiqvivcAx1ZHBbcdmA7/z
ZBddJ+hSWAmZE26ZTWksq+WvzX1get6KGMu+6f/KqrBcxCukH+ajNIkaFcJFh0uoJEkbhXzvyqY0
RbFVAF7OF6bC7kySTjLQUB3c1AzfAgl8/JyYf5s2kjNVqP3FqDUkW0zGa5+LOzXhfy9NBLy1ZciL
JAFB1rSkRfRiIBUZaQS0P7qwRSMu/8NckySUoGbE1Yi20dCdKRyUgAoGnhr3mVJ0MNSHwr9FTDPv
eaL3cOR0P6Qr9lE2qmHvfRJQWxW3ufPiaTeC9o0NWDW7tcLDVTrYjavXMMR0yaIr9R7XJka/hMCp
puI9qbISANymP36AMYIDgzCCA38CAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFs
U2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0Eg
MjAyMAIMDvnnwSoJrJc++3xEMAkGBSsOAwIaBQCgggHtMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDYyOTExMDU1OFowIwYJKoZIhvcNAQkEMRYEFMofMRUVjt0q
Jt0QQyb0v1JhxCkaMHoGCSsGAQQBgjcQBDFtMGswWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBlcnNvbmFsU2lnbiAy
IENBIDIwMjACDA7558EqCayXPvt8RDB8BgsqhkiG9w0BCRACCzFtoGswWzELMAkGA1UEBhMCQkUx
GTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBl
cnNvbmFsU2lnbiAyIENBIDIwMjACDA7558EqCayXPvt8RDCBkwYJKoZIhvcNAQkPMYGFMIGCMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3
DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJYIZIAWUDBAIC
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCp3mVmxyMjVCHS2bdtp9VfZZ6TWOkeGvLs
heQFztU97TBy/RsoA7PHRemetIgTG0C5A8CAWcCyVGOjvkbpHlbqAGEUjAYuLkDSRbOMYj0nRFNB
C9AT8T1dmWhkvPKmWq8HB2Nz6wC2VzoH4xrpeWeJFc3Jq/FyF3EaA/RY3LsSsh8cQ9RQUeGEuZXf
9DJcO4uujj3/g2Pb9A1CJrckIlBWH+/dXywN2GgnkGQ+DY29PM3n8q4Zb7yOeE3+Q9u1XB9+nDxZ
xowBYbS5ApfPGgCAU2O8nvnvwo4S+PuIIujWvR2bK0FlJXQP7xB4xlphbaCoSKCtZTVt1Wop6Y5I
z3aVAAAAAAAA

------=_NextPart_000_02A9_01D88BF3.A5DABFC0--
