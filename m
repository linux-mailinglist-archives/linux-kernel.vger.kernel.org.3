Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26DE4652BE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350612AbhLAQbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:31:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50804 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239044AbhLAQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:31:40 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Fu5tR032508;
        Wed, 1 Dec 2021 16:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vkTJshEWl6uzttOVRRfzjFeuZY/hk1Z8w4haPLUzDSg=;
 b=G5e0pybPnN+DxWzDHEVQNRmfwUMui0plt+6i8uAMZJmF8jViecWRAwGU3WwR27QxMae9
 cPBVk32eg/A+LprskxH+8N8rhv8Y0FFanoa0efVxzOTLXvEDSdmnolKyfD7eeDYJ5vzL
 ioaVxW6URNPYyu0kEqEjYmRcDMqdn8ibOXp0iBcKk3Q/Emb3yCdwz45Aeu2KfJoFPimE
 ttbbRkQr++3+FGgqSz/ifqp0QovT2eAt85UbL9xapX4PGw3jqovEYu8vVo9DU5pIFkVT
 R2I+0nOQoEbRIYHYXnr9/eBKAR51uAmdBinVPuxR5FBMLt4cPmrRN9eFmf0yRcmepOhg 8Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cpb700qvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 16:27:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1GQLlZ058467;
        Wed, 1 Dec 2021 16:27:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3020.oracle.com with ESMTP id 3cke4s1vku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 16:27:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqcCIL+k+6WyxVNaGeg8NtHiFVKd2wgftN7P415ZKfJ58BmJ7gVwUKn1RIp/UlwkzHvBU4CNtnI+2q31RPt0b/26o3LI7kuZy324W6JRFXX73XdgporARgW+OhJ4jenAek4m5hymiKMyjxivLoM8+zwEiZo6MhDAK/ZE5nkv2QkmvVdx7rz/lCxuDi5n+bgBQldwhMj48jnmR2gDoxjKclGfENyltwNMqgI0T3z+OE+upqPZU6KGy9qAI9KMgWJbrNd/b/bg9Gonzs2EQ4K+wHTjsf/7CWr3uMYExdkSIqO3pr1q/w5YcEfWsay2IxLR2J/dcTwzBqgLk/54XmjmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkTJshEWl6uzttOVRRfzjFeuZY/hk1Z8w4haPLUzDSg=;
 b=WJSXsoYawUPPMYQFa7KbKV3v3UTojgaaL7YazzujnhvM4knE+bgg/PJt97g6wFO1FBX6njsKh41UW+SIwoy6EQCayAORpGW6uS6rnoEnfv2OeZBvQaJOMFWQoKrx/0U5s3hcoqn8eAj/B0nYrgt0XWoeZruqkUb82vU4D+Y6F2/ORLEWL1OjDerjlSIfIV170aySpd7Q1zVgQcOaRGNedyqt3eAmRrKe41TTo7zRAKphb8AlzpXF5DSWGn0evV/uSdKM53SUlBDoC7e2tPvWNQyFNs5uwlOS69bPGq/fuTh1WsYlsWZyzmNPDJFpk62afEIY3cAQ482y+5Xif7WQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkTJshEWl6uzttOVRRfzjFeuZY/hk1Z8w4haPLUzDSg=;
 b=qdCcvFniHrpbb6r3w0004JzO3J6QMjs2yxEnkop/Y9H94PsfvuQNkqG0gf3ZFaPbS5dY0U+fOYtRYUT9Rj2Xq20soLYWc81KisP8k+Iz7fiM3RR1rNpkKLc+GuEU9LDCl6y3lB5HCpAVwK5G7qVVFoZ3UKt+jD12U8Xt7dRh8fk=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by SA2PR10MB4505.namprd10.prod.outlook.com (2603:10b6:806:112::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 16:27:54 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074%5]) with mapi id 15.20.4755.015; Wed, 1 Dec 2021
 16:27:54 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] cgroup: Trace event cgroup id fields should be u64
Thread-Topic: [PATCH V2] cgroup: Trace event cgroup id fields should be u64
Thread-Index: AQHX5s2YxdUpzfcaREipjfnrRXsbY6wdz5GAgAADm4A=
Date:   Wed, 1 Dec 2021 16:27:54 +0000
Message-ID: <AF25430B-AE4E-443B-A231-3C93C6CD2901@oracle.com>
References: <20211201160746.726158-1-william.kucharski@oracle.com>
 <20211201111459.4ac7f84c@gandalf.local.home>
In-Reply-To: <20211201111459.4ac7f84c@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.62)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 510b0d5e-3b79-4530-5abd-08d9b4e786e0
x-ms-traffictypediagnostic: SA2PR10MB4505:
x-microsoft-antispam-prvs: <SA2PR10MB45050E3836A5D403ECDE0F5D81689@SA2PR10MB4505.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UQclzB0SNf0gQ3aqhFvGbrcAZ6KMmMXLRdKI4rD7FMbAKtDyZ6kBZKodHYvLCIC0VtMruWkHUQad9CCeCNEzdkgbz0V0LlImruKscbvnM6QuLYJZJnecvoEsKHsDf44lKW7gPq3r2kJfI5bKcCrCjiP94eOu5xaErOonUWPsKuDgE2WL8bZKscWOfBm988+U2GN9AlIZcydpOCnTtLWXjtcvjwX2vU6EynTsd+JihaiIJAk784h7KWgMyUnPHrc7odm56ybTbl1YTs0Z9CmnAiAtnZNtWU+btpnlu73oJyi0Ob22gdzAEESK/kVVpDUlHjX9UNW4PATgewv+VoJRlKG/B/s0eHbAC8f6VaO1X/VSmydUyjjg1OEn1rREyDO61rUJaQWU+WK75JFOir0PNxKF68+Sm0Y5eJ0iLG9AlaHs8Aim9lIRk1nyLI6G7lcNWaVzAq8h16FWIuy7owkLvfChWVub7FozBxUsZ1zl4RTsCp98rR2OaN3nxslzYt22fiNpcVfqahBdUu7kRv+T9j9VvSR7wtqb6a7gO43rE1tlNYf2uEprjvbZSm2kmeNcLMObTABpGQmsENc8a2vJbUJxrvvX2/KjDnGxEkY3pzFpGUV/weH9h/By2HukXVeZuo+pzhEkOVeOUPAfET1+5ruRxx1iIIVkeV8/+07TVZ44B3pood3MbwHmbsz6HYy2QLzcgUa+LjFnQmCENobJqtDva13/a6LqCVs4cMmAdfs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(38070700005)(508600001)(44832011)(66556008)(64756008)(4326008)(36756003)(6506007)(86362001)(33656002)(2906002)(54906003)(66446008)(316002)(186003)(66946007)(66476007)(2616005)(91956017)(83380400001)(6916009)(6512007)(8676002)(122000001)(6486002)(71200400001)(76116006)(38100700002)(53546011)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RB+pGKTC8JeojoRtxvtYHFFA/28Lu7ZR4/uknRkjzjm7dlBFA1VCRlAm9IQV?=
 =?us-ascii?Q?JGwZJOKoHp81aU15nZk/mUWQlVPWSaFdIPfIA3MW6vqcv4J1hFGwrbPG7sng?=
 =?us-ascii?Q?0brVf22VhdZiRwLb1fJ9uHRvqE5WgBgR4Jb2lKMrVqa9Ibcfim6vogc2ZzFR?=
 =?us-ascii?Q?1J8vAbGKYv494+pWwmIxkm57KPRUGmO5g98S5opO3q5A6upHoyZrt2+jsxbc?=
 =?us-ascii?Q?Oix6UdxCf+Iw2iiK5PWLi3jg1w6tFbbutFQ5YhDEWP5rrrSaqi5GEbCgofOX?=
 =?us-ascii?Q?4HvwCzePwaYCGiU5mzpBLemHr8xK0WjUaqqXcnAZj/L6NL+gzgdw0S+p2uX6?=
 =?us-ascii?Q?yzM8gm33peCAHxzfnI3SlejxGNuu2XrnYLmHuq44VIm8KQnj4dg58ukRdz2w?=
 =?us-ascii?Q?0uHEGykBUmmvFfA1AM8l6aVLekM+EwCtCiaWG8le+ZCVqJUIPoezY2qwOXgL?=
 =?us-ascii?Q?0qol4RB+qJ1iviBYlhg8xocbUUbtm/dULmNDwVZzf1Fyp5vBzs2ADhArrx+C?=
 =?us-ascii?Q?eqLZnNGZxRqnQP0PS8K8BfLmp/dEY2y6abx9RLJAIoyg7cXSoX8pZpvLKBNQ?=
 =?us-ascii?Q?pmJoPzb8wpFAI7ciemCvssPqB1w88cnuXAIIqKbCC8C/Khw705dpI3DQRBdN?=
 =?us-ascii?Q?qSiyWzmL12/qcJT9StOeBGVg/U5qE6NZrcshRga0nb8eWuH8YP1Ix/dPu5+l?=
 =?us-ascii?Q?NFNom46cVZchbDgm7jdo/JCRvXaHhDBPvqHBfYm+nsyN+w/AU5BgRZTiHx40?=
 =?us-ascii?Q?zzqrc3JARw7n3Jzvt+1fdWneZhmnCCXsLeiME6MXz7G2alJEcekr22Fq4Amo?=
 =?us-ascii?Q?fsYIUbJ9pcPAmi86aARA1hE/4XBB5I/E7kAEbb7lzwi/t9UP0iv+3S1WLtVe?=
 =?us-ascii?Q?ONyQ/eHiBLiXN6NcabQ7wsN2QEhtBUE65OAhDZPGXD4yr9XOywIuBBeWYsUQ?=
 =?us-ascii?Q?md8zEolch5dUI5xqoDRkEz9EkW+cfu871yb59LuWgBtpLEmljXkNsLVxCn5M?=
 =?us-ascii?Q?WtDePigNNZMLo6m0FERxUKqdWsF9xBDQxW0qsQLTO/QEIHHnsnG5bKtEWE/t?=
 =?us-ascii?Q?MDapke378MEJwjwykYX28ji0Xdo6PrVaHMQZw0X7Xp2rDHp9L0YslDr9cbtt?=
 =?us-ascii?Q?84ZnXF9SHOMkaU2tCTCAggHU7UbzWo1v3YzyUYE4gemjYEGnwoc4GTJxYM1d?=
 =?us-ascii?Q?yjAh8piAiMp8CCIZCuvxt8zpBA5DUHb7qiGXDF6NWVQpdR2Xcyp2KvLp9gai?=
 =?us-ascii?Q?KsQF9sjf3wKxN3IBdFIoN29dJoCc9hi6DEHLH9wUivTr1OqGxMMWK+XUr/sH?=
 =?us-ascii?Q?MoOcbTlK6wTYxM+T8C5rrV+KODeU4U3jyy0Ej2Ntw1ydmFCBTK3R4sUBnbf1?=
 =?us-ascii?Q?/uhvqUoI1TpjSe23Lc+h5OfHnaiUbJ6X7OPHbl+tPxFWr3Coz7ob6/anyBjf?=
 =?us-ascii?Q?hEw346gKcBUEqC/prGneciMaU4HmMgg/VTV8rAD0e2yPCXT4gE2VtrR4FxYR?=
 =?us-ascii?Q?j+/b1OpYOE9Rnz+h5vepbedTszVKwNOcLFRZafbtHU82bWa+dyZkoSZKMvN4?=
 =?us-ascii?Q?hoiF31I84v65U/VxtsPDjMVLyJseOeuo+n2lVqUEkSg50NWYb5coeW1mzawu?=
 =?us-ascii?Q?y0X1kFrN2QSisxt28e8QvO+52+q7GMCYvfCU3RkbnCqtryy06Kp4cWgAnYFR?=
 =?us-ascii?Q?Y9StL37FqL/ixKsQ1UW9ZSqtxWbq2V02q0bC4VkPEXheWP6J9KQ+4EXAAw9n?=
 =?us-ascii?Q?0A5RPMDWp8pBjoYORg1w2BZI2gQXTms=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98AD09789B4FDD4EA2C0D0D21EFEB643@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510b0d5e-3b79-4530-5abd-08d9b4e786e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 16:27:54.2045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yq21qpFRfwVL6F9EVrjlTvkg4YtncYbxVNCBVZvWqgrWlIvCTUexZMd0Ehl0f9uI5PfRFowUzlqoWtvuxTXk1wJUd1F6b4+o30lgEBdDky4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4505
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010090
X-Proofpoint-ORIG-GUID: wba5kv7MwrJFc7oQ1t_XVeMcUY6V_EVq
X-Proofpoint-GUID: wba5kv7MwrJFc7oQ1t_XVeMcUY6V_EVq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had pondered that as a consequence for two of the three uses but wasn't s=
ure
if it was worth reordering things; I can easily do so.

What do you suggest for cgroup_migrate as that will have a hole either way
as it's:

        TP_STRUCT__entry(
                __field(        int,            dst_root                )
                __field(        u64,            dst_id                  )
                __field(        int,            dst_level               )
                __field(        int,            pid                     )
                __string(       dst_path,       path                    )
                __string(       comm,           task->comm              )
        ),

if I put dst_level above dst_id, the int for pid field will leave a hole
anyway because the string pointer for dst_path will want to be 64-bit
aligned.

Thanks in advance.

> On Dec 1, 2021, at 9:14 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Wed,  1 Dec 2021 09:07:46 -0700
> William Kucharski <william.kucharski@oracle.com> wrote:
>=20
>> Various trace event fields that store cgroup IDs were declared as
>> ints, but cgroup_id(() returns a u64 and the structures and associated
>> TP_printk() calls were not updated to reflect this.
>>=20
>> Fixes: 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID")
>> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
>> ---
>> V2: Do not remove spaces from macro arguments
>>=20
>> include/trace/events/cgroup.h | 12 ++++++------
>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup=
.h
>> index 7f42a3de59e6..1b68c842ac46 100644
>> --- a/include/trace/events/cgroup.h
>> +++ b/include/trace/events/cgroup.h
>> @@ -59,7 +59,7 @@ DECLARE_EVENT_CLASS(cgroup,
>>=20
>> 	TP_STRUCT__entry(
>> 		__field(	int,		root			)
>> -		__field(	int,		id			)
>> +		__field(	u64,		id			)
>> 		__field(	int,		level			)
>=20
> It's best to move them around to prevent holes. This is not a packed
> structure, and the above will create a structure on the ring buffer that
> looks like:
>=20
> 	int		root;
> 	u64		id;
> 	int		level;
> 	short		path_offset;
> 	short		path_size;
>=20
> (the string() macro is a 4 byte word where the half is the offset of the
> actual string and the other half is the size of the string).
>=20
> Having a 8 byte word between two 4 byte words, will add a 4 byte padding
> after the first 4 byte word (before the 8 byte word), and waste space on
> the ring buffer.
>=20
> Better to move it around to be:
>=20
>  	TP_STRUCT__entry(
>  		__field(	int,		root			)
>  		__field(	int,		level			)
> 		__field(	u64,		id			)
>=20
> That way the two 4 byte words will be together followed directly by the 8
> byte word.
>=20
>> 		__string(	path,		path			)
>> 	),
>> @@ -71,7 +71,7 @@ DECLARE_EVENT_CLASS(cgroup,
>> 		__assign_str(path, path);
>> 	),
>>=20
>> -	TP_printk("root=3D%d id=3D%d level=3D%d path=3D%s",
>> +	TP_printk("root=3D%d id=3D%llu level=3D%d path=3D%s",
>> 		  __entry->root, __entry->id, __entry->level, __get_str(path))
>> );
>>=20
>> @@ -126,7 +126,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
>>=20
>> 	TP_STRUCT__entry(
>> 		__field(	int,		dst_root		)
>> -		__field(	int,		dst_id			)
>> +		__field(	u64,		dst_id			)
>=20
> Same here. Just move dst_level above dst_id.
>=20
>> 		__field(	int,		dst_level		)
>> 		__field(	int,		pid			)
>> 		__string(	dst_path,	path			)
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
>> @@ -171,7 +171,7 @@ DECLARE_EVENT_CLASS(cgroup_event,
>>=20
>> 	TP_STRUCT__entry(
>> 		__field(	int,		root			)
>> -		__field(	int,		id			)
>> +		__field(	u64,		id			)
>=20
> And here.
>=20
>> 		__field(	int,		level			)
>> 		__string(	path,		path			)
>> 		__field(	int,		val			)
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
>=20
>=20
> -- Steve

