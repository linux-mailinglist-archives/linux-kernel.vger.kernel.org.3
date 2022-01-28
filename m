Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF1949F818
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348125AbiA1LTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:19:38 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:9658 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348078AbiA1LTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:19:31 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20SB5Fqh008150;
        Fri, 28 Jan 2022 03:19:12 -0800
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3dusebmepp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 03:19:11 -0800
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 20SBGFKe006312;
        Fri, 28 Jan 2022 03:19:11 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3dusebmepg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 03:19:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOIPNdnpoGq1mYDtj8zeXFfGa+vrwBTh41IdygxD0u3tHlEFz/6b4an4wqb6kDGVRDgceG41mxke9sbVp3+twmadENAuhSn0tPqCBUCG4Ul+ntCAJAhuud/4poIA/208x/WTNzf1ZMMrYWO6GY8mMPsRGrY3TEoinwS5X/Fz2seorWwCFInIzXrpayN3glq19IxrebRonWOGIOWnnzigpjoYG6Oa7EXP5brLOT3syWYVnRMculqAEc772mR26EClw4DwB2q3wwf9R4GmnnM7TT4Th012fWEbG/yfsxTgF0mgRkCzp/E/oiFTTRZnTSpRRJ50PRvlRhZY6TZCBt5Uuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiOO/jixUNV/TSMz7m4bYCFnYUChW21fd4xa8OAjSVw=;
 b=C/HEWDWXx/t4iQcOgtcGhB142u3dRAR5OnBl+MQGCICgZgT1x3ksQlAeNarhLqUFpWBjq2xlgd+mTCkiFfKJO46GnK5Ve9zdBKNyPWEJJkDT7qX/yPWZqndEQyZ31Box6E9JOrc2V+yxn19fbEI35upkbDa1WSXcrWGSdUuT62W7xx+CmhMyzxnfg2OVasyq83NP9HEg0KMlNnDMSmwncn6okGboWrdTEBO8irdiISb3R5QNm4asdcsyja7iA/WeVmhe2SYv/VDu0AUp2NM1KoflFRtrpnxPAHl7o1OMwoznrgKxqdOqY1Bb5Tjf8QTHmhosFSt7ILncUbyXJDEE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiOO/jixUNV/TSMz7m4bYCFnYUChW21fd4xa8OAjSVw=;
 b=cJ80IqBG30T6Iv7FZ1TkTRcgUbT+kegPhaFFExaGNlT6AubZmOVmu/RDMjtdTPRk3XTCUcs5u4anqYHkY5tZjE2QeCKwps1fFedahbK/pC7MnRcmoP3wrgnCehQ902nhGEkjjXyGeXQP9XQFaeuveUxYZhgYuldhKIAQknIzN3A=
Received: from SJ0PR18MB4429.namprd18.prod.outlook.com (2603:10b6:a03:37e::12)
 by BY3PR18MB4593.namprd18.prod.outlook.com (2603:10b6:a03:3c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 11:19:09 +0000
Received: from SJ0PR18MB4429.namprd18.prod.outlook.com
 ([fe80::580e:4993:a290:71d1]) by SJ0PR18MB4429.namprd18.prod.outlook.com
 ([fe80::580e:4993:a290:71d1%3]) with mapi id 15.20.4930.017; Fri, 28 Jan 2022
 11:19:08 +0000
From:   Shijith Thotton <sthotton@marvell.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "arno@natisbad.org" <arno@natisbad.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Srujana Challa <schalla@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "chi.minghao@zte.com.cn" <chi.minghao@zte.com.cn>,
        "ovidiu.panait@windriver.com" <ovidiu.panait@windriver.com>,
        Suheil Chandran <schandran@marvell.com>,
        "Lukas Bartosik [C]" <lbartosik@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2] crypto: octeontx2: fix NULL pointer
 dereference
Thread-Topic: [EXT] Re: [PATCH v2] crypto: octeontx2: fix NULL pointer
 dereference
Thread-Index: AQHYDu506+NGMiNG1EOgNzFnpf+DMax39iqAgABczgA=
Date:   Fri, 28 Jan 2022 11:19:08 +0000
Message-ID: <SJ0PR18MB4429BDEA6327DB256A4AD38CD9229@SJ0PR18MB4429.namprd18.prod.outlook.com>
References: <3ef09bf0c4adf7bc33f01f60cb8ce96e8f77b58c.1642786900.git.sthotton@marvell.com>
 <YfOCkY3RL0qqn5YU@gondor.apana.org.au>
In-Reply-To: <YfOCkY3RL0qqn5YU@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7a4db91-f71c-41d9-2c51-08d9e25000d6
x-ms-traffictypediagnostic: BY3PR18MB4593:EE_
x-microsoft-antispam-prvs: <BY3PR18MB4593D5D7E3D554C84A709FC5D9229@BY3PR18MB4593.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Pmvua7f1G4huqzQK3ctDPODPGjaZPWhV+HHaFX+w3jw0lR35dysZJaOYGSlIasdfFqPO418ZE7zQ4Gk+4QSHl23zSMtAPhj5JAquxVplQLnbKiGyFECq2IQUF/rl4g7J8kr81/We2v3stz0k5QjtFnQ9nvYm3woEq3cNtAh1xDePLt3rHPLIGPzgZRfXN1WUF7pGkjnf6KEZ2vxkBlBKG9/yWZcRirZ91VBKEOb+Xfr9so2TvS+A5mo/0PSaZqPyyT2O+NGzcsauE+QrT1y+J3U6K2V7iVrO1IgLAlkJQH5n7gVvxDaseyi12tlHPRrAEnvwMZZLpvKe19kDF9vjtWvKUahs5KWqPyTkgIuRUqg909A94LyiYprRB7ReY9S9tk6FY4/rUcyF+1AjOhot7GWt40i0UE3wUmIb+LljAo73o2YmkR5c8k5oSfSnXj5AX22/xAqFK1OGLWY+TXVS9E4bRM6dltSddKn9KNCp7LCKzJTPCyPKued7/3dVLF3ZvCY6rLgMRJObKFnqhAW0ckuI0kKYFr9sDONkIS5IxiWNJzmze+IKZqbLMjYc9w4ldAI3Ql5W0/W7Xnc9/5LHCXcmE/9RNuC8/s7PObzydkGqvW1Tc/FupmUAcAZmT/Cf2w0YXccLc2m6VPPBZzYQtMNRvceMHcLGFmaNsx2peYWVjDFhtkG3IiQssyXVNRAtTeY6RqDXPTydiRIu5E1jQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB4429.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66446008)(186003)(26005)(52536014)(66476007)(66946007)(64756008)(76116006)(4744005)(33656002)(8676002)(55016003)(7696005)(6506007)(122000001)(8936002)(5660300002)(71200400001)(4326008)(2906002)(9686003)(508600001)(54906003)(38070700005)(316002)(6916009)(86362001)(38100700002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g0hVPl7aEcr3++n3o7ieDkx149ENIW7zexP3I7TQLjRjGAu4vaRtDh3UmLoO?=
 =?us-ascii?Q?e4SuONX/IhMtZlwHFAVzbA0uX/7VYuQ3ykblAB6CkJCbMNRaCLgxMMrTks4f?=
 =?us-ascii?Q?VoM3RZnMqGJEQ6y8cRwUHlUa99l0iUJ3neUS8xIep+rOfcLM4HSK7LEWlstA?=
 =?us-ascii?Q?scC9X+TkNooZH551GS8NaFBXZyEvbeeH7IWTEIypz4Nm6QjlKaiAj4fzRTAy?=
 =?us-ascii?Q?eD2iwf4i8x79ZluO/k6lCFwMTJ1cVwraB7GtxIn8PLs39OujF9UBbP+D38b5?=
 =?us-ascii?Q?hX/rLAOl1rcQE4SfE4DsJQhYEZNaY4qFGTqTl9t15vdVp/u8zNc0n1XzyR53?=
 =?us-ascii?Q?vEBYnYgq7zMUW6ZyUihlRl4g04mYz82hJyQZiuKTLq14NI655Ppm1iusCxJB?=
 =?us-ascii?Q?9sox4cxVFzDfokoCDLvCmbJPfxtqCfQnImKyFmSw23mbXEvO2OxOrhH7z0Wo?=
 =?us-ascii?Q?ucvg2bJfezmCEgghw5lMzZ1L4nYo9wU0gE3qN+76tt1rfgbGqDZaaKZx/lRm?=
 =?us-ascii?Q?fP9hpXhN5BvGXxCeqoFZT9Uhr/F8hgwN9+z+86AKQftY1cCGtZ1/S3Vhj4hU?=
 =?us-ascii?Q?eLEuDb9d7ZnYaseVSI9TMFc7SdkcS0370vMp54ryburpV+6WesHQWuSUBkSn?=
 =?us-ascii?Q?Jvpkgal8ha9JT+Rx3PzBfZ4VbUaRPIoPXSuHZrQtXs8piS8+kSZCk82OQq7H?=
 =?us-ascii?Q?n2VumHmZXkGRPkSeek3i0Tnfyqo5p8Xv9LhtgO3aL+bBf3CYGjiKvucyWVwA?=
 =?us-ascii?Q?w2jd7QeicG9y38MROvOGVpQcZNDgBHAYFGRbe4vgbOhXLwixUzS8X2/gDHyl?=
 =?us-ascii?Q?DyzBRN8Gt8f/B95FSj45afLrQBXHoPbBHTDIC2RXY7rrccqFAJooLrRtHn2b?=
 =?us-ascii?Q?I1/2I4W/qy5H4O1sshnGF39pVFO3iKUBgI1ljTzcN34Po4jC8eGn3fWZq1t7?=
 =?us-ascii?Q?FZralJueV2XDvc3iGZGQ9vDpXodwKZtl9PRObi7CMPyrT73g5HRZ1w9toOmz?=
 =?us-ascii?Q?QZCs+yiFoeExqsvBuGsVRY9w+e0yT5vn66ccoXFzTNjuGCw/8p4NYFCLJXqV?=
 =?us-ascii?Q?n3ZEJ6R5qaDz0VGT0lgAY1zZT/vZv/sgksCITqNOXQ1YzmhYxKThfqr9Byf3?=
 =?us-ascii?Q?fsLNEqHSAgnNc+3ITiWyVFKoS0DWLhsBCqF9Jlj1ggEQIZtahlPz8bso1kuS?=
 =?us-ascii?Q?Knc8WDEpARaJOMZpj3cj12yzLjxZNAl/3tHk8hZqvXiXbF8hYljSY10kNZr/?=
 =?us-ascii?Q?VyuJOpa8SBDnge3KGUCqCEmooGhSWYaDHcBUezkVtdGEFslQUGRToTfn0FDb?=
 =?us-ascii?Q?BCgezHBivxAs91qXLIGhJEwy1LGvicrNlH8KAUwjBirXZTvq2/2zu6aTewVH?=
 =?us-ascii?Q?jgxniRbrShRSrf+5LSIUyJC5+R2CXi/b4VxF4ZiEzMi/wygFmT+LkSQZGMkk?=
 =?us-ascii?Q?80wvriap9R4uy0+MM2A3w0bWKWLUMEyqbo6pZH3cFGyG40vWPRjDHdDThglq?=
 =?us-ascii?Q?IT9ki9Ne8b288pK/x5Lp8izvrBx2i3eHQtvu7lacQg0kiO0fj3M0ik26Iw9k?=
 =?us-ascii?Q?qNxqM/UimMHvPQdLwoOSKIO5G14T+dbBVA8x6/E87Hs2VScXExoIThkzpi9o?=
 =?us-ascii?Q?pQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4429.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a4db91-f71c-41d9-2c51-08d9e25000d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 11:19:08.6901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5zRpmW6ELy73g84Um0uqnYSlI5YlGqiEBwMRpWylK4fptTYsLKFduHxhL6xIhy2zPxP6SZ8xAWcgfVKPkvYkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4593
X-Proofpoint-ORIG-GUID: EGtQSZgd62ys_ZIPtxIkr5uleIaNfB_w
X-Proofpoint-GUID: Qv5BozjnQEoh9XI_vm0jrwyVkc686DxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_02,2022-01-27_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
>b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
>> index 2748a3327e39..620fa9b23e78 100644
>> --- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
>> +++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
>> @@ -1650,7 +1650,7 @@ static inline int cpt_register_algs(void)
>>
>>        err =3D crypto_register_aeads(otx2_cpt_aeads,
>>                                    ARRAY_SIZE(otx2_cpt_aeads));
>> -       if (err) {
>> +       if (err && !IS_ENABLED(CONFIG_DM_CRYPT)) {
>>                crypto_unregister_skciphers(otx2_cpt_skciphers,
>>                                            ARRAY_SIZE(otx2_cpt_skciphers=
));
>>                return err;
>
>A better fix would be to make the driver actually work with
>dm-crypt.  What exactly is the issue?
>
>Even if we have to keep the kludge, please move this into Kconfig
>as a dependency and simply disable the whole driver.
>

I have tested the latest driver with dm-crypt and found no issues.
I will send next version without the checks.

Thanks,
Shijith
