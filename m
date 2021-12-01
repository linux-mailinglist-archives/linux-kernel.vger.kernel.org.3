Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6383646514B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350711AbhLAPVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:21:24 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8366 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351081AbhLAPUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:20:34 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EOuu0023540;
        Wed, 1 Dec 2021 15:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=f25b64iKyay7H0d1SlXtupd1eEF2ZS3DAnrlNmyPqyA=;
 b=asG5RgTySuMbGaqKLDlTcCwjnwxHbnxZYPKersiUGIoSnf0yiW7uWgWA6YrP4kKxXoqy
 xJ4EVSlwYXygU4iSNoxHa3iCjoDTGAHBFlz3Sydq2z9ZPpHH4kk0RZ/QzZvVYDvrJEdr
 tLpWkEuLpECOyL1bigjJsAxVOtLhwGct7AmN0y+e8mOPtVdM55NU5glNhFiCAdmztwYM
 UNN/QeAm+wCaaN13AVasXBoW2x1qWhKzVDOwpsjL9j8J7LeGlYInJVZgfUMOvSUxw1O9
 7KsEaaBc/lV2t12iTIOQ9TK9dUwCXaMb9sENUFhY3nS3xHoqpZ7RrKryUEGwI37KIZnP eA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9gkgt1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 15:16:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1FFQmP122358;
        Wed, 1 Dec 2021 15:16:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 3ckaqgnfeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 15:16:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OR0Z7yMA7ifbCnOKIETPhytVPjbcyFTxzxsl16npdCVV7ldqIT386tcBu3nAQw5fIX97VhL82IQTfQuYqFDXRpQHqbI76dAt2iVr5Tpz/HCUg1K+y8Cz8eeJxlGzUsfZlivyUZlssXvtFMyKUWBXtPI7ZmfpWJlvSiVkL0fso2JJi8kJd5uguY7vCtblpgZu4HjiLOplo/2AoEkHQluZ4Ren6vTPcFgcJusmqlV4fqqBTG+2Y+W65hquZD1YtN+Tr5uM0tRm2ZxFgWeZKNWDVR5pq8+u2+Dkc4kFi2xZE/wRvN8JOk0FhNhpqLH6jBpllrJYrP243jnd3yPR53Ia/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f25b64iKyay7H0d1SlXtupd1eEF2ZS3DAnrlNmyPqyA=;
 b=TEg/wo2U0YvSNS2sXFAxEFRwAt20YGsFLEIKVO0aHbuRF53+tpt9eAdVQRoZwq2MQwlgXHlFZVW/zZ9w7OzHN/RpHKuwIFpeg+P+F8JMN5+nCKdl0cQMMn8JNogCxeZWxa2Fk+I81dQ3bHl4OMAeMT6RIIjIVvjJIWg0ZdT6ZiHF8coFaR74+NUV3GfXPq0UifK/ca4x6Ns6ygGFVmAmtxDiadwi5UVZipfCrrACfsVtCe/ycN2WwEPqO8ii0nD7raiNq1K8aOnkvsi0FWYkbcDWET1zvlyL2nhW9dOncqzvPhF5mx1Cdu2m9eM5q1H2Egk9/odL0NXRtJLT2pDvvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f25b64iKyay7H0d1SlXtupd1eEF2ZS3DAnrlNmyPqyA=;
 b=kPJfynda87v23fl0En2qKxg7Cbs03cgGvMlhjIIktPtYzWBCxAHowboWgpUmUo/5YnR94kWIzYD0JON9n3d1lArdehA7QDLDG/BQGO6g79s8MBLXcRe35btykX/zOc4mY9m5TY0l3ZnLmIU53YhH9mYDAefflz4fuG9DB4w3g2o=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by SA1PR10MB5844.namprd10.prod.outlook.com (2603:10b6:806:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 15:16:49 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074%5]) with mapi id 15.20.4755.015; Wed, 1 Dec 2021
 15:16:49 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cgroup: Trace event cgroup id fields should be u64
Thread-Topic: [PATCH] cgroup: Trace event cgroup id fields should be u64
Thread-Index: AQHX5sFwaB6Hoy4YakmqLMRZzO8P2KwduSUAgAAGQwA=
Date:   Wed, 1 Dec 2021 15:16:49 +0000
Message-ID: <E346515B-DEE8-4CE8-BCBA-3B11EEFA838C@oracle.com>
References: <20211201144043.557470-1-william.kucharski@oracle.com>
 <YaeMoCGy2MXQtJ/U@kroah.com>
In-Reply-To: <YaeMoCGy2MXQtJ/U@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.62)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5dca60a-44d1-4fe1-901e-08d9b4dd98ed
x-ms-traffictypediagnostic: SA1PR10MB5844:
x-microsoft-antispam-prvs: <SA1PR10MB5844F48B9A4FA5AA67EFD74681689@SA1PR10MB5844.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tatRsSsbQnxQwkz6l6HNuwQhvLqTCWzx2SmXpim/D+veRDbY3c/mAQ7/nyFssrwpWoZcgFsoaQkARQhaqTNRnf7JDCUB/rnxvTIwPe9FT2volmXqXC8EH9aA7b6qt5c7v3UJmVoHTnVUzalkKa/8i4+NVOM9c7QGnvSZjrFEcNujTq6IQ8Uz35dAjUHTGMwILetId/K7F9lqapvcQbnxc0f3R+X/T2ZDcub7GpcznsyyYfjOJ4JO6GSw3hZTQzsqioyBZUJP1YliIon4jnol/PjizmeEvDNgoDXBZUBFDKUr3UIQWAB9aUotmZgoM2369BZizn3wTI0yOle5roIVc7bvgMTzsZDCvhUKiY2x2uYE4dFWfoRN39lH4gSBJkL7NHGVnS/Mb7Q8tjf6yi5ZRb28JWqo5zIFBg6W6TLrDIrjAe6zwTd72TZcI35YwxMyJmr9JBdBu/jbgB7hOmhGKBU1KCtCFByzGqDDr8X/wTfooBcyXFvR0hq6ch7scqW9Rm0p6TYWvJgGxlR5dG5dR5iPaQ35XYxp4o8ZlwwsvcYBhI/no2bEWZi6DCROog9frOIksBnZs6s/QWQ825jVxAfXjCUzNMv7asQWFYdwxl+0fx7lA3AITiT4PsM+4uKk0PmGExfQd5XqSWb9laiN8+vDtbfiXj0FtW/A4Cifeg6lMzsFXk1u1VMWqPCk0wMWRNref0HZoOvAN6FfH95cnCsc3KTG0NaNd7K9D6WxGYA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(8676002)(186003)(8936002)(91956017)(53546011)(36756003)(38070700005)(6916009)(6506007)(6486002)(38100700002)(2616005)(44832011)(64756008)(33656002)(5660300002)(66556008)(2906002)(66946007)(66446008)(6512007)(86362001)(71200400001)(76116006)(4744005)(4326008)(316002)(508600001)(66476007)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8XgMM8idahVJbGIsWRYXZcxfimqiQGiGXGdZj7RRHrmmn+4wgCn+qYoDx1E4?=
 =?us-ascii?Q?MlHJlcVlJ6pif6J8Xo+UKHOYWm6d9BbLKxFEkHS6pEjzpD4zRvVynotF/i5x?=
 =?us-ascii?Q?6vUwiFBqhW7Hi2MCGhNxvqhbNUAe3hfap+FBaehSIoOtL9ypBFWxPqarFwIr?=
 =?us-ascii?Q?JulqQFcsT889libzNtoPjfK8qBiZ02qBfx3/fQy4zy1TvBrTd6HrdeQXRL04?=
 =?us-ascii?Q?4yabE7fOpZGT0UeYu9LHpxDjSA2FgnpS15Lh4bxmjORqFafdPggkkF7rlyMW?=
 =?us-ascii?Q?JneqQ/ljx+UTYYdeAWfFLWhYcZurvZhznRmUWnzDQPXGLE7cvTQLzn9DPX2W?=
 =?us-ascii?Q?m+kgxnDJsWrWWuWBjbeG5NJv6jEHPz2AGy9/vO5SXRkXakjobGPIVQ3N+cFQ?=
 =?us-ascii?Q?SFubmEnp8ElEA/yQkomjaP860YnZijQ46oRJFdhZizgeulGjl5QMs9RRvbxq?=
 =?us-ascii?Q?6+bGHG2xgFODz9musSeHd8zPlIpIJogMMQuYFH5ac7FZFQHDmZXfHMDSyYbR?=
 =?us-ascii?Q?45liFmpm3WYQrHd3zqS2iFRAoAUDVhJe5CUtCVZetu4prU6PwidYhv9gWe98?=
 =?us-ascii?Q?ELe/P78k4YCHhiharzmNXSNm8pI1hzxYy+fYDZDL6oOnZgrcLog4c6GymRgS?=
 =?us-ascii?Q?SaTZgaRfEbNQUpQJs0qozKQ41FqOt7aYiXc5UH5ygiKSdbilQppvfot+yCeT?=
 =?us-ascii?Q?YO5f6wYVjgHZ+8oz2bsz7738QDhR6t/lqSsKu0SQwH+DudI31fgxwkzb8gHM?=
 =?us-ascii?Q?4PSxsjvmRqZBR1yjl7NCHbeuC97FSj54+Kp75v/Kde9GUa0vj6MGOgzTG6ab?=
 =?us-ascii?Q?MWs/Nx6MVi6k9w/LwqnWS3F5Sf2Viei98ZRD76Xu2pAfXJzSdo7eICmNQwP/?=
 =?us-ascii?Q?rkqvU/QWlx8Q+HBrpXggh6Vfyp5ZoY+B4yspWAOTCJmdnVLDFhUipvtVWmgD?=
 =?us-ascii?Q?4q8v9dYh08f2LOipuJqbuevVhAzeQkMLMQL41bSTxF130rqwaiPbSBqeQ7Yb?=
 =?us-ascii?Q?5W3V8afm7SbWoZENP3ZYAaaFKsmCOil4+4fLWH2V2ZqMhdInBZ14roUcz/tW?=
 =?us-ascii?Q?F0DwHEo4vSipyU4bI5O4mpLE8ue3UTLCxeAlicWMA8cTVab7dAoRXeezPvsc?=
 =?us-ascii?Q?9JbymbPiroVlhK/AzxaZFJMGSsFvNUiT931CtyS2VJZVJZQ4VMiQk59Px7FL?=
 =?us-ascii?Q?OsKBmTZFBSSFg5jpBotaP8Ig/5qulC3/o46jfGmqo8sLq8W5D6Symw99kOcz?=
 =?us-ascii?Q?O635OgdZP5PdaJbQYgSrWIyv2TPgrOO9EfNjsyG/CqL1HoTXZxNVT5LlQ2pm?=
 =?us-ascii?Q?H+lsfVeU+9TJYogBlP+9jRZW55jsAMUabvNu4E+oa1zVtDvzq+Vxx2OLEG89?=
 =?us-ascii?Q?fGDUs5dcJk5xqMQieJyo0mrKdTIrH8TsqkHAkR2VPlhn3uA5cGZFMCFh76Hi?=
 =?us-ascii?Q?92TARw2jITbpPFbK3dXeUuNF0MxA0uH9KS/ftMEOO6OUODLft0vh8YkKInuA?=
 =?us-ascii?Q?oM0F35a8ujWRebEXmWDq8YnheukBxff9iT6WfwwpdQJU3uW/3ql8ftfyOTTU?=
 =?us-ascii?Q?9+E6UE/NfTfSsMnWoSTe/6eNVcN8e9r7fYlDYeGtDiqxy1Egqp3SU4ZcHSj3?=
 =?us-ascii?Q?rFwFiyHsGPYKKOmoxgEZG2OTcE6BX3+jdYOSKyxAmE1Z7O4/rDq8/Hjs8ijv?=
 =?us-ascii?Q?35xzEeE82K8Ax01F/mor7P1H4J0z9Go+4jirSnQtpW3y/pQOf624uMqmy6p8?=
 =?us-ascii?Q?sp4l7NQjltt+aJ0bXda3PdGO2KjUvIc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F1C72385D0A2B34293495A0AE7866ADC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dca60a-44d1-4fe1-901e-08d9b4dd98ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 15:16:49.4769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mF249EA184UXScyKKvGJ0STEP1R82AD4MIRamm5ll5+oLzu4AhyQcPIdaSPk2Q1gzb88kpnPmX6ImkLT00sMVyBlUTxq76qETcAkZzy6GLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5844
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010087
X-Proofpoint-ORIG-GUID: vE48uRGKyy0EeHzVMYO1G-864Mj5QKGa
X-Proofpoint-GUID: vE48uRGKyy0EeHzVMYO1G-864Mj5QKGa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll break it up into two patches if you prefer, one that makes the stylist=
ic change and then
another that makes the u64 change.

> On Dec 1, 2021, at 7:54 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.or=
g> wrote:
>=20
> On Wed, Dec 01, 2021 at 07:40:43AM -0700, William Kucharski wrote:
>> Various trace event fields that store cgroup IDs were declared
>> as ints, but cgroup_id(() returns a u64 and the conversion was
>> not intended.
>>=20
>> Also remove extraneous spaces in fields that are no longer proper C styl=
e.
>=20
> Shouldn't this be 2 different patches?  When writing "also" that's a
> huge hint that the patch should be split up.
>=20
> So one for the bugfix, and one for the coding style change?
>=20
> thanks,
>=20
> greg k-h

