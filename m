Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41C64E22EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbiCUJJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345623AbiCUJJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:09:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63A8E6D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:07:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22L6Khs3017423;
        Mon, 21 Mar 2022 09:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=kc9axuQ8dHzEWPeRYXXXZKhVnjsqIxdKNz4UwTM9RwA=;
 b=jLh98SfY3FcyrAXyWMK0C5aBDgSTFTEOCV0LJgOTBJMXImZS7PS88esHWkqo9YDPPCen
 YJfssDs3NIwO087fJ1xbCYLUaVe0lzBk93Hx1qRkku42kguPaHcLrs9G8L4yLe8RI8w7
 uX2JVHkfoSV+YDkz4h9yLhw1EmNK0yXHNyrpp5f2d/0PxT+7XoplyIU4nomzSgbgcSFd
 6/f2CP8VNTQRLmYs6u+FL8w2w98PqeGTHBpdsJsvKY+MzIJNMxL6QxmPRR8in8dQFH8e
 s6Eq+44C3cV+uYvaWmRjzPuap2OrABPLXWaSaevqMxJ5DvQY34/DYS/oxhvopMAE4lVT BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcjnbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 09:07:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22L90Idc136234;
        Mon, 21 Mar 2022 09:07:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3020.oracle.com with ESMTP id 3ew700c5r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 09:07:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjqFaBGKdCJkTzTTpD/ml2GtMewrgDvfcwYKUbQ3K3pS2LuLIfiVNXU4ogEEtavkVsKOUkJdaU5dnQaL+7hohcBvY5gHxFQ8QHYdPLnD7LlkuBhb40sj17OG99XkIUxIv/oholq8uwIQ7a5uSg0xtx6lazWjUTPCnP3TzR9+PlxbdI4/QHJ2cPyz6v+fOC+2Ojc0CTVX91dl7Tg9xsrgF4Z9owBtJx+jlV7+74uj5odygf0NOC5X7xEFHjtZ9cz2dJp7Tj+mGk1WZC2FLkMzKb51AFH4SPOo0vfynWP0sleXuwTTYboavA57VzQq4Er0kG04r66H8zQ6zc2N3K6K3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc9axuQ8dHzEWPeRYXXXZKhVnjsqIxdKNz4UwTM9RwA=;
 b=nDrKp15SLp1QIGANPWs8AGKx8c5RlE+72uxM0LYDer3uS/mUxUWMZDhQmly7bDhJjf6bZZI+E9lcwsTRxBcJlDsDEjg+ESEEacJQFtK5H7IZ5X6CW46lGX8J7QispvGO/7/SzTzdZl8GalBXRZT9thhZ5z4zXBUZLGkXgCbDk3bzdgcIgq/vM0sC+cOPNANccd7JgVDE8WY8MgDSsqKwNOObOvPM/ZS0BxEuzaL6AWth1gby4yx/jLW2L7jcKbn1aznZSpNo3uWrzC+H7SGym6lw1TekjITIr0mqSzbDbo2UIP0E+n2taNADrj1+N4TU0M52bbjUfd+ljTv+ykc+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc9axuQ8dHzEWPeRYXXXZKhVnjsqIxdKNz4UwTM9RwA=;
 b=DdKjm5bTmJo5OLgh72ajuc0IOiUpAcsAnnYY8lDMSjIPCZSOFGDJ0BrUXFSvmGsmfIpE83CyuDtZ7MWgxj/nkUY8meRqrUWdwbC8hzmFd1SGQq8otlFFZap7bx6EZa5olDK1PokzPfnW+Eri4CGZVWhT0BN2tHLkUfCL0oejMUI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4881.namprd10.prod.outlook.com
 (2603:10b6:208:327::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 09:07:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 09:07:42 +0000
Date:   Mon, 21 Mar 2022 12:07:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: r8188eu: remove local BIT macro
Message-ID: <20220321090724.GI336@kadam>
References: <20220319180342.3143734-1-martin@kaiser.cx>
 <20220321081559.GF3293@kadam>
 <188ea71f265a4f9c968de68dc9ea6464@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <188ea71f265a4f9c968de68dc9ea6464@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0068.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9963be77-30ca-4845-6b67-08da0b1a41c4
X-MS-TrafficTypeDiagnostic: BLAPR10MB4881:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB4881CF132E918BA705EEF1518E169@BLAPR10MB4881.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DD+EcIRix+dPkef9vZGl50JKJ+m4jIRC9rXQIikZok/0YjEH4eLpn/EtzOVoVChAdkZPqYCsdttWne25T+EL+EVvXkgxWLAzuSxdKzO7L/Ge6rsjxWzbhyijpTK2DWIwbTCw+ryC/ZtTt84a1SjTTFj5trMEzNjuNRzB8KtDM+kqfs5uOzsUorGcJUvfrPjotjJcJz35dPL4tNNuZmm8Qbtw9YkHq3j10ORfBni+TcdnOF6hyq1XEXNYbun/9UP7T0shIDZT9kbwLowHi/raKUKfuPZNAV3ak80tqmF5IHs0fuFHGlEKC0wL6QUtqDAG8ylAXLHhDI59t3f4ryvyTH0uJM5bXg0yYmOTDoFglhjS1osdgJYx9LNIlxOQdDE0LEpptmyZPrx7EH02JXZ+bY14TsZjntWmZcucbRrThvrTDiRqeFp9Oo1TjahwTi4l5+5brLAZ3vKCRYlZcC8rHY2WrPTlQ+ITpeP6aiCeOzIBYekKdyCnkllhlSVo4+N2yMuvfFi1SjeGGeF+rPsAmWyFyQiUFlfP6lxWB00NkB3Du9VERC+lffHCvIF3KrZOanbJOUjHPu/bNLoWjTQh6aPhPr6GtFS7Zt/OXfHqOuhAeqK+gK7PdEHnFMZR75pTNbMk9REcvizayENrWjzNz0Wr8jsb+dPl3ghLVEnQOyrhYXPihw73WkmFF60pNT+o1hVJd8OSMwYY4QCk0EiBew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(52116002)(54906003)(6506007)(9686003)(6512007)(6666004)(33656002)(2906002)(508600001)(6486002)(316002)(26005)(186003)(4744005)(4326008)(66946007)(66556008)(66476007)(8676002)(1076003)(6916009)(38100700002)(38350700002)(86362001)(5660300002)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3/ZR9TxF8nzWMQc2kCbQZgvJWgSV71/95Z0IdmjbkTlGzIax+f8uXmZgL+Is?=
 =?us-ascii?Q?BM0Wntz7DdVTabfRqN5YtFX5SxDrGad92qR0VWNd/av52PuWE7pEHAhKRP/N?=
 =?us-ascii?Q?+Pc5ri7/NGnAZklAnfaf3N6LtP5JX/UayvHX85VCHI43xJnp/mI70iunjJom?=
 =?us-ascii?Q?fAhzIYHLnFHvo+DMwHfrPR/zDHB48qi1kftommAQoLFN+yWpU8cZaKXHL6ON?=
 =?us-ascii?Q?GsrPaE8upH+6BggFlA09x3JMKWDNI9XAgB/b6urvYOcBjJ+xBArdSiBqBwfg?=
 =?us-ascii?Q?HE7bkUH4oyNT/VCwaU41QbaxKhgjCPV+Wc4ghQ+nIM8Z6Wv3ocrOE1xJZnp5?=
 =?us-ascii?Q?G4vny3b2xqFLTfUUr9WYQRvFJxAeqbNggU94HW0BzX3/a3MXF3vc9it/O8lR?=
 =?us-ascii?Q?FRvBsPHYqhXw8b4KMZUDTEWxvOqwUq/sGV/6gHNbRrvBo1zbQvFB2S7U2uYs?=
 =?us-ascii?Q?a+6mhs8s6vtiJ7JapVw1xV6Vjcb3jsup/d6882wZpo0ixVflmpoAYdyoBFHr?=
 =?us-ascii?Q?gt4u+xqGD6ME4XQJHd3oA1G4yf4lZ45CDbhYUHV/7qcwTXf+YHjYgn84sVZ1?=
 =?us-ascii?Q?jQ4iNa7e6QEVsXH4OvWze/dKb0OAaJYsNydp6QNJIt1GBzY+Jv3s0aeReoX0?=
 =?us-ascii?Q?UEB+hXHlTaBkCpCs27q1v8VWIOohDL9t+XwVEDvToJnqoPyXdb0as7Sx2MDk?=
 =?us-ascii?Q?YkwidkCfuTkb/ir4DdYIhq+z5NQ4iCFTlvWFeIgG9iVrku7xYqFvwKFh598x?=
 =?us-ascii?Q?ypq7g9hcX+H9Y3DkyzwrgL4MX6Hy2HwarcC07m+KpxIQWVGZNLO0fVwrDQei?=
 =?us-ascii?Q?h/bB+Gm16V6cxz3Cpc+cteXgDQ+6oTUBJmGNxmvpg+wU5aW0lELPMaevEJFF?=
 =?us-ascii?Q?8e4iPbjO90+z4nejKPbjpPNeUaDDlBPBJVAEg/zdr7v1GM274iv2LKbgeEyh?=
 =?us-ascii?Q?2Ceg+q2PC6+EI2NhYgUtE2WO6nDNzsjp3o0Ik03oNiGuzJCK0YmBNYW0rnDE?=
 =?us-ascii?Q?+esmFAEfl9BvtkryMpYS1bQdcUEGdOLE0GW9zuJUQ4frmdHb4XEvhfMMEG9z?=
 =?us-ascii?Q?KK2bxSiK40taV9qFth53nLul/qcjNOtrXTcz4jPMccyEkI8XedadRwfnK17v?=
 =?us-ascii?Q?u8lEDMZ/VTFD9A1HY5T+jRHuX3Z+NDeAb6wJRySqLM1vXrQwc1CV7IbC63Ws?=
 =?us-ascii?Q?N/v6iTAsljCxgB5WVJEmMk16U9O7Nu59BrONWziYWkoVL5UBdWHMKFG3nSVl?=
 =?us-ascii?Q?u5iugRBAYevedZJAKBA0lC/kobnM3JNiU+diFiFhPkY5B7pWNTDODineuG2W?=
 =?us-ascii?Q?EnwwG7nFSEzmojrTzpGi+QFuhWkUpi9SDwYKFXFkFwxxqf6GNlKhR8Tv0Z4n?=
 =?us-ascii?Q?wh8xZN5Gew8pdyVCSjfg5FY/78x0pjgiTepNFc+ROPSWRA+ugnA32EBNDzW2?=
 =?us-ascii?Q?Sve8xZA3p88+PwQ+fo9yj1xUVRmQE1ETFyGlZkXzGv36iM1vO5YsaA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9963be77-30ca-4845-6b67-08da0b1a41c4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 09:07:42.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9QsLBP/cRgHjeVtw6T5BojIKCvdqhGttzhCRKi2tO4vUn4gRRgI+I9szp6u9iWCnY3/vBRnvKA4Q7N8KbnfhQvEWeKu6Cs1upjZaR9vGWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4881
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10292 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203210059
X-Proofpoint-GUID: azZnCTxw3vKj7yKkOkXxBQpKBJR5YZQo
X-Proofpoint-ORIG-GUID: azZnCTxw3vKj7yKkOkXxBQpKBJR5YZQo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 09:04:46AM +0000, David Laight wrote:
> From: Dan Carpenter
> > Sent: 21 March 2022 08:16
> > 
> > This version is better, thanks!
> > 
> > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > What the GCC devs should have done is run their checker on real code and
> > silence the common false positives.  There are a few ways to do this.
> > You could make ~ a special case.  They already ignore truncated sign
> > extension so they could equally well ignore truncation when all it's a
> > 32 bits which are all set to 1.  Probably the best answer is to do both.
> 
> Or start using -(BIT_VALUE + 1) instead of ~BIT_VALUE :-)
> 

You are a bad person.  :P

regards,
dan carpenter

