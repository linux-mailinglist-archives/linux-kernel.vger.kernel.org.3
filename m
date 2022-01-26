Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3402C49CFE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243242AbiAZQlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:41:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19874 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236669AbiAZQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:41:54 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QFonBK028823;
        Wed, 26 Jan 2022 16:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Zq0r0mXHNf3c9xW2e0XsSnCfyVCbGODT9LMV2IU9LXw=;
 b=hQAwaY6K/sHAT8UD94Xgz6610ZSKsZwifXMZ2VUp9Q294lKuku6MNkRH6pzKouABn2ZB
 Owbk9WSo8GzNs4uUK0rpd/TNkFITvD5kH3Imq2LuhE2VcOctXnXx3G5+8lbJGLL3n31H
 upjETzkVnoCKw7fb43lqFr4+58E3WukqI9BZKFnPHT6p/UovBlKCNXoKOBXs0wRSU828
 4QUBZgatbHqnL/qtQsXclhO4rttltWEql1joxrkoxHXgUZ+TomI4aPQmg8wmVuPK5esH
 tLWpLyoPZ8MEnPt+YWR1hH+e0EiQWWmTD9F91evczrX4Fn3iovp15TJVfv3vAjJaxOdF /w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaaek9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 16:41:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QGXcpY116638;
        Wed, 26 Jan 2022 16:41:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by aserp3030.oracle.com with ESMTP id 3dr7yj397x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 16:41:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVKtiSYi0iMMaTkkA5xWYwg5iRgOupbD5D3OTMiIOtwQsmMM1V6w/HhnEIxUyZUisc1j8JMDVY88KkLialhY6OCmfNyvU7Cv71eL+I/6/wMbXtAKd9hPKuJkc6vNuxLsyN3OozcrlQrq1gM0ZNX85IYFHSWwrmeaG8dPHeBH8wNPlBiL1Lcjxzsp7b5TGGrNAZAT3n6BzCQWnoHNU0vw+Qf3IbkPqkwj3higlTt7IvsVHXJg6pG6L84S9RUytLrDKUQPFDA0chI/LMUoSPtX8Fd8OgmRH8l+Z3ONYcDKCwCKbhENT7Q1rkFrdmc1ibR7djOV00G6p+Uppikd78MA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zq0r0mXHNf3c9xW2e0XsSnCfyVCbGODT9LMV2IU9LXw=;
 b=j8J4afAZifqHTUmu8AL7AUlBP5OfPZr12KBlP5S8+Imr5ReXAXvYO7wtTmvtxFB43sgp9vuFycGh8jYSD1QjINtQQ6VQ8XvSHXPruqSbooU+9FfizP+oeA15VrGMyT5x0Tf0D8MpWOu0QcE7V9BYJVKlY1KwxM4xIEDeEw7Efz/L0REpROphqnPP62clVhOad8IljLlakcD/8NFPirANITvPSyuK/kFhfOflowbpI9XersHmVfDWWJNhbhrIczfPI841+77UNL8OVJp0rezMPP1CeaI+UtHrPnWGHDZLRCHnp22ppHuPF+z86W2G8siQ+YuD8zZAqpWwbJxT82biLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq0r0mXHNf3c9xW2e0XsSnCfyVCbGODT9LMV2IU9LXw=;
 b=I2pTQxHguH9nrFfaPu4MJmx3fN+zDXw2YTAK+K5eDV0GHQuMPdTVtDwbaKwYhgvXXizwSrEPDiT6a37CYqv4vpzjGJnqD5DVgAUFSuT8HvQiATGAAZFrmAMtgDb+vSOIfsPFIGkuacCbmYsK6mmRs/vz/UAKD71IBJvIPF5siws=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR1001MB2161.namprd10.prod.outlook.com (2603:10b6:405:36::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Wed, 26 Jan
 2022 16:41:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 16:41:11 +0000
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
Subject: Re: [PATCH v4 56/66] mm/mlock: Use maple tree iterators instead of
 vma linked list
Thread-Topic: [PATCH v4 56/66] mm/mlock: Use maple tree iterators instead of
 vma linked list
Thread-Index: AQHX5r/0n+VjSgFv/U2n/DOQtwVgxqxsIY+AgAm38wA=
Date:   Wed, 26 Jan 2022 16:41:11 +0000
Message-ID: <20220126164102.of64gqiikbtwhnu6@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-57-Liam.Howlett@oracle.com>
 <75a30665-9884-ac6d-c526-e7deb1e4e879@suse.cz>
In-Reply-To: <75a30665-9884-ac6d-c526-e7deb1e4e879@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e25fd58-6437-4dd4-a402-08d9e0eaa92b
x-ms-traffictypediagnostic: BN6PR1001MB2161:EE_
x-microsoft-antispam-prvs: <BN6PR1001MB2161E504CBB22990168F3AE0FD209@BN6PR1001MB2161.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uz4ujKNsH0MZVtYJgJFG0F1/bVmNq97Iiem6+CUOYfIjjbavJ4f/Lqne4wQ7NoKoLksqCDD31+b1gfoXPDSjjJl9HBJ4AqvS8jC57SxJZ9PYq9St0XnQ/kQXu6xe0x/T1r1CTuLVNd3iHj1VEHVrrwWqmz3nlSCHICMxDS++UlilgoFv7LuNTimZwCb0qHOvL0ibrQDahigelTg9koT2C/TWbNSLV4YdpzfzXjUisJbHG9fvqzVPeNQilC5O2rmMQI6TNHglx8vS7EhnODbDEoSEuqW51xHlSvKMkL9TjhwW9PalJGmhEfLONfalxvdUlIspYaOxvplHfCmoAZebBchxqBgLdpKtsMlSLkVqI7jdwhfxs6eACqNMdKZImCRgI5w8DaCeqQ7aoKeZHwwGBTrkZY1j5jEhcBjgWEzij+RKTK7XhKbg97l3eeE9boZp62i7d1i1SqAaFm/cK7vDFOUUJe9mcKOSUm47asjZquu+0gN74A+hB3RjL1eJVBGiI0O3vVKOXT/qa1ZUSlcfLuj/8JjyCJGIZTTDQiybOcQZyIUUS9HDZTtEmELmHn+aSPNmAHncky42KAcyohiW2Wkd/wq0hy45Efwp5zgQuCJ98WqpIPXOe0vbm/6Em71H1IWUVXPQdtKVGlt+d6/8dS1JV5i6VfIXhgR0/hvuNuGwhBMd4RiZAl1Yl/eMbVl6MGvjvIvScKN8blR5WsoDQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66476007)(66556008)(6916009)(66446008)(44832011)(6506007)(26005)(6512007)(9686003)(76116006)(33716001)(83380400001)(91956017)(6486002)(316002)(7416002)(2906002)(8936002)(53546011)(1076003)(8676002)(186003)(38070700005)(5660300002)(4326008)(122000001)(71200400001)(86362001)(508600001)(38100700002)(66946007)(64756008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CpGkMUstANqjbulAOGhCSzGpxJksNaROR6IFQyN+qGbN9yxo1yw3pFMuGH5x?=
 =?us-ascii?Q?7meDMGn1sOCbDDLu9hQcuZDkI0KPSQp4C4oI6WTUx097hCGrT7SvuDYuxM7y?=
 =?us-ascii?Q?Uw8OY+rItoKVtImcrm7lmp6FyQg2IrZpre7InzcZq6T9DLsG7x7ixlOcWpL4?=
 =?us-ascii?Q?V645a6pwumCHvPUUVsMetsul9/PICx8v1EUKNOG3DieUtX3c02pOeNqux4/B?=
 =?us-ascii?Q?sMPezoYjO+8sL02YLjbgIBsEXlk/mp9cF5LKq0UIRarc5uIOUZFV7rXf8hLE?=
 =?us-ascii?Q?+X768+SDMM5ecOoShfo2AdGOi5MGxJqwEZDB5CXA+VJJG+7nExo0JSCnAW35?=
 =?us-ascii?Q?L+e34NfOyAIWIHwIQkD3s+WlAMQj+KFCxcLO0/b0iEh83+hCa4/cdj5LVQux?=
 =?us-ascii?Q?ONAeeCQWk9kpw3xcEDOhZk1w2Bnj7MwQwwmrCeEYu6AEzxj4K+zua9gaZnRD?=
 =?us-ascii?Q?ZIq9FbR431smW7NjkaF14D0CBKtfpdwd4ce5o8HvcxXuPrFz2U9IhwQlMwO8?=
 =?us-ascii?Q?7S+bNKDwAIx/WCpbyQ2081jLu2aVMA+/Clstp1tF5pi9ruSu/NNvRVbcweWl?=
 =?us-ascii?Q?QS3ri1+KOrv48IgmBz6gvi0J0ryeP5yg1dLUFX61VkZxsN8Dyc9OPpyI23zI?=
 =?us-ascii?Q?8NlkLyUV3m1maYvfPi2CIEyg9KFj/uZgIaFgsw08VYCZleBN6XDGLS0FJzj1?=
 =?us-ascii?Q?uh2BiIo36PE9i342fYkfEFHIW1P+VDKYmv+1+rPdWNgQ9cw1UtKCV+LmEzm1?=
 =?us-ascii?Q?zL/yYjDuq5RjtZvqeM2YrbSrX2gl53cdzJ4KPFHEhoxyxM+epe0jIue0ZSG5?=
 =?us-ascii?Q?VOMA+N1RV/ZG1vs8S1c0O4g6EstQ+sCf12thTBpDTRh4Mun7LmavQLGpSc66?=
 =?us-ascii?Q?TO6JsEtiGj1DT6hTTai5ypootWBjVdu+lMv48PzdsDuAW/9A6jJHo83uVwoI?=
 =?us-ascii?Q?fi8dSp/HUtlr/y8wdn6PEC5e/VrRw1/NeMQnxMMwoEMYGeTianwvFcHUK8eX?=
 =?us-ascii?Q?RWMXRw9ji0y/moSBLck5oNytck3/z+EejVxItTygnEB3JqJXn4yK8++M6ioV?=
 =?us-ascii?Q?O9Lgpi/fF1dSowP8P+Z2NjI8117U2TQ2RJJhJom37yCSv3L2DCy5+mOTn8dK?=
 =?us-ascii?Q?UpPkuRpLGve+WXmcbYwbgN6J9TS7yc4oX+wdLtZed65daplf8FhQVOVjcTv6?=
 =?us-ascii?Q?eGjX5mt1EjGtukl0wI0R4pyb50XoKt4R0og+CgHVccM4v4FVW/OlwC6p5QVg?=
 =?us-ascii?Q?56gd+ijyEP0pqNlh7yTGqB9TLQfDmQ3jMuSE19Zhv9rhXZztIYAdUf2ALtpz?=
 =?us-ascii?Q?HYR35CKnQCM+dgfQJJGiEpyggdJUhxGr5PIYb/9c8RepLJgalUCJLv+GUAUv?=
 =?us-ascii?Q?h8JlJWsqlSQbZZrV2jOmMhfFmrKsuGaLlTWCLD6i7pY/bY0U2hlQ31v6H0F6?=
 =?us-ascii?Q?/7WDhBrQa0ZVFukMlVvNoE4GC/3wH2VsrEj8AQffySBlZDxeYFheXoyASjCh?=
 =?us-ascii?Q?9MtbUdQR2WqvYe9lS3HBLDD5vaFxoP72m0E3eWIJVXxEbL77vQ0ysCwWSA7O?=
 =?us-ascii?Q?rPjfF2ajZgavcKgSb0dV6aBbgaw6rppRDDImdbqEHdM66WXg3QrSIAuH+UAt?=
 =?us-ascii?Q?CVm3AfgajJUx6iuvn7XNK5c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <065873BE13790148A61490AE548E408F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e25fd58-6437-4dd4-a402-08d9e0eaa92b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 16:41:11.3564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbgFvMhWU+8L8AzFGCiADqVcZNrT9aqQ33QO3MBn0ddWqY5wTa4g6KXGRmju4P5LsMRltJrz865yRfwjo2ohZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2161
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260103
X-Proofpoint-GUID: VbRUlyS-G8fhFi78qFwjBPtQwbV-UfGZ
X-Proofpoint-ORIG-GUID: VbRUlyS-G8fhFi78qFwjBPtQwbV-UfGZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220120 07:16]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mlock.c | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/mm/mlock.c b/mm/mlock.c
> > index e263d62ae2d0..feb691eb4c64 100644
> > --- a/mm/mlock.c
> > +++ b/mm/mlock.c
> > @@ -563,6 +563,7 @@ static int apply_vma_lock_flags(unsigned long start=
, size_t len,
> >  	unsigned long nstart, end, tmp;
> >  	struct vm_area_struct *vma, *prev;
> >  	int error;
> > +	MA_STATE(mas, &current->mm->mm_mt, start, start);
> > =20
> >  	VM_BUG_ON(offset_in_page(start));
> >  	VM_BUG_ON(len !=3D PAGE_ALIGN(len));
> > @@ -571,11 +572,11 @@ static int apply_vma_lock_flags(unsigned long sta=
rt, size_t len,
> >  		return -EINVAL;
> >  	if (end =3D=3D start)
> >  		return 0;
> > -	vma =3D find_vma(current->mm, start);
> > -	if (!vma || vma->vm_start > start)
> > +	vma =3D mas_walk(&mas);
> > +	if (!vma)
> >  		return -ENOMEM;
> > =20
> > -	prev =3D vma->vm_prev;
> > +	prev =3D mas_prev(&mas, 0);
>=20
> Could be only done as an 'else' of the 'if' below?

Agreed.  I will make that change.

>=20
> >  	if (start > vma->vm_start)
> >  		prev =3D vma;
> > =20
> > @@ -597,7 +598,7 @@ static int apply_vma_lock_flags(unsigned long start=
, size_t len,
> >  		if (nstart >=3D end)
> >  			break;
> > =20
> > -		vma =3D prev->vm_next;
> > +		vma =3D find_vma(prev->vm_mm, prev->vm_end);
> >  		if (!vma || vma->vm_start !=3D nstart) {
> >  			error =3D -ENOMEM;
> >  			break;
> > @@ -618,15 +619,12 @@ static unsigned long count_mm_mlocked_page_nr(str=
uct mm_struct *mm,
> >  {
> >  	struct vm_area_struct *vma;
> >  	unsigned long count =3D 0;
> > +	MA_STATE(mas, &mm->mm_mt, start, start);
> > =20
> >  	if (mm =3D=3D NULL)
> >  		mm =3D current->mm;
> > =20
> > -	vma =3D find_vma(mm, start);
> > -	if (vma =3D=3D NULL)
> > -		return 0;
> > -
> > -	for (; vma ; vma =3D vma->vm_next) {
> > +	mas_for_each(&mas, vma, start + len) {
>=20
> Could be for_each_vma_range()?

yes, I will do this.

>=20
> >  		if (start >=3D vma->vm_end)
> >  			continue;
>=20
> Unnecessary? (even before this patch, I think?)

I think so too, I will remove it.

>=20
> >  		if (start + len <=3D  vma->vm_start)
>=20
> Unnecessary after your patch?

This appears to be for overflow.  My patch will not deal with overflow
as it is dealt with today.  I will update my patch to deal with overflow
in the same way by removing this from the loop & setting up an end
variable.  This will have the added benefit of reducing the loop for a
one time check.  I don't love the fact that overflow is handled like
this.  Perhaps this should be revisited at a later date.

>=20
> > @@ -741,6 +739,7 @@ static int apply_mlockall_flags(int flags)
> >  {
> >  	struct vm_area_struct *vma, *prev =3D NULL;
> >  	vm_flags_t to_add =3D 0;
> > +	unsigned long addr =3D 0;
> > =20
> >  	current->mm->def_flags &=3D VM_LOCKED_CLEAR_MASK;
> >  	if (flags & MCL_FUTURE) {
> > @@ -759,7 +758,7 @@ static int apply_mlockall_flags(int flags)
> >  			to_add |=3D VM_LOCKONFAULT;
> >  	}
> > =20
> > -	for (vma =3D current->mm->mmap; vma ; vma =3D prev->vm_next) {
> > +	mt_for_each(&current->mm->mm_mt, vma, addr, ULONG_MAX) {

and I'll add a for_each_vma() here.

> >  		vm_flags_t newflags;
> > =20
> >  		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
> =
