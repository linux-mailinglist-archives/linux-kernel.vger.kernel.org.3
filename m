Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB92F4698B0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344025AbhLFO1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:27:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3618 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344070AbhLFO1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:27:00 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6DObiD013020;
        Mon, 6 Dec 2021 14:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=MMg+B+BDaQIrDLnvwsyhtaVfsGDk9SbSdYxKORNNuRs=;
 b=F7iY68/Jv9AJ498L2AtWLRocqbr6Vr850pIiJood1RQqlZTMdlVqMXvu0Xkvf9b7jv1D
 4tWDvnnOO3JIRrdvnKH4QuorYjPLs2e27s1NRyWvFCO8MGoEIiG5IL9aY7VzFCd4ZEP6
 /bV0OcdEX2MVG/QT3ACb19wl3gNQFMfZ9O55QuLFoux/HudNKj7b53i+gQMhwdavKsFD
 UNzkb29lK51UGyrtY3nzS2n5bM3IkG/xEXYV767+IQbl1dUq1+Z9WvXbjc1Kb7Ve+Wbh
 B7dalLHleswv42wAgEMjB/5Lc6RQ+q6FfJPcJxEv+m0/SuKnsyOUicWREdRh2m1XrgF5 /Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csctwj71a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 14:23:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6EM4KP077685;
        Mon, 6 Dec 2021 14:22:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3020.oracle.com with ESMTP id 3cr053fw96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 14:22:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPjtksCuIWbXwsPwnCNt7ylo/NiaqcciatthRw2/wJ5GBE+NGEpWu7b387DhfsQDjSLTsC0yAOK5HmtjHp/HeqSDI6Pr75bMpBx7pgZhd0Bq5obBRg28wXJPfsClfzgVjokaR+fwMpLtTFNexHjsPgfIAS8SaMwxGZN5t3u4nOVevpGcZJeAQ6f7A0ygWN3s3PlgpSdIIuWd+9qFSin5E9L8LruiNdup0Ti2WICcJUwhJF/brlvJqgWomWGSJOisP6a26T+fVkM+Ve8Qw3EGRAkPjQ1xsuxO1JJd8xYs6lkzatA+M/z3RQQPqhVms/uP83nQEtQuetemuHCBWKHXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMg+B+BDaQIrDLnvwsyhtaVfsGDk9SbSdYxKORNNuRs=;
 b=dG95DwQc90rnuyl0WZBpwJeU0oKZz2beGOC5ATQHRMOGWD9S/P3HBkW+raY/7ih8rPf+b6RPzW8H3zH3yQKEcpcLb9eLbzj8IyoEemAt0/IXtxBaLcgMCTreXGC2L8Sm/H7nED0p/T+QWVUg6ucGxrsbjaHLzho5JgR3a8RcGEb2/XyfhU1OxP1IfKtB1u4nQkXMoOskW1s/0+kjI+MMddkqmvYUR7wzxz4oBnxWcWnUd75AeZu2kna3sVdTfv7BDaDl7Y7XaHuyeyOadPCpw2ReOJLuVJfbwT5a37oIM2Ko+vre6kXnZeSuPQg8U7yChLNmjITjz2zyBojTmaIHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMg+B+BDaQIrDLnvwsyhtaVfsGDk9SbSdYxKORNNuRs=;
 b=yttoK9vb5B5D/rsSY+XxPWpuG3MF/Y3NMVSYQrfm6uvYMII9dadKWIm58qzr/NuM3FRB0kyhytPAkjl1WbMxNaCG6ogxYyGRqt7tjC6JRJO2SIem4w7/ZDXD7CWEdfhtb4A7dRVX7fXUSnYazSwgUa/a6mwkZjXdKJD1BfIXrPA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4449.namprd10.prod.outlook.com
 (2603:10b6:303:9d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 14:22:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 14:22:56 +0000
Date:   Mon, 6 Dec 2021 17:22:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ngo Tak Fong <simon.fodin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Fix alignment checks
Message-ID: <20211206142231.GB1956@kadam>
References: <20211206001949.GA54773@simon-desktop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206001949.GA54773@simon-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Mon, 6 Dec 2021 14:22:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 998ef0c7-b01c-4cbe-8ccd-08d9b8c3e5f6
X-MS-TrafficTypeDiagnostic: CO1PR10MB4449:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4449D39DE5081BAB4BAF807B8E6D9@CO1PR10MB4449.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6/AN9dNTZp8ktHLbhqwl59MAK9ZVy8rn9qKlgevkOWeBLrToCdykK9SNyEWCvwnUNxwZVX2JXEstmQfkakuk88/7kIe2hDXGVVLB1MM+bBEOilOww0QyjgVHZvL6sREy32edvtQ3v6+/oeQj+koQQo+ng5bm8cJ8fx+SbIfLrRpO3dKMLA1zkj+0mz0SGpSl9uS00dO7RN8bn6eF0ld0HaObbFdT513+ewmhhu4qARmy4Md7gfnAMKzC60VPf2mol95XiUNaejyN4WKWtj8cjg0FrdkavUWhnXXzQMQCGwin28eaq0/0hq/hHiyHGlw5cZpOYgVGaEypQumoKXEIUXBhibJG2StRAwM1yJtq6UJ2QttwmRi4kHhTR+7dxcQY/FJttWKk4SZITmxGso4dLiknyOBTDU3HObvg6qLI2zMsZnvA4eTwST1pgV4LjvAhi8F6s3R8gt37Mzn//+aqF2tS+Qc2sCNjh+JPceyKXHRBVw8dBM1v9KQ1Wzrjenx7UtFR2+veer9GTDLYWBA9ZY2u2nl17EMiS3vzLN40L9GfZZg98rRlyc1HD8HbtHVRbU1jZ7Twl8FdQWp50kjIYqo2/TEsUI5Ln7HpgOx7TJo98W7rk7z2n750vgGodvsT8LcMfXjy2Z63MWK09mf2XNKwsFl4XqPVdgfqZS27vS+GaW/A7M+53HInDUsWacp29HR86BGpYdx3mebuMRb/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(66556008)(8676002)(2906002)(5660300002)(6666004)(66946007)(66476007)(26005)(6916009)(33716001)(55016003)(44832011)(9576002)(316002)(508600001)(1076003)(33656002)(86362001)(9686003)(38100700002)(8936002)(186003)(52116002)(83380400001)(38350700002)(956004)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HAf4Np+EeRoo94AcUVUWrqfI6keINHuRfjQ/F4wLnjh0aKYJAGOLtx/NUMf+?=
 =?us-ascii?Q?lDtkc/NE7+aqub51bV7iMmAxk5sSM6pWDEw4SpTKyCf3hTvmoD6UHmsmQGw5?=
 =?us-ascii?Q?qvyC9ZWKJdshjjeJB+iKPlVSpKldE7tP+WMroMLzK14sGwIG0Eqcs6y+GWZW?=
 =?us-ascii?Q?MiOSroHIgZD1yn6HeB7dpS6gTmSFvcYjh8MEHtHjMopOi5JFaURnoykvkbT9?=
 =?us-ascii?Q?Tq9ytpnhPNo0htGwkfuyeZrhOVL8VZgq2kI7XLAaIz5CyUuMBZ4UlqWLdamc?=
 =?us-ascii?Q?j3wVxARcSCmLGhc96fug1erxpX6cI/x0eozV2KpV0RvxKqKGksssmpHX9wri?=
 =?us-ascii?Q?4YWOocZ62wWkeSMlTIihjD4qKZaiU/xHP8L/Kms7BLEulOE1KTcDRZ5VEP2N?=
 =?us-ascii?Q?4Bs3qXu4rqrNo+4+OXDIg3konQY7EkQbBGj6IkYlRfYtMjIUuvwkkl5JTTy5?=
 =?us-ascii?Q?V+fLmp+o4a/lOx5XR70cO06b+/N0rzy97CYyv5SLx1gJQJxNi7Rqidp2Bad7?=
 =?us-ascii?Q?STaqP7hBOyi9LTJbeKUSNUo0Y56KzkAzvU5tm3WDkh1IKSM7kMoAdK+aE/Gw?=
 =?us-ascii?Q?UWUMu6URhxQ6lyahLLI53DPtHF9akNnLx1VJNX3W/5xkni/8JtJfhYNTW+6j?=
 =?us-ascii?Q?i7Toum8V+d7NbRQyg8GYwahH331yrd+ArkiKz2S0PqcTID2zgll/hcJW1oqd?=
 =?us-ascii?Q?0zVY4MTN4oIXLIrET6wmT3dSIvxrtDITQkmW9KljSo0dMGqVmH0i1pEbIFw3?=
 =?us-ascii?Q?7McDBIKgFcdTEbYKH2Tflp+jisl17ktWAjIMgezEfNEtq5ORXjSMrblEC234?=
 =?us-ascii?Q?umdgHVYyXO2PSVOdIeS5TJKaaXsXvzaIdurSQkzFwIKqUGO+mxtkUgo9SrH6?=
 =?us-ascii?Q?zkmAAohrzrNIPa6EKRbkUAvD04JThb83sPFeFr/Cl0+iHK44czSmTywGT5Mn?=
 =?us-ascii?Q?RvuHQ8c7e7LWz309iTYpeahggo/maKnlDxuHsd3IRg8Pm7XkysPM8KEGcYcs?=
 =?us-ascii?Q?upHDBl4m/x6RJ8GiCWYy+1OqQ8RyP/EYY36Ne+Y6RRyI97D6LQ+0svm7wg/5?=
 =?us-ascii?Q?sSzXmsGKee43bJUg/wJpARx3tRkdt9hJe7C6QcMOAGmeo4rd7c0KjXFdgd/2?=
 =?us-ascii?Q?ClOgT8UVKRd2mkLrcfp/Cha2ROGx/I5CSy3I/RTlFHgdi73dEYGqVzWVzU0+?=
 =?us-ascii?Q?2oMdzirQoNwFI8w+RmNuolSyhuaSMZ5iogIgz8FjR6VVN1MCXE4LoWrQyh3J?=
 =?us-ascii?Q?UU9bYpSsbuUnSpLgkEoIcC6D93/Z/Ke8wNeNQmMkU9mLZwvXgYq+jQ3qMZlv?=
 =?us-ascii?Q?h1zsXQqf/nQKSZtvO4iiXCA46jbx8/IXjCju1w4O2jrDy7sgGgQko8CyRk50?=
 =?us-ascii?Q?XFikejeCFjbcI9xO8dfWZhpxQG4ljvlJkWqjVV08t3NgZWL67Rja2TFmYnKV?=
 =?us-ascii?Q?CN3+f1H0nJwxGUxRq7MV/xSt1HX7Vq7LY2GBsA7qMh+j3cbu9eh8I6A7bct6?=
 =?us-ascii?Q?5V0+kSTtA6W4fg++dh5yasfzW0cM+JPW+3+Z6zNRHo2nnbG4NFC9cLHWD9dH?=
 =?us-ascii?Q?g9eWIX3JKJuYnMxBvNCgldgiBRxu3N6LSch7jW+nmXzkbsCVQqW9DEilBq+C?=
 =?us-ascii?Q?w4XLNRk8GkqEtisNJw3Te7Yv7z13kZon8qYAuIBfVC5yZLFB+NhyB9nQt+pR?=
 =?us-ascii?Q?WiYNz87S/DtZP4Ulf+jyUlZ7qVo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998ef0c7-b01c-4cbe-8ccd-08d9b8c3e5f6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 14:22:56.7918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjywBZmv08uE3hQHLRSahkbmQSvwnL4O9nrhlFVQk3JBIHq5K6ppfNuoPupvapvnR4swvAcZVno30h5r/NopmtM62sP1rsNav2gA8z/krdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4449
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060090
X-Proofpoint-ORIG-GUID: 70X6fvxdFNFTec29DCcc-DlL18gf4NF5
X-Proofpoint-GUID: 70X6fvxdFNFTec29DCcc-DlL18gf4NF5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 08:19:49AM +0800, Ngo Tak Fong wrote:
> Fixed two CHECKs of Alignment should match open parenthesis.
> 
> Signed-off-by: Ngo Tak Fong <simon.fodin@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl8712_efuse.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl8712_efuse.c b/drivers/staging/rtl8712/rtl8712_efuse.c
> index 4f3b54a7c3be..3555f612a066 100644
> --- a/drivers/staging/rtl8712/rtl8712_efuse.c
> +++ b/drivers/staging/rtl8712/rtl8712_efuse.c
> @@ -300,16 +300,15 @@ static u8 fix_header(struct _adapter *adapter, u8 header, u16 header_addr)
>  		for (i = 0; i < PGPKG_MAX_WORDS; i++) {
>  			if (BIT(i) & word_en) {

The real problem is this code is jammed up against the right hand side
of the screen.  Just flip this condition around and pull the code in
one tab.

			if (!(BIT(i) & word_en)
				continue;

>  				if (BIT(i) & pkt.word_en) {
> -					if (efuse_one_byte_read(
> -							adapter, addr,
> -							&value))
> +					if (efuse_one_byte_read(adapter,
> +								addr,
> +								&value))

reards,
dan carpenter

