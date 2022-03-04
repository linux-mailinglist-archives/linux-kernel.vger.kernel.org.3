Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C5F4CDD1F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 20:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiCDTGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 14:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiCDTGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 14:06:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948B61E3771
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 11:05:51 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224HAcMk011979;
        Fri, 4 Mar 2022 19:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=is/ytx/ArEzfr4Zz9gcyMjXHxosYjXTAJ0E9K/AWauM=;
 b=Q/B5I2I4DnWsVc24EY59/w82XbPFqa9WNFGtwEceJUBg2pITIsfL7TbZe35gHAYJHPEG
 H9m5YGnRylbf0wX1ud07LkTqPZQ4v98R7skRAF1TFosdgPVliiGkHg4rTPGGwnfPRcJg
 eRyQ2eTMXg9hZEBZZxSRAp1iVK6CgNUqH6FHm0gd58RZj9q573kQrAK0bGpGL8GUiPBf
 TBUVFrm5F2XmDmErKN6mAlfOUYUsQ22IuqNsEjtlB0we6sah7cRX7deF6ryt1qg2FaJy
 tVYJouuRGTjCwYdqZSOINyfNY3Igv9sUamdRVeXUbhgKGWmglY2ycCozDsL0KeF9wwIf bA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hvjmhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 19:05:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 224J0O3M002679;
        Fri, 4 Mar 2022 19:05:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3030.oracle.com with ESMTP id 3ek4juns9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 19:05:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dc1CY464NlGkIeL85dkjLIIR+tT4T/s6NXlbhO0cLlMw0xpy/73n40Z70KOCO+9/xhdbQFr+5fllqtRpSbBqDL27HX0rwqxjdIscJbJ5+XDLyCsTaQJjnI1iIeZFo0g9D71O0tf2bEAIFJx6TgW3NzheZFKEr2r3hbHUHFnVQ3GMC0xhMa+NHzJI/G7ysIvZApPk26ofuDVwXrARF6KknkwRKmlz2gje3WOo27/LK+i/PyOaenNvojB9/ZP/uEBENeALT65ZkTdN54D9ivIbB4pXbnWv+UVRtpspxr0663J2giJDYlmvBDKLZXqEigmHNmWRJtuelR+mSwcwOQjOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is/ytx/ArEzfr4Zz9gcyMjXHxosYjXTAJ0E9K/AWauM=;
 b=LAfSXdfNhD/u/ogjCkK0GPcmIuvZQODChzGEwLxCXXKQjkmT1R3hK4mL7IsqN3XIRzmXzs2T+7CtlYYkvbrFmqrEqPTHJi436IuxAUNfxte9bJ5l7T6rCCiR19fKJ0gm+brenCbynJRBM3vIdIF/ey0UkcFr/u3X3ihgYj9MCfHGED7BcPdF0IXON1eoSCbdjk3cSpjPdIpt37s5wWzS7MQRmG/vo4PYrVgkbmT1IvwuvDvJu09QXHTI69cxVc8ocVxvWGCBKfDALJ8NGIdu7zfri43uY7jrjK8WWx6wIQYT0SUtGqKxcjI1IKhJMDPBpwR51ojlgXfXXxbBXrzIXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is/ytx/ArEzfr4Zz9gcyMjXHxosYjXTAJ0E9K/AWauM=;
 b=fidPcgEMPTtaflZNsPWmwVs/5V/PD/tpQuYJcvLoOW76YLNCuc2XmCNE2LwLo9vJFsebPN4kIkhReP27kSmH2/VREiV1FuSmO+QB5UIOYk8NusOCaZKzKIB7r8mDGbSiUSWjZjD2YvyC6PaFspNE6580s0EA47xktEdeZwN4cXI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4614.namprd10.prod.outlook.com (2603:10b6:510:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Fri, 4 Mar
 2022 19:05:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 19:05:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
Thread-Topic: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
Thread-Index: AQHYL4FzWFkyFnZUSku+xBH1UQyT+KyvkiKAgAAEfoA=
Date:   Fri, 4 Mar 2022 19:05:38 +0000
Message-ID: <20220304190531.6giqbnnaka4xhovx@revolver>
References: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com>
 <20220304184927.vkq6ewn6uqtcesma@revolver>
In-Reply-To: <20220304184927.vkq6ewn6uqtcesma@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0f631c8-4087-45d0-e043-08d9fe11f82c
x-ms-traffictypediagnostic: PH0PR10MB4614:EE_
x-microsoft-antispam-prvs: <PH0PR10MB46148014BAF7235ADA751D8DFD059@PH0PR10MB4614.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uB/7bJzEQ7AMdJr9Y8x6cIrT42utIFra9/AJKiXPBtRTa/E5xXnAJo+Jy4ywf63jdrJrC/e/AGGdbCkUut7wwROONlhGllVhDH/Vo9fYF3vmObxzmlGlkOQNIcqefj6tGlH5vJIp5ACOsNXr4GBs0qzXZPwpq2xEEan1/lKcCTbEr+dPAs6IQ3FQG2STwcCynbcSyjTFfE7qoXTqMRigSziSPkttVA9ZdYAQhZcgBOw7bPRiO/P8Gzb9+BVM/BqnwOq/ioWY522Ffg052SXAwvF3sNMWOuHDCS624s9T//zKQTn0dA17aBTA97bImJDgNThmPwcxxrtHMk4YsAjCRmDyNa6Dnx/OYxOBizZEd/HYqIeqT7DJhmLU3vgruaGkXEUrav4Qt4Ia4v4rtWWBMgt6xgMaMvKdLAPgGNjEyvZIp3ygfT+13EiF8GTc5WQXgjN85VuxheDB/myj6HSxUK5tiQ3s8eXCaRweVsg+a+Ji8OvJU+ko9MnZSJs3lvZS/BQTfnZFrLG2t1bnEoxUaaj/MKWr2ZzMKwgiAHnc0nuh+TZgWjISagrQXBsS4rvpnOrgyF8C0b+qMvnb6JqHzDH82TNW6r+oRZ2GyK7hIYl+3EhKen9Ibt3k8jcMaTr5aGP/mhjKWjlN4acnT2Ens1CMIbdOxI/ukOW/YdpWSNjhKd0xf/yVaAaYJ7zNgF56euYA6eLmNzvMhanUlPBoMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(2906002)(38070700005)(83380400001)(186003)(316002)(1076003)(26005)(110136005)(86362001)(5660300002)(122000001)(8936002)(8676002)(6512007)(6506007)(9686003)(38100700002)(66446008)(44832011)(66476007)(64756008)(76116006)(91956017)(71200400001)(6486002)(66556008)(66946007)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9f5j3qBPK8NKSrRJiKZ+TpIfaRI+invdZqmelH4jH/StrlRRTS9KT9WjFOjt?=
 =?us-ascii?Q?mL/cyCS8rnz62Q7eZj8U8e0UyabtUphBp/D57oLI6VQ69OPePtwlP0kuqxW6?=
 =?us-ascii?Q?gEJGo4yXnCGIM5RB+jp9BuhdS+90yT6vF+Tk+d43nS4ROXGdxA48FUocAGoa?=
 =?us-ascii?Q?12Ia7dvyWz9GRrR0VSTO73wVtPPdSZgp5UUrOHL21Wij+8KJ0DbF4gCggvWl?=
 =?us-ascii?Q?tqLInk1299uaghkiIXF7qK+i2B9UZroY0udp09c2UZS0wk0l7/ZN6Us9hiSG?=
 =?us-ascii?Q?qrPQ827Mlu0une6h5RKtYxoRw6q0ZDunkz9mkOpsozhLhkM9fsLzYNcknnUD?=
 =?us-ascii?Q?fz5T1X5Mivu9onWz3VV+aLdGENb5QmQyFvs1ojPjqRN2STmUL28PC7HdeqmJ?=
 =?us-ascii?Q?RpEQkGV87b/98A1QrIjHWG3WmDarYrRQ6p53aYliuYl0SHa4r58DeSZmd6dp?=
 =?us-ascii?Q?hxX9nQwxkfAB31uZ8pljWECItImQ0ABd7rAdsivAWaThyNDB01J+EVAPAo2G?=
 =?us-ascii?Q?mxJv7bgZTelJhjfugsGAceL/fGPbMASlOhb5+AGB4ZwSJv3Jmpd5XZLtcm+w?=
 =?us-ascii?Q?rfJm4G6ssxuCU16BfGTbNM6gujguispWePx14l26C6AHjfyL3rljMXjdc+nE?=
 =?us-ascii?Q?7qb8eKNcxxZMzBJwYYkMpxKupQYU4Uv7vnAlQDUh+Uj3yQn3SuLuKK3XInjL?=
 =?us-ascii?Q?CWKCaZtJrHZC1vYnUh/fif5aEngcILXPqtpln3p+XsyDZYnJpjM/c61Fy6Mw?=
 =?us-ascii?Q?rHLuy+iZ5sBrUxx8xCsviSyNtXFlecGRhWH4G1R0thkdV832fmNX6ei8FHTN?=
 =?us-ascii?Q?438GkZuONXeCzYvciiQ3jFNAKfgT4Oe9YMnmUjIur1MGtVRaRa5lJbwglpwi?=
 =?us-ascii?Q?pN5N71M4TH71lwowDiBAMVCHWPqQQ6BcOZgmpiGgQDGcP70a0BA1+86i9iRH?=
 =?us-ascii?Q?3yxH7+4GsXrUl56G2hP451C2IflXnmFXULGKabyyHQguv89k2rNol8SX2EWI?=
 =?us-ascii?Q?OlWv9KFV1zfSrYowNQ3fHZ7BEx9Thj2ItOmI9Df6tXkhBEp8fV0xKFCyguUo?=
 =?us-ascii?Q?g9UgQKBrvgfOb4dz9wMiAYGevou7A6obxxO4n3i0clreSXYkEKFpvb4AecOO?=
 =?us-ascii?Q?bUm7cS3eiPdBcRf/hfyZeztM0TmfcSGVD3bvVO91UNYHnSAbIqDEvJ7IdrMQ?=
 =?us-ascii?Q?H05vRLhBynfic5ajzLu7NLRVUWg4O06az4RRD5q8ckNurVhKskj31Y/aVp/W?=
 =?us-ascii?Q?mxJdivj0UlJqlkmJkkpbV4wJvPI7eV7il1NALDoOZXTLKa1iL4H0fg6/Jced?=
 =?us-ascii?Q?0YXr4NNRw140ogj320jo/lidtzrK19TlgtDYcJuxskUtMbtfGJuROu4V1jNO?=
 =?us-ascii?Q?7DPgCPl8iz1+IdL9XkcXSlgp3Tl4mas/T26rHTJZ1EWGvi3A+vtzK3qZxqCi?=
 =?us-ascii?Q?5C7/E9WG/abuQwPw3KIYOWedYNHnpsIKtN+CQdYO9/N03S/opWXYsCSyqrdi?=
 =?us-ascii?Q?gWcCjxYEM1AZf8pn7w4kgVoMS/SoK0EsFc1fz9+p3S2k1xIX3LNbUpOPOVIM?=
 =?us-ascii?Q?weF2/QhfRumI2bAUidPQVnWmZ0/hyww3qLCvbQ0SwHwk7TICDx4R3BUvInN2?=
 =?us-ascii?Q?nxsCG0N9BPlDvMkyjvyCFMs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E564D1131C39447A89BE8323FABFD46@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f631c8-4087-45d0-e043-08d9fe11f82c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 19:05:38.0913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMeA4UtgRBLG3o1hBl5WxVl4ZfLl7YuZivOlnf7Fzd4HZdSZkUxOGcB3mU8dEycoipuiK++LuW86QUKQJ5Naig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4614
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10276 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040094
X-Proofpoint-ORIG-GUID: _Hk2aQZBQi-PMk8PWWRDKDinBg_N-OGN
X-Proofpoint-GUID: _Hk2aQZBQi-PMk8PWWRDKDinBg_N-OGN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [220304 13:49]:
> * Hugh Dickins <hughd@google.com> [220303 23:36]:
> > v2.6.34 commit 9d8cebd4bcd7 ("mm: fix mbind vma merge problem")
> > introduced vma_merge() to mbind_range(); but unlike madvise, mlock and
> > mprotect, it put a "continue" to next vma where its precedents go to
> > update flags on current vma before advancing: that left vma with the
> > wrong setting in the infamous vma_merge() case 8.
> >=20
> > v3.10 commit 1444f92c8498 ("mm: merging memory blocks resets mempolicy"=
)
> > tried to fix that in vma_adjust(), without fully understanding the issu=
e.
> >=20
> > v3.11 commit 3964acd0dbec ("mm: mempolicy: fix mbind_range() &&
> > vma_adjust() interaction") reverted that, and went about the fix in the
> > right way, but chose to optimize out an unnecessary mpol_dup() with a
> > prior mpol_equal() test.  But on tmpfs, that also pessimized out the
> > vital call to its ->set_policy(), leaving the new mbind unenforced.
> >=20

I just thought of something after my initial email

How does the ->set_policy() requirement on tmpfs play out for the
mpol_equal() check earlier in that for loop?


> > Just delete that optimization now (though it could be made conditional
> > on vma not having a set_policy).  Also remove the "next" variable:
> > it turned out to be blameless, but also pointless.
> >=20
> > Fixes: 3964acd0dbec ("mm: mempolicy: fix mbind_range() && vma_adjust() =
interaction")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >=20
> >  mm/mempolicy.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >=20
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -786,7 +786,6 @@ static int vma_replace_policy(struct vm_area_struct=
 *vma,
> >  static int mbind_range(struct mm_struct *mm, unsigned long start,
> >  		       unsigned long end, struct mempolicy *new_pol)
> >  {
> > -	struct vm_area_struct *next;
> >  	struct vm_area_struct *prev;
> >  	struct vm_area_struct *vma;
> >  	int err =3D 0;
> > @@ -801,8 +800,7 @@ static int mbind_range(struct mm_struct *mm, unsign=
ed long start,
> >  	if (start > vma->vm_start)
> >  		prev =3D vma;
> > =20
> > -	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D next) {
> > -		next =3D vma->vm_next;
> > +	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D vma->vm_next=
) {
> >  		vmstart =3D max(start, vma->vm_start);
> >  		vmend   =3D min(end, vma->vm_end);
> > =20
> > @@ -817,10 +815,6 @@ static int mbind_range(struct mm_struct *mm, unsig=
ned long start,
> >  				 anon_vma_name(vma));
> >  		if (prev) {
> >  			vma =3D prev;
> > -			next =3D vma->vm_next;
> > -			if (mpol_equal(vma_policy(vma), new_pol))
> > -				continue;
> > -			/* vma_merge() joined vma && vma->next, case 8 */
> >  			goto replace;
> >  		}
> >  		if (vma->vm_start !=3D vmstart) {
>=20
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>=
