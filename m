Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D07F4958F9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 05:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiAUEmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 23:42:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18450 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232128AbiAUEmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 23:42:20 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20L040YE001093;
        Fri, 21 Jan 2022 04:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=mYcOwwGuFMXAZUtkmOnACyQwwdPgM9hs1R/oKr7Eu4M=;
 b=ftuBNnezAtO/h48vZ+PLXXYGkwjTkkRoUT27TY7YI/FrF5Poyiqn4VEEea/kXQH+CrFg
 7J+v+i5WwJS6BZG+Umv+DOoWnY+oOiRi0k832IW6VqADHRtEt9Tso3lNZ+wYKqeMi7NY
 Qu7oeL7W2IEMRwdAR5dZQ+szRW3l/O9/FVCOHJOouz6XySxJTlBrK7M/z222U/TcYn4j
 CfwhRrgbktzo+SuxJSEomY9DvNzQKnfxcYwvJSTZaQJM0NFSkNIhMSaPW1dUkzYRv2CH
 PlI+MjDAls+xL/nXW5y8yoT7TbCdY7MHcXPemQ+ngW6U1k5U7I1fYKV4rRz46DQzFjIV Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhy9rbca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 04:41:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20L4e9aJ047879;
        Fri, 21 Jan 2022 04:41:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3020.oracle.com with ESMTP id 3dqj0m9mce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 04:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laEzOut8Bt26WSDklbBkOUwG2slC93fUgDB3RSyjDTNGQiQ3O0BV0F979wbtaBKTNbqrsRAArHhvwTeefBwND7aOyWu0ld3EvWH1tIGVNXvIRHHv2IvhqI8rzn/0cRmZG/uY/FEgdkK4JUaYLMMCIalTsnopO0vaf5I1uVn0+AOqv46yNKCDM2ZqK+vltTrBHkeFnboU5shFx9UpiGZppqi3vTqebx2Hjj57iAgxV340Q5t7ykKJlYyrkcf0nYccIp7giBggXuwrbn0+MbhbCZY3KOrtFhzWntCEVPuXemyZBt9Nx/CUBFPYodSVfKfzmM0Y+/B9TWjx0sOhtSOP+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYcOwwGuFMXAZUtkmOnACyQwwdPgM9hs1R/oKr7Eu4M=;
 b=kteILZxOEQU9yh3r+qkqRxchEzHcJ6U3Zb4pv7POFzrdLGc/c4l0jnjfaPULlHnkQFXDdNq3wOk7HEYddrZr0JIvROEoFqukRBInVZrw7fkTR63FP7+casAGr3//CujownB1P3KLCZwEJpvBcFbQwlhOglZVGChB2vWEIUnSs1X5tD6caNGL/cRKPWPRY4pyMr2g9TcF0hEbMiySUUFSvp++fOajIQnHLnWHBSRXMsibn6nug6l3zwZmm/Nr7n7s7cYeMo1f9XXUPZ00oJFYAtk2anR+Qh/NaqIwKOU5QmfuCSjRdpk4eCFQubON/W/zZafidh48kto5bRALBp+NjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYcOwwGuFMXAZUtkmOnACyQwwdPgM9hs1R/oKr7Eu4M=;
 b=DyZepoJIefFjyidPRmL40OsWW0vdgpG1H+d8R2ilLDs9bVNdDiQEEJwiDNckh+uKVi9SBzwAqu2xVDxFUu1PACG4C5PJ0cYJwlg5A1OumT9ZJfX385gkSFSYqjuppCzE4QVc8WrM58/IbxCHM6I12jQC4Z+psgnq04p+Lz4NUvk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4183.namprd10.prod.outlook.com
 (2603:10b6:610:7e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 04:41:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.008; Fri, 21 Jan 2022
 04:41:51 +0000
Date:   Fri, 21 Jan 2022 07:41:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     gregkh@linuxfoundation.org, keescook@chromium.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] lkdtm/bugs: Check for the NULL pointer after calling
 kmalloc
Message-ID: <20220121044130.GD1978@kadam>
References: <20220120092936.1874264-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120092936.1874264-1-jiasheng@iscas.ac.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0067.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71f173a7-dfb6-428d-ecf2-08d9dc985734
X-MS-TrafficTypeDiagnostic: CH2PR10MB4183:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB4183C40D8CC236E1A85F3E0B8E5B9@CH2PR10MB4183.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5Z7Bt3eMrjxHr7Or7jYeYRxAOkigSQgl+73EgFIwkcJNjE4xmccIWgauprb92Nw7uvJHne6F6wsTMHxC3KKPAkfaY9UjsPOGiFvDiO5B91jhEoz6c0/UFO9LZqJxUdoAEDGaGA3kTyhmWxd4/chzo3I4NQmrYTmxZOntlCPzE34NgXSdk8iOWcfD+m1SOqy6W6T7t18ZiEKjI5W6xtmWXcaL7b7xBSQHGfCDDnxdzprTfqIGl2EjUAYZGJ3RIBvVXslzreoMYIu3+aT4zZRBJiPTfUu9hk3iUm4VH2MdGSxOJZ39zzn/hy9q5aUNLID4nKzvBYFEBvvX7jWTpCSdK/vLrNYsr30vV7z/BSOtbipJ92Hs65O22dsIsAqrabMvUngziHN/Gqi7fmeTGCIdQ2VQCX2clBTaQV/Fx3Vv5cKjm8otMJmCKO2vXe9g+IHfo+cUegd7qEyke/y6GLlr63m1QfwTEAGMIalSPT8EtBSOF8zYeiXiJr03Nq5BqEAgi8NQwTf6HthduQsYK00n6m1TfLiOzoJlkLmmCz+ItPC2nUbUgakasEWCgvVLB7h4orENiYiXC5SZN2U+E76EEGUvgPVM312v++3fq4zykllSk71Sf1o+3IlH5iFfBUdsUcfEtrYp3oKn7O0vi1qfzEFErR9HdCOGoUmIS5/6D0Mb7e6mM1LXGfDPvXDzmkeJjwRldyO39mf2jZHRDXLpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(2906002)(508600001)(33656002)(8936002)(44832011)(558084003)(19618925003)(6916009)(8676002)(26005)(186003)(38350700002)(6486002)(9686003)(6512007)(1076003)(33716001)(316002)(6666004)(52116002)(38100700002)(66946007)(66476007)(5660300002)(4326008)(66556008)(4270600006)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?516jBC2QWtCzykcXW17i6UrsUO08qEsqxcTY4Wg44++jXk6wj2KP5plXuyPH?=
 =?us-ascii?Q?VPz6NJYEOtGm8CP1sbAXFri9mAxp8U9NH5+UHHcAi45uNGL53ePR78trdcFM?=
 =?us-ascii?Q?n/yl7sOYfqp4m2X+wla5aiqwrmtExkSqxklLAPlD/WzorYgC9gGNRfZ2ZhjO?=
 =?us-ascii?Q?LB9KP139ek+EPNXJPzuSfFdKwcHvnzVYlrH3ZiYJIkk1ftQJTO6vctQzV8mm?=
 =?us-ascii?Q?3Xfw8gP2yx3Dn5uhFJ6pq/opvPMiD8AW6dXNGQgEcuObMerrPr4GNdpO8LKy?=
 =?us-ascii?Q?DM/aKzmCVJbvNmRxJR0iy8LmHq9BSnlB7B6fTrHLIvqlIYKlpoqeysZLoAXr?=
 =?us-ascii?Q?HHQRBtyGIG5v18ri0wJKVz+CsCbPfruAJl8SBReAkIKb1XmVOhdfjCUPZxUO?=
 =?us-ascii?Q?y2G75Mtg8x9EZRI1kMmin/DjXWJKXsvhX3lAmg4Pq99lbl/UIXizV09GrkwL?=
 =?us-ascii?Q?md8LGTiaao8alYQOhtwUN9nLOmMjvLvemGtEs1E0Y2O03YnPyAMu2AEufRT1?=
 =?us-ascii?Q?UgqAI80YLZ1ZvjM2tOL6yZDn2o1xoK+AOkgOTkODnK8kX4Hh9l9Kizdd0O+G?=
 =?us-ascii?Q?X4dVElOQE2MIfoK8OyXpwWGaPgbXABzvHBgNgeBI7qFguIP8OihiSbA+kq2/?=
 =?us-ascii?Q?BcY2VFyIwHvTi0jQuWHcRdnsySksAZVz6oS1jjFTIMGU56Fw8klXJCbsr21u?=
 =?us-ascii?Q?D79f1GpMndGY2+6V7MDT9/AwhwfZsdYhu/XwWJachVM2tAY82GVdYtUMgfmp?=
 =?us-ascii?Q?wT4HgYzelIwYOTdvjhSp9ixg2RJQ/d9hpHDQX5V+xCMg5VqkEvFbYIq3Vw9n?=
 =?us-ascii?Q?pQrQ0S7WFBmXP7B3s5mzAOKp6Q1Dd2bl3ElwvBRNwuJkWhyO9Z4TuBxAlSiU?=
 =?us-ascii?Q?I6VcGSylBCUkT4uyz0xbioFTAkRoD7PoAQk0wG5oHTW12CDGsIgjSalvwJmM?=
 =?us-ascii?Q?PoBDMepTclCuj0pnHqq9ySScu1egNWmz01YSSNYFBWJ6Ho9FqRpc2O5G+d3F?=
 =?us-ascii?Q?cYedyjNyDfbe57Djbhs57shT2O1G0ZHPHBXFBf3Py2qbuseYj+AIRjJqeTd0?=
 =?us-ascii?Q?h6Es0+H7j+ACQ2yqouniH1m6E7I4rzoeUNCnF1w2yJZfx6q5l8SD/PW98TJJ?=
 =?us-ascii?Q?0YjFzX/Yx5DNAXUV7Jxg9KxEFNEylVnoQbKeZDv/B4Oqpj/Js5CXqfGXPnRM?=
 =?us-ascii?Q?Ne57NHtZmwQDfOwl2NUQNzTdDAuveXCF1HQxUFymFiUObYGSdGzZeoM0lOlc?=
 =?us-ascii?Q?Nfdp4ZeUL93/itNk/w6vDsprVGZH28ROhiD7+xSNqdVINhxWdHJ+4m/gHR4E?=
 =?us-ascii?Q?DU7cF7kMiJzSjYNSVzFEN+ps6vvxqDx9tgaYYyXteVqdXJHeUIQU4t7rTSSS?=
 =?us-ascii?Q?D+E6sxiyNBvdK4peXeW9Vf8p3p8+y/LtEyBg4hRTK4KT+LIOgAKHVKWLV4kC?=
 =?us-ascii?Q?+vSb6V5ZLbiXDah3rVk8+hDwdim6txDf3YhhU7Ha3REQg0XMaPcIizvrkzZ+?=
 =?us-ascii?Q?aPnFIcNdRmp1m+AKaaGh1zCaF7eZEt+My9DA7O15JO0/vzkc68pzvJmJbGLW?=
 =?us-ascii?Q?LGo6PhWe8rESMim2SZg7kbRyGUy1qKHcawlRqP4a7FkY8C1sQOwHE1JvO/UV?=
 =?us-ascii?Q?ra+983QjMGtOir6D12wObheQCfKbay/EFR/lLAVvqtEOX7ZeRTq+vWCirt+4?=
 =?us-ascii?Q?3S+w5Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f173a7-dfb6-428d-ecf2-08d9dc985734
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 04:41:50.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4iQpaIs9HbcYD914gJuN7rCzpZiMgfoOlGbK0kZbrPXvCBo6j6IbQDgsgF7TrhlGm4TbxRpgd6srjwIE0iHF+KOb5l9Klbi+m0DgxqrD+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4183
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10233 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210032
X-Proofpoint-GUID: dLEFpRd-WHygImZOdIepkM9co7bjg67C
X-Proofpoint-ORIG-GUID: dLEFpRd-WHygImZOdIepkM9co7bjg67C
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

