Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D615C468FC7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbhLFDun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:50:43 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17834 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233069AbhLFDum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:50:42 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B5Ho64e010201;
        Sun, 5 Dec 2021 19:47:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=KwtBA2B1Er/UFNlu1S+54jzcRBwwsSqPqW+ouSJusgA=;
 b=XziB39w3LWSuOfRLi7ZsW8xjIeeYZU7YYMw3C+FaeZeYwAxWidJzl/tWuHACWqu9HO4F
 HHuu2SvEAHmeums7KXoFQ7P3cCGCd5ktq4gwMOC13EhNEZ2g0WKaMUCZy10IfVLbdQtg
 g827HLn+JTZJYX1cLinmmJvfhVfQcQ0P2WU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3crs873nd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 05 Dec 2021 19:47:13 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 5 Dec 2021 19:47:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ozx1igFyQt1PrmQkWzWMQxzQVV/svBBEMKRcCb6gd2tbkSdM+EtMJBvcFZ93lgNGZxqrhq3lhM5i78CroaAVBog6WmCbeu9iKVWJpcwZTaOl+nLVDsDZZRfC95hXO9IszRvQ45stqNbvGI2iUlxGT5t4W+4299eThbb07R1fhkz+CtX+nSotLJoTnng0nmPBhsyjTYRM3sro5NMLjD2t4OTP1rHx8gsTqOkXuOwJPuLK4T3s5zrJQKji5BYY195ITSFckBRjkyUUYp3CyjyY1hbGicilY0pIZ17m8uwP4NL868A+WCfCCEgKUuV1NtKTx6UUqXL9crdDBjnTVNTfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwtBA2B1Er/UFNlu1S+54jzcRBwwsSqPqW+ouSJusgA=;
 b=lJGbTDY4MvE7jL/fUOPTwptDM7eEYLWzqhHdQLFXzGiqbIR3tTuoJSBFAA3pNe7NZihC6hSny9i84fqm3vfmQAFuVMFKAMc7jbcE6tRbl+flNGXugEQMC3WmDN2WKMm+UUdaEsyGkxLIOC6u/EhlxCW7nO4rU0BhJ0OFf4HkxMgvJY4Sf6qpj3vSs3VTRxhLWzZSF0vDOy1sCci2hNGFdHl1VkhPuo0lMTtULjaDMkIhA9jhJPz6o39YVYR7lADCYT6hyNnizlaQ3KFt0S8lDtfL3R97cIyOuF/6Ce5IQJ+P+SzeMjEm6PStN4AmlYw9Cip29wW8waobGB8OSTAo2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by PH0PR15MB5166.namprd15.prod.outlook.com (2603:10b6:510:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 03:47:09 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::3102:269:96e6:379c]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::3102:269:96e6:379c%9]) with mapi id 15.20.4755.019; Mon, 6 Dec 2021
 03:47:08 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Building perf with BUILD_BPF_SKEL=1 by default
Thread-Topic: Building perf with BUILD_BPF_SKEL=1 by default
Thread-Index: AQHX6EczClIG2E5d9UOz/2n0HlwT/KwhKHqAgAK43ACAAPX7AA==
Date:   Mon, 6 Dec 2021 03:47:08 +0000
Message-ID: <A8AD990A-BFC3-4194-ADDF-35BED3DF1219@fb.com>
References: <YaoXUrLUZt1scVb0@kernel.org>
 <CF175681-8101-43D1-ABDB-449E644BE986@fb.com> <Yay5Yjnj7LUodupy@kernel.org>
In-Reply-To: <Yay5Yjnj7LUodupy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8079282e-74a7-4f74-4792-08d9b86b1420
x-ms-traffictypediagnostic: PH0PR15MB5166:
x-microsoft-antispam-prvs: <PH0PR15MB5166B97B95289E1443A042DAB36D9@PH0PR15MB5166.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wy+YMXkqGf9Dk16Li+4+a2IXRbMg4QfT6vSOq/SSAlylsD7y1UHNUZXHSib3/PHlsSnM3zHGbZf6XEsErA2NUYS4abRZfjUV9V/xq5MN0/P6am0kRTUbT5bHawtzZyuzna6TQtmvnYyIY2NvkfyvoJci84d1r0ebqS+Bzg1EGeaAIWi6SD60NjHcBBhhOegx2phusleUwzGJUzpI2NwBahK6ZSzEt5EIlkGUWJ8euabUzbPDlAOUlNkY6th2jEg+yU3agKMhd261EcHXc3uwMx6+60OyDhVubnzkj612uGWOXb6gUatri8144zWKNLB5ob5DvgKqpM1tE+Ixl+UovOGty8HQR/SGHkT7AYsijN8iguU9BxunL3pxGlwiX0D/8ni3JpqY6XsI+ucREdOiYvFNBJCh1/3j0eg6GDojC8Oic4LlT4FMwapgzwi9BZcTZBAMzyiH+il0NOQx0hksfgUzEbmfi+CcET7gH1r/JmLA5GZHtHv1lZshaLVi5c+9JdKHZ7PrSSlvArJSlreiP1E4lVfY05jvIOd2GDb/oqDIGWjInQ8FECIXPyVdvfd4QLeaO+MTFh6I3w/5ULLd5zwuOwZvnmVjACJdBW2TjU4jM5rwFhsXB1Mi3Si0ge3Iv3e4CN7SgRqe6QQzO2y0lXepLGmQ/jxy9Ua/M0ykw5MpaqHBg21bEG8CRAAGQPS6V0tNkMxPxAstNG0ene05kenz9Xm+OSDF5pN172PtUU6NHFIcuO3FnLDqLdmTAM+K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(6916009)(186003)(122000001)(38100700002)(2906002)(6506007)(4326008)(36756003)(76116006)(33656002)(54906003)(71200400001)(53546011)(8676002)(6512007)(5660300002)(2616005)(38070700005)(8936002)(83380400001)(66446008)(86362001)(64756008)(66556008)(66476007)(316002)(26005)(6486002)(508600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8dEMFf/NFktc+M6tqB0x3Rf2TM4Bezbo3kjDddTa+UwLUgIiCbegjfLCpgVW?=
 =?us-ascii?Q?4mmrh3cgyT5RmEqsvmCHdgGHJqo1rf3kgIa8RyektJ9SXq/ta/gnhm97BGsl?=
 =?us-ascii?Q?S1+AvRUlygGhWHRReCQ4scMUZCXTBoqnj49PWt4KdZCSH0WR4d8VhOHfZA2G?=
 =?us-ascii?Q?LcZninb4m81npHgbTPX6uTsdSDx31Ce2buKgJ+LzkIiX85VewRYRsEsLArSx?=
 =?us-ascii?Q?ErPjW5GVQfw7Sos4f49dhijTmgETCtUIgtcPRuuSFNAwFW15FYXKIrM0cbT1?=
 =?us-ascii?Q?2+dQKTiBzCuIDx/AdaSiH3zvim4JkwJHuq8p9TuA8aFyb3osoUJH26GEhqNZ?=
 =?us-ascii?Q?8whusueWmP2YR5BP+aRwUnyISXGwWH6eTqF8ohzL0ojwmFhsgXgQJYlLaO5d?=
 =?us-ascii?Q?+1fV2aGsuBNO4yLI16Zhmjv+16IxJWf1n4ESt0fN4B+eKzX6nBotdYyiXVvB?=
 =?us-ascii?Q?8O2MtDbuUAKNynyWrxFCAdCv07wwZNJm65crwE/oVYYIv5Uiz0rgZvTF0kpJ?=
 =?us-ascii?Q?KpsuuhicDv4RdZtLpFkA+D/XzJZ34McxKwNtD0tKRI+56KNIuGLn5KpbBJ7i?=
 =?us-ascii?Q?EZv3jdd0KwtjpQC80lAAgw+jE0dcgfpZv9ZXNmGtZt7i95wv7wpeJRdjFtXh?=
 =?us-ascii?Q?FeeOc3jZ4KhsqOzIBL4hsrWlDM9gF5JArkPwoAWmxelkukfrsnm5ib0qHU1+?=
 =?us-ascii?Q?Cw5VNZOu2ysOMoEwrI9NvF9rBBCjq6M16FVlpX4E032HPU/matQmrzyaX2aG?=
 =?us-ascii?Q?KRodd/iJaTTTshq8NAJfvcmP1keIgPVffiZCt1887KVe+LfVYKkJdTltVT8S?=
 =?us-ascii?Q?WJu16WsJRLh/5do/mpmQMNgS4LdrUqbMIER07xJ0lhniyP94rHKyoykJkEda?=
 =?us-ascii?Q?zzoXlUjYMk+Szlbese2hVHiZxo49rHz8/96tF61b9R+9FruUJhMJdnpIgqi0?=
 =?us-ascii?Q?WPmzajdblk/+3PHlun6hMlX5ywWUUT4Lrv2lpadJwZPi/SDxyfJYP21uUKSR?=
 =?us-ascii?Q?OGDjojbyKSgbD3wcbMO6g3K+89m1zugTC7KEnEvethEAOz5ZQP90ltJg58Us?=
 =?us-ascii?Q?6sMLpkSjNM2ry/xpzG1q2EBIw5lm3tW/2Cu7GZUVj/yz+UXa5Vl9yh78ZBHS?=
 =?us-ascii?Q?8O3ciG5vgCy98GXbw46RFrZXs/ztuCTdA+U9pXjOCh21SLpNMIV96TP8uF/r?=
 =?us-ascii?Q?CJwd2xQgPrfK1uE86B3ra2I7gQmeCBBx17gDn8BRrjD2rkl1/Bgc2shWJW+Y?=
 =?us-ascii?Q?nOlkxNW2TM+JU7Frj4wZqqStAFY3e9QKfzpvOU6i9x2W5HwTV2uJ+MYHXI+/?=
 =?us-ascii?Q?g7+OapooOUxLXJE/MYONm2/t4yeQYpG6fUMYQdoDWS597q4/Cc/X+VRSQPGs?=
 =?us-ascii?Q?1Wsyl3vWt+7XdmRsi550HC/ewdSV4lr5ejjyhbS80NVByxK6HAC2d9lV1At/?=
 =?us-ascii?Q?ZU8zZTiy7Zpk/PDieaMfKi/54iz2wYoPPSx3sw3BhdaimYHltwe+zhNEqqui?=
 =?us-ascii?Q?+R180rxSgYeZHdf2KJWbVMJMXPy5InRvJcRqi8h2SBypUoS5zKLN8zsifqLR?=
 =?us-ascii?Q?3Nk1iFDuyZgvEXb4sUZZ8Aj2H3SJEybjErJxRdtezFk+pIYdhOsqIvlo9pu/?=
 =?us-ascii?Q?gdDljOiMI3yVPHiM8sNOsuw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5ABA5479EA21C845A359D9A731219684@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5117.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8079282e-74a7-4f74-4792-08d9b86b1420
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 03:47:08.7769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rr2lZd9BG3p7b6Qkoe4QNCBlSD+kUXjmUvd36fABTfMgMfmmQB0TG+CGluo9J9DctMQiM4o3Lu1Hn2U+G8wfzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5166
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: JvbayEsnvLgl9cCTIdhGBmD-FcXgADZ2
X-Proofpoint-GUID: JvbayEsnvLgl9cCTIdhGBmD-FcXgADZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_01,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=862
 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 5, 2021, at 5:06 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> Em Fri, Dec 03, 2021 at 07:32:34PM +0000, Song Liu escreveu:
>> 
>> 
>>> On Dec 3, 2021, at 5:10 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>> 
>>> Hi Song,
>>> 
>>> 	So I'm changing all my containers to build with BUILD_BPF_SKEL=1
>>> to then make this the default, so far older containers fail either
>>> because the clang available is too old, so I've added a NO_BUILD_BPF_SKEL=1
>>> env var to disable that in those containers and then there is this other
>>> case where clang is recent enough but:
>>> 
>>>   util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared identifier 'BPF_F_PRESERVE_ELEMS'
>>>           __uint(map_flags, BPF_F_PRESERVE_ELEMS);
>>> 
>>> Because the system's /usr/include/linux/bpf.h doesn't have that
>>> BPF_F_PRESERVE_ELEMS enum entry.
>>> 
>>> These are enums to make them available via BTF, but then I can't use
>>> the:
>>> 
>>> #ifdef BPF_F_PRESERVE_ELEMS
>>> #define BPF_F_PRESERVE_ELEMS (1U << 11)
>>> #endif
>>> 
>>> approach.
>>> 
>>> But then we _have_ it in the tools/include/uapi/linux/bpf.h we ship:
>>> 
>>> $ grep BPF_F_PRESERVE_ELEMS tools/include/uapi/linux/bpf.h
>>> 	BPF_F_PRESERVE_ELEMS	= (1U << 11),
>>> $
>>> 
>>> so we need to switch to using it somehow, this way we can build in more
>>> systems and make bperf and other BPF enabled features.
>>> 
>>> From a quick look I couldn't find where to add
>>> $(sourcedir)/tools/include/uapi/ to the include path used to build
>>> util/bpf_skel/bperf_leader.bpf.c, should be easy, can you take a look?
>>> 
>>> Thanks,
>>> 
>>> - Arnaldo
>> 
>> I think the following should fix it
> 
> I'm trying this now and tentatively sticking a Signed-off-by: you to it,
> ok?

Thanks for verifying this! I should learn to do these container tests myself. 
Yes, you can include 

Signed-off-by: Song Liu <song@kernel.org>

(or my fb email, either one works. )

Thanks,
Song
