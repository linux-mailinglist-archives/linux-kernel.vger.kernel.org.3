Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A0F55F942
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiF2HiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiF2HiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:38:13 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2056.outbound.protection.outlook.com [40.107.114.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E79CFD0A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gS3LFNDH5TfR9bEwv22gJdPcYQF4QomgAAElOdy596LKUUmt/6Dx33tuCJbs+TBy+MT2S1zj9+I9/gAJALHcWZ6r+lbmdJZmrWW/YHtuCGAxFWCy3WQFOftBr5umluCt+VfzjJ3+Dj+9ruXBpi9aiX6j6oq1srG13fLuGtRHjqJzAaAzFAjgKlQPV4EA5fCpLpGcuyy97Xbzy6WXL2hY+KP51DWI6xEtGphPK7uJ71LowdNz8gKC7B/OHcDETEmBRHquLNVov4SDuoUkeSibGBVeSNDV1Uf5PlBDAl8YF9PAsdirgrwC5PkYdF00zZjEDoTJvIoN9ucG8wbDjV8eTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4Ci7pLyai7VJ61sv/yx/Qmv2Hembs4J3F8vmV+v1Yo=;
 b=PogAXFy/5nmYljl1TXcjp8iXkU5C0AJdyh/dDkD2/zX8x2/8MmPbLJjyzJ2S8xFu/em086uYyBRQb3jkKsS0ga1hOHGHKmVDZlNu7MHXAwSC0hDhTZn6BScU/SOqRpSS8ISZ32kO9HJjdI7rtirakCvjLNY8KyYIyCUTIufnjYZ9+SVxw+sFrllG4xAKpSWpJpWiVdoeqJ45cnjiw3d0ZuC7uiRttAWRf9Ryb4ZMOIeVTA/QD2iwv5ar/HpQ4FpKooAc+2BC3sM1SAXRBku2tQd4lYzfWCpXr02F1wUzqa4XXoRJ8hTt1EXYGiavYmBRxNPqB92r+5wOVvx8wCxeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4Ci7pLyai7VJ61sv/yx/Qmv2Hembs4J3F8vmV+v1Yo=;
 b=FCuKuVYU9Fi6h6qKK44SvjMwwex3tV4+MNAjDymE28V8cuvQQOvGDthIf5ABcZHR+N44kUSOGcQrfa+DlBYK7cpjDa9Y2IzHpFltir+ZQirH6vI/h4G6xJWyJHjt+L5hlGDGm0qKjmwmEsUXYBg05u3hzdr/c3veQhJ1nQnyNhA=
Received: from OSZPR01MB6953.jpnprd01.prod.outlook.com (2603:1096:604:132::14)
 by TYCPR01MB10020.jpnprd01.prod.outlook.com (2603:1096:400:1e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 07:38:09 +0000
Received: from OSZPR01MB6953.jpnprd01.prod.outlook.com
 ([fe80::19d0:3b99:8d00:4e24]) by OSZPR01MB6953.jpnprd01.prod.outlook.com
 ([fe80::19d0:3b99:8d00:4e24%6]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 07:38:09 +0000
From:   =?utf-8?B?Tk9NVVJBIEpVTklDSEko6YeO5p2R44CA5rez5LiAKQ==?= 
        <junichi.nomura@nec.com>
To:     Michael Roth <michael.roth@amd.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@suse.de" <bp@suse.de>
Subject: RE: [Regression v5.19-rc1] crash kexec fails to boot the 2nd kernel
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Thread-Topic: [Regression v5.19-rc1] crash kexec fails to boot the 2nd kernel
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Thread-Index: AdiHYUeDOBniciIDTZqhkiEHijhZ1gD76gIAAAS1nTA=
Date:   Wed, 29 Jun 2022 07:38:09 +0000
Message-ID: <OSZPR01MB6953EEF3F8E63330547E031183BB9@OSZPR01MB6953.jpnprd01.prod.outlook.com>
References: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
 <20220629004114.zn5rurrmqdkiceun@amd.com>
In-Reply-To: <20220629004114.zn5rurrmqdkiceun@amd.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50a95f45-2c01-4d64-c8d5-08da59a25055
x-ms-traffictypediagnostic: TYCPR01MB10020:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o+EUc9E9JCEAiBRrzht2tb8TZhPQygLFAIBToG11KJKwSozaQm/UgvKws689YgnhSb5+uFb3yFazSLOUQwu9nT2ULiKbUrPm/ZHKTPTu8K/korGd3SCbHe5uPvKrT+u94ANooNUjk0Z79IPPzerCk98Y/Z2w+EwvDt/oqUbxJQICdi2/qJ5kksGaX5KDXK7IyssD076BTfzJFKZrq5I0CuDZRKHZwOcjOJvcV6I9F4XV4e8BmY5AxVmpqVgCokq6gg97kebeIsRGmYXPja9PzLbNvWm/x9PnegGHbznU8izDAzJ2nuhTY1W+MTVjKtcgc7cucCIG/AIPbDWHotdEk6OFErhqrkdtS1lJiSKnffmnQBV4qk5i3JjS+B3P90cKN7jKMND5FdQpCZRwn6wogIpQF7MtHAOgIj67aLIafhe0P+0imwXPvYyhEXM44I6AUFE8BKqSqtlpLij9Oad6NTnAflNS9k4XBh9+juPoncldEwTy1jCpy3SWLdXDr8LJZJwwx8HhRV/yOSYr9ct44ILdMAO5IDoBHc90o4sllVo+U1tjDIeXYAt4uwZ64rs4++rYgJEcw8y9Wi0xh7+e9464SIybMrduLPZpjykdl1UB4Hn1aMa0UXCXuo3uXd7iQayf1jD8bio6rITe2gGbNLXHbdMEGPrDx3IDNmbSaD6AOtQCHV7SGTYMcq/UmrazR18Sj9P6Eg90d9MI2+dObmC9E8UmpR8AnXBneFI62C8phEir3D+h90Dge/I/RVnEpCCl3D/pxLHF1PHrxst2p9QBxRnGv8Z2gReayJ0FerMLQsUKVFhG+VEZITWQzzvG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6953.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(316002)(86362001)(6506007)(2906002)(41300700001)(38100700002)(7696005)(55236004)(186003)(38070700005)(85182001)(54906003)(6916009)(76116006)(8676002)(71200400001)(66556008)(66946007)(478600001)(64756008)(8936002)(52536014)(4326008)(82960400001)(66446008)(33656002)(26005)(5660300002)(9686003)(122000001)(99936003)(83380400001)(55016003)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzNkcGIyU3AzTHhaVGtQZGQyZHEweUN0OTloakNWbmd3a21FSUpKK1Q1NmlH?=
 =?utf-8?B?MzRwckJQWmRKVFNqaGdVajB6S1FvaHNGeFFjbGhhTHU4Zm9zMmh6RDVzZTYv?=
 =?utf-8?B?cnVwL0VYQ1RaWmQ1WHAyd0cvZGxybk90OHJNaE1MYzVEeUQ0a0c2NVFDSmZt?=
 =?utf-8?B?OGIzSENBd1gvaWJiZUhFYmthWG5FTXpGWFdxVTFPUWNZWlFPWWFzSmxMMWVp?=
 =?utf-8?B?WnlvMExOZW1OV3JiU0ZGbTAvVW5SdHdJc3c3Zk0rT2NKSmtzMU5MbTcvMGpG?=
 =?utf-8?B?M29VTEVTbElWYkplUDY4Vy9lbjVnRVpweXNzM1F3LzJQcDIvWmxSQXNIbDZI?=
 =?utf-8?B?VmZTRzlpUExuaExpenJtWld2Z2ppb1pBTHE2NURHazJNR2sxb05oQnFjUW5l?=
 =?utf-8?B?ZFpFTGx3M05UeXZzREgxV1ZhS1liN2pVYVhVeVRHZDRONEVJb011QTVUb0sw?=
 =?utf-8?B?VXlDU2dhajdHVGxFcUdyd1hWQnVnVDhzdmRZdDNtd1Uzc3BHNGd3RkFPQ3la?=
 =?utf-8?B?Zm1xUkVJRTRCRlhOcC9MVlFTekdMRUVXY01sSjU1V0oyQnF6ZElYdGxNYkRq?=
 =?utf-8?B?QTUxb0UwV1A1ZnhDeHFMMGVyWllTTGNpczBzOHE2MFBYSURaT2dlelFKNk1U?=
 =?utf-8?B?NGJiVzhJQkxBVERUcTZVaEFTcm9odXhkMWg2QU53bGpDSlVNSmluNWhIdFVP?=
 =?utf-8?B?WVQ2Unl6TTJIZlhTeHp0elVoUVkycU85cXcyY0JXWG1YWXg3Q0pzdHU1VHBH?=
 =?utf-8?B?SjVCU1pWcXlibUhOOUcyTG5wc1ZWMWFKNDJFOXRNR3B3SklkU2xpcGFEMWUz?=
 =?utf-8?B?Z0JIdTcyZ01EUmVpMTRyV0E3Mk1kUEIraytFbHlrMkVKQjg2R1RZTXI2aWxL?=
 =?utf-8?B?Rkd3Q0IwcDIwcEM1cWx6WWY0aXFuVWJwZWc0YTREWEZCSVllZUdsVURCYmJv?=
 =?utf-8?B?WCtVL09WMHk2WlRiZWtmU1YrV05hRDRnU1BDR2h2QndyU3Ixc0t5MG4zYTls?=
 =?utf-8?B?YWdUY1g5TjNtVXN3VlF2VnZyb3o4cXIxbi9UME1odE9QQ1QvOGdydk1VRGI2?=
 =?utf-8?B?a3pZejAvU3VnMTQvQ3NwUGRlRmR0aFgzMzhWazlJYVd1M1VHamh6c1RDM2lX?=
 =?utf-8?B?OEFFU1dBQm5VTzl0TE45Tjc2ZUgraG9tOUYwbkk5WGxjZDcvVjd5L1dWSGdI?=
 =?utf-8?B?M20wbFF3Y2NDeDlWTTJRbWw3WHcvY3pNSGc5Q3p5a3FTd2gxcERXeGowV3dL?=
 =?utf-8?B?aFQ2dEdPZFhzWWJUa3o3Y1ExR3RReGdXR25uaWNQUjVZWmdHOUwvOGNrTzYy?=
 =?utf-8?B?WnVncnYyMnVkNEtXVitUa0NENWZBaTV5OTh6N05XVDJFTXA5aldiNzN5Q3JQ?=
 =?utf-8?B?cS9WYXdna3BOUVVNaVozK1YzNTlnbDZIQnlxUEsxTnM5UEFldzIvQWU0Ny9L?=
 =?utf-8?B?YmUzV2l6TVVYcTNuVjBENU9kTXFoOGtVdTIxRlpDdGpkcmV2QkdsS0NJQy9D?=
 =?utf-8?B?SkNWVnQwTFZzNVRiaE80a1ZpWmc4d2d4M3NyMVF0OWswbXlHQWZ4S0tTUDNp?=
 =?utf-8?B?UXROY3FKY1hQcmx5Tnl3U2tNdG1xMDNrcXlxQnJuVW9ZdU14YkZQMGZuSUs2?=
 =?utf-8?B?YXlPSDJpcnl1RHQ0bzFUNHlJejFFZ3c2UHlZQWttdUYyVjZUbUUxSVJ2clFS?=
 =?utf-8?B?bXNjdFZsQnczTjh6OGhtSWdNbFNtemg1QXJyUyt6MHVmMjBaL21OR1c0Uyth?=
 =?utf-8?B?b09jZUw2dVFhRTNBcmhONzV4NERtSzRSV2ZsbUpycGs0QjNoRjdSNDBZVUY3?=
 =?utf-8?B?UTkyT1ROUVJUQlhZNEs4SlFlV2w0WGZlRWJ6RnMzZHp2MHA0TFhpN2ZFdkFV?=
 =?utf-8?B?OCtvVjVnRitRN0xNTWxEQWRqOHpyQi9oR3BlcEwzcjdoa1dIYzNNdmIyODhK?=
 =?utf-8?B?SDJUNTdWNkhSYmlmVjZ4V1hOWk1nWWM1L1JiRXZ3aTJUWTZjaXY0dXFMbkd5?=
 =?utf-8?B?WVFmUFh4U0t2aU9YdW05elpLellJOG13Rk5FNTdERjBlUzEvcTREL0dsTXlC?=
 =?utf-8?B?UXJUVG93YjJLUVpIZ1hodkdmdzM3bjhPUk9LNVdNZWMyKzRvd3RTU29NQW5D?=
 =?utf-8?Q?uhC25aS8QRkEOvx+QxEaif+2c?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_01D6_01D88BD6.9C3BDA20"
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6953.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a95f45-2c01-4d64-c8d5-08da59a25055
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 07:38:09.3250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SODo49/XJ5HW20J6262QcjVqgITm0jJBtRx3SHjB0u2eVtJcBG6JuV44Qkdxv73OYF7dzqwNNRD0s0TJoMYMwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_01D6_01D88BD6.9C3BDA20
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Michael Roth <michael.roth@amd.com>
> Thanks for the debug info. I haven't been able to reproduce this on the
> Milan or Cascade Lake systems I've tried, with kexec -l/-p, and well as
> with/without -s, so there may be something hardware/environment-specific
> going on here, so I could really use your help to test possible fixes.

Sure.  Thank you for trying to reproduce the problem.

> > Other places that parses setup_data uses early_memremap() before
> > accessing the data (e.g. parse_setup_data()).  I wonder if the lack of
> > remapping causes the problem but find_cc_blob is too early in the
> > boot process for early_memremap to work.
> 
> I think this might be the case. Prior to early_memremap() being
> available, we need to rely on the initialize identity map set up by the
> decompression kernel. It has some stuff to add mappings for boot_params
> and whatnot, but I don't see where boot_params->hdr.setup_data is
> handled.
> 
> If you use kexec -s to force kexec_file_load, then the kernel sets it up
> so that boot_params->hdr.setup_data points to some memory just after
> boot_params, and boot/compressed uses 2M pages in its identity map, so
> that generally ends up handling the whole range.
> 
> But if you use kexec's default kexec_load functionality, setup_data might
> be allocated elsewhere, so in that case we might need explicit mapping. I
> noticed on my systems boot_params->hdr.setup_data seems to generally end
> up at 0x100000 for some reason, and maybe that addr just happens to
> get mapped for other reasons so I don't end up hitting the crash.
> 
> Could you give it a shot with the kexec -s flag and so if that works?

Your explanation makes a lot of sense.  I could successfully boot the 2nd
kernel if "kexec -s" is used.

> If so, can you apply the below potential fix, and retry your original
> reproducer?

I tried your potential fix but it didn't work...  The symptom was same
as before.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

------=_NextPart_000_01D6_01D88BD6.9C3BDA20
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
BwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDYyOTA3MzgwNlowIwYJKoZIhvcNAQkEMRYEFHoApvncVtCp
bSjn3xmojurukVB2MHoGCSsGAQQBgjcQBDFtMGswWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBlcnNvbmFsU2lnbiAy
IENBIDIwMjACDA7558EqCayXPvt8RDB8BgsqhkiG9w0BCRACCzFtoGswWzELMAkGA1UEBhMCQkUx
GTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBl
cnNvbmFsU2lnbiAyIENBIDIwMjACDA7558EqCayXPvt8RDCBkwYJKoZIhvcNAQkPMYGFMIGCMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3
DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJYIZIAWUDBAIC
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC6k+caFXNDSHNG2qLvwb03VvXTVIi6venS
qHZBE/hDzSfB/4YoDHRYyB8OF1Xb8uHUW6yjTDe53RPB3lImy0tTy2aLgcSDh/77+OEK5KwlvibY
X2lqdaUbOemXMqiJWdj6Kpbqmtui3JC1uEhhJR+uHVm6xf05IAeUa9f4EneYqyNbqSME0V4o4Uco
mp0BzANVDRZnp10Hjd3u5omXMM0bUi9FF+IbKqtOweI+eD4ZpnUdx9buWo1/lj9LmnLjq8qSdtOV
QLMDYWHFMq2Ug+LhGQjaMwenMRZgDxhcaX7lpgKTmcgiIHd0QJWGcQsupiv1oNB70c7+OeDzXfwM
1wZOAAAAAAAA

------=_NextPart_000_01D6_01D88BD6.9C3BDA20--
