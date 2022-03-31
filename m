Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759F94ED634
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiCaIvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiCaIvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:51:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AAE3A712
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:49:53 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V8dkG8007047;
        Thu, 31 Mar 2022 08:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=GXArqr/FwjisUDSIb33Yi1XnmQcN/2wWnFNrsfm50Rs=;
 b=BRXIS4h/AMKM0HBhvruQ3dLd8kRXBZDDgUnVdjJIImoTfdA5S3uBGK539SLRxLKHTCY5
 7W2AdriRuA4787mEVl5srqcZEGiZFq/cqWusNOLP76Iu08W0PEC0JAtMF+22l8wxbOg6
 xaH5aOuJWg8SwmrvvfZqvlS1PQsG/MnKqgimXS+ZX2Xf8ZnjTJ+mZrCYvtBbsw35IFRl
 vLo4z/+5wBmbkszdELZWdsdw11JwBdS0RWUnXf5OLPwIY0w9njINaW7M2BqgDpujEXiq
 6sM99X4pvtvxVfpbCHRz9uvSAuovgUH6yqTwXsG0UZ7BNKqgvzwR6fjTzYAlCGK75NSD sQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tes3py3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 08:49:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22V8lNsu021775;
        Thu, 31 Mar 2022 08:49:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s952sf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 08:49:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktyJQK1CkyOrvQM28cVBcX9rFYX4YwrEwucKTbfneU2NSDhJuxKI2cZ0MCvCoYtFOffNsLmptoyxonXmzCH1FGRK+HXsPd7tApvvppVBBSw+TmqX1qXkWvHDgKRJ3dNovmB4Xlc5kQ5H6giyndq4ei5jQX+hZt6jJa9Zdn+nQCt4sjSdrb95JL3jbus3rHoSgBKI/7vyjV9/Wq5KYIQY1JRT7REqEwE2P1a0dfXs6CbxiiogkkxGbDqQbvPA8RaLuJqHHJuS0TvI8SG/HyoiTzdg/Skrldqe6PiKiDjfm3LQ3ZYrHaIHUQW/HvK8MXiFhI7pCWl6/hhSt1/f7ZHdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTF06C59XGo9pBwnkfcnhRWPAw9csF6VvItax/rizQs=;
 b=kzpqNYi5kYOIUt/86EegAWk3PwVusLlwYLuAcZ+Hl9kP2Y+600n4ieoPjDyyuISAAGwbZwnKZZ95Xg/2Lza4215vV0u7Q8b4YjdkPVPJuNkvElz1fDIPmO2TzsPTqFuHrx8/NgvrR1SC0ubp2NooUhbZ8ZxmXHc1B0ziPriMl4nPbe+Ho0BpVRGkyYnVGODxxFr7cgg83TRezyBoBI5dGnf1SMjhvXe2k3hozuQFX9MD4Ke5q7gRDW/1boTTiB7Y3qm8KGwSdbxOVc2IA0XBr7/fz3Ylj12CJgfa5y30iaA6qQqJ8PIU1pr5Vc5JIY9iaozAvUrLqK5txgVm7ld55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTF06C59XGo9pBwnkfcnhRWPAw9csF6VvItax/rizQs=;
 b=ecyVTYy7CvMiVjmJLNlEaQWOoDp5fIvhJTT7tgk/2b1i5OLMCb/xsXPhgMCzu/GyzTihuC1SzVROrLzp46ysJV0sOZ9ydiYOns1vDi2NNmhbOyCKoS3lE4/BB0RkqPRZWb9yTtz4PY2hta+5XeccohhlUW7fO03FedpoMQYqvso=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com (10.174.166.156) by
 CH2PR10MB3749.namprd10.prod.outlook.com (10.255.156.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Thu, 31 Mar 2022 08:49:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 08:49:40 +0000
Date:   Thu, 31 Mar 2022 11:49:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Xiaoke Wang <xkernel.wang@foxmail.com>
Cc:     "Larry.Finger" <Larry.Finger@lwfinger.net>,
        phil <phil@philpotter.co.uk>,
        gregkh <gregkh@linuxfoundation.org>,
        linux-staging <linux-staging@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH 2/2] staging: r8188eu: fix potential memory leak in
 _rtw_init_xmit_priv()
Message-ID: <20220331084920.GB12805@kadam>
References: <tencent_12789CD2DEBF33C818B3542E170737854506@qq.com>
 <tencent_2F72CC5068850B2BEDFC2B8058303FE6520A@qq.com>
 <20220331073555.GK3293@kadam>
 <tencent_B595FD8B8004319BE5AE71A052A08683280A@qq.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_B595FD8B8004319BE5AE71A052A08683280A@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20e89b79-7bc1-4bf7-753a-08da12f36488
X-MS-TrafficTypeDiagnostic: CH2PR10MB3749:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB3749AFFB56B7CF8D89A74FA58EE19@CH2PR10MB3749.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0rD9k4i3/jallwfKXGSzTrj+LQvxTkaZu22nstW0MIqhi4T6omTifqwFnNP6d+zLE8IsPI6deM6gu9fNijBvQp9HA8LVSu2A81Naxy1yhSbeT0qcTam2qGOg/ONsXtQJFTfAISv5/ODB3cFsEM8ZZ/LRwBfAGT6No9E4ivcSp3rrwfxPtj9+p6C7kmAwawyjshGLByIOskZQ6XeaO5xwnjBT+NUM0fwB6/cCwvBlcGON9f7cgmliqrtPzsFOv+jKO9omCCBvJWwiNtE1znKudwnAmI6Ks6LWKLBAl6TCNxR/tH4yHvVAXqsZ/9earl8MIPtERs5rfkSU0h3G2q9qGG1RULOqLmH936tsUb4gXUbJ99BImR6v01LfEE1CjHlcZjFvQbxsRybfvxgXY64stVsuxmUiXlaGNUvv8f3gTAg2ZEp067xGh6N7IQq1bTq4BGwUdB24chOqj5MPkvvQLiCumNGZQuiGLHjheI0FLn5Sm3EMhXEGo0pdMRxegK0ZevRHGcXSLmQi58NP2tPEy5wkv5VLV5ZK1/OFL+QpMNl/AZuh6jS1VY2PxAnxU9TVyG1n+VugEkInZbYMt9uYHlCdwj51hxmaOrGTKm7QGm0VtTRh4fNg57/iO8FnlrQF7I3usMxovoaTfnpPH6/akvAqUhgkw6j6+EXFOu+G6Mg3NbF/OcBwDDLaThSe2FOXZ1yXs6ROziUQfJNqSI3wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38350700002)(38100700002)(6506007)(52116002)(33716001)(86362001)(83380400001)(9686003)(316002)(6512007)(6486002)(2906002)(66476007)(6666004)(508600001)(54906003)(6916009)(44832011)(1076003)(26005)(186003)(8676002)(66556008)(8936002)(4326008)(33656002)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YhL2QB1+rPNt2PCmthcdIEa9T3BVLcXOLBk+tggeERgHZRbSWu4LfR7CQI?=
 =?iso-8859-1?Q?fNyqKPZtC6VY2KPmXN9KDR7uEK+ALqvStDxbrbjHjO8JoMNtnbVukkR4qw?=
 =?iso-8859-1?Q?W8yhcqe25xtIm+tjDK+VysxclFe/3NhLa+WLqoyD0morlchP/iZ09Fkp/B?=
 =?iso-8859-1?Q?1h4vvC2fpCsUg5h0vrhy6uszqKYvh4GKV/gINQ7UZ3pjyNiE4iDKyLa5vH?=
 =?iso-8859-1?Q?RJESRjK2vPkcEjgCKRuSRmFS3JBmWxxV5JdEbZjSgQHDNnDWNMioAxRVcR?=
 =?iso-8859-1?Q?epApbPbWwBwH4jZ9mwHI9SLUKm2uoWkf+dJQgt+4x/7XdmryJCVTmu/MEy?=
 =?iso-8859-1?Q?JjzHtWf/HFWDn6XIjDD6zz6b/vc3FEfMnJFBPrD28T6BIi06oAJDzHQKuz?=
 =?iso-8859-1?Q?QHKcOn2gkBP3+L+3YX5cuA8JjJ+9nAxz4AFcEqM6x6RsXpVRh/8A3X+g8+?=
 =?iso-8859-1?Q?QlDnbGLHO+WeZ3pS9Ce0g8B2Uid+6Wg1jwzWSuOJ3mTMfmx3zBPOcuvI6z?=
 =?iso-8859-1?Q?bJu/QzqDSGIZI8km6jiB5W3E5wLmdyLH/mDH3ejkgbCFlQ7AEWcOnhMsMz?=
 =?iso-8859-1?Q?OZLHxw1X9slsI8fMJwmlwLUoS1l/EaMj2INJeCi+7Ec43FcgfWRnxFG9ap?=
 =?iso-8859-1?Q?OdPGc9JkdW8nk5+BY6PzcxsamusSinJ3fN4V0mOAFoNMVvEQLfLm2zQXn9?=
 =?iso-8859-1?Q?5KRe8AfMWWUNVEWQn3nwVQIQE4I7eT8DwwJ6HJb6lcGSpAtvHDrdesG/pu?=
 =?iso-8859-1?Q?iCHYEAuM5f1bS6X8M4PPUC/0L0/uFbNQUqrYHdYnHHQJbHLDyYE9x71pLq?=
 =?iso-8859-1?Q?uIhJ8v2zuFmuMBdx6DLW8Ffwh6TWpXztTscC7e3Z5mEwE02AMv8yMP+MF0?=
 =?iso-8859-1?Q?HcMKlnhtAZbqgc4lA2aaXXMDLm3JRQao5z/E20ZlGsuj/3j4nq/g0NkwWA?=
 =?iso-8859-1?Q?qczM7GZbRNsv5c6bXBbxGJZrON0GwLC+AkgAc2q2uxmEDvDS6ac45lpHu6?=
 =?iso-8859-1?Q?bElr1TVojsOqqsmn71JdUbyYZwMbwkO01BDt4dtFqhGPBvCgA8JlYIM+JX?=
 =?iso-8859-1?Q?c0OH+QffT7W3JgZB/ik0DmamSkb9UXbGbBpP1p3Zvg7sTZ4uByd0/amv+T?=
 =?iso-8859-1?Q?qWr7gKCDUWP7fOTwd35XpPNZ2DfOAGu4i5sFtRdOC7w1MHo+oqwSrqhgQx?=
 =?iso-8859-1?Q?2zi5Vd1IgLF5VEOCQ8UsYSuQ7aZ4CZjiRTqEoPyyb+FK1BbHPo3th91tQz?=
 =?iso-8859-1?Q?oeWYhP0Q1DS5CQYHm+u3AjOo9dt6joVIE5MJxsKmNovaquajBsZra8Xtpr?=
 =?iso-8859-1?Q?ENkY4irAxXos/dQywqJ7Kl9qGdUFqKcpD7ch/Q2Op/hckYFYHsaLlaJ08j?=
 =?iso-8859-1?Q?q4tDsQ0vUusp7DTVWAUo0kkjC6vd0vVMC/hRsLJ+dd0M9nzLpmXJNqEkFB?=
 =?iso-8859-1?Q?yrL+mNBL36yJw61GYpdBQI+2sFHIQvVCe4jMNIgZ8mxa9nJz1Pv2e4Erj+?=
 =?iso-8859-1?Q?gxT/4WN1pRItLXC7rJRLxSw0cTcCgQDQ8vq080P5K1mzOP+7uNpSZnOXf+?=
 =?iso-8859-1?Q?PC6AIjukocnM6xQ9YhxbOWlSjC1oFQkevD+TmVmQaH/Vh4TG3qhG+0fnDj?=
 =?iso-8859-1?Q?13MR3fCj3G6+DL9eWPdvPyMo34VKPUPM+CVOiXaXYq7hYqcWb8LH0/ixMa?=
 =?iso-8859-1?Q?FXaKHd4JinHAqeXDfY4DU6SW+/bCBHZjknULA40a1FRaSgLTX75yogpbIs?=
 =?iso-8859-1?Q?ovQmo+SCObEWbdMrZsPYoE+5dMcmqI3W0NEYRyoC9Uzxs4wIRmKLxNY55i?=
 =?iso-8859-1?Q?Fqy9czxKvfve24xJawliwbQGSFKl5fM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e89b79-7bc1-4bf7-753a-08da12f36488
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 08:49:40.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPJ1ekpjqIJkK/fHflS6usJdFQgkcn9BCmpcrp+M8yT7lpzsW0Jd3oA60Z+w5X6KRTIJ6osEokTEzAZQBUlyvFjeMoi+xHIpFzgAM2XJoH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3749
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_03:2022-03-29,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203310048
X-Proofpoint-GUID: E6rJiUeNfNbQEmwBLb4LsuxOHNTMpQaj
X-Proofpoint-ORIG-GUID: E6rJiUeNfNbQEmwBLb4LsuxOHNTMpQaj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 04:21:45PM +0800, Xiaoke Wang wrote:
> On Thu 31 Mar 2022 15:36:21 +0800, dan.carpenter@oracle.com wrote:
> >> @@ -134,7 +134,12 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
> >>  			msleep(10);
> >>  			res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
> >>  			if (res == _FAIL) {
> >> -				goto exit;
> >> +				pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
> >> +				for (; i >= 0; i--) {
> >
> > This frees one more element than you intended.  It should be:
> >
> >	 while (--i >= 0) {
> >
> 
> In fact, this is considering that we do not know where is the failure
> from. In rtw_os_xmit_resource_alloc(), the failure can from 
> 
> > pxmitbuf->pallocated_buf = kzalloc(alloc_sz, GFP_KERNEL);
> 
> , but also can from 
> 
> > 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
> 
> So if we do not handle the current failed item and just skip it, then some
> memory may be ignored.

The rtw_os_xmit_resource_alloc() function should clean up after itself
and not leave things partially allocated.

First of all MAX_XMITBUF_SZ is 20480 bytes.  It's giant.  We need to
figure out what's up with that.  But then if "pxmitbuf->pxmit_urb[i] =
usb_alloc_urb(0, GFP_KERNEL);" fails, we allocate directly over the
pxmitbuf->pallocated_buf on the second attempt.  So it leaks memory.

Every function should clean up after itself.  No partial allocations.
That always leads to bugs.

regards,
dan carpenter
