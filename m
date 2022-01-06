Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C62486340
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbiAFKya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:54:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53312 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238102AbiAFKy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:54:29 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206AW52e018971;
        Thu, 6 Jan 2022 10:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 in-reply-to : mime-version; s=corp-2021-07-09;
 bh=kSd1VhF9N0doTiA0upj4xCD2kKeuJHhfqUMZUTESn5I=;
 b=jM0L5GeGgqWh8q2kxEfocpRntyojfLTVlkG/C07pmOhHFecsYwtcmrGIo6rvRH0OMB8o
 KAXdoo3jdStjNpZxItfYRx5v9KDS9XI9y1ZnXxwhawTKKok2jn1VdiuMAy1jlYpRPm06
 +etTKU+83dB1uP2J/0SlECt5j/rIVeQI47dEd0kcmTLMWicniv+SRnaca/vg9wwUALWZ
 XRSDmkkZZwa3fHaohXx1R+vt+SatxsN+BPnf6Ak1CMe5DSQjc8bZhjBLs9SOw80Kd9HS
 lKCg+1I5grp2o6NG1KZ5pWB+jiOOFEUCX2UDZa0PjgzQr/4dNX+JPAMOg1xi8sMUav9a +g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpp9d37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 10:54:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206ApiiK048621;
        Thu, 6 Jan 2022 10:54:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3020.oracle.com with ESMTP id 3ddmqanvch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 10:54:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK/gE8oMubUgbyDAxKeojBGeQ79avODfEIyLRG+npFpsSdShAOkb3ddfYLIq+9em+9U6H2o+OKA7NWAKQqScR4ADUBINLSiQ+qJtGzJ27oZDtXXy83xPZowN6i0/GkE4oYpNOaDGbrXoS+1kQ4dx/6lrYwyz6TRtaWHWd9S+Y3pJVIlO0ZD7/SgYZv1YYBx5yPn7OIQq4intnRta7iOX+jvTMSKBGJYC5CcjOVSRY4JeemBn4TR3xVicIFeA0HEP2TW9UZeniCj2u8OmbFe8U5NgfkNVlHtLxbJioggsmB3WLSzUxrArJCMUAaB9KJwnQ1VY3w0YEP9u/CgM/GmOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpEdUQyS/j1NiwHAMZe/QCpadD20Y7By+wnz+R1Abco=;
 b=iIHw15X5S3oIkjWNW+OcuIpYc51y8HZL9gwAZiaNG02dJPTzVoI2ZJDFqXs5moEh++XMuw8ycOSBSewhtSognK25Ti1cxljZi84ChSJAj1Kts5DCFueJF12ccBrwxv2Hw3YrFFU3S6NZaEhtUx1fN5dPUZE+iQhP/doJbmw+RJtzprfy//tBTgVE/gK9iyecH8HE5Jj2DYmjVKLTo0FDWCP6ENnLMrudfBOmcfjxNNow4VVi64jXk9061xUhFns798AAC02j+HAMJYIHmNXvsSaPvK1FE3KX1N1mHGkSi7vaVcZ+yBNkUx/c7r+XoBfArRFfmLIsuRxszb6SderEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpEdUQyS/j1NiwHAMZe/QCpadD20Y7By+wnz+R1Abco=;
 b=VFc9dnCKb1NTGcDhm80B9JoZBQQIy7f2Vc6ftxxMEZTKKAbHCbPlS6G9vKEMlptEoWD7oteLQ38tKqdRa4yag4zffnGxr4dhSyCieCuUGQ9DtSgfFissakaykVS5JF3nmQ/t8kXNw9zZCYVi0H4ujZTdT1MQG9y23W4Qk3UEH3U=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1895.namprd10.prod.outlook.com
 (2603:10b6:903:123::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 10:54:02 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 10:54:02 +0000
Date:   Thu, 6 Jan 2022 13:53:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/23] counter: Provide alternative counter
 registration functions
Message-ID: <202112290340.PMwi47LV-lkp@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211227094526.698714-14-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::21)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32b84cdd-a862-4928-0723-08d9d102d916
X-MS-TrafficTypeDiagnostic: CY4PR10MB1895:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1895C559D15E020D1301451B8E4C9@CY4PR10MB1895.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKyhOcFXh7wRk6m6phcdEGIFyPFTD8+RCZVFkFe52na1OTb/5O3d9dWvo/W68b/v2sJSTNjiUSghjfnA8WhljB7lFI+CmWWc7ui95qnolHsmxEG9LGzgOYiHlzrgUq8ZnETRjs5sxQlFOoxqX10HGleWpNIkFTMABD29wQJTqlUQtuYtZ1BQBS0jgpeY0pVtgKeZvCzOBcC4TYIKhZ1aWEBWQr5mQUFQ4lGPtT3/HycLIJFeVZ+bZD/Aa7kYdtzYZBXlV71BkkzPYG9mQstFjQ3eQpGsq0LKHoXh6QwgEJEokmERgDpPuDOokfAF+FbJMPXS1ZcLCv0ipug7hSAvuDh/u8mEuyS4ohSr6AEonsRFFoSaSuDan41jpZw5sVUlfpQchJdeGhNwyA2pQTcdOIaPpli4lfMdY8Xmq8De9PTmL3P/8/SyAzbfxBLbEPfK6icI68lJd3snLklQ492WjJatG7xTlCi/gcVgX7nA48ZPLWvOTk3HDVwbLzC9tn8hWjBcX09prtOITxbvASNOlQsQ2zP8qY5TcaO2efST2gQ/x1PX0NL4YBHCS1rWZkeD0vERTHBTVVlr4Md20OuZdl39P5M5bCsu7e2FQdv3w9qdappfQcQBeKQf+1wAmbzkHIPMo7RNSQifNLx0nFHiQ4yJCmIeaMgXcypG4UG3H4/Tx/s5mkf9r4CtHppPZBCH6dDmugpkX2rEmgTFjsmN5ZUcj4ILakKDERg0ZPvlnAVlOjWmc+APnlUttMMXHIm3AMSNs4XeUyeYOwDnfiW7KXY58Lh4KiU2EeLYHdjCXBcy9qf6VrnH4lwmnKv/NAUoFLWoJael3aHYTitspxZ//w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:de;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(1076003)(36756003)(38100700002)(9686003)(6512007)(7416002)(54906003)(38350700002)(316002)(5660300002)(110136005)(4326008)(186003)(66476007)(26005)(66946007)(66556008)(2906002)(6486002)(8676002)(83380400001)(6666004)(966005)(508600001)(86362001)(6506007)(66574015)(44832011)(4001150100001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3Skr4mEFFJiyZ1SljyV8vHIG7k4VdNkK4kxnNINAmOr3lQolTt6cZ12J9A?=
 =?iso-8859-1?Q?NN3xic4HcP3aPcGsjeoymKc0671ike3ROAmvNmYTwhwKB5W2caxRB0SEdr?=
 =?iso-8859-1?Q?ZQ2x0scjbdBkyaLa1pbyCGCs20drej03nWFcbGA/l04/YCVLS5LCqsMHZI?=
 =?iso-8859-1?Q?+SjhAtjJEz9VMaHP57KjIbFLxFDUjY6pNbYs0iDzpNARZ5RZQvbm+Xeh0L?=
 =?iso-8859-1?Q?cD5oLPfTq/kKTyZSe1Vu2FERWvPZBOV9bpo9NzlA92H3FYf7vK3jiqlkit?=
 =?iso-8859-1?Q?Oe3UVo21mo6GVGNOVQYKFxgJB+HFXfEQs2wh6YMqUsbzwpoStWV1X5eE/0?=
 =?iso-8859-1?Q?OryZ/FlAhwfV80Gv629jZQiTmJuKN32oYiPrlhI9EYi7tqAAUmUjZ7/wb3?=
 =?iso-8859-1?Q?C5X4H6w4GCT/G9R+3d/FK9NYtJiOPeiHkeEGrT2Iya2xdXMSr+HwXzbBIl?=
 =?iso-8859-1?Q?3UxKn2v7t7zqIWygjiRBOHBH/P6zGFflqOtxR52Hm2gOgiElbwWnJzA+2F?=
 =?iso-8859-1?Q?Jw4geFwKoqlnoJ5j7+reCe7uegOrhLXMb6fO0lxXlsi4WtiNGsRTOifmwA?=
 =?iso-8859-1?Q?HoW83eLDzJjPnkI94QBaU9wIClA3jQOUZMQjcYCuG44Fe9RPR4TtlM2gqX?=
 =?iso-8859-1?Q?igKRECvMeFLa9IjVxBgyDe5IxQCLwh1qSX+eod822JPxDjOVYPRKcbzIz9?=
 =?iso-8859-1?Q?eL6nkTej2YXhgdt7AgT6yp1N00/UNZDkOh+7ulpYrb03+MujgGA1+H3aRe?=
 =?iso-8859-1?Q?3pn4RpK8GLKYBshR8TFkhenkVPqJ2xMQtId7lLKXrKqllWjvgPkqt7Y4pK?=
 =?iso-8859-1?Q?AOAsL6y0sub9+FV1IavFznw2ec1VL7/aYjgUxSt0dvhoYR20JIHTh9u/SL?=
 =?iso-8859-1?Q?HYoTVp36QpxN3lPDLPhU+5hoQaPjhEqw5GnnJi6fi79nZR+eGRXDKciSay?=
 =?iso-8859-1?Q?/wH/dV+Kq0o9uhp2bkITblGtnwtfylWG47Q6vI5DYEA63bDs0pFUaJEnDM?=
 =?iso-8859-1?Q?YSNCWkGxj6WzFXbF/9Jm6ZuwbUxVXxHcpEqlDffDxvzU9k0+7cD/2+ehCN?=
 =?iso-8859-1?Q?vWnPll4momi3E6L2MARzzw7rB/2w8hOmwIc3aAaQLJULrMSooGq2m9bL7q?=
 =?iso-8859-1?Q?s0LwA2stclH2OCCBKFSPd8imqge51ylZpEpB1YbrSETzihfLfvMd3/w3Gy?=
 =?iso-8859-1?Q?C1PrvJZLCx3B8pgWbVkUgJ7JYyRS96WUTXJq69Pc8B9YjevytZzEW16glu?=
 =?iso-8859-1?Q?uMOSuEBYOGR93xq4ByDL1f1SXxR3lqvO7+YINPlLh5M6hjEk7ynYKX7za0?=
 =?iso-8859-1?Q?K2RJW3LABkzm4OtwjGLzpmFbZUAOGzAL3934kUmhRC/I7JTe0OP3BkHvMI?=
 =?iso-8859-1?Q?tYdCfhgzOqcxNoIsyjS0iSScB2GFXHTpb+EfjpEsExPt+tDVQQ9yrBicTq?=
 =?iso-8859-1?Q?fi5RCkQyotNw4binNnvB3AoVsd+qE5rrlSeNvMCHXRsmxKjtbKxIC2QycK?=
 =?iso-8859-1?Q?l8nBRk7VAwTtMG9+rSE3gD3zMnkP0OnjXSxL684tNZkYi9Cf9htdYGHY4C?=
 =?iso-8859-1?Q?pqcPb+e9eLD/6ysGNzNz07YIHgJxn0ftG9qQpXbuLmC3vomlpynuxDQUBD?=
 =?iso-8859-1?Q?rdklTR966dGlqtY8mVw2cBdJNstuO9ZKzmTwwMxMU64DvqQ6AdEC8q9ZAt?=
 =?iso-8859-1?Q?xS/FfmJDQVG0rFV0AaQp24DxvyGhGrfepG2l4O2ZlJh2qhQW72OMa/iHm7?=
 =?iso-8859-1?Q?IB3qj5ZnFhknWQKoL9OzKWQ98=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b84cdd-a862-4928-0723-08d9d102d916
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 10:54:02.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGzP1w4xXRc0PTsJ16ZB3/2WbNMdvtCDyvA+I+lijEtDhJHscJcIqbsWdK+5zp+7nPpkZ0oFVjycp0LV8uC/YQFVnAjxfpsBorIEkP04Rc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1895
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060076
X-Proofpoint-ORIG-GUID: 1a3fwffGtdMVsO5ddlE9ZGRkxWbNG_PW
X-Proofpoint-GUID: 1a3fwffGtdMVsO5ddlE9ZGRkxWbNG_PW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Uwe,

url:    https://github.com/0day-ci/linux/commits/Uwe-Kleine-K-nig/counter-cleanups-and-device-lifetime-fixes/20211227-174815
base:   a7904a538933c525096ca2ccde1e60d0ee62c08e
config: i386-randconfig-m021-20211227 (https://download.01.org/0day-ci/archive/20211229/202112290340.PMwi47LV-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/counter/counter-core.c:175 counter_alloc() error: uninitialized symbol 'id'.

vim +/id +175 drivers/counter/counter-core.c

250e0e3d91caea Uwe Kleine-König       2021-12-27  144  struct counter_device *counter_alloc(size_t sizeof_priv)
250e0e3d91caea Uwe Kleine-König       2021-12-27  145  {
250e0e3d91caea Uwe Kleine-König       2021-12-27  146  	struct counter_device_allochelper *ch;
250e0e3d91caea Uwe Kleine-König       2021-12-27  147  	struct counter_device *counter;
250e0e3d91caea Uwe Kleine-König       2021-12-27  148  	struct device *dev;
250e0e3d91caea Uwe Kleine-König       2021-12-27  149  	int id, err;
250e0e3d91caea Uwe Kleine-König       2021-12-27  150  
250e0e3d91caea Uwe Kleine-König       2021-12-27  151  	ch = kzalloc(sizeof(*ch) + sizeof_priv, GFP_KERNEL);
250e0e3d91caea Uwe Kleine-König       2021-12-27  152  	if (!ch) {
250e0e3d91caea Uwe Kleine-König       2021-12-27  153  		err = -ENOMEM;
250e0e3d91caea Uwe Kleine-König       2021-12-27  154  		goto err_alloc_ch;
250e0e3d91caea Uwe Kleine-König       2021-12-27  155  	}
250e0e3d91caea Uwe Kleine-König       2021-12-27  156  
250e0e3d91caea Uwe Kleine-König       2021-12-27  157  	counter = &ch->counter;
250e0e3d91caea Uwe Kleine-König       2021-12-27  158  	dev = &counter->dev;
250e0e3d91caea Uwe Kleine-König       2021-12-27  159  
250e0e3d91caea Uwe Kleine-König       2021-12-27  160  	/* Acquire unique ID */
250e0e3d91caea Uwe Kleine-König       2021-12-27  161  	err = ida_alloc(&counter_ida, GFP_KERNEL);
250e0e3d91caea Uwe Kleine-König       2021-12-27  162  	if (err < 0) {
250e0e3d91caea Uwe Kleine-König       2021-12-27  163  		goto err_ida_alloc;
250e0e3d91caea Uwe Kleine-König       2021-12-27  164  	}
250e0e3d91caea Uwe Kleine-König       2021-12-27  165  	dev->id = err;
250e0e3d91caea Uwe Kleine-König       2021-12-27  166  
250e0e3d91caea Uwe Kleine-König       2021-12-27  167  	err = counter_chrdev_add(counter);
250e0e3d91caea Uwe Kleine-König       2021-12-27  168  	if (err < 0)
250e0e3d91caea Uwe Kleine-König       2021-12-27  169  		goto err_chrdev_add;
250e0e3d91caea Uwe Kleine-König       2021-12-27  170  
250e0e3d91caea Uwe Kleine-König       2021-12-27  171  	device_initialize(dev);
250e0e3d91caea Uwe Kleine-König       2021-12-27  172  	/* Configure device structure for Counter */
250e0e3d91caea Uwe Kleine-König       2021-12-27  173  	dev->type = &counter_device_type;
250e0e3d91caea Uwe Kleine-König       2021-12-27  174  	dev->bus = &counter_bus_type;
250e0e3d91caea Uwe Kleine-König       2021-12-27 @175  	dev->devt = MKDEV(MAJOR(counter_devt), id);

"id" is uninitialized.  Should this be "dev->id"?

250e0e3d91caea Uwe Kleine-König       2021-12-27  176  
250e0e3d91caea Uwe Kleine-König       2021-12-27  177  	mutex_init(&counter->ops_exist_lock);
250e0e3d91caea Uwe Kleine-König       2021-12-27  178  
250e0e3d91caea Uwe Kleine-König       2021-12-27  179  	return counter;
250e0e3d91caea Uwe Kleine-König       2021-12-27  180  
250e0e3d91caea Uwe Kleine-König       2021-12-27  181  err_chrdev_add:
250e0e3d91caea Uwe Kleine-König       2021-12-27  182  
250e0e3d91caea Uwe Kleine-König       2021-12-27  183  	ida_free(&counter_ida, dev->id);
250e0e3d91caea Uwe Kleine-König       2021-12-27  184  err_ida_alloc:
250e0e3d91caea Uwe Kleine-König       2021-12-27  185  
250e0e3d91caea Uwe Kleine-König       2021-12-27  186  	kfree(ch);
250e0e3d91caea Uwe Kleine-König       2021-12-27  187  err_alloc_ch:
250e0e3d91caea Uwe Kleine-König       2021-12-27  188  
250e0e3d91caea Uwe Kleine-König       2021-12-27  189  	return ERR_PTR(err);
250e0e3d91caea Uwe Kleine-König       2021-12-27  190  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

