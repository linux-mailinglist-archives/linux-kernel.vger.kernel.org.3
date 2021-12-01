Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FE4465240
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbhLAQDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:03:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36588 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232211AbhLAQDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:03:00 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1FbeXJ012055;
        Wed, 1 Dec 2021 15:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mzQCShbHnl5YEIPaYrCf3BbmGWgHWcO/fAZWF4vsgBg=;
 b=b1c7EbyZLJ+5I+w4b4j2LIyCFCtynyhIIjQU/lTexP+v2qYw5kiK4HU8fwyuZyUWDbuU
 7DcwvU4GhIUfd2DNkJPR/OIrwtYHwq3C6WMRRgWGiJsf9eXjnf/yaTGzr2bG8TJAAf41
 DnUAwxz44YUCz26nuNFukNvUTLQFYvoXjOBlOc9+h17s6uLQ/VpB0YU/9qi9DTGT0olR
 TuBXU6Lnhh2+BQDnedUDU/PhArYz0I92LAilc9l5jbQi3C1o8rotD4UVNrS/OOks4VKQ
 yRJquK2DpMjIbp3lxwyT3xF6s1+lBPMyiNlJgYG7C6hpqmNjUrY+G5BPE+cYgoSsJO2d BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7t1hjcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 15:59:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Frmgq162097;
        Wed, 1 Dec 2021 15:59:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by aserp3020.oracle.com with ESMTP id 3cnhveu9jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 15:59:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2oNdRqTGystgCE1D/dKYoOUqs9B/9CQUIfypnkZOXMv8c5yO9NNVo5+5ztEKSeIMPDziPxbaK07UXNIl5L1H4Vz6qz9oO+u13iVBImAhlKVCz4wNcVkMFFDRGpqwberiMG9RL6DrcEH0nOXB+chh2ckUZOnoT/yMdDbEq/mm+0vYLbc6EYSOg19+Uffw0T2TfRUc6vBhJbnCZyowd4pqriQwvYazaFJWvLxruJnyXusLSM3pg5TxzhlHdNOzWbPqtPEpyxeBRwq37vaENw+50zWEAdSbrsJZPbG/3ONkh8prcxKwJCVFt9vk369aaj+TpIVujI5d1yx1ufQiTRu9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzQCShbHnl5YEIPaYrCf3BbmGWgHWcO/fAZWF4vsgBg=;
 b=OTsOPfX4E1kz6T925tBxcAxzTM3IquHxmA2RpJSF2cnj/h1WITnK1fgJsXa7dNAbuOqyVU8oSNkVuKic+x8DLb8g72LN88qM+9DgoUZASTJyzb0uT+q1g8xy7L0wenJCGmHRp1tUTvTKLAQ1HxqQaEcjDGSRrltpP077C32wMCNuP6F58A1it0Ritv1XGcBWoXZxdkplkyhD9I7NFUVeAPzkZvlMlr7rz4tnmatx9SaN7zXShQI3g0QL5QyrDDYjgAU+pXR8Ou9/46gK4OW0wxr/EzbZEAH6lmAqfTjrzvPdOq29OLyV0dWu2ueX/sNgvzLqFIY03budR5tEf0/Qug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzQCShbHnl5YEIPaYrCf3BbmGWgHWcO/fAZWF4vsgBg=;
 b=r/MyhlWMn44siFuLTLOhZoRZNiDnQgAkIwzIR63JhqgITNWiWtLphqqEPZLmBRwq3R/5FDa4etZhWztGxiShA3C1DU2g68Ld5yNivB3JEy0iNYE3I6h0kUO+pu1YWbSJ0uhMPeKG810IyCotd85NERan4mrxKTEO8nlwx62HaM8=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by SN6PR10MB3040.namprd10.prod.outlook.com (2603:10b6:805:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 15:59:21 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074%5]) with mapi id 15.20.4755.015; Wed, 1 Dec 2021
 15:59:21 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cgroup: Trace event cgroup id fields should be u64
Thread-Topic: [PATCH] cgroup: Trace event cgroup id fields should be u64
Thread-Index: AQHX5sFwaB6Hoy4YakmqLMRZzO8P2Kwdx44AgAADvYA=
Date:   Wed, 1 Dec 2021 15:59:21 +0000
Message-ID: <79DDD700-AB39-404B-B27C-F9DFE6E624FE@oracle.com>
References: <20211201144043.557470-1-william.kucharski@oracle.com>
 <20211201104558.230196a7@gandalf.local.home>
In-Reply-To: <20211201104558.230196a7@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.62)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9dfe104-4d97-42ef-5ea7-08d9b4e38a0d
x-ms-traffictypediagnostic: SN6PR10MB3040:
x-microsoft-antispam-prvs: <SN6PR10MB30401BE3D9027303CD28C66481689@SN6PR10MB3040.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nFas0MmA5qa5phI42W3CXI51yBWcONfvtYKx0ep/vrJPaWsNsaUh+yw7RdiqrvJZuGayNZtn5kiTAA9Gu+8qUzkxRa1XRTRng67iSbS8YZLV2PfgbfX89DacD0iBS1EqjLXB5qInWsIWluIi/pig5TiKPsHz3CIAM3Rs1YTQIexg1RSKFGislY62LprCiZJChrJYqxa+DDGjvApnH0EYhqA3Nf1LhGpT7QPMC+liRrp0gkuIOVgCmfvSAo61AXdfPNtP6X1jaLItQpcSmnyZ2o+YjVYZ3J+aKlIf0uqWDb3wHOasITd1mSJoqnX4J3vfvQBHTtS2EMmBBHFduY6yE8ShDKk+PcDhCXLik4jPdfZkAQtbBRqKAMY8sbJxxzAMk6PBOtRL1aZXUrJ2u/Glc09jcE32MrgbVaAFdMg5qvDDOlN/mSqzb5rayy3hzJwap+gl4OS+7Z1iFp4nSm2Yp5qj8wqom4yqLbd6YIyNdRMdwXsJ5toRIWcaJNxRBKgXPyFEdyL7CVQHffeoSPhCkRpwQwoAJMKDkrSpvADHJmdpfhujaBlKTlecXtHWdDBl2g4Wflgz1nPBy6oH6oBQRNyTMXanzBxuvsXdT2bQsPVmYzYeYw0zqR6oTDZeIHdOumk7G+Vv/4QIXpcoQ/27dasWjqGXrul7dL0DTwoRKk6jto2fvFERVXC2wvJXKvCRwiT1PmkAAQrSIbSncC6Wvk5sh0FGsl+6//dbMmjkPIKU8vAkYYykjbqm7jlyfMwx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(186003)(83380400001)(91956017)(66556008)(2906002)(316002)(71200400001)(33656002)(8936002)(86362001)(38100700002)(36756003)(6506007)(64756008)(66446008)(5660300002)(76116006)(6512007)(8676002)(6486002)(508600001)(66946007)(44832011)(66476007)(6916009)(53546011)(4326008)(2616005)(54906003)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wY8svpHNiRnl/BGqhsEInZQNaLXPd3m4Y9OwUQsNoMai6cBg/5cLFgNF1pt7?=
 =?us-ascii?Q?JoGKaymBQ8L+HxNYoF4IRqxOOYt9m5ONkp85+aNKizEp0epe6GQaSwgtF8mV?=
 =?us-ascii?Q?SeGqzWwvwVlm1XrxS0K7RU7aCEdpdJuHNhzMUVAilHTQJ3eS7pBSptcRa7XF?=
 =?us-ascii?Q?DaWOFNvBBlARoCewkmPZx63WMlQj8eKK9mR+XafgdGoCHfzUXu4RjjK4V9nS?=
 =?us-ascii?Q?19MibtKEy5IPanA719l4rLBgMeb2bihm0XhfKJR7P8ljTy8gSk/Rxm0Z39p3?=
 =?us-ascii?Q?uPjv3WJ7Hd9tlIBPzik/zmBjOv/gqMYO8Tn3gIRMQKO8Z7EMjiz0hNxxvMAP?=
 =?us-ascii?Q?neYFUQwdUw+m39zt4WlZYoQA8JHZ3snz3vXSsJYVcBRWS8mARKqr5GwDMlVo?=
 =?us-ascii?Q?3em/zaEcg3HZT7ZGdTgITgk9PHUa1BB7MvFjEpucvnwTjyRMhWt0c1PgH0P0?=
 =?us-ascii?Q?yVmCYqLIwAxlTPTESVNNzyzu7nNc5AX9CWv8AXH1X2p9SgEqGSPFf0UK12pl?=
 =?us-ascii?Q?fVbM7zp0FPNWKkIQwS+ueYD4c6Xxy/NXd9610PcaJoh+JWNhw6LTGoTnDSkG?=
 =?us-ascii?Q?Aq2rcmEwsPFk+4mic1FXL2jTDHDa+QO5Ya9bJsaR0sYbQtNbi0Eo1x9koZXV?=
 =?us-ascii?Q?Nd+FP2Lkjb7pAKncahAK9VP+1Djxb4+aW1NOm98jqS4TS/FtcB+UTE2RlZzo?=
 =?us-ascii?Q?ixFg33valhTwA6Aj4DBRxMWT/PqrbQczuI8Ark4/qsHPIPz1HX1tBi0DnSfJ?=
 =?us-ascii?Q?wtCg6S2tIFTCQIqNTFHxFzjBaEX+225fg8/2lXNtgDxU7cOiP+bBRjFolEzK?=
 =?us-ascii?Q?tmg2TI81BwH/b2lwVH0hiKlZgkVBg8VtcF2AFBBrHA2eqsxcbIGKVCL59p/M?=
 =?us-ascii?Q?RIlr/lahUPHIUVFcvT5P2j/a6fGdBzTsiy0roQvQ9BrB/1aWSUzPNybcEyQs?=
 =?us-ascii?Q?+VHVfN6KyUoy8dqXvYsYiMeI/FbS1M+2E1dejQ+CG3azY3ZODpjnG6N+ubY4?=
 =?us-ascii?Q?FrFuuvBRA9c3BNHpK6c835uNbyoMaqRS7vFdeZMEzI2dse2CZ3cBVSjRwBnM?=
 =?us-ascii?Q?kn1YaFvuFYuVAZHeWA2lJjodao0vnLCxrMOw8tKsJiGQxJJIErSJWVhhw4lO?=
 =?us-ascii?Q?aoExnEyUlu46InbCuqXB68I0pEQnlV57Vn5fHojkZsAPtIRRuFzc9ygmQx9/?=
 =?us-ascii?Q?+qSkcxzqlZwT0jNkF1KHe+UVGPpQW+ezZ7XmWFbqCLeBfr2yqiRi6zseHm5h?=
 =?us-ascii?Q?Dr1BbH+PMf31VPgI0tXSmoQ57N8MDaRCytxYpDrrwsH0uRTsaBJwnIPqIU47?=
 =?us-ascii?Q?NUv0ig4lXemYwprRa8UyPrB1AWULzzsClZRunRqRgQ6SCx9vkXzxsBIfxF0Y?=
 =?us-ascii?Q?BsRbaR2G9i8DK4QVESk5yoITPCLYnvTHbs9lYh1BK8xTyBNhwvLrer8fM3I5?=
 =?us-ascii?Q?IkuDeSeAg1fB/ZVusTdZHTFqhJr2kAj6AazEnp1WXy3Rr6R9i8Zb751ZBYYF?=
 =?us-ascii?Q?1Rmwy/vVC4I/THEGTs3Uj3VCkbvkWfPi70ie+Bkt7dTmW0AYpczqnK2MgOo1?=
 =?us-ascii?Q?NrqwGuINzCKNcxx0Yjoyt9VTEflqAsDOZTn+sPl3NWcGppue+qhp6k7Ej9MK?=
 =?us-ascii?Q?qHPSJTtEr5peYLFe1arj5sljU8pLSJL1PR0sAHrFkr3T+MO15p16JasEuraL?=
 =?us-ascii?Q?ehc/ndTXuEAz6nUbfqhbYWbeo67hvXlQfegkwpq1hXlmHcrS0agitfy6um3Y?=
 =?us-ascii?Q?NQQJHRmTohLwvAkESBWx4+U6V4UVPEk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C19C74A9B3C7C3439AB4164AAEDC3727@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dfe104-4d97-42ef-5ea7-08d9b4e38a0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 15:59:21.5089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: olsR5Mr6eSQJlp7EJbvHRKmfRRv4X86WL35WJ/1CIHMAfMgnjV4ceU1xPpLZHlyfd0wyELeqfGZp/24lbtUEQUcSC2Upnv52542Zika6szI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3040
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010089
X-Proofpoint-ORIG-GUID: YGYstgVxkW8b8JQ45K958o0cwpowjMww
X-Proofpoint-GUID: YGYstgVxkW8b8JQ45K958o0cwpowjMww
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, V2 will be out shortly.


> On Dec 1, 2021, at 8:45 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Wed,  1 Dec 2021 07:40:43 -0700
> William Kucharski <william.kucharski@oracle.com> wrote:
>=20
>> Various trace event fields that store cgroup IDs were declared
>> as ints, but cgroup_id(() returns a u64 and the conversion was
>> not intended.
>>=20
>> Also remove extraneous spaces in fields that are no longer proper C styl=
e.
>=20
> Um, actually, please do not do this!
>=20
>>=20
>> Fixes: 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID")
>> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
>> ---
>> include/trace/events/cgroup.h | 42 +++++++++++++++++------------------
>> 1 file changed, 21 insertions(+), 21 deletions(-)
>>=20
>> diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup=
.h
>> index 7f42a3de59e6..a85b01aa1fff 100644
>> --- a/include/trace/events/cgroup.h
>> +++ b/include/trace/events/cgroup.h
>> @@ -15,9 +15,9 @@ DECLARE_EVENT_CLASS(cgroup_root,
>> 	TP_ARGS(root),
>>=20
>> 	TP_STRUCT__entry(
>> -		__field(	int,		root			)
>> -		__field(	u16,		ss_mask			)
>> -		__string(	name,		root->name		)
>> +		__field(int, root)
>> +		__field(u16, ss_mask)
>> +		__string(name, root->name)
>=20
> The spaces are there for a reason. These are special macros and not C cod=
e.
> It's defining a structure, and the spacing is to imitate just that!
>=20
> struct __entry {
> 	int		root;
> 	u16		ss_mask;
> 	name		root->name;
> };
>=20
>=20
> See the difference. You just made it less readable than the original.
>=20
> So leave it alone.
>=20
> NACK on the style changes.
>=20
> -- Steve
>=20
>=20
>> 	),
>>=20
>> 	TP_fast_assign(
>> @@ -58,10 +58,10 @@ DECLARE_EVENT_CLASS(cgroup,
>> 	TP_ARGS(cgrp, path),
>>=20
>> 	TP_STRUCT__entry(
>> -		__field(	int,		root			)
>> -		__field(	int,		id			)
>> -		__field(	int,		level			)
>> -		__string(	path,		path			)
>> +		__field(int, root)
>> +		__field(u64, id)
>> +		__field(int, level)
>> +		__string(path, path)
>> 	),
>>=20
>> 	TP_fast_assign(
>> @@ -71,7 +71,7 @@ DECLARE_EVENT_CLASS(cgroup,
>> 		__assign_str(path, path);
>> 	),
>>=20
>> -	TP_printk("root=3D%d id=3D%d level=3D%d path=3D%s",
>> +	TP_printk("root=3D%d id=3D%llu level=3D%d path=3D%s",
>> 		  __entry->root, __entry->id, __entry->level, __get_str(path))
>> );
>>=20
>> @@ -125,12 +125,12 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
>> 	TP_ARGS(dst_cgrp, path, task, threadgroup),
>>=20
>> 	TP_STRUCT__entry(
>> -		__field(	int,		dst_root		)
>> -		__field(	int,		dst_id			)
>> -		__field(	int,		dst_level		)
>> -		__field(	int,		pid			)
>> -		__string(	dst_path,	path			)
>> -		__string(	comm,		task->comm		)
>> +		__field(int, dst_root)
>> +		__field(u64, dst_id)
>> +		__field(int, dst_level)
>> +		__field(int, pid)
>> +		__string(dst_path, path)
>> +		__string(comm, task->comm)
>> 	),
>>=20
>> 	TP_fast_assign(
>> @@ -142,7 +142,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
>> 		__assign_str(comm, task->comm);
>> 	),
>>=20
>> -	TP_printk("dst_root=3D%d dst_id=3D%d dst_level=3D%d dst_path=3D%s pid=
=3D%d comm=3D%s",
>> +	TP_printk("dst_root=3D%d dst_id=3D%llu dst_level=3D%d dst_path=3D%s pi=
d=3D%d comm=3D%s",
>> 		  __entry->dst_root, __entry->dst_id, __entry->dst_level,
>> 		  __get_str(dst_path), __entry->pid, __get_str(comm))
>> );
>> @@ -170,11 +170,11 @@ DECLARE_EVENT_CLASS(cgroup_event,
>> 	TP_ARGS(cgrp, path, val),
>>=20
>> 	TP_STRUCT__entry(
>> -		__field(	int,		root			)
>> -		__field(	int,		id			)
>> -		__field(	int,		level			)
>> -		__string(	path,		path			)
>> -		__field(	int,		val			)
>> +		__field(int, root)
>> +		__field(u64, id)
>> +		__field(int, level)
>> +		__string(path, path)
>> +		__field(int, val)
>> 	),
>>=20
>> 	TP_fast_assign(
>> @@ -185,7 +185,7 @@ DECLARE_EVENT_CLASS(cgroup_event,
>> 		__entry->val =3D val;
>> 	),
>>=20
>> -	TP_printk("root=3D%d id=3D%d level=3D%d path=3D%s val=3D%d",
>> +	TP_printk("root=3D%d id=3D%llu level=3D%d path=3D%s val=3D%d",
>> 		  __entry->root, __entry->id, __entry->level, __get_str(path),
>> 		  __entry->val)
>> );
>=20

