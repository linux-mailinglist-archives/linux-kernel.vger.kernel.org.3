Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4C84A6C6F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbiBBHp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:45:27 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27960 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234558AbiBBHp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:45:26 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2126RReC004733;
        Wed, 2 Feb 2022 06:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=wM+ohfNYiWGeay45lM3FggEpFMKPXfUKvl4xBxXNToA=;
 b=09IEZc1XhcYnMIj2eXtpgXp8IWXZK3k5D//a4fdsj+HfyFf2l83NwzF1EA7TFIraTcGr
 8IIf/Pr7kx2mxXoGzOyEfdGqybfhTnQPWlk6zPjNfP3skqxySXa72TmHdJTBZZA2aF1J
 oSsmg0d5oOu66SB6uky1T0oP5BQP2C8CpkWRyG8Xx/KmXdJPXqiDP5LlVy03gzo+duCb
 eg6io5U73KiGXOX9UkZBr94ORsBpaViBIFogXJp0vpNqWLb6I9PYW85x0blMFbTlSMI9
 cxCsQyNyNrSqT7TzMr464IQaRkd19dMnEiYVcN1odiMa0t0BglP5a6pJz+SI6qSYk6ol Zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac53sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 06:50:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2126bQbW056246;
        Wed, 2 Feb 2022 06:50:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by userp3030.oracle.com with ESMTP id 3dvtq1x0bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 06:50:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO5XPaZeplsFroEEPJcQX1vG4u/yfxn2NJFuq7B0Dk75xGH8jWTXrRUK4D8pvSHgZHlvNeYx0QNG78tHQcbaPgb8oTIjRWJHnTZsBpny2JXNXMtN4FEdXikzU2w/gs/dLvax5es7dnMMP0e+SpgOi2g30Kta37FZn7VCl0qMcTJaOBhmmzb2/BOzURX+gwkdL63eGvWbsQUL8cLRxtLX2jrt4U4fBE4Y9MtU0NDkue9bUmYrtEi41vMpxjFWiW5cHDBm0FOawu90WL5rjTtcm+grbgggNuBX1ckYL+SYyMKCh4tQortdLKOQAsSSgVoImyAtrJ84rb1Pj+Stsq08cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM+ohfNYiWGeay45lM3FggEpFMKPXfUKvl4xBxXNToA=;
 b=lhSRnSwU9xzZXHyXL+g8Qzq+dAXj8AZzNCzSsXYNq5WnXFMStZkMfiRzNcfpXQ81o+g4i5wuFPcPzkZbGhqBPA8+oWEwgxUTVyxNMeRNfFFkJrjeImvOIJi8sUVn22vVCCZfylS/F/gkTtJb69LMq6eW3D5JVemfcxi+A0urk4sMJAuYSJ41ZlH8qmos8sKdLcM0LGc0nmPrzHe2ysD8Pi8Q2kPuqVf/y3VXFELdP/doHcGkbEAajPirFv0kHLyQ2vo6De5CSWXIJODEUYEKHAozzQblBS4MA7LZp7ooEYQ+2Sz+p10DxTRsoHOGNhVOa1SDWPlJerIhnJbXdUr2qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM+ohfNYiWGeay45lM3FggEpFMKPXfUKvl4xBxXNToA=;
 b=cKo6mN9FT49mh7oTNvkmWNuC4hGx8d4geTNQ5VdAQNOTBlset/lvNzoccuqY/MXYgVNcT/FKP1Bhsjk1vXLaLArjC7HBSCcui8E+kk4jDafJTonraFuCuY6yqB5jNiNMNZZT9RnpD0CbyuJB9rX5pwXarC0VR3sbljvETraxKdM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3834.namprd10.prod.outlook.com
 (2603:10b6:5:1d4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 06:50:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Wed, 2 Feb 2022
 06:50:02 +0000
Date:   Wed, 2 Feb 2022 09:49:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] staging: r8188eu: Fix out-of-bounds error in
 HT_caps_handler()
Message-ID: <20220202064943.GU1951@kadam>
References: <20220202053136.GA238541@embeddedor>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202053136.GA238541@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7873040-808c-4e01-d0f1-08d9e6183ce9
X-MS-TrafficTypeDiagnostic: DM6PR10MB3834:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3834FC86E03D311C11915E848E279@DM6PR10MB3834.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:425;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRtplgC0acwmpbr6KBctYyMvF072pxQlW8Z1ivNF97BK96LdI2U2Mvb+4jG6HS5OopEw/kDEt4gaS6vXJDvkwXISgDjWtp7CtRO7rYp740yNabfQc3O3o8jGHzq3pRnV6ZaCuf738yqGMizNo+QDHLSO1zNl3imgrFcEle4NMfsHaM5q4V7MCw3FZweLN+IuwUGKmGqZaKOzSwZk+NWihuaswrVIgpiP3Dkv3Wy6n/w9Ayn8yfSTFvJwdU1x4GhJx4B71ww9IXNsYeLQ9coiFKyPjmEa00HpW5mQk1aF9o3sbMOVCtI+Md0VvQr9xW0TxOUUROm8oXo7WqZ2DNKl8FlwrIpEnnWToqliVN+pCC5XYWPE9blASz6Z69P3wh9NBe+Od5tPmyiWGTaNtVz1dRERVJp6B+3sdtsr/DA/75kB1yLDBRYlWklHTMa6MF/ztmsD6fDOW8NcRpxQLaMP+vXx53eIwKKV/2Rx5o7Lyy8jffJT9VqthFZ7jlqU3/zFy/nHNxVx+MvNX7Z7pS3JhsvYph0Mui34b87jC+2ZZAwF/NeUZnCtQIqsng548i1Urw4qUeNSUSRoVFR+TNGmi/1rB+gHg+TXwTt+Ytnn7fHTnOlke9zxOTcWM765bHX1cYmbFqz2Hvn8U+KyxB57JPtmTxq0ZzOqlp9wLZ/JPRuIUwnYKeRWF+Ex8QQ4BGH9LnDlh9BJmwd5F4FXOlZnpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(38100700002)(38350700002)(6506007)(508600001)(33656002)(86362001)(558084003)(66556008)(8936002)(66946007)(6666004)(66476007)(8676002)(4326008)(6512007)(5660300002)(9686003)(52116002)(6916009)(186003)(54906003)(6486002)(316002)(2906002)(44832011)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b6mVwkqQUOY63HqP+IjaG5aQq6UBSW/n0mDBzmKGL2EVpz62tAbLad80PXhG?=
 =?us-ascii?Q?QwaqL/7oKpc5IswM0SZbmFyn/iADp9L7E3Gftc26yOkoknuKwThtY3E1wBrW?=
 =?us-ascii?Q?/+PmYT+DuUZKp/I208wUGrHngC0ur3AaXtlv3NHbSkqZ7ePlugOj1u6Ab4Wr?=
 =?us-ascii?Q?9zhmZXue7rcD83o8qLJ35Ialul/aBGYbc1Uicdmk9QiSuiXf9ULvt1PoPxlC?=
 =?us-ascii?Q?KyL4WM3LmP5lzSunrm52hkeY44+RxmX9h0pdHya0zJp15qpXMHv34BLIpiSJ?=
 =?us-ascii?Q?fWOf3M6pf/+zxZafuIL6gU7ZKfw8JKVZwxJUApDHaFHteFmutK3EuFzfd5oP?=
 =?us-ascii?Q?goU7O5p0b89c1t2A0Qh+BGLi/j7lTvd6sPX+bwdagYhxHthrz3trHxC1sXEb?=
 =?us-ascii?Q?Xo0rjfK85ytkx24KxPS8hJ7hHdvXSpqBeIWeorJti5oRDZQCK2PsffelqYVk?=
 =?us-ascii?Q?UQCNd1/1VAplhOZfuQtW2bZjUoovqIW/GKWtGly2u+ZggM/RkC4c1h45MSKT?=
 =?us-ascii?Q?K29vb5XgzzyKDy4dwxN54Ggwgjd5z4BGW77QGHdtj2FFRQRY6+ZEVDtylT8V?=
 =?us-ascii?Q?VpoyDopkNM+lCsZTju9uDWcbMrKJJtFEifxaspTFSNiaIKYCzceD/cLK/8qe?=
 =?us-ascii?Q?RQ/VqEh0WafffhagKJKfvZk6N2XED5LA0BVKMbIySb49FjSTjEyHYNkWKZ0Y?=
 =?us-ascii?Q?J7tsghL+iYEOhgyTi0fXOdULcfM4B3mI0QML1zK+U5JbEdt6/k9Xl6vbjRZ9?=
 =?us-ascii?Q?lnto+okgeStYkP0P2kf8CcGnOlTiNC1T2x0FyoqHYvhXptgQrI6idZ+DllR1?=
 =?us-ascii?Q?8zHUZMMgenDaEJlZubLbn83fm19tMMlQkenG23Pf68orXBIL+d20VNsULyJQ?=
 =?us-ascii?Q?Sjbbg0iHjRcPPfl+e+XkCPZPl2Ugrq8VO3/75Zm5waL/GsLoF9g22szudueS?=
 =?us-ascii?Q?SlnfuERjLpvUUHJ+3T8zy2RIj/hzse5AcViMcUFdSijAiWyUxkVvl8e9zG4H?=
 =?us-ascii?Q?R3cwNHtlXFKD33kWenq0t4R83iqF5OQlQbLIvVItChSkL+ZOPcL9MFKjT+GR?=
 =?us-ascii?Q?wOWkyhSbbmig9wSYSyZ189g2lhd9XTdcxjIusU2LTLtTJ5TisI6tkz6EnzZk?=
 =?us-ascii?Q?LVvkTnY1sU1u0wBy1X0jAQnDh2yI0HmuujoQZYkvpY0Wj/0sRXpxD9ELRACy?=
 =?us-ascii?Q?87XFku/1lk2Wk0zqo+eKjimtEnRVAntDspPUxCwW/bwQEJXpXARaEkyMdWiB?=
 =?us-ascii?Q?HdZ2B8pDL1sGH7edIK10PLD3chUk3/VqNKnMffbuqVUsH1cH3iQThLxE4mtr?=
 =?us-ascii?Q?4WteGAVNRiHpenSsG9BKI2I23oapj0ntspMEQYV3dn7hNGdex0eLgtrpyggc?=
 =?us-ascii?Q?jnprlfmy2FDdy2ZVpJd2jMdNYGlcF03DFeiYshNoqn24Q1chgn66wlM+O5Ys?=
 =?us-ascii?Q?B66afmeEAxTy8YoUN3xwHkwN+Zc+/6W4esvvZYrqLddrcn9kMJdDjCPrXe86?=
 =?us-ascii?Q?dsTs+VXFrAvPj74tXxp/aoBhdsFIvHvhiGiRE7P+4JXTYyJWTxNJCqNXrQQ8?=
 =?us-ascii?Q?uzicfG3SGWG89pR31vzj33KK8bV4VetoiByNwqWByMiUYpPInOzxzAbZZgIe?=
 =?us-ascii?Q?wwrdbrcMJHYAavlpL3DPsKTZI57xfHP23Cr7Oo3OS3qDqEe+Rk8PbI2mtvN2?=
 =?us-ascii?Q?IgAoQ55adNxNk4FWCVTnfX/5dcM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7873040-808c-4e01-d0f1-08d9e6183ce9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 06:50:02.7383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXW6fvJeMT82JZaz+6mJEPS01pEs2U/v7TDHJXaXAA9uwejgSEh6CSha7pVDrFZHWpBaW5XqvN3Al8EfG/XBQUPZE6sM09J4dvPaeKcIlgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3834
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=942
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020033
X-Proofpoint-GUID: UfnFay4dPpYV0GH6VsRBsE926-0vNopS
X-Proofpoint-ORIG-GUID: UfnFay4dPpYV0GH6VsRBsE926-0vNopS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I really hate the subject because it says there was an out-of-bounds
error and that's a serious thing, when in the best case scenario this
patch has no effect on run time.

regards,
dan carpenter

