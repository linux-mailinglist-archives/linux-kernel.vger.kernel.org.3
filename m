Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA34A4BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380241AbiAaQTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:19:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51780 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232764AbiAaQTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:19:13 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VFx245031412;
        Mon, 31 Jan 2022 16:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0S7NmP559TjH2zJoJp5nY3usO47xG71O1hNm6FZhq9U=;
 b=Oie1/wyYljXBZWpHCCerqp49T7Ublau4+E4PW+ovVocQaOAH9SjA5EAdDvm32t0xUUm/
 JLzFb7gcYRSD06ULNxFcAf/NClmUoZWXIwQQxRrV3CfTum3cInfBXyosAS9BAT9A7we7
 jm6jsitJLXOe6zTYM0sPyz7d1eiv7eluuKJfpkiPHLW1R5euIDQMrpycY+CfwhXz2NSt
 pbEk74ufRL+YCpXzz3r60Yw/rVveUpP/v9Pq4At49AxjGa8JcrDnjZoS2kjKViMI0hHc
 Tmi1jMD47/U6P5qcoUEp/RN1gFqhwGakRrpcBeChTQYjqn40lS5kD0hJmu4i/FOZZbH8 Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9v870e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 16:17:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VGBb2q115147;
        Mon, 31 Jan 2022 16:17:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3030.oracle.com with ESMTP id 3dvumdt8g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 16:17:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+qDkagV8xhn6+wpddRA+zAinVzax5nB7mvXV039bK9zkGl+B+JtrAX8mPzmhJC/SqJl7gFYGi89EOrw14MeMjq7tcutNrtc4+KNmSX+NjvErvQHtpFFWN+ZoD9s7EfXUeLW6nZ2L3HWPkDPlS2xZayR22ftZzMq2YTTmsEjV64ieCx7ljGQAh9dTxqbQ+BqE5TRHMupC+BhDm2FSU5Caha6Ge24iq8GAK41aSA8194R39ktMJmF23tAlLbrWsGTI+i62UWAOfJDVq+0gXV/vHvAb6TxuVuYJNFQiDxqVe1wXH2rQs9n8fLsByshOgeN1hurm46kL5w0zfi70Qbcew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0S7NmP559TjH2zJoJp5nY3usO47xG71O1hNm6FZhq9U=;
 b=hXIA9Dtalfwlrfo8X6lqcL/q9HWhuRocDilEtyKsN1/P7tCFA2gwNtbtED7KGU01cX9o4H6VLZ9cSIyB9EthEb6Og9l9oVXcrbk/ukHrR4owOLVZ/l1RDd/HjVziZWZdx3Pw5CzFBXjDvodsv78o6sOf5UhL48aaqyvbWoKV1l8EdwxpFfe7xeJmDysxnaNGUWfF4oEOf0/ceYd9abBqYzS98YkjvFV5gOSsj6Y6rAK5ZHU4dz4I1ujCEqRLLvsnJVP1l6wyJaJi4tzoAZ1DHHAh376cr0/J6oGTvsyPOf1HOUqFnC8uWxyhiOD1q37Jaw3umjHxHXBiJeWNarp3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S7NmP559TjH2zJoJp5nY3usO47xG71O1hNm6FZhq9U=;
 b=syNuyAPCe/v9VKz+NE4akPsr5kUdOvZ1xJiV9C/OZ7yoP4KW/dki74BBRZr16I9SMn4HB8aAf2evdsf6H+E0F5zqQo2Jkoiq1yBBW8AkzEuwWQRGhou5MIBzTFhiA0yx07e58Goer1KAvV7OK+i+Div3W3f6fj5mJhZqmzGdHfs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 16:17:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 16:17:43 +0000
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
Subject: Re: [PATCH v2 03/35] mmap locking API: name the return values
Thread-Topic: [PATCH v2 03/35] mmap locking API: name the return values
Thread-Index: AQHYFEhlS0G23Foc5UywdAOJNFKkp6x9U46A
Date:   Mon, 31 Jan 2022 16:17:43 +0000
Message-ID: <20220131161737.cclyx2ntil3opted@revolver>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220128131006.67712-4-michel@lespinasse.org>
In-Reply-To: <20220128131006.67712-4-michel@lespinasse.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aeaf5a03-2b89-4089-1e8c-08d9e4d535ec
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_
x-microsoft-antispam-prvs: <PH0PR10MB461527FA49360E8F472D1E16FD259@PH0PR10MB4615.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HfP6ndBKHDAdpvgXdk3Xz3xyiBw/O+FKhwITFcJcmCAV4AM5q2RdGwlJVy3p9api91kNB4bm4erLRBsW/Uqg5eYaW1edpSFQqF3R5e0iPqJ4eM0LnNu2G1NLgKlH5TC/+TgNVlaYQ+ZpK2xa7fVZJUW4zMtJzN64VcuiRM676Y3rcsJka5KgQ0kJpkgXacMc98OZSf2TyBuoJe6+th9jjo0LiR4et//tIOJJ12TzR6DVJ3lRZcpR+lkFBXIj6/VZhV/I+VIhkWFGGsBfwNXbDbcByWNDUrF4FmULGCbwC+xmCVdTwHdsI3oqqNlvrG0YHm9rM6gyo1PRVH7YumeiRMXrjAPLVnz0FzTvwy6WvrCSyea+MK7R2D01o4MPAH4cnI3UWJC+odbIJ8wCvFbeFRlDrkNqPar5ptFchQbhW1RYeqB2S6lsvhJPnl4uQVnwBJx8YYG7CaCIy72mnBi7zd1epzIdTkVnFPcEhsX1OtCd2blXnsB3lxjUrpbrdoZqprbACVSW/io5OqmjFPqys5m4KVRbiYj4yTSlcfd1BbrrVQPdldJwC18p6TKzpUgCRyJtCmg/5ouzvj+WpKVa38kh5l2i+2pIx3Jtz0If5yKEjCc4xISQrrsEe6cnpVonjam/UxGqxOJML/owKWE/2+QHYKS9CtfN3f1NyxPG9ta+hfc8QAJ2aImosVLPvIvhAnPsFoJZrpQ4vscZn0fS4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(66556008)(122000001)(66476007)(91956017)(6486002)(38070700005)(316002)(86362001)(4326008)(8676002)(64756008)(66946007)(66446008)(33716001)(8936002)(76116006)(54906003)(6916009)(508600001)(71200400001)(6512007)(9686003)(6506007)(1076003)(186003)(26005)(7416002)(5660300002)(44832011)(2906002)(83380400001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L28n83qYkFVKll8PmI3khTQe+dJ/dqfcxj0rLq6UpQi5ltBy+w4Zon5CkeuO?=
 =?us-ascii?Q?OkXSrv4W9SymfRDXL2i39Qk7+KzwJMbBl27bs5AcXOISU5H8e1Bkxv31fryj?=
 =?us-ascii?Q?xhWv1Q9j/CEJoG/XHHV5VTUmtjTZg6RDo07SRHVjfyubADfxdlwriwKg1SvG?=
 =?us-ascii?Q?ZZYYcudf7oW39g0uP30CuflmW0dtrc7GzlHRPcaDvfNMPp4YIkG3WOoD2cvS?=
 =?us-ascii?Q?izRSrzdkSjXcGzGdVozywj1TqXHfflkr/H6AVnrpy/ObCPx45Vx42dUAT6tp?=
 =?us-ascii?Q?RZaaLU7eDqz40Qz+i1idt0/TRFYArTCmQKwaWvunN1yZMzVkhsc7hd/8P9eP?=
 =?us-ascii?Q?lPwucqim9Tr/WtmBzf9mDNNOFEAEc+YFQWPuwVCUrxkOP7VYoHmybe5eChC0?=
 =?us-ascii?Q?fEyG6gkEa/JD2tigw8Ysa4e4P3jvrCUk9JNqONn9alnRVEIujAmvXrJUONi7?=
 =?us-ascii?Q?3fT33P+9gqJXLUKwUHo0x20dCZYi7ifRjk9MQtm1ucK9dGPQVfnUldWkW+m9?=
 =?us-ascii?Q?2XwXddSq4lZ1INsIizw+q2x1sN1G2g8xhRrTlCnz8RQa07vPO/NcDMWRuqSC?=
 =?us-ascii?Q?n4SLWyjbPISXHknIUJX28iolfUWIvrxgX03kvRUHzCY8zTOUeek+Hx/h93pi?=
 =?us-ascii?Q?Emz0EkGW43MbUcsvxvWh0cdRh7OYIiLJ+agBySL7mj95en9i/C/hWgA+LTZK?=
 =?us-ascii?Q?+mkFEl/4I7dY8uAt15qqL9INpnGScdu2Ooi4YF9YfKl1RuMXs0ZqAa/LTeXl?=
 =?us-ascii?Q?1+rMblBs4PMzZds2ppAOLFciTdSgoJ7kB4lAiq78JEakCxrEjTtsixhOsR/x?=
 =?us-ascii?Q?U0MjmENzRdqPnMIeBDxycv6pThHQ1cHYeiJlsQ0qVDuxwF0lz8eypoiya7NX?=
 =?us-ascii?Q?FxPTtHTNUo9sabVsI+ZfHRyW5w2bZJQFeWxMGpDz/K7xlenemrrby14B+uZv?=
 =?us-ascii?Q?CkFm8fHz28CPOH+xMJYl7BAfbzkMgNP+mMEvF7b7METifjP1xzF+5DOiWdiI?=
 =?us-ascii?Q?0KLF/woF+5Ew0DMb3Hr4gJ8a3IITCq2d+O1KRySC2k//RBSURZnmPULNW0F9?=
 =?us-ascii?Q?oYdZHDGEYXa1KYK3g/vTaGEz/O4HlGaXdkVVNUd3pOxsdWqoiI7JQPKPqILk?=
 =?us-ascii?Q?9alo41KYCJzuHmvb5CwZXZaKXgwPqek6DVQhsgxS6oc3ZYVeAnq7qRW9ExO5?=
 =?us-ascii?Q?eOs1HX7qlITQpvJ5M3YTmVt0J0PWkl0uIECIDFX8yOvCqlc0ktdDlN2kEOfd?=
 =?us-ascii?Q?kT0coHKLau/iXQfsW05zz9w90v1Slbz/CpBf8CqM7N42q6biq8X2f/6pgblf?=
 =?us-ascii?Q?HeZIw1hHr8RWFwhDKIAWsqSxNJyONDrowG/eN66kvi3mOMskTjCAtHjyqh20?=
 =?us-ascii?Q?eEKLWFeD8Yy0ISj4RD22Vdd7e6G2VdfOsb1vXtuRAxJgFCovmkqTOs5kKWi3?=
 =?us-ascii?Q?a0XIq5AYx6A8r8CrMmlhEL1ELsuZ3s3yG3AQED0t/nrvLvDz33w9zJytZLIK?=
 =?us-ascii?Q?HmDsK427/U6v0Kjc7WDCp0I9QlezkLZ115kr5QJfDftNV5bxOqgK1sHQWJ9P?=
 =?us-ascii?Q?vs3oju1mIntkXNIjjeOH6FK3mcLDXcdPbd3WTPa388Y+SpV7fEgMD11R8Q81?=
 =?us-ascii?Q?zEW6XQLZ/7Mag6rg4VK45NY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <699B7732D962904FACF071F0C3045786@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaf5a03-2b89-4089-1e8c-08d9e4d535ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 16:17:43.2844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XAtWibhFjhpFmf50CDg99JRH5YQQf/4buIrCZb3TQ25RXMxXlRICgM+M9LXHF8aNJdBHm+ss6jtUjbEKlizmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4615
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=908 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201310106
X-Proofpoint-ORIG-GUID: BZshXYOJbcftEV9ZH-grOFpGXlwtSuYO
X-Proofpoint-GUID: BZshXYOJbcftEV9ZH-grOFpGXlwtSuYO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michel Lespinasse <michel@lespinasse.org> [220128 08:10]:
> In the mmap locking API, the *_killable() functions return an error
> (or 0 on success), and the *_trylock() functions return a boolean
> (true on success).
>=20
> Rename the return values "int error" and "bool ok", respectively,
> rather than using "ret" for both cases which I find less readable.

Would it be better to add function documentation in regards to return
types?  I think changing the variables does help, but putting a block
with Return: <what's above> would work best.

>=20
> Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
> ---
>  include/linux/mmap_lock.h | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index db9785e11274..1b14468183d7 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -81,22 +81,22 @@ static inline void mmap_write_lock_nested(struct mm_s=
truct *mm, int subclass)
> =20
>  static inline int mmap_write_lock_killable(struct mm_struct *mm)
>  {
> -	int ret;
> +	int error;
> =20
>  	__mmap_lock_trace_start_locking(mm, true);
> -	ret =3D down_write_killable(&mm->mmap_lock);
> -	__mmap_lock_trace_acquire_returned(mm, true, ret =3D=3D 0);
> -	return ret;
> +	error =3D down_write_killable(&mm->mmap_lock);
> +	__mmap_lock_trace_acquire_returned(mm, true, !error);
> +	return error;
>  }
> =20
>  static inline bool mmap_write_trylock(struct mm_struct *mm)
>  {
> -	bool ret;
> +	bool ok;
> =20
>  	__mmap_lock_trace_start_locking(mm, true);
> -	ret =3D down_write_trylock(&mm->mmap_lock) !=3D 0;
> -	__mmap_lock_trace_acquire_returned(mm, true, ret);
> -	return ret;
> +	ok =3D down_write_trylock(&mm->mmap_lock) !=3D 0;
> +	__mmap_lock_trace_acquire_returned(mm, true, ok);
> +	return ok;
>  }
> =20
>  static inline void mmap_write_unlock(struct mm_struct *mm)
> @@ -120,22 +120,22 @@ static inline void mmap_read_lock(struct mm_struct =
*mm)
> =20
>  static inline int mmap_read_lock_killable(struct mm_struct *mm)
>  {
> -	int ret;
> +	int error;
> =20
>  	__mmap_lock_trace_start_locking(mm, false);
> -	ret =3D down_read_killable(&mm->mmap_lock);
> -	__mmap_lock_trace_acquire_returned(mm, false, ret =3D=3D 0);
> -	return ret;
> +	error =3D down_read_killable(&mm->mmap_lock);
> +	__mmap_lock_trace_acquire_returned(mm, false, !error);
> +	return error;
>  }
> =20
>  static inline bool mmap_read_trylock(struct mm_struct *mm)
>  {
> -	bool ret;
> +	bool ok;
> =20
>  	__mmap_lock_trace_start_locking(mm, false);
> -	ret =3D down_read_trylock(&mm->mmap_lock) !=3D 0;
> -	__mmap_lock_trace_acquire_returned(mm, false, ret);
> -	return ret;
> +	ok =3D down_read_trylock(&mm->mmap_lock) !=3D 0;
> +	__mmap_lock_trace_acquire_returned(mm, false, ok);
> +	return ok;
>  }
> =20
>  static inline void mmap_read_unlock(struct mm_struct *mm)
> --=20
> 2.20.1
> =
