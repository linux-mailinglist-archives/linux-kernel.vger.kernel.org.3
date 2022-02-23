Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759E34C0983
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiBWClG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbiBWCid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:38:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5183A5F8F9;
        Tue, 22 Feb 2022 18:33:13 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MMo6nx018680;
        Wed, 23 Feb 2022 02:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JXuwKfa9oVPPr5uNuzE1BiAGl+hJjyzHJlRoD33hqas=;
 b=vYuTh9z1vNalORwl7LbUn6f+pvEKtr6aaIdO15pingyBj7JpJ7HxtRwmOyigSh1oy8dD
 gdVHUSgJ0xEE413EBy8O36f/fmyEBz/MNdNgHKkoNgm9OIrR0ewUOY3UqHYf/cpkTgfA
 FbP33l3V5Ig/yxLxQY2p3fv32mVCnYpemvqdA8KsFu25WT6NoOU0R5zSROkOpWAbweIp
 arTuHoEnUf2cLxdCBV9zO5A67TeWzEAMc5QHM+5c7GX3qpfCUOHo1UQsFHaUo+W+maea
 lf7tTjiwWZ3Ei+Cq65Lu/WMoOzx38xepEPJTbz9342eu+ZPz0zgHtSbdGx04OAIN9YaG xA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx2v02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 02:32:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21N2GTpl136671;
        Wed, 23 Feb 2022 02:32:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3020.oracle.com with ESMTP id 3eb481um65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 02:32:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oqcb6KP9M5kwC81/hCIx7xrcwMo+MNJ714hBwS1RxdfmqM+7BaFuW3bj+F3yKZxplIs6f9mKS1QaBqbBXqeaLOG2r1DAV9hZz2QPXcPqK5rvL3lmNy8qF7UgNkam8P2XA2Z1asL8cliqsI5kbVRwOtXynCN0mbWzNIpsXAu6QZL9vR2Nf7M23YQ4DqC3RcWE08APOINO9VYmXiEZa1gXf6g+jp98xxqlbj2TIdchhB6jI1P8liXAoZx0ao0PsnBB//5tL6mS8eGSn6tAQVclMCy1uAxswWKYD5iSbSL1HXUlaHDA1Lgg2fI15LEac4rBPTqFFLpB6X/TUtXX2napcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXuwKfa9oVPPr5uNuzE1BiAGl+hJjyzHJlRoD33hqas=;
 b=MX66TC5ef+v/Dr7zwtgD5w71pRNXA0MW2M4vL5xuoPJXQ2oOuF2yZwqs9/MKhme6dPiNW7VOIC/bq4e16U+0xxXr33hk0WhjqNJYQABS0silmdSd0+sXM9hjgktYgkCtQhAPA1rJms8JLghheGf7GV46N2P0LLmc0U4aSY3lJfHD86xpVvZTbexo5W6ySM58ZbGDTUjpLB9AJGyKwfImwv9X5frv5X18bpHnIOMRIb14loj6eQ37B/cq0RB59zAmfHNNIdnT3wufjQl6Z/f5c2pLzYvtyrpuZjdIAM0fMjbgCG5bnzxZqZldUVSifudwNc93xABQRe+0p9B3VR+kXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXuwKfa9oVPPr5uNuzE1BiAGl+hJjyzHJlRoD33hqas=;
 b=rtQ/1416sdkVANNFwPaA0z9nbBV+cWiUEPNNCP21kicg2ZU58VQwRRaNyGv5kmqWmg+RxCYHvvy+zP94MhfY5zi0Qrvu3nsyIPJUN8YcCGnliPjFsfQ5iRlplV6BO1CZP4w6Ss5fFMwgWjinx8GAPr4a5gIT3f/nF2DKzcuJrto=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4634.namprd10.prod.outlook.com (2603:10b6:806:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 02:32:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 02:32:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: linux-next: build failure after merge of the maple tree
Thread-Topic: linux-next: build failure after merge of the maple tree
Thread-Index: AQHYKE6tDfn+/8vPv0CF/d3zua/XCaygaqmA
Date:   Wed, 23 Feb 2022 02:32:55 +0000
Message-ID: <20220223023245.uicyzttakfq3k5zf@revolver>
References: <20220223004525.2034065-1-broonie@kernel.org>
In-Reply-To: <20220223004525.2034065-1-broonie@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fefdf2b8-8c90-41c9-e725-08d9f674cc56
x-ms-traffictypediagnostic: SA2PR10MB4634:EE_
x-microsoft-antispam-prvs: <SA2PR10MB4634E0ECDDDA5261E2337B64FD3C9@SA2PR10MB4634.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i7b04ZW9H+Rx8fSJGwXWZ8d9qldbyXGSS4DnS6aYD9w7txAzQ35tv9Ou/MceINtCwa7lOuZrc2cfWWFOBzpDjlj3Mr+WWpa35GOhvjysPy9+SKkUbexnAl1f9XoIIKhdrN27w1QyvzlsjWf2llgQmlmAj/1VbW5rpwz0CbLhrP+yVHl4G7UoW3ROscWd/+h0gBuraJKZUKZdIc21M+fxTuiqvHp57cPKtLNylB2gZaohuvPz9akisT/I5DVunFCK9A8C+eXU4dAGk8+9vEGdDm36+3xKfGtm+W+QvaMN9E6aWYg4+FXlRt6oOeLG90uhJ6551ykKFdh345IWobAw79t0xJd3Lkj4YEBrpplNvEFjMom/8xJvebypnqoHgQt6a3jwGu7pSVDZYjyOo2snR9VTPCKZ4gva7+z3SZJjmBk14AFDUCKTu8TAU1CxaZ1EptJpaJ4vhH5T4Iu26Zhnf5yprMCZ0cSLjjhQF5NbK11NuJfOHq15ccA0AS10JSPO0KbE8GdW7WA/1Es3ZivvD+bDM76BKCJFp54kaSHO4apL5ZT0huQvdXEyFUmT+Svd6iNWBJstahwFTcpYVBhVc8R0RWBvkxo1gi7IrbK3Cp1nNu/2ieiJxhikIl6RHRkW9NceGhsX6IdMs2FP7sxVBtIp6xVk/kFK4pUzFvGLcupSvxgy4zb16hVZXQI2IDbJFfq51hbeRaYH437EDB9IQnX2rxbKZ6gTl+xVCa/GHMyUiYoNrwd4xh5BbawnKToJlE8LjPczxlqFkvcALii0zco9uT4RPfJvdGk9zdcJfKo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(71200400001)(6486002)(966005)(38070700005)(6506007)(53546011)(6512007)(508600001)(2906002)(38100700002)(1076003)(186003)(64756008)(33716001)(5660300002)(66446008)(91956017)(66556008)(66476007)(54906003)(6916009)(8936002)(26005)(4326008)(8676002)(316002)(44832011)(122000001)(86362001)(83380400001)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nNPTf5E7kWoKKUGxrfNwpLWolfHkRb7uDEpwb9k3MhYqSiVZg/yfNIm6Uaz9?=
 =?us-ascii?Q?C+ICVf9Z0IFIAUSQ4q6aPBU18137SyLtfVpbdFgAsO9UuuJqO9GtlC2kLl9f?=
 =?us-ascii?Q?IQHYh1pMRlo2IBO/FWE+9ZNyNG8nNVYoNyW0dlAIDOmF7sw407kxqT+XWoz/?=
 =?us-ascii?Q?y1ai9ZaT3DBNM7p3fsiS0BmxgSWraPw30Q46dXHXeyUfo0CugTNNUbPrkXwZ?=
 =?us-ascii?Q?9vvDwC10K5vgsPctRA2hsC/XUnkbORu3CGBtDqNOG3p9zTPRs/3E7qRCr0Tf?=
 =?us-ascii?Q?e2z/nu0LcLgzgaqj5TFs9EbdOSvno2JDY6U2+Egpv/WKH3OkNjwlWe0ibNkO?=
 =?us-ascii?Q?nC/wviXwb8Zu9IrEDuC6AbT+puD0Uy5qmNT+i54LceSSIfDtFvyAUO6Q+Jrd?=
 =?us-ascii?Q?jFLVPgPSmRftKA6EiyQYG85qMsA+ZwdYtzY3iztaet/WX6sdSsvpPMsblhUg?=
 =?us-ascii?Q?P7bu2ZQutJEnq5VrDTrGIM3N3zWKcW2DUPXPWZLh0Vhh0Am/XTTT7Ut9Ds1g?=
 =?us-ascii?Q?2vAiV06Cmjk/K9vZtXIfe9OXR0e4O6BzEhDDJZlgoSj9Ip9qEH+l/VJkoFIG?=
 =?us-ascii?Q?B3VaJ5EpVG/2OrAn+AdUROwm3BYgYwFT6JV+9nbEi++70IxcGJNHxnQp/M3g?=
 =?us-ascii?Q?JeULLKBwcXzo7W0dz9zOVc+0yhFVaoN6rxlXxQ0TXCXlx2F6cCKdizUH4Hbr?=
 =?us-ascii?Q?CTNu8Mgn6cR7qMmnBNy+HtfJEEdWfIFGZdQmko3cyGacmmvonBxhb2W1AjWO?=
 =?us-ascii?Q?nhIzC4UHmo+6gloXwfpRrsK6Gqgvfm4hNZeXrdnqhuWYuAXxQPbm0X9BGK6i?=
 =?us-ascii?Q?C1lBW/8hgYlpauOZmQrv4kXiPREvuR2PjzGrRn1rVC6DC73zCEQ76PVic15X?=
 =?us-ascii?Q?8Bshr6uTLce0g+j2m3Hr5RmfyZ/sA3a6NpPeT5qkxKBH+ZYmP5Za9qFvwqV6?=
 =?us-ascii?Q?9xrU/46HsVnDe0/Y2wF1gUVjlbVNJJO5ehyKtg1Y4wAJzHPZokL7Yczqz1SD?=
 =?us-ascii?Q?nQgiLSk4jeIXMOfeznWqhiRATEMQOs4IQmwtWVC3egu1buFgWRX65bsJ7sS0?=
 =?us-ascii?Q?XA9aguu7X8DuLTEr/c5j0JvGEUrHqzW7DFjLHeAK3ylHGfOj7mYGaJh9jIey?=
 =?us-ascii?Q?pT9h4Y1Stg6joQ7NETtqBWTP2hMglCFBYHwB9BUrqKcoQFA+JYg6GVtyvX4p?=
 =?us-ascii?Q?V+bF5P/TPbAzxoVxl3ktDWJ1APw4X67u+IoS6u0Dal2cAV/XGX+jH9VKBHSr?=
 =?us-ascii?Q?FXIVsKsL1bzVMh2/PhKJKi5oDOJ1JkM7ecZYQNZZZ9fVh5Ggocg8aU6MKMLy?=
 =?us-ascii?Q?1u4Nyv3k7rKiGUNHUc448EbxafJzZK9AqAUAqDUyJ5faNerFLLHUR9mv3xzD?=
 =?us-ascii?Q?1Nx9Yw/dyKBTqhQVLqmhwf1hy9rEBeeDsMWvsoEZXa150GUD29tuzc0UqqvF?=
 =?us-ascii?Q?nIfY8ep6Mi+YsWsBoWIFEywN2sH/9f/kubKgBOTJuDyJFR5XBZMY5adh2Vl/?=
 =?us-ascii?Q?anf/b/HTDJ1ybzxvHX/7NshkO+w67XALGt1POWw0gV68DBKcJxgvVLOmOwza?=
 =?us-ascii?Q?2vtEIMEnZs90PKLW/Kf3feK9J1X/7D55FgG1NVdrpUFFXN/qUKNzOoJ3wQmt?=
 =?us-ascii?Q?dtQ56jp8Is9xjzid1NuC0fI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E9586161F326A4A989FB633F0BF09EF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefdf2b8-8c90-41c9-e725-08d9f674cc56
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 02:32:55.3897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jEVoKJ8U7n5tqDLKAgI/uJAmeUM8wLH7kzt7wEQ/CQPXTRi5swTY4KV4tCi49mGP6cuOneX7pR+Jv92cG1VWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4634
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10266 signatures=677939
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230010
X-Proofpoint-ORIG-GUID: uaih8jqgaxO5Jqbba92KrwSJOzm-aVq_
X-Proofpoint-GUID: uaih8jqgaxO5Jqbba92KrwSJOzm-aVq_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* broonie@kernel.org <broonie@kernel.org> [220222 19:45]:
> Hi all,
>=20
> After merging the maple tree, today's linux-next build (KCONFIG_NAME)
> failed like this:
>=20
> /tmp/next/build/arch/arm64/kernel/elfcore.c: In function 'elf_core_extra_=
phdrs':
> /tmp/next/build/arch/arm64/kernel/elfcore.c:13:21: error: 'struct mm_stru=
ct' has no member named 'mmap'
>    13 |   for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next) \
>       |                     ^~
> /tmp/next/build/arch/arm64/kernel/elfcore.c:69:2: note: in expansion of m=
acro 'for_each_mte_vma'
>    69 |  for_each_mte_vma(current, vma)
>       |  ^~~~~~~~~~~~~~~~
> /tmp/next/build/arch/arm64/kernel/elfcore.c:13:43: error: 'struct vm_area=
_struct' has no member named 'vm_next'
>    13 |   for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next) \
>       |                                           ^~
> /tmp/next/build/arch/arm64/kernel/elfcore.c:69:2: note: in expansion of m=
acro 'for_each_mte_vma'
>    69 |  for_each_mte_vma(current, vma)
>       |  ^~~~~~~~~~~~~~~~
> /tmp/next/build/arch/arm64/kernel/elfcore.c: In function 'elf_core_write_=
extra_phdrs':
> /tmp/next/build/arch/arm64/kernel/elfcore.c:13:21: error: 'struct mm_stru=
ct' has no member named 'mmap'
>    13 |   for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next) \
>       |                     ^~
> /tmp/next/build/arch/arm64/kernel/elfcore.c:79:2: note: in expansion of m=
acro 'for_each_mte_vma'
>    79 |  for_each_mte_vma(current, vma) {
>       |  ^~~~~~~~~~~~~~~~
> /tmp/next/build/arch/arm64/kernel/elfcore.c:13:43: error: 'struct vm_area=
_struct' has no member named 'vm_next'
>    13 |   for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next) \
>       |                                           ^~
> /tmp/next/build/arch/arm64/kernel/elfcore.c:79:2: note: in expansion of m=
acro 'for_each_mte_vma'
>    79 |  for_each_mte_vma(current, vma) {
>       |  ^~~~~~~~~~~~~~~~
> /tmp/next/build/arch/arm64/kernel/elfcore.c: In function 'elf_core_extra_=
data_size':
> /tmp/next/build/arch/arm64/kernel/elfcore.c:13:21: error: 'struct mm_stru=
ct' has no member named 'mmap'
>    13 |   for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next) \
>       |                     ^~
> /tmp/next/build/arch/arm64/kernel/elfcore.c:104:2: note: in expansion of =
macro 'for_each_mte_vma'
>   104 |  for_each_mte_vma(current, vma)
>       |  ^~~~~~~~~~~~~~~~
> /tmp/next/build/arch/arm64/kernel/elfcore.c:13:43: error: 'struct vm_area=
_struct' has no member named 'vm_next'
>    13 |   for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next) \
>       |                                           ^~
> /tmp/next/build/arch/arm64/kernel/elfcore.c:104:2: note: in expansion of =
macro 'for_each_mte_vma'
>   104 |  for_each_mte_vma(current, vma)
>       |  ^~~~~~~~~~~~~~~~
> /tmp/next/build/arch/arm64/kernel/elfcore.c: In function 'elf_core_write_=
extra_data':
> /tmp/next/build/arch/arm64/kernel/elfcore.c:13:21: error: 'struct mm_stru=
ct' has no member named 'mmap'
>    13 |   for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next) \
>       |                     ^~
> /tmp/next/build/arch/arm64/kernel/elfcore.c:114:2: note: in expansion of =
macro 'for_each_mte_vma'
>   114 |  for_each_mte_vma(current, vma) {
>       |  ^~~~~~~~~~~~~~~~
> /tmp/next/build/arch/arm64/kernel/elfcore.c:13:43: error: 'struct vm_area=
_struct' has no member named 'vm_next'
>    13 |   for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next) \
>       |                                           ^~
> /tmp/next/build/arch/arm64/kernel/elfcore.c:114:2: note: in expansion of =
macro 'for_each_mte_vma'
>   114 |  for_each_mte_vma(current, vma) {
>       |  ^~~~~~~~~~~~~~~~
>=20
> I did not identify the commit which triggered this. I have used the
> maple tree from 20220217 instead.

Hello,

I had generated a fix for this on the 17th and sent it to linux-next
[1].  Alternatively, the patch is inline below.

1: https://lore.kernel.org/all/20220218023650.672072-1-Liam.Howlett@oracle.=
com/

Thanks,
Liam

----------------------------------------------------------------------
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Thu, 17 Feb 2022 21:16:53 -0500
Subject: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA iterat=
or

Instead of using the linked list, use the vma iterator.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/arm64/kernel/elfcore.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
index 3455ee4acc04..930a0bc4cac4 100644
--- a/arch/arm64/kernel/elfcore.c
+++ b/arch/arm64/kernel/elfcore.c
@@ -8,9 +8,9 @@
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
=20
-#define for_each_mte_vma(tsk, vma)					\
+#define for_each_mte_vma(vmi, vma)					\
 	if (system_supports_mte())					\
-		for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next)	\
+		for_each_vma(vmi, vma)					\
 			if (vma->vm_flags & VM_MTE)
=20
 static unsigned long mte_vma_tag_dump_size(struct vm_area_struct *vma)
@@ -65,8 +65,9 @@ Elf_Half elf_core_extra_phdrs(void)
 {
 	struct vm_area_struct *vma;
 	int vma_count =3D 0;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma)
+	for_each_mte_vma(vmi, vma)
 		vma_count++;
=20
 	return vma_count;
@@ -75,8 +76,9 @@ Elf_Half elf_core_extra_phdrs(void)
 int elf_core_write_extra_phdrs(struct coredump_params *cprm, loff_t offset=
)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma) {
+	for_each_mte_vma(vmi, vma) {
 		struct elf_phdr phdr;
=20
 		phdr.p_type =3D PT_ARM_MEMTAG_MTE;
@@ -100,8 +102,9 @@ size_t elf_core_extra_data_size(void)
 {
 	struct vm_area_struct *vma;
 	size_t data_size =3D 0;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma)
+	for_each_mte_vma(vmi, vma)
 		data_size +=3D mte_vma_tag_dump_size(vma);
=20
 	return data_size;
@@ -110,8 +113,9 @@ size_t elf_core_extra_data_size(void)
 int elf_core_write_extra_data(struct coredump_params *cprm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma) {
+	for_each_mte_vma(vmi, vma) {
 		if (vma->vm_flags & VM_DONTDUMP)
 			continue;
=20
--=20
2.34.1=
