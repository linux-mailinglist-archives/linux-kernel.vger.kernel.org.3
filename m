Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAF149C81F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbiAZKyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:54:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20254 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240341AbiAZKyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:54:37 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q9eWOf007704;
        Wed, 26 Jan 2022 10:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ic8o+h5FlX+I27h8cRh/VksxayUA7SoJFqGnnEbtteQ=;
 b=tZMYCL0NQNwqsG1QcupWM2+iXfRfmQPZd226fGRXJihtrVZZVI1TCN8HdDgaf9XU23EN
 7d2eqlx7RfP1KPpvTOC9yTaAicYtKmOWSdklRW7LpOGUxAlOn6lRnofHDk0q6GhAvYJo
 I7uIajGF2Y3K4n7BoRCLRjK9xI8IFdOO5XldBZNhpR/El7P85Nj4itStMbLmDyaMdmnZ
 TAfoLTUJkbJwVCRKacEjy5b/wmlkxiTNNCin5FHc5VIkFsGlBNnrrrMrbmhZ34gWeL+N
 bwhMgZzxg/tVZDu01K64Yf/AwbBnY/mmLDnq2FFxkLfEwaPrnvgwWvjnc8+PuVs8SIpy OQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s5s49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 10:54:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QApJes018469;
        Wed, 26 Jan 2022 10:54:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3030.oracle.com with ESMTP id 3dr7yhg0xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 10:54:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6nO4Ff0hARXHFjmAvHEj8Lfg9VuBgzL30AfDMnMqIAtABlA9XXxVO7KcLCbmJtykZ/555132BGq4q2+lOBYkN/YtCBTh+sanLIBlnYL1uiNZewFp//cqbzz20sPY0Z24Dh42DMLDDSMG+zHBppyNR03LQqD81yl9iQsuyHR7XLWJ7L2Ax7/V4iPgJS3lkyceRnnlo7p54UIMGMZ8VCASQpkQGPNJRrSglhx7N6y4pqXqE4O14y+pAQQ+F2YP9PUVr50WX4qtPdEvf8MpdYaX8pC9OWxODWuhItZq5Ks8QsPzZw9LnEKzymE4wdF1NmKRSe8Ds6zVOezwwvjTFM/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ic8o+h5FlX+I27h8cRh/VksxayUA7SoJFqGnnEbtteQ=;
 b=ZXsWZxCcISHS3XTg0ZB/VeRgRDUMVkiNIEbToh8VySpZ/d5QdqvNX2LtdSnlTUo5XuYOsI9pSSzw2845uJ1kkJKsoIoC9JBtQjTdaPfMUS9E4UEco9KAKLKiVRdQBHttfan2VSE8MFGNHsyWqui7JSJC+LG/OnOTYvGC0dErUqlIZ2aj7xm5TIkBOVPEKkOpDi6Lu8Zaoq92jv6pLaEVGaXlBqy/WQo77vL8gisAugL4rWUDnEH4HccHgnkZ7xcssqpZtMBmwaLOgJ04Hfk04CtJaNTOVLGdCQ7QAPwa7Lnkd0nKettJrGWJBlxdtS6HmEg26RTWS9YwVfQbxAN0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic8o+h5FlX+I27h8cRh/VksxayUA7SoJFqGnnEbtteQ=;
 b=iMQ+0+q9RR9SQ1rs3SDKyCq82JWuvRU6XLIAZVxw9t+mZz64SBrvWbCOVKY+Qt0u/df6gxd90Xnw2S/w/o+l7Cx8sjoQGFDQagFaQBBxJxKfxAoFUSPMlVH8zgK9INO/QhI4tvaSGJnetbalJNWX3YCvVCtU15hUhOtdQ0tJnPQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2763.namprd10.prod.outlook.com
 (2603:10b6:5:b3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Wed, 26 Jan
 2022 10:54:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 10:54:29 +0000
Date:   Wed, 26 Jan 2022 13:54:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] staging: greybus: i2c: Use struct_size() helper in
 gb_i2c_operation_create()
Message-ID: <20220126105404.GY1951@kadam>
References: <20220121222250.GA73021@embeddedor>
 <202201241213.82E7D9F598@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201241213.82E7D9F598@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47734eec-1fac-485e-4348-08d9e0ba38a0
X-MS-TrafficTypeDiagnostic: DM6PR10MB2763:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2763E1D36846768FF7CF136A8E209@DM6PR10MB2763.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPlkcy5ve1wJkw78aaZ+Pt6+lGFOP1TNlCJEvDgeNDv05BtW1dseNaeT+oXIOkY0AJ3jw+WTupRAxE1EeE+uZnQquzATNCrPb9xBWJzclKgpFFKTTlAoj0QlUDWbl4FEUrsPIlowPgvXMszTEbionW4sowv111x+fMCStAWLq9TGaejQhUA/aUKnR0uQJTVvi3wBu6TuMyi5X/avgkQBvjw6JyPLVV3XpmMm2pp3OiZIqItfWZ9DUsyLldRPee5lVrtYSE/7Fd6SSIednvkiwWpjh3IQsvcZuaEhFcy486DnE5WFGB9rA5ZYBgErcGgeC9j0VFwf3TQR3qb3FT7/9bmXJQ5K6e2TrgGtl+pQeYZw2gJB9gRBe3XShgea+AN8XH8zZYfF1ingzfVFMO3t/M2MbVqUlpckwPuv4f2w+MI0fuIbLiYAxa+u39udzegrZcDrhgJGXqYe6cDFknC4TIi/NjHadyc54t9xWftlHw1MQ+ZnhrDU+WLYE1xCDCLM6vZ2qZ4LTMRJyICLhmYseWZezXIrFakinmZ3+E+csDjUjQI9WoCUcMoo1Rrlv5xdtwew7z/yjJ8XPbVD5mAocqsg8PE+M5ogmqwnc5ped6DgE57esVi7snIXsa/ze84dEktUEhC2tmO13Oi6YRiyQ0Zqt4rf3qsQn87/eFBeDesXcdIgNNyBXX5rQXiKYYcc8OFttAKVkrrQ8BDJaw5QNxH0T2IRyu/eViN4HclLLFoaLhhAOOS3zSvkg3BdIGOc+BFYJYp1ZO6+z132lk/Ad0eyAtGD6OVuEZCZ0mBsk0t9VAhyuMqkYkOX/gitBrzoi2PtA+4N6Zveuxw8dbITVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6486002)(1076003)(52116002)(26005)(6506007)(316002)(66946007)(54906003)(966005)(66476007)(2906002)(186003)(8676002)(44832011)(66556008)(508600001)(7416002)(8936002)(38350700002)(38100700002)(5660300002)(86362001)(4326008)(6666004)(83380400001)(4744005)(6916009)(9686003)(6512007)(33656002)(33716001)(70780200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jrb6XQser3te3d9/TsArEAfjVF4azz4rA13vg8OkITKMU4UeU/JsZFapPtQW?=
 =?us-ascii?Q?e/4HwDHW6ulgSHDBXzFqpFeIH4KyyJaZj17Vkb4kWU+tIZbiY1UqAkJ4aScE?=
 =?us-ascii?Q?d15psWY1yzsCUhw7Gch0nNvuUSqnE45Tkt355oal+Eh+fS/rn3TMlgG+PHg4?=
 =?us-ascii?Q?hYxpHkZ59YzWHe++lkm6h2WlH0aO6HiYE7itG8vHEJwqu+FbtKITWYlZOgc5?=
 =?us-ascii?Q?SfbX0r0y6bWdbVxZYqRBYvItWgBLAq/j9i6adDuX+BMpcUrzWe1tGxzxuEYX?=
 =?us-ascii?Q?q+543NrZfWoQt8UMIn+JO1Rszpgv6lzbaR25gf9yADXKfmYEjcLAbikdHaxU?=
 =?us-ascii?Q?Dsp3jKS8YL3wvhZ94wnNMBH3nXbeVoIhWG4ZYhG1YHpBd+jTvuA27ENRWtvq?=
 =?us-ascii?Q?lw2JIobwGbglaOPbRjQSTtAz9nDdx7X+1J3X1jXJGGliQxIfW1+3JmAFB2/5?=
 =?us-ascii?Q?aREGU07W7+RzzahKlCpPxh+231S2dcnc1b4bDPqG4KyYQzNvqCJ4kjgYL5Qo?=
 =?us-ascii?Q?ToS2QkOiqCkAtWnK7gwfKwxTMXy6CYqkbamEbCWnP/YanFxXSjC4SjR4SvpI?=
 =?us-ascii?Q?PBFddHA6cU0auAUUuyhc41175oWUU9IMmDc4TEOCfTx59Kh5JYiOKwyX4roV?=
 =?us-ascii?Q?k2LqLv/3GxU4YC39KEMba5YPCCwr96uXyOscU+bgS/wRA/aL3emdiK7cP77v?=
 =?us-ascii?Q?kucre0qQ19FafPHHkLAu8Y4bIUvvOKUCi9CZv55pZWcQO8gE40TPV6ijPyBW?=
 =?us-ascii?Q?mf4jH7CHffznCm5CLEILC98v47jTpMyWVYReX+r0zqRbv26NdEKahPwuOXkS?=
 =?us-ascii?Q?ksFJeiBSGSxL7i8VVFcbfm/8nk+MiyqGhfj9xXtqBHXl3f724RhabihawdG2?=
 =?us-ascii?Q?lyEm1IbXjDO1OoET2saxfYIieF0ezAnZddyt/jRgyyJInzDzp+pxnehVjHsz?=
 =?us-ascii?Q?7urnr61prt1LrICfmoFZNJI8XXD0gAEMrRs353MTODvnOJislzuGwXytCS0U?=
 =?us-ascii?Q?7l29fL74WiM1n1c4ce6LFoXlAPyyqoPJL3WGTNoylVlk/aGh+KBJmUNSt1p6?=
 =?us-ascii?Q?A7ojDnptR9cssZWo68eG5zZJldPTfpB7Ngv/sKwwxuCqkHl+MkdA09WcjWbw?=
 =?us-ascii?Q?2fwDGpalHwZnPMgofwfqXIlkGwK4jNAuOAdkks2SwM/SJbCJilIWvBtBL/As?=
 =?us-ascii?Q?k/izx97dINgK1+s4HzGU2muTTJzqi6SEeb/A5vSDxetwLkPN99wIpTfOYrEM?=
 =?us-ascii?Q?qEY4QhkG329WiOgaBUZ7BKATLGZC6GEsSxZXMlJblUurqiN/f7PF/DE5R0WL?=
 =?us-ascii?Q?xsHLC58l7mxe1Kb3I+ZiP9Yc8gOxW6ADjGrWyri69ZWiUYpLyBJpp7HIvQvI?=
 =?us-ascii?Q?33KexQeSHH1oLaFVb3dRvagyqFHw9vYtvXxzy7RIeJjgpUKntlA3WGTLCPin?=
 =?us-ascii?Q?Ig75cLrpK4TgQNM3Z4VNNEO5LQnm5LnonydXKxr3a5WMyvFc03MjUWrIAHBq?=
 =?us-ascii?Q?Teqc6ncwOu5mLcAUbp24JR79PfIl4XcBq+ykKazCT2jA9QO6KEkydRQfVM4z?=
 =?us-ascii?Q?KretHjD0JHeYEcLfF7ia2RrAsBsuZ+ZWPUSgtXC9T11srypDuLCAwUDuAVBs?=
 =?us-ascii?Q?EJN/lcGXZRshlnyspXh1k8JorkIyxDdqoIibH4jEFv2MWYxc9PeeF9JbCiul?=
 =?us-ascii?Q?GYUlfLWp1/45Ek6z8SUAe1bZQGM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47734eec-1fac-485e-4348-08d9e0ba38a0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 10:54:28.9293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zyFsAtLSwYF56xk4ZAzIC5hlx0Krs30mIpdtwXVlxRE1+pej/rfiYTIFABFLl5uGqrN6TFoU3ZI+5lNp/W8/gZIFlr/tZy9uHo2jgPmAao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2763
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260064
X-Proofpoint-GUID: NNqjVL2BhSvAW0Xx9EBHUOyoJ5hSiNM1
X-Proofpoint-ORIG-GUID: NNqjVL2BhSvAW0Xx9EBHUOyoJ5hSiNM1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 12:19:03PM -0800, Kees Cook wrote:
> This could still overflow if struct_size() returns SIZE_MAX. Perhaps:
> 
> 	if (check_add_overflow(struct_size(request, ops, msg_count),
> 			       data_out_size, &request_size))
> 		request_size = SIZE_MAX;
> 
> I should brush off the saturating arithmetic helpers series:
> https://lore.kernel.org/all/20210920180853.1825195-1-keescook@chromium.org/

Yes, please!  Those seem like a million times easier to use.

regards,
dan carpenter
