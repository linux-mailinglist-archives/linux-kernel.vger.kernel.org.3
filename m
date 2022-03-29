Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D714EAA2F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiC2JLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbiC2JL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:11:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAC21A821;
        Tue, 29 Mar 2022 02:09:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T8oVco017301;
        Tue, 29 Mar 2022 09:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=mYcOwwGuFMXAZUtkmOnACyQwwdPgM9hs1R/oKr7Eu4M=;
 b=OnwqHKBRZmnIHTjfncG+RT7x1ZF+YbdN5E5sWW+gIrbGV7JqHPklS4rVavj+FzlJzk3t
 8kpKnaOYQjnxUwF3LyOAwq/3pqrjUv82T/FIQXNJEmhq78+Krl72DGsCKfcV8zRb58K/
 QSKShJb7ffTESFgtMk9dRFo11hjHWF28CDqJ6t0zrh0KKb0jTUslxFBAKchcpMbgcPRM
 Jyc/6f+a2N7dJXBD3es93gC/cqwNqM4YH+JwYuufyV70U6hXjisLRDIxFFBjZ6aMY70u
 FqTtHMA3VvXbSHF5O3pUTtNJZcLvHIdWKkP72b2GRKL+d0bVNUWJw7g4n+pRqbemaj1A xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cnxdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 09:09:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22T97370107870;
        Tue, 29 Mar 2022 09:09:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by aserp3020.oracle.com with ESMTP id 3f1tmyjrxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 09:09:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaqm0+UjtEQixYASu7jdpcpJTtYSHl28BbC3TaC75WAy3xNEMi5a8ne1JIxrlY+qHFEx1LJrjG5xSuedT9vqFuibmeiZq/NYHS+psTxUGWnYQBsZxvPhTyGeI/ezOE5cB9e1aYlmSPv+NbkwTmM/MAuULRNMfpvGEOM6PF95yAdWzgCOyyfOPdUsAOq2jTf3iCL1yJSl6iAshamm91o8c8QgYNF5drd6uFGS4VtQn4CfIul8qeRah8MN3mIvpVGxtTcwrtc+CVtuTETeD8fYOS5v2IWX3gK5mnsOa9iJYBb+2h3ONfJ8xnrbPDeQn/7X4B3wcPHeLl5kNEStmg5RGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYcOwwGuFMXAZUtkmOnACyQwwdPgM9hs1R/oKr7Eu4M=;
 b=h2tNmZZP+9WzxVxwd/29MFoeTeQG8QU7Q1ObcdumoS6VBvaYWxrOTmWjfmCTw6wXcvZ03SvOjwlNgb1mcnhunM8WwpO6PebUIeoCtkYOz+FXjMkaQfnY0H2qEgVC6HvcecOf82KtvI9mEl4CmrPiYkETz8WrGfB7OqD+VkfvftaNmTLYNNTNEvZhZE6dKSCf3VFyRnniZ2CxjShgKp9CAArd2ICRNCGhn0HoLxWegjgMb1hNcyR8hQmMURy/DksuX+Qef2t6hucwpcPAuF3A1UDPWZnCV8pFwHZIPYFcgwdCHjKSY0FWei23nmxW+au1t3sfa+dwqxgIUeoN3nDmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYcOwwGuFMXAZUtkmOnACyQwwdPgM9hs1R/oKr7Eu4M=;
 b=Niz0/tP1XGxIL6p8cbvk4M9qXFNTdr1/cEruTCPhmN6Th/G+lF5vNzPK1Ysci7RNbTDpHkuPSOzfUFLcj8p7hpFX8KJ7lE38ehnj6+8ed+ovaJSBktgR7bA/ThhecYo/TPxrY7835D+QfNvu2m2NMpRRU5DKmRLMoWAwWrV/GCI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2523.namprd10.prod.outlook.com
 (2603:10b6:5:b2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 09:09:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 09:09:33 +0000
Date:   Tue, 29 Mar 2022 12:09:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
        davidgow@google.com, linux-doc@vger.kernel.org,
        linux-sparse@vger.kernel.org, cocci@inria.fr,
        smatch@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH] Documentation: dev-tools: Add a section for static
 analysis tools
Message-ID: <20220329090911.GX3293@kadam>
References: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e656210-99df-46c6-88d3-08da1163d6c1
X-MS-TrafficTypeDiagnostic: DM6PR10MB2523:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB25239F904DA5780547A28FF58E1E9@DM6PR10MB2523.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yr615by9iVbkK74FICqpcDzCefLgxvkcz06JCQ7Z7L4hpgDG3sL4e/G45iEldqjo10ubfpvbvsc6rNCL7RcSr4Ul0mi1eXJzQ+OqNBEmZJQAETk0kAVFtwBd4myU1JlrHja4t3WZFihxvvv93yl3Em8uEAsXTLNfK4wy2XSwflS9cCYfIrNHibQnJg12/4fKfozywTH0YT8JJeSOTCzaN/LdqKoGRYxEyxlsv4aB3hMISLmI2qcc5wO+06wsj+GfMWZX7TsEf6pVvaR/g5tRw73R5Yee7cITp3zRsGVtDwhvaV0fWmeMLyCte0WmUs5xRyqR9h+kuBPditd0sEKOvSpzsDyl7b78k1CHhOXcYzOrfJZMNLO5v5v06tSbbLDvaATMBeqNH4iJrhFuPDJU6EzdamxHBcexGQnJZYG+xpmBD+na2GMzT8VTeDjI/fF6vajejKvA6w5PbvRaPLXG6Um8tx/IwpxSF3+bFOMf7isLzCWJKgPJZZh5f+qqt0mqJTwZUwTrA7lWaCikRwwOn0/TzXcefR668WZHyoUIcaZEu7mKQtKcygQCkQRrJRsf3krz0rK3FW6YOTjpSBsTvIvyhdzIdC8b+yUDjOx1cEg+NyMvzgjaieZl5lduoYI4/drM+2DUwNjde2ErpFy853nMEeaDlaKlWfiQ+gCD0QxZEXO6fjLpfXQhUcZP5DswDuNq9pLgCPWytVAIa5AOyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38350700002)(38100700002)(7416002)(5660300002)(2906002)(8936002)(44832011)(19618925003)(186003)(6512007)(9686003)(33716001)(66556008)(6506007)(6666004)(33656002)(86362001)(66476007)(4326008)(558084003)(8676002)(52116002)(4270600006)(316002)(66946007)(6916009)(508600001)(1076003)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cQkYICMb+D5h9furewZSGSxKoSmyzF6kPL7AN/AQBr7FcAc4zvLjRGkQlRVl?=
 =?us-ascii?Q?49RTRCw8zVm1ojWxYRZUmbI565ZnjxKJujeAMppOmzRKuuUePTLAn5SOpiLo?=
 =?us-ascii?Q?Bi2BgKlKuR/Llakv5zObYYNTOKCOSifeK4z1Il+bsdyEpEuiU+25QlgOuamk?=
 =?us-ascii?Q?FTGuvQTKA/8amsOPolEyS61a8XWQUZEBlpWq0Ad0qWn5/jeYxXTCN8m7wmqC?=
 =?us-ascii?Q?HwX7ZBG4kZ0uIfizmulo9qwBKNj42yGV1lWYtMAxMVxbaULQ+MaWI4syoWOa?=
 =?us-ascii?Q?fvBBVqufokAJmQotIEy0H/DktLCTOsY/dZJJdg+pecRBuPpTl7IsjqG6U4O2?=
 =?us-ascii?Q?OBOKfIizg9wJMyM0stkqgheSvPF9gctUIpjg/P49dPh6CDCBJlj1utBr7dEG?=
 =?us-ascii?Q?+ATRX/7kOPvA/Dweat003K3P7+1PR/GvpvLAv7qPbbNUygcBXRN3wpc7/2fU?=
 =?us-ascii?Q?uSYF61xP2FmKw4Y5HGBmPFjqB6bO57BmdfBxKowlFAz3XU5sUUTQ3XAxJfvw?=
 =?us-ascii?Q?FdI66b1V1VJrt6CtWHwv07Q1D4DsZ2V8HjJ6OuaOBDhGBYACR+eKRYz3CTJw?=
 =?us-ascii?Q?izgl4L6dQZ/M20Vo7L36mgKJUCQNMJ+j0kxmlv5aByIF9SJ4VpUWqbvg1RMy?=
 =?us-ascii?Q?3Igx9JFRbHJrJIPylFeZl4VvGoyTxj1mXAGbFsUOIjxqWYjn7ZM7XQSeFYVM?=
 =?us-ascii?Q?AxkDuvOqyD7rlh7BF7tNRAlBz+hUbxvEKdh4+At3Ldrn+aagKGXRJEeDPv0B?=
 =?us-ascii?Q?X9k/92IYhoHlI2Yv3g4Tf3JhRLe4NZ/DN9KmzpVRl8AY95NWl1BROW6zv/Id?=
 =?us-ascii?Q?EWisomp/mh+4itTfUHXaQgzBueklzCDDDtP2FrBBUVk5yE9mkRAZtbgCXrVf?=
 =?us-ascii?Q?5whAW3JPewMlD/4rfwSrU3KDQBrvxgtZctgaFZHifXiP84rU4GWHAngURLnb?=
 =?us-ascii?Q?N/uduYuUXBQGIk6OXOcq/daEHQ6zjbU0JV4/r0mghma9NEGJb060Y14iiZFL?=
 =?us-ascii?Q?k3rkSqyeVLSKGu1nGE0I82X1KgQn1QCfSEJu+yPQJVf3b2Scx21Y49QO+twt?=
 =?us-ascii?Q?RUxZTYAierIQiMpSNU92zSfn9POE7o/5CihFlCUxvVTYr/VTQ/RSFdKV9SA7?=
 =?us-ascii?Q?SD7Kqd73Z1iZ6P3Pfxf4LAwSsyuzTrEqLiDazm6njnyZOPHI1n+HCs7PWA2m?=
 =?us-ascii?Q?fMZjFWKlEobobmdEat5gqyKqUx6nF8NWbgNj1Yz1llSdfIESZ/QV/4AdAaaw?=
 =?us-ascii?Q?NJsTXHU6kGzTyipL6sM2CEImYcH92MqPy0VKePToIwBCbi2m/FnFWymGyIas?=
 =?us-ascii?Q?pw2W96Mz7CGXu0YoH56LxAydxn3gRBnqMkibxV1lucWWH8niiLRVBr6eUB4j?=
 =?us-ascii?Q?jevEKJyegHieLd0eOhj0DG5a08w4tbCdE8VLZ4HXp5ZshjqXNwJ64Vp2VLZv?=
 =?us-ascii?Q?grR6WoBwXhAQumIN8ynCa/ut2a41BWlbsJaHGnZqcLvuabJFZ6OH2nV5i8IM?=
 =?us-ascii?Q?bvNPZbVacMXYeZivPwCSIChanglJjs7w7VOAD0QXHHdN55rG6euNMLuqMA8O?=
 =?us-ascii?Q?/J/4HAs0l5tQ7nR4vPy3srwQucu6t3AWOuDxXgfzh6lKbd6+oeIuwDlK98q7?=
 =?us-ascii?Q?u/YWZ0uv9C6hH8HYBqENCgTyWxeDOicHwk7ay1iPcyL/oI5aLoKldvQAJj6G?=
 =?us-ascii?Q?nNnz81eJE8g06j5CRGfMP3k/PNQONEZrn4ovQ84flsdDN+DZP03NSSGnhuUR?=
 =?us-ascii?Q?TqQyQxwa0rvpPRCgdTECt2yGk09ysxw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e656210-99df-46c6-88d3-08da1163d6c1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 09:09:33.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ESeQaeypIGQk5bAmboESrtw0C+cn10S4pDCW/QpKPAVYvvL/U332JX/1Xvhn/C14EuwcaJJrdfaSBVMx7h5Iiphowoopk7oBh4mTu7KaMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2523
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290054
X-Proofpoint-GUID: jP5RZU7VQ1fbj1xI3Q9W20n-rbzR40pD
X-Proofpoint-ORIG-GUID: jP5RZU7VQ1fbj1xI3Q9W20n-rbzR40pD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

