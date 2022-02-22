Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7C84C01B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbiBVSzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiBVSzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:55:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C8B1375A3;
        Tue, 22 Feb 2022 10:54:54 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MHx6gb030158;
        Tue, 22 Feb 2022 18:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IHNEx76Ki0ytcSyQeW+bt5F7Rr2BICUw+nVt0RXKIv4=;
 b=AnAKmBCsCjyjd6W1UGEhcEk5nvuI1q8TOmKMzwNu6sF8az6cCKpTd4j8qIfaYwg2Cfrx
 noGiPgjPzD2iivsSfkt6afl0wDsbpz0rTdOEldCs+sviMEzbOQPAVer3Usu2z07H3GhQ
 9QfwM0BYHrKSCoVOM851kxDBK32jM4yzyn8Tygl95IcRws9iPORWFs4z8B+YXm/iWHyR
 bH96ayQpInbaHUVMGbRcsr/9Rziz/6CvrvqN0islSpfBDE0uoWaYYxXkPGGKArNvC8D9
 yMurO9x+NfGc/pu3Ei44wrYgb3R69bbdaKaA/1YE3gFbjSp48++JDcdoOT4WR5yC6OD1 VA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecxfasbxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 18:54:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21MIkfsb118202;
        Tue, 22 Feb 2022 18:54:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by userp3020.oracle.com with ESMTP id 3eat0ncrc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 18:54:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEnPTOzCwKzjZkcKgy0q/x4/rbLXoqqhIuXdUSgBPePWq8+JUN19a2hRxvLn6CD1+RyUg+3n6MDXoxS1R6o4svbKsJCq63rQ5oqP84qb6VXkuQ9G9ivgPw47u6YwsuodnFSdrgYyR0DcTVjnbUhU7fvEv/om5ha+LE0bVhl9J6z8xnLEEjEsGf3xYWgdqhoP9bxeKaiIPux2UYeLf7nw6ImpjP+84GpPaY75ZOhT90sYfhCrgmzyQSwjBHYN+IDXCzYdxrKPZadsCC/mHdyY4VXTRWbrjFR1whab52UcDkKNrhBLllaljL+Pfun1w1B4LyHm5EWhq+DhIYWp5CCz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHNEx76Ki0ytcSyQeW+bt5F7Rr2BICUw+nVt0RXKIv4=;
 b=iV9UNzmMDMclS5jgqFbKiyRC7XhN/44+9sxT7KUTAnXHbuUu+xQ5o6oJewUAERIjM7getbq9fOFOFMLM5eMwstTWIzdtp6zFp6WCziyeHjEurCSxBQRuCnWmkckpygwEqh4PWrCyCKMY0AnssE1nBZDpbAuWN/iUt20+lKUxdZW+tRzHCMR8tccqc2kEcqUQ1suCI7x3dkvzqxBldvTqaycPpPd+TH2ULvQHCVDzHLrbV9pNWi9Qxb2TOeTCroDkpO2p40rNJrwOhdpX4KSp5K3ubGe61J8T6ZLxqHK0YE4bf6A23LBYUeGePyhxRbCwKKXye7qoanOUDDCDu7kkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHNEx76Ki0ytcSyQeW+bt5F7Rr2BICUw+nVt0RXKIv4=;
 b=I2VVEWdjm7Z6bk+Lh3wxffIoXDBAQoCiKe7VUzkgz4PGWdbK6fvKDdA5f4/UC14QNBu0gTHfoBsXEQz+/0XXo4VNLgd+Yiov/PCGkh07AIQL2JIl8D5LAG5wk/Pv4fMO5IhfU3bnSTbO4ugHyzUx9kthMGDa/m5vKSkfKZFAKHs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB2023.namprd10.prod.outlook.com (2603:10b6:903:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 18:54:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 18:54:38 +0000
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
Thread-Index: AQHYJHBq9S9Lf3gga0WdWNWpZs6RLKyeUrcAgAFUnoCAAB/xAIAAEoeAgAAYlQA=
Date:   Tue, 22 Feb 2022 18:54:38 +0000
Message-ID: <20220222185401.jntcd4g62pamfxvr@revolver>
References: <20220218014642.lop2ohx4ov6fekyl@revolver>
 <20220218023650.672072-1-Liam.Howlett@oracle.com> <YhPUuu+6TPMKjhwk@arm.com>
 <20220222142557.6oykxjz3j7fq4mrn@revolver>
 <20220222162016.GA16436@willie-the-truck> <YhUcywqIhmHvX6dG@arm.com>
In-Reply-To: <YhUcywqIhmHvX6dG@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8b52190-7b54-4062-050d-08d9f634c702
x-ms-traffictypediagnostic: CY4PR10MB2023:EE_
x-microsoft-antispam-prvs: <CY4PR10MB2023C0AA6EB37E5D79F5745DFD3B9@CY4PR10MB2023.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ba9OhhRz+7cmXdKggLG3ZBYqlBdKSUEXKNde23NaocJu3caCzn73R/YfdOq4umzjczO3ivq1KrKoenEqpIUd9fTADCA+QuDfnO2zu9HocV1CV4+rU+bhARnOG8Cl70ZEcHLd+mm7x6ppSuywuq4aXz7+Gk2CyJ58o1Gw+d4McAAj2ZuYf8sf6WYUf0P/VeODZlhFZsXNVQEyqud8/tK5aa173vxjz9KFXSBjYLnsDBFK7DtuFT3+aTEUeFGjC5806Qudj58uJXFh1CLQENwhqh27SZsy+rFEYNZD1QhD295fMEIrp0gv1gWtGSTw9jmQg3xyUYK1AYY+pGFMqiGo9O9Atbny6HYwHl2c4uznm2CJZ7GA/yougb/qWoDRR//pcLpnD+sO2pmMe/Oon2qWXg0U8IB5Heh5DP9ajO0c/HMFUhcrIGK4GhqCBMdqUH///EpfbJ8WW2w3+Mvam96WuqGJbUVsPE3oHA/9LwHRVuxvexb7x68J6ruMdMtfhGTKVBjP40ASJie/ZYF7J7lgWpx8gYkDKUwgKB3ulwBe/5p0Rl2xX8w4mNZLfBHYzh9vNUFuOH+eaHwM5ZiREcwLWUFpDmCg2PnYU42coNmp+AuvH2qPNOGgEsoa8xT9xCo6oEV7L8KfR95igLlgZin4wqrSFjev3M7gRqxzfYP9efYWfaPJ1Io0xZ/pK17syx6Nzcl/SW/nKuujfVqSEO0eTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(6506007)(8936002)(2906002)(6512007)(9686003)(66446008)(4326008)(66556008)(1076003)(26005)(86362001)(186003)(508600001)(122000001)(6486002)(44832011)(38100700002)(64756008)(5660300002)(8676002)(71200400001)(66946007)(83380400001)(91956017)(33716001)(6916009)(38070700005)(316002)(54906003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cjGJJ69Wl2oot3vQGegb+G9omeUy8gOv0oGKfK1wodrOjMUnA9fpeuW17g7x?=
 =?us-ascii?Q?byymTX4UxIsZtYuOq1z9IsXpnqRfozBYLT8U1ZjtubQR/l5020oZA8RPtuQk?=
 =?us-ascii?Q?XfXiwRN0cvwynJ5T4Ok4nsTTaonyywV2GNhg4D8TQ4hK0MhAkShwfSFAykba?=
 =?us-ascii?Q?dZXlHT0Ab8+5cZM5sWDcU+coBjOBJ/8z6kVUgSRCCI+dI7qjQQN/dd+EhJiI?=
 =?us-ascii?Q?TLGEBVh/uJjis74yWvudg76yGrBNahvtnhBHl5kTYXaLdwoP8PXA4pTgFG/4?=
 =?us-ascii?Q?SSgi99VCNJaHEmpgw//Agt8PmE1PWbaxe1QkpRCdmSy2bz8/oflT0q4li2nC?=
 =?us-ascii?Q?XBWgLHS+LlUyaUfJX9tzncfLjVAncfHtJvEtsz3F5zT2m1aY8+Pc0XLtK8N+?=
 =?us-ascii?Q?+GySqzTh0TpY1+IMuhCD2e4gDSGAm+lxxnXJq4h5p3TSyrPNKFrpFTIpSoJq?=
 =?us-ascii?Q?gCps8Cv6QQ37R5xWELdu8KO6AlpKoA81GnRaY6WpejvBrGGinvwflbpaNl6e?=
 =?us-ascii?Q?dK3SuSh572xVR5ecBCJyeSUbl/uF9riFMGzRfm/lxGe+als07XcCbxyTixrl?=
 =?us-ascii?Q?NobMRDh2oblzpTeZirCFoYpzuDMDhSYlSMBKXuXfPNT8914+NZTIXOmkQTQg?=
 =?us-ascii?Q?Z73jCxUWK1yNQ7wJMXiNoXjKTa8jS9F3Npxyt8avZViFQxK12YkNkZp3hxGh?=
 =?us-ascii?Q?vUdmEZvT1h/a/AgK8nrMJEtxgKWnfASB2xZOIsCYBHMNPbbecALxcSbPTQo9?=
 =?us-ascii?Q?di00vNP34bMoWvGgk8ZjDL9kaXd1CVx41piUcMNg+8G1yj8LUnnzW6aGN7Bp?=
 =?us-ascii?Q?9F12kdKrzaGl44FnTtYtGVGYhuFVxcHXVZMzMU8BMHY7TfBKcyXl87V0OQyY?=
 =?us-ascii?Q?7VkfXunCi9cdQvHURzQ95B5V5Qq/Xi+DncrNOgmv6/oTwFv38WXYxPiCfbrw?=
 =?us-ascii?Q?Zi0uYFz+/HKLXxp1JimgDItRdpe4poJ2s3xDzVJZvARYLT8Om5RqVqjKfck5?=
 =?us-ascii?Q?h7FUhkqkrFbkpXyv30Pi99FXIVXtY3XXOpAb7lOL13VE0zqvWKtoIhVgTTp6?=
 =?us-ascii?Q?cUCoxIkMfSdyT3iiahIiumHqD7Tv0Wd2U/bTyeLtVptS5TiHbZf/Fx83lfRE?=
 =?us-ascii?Q?iO/suXEJbG035mHPYELItEufE/f6ApT3VxKx62xS6+ZnYbDLjRMCs+/xMtwo?=
 =?us-ascii?Q?YqqSB0sOVYaEgDYKJF7eQkbiCCNMI6NjXbF3CQUdWwB+CzdZkcLApZvqfWbR?=
 =?us-ascii?Q?bTuC/d15DewTIc1PIiwYd7yDbzwsz67ieYHK7XH6BsG9CpzCJjCDw+oAkJyU?=
 =?us-ascii?Q?RyWHhMHaMu/WLY0ItOPi0qoRmUBsJJec23qM5ClhtVu/+FZACxikjAGZHOuc?=
 =?us-ascii?Q?lNAG8pru1euZT0dM74Fl4QDzuSwLeuJ4b918vtF9x+IWyCbVtIlYI04NPSmm?=
 =?us-ascii?Q?t1y6O8n8xynFJJVCKAi2X6pDL2m4vPGMmV6xxStSuyGn6ZaPQcSS68kE5Qka?=
 =?us-ascii?Q?RPgnauzWdyylMGKMj3GYecqPfClKryOTgTxFZQWRxBlD7FL+h5+0Q3+0/jSm?=
 =?us-ascii?Q?5Hi+pghw078nzQbf3NQx7vzhE6Mh4DrFJwDP5mrbRQuOzkVmjpCHQ/LCcsQj?=
 =?us-ascii?Q?FBuj7KpbD+GZCLLVqLyW1xo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FCD01ACB96F4944EAAFEE16B2279A114@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b52190-7b54-4062-050d-08d9f634c702
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 18:54:38.6385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LT/EQTbVvB7SmLRgKOD477Pz+UnNMRg9HIXLJ0VUArRxQkU1/Ja0BEJNoL1tbER38neWyddWK9oTEgSLyb1K4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB2023
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10266 signatures=677939
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202220115
X-Proofpoint-GUID: TGVy1sKohjt4qukf8AbunKQKXnIsERgy
X-Proofpoint-ORIG-GUID: TGVy1sKohjt4qukf8AbunKQKXnIsERgy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Catalin Marinas <catalin.marinas@arm.com> [220222 12:26]:
> On Tue, Feb 22, 2022 at 04:20:16PM +0000, Will Deacon wrote:
> > On Tue, Feb 22, 2022 at 02:26:03PM +0000, Liam Howlett wrote:
> > > * Catalin Marinas <catalin.marinas@arm.com> [220221 13:07]:
> > > > On Fri, Feb 18, 2022 at 02:37:04AM +0000, Liam Howlett wrote:
> > > > > diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfc=
ore.c
> > > > > index 3455ee4acc04..930a0bc4cac4 100644
> > > > > --- a/arch/arm64/kernel/elfcore.c
> > > > > +++ b/arch/arm64/kernel/elfcore.c
> > > > > @@ -8,9 +8,9 @@
> > > > >  #include <asm/cpufeature.h>
> > > > >  #include <asm/mte.h>
> > > > > =20
> > > > > -#define for_each_mte_vma(tsk, vma)					\
> > > > > +#define for_each_mte_vma(vmi, vma)					\
> > > > >  	if (system_supports_mte())					\
> > > > > -		for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next)	\
> > > > > +		for_each_vma(vmi, vma)					\
> > > > >  			if (vma->vm_flags & VM_MTE)
> > > > > =20
> > > > >  static unsigned long mte_vma_tag_dump_size(struct vm_area_struct=
 *vma)
> > > > > @@ -65,8 +65,9 @@ Elf_Half elf_core_extra_phdrs(void)
> > > > >  {
> > > > >  	struct vm_area_struct *vma;
> > > > >  	int vma_count =3D 0;
> > > > > +	VMA_ITERATOR(vmi, current->mm, 0);
> > > > > =20
> > > > > -	for_each_mte_vma(current, vma)
> > > > > +	for_each_mte_vma(vmi, vma)
> > > > >  		vma_count++;
> > > >=20
> > > > I'm fine with the patch but it can't be applied to arm64 for-next/m=
te
> > > > branch as it won't build and the maple tree doesn't have the MTE
> > > > patches. Do you have a stable branch with the for_each_vma() iterat=
or?
> > >=20
> > > The vma iterator uses the maple tree, so this patch would resolve the
> > > conflict but both branches are needed.
> >=20
> > I'm not really sure what to do here, then. I think the conflict is nast=
y
> > enough that we should resolve it before the trees reach Linus, but ther=
e
> > doesn't seem to be a way forward other than one of us merging the other
> > branch. I'd like to avoid having MTE coredump support depend on the map=
le
> > tree work.
> >=20
> > Is there some way you could provide a branch which implements
> > for_each_vma() using the old vma list, and then the maple tree series
> > could switch that over to the maple tree without breaking things?
>=20
> Without a branch, we could apply something like below on top of Liam's
> patch and revert it once the maple tree is upstream:
>=20
> diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
> index 930a0bc4cac4..400ec7a902df 100644
> --- a/arch/arm64/kernel/elfcore.c
> +++ b/arch/arm64/kernel/elfcore.c
> @@ -8,6 +8,13 @@
>  #include <asm/cpufeature.h>
>  #include <asm/mte.h>
>=20
> +#ifndef VMA_ITERATOR
> +#define VMA_ITERATOR(name, mm, addr) \
> +	struct mm_struct *name =3D mm
> +#define for_each_vma(vmi, vma) \
> +	for (vma =3D vmi->mmap; vma; vma =3D vma->vm_next)
> +#endif
> +
>  #define for_each_mte_vma(vmi, vma)					\
>  	if (system_supports_mte())					\
>  		for_each_vma(vmi, vma)					\
>=20

Note that the current VMA_ITERATOR takes a new type and not the mm.

Since I am removing the linked list (mm->mmap and vma->vm_next), then
the build will fail if this patch and the maple tree branch exist
together.  The iterator may also not start at the start of the list (but
usually does) and may not run through the entire list; see
vma_for_each_range() in the patch set.

Once the maple tree is upstream, then you can take the patch I posted.
I think this is a situation that Linus could take the fixup?

Thanks,
Liam=
