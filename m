Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B7F49EE68
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiA0XEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:04:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64880 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233578AbiA0XEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:04:02 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RLEwDK012326;
        Thu, 27 Jan 2022 23:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=k13wktUvw/cQvhqDwTLqcBQ3Ibovb5LQPQM8q01tfhc=;
 b=cL+HwGoM65K10Mdu+NO+UUejmmK7pSF1JxMTSolCCBzhtbE7IEngqbUtmM3DQeglFEwk
 uWvP9Mu/6r1ezZ5m0XE+3YrIkZt0DBtLsgu1f3/qtcsCp2QqVweYJzT1eDR9mSH33/Kn
 sdP8v12DZBFMKlZ5SsU+wd8tF4t+UkIZ4EmXUlizF6gmVckk+Xly/KwoJQtSfdzZ6T8o
 TVBuIwgt97dv9p3fAp78mamKxNKZtOnTf5OT7+Yik+0VJgNAdRfEBO/K158JJB+bdHjj
 7LvzbJFlSnNUkqW/QJK1uAdU9hy87uGfNfWbL6S0ApDZ7iO8JEa2vQMKllnmQkzU22ou Dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvnk9ndv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 23:03:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RN0cUK109983;
        Thu, 27 Jan 2022 23:03:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by userp3020.oracle.com with ESMTP id 3drbcugg63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 23:03:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVu2et7dGuJqvB1ZDAMSrliLbdkpUhFlbat0DgZM0jM5zjj+9HbYnT7ucSBktwM8/VZbKqjE3dmTNxtoEOVIWWLNtOzAM/n3tGQeX16To6lCU2x04ooCfqeVMOgYqoYWQHAM9ii72AoG/rG8L0e1Dyz8dTfX9HBRgounTnxHhaZjKnx9WN2jd8NquZcri61d11IMiZeveJeyD/NMrjQQabV+SHqHvqu37/kMwH6wXJ/kdrjYZEC4GTT6GgANRPYvh7X4WL+egeDQPRtUzWX7RzPmuKpkB8pDwowQNwtXa6w2qx28Jsj1A/LrMtNtb/XVyH9Q+2rWsdMVioC2GgNX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k13wktUvw/cQvhqDwTLqcBQ3Ibovb5LQPQM8q01tfhc=;
 b=Iv+afmZe7QCNAWYDzfcKAT/+YXsboI7xZBxu6Echi4xavBY8Hg9f2fP3QG1fHNnTTSofmIY49o4aGkTCXaKOwYvWV44c0JbKkEnT8nqp3XfjWuHnlN75GSiD3tQp2y7KDc8VgF9lJCH3IcL6TCShN00ZAp3pCk2B99iPUVUO22c/vmPH+x8HUkpaKp1C4+M0ZwGhi9eq1HRj8wdtUHQCogykh6IzKSCcShaehR3mPJhGFfgX2AFTniM2dqypwHmZBdnyqW2Nx6oQPOCqd9tFtqa8+XfkuNzPxQ7IzieBNgUIchIcrphfIKEXEyYLZTRK2gCtRntuLk520vS2aFDzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k13wktUvw/cQvhqDwTLqcBQ3Ibovb5LQPQM8q01tfhc=;
 b=Z2OsnPbOaSy6qSz2hcVnk7Lamx+aa7i8GRq3hVJ4+9mFGrsZEcamJxtnCSDrpA9Ghw9YtRYutgOravq4LGwHCmll5ofRSb/HzlL0m7qM8xf5DjoEo4aGfFCDfFzJCn6AeCZ5mdW4qaEU8UL28VVPNkz/3uPZG9swfoyVL4/Dzq8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB3349.namprd10.prod.outlook.com (2603:10b6:a03:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 23:03:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 23:03:29 +0000
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
Subject: Re: [PATCH v4 55/66] mm/mempolicy: Use maple tree iterators instead
 of vma linked list
Thread-Topic: [PATCH v4 55/66] mm/mempolicy: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHX5r/0Jk+tXlVP4UiIr9o8XNMVtqxsHKmAgAjUMICAAG4+gIACGRsAgAACVwCAAFwmgA==
Date:   Thu, 27 Jan 2022 23:03:29 +0000
Message-ID: <20220127230327.34w7qqs4dpx2nk44@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-56-Liam.Howlett@oracle.com>
 <10798a7d-e157-03c2-abf4-f005a3507cae@suse.cz>
 <20220126024819.i35wd6uxh463wkps@revolver>
 <3dc23bc9-2b0f-00af-f85b-22c270356e96@suse.cz>
 <20220127172516.dj7mditbishetlxv@revolver>
 <1bf686e4-6c22-47d9-d6e3-fd33faf59037@suse.cz>
In-Reply-To: <1bf686e4-6c22-47d9-d6e3-fd33faf59037@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f931f889-50c3-4651-1af9-08d9e1e93be0
x-ms-traffictypediagnostic: BYAPR10MB3349:EE_
x-microsoft-antispam-prvs: <BYAPR10MB3349839049662BE86553016AFD219@BYAPR10MB3349.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iHL6z9rkoewNXA1/+LgoqNJyicQxsE0hvQFhObM4pvc7LTepghK7B3cc6Htq7H352pt9BFtog3e0YXqdVaOkQorcDL/X8o1fqjq9DOAoTj2NJrJEt1EpD2ygcOYEpNKosHV6u1ttcPhy6zPtgeGoQMERLydcdgiK9HkubxJYRSaMfR3Eeouwxn1lvYayOKqeoqZ530dqcmGnCUp8Fbo8qucPVOXNe6p3JwajGqC+6h0arttLUJTe3DqS9jNhhgD8DLVTzaUn2VPzmkdI1q2SGV07r8jaK0Ezh0PbhRGidIE8LmRGDqLD05Lew62XVlwF5uut4J5y1RfGBho0M/zWBrKrm8WG0MlvzHuO4/rVJmKxNKYZwAjObrMtUwxteMBWdU4L77zYiCiUf4DELVeuF6HtPzFMzcMeCOdBbzwwvGr0XI8SImIrpjtXmpp840hDsuUj8V5epBvkBb0o2z6y9Jnk7zNx2/DuvX4kIne09v9Z7AmP5vngj+5p/b7Q6wcg9Fq/Ul2PM4LU0QSoUJPZg7+dgdyxs5b94sOYHrBcsBsBokiv3JSLm5YYy+b01Xac25xYv/Go7IWWNkuXsZUi4Stw6SegA1qZQyc6DmdbWNNlSvQ/8WyEp/4nvPU5bvAz0Jy7vkTOzQSy2vsIj3ki37yIvBjaXsGLR6IPUg0ulWGmF5tTutwmQBvpvzXM7ZsHrvt2Y9Zf3KcK1FaNu3IRNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(6916009)(54906003)(508600001)(186003)(6512007)(26005)(44832011)(6486002)(5660300002)(7416002)(66556008)(86362001)(38070700005)(91956017)(8676002)(66946007)(76116006)(1076003)(4326008)(83380400001)(316002)(64756008)(66476007)(66446008)(8936002)(38100700002)(71200400001)(6506007)(122000001)(33716001)(53546011)(9686003)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wbDKfyJx2U0G7GCPW7g1AlDD3KX70nP03aurXNTHq8CJNkNDUNxk3yjERVYG?=
 =?us-ascii?Q?3SUYfkMxPUW21Kyx3ejs3pcc/8zbFLztggIc3sd44dkzM0MIyI4Jq0eJe9Iu?=
 =?us-ascii?Q?aYlYF0GmuCjhqdosFtSdV7/EVuzK+bn2RNoJWKQ++/2Qj76jU1u/EF2pCHgx?=
 =?us-ascii?Q?KDY/YYgNMwYxOrUZcZp3DInVR89dkK6LdrD/2oiUUH8C+4nYFRvAjQlfi6cm?=
 =?us-ascii?Q?8Wwn6laAS6zuAQyDl3IJkz/lKcWI06JcPsfKjlqT+QSeOCHD+ri5ZRTEKrxS?=
 =?us-ascii?Q?Ki0akcaYjQgQjmodC0INRkZqqcQDdNnyO+dlJxG/AThwhs4JhbPFJHj26LCy?=
 =?us-ascii?Q?FJa4sa3PmeYnbC0IIVaWFUNkL5av0Tu5ED+vMt0jJf+TCbf0yENAd7PBuKz+?=
 =?us-ascii?Q?tt3rqb5TLbYyjbFd/8q+21TS0awILNgVKbQtU5dGbNJA+cssPMIsM6xuwyZy?=
 =?us-ascii?Q?hvIdwHfY5C/D9lEFlLsKtfBJxpt6Lv0D3DEeb1YV9fZ0yckv43Ota75nBYZS?=
 =?us-ascii?Q?wO7JQMzdkY9U1nJiejqwi3N1ElHo4YFEb/GTgh2qg6JDNmcr2yWgWAbqzNVt?=
 =?us-ascii?Q?l/qcr3So/fhOc/B0KnWrJmmj8BNwqIeszCgnENaZmDZ6sKPZ0bsTjJkWRank?=
 =?us-ascii?Q?tGW55dx97MgtSQNaDkp3/UAL4s/xbISaa/tg55SCFzGFTM5x7wtAbv7TlM7K?=
 =?us-ascii?Q?i/ROus+in4fJyGFjuqeVhIPkPRN/ohY2BcdaEtYSUnbS8jJJylYcoCULnUJX?=
 =?us-ascii?Q?C93bZdFDqXeQ5PMAlOywwvNieh+L4EHhcd+TbCkmHCHt7Skq9EHedyuZUPVw?=
 =?us-ascii?Q?Fdgz6ex0wWuHmlilxULnYPHrcWfqHD9WXu+PnUuZu7RqxU/M7Ioxt9nPNE5e?=
 =?us-ascii?Q?JrHSeG0jLTL4L1rZFIp196XX7WjGwl8pku01pzWIHE+pOteWHZ9Lt8tD3bFJ?=
 =?us-ascii?Q?YUa5lD9hEGPs5IPvsgxTu38HiKEc1Bz9jSG2vlPRHNUiH7j0if1Nw13zYJu3?=
 =?us-ascii?Q?6RoiFbL3SGvwyPjNUqds93x2gKY//ORPdsQfdCRP5yg4pyygFaYA4tLkXH/4?=
 =?us-ascii?Q?ovVoRP10pzagFfrthBOrLGuvD/iMDsCADXm4mVkkxiEnh5SMHakS3TUlqrSr?=
 =?us-ascii?Q?DbsA6BFFtbu2wXAekPB0kDND/blJvtE/2p03PEWfD9VwU9XnYvAmF5kS84uY?=
 =?us-ascii?Q?/I2p0Dq4VYqgVKSMcOgjimU6qje/z9yus5tlTql13dCE0J3NHRw45kROMuHq?=
 =?us-ascii?Q?LAsREHFc+ELeDWW8Xa//ERXFfuFxXRJ3VfF8fD7RGfPue2a/p+oZHku1jT85?=
 =?us-ascii?Q?zUtz8ihIp17OOz04QyHGas12qqNJ1plnV4SDiMahof5szOF8xEYkYp/NaqwS?=
 =?us-ascii?Q?4S+xkHJRYYcblG3In+nWKDHmAHdhmurluKdG7l6ppFN8SZoq69wIgLtqvmK5?=
 =?us-ascii?Q?8MsOnJnT39sYyVaq5hjxYKha4nVawz/y+3JxOmFWX8Wwdszk24wsw7pu9a2L?=
 =?us-ascii?Q?HIMjsP5d8Jh9d3IraOXbY5kKdEk3OnY/3y3c6IAsH+P60PujiZQrh83gRatN?=
 =?us-ascii?Q?ACkt8Tm/hYeW9qf5Vbtinqj0xuWVAFAAWbWtvwmTcYeacaY94Q9noLHq7qZV?=
 =?us-ascii?Q?LyJ/UjUkaP2yEOFrznXzE94=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3F99A516CCBF047974430155BC60533@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f931f889-50c3-4651-1af9-08d9e1e93be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 23:03:29.6714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8sIjhjKSYBGdI2mbpCamDayczcVr8Gqya+2vB75gWebEkSjFwU3yaQHJ5rj3gG3wYVVDdz0PUx7PMK8o1Rhbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3349
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270129
X-Proofpoint-GUID: ZvjRVAxDPy0kQqSw09BJM_e5VouHUZ8u
X-Proofpoint-ORIG-GUID: ZvjRVAxDPy0kQqSw09BJM_e5VouHUZ8u
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220127 12:33]:
> On 1/27/22 18:25, Liam Howlett wrote:
> > * Vlastimil Babka <vbabka@suse.cz> [220126 04:23]:
> >> On 1/26/22 03:48, Liam Howlett wrote:
> >> > * Vlastimil Babka <vbabka@suse.cz> [220120 06:58]:
> >> >> On 12/1/21 15:30, Liam Howlett wrote:
> >> >> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >> >> >=20
> >> >> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >> >> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> >> >> > ---
> >> >> >  mm/mempolicy.c | 53 ++++++++++++++++++++++++++------------------=
------
> >> >> >  1 file changed, 28 insertions(+), 25 deletions(-)
> >> >> >=20
> >> >> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> >> >> > index 10e9c87260ed..0e2d918f4f30 100644
> >> >> > --- a/mm/mempolicy.c
> >> >> > +++ b/mm/mempolicy.c
> >> >> > @@ -377,9 +377,10 @@ void mpol_rebind_task(struct task_struct *ts=
k, const nodemask_t *new)
> >> >> >  void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
> >> >> >  {
> >> >> >  	struct vm_area_struct *vma;
> >> >> > +	MA_STATE(mas, &mm->mm_mt, 0, 0);
> >> >>=20
> >> >> VMA_ITERATOR?
> >> >=20
> >> > Yes, I will make this change.  Thanks.
> >> >=20
> >> >>=20
> >> >> > =20
> >> >> >  	mmap_write_lock(mm);
> >> >> > -	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
> >> >> > +	mas_for_each(&mas, vma, ULONG_MAX)
> >> >> >  		mpol_rebind_policy(vma->vm_policy, new);
> >> >> >  	mmap_write_unlock(mm);
> >> >> >  }
> >> >> > @@ -652,7 +653,7 @@ static unsigned long change_prot_numa(struct =
vm_area_struct *vma,
> >> >> >  static int queue_pages_test_walk(unsigned long start, unsigned l=
ong end,
> >> >> >  				struct mm_walk *walk)
> >> >> >  {
> >> >> > -	struct vm_area_struct *vma =3D walk->vma;
> >> >> > +	struct vm_area_struct *next, *vma =3D walk->vma;
> >> >> >  	struct queue_pages *qp =3D walk->private;
> >> >> >  	unsigned long endvma =3D vma->vm_end;
> >> >> >  	unsigned long flags =3D qp->flags;
> >> >> > @@ -667,9 +668,10 @@ static int queue_pages_test_walk(unsigned lo=
ng start, unsigned long end,
> >> >> >  			/* hole at head side of range */
> >> >> >  			return -EFAULT;
> >> >> >  	}
> >> >> > +	next =3D find_vma(vma->vm_mm, vma->vm_end);
> >> >> >  	if (!(flags & MPOL_MF_DISCONTIG_OK) &&
> >> >> >  		((vma->vm_end < qp->end) &&
> >> >> > -		(!vma->vm_next || vma->vm_end < vma->vm_next->vm_start)))
> >> >> > +		(!next || vma->vm_end < next->vm_start)))
> >> >> >  		/* hole at middle or tail of range */
> >> >> >  		return -EFAULT;
> >> >> > =20
> >> >> > @@ -783,28 +785,24 @@ static int vma_replace_policy(struct vm_are=
a_struct *vma,
> >> >> >  static int mbind_range(struct mm_struct *mm, unsigned long start=
,
> >> >> >  		       unsigned long end, struct mempolicy *new_pol)
> >> >> >  {
> >> >> > -	struct vm_area_struct *next;
> >> >> > +	MA_STATE(mas, &mm->mm_mt, start - 1, start - 1);
> >> >> >  	struct vm_area_struct *prev;
> >> >> >  	struct vm_area_struct *vma;
> >> >> >  	int err =3D 0;
> >> >> >  	pgoff_t pgoff;
> >> >> > -	unsigned long vmstart;
> >> >> > -	unsigned long vmend;
> >> >> > -
> >> >> > -	vma =3D find_vma(mm, start);
> >> >> > -	VM_BUG_ON(!vma);
> >> >> > =20
> >> >> > -	prev =3D vma->vm_prev;
> >> >> > -	if (start > vma->vm_start)
> >> >> > -		prev =3D vma;
> >> >> > +	prev =3D mas_find_rev(&mas, 0);
> >> >> > +	if (prev && (start < prev->vm_end))
> >> >> > +		vma =3D prev;
> >> >> > +	else
> >> >> > +		vma =3D mas_next(&mas, end - 1);
> >> >> > =20
> >> >> > -	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D next) =
{
> >> >> > -		next =3D vma->vm_next;
> >> >> > -		vmstart =3D max(start, vma->vm_start);
> >> >> > -		vmend   =3D min(end, vma->vm_end);
> >> >> > +	do {
> >> >> > +		unsigned long vmstart =3D max(start, vma->vm_start);
> >> >> > +		unsigned long vmend =3D min(end, vma->vm_end);
> >> >>=20
> >> >> What if vma is null? Shouldn't this rather be a "for (; vma; vma =
=3D
> >> >> mas_next(...)"
> >> >=20
> >> > We have already found the vma above.
> >>=20
> >> AFAICS if the range intersects no vmas, we might have found a 'prev', =
but
> >> 'vma' might be NULL after the "vma =3D mas_next(&mas, end - 1);"?
> >=20
> > Yes, I agree.  I was going to restore VM_BUG_ON(!vma) after mas_next(),
> > but that's not the same as the existing code.  The VM_BUG_ON(!vma)
> > only catches if we search for 'start' above any VMA.  It seems
> > mbind_range() would have returned without error if there were no VMAs
> > within the range but would error if the 'start' was sufficiently large.
>=20
> Ah I missed there was a VM_BUG_ON(!vma) previously and that the callers s=
eem
> to only call mbind_range() if there's an actual vma in the range, so I gu=
ess
> my suggestion was misguided.

But that VM_BUG_ON(!vma) doesn't check that there's an actual vma in the
range.  Right now, if there's no vma in the range but there's one higher
then it returns success.

>=20
> > I think it is better to write it as you suggested to restore the
> > functionality of not failing on an empty list.  I don't see a decent
> > way of checking if we searched for an address above any VMA to restore
> > the VM_BUG_ON() which existed - although I see little value in it to
> > begin with.  I will mention this in the commit message.
> =
