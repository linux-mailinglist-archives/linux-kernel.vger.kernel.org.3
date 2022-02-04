Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB5D4A95A2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357289AbiBDI4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:56:24 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16034 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230415AbiBDI4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:56:21 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214877GH012591;
        Fri, 4 Feb 2022 08:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=CxrEcQ1sZdyCc8FWHvX3Z5pNmlux4SxxTVIeGEIsT7k=;
 b=UfQqbdEBqJ5OcVcNSNsRJSZuxJn2GiEtxJpdHJswa4HkECMAVHzQabhZocREoq1ZEeZO
 YpJHHLrfRX2nEf45LDxlzRhp7bzn5cIpFr918PavTb7nyb8kTL9S90A8CyTE9b05Bhaa
 GR8QBjWMHV1A0VUa0GhNN588ZO+AfYPEKu65dzBTUJt6To86KuPi09yRaJiG7Er5EuhP
 QmmhNi4Ld79xrf/6HTjk2WaNAfn6CoT0qy4ilsLP832zM4xif7qYJHYj2bBtDfyzg41F
 Wg5SkGm3uWsZE9q+BCx9igOhfNlPc+F8jGz4XkD8hmNFBUirCD3F/rbPsTCNj0FPGyWs eA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hevt14v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 08:56:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2148pXHS088627;
        Fri, 4 Feb 2022 08:56:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3030.oracle.com with ESMTP id 3dvtq739ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 08:56:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxEuIK0DAGw5GzrziTa+BTiFtF7GiC5Vk1u5zq5/eQnaoCklG04fhKu6hZyNWOWYCqZIAbiqe4yX+tXnIarE3ixQ/Zo08kGnHcaeWPYNaYL/ILYl2TBOJaOpw9hFZfvgQpR8pvFdB7/w11p6FeUxibH4J8BuyKWVb4jMdITVmjPQk5iPf0MYHuDTUFrtTy0e7nNPDd1KnFbUzEKoT5PgFpcNB/GcseNf1u3+yoPGXbJ4yvc7JTq28XEB4528NWQgqUyehR1T7UGpOzEQXPz+3fG1O6iWpF787ML3te9rSH3rPwkkcAOcZ27Y8geugl5MUfnZudWSXvZ1C9TvQ00+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxrEcQ1sZdyCc8FWHvX3Z5pNmlux4SxxTVIeGEIsT7k=;
 b=iJDH99YgUgkrcz9+0CS6xLGrvk4ca23Eu2XinQLN9Dtnvjj/S4snFZFJOK55Gd4Rje+qH0mgJSfa5gkuJJ8kuoY0UEYUII+Q8fWDUzfTEY40eaYx/HPWvqabTJhcnO6freeSeJW1DWGmQzijYcJjDQB+ViWnlib3miCzXhCFbgqemDYUWPVWg/qxumCmbqzUgsn5B0+zcRzV9z46fuLjW2drTEig2A37y4s1oYSRtwi2DN8vF7U7uX1tE7m1OKm5oKP/JMpyE/KsaL3C8StmnzWTYEcwLGcDuvkbntno7iBlc6ux8kpeadNxp6RYNBKOb9TpPsjoq36SRdCjQGUMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxrEcQ1sZdyCc8FWHvX3Z5pNmlux4SxxTVIeGEIsT7k=;
 b=ZcymKM4O5nuNbNB6Vh4XtBUqN4anjUa5usTLwIhEHnzchByfjsQ2UQlL8zvdIJ/5OmA9x6W+RYDdgGX5LOw+x9ur1mDsyOC2oInGGpci7+f4Ou46fZBimX4jUcVzbiPsJt+9Js7rWZU2/vXbqUTyvNvutJrr+iV8AZJwaFLuoKE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5093.namprd10.prod.outlook.com
 (2603:10b6:408:12d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 08:56:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 08:56:15 +0000
Date:   Fri, 4 Feb 2022 11:55:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: pi433: add debugfs interface
Message-ID: <20220204085547.GY1951@kadam>
References: <20220131134558.GL1951@kadam>
 <Yfy0QSxL+3lbPlLK@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfy0QSxL+3lbPlLK@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59f549c7-85f7-4886-0d14-08d9e7bc336d
X-MS-TrafficTypeDiagnostic: BN0PR10MB5093:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5093C03FEECFAD2226F452538E299@BN0PR10MB5093.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1EZz+gwFCOC6Ajbx3v8uQ8zGagbNCZKIBpjje9m+OogiREte8vddeqqNwGvWd+27lxDV5HZRwq55p/CLEpA2xRemLoLfRox9ovRCoCeOJYUG1vzDNBpjn37AnMrL/HWNpbXuVza0HyyZwUZhcbtctJdkhA7hG+4b3F2fyWguE+ccPFeA9v3Q47emK7y+CTa7uaXNgicby3+CODgGFCCzqsjwO/mo9/owlPqeJcqccky3rEaX/3PVykxJl/BxGLrV5YbzK16YNDLV70QjDfxXjTBwKQwZIjo63D2sLNiUKMR1uVssOfoy07ECURcaE3+YW5UH8vG9kmWmT0mnfgu+80HdF58ZfqjcDt0uzUWeeVTC+0jo9G5VDGIEepQBCXffpsXTnnzGJ+3NxgZFKBWOqgprks7Nnp/0mSFj+9hveN0EmzytWEEj9gzwFmT7qMoGXUzj5CD+TldW6pdjOtNl1WUDxUN6oAU+CdwQ6O60DoI1RtWni4Z/y+HWy7yD5+mLd3r3v50lTvnjiK9IRxPm8jmYGdrzR1eykpg4uVb8I9jXwYn5YmieilVsRdi6x7S5HY63SFldeMDfMTT63hlJ+ZlyCLS38GSPMOU07o2URbzdbw6Vl/ohH00vF5o2ctUcB8qyZ2m1CS0CQMiiOCnLEm7hvHIXmOIazXbDRCFLixaJZyRXXGvT/PMxxX02niX73IqHpgTUr4sWh0hyveg3uQt1hMf1MpQN1Ek0kAnIN3k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(44832011)(26005)(1076003)(4744005)(38100700002)(186003)(66556008)(8936002)(8676002)(4326008)(86362001)(6486002)(6916009)(6512007)(5660300002)(9686003)(38350700002)(6506007)(52116002)(33716001)(33656002)(508600001)(66476007)(316002)(6666004)(66946007)(5716014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eO2oJI0VZTPkgXqtHI6kDZScG1WK5UoKU8zGfgzvdfSga1sfWOHEOjxy012S?=
 =?us-ascii?Q?fm9j+hiZUm0GTGT9WKiGez3J7UK1iNgTKiCAGhCK/fc3bDEFQ8iCXUOnH0NP?=
 =?us-ascii?Q?Z8FQzzpRnrh1wiMW/NoZFeasaSlkLAZDqVM+Agp/d2tT5nMla+qnCs5dF/rA?=
 =?us-ascii?Q?dWpVAjrW64eleLjbfOLAnGFLQOAkzMvrpst1k4Q2U1FNKn2pckX6kIVLhO8r?=
 =?us-ascii?Q?c/L2Fb3idjSSeIQ2ZzNMOE2wvcp7vKU1ysMHIR4vSvegZ2YlQAd8/y+iH7ue?=
 =?us-ascii?Q?jGG0cRp1qQBlNxWkTbFYBtQw8u0zNsAyzm3Ph9HCmYRZjCU/4KteTFZ/pQc+?=
 =?us-ascii?Q?nJd6MDQS5xDyFXXfGlB5y4KqJ6OW0gP741OoJO8pRIY1ZH7Q1SfLXYyoh1xm?=
 =?us-ascii?Q?+e1ZiNqc7bGtnq3WdbgP3XRIsBxVyepPPG++RH865mOhPY8x3/FJcK5CiMaW?=
 =?us-ascii?Q?vqGaM1nVhfftToCZXZs2a262kj1Nc/lZ0QFr5LtJmsjI6QoxMDNs9AN1++Sw?=
 =?us-ascii?Q?hKF8fn6h0cqqrpEvzT3KOVEM6qe1Cj4mmZKDEMjwiMTWJJNJ18c6LKJH8MYQ?=
 =?us-ascii?Q?3yckso8H+KjNs5GfiqVz9/mAN3s4mXB3YnwiTs/+A5ODqua/ytmTxxLDYmcU?=
 =?us-ascii?Q?WQdpfxz2hF+0R9lbseSOIiQwBELYvdUyq165lZtyZ08HnlQ3Ju5HTLCiuG5q?=
 =?us-ascii?Q?xARzImmsrbMsv+CEuEYio7ArryXibsbeR/By0Ahx4bCWSZfNR8XNZYwwkrxV?=
 =?us-ascii?Q?DI2tfXEHgwn9z6pNvN5RxnK630hWunyCTB145P9xJHp9L5kp2Q5UhnVvBQbn?=
 =?us-ascii?Q?2mc9njkviNb30TKFsXjVR7p2dcuAFaZe8TpgIS+vtlmQQSnd779Sh18v5d9q?=
 =?us-ascii?Q?j74rVyOvDJW1QGjuuC8/kF20d4sooln65dR+ABKVUMm/VncHwF54LaBzCy2D?=
 =?us-ascii?Q?l0sf2kyhRxoadXtoIHt7jt2ACl2EwfXXwExBifiXvC+R9hbvaQNWga3LO9ic?=
 =?us-ascii?Q?+Rtx2MY2xTANbF0wt1udwQXf52OgAFVwtXNTQnslNLHZUJRCbwfdnvv/jQft?=
 =?us-ascii?Q?j6PK98076Ct62jd8rIHU2r4fNi5XEPa+YSFDQFALtlhyLMr+327x1eOJJlia?=
 =?us-ascii?Q?rLrUVN3oW7H8qEvMgHf90kfeHkEVbQTfHvndSXj3dzupbqrCd4OTRW1JwTfh?=
 =?us-ascii?Q?wbQYDHhzZGOvIJ9hLexwYGOwO2+MjcTTgCgmZbLJOKoFXO152V9YegYW/qHu?=
 =?us-ascii?Q?2GOMSJBfxPm1xtfjqyrmvHY7Y6wdHAlvYZiCol/EsINzAbU0zs1ZkK7I2O2K?=
 =?us-ascii?Q?/sKIFyY0asShZXUsT4n8BSCgbOHRO3wIT47OndGFMC4cV+RUdXZQltnqlWbB?=
 =?us-ascii?Q?aWp+9LQbPRkX8UkZPnS/29zXAN9NCIZqE/LnffnRgyeAQYRqVJD9iDYMBZ4e?=
 =?us-ascii?Q?codTEHMqAOtyhjQKJ+Fk5qO88YqBjD4P1bQTz1VKNby9Cg681rEvB0UdlmFi?=
 =?us-ascii?Q?q4xBeRgUrpXuoyHxlcDolPxDebWfxW7l/yqxroDoc/c1C3PN7N2IJ6VGoxX+?=
 =?us-ascii?Q?hcKC+oa9gpz1yMVWop2n9FaC0t5w9aBVBsaUkLwvH3m/wfIuwUA8OuiVTJxU?=
 =?us-ascii?Q?SDIswi3kMTK+GuoUTZrWEgdYZsIZwbDWk+CVIwIaf5WUohPMoUEKWhmMNrhi?=
 =?us-ascii?Q?CjyK/4cVWbXYVTGkNjn7I0biUO4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f549c7-85f7-4886-0d14-08d9e7bc336d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 08:56:15.4944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e388RyPo+tHENl9wlCWpAMyVpa3F+I1YCg2uRSeZAb1b+M8xD/dnlpfwM0yN0rBAVOmvXsKtbmCj8vleR+hm9l/RBnm/2zlSJpplSiSG0vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5093
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040046
X-Proofpoint-GUID: dQwEK8KgYiTy9iiFn752S2S5A6TIL8xG
X-Proofpoint-ORIG-GUID: dQwEK8KgYiTy9iiFn752S2S5A6TIL8xG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 06:06:09PM +1300, Paulo Miguel Almeida wrote:
> This adds debugfs interface that can be used for debugging possible
> hardware/software issues.
> 
> It currently exposes the following debugfs entries for each SPI device
> probed:
> 
>   /sys/kernel/debug/pi433/<DEVICE>/regs
>   ...
> 
> The 'regs' file contains all rf69 uC registers values that are useful
> for troubleshooting misconfigurations between 2 devices. It contains one
> register per line so it should be easy to use normal filtering tools to
> find the registers of interest if needed.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

