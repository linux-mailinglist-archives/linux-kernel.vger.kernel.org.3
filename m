Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196A4476B40
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 08:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhLPHxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 02:53:25 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59494 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231932AbhLPHxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 02:53:24 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG7hhdN006553;
        Thu, 16 Dec 2021 07:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=cIQGyGz04oAnbkoThwBW+fszEcf8gp7mQdN3pUF5W7Y=;
 b=UvmQBvtfH/r6P63v3CyeZwiY/h5FUXTcC1MUvg343sI7TiT29AazuGDewP3/mr2oCcRv
 5b24STSHG5rWZsOBz31RXJGxHzjG9qIV5mptDgRb1+ks0GQi49tNlY8DZfpSeihcASX7
 UAiEDilHQl5Csz2N51FJY4RaATnx67mDDI63qR/cEUg9S4o4wr6X74xWZyabLuquEunz
 D5sfZAK/U47BhcNQ8iemZbKr46j1lmwS5SlTBgDdGCvxm3Ty3PfHvOAuWAYNR50EmBus
 4x/cWYkC3ZGcZXYBCBfMU0eoWZig8HMeK5640J73ZgMUIaZd3rrqRhReE36ojgNBtbVO kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykm59ycc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 07:53:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BG7kAuv189447;
        Thu, 16 Dec 2021 07:53:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3030.oracle.com with ESMTP id 3cyju9ha13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 07:53:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQac7o0xtIjbLlH2jsaLWIqfRuyIkuM+pJ21X1mCGLn0C/x/o5i9tQa4iIkbi7+iEMt/vnPcUZpYNDy1QDl2Q6Kzmw+2kukI1bYQfTOlB/rLu0dtFodtwiKJ3S1kvogtEMlnKOYF9E+6Wid3EoGfYA6+WWQAGLh5wCWvClbTz30auyUAoWgJ4mexF+DHB4QuTn3ECgi/ea+WzxiLRAkxauR1w3qrNLn4KlapqWsqAJLn+tPVVwmeXaD3cUiXZMReeoSc4GXOhPYotqYF0Pc3MIoUjUv1k8dUr9Jh8tceFWgCgFxHHiQcorNxqQJoRFNSjvSqdq3BHHxm4UDR6cJCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIQGyGz04oAnbkoThwBW+fszEcf8gp7mQdN3pUF5W7Y=;
 b=cYTVZaqebJjC4qss+7upx4VUZ4unGUGIj8kSRgJzc9nu1O4GPfQOAGPY15LR9RpwgppqwSqoYci25uBvCIGRZyiANrutgRIfG1SRrED8qxzmXGS3lmI1pgRrrwlAxA9NibP3nGxf5s+3FZ4tBSvCnP/uINhPBPbG1zdfZN89G3WmPRXl59B9aFBkYuRRiV/pgZ47pXW6A+qQhAtWr3J6CyZPyup3OgE1An3fNqDW+hS8eOilD9d8r54oDzBR0b1Dzz+h1eZ71CU1znGWfrA85/Dq7VuU6mCRTWd/2IlzVArasoDRALBAgK6bhK4jElAyOKa1els9jUVt4nRXAIPDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIQGyGz04oAnbkoThwBW+fszEcf8gp7mQdN3pUF5W7Y=;
 b=FnYbp0MsOmsEQlrMe7zV4pw/JO2hsg7/ks8soIeUcRb6YRecuHXnvQjQkuCqoEExQhzegfeq968PVpy+k2DB0BilWTjanNvynO5bhp5+10hXjvQ+u4zNJYsUCk+11+/Id2CzIU8TfZc/ie9V3sThB3biOwKy1OfSUs9q+HJZq2Y=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4402.namprd10.prod.outlook.com
 (2603:10b6:303:99::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Thu, 16 Dec
 2021 07:52:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 07:52:58 +0000
Date:   Thu, 16 Dec 2021 10:52:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] extcon: fix extcon_get_extcon_dev() error handling
Message-ID: <20211216075233.GD1978@kadam>
References: <CGME20211123084357epcas1p14833147710153f9606f14941ac8b0d96@epcas1p1.samsung.com>
 <20211123083925.GA3277@kili>
 <562b12ff-e395-c818-787e-7fd6ee6d53fb@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <562b12ff-e395-c818-787e-7fd6ee6d53fb@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65b2e952-b370-4baf-9b12-08d9c0691397
X-MS-TrafficTypeDiagnostic: CO1PR10MB4402:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB44027FF2C49E102F12D3982B8E779@CO1PR10MB4402.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9mkV+/yxNvtxIeMXbiDhDR76vSZ4sFLZmD4Gs86YiUzr0cNq/os/zleQUHe3DbWd/DLH8p18LQKpOCeEA4QIKHB/yu/JPbHEJYjWdURqYRvXYqhQum93YC6wtXIsN6dvupyBJRn2ZYBZBe8GaKsGWG77Y1XDIkKY0XCTGMN9Z6+O1chlhODuC6fK8ianDsf/QfIUsginU5aLfj1aCyTkPG+k7fapBYbiNY8thwCKmPmspgl52pEHQFCA9wWjqiHDGkGsPn5gIuem85bOZK+vsMQP89vTsOUMYBuDDbwc1Ra0zOReMkapkoTjZCyqkTYHBqYcLyQNfFaWVkaGx1BNWqScPnrS+jLfPJaI7gVX+jEDbVXZG3+LbBUzTG+AhTRwVhZHa7ITxptOWFcpfJklpzaNQA2C5Xw/VPTa9rYxmNkISMXewzZBW8vms2lDX37cheHaWuTzzVp9Z+50HIzXVgVA0/r6Lp07KVdnTAEDhdsN7eQR6uHWmBhJaMbTDCrNEA8IXQJq1w1sx1zvGnoNwRmrCPZuY4EAcY6FI3fRIuP0DWRBAhHcNuyGPvlsyDXSBd6IIu7kcHqWl+1Ob31WYoZom59ZxIyH6xaXB5b0H2PVLfcZLW7APu2Ht7tUOglDqg7w+Mfdm8/YDb1GP7EZ2bu2mcG7FsfIQbUVM7UFCxqJBdDnTxEY/syO6BPVkqpvffv0iAOvwK4K3Vy+yGy1raCpjNDTi9QA4LnivcsY66eiRDNmRkhCdGjzs0w1yT9XBcTEw74h5cXd4zxw5GYx06R2n2iW++PCIUACV5hdr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(7416002)(5660300002)(6916009)(6506007)(1076003)(66946007)(316002)(4744005)(33656002)(33716001)(508600001)(6666004)(38100700002)(26005)(38350700002)(9686003)(8676002)(52116002)(2906002)(8936002)(6512007)(66476007)(44832011)(86362001)(6486002)(66556008)(54906003)(966005)(186003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ttgxmHsfFJiPhG+NeW3SdBo4Gb6O0pwZZrDJ0wp9q7zZ7z3QOvWDrT0UJM4?=
 =?us-ascii?Q?NK+cPBRdPKFuC1OO8ISfsADrD31YnbKJd81Vr4JzpZXeUt5YNFa/u4Ecf5N9?=
 =?us-ascii?Q?MRQcSzUq9rIoblsAfnoOF6R3aN75pinDWsVVnHVOahk6rXAnM0T0rWS9agaZ?=
 =?us-ascii?Q?phq1/arfGRT/SHTTbj7pi4NyR6+jLezPfrYoiBAziEehlXcpzzdmp+UBiIQr?=
 =?us-ascii?Q?Ru0zavjeZ0NrPPXBhrO6iy/qApzMitrsmHLFD8U3LqnmTS6FvB6V98gUnCUz?=
 =?us-ascii?Q?XwQqbn84HFYtHmx4h+H4RxqLy+B1yX0Py9B/0PEePOyNT/XNn8RCu9WnYpmt?=
 =?us-ascii?Q?fhi1cK6sjQGw6p6SGvOIkQOJQImwV23XxDahy15+MsDrFhTUBouPEoyhk/7n?=
 =?us-ascii?Q?AQt+sKfiBhC4toT9L2Gx6mN4q7FZlDU/bursE4wUb0Zxcgi9vMWFzQbtemFC?=
 =?us-ascii?Q?7ckHvkwjycfaIuyS9BY8GRFRTL8Le5Q7402B7gl9dOROZaumQlLRNJR9lQ7g?=
 =?us-ascii?Q?0QfRdVOgdvk13J6gCi44qL9XSnOdMLS06IYZN4+qDFKvyG51/88gvpqhHy92?=
 =?us-ascii?Q?VZou6L7sv+mF8Z094OH69kHiw//TlItd/YCAR4DlYblhh2KXhCw4no3mUkLl?=
 =?us-ascii?Q?DLh0WouAVGKxf68mfmpC6htiboXx1SIaI/VqRpaDifHW1I/qw8FogJcdQX5i?=
 =?us-ascii?Q?LM85svN5ZKzFz9GJWJaCyHliAvTZxhoPL/i/DowFAdF47z4C3BmJuIXITOkH?=
 =?us-ascii?Q?FHZS8xAKatol7oFb2AsBrPPCOK9EULByIticfGgwIQiVKCQ0pJEJGE7uMxdg?=
 =?us-ascii?Q?4JRQxlv1Vwn8yrDVZt5itdTIxqMhDQo1ZDGGowB8LBGuUcqWK/TzPE7sU/6E?=
 =?us-ascii?Q?fpot9Nc1a1OzVL0Y9qlOcoJf+5ccl6hXvN/8isUl5symK0FjEYJA0KNDohW7?=
 =?us-ascii?Q?l5xBxO0ik25mwk4lcC0gB0hPDWZZ/xHbZzqaNrM44LCGtu73/1mk8FxGay4a?=
 =?us-ascii?Q?tZEd5X/LPoB2raTpggqeNmxNpWw6hlfHKo5Ib2G/zxTvWXJVqYRI66Ssiw/n?=
 =?us-ascii?Q?X6+c0J2/IUfnfltf/Jj9v8aeNq5JkZ6btolvpCGxJvHgCx8FF5o1nPqkI0RZ?=
 =?us-ascii?Q?jiBnZ2v4JyX5mcHk6vUX4GQWaGrn8AQxf4S5vkqTIzfaEnIcmONrqDikeNmo?=
 =?us-ascii?Q?+LP7MZSAu18mHbNcM/fac11WqZOs4lv8B+HP0Up93m4gmcwOE5ttALjWm0q+?=
 =?us-ascii?Q?4WJBr3JKPKGZolsK52NgjckNl55U2iZS5jJQzBj5/qe9WrilTUn2D+85b+bC?=
 =?us-ascii?Q?5aL44O5igHqBVv6RTLRCPS8UmQR+tt2bYL6mmovqJLozIqoaYgxRmwuMd2TH?=
 =?us-ascii?Q?vFWGquujlkyftLFBh4ZHxpPKtB2dTYki1XGNyvY06wr+EB0J50IFQNmasFOY?=
 =?us-ascii?Q?PBZJQb55TvwQBtpvFk4Izom8aceuKAhRhPrM0/6f6ovFobPmAxosoYfwvO9k?=
 =?us-ascii?Q?ZTjNC683rbpfpSrmsq/9dMADnnCvsFL+43pG+eErVIjCPf097o4qfYxEfO7h?=
 =?us-ascii?Q?OPRWbut0CiWoeVkSmeZtU67z0tOm0WBvkE9D4mUqDlpdlXtbE9Jgy3+FDdTw?=
 =?us-ascii?Q?Q1dJvUt9aE79fON+9/kDiHsEjUkV3g9XQ6n7f6qAJQvX6lLR86wRTFkgqO48?=
 =?us-ascii?Q?rZ/kBZsQqAl49Ki+L94LIMvEXTQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b2e952-b370-4baf-9b12-08d9c0691397
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 07:52:58.6165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W82Cubhhcjoc6grAA0o7RAItpIyd0lbjleM7s8GJeEjUYvECrwNpyIE1Gpgbhh0WErxmW/mYsrkP6M9P8ZpStv3xumud27uJAp79qBWJx40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4402
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160043
X-Proofpoint-GUID: 9SyO_DsbX1q9hoV1c9QtR-RLh0C0TB0H
X-Proofpoint-ORIG-GUID: 9SyO_DsbX1q9hoV1c9QtR-RLh0C0TB0H
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 03:39:46PM +0900, Chanwoo Choi wrote:
> Hi Dan,
> 
> First of all,  sorry for late reply.
> 
> There is one issue. About this issue, I already discussed on patch[1]
> [1] https://lore.kernel.org/lkml/5BEB63C3.1020504@samsung.com/ 
> 
> extcon_get_extcon_dev() is used for anywhere except for probe step.
> But EPROBE_DEFER is only used on probe step.
> 
> So that it is not clear to return EPROBE_DEFER from extcon_get_extcon_dev()
> because extcon_get_extcon_dev() never know either call it on probe function
> or not.

Currently extcon_get_extcon_dev() is only called from probe so it's not
an issue.

It's impossible to know what future programmers will want, but I feel
like this change probably makes it easier for them.

regards,
dan carpenter

