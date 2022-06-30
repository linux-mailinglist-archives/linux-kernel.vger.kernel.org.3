Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8D5614F5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiF3I0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiF3IZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:25:52 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2068.outbound.protection.outlook.com [40.107.113.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0F2419AE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7mGmwzIcFnbql2vwDwA8JKgqoSDGp0j6iRbCrULu5pp3TiMU10rX+E72wyX1Tx6NGo1X9yJkFXNs4YFvPStwJHOZzZWBj83I+aoTBW65I5uiCshJDgLWrplPyCM5oNG35V+X63fCY2CWBhQHcy7MsqGVKMEJwlluBYjutY7aiCTLWbmG74JJsaoJnRrvSuc2lNsnTvFhnMFM+dl5vJQgOIi585xadKm0xRzN0wP5MIG4wI75TyKMAAowydFLCNBmyejnBuE1HJ1oiKRwNXhL0t54LlO9kjldFwLGOElGOSQFE76FfzfhvMof+dqDIWI/aLlN0c4NhH0KRty972uQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1okWrt3YooC/h7MEEv+DdogAXuOB/uDD8SOA7CITW5s=;
 b=SLzsCVxtibEPO6Fl4QiVcrP4OVCkKirfL31D0yXXxF3UdHeFWpVdKnyyDNaJ8G1XrfN3KxQPkJK+wLbEZIEDYWnaAMQP011vbp6zVXnqT9Xxf/CGNBwoioioA1Qb4fyIHmkTj27/UmPwad8dGKESvJ64hdeC59pO1GBsbwree37EsAnHd7TydlPYh8PzLDkMrz6Q9eGi/FYrNB4WHLWmricJ4xuulE2coVD329Wn9zeXbo7szEn9AQgE/InwEQVNnEwRDqlXpqE3m+e7l9OZeEdM9StTYjdngv5fCMlewTYMuML1igFKGx7ulQ6sLTk0HBdwHR+vEzWsmvyit/ZbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1okWrt3YooC/h7MEEv+DdogAXuOB/uDD8SOA7CITW5s=;
 b=ZG+FLbWVCT+Ckl3/Guh6cwhvk5GyRxXZpQzY6t6h0Rid5JHlPHUb+bn9cykPWfhMZU34uZuH5DENP+3LuYKH+mC1hbv2kElmk1AA2TPMQUYzlgnzR5VEnl3OhpPI6tWEGuBjTDog3ONuvNqmJWbA4VXFvTFGkrcF3T3kpXtwVzs=
Received: from TYCPR01MB6948.jpnprd01.prod.outlook.com (2603:1096:400:bb::13)
 by OSAPR01MB4721.jpnprd01.prod.outlook.com (2603:1096:604:6b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 08:25:30 +0000
Received: from TYCPR01MB6948.jpnprd01.prod.outlook.com
 ([fe80::41c1:d812:3e8b:87f9]) by TYCPR01MB6948.jpnprd01.prod.outlook.com
 ([fe80::41c1:d812:3e8b:87f9%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 08:25:30 +0000
From:   =?utf-8?B?Tk9NVVJBIEpVTklDSEko6YeO5p2R44CA5rez5LiAKQ==?= 
        <junichi.nomura@nec.com>
To:     Michael Roth <michael.roth@amd.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@suse.de" <bp@suse.de>
Subject: RE: [Regression v5.19-rc1] crash kexec fails to boot the 2nd kernel
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Thread-Topic: [Regression v5.19-rc1] crash kexec fails to boot the 2nd kernel
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Thread-Index: AdiHYUeDOBniciIDTZqhkiEHijhZ1gD76gIAAAS1nTAAFwBigAAYcfSA
Date:   Thu, 30 Jun 2022 08:25:30 +0000
Message-ID: <TYCPR01MB6948A8E606A31E8C8BD6BBC683BA9@TYCPR01MB6948.jpnprd01.prod.outlook.com>
References: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
 <20220629004114.zn5rurrmqdkiceun@amd.com>
 <OSZPR01MB6953EEF3F8E63330547E031183BB9@OSZPR01MB6953.jpnprd01.prod.outlook.com>
 <20220629135441.7w4ptweifvfyw5rc@amd.com>
In-Reply-To: <20220629135441.7w4ptweifvfyw5rc@amd.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 383347dd-f6fc-49a6-3f7a-08da5a72182e
x-ms-traffictypediagnostic: OSAPR01MB4721:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n0Txlf1WQk36QhuT7Yu0M1GkgxrjjrdBODsmuenvTF9Yp0siriNcTIXl8aNEeyQXs6cwTI0Kx6go0FHVX1AqbOC+npo6s6XS8lQJllTvfFLRroSVQyH3snrM6BzZiMKvdwt/mX3nDlwTHfJZA/nVjjdpH/onRcr4PF+SBTpQ+hOaVUv7fteaFoRSrXBTe1Gyh972+PpZugSXI8eiEw4rkQBM/wyUx+HBkj62pITNLzOqRbsYFnE+vdjHCq1m4f3IkHpyzSyAYinMtXdYgd3QMuCgTWHMEuE7hKJBDfWJ0sEUazHIrZ0xpNOa7on55w4p40G4PIGUfesmedZeWrd2soxrQdjrRx20W5kJC5CdNUKYMYHVOjRfmxo6ldLARY3/AGrVCX+lCAE484S4j6jN64V/+ERwr3euf6jcI+qDsWO9hcghua1IFafpEDDa9mKhFsk5yc0lSCb8lBG/lZQBCNEVz0lpt7zCZ9w9hN8qBh7UiaWRapzrmhmbyihP5xiztdoOtTsqvcg96BwHvuSE6psNXK2QV6gNPefe8mBr3W17ow+fY2pieUK/mIOZ5xgRWCWlRtsg7oXVrdDbRubcIVN+BRRgvQWuHZKges1p2L5znFSI4gUK0EWKhzBbnLiIs3lbVLLq8GtP8oQuWzPW4BO8Ss8+kPaRuEsnFWJ/jZYujw9OGWdYkbab4LZk+ojadWtrXrslljIyrAYA74gvz48r7Ztc3g78f3svD9Zq9n9mYnKbWVojFPYIpG94pm6bLUxW/K+ZhIS2f7Szd503TE25ptdI73Rz+F6r93iirpXYoxeKA5zRoAp57HZo2+4Y9F2e7hZg3U0IOIB9P7Oc6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(26005)(9686003)(6506007)(54906003)(7696005)(55236004)(122000001)(86362001)(38070700005)(8676002)(41300700001)(2906002)(85182001)(6916009)(76116006)(66556008)(38100700002)(66946007)(66476007)(4326008)(66446008)(316002)(64756008)(33656002)(99936003)(4744005)(71200400001)(55016003)(83380400001)(186003)(52536014)(8936002)(478600001)(82960400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTIyRStVTXNXUk9xdVZhWGMvS0Znek5qWUJZa3dVNEpGMk00R2RFRmRtK3JC?=
 =?utf-8?B?RTlIdGJRY2hxR3RjdXREbldkSWZRNmZucVRRRU1kREZBRjhIK09IeCtzdGJC?=
 =?utf-8?B?Sk1QR0tiem5Cdlp5WjcvVnRzbzNjbzF2dCsza1JXN21HbnIxQXQ2NGpkVTBG?=
 =?utf-8?B?QkhzUitqQ0JBVm9JUzhQbFhuYm5PT2pMNDlvQ2NTZVFCQnp2eFVRYzRHcXdY?=
 =?utf-8?B?Q0p6STc2QWJRZEx6dnNwclUxOEd2aDYrdkpwb0NZUUwraDBheTNOb01sSWZV?=
 =?utf-8?B?UnZTS1AvVmVaOWNIL2pCU0IzRGZ3NUwzTUZOTnl5T2ZicHYzOGhrbng1dHpC?=
 =?utf-8?B?bmJ2aURuRXFlV2Y1cE5TdTRSdjNnRFo1T1VKa0IxdlI0VitVQVQrMUtIVU5j?=
 =?utf-8?B?OU9QNXlsc3pFS01TQ2pDQ1YwUVU2ZndZejBtcWFxZFJERSszem40Z2Z6Zzl2?=
 =?utf-8?B?V2R6dmpRNmdVbWtmckZmeFRjTlBZYTRXL0xiM2JoNTBWdHo4ZGgrcysxZDlG?=
 =?utf-8?B?QUxqRStSY0xENG1NQ2tMR1FsajEydTJISUNhOXc2VTdGVERNUUFSN09pSFhx?=
 =?utf-8?B?Mjk2Vi9qWklkc3JUUkhkajZ6ZTljdnczK1pMWmFoRkx1VVFrSGpyY0lVVy9s?=
 =?utf-8?B?dkxTcVlPWUN0eVVuL3JLY25ydTNhTDh4ZitQd3QvbDhCaUNVVFMyQ3FwSnor?=
 =?utf-8?B?MGViVG9Ud2RHdVJSaUpYVFUvcVlMTDdZU2xTUEtiR2g2S3VmVUdaUDBHUnZZ?=
 =?utf-8?B?KzBTL2ZsL3MyU3VVaEhsYTRPT3lWdTM4eTZNRkRiVjZqTk14U1lCL1IxMVA3?=
 =?utf-8?B?NGl2N0N1TXFQMmt4b2VnbEFjVHZEY0hHMFYwRDdkc3dtWXQ5cTgzSHZUNlU4?=
 =?utf-8?B?MW96V2VCeE9nOWw3dUFBQzlWZWh1TjVIV3Y0VjZTTW9tMXdKMFYyd2l3WEF2?=
 =?utf-8?B?UHRZSVlSZk94eGhwaEJKY3UycTNjT3NxemFhTVlzVUJicm5SUGF5eVR4QzFy?=
 =?utf-8?B?LytmQkhOUUx0VGNhajVYNDdWSUV3dEd5UGtlV3BjL2JGdk5Ja2luQWFNTmVS?=
 =?utf-8?B?bTc4b2NlMzVUL0dkMllBRFJVcEgvdkdXWkc2Z3pGaHppSHFVbkZwYlNyUW1Y?=
 =?utf-8?B?dXo4TnJYaG1GQVIwdk9GUE4vN1ZzbUFadTdHbll4dklTSFYyZmk4NTdCYjhn?=
 =?utf-8?B?elVtRFhWcEFIWll5b1JiUnM0ZWEzczRjN3Y2WVRlOW55V2xKUGlLazNXS2pp?=
 =?utf-8?B?S1EwdENtL2pJRnRVUnpUSzR0c25EeE1WYlRKVG5pUHBWOGJGSUo2L0tyVEdk?=
 =?utf-8?B?SU96bm93K2ZhQS9kdUgrL2NHc3g5TWdnblRYRGtlOGZQY3BsSXFldzhMTkVR?=
 =?utf-8?B?RDNLSGNpS1ZWLysxMHZycERJSE5DTEJBam5XV3hKOWF0d0RkMDMxRVJzL3ho?=
 =?utf-8?B?UG4zYWhtRGNib0cxS0ZjTGxZbE1lRy82ZG5hTWpjejZVK2x0d1dzVDVwUGNN?=
 =?utf-8?B?a1Z3MDh6eExsMGxmM2V6MWpVVDU2Y01Hc3Q0ckRsZThZM3Y0YUpPbFpWbFB3?=
 =?utf-8?B?amhNQlNqaXRhTVU4UmRTdjB0c25PWk5uUE5zbkVWVm5sMXBsMnR2djNCdDNX?=
 =?utf-8?B?MTBIMkdRNUNjZkRacEFnb1lxTllnWjJ5RjJyZGNGeWQ1U3VqM2F2YkN0cHd5?=
 =?utf-8?B?TGdsMW8wbXJoM3QvWEpvSkZoSmpLRkVraFZ3NW5vRlM4L1hNUjJNcEFQbVhw?=
 =?utf-8?B?WGxwcitBYXVwbU45UGRZdEZwWGZiQmVqZUxGanQ4WmdkYWJmbTcwOW01RGxO?=
 =?utf-8?B?NmR1YXdubytRbEE0VTI3SURBZjhKeGJ4alJZdlZINkE5VjVkUmJjVFM3UkZG?=
 =?utf-8?B?YzVxY2dNS3JjN0NMZFdhTndYL21nNi9VczFJbG1sUGwwN3ZYb01jbkJsRVht?=
 =?utf-8?B?Vk9UNWdYWU9VYWUyc0NwTUZnMzN1UFlBU2J4dEhPRGROcm9qYW44TXZTcUhO?=
 =?utf-8?B?Qkp4N0E3U01IcHhMaGN6dmxSWFJzNVY3NGg4SUtBVDZ1R1BJdHBvWlorQ1Y4?=
 =?utf-8?B?UnlOcytHdjB0WkY3VExsUUZjOXkxQ2ZQUTYxU0pjaVMyTWcxcEdCVjhzem9R?=
 =?utf-8?Q?MN58Gd3JIDBR++LB0EOzouTpx?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_025F_01D88CA6.644DF500"
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383347dd-f6fc-49a6-3f7a-08da5a72182e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 08:25:30.4489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHiL3NY6k/IpU2pzOZ0j4kBMMgF4CZVym6945oYubshqEF1AJcQTvqEIiaOH0H1NQDVYoXYUZvGacenyF+Wvfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4721
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_025F_01D88CA6.644DF500
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Michael Roth <michael.roth@amd.com>
> Sorry, I just noticed I had a typo in that patch which made it a no-op
> effectively. Can you give this a shot?

Ah, thank you, that works!

> +   kernel_add_identity_map((unsigned long)sd, (unsigned long)(sd + sizeof(*sd) + sd->len));

But I think the cast should be like this and it works for me, too:

     kernel_add_identity_map((unsigned long)sd, (unsigned long)sd + sizeof(*sd) + sd->len);

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

------=_NextPart_000_025F_01D88CA6.644DF500
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
BwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDYzMDA4MjUyOFowIwYJKoZIhvcNAQkEMRYEFBz7gy24H13Z
rvOMJsIfZncNKdZYMHoGCSsGAQQBgjcQBDFtMGswWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBlcnNvbmFsU2lnbiAy
IENBIDIwMjACDA7558EqCayXPvt8RDB8BgsqhkiG9w0BCRACCzFtoGswWzELMAkGA1UEBhMCQkUx
GTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gR0NDIFIzIFBl
cnNvbmFsU2lnbiAyIENBIDIwMjACDA7558EqCayXPvt8RDCBkwYJKoZIhvcNAQkPMYGFMIGCMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3
DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJYIZIAWUDBAIC
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDhI1uaaS5k4Gn9Rc9sz5GaAeUINATmtraY
xKiNweCKstw6kbF8CPefYtNLSXGdyL+f0TVKcX3OAS+f7hDR77G0QJ+Eo9BSjl9lNhVd6qRWqIof
YWEIsJXkFAjWgf4EATckrMquyXJ9WTx8z4COKn/dwv/CiFrMjpFXT6jFKu8AiD38q028kHvNeYS5
K9Z0Cn7ieLGvj4HBy/k0DhIsSHnKmeZzc9fVfe5+tMyldxk1/Pw0O/skpDM+M3lSCWKPwNYdPJRD
EEgLvbQv1nKI+5PZWJ0Bj9vSkPUMXjA/vRcIEakqopNA4ZWrofmaOsPK0zRrkj0ZLfZJKpma4DTO
Nkz1AAAAAAAA

------=_NextPart_000_025F_01D88CA6.644DF500--
