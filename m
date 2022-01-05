Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963D94853AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 14:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbiAENjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 08:39:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38684 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240392AbiAENjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:39:45 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205D4MAr027777;
        Wed, 5 Jan 2022 13:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=3J3FZwmsF6Jjf9fUquDLwe+xy3R6NplbY+u9BRDsUUE=;
 b=ajaN53qwxop80+jHiAFCuNvDZsm/PLEjKqkp4DInQzts1jpnk0p+iglZ4Lhf94o2chf9
 VP0XRmEthaHvCacQghdntBQpsG8S7IGi85HeyveLzji08NrD/Msr08xvU4VvjsBDbtIa
 vHfyI3z4+KtgPaPHsJ3RoxO0h2rKEROGc9uGO4lk9qXEgqIIanUGixLw/Fm85FXTHlh1
 2xQLesLL4Iyjv5eGzLVgXOCbKjmtZBFnjutyQl/0cz0+N/bHMIm0WnwM78XGKwMfcw0q
 9QWZw9PW/QpX6aKuSZDaTMF0aGMsnar2rpw8torKRGdHQxodU+n2amMw4kiR5USVWkeC bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc9d93yq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 13:39:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205DW7Qa082390;
        Wed, 5 Jan 2022 13:39:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3dad0f14d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 13:39:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn1o4rtlGMgg8oZ92y61D4vY/31+1G7uNesvzlLCqoyafdTPlbVnMDIemQ3MZMN/JGZhPzS+NI737Qvxnwy+pw3iA12erI2WzVUcL0INB9imD2ijyOn7bMvHFNT4G08q1gOSK7t/UL1XEt7UKgTMhKrpkOA0IjsW7dfuElYNza/7E5scKKnzqx/+/thhdVY56A5NSf+26Hs+PBVQ6ALETOMCqBjTplPKLhyKPqCoCA7Q1q49gZZDWqfaY8aL/XV31xBY+aY6QYy6/vGFWZPJEiI5J0/TB6mIZODmKMc4D+owCz1fE0GRdqVhpsETxfal4NaNll5s60um2AR38SxBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J3FZwmsF6Jjf9fUquDLwe+xy3R6NplbY+u9BRDsUUE=;
 b=C3xYEot/fioQTx2fk/pjmg2nj9KMYkM1vLm6utw4yoEfZUeY/XFPOVWWwuSTS68DX1B/QHWfSOpY6YDnd4CROZOuNI6voj0UKAeINNJuvM1/s3ATerRexRudRkYjNiBn5zU0fwjQ78lLajelm6dMVFBuoLI4l5xBLs3slyXzMfqI1tmyeOB/tRWbpfWQkhV+zCod1T6lnaA1R6xkaNzbmb7MwiOdvn2jqG5DGuSAbyTAy4v21Y3ZMF+340z+8xOo4W5pQtadx3jR9X42HIRA2KlZ7q4z9MNZ6B3bNhBkPbI1jZpXwHhKVEeforX65AfwR0udAWubtrUqJDjNm8JjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J3FZwmsF6Jjf9fUquDLwe+xy3R6NplbY+u9BRDsUUE=;
 b=fs4JEfWGepCeFrO9RiOVKvdrkFm11vguoFKFZcu61aP9P72R9LUoy0Cn60ey4N2I3RdAXY53lE8W0Ve8JzyK+3k9qZ55IsTlJv5lN3kle+hdyoJntfEx6Dlj38L1AqF3RdyuWI7Sc8KjKmFTrWOF/XZW9t/cJS50+/lCVevcF/4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1422.namprd10.prod.outlook.com
 (2603:10b6:300:22::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 13:39:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 13:39:23 +0000
Date:   Wed, 5 Jan 2022 16:39:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Mihail Chindris <mihail.chindris@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drivers:iio:dac make expression evaluation 64-bit
Message-ID: <20220105133902.GD7674@kadam>
References: <YcIpAKV7Cmi0o7PU@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcIpAKV7Cmi0o7PU@debian-BULLSEYE-live-builder-AMD64>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0069.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ecb02e3-0381-4d7d-c99e-08d9d050c8a6
X-MS-TrafficTypeDiagnostic: MWHPR10MB1422:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB142220D16E3A15610C6B04FD8E4B9@MWHPR10MB1422.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+gm4j+ucS52Iro7bLWJQ3e6a80o3WNI74+8CREa/yAKxwGQUsUrfcN6pljHu43DOJk2ZWVNkx4XuFbMxQXtOthUOlwendFAZp3kKSY4ujJ2XKXbwklHAQlqrt9Y2Q0F77sNbJWQ5/16vE6OV2vaZbFcJyt3VZgzRTzWqWBe8SiFLelKnOh7r87Ogo4UMCfNMnU+hGfyeSYer0KzOZteuiHSxmt/WzV8b6Q5P3RNK7mg5Qu8g1UX5RX2I5GKi1s16h1BQD3ZCMzes32GVfSLmrkPqx3/G0BesPGCh5Wvy75NVGXBjp7wQueWtZ8xVxmf9yr7NTYCnxQb3tk0d0YpyiVbK7t7rOLRDlykgce6yaXtnRnlIjTuhlmvNPBIxQ33ibEp2YQhf98q/wI+rbQ69gOdL3/nZ0PYyjE1ZLWcc4Ge2ToZ5FKCjL9b4LXFGDQ60BCOahy89zx1ong1Du2l66muhbaS4sVPGHaEUJLUB2rNDlT4bQDCjMD3pBrk+d5KB3+awcHGpABTwBxM+MiMdMc1sCotpGN5Y3YHxBv5qfLUu09mCCPKyqYzOsieYbUDAH/4OMEcWrpFqfGwf1o2OimDSTXdJYlNga8P0ll4wNJRd4eKSPM6EloZ6ekwVjbiXerRTN7G3PCwWxtZdxPwCljcmJXLugOZZsN4ZjWuiFw+yGsRp1fXgODP15zJaTILZJF5Pze5qW1WKVVTMs0h1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(2906002)(186003)(86362001)(6486002)(66556008)(38350700002)(1076003)(508600001)(6512007)(6666004)(44832011)(83380400001)(26005)(9686003)(8936002)(316002)(5660300002)(33716001)(54906003)(8676002)(52116002)(38100700002)(66476007)(6916009)(33656002)(4326008)(66946007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ji2G3zxjrmKy/5rs1qLIUk4f+OFPkBZp2hVF89S/pcNY7t8b6nUFhmDv5xdh?=
 =?us-ascii?Q?56Yrs43VMGUQpTBFetlLECfOLP8EJr6HkLG7XF+O10NW8HKQM+pgQrSQ9OqA?=
 =?us-ascii?Q?dv1tvOHyhs0mz7NcfOCRgS+P0uLYoYiUG9MWnhOeJHupXWgAX3DgPxnWtQjD?=
 =?us-ascii?Q?IOVEnjWdUmX0OzTSrHe6wiFlMoQ+IKWZC3dak3jheGPW/hJsnTV9zbgpJD9B?=
 =?us-ascii?Q?feV1apuQUjr06phst8uMHm4oQoXfLXLMz+NrKqp7jvmCddcGyF9YWJ6brzOi?=
 =?us-ascii?Q?d51p4O31GoaJuz64Z3TvhvphexIZbcC2Vau/GqblQWLMct3has0KTmVXVgc8?=
 =?us-ascii?Q?HFtoQ6PL04bdBDy5laj9wpuBqiKZRE8wrFMIx1OUETqHw8ZIHj/sWURhkVlC?=
 =?us-ascii?Q?yquuzi2qt8rcp985T63FPl1Be6R8+0sVc/pC8sGGzfDlz4OlLukpKEe2zipb?=
 =?us-ascii?Q?IdVBBwTQfCnti4YCQRPVqybtfmMkO61C4JuaDLV+hP/u5zdLKwEwDiovDggk?=
 =?us-ascii?Q?E0U55HMqe31l6xnZU002DZ+sLZRvyu1mVWdRXuGqZvG3RFeuylqXe2OnDkV/?=
 =?us-ascii?Q?w0W5BqAt3RI8NLkrmqr4c93W6DGc4ZJtu2BNKm+GE7hWPBKXY9+0aIZkrfCQ?=
 =?us-ascii?Q?ayFli9G34Jmz2v/oSVPlR8uXmnT1KfkHJ1lvOzV3rdGqa3gb9+1aw2pW+5sM?=
 =?us-ascii?Q?kqSnUJEI11x88GufUidbuHg+gB7WlQUIVD8nFsnsu+cUxrp6iDASv7Je0Xu/?=
 =?us-ascii?Q?W/ge3ljqQ/7Z4AB5D2iuzvmbA4HB7bMmPoqvLg3RpOXvW384QGbbDZ+h6XfH?=
 =?us-ascii?Q?Mgvc1m06+eqOV1d0uOs7+wE2sfqhhVxwjXyUPgpkZ0TueNNgNXWOZUfKBQa8?=
 =?us-ascii?Q?l+o2C5btH7Rbgg4C/LBZYeJlr9jCXEK9s3QF7yeVUjweikyuaAt++wzKdFfn?=
 =?us-ascii?Q?xZiMIgZrm1da4miYD/37OBuBlQaZYZ4MRjUpZkQBzR/1quhKndw7DPZwG7GH?=
 =?us-ascii?Q?L0k//yhLHu6zRh4cefSP3YeYQhD2BexLAVRwQDgtfU7QHLf3yH+i0+5Z0jZq?=
 =?us-ascii?Q?FsRbzIh3ocVCBfD+BiGPIDJ5Gff8HaL+aT9M5eAsM5Dl7WJEz2hcCiYEZ3yR?=
 =?us-ascii?Q?0IOeEUPllsFxA4XiosvmKXWzdrfsbp5cucQTcCX2FoJawxcbDjfak2Qddt7s?=
 =?us-ascii?Q?Yvbz8aLkVOk/IVMjxi6u2bQgPsMK1zgesGnRHRHBi1TirGyXP+JHoU+BJb+h?=
 =?us-ascii?Q?JHSSgPsJQ36F6xFwswqgjgYtgmc0lPb+8Y1jTQsSfZGs6x3GC598Xw73VLrX?=
 =?us-ascii?Q?Ex63vKbvHg39allRC9USjxJyeoyisX2YqcZXESjVCMVxr6/N9hkJmsXAKeCM?=
 =?us-ascii?Q?+lLtaaCQRcAMWcI2XEmD2ay7hyTxq4BdPuvDVC79oyT4O0tuIhCDaa5/G7WH?=
 =?us-ascii?Q?+/UOPxtqsrnoLC0g7SUKLivGPGQ8EBDo7hI7NGnD5XNHR8OVGqVxRj/6N9Kk?=
 =?us-ascii?Q?P4nhO6sxTs8lTQbBXocq+/tnZbXPuU/tS55SIxaytTVSOLjGc5oXnaQBDCIg?=
 =?us-ascii?Q?8gBL9h6CU5TBfCfteOYgLovZ3DYPlkdwtUQByYrYZNzwvRhRcWmdPQhEyG//?=
 =?us-ascii?Q?zhmJKVi7t4ixnqpQMFfqYQ/dojUdhU5vu0i8Zvn4C0Oku6Q38ha+RyTimvir?=
 =?us-ascii?Q?Y8FM2bEHSW/tY8ioR68BFbVhGHs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecb02e3-0381-4d7d-c99e-08d9d050c8a6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 13:39:23.8376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkdiL0CRCISwPIjKvXrNbjJ8ST19KoWSspPQsTRfxICHl9U5u87rV//Ofa6NzNnrGBJxXNGu1AJwKT37UY2FDG5wPpfWDX+nlX7mLQKBGJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1422
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050090
X-Proofpoint-ORIG-GUID: 9tLcv5wZbTQyjlUOPNP1vA-6CVqN0eQo
X-Proofpoint-GUID: 9tLcv5wZbTQyjlUOPNP1vA-6CVqN0eQo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 12:20:32AM +0500, Muhammad Usama Anjum wrote:
> Two 32-bit values are being evaluated using 32-bit arithmetic and then
> passed to s64 type. It is wrong. Expression should be evaluated using
> 64-bit arithmetic and then passed.
> 
> Fixes: 8f2b54824b ("drivers:iio:dac: Add AD3552R driver support")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/iio/dac/ad3552r.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> index 97f13c0b9631..b03d3c7cd4c4 100644
> --- a/drivers/iio/dac/ad3552r.c
> +++ b/drivers/iio/dac/ad3552r.c
> @@ -770,7 +770,7 @@ static void ad3552r_calc_gain_and_offset(struct ad3552r_desc *dac, s32 ch)
>  	dac->ch_data[ch].scale_dec = DIV_ROUND_CLOSEST((s64)rem * 1000000,
>  							65536);
>  
> -	dac->ch_data[ch].offset_int = div_s64_rem(v_min * 65536, span, &rem);
> +	dac->ch_data[ch].offset_int = div_s64_rem(v_min * 65536L, span, &rem);

"v_min" is relatively close to zero on a number line so this can't
overflow.  There is no way that this change affects anything at runtime
(except making the code a tiny tiny bit slower).

And it should be 65536LL for 32 bit systems?

But I just don't see the point of this change.  Presumably it is to make
a static analyzer happy?

regards,
dan carpenter

