Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4931E49694C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 02:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiAVBye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 20:54:34 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25206 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231879AbiAVByd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 20:54:33 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20M0amFK006866;
        Sat, 22 Jan 2022 01:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4Bn6PRMXDbF+E+mEUwQqvghFVU9Wyiu33nEFFLbIbgM=;
 b=k3mvsf9wvfiOWNUucQutMIJj0QiNB3G1b6cdRIM0tlcadVXMNFI3NI+nH2IdRLk8xYxl
 KMHG/cMaqfCQouN4dPOytSkJQtFZUBNflmffGuL9exLzpynDIB+D5Ong+YbujTcDPcMK
 Q5pW4VMVjCsfQYA90rtVZdnN3GnQehwd88H258mUxwf7bhUixiD0y7NVs/DP0XzTeS93
 iAVBEb6q1YiD1repd0GgZlflJfq5/2WeqY4fqVgk6mjKkpBZJqgBSGOAN2mQK4T/dRqV
 ZYEv0aSNXlGea/hskMBdfmiqYnqAg05AznNQvJZcBTrjOh7hCmsESXmfPh2Mn0/o3NMQ 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhybb1cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 01:53:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20M1f59G165123;
        Sat, 22 Jan 2022 01:53:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3030.oracle.com with ESMTP id 3dr7yb91gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jan 2022 01:53:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1YimjHkwew+3Yml4V61m5xO5incVpPTXt2yss4U4ORGoSxD8HhRpZE0deSpfJthmJuNn1exL1xxbZLFtZd7HSCpWu8VigMR2aukWIAmRJYsSmQPAHcgz+cV62h7ntthIQsTtSX0Y1uayCI1jIuyTLyiq1459rcT3KG/0pfmI8NuXNHqNo6mw3WZcU6DOQ41yfMyXBREKbjX1NYjZwFKt4qVap4fMEAIXULZLJsbICkTsmsKzAsNSfi3K5xC11qt0fUg6n98qKiUAd0YC97jLFCLHOwNGzvUYK5KDGk1l2Xpjor6OGcNJnixQziLqls+D9aKyRl8ItIqhcPze31PDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Bn6PRMXDbF+E+mEUwQqvghFVU9Wyiu33nEFFLbIbgM=;
 b=KHbtzgrSK7qK8yT9wYO18b4YS3W71e3k4cTLg5OaaPHU0c5V5nRvhaVvceWE48XYXLfasCNppKzdDYuVHo4BeVZVO6YF5AYym4Q3XmkWcvzzPnzC+D+dkNEndpZ5H30kzJasKacZa7BDImQyi7dy9DaepiD8VJ7LelUBfst9yGY6RmyTY1iR4Mv8plO6phHyN7YzqOQzN+sKHaDfB+uj8zAeMDDUxzZvdi97PUlauoEbo/0R7/RlIVqni1GYBpWAswRZQ3cK7YtO2mI0EQknVfYFBirR2rr4EnisJi/imJx/dQFTD/ExScxeOOdvu1BECFnPx8UxQyljFGVshobs1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Bn6PRMXDbF+E+mEUwQqvghFVU9Wyiu33nEFFLbIbgM=;
 b=EsFH4G08ZbFvl4Nd05tG/LQLqGCbPhkGAGbFU7D03+aFWfRW3imMO9yNCTflxJbeAON1T1NWft8T1ycAe0tEHgyFs82qMq02hje9AWYi7iPM8aI/BXicMKiThMKgKzrVz7ZfkkwRfv7sQ3nGpxIcVXapBF5YkeY4H1/9kci55UQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4327.namprd10.prod.outlook.com (2603:10b6:610:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sat, 22 Jan
 2022 01:53:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4909.012; Sat, 22 Jan 2022
 01:53:40 +0000
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
Subject: Re: [PATCH v4 27/66] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Topic: [PATCH v4 27/66] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Index: AQHX5r/usRUxQs+IyEmLitRRgBJ0VKxo97CAgAWghwA=
Date:   Sat, 22 Jan 2022 01:53:40 +0000
Message-ID: <20220122015332.hjbplpzchsc725ll@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-28-Liam.Howlett@oracle.com>
 <bc55bb89-9986-5271-2e60-a38ec0d44cf0@suse.cz>
In-Reply-To: <bc55bb89-9986-5271-2e60-a38ec0d44cf0@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0f16491-58e4-4454-410d-08d9dd4a03b4
x-ms-traffictypediagnostic: CH2PR10MB4327:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4327EA731CEF35C3686EE82CFD5C9@CH2PR10MB4327.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q/dsVfRu3BHk56r7G94Aj/iOfWPL4artLtxgDnOe4AVrLfTvvprRibjJ1P3Wb2Bu9no2HXHMj7sIkeGQ6HTant13dDvlGwwTOiInGA1Wk5DPklvcRfz1YOhFboj2MdgdG8ZRW1TbFvDPbIvO8aJYK0tbf/zoQSVSUrBekwtLMAuOKxH0c28tpnfm266FzCm0JCBt6+fRczJFLrj5Q9ecbnoeyCGwyq1owxTyw88mk2Etd86MPD9eT95n0WojObZiXrEgTqVITAJs6a9DBeo56xgFNkvqAnB4R8e42EjAcLd2PUfR4fmPl4Y8OA6uLeKwFPpUwWBuoMtSdnzjoj0MmwC/Afh9H5016L88YTT3U85O9BcyClBB83fmpECvGOwMikX7iFamIPrdLjiNb0xAFg363uC2beeNue3l9MaVQtNV11lNtGFLKbwLQ17nt6/D97F6njy5R5gZXc7XN6NTAD/o5LUVb+wUK/GLXsOjLktuQ/YQs+v5g9VO8jxxYEePVzGy0Mn1Ixl3qpeAFJvIWxeMCddRLdz23voKYQFdfx2U3e85oVzP/+9mJw6AW4JQyzOhM8Qb1jGike1NXu3VvFsIX8QKaky2ANkX6u8E3h2ajePFj4dEJIXJ6eZE+aDdEIjVR2oM5AVnt/LdJoSJfDgdpj2vu6fexhKc8oUxJ/HNzqBQXTJpWAEyxAzZMYBMYCJzMhJUpFrvLxQLO0Pr5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(71200400001)(7416002)(6506007)(8936002)(86362001)(83380400001)(4326008)(508600001)(6486002)(9686003)(53546011)(54906003)(6512007)(66946007)(76116006)(91956017)(66446008)(64756008)(44832011)(122000001)(66476007)(26005)(33716001)(66556008)(38100700002)(1076003)(6916009)(38070700005)(8676002)(2906002)(5660300002)(316002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HQx2eufIybOfLInNFhuS2HmITVkTmcJeEzimMhvLetLFfnuL51bpsh8bl0XQ?=
 =?us-ascii?Q?oIrvpAX/ONNByZ8+jpjX9TU3fmiq8XMpZiPTAnpAMKrjYzRL5losXP93TuSS?=
 =?us-ascii?Q?nkYU8rd8pBT6fU9ihJcaTnihyhmHLtC93WLQ1Y21aMJMyoQjL0D3JnqvSavG?=
 =?us-ascii?Q?NXIbIbpzeH1E+JLwmsBhs/Ojtz6RxVG1WplrwgZySJJ7yYRaHUFr/bleE1Lz?=
 =?us-ascii?Q?CVRbTUL9TEQZi0HwSKKSjL0kEmQ9eglloA1i5KzS8Dl/AvZix7uhWBrhl0XD?=
 =?us-ascii?Q?XuE3g1/ZCBgp1PJ4GfJf4GYiCMKok2wb4L8qcR9PVK3xvAK2ls97qMR00W53?=
 =?us-ascii?Q?A57W4UYbfZKAkUQzeGhmioBk/DpL3J4eQ+kQuWs5VLY3lQ3Uu6I7H88/b/Bg?=
 =?us-ascii?Q?IqP4xVDmDlvssIqe61Rejd8O7RFsLqSpNCHMhJ05rPzvLM4SAOvNQV30kYQ8?=
 =?us-ascii?Q?qYDLkvHh7wR0XhHfIpGi0pA/IGNjiIdBM47ffT44JUGtIgq8OzKjqXqDUF/z?=
 =?us-ascii?Q?/njpPK1oyWcFs6hK7pmOq5wDddqsxdukbOK8YhRUXhYwJQoaeGowfSTcs6LO?=
 =?us-ascii?Q?UOPBHYwfEXuNK3LqpvgiZiMEMinJXPSgfF6HZU5LKjwdkrHnpFlNXoNNg9C4?=
 =?us-ascii?Q?Xtha+F0y7X+JzmUDkL8ziW8R4zDjEn80Z51luBNHkCeoHqAnNpxPypdWRKt3?=
 =?us-ascii?Q?O+XJWSEqEFdmhBT70qenaDwZ1Y7l5u/16cSwOggxj4Yo2MK43WbcnvDmhKTY?=
 =?us-ascii?Q?HnMEqdNkp1Os4Ttg65Cf+JDpfEXJn4e/pQnVzXgm9JAtghlaIyMKTarXAYdN?=
 =?us-ascii?Q?deFe596i049WauUn6N5tpnz+K+sBk2QUVCPM1/Owcuq1u7iPLY7TF9NnwL1u?=
 =?us-ascii?Q?7jd0jUApCd0M+NsZc25XlK8KhwhIWfZNirfhR9iGMweGQMqm+Mlf9YVn2CPv?=
 =?us-ascii?Q?7S2jvkWh9xdq4lSsfqbaEHtpiR6ktLPf4jelYDSdl/xsAmu3a9EeKxFtyh3R?=
 =?us-ascii?Q?sHo4355TqwJ+R1ss04ObHTegLuZKFYOAL1S2A78J+WPWE/hLpGxT02eSUslf?=
 =?us-ascii?Q?dkRgGXAyTp2Y3gDxK6WpRtjuqjKaXcxUi4PxrPvl/efhXxEdyYmxqvVYAbXw?=
 =?us-ascii?Q?bNQ3HvOJawJ339lxjKzhHMru9LlFtqbVusUV99uEGvZ8qHOnQInHzeTanRl8?=
 =?us-ascii?Q?2d2IwP3Olby7Tl4Yha/zgdUOlyq2p6Bhzf42x4ND0kb1vgNjZQcD22AxqHsU?=
 =?us-ascii?Q?9/E4a7hIOpXQEHzku84NefhjiOWovJcniUOl4tp5r01Rol/qN6AYz3tZxsLm?=
 =?us-ascii?Q?5DLn3qmox5JKH8SFqYHaTXmsyDF9OudMplIZGzEoGKVH2gQeModYTDngsRqk?=
 =?us-ascii?Q?OnijaaTAccFbhc/QHqKkUvbXy+eNjfuurovzogOa4N/hFNLsi3ht7BiCE4VT?=
 =?us-ascii?Q?IChrTFo0z0Ub5Ojq2YJ4CXON65CU+patxNNo57HpmdI3rxFCQyMf/xJ3mQJA?=
 =?us-ascii?Q?/U4KH6pmlDQWMwp9WocM0/zzTxa76+rSqVjtifrInXZxsw8TlPY3zhg0xYiD?=
 =?us-ascii?Q?BdJQrrH/y66YKd1zkDJ6T8J29WDALV4wZWihHnwqCg9sAUTUFIyAhxxr+JN2?=
 =?us-ascii?Q?+Z/Blihh6k/RR5DQqhl1wqI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D0417AA7D4FBC248B08B5A92B759684A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f16491-58e4-4454-410d-08d9dd4a03b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2022 01:53:40.8161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6Lrqop1bN6wDj2E7vuOT1xqPG6jPYvc0nbi8XxopqNlbXdJTKGljd0eyAWIwEMzK48t98ChpmfhlakOEjJYYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4327
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201220006
X-Proofpoint-ORIG-GUID: 3Fv5Vq2OYFGlSoRv1LOafdOoYGak8fyd
X-Proofpoint-GUID: 3Fv5Vq2OYFGlSoRv1LOafdOoYGak8fyd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220118 06:57]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > do_brk_munmap() has already aligned the address and has a maple tree
> > state to be used.  Use the new do_mas_align_munmap() to avoid
> > unnecessary alignment and error checks.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mmap.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 14190306a483..79b8494d83c6 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2926,12 +2926,15 @@ static int do_brk_munmap(struct ma_state *mas, =
struct vm_area_struct *vma,
> >  	struct mm_struct *mm =3D vma->vm_mm;
> >  	struct vm_area_struct unmap;
> >  	unsigned long unmap_pages;
> > -	int ret =3D 1;
> > +	int ret;
> > =20
> >  	arch_unmap(mm, newbrk, oldbrk);
> > =20
> > -	if (likely(vma->vm_start >=3D newbrk)) { // remove entire mapping(s)
> > -		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
> > +	if (likely((vma->vm_end < oldbrk) ||
> > +		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) =
{
>=20
> Can you describe this change of conditions in the commit log as well?

Yes, that's fair as it's not easy to see.  The second part is to catch
an exact match of the vma - simple enough.  The first part however, was
changed to catch a tricky mprotect scenario that can land us into a VMA
which is located at a lower address than the end of the brk.  So we know
we have to at least munmap one entire VMA.  Checking the start of the
VMA against the newbrk may not catch this scenario.

And now that I've explained it, I think this change should be backported
to the earlier patch in the series:
mm/mmap: Change do_brk_flags() to expand existing VMA and add do_brk_munmap=
()

>=20
> > +		// remove entire mapping(s)
> > +		ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
> > +					  true);
> >  		goto munmap_full_vma;
> >  	}
> > =20
> =
