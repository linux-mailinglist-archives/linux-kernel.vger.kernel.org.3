Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42134C3249
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiBXQzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiBXQze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:55:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9A522B19;
        Thu, 24 Feb 2022 08:55:03 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OFWbgt007287;
        Thu, 24 Feb 2022 16:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=exn06IlWyHEzFy63SVNFnsbBPo+i5JjG4ZylIiqqa+g=;
 b=lAw72qrUxZ0HR+fl0Ayz2wCyksCvRlVBhjvwiEdXus2kxwukh5Q9M6JA1RdLylilRw83
 YrAS5ja4sEOLdtjjF+dE5TT9LTyFun+j/HjOlqdyiwQagNivx5W3BKkeXv493w6GG2jK
 O3glkvOLk5Gy/l7YbCtYLACHe5Co+Az8JWIzGesAryhnEOh3dxz9vB4A9kuk2nrwgCYt
 hU8cvuZFaRR9tpFtmFWGEkingjM+5B1FX4S4XFHE+VyAjML1+ualsSST7fJSEORWQNmd
 XpehnjYjwAf0FxaXqGLC5/tt+V3UBQI0txfFbzJZiGpqvQ091SII31GsDYrwejo5V63w NA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx80hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 16:54:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OGUYQc159634;
        Thu, 24 Feb 2022 16:54:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 3eb483ukwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 16:54:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtNeibnkGELRPAvvFxcEl962Pnq71yY0TCElvcIEBsUui0I5ObMDBZMEQyLLeA547Aau2or0ZsxP+gPSMr2ShoLoHISyfIvpfD/iW+tgltly+gCbZWEpXAmRiuRn1m0EfrURusIvHQKRQ9S9Yy5rEIqipdkGyXCWqsEt82j6PF7mXsjL7qjiKMeFTdxk0hZPUOnrL9g05pfln2qyHlmx/1652ktLYcPKCkkPYJiQPzRZ/c3Rrbys6KPDHIs0cJxr29WssCtaIB7Bt5GrwCtEso0oLHaGR2kFAhaqdd6FNH6+gydvAl0euG2aXZHD4HVG2/uaOmJrQdqtgVSvPFSygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exn06IlWyHEzFy63SVNFnsbBPo+i5JjG4ZylIiqqa+g=;
 b=W2vjRiNTLBXUQHnN641tV5jclkE8rhdMFwRcmG515l+C5c/InbUxEPx7UktAQAXsZShHrDBm4vSuFn6M6djbV0onv2f+pV9K7NS/CPIl1oxstK0YlUJ+sNyc1u2Q9f4W7112F6Rk/yo79jrGPnjw4ZiN2OUSpOgoU3eaWop/IkGJA0ifd7ub7oLlA/hu3cJ2mJeF6hvjHcd90s3MLYOCcqn3s1U24pHTr7zw+BUOO149AlSKOaKSSWsGzLqiuVm6ujuc+nBY4pXj963M/jpp1s5ypyFFTNqrtT2ZU5P66ewtd16bysVB28gobQMOlvzNTAxwcCrGWa+HlDmKwhaNUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exn06IlWyHEzFy63SVNFnsbBPo+i5JjG4ZylIiqqa+g=;
 b=H9hUUcJF0c3lHZ7EYNnfWccJmz1wNrNy9Wo0v3j0mhDOy9VP2k/8eCm5k1CpO7s1niwDzJO3aMBWwj4cbtFL3XZ1pnpAN0GWCj4AyXKJLem2tsfUx9cb/u9XtNTKoAChqw0YfnTwf75AbXpypVEkc72MPvyfOQ1g3fnNbHRZSTg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3200.namprd10.prod.outlook.com (2603:10b6:208:124::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 16:54:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 16:54:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>
Subject: Re: [next] riscv/kernel/vdso.c:123:27: error: 'next' undeclared
Thread-Topic: [next] riscv/kernel/vdso.c:123:27: error: 'next' undeclared
Thread-Index: AQHYKYoVxjaEXtw9fUOXgBAuDy4zo6yi60gA
Date:   Thu, 24 Feb 2022 16:54:36 +0000
Message-ID: <20220224165426.kihlm6bzwuvbjaot@revolver>
References: <CA+G9fYuhipgPsHetpvBmD4GO7KGfhSRRAAgN2ZnoFUWiCKMy6Q@mail.gmail.com>
In-Reply-To: <CA+G9fYuhipgPsHetpvBmD4GO7KGfhSRRAAgN2ZnoFUWiCKMy6Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f518e89-7fee-4f19-6523-08d9f7b65700
x-ms-traffictypediagnostic: MN2PR10MB3200:EE_
x-microsoft-antispam-prvs: <MN2PR10MB32005F804309799C2F02DFAAFD3D9@MN2PR10MB3200.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jmRB0Kf/9xPbIzZkyZNzT/nIw8rebK6Bz58jhtgpGwu6F+QXOgfzCv5frGQvsHYN/CBfS0B6XFJvG7XGfuZoZGmLrYHhBu2JKLjDpkSEg+4oXw/SZWHJ3eelJe7upiHUC8SyDEO37eYkllsIN7PqV5okS5O2/603Zp1eTBnuqS12v+J+C3zwNWY7tlWtP+nqphebMQrt4DhotFSZS+hD32KdS79BPGC1t6+15gWeLaIhPdVOssCAy8OKmC8M3GdnVU/nsKlfnxYk2sJEbVBVA+OTgTskavMd/eHgkHTGjCpC2bMW38wAMyj6OaRk1DVQPfxeBGzhWjv4DRFPH/0HcnxY+3stDeaWc/3HkHEAcXGRcW0UutUp3qtbFGXaOln/e+IdRxEk4ZQFCMsu9ZILbtg4hpu8xflRvjAgiJytZzhLTYaFswBZI8vZgKdhnwyQzIHPIs0QpOs5X7H4g3JvIxLlhVdaAJSp7PRvqvOzzqaaATUDRIj2lsB36SN24z2qtM3MfalHkKQQ91QLNU8ZfdcAPVdH8WymYket5EjbchqtdWWV6pljsZHPQDR4ooxbSQbN/93wQ4tVPkNgKgPc0fsfZicFnjn/uFZqhhB6V8NS/L/0bX6eggUZMzdBslphenjzpepBLXGuaPC1outfI95YisPMKbtYrwI8RPFd8C7mHGNSDHLNe9MSAU4sWhNYK6mvx1O0mQbWZhCrwtuBS++8W28HOqVaSZPWwz0CzbECMNncTRmKKbKWznPBok1iPppsiHgH8OvCCgGqV/HR9ljEwtriOYWWQBsY/6H5ZU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(9686003)(33716001)(38070700005)(4326008)(66446008)(8676002)(76116006)(66556008)(66946007)(64756008)(66476007)(7416002)(186003)(44832011)(26005)(6512007)(6506007)(91956017)(122000001)(6486002)(966005)(316002)(54906003)(6916009)(71200400001)(508600001)(86362001)(1076003)(2906002)(38100700002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+oMVUlzeAN6fAMiE0OuXGE3wRbHa9sxRcS4kqrhmxwBNHqqlJ3n/BgbI1kMA?=
 =?us-ascii?Q?Wu7q6/WOXlF+QtMvNs5t7uczNavHMO1WLwn69jQ6hz7fe76zWV9qE8ulrwrQ?=
 =?us-ascii?Q?gyoL7ZtEb/kX4i3nB6aB52M3MRIIL9JOmKjEZoAcOPbcVF/oaCNl6LqWFgf4?=
 =?us-ascii?Q?PBpb9qFQ2JtefDGB5CbAd0bA+mMmbxgNhGfRQP6IunkTx8FQn4cyA45RtcMj?=
 =?us-ascii?Q?Gqdg9PZJMLJZ+cRLXYn/3dpbmZS2NnQ6fODBeKYOfjS1T/DQlEqii3A620Q4?=
 =?us-ascii?Q?zddAeXGTaOpGYByKE23UhXaClrwRcOwUfZDVQeAYW+uqgaW6ipX3PZcbU1n3?=
 =?us-ascii?Q?zckKdNeHIHBlZYPLfAG4laCCoXpJQkrRYJPHpgH5po5aoDWGTP+7jS7v+0Lf?=
 =?us-ascii?Q?KdHj8BXYSbAUciLxkkgQuvVTCFHihobIe7lQprjJnEBO///NRUxdBnny0SFK?=
 =?us-ascii?Q?eUZ7GkwDpfuf6rOCSFBRtan6CUhtdeiNKinIVkmOrwZ2knTxPxIDeLvwL0IU?=
 =?us-ascii?Q?E1jNjQ7pLKCuyKc34gjyeuPjx3E3E0WJ7cqWxtAQkj6WeN05zuJMZ3u+pnwN?=
 =?us-ascii?Q?GJ8itpvxeZELAnjOdwDyLsUPG+32dPcvZMKQTqBV73SxcY46SQhDGVzPUrUg?=
 =?us-ascii?Q?I4wHaaKS9jc3Fm2F/p525/WuvTvzJ6L/L7wpe4iOldTglBhBH63VmyDlAgS9?=
 =?us-ascii?Q?aDTfBPC6SKvghs+cBwE3pC64dQQxlhK6HV0V0lp5ZeT//WAu8ReeSLMgLHds?=
 =?us-ascii?Q?6eoaDTdEsht/v0XAYtcU+4vjDli2AzxotVksOardZGxVL67cYreiWWcWaMol?=
 =?us-ascii?Q?tU5ctzfejUrS4KYQpu0PrNj0n0GJ/gooN+XC75v0vCmpqoCiCsfuVNrMblLq?=
 =?us-ascii?Q?KMl/dc9wLXUAib36FL7wkk3M/oO1yq41D5n7XjprQyHPaHTsMF1X7RnJR3bu?=
 =?us-ascii?Q?fWUcUULbtZyjT7XjIbhKGqYGPWVXvEcfSluXF3ek4eTHvZjfedU7Q44hgukt?=
 =?us-ascii?Q?LsdU87tXxgqZgyPiyM1VTANv0DJ3uQ4oo6l/ms6GqMzg5UAnKmIs09B3LLxv?=
 =?us-ascii?Q?DdnRlDxC7esz8j8nB0Kiz1xgLeIwvtN8E3zj7BnqfMrd1tQSj6gKllfqdVsP?=
 =?us-ascii?Q?8vy9JQeL90qmeDy3pZfQ6HyAInzGh1LAVYARFpWiVcUxt1ljDOCq/ox5GL33?=
 =?us-ascii?Q?QASL61x4s5rz/TsyNue+/2/Qj4I3AJPLE0DzYbGvvQ9T7spfa0bKcpZlm8h8?=
 =?us-ascii?Q?1CWfWyvUFkbje5wjrCSzi85kFGeCxZA7c/AKBJvBILUf3+HQgks0Ws2AH2A/?=
 =?us-ascii?Q?0MjY3+Ejqs21tSAuW957reEhqUimviChaWKsAzBYkouFPpVym2kqd7oC1tTz?=
 =?us-ascii?Q?KfSNBC7fZ92UVRdWFhv4JJcUYK2gu3Fy1UcCfVzG3G4zIbax/U6ahwv5EdhF?=
 =?us-ascii?Q?rs94XFa0VJoz4vGsLzLbX1tL43dk0i+K4Ax94q4EAdUUH9AR8EOaUFhEC77D?=
 =?us-ascii?Q?uvdj0+J/rwbxVRqBdwcwUSNFlfURQwwveZnp4+AadrQP+mij9lE0dMI3wZNU?=
 =?us-ascii?Q?UKeuQTINnE+4ZF6p00kYx7ZIC4wbR5zg+JhM+0j1dfofdwmlZZ+BAy5DNGEk?=
 =?us-ascii?Q?suixob1Ei5kudNq9C8i0uu4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA28A8CC7BCFA64882A696C451DACAB1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f518e89-7fee-4f19-6523-08d9f7b65700
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 16:54:36.4450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hROOBqYG7bDZOwJMbzd+DyrS6evWlmR+yVNDceqoMGlAdEV5bE4Yc/d9BY40L7CscbgqeSpP3Av8ZNd2wKhV1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3200
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202240096
X-Proofpoint-ORIG-GUID: 9g2lmq0OZpvAxF_aHDYui_258C-5FmWA
X-Proofpoint-GUID: 9g2lmq0OZpvAxF_aHDYui_258C-5FmWA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Naresh Kamboju <naresh.kamboju@linaro.org> [220224 09:23]:
> [Please ignore this email if it is already reported]
>=20
> Linux next-20220223 arch riscv builds failed due to following errors.
> Build configs:
>   - riscv-gcc-9-defconfig
>   - riscv-gcc-9-defconfig
>   - riscv-gcc-10-defconfig
>   - riscv-gcc-11-defconfig
>=20
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: d4a0ae62a277377de396850ed4b709b6bd9b7326
>   git_describe: next-20220223
>   arch: riscv
>   toolchain: gcc-11
>=20
> Build error:
> -----------
> In file included from arch/riscv/kernel/vdso.c:10:
> arch/riscv/kernel/vdso.c: In function 'vdso_join_timens':
> arch/riscv/kernel/vdso.c:123:27: error: 'next' undeclared (first use
> in this function); did you mean 'net'?
>   123 |         for_each_vma(vmi, next) {
>       |                           ^~~~
> include/linux/mm.h:685:49: note: in definition of macro 'for_each_vma'
>   685 | #define for_each_vma(vmi, vma)          while ((vma =3D
> vma_next(&(vmi))) !=3D NULL)
>       |                                                 ^~~
> arch/riscv/kernel/vdso.c:123:27: note: each undeclared identifier is
> reported only once for each function it appears in
>   123 |         for_each_vma(vmi, next) {
>       |                           ^~~~
> include/linux/mm.h:685:49: note: in definition of macro 'for_each_vma'
>   685 | #define for_each_vma(vmi, vma)          while ((vma =3D
> vma_next(&(vmi))) !=3D NULL)
>       |                                                 ^~~
> make[3]: *** [scripts/Makefile.build:288: arch/riscv/kernel/vdso.o] Error=
 1
> make[3]: Target '__build' not remade because of errors.
> make[2]: *** [scripts/Makefile.build:614: arch/riscv/kernel] Error 2
> make[2]: Target '__build' not remade because of errors.
> make[1]: *** [Makefile:1971: arch/riscv] Error 2
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> Steps to reproduce:
> ------------------
> # To install tuxmake on your system globally:
> # sudo pip3 install -U tuxmake
>=20
> tuxmake --runtime podman --target-arch riscv --toolchain gcc-11
> --kconfig defconfig
>=20
> --
> Linaro LKFT
> https://lkft.linaro.org
>=20
> [1] https://builds.tuxbuild.com/25XO99nwfQgKrWKz4yfBPYw0wyU/


I have fixed this for linux-next.


Thanks,
Liam=
