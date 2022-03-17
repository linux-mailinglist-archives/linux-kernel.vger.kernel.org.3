Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8B84DC46A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiCQLGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiCQLGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:06:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A902C1C9454;
        Thu, 17 Mar 2022 04:04:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H8S1uH001939;
        Thu, 17 Mar 2022 11:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=FPkoVeIpjTebodS+FXWpcahPn1EjakZmAJzN6nRyO00=;
 b=mBMUld3U5BE15h8IpHSIP/fNNac+20YjnOlxHcOLosi/t4WGWhDynlESlran14SzgqfS
 IGPHLgI9TNKNtMuJ6DhWX7SmKAzc7hnmn5f/FlzC3TBjRBdDffaTrWFgTLwjooX/6krU
 B+B0X7/C1HUF8Q9aiB0Sz3tpfGjd8Ov1lRWiould6COC38h+pTDPLinXVuk6TpDjvDEL
 caX1pVhvn7qPH//H+97WNHZMb9SxXvj5kbZ0EGphQqR4Ckot0wzALfdEBI1575YE0zDp
 U/zrpPxEl4FNz8FvOCn/+saL/RPW/F4lyVVohrU+UH7ytYNiAyGO8nlRZNMWNjYHSwCA GQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwrn8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 11:04:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22HAu7Ug015538;
        Thu, 17 Mar 2022 11:04:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3020.oracle.com with ESMTP id 3et64m81ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 11:04:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRsxkpF5eZuhQZKPFUIM0lw0GByYjZTHQkA2wpc9vLk3XkBNJa3AhitXY7yPoUU+jr7r6GaljJnenaRFqXcG2oRErW5UVoPH2gpJfXOKUW6X3ayoM9CBU720qyJWBdsxwRuToTmAKd+j3JitF+uNpCxdL3BmLjCgc4RD1yTjO/eBuDFFjNcDGix1uIHC8frK4PvsfG/1EqkaWUbXcSk9BWvZKO2Yw8f2ReJ3Q1pwud0tGD9aMUZ4mfk2+e16WjumqIFlVMwRwZWWmklPmEinPmS8mQ7BGLEGMN/K+tVxxbQ4e3sS7oYu5Zp6fT3ocpvJoADmGzVfDoc+iqasScSHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPkoVeIpjTebodS+FXWpcahPn1EjakZmAJzN6nRyO00=;
 b=PE86Ojx2VF8ja0M7xRl1ySV8ZuMvlGn8rPPqWSaETeZwuCD9dOgb0gVMm8+wPosZEvXwdcGELygx5W7kzs8Q9HOFZm8gUHVTtzk8bllS2bJ5O/pE4u+MQ1golWSi5svnJEw1bad6La8FXW0kKAwT7M34iE4GgczeuRWZtV/mTDsbkRQNu9ajGzqF5WzMp68hE5Vaxs0s8Ce7n/vbBGc3S2UsoT0FO6vLp0OnpV3q98h6bgN9eWKkhYf5J+pW93LyCLJskY4UaGK965x+AwamRIaxC59NgD7dRd0N0AOAwqYCvpUsf+FEfsu11ADsAStDvVDUzs2W2fQfKZa+yAcNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPkoVeIpjTebodS+FXWpcahPn1EjakZmAJzN6nRyO00=;
 b=ZLg9vAFHFMD4n4ERSaOMcDs6MjpqXBoG6Svde06BZqHRmcxi6e6LGMOpQMLL+wqvXXhQAm2DqLlA6LQhGmjYpJ+D+6cQNXmqMukgB6O3kQdDfi7nO9pMsBei6AhJsfS2sswzZYltsl/ROad1fhhSIKtmr5gayrliftBURxAUQBY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2236.namprd10.prod.outlook.com
 (2603:10b6:4:35::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 17 Mar
 2022 11:04:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 11:04:37 +0000
Date:   Thu, 17 Mar 2022 14:04:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     "Colin King (gmail)" <colin.i.king@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq2415x: Fix spelling mistake "vender" ->
 "vendor"
Message-ID: <20220317110416.GA3293@kadam>
References: <20220315223700.2961660-1-colin.i.king@gmail.com>
 <20220315224645.ytcf7y7awc3q2y6j@pali>
 <5ea0e154-e06e-32b4-be86-f38ce07b8bec@gmail.com>
 <20220315230753.6xymu77uirjbnn3u@pali>
 <9e2ac011-72e8-977c-00c9-5fa862a4e5f6@gmail.com>
 <20220315232806.m4mwsdawyiafpc3d@pali>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315232806.m4mwsdawyiafpc3d@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ca0ac55-cba1-49e9-e720-08da0805ecb4
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2236:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB22363043C1AB4CB23221BF1E8E129@DM5PR1001MB2236.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHtQbyrrtVUijAIizdgy+eJWDkewrV6LJztvUlTBvC3Zw45NOGyigS5tB9p4SsPCHf9OBKubLbyyTGl4+UhVtk7IGOJdtqnrwuGvhePm4tgBiIHUm+b29HvAgXDKUMewmKMHVGspN/A5DNq1sXzytMhL/uJcDMHFZfgvq8B3OHVcjSAZ887ZWUribFKMmVSC5Qsbn4oj0f9zt86OwcRuCGRsMFaGkCwHEyZ39e9W5b+ZFjTr+EC7oYxzdNMz32Sue20kcKIdaAEsBkd/se9Eim4tjnBTaEqVG1/Jm0CJphjxTkD3onf+QE0XbKvsk7frelMteq1S3Gg+X5F/1ojUJ130IW+qZFlOjRKN5AS/cTdCsv9aCE65ja9ZVxXmTmzc5+L0RURC0Ru4oeBaOUCr6q1g8DOrihY0hOsdH9w0k/9sLtusDDKGCwiAUAlQujQRx4ucqM9/uHGIqsCjlISW3iWehcRVS08J4tV/kEdBoWU3nS6j877423L3ThXVRlB0A52V4ko38t7jrozAMf90E90k9c7thHYHKb4LnwzZfxDuCjK6hIhCJKFwa5+Ixmas5qkpYaXdzo+k0GZIik1zdLdTeE2nv9hqGWhnx+goY1hRR6xYjjFj8qSkx3JimJz0Sh8s7Nrv+m6qhkHjEEqjOqlJwvv0uscGrcT7hd0TJFnqb1GQOM4cvFdP79FhnJO9ndxwscHdrYzc/u21NVkT8EPqnUsT5pgq58wewgZKir3bRSGL1zqRhYSl6MrMjT0tlEqkjgGaQ/mi1oWo++g198MQfDbT81d/2M8rgBDSjLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(508600001)(186003)(2906002)(38100700002)(6486002)(966005)(38350700002)(5660300002)(8936002)(66946007)(33656002)(4744005)(44832011)(26005)(1076003)(6512007)(66556008)(8676002)(4326008)(316002)(6916009)(66476007)(52116002)(54906003)(86362001)(6506007)(9686003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ua6ncpd6GRICrwSgC4hDdG4Gx0jkXe5M14ceKf9Smz0kfShioCi9GjCfEsTm?=
 =?us-ascii?Q?CeVIOJN6IZCE6Rd5jeSMYQorOvJK7RL+vl5lqP9mvWK8/Mkj5wg4Po4u7XxI?=
 =?us-ascii?Q?g2BnJW6EKv0ZTP2N3wmic1B/Rs8qql7/qC5dmlzlzrki14do5jdBVZWbmFz+?=
 =?us-ascii?Q?ptLTnauX+Iy5ALcQT3Iy4rxh9yDcTgSk6Lx7JrD2Im8Q7xjE77JmLvrTfskr?=
 =?us-ascii?Q?FV7o4psjUhIUJuNB0mwQB1D6HWdzBLXJKdTUhbFTPJ12Qo3PLpU9nxD2ai1c?=
 =?us-ascii?Q?Sk3yLcKT2c0BBGCnE8zV/jatl2+vp1wDv7/DisZEL0dwsgRJwuhcu16/0x1E?=
 =?us-ascii?Q?Ngw866r/aWa/1oXR7yrWP6YY8kqUI0jAnuANluzVrpUY0nOSuY8jLZMpOH4S?=
 =?us-ascii?Q?w5FqY60L+GEPq8z1eq0ZAVv9eQNDQMZeBRwaqGZKkzyaBEIEvhNOsJA56HTx?=
 =?us-ascii?Q?3J9Aw/M+mbMA46wsPCSmrf59jZ8iXHwoj+E8ITKlJ0T+EM22EgLPmr3OIF78?=
 =?us-ascii?Q?EWi9SUFNLLalbPxzlEoqjJ3jh5l5LN0rGrLPaxOZOTWGLmMx5YsA0yDEOGEj?=
 =?us-ascii?Q?aCmhiIyq98TUXiVjs/uunKsQ3dqM4KpI4aZPUhCwPn6+yqMGDnyYPN+pNnV2?=
 =?us-ascii?Q?/mXGzGbzFrkHYKPxNQa9pb2mKTxjkvT0UQFHaiqH8Ck6bz7FN5yQASjjTxZ2?=
 =?us-ascii?Q?gj7CItLSimxn//sE7FNotiNvbZCOrX035BCGIeRlPQREYYkYwOKRopxLhhlp?=
 =?us-ascii?Q?z84pWvCabKn9zdxEALlyM1BJyjo/u1Z0r5jDnEBmFVVQsZKxoY4XIib1ya/B?=
 =?us-ascii?Q?qOimvKzWm1KuYx8K9l9ViQSbxhrMUDcQpBhwOXWvQ1OQEvfHQmk32O/ioj2i?=
 =?us-ascii?Q?85F/kfbP1fhfpN8QAjs1C6pMYMUPlO5BhlSCdEq9DnXtbG2WVh0cTrf/xM09?=
 =?us-ascii?Q?ZXpCJffAg6qkQpAF563FpPQRzxTurOezedKBHNs6kPVb+sqI3CqaFJNWRAB3?=
 =?us-ascii?Q?/13cww/1FglLe1CRejJRx+zsiV3l3JPfLpQxZndzXfe6T7wjPTDrBKB/4gpN?=
 =?us-ascii?Q?Sin06TqDjr8kvrepuPKXxl1aOSjCLekWVmRlHSt0+SKI4a3GCZrKYsTNA2u1?=
 =?us-ascii?Q?eVOctuMSRXQPgUK5QD/cZEb3rNSn8Oc0HIHW5/xGJPPDXJkMzsdG9LDGZUJF?=
 =?us-ascii?Q?qtljexPaepeN0pry5c94HmKO75ZHDVX6EYe5sAj5jMuNzVIdtjUIjlfmTpbl?=
 =?us-ascii?Q?XzgqGGqJa5vay6h8hu2EXZ90RRV8cZ5NyDL0pIJjsdGW3d4SJ7yGAuTzLbb6?=
 =?us-ascii?Q?Y90Pz1cQwOvu1xiJ/MjgE8wmxNejDzHatbWzPWaUyRrcGVCO6/x48fEidOuf?=
 =?us-ascii?Q?85lAklsyPKvwGd2CVrmIbIMECFaSbKYL3GvZL4CX2n/mhnLMBRYKbeawyTOV?=
 =?us-ascii?Q?zGqjGPCuBLcxfgqkmXiVYhHT+Wo94yLsc0tegNxa7gxjwRTNlYQpYw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca0ac55-cba1-49e9-e720-08da0805ecb4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 11:04:37.0483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8a9cBYPs0j+0O3IWjH1T/BhhhsdUTKO3FPqzDgl+8DAE4zK/7L8co1RyCP19sYF3w+m4nJCYFAbbnFa83PnkNoghX+tVZ19tXCjrB/Kj74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2236
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=932 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170065
X-Proofpoint-GUID: ICupSxBktN-ywIvWl0ucoYvT_TzwSWf0
X-Proofpoint-ORIG-GUID: ICupSxBktN-ywIvWl0ucoYvT_TzwSWf0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is like "referer links".

https://en.wikipedia.org/wiki/HTTP_referer

Everyone except the New Yorker considers it a spelling mistake.  New
Yorker spells it "vender" as well but they're alone in that.  Everyone
else says "vender is an obsolete American spelling of vendor".  New
Yorker is crazy with their diaeresis and hyphens.

regards,
dan carpenter

