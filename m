Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5018F47089B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbhLJS2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:28:17 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38030 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232663AbhLJS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:28:16 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAGHYqb001906;
        Fri, 10 Dec 2021 18:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kTJtoRfTNop5K7zbU+y9iBaF8FCjxwzjV/vsqro0qsE=;
 b=kxz6e3TX0X8nKJMqzzC6xno6sVsylKWCGA2IHIKjCVblRWUBxX2NPAKR6Bhj8ak5zH21
 n4KyAt4dCtsNxc9E9P8Euu8k+a5KKRk+0gcVr5ePXvWJREaVXDIjMpgFQ9funtKzq29S
 aUpIfv9DNgJhU8vLPK6wglMmT/VmE2FHvRw0wm7E5pUkTQEeL0Y1LwymadGou+pG8ymM
 LHY/LsSg7YAaGKCivtvWONLTXIAMWLcXiQwh0ztzgd4vKFPMArMm+qbAyuQoSaWEqBMF
 yMYYX4IafyawF0ycfIeqUw1eie8/OxTUk43d4My/2Ihr9/dtOG+d8tYCnnWwCpB+s995 gQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cva9nga00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 18:24:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BAIGGP0180709;
        Fri, 10 Dec 2021 18:24:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3020.oracle.com with ESMTP id 3cr059mr6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 18:24:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UalQZYhw8iagcoju+Vbxvu7xQ4NMsyjcXvdBQMBzSATI55br8Y6UM7qGKXK8Vqm4vrRaaDZbPixoLn2hOM8+uKqGN9nVERUlsA9AF91CfH6T2FVpqvSNefb94KeeYNwXKIzxzEXOfX/yuzmJMaqCP4ldkbeZDNwQhaN7HESpzvHxzXRMoNQ3mkAoWyuANi7KN4B6umxQZZjq1k+h6Xp9kpgeBNRY7LT43yRbBessll+Ezo6YsNTeFQAo27ClvthXIyNUHReLUv8K7cDd0MSq75DpDz2UphPeT+HPTTpxpAH9I2kK+SzDU8QUrRuNXXFvzngwYvq5X8lqZiz/iZf/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTJtoRfTNop5K7zbU+y9iBaF8FCjxwzjV/vsqro0qsE=;
 b=Kh6OCcCTP2jmzMUwUK0B+MD6wLsMwokjuFQvbJrKuzCirFkuyDXKnNawJwd5l5MexPXiu+vhTiK8eA4DHt5i0m5tkUBWtXmZZeRbCpS2caN4WErdxfTFBCk0cqLOQ1l1xf0VmRlKzP/9BUboom44Gegvy4hYzKY0lwDSfZQiYPLZ4XAhTr28/P7fboOKsEurH8D22IMef/m9VJkl8803iZuImPPgOL5mDqKBFbbJak8RJw91dsRxHBnDN7P+B1N1nVTNKr8gd6Ek7Sctm3ImBfhpJxHg+eFnCBOJvN8hQs1MIdI6YGL9Lthztxxx+CgY9atHtHAbhlci9SOCwr3AIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTJtoRfTNop5K7zbU+y9iBaF8FCjxwzjV/vsqro0qsE=;
 b=voeLXhehibRU0BqLx+vSBD7eN2N+3+uhMyjnt9NItwE9fVlw7YvFheYYnVJBVpNX0+CQU0qPBhetwI83nSfP4tj4uCwnF4UUzW6GwwIWsnQw7TLMrMb7yeTAOiy1K6IwmfYXvr1XEwgTkU6Ws2B5j3uK1mqVrraP5wI58QqhWfI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2573.namprd10.prod.outlook.com (2603:10b6:805:48::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.24; Fri, 10 Dec
 2021 18:24:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%4]) with mapi id 15.20.4755.026; Fri, 10 Dec 2021
 18:24:11 +0000
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
Subject: Re: [PATCH v4 07/66] mm: Add VMA iterator
Thread-Topic: [PATCH v4 07/66] mm: Add VMA iterator
Thread-Index: AQHX5r/m765iFHbPa0ejviOTbVUOwKwqVMuAgACxxYCAANuIgIAANqaA
Date:   Fri, 10 Dec 2021 18:24:10 +0000
Message-ID: <20211210182103.h6tkphmejksu2dll@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-8-Liam.Howlett@oracle.com>
 <f68de664-434b-d8f4-44a2-cbb0090abb87@suse.cz>
 <20211210020243.jciodseey2ckf2sk@revolver>
 <1d0b51de-59d0-c3f1-3136-4dabc2a873d1@suse.cz>
In-Reply-To: <1d0b51de-59d0-c3f1-3136-4dabc2a873d1@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5aa3525-03b9-405a-a77a-08d9bc0a431b
x-ms-traffictypediagnostic: SN6PR10MB2573:EE_
x-microsoft-antispam-prvs: <SN6PR10MB25731CDED3FE3F9DCA7F7C49FD719@SN6PR10MB2573.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IKkpHR+y1ngUuygrJuMNA9ZWvMaZ7+0RxK7vD7APRZJZbD/fNk5YbXFO6knMbQYpFuGJTPBPZUJEJ7d6zqVM/73BTUozw0nGcoGOcC4h5K4zAccaOBZ17EUvFl99VPYQVvhaxgYOCamaGhU38QJlYJ6qTvLaWdyMISYhvoEw+cR2pOJC+S0SXcvQva+e9Py/ZkwYFcg8dsWwSGWSfR8ZVZ+G81X14vfIZK1e5Er+8Xfqc+qynyjbp4AHkpax0OH6UmYbDwSqx8OtYCqJsw9HTFehv5QelkE3xq0QAr9xt5IyX3VxHTZ74p8eHOCBHh2363jcvZqda2rMlyTWy2chX1SDdI/q/YtnYnKnumznbPlMVhZSsJqf9smkBoO0b7eLfZ66L3lfn7iM5m0IrtdXvJOteNG75wlLkC9Ya8rYXKuOS9XlQxHCjDcPPWA87TY9zdgxvyBYYHoFKxFAy81HSQWcbuRDIF32VfsDOWBF/cWWe1VTJxNnQ0E0v2bMZGdj7pyeHIWZQXBVjlDPTKBqes9grgWdHWVgOEsK5eVBLLcpBAkJLeRqmdlIV4U4DQ9JswYj/RLvFCk0YxH+c7Zl04T9QNvwYSwAvetiS8vHpOnfyR8eJcZ3P0XkAjtJrMpeST3JQ61fzmFqgWlqbtLU8wdGGrgGqFnKtsqMq8NbOHgluGNRAy8rAOXuSnCUezqZpy5/PTOpw8TwzsFCVmYqkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(71200400001)(83380400001)(1076003)(66446008)(53546011)(508600001)(2906002)(6486002)(8936002)(6506007)(76116006)(38100700002)(122000001)(5660300002)(44832011)(86362001)(316002)(64756008)(186003)(4326008)(33716001)(66476007)(26005)(66556008)(7416002)(54906003)(6916009)(38070700005)(91956017)(9686003)(6512007)(8676002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xYK37/v7r+ox25BajjZMOfU3YPYqlQAlhKr/8UfWifMTJsRXdJ/GXxVGfav4?=
 =?us-ascii?Q?S2RbwCVHH0v5AsCjGNLczqonQzaUDac56SCMVmj033eNoSGhpuLz65ZXMdxp?=
 =?us-ascii?Q?vqyjKL0L5w5UENH533BYHKU2/JAJdara0S4No56vszWuynaFi7/0XaeoTHlx?=
 =?us-ascii?Q?hWneugwuQkpguBBBmi9haibVJBI/Y+re+gb/R/qYf2cszsl+N25tnffodsum?=
 =?us-ascii?Q?qv/QWUemsD6vy+GmA7358QQ7qZP4QLHaS0ZskoePiyq7y3T1e3QOuCxO31+i?=
 =?us-ascii?Q?FO2UuQfNsZQNAurVvNh5SHvCndT6qe2t14vxMTCwOB69mWbltH77PqPKle7B?=
 =?us-ascii?Q?FX63viSPc5rPb3pdaLN5jypRbIoeD41zW4hwrOHWXk5S+BiD0VIuOUokp8Lx?=
 =?us-ascii?Q?sC6NPnDgLqyDFbARv++g3yByUI7aelGl62kCdvW5yaI61o8Xz3cEq73unSqz?=
 =?us-ascii?Q?tnnhyiAPFA2D/JoVn1n55AjO7K4uQXejZGRnaifio8XHdX6D2iC5y/irxAC5?=
 =?us-ascii?Q?fpHDQSBya5CLqkq1g8c8liczrPv+IQedTuft2wzzmborEx956/1/XtZI6i2z?=
 =?us-ascii?Q?ZJqB/5Lm4YI70guVFdxPt2Oie3MxT/p9yILAZlpGn/HjULZMyBueDY9cjy2i?=
 =?us-ascii?Q?/TI8kFwjKf4tstfK7WknKQPXct1dvLhcwCpJ+Xr2kvlH4pvL9GB9K/2FXpWY?=
 =?us-ascii?Q?p31qmu/qtSYViEHZ0+vV0aGDmq3P6Qv9YRguIGhGnAJ3/QqJYKbgCagu1Ibr?=
 =?us-ascii?Q?OoxoqFsyMg66iA9HMBMBJRMJbwOMHFenp/rWNaG2PzOBocEYiwWW8qMJlCV8?=
 =?us-ascii?Q?d7xCCg7akX+uhfol2zl8So/123epYwOShWM/TM2R/+FLN6sII/TpFUzKiYQf?=
 =?us-ascii?Q?nWntAr2eQK519mggLr90wU8x6jj1Lr91zSN4BblTO3X3k1Af1GwiG1zT1R8P?=
 =?us-ascii?Q?55hddvSwQ17noYnZX8l5g7mB+AS9y/rlKuzbt6fEc3lK399IfbQAb1U/qlkT?=
 =?us-ascii?Q?sslPOexIc2vzGdopAkUcrgTa+7Zfwv3yOyEzvFAa3rnifCAbC2tO+VN1qn+Z?=
 =?us-ascii?Q?hWbiM2pDE16hNf2dCzPnVlk1Xr6Bf+51homRsq3aUwXfFHZFZatJaFrsIqV0?=
 =?us-ascii?Q?CpHRfqp9NDuKdEVxfAdLnZyvjlxXOIlN0kR+wDbyz0x3ddBwboWCaHbBXLwx?=
 =?us-ascii?Q?CJvPr3IIVZoplTwGMxgaw4YeDk3AzzvrM88AHBOWyRtn8RX4rWmCl5WXXXgg?=
 =?us-ascii?Q?RY0ZIDUjpOKbBJ2u4jt9ktLG5OpFe9Qc4HmrH7TXCgr2P3nnQD6D95tBbeLo?=
 =?us-ascii?Q?PPq6vPbzHpPhGD32QKgHc9TjFpoTCazthGIlj+LOdDCmJjvEdTpMhzhhZhEd?=
 =?us-ascii?Q?Q3ZstmINO8DDARi+XXlMwtt8JT7F/Lw7ssn7R2rJKkBo4wQ5CiFDZkR1UCc5?=
 =?us-ascii?Q?n0RC+dW4noCJUWXjRo0I+fZ/jR5hTl4cAxd/WNc5HIuH93/eQrosoJs+LhRA?=
 =?us-ascii?Q?9a5tvIQUSns7px2Ix2cYkHpAkURAyOqnQmEoxtMvrzr4/F2sWNYFuVC1jPHO?=
 =?us-ascii?Q?Byn4xN2xRctD/Unhj3uXiBxxEAPQHONm0rKfp+llfHWRkU1iECg2dguhQXCB?=
 =?us-ascii?Q?dblhFTieEyBUX0ffLWeg8pc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2273613F33B6F54BA917E425763E3399@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5aa3525-03b9-405a-a77a-08d9bc0a431b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 18:24:10.9966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CIUfOzQPSOG7onMbakjjZcHz9XtfTqZo1FeDsKBk8aQhTCo8Q6FSuo0JjEdSARsB9nQCPbuOEBx3Cbu///lFSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2573
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10194 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100103
X-Proofpoint-GUID: wsc9WVeSec17Bv3JdqAfKl6TPsx_t1Zv
X-Proofpoint-ORIG-GUID: wsc9WVeSec17Bv3JdqAfKl6TPsx_t1Zv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [211210 10:08]:
> On 12/10/21 03:02, Liam Howlett wrote:
> >=20
> > vma_find() uses mas_find() which was created to implement find_vma().
> > As a replacement, the search looks for an entry at the address and if
> > nothing exists, it will continue the search upwards.  The result is tha=
t
> > the first entry can be found at the address passed.  Every subsequent
> > call to vma_find() would search from the end of the previous range - as
> > saved in the maple state, or the vma iterator in this case.
> >=20
> > mas_next(), however is more of a traditional linked list operation that
> > finds the next entry _after_ the one containing the index in the maple
> > state.  The only difference is on the start when the maple state is not
> > currently pointing at an entry at all (the node is set to MAS_START).
> >=20
> > mas_find() can be thought of as:
> >=20
> > entry =3D mas_walk();
> > if (!entry)
> > 	entry =3D mas_next_entry();
> >=20
> > return entry;
> >=20
> >=20
> > mas_next can be though to as:
> >=20
> > if (mas_is_start())
> > 	mas_walk();
> >=20
> > return mas_next_entry();
> >=20
> >=20
> > Matthew uses mas_find() for his implementation of the vma iterator so
> > that the first entry is not skipped.
>=20
> Yeah, but if vma_next() is going to replace the cases where we already ha=
ve
> a vma and use vma->vm_next to get the next one, then mas_next() would be =
a
> better fit?
>=20
> Do I understand correctly that e.g. after a mas_pause(), vma_next() done =
via
> max_next() might return the same vma again, while vma_prev() will not, an=
d
> vma_next() implemented by mas_next() also wouldn't? Isn't that unexpected
> semantics?
>=20

No, mas_pause() will set the mas->node to MAS_PAUSE, which causes
mas_find() to start searching for mas->last + 1 and up so a duplicate
should not occur.

...Unless the VMA you found was expanded while paused but this, I think,
only happens on stack expansion.  During stack expansion the VMA can
grow with holding the mmap_lock in read mode, so if something is
iterating over the VMAs and pauses on the stack VMA then the stack grows
and the iterator resumes, it could return the stack vma twice if
expanding upwards... Is this actually a potential issue or did I miss
something?

> >>=20
> >> > +}
> >> > +
> >> > +static inline struct vm_area_struct *vma_prev(struct vma_iterator *=
vmi)
> >> > +{
> >> > +	return mas_prev(&vmi->mas, 0);
> >> > +}
> >> > +
> >> > +static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
> >> > +{
> >> > +	return vmi->mas.index;
> >> > +}
> >> > +
> >> > +#define for_each_vma(vmi, vma)		while ((vma =3D vma_next(&vmi)) !=
=3D NULL)
> >> > +
> =
