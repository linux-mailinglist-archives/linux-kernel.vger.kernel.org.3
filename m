Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B6949D069
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243579AbiAZRJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:09:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8886 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236841AbiAZRJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:09:18 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QFosi4022417;
        Wed, 26 Jan 2022 17:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=k+kLu8kUMIm9nn6o6yBU3VvJFBdI885OZvJ1RpZtJzo=;
 b=gOPK3TueMkwV8uMH8h56XvxvOsunuwSjNCBWai3V1oFtokWxc1dhwSCg0hK05PAw4Zf5
 ztxhfaDNPOHc8pwuDaolM/L7JTJ1yqW0A/5MiOWi/Z5C6LJ0B7TXypbHDupTdM8SIc/n
 nlHRhdevJII0dFwNeFnfH3pR4Aotr3Qt2dbPvc3lXbwxi6UZtfMLN2JkWVF2q9jU7eI2
 svZ8PXxA/maYm52wTfLhtrpB6AmViYCMTrvurO2NimdY/5Bq4l2ZnBk2uolQ7a8OwenJ
 jBrpl4lrBXsybfwEKWqH/uFCPcSd99J/KzOJBfyGyEI/vEcuC7USQ7EcqgnGpE0/6/Tz Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmjf7vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 17:08:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QH6UOo173265;
        Wed, 26 Jan 2022 17:08:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3020.oracle.com with ESMTP id 3drbcrhxnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 17:08:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/VXM6vdb5I0sinEw4cvgv5ll2zisyObIlPBBHwAVDeiJDKLIU839q9GBg3tjaqs7mkV84jykCJDPax3G47nnvKeYoBIs3OA0RDAQP6EsL2znKGlV9dHI2qxb4YsULzmgbFLzslNc5dXqkSo2Oujt3wcVKq/hXr91tGWZskC0qSigDxcOEh1DqJvqBUJ/CGChw/qDinO8DeJLS08ticJArD2n6YieM3+Qtgotjz7XkJKDYtfCvUEzBe4Kd82mJddNFozNli9/2yD0uju29KmtI9yWgr1tbDMTQ8KdjMvoNW1JgjQ7rSlTKaHsQ7A+UwQD6vfpd5OIweMYG/c0ETJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+kLu8kUMIm9nn6o6yBU3VvJFBdI885OZvJ1RpZtJzo=;
 b=oIy/ray8A0uQJfh+FMwVMLpThp8Dvuoh6QsNkD7DNjAy/++W7Kffz0oJMZcoVlQWU78FeGPfAfMRak0t2dkgEdedMoHZJJOkg5/lUHyYqiXNXxa8Mv7dTxyOW2J+RwVVoOG+bwdGP0xWxi/fR4o2a9SVfF9q55eeaDJ8jWBFpsspR5usPtvbJV0lR/LveZs0riWDBgjGXRdRkHpKDRFCFf0hAO+UC+79Wd5BMEvvsznKld8Go2I+vb8I2g2jFFFZZ/a2FzmiCj3SK+dEWFKLXtuTYIcYgF/oIY7dqaujcAdpzPoDVVuZq35nosYPluLFP+5neYv71iWD1DDsKqYRMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+kLu8kUMIm9nn6o6yBU3VvJFBdI885OZvJ1RpZtJzo=;
 b=Wo92XakqXFjhrI7CYq8XhO6AlC5dkC1XSZRktNWZ3g80GRxrizMaTulCwIOR/rHjB8J+adzClxt1T4+pw9CUN3fAD3rcK8sCmZ8frPZCJQnc+IP/IY4LZbgiiQaIglnWXgG78W30lN5Pm7FSdGu0k97+8gtrA+r0WDe1O5ODXA4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2058.namprd10.prod.outlook.com (2603:10b6:4:2b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Wed, 26 Jan
 2022 17:08:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 17:08:47 +0000
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
Subject: Re: [PATCH v4 62/66] mm/swapfile: Use maple tree iterator instead of
 vma linked list
Thread-Topic: [PATCH v4 62/66] mm/swapfile: Use maple tree iterator instead of
 vma linked list
Thread-Index: AQHX5r/5Qu921AGvnkWSJx5zNaXLdqxsKd8AgAm3XIA=
Date:   Wed, 26 Jan 2022 17:08:47 +0000
Message-ID: <20220126170841.h43m3xqfgyankitu@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-63-Liam.Howlett@oracle.com>
 <0f62ab3b-eee8-7465-bd5a-470e7e579ded@suse.cz>
In-Reply-To: <0f62ab3b-eee8-7465-bd5a-470e7e579ded@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce3fac66-4e50-413e-2a5a-08d9e0ee8410
x-ms-traffictypediagnostic: DM5PR1001MB2058:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB20586244DC695B9845484499FD209@DM5PR1001MB2058.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V6CD4qagTLO31YpexSB34FLYiyWIE2tWQgjuKNeO15K/tUxCf80TM4ZtJZkiU9TeJWZThPmBT7WoLYgJmN0wsLDDOVZdsmGVyyFUXE91GDgLCXnhfoWu+gXmn97Z6Fjc1oJ4X67PhVuNEOBHRIzslQBrW/sp7loTrPCF2rjOgBmevNvc7T9GvU4xkmQubqYyh1Jt5pJgi2/igy9UAHjRb6avI+BRRy1pl3e7OxHGZtjoMmEnD0TooLghB/YxYBXeuE4sjej10z5OYkUgRBfzK1GAJra7zyhf8m5O5v2+cdoyu/EmFi7lVeoOZj9FNLsm/kQUdJZVJBw3Nzmwbi+aBM2gyv0Raiobr3EjAZOqWdl/kE8JgOQcpEFoL7lunIva87Zj0HPxvUxNuG0WXG+i2c6zhogytF+rcc37xT18N2b+TZt2hrDXDsjkknbijvHzApzzapW1+QXxEhxp40BaUp0THOt9qELGP2LuCU0zqQJrIS1Re5RP50NwcZhMuQ/ZQe+1voQh/bx7AaKHcfUmkfvL9E3AS3apBVBm0Vvj0Z9rLGRv4Rh6PFLU/tJhxgkhtWG2D//gzQpvkLbGSaBizLoAPzXefrI0Ef6cLYGk78ZgK5ZwlK6BjAThLOh84UR5C1K8H2gzFrIOykncc/B9JU23gYN9d8TXx0WRzsX+5HeOHAeIy/9vcEJCYaHg9FsSdwVfUcAff/DonScFre0LEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66476007)(66446008)(64756008)(83380400001)(8936002)(2906002)(4326008)(44832011)(76116006)(6486002)(316002)(38100700002)(91956017)(1076003)(6506007)(508600001)(66556008)(54906003)(71200400001)(8676002)(122000001)(186003)(9686003)(86362001)(53546011)(6916009)(26005)(33716001)(7416002)(38070700005)(5660300002)(66946007)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kIzwqyxvWLwHT1d8OHBn2HwNATyt/9xlKIFE/Nxb++o2eo1OvUQPTBB8gP9Y?=
 =?us-ascii?Q?L0yJANI+C1KpUwRWECMUiCSxELZYi1aENuXcHevqeqA5Sh1g1kUpDLImEVbu?=
 =?us-ascii?Q?s/hdARcA0Ib9hXDuruOD1djzityPeyFOv6XgWiqKXO/W+YbJBfyHgnH84Ov/?=
 =?us-ascii?Q?qmaZQk7Fu2Lut7BZwcOYUoYEYaWqwvrL0OpZdp6NkJf2yL364sxSW6uURwcN?=
 =?us-ascii?Q?CZDT8E3ecydSGz9p8/ULY2lJG0j5lFh0hOAw89/U1S6HY6y8EJCHbR43SW9w?=
 =?us-ascii?Q?9KBXqyvdXZ8UOpIgDMZj7S0aVZBJY9sfXx8is6nBk6bG/hOonJGBepCbSR51?=
 =?us-ascii?Q?q2ldMqgPb90A2lXSRE8FvUqvJsK6W/Nyo6MLkKUOhDVA5TBHK75uAQEiSj0u?=
 =?us-ascii?Q?2Wl494jnS8V7K6SiwmO0PpmYO4jxCkjx7zoULxFFE4PboIJ1MQVyfbWxGGUP?=
 =?us-ascii?Q?pjhOPz7HGa2fL+VPW1XQnAmJNDCHbUO2Rxkxn5CiCDk4nYy27Le/9BE/JuPU?=
 =?us-ascii?Q?3zmiDTSyHHzmSi9/l+iZ5XslmCmbDx4znCGUn0A4pK5KYPu+KXYeXtsRuqrd?=
 =?us-ascii?Q?E/AKS9/8+b9215vbnRI5WIT4EPBrkQUBk57i8z4j/AiApQaiFdO/GOMhqR7j?=
 =?us-ascii?Q?mQoazqcqrDHiTMqhU2WYH5xskFZgPudwOhCoCF4eocKWMFEUt5hkc1cAVVKL?=
 =?us-ascii?Q?LWUA9JykP7LRwugVe+ymANDbRQuhhICfAI1YyLCSZPKwaE5FXTDW7cSp3qVn?=
 =?us-ascii?Q?LfjmvJHdNeC0MXCMAYWRzNPhjQvUH8MmRbqyJIRlP239lSwHxJg6xxHjeAtq?=
 =?us-ascii?Q?FB+IVBEpe7I6KFMDe69D+jStBdrrgOZCdr/AulonraOg7BpaO5GJp56CivLa?=
 =?us-ascii?Q?y6fMRqsqf7dyyHPtqaCgYnyuJLn6L/p3x2LQlen5TkliCfgQBKrinYJrl3IV?=
 =?us-ascii?Q?qDUkj2UM4/wMUigJZHQcycio/1DYbv3fEWY1WEt8a2aGZz4Pbd9GS2ZRuba1?=
 =?us-ascii?Q?4n4q6RBzIHKm46AVAqa+ondDm7F5bmqpYPIujq/SUd8rLHVuAnJSVXUYc6xG?=
 =?us-ascii?Q?kFNgUaC4hyGjDMsUW58CTAa7228xCdLkLhEBoXg2IiDNeOXt4sHqprGbtBfZ?=
 =?us-ascii?Q?QJkUoKasdxhZyl59Ea68mdjcRd+yQPDilptq4tMV5PcdhTu0+11yLD3SaadV?=
 =?us-ascii?Q?j73ttEDaCqyjxxFlnR8m5p5EF9CkI0tNl83Mb45rhgVhEnRES0aGZX9/qFqJ?=
 =?us-ascii?Q?eJIuj5C1Sh7cjLL0XAD6X5Fl/mmrNJpsvCcnFrk+bBunI1kZUsoyCQAnoNfD?=
 =?us-ascii?Q?I5FzuiXUsN/Dz8zf8XFHQ8vF37AZdB6bse/L9Z3KaBn/ZSYaKGYVFgWGWU1o?=
 =?us-ascii?Q?+G0b76Tg2jB9ZHwmb9C0WHMlfPWVcGG/yf7JzfDW6kYDkGPWuh6pCCVeOuMU?=
 =?us-ascii?Q?uORC7WBWDk+r9wrb1ECDowpkkPOpmjhwOUQ4YppYcpVUoAAZh3Mgtoqm+RLb?=
 =?us-ascii?Q?9aqj5fVWeS4+b6yLALyUm8fh08lgjUdZeEnyn2/7QvBueptfjzHqYDx9ResR?=
 =?us-ascii?Q?JeTWumrHNj1hfNoLmEc+WhbKCpculbj3OxQ5bo14Avy9MsteHs9Mlcyd5IaJ?=
 =?us-ascii?Q?NXVg7kQA7HmGmLo8v+fuUo8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9E5C86827D5A34FBB42CADEE6982799@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3fac66-4e50-413e-2a5a-08d9e0ee8410
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 17:08:47.1344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBZFeoAEtogF9Uao1Yio2v7JL+L5MxVC3xuxq6ftOcGiSQEEZvpOhcAPGQN3knslW/9qomrrFt+4JHJ0S3Eeog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2058
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260105
X-Proofpoint-GUID: aXU3YqG8XJZRCfEWxEPWsyoVcSYWHOgV
X-Proofpoint-ORIG-GUID: aXU3YqG8XJZRCfEWxEPWsyoVcSYWHOgV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220120 07:46]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> > ---
> >  mm/swapfile.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index e59e08ef46e1..21c88b0944f9 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -2103,15 +2103,18 @@ static int unuse_mm(struct mm_struct *mm, unsig=
ned int type,
> >  {
> >  	struct vm_area_struct *vma;
> >  	int ret =3D 0;
> > +	MA_STATE(mas, &mm->mm_mt, 0, 0);
> > =20
> >  	mmap_read_lock(mm);
> > -	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
> > +	mas_for_each(&mas, vma, ULONG_MAX) {
> >  		if (vma->anon_vma) {
> >  			ret =3D unuse_vma(vma, type, frontswap,
> >  					fs_pages_to_unuse);
> >  			if (ret)
> >  				break;
> >  		}
> > +
> > +		mas_pause(&mas);
>=20
> AFAIU unnecessary for the resched as we don't drop anything and keep the
> mmap_lock?
> (and without that it could be VMA_ITERATOR?)

Agreed.  This was missed with the conversion of the locking.  Thanks.

>=20
> >  		cond_resched();
> >  	}
> >  	mmap_read_unlock(mm);
> =
