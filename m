Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9874C4716
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbiBYOIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiBYOIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:08:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A16514F98F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:08:14 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PDVYIu001258;
        Fri, 25 Feb 2022 14:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pEDQ9erI4m8hdQVs6+lds3sGh2BxpWtOCsldOcpGYoo=;
 b=VPnGs6oKOxrF4+kjq37Ea00Cc5zr84c86s7DQ61TCNCQ/y+mnL/sFgx0YxUqul4rc54W
 vifkZ1LeYTXUNdL7Rzt/uOu6/73smNivr9lfdVOgXMM+dEnSHB3tC5ogMDPb8p3zZaAS
 zAh/y2hmV0LC6apNW7vldrbsXQKr2l16uEgVqLdGoFd4JMu/RkR2gRNqiwR7w3y7gQ9P
 jSIlmoEvyl4gCzNhWsCx2T7SLa3RoRE4rjdZUSYpIeikigwRDLOV/c3OMKLdkjj+L2T/
 RyA5TI9jV6mEhPo0qnOrTkKqUDThAkcZZx016C3DYnE6ehYXLkIJ9+W1fiiUeIqhMylL xQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eexa8rxb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 14:07:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PE12P8039184;
        Fri, 25 Feb 2022 14:07:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3eapkmv6t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 14:07:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbYjLKMTZhwdQQkBBNcU2g3Z481/GcwVajXZ4bWR3bmmwSFSbIT1AUYlD0dcKxGRWGJyiGIhTPoaRG10PntF5K9fWxc5iDcCksix2mfyVlaYOT/C5TZt5VwojJVjAoke9APJ5iLa33u15qBa2i3iNKfewUe+6QYaMZuy0u4G7gUrcydrbgmB0l7c6+gFzL4ur5Tt5x46PFwHnbb1QdI2Y7Iv/1t/cu/kyaRu7LCBCmYpNo/Y2SVLNQ4uTMbJCXPXCslKZR1x5XX6yGdkWGSE7R4uDgNAlzCKks6A+JZGqPfYkVv0TVLA0OMZYRmjsuwB9jvZ+TDMYgHGk0ka3VRwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEDQ9erI4m8hdQVs6+lds3sGh2BxpWtOCsldOcpGYoo=;
 b=oZxL45uwsuhVmtiIiiYNkZpUX52HddyZV4ZqTt6eOBb5ssqWADzf+llvOCHmI8LjODYiIvG4R83/vSdA04McahvMVLSbUhU543I0Ts3GR/hNk9utqkTgnCp3orSQe+5rCwtEhODU0X6MH96xrKpM5Ac2/jIZdsSoH5RGXc6CuqbqaXqD4Vt7rCzJ5n1Wua1SdbN5zaU+/ljT6fts6r1IEgUAuJ3wl+wpXFVDSL6Hwn+RAAysy1Wb0+7YwtR50Z3JP9PXMpFMqd4e9L9dhR/k13yFg4tk/li439+TUv8TkrUDsGpBqMbq5uZ6YnzzmsUnsQddrYkt8U+VvmvEEh7bRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEDQ9erI4m8hdQVs6+lds3sGh2BxpWtOCsldOcpGYoo=;
 b=fs5vDwvqdJvCmC9ALBbXpJlI7VOmt18p+/mQC5rKpDp5HBgkjmYGkccNGJTYRsybctkE45plcIRJUle6dAq/wnYQmrpgdgYVxBf5CCFO/jKujiJMsgsmJwIEJu2e73HsWE9HglB9dpgZeLKy/R43cm0B3UVaeRhiedeNdx4rGmo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4640.namprd10.prod.outlook.com (2603:10b6:a03:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 14:07:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 14:07:15 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     =?iso-8859-2?Q?Jakub_Mat=ECna?= <matenajakub@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "riel@surriel.com" <riel@surriel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [RFC PATCH 4/4] [PATCH 4/4] mm: add tracing for VMA merges
Thread-Topic: [RFC PATCH 4/4] [PATCH 4/4] mm: add tracing for VMA merges
Thread-Index: AQHYJMIWwUhFsrN60kOTfTd4C42Vf6yZugmAgApkeACAADntAA==
Date:   Fri, 25 Feb 2022 14:07:14 +0000
Message-ID: <20220225140708.onog34i7xp2d7geh@revolver>
References: <20220218122019.130274-1-matenajakub@gmail.com>
 <20220218122019.130274-5-matenajakub@gmail.com>
 <20220218195729.oa5olrcsq6yox7hp@revolver>
 <d7f56188-5512-1365-243a-1e70acddf5c1@suse.cz>
In-Reply-To: <d7f56188-5512-1365-243a-1e70acddf5c1@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a16bee20-bd26-48e6-0e75-08d9f8682035
x-ms-traffictypediagnostic: SJ0PR10MB4640:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB4640C3CBB75DDE5A97772C1BFD3E9@SJ0PR10MB4640.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FsaYmYcoE8iSjEvOKDIjh96omhnXYRnf6Tm7QcnArHXRFQkqXcUSbTf7/wDsmYWa8S8zVXB71mGu1+3RXwhfTkJbZD1EfZbg6zmISK8MKcrV0mBQzEc4/4dnzc+x5Tavfg2pXiW9AGwfWkqnb/awg6WnrCi0V/1iXBZWNrH3OrcNOHTT/zPOuRXsZ5R/lnGZuSrM5afbVbmtOvXLHfFUyZCOARdeVCRtnktr98vKwForMuqI3fMzZvEGywWlrGpM0pLAHcDE/1ihdvmGthepavKsKumSdGsNZY0V8+UkzeyZwT/CTm99YFpsuRz5tfx04QhbKPmh8eduQ3SPM6vWq0knrHqW2JdJXUO/Fk4aFFnMmyyYV+/TyP9IANT4iccvMkriOuL/RfPPAiRc2IduztnEnLhsIOWDuyG4bVBnPTmrnwrtUYOSqI7ueEzfl2hYBbaJlb7ucbz+vqt1gQ2Ne766xEKrztH1CSO5RSrLAPmqwinqqK87Ztc0KLr3bv3OP9FDVjtpI/ey8jL7Hqp2cIGeO+9q+NwlPoBczwkGgkw+R2JjIQMlf1Wz67TFaKXnE90ZS0mo1yMZL1W6EXU74dObNUw6JhsyZMXXAQptgtckrRx3XKbDH0CRFTfc9KFoGG8TfkC3+yNvmvgkr0g3p8/lanFvvfUhWeVHifbwszBm9HPoMX4N3hznywukqUtjwm4QN4Mflwt9vr1iDV0mKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(53546011)(9686003)(71200400001)(1076003)(6506007)(6512007)(26005)(186003)(8676002)(4326008)(38100700002)(5660300002)(7416002)(44832011)(8936002)(122000001)(2906002)(33716001)(54906003)(6486002)(86362001)(508600001)(91956017)(64756008)(66446008)(66556008)(76116006)(66946007)(38070700005)(66476007)(316002)(6916009)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Tk9yTZXK7bA+531din1GEQzke3Xays3rqOqaE5UEC6SfQlD8yRlSM7phmN?=
 =?iso-8859-2?Q?rL/pPuW2/3Y64oWInMYeC+U55YN+Yy3rV4krEG18QD5UsgcQmGEpRxP4KL?=
 =?iso-8859-2?Q?PfNsgmSE8jW0LAzXarJI3wIAnJ1AoXu7DR1CKGBs/w1pbbPB7AdGev/b5n?=
 =?iso-8859-2?Q?Oi86NLc5h2VRKN2mMUzAsdnM0XQSxzjmyHJH1CNCH8LXR8TbwR3IrteXev?=
 =?iso-8859-2?Q?G92iYS5mJzLaNmQACLgoiWufCY96P3OLxBvtk41JMcPIIX7XKQF0OOzDVk?=
 =?iso-8859-2?Q?G9onTHalavxIgq6+JCNEqf7yMKUo77dyYV4hOos1Z9zuU6NWZwfBfhFiIc?=
 =?iso-8859-2?Q?Lq3DPhxUqPfXePnrvIsGwG0RDm/NOb2Af+cmsggZYXuBO+BMEjEeQgqx6H?=
 =?iso-8859-2?Q?uztQ8rjbNTGpIuG2tn5Xvdrf/Dn94ieRCN31ARaDcbGh4Xrp7pjuWXkUhY?=
 =?iso-8859-2?Q?8LCxlzbbO21W7zgjlwBl/b/Z0mzmL42vpYp6GzmYs0U+tdl/aEnRYamY0C?=
 =?iso-8859-2?Q?WB+v19blSg2MlZ0wYIlDansCcxRPV4m1psssGPx0MBPWXv1fwiqGxWUX/v?=
 =?iso-8859-2?Q?RITxDA9aPmjsQYYlz4hOf0q7QzwvEeEX/q6UgNwXjUv6cT3x5bi3UNN2Cl?=
 =?iso-8859-2?Q?3ogTDzn/D9MD2Tmg2VpdAZapGwMs8Mf7/3EFpOueIgIaeI4/3Y/zkJO8Qw?=
 =?iso-8859-2?Q?KBIil5D0vm6+41dCi0Kmh+V8xkjwTattWM0Fvmdqbhfolpc5LRAktV97sS?=
 =?iso-8859-2?Q?rrOMaRuORGZ2e+gbwNhZmEjGFsvmQtie2Y6u1EmkF5MbjJQYEYz2AQPFO/?=
 =?iso-8859-2?Q?gnr2ErjlcWqpjdaiEvOokErqRBnz02zS8aQIEcO8sONoCAlLqglrW+eE4B?=
 =?iso-8859-2?Q?h49GSXBzEuIc+QXQaed6960tVTdXowfOc+AqH7PRPoU6VOXMjVSUUwVZZJ?=
 =?iso-8859-2?Q?Wu/I/iZ7zpCtpt+SL2JQyQmH6PumDJqo2ShCN0HWAnVFZl0l2XVuFXVjFl?=
 =?iso-8859-2?Q?InXIsDFiwbpyyCM3D6wRvSJ8DrfeJRHWo7yDv3AH4SWZDYzB4+BSN1FCth?=
 =?iso-8859-2?Q?/gvo8CI+WgTZNWAeyu3tf8assnugKL4FAgfehOOaQr57dmLi+vSgRCVTi5?=
 =?iso-8859-2?Q?/mmya45YBYFlUdT7tjMCdljXwEmdD2PCzjeRfP/T3hAfVi6+hekD7f4Sru?=
 =?iso-8859-2?Q?epUYlPVWYQZsN8fYdRzk1iNS+CjBPBGcw2zYU0JiLpc6sFRqEwkQWoiPt3?=
 =?iso-8859-2?Q?rKX7HJAg2g6Bf3OMree1wQTO7hqRuRDbIhHPEk84LIqdaR5tUXcouWP/ak?=
 =?iso-8859-2?Q?WPVQvwFxyhxxVP0o1esUp6Y5GvgspX4pP4+CEuuK2Jt4G3HWAngh9gp3wD?=
 =?iso-8859-2?Q?NSLjFO/BODEUUPQDN1gynAhyELm4T5dB/XIWW6EV2d/1g+FZLxA6aVG8IX?=
 =?iso-8859-2?Q?caoSC33oBz0UDiJVU2Q/DPfI2ZSCjtFx0fs/Du+zRmzea+d6wXefSyUpAj?=
 =?iso-8859-2?Q?FArpt6oWOkKopG3phKe74IFFqQDQ3JMekf4vubTtonXYifQct06hCO22rz?=
 =?iso-8859-2?Q?HHGMTqD2CAD+gE9T57xempwBsKlH/cOpv3c5a/rJRE78uFxjbr0fkameRx?=
 =?iso-8859-2?Q?mV94sww5QTjMKhtv68tJaqoC/J5c8Srci7m+9yUI8X1a+JEGRCGXtZND2S?=
 =?iso-8859-2?Q?CZyJXsmeEaq4HF0GbhU=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <4696D9A8FA429C4B8C28F1F3F1C801CA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16bee20-bd26-48e6-0e75-08d9f8682035
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 14:07:14.9333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icWc0wlO4uaqtNxmXxsqxiwR6nCro5xtcQAdu476Au9p2Dq9gfG4t6ZiACgRr86bKnp37VlYK8Yp5UhZ8AQtnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4640
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=620 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250082
X-Proofpoint-GUID: R7t6jOj3xsZoOzvOVE4P-0pRFN7EuFkj
X-Proofpoint-ORIG-GUID: R7t6jOj3xsZoOzvOVE4P-0pRFN7EuFkj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220225 05:39]:
> On 2/18/22 20:57, Liam Howlett wrote:
> >>  	/*
> >>  	 * Can we merge both predecessor and successor?
> >>  	 */
> >> -	if (merge_prev && merge_next)
> >> +	if (merge_prev >=3D MERGE_OK && merge_next >=3D MERGE_OK) {
> >=20
> > What happened to making vma_merge easier to read?  What does > MERGE_OK
> > mean?  I guess this answers why booleans were not used, but I don't lik=
e
>=20
> It's similar to e.g. enum compact_priority where specific values are defi=
ned
> as well as more abstract aliases.
>=20
> > it.   Couldn't you just log the err/success and the value of
> > merge_prev/merge_next?  It's not like the code tries more than one way
> > of merging on failure..
>=20
> An initial version had the "log" (trace point really) at multiple places =
and
> it was uglier than collecting details in the variables and having a singl=
e
> tracepoint call site.

Wouldn't the success/failure, merge_prev, and merge_next be all we need
to know what happened?  This could be places near the end of the
function.  It doesn't say why merge_prev or merge_next was set to false
but I think that's enough for most uses?

>=20
> Note that the tracepoint is being provided as part of the series mainly t=
o
> allow evaluation of the series. If it's deemed too specific to be include=
d
> in mainline in the end, so be it.

Ah, in that case use bool until we arrive at this patch, then change
merge_* to int.

>=20
> >>  		merge_both =3D is_mergeable_anon_vma(prev->anon_vma, next->anon_vma=
, NULL);
> >> +	}
> >> =20
> >> -	if (merge_both) {	 /* cases 1, 6 */
> >> +	if (merge_both >=3D MERGE_OK) {	 /* cases 1, 6 */
> >>  		err =3D __vma_adjust(prev, prev->vm_start,
> >>  					next->vm_end, prev->vm_pgoff, NULL,
> >>  					prev);
> >>  		area =3D prev;
> >> -	} else if (merge_prev) {			/* cases 2, 5, 7 */
> >> +	} else if (merge_prev >=3D MERGE_OK) {			/* cases 2, 5, 7 */
> >>  		err =3D __vma_adjust(prev, prev->vm_start,
> >>  					end, prev->vm_pgoff, NULL, prev);
> >>  		area =3D prev;
> >> -	} else if (merge_next) {
> >> +	} else if (merge_next >=3D MERGE_OK) {
> >>  		if (prev && addr < prev->vm_end)	/* case 4 */
> >>  			err =3D __vma_adjust(prev, prev->vm_start,
> >>  					addr, prev->vm_pgoff, NULL, next);
> >> @@ -1252,7 +1255,7 @@ struct vm_area_struct *vma_merge(struct mm_struc=
t *mm,
> >>  	} else {
> >>  		err =3D -1;
> >>  	}
> >> -
> >> +	trace_vm_av_merge(err, merge_prev, merge_next, merge_both);
> >>  	/*
> >>  	 * Cannot merge with predecessor or successor or error in __vma_adju=
st?
> >>  	 */
> >> @@ -3359,6 +3362,8 @@ struct vm_area_struct *copy_vma(struct vm_area_s=
truct **vmap,
> >>  		/*
> >>  		 * Source vma may have been merged into new_vma
> >>  		 */
> >> +		trace_vm_pgoff_merge(vma, anon_pgoff_updated);
> >> +
> >>  		if (unlikely(vma_start >=3D new_vma->vm_start &&
> >>  			     vma_start < new_vma->vm_end)) {
> >>  			/*
> >> --=20
> >> 2.34.1
> >>=20
> =
