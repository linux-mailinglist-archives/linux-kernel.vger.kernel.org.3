Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E664700C1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbhLJMjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:39:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7434 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231149AbhLJMja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:39:30 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BABC2ZI012285;
        Fri, 10 Dec 2021 12:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=FdiXoPwdToBKZhM/yRZKsdttub6bNEWJiD1hRSMnhkg=;
 b=WZfFMyK1utFT2TRYecYEMafiyOHQoetAZ7/x01xfSeEyqemXGJlhTxmSPr+PkRFRNCLP
 AR8ZZ0Fx927S8lT25zQ8jZnGlHvyvRR3HLr1dfyW1DZbuvc4Y+A90T5vuX5xn9uaYoUA
 KM0yYNKIH8a1o0E+mEJuBBiS/tUNFDKIFfPE+d0Y3z5VDnJtX5xzhTEn7jXXtSR2SUEp
 xd24ypdXaXxd1c5z9RdX8b0mvDMMJVaTkH7ZDhFwTZlX8igFOigZPLS7bYNf41gacnWC
 61rO3Sx8IrFYaSt+izp74kbiqDlA2mNuL5MNXQNK6MomF4Xm2IA+NQpmK9dWSK7X56ss 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctrj2x7h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 12:35:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BACZb3r108256;
        Fri, 10 Dec 2021 12:35:44 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3csc4xn684-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 12:35:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cszEP4bdihs9EPEYXCMocJKH+uHrn9QlQdOT7j+/4NwUXRcWJfUy9/Zf9b+8MTZbM8e9qbmkV6qJTba8J4nxk3oio5+3QhEIcOeiOhlYIwn5P3ufdftCPqzgHrluHxnlrgnMG5+496UisBxWcWVxoD0MIbvdy/EnixY0Z650pAujp5UVO0u+I8yXST3fMyl6HhMQP/U2kvbkfpEVHYYc+og5SRhaCi1JPFFwrrGWvUw+ULg91ppunBtpjPAFUILWWCjv8t+HthLcUEYQQqgl/xNqbaKB0D7ybkV7VE9g5ktaThFJOUHJXKKCV4wKZv4yqHpflI9BgvdE1F2qpxILcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdiXoPwdToBKZhM/yRZKsdttub6bNEWJiD1hRSMnhkg=;
 b=NdbUbcAT9/S+SY1OjAcL9zNHk8sJVkXm+qFpCIJsJVj6jrpo5fs6pMlP66grnBFL5uoVUt8aXx8vpn2TLcBFIkYVolinjs6RqTSp4jNjd4+eQwvjaeWQnzKFd7M3OXshmjurn8biA03yk+uWnhA7SJ1BpSVo7MNswusKA9mVdUNoUVG8FUPL7athV83CQgjFR/LQUELgZD4Th8ko/FngaHTQpNeIGHnvftohII4HTEKKPm15uy4IpT4gpgILXQiokQmO0X7srg+ou48620kmKBLwLhPJ0WNBBxMrIaEf/lapsr14JcnJXy5yeaZKMPiyQA1Sg7Vj2NZgPUVoj0nZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdiXoPwdToBKZhM/yRZKsdttub6bNEWJiD1hRSMnhkg=;
 b=ydzOg8J2+czLN8LerkVyLLCOPqoXukCIdclJCUOXZewhy1I4iMO68QDFZ9iKRFDNkLR/VLvk3Eh8FG+WQtabQTl8l4zd1JAg/wJ/Q67gR0iz1kaeId5UvAWDCYgWtfiNH+GQnzeAq0yHVyIDXAivWkqcURmZzpSGKsihFmdJdA4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5851.namprd10.prod.outlook.com
 (2603:10b6:303:19b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Fri, 10 Dec
 2021 12:35:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.026; Fri, 10 Dec 2021
 12:35:42 +0000
Date:   Fri, 10 Dec 2021 15:35:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     workflows@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v2 0/2] Create 'Posted:' and 'Reviewed:' tags for
 links in commit messages
Message-ID: <20211210123518.GO1956@kadam>
References: <cover.1639042966.git.linux@leemhuis.info>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1639042966.git.linux@leemhuis.info>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend Transport; Fri, 10 Dec 2021 12:35:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73bccb38-c7db-4b71-2003-08d9bbd9945d
X-MS-TrafficTypeDiagnostic: MW5PR10MB5851:
X-Microsoft-Antispam-PRVS: <MW5PR10MB5851C65E7AB6032C357A16E98E719@MW5PR10MB5851.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnEDGWkgqFXxJ9wataaOE1xoPOKqI3IAYs17/QJMyzckjVQ7AUSDBuB8m6yZKqGyV5MJzL8p1UYpvPWLFsphBCOYEwacd+KBkxCijdfrJGS2l1umQZpRSynJNBW0zyJwNkOFYt6Kqr+4WBnajltXF/P+XdkJE6zOxzJGzpJ8U9iv1HLQHIqPWq/cF77rONycFCg6ADHlXZHkDh6AOcQ7IXMb5mqLvfJNwjRdZ6tS4/Md0ZNX4j5TxAMLNk8GbRfaKf++ZNw6D3N1B1WL8ELB3TR8HzqimKhCLxwP0VjkREG0pfwbp++chqC60LRIheg8YVdaD3vT/gYHqWOTPahkFt4zZtRDR/jpfoWIgqub/b7gZd58aTwjXvEpEknuX0zE6yjuoNUECNf0FytxwkY2C6zhL7REQFEOhMyHqSreS7wZEhoopsgKGmfs2JQPQsjLpSsbFo1vigO0PgUq8YsB/lNn9Y9OB4om7yRNbTDeh3V1X6Mf+tKTdTsx/Ov0FXWGExU+E9pSEEkWpQ9WuilZIF0WhKdXNOE2odY7q0wWOhYc/p2PFSWUXrYtX2YU6xwqS97Cn2JUZu/fxT6dwAuT1qC0Dd9w+74t69lTfuxAOCkA4K8eBxrglJr3t/f6XAt+LcAukugZ5RlSmI2l1HlYw0+byu3RBmOFzZAGWKp8/wmBiyyjyF1ByuG/SSKpIIHkSG1TGfP25rQS+czXTwGIfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016003)(9576002)(26005)(558084003)(83380400001)(86362001)(66556008)(54906003)(52116002)(5660300002)(15650500001)(6916009)(9686003)(956004)(186003)(8676002)(6496006)(508600001)(38350700002)(316002)(66476007)(4326008)(33656002)(1076003)(2906002)(33716001)(8936002)(6666004)(38100700002)(66946007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZWortJB7rm8ZhRtB9bTpdmfLj6ANI4+WTltUH9QgJii6yGZ4AvuqTxQdeTij?=
 =?us-ascii?Q?6HSDBrbrQrrvmHr74Z7W+OnRVAn1ffZvT/hYKcsR8PVZoFSKuBYUJP0BG8uS?=
 =?us-ascii?Q?FIh46ksOrPLeEP3AQlRjSwzeTwG1sl8eNuzFkjvx9xr4yBe9UKSJ0JGw63aw?=
 =?us-ascii?Q?JYc/5ucgm4SFsN6ZBP1+AhURRoQSh8nTx4ZSshp9k61WQdy7uAjw3FMkcMnt?=
 =?us-ascii?Q?vq5C+6ajix8Pj004UXXSkhwrsNDxaxKEAsUBCf3nibOwo/UdrFFJs0wE4udF?=
 =?us-ascii?Q?LMrDdHzHfnlOB2BL3AaSpaDWsBZGquP2IwEW1qq3lAwg4lT1hyBoiBYnpE1I?=
 =?us-ascii?Q?5kIIa21bPmQyOIOYavSkcvd7TvykI+sEZJZLIZ9n8FEw9SQ49YSE4YxHngMS?=
 =?us-ascii?Q?ykXMpJ55GPlwBhNfqAoV42CqoXEoZPJ7zrfvAbPmS8U2dfPaC4/K6uIig1i5?=
 =?us-ascii?Q?k0+VEOPAgywwwKrg54ah+eeEDWfuBhoVX+mQoQQ33dWV5OpopW9fEYen/y5Y?=
 =?us-ascii?Q?jQ/n77pv2DSTBqWvsmvF5RQv3YifeCWx3mpxg+0ddlNBAB0unfH9mru+O5g4?=
 =?us-ascii?Q?7GG9vRIHyEhwhs6wJ1VCH5507JPTAPJK9Ty0DhoeGm9FMk4B3jfhqRoA68AC?=
 =?us-ascii?Q?xTXZ4jsw9ApXt/YjU3tKYRpMeRVFmoleZ+zh09z+VGUBDqBNL03W/ak/xJkB?=
 =?us-ascii?Q?dxDRdbc9LTxHdSXxi0GrrUfuZEfyhZy58MKno9AfHqKXUkkCFgSU+iHOFWqv?=
 =?us-ascii?Q?jegnS+ESpfyaFgLCa1wzxL3ZsvaAQ1uZz0o53Oyxbpw4wEjjruZI1qX00BtA?=
 =?us-ascii?Q?BAT+rYPMuRU9K13GxQ6u5HAnpcnoFoC30Ev8K08mittF10WxhDTrf+TfJK/0?=
 =?us-ascii?Q?PXhI2AlI7qTsfwlqEBeM7jVI7CJvK//ccS4PFtPIiSzDOv+2N/QKijkaUKK7?=
 =?us-ascii?Q?boYvqhRxDW7eLyJaBgDz/GwBgp5Z3bj15rBXYJK6EWMwNnsrF5GCNqFcYEY4?=
 =?us-ascii?Q?OTHNrjWJsgZ8Wr92bGF6iDK5qm37XC5X4eHtCy/09mR+wh9DLymxR4PGCUK9?=
 =?us-ascii?Q?Dm/DcEWR85bckPk/1MPStDeBS0sPzuglSQ2iDpr7SjzAZEYktW/ekt0Yo/TJ?=
 =?us-ascii?Q?NOxHEegtRrq6oozjzkN4XhFpAv6bBqiiw9siAes0dS/jAEvwyvtO29dv0RZQ?=
 =?us-ascii?Q?Wz09GopN7TrRUVOZwQ9bJHr8m7OWbqFjx2Otw1wY8zEJnAz5xH2YJCJL5rw1?=
 =?us-ascii?Q?1kd/uiScO6jEajGDSiBuQpmsDacnSCqAhdK4ftsBxMqPUhjOdL/G+YOx2OlD?=
 =?us-ascii?Q?bwjCuGnrbxVt73bcpCTBStdqQ5+VBSezu3YD1TwcQoD9moxu1lRBtBLQsNVj?=
 =?us-ascii?Q?8upU5ugo1vFBrPo+Q3DEt/AduaargTNpZ+lMHohzM5cTFdGUu6ue5VoUIcAv?=
 =?us-ascii?Q?8l1OopkE9+FC248rPU2jnAfKiBqHde/cPOgc0mJosR41wzUfHRt6umNSUTV+?=
 =?us-ascii?Q?rxhgFdqm/WL2Fcr2hU1SYpZAYty4QjyyAEtoxKpAXjw7CHpkFmqNOqtzJjy5?=
 =?us-ascii?Q?livaedTRJHix0dQ+5zTIpp2UPpr5+AFAZRV49cB+YgH+GHNixrMctvENGVEx?=
 =?us-ascii?Q?pcoxQ0x3zgx9qKwpe7DIemyY6Z7TNCYXsMgcq9qHl5imL8pASUyBfWgtAegY?=
 =?us-ascii?Q?y5MRV59yfbEPmnVbl4ttiKEVOFU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bccb38-c7db-4b71-2003-08d9bbd9945d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 12:35:42.4182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UD7Zs6pfoo9TvHLPngBTIpDxACz8z9rLGywtF04uviquLNJ7tXcBUzI1eUIhrn1CQffxwHlM4UsBteZO6hz4+KY8RJ2vQyt9kwvFf3ylz4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5851
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10193 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100070
X-Proofpoint-ORIG-GUID: 85lq_PQOwJFnJIQoN1ITZhS_nmhf6lvl
X-Proofpoint-GUID: 85lq_PQOwJFnJIQoN1ITZhS_nmhf6lvl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah.  Now that we're all using b4 then having a message-id is nice.

Perhaps this is something which could be added to patchwork so that it
can be added automatically.

regards,
dan carpenter

