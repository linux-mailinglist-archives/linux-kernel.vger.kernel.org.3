Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116644CDCF0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241425AbiCDSub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbiCDSu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:50:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C2B1D67DC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:49:40 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224HB3mh003471;
        Fri, 4 Mar 2022 18:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pz7Oqi3mp+e0dv5yRQhubplWkJYJBPb8cVo7EtsgR8Q=;
 b=TGxn+uxBi2IYhj6kBpVS43ruScsfrc1UoJ/SVDVDso60LtcT3afljWzkl0L1KEiFkqAV
 DHIDaLXBOO/5nlS2YJUii/0A0j3qcFVsewIjelrDdnDctXBACO8AXsm8PUkqCE6k2maX
 ZkkcDvm+SHOFvchr0liRreS5ChFAtR6bECIFS/qDKGDxQnvo6Usjh4GIK9/qjPaRrxRT
 l5QHD8tzsLMxkL60zkKRqa69XgT7nU0nQRCrfvfmzJFiQHQaFw5078O0eCyvw+t4Lxrp
 ZucjD5ZhikSZzPLYtEtURDINQ6R3PKHtFYtTCzwAM5iosK4+aIUSOJr6vYFnHut90wws 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hrtkvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 18:49:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 224Ib2cN170442;
        Fri, 4 Mar 2022 18:49:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3020.oracle.com with ESMTP id 3ek4j9324r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 18:49:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT9gG7rmMUSZyVIgiJ73SFPYeXxBKEoYvSyl2ZhCS4RJfvPLFk+NBuHgolssoVIKSWBRNL3FahA1u2kns7neyii203qpznA71VgsVVokjIWCbMDgrVQy7cvfH2FQEfptuTfXOxOfD3+sk01T9PqEKyVHd7BGPUaHJYjcLP9V+yDnJBu94hyviBcs9PeB16FrBlDbmLJnHS5ZhbtGQLG9WbEgqqALJpQB6nKAv2x6QcX63s0oAU9TG4XVwaHzcbAU4cq+Z64UVAkVCalxMUM0djxOerWlRgn+TQrb58cWuiRi7iiSNradYcWsqgaoGYj770mGIwFJoXZW2V/XN7RLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pz7Oqi3mp+e0dv5yRQhubplWkJYJBPb8cVo7EtsgR8Q=;
 b=nBQ0lycN6b1S/b57AQ3a4mstIewk5iGS0tvRREwmu7nxBZ8yRhA5ZKg2h8WiA2oGZz6xmJwI3R/ulVMxWbAV/r3PGR4DhysAejfc1a4DMMviKqLtQyTKBKZ8DYt9VpzpVh1XF/K/yQy61+ByUu7zIqLhUl6eTGNA5XWNVtMYxn+PXVMmlIHg46ETxIzWDEq89N5YHTcIvI7xymPQNxVG62TauR/XHQ230iNvpf3YcZFlav57K0i+qC0/tsHlgP7+8M59zm9GESFeH7gsNX7RurDYV5/hJaBOzccRFkNdpwbOcNFYqxhyfabJzFIFvT7atnwNxCTneGKA7MeIvsIpkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pz7Oqi3mp+e0dv5yRQhubplWkJYJBPb8cVo7EtsgR8Q=;
 b=AVfUbaY0d6d6KIDtDDNcIRyplRaSQ8p0WX+S+WNjIDRHMZOzf39LzeeOxuEmHKr055J7Yj4SBA0gTt9VyrQk3h2yqHTkMpdpopoYw2bY4p+vfutndeO2PV1v5YE9T+aPAKCnPHQ4G0SZONsJw9mYIEfVdJHS1m123xsycOGyhnk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5212.namprd10.prod.outlook.com (2603:10b6:610:c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 4 Mar
 2022 18:49:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 18:49:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
Thread-Topic: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
Thread-Index: AQHYL4FzWFkyFnZUSku+xBH1UQyT+KyvkiKA
Date:   Fri, 4 Mar 2022 18:49:33 +0000
Message-ID: <20220304184927.vkq6ewn6uqtcesma@revolver>
References: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com>
In-Reply-To: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6ce9fd8-1ce4-47c6-7789-08d9fe0fb964
x-ms-traffictypediagnostic: CH0PR10MB5212:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5212F520E8AFEC6D41F09F0DFD059@CH0PR10MB5212.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DqYYiwKeAiP/tfkUbUErwexixMgS5M+SXp1rM74b148OKIOGS1KDgU8erRSyMkpVRa8ZqVuuXnoiRa8wk1CcJCI9jAjlRkHPiKG7ORXcMgGxdWlSktwKPGqU0ruiL+BKrxO3N9rEgbBUtBjct/Mijb133UXxMjCbDjT5X3+8rGDsvMrvGAofL8LBHLxk0dKHoFfc/2HIRtqHDKO6s41XABikiU1L6aFyL9wU5uHF9tjPKue5FZ7M8J8lzRmatKDkJFRBA/YW8yYVNH11xE2Qe8VTK0mewryib3i3qQmi6bj1feF9ndpxL4oV5zWuvVVMrpO0p2PydXrxhykUeLyS2U4P89DxbLzUAWdkbvHBo1WBUpNOHtCfQKHavHDAa7YV1RsZUcPHMXRHRjKpg5onPfDkJCQSCRnsyJGGX7AXsjWAXJ8WUsV27gw1QOjb1lv4u7rdfC33jOv/jQKQSK61UUvKMRbzISmXxnw7CiAqkRJVGEXFn543uRc21C/ObYn2vKlJ5g4Y2Y+rVmBPP6z56jDYKy6lT7rsSZOnn9vz8Jjpzp5Y54NiK3SP6y1lt7MVrBjKRpYvPYyTItCMiYrWjp3vQ6HdVy1VFltR5z4tZIFdm66TEuqF/sD/f2ppVzX2lZyM2d7geq+x8F77AretJyuY7YyrfOM516XOcG06zydAPN8XluB1NSZiCmE+ELPZigPDs5zOnjkpxkzadXgitw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6512007)(9686003)(316002)(2906002)(6506007)(6486002)(66556008)(66946007)(66476007)(64756008)(8676002)(508600001)(66446008)(91956017)(4326008)(76116006)(71200400001)(5660300002)(86362001)(44832011)(8936002)(186003)(33716001)(26005)(1076003)(83380400001)(54906003)(38070700005)(6916009)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ad4UyP1RjmiaFA8lBTRpHlb3wpShfuG0X/fobjkul3ImQiHqOgNBTw1UnOgn?=
 =?us-ascii?Q?fdA1Z7nJh7eKi9mg1FCBatD8bf00SFZe46B0weKV+Ay3tiePzjhos+NYt1q9?=
 =?us-ascii?Q?TBce4tU15/O5vgM1oht2e/2gebGHbMUU8UxOJafOhQDaT+pDHxu02147Qs5S?=
 =?us-ascii?Q?LqkJ3K3jmo9vCVpUHFs0dMJ0Ynns2mqp44F9AmLGivQ5I9CcOwZjowGb6PDJ?=
 =?us-ascii?Q?XDcjtTleM5O+oSPU1sx0gbyhUYAua+rAiNENug0b+oXQeQJKHuPChs7c+ESq?=
 =?us-ascii?Q?+q68Q0mQq2zk13errsdeKPSk3oB08wmfPHa27T0SJJ+gh3f9FaOT2KFvQ9r+?=
 =?us-ascii?Q?2nyHUHWUacqL0/6Tbq66bqV6Q3i+cZrV1KS41hX6LM85U7dErX6L8S4OCDAZ?=
 =?us-ascii?Q?ogHuNJTzGKNfxKhgRyQtNRC8Z9ohRRxNe7RvsL19bM7Y/QpD9+e7ZV8OBhVH?=
 =?us-ascii?Q?6Kjaq8d0CpcnPHvbQ8MyIzcX0yjkl/GfI/xCL9krnILgfYCk5mW3q7IxQ2z5?=
 =?us-ascii?Q?tFai7I2NJ6PbA4SdF9P3dSX5B/lDCK6zZErPQfWdr2EIt0kpbbBdsmb+Kw+M?=
 =?us-ascii?Q?eM65nRzRm+aIGN54miuDsi5wGCfrsH07XRwyusk2WbgO+jA1QImB28IC1wpc?=
 =?us-ascii?Q?/5o5UkJttXYJcLDhUHBswrJEDWMZyl1KMzWrtk9rJ6brSZV4ZBm0pqlrUcO4?=
 =?us-ascii?Q?Iy7id8u/QT3gTF/FmycCzKl9CAzKkRlhTIw3t6FH0jRmXEjTIjfHhS4ih9OV?=
 =?us-ascii?Q?1cJQWajJr6em1GfSHliG3HvR1QHydYhJnCyt1+vOkoO4ehYidnKiBXMfB9qp?=
 =?us-ascii?Q?OnXW9ptYpCht+eTbx8jKd69aSpjO0e4xrFlA49tukFavKDx0ihJUvv+FkYNj?=
 =?us-ascii?Q?tZ23eHl0Ve3Q9N8NHvJyMcolKCO7MidscCusjl3nF4Aw/+m9s1+mXUb+G8Gi?=
 =?us-ascii?Q?fxgWLdltW+f/fAJyJncPT46+tnQAkrkOfU/g1c55wHKjrekLOulFn7dghwuu?=
 =?us-ascii?Q?iaHvCO3E3t+54VfUo4I1a688v9+GHCeLzfOFX4HS2jHmNMPFiTO+TCrCWUMx?=
 =?us-ascii?Q?f5Q89MSZ6xtTO8TFH2E0QxYHrXyzR5q646ePQJmyJC8uApWRWIfjcDYkLWce?=
 =?us-ascii?Q?urA94T8gJjPGI3JyxLgN+q9PqgshB/zQLIiwMf750xltfW8yft4u0mj9mPFk?=
 =?us-ascii?Q?gG4gv5QU8nKxg3dewOCaGcmlMlgNSBV7Z4/xDYW+DxG83Xz41sBWJiLjXCoE?=
 =?us-ascii?Q?I2qBFuUBDIBv+eOtpvtXUhGoEZfbxSD/quoPXh81L1QT0XMqVgfMbWdC1mFn?=
 =?us-ascii?Q?a3ArF3gDdp5pwqa2ZxWLEmCABI8Z5hqzHTLfRoX6APm2xqtl8YTOSaIQrplO?=
 =?us-ascii?Q?6N3a4La3SclEAp+mqMfVdwluILdpDLlNQRXCdsQLOadFbXixJ33o/zwICzdI?=
 =?us-ascii?Q?veDubmk0lk97IH8Uw8uYYAek0MHDS893POzGwxbx/ZB6FdYKMkX9pkiI8RKP?=
 =?us-ascii?Q?HjFDfUA5KRtwboG6Sw4bgGXhfr7ZC7x4oBVxNTe5NOhzhRmXCxgz3pMrzwZa?=
 =?us-ascii?Q?DKOlOC7J9hGE8StgXd2wgJ0mNGBlwpUANWABRtEgrLx8wNHSB24FC9NWy9I0?=
 =?us-ascii?Q?oWtFOWPX43Z5PA3juf5GoFo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0929FA07B20064D86799D5C4B8F5837@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ce9fd8-1ce4-47c6-7789-08d9fe0fb964
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 18:49:33.7657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88VMNKKHaopT/0fw9tNaGlwqlVeuhxv3/C0JtOFJR3/pHNhOGI75ylL9x4AqrENzQgZdOh7imIxuFGs7CG7o5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5212
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10276 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040093
X-Proofpoint-GUID: xlLLAiT_7EPbTlpQ4AcuTCD1NlHb-yvo
X-Proofpoint-ORIG-GUID: xlLLAiT_7EPbTlpQ4AcuTCD1NlHb-yvo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins <hughd@google.com> [220303 23:36]:
> v2.6.34 commit 9d8cebd4bcd7 ("mm: fix mbind vma merge problem")
> introduced vma_merge() to mbind_range(); but unlike madvise, mlock and
> mprotect, it put a "continue" to next vma where its precedents go to
> update flags on current vma before advancing: that left vma with the
> wrong setting in the infamous vma_merge() case 8.
>=20
> v3.10 commit 1444f92c8498 ("mm: merging memory blocks resets mempolicy")
> tried to fix that in vma_adjust(), without fully understanding the issue.
>=20
> v3.11 commit 3964acd0dbec ("mm: mempolicy: fix mbind_range() &&
> vma_adjust() interaction") reverted that, and went about the fix in the
> right way, but chose to optimize out an unnecessary mpol_dup() with a
> prior mpol_equal() test.  But on tmpfs, that also pessimized out the
> vital call to its ->set_policy(), leaving the new mbind unenforced.
>=20
> Just delete that optimization now (though it could be made conditional
> on vma not having a set_policy).  Also remove the "next" variable:
> it turned out to be blameless, but also pointless.
>=20
> Fixes: 3964acd0dbec ("mm: mempolicy: fix mbind_range() && vma_adjust() in=
teraction")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>=20
>  mm/mempolicy.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -786,7 +786,6 @@ static int vma_replace_policy(struct vm_area_struct *=
vma,
>  static int mbind_range(struct mm_struct *mm, unsigned long start,
>  		       unsigned long end, struct mempolicy *new_pol)
>  {
> -	struct vm_area_struct *next;
>  	struct vm_area_struct *prev;
>  	struct vm_area_struct *vma;
>  	int err =3D 0;
> @@ -801,8 +800,7 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
>  	if (start > vma->vm_start)
>  		prev =3D vma;
> =20
> -	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D next) {
> -		next =3D vma->vm_next;
> +	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D vma->vm_next) =
{
>  		vmstart =3D max(start, vma->vm_start);
>  		vmend   =3D min(end, vma->vm_end);
> =20
> @@ -817,10 +815,6 @@ static int mbind_range(struct mm_struct *mm, unsigne=
d long start,
>  				 anon_vma_name(vma));
>  		if (prev) {
>  			vma =3D prev;
> -			next =3D vma->vm_next;
> -			if (mpol_equal(vma_policy(vma), new_pol))
> -				continue;
> -			/* vma_merge() joined vma && vma->next, case 8 */
>  			goto replace;
>  		}
>  		if (vma->vm_start !=3D vmstart) {

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>=
