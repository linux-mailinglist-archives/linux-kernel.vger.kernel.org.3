Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC974A6227
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbiBARR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:17:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15814 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240704AbiBARRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:17:55 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211HEfVk015897;
        Tue, 1 Feb 2022 17:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=trSee8Re01/amF9Ye1e78WLqbGd2Xqr0HF/6wqgXiDo=;
 b=quDb+mdDLNDDApCoFvRKp8MYoG/VShVHMTelDlGjnxK9CNJs5eCueyQuoZgah557ewMt
 syzdZiqq0432RjlE2EDQ15CiO6Xqq9iinSJGZR9idlyTXiVbR3LDTdC/TXSXNFkIo/+7
 HldwvQL3/Nh1uX9vX/EKDuFle4I+Rk1Pd3EzxaJBEovw7+Mg+tGB0jVoE1oA8JtK5C0C
 0m9+XuBFWQToZ83BCqUqxPmoXbiZZDTWjSMLNb5Y8lnIBND0p0uMwBuGHMz2Ghpug3yO
 wFqCaUh0oWQrlvw4qNUTrKUxDpItoh4JC8bFn+o4HOoaaBSSj6Tr8mFi6nwLPDFqzWVA Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac3k1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 17:17:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 211HFatw015775;
        Tue, 1 Feb 2022 17:16:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3020.oracle.com with ESMTP id 3dvy1qcgxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 17:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0JZCOa7HR5O3DDuEQfiW7uK6+T7EdCPHVMiCajfVUUEH7WuKWuoZ6riromJ4Lnjyb67lZrpOZRfkHHKV8+MDqiYe3XMYFu1+okFOcGRvbzmrhxYKpcjPKvw1vSdFduoWvwObPp4auCjtH8dBBCT5E+VOuljjr4isaeSrRFPv1eQCDTztI0SAuBabEUrkS2O33EMmVkIgPl0srB6exhZTUC8ThXWKss0TwsZ4ENFuVNHDRSkmFowpIo+AgJRep9evw5PaIn+j3ZbKPdrN8TZbwaXWI8P5QA20qdYv+MFDoz0vvx/lfkSfvc2DKBzdWtmm6GT1m8VzYbDdlkAslTfpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trSee8Re01/amF9Ye1e78WLqbGd2Xqr0HF/6wqgXiDo=;
 b=m/cSRK2LsK0qZocm9bYDV8rdcVGwAZdKLUm1++y7Ve8H2Gk4RANKQzJfgdRrOMIHZ2TaiaFSSnlk2qLTypKdEX010RkWy6698o6rr6t5B3n26EgAYQm29eWhj839mFcq36tKUHNsDssW4vdLnBAmcOaJoIvF8lyf2NT9iudLkSDsRKEGxrHDrwpK9TGA3XTLZF7mNj4BEo51iNbJTtCHdnUdCiPj1B0Ccs1hYytfi0ObgJk7gbNHi+UQFg91zabqmv/n4qMghvxqLYj/7DAvTpSvOCCHsDdkozzZ2a1FemsRh1rcQMubwk/YZKreeQCCvkv1W4+uCPkPXdpLxf8d3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trSee8Re01/amF9Ye1e78WLqbGd2Xqr0HF/6wqgXiDo=;
 b=ONqXiav8n0SSlmp7LXvPIzZceEuiaA10p12swLFX7VzVsI3uGFsKiyomSjzv0wobKf2aj86b3gHA0gJsaEvyz+mUc6tG6un78CYwNcdCx1+2B17vd/Ice6+7k1wxGkoYaGuJPz4bLEBjcVO5cb1vG0/k1P72Oor56uFgaR4lNS0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5194.namprd10.prod.outlook.com (2603:10b6:610:d9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 17:16:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 17:16:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Michel Lespinasse <michel@lespinasse.org>
CC:     Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 13/35] x86/mm: attempt speculative mm faults first
Thread-Topic: [PATCH v2 13/35] x86/mm: attempt speculative mm faults first
Thread-Index: AQHYFEhl4v7PtaX0EUi6FfnWr7s+M6x+9mSA
Date:   Tue, 1 Feb 2022 17:16:43 +0000
Message-ID: <20220201171617.z5zgafitgolyv5np@revolver>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220128131006.67712-14-michel@lespinasse.org>
In-Reply-To: <20220128131006.67712-14-michel@lespinasse.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5377fe9-7cfd-461c-09a8-08d9e5a69e7b
x-ms-traffictypediagnostic: CH0PR10MB5194:EE_
x-microsoft-antispam-prvs: <CH0PR10MB519468B5126B724E2893A8B9FD269@CH0PR10MB5194.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jfZh3P7DmiKVz0/cR877Yr4OLNJQvUuL0cUkzm0zvuHK7JfAx7cz1sGqdM412AGgiHSfPcNtvhmbJzsb16leotFMUMuispiT5ow6c0WeNDip7PpWnZQ09FgZ2AEjugUGd9FHKWNiJMtFKIM3t2g5lBi/Zz9yJR/lD/I3slOZOh9Vq1LHa+foWje5u+4KoNsx9XUspGK48ZESYzXL050clgfpm3bIfmEfUK7o2XVIB0RcPX035LBPXYS0rTdbOLf9DxmsuG2Lxuv3HItSXGh4vwe9UDhFoVocj2mW7LZZTPLgjD281l7SQfHmftXZ6+oBD4BxKFUDLHLZ5Mt6BcHbblVJ/eGmXcDB45kbRYanIBANXn0RIVNDdjC60D7hLAB627ROxdqVXz9p/NddFZAzqzbwlgeUQjA5Hf1uQ62ozGszvzotHl+UFjEp+GbRWMBUHBMZtYYf6jisaG/zeVg5wixuYwPfB37QHQhZq20kv4AvVrSYp/kUhTITZ3NbAUQqD0UGrE5geaImBBkiyvwI/bTrFpQEsciOsyEbdSF0CE1Q9ZHMZTge3+H4NipXsNNCdnNISRRzxVnyW57LqSkT502UKdX8pECaHeamQbD8QXSKrnk8w1Da8ZecmwJ43UiN060NLY16QE7NZh5nx2jvf3++2yWJY3DI6U9vJ0k4aTJjLUnsCdZUDQxUCqZ/tP0It3U0DwA2mpsOzLEUg2ZAHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(316002)(508600001)(6916009)(5660300002)(76116006)(6486002)(38070700005)(7416002)(44832011)(66446008)(8676002)(66946007)(91956017)(64756008)(66476007)(66556008)(86362001)(8936002)(54906003)(4326008)(6506007)(6512007)(9686003)(83380400001)(26005)(186003)(1076003)(71200400001)(122000001)(38100700002)(33716001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a2aumMr9JZsx++3cA2/u1ew8o/Keiy7+QJpSrNqDP7ydSF0aBpxI8GJzKIl1?=
 =?us-ascii?Q?D0nQHE7BTdpdCbh/NOyix7+8Ia74SALbPuSrdo1y4QS/rBOjRVf7QNM7XKN3?=
 =?us-ascii?Q?t6sZkOTWAmbu4iPVIvZFQUu0UH1ZMGV8lSKh2ijZ4PZEhQ/FosyTRzrfhFne?=
 =?us-ascii?Q?lErabUUXmUwKHo4Gjo1U2zgTMH9ySPEg3T9NBr95XbzBz4MFdIZIa1ymPHw+?=
 =?us-ascii?Q?/XAcE3NetEnAa8jneyop5XVjkD0RbBg9BuEVG4AWRfUOnnhq+rcEOfHtlxzY?=
 =?us-ascii?Q?fqNGuafA/fVMGhcbqHKE/xfDvlJZt35TqK1MdCBvm9/5v1/542B5FDMX1/Cm?=
 =?us-ascii?Q?YvdYBlQ2jBPQC8HtcA0m2F/L0wybQOHsEurhOQb7bCx0K6jU7kQKSKZsThXw?=
 =?us-ascii?Q?HvHmJjtEg6dvOhfZUVHPQZi1UC8cWHWoBbu06J8FhavfvWfY8ry4WQ2P1w7y?=
 =?us-ascii?Q?aXN7m27u2J6mowrW6P0fOvOExDWbdyIjEqoW4cNz64j3hDkKATWer5FRcfkH?=
 =?us-ascii?Q?FE0WWJfX8TLN/SB6W2XmBWv4ovs1mYUhkc59geElywluX/0G6u/1uDo+GLNl?=
 =?us-ascii?Q?NaDgfQTIA5J+PnatuapeO3/VtIfNgVTtZdhETwBJZGwphnH+QThKWNfJwp9q?=
 =?us-ascii?Q?4qFOvK5LoAc0uynav4e+Qca3vY4uOpXp/9I6/rLK7shfcs9l59uTkEq73s0f?=
 =?us-ascii?Q?JVDrzSStqVpOvmdVd3hsRFbsoB/8FJlSd7bl1FnFqdmp3iotIWRc6LYJtJ/J?=
 =?us-ascii?Q?GbdtnUnMeZwYHKhe/w7Yp2Dzrd6D0gcnLQIU5U8holz90xxNVsbmcOyB9aqg?=
 =?us-ascii?Q?ZkUsoiCg7mba/SypHbdlySDG3vPdS9hG9oW7ehTL73aw6iWVqrMyN2oiesHj?=
 =?us-ascii?Q?EhW84FEaTimPoPB0wL+/A1QqAYakKmn5+jKd2ypbzJfXgIP9M9DqFwn+6yqA?=
 =?us-ascii?Q?KebDgZ9/35cOHnIaDiE1h7GKNCnCIvQOkvXACcFTUt8xuv9HdZ8UG1Nexwqi?=
 =?us-ascii?Q?vQ/0XfARgoeJnRu7pAPwqsTwtcGhEzQi+2BlqwRNqM3A/0HV3FpTaOlWknuW?=
 =?us-ascii?Q?brxZxBe8oTWDHHkldinLzO1Gxag5WUvfVpC41+MxAM/SC8LXhRk7VCC8UiYc?=
 =?us-ascii?Q?UssqDRWnV1pG84AUZsndOjz6k61n6o3BXBb0t5kbfgzZEqe2bZwsA1ZuhzAc?=
 =?us-ascii?Q?QTAyl6lhJgTmZUOfpLGLBPRPPj0NF5bsKY7fPVl1rIwVmc84Hoi7FFb/einQ?=
 =?us-ascii?Q?HsTRZzJ+8OJrID+1yxitoD9Sz7Vym+A5wtxqipvjMEZuLlm4BqX1yMsr6bIY?=
 =?us-ascii?Q?I0fnqRPUuYH9gmKxnt/zW7UkJZWVPukIjBnsUx2FvEEdWrU+aMwHrYVUrU1j?=
 =?us-ascii?Q?/Bnduei+4009NTQNid9yLaYMzZA9cwDptpwxQkOl44gIqxZdF/DXvCpk8d6v?=
 =?us-ascii?Q?av8OhVPjrE8k6dR441xChegy5OsG75md9AA2pFg6o+VpFzSvSsMDxjM61SI1?=
 =?us-ascii?Q?Mg70CD5HDLnFseaFF8m+h/7szdI0J89nvawp/evfQIZy/I6it+cdicb2rhMW?=
 =?us-ascii?Q?+ANrql2UGdYG7B7NdNqFUE+4QdxWzgQxQAfG2iHYO3G0xgSICPVl97KHUiGy?=
 =?us-ascii?Q?MegHSocGhMogSbAjUaYHa8E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <360D3B7B2E89FD4EA43623E00C209378@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5377fe9-7cfd-461c-09a8-08d9e5a69e7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 17:16:43.4893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5PaVO9Sk7Q4sRw6C1EP8ewqdro9Jxbi1txPtqcbc2FIuy2M/6LIWPhnfNiIxHytDlRG7zS2kNnPh6CG8mY70A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5194
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=691 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202010097
X-Proofpoint-GUID: qKxjSgxONCIBdl7CzjdOYqGxXeE2eKJ2
X-Proofpoint-ORIG-GUID: qKxjSgxONCIBdl7CzjdOYqGxXeE2eKJ2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michel Lespinasse <michel@lespinasse.org> [220128 08:10]:
> Attempt speculative mm fault handling first, and fall back to the
> existing (non-speculative) code if that fails.
>=20
> The speculative handling closely mirrors the non-speculative logic.
> This includes some x86 specific bits such as the access_error() call.
> This is why we chose to implement the speculative handling in arch/x86
> rather than in common code.
>=20
> The vma is first looked up and copied, under protection of the rcu
> read lock. The mmap lock sequence count is used to verify the
> integrity of the copied vma, and passed to do_handle_mm_fault() to
> allow checking against races with mmap writers when finalizing the fault.
>=20
> Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
> ---
>  arch/x86/mm/fault.c           | 44 +++++++++++++++++++++++++++++++++++
>  include/linux/mm_types.h      |  5 ++++
>  include/linux/vm_event_item.h |  4 ++++
>  mm/vmstat.c                   |  4 ++++
>  4 files changed, 57 insertions(+)
>=20
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index d0074c6ed31a..99b0a358154e 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1226,6 +1226,10 @@ void do_user_addr_fault(struct pt_regs *regs,
>  	struct mm_struct *mm;
>  	vm_fault_t fault;
>  	unsigned int flags =3D FAULT_FLAG_DEFAULT;
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +	struct vm_area_struct pvma;
> +	unsigned long seq;
> +#endif
> =20
>  	tsk =3D current;
>  	mm =3D tsk->mm;
> @@ -1323,6 +1327,43 @@ void do_user_addr_fault(struct pt_regs *regs,
>  	}
>  #endif
> =20
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +	count_vm_event(SPF_ATTEMPT);
> +	seq =3D mmap_seq_read_start(mm);
> +	if (seq & 1)
> +		goto spf_abort;
> +	rcu_read_lock();
> +	vma =3D __find_vma(mm, address);
> +	if (!vma || vma->vm_start > address) {

This fits the vma_lookup() pattern - although you will have to work
around the locking issue still.  This is the same for the other
platforms too; they fit the pattern also.

> +		rcu_read_unlock();
> +		goto spf_abort;
> +	}
> +	pvma =3D *vma;
> +	rcu_read_unlock();
> +	if (!mmap_seq_read_check(mm, seq))
> +		goto spf_abort;
> +	vma =3D &pvma;
> +	if (unlikely(access_error(error_code, vma)))
> +		goto spf_abort;
> +	fault =3D do_handle_mm_fault(vma, address,
> +				   flags | FAULT_FLAG_SPECULATIVE, seq, regs);
> +
> +	if (!(fault & VM_FAULT_RETRY))
> +		goto done;
> +
> +	/* Quick path to respond to signals */
> +	if (fault_signal_pending(fault, regs)) {
> +		if (!user_mode(regs))
> +			kernelmode_fixup_or_oops(regs, error_code, address,
> +						 SIGBUS, BUS_ADRERR,
> +						 ARCH_DEFAULT_PKEY);
> +		return;
> +	}
> +
> +spf_abort:
> +	count_vm_event(SPF_ABORT);
> +#endif
> +
>  	/*
>  	 * Kernel-mode access to the user address space should only occur
>  	 * on well-defined single instructions listed in the exception
> @@ -1419,6 +1460,9 @@ void do_user_addr_fault(struct pt_regs *regs,
>  	}
> =20
>  	mmap_read_unlock(mm);
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +done:
> +#endif
>  	if (likely(!(fault & VM_FAULT_ERROR)))
>  		return;
> =20
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index b6678578a729..305f05d2a4bc 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -370,6 +370,11 @@ struct anon_vma_name {
>   * per VM-area/task. A VM area is any part of the process virtual memory
>   * space that has a special rule for the page-fault handlers (ie a share=
d
>   * library, the executable area etc).
> + *
> + * Note that speculative page faults make an on-stack copy of the VMA,
> + * so the structure size matters.
> + * (TODO - it would be preferable to copy only the required vma attribut=
es
> + *  rather than the entire vma).
>   */
>  struct vm_area_struct {
>  	/* The first cache line has the info for VMA tree walking. */
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.=
h
> index 7b2363388bfa..f00b3e36ff39 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -133,6 +133,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOU=
T,
>  #ifdef CONFIG_X86
>  		DIRECT_MAP_LEVEL2_SPLIT,
>  		DIRECT_MAP_LEVEL3_SPLIT,
> +#endif
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +		SPF_ATTEMPT,
> +		SPF_ABORT,
>  #endif
>  		NR_VM_EVENT_ITEMS
>  };
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 4057372745d0..dbb0160e5558 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1390,6 +1390,10 @@ const char * const vmstat_text[] =3D {
>  	"direct_map_level2_splits",
>  	"direct_map_level3_splits",
>  #endif
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +	"spf_attempt",
> +	"spf_abort",
> +#endif
>  #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
>  };
>  #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG =
*/
> --=20
> 2.20.1
> =
