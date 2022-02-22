Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514C14BFAE4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiBVO1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiBVO1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:27:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C355B13E0D;
        Tue, 22 Feb 2022 06:26:35 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MClKhf028190;
        Tue, 22 Feb 2022 14:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BUDmm0wmcel4gD5t17YRxGIsCm1MzsF9vYV5a584FOE=;
 b=RlTQHA6BfIIscbyqZyrSh1PVRPwYxHGlRpGpA5bJBmTLaT7UYx5kQNNtJ+GLNRMS01ln
 ivs3vWlDP6nTvkos7N78bC5jwbRQrMeUlkrdjrsckBnnDjAoyE2NGs47HRPXzjX1Ggec
 wPFT/+lKtMm9UyhQCvhiKIhCXQnq2aX/eQeeyFt/i37t3FpDz6o8jfOGjUCcsKdfefOy
 SKmwhYWLaSXs+tfZhEQmCvaC/L0xpXXJgHC/5UyhAWCyuEh3EF00dVY7SBjubaSXBVbg
 eVHzaHy97GyEPGohgQOkDb967PQQ1R69g5AcsYJaBzbOnfIWjfxJMNRtGTOn+Z0gbmY9 oA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect7ahbd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 14:26:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21MEKRNO193168;
        Tue, 22 Feb 2022 14:26:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3020.oracle.com with ESMTP id 3eb480yuh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 14:26:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5waDIwYvM3ReVQYnWEenM8LkVecIEKLiIDZZGHZnyP/4VkGtTN14ge5OUKt+8c44JI2/SXn49KJ3MmfuJPBFi7dRpgIa2IfCLZbV6dQ9o7HFTEb9YzM4Cogd3SIL8jbiic25mMo5cGTJWW8ekXf6rGO2/eD4k9mfkKv57ymQwZ2ruUojAGfVlSd5QtzoRpHrUzKsJPYnr32AEj+pBdHVQBCnxHBYgAIVOX+ebQT7OdjaAiWyOPh3yHD++XUEOXYv9Jd4JAOT5aD3jovRUOxXQkXyQTmB6uErYl/MiTNf1rU9xEDucbix3yYWHpZlJNsWGQfFD0Scof51hJGQkc0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUDmm0wmcel4gD5t17YRxGIsCm1MzsF9vYV5a584FOE=;
 b=XPB9HNq52Y6Lmku+CSO23LW/4ZGwarN13osZnGgySZD0fIZXvOp5cC+XKfB/jYm0y/gmKFBJgUEd9LCZ35XlXKpJIbjoCXPGDHn+pgMd7ziASrW0ZGQITnUPbj+MRvI/iVvzI62RRVtF9bO9kKbi6ve3k5Mm1pDLSq4UyRifmoI2sfyYE6ytPIbpLyj8xWIRETVnZG/FA4TIuY5YgEVnusQ54Bcn5elg48dd0hZK5VA476MP969Pgcc4EfzPbTbZ6FSjXtNkOJFyDPUJIU4KIGyiy3+vCXK+djYcu1HsHM1/1x6HWzsjJTrTgGEVR0qwXvo4lHa/XQS0hSj58xhS4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUDmm0wmcel4gD5t17YRxGIsCm1MzsF9vYV5a584FOE=;
 b=RPeOPcmnoM2XU7kjGpKfA0+HYJkWQXspbDPPkgETMDmAgX7DzB2eUMLBnVJ7pe46B7Tr5O9Xf2X2bOh5bE5lEF3r/1DXMCwsahbsVinjWlyim0pBrl0z5RhYCWsaLcKgB16XYbvdSxzpMCqN8Mk3uD7UH/JE2iPuUGnuavBLZR0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5297.namprd10.prod.outlook.com (2603:10b6:208:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 14:26:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 14:26:03 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Will Deacon <will@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Thread-Topic: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Thread-Index: AQHYJHBq9S9Lf3gga0WdWNWpZs6RLKyeUrcAgAFUnoA=
Date:   Tue, 22 Feb 2022 14:26:03 +0000
Message-ID: <20220222142557.6oykxjz3j7fq4mrn@revolver>
References: <20220218014642.lop2ohx4ov6fekyl@revolver>
 <20220218023650.672072-1-Liam.Howlett@oracle.com> <YhPUuu+6TPMKjhwk@arm.com>
In-Reply-To: <YhPUuu+6TPMKjhwk@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ab885be-2fb6-4481-57e4-08d9f60f4181
x-ms-traffictypediagnostic: BLAPR10MB5297:EE_
x-microsoft-antispam-prvs: <BLAPR10MB52973F7CB5A4B0C4C815E6B6FD3B9@BLAPR10MB5297.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /riEuBAKggEzMx0JKDhWeZBB8aRfn+AbmYO9ilgG8LnHJfGDL7SicfFaE/i031NgkS0zMJJBYc/9wxWP/UA3IRo8fEpz84YypYoihRtvKgKBDhKxDdDBXOAx+t5Tic0rQhUVs5frU7ZHpPcSQ+PbffK14l4w2ZlImyw8n4AJWZhZgBEz6mGi0rRW7hLrJRMpqMHZfcK32Aoel8ZcCZ5x55gb2/ukvOta114Ps+OJpcbfH4FCixJ5tHBfOZ/Dztws+blPZpUXAIy8TtNw09g/ZIlAefEJpNh0lDxLjWTVCs73vhSv+oXVROfsm7ndJ7qetzh9LMTpJBAUM1ef4aTZwLq1fWB18Ovil9niPK08kGBbXQeIMzmupZd/b9OdOoS4qO0RKnrP4kY6Ce++xJiOcNrJdoJmfBHGcaAahrFVi5VV3IZy1TsDDJjQRMiWzIv09DlcSSPgW2WZUApbMIpQ/SobSRim/5ZDzmMKJJ5nIGO8L8FQ8gpakKVAPFeRyMs1hFXM99JM/qc+RXXYDZm8DztdsBXMyP5xqDEBimMfn7RvRr0daA/Fi4go8FivoMhX2qsNEVyp7ebklhJ0jk76Jm6m3tCEVi9cDVMEpLf2O6w9ZIjHdJsTTjnn/sDQnjScYsRbLI1nX2bQE/OOet2m/d3Kf9ZdvmgiVHSDrw/d3nGIJOK9GQua/UtMJ8HXchCcQXTVEpl1PxAyRWyXz5A4Mw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8676002)(83380400001)(91956017)(4326008)(122000001)(71200400001)(26005)(76116006)(6486002)(54906003)(186003)(66946007)(6916009)(6506007)(2906002)(33716001)(38070700005)(66556008)(66476007)(66446008)(64756008)(5660300002)(9686003)(316002)(44832011)(508600001)(1076003)(86362001)(38100700002)(6512007)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vpq2IlbqLCqUEm/qF+w7pCc1xuSXRsvPBO1DADCjCjWy5Jos68EwBbwqN058?=
 =?us-ascii?Q?eY4WQNQOXHhenCaziNuK+dVz0eVtcElJrNrWZII+8fBdATLjL39Ne/9Gkf5X?=
 =?us-ascii?Q?E4y1HuXZsU+FUfSHBerqksCHnKaD8zq0PQOWlru9ZakJV4n0oZiMVAlgSHKb?=
 =?us-ascii?Q?auFO7UG6WlATNBDvgDmRDcYZ9tf5wI//nKRMFxYt3FmmcjVO8ZCgH6LHqUnL?=
 =?us-ascii?Q?oZgWAMF0Pe5IWL34SzhlGxLB6Igtpgn6bCzNIDJG1MuH0rPDdqiqFUP0k20W?=
 =?us-ascii?Q?TjdTIQe7MQ4Tt+EjByy/F9ntOXuPuDuZIeY1PlerIJnAr2Blq3CueJ9ZDZG0?=
 =?us-ascii?Q?xqQB2iqzO3njUR90ieSIyd8ZCQe8xTs7wf6ndxnSisfABaXthvlK49zuguS+?=
 =?us-ascii?Q?3OqrVZ1+qEj+yE4Og81QwKBTPMBfI5yHSk0C09XH99godxKs6v8r37XBUDc4?=
 =?us-ascii?Q?jEBoNqPtEHR80yVEBdlcJ76aSmz7E/pp7+0HsNZLKcYe3AW0LDKbaeqIMUzf?=
 =?us-ascii?Q?qV7kuHa53hhIAhYltE3fAc8tLwxIVG+/g5brAZ4oVhrZf/LdTY4jFdiCS3xH?=
 =?us-ascii?Q?Au8gwVqojiSdwcNCZL5m6l/wm4N3WGh4exfW91fHX2NHhDSlJPSs8poEZLRj?=
 =?us-ascii?Q?VyYjR/Np1OCj6Q+CJ/zzsbJefT8uy8uOSFs+hSF9xZ6NMA8Vqf5Tp9pJdXgH?=
 =?us-ascii?Q?TwRT9DqCm3RdPRbhdeay4EpTI6CH51QhGg1ZZEZJmXKEE0ALArbUVdLSKoxu?=
 =?us-ascii?Q?6UwfXcr66AWpmM2imHkAcQ4XDEk+rrGizQEvrsGCe4QVenoc7PDKIipXCAdr?=
 =?us-ascii?Q?IUsv3LiDm4GaoWdsW1Vs50QY4FqLfR++fM9GqSvx9VzSyx6OW1O3PpyR3PNk?=
 =?us-ascii?Q?UfYtoFRZpx2ApjNkU3mLYI5PDjm6FGLxRuDlQE1bco7PR1YAGR/aI7FVG1C+?=
 =?us-ascii?Q?jYT3u70uJNqR3tPFjX/14KGRMB7C/B0Tj+mB3fvkB/M44iESPVdMnW7CMgFK?=
 =?us-ascii?Q?SIG9WbFAsGc6R3UaeVcD/7nv2is4Moj31+qGAGV9SJn/s5D3zRfdOnbtHgT1?=
 =?us-ascii?Q?MlfGLMc0JM1wEtniBSgPrW/InzpHjp+mwu/jrFb0UbBdDCR3bjeEDD2TSi7Q?=
 =?us-ascii?Q?6QupTGFpdtlT1RYC6f4+cPuZ5bySXRMoFk+G79VZMta+HLQPJuw2isxg9QBL?=
 =?us-ascii?Q?lXyFFDby1Q8IUA2AJyEfNs9m6yacs5nBvceybPxp1foxwEx6BV/0IYay2HjF?=
 =?us-ascii?Q?zgNLJx++LxOY0uXc1zFzUl5NSEowiYe8ym4/CcFv8qRUhWKQjCcd6x37/FYQ?=
 =?us-ascii?Q?NgOiu4QUbPn3CVaACmlNq5aXeSIIWQj4vFfRlMEMj7CBqldmUADKCOc89kbS?=
 =?us-ascii?Q?c7e73vZvqMyJBosXWfO4gTuzFeHb3OdeZtVOtWYM1QCA1RlsGn7Ql4tiQNDp?=
 =?us-ascii?Q?MFcaG2XnExavxs4UUF6e2UG227tx4LLq2tdzDCpowNqC3PFiy3xuCFEukyfF?=
 =?us-ascii?Q?kcNd/awAJVIvt4r90hFTj4TtNvVhie+eJw/6PUSZa7RZQH12ePsc7uSASEqp?=
 =?us-ascii?Q?AIYeHCxARXi2rznvxgUjkhHTdCPDcVfAdMUH6ly8o6sWRzcm2UMsBAjgsGfC?=
 =?us-ascii?Q?nOaQkx+aADAkY84Wa2n/pbU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3391E63E769BBD4DA642BFAAE1A859DE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab885be-2fb6-4481-57e4-08d9f60f4181
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 14:26:03.2792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AhaiOIVl6UBpAFyKWffLeeK2v6aowURz+q1yWfCBENvSAxgGPqMnPRwqXHQAXrHll9A+bcfF4I3L1oN4e9Y8Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5297
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10265 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=613 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220089
X-Proofpoint-GUID: dkcMrpy3MvmG5XbzU32L0294LTDhapjk
X-Proofpoint-ORIG-GUID: dkcMrpy3MvmG5XbzU32L0294LTDhapjk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Catalin Marinas <catalin.marinas@arm.com> [220221 13:07]:
> On Fri, Feb 18, 2022 at 02:37:04AM +0000, Liam Howlett wrote:
> > diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
> > index 3455ee4acc04..930a0bc4cac4 100644
> > --- a/arch/arm64/kernel/elfcore.c
> > +++ b/arch/arm64/kernel/elfcore.c
> > @@ -8,9 +8,9 @@
> >  #include <asm/cpufeature.h>
> >  #include <asm/mte.h>
> > =20
> > -#define for_each_mte_vma(tsk, vma)					\
> > +#define for_each_mte_vma(vmi, vma)					\
> >  	if (system_supports_mte())					\
> > -		for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next)	\
> > +		for_each_vma(vmi, vma)					\
> >  			if (vma->vm_flags & VM_MTE)
> > =20
> >  static unsigned long mte_vma_tag_dump_size(struct vm_area_struct *vma)
> > @@ -65,8 +65,9 @@ Elf_Half elf_core_extra_phdrs(void)
> >  {
> >  	struct vm_area_struct *vma;
> >  	int vma_count =3D 0;
> > +	VMA_ITERATOR(vmi, current->mm, 0);
> > =20
> > -	for_each_mte_vma(current, vma)
> > +	for_each_mte_vma(vmi, vma)
> >  		vma_count++;
>=20
> I'm fine with the patch but it can't be applied to arm64 for-next/mte
> branch as it won't build and the maple tree doesn't have the MTE
> patches. Do you have a stable branch with the for_each_vma() iterator?

The vma iterator uses the maple tree, so this patch would resolve the
conflict but both branches are needed.

>=20
> Anyway, if you find a way to solve the problem, for this patch:
>=20
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>=
