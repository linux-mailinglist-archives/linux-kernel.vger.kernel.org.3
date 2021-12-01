Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D328465210
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351161AbhLAPxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:53:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55940 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351143AbhLAPvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:51:14 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1FZqVP012062;
        Wed, 1 Dec 2021 15:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iL59dxU13dPDSfIaFzD7nz7nQQAeSLDC/IJUEwqgnpU=;
 b=BZBj0zCPa5b4oXBjEj4FsoGjgMv/5QBQ1v3vPi3YqLtWkSH3vtct01VMxUhmPB1NHfXW
 bHbc1lTaAiICw+vZFEak52wsKdd5Dr7HK/X4/b2xkKjKrXzWMTylGJ0e9cHJZH33ZmFD
 6kGOVuBxkbbxzwZfE8SJESISceJZprTSobdEZjEkGqWMCVZK6DlNjYoNiSY57BiY8E5C
 PHBsKQ1CRAAomwzowseOqXcDo5jXfNEZPMQuXDa9c2WCpmbDH5eSy8HWcnd8WIWrcHU6
 CCpYnKhNwD6mu00YCV3ngxiaYgroRVGgkuvx4lJKwAaOrMn903vyNZjkNFwVbp7dLorR pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7t1hfvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 15:47:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1FJrDZ010836;
        Wed, 1 Dec 2021 15:47:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3020.oracle.com with ESMTP id 3cnhvetprk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 15:47:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RL6j+aCA8yjr9d4dK7j3Ym8fZmYGoNObaFjhtE7mPZFYG1fJnAlIad8k5LNc4qgPQm/HpRT4sXFG5vRFNBc+LJKByh64jFuljkMUPjbKsYQpF7c9cYnHzQnJt5qT2hzmRZqgGGI+LgzgNhUg7D0Q/VZ248rw8RVFiLTMtPJflgL15vggS/k19oBRYJFXesA8W3Rc0OFxdCDNLCSNtZTPH9PJYRpxB7xyLOVJmDRoieF7W/vjE6Y1ufrMr9+IWEIEttzkzA0zie2o4kX03FN4ksls+NkIHR1Ancc5/nU5Ceb09TBLz/sCDn8FdFZtO130O+8i/Gg0a6hNxRicnOk1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL59dxU13dPDSfIaFzD7nz7nQQAeSLDC/IJUEwqgnpU=;
 b=hMUMXjgl4vmxy0egljEN4qmF30VODpfk5G0EmzGN36fOMaBOCir7zj3HoHY1gnPUr2y3Vj85WXpbusBELGg3zLZ2i0YkJ2qg59QNBuZfiOg7c5qdqr1MC6fkea9WvqwT1CdMpEaWoK+AwWkllizEXBSnrwzgvlJDFFZI2ud2ksUA9buPlCViRyG7UuWybze+kameWzhlYBncnQOhljU71TWawBhuWTAs2F0+i+5yZODQhkBRW3ucNzj+njNhjiIbcL6yZiNXl2WbPySHkZEiQFQcskuP9QUVh0kIbfCp1O6w7Oo0g2mkvYg+Q13zm1GRNewGi3WpCiC+2qOGE7rDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL59dxU13dPDSfIaFzD7nz7nQQAeSLDC/IJUEwqgnpU=;
 b=ULDtWarHpTkctS05yBKoGoy/dshNFAbjhzx0eg/8zkGIgfTSKAdxyBfFeUK6W0q+aWdJM+LkF2MypaNIjzKFxrCZjXqxsTWCWUSg7lyXXmI5PAsjt1BAh3qx+S1Ubbeh7w/PjO6BD0mAqxi0Ltqm8zsbh8y9XiA7AS+og9kYxjQ=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by SN6PR10MB2685.namprd10.prod.outlook.com (2603:10b6:805:40::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 15:47:25 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074%5]) with mapi id 15.20.4755.015; Wed, 1 Dec 2021
 15:47:25 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cgroup: Trace event cgroup id fields should be u64
Thread-Topic: [PATCH] cgroup: Trace event cgroup id fields should be u64
Thread-Index: AQHX5sFwaB6Hoy4YakmqLMRZzO8P2Kwdx44AgAAAZgA=
Date:   Wed, 1 Dec 2021 15:47:24 +0000
Message-ID: <087E34E0-A259-4BC2-82DF-8FD7665CF22C@oracle.com>
References: <20211201144043.557470-1-william.kucharski@oracle.com>
 <20211201104558.230196a7@gandalf.local.home>
In-Reply-To: <20211201104558.230196a7@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.62)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 579da10a-cadc-4092-c1cc-08d9b4e1defc
x-ms-traffictypediagnostic: SN6PR10MB2685:
x-microsoft-antispam-prvs: <SN6PR10MB26855E3CC4F432C7C206153781689@SN6PR10MB2685.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k3/JEfcfZmLe32vS9W1lu0JzQIKO7etLSrl/bShXw+C4yBbSw2IGZhkiWD+9Gz4cEW8SP66CJp4KDV240IEfXhi3bke/eH9RWCTybofaIUD0zKj2eLmqFgMnNjOI0GsVeD6y0keiULkUHZB3B1yVBhJm/PATY0fC0HqMMye4PQHuR5pZzJu1rnDMGg5qepTKYbFTRx47Pj4QO0EIwCIsEsCTvjHABFcilfukw1ZGt7FPyP3CztsW9ovLDtN4WppH8VjIghUYwg/HvHBH3Wb/OcDBW9+HKpGnxuNMyaymVhOg0dkzgmCZ4RcN+ljthUwqIdPXtwOKqP31p5DzOZTfZ5FOI3jDPPkNi2+gBEadc+vHq4TrAwy97Qd2nJB3Zys1ZLuly5BSAkKfAtYl1oB9HE9trOE+FX1ypCk25AA+osZiNHNgeg3XvirrVA6f+bGtwdkjgHzv2TvVthTY5O3ZMzuQAey+HKdF1TPoK5/2cdgDYBj39Ny4scI+P3dW+3dC4mtnpxve0bG6qSWE7NfLIusryk1x3BEMt5MF8F3UNY2jS0KCMAe3wTdvgKteDQLvrgeOsr9owfBTBtImv6YdH25mKtrMShAuwFYtLrrot0990yP2JkAWbF2np1tXAxRas9JVZvevIUnoCyaKqnmdvqLNJnqRlEXjXFFv/CmsY0DCciBs5OLVSm9AaGJgXxeSXku3cpKZ0X1yJ0e2l/yvbrEoV2QtPzkTjrcyu3ew5y17QhOi44MEJZEcqbn7MNpe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(6506007)(71200400001)(64756008)(2616005)(508600001)(66946007)(66476007)(66556008)(2906002)(91956017)(76116006)(38070700005)(66446008)(316002)(38100700002)(54906003)(186003)(33656002)(53546011)(86362001)(122000001)(6916009)(36756003)(6512007)(8936002)(83380400001)(8676002)(44832011)(5660300002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xMhzR45qBZ2KpJCylPica8o6TqFdvcicavEd/ErJ8bEj4Ih+KhIUgVuNpQlR?=
 =?us-ascii?Q?tN2g7FdHpz7TazRURo9l7GT3P+wLT32WKJmL7cXmZItmjSWXV1JhK9/45tzw?=
 =?us-ascii?Q?Uj6rxRBMllIpMkZW01ZlhgtrInXJlGWhI124BfemhPjR3CEyM42IOPqzJJCr?=
 =?us-ascii?Q?ifNiyWRxsv4PDlRxUUDsEI9j3ps0DHBZ4M6TZ2ct/VPsxqvNPkQRsw2A78I/?=
 =?us-ascii?Q?uW6T8MK/oIJ/FUZ+okA+IRomBt2GczRgsb/pZXsYvfvNgGEzqGkaobPD/Lgp?=
 =?us-ascii?Q?EQauRyRjWjzN2+myeY0XGiBZBWlhp/zyNtKrtgkct7EljxsQeRA2hq7AnxCL?=
 =?us-ascii?Q?QOLPR14VZZmquBAf7Sshnit964QP/U4YDcxN24sMZ8SjJnE9Z+5RBbt1r0l8?=
 =?us-ascii?Q?/KpyDtVCUPv8xkdHIEcD4DpRWT52v/D3/8bBQVwxUPLI090GXXewlYoeN0iK?=
 =?us-ascii?Q?uJ/OUkSnQbmdVZRKiYCe6qv2WrHLybQYVhnSTKzMqHZ2BPiVuWWYNR7PGaDX?=
 =?us-ascii?Q?h9RUImB0MeoHUtE1aUWuAId0yHtcT5vP9SMeTHMInvdahFtISQ5WRY4MBRPU?=
 =?us-ascii?Q?mhHRAvUXChOacpCmTFLnfcEAdo+Xbu7oYEx4WHJze/R1z2M0Oheq2Ay4umS9?=
 =?us-ascii?Q?H6gWgn5L+9o88DGr2aBnsrIuBS82mY6+WGyxfWke2cbtIpFsb2XVncVHvvKo?=
 =?us-ascii?Q?34oNe/StjP/+Q9PQBjIceL9yA4feILju7Y6yhO1lDJqqMiF0xjbkNAnJ+HCn?=
 =?us-ascii?Q?KBfAKyjoagwwsB7AlbYU7/nziSj37l1FNncIsEvIQtIQ0pRJ6iYhsSwK5QvB?=
 =?us-ascii?Q?usMpou1KknvJKTfTyrnPZ1VyaUvlttEq8qXWNro7kbYDWYqLi5B0KoCK+tTL?=
 =?us-ascii?Q?nVIgkOdmUCvViCRv/oPSS6/wfuYgEOTh98xFpL5c6NxcZEhAmK4deWlHfuLR?=
 =?us-ascii?Q?TojPgiuvGz8PSUWqKlJN5CgVMuqBHkICz6e1PFMVcn0Z6GWBwLLzIAU1FfWR?=
 =?us-ascii?Q?d+W8ffQB7bSc5OBa98ztRAgDu50aD5e7sGAdbjD989b406XxjvpiPxntSccK?=
 =?us-ascii?Q?JtSmmmnRbFEfBnL/PPwzxTdvdqfuJ7kDDLdxRYiDPndTSY/Z0jzNC3Vf5B0k?=
 =?us-ascii?Q?6lUcwbbtpW6eiulIDLThIZltD7SK1QmUL8YVzBr6sCud1/6xYIfHg9qxxYlA?=
 =?us-ascii?Q?O38Uh9+p3ryxsKoLWfy/kSYHOcdq5Pv81aWTd/fRleD7C1OPBDJu23rmRG6P?=
 =?us-ascii?Q?1oQ8GjvSAsz5VmH+vPdVciAdcxmqD/B1UbH2s9/2LjVTWpTr+pniopjI5VbH?=
 =?us-ascii?Q?yLgpcpte+2UdS4jhiDgmAfOtDsiKRPVqT4dIlCOPucHQybZoPRGFeiEyM4LP?=
 =?us-ascii?Q?JoU+GIbJtubxlu1eYQ5JfQoEnyAmCamxmosP4f800xwevn5WWZ/cuE3215hw?=
 =?us-ascii?Q?MFahRWWmrJ7kTQTSIPNZKWptYM/WV5/04nrWg0xQV1dTwZRRRyxxgr2YHfMy?=
 =?us-ascii?Q?JrvwIfSfAdYLdjgOC71utBGk6u8rtK4Ce/Xh+XX8b+O8LVWy/qCm41k8H3TY?=
 =?us-ascii?Q?Hkq8jRu0NE3lR30LFO+1dx0yhzkdCTMqPM/o163r3D6wDm4Tqkte0jtsUpud?=
 =?us-ascii?Q?ME3+VAxzkOw8DkQuFiQqZm/GxpRxYyTeexEP6U6dXVr7/l9uFlU/SzaTKP+L?=
 =?us-ascii?Q?1aFXGS577TtszFozeR85BxQfTAeDJexQFoCyMIDkQRunIEw3OO3JQeG123Tb?=
 =?us-ascii?Q?ilwWJuR2XH3kMLIL0Z0kNEouwBbUVfQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9DFC66E19DA31C4480653EDFDBCF29C6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579da10a-cadc-4092-c1cc-08d9b4e1defc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 15:47:24.9860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXHGzk9Xa89jgIMMacFwqWUntfYi+avzhFPm+GdNDh8Cw58qnGDflaQW64IHXsQhomHKSbG11bk5xCInUxV+CfKjvhVfhwPB5ezcGTgac14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2685
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010087
X-Proofpoint-ORIG-GUID: p7WgAVovFdBa-AAq6ZP9g757f07LJ2nV
X-Proofpoint-GUID: p7WgAVovFdBa-AAq6ZP9g757f07LJ2nV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No problem, it makes my life easier for V2. :-)

Thanks!!

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

