Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E479149BD6E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiAYUtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:49:07 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9400 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233141AbiAYUsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:48:23 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PJH8NR031648;
        Tue, 25 Jan 2022 20:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ByqOCTjFvjlo/ZvbI9R1IC0bDrl7DRtIp31/vCed+hY=;
 b=O8H/fVUbdcSGxkYfvhL8EqZhnjPyy3gwj1zD+pjn6HvoJIKyJZNGaZYqjbToKVeULJCa
 jVp/7SpVYSuSJYTP75d5QofHQaHDAngJnQLQOaAQalRp1wkUdTv3NwKh6ExLQn+OW87O
 CUYcGc/PHVcjDL/LcLEh+ro5dh01sASTGFEiZM5RBLY+8mR7EELmSYg9XXa0y+7Cb4wN
 C9V+bGPP7SAedLH9qIrTabbipOveXQrh0zkGhE2LTJXIdBYuIwNC40hdfa1KMX8rBIM2
 VjD9SRDvFw85hObW3INpClr1+xU8JWxPBxKnVMEzmALpJaHjBhC+iZDlWEifP93P/irk 8g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s48y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 20:47:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PKkRNu163303;
        Tue, 25 Jan 2022 20:47:54 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
        by userp3020.oracle.com with ESMTP id 3drbcpqjmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 20:47:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICbrZ1nIIY6gNsRKZVALQnKHlixgZgHSq3SMyUZnzz6rJ++8GNJKuJy4dSOgxlxob064MLoweW5xEmS8dBHBoX22bTVgBZNDjjk332dKtkIa/zdymutP7c5sugZEnpzVhBABK6oMF69kwlzGZlqz641iQuv+QBpm7xIviBYFT0V8tGnp6vnbxqwC6OTLiS1PpcXpqqTzvYiAieQG2AcaEZPAmRirodj51Hd5Z4jwLRkUko1vxL2UQ652zp3KtXzLfVDoGh0ySsoFtPmvKYpmaftEFGqGTigzPXW2jZm0aGJi1D8YEzB2fGxum30mG4s5T8qRCxizGeVUoDLdxypBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByqOCTjFvjlo/ZvbI9R1IC0bDrl7DRtIp31/vCed+hY=;
 b=EnBt/Up+9dvJyx3X/Fd7/oVwV1zjxRLXAsOQmj/ErHekURZCs0VWpkBS9+PC6Pv5nQFZdIRRbfMmt3i/8Uus4cNDMiHcAuKg/yX1lyahJEIsExZlztebrJuuFISjPk0UwjvvwD2pdkgQj64TD1jE6yEiGWl1k25Ge9IYbkuef+FRctOpZGwqAM043/b0jXRo9VwdORbdWgz4esE1jtpzfNAs7ZZ1S4T+ZnRPPDS5lHMP60FnBxFga957aTYCuvYz5jia8vqaSFJOq3Vy53B2RqAH/4g6o/IbEzy0qKHMmbIiScHbQVjkct9+YUKIGGPoGH9x0emdK6cc182tVlXEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByqOCTjFvjlo/ZvbI9R1IC0bDrl7DRtIp31/vCed+hY=;
 b=Se8GM6AFf/NNjp0LutgphKmxy1sVwfKwE9ihTaEXgnUTuyt761ZI7dqOwjpNT+xluW154OoDyEkFnADNdvfrORXA7VVEfxzpPSXp3+eZT01ytksgmz77vv6h9fWcif/jaocDEfJn6snPrKoONOiEAwz/Z1/am3UCl3oLCYSh3Mg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4738.namprd10.prod.outlook.com (2603:10b6:303:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 20:47:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 20:47:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>
Subject: Re: [PATCH v4 43/66] userfaultfd: Use maple tree iterator to iterate
 VMAs
Thread-Topic: [PATCH v4 43/66] userfaultfd: Use maple tree iterator to iterate
 VMAs
Thread-Index: AQHX5r/xxngSsnXavkytBhuaTJnW/qxq1QQAgAm3E4A=
Date:   Tue, 25 Jan 2022 20:47:50 +0000
Message-ID: <20220125204741.jklejdjbrwxqq67t@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-44-Liam.Howlett@oracle.com>
 <e0aa5cc6-0e3c-a642-5b51-66cffd9ea4c5@suse.cz>
In-Reply-To: <e0aa5cc6-0e3c-a642-5b51-66cffd9ea4c5@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3fbb434-d70d-46bf-305b-08d9e043f413
x-ms-traffictypediagnostic: CO1PR10MB4738:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4738F5D77A2BA0A874B02137FD5F9@CO1PR10MB4738.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LZ68G0Rzs8lotVA16VPqTpjOyDIkxDOEbyF/85cloPzXO1bSD5Bzidg69pqa8Yy2f4FVsrlc3nXbk8bOO/r7rXmV7VnL0bzC1Jpo3cweV04TvHeHxUvE0eqZHc83m/Nd5uZ4u+N3vkICSsuYpBek3wnUsZUyQ4u2JsK6BMoE1Fn99IDKEq56rxCuD3Cusxi9OyzV0E8VBw7euVl8SS0cHwbWxXQDPgpMA57kEHhMNfswghQ/GHta4ig/QusUrqmOGBtz87Qe+RSA+ejNkGCZNfw1CY2eY7LxZB81SgRqxf0vvtPlh1GRLcBPQuUVADw5TIijHccBkIWBFKVQIVQcOkSjo1f96ivG38FRHZLqtjvVOHw18RKEUYVWUbfB4mmnT5qBlpDRP9vqFXF+X3EiNm7O4BZCuayJHGXMTP24+XfE/pKCKZj2MiDUyX80K/c/V9+MOtHnMGM1GY+mrUWRia+8E5s0cpYWML0X8AE4EtI9esJQ1GHCHnpL718UsZgJcLZ851kbH5E6EA+PHFw59w/g6mMZTKzUwshXXRv7ypou5AV1rycSB1l3dE4zXgQfNAhL920ZLQGjCC7IZsD0PW3tOgrkdagCHC8oF8tSleCkN1f0ralzUAgsVsNUVgPfODUlGpqqBtXm9hyvHspxRvSeTUs1jvPtlozogZMga42gdRA3/3kMsz2AEiXkt2UgdnPV2ojhC8qDy9m/qO1PtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(6916009)(44832011)(316002)(7416002)(5660300002)(38100700002)(38070700005)(2906002)(33716001)(76116006)(64756008)(66476007)(91956017)(66556008)(8676002)(8936002)(66446008)(66946007)(122000001)(86362001)(4326008)(9686003)(83380400001)(508600001)(1076003)(53546011)(26005)(6486002)(71200400001)(186003)(6506007)(6512007)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dWh1gWkXUkvAIucuuE+melY6lFA73M5icR5iFTdYWFe/neXkUXEQyGfRVn38?=
 =?us-ascii?Q?72hW1TP94U27KDkGNstg7L7uQb/sbuxMl53f5JiJ/Ma1KskDk672szOdvv/J?=
 =?us-ascii?Q?hakM+0B1E4+tLcVx7/jfb0t9/x3ru/zPFvHVN09V1J3Y6y/hIuaB+EUoB4J0?=
 =?us-ascii?Q?sR5OErETwYK+b8Uc1yqVctDXMk7fMVmw5x5JMjXy5lP2mfRgzbigNI0sKGEJ?=
 =?us-ascii?Q?sR3n7NDoBPF3rmeh1sbYHHtavZFG+0sW/N0O44907p3rE+FxEXVSxtzlNCWX?=
 =?us-ascii?Q?gGjSPaxBcODi0IksX0tQwMZzdlWijCLzUt4uH9I6O3quTwwI9jf5NSeTGO2c?=
 =?us-ascii?Q?zgarsooHrMJ6Ads/9io4qhx3KWY1wV4b1JcJILmXV5WaRjR2+nSIpraauF0l?=
 =?us-ascii?Q?DmydWmxDwxQ1AzoeUX2wP9+GHljX0xkNNZyfKe+JjGZwqQRVy8oBMBYKog68?=
 =?us-ascii?Q?oDWBkxPVptoT62yygbCUzxUp3BFYbqAjNdjNkH4u9lnbLuLq4rbTaTbK7S3V?=
 =?us-ascii?Q?tHNvgKQQ05dUVlQIXTIy6BfolEzTxdzSoryFXFzGQFL0thu+qGJkemXwiU2j?=
 =?us-ascii?Q?5MwGeWBaLpWEDILV/n17qZ/bU3t+p9755dI65r+pNLyji4XB2PyIpTsWVskJ?=
 =?us-ascii?Q?uG1nQKNiUxFdwNE54UKZdtlNyIvzr5P8lE4ZFaF0Yl5QEu8pE2qDPpSHDHHP?=
 =?us-ascii?Q?hM24a/B7gSStxW64+PZk+b6xN9TgKlXDWnIAamZM+2bvWRUexiXndn99YNuv?=
 =?us-ascii?Q?ChRtez8UzmaXQJkTu5YheFkQxyzH7q0bBKyz4I/5qT9ZIo5Men0zTcRnqxvL?=
 =?us-ascii?Q?jkUOeXxesbesFxZM4ORSodwR0XPoK3Sc2gXMVVPRSi8TEZ+oZR/nr7Ym5k84?=
 =?us-ascii?Q?cWBy/H7mEfd9ApH7c1jDyh592DoZ9V/OFmAofrmzYVpK/e+6ToPr/Ue4w9Gc?=
 =?us-ascii?Q?gg5Fv8kOEmPFBV8Oi1ym3u73doBfZMbqb6aiSCzVhp8r+Yf3hqYkuecy9UK9?=
 =?us-ascii?Q?vx6lX2CVE/QwLFr4ggEEV/5a/DLG6Hudgwiy4SUUfWLS0oyRUJCBNjgGabLB?=
 =?us-ascii?Q?wXq18TPIGxY4A+ZncP0cJc2dy+LwFJY6VpQTsLJ1v5sConoucPyhp6xakgmC?=
 =?us-ascii?Q?whpbfH2FcCo9DKeCl38pkY5mG0YpafgLa4kybqCKvqwePtAV5a4M4SCoPPwj?=
 =?us-ascii?Q?J2CEyKNnnDId3gbOB14oJEwvNdtJHIgxmDWzRQXwtrQ4R+Nl0tsIDbAjVi7L?=
 =?us-ascii?Q?YTzZuLKEOgTTG3b9M7JaLy3XaGVZV/CFX90zjdapwD72b0GSEbkwXrJ4eKSV?=
 =?us-ascii?Q?p32slmb5m5IppQL2UAnjC7Igw+9SluxKMiBSVytJdV3p+/jUSTRXIdc5Ux0I?=
 =?us-ascii?Q?qghNIfjmHIbjasVnj+xBJq47pIToWWP1GCuFiCh7gwJKDFaFDxjkiZUKH53s?=
 =?us-ascii?Q?jNm1jJ8YyN+AzuYyz4N3woepZ9fvTJFkVKh6zxSPh7Tjq5tT2C3dbXD6B1zV?=
 =?us-ascii?Q?JaSIha4+BNEcnyeLyVa8F0foq1iV4/BT7xPi9yiCgyxwpYzyaGelpyheQ04L?=
 =?us-ascii?Q?FMFl1TlF/la7gHXQLOKfOv2j/LQg+XSVWDWnEtNtAbjnT8P1JSKyLBi0Kig2?=
 =?us-ascii?Q?qbhP6EUX8mJqCEggGVDHRsg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <730204C43ED0C4479DE8791B826BB84D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fbb434-d70d-46bf-305b-08d9e043f413
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 20:47:51.0871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYQD3gSG82xXuRhQK+cUXlXCASqIquEGfkIC/zwfx7WeHwjJ6vMVUdm//a0PEXh6S1hU6p/LqTh6ez/aNjWRwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4738
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250124
X-Proofpoint-GUID: mK0U9z9fAVkWfiif-RsqqijaBGzblyi4
X-Proofpoint-ORIG-GUID: mK0U9z9fAVkWfiif-RsqqijaBGzblyi4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220119 11:26]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Don't use the mm_struct linked list or the vma->vm_next in prep for rem=
oval
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  fs/userfaultfd.c              | 49 ++++++++++++++++++++++-------------
> >  include/linux/userfaultfd_k.h |  7 +++--
> >  mm/mmap.c                     | 12 ++++-----
> >  3 files changed, 40 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 22bf14ab2d16..2880025598c7 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -606,14 +606,16 @@ static void userfaultfd_event_wait_completion(str=
uct userfaultfd_ctx *ctx,
> >  	if (release_new_ctx) {
> >  		struct vm_area_struct *vma;
> >  		struct mm_struct *mm =3D release_new_ctx->mm;
> > +		VMA_ITERATOR(vmi, mm, 0);
> > =20
> >  		/* the various vma->vm_userfaultfd_ctx still points to it */
> >  		mmap_write_lock(mm);
> > -		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
> > +		for_each_vma(vmi, vma) {
> >  			if (vma->vm_userfaultfd_ctx.ctx =3D=3D release_new_ctx) {
> >  				vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
> >  				vma->vm_flags &=3D ~__VM_UFFD_FLAGS;
> >  			}
> > +		}
> >  		mmap_write_unlock(mm);
> > =20
> >  		userfaultfd_ctx_put(release_new_ctx);
> > @@ -794,11 +796,13 @@ static bool has_unmap_ctx(struct userfaultfd_ctx =
*ctx, struct list_head *unmaps,
> >  	return false;
> >  }
> > =20
> > -int userfaultfd_unmap_prep(struct vm_area_struct *vma,
> > -			   unsigned long start, unsigned long end,
> > -			   struct list_head *unmaps)
> > +int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
> > +			   unsigned long end, struct list_head *unmaps)
> >  {
> > -	for ( ; vma && vma->vm_start < end; vma =3D vma->vm_next) {
> > +	VMA_ITERATOR(vmi, mm, start);
> > +	struct vm_area_struct *vma;
> > +
> > +	for_each_vma_range(vmi, vma, end) {
> >  		struct userfaultfd_unmap_ctx *unmap_ctx;
> >  		struct userfaultfd_ctx *ctx =3D vma->vm_userfaultfd_ctx.ctx;
> > =20
> > @@ -848,6 +852,7 @@ static int userfaultfd_release(struct inode *inode,=
 struct file *file)
> >  	/* len =3D=3D 0 means wake all */
> >  	struct userfaultfd_wake_range range =3D { .len =3D 0, };
> >  	unsigned long new_flags;
> > +	MA_STATE(mas, &mm->mm_mt, 0, 0);
>=20
> Again, it looks like this could also be VMA_ITERATOR, consistent with the
> one above?

VMA_ITERATOR is for simple cases, this is not a simple case, but in this
change it does appear so.  I missed the mas_pause() when the state is
invalidated by vma_merge() success in the mas_for_each() loop below.  I
will fix this.

>=20
> > =20
> >  	WRITE_ONCE(ctx->released, true);
> > =20
> > @@ -864,7 +869,7 @@ static int userfaultfd_release(struct inode *inode,=
 struct file *file)
> >  	 */
> >  	mmap_write_lock(mm);
> >  	prev =3D NULL;
> > -	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
> > +	mas_for_each(&mas, vma, ULONG_MAX) {
> >  		cond_resched();
> >  		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
> >  		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
> > @@ -1281,6 +1286,7 @@ static int userfaultfd_register(struct userfaultf=
d_ctx *ctx,
> >  	bool found;
> >  	bool basic_ioctls;
> >  	unsigned long start, end, vma_end;
> > +	MA_STATE(mas, &mm->mm_mt, 0, 0);
> > =20
> >  	user_uffdio_register =3D (struct uffdio_register __user *) arg;
> > =20
> > @@ -1323,7 +1329,8 @@ static int userfaultfd_register(struct userfaultf=
d_ctx *ctx,
> >  		goto out;
> > =20
> >  	mmap_write_lock(mm);
> > -	vma =3D find_vma_prev(mm, start, &prev);
> > +	mas_set(&mas, start);
> > +	vma =3D mas_find(&mas, ULONG_MAX);
> >  	if (!vma)
> >  		goto out_unlock;
> > =20
> > @@ -1348,7 +1355,7 @@ static int userfaultfd_register(struct userfaultf=
d_ctx *ctx,
> >  	 */
> >  	found =3D false;
> >  	basic_ioctls =3D false;
> > -	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
> > +	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
> >  		cond_resched();
> > =20
> >  		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
> > @@ -1408,8 +1415,10 @@ static int userfaultfd_register(struct userfault=
fd_ctx *ctx,
> >  	}
> >  	BUG_ON(!found);
> > =20
> > -	if (vma->vm_start < start)
> > -		prev =3D vma;
> > +	mas_set(&mas, start);
> > +	prev =3D mas_prev(&mas, 0);
> > +	if (prev !=3D vma)
> > +		mas_next(&mas, ULONG_MAX);
>=20
> Hmm non-commented tricky stuff...

Oh, I did not see this as tricky.  I will add a comment.  Basically, I
am setting the maple state to search for start, then a mas_prev() means
it will get the vma before start.

>=20
> > =20
> >  	ret =3D 0;
> >  	do {
> > @@ -1466,8 +1475,8 @@ static int userfaultfd_register(struct userfaultf=
d_ctx *ctx,
> >  	skip:
> >  		prev =3D vma;
> >  		start =3D vma->vm_end;
> > -		vma =3D vma->vm_next;
> > -	} while (vma && vma->vm_start < end);
> > +		vma =3D mas_next(&mas, end - 1);
> > +	} while (vma);
> >  out_unlock:
> >  	mmap_write_unlock(mm);
> >  	mmput(mm);
> > @@ -1511,6 +1520,7 @@ static int userfaultfd_unregister(struct userfaul=
tfd_ctx *ctx,
> >  	bool found;
> >  	unsigned long start, end, vma_end;
> >  	const void __user *buf =3D (void __user *)arg;
> > +	MA_STATE(mas, &mm->mm_mt, 0, 0);
> > =20
> >  	ret =3D -EFAULT;
> >  	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)=
))
> > @@ -1529,7 +1539,8 @@ static int userfaultfd_unregister(struct userfaul=
tfd_ctx *ctx,
> >  		goto out;
> > =20
> >  	mmap_write_lock(mm);
> > -	vma =3D find_vma_prev(mm, start, &prev);
> > +	mas_set(&mas, start);
> > +	vma =3D mas_find(&mas, ULONG_MAX);
> >  	if (!vma)
> >  		goto out_unlock;
> > =20
> > @@ -1554,7 +1565,7 @@ static int userfaultfd_unregister(struct userfaul=
tfd_ctx *ctx,
> >  	 */
> >  	found =3D false;
> >  	ret =3D -EINVAL;
> > -	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
> > +	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
> >  		cond_resched();
> > =20
> >  		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
> > @@ -1574,8 +1585,10 @@ static int userfaultfd_unregister(struct userfau=
ltfd_ctx *ctx,
> >  	}
> >  	BUG_ON(!found);
> > =20
> > -	if (vma->vm_start < start)
> > -		prev =3D vma;
> > +	mas_set(&mas, start);
> > +	prev =3D mas_prev(&mas, 0);
> > +	if (prev !=3D vma)
> > +		mas_next(&mas, ULONG_MAX);
>=20
> Same here.

I'll add the comment here too.

>=20
> > =20
> >  	ret =3D 0;
> >  	do {
> > @@ -1640,8 +1653,8 @@ static int userfaultfd_unregister(struct userfaul=
tfd_ctx *ctx,
> >  	skip:
> >  		prev =3D vma;
> >  		start =3D vma->vm_end;
> > -		vma =3D vma->vm_next;
> > -	} while (vma && vma->vm_start < end);
> > +		vma =3D mas_next(&mas, end - 1);
> > +	} while (vma);
> >  out_unlock:
> >  	mmap_write_unlock(mm);
> >  	mmput(mm);
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_=
k.h
> > index 33cea484d1ad..e0b2ec2c20f2 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -139,9 +139,8 @@ extern bool userfaultfd_remove(struct vm_area_struc=
t *vma,
> >  			       unsigned long start,
> >  			       unsigned long end);
> > =20
> > -extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
> > -				  unsigned long start, unsigned long end,
> > -				  struct list_head *uf);
> > +extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long =
start,
> > +				  unsigned long end, struct list_head *uf);
> >  extern void userfaultfd_unmap_complete(struct mm_struct *mm,
> >  				       struct list_head *uf);
> > =20
> > @@ -222,7 +221,7 @@ static inline bool userfaultfd_remove(struct vm_are=
a_struct *vma,
> >  	return true;
> >  }
> > =20
> > -static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
> > +static inline int userfaultfd_unmap_prep(struct mm_struct *mm,
> >  					 unsigned long start, unsigned long end,
> >  					 struct list_head *uf)
> >  {
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 79b8494d83c6..dde74e0b195d 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2449,7 +2449,7 @@ do_mas_align_munmap(struct ma_state *mas, struct =
vm_area_struct *vma,
> >  		 * split, despite we could. This is unlikely enough
> >  		 * failure that it's not worth optimizing it for.
> >  		 */
> > -		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
> > +		int error =3D userfaultfd_unmap_prep(mm, start, end, uf);
> > =20
> >  		if (error)
> >  			return error;
> > @@ -2938,10 +2938,7 @@ static int do_brk_munmap(struct ma_state *mas, s=
truct vm_area_struct *vma,
> >  		goto munmap_full_vma;
> >  	}
> > =20
> > -	vma_init(&unmap, mm);
> > -	unmap.vm_start =3D newbrk;
> > -	unmap.vm_end =3D oldbrk;
> > -	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
> > +	ret =3D userfaultfd_unmap_prep(mm, newbrk, oldbrk, uf);
> >  	if (ret)
> >  		return ret;
> >  	ret =3D 1;
> > @@ -2954,6 +2951,9 @@ static int do_brk_munmap(struct ma_state *mas, st=
ruct vm_area_struct *vma,
> >  	}
> > =20
> >  	vma->vm_end =3D newbrk;
> > +	vma_init(&unmap, mm);
> > +	unmap.vm_start =3D newbrk;
> > +	unmap.vm_end =3D oldbrk;
> >  	if (vma_mas_remove(&unmap, mas))
> >  		goto mas_store_fail;
> > =20
> > @@ -2963,7 +2963,7 @@ static int do_brk_munmap(struct ma_state *mas, st=
ruct vm_area_struct *vma,
> >  	}
> > =20
> >  	unmap_pages =3D vma_pages(&unmap);
> > -	if (unmap.vm_flags & VM_LOCKED) {
> > +	if (vma->vm_flags & VM_LOCKED) {
>=20
> Hmm is this an unrelated bug fix? As unmap didn't have any vm_flags set e=
ven
> before this patch, right?

Yes.  Thanks, I must have merged it into the wrong commit.

>=20
> >  		mm->locked_vm -=3D unmap_pages;
> >  		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
> >  	}
> =
