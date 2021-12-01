Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36AA46470A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 07:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346850AbhLAGR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:17:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44364 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235759AbhLAGR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:17:26 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B14Zp0Z007178;
        Wed, 1 Dec 2021 06:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=IGbXW8ZttRGWg7k7TQpMyunNLxwJHXXZmMEPu4LtYkU=;
 b=pWZRioWGUK75441pS/GmY9udjNRvImKhD7V5IBQ1Gw7rKka1KhT9xAFl1Cjdfa55+9kx
 aG4dXcpYDZBGX+/lgj8eaGhYtw8F7ZIHgDRx+47LoMCGf3L+WwacHbjHA/v1RMQ4Wn6l
 eM1w+rQQWtvW4GRQAE1jD4E/H6iK1ZNwfrdcHWc7G8ELMb2ASjfJ7Dv8boQYVIMtyMc6
 hscC3NIU6XWzqmpqocqcXGIaOKvQvaX4/EuM76Axf966YbqRW1QJ7hNxrJTc4lA4JgLX
 kpn0AjODCu+ZtK5/Af5fqQmU6G3dRcrrHDrSTztpXTrOV82rWDtqN2jTMoiDDcYuCC9m MA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmueept8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 06:14:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B16B9fI186814;
        Wed, 1 Dec 2021 06:14:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3030.oracle.com with ESMTP id 3ckaqg0g58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 06:14:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKb/Piu1s8tjRcvzf/rvXCdT7BHzqUk8FUuV9TaoutDQlPUwqHktmwdTQ4WqaDomTsm3QCwizPhCNTwiuZUrE8jdNfRKd6WPqyeFSFGU8Ub//sTmebUGrlgsK4LBY9aoWuN3SuGkj1e5337XNrIEChAZQ4TBMQ3smwwL3WYQ/CseJI8tjbi4QxD63p7t7/nhFWUISqKP2lwLq4j1gR83LWyVyOUu4rldkI2DeSt2yQD1xKx6uNoGq1r8OjjYMyJGUVH7nEE2xjOZtgl9bSQxev8WeMI+CJr7O18EFTS2wOnXwUfU5q2+rL0jmsNlTrzPlZVzEtuZHLWKO0x0lhw9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGbXW8ZttRGWg7k7TQpMyunNLxwJHXXZmMEPu4LtYkU=;
 b=ZXiD7g1fFpCXtzeILwaqR7CEe1MS8WtUhxH29YuMv+Lir/j0YzuGM61Hpt8rIQRnYzFFlcnVGBnECtcFd0wimCL/5E0FBQOTcf+c5RnZXLwpdxPjnTnWcNpkULoDj/g4YcVnA43eD5q2NkNhtY3MIg+z1naJ3zTfDJ2i6p87zij3KiDKiDu3vkz1AEygJmtT3L/sYA9GLiqT70zZpbZo00IL+i5JPcM1UDd5n0htY6E0XRqE4wd6UGMy9JjVGFBu7dQg/Zst/LCpNoob7pqH7fPvuJfAINXTbUjSEOMibcPQkeJrWOp9TvsIaXclZrsgvu6qb2Q8VMOD43qc8FonZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGbXW8ZttRGWg7k7TQpMyunNLxwJHXXZmMEPu4LtYkU=;
 b=kj0PwPG3EsJdWyoGzigu1o8YWdAg/yZ91PzPn1ChtqMPf6UyYAZsFSJqWxy3Fbi1a8X+J+tnLjSsHAt9vpF/HeLFzzE3Nue8XTanIszs1yAyY4qknYXRV+ITqs56UuBHZC9NCm0vsQD5q5OgC2fs0vd5zlaB+Ok9zlWYTWCAgz8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1551.namprd10.prod.outlook.com
 (2603:10b6:300:27::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 06:13:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 06:13:58 +0000
Date:   Wed, 1 Dec 2021 09:13:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, christian@brauner.io, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com,
        avakj45@gmail.com
Subject: Re: [PATCH v2 0/4] binder: Prevent untranslated sender data from
 being copied to target
Message-ID: <20211201061335.GB9522@kadam>
References: <20211130185152.437403-1-tkjos@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130185152.437403-1-tkjos@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Wed, 1 Dec 2021 06:13:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8d142b7-8853-4a74-b019-08d9b491c2d3
X-MS-TrafficTypeDiagnostic: MWHPR10MB1551:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1551C3FA13BC43D8C16668508E689@MWHPR10MB1551.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P8iS5j5EyvKO8gS8T/M4Z2W38yOX6n2xMCkbf2Opc3pFwdoVzsoFUarewSF3oOHMm7HuF54jEvNBHwZwx9bQkP3vsrg61ncDawqbAJFEq0LTLdhTPNf2Csw4QQIoWpShntpsz9iHrYXpPcPLGUxmSQeVigKD3/bxpvAeTvaMsMTdm7U7gXIwY8tcEl+j96PUzXWU9Lohd4SbLZMbnFlbE9TVR5GKVb6mkrA93oLeFRPvcK3dnoewXg42rpHRQJQCc2SkbQz6eG6ihLvkt5S4psZ/pxV8TX+JXYsRe50rvcnK69D+yBrj5BQ2WSCof7RTq3tuycpqiH1IBCRQ535qsbnTImF6IMjsEVEQ3ejX4njYkQ7jwnkg9omCAPT8vr5c2Mi80GJbJwHIO06nf81F6vUX69cs0CVRZR3xUS+S1aSHwArQecwHkSPnRHImLWj70LiTn3u03guCa4PNMHkQuaoW8lv79qMjFplk9xNJ0Y0im5IY2UrQvENPRSxFIfVo3MpcY5qx3Pfp+4QaJal3pelC/ShlUNseHSOWPkVruQjPiGuyDI2ZeXc7qEbpIb1HUlamxT9zGUmaFvoydburMpkTcywMBJyqi6hFAC8gQiJr0tfDbA/tSR2ISUEHcCoU/LLXoY9oVqTNgxXiJLo75YYWRKY8oJdrcWET0yxER2ijrYiRryHiiydGdtVNOWjyqzFSFgTwKsQlg3CZeZn4og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9576002)(38100700002)(66556008)(66946007)(2906002)(316002)(7416002)(1076003)(6496006)(6916009)(66476007)(956004)(558084003)(83380400001)(38350700002)(9686003)(186003)(55016003)(86362001)(33656002)(8936002)(4326008)(8676002)(6666004)(5660300002)(33716001)(508600001)(52116002)(26005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4BTpidS7mdwD7QPuGoQEe+1Vlk23mbG9q7clPP3nH5xM2xcA3Yvu8HDrhzQ5?=
 =?us-ascii?Q?LKZiy3tSUvvgCFHUBBhDr/btoSyK9DMUvTyA79y7c5Y8PmFSiNH96nsCNZtw?=
 =?us-ascii?Q?4XmbOfAaoEpQyjXmIeLzn6tHmUvGEXaWGcYsQ67HY6JNJRrw84gJD7aXyZPS?=
 =?us-ascii?Q?xYlLMkAbvgLoWK22PHlrIcaD0bupJyz5oVgP3xexQoNqU9MRcrEY3jTQtcl2?=
 =?us-ascii?Q?BWc9nhRVVU9NMOtgWNonLlivX0suN8XMujSIPhCSY5Xi9DLK4gmG6JxWARQ8?=
 =?us-ascii?Q?eDXaMNiCQPw51tpxfogT5h+9FcDLHuQAn7Gth6vtwAGfpPBtom3XatqCRBIw?=
 =?us-ascii?Q?Y+5FAo+ALbmn82ZnZiMtL6qObLncIQuhRhBtEGwIvCR17PCVmyKlr3mnK572?=
 =?us-ascii?Q?eT3XySyqsmhmLDaGeKUqwm7341U2aDsi3ZxBtbKdZxWsktS+fT9s6thVL3tc?=
 =?us-ascii?Q?5rxU5B9ZEf7xZVBBpfZQv+PgkYFCxIRtHghJ4W+D0jOF2OTkaMHlhY5uD3hJ?=
 =?us-ascii?Q?MrSbKEnogHZTUDQ7BBuPdQC5RDP5e4//wveZKZukzhIb+u/sJX9OJ9sYc+Mq?=
 =?us-ascii?Q?qOGFk9XRI+CxyxvLnuBgEIAuxfF9LwblCnHsxxYRQ4G4MuFh127VAsdM+Ryf?=
 =?us-ascii?Q?meEeROMLyMqo3jBk/XDsleJzn5GKnlpzPWikM7fxAM5wxR4LPSWcf2nTXTTs?=
 =?us-ascii?Q?jh8lumS3MyjOM+37v7U2zjLtda5wvwsbKbcr1P/bxvCb/V24FF7IOWCXVcKZ?=
 =?us-ascii?Q?oZLjTjG69Ro7jMqCJKzYoT+gU4bbiz9RazTmkHcBS8JeHOGk24C3QsCPTYdI?=
 =?us-ascii?Q?wNl2PBkgVmVgrS1Y+2MpvpaBL47CIfB4UKI4s7n/xoQJWZKAob01rx/a/9ab?=
 =?us-ascii?Q?eu2QOGNcH4+4EC/05TgAZtDeRhEPxu6O4WMo6lBEB6nsgwQPArQjIdx5FLVe?=
 =?us-ascii?Q?OpsjJxCC+GOCaSWQWjAw2ZMFpg4Ltcl6buG8ecu/prLB+gq3R9AlVUwWIYnY?=
 =?us-ascii?Q?DSxYyCpaek8Afio6P+3DrEr8w0qVqvE4U2ShroDrX+gBG2ng1a56lksqlOev?=
 =?us-ascii?Q?a4IO0c2lXXu8QL7STshyBlWzHWi6ihiSe4amJFNJoxt7QQF/cWp7MQY0I0Su?=
 =?us-ascii?Q?0+QF42ozyiORz3ubidvQ3fLVsmAyJTATRLaldcgaijrHsfASFyk2zU/C8YX0?=
 =?us-ascii?Q?reaMMm7XytXv/s7R2D8NeTJeA0B5eOtYpAOfKqLIw/vTGSN/A2idHpOwL6/3?=
 =?us-ascii?Q?EFnIOx3m5mp1NeMvnz9nX8Avbo+tusAgXr3maP/45UEh6Noeooc8bgLvqGND?=
 =?us-ascii?Q?3mOHar6KJ3lEMfTJ7+ro9Hbc2eHud2ngr6jjNIQpZECw+GF6nEIoEjpvGE4z?=
 =?us-ascii?Q?gK1QoiyeUY+X3ESge66oORTNr3gw9XcOTdeI7Flk3ptEF3bIsuJGTJInPlYR?=
 =?us-ascii?Q?6heuq+KY35skGtvA5dMLpo8HLmIz+gVCqPgSMUN5UctJe22Zw8YKON4qr1KN?=
 =?us-ascii?Q?UOCiyXIzkdRThfn6AzQGWzdLKGN+tscA4HVdx+d+EPlPs5tgb7huM+rxaofU?=
 =?us-ascii?Q?3hkFP5D3ejuVcI0PQU8Av2iZfwUXe1Q348GLWuRR4dW7YF2cEW0gMoxAl7fF?=
 =?us-ascii?Q?+Fax8nuGOUlpTS2qMDi7q9rq2h1QexAEenQXDom9bQ9W9c1RrQvP3ijFZkJL?=
 =?us-ascii?Q?WtKDm0hiXUcgHgx4d8efVK+tGK4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d142b7-8853-4a74-b019-08d9b491c2d3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 06:13:58.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arnnSCdm+3AK2v1JwFj/0mtp/CShbIuwms0h95By7T/bELyyi+wDLCEscgxjAMDNki6OYeDqtoHYMlNNnGAUTsZSFSzORRXeJ0dLBvFNHYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1551
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=904 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010035
X-Proofpoint-ORIG-GUID: tD1teP7rxsaJ8xkS56bz5SBPpA-lpM-b
X-Proofpoint-GUID: tD1teP7rxsaJ8xkS56bz5SBPpA-lpM-b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:51:48AM -0800, Todd Kjos wrote:
> v2:
> - add "binder: fix handling of error during copy" to fix
>   bug noticed by Dan Carpenter
> - address Dan Carpenter's comments

Thanks!

regards,
dan carpenter
