Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A57535D87
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350652AbiE0JlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbiE0JlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:41:17 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55AEC36;
        Fri, 27 May 2022 02:41:14 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R8aqxD027423;
        Fri, 27 May 2022 02:40:20 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3gau9d064n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 02:40:19 -0700
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24R9Wb0M002942;
        Fri, 27 May 2022 02:40:19 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3gau9d064m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 02:40:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtW+gwgo7zzBdE0xwlDFjP3c7zC8zLP9DKsfJseAK5UxvyezInPPcYt8rkzHj5FbB+21Wox6ffWhmR4aE7+HO/ALSeRYTVaBsDxZ5NaBO0Lb8qh/QUb+1AYrrZlIOHs20FpJu3SHlAsI7UyL3Eay1skJnlRrWqCPqoZXnKPXKp575mJ++T2+0dKgrDOKqL3T92zY7N9ZnrOrRFvTX0LSuE1DGDyNDg1S7dOUXFBpwSnjo/NjGtwvKb3yXu5mR6WS3wBZutaWYu0q0u7CFEb0KA5CqQDVeim6RcWkhGE6oXvfeXR46amduTNil8YLCnoa7fOdhen3XYgRVJ8XlS7V4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTt3xsmnn2Sx4+5oLOeaXojtL2A4VtlWGGje2ykkbP8=;
 b=V0H75WqEehpqWzouxnKCIvi+p7SBJP+bYMuwN9GUyJXzwZDzKxrBDXkrpFq9/y5sR6TSo231FbouWAPqhAdf6x8xdxRkaSO8MekBELgdZODGPFOFokeDxv9SKFVxrveb38AJumFVe7cyJ+cqjJtGvwx5GZJWZfCPht/YzkxyohQ5DMyOVrsFRdvxUOdil1VQmdgSncs57FWDOcopOF4YWFSaqZsKWiC/jkruzkBYCx64Z1QOns2b9SC9savEeSgFSOAdpgGk+DH/0hoFZ7IrO/u/PENW+shWyM34V7IDZBZVEjESGYs6A9su1IwV2s6CBuLTvYSkILKb/qhSg/APbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTt3xsmnn2Sx4+5oLOeaXojtL2A4VtlWGGje2ykkbP8=;
 b=GvnVP5dW1A9wWOvMllZGVNmQCjpM89fEjvhtx+ZcRX7rlKt12z15x6yFtvgvVAGmy6IGvrNm7Zb5GpimH2odT0Cmzeezg9tioG7+I9AXNMbSA+HBUt+hFZM/uifEG/vyLyb36+arabhEsf9Vi2fwx7maDM3Jd7YKEJyO0hsVCi8=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by MN2PR18MB3463.namprd18.prod.outlook.com (2603:10b6:208:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Fri, 27 May
 2022 09:40:17 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::e4ab:7780:fb1a:8fda]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::e4ab:7780:fb1a:8fda%6]) with mapi id 15.20.5293.016; Fri, 27 May 2022
 09:40:16 +0000
From:   Shijith Thotton <sthotton@marvell.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Arnaud Ebalard <arno@natisbad.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Harman Kalra <hkalra@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] crypto: octeontx2: fix potential null pointer
 access
Thread-Topic: [EXT] Re: [PATCH] crypto: octeontx2: fix potential null pointer
 access
Thread-Index: AQHYcZ+WFeoConjOvkuT00xCknB1x60yYbgAgAAVDHA=
Date:   Fri, 27 May 2022 09:40:16 +0000
Message-ID: <PH0PR18MB4425FE9F1CF5BA4B7F981F94D9D89@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <da89ba20819ad3ca6b99f9ef056f2bc1b076dc6d.1653632699.git.sthotton@marvell.com>
 <20220527081928.GO2168@kadam>
In-Reply-To: <20220527081928.GO2168@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f52f56db-a827-4a80-23f9-08da3fc4e829
x-ms-traffictypediagnostic: MN2PR18MB3463:EE_
x-microsoft-antispam-prvs: <MN2PR18MB3463452356F4399758BE24EED9D89@MN2PR18MB3463.namprd18.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8h/t/4ZQ3ZVGLJx7m9IICBKDNifoP59x5PGB3vI8575CjE5cbhbrn0gWk0/XiKgNPVHK5a1BIYPBd/bZVt1HT1WfZrzHn9/qoWQ8loemFudzEsHL3lY4v7wM/AUGStPOcIrzUFYKS/Nbqa5VyBosYdIPb0Opask8EWQl0p55/GxUW1Mb3LOgUybRl5OEbsbY2+wfv1ajDKiXBSVVngpQagL2HF15pSW+u61cfOdHy2IN4Zeg86+yBNe/IjLkSWhewdAwz398GI5Qv3qV9EXd2HCGE7hGU5ryYl4qtQiaj6Lafs7ss9cVNGOFbKran9ixCgeTphFomAoJsR+klF7Ndz4WYgXtUhD3wKmR3j+qlye2kh4KfIXJYJWiZ4eb3rrpJuuPiQUToiBoAdG+UJ81XmiPkBLNCvD+8FJFS0lyz7oAhxTsXoRRwazUZLaLwhzzV9XQCSqlZ5bJuSHngpLUGO2Y1mObFGYpFq0voBAiToa0G+A8rh9Y55iFqRPr2L5yAHVvBmdCQJWDDYNVft9en/YCbYBZTbGZ8bHwGjo+rvCMOO6K9Gbw+d36RBtQhSizSPitJzskwhomug9q1GpaHonS/3eynHDDSZSnmfh787YN3WylkO//I6HWCCycJfVVzK8bBJFIb+jTBgPYsaMXkXi+sCrtvO5FCyX3eoVkx2TW86t5Jkpm/ZYxI+7FwKB7GVm4zmapgQUtugNrrR1owQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(64756008)(66446008)(7416002)(7696005)(6506007)(508600001)(8936002)(33656002)(38100700002)(38070700005)(52536014)(2906002)(54906003)(8676002)(9686003)(5660300002)(55016003)(122000001)(66556008)(26005)(186003)(71200400001)(316002)(83380400001)(66946007)(76116006)(86362001)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?47hvu2o8s28ZiuQzK/RwZMfm2aC7L+1g2HSgXG2IAQAGyjFiUuN9TIfYmPk/?=
 =?us-ascii?Q?1xqIQ7Eh8rbgsbHTAigEiOTKqBckVgRtsgci06Vtp5mK2y7jkzxhu2JCOGYv?=
 =?us-ascii?Q?vmscABjRX9IYDBgcYeoVgy2pXSt7qOALpz6d3YE32nBHpBbqLZTp3z4r9ior?=
 =?us-ascii?Q?l0HzCipid8zbiBy4Bs4iujlyejVqJ0zeqaFDnJPRjVelHnzXBiOEJLTCCAMZ?=
 =?us-ascii?Q?POqk/ZKQ0Ar6CUc7cvLt2MsUAQNpPxPCpGpR+9p26Po7Fy2VU1hNAmwjj4bM?=
 =?us-ascii?Q?manKdedRofYb6SXVM7ZPlShm1R+4eZV/CUJIHNzz20jkzdWmM8nkLLEKjfK2?=
 =?us-ascii?Q?SaitKM52fIQdMjT7SzQos7usl+FNIjxltv1ycnbEHFZ1pSSK7XZvsdOKWNd4?=
 =?us-ascii?Q?k7YrabDNFjqHOMiWp7ZcDSvH6P1ZuXZaywrzaZlyM4B/4iyVL7Wwy1BnABkp?=
 =?us-ascii?Q?9bOhJtxMSytS7MDRcyds2StX9EG4EveZsxUwHt7Sr4vOnTt3dptSJsEnlJXb?=
 =?us-ascii?Q?Ou5anS53YR5mqluj5kGWSqtUcVMooCl2NKweBUAdvYANAVCckbFnhbqv7zC6?=
 =?us-ascii?Q?8KMAQORshsCKCg5EYJ20yTMACXs9DxMicl78/AVylfxuTVn2ciEwF5C3IU6s?=
 =?us-ascii?Q?4RO2ZA4z6mblipuBCTZOPU2qYdxm9NZa4PC4ckiJRkEEvDNw8xL+zLIind+z?=
 =?us-ascii?Q?MuDYdqoDweZpOS076ErGFMs3CwZSsnNjqPBiViDJBy6WTdt/yeslgQoAoyXK?=
 =?us-ascii?Q?H61HsuGUEGDV7N1NZLAYUEjUs5pwPG7aFwLgLR/jX5em99MfH4y2jT7yl/Vd?=
 =?us-ascii?Q?Y15LkzbHo4Lo2d6uH7c0GI9XkpcZctc6U70G95Ug4KM6Vt5bHgrd5am410F4?=
 =?us-ascii?Q?ZpsOQgjn0NUy13R1NTrB3nS0cLuBddfQ+kiXBiL8h4xO2OuRrvp6qKEuXgVS?=
 =?us-ascii?Q?Qmk2BDoiWCPMVvgWwaK2b2H6I3z83oFqCaYYjPBfPHPbmLQ8+VVlCtK34yKV?=
 =?us-ascii?Q?4s+8F40O0pSuc+PGBa4Eg+TvPJIGqmqOoABWoS8e4UttfpPjRCx9ehvlVrRA?=
 =?us-ascii?Q?eF5TlOHlb755bJhu6/6lX/YeemSCsHzdkpqdygUlWoHMfTBotR9IXsgRqFP0?=
 =?us-ascii?Q?CCi50vbYu9lj/AQfF6EzZOfY/yPMe4KxAoHDGhpf2puOxdIxLi3307f/QvRy?=
 =?us-ascii?Q?LUotSGWDAvlh4604RE5EBfb6g8FYm9v6tB+qqHDIoHbIwFKhK9zslEwBymQO?=
 =?us-ascii?Q?nyEiXsWx0JIbfTNCchJIrK4Oa+dGhkAJkhukO704Mx1HwL/E/QJwZajNlr/3?=
 =?us-ascii?Q?G9Oao2Q0Kenz+GKsDyCYM/yV8jIj0j/hl9F9h7UJ9lVYq7RQrh6B3UYA/pTr?=
 =?us-ascii?Q?l3j3a7Ylo7Sa4TbQrLFyHJg31YKh8evHX8pHQW9Me7NqhnUJtPbXOZoBrhmF?=
 =?us-ascii?Q?7DNjKW4ZQ2gI53AkzbjT70GSRgoUVd0tJlxMKg6Sg3csHpjDkmm18z3g04p1?=
 =?us-ascii?Q?QD9cq5H+e281hs53WKJhjFzEvh/Fd2scrgGX0b9n/MBdK5Ufef9CiTBhiGiM?=
 =?us-ascii?Q?XL8yQombSo2B0uBdE9aZOwvXhb8sF/Jp9fnT8SDq2lnQy/wrifTAc1CH8vSh?=
 =?us-ascii?Q?uk63k4ZmVn/BjCu3EA7r3WTXXqFKVDM73RhUzDX2edflsDmfaC2/tF2IiEGM?=
 =?us-ascii?Q?bLdFKDF+nFtkFKpP1BjHd96LKHphvkK/K8cHEPlv5EYlxH1/SYtPX3wBtfxJ?=
 =?us-ascii?Q?TXjOOgSvSg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4425.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52f56db-a827-4a80-23f9-08da3fc4e829
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 09:40:16.7184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MIVc01ziznNj/UYLCranJAR7F2qk9kSzlRByo+HOsA9UI2XqwExWHjqiz/J8J6oTwfnpf1pEK4nBy01ZpikFRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3463
X-Proofpoint-GUID: 7Nhhx40GKDjROSkoEbeLj56UVk5E5DVd
X-Proofpoint-ORIG-GUID: IxdcRznHdaryYCg25llTPt_4p6iMVvrQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_03,2022-05-25_02,2022-02-23_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Added missing checks to avoid null pointer dereference.
>>
>> The patch fixes below issues reported by klocwork tool:
>
>Don't fix false positives to make a tool happy.  Fix the tool.  (Unless
>the patch makes the code simpler, then it's fine).
>
>> 1. Pointer 'pcim_iomap_table(pdev)' returned from call to function
>>    'pcim_iomap_table' at line 365 may be NULL and will be dereferenced
>>    at line 365 in otx2_cptvf_main.c. Also there is a similar error on
>>    line 734 in otx2_cptpf_main.c.
>> 2. Pointer 'strsep( &val, ":" )' returned from call to function 'strsep'
>>    at line 1608 may be NULL and will be dereferenced at line 1608. Also
>>    there are 2 similar errors on lines 1620, 1632 in otx2_cptpf_ucode.c.
>>
>> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
>> ---
>>  .../crypto/marvell/octeontx2/otx2_cptpf_main.c |  9 ++++++++-
>>  .../marvell/octeontx2/otx2_cptpf_ucode.c       | 18 +++++++++++++++---
>>  .../crypto/marvell/octeontx2/otx2_cptvf_main.c |  9 ++++++++-
>>  3 files changed, 31 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
>b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
>> index a402ccfac557..ae57cee424f0 100644
>> --- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
>> +++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
>> @@ -703,6 +703,7 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
>>  {
>>  	struct device *dev =3D &pdev->dev;
>>  	struct otx2_cptpf_dev *cptpf;
>> +	void __iomem * const *iomap;
>>  	int err;
>>
>>  	cptpf =3D devm_kzalloc(dev, sizeof(*cptpf), GFP_KERNEL);
>> @@ -731,7 +732,13 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
>>  	pci_set_drvdata(pdev, cptpf);
>>  	cptpf->pdev =3D pdev;
>>
>> -	cptpf->reg_base =3D pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];
>> +	iomap =3D pcim_iomap_table(pdev);
>
>I don't know if a check is required here or not...  The comments to
>pcim_iomap_table() say it is, "guaranteed to succeed once  allocated."
>
=20
Will keep the check just to be safe, as allocation/kmalloc could fail.

>> +	if (!iomap) {
>> +		dev_err(dev, "Failed to get iomap table\n");
>> +		err =3D -ENODEV;
>> +		goto clear_drvdata;
>> +	}
>> +	cptpf->reg_base =3D iomap[PCI_PF_REG_BAR_NUM];
>>
>>  	/* Check if AF driver is up, otherwise defer probe */
>>  	err =3D cpt_is_pf_usable(cptpf);
>> diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
>b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
>> index 9cba2f714c7e..b91401929fc6 100644
>> --- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
>> +++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
>> @@ -1605,7 +1605,11 @@ int otx2_cpt_dl_custom_egrp_create(struct
>otx2_cptpf_dev *cptpf,
>>  		if (!strncasecmp(val, "se", 2) && strchr(val, ':')) {
>                                                  ^^^^^^^^^^^^^^^^
>We know it can't be NULL.
>
>>  			if (has_se || ucode_idx)
>>  				goto err_print;
>> -			tmp =3D strim(strsep(&val, ":"));
>> +			tmp =3D strsep(&val, ":");
>> +			if (tmp !=3D NULL)
>> +				tmp =3D strim(tmp);
>> +			else
>> +				goto err_print;
>>  			if (!val)
>>  				goto err_print;
>>  			if (strlen(tmp) !=3D 2)
>
>The rest is all the same.  Likely or definitely false positives.
>
>regards,
>dan carpenter

