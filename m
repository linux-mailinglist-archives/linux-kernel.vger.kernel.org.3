Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114984BDCBA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358037AbiBUMgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:36:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358028AbiBUMgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:36:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8129119280
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:35:55 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21L9YBb5002314;
        Mon, 21 Feb 2022 12:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=cIfRRmiSWsKOWk96RMPK212phKWfRyP3Q2Yj/SIHYxQ=;
 b=R1DwZ4QOVoxnahy+pUjjZ/WFFg+jU39RXW5ZBksAKG/Zh91TKmbsnv6sSmWOQnKMSnV/
 N68C9QcvnualJaO3LkIsegxU6nfzCawm9l7YH1OW9/9uhoZUZiiInvgqRJ6miZDCXj7A
 08IbKEY1X67T6EkDhgPerzmDoU7YsA33HdN/GXS+jTJfNtRmyDqPfF98hncXUfmIv3/c
 vKKhfBM+cZiBDJDx5VQ+oUBLNb8r+J/Cb2NR+0q0iUnIi76GjpN3YZLHItL3ok7IGZ6I
 VqBsX7UOQM47ElSf90CDXVgEGrD7iogRXWSpYhjkTUGx+5CHtJyBJM0eYgkZVWRO1ice /w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ear5t40t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 12:35:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21LCGmhn031975;
        Mon, 21 Feb 2022 12:35:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3030.oracle.com with ESMTP id 3eapkenexr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 12:35:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWIIGKE7F/TkPDhj5k1soyT0jzDC9SO21OAIyaiijkuOXG1sS10qURJznFIkmhrhn2+F87cudn1898drlcPxBK6YrLrzoCJOWF39MwxvVFqYnY3yvQGx84Kn9ToJKvgQNHCu7fWw911fiNYt+2KG58w6lDRH15UYxgyDa8Wh5a3pVYDKgb1PZVpxu+8rqivFBj6aGgquL6NWBdMac8OHnaWkRUYkEjz5fw9Tcug+MGjuXWSN5rnCex0K26/yfrzrKvDWRwoV0YqNczff3qSZCbXPPp4ng2XTOMzZkQUwCnZejg74iCRmLo1hmiUt6KHZHeSbX5nJHLkvOeLm3DM3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIfRRmiSWsKOWk96RMPK212phKWfRyP3Q2Yj/SIHYxQ=;
 b=TWTY7YDfM/l1WfQIFvGuqx2u2tdsIYaeGkyhbhld0jAe4a06EKTp5U66ZJ5kXp/vGMKolJFO0qyDaLODiyEZO5zuv5Xb9HBVuI5CCnORySPhXQxuF5wulZDP3bjqUQBS8lSF+zxy5OPyzjsYjzupTQdx138Qzc80FbazqX3vCSczwtYQi+EMlBnOEnetW7djJbMLoJnmnI17QezngD+mJikfBUoQWbHD7s4y8qqexwQnpCZSRWgfFwUES6rdknDMP5lpDdi2hhDkkQdFOpuIyBM0O7XVk1howIRMrSy5Nqv8w1BzYFzo9L0ywYdOLSE0fFeWW5JBwCWyUlsFJiO4AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIfRRmiSWsKOWk96RMPK212phKWfRyP3Q2Yj/SIHYxQ=;
 b=pMz0Gf0JK/CM9kEvotjoeICqah9KEJd9PKNYfxi5/hlSi6gNtJB0wud0BXg4SJ9voOOy+OuOv691bnU9YLLQ5dZBlCh2R6xdvDdCHmubOkX0g4hCWCMz6HLMhFSjNpieK6kExjt6sBxmrrq9v697Bx76vkbjANh5lybnZeqsUb8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1655.namprd10.prod.outlook.com
 (2603:10b6:910:7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 12:35:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 12:35:48 +0000
Date:   Mon, 21 Feb 2022 15:35:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: vt6656: Remove ftrace-like logging and
 unnecessary line breaks
Message-ID: <20220221123536.GI3965@kadam>
References: <cover.1645386791.git.philipp.g.hortmann@gmail.com>
 <44f469737b788d1012943eb4e95997d40a947f04.1645386791.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44f469737b788d1012943eb4e95997d40a947f04.1645386791.git.philipp.g.hortmann@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0069.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::33) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3f9635b-1dd0-4d7e-7f20-08d9f536afee
X-MS-TrafficTypeDiagnostic: CY4PR10MB1655:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB165532C8AEDF6B47946B70048E3A9@CY4PR10MB1655.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdrDxRIPkI2Cq0uaWVssBj8PFNiiWQ+K9QNpvEuCQd8oQrnMLv4IvyPQLMQewmvL2D8LLjGSq/NpNB5p9Wqxky+23mfuAI5YeXv1S2wD7ufNXGgxdQkN51pO778g2+YpoD4HJiV/g2LkdIvynyEEEZI5CqAKyUfo90a0CF4Abaoq17CY+JVWWK+xDKbQGirQFB4lgCPuKot2nB79L6ZeI/mqZ/NfhqR8V+BmTD+bPbdIVvjfyPlLkeRssNMZaeMmTz93isVlE62G+xFPVF8X6zom17flIahB/HwlkWtoJWS901YazyPNFt25poDGVzM/bC6JkYI8I5Imyo+wcOj8mFZNneLXVvBoJduJqTQvNuL4MUzoPM9iD6meVyaS/8xD/OCF4IGke7z6dVmYgp5Kr6UTIpnVrH01++zCMV/nqe66krX/qjx+wvv/YLDYTvnjr1Jsjsm+eoGAG20to3VoyeGauMjBMLX0dgIpPFPgbQIppgzqu4P0Cumpte3JFR2a0AScYX8KrlZL2tMP4g24mzS6jmsGv8sgwzT0025A95xjolYM0Jl1VgWJzxvbXGDnhaun3487UHLXQskb3yeuFeDimJzwqC8m5FD/WwSsBwwYpTukmv5H4fojN2x1fpd10lRmyW7Z58n+o5q5T0NTAP3U+Vs5wEpS+vMP3fZwVrZeK/WHxgZHhN6QlcsX1au5OG07wgcZiFG2AWZEZWF6AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(186003)(26005)(6506007)(66556008)(6512007)(9686003)(66946007)(8676002)(6916009)(54906003)(1076003)(6486002)(66476007)(6666004)(33716001)(86362001)(316002)(508600001)(83380400001)(38350700002)(4326008)(38100700002)(5660300002)(8936002)(33656002)(2906002)(44832011)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J+1lfcrlB9uMDqfSXZ2R/fE9S+uHDw8ihr6bm1cJO19wKsP+YjXYpdXw4ZqK?=
 =?us-ascii?Q?Z+1SBSUIlrqJCO+vN2USkWMFjfCIKJKrHum4MaKqBTAeHD+4HIg4GJXK8JQb?=
 =?us-ascii?Q?RMhy6ME4LPswTy0vKHpT4JMvX7LEGU1IMrUh8ogoF3vhGKTCn3bB+pEv/8tN?=
 =?us-ascii?Q?HmiOSDxjhuoJ373SUNQwg+DZxgGkd6K/wjtfyW/0INVpHwcmHHKBxXmQ99kA?=
 =?us-ascii?Q?HG1xsm//qTqxzOLRlkgdiBi4maGNaxLIPtqUj7B8hNDtwlW10/C618W0ifRm?=
 =?us-ascii?Q?++QDtnykqke2SVxAvOj0vxvrQRiRfGzuldJlWui7u9iR1MaQy7KaD5LH7mf6?=
 =?us-ascii?Q?rJ8wUHTc/LDF2i18DyRugA3QaDJgXLe6ijzomcd6cRb0Tz3leP9F7vcnDFDF?=
 =?us-ascii?Q?+6QPwxIH/rHI8NmnXf+NL2Yn5SqDvULicZw2qlRVH/fw+/PF9ZuhNO0SxS//?=
 =?us-ascii?Q?eobDarXM1c7aJl1O6aoARgqxNjln+HidX9PuatwqvgSJx95v4XgfHoQTXseL?=
 =?us-ascii?Q?S16b3ltTvTdFcQTPy+CKBJXise6lt/gn0N23ItesbsBxSthgGIDsjMcSZa2k?=
 =?us-ascii?Q?mltMdJ2PQWpeCErfFvhWIe/RErft/HezNtdedFOuzKUO4wcLKLskpH4rAitW?=
 =?us-ascii?Q?B3h/f4gsZQ5ktB4LPlKWO2LsZ7Naz2zQ/NkMNcFV3CpyLjZ63KgVJaBsUzmv?=
 =?us-ascii?Q?PzfBXyTIhZOZkhkoERVu4J6wWIJH78/aIMW6kTxdsCDCteV8aRzAWy8+8Dc5?=
 =?us-ascii?Q?xKCwm1PpsrQR2fmbGU31wIt42vI9EDnGEGIGirqQ+jsOKeYn1O7l0wnUKdxL?=
 =?us-ascii?Q?faMS/zfaosr8CqRziief3k2rtuyJoErSFZuxAfnfxZf4PKSkabnPgOIjipni?=
 =?us-ascii?Q?j7+PlCWK9VI0XUOxO6qbzs4fW1dpEeduDbg8j1Ey/dQXU2lCNejjjw+J7gVV?=
 =?us-ascii?Q?18ODAOG/MYjMwiqhIs/gZaiE6BqdDGeobmoO93zPYyBWb57mgvatFlboQbUo?=
 =?us-ascii?Q?xWXE/J05oaBPv8BnFgq1aXULf9OUf42bA2Sm0NzoOOraTfTgOQ/kSpJaox0b?=
 =?us-ascii?Q?FJdxRohxdCiZITwK0yBa4CkKcbal2ASSxs57JaIzIhYbUDjqaumPWKdGtWoH?=
 =?us-ascii?Q?jzQz5qSdoX8sIIOae9VejjWx6xBcGixVkrfHsJs4wnLMjl2OMt2ITSRMJ9un?=
 =?us-ascii?Q?AvSBnUu2OVJX6KgrEPUpsts/ah3pDTe5EAU0qcq75e93LyUdpuU3Qk91+Z2V?=
 =?us-ascii?Q?m51OscPFLEGj6i5kHgYapAy+cosiiMmTPIvQOkZVk0unSRQVQ5aur1LDv3zf?=
 =?us-ascii?Q?gzjPVOK7vmsYMYSAHKBo+DyIqrp/7r5hMtWKfNwLO6jaQ3IgDufR2C27ZpQw?=
 =?us-ascii?Q?jMx0cslvIMjJjhd+qo97ObNL4E5njxiIYFa20Gsp5+p0LmlPnxnYIvJjqO0w?=
 =?us-ascii?Q?UCfmypSlHadmfouDgUCqCY6v9rwZjAVSk3r2KIRPv9ogUrht2b8uOGwI2GS5?=
 =?us-ascii?Q?ccEfm5AYV+Ey1Vq20wf1b+v19uT+eVM9DSv19N/JLNbw+8x2NsmPvWgP2pDc?=
 =?us-ascii?Q?Fze4ZIfFf0Oevrqg3zIU7qrC3hYk5XPtMlcNaoWOC4XWA/CYwUup/yq/qZ5p?=
 =?us-ascii?Q?AMonAJhrO6CVpfiSO1z6WnFYvVgfkr5qrdWmHDW3XtZZfTWHsYKjSWgZIgBO?=
 =?us-ascii?Q?3XO1jg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f9635b-1dd0-4d7e-7f20-08d9f536afee
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 12:35:48.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UT8I2LUwycGaz8bgr3kmQGJbmrdFi98Xfqi1FyoEK3u303HCJIFw8SqJACgLCixNJEMxvbydU7iUxLcn7277KZH5QIII1UthHStWzJda4KQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1655
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10264 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210074
X-Proofpoint-GUID: g8CFdZfPxJ8zk_Ytuzc5p7-XkRT2tSuC
X-Proofpoint-ORIG-GUID: g8CFdZfPxJ8zk_Ytuzc5p7-XkRT2tSuC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 09:30:42PM +0100, Philipp Hortmann wrote:
> This patch fixes the checkpatch.pl warnings like:
> WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> CHECK: Lines should not end with a '('
> 

You're going to need to send these as two separate patches.

regards,
dan carpenter

