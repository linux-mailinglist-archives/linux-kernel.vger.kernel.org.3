Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47B3475FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbhLORwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:52:49 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64168 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238305AbhLORwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:52:47 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFGAR7L021195;
        Wed, 15 Dec 2021 17:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dUcWbz9Jy0xh3UKxe1/WGtaHirx4h9ZZzEs1KuHHUYM=;
 b=qFsjP8o9H9RbVSyj3jQQqum51BjJipa5lk5J5tjXnvpFG+2RwQdW1o63uqlEJ8QTbfA8
 N7fxOEPT4LL2BNGr1P4px/PbUMLusdaBH5zb7ptdlWOfj5Bt3ScyM7OQiuhG71vyfVhH
 YYT28bxcn+25GgoxEWY9ZBNlBXhc4qbO/srFZMabR0bueSTzpf8tq3+lBEz1bwupg5mF
 yNRlMRLOouzgvvZ8lAO7zmBCHb5brxbXRMwSJisiSKKfBxI+vdj+Rf4/n9pHrgWwum3+
 rmfGgomwGT7e3pKMztr7CkQ0SZXZqBDDPmuGRTwW4q+rr7ZUQDefErHWHG1x7LqxZ1DO 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknc0bp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 17:52:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFHUW3k057722;
        Wed, 15 Dec 2021 17:52:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by aserp3020.oracle.com with ESMTP id 3cxmrc6ff9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 17:52:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA2lKjw0ki+qBGx3J+bkAidhosthkCS0yrkagHJ3h491r/x3rCbd4oQ8eLmKS4kHBEJm+QpqpnBDGny1b4d3JSjKNO58RXwq1b8vW2vGJLvhnw7YjlFC1YVYGy7FVBYb7MMJhmTpeP8yjAxCeEuANOlORCk31O2NecGWsstJbYyyDUKnihcQEIcSUgNyQJIOkBOlwdWkfdWMg8j/GAXhIYUI2QiJ+I7DlOEgUvId8skljvLozX4vsvLuKZwLwMCjCKuOUTk38rAm7k9TqNtUe81ffV+O1ZtmkgeDLMn/a6SZqTk8+4BXBMlnJtc4GAnVYtQJtB5D3gk4ZJfVmcswpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUcWbz9Jy0xh3UKxe1/WGtaHirx4h9ZZzEs1KuHHUYM=;
 b=fQEIm7QVlGASgUGpEEa+D7ks7lf12admPc2RsN8F+Rnsnubz7keAuaEUD1duqoberGjqZy2nJ6dV7DiaMKg2Oa2uqRxffgNtaYl4rPKf/3FGRm19AS9wvgrhvLyhwnlFV8Gh+bhPJehpMjxkstW4X9NVgUPTC424j30np111vIIIssXeCuxbbkvXfbO5S92XC4dyaPplTVaEZGJNMzLzf0AvZ7dwn+gNcoZqU8dmKemiwdmzz/yquaqcRRMX+VitwVLxInp9S5GyEZYk+JFjV5RRVcOs385TqcErsH6Bfc6cwJPRnagEMjvf9sM/QxsiV8DaeOnCMMhoth2aNMBSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUcWbz9Jy0xh3UKxe1/WGtaHirx4h9ZZzEs1KuHHUYM=;
 b=sc3OJIAGBMdRjeCZx8CKsFbDnC7ohaIQITEaUXn7zVyD1k6Sm2APXRaIDuVX6lk8NiV8UOoZGXxcnlPhP13ZjlgHqeiF1AMDjMnHugSPGF81qlgSqdXYs/7JtolDeB627gABnWkgtVIhpTXgKsz/5U4ELUcmqSG9gIps0XYfSng=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2623.namprd10.prod.outlook.com (2603:10b6:805:46::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 17:52:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 17:52:08 +0000
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
Subject: Re: [PATCH v4 05/66] Maple Tree: Add new data structure
Thread-Topic: [PATCH v4 05/66] Maple Tree: Add new data structure
Thread-Index: AQHX5r/msk+dWGpCHEuUYu1SfT0uo6wzmF6AgABTFAA=
Date:   Wed, 15 Dec 2021 17:52:08 +0000
Message-ID: <20211215175139.nndgst2mbdudu2dx@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-6-Liam.Howlett@oracle.com>
 <f727adcf-5967-0b71-92a8-3269c0256948@suse.cz>
In-Reply-To: <f727adcf-5967-0b71-92a8-3269c0256948@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2df5741e-7974-46a1-fb8b-08d9bff39d43
x-ms-traffictypediagnostic: SN6PR10MB2623:EE_
x-microsoft-antispam-prvs: <SN6PR10MB262346D38F681760D642B85EFD769@SN6PR10MB2623.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RzFwnT0nv2qy/ZqQeraypy3SahNB2W4dNiOW3oTIe4OhZ5HOHTRXxg2VH0n3kV64010koADQIGbNOqtdyUK3Yh/gjA8f/ooAiOyOTKeTOlTUCWWDE6JW7nHqqgb2YUkNO1GspHD35tlwJHGQNHxrpr9hNz1y9DfhNSkUqjNY4m+V4O5uowgVTBSJzqzmDg1BmVF6nZh8WDC5gidjLwzjYKjMgpbE2Dv6s9RXKdCg0UB57TQi1Xw6soK2EUWjWVC/NlTGCS7YlkHFgw8RCAXkTHeujzFUNerKDe2ECLF2uuLLf0uHjXECwYA4yejM/5G38QoPkHWvevUU2gm6ls5wu62aE2cJ78XFsabCYRi8b6FprnZxec9EUxx4XA9qGQdVyGsToQm8T9AmpaKJa7voVAW57IiE+nLC6E5riZ1sra5Jfvj2fK6W+ygvLX5t7NBgbdKa2CEbMS3lUxbuqqjYfj96+rDMHTh1qCcefSPk+8DOKaVHJAzyDPFN28mlAG9q6a0Gn+IR/KyjKyfr/ZXQBrIZABm9nQsJYz7FcktIzhTOz5lqGc6MT/WCWUXFnyaeM+qtLfaFq8cRgR14rw9vKRfN9dToOaTUT6TDbWJp0kKW6Qfn9Hnp3voe3HxVMzMAjWafOiZD2wLEA41oMdXe+FAWg8Ce+u1UWBFWAH0nwTMkhBPjAGCWJhgTi56crMVmGqQtch6q3LjyvSHoX/ILng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(5660300002)(508600001)(316002)(8936002)(6506007)(53546011)(38100700002)(8676002)(122000001)(2906002)(33716001)(6486002)(1076003)(26005)(44832011)(4326008)(66946007)(9686003)(66476007)(186003)(91956017)(6512007)(66556008)(86362001)(64756008)(66446008)(76116006)(71200400001)(54906003)(38070700005)(83380400001)(6916009)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W2kgL/VHPl/MpD618U/rWAPeglK+oG2XxBoTEJb0ClPzMPQ8AWxr11zXZ1YR?=
 =?us-ascii?Q?9B70GTPYFoN3W/Zi+fpVKVQz0GZUoA5r0GN3mHyivMl8hQL4P3ibjdVBgV/h?=
 =?us-ascii?Q?Y/0ehCPPtS8gPjYY43ja3oPmgfF2gBkSL+0TdppW1XijDr9kOdDEZeiWw8zs?=
 =?us-ascii?Q?Oxkfb4CiniUqRS3bbRhyI4hlWfvrDxdwcubD69mFe4N38j88NTlN+VKX6hrb?=
 =?us-ascii?Q?yKX0YrZz+VDta5+SJXdN1FYfyqHhc3KI142XT/Xd6kkJvkNCfCobghYXZZlr?=
 =?us-ascii?Q?gtkhC7wiVxMQSqI5qu8xHrW62va52yJw3ITZIGpwFWifSAiZhB4IiB4Orkt+?=
 =?us-ascii?Q?QCWyl3TEUScozu6jCHKuSqA7exYqSN8QOLy5yjOJVvYB9HjxKkr+QfmxTskp?=
 =?us-ascii?Q?UfLXQsWdBoKrSPIIBGVYh9zvN7gGT1cbSvtmwfQm9R1iyT7an28HBRr4iqLa?=
 =?us-ascii?Q?raqob9ZPdKwd9KGggWDISrk/nNbiYqAY+jZQQ4zlGogz2xJ5azAaSpK+sPxh?=
 =?us-ascii?Q?qIidCFMimddYUmzxdwvQc3l5O1nbMc9lZoGJvpngoRL/XrVE34jANmlot8Ms?=
 =?us-ascii?Q?Sp2RQx46/jy2+JED/dJx+ILAGY/CXV7lUcgKWv+dExZBsxNMQElvMwXpmVow?=
 =?us-ascii?Q?AvswrHnlfnGpPBzpyQvRuPbBAT+VuWry7/8/uV/XCtLMuYdCuz+Cd6CHcSIm?=
 =?us-ascii?Q?ZiTZWxVHU+DOav4XuS620jaYpfoyLlkj9ILojYfY8ZZ5od7QpOqKA5v5Y8aW?=
 =?us-ascii?Q?b/tmCR20wQ+q2MeX6lPTIS+B89pydoUT1SeIygrl++SU8xt6tkwIdxJZtbfp?=
 =?us-ascii?Q?i+ZjQhpOYd9AbB7BTdLp4PlWPZKJ3NfgrZIJkYj38wrZ2K+OtOncrxA2474A?=
 =?us-ascii?Q?BoIcw30dTE6dCBKxQm/IKbzu1IULaGACjsH5YNirTkPiESydjgysch78k2Gp?=
 =?us-ascii?Q?z6Sv1YGdVoUCQJquSlsmygEUeul02vH1eoEUii6RwUx8Uplk5u8kYwggz1w+?=
 =?us-ascii?Q?AIPxii7rEE8jx+3mQnuhjQ33gXDAIK0n5nJ7cd1bf3hVlmHDM+i7WbWW+tXc?=
 =?us-ascii?Q?HfE1kGoJVGJe4vO6W/J7oQjyXNAWExfcQ1RYGTner8uei9mkFzTrDf4dym6u?=
 =?us-ascii?Q?NU6NuASzZdWa/qOaPtCqPj8b5KztjPgyeNmHhzXN7jBMcgow9iGlniORm4GG?=
 =?us-ascii?Q?Ugm4mu2Oy5f9yMZFAJAUi3cGeOU3foWuOYLUbHZVjzaNevrW/B/pzlNuvmzn?=
 =?us-ascii?Q?3eS4Ua0MgmYh+AGzO5mKTjOsb8SZ/BFm31IW/HX91ju+PvCiyrNYbuV0aDLu?=
 =?us-ascii?Q?dF1VpURU47c7HsqFFO4JQUHYv9GrwtvnIIGg4uewQLmdedavfhLUu0CfQqiQ?=
 =?us-ascii?Q?mwUECjdRPoLht2NAwGWB79q3yEYnBMAVM65ZGSW3xAFjP3TNUvkDUE84CKHy?=
 =?us-ascii?Q?plLWz/jQDq7Shzy6ncS3XSbWOeyAYMt1BNq4cvWyzcbBHyutu8qz5O2iP2v2?=
 =?us-ascii?Q?5dduZURF5aAaikE66y9wgDMNLxyRIIpz3ohCgL67mjie7YgwfwBppRQLxMtk?=
 =?us-ascii?Q?o9a6h4yhM6//ASBg4cKCeSZVnkJfkf5yJqvDwr45NX8ngNuGbxN9hKD1y462?=
 =?us-ascii?Q?UQV9Wt6M4uSB0dTRkzlnIxo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <824047285A820F479AA54782F0C0CCAF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df5741e-7974-46a1-fb8b-08d9bff39d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 17:52:08.4978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0VW6uGnoqrtFD8cN2CUlKFKrMdVepEfIlDj+MsaK78W4sdEgV8j3H7KuU+rmkc4mOtxRTZ6xx+zFbf063bB53Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2623
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112150100
X-Proofpoint-ORIG-GUID: Le_ZKEC_iPM0B8j7WACDvFjIs9bPxQrP
X-Proofpoint-GUID: Le_ZKEC_iPM0B8j7WACDvFjIs9bPxQrP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [211215 07:54]:
> On 12/1/21 15:29, Liam Howlett wrote:
> > +/*
> > + * mt_find() - Search from the start up until an entry is found.
> > + * @mt: The maple tree
> > + * @*index: Pointer which contains the start location of the search
> > + * @max: The maximum value to check
> > + *
> > + * Handles locking.
> > + *
> > + * Return: The entry at or after the @*index or %NULL
>=20
> Noticed later that the comment doesn't say how *index is updated.

Good point.  I will add to the comment what happens to *index.

>=20
> > + */
> > +void *mt_find(struct maple_tree *mt, unsigned long *index, unsigned lo=
ng max)
> > +{
> > +	MA_STATE(mas, mt, *index, *index);
> > +	void *entry;
> > +#ifdef CONFIG_DEBUG_MAPLE_TREE
> > +	unsigned long copy =3D *index;
> > +#endif
> > +
> > +	trace_ma_read(__func__, &mas);
> > +
> > +	if ((*index) > max)
> > +		return NULL;
> > +
> > +	rcu_read_lock();
> > +retry:
> > +	entry =3D mas_state_walk(&mas);
> > +	if (mas_is_start(&mas))
> > +		goto retry;
> > +
> > +	if (unlikely(xa_is_zero(entry)))
> > +		entry =3D NULL;
> > +
> > +	if (entry)
> > +		goto unlock;
> > +
> > +	while (mas_searchable(&mas) && (mas.index < max)) {
> > +		entry =3D mas_next_entry(&mas, max);
> > +		if (likely(entry && !xa_is_zero(entry)))
> > +			break;
> > +	}
> > +
> > +	if (unlikely(xa_is_zero(entry)))
> > +		entry =3D NULL;
> > +unlock:
> > +	rcu_read_unlock();
> > +	if (likely(entry)) {
> > +		*index =3D mas.last + 1;
> > +#ifdef CONFIG_DEBUG_MAPLE_TREE
> > +		if ((*index) && (*index) <=3D copy)
> > +			printk("index not increased! %lx <=3D %lx\n",
> > +			       *index, copy);
> > +		MT_BUG_ON(mt, (*index) && ((*index) <=3D copy));
> > +#endif
> > +	}
> > +
> > +	return entry;
> > +}
> > +EXPORT_SYMBOL(mt_find);
> =
