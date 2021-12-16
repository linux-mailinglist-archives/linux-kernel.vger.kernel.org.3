Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAC5476B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhLPIGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:06:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19200 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230324AbhLPIGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:06:44 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG7hhgO006553;
        Thu, 16 Dec 2021 08:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ShMltKNkVNAXQ5JGBIxZ078c7Ar/PUKnPNl+hfDjn8E=;
 b=G3mkF0UjQdjrPKveoL3RjmO2Rq8ydgfcMt9Pe0zNrsvQSdlGWl0dN4j9bVWvixshumpr
 7Nr9lbXUp7/9ir/SAhZEEN068a99vf4AGFNMMr6MQbhexRZ2+CC01mbpOkO0WqWY2guh
 mkvPUZXNscL3x7RWZcLmZ866n9iZXZp38o2j3DVcEemh3pgrQByXOV+wZ5Bdlpqjy2qh
 Pa2xeyy7fSy8Ftvoiu6Fu+JawM8WpljqcFrceNahgluxTumlfidWsa608TedpbTV4C70
 z3yWnP0AWfCtfIYKcX1oEsu5yelrGfSGftKEBP75lEAKJTDktdriMH5a85tAQntJ6X1A 7Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykm5a05v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 08:06:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BG82ACE041088;
        Thu, 16 Dec 2021 08:06:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3030.oracle.com with ESMTP id 3cyju9hqk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 08:06:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uqo5q6Zlt/YlFdNcnONaKylHkbP+YKxrdLs3dJ7rDuitAd46MHfpHIga4CqYOu3j1ZZdT+JwFKLpEKQ2UnUkWON5U0K01I68F7Zr8tJr+dwd5hxjXIAxJsI06VteuMF1ISFB8zpS9NuICZ8SyV4sZR8OZ82+qMQa/H0pUUT1KOZllkYgXGAy8K7a5tFbcgJ46Q+YB4PFYU3mNbqZcDEac+HfWV0MZpbCYenGUwmGGZ78+Ovq/6a8FhYSYXVHdUG0c0AnwW+6xt2JJNokbh54UNSAYL5QslZxIDld+/crkSpWcfJUAGx91ITjoNOK1ceCMVSxW1qCLr6104s49e4I9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShMltKNkVNAXQ5JGBIxZ078c7Ar/PUKnPNl+hfDjn8E=;
 b=MI967/UDEB3bvjhygnFZbWYUY1XfsOcTSB3Ui5VQ/w27PokRGFgfMnCoZ/OC19BqxiIfhOVdCRvjlbgHDLgI0/JcIobThDfHBhFschha1oxoSu0YV/mlyuJa+eEkjICJ7iyYfbP3t119RvrsP3ftakPQiPBdPIr+zO49hYKgyCZAvXmwyuxrRx4dXIeIPd6ifptdVVOcBfKR3Qg963K69JLhWQ9j4v+Wqwel3sSmuTkEhMO1C29a4Bd28ZRAx/VXHjBvPOOstcYTVshXatrPQeQIA0wxGTsSg6GBVuLOEeFQicW1rqCsvDfPOrNvpZhe+UaXY3NCXqSXu0RszF32hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShMltKNkVNAXQ5JGBIxZ078c7Ar/PUKnPNl+hfDjn8E=;
 b=pfTkWOi00SPb04RhspJIbtVOTESuNrQg8dPfQ41KMFLz1JvaeI8paCDmt5kEHDZ3EvTxPb9fCwKh/P8VMN5yE6d/9A4Xyfgi4YGkwwshyrNXYmF16icEpZclnlRSDJvGVjXHvwoJLdONx+vyM+SozDFyxcR1gvGuAYe8wGlolWg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1294.namprd10.prod.outlook.com
 (2603:10b6:300:20::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 08:06:20 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 08:06:20 +0000
Date:   Thu, 16 Dec 2021 11:05:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] extcon: fix extcon_get_extcon_dev() error handling
Message-ID: <20211216080558.GE1978@kadam>
References: <CGME20211123084357epcas1p14833147710153f9606f14941ac8b0d96@epcas1p1.samsung.com>
 <20211123083925.GA3277@kili>
 <562b12ff-e395-c818-787e-7fd6ee6d53fb@samsung.com>
 <20211216075233.GD1978@kadam>
 <b4d0c326-3122-c5f9-f376-b122f263d92c@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d0c326-3122-c5f9-f376-b122f263d92c@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 155fe366-0f18-42dd-d326-08d9c06af140
X-MS-TrafficTypeDiagnostic: MWHPR10MB1294:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1294E26BD731410EBD7B50F78E779@MWHPR10MB1294.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFRIL6FrGetp8LtbJwqPVo1iVS5i+r7staf0g98g6ef6bVxak/0soSuL5d7fGpFbeeCb8w9X0yRpAgazENeE6IwHJmpFgHQ3vO+36LSstrGrh5RchkevPGiknuFlXNHRUU88xI2PF8dNVMAluuiaCGbnQidcEVbW4npg6dMspYRqdfRAkJie0Daz5qn2eoXpiRpWLtfIyzsrnUQyDyfCTZHJc4xFq//jIs/nVrKnDkRrr2fyPBF2zjLXneOyslHutNKPTbaJTsL6xJxNjcWiIAbwvJEPS9QeIlpDPiSQ03SgCpWyxHXRdAoeZ3G5AEVcbyd32hbemgw3Z6TlCbR8fZvdAbm/sTYpKs1kx9Wx6zW8SCOZCrIteiodgSwJlGk4gTnwCUlDeoYK7sFNEyWelfV0BhVEFHiGZzlPeKN18EsRCzO5icZcRNb0NafizuykY1CHi9FkyHSKYhFEZGMZyyWh2ERGvYJeZK0TJHRD0tv6ASYN/jrx3FnLLYMKMvN6fQwr09gA4ap5WUefhFOv1xeiyJ3rAWNv8cptqQhjsBeoi2hGey9yxOhbfeVJnD/WfvJPfU+c8PMmr7TQYFmU4FoTVQJfOrO3GxRgk+roiJz7YDlCbF3vlxFnFLq3Up1IxSdliDN9wfplVxyXM4adoCFlqgKX2IMCMyNzVZFFPu+AMbMfRjpTYXiaptEd8RrGj+599E+Bm2EaGyL6/hXNbjo59TGIeIlr950UQaVjtRF8zxcHwZaZbmf/MhvqQAHgHmslQyergyYp5D+5Bo1eYaOcTtuS9tubYbWSwap/wEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66946007)(52116002)(6916009)(508600001)(86362001)(38350700002)(54906003)(9686003)(33716001)(1076003)(6666004)(966005)(4326008)(6512007)(38100700002)(6506007)(66556008)(5660300002)(8936002)(66476007)(8676002)(316002)(44832011)(6486002)(26005)(186003)(33656002)(7416002)(53546011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/eJDfmxkIrWsKuwSjX8Dp2rvYXI/8tzPMKmOlwTqtME26UzfiM/j4CWz0BkR?=
 =?us-ascii?Q?9O7Meb96bXJ2AF2A+Oog6Ub6t71gr1st2fAVWRDlpyvQKrPZb6B8jGNloLRL?=
 =?us-ascii?Q?YZ6J0imEQXnPYqa2RflwtFFcxvF+n9j+2xj3KGAe8ykrx3DHOm6obP+vOG3I?=
 =?us-ascii?Q?m3xZTqK/6lLVgNho6WtmH8ViMKly2YTuBfa6f2LhZZ1aYb4nLUP9UWtnV+Qs?=
 =?us-ascii?Q?415Weifoqr7k8Md9o6uqaeXqpdUxGaYJlhoFuT3x6xPNLtub19SllY3KS/lF?=
 =?us-ascii?Q?pYpdv1VasbO48Pbbnttv3/eEi8qyDq9H2iIF6H3XAA/GZgVKlj41pqEYMHRb?=
 =?us-ascii?Q?aNDMFBBMVppRR+0XlLC/engTytqt0tswwKgu1DTfexsauhfF1e4l6IhSjWjz?=
 =?us-ascii?Q?FYBhfOcuiGEeWXtd7xfLlwJ4mY78viZaSt7YIfleA7f1YfifIq7dDkYygFnt?=
 =?us-ascii?Q?2rLJPR0oY0Ip2fqbVeeAxiOswgpeZSErQd7aRnRwMu9K9CvwHO9f0hUW8/4T?=
 =?us-ascii?Q?/xDcApalu9IdAxZPxYP99ZMWnIpXdqUMEFKDDaR7vQud9Qj7qhwWi9KGoESV?=
 =?us-ascii?Q?n9ffwUaEuk6nt59+FsRkYmcHz1WZA+vuCzkRQELtk4CqKhOpiXKLOFgn8s33?=
 =?us-ascii?Q?ibzUMB9Z/A1qIILdn9EUKy32boU2bZGuJzS1yfkqGLZ3rYmhlZ8wGjb1MWiO?=
 =?us-ascii?Q?Rr45qYuvQj6VtEjO5Y9it2zmfFv+qFY4EZzqo10e5E8up1/dM00eGzpNEx4C?=
 =?us-ascii?Q?4r/hFQAelZ+xdx/09MqXO1FmLfG3iR1jqaDJP5O3Jno6zJeGoZQrxW6m+TID?=
 =?us-ascii?Q?2PLnMDGrNojBOY1S+6ytfu9FrFguewKNasBw/a9oY9Uf3KChIPm0EU8lk1ug?=
 =?us-ascii?Q?WjeCDWhDj1hcP6JTy+LWjkgdV4VGIIC1lnTw9RIWK7AB1W+6WdyjcjtfAgGo?=
 =?us-ascii?Q?1zLoKU5CGw8GXNsLNAMTrNpefWGn4wv/FT5a25PaN7NfAjIuPM7kxC5Ss7JA?=
 =?us-ascii?Q?Fnfh6/eCBqbPeBqscIHv0BVBreWh2cvu1vBw6FB8/DBQSt0lsS1WT8DGjjH+?=
 =?us-ascii?Q?pihR3ZXnIxl7NIAB4G7Vq8al875FKRZykYU6OKp0+NEnzwWzr/CsOCehwy/l?=
 =?us-ascii?Q?9to9j+nOyoO396jmcQVVqgbiEemsIioTlGinCWktNOJrb0fV+8QUI+3T1loL?=
 =?us-ascii?Q?UjOderK4wWXddE6Ezo7ExnWxEBvC6C/ScfBizwb6YnDr2UG+pdQBAttn165A?=
 =?us-ascii?Q?5PJBI0qLeUsHQKrqM12AUOG/d+nvvFQ4uD6EsJzAGSlxgYmvnvtSoiRvUVhj?=
 =?us-ascii?Q?mIop2m1Y5lzAXItY/y0PLsWWSE6T2lo/wKVlrgEDRzWQMoLwK11QyGUT4sKa?=
 =?us-ascii?Q?MM9qyDwdiTo+8lTKxjV1dEHp2EAn0bpOOCxUcjZMobWnpXDAZ3BoMOpITA08?=
 =?us-ascii?Q?T/xLBfGitXd9r2vjnozFc2p7j/xD3oENFOS+N1BqQ3zKLN2cNNgjMQNy9CsF?=
 =?us-ascii?Q?356b85xUx8vL9zdMU0FVn/pwfauCY0/gPHlIamm09nAORauhkIy5FAY3OstD?=
 =?us-ascii?Q?ujZjxpMax2pq/CxRtn8br7Zi3dYq0wenyFtTupdOQK1GNw+k6qVVyY/fhRwH?=
 =?us-ascii?Q?7fiE1IdKRhawOzvaxSQaUAMwodR+urBACJhh/jNjnEDfGOOuQmp8d6DFrAkc?=
 =?us-ascii?Q?6Wv/GLsVbaHEp9iy1zp8VdcomQc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155fe366-0f18-42dd-d326-08d9c06af140
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 08:06:20.0527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aP1zUJ1gWCKb/fLWVSOubfRbfnLo+mfsg6Uu6MdWy+2RqMTXx0X0ce6V5eFnJoqYGDxyzR8wC7cqyViBJDsVOjWxQRh0ERKMHU7LxxYeE38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1294
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160045
X-Proofpoint-GUID: 2fditgh8u7vH4mUBjSZVD1hUPmI6yJqh
X-Proofpoint-ORIG-GUID: 2fditgh8u7vH4mUBjSZVD1hUPmI6yJqh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 05:24:30PM +0900, Chanwoo Choi wrote:
> On 12/16/21 4:52 PM, Dan Carpenter wrote:
> > On Thu, Dec 16, 2021 at 03:39:46PM +0900, Chanwoo Choi wrote:
> >> Hi Dan,
> >>
> >> First of all,  sorry for late reply.
> >>
> >> There is one issue. About this issue, I already discussed on patch[1]
> >> [1] https://lore.kernel.org/lkml/5BEB63C3.1020504@samsung.com/  
> >>
> >> extcon_get_extcon_dev() is used for anywhere except for probe step.
> >> But EPROBE_DEFER is only used on probe step.
> >>
> >> So that it is not clear to return EPROBE_DEFER from extcon_get_extcon_dev()
> >> because extcon_get_extcon_dev() never know either call it on probe function
> >> or not.
> > 
> > Currently extcon_get_extcon_dev() is only called from probe so it's not
> > an issue.
> 
> Even if extcon_get_extcon_dev() is used on probe until now,
> it is possible to use on anywhere as I commented.
> 
> It is difficult to agree this approach without any other solution.
> 
> Basically, the subsystem core never know either probe time or not.
> It means that this issue should be handled in each device driver.
> 

To be honest, I'm not sure how this differs from other functions which
return -EPROBE_DEFER.  How do other functions guarantee they will only
be called from probe()?

regards,
dan carpenter

