Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDAD464B13
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348354AbhLAJ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:59:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3002 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232736AbhLAJ7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:59:53 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B19p71K007277;
        Wed, 1 Dec 2021 09:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=/L0sujy/pNu+RlE3GQ+o7UqMoK/O+K2Hx7z307lUXiA=;
 b=BRJaN8YEXxGR4A58f+8fe5Ykkjf/vdkOLGWzKDck6tZgbDv+7gxtugaGlr9Z0/4FmkBz
 A6Vq0D9ye5x/KeaIgj5QSc+juecBtv+K6qLXl1XJzY2HaSl3oBBwfCJBc8Hln/uQeA2s
 g+KEdUP5JEUHgvzA5j447fzmu5uW1tinpV2KEg+sQ5StivpTdA7Tkof6kGlZGpUisJ8H
 N3riW1aeLOmjPKss1DZ//P36HpTqTj7jKSkv/ybm2i3Hp1iOa00ldhZaFTDCWItP9zVi
 aiUGRr8o9eMpFje34AdfPrp9gvVZxuKDN4x2KjUX+aXunXisroICpwaVKbaKkLo4WS+C 0A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9yuud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 09:56:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B19qKnJ047962;
        Wed, 1 Dec 2021 09:56:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3020.oracle.com with ESMTP id 3cke4rgjhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 09:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl+LH8xY1/NJMIS3i1EvXvLaa45ngdf0q3mHB2bYu9eoAqym1h0FpoFMNRITPUKkW1yxxWcijC2CD/AC+qr2PJDr9bP/NLHUAhnzKbX2IYngLT0LG9GhVYsHW/ydfKSptQ1KORp7bB3Yw3t88mMV63/6wXs9fnGAws4XneLqylidEy7cilJFyUfOezgQV6zqV81nFE4TFN1iKHRXbhynqgqLCDH3kCwPvTTgmOMNy1sxiB19ZYpN3UhiRvK44WrSat2GimHGpKwGgYM/XkYM8euYBNcwzgTi7MFN0NEL4ZX9u7c9vgzIE3KE9lVeT3kw3MB6laMCOWNyPyT1l2176Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/L0sujy/pNu+RlE3GQ+o7UqMoK/O+K2Hx7z307lUXiA=;
 b=bC/IUW0wqLxh1ju+enU5Q/GOZjF/zK0HCx9WCrC5ayFro7m6xmHcsMn/fCTsJ/7XaATUPp6tRlUrXzrxLlttxUkfc1NFoFPXm8kZRCbvDmXHSgGSCwlIG/4Qd3gYdf1INQGmWY9sSBA361401R2an+wIQrvNgapG7sFUbHSrBe04r6oHX8NkFkByXZVanEC5dZ27rggtpEg/TsykTOhkeKpyUzs9NmR2VZlfacOSLRRQ4noK/L4z29LLhusUNHH4/m2tLD7ApPRU62BTCuwrl3YzTl/v5Ic8qtpgra3QfBOofVpCntFVX36hF0OENGfmFqheNqaVckWuxu5YpWHtzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L0sujy/pNu+RlE3GQ+o7UqMoK/O+K2Hx7z307lUXiA=;
 b=AamJux7qgZkZgyL+6qda/+5GDpZsJ2UjVJ6q/sLnd5BRBPQQRqmwA9Rr2Y8OEQLDaC2D9VjpiTa8WeT7eGgJHYJLLzN++lpB81y5bZBFDLnFTFXUnGF6OXWkrVm9SLfGBmGUovDLDCtrykZz2AhUANJ49HZQcaekB2ty34VHQ7o=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1773.namprd10.prod.outlook.com
 (2603:10b6:301:8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 09:56:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 09:56:22 +0000
Date:   Wed, 1 Dec 2021 12:56:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, paskripkin@gmail.com
Subject: Re: [PATCH -next 2/3] staging: rtl8192e: rtllib_module: fix error
 handle case in alloc_rtllib()
Message-ID: <20211201095602.GB18178@kadam>
References: <20211201095036.1763163-1-yangyingliang@huawei.com>
 <20211201095036.1763163-3-yangyingliang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201095036.1763163-3-yangyingliang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0061.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0061.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Wed, 1 Dec 2021 09:56:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 927f52c5-d65b-4d1e-bcb4-08d9b4b0d449
X-MS-TrafficTypeDiagnostic: MWHPR10MB1773:
X-Microsoft-Antispam-PRVS: <MWHPR10MB177386BC84CE00845DF958848E689@MWHPR10MB1773.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEb3RO6svEeq8tlnAL+w+D3xol5QCnOChpgkmRFWkBNKjOL7uNqpRGPt7kg7hX6NPWsMqFK/UU9STQW3mB+93i+A8FR1s9u09QP3SIewHsBH396BvGwNy4uBgxJQbddDG2q/bTV0xGRng/39569Ohyp6rC6bHB+r0EKcisuPUlE2LKPDFEHqXvaRtWwpZMSbro7NjoVgnl7rDKDKu8NBtp/d0O7kLvSc7Vb7p/ctMr3O2DLHfgjCI9zP1G9Hw3Q16Yme8hmD+cec0rjq+8dZmnfzRrPls7wV7ku2qKqiGSZaGrWU7jeIXmQrmCa50zuCA/oXwmwTeBGPbnV8sES3lICo2jtzq3fIPDanz/bIvPmDnTXAQs6s3iuifMIEv9xuBYX9t8Gpv9oiW8eNSSpdU6bQyOPq03Afd9XkHmdeMLTFRWAa2xkg1zYBxkFjt/+T2lpXwX+MscVaJdMAeB89B8ilPSzyAR1Min4gM8+h0n2S6//DYhac6afFYNbjhARf93G2AcOHMVVr3to9363YX8zCgCfiemDx//hkefocMLhWC34FinuTjREIvp3d/ePTPpXEOe6fplJwx6QItsQckgdleZxfgxOQEW6/ilYXSNt0C5Vt818f3QMJyQEm77LMV/oUvMDG7Kyj9Kbr85sUjnoGHctdnSZJoqAAifbjmVJ3TB3lw/b0tRrIz9RARikZXq21/gy7xM773TaGm/j0fA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(44832011)(956004)(55016003)(66946007)(66556008)(6916009)(33656002)(6666004)(186003)(508600001)(86362001)(4326008)(83380400001)(66476007)(33716001)(52116002)(316002)(8936002)(9576002)(38100700002)(26005)(6496006)(2906002)(9686003)(1076003)(38350700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z9LWK5sjS1NSIPKvho+/pBMDMeMEDPGjHfoesB15Hv5ygC7+IwLnlbgAzM72?=
 =?us-ascii?Q?yuAnkxKErcoIK1jLj5O9YxV7Ti4Qlpt43FopW8oziYHBpR6m10iFcY3TPmus?=
 =?us-ascii?Q?4yy7SVAjuCbTgW7HzHYzJg15YBm14fOW+wNEYFBSSfTfVc/p+hTKdDoTrRZF?=
 =?us-ascii?Q?uoueLVOpxoRRAvsRAkFUA8mtMEmgqAaaNLg7dCS64/1k3u/qo+i6RKtmbFba?=
 =?us-ascii?Q?rnDPujl+2bF002aMGR7oqrT5aKfPbqwZEGnYYeG3PD9XCfDGT19+8LUnVbsW?=
 =?us-ascii?Q?VNEBpSQo2umGs9ovQSlWku4jv6LVeFMhWRsKBvQOJcFckOxLlUocDbkpX0bQ?=
 =?us-ascii?Q?uyKpWlRhdtCFMGwmDONGhvhACEgOhyOe6jCAmyIEnMMOCze66iTNl6cn1aEC?=
 =?us-ascii?Q?eKmIJbzfzUJXpdzWF+RqllCj+CjzRDztydqQej9PN/4nLkyhdP0lu00g6MX9?=
 =?us-ascii?Q?q0LWPx1M19Q5MM8ioJ3NCthRLlMKhmayvOzJJvtW//z6hYbHkw4XzZfHiNk2?=
 =?us-ascii?Q?uDQHegR/CzxmSB5O7EUpO88rW7CW9WFQ7qKivhC4Qrt/Gm1EoJddMMqOmEIr?=
 =?us-ascii?Q?63w+YvchmQGvKVES+OEopXNYYZrIe2uggX0Buw3oMhtc+29UUoX9w+3bIh1s?=
 =?us-ascii?Q?AB1Io1WsolojV1o5MQ8FoGl+Xjx0rWbhctxkX9sIPS2By4jsMwmrkuQI0Oq/?=
 =?us-ascii?Q?S5G2QQ48nYKZ6LyzHFL3f45CKKrnLIfTZZIP+WPVv6RdqQPI1BUiml9aom2X?=
 =?us-ascii?Q?02Dk2Unyfsdhlc0QqBxj1yHq4mZjw8zKiCB8Z3GREF6l8l1X9zLGPkchCdPP?=
 =?us-ascii?Q?OivaBYs+rgo+9tx/huF8QtW4454bbasorVsshBzd5X2mRY3p+gtJtWdURYFx?=
 =?us-ascii?Q?9W9HvPiaOTOj1JlMMzR9+XFX4/oI3CshM8+t5rt58z5N6KkNb9wsljP4F43I?=
 =?us-ascii?Q?+K2e2Nh1xZHzCfEWCp2ud8pilVEKXbMJuSsupMJrSE2bSmw7tkobcbmsjzwo?=
 =?us-ascii?Q?5Uqo7oEOnqmMkZhJDWwu+erbZ2iIEZcA/vlBKmw5MZjYZJeWITmRJaDzC1EA?=
 =?us-ascii?Q?Ev89J7cbJ7B9e5b4WqKjKEE6VOro9Gtifm6YP8xgs2vNq9amZzlpB3vzb4ua?=
 =?us-ascii?Q?8JLDiEUjzcnH8eaCHM/EySwgqt1fI4eN7CFyfassvngs+ALXx8gIgq2q2X9h?=
 =?us-ascii?Q?MGOFj7U2BwRAJ8kVwKgX2xqRj1f6rT9xcRcJlM1+1AkKlPHgGqOMiTomiWnW?=
 =?us-ascii?Q?IkW6J5dg4XIhMunAPqT6xIVuhK8x1sGsLXZEJEdVpeQwqCwtxfU+US+bLW2V?=
 =?us-ascii?Q?B8WLDevYvyI1BolYLUqa5+lOaW59n21YBunYGfyQM6lgJq+p33XrH6rqj9ul?=
 =?us-ascii?Q?Qna4T5pN4IWJdCOVSdhatolAbqWgDnpQeEH81h72fcXO1Y3MwQutXXkOqgIW?=
 =?us-ascii?Q?I07RKtGYUIRDK9MUxoUsPqPdeV+uslbBLvR9vMGKyEeb6hCbruDvXGThXLTg?=
 =?us-ascii?Q?x47pfcBWDJjzLm9say5VHlrXnzS1QPiXg4sGEdTOuwh842HAMA/n7SHvN8FI?=
 =?us-ascii?Q?AfDoICOzmQ4dsLwI6poZHDomDI9FJxrTM+Vl8SK19+CQ2D7NwCA568UhxO8f?=
 =?us-ascii?Q?oWbGH7K5kZvEbxQGgcWMqeHh4ugqixg8lm18QRCcqn3TX+GTM+FZz87EDnHD?=
 =?us-ascii?Q?tzjISiWcnuGew+aiZWcocuqVO4U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927f52c5-d65b-4d1e-bcb4-08d9b4b0d449
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 09:56:22.0360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUilnlOblwqbTxJU1SuH76tlmiWCdd0kNuEvs1LecEC9VoRQHENjYR/ri5IK1HZ0yXGo5wVuvbvNIy/tjQcOfTQtg8xDTSoNRF6bCFNYET0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1773
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010057
X-Proofpoint-GUID: bDhFDVmUvZJe8iQ6oOwhO019NxSwFTZu
X-Proofpoint-ORIG-GUID: bDhFDVmUvZJe8iQ6oOwhO019NxSwFTZu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Almost perfect, but it needs one minor change.

On Wed, Dec 01, 2021 at 05:50:35PM +0800, Yang Yingliang wrote:
> Some variables are leaked in the error handling in alloc_rtllib(), free
> the variables in the error path.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Please send this as a v4 patch with a little note here:

v4: Fix crypt_info leak
v3: Fix more leaks.  Break it up into multple patches.
v2: Make rtllib_softmac_init() return error codes.

You can probably put that in the 0/3 email.


>  drivers/staging/rtl8192e/rtllib_module.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
> index 64d9feee1f39..a3c74fa25cfa 100644
> --- a/drivers/staging/rtl8192e/rtllib_module.c
> +++ b/drivers/staging/rtl8192e/rtllib_module.c
> @@ -88,7 +88,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>  	err = rtllib_networks_allocate(ieee);
>  	if (err) {
>  		pr_err("Unable to allocate beacon storage: %d\n", err);
> -		goto failed;
> +		goto free_netdev;
>  	}
>  	rtllib_networks_initialize(ieee);
>  
> @@ -121,11 +121,13 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>  	ieee->hwsec_active = 0;
>  
>  	memset(ieee->swcamtable, 0, sizeof(struct sw_cam_table) * 32);
> -	rtllib_softmac_init(ieee);
> +	err = rtllib_softmac_init(ieee);
> +	if (err)
> +		goto free_networks;

This needs to free crypt_info;  This was my mistake in the email I sent
earlier.  Sorry!

>  
>  	ieee->pHTInfo = kzalloc(sizeof(struct rt_hi_throughput), GFP_KERNEL);
>  	if (!ieee->pHTInfo)
> -		return NULL;
> +		goto free_softmac;
>  
>  	HTUpdateDefaultSetting(ieee);
>  	HTInitializeHTInfo(ieee);
> @@ -141,8 +143,14 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>  
>  	return dev;
>  
> - failed:
> +free_softmac:
> +	rtllib_softmac_free(ieee);
> +	lib80211_crypt_info_free(&ieee->crypt_info);
> +free_networks:
> +	rtllib_networks_free(ieee);
> +free_netdev:
>  	free_netdev(dev);
> +
>  	return NULL;

Something like:

free_softmac:
	rtllib_softmac_free(ieee);
free_crypt_info:
	lib80211_crypt_info_free(&ieee->crypt_info);
	rtllib_networks_free(ieee);
free_netdev:
 	free_netdev(dev);

regards,
dan carpenter

