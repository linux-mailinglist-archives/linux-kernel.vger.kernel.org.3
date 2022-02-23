Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BC34C14DC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbiBWN61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiBWN60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:58:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1190B0A43;
        Wed, 23 Feb 2022 05:57:55 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NCWIUj018602;
        Wed, 23 Feb 2022 13:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iZOy3VlEW2VgKBfYOdLI0j9iOmX4/LlaCj6BzaH1g2c=;
 b=pCRTKa07K6S/UbcMDb3r1uh0rL3h2pKmfPaXGJiz2KfAq1RFrJJxWTQndLp34gpHelkO
 m+WKs7OAerfQA91V04VeR/++CcqPh5EqyhhibiSFMJwNXPA0baOHv1LGvz42Xjhgx0xX
 ZXbHAQxd+koT/T+cprVS5KO5mA6zvNyF/cvTV/fzXnnpQIWVGHI5qxZK7p837XC/U+I4
 BEKe2DREU3r5FMLPqqWHKe+lPiHX31KwpaN+wL3udRKw0UgmWy0VmduJhXibOEzl9SEE
 bAcnSJ6ratRt4elEpW5G9W3TbllEAxiKY3uVH5/yOTP1mIE9rAExvih0h2An7WMFTB7T 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx48fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 13:57:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21NDuV25104293;
        Wed, 23 Feb 2022 13:57:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by aserp3020.oracle.com with ESMTP id 3eb482gwwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 13:57:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBmyOHKO6cOJSOxUDNq92BEPhHXNnvMzWhkQmXEFgDpaIojObkpIcKhSh6eMprsl9hBXmmLU/1nwYQYHijQu8Vlv/wGYkplW4fBAaJA0oJqstgbIDKHQc8SKM7fTzCz/n8qiuckSQ5t/YdGpfW+cfEhpzUgybpGrNK+Qqv9THOSYetls9ul4R32+cuNoDTNL42G4ichb6WKSKDSmUzpusRcz7BcPtaIfZMhRlasb3Fc0hnacDYH+gHiuFyS6WnNBIbMkGZgNmc2+t7Knzc/KH72UGcj/FsguSZQ4zvDQOCqT+GFwospobn2PXs1Tw3g2yZb1CAgjAauxTpgqe/hmDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZOy3VlEW2VgKBfYOdLI0j9iOmX4/LlaCj6BzaH1g2c=;
 b=Oh2tt+QMQplAcVZtWJU5AZ89Pjqi9OwKiZufsQOrJYHDeV1CMZ0Rw8Ndfw+2A3ZP6neuuk8l5scpVNCBxWQ6GJ7zNZ5Z0dlfvsGfi+kecYqQnSwQz3AYahoBMbXoP6Gz6rqOFd7GEFRof5g74V1kh9Sv3QU/9Qr3ZIRVl9f9QKGPGhgL1oei8/9qvZ17mdXpn3o+cSSflk2J/sSwbjT0IRSBr7B9ujFdsIOkUE/QPmPkFjH3IYaLGo2H3IFXuHrJvKbpF/K5eCU7wSW0d9Jd5Katnan747bko9VGUHLbwWqgwilERQch66nlMak3Z46YrUrs0gKpH9++SyuLSFXMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZOy3VlEW2VgKBfYOdLI0j9iOmX4/LlaCj6BzaH1g2c=;
 b=g7P2jiG7tbNd5gR8QglsGa1ZankU6ZE4ZPpKfOyRfYmFtphhx0+CqUM/Cu2oCusxqJaT1jZbcPOiFJ8PUR1VkncbS6EgRB5N7LWuMkRdfpeYRO+e0cq1REauiUBgtpCa4iryshcOMNd+DIq/y7ohHf99QjDvxHtMlz/Da6PYkd4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4308.namprd10.prod.outlook.com (2603:10b6:a03:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Wed, 23 Feb
 2022 13:57:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 13:57:23 +0000
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
Thread-Index: AQHYJHBq9S9Lf3gga0WdWNWpZs6RLKyeUrcAgAFUnoCAAB/xAIAAEoeAgAAYlQCAAPcwgIAASBqA
Date:   Wed, 23 Feb 2022 13:57:23 +0000
Message-ID: <20220223135708.kgpv6taz6ydr7hhe@revolver>
References: <20220218014642.lop2ohx4ov6fekyl@revolver>
 <20220218023650.672072-1-Liam.Howlett@oracle.com> <YhPUuu+6TPMKjhwk@arm.com>
 <20220222142557.6oykxjz3j7fq4mrn@revolver>
 <20220222162016.GA16436@willie-the-truck> <YhUcywqIhmHvX6dG@arm.com>
 <20220222185401.jntcd4g62pamfxvr@revolver> <YhYAxb85oDSYJyw0@arm.com>
In-Reply-To: <YhYAxb85oDSYJyw0@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c2656ad-fa64-4232-4285-08d9f6d46b19
x-ms-traffictypediagnostic: BY5PR10MB4308:EE_
x-microsoft-antispam-prvs: <BY5PR10MB430887FD1F8B58E0582868D0FD3C9@BY5PR10MB4308.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k/ZzB48p0QIcdTIbXJXmKc5s1AjYZraazVSstdSW+eRg2atB4Y0QMXWKIJac4/tQ1RbWVlxryuotZAM7O+NftAs2iJTMp1ypv0nMkUwKWS0cxjp7M6WBvkGo5d49The7eHxmJbKXl/y+YigXOXdaBClJAMnblb0gpBkgx509GgVOzcR2/IgespjGU/ltzRrVlm8dNSXvnasrOfO1ZmCsY/j6/35V7SjDlmO2X3MyzVWpNjCULrzZ9xEdanyatiTs/sWBvdp9cEA/ds72+hxu2j3QrNsU6yorWQEcVYokrLrnlGs61ZOXhvPFWurEE9VFB14PRoQepJDY/gdn803SweyQpgnJRMxn2H9qA+4+oR/Z6G86gpdEXh//48/AvErGdIBAgRgEE9x0iyf56qxhpHt1QsevYTzAEsPav4ZoCcREiPNcJsb0/ar1yun2E+9e7GdZ9LgfqJ/yqbH1xkp9aKbG3lA6IssR5H/9fpktGlAt6+k6mtn6e0ADJNO9NOtQOeXxlnG8DOJgVEOI1NrLqxDKs3WuAdHV8w6+5TtZ0JQpcDAbZ7xGDNMCZP0iSODZFudfwfp/VWaskx28HrqO4nwuKh97k6gns5j3lz43kOrP8EiDBM5YeodOxD/Na6YBLBMwCBRdB1yIwTyHmTFfOoOp8sJw6IgHcYssuDbU3ytQbJ8sdC0h9UzGhBSJ5LU9wOkmijO+vGVnmibzS3PXHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(6916009)(6512007)(316002)(33716001)(9686003)(508600001)(6486002)(91956017)(2906002)(8676002)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(44832011)(6506007)(5660300002)(8936002)(76116006)(38070700005)(38100700002)(122000001)(71200400001)(186003)(86362001)(26005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nMq5UXSxeXkZzbs2qN1QJJK0CWt5o1e6RKIHWoBn63z2QuKFYoBzypzwWYUG?=
 =?us-ascii?Q?tN8Yn1/yJhOVXnO2Uy17Ncj5mdfDEqqvaTrJzwXRT41RzjK6PKMsKNt3+4qZ?=
 =?us-ascii?Q?481ZzM7cE3nxbpaV+xRwTfi0rLuxjIF3xGf0gFfXDOZ6aRGTGfhL1qKK5BEr?=
 =?us-ascii?Q?8uQURJOO0d1qox+r6QxeqBPjRbkfZIeouuK6BVZkg5p5v+e8R5KEifpoLlEg?=
 =?us-ascii?Q?6i37itdFUCWJCqY/LgZ4fX34FVzDb3+q6qrFoFhTEolXBMYJ/IjmGwp/PGr2?=
 =?us-ascii?Q?q9YB+HwBvwmfi0ARenbZAhx8rbHTIWi89x4WNmXOvyNlB1NdTTgp5acOggzw?=
 =?us-ascii?Q?pP31c6/MR5qdRMqTvdYmuDYK6xxlG6Y7DirUnZxsW7m6Ak7T9G6IBzDGCVbH?=
 =?us-ascii?Q?MY3v3CzzMUigUmx/DiuN8vdIQghN3Pd4BVFlsmVEIigHdBfstixvse6fnTnC?=
 =?us-ascii?Q?NtN+3HigEIGYd01PsVeRnrSOm3EkQPdC47lNIstL1pOPBOkf3lJ3E/qowmC/?=
 =?us-ascii?Q?ysDppEx9TRz0dwtWBU+zeHz8ef7NTPnP7w4ggeeBitYhjlxco+YTLjtHfXf7?=
 =?us-ascii?Q?bNAaunrMTvincqIsWU5nrWzCIFNwOAW3H0M7k6kg9Kis7E1+fLH+Q2QvPgJF?=
 =?us-ascii?Q?eqyL53Y00Xvgmr0EGdUpkVms+GiVlzLbDOQHBByaH0z2xc4Ce00kGfJB3FAk?=
 =?us-ascii?Q?e4giTxaoz7T1k3Vh3mhwXWmtZ5kzjBc5urccNczkAvW9ANukxNY2Sta4pd91?=
 =?us-ascii?Q?t5BgD+IARChQSdcUci6ZwlKlRZxGEgl4JsaUbwWv/kBdYUlQYby1U2Q+p6gY?=
 =?us-ascii?Q?H48yd8HxEHj4SbvJxJhBRq/9n7DW3pBl83pGFXVEuD58UViZUArTbYDFMxtp?=
 =?us-ascii?Q?Z63sbmbGSw2sZ7IEoZ7IUlrRf0R21QO+lv/5+ii0CJdNbWnNrpiqktBdxH23?=
 =?us-ascii?Q?bKSti3BMD9TKtsC6aNmDRxsC1k++ReqR4yh1CjaxHa9D4B+lgWlNDKpF6Wvx?=
 =?us-ascii?Q?oBdhJ7wnK/oYr93grLzfUx7kNR74E76pn2y2Cmvpa31POhOA+UeM0VAD+tpE?=
 =?us-ascii?Q?fWPd9e6kITk/uUOgUwjpiecIPMubmwaGYVf213cV5fLFnY0+fz28icmwwGaF?=
 =?us-ascii?Q?XbIGHP1auHis1gkhQpnbMwS4mIwO6VMk0jVo47BsoEIIfIXRhzGuQFMdd2oj?=
 =?us-ascii?Q?TEzqemqdHJfdxNFr21yq7gN83XbvdbUwp2Z9oCqqtRB3z9M67kWU00AEjTxv?=
 =?us-ascii?Q?vgjZAzEq2Q71FWozfEQ5zmoIERc/QG2IiTF/IKkyzcvvQGMLSBER/AsmUnmA?=
 =?us-ascii?Q?xyOvaRtZVSoTg3hRX4mWpXBM01ZHK8n0IbHq212MUzU6nqgtOncc91r1B1bk?=
 =?us-ascii?Q?F8vGEnThvIujhjjE/giwF4AYBJd5DtQ3rOTF3JZHoL0iD4IkIAebLDA6aSSw?=
 =?us-ascii?Q?MrXW25I5X7ZTTSODNKJUAi2kl0OAEILB5/S06dSMBlh8Kc9FgBvitKLoDpd9?=
 =?us-ascii?Q?NB0V9kvHORBDJ0mv/Dmf+uVRgk6aj2CGQ0S07lURlsxeENfIqUAjpHRXjKq4?=
 =?us-ascii?Q?ti+qXboaCvEjgsjNZszhJzeWahMD793aW9qaSJc7ic6PxNxkgdPRZSq+c6L0?=
 =?us-ascii?Q?4NJJtFl2Qcj7H7ZsBBylCHE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3246D7723AA6DD469DA90E6889E90332@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2656ad-fa64-4232-4285-08d9f6d46b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 13:57:23.9015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1j5wtFYwfCjtgchmxBhI9YlvN9HQNsxh+0LeJOjw23mEazwELLTVhu6t0cm42lojnZBhtU4SegF6TD01dsSLTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4308
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10266 signatures=677939
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230080
X-Proofpoint-ORIG-GUID: HuYfNW-Mk4-poj_yQSXTiA8PvJNuoTpe
X-Proofpoint-GUID: HuYfNW-Mk4-poj_yQSXTiA8PvJNuoTpe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Catalin Marinas <catalin.marinas@arm.com> [220223 04:39]:
> On Tue, Feb 22, 2022 at 06:54:38PM +0000, Liam Howlett wrote:
> > * Catalin Marinas <catalin.marinas@arm.com> [220222 12:26]:
> > > On Tue, Feb 22, 2022 at 04:20:16PM +0000, Will Deacon wrote:
> > > > On Tue, Feb 22, 2022 at 02:26:03PM +0000, Liam Howlett wrote:
> > > > > The vma iterator uses the maple tree, so this patch would resolve=
 the
> > > > > conflict but both branches are needed.
> > > >=20
> > > > I'm not really sure what to do here, then. I think the conflict is =
nasty
> > > > enough that we should resolve it before the trees reach Linus, but =
there
> > > > doesn't seem to be a way forward other than one of us merging the o=
ther
> > > > branch. I'd like to avoid having MTE coredump support depend on the=
 maple
> > > > tree work.
> > > >=20
> > > > Is there some way you could provide a branch which implements
> > > > for_each_vma() using the old vma list, and then the maple tree seri=
es
> > > > could switch that over to the maple tree without breaking things?
> > >=20
> > > Without a branch, we could apply something like below on top of Liam'=
s
> > > patch and revert it once the maple tree is upstream:
> > >=20
> > > diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.=
c
> > > index 930a0bc4cac4..400ec7a902df 100644
> > > --- a/arch/arm64/kernel/elfcore.c
> > > +++ b/arch/arm64/kernel/elfcore.c
> > > @@ -8,6 +8,13 @@
> > >  #include <asm/cpufeature.h>
> > >  #include <asm/mte.h>
> > >=20
> > > +#ifndef VMA_ITERATOR
> > > +#define VMA_ITERATOR(name, mm, addr) \
> > > +	struct mm_struct *name =3D mm
> > > +#define for_each_vma(vmi, vma) \
> > > +	for (vma =3D vmi->mmap; vma; vma =3D vma->vm_next)
> > > +#endif
> > > +
> > >  #define for_each_mte_vma(vmi, vma)					\
> > >  	if (system_supports_mte())					\
> > >  		for_each_vma(vmi, vma)					\
> >=20
> > Note that the current VMA_ITERATOR takes a new type and not the mm.
>=20
> Well, in you proposed fix, it does take current->mm.

Sorry.  Yes, you are correct.  The VMA_ITERATOR() takes the mm.  The for
each takes the vmi.

>=20
> > Since I am removing the linked list (mm->mmap and vma->vm_next), then
> > the build will fail if this patch and the maple tree branch exist
> > together.  The iterator may also not start at the start of the list (bu=
t
> > usually does) and may not run through the entire list; see
> > vma_for_each_range() in the patch set.
>=20
> My hack above is only temporary to allow building the arm64 tree on its
> own (no maple tree branch) and with your patch on top. In -next, when
> merged with the maple tree branch, the VMA_ITERATOR macro is already
> defined and the above hack skipped. We'll revert this hack around -rc1.
>=20
> Note that the hack above is only in the arm64 elfcore.c, not a generic
> API solution.

Okay, thanks.  This sounds good if it works on your side.  Sorry for not
getting it earlier.

Liam
