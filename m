Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720C047767E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbhLPQAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:00:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56740 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238661AbhLPQAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:00:16 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGFOg8g031789;
        Thu, 16 Dec 2021 15:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=qUaKiJDLUakp0DMk4KDnKlYxw0l+h9l8lL0qAdf8FQ4=;
 b=ZCroT39fKlrdkV1dE+TTKiZrPojKs1Ca6vHaYQOXn1/gB1OZAQECvxun2uozJtsbhjQn
 5GgYvkWpIOvOXkGbInLGB5yjUQ3lPxfe6n8BxDp/Fvmg6aGRZ3DIoP4o7Cbc9BvK0xBL
 R2SumSoXsLfyD48mRKrK/2RxT8BA8I7shajROBqgf6glPcMD3p91nDEThu3yvU6YTyd7
 7CsoDDjFo3Iool1yKzn02MIlR0grTcFGJYU2jcJoKicqW87ygo4arLVfROS2QDyXhgaV
 6aQ54SH201TeVUrt95AeINGUungodFaZVYq9v3/+tvYJf0GwU27ZNg37IvUAaNrzaq+m sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmck516-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 15:59:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGFoC4i193047;
        Thu, 16 Dec 2021 15:59:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3030.oracle.com with ESMTP id 3cyjua2b1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 15:59:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmKD1t6lhYK3qEp2ASzHWC9qVpvvquYH47yCf3FqwzxfJ4yMl3NBwhMYnMydLJaJX96NvHli8TzlS6f9h6vGjmZzgN5Pb5XfERHU7jd17cPU/i/Pcjmdln4OJwUPEvKUfvTDx9UzFH3BSgyMcvfxqE5afYR5//6RDijLvHxzcRSsaTo1WgIZS97fWYSwt8WpS+MEd2DXj2UGuL4EdiIPrZGg358Z6bly2DXx3RivfZNfNTYgwVhJpkDWsa31STZqCLeRRQTBegWf3uC9PtLv1XxHbKyfquWB8EbVpSsj8RzV2+WFDY8dOyBmJQYmMkNrPVQo/M7CM4im4dNzBEUtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUaKiJDLUakp0DMk4KDnKlYxw0l+h9l8lL0qAdf8FQ4=;
 b=m1R8LZKD6lbNApCiqeFlPq8LVvYf+kyWLbR44vF9+UYF/hPixcpxNOLtBu59KwLviMPweTdrBah+k9jv/za5eublX1LZL2vDc94H2hAKz12oWDubIfvpGa5F5H+fnfh73cSFPZME5ZrIBMyKYxTJf8rBybN+oH7o3Gb02Fk58eVNQGu1xMq1+Sg820A+V5O3TPRACwoLEUzWP3H8JS7r6yCNwnhToo4cXZMQtZypH0hDN8NeXv7RRKREuVbX5Dwf+4GF9M+w1XsaNYmvYP+2NcLECy/4wmy9ljN+hXYw9C+QZhk+O6K483hmaPYAmZk66VPCBqxQbw0xC4lZpE8eSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUaKiJDLUakp0DMk4KDnKlYxw0l+h9l8lL0qAdf8FQ4=;
 b=qjO9ap5v90htwUHKRE5N8w28oML1xEOjVt+zX3KCumUefELHtb+C1AofuqIphvhcYIbBlwGGMeRo56ZQM2PGwMdo0qE049EUbFsNLE5iFTZi9+hoHx995hHfjlp3K8P6BhxV/ACg1h0lDPR0/AUxE6XfKVRJuxdDTcb462bBfBY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4708.namprd10.prod.outlook.com
 (2603:10b6:303:90::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 16 Dec
 2021 15:59:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 15:59:46 +0000
Date:   Thu, 16 Dec 2021 18:59:16 +0300
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
Message-ID: <20211216155916.GA7738@kadam>
References: <CGME20211123084357epcas1p14833147710153f9606f14941ac8b0d96@epcas1p1.samsung.com>
 <20211123083925.GA3277@kili>
 <562b12ff-e395-c818-787e-7fd6ee6d53fb@samsung.com>
 <20211216075233.GD1978@kadam>
 <b4d0c326-3122-c5f9-f376-b122f263d92c@samsung.com>
 <20211216080558.GE1978@kadam>
 <c8d18573-5dc1-4d45-f134-2a1dbb7590b6@samsung.com>
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <c8d18573-5dc1-4d45-f134-2a1dbb7590b6@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 715f9cf6-6e9c-4f2c-8280-08d9c0ad147f
X-MS-TrafficTypeDiagnostic: CO1PR10MB4708:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4708E5A81C7D819988A2F0068E779@CO1PR10MB4708.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xi5/LR6tyqn72ztDc3j9WFWbdclvqBHY6FAjbpU2+6oSh2Ez6Z0sQkL5xMvqQ4WIvYK3h4yt7RZqkKk4ZQnPYU2/q5Fa6lKD31vXD1RTV4cU5vsH8InXnAIUVp7Bcf6RF2ocZVRHF/wAgYFeA4T4fEd3vZIYvdQgOkxJJNBLKjzs3jHwYXhoP3+Xf/kvfZn6Mcxm8UClDlitz+ynQpHs7MvyEW2O5wXQBbgpFBeiokCYqVb1qGArQkP8JKWWPTqeGqcpjgzj8ZP4b4f6JZndM8F7WaYi0ZYvUEIGAB/npbjUBMQOo5O3x5k6ERspBiNEp1Vt85Wa4BYuwHC6tokPDuS4QV6y5o6YNq1sjrUPssGTrrLTx0KN79zohVO40EDtsmP23NguRvgdKA68QGK6+2+Ng0fLtOBMAW81HttJ6N/k9fslZPUB9R5sd4qTvSgZkZBoARnz3VBQy2y4T1Ooj3ZF+d8Nx9L8uA8swvS7hxnZiLe3RhbiSIiWfm/7G7Wr1QzUg7+rd6MLeSPDdoU8KSI9fixbWR4rjeS2MNG7byDkzuV/0ySRcGmpDFJYBsYHfDsiYw5waQGsxdCKOd82+g9pWUWBCYsiMBcH+Bj4DaijILx0MpNZElJIVekHECS6781XX/iv07pQWEVBPjXcbbmLGUJbU+j88flm5RtgUW92cGU6VnK428ZXXt4xPzKEXQDm/W3yvd7xQHZR9xxpFFnH8vxdYFYNw6gliyyAzQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6916009)(186003)(9686003)(4326008)(33716001)(1076003)(508600001)(66946007)(6486002)(235185007)(6666004)(6512007)(66476007)(44832011)(66556008)(8936002)(7416002)(26005)(83380400001)(44144004)(2906002)(8676002)(6506007)(52116002)(5660300002)(38100700002)(38350700002)(33656002)(86362001)(316002)(54906003)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AE38x9yDnFa6e/Ff542DDFQgh5dYjhWkyWHkJ/AcTxcSzQnABjUYICbB/IAg?=
 =?us-ascii?Q?5wQ0a3OyBJ53X/UM6xyL2eVuj1o6zYBrde1KthrqGF56uZAZLI3FahmdD7f4?=
 =?us-ascii?Q?XQcY6iGl/W5iC6ueDyZ/oci6Q5fKYcwc+9axGWwJWBLLEkgEs75EcewLzxN4?=
 =?us-ascii?Q?/VFgZeD+LqcJN3O8FEhd12Z7jZZ2vd6QPZPr6AJxGdNU7ZDBlu4zoquA+PIB?=
 =?us-ascii?Q?jqqtlE6zOxxmsx5S8+WBmswIIYX/aovU2ZyiiE/iFTt9wTaUuclhSsCoAKq4?=
 =?us-ascii?Q?vaqBgqYVSyHUsksSVQ3pwUJQMC0S4xpLJbMZlkcmaR8OE2aHb3lRg9pavutD?=
 =?us-ascii?Q?MaakvTT7f1dOqolG5XR+VkheYBBx/137b6Tr3CCcOADUJ3X225tljaEEZSCt?=
 =?us-ascii?Q?QkWxdw6o0FXnGfHVmkjq06Ms7VwryW/owZhLVivpZWyxFfBJDyqZwMrHuHNs?=
 =?us-ascii?Q?LIMPgWKhew9QKjq5W9XNjKHikJs6A5pH/BUeU04ObIbYV/cNZmQ+OSm8StFU?=
 =?us-ascii?Q?fU12aLA5eRSqUGsNR/ThcJTHnx+Lkt63/aFItxKIg2l3K/e8PzGmF89kTMHG?=
 =?us-ascii?Q?RxHs2Ur35AOY6WpfgO5QZ0l43XmqyTZqf5svvuSYMv1L17nxI76iv3bYDMB6?=
 =?us-ascii?Q?n5f8gB0cYOtvZJcXcAc1dVX6qiyFqW6E1sG5DM5/c8Nfeai1+AlvXjSY53cS?=
 =?us-ascii?Q?lc6+QyvmED8R3o3+DNXa9ashDDBWOiFEx7VjouZrCWJHMDuXjjhnUup9zNQ/?=
 =?us-ascii?Q?rYzhvgYGazqNlmtMZs/P6PjNlnNPQ1kjlcYzeNDsUunBXuBBjdCeS3LrnrFR?=
 =?us-ascii?Q?UGKFiLqqjHUNB6y2ahtLJsI5uLvT1915Ss2O+hFqsGiMlyENwKz8vZM67ZLN?=
 =?us-ascii?Q?MIcvI4ASotaRBmAwuV2ryTzxKiMwyLHB9SP8Xyt7HpLroagd4sPWonOZXy0k?=
 =?us-ascii?Q?HCzE9Dcw26t8R4Ueb6oqcy3ER7H6f4CRVn9/20/NKL1ALJJMZWIDjlomE+wE?=
 =?us-ascii?Q?bpzA3jspjPrXxcgvcWK/EhmUyq0oitfCdVOifHpYeQcLE2GTkpNKhmHEkHg+?=
 =?us-ascii?Q?gfKbRj4JLzcJqJXnoP2Fwu7k0c6CbQpcDkGokq/7/6nBHhbUpeOJWh7f/+rt?=
 =?us-ascii?Q?pH71tlxg2Ew6CXxp3v3fVvp9dQrcVcCvqGS8HAVzIXXMntxaC+qL/vq7Ynli?=
 =?us-ascii?Q?ZVQKUmS4MFVDiS0jnrtIY+dOxwH7Lb8BTF4OpklkrthOd2xKzuzezxuRsehI?=
 =?us-ascii?Q?5+HUCCQ8+iPQGN3CAhMCiA5O7w/zcpMt9xJuOo4M9CEaxDjf4TBmYHOnvXGg?=
 =?us-ascii?Q?yYA2IBKh0qMQQ/7Yclj/CsrqugnHkiie1vL2J2KbJm94nLhgWLXar7Tb6a7C?=
 =?us-ascii?Q?zB6+IJJ5ePjRZoEIpB+3vev+wlsIP/bWceNiD1SoCzoaAAzsKhxu7n+ZzhfQ?=
 =?us-ascii?Q?/rPdBb06GTAeg4tO5nHeyPVIzMPn5VK9RRFBZADlN7T7q8j5zl3KN8FLSh9/?=
 =?us-ascii?Q?ADRxr0zqXV4MZJ/oF5ROAuI1mV2RxyIR4CdkgmHh4eszIog7Te9+BghaEn42?=
 =?us-ascii?Q?dzIwpqz/mO6sZZp8CO9qmOOLvsuVCt0gO9QehO3zqUggrXB6brzt3YT/9rH2?=
 =?us-ascii?Q?EVBpGCAoYMnL4dOJVezGxn5jTSyAwzjMLfKcH+WuQMQ7dDUXK+JX0aJHfkwU?=
 =?us-ascii?Q?+hMZKmp/CbeNzktyHJ88hH/APUQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715f9cf6-6e9c-4f2c-8280-08d9c0ad147f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 15:59:45.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixbBsfmCcvGV1b87mGfX6QUZzAcie+6myzk4LGl+26sVwkTUuoWUob9/ZnzgBzNnezSLqDajKXKChuSVEYWA2b1H5eTXN19tOK/l7xskiWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4708
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160089
X-Proofpoint-ORIG-GUID: PI20O8DhkX6SWB_H2DJ5GUFKQ0yxtdRs
X-Proofpoint-GUID: PI20O8DhkX6SWB_H2DJ5GUFKQ0yxtdRs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 16, 2021 at 05:38:04PM +0900, Chanwoo Choi wrote:
> > 
> > To be honest, I'm not sure how this differs from other functions which
> > return -EPROBE_DEFER.  How do other functions guarantee they will only
> > be called from probe()?
> 
> If it is possible to know extcon_get_extcon_dev() will be only callled on probe,
> it is no problem. But, it is not able to guarantee that extcon_get_extcon_dev()
> is called on probe. Because of this reason, this issue should be handled in each device driver.
> 
> -EPROBE_DEFER is only for probe step. If return -EPROBE_DEFER except for probe,
> it is wrong return value.

The future is vast and unknowable.  We can't really future proof code
and we should never try do that if it makes the code more complicated
right now.

When Andy submitted basically the same patch as me three years ago we
worried about future developers so we didn't merge his patch.  But
three years later no non-probe() were introduced.  Meanwhile the bad API
created bugs in the kernel for current users.

To some extent, we have to trust future developers to do sane things.

I have also created a static checker test for people who call
EPROBE_DEFER outside of probe functions.  I don't know that this test
will work.  It will take a few days for the call tree to be built.
Another option would be to change the warning from "is this called from
something besides probe()" to "is this called from an ioctl".  That
would generate fewer false positives.

Or potentially, I could save a most recent function pointer in the call
tree.  I'll play around with that in the coming months.

Anyway, I've attached my first draft just to show you my thinking on
this.

regards,
dan carpenter

--RnlQjJ0d97Da+TV1
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="smatch_kernel_probe.c"

/*
 * Copyright (C) 2021 Oracle.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

/*
 * This module answers the question:
 * is_probe_function()
 * called_from_probe() which returns 1 for yes, -1 for maybe and 0 for no.
 *
 */

#include "smatch.h"

static int my_id;

STATE(from_probe);
STATE(maybe);

static unsigned long is_probe_fn;

bool is_probe_function(void)
{
	return is_probe_fn;
}

int called_from_probe(void)
{
	struct smatch_state *state;

	if (is_probe_function())
		return 1;

	state = get_state(my_id, "from_probe", NULL);
	if (state == &from_probe)
		return 1;
	if (state == &maybe)
		return -1;

	return 0;
}

static struct smatch_state *merge_func(struct smatch_state *s1, struct smatch_state *s2)
{
	return &maybe;
}

static void match_probe_call(struct expression *expr)
{
	char *name;

	name = get_member_name(expr);
	if (!name)
		return;
	if (strstr(name, "->probe"))
		sql_insert_caller_info(expr, PROBE_FN, -1, "", "");
	free_string(name);
}

static void select_probe_fn(const char *name, struct symbol *sym, char *key, char *value)
{
	is_probe_fn = 1;
}

static void match_call_info(struct expression *expr)
{
	int call;

	call = called_from_probe();
	if (!call)
		return;

	sql_insert_caller_info(expr, CALLED_FROM_PROBE, -1, "", (call == 1) ? "y" : "m");
}

static void select_from_probe(const char *name, struct symbol *sym, char *key, char *value)
{
	if (strcmp(value, "y") == 0)
		set_state(my_id, "from_probe", NULL, &from_probe);
	else
		set_state(my_id, "from_probe", NULL, &maybe);
}

void register_kernel_probe(int id)
{
	my_id = id;

	if (option_project != PROJ_KERNEL)
		return;

	add_merge_hook(my_id, &merge_func);

	add_function_data(&is_probe_fn);
	add_hook(&match_probe_call, FUNCTION_CALL_HOOK);
	select_caller_info_hook(&select_probe_fn, PROBE_FN);

	add_hook(&match_call_info, FUNCTION_CALL_HOOK);
	select_caller_info_hook(&select_from_probe, CALLED_FROM_PROBE);
}

--RnlQjJ0d97Da+TV1
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_EPROBE_DEFER.c"

/*
 * Copyright (C) 2021 Oracle.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"
#include "smatch_slist.h"

static int my_id;

static void check_for_EPROBE_DEFER(struct expression *expr)
{
	sval_t sval;
	char *macro;

	if (!expr || expr->type != EXPR_PREOP || expr->op != '-')
		return;

	expr = expr->unop;
	if (!get_value(expr, &sval) || sval.value != 517)
		return;

	macro = get_macro_name(expr->pos);
	if (!macro || strcmp(macro, "EPROBE_DEFER") != 0)
		return;
	sm_warning("returning EPROBE_DEFER from non probe() function");
}

static void match_assign(struct expression *expr)
{
	/* "ret = ERR_PTR(-EPROBE_DEFER)" generates a fake assignment so
	 * that is covered here.
	 */
	check_for_EPROBE_DEFER(expr->right);
}

static void match_return(struct expression *expr)
{
	check_for_EPROBE_DEFER(expr);
}

void check_EPROBE_DEFER(int id)
{
	my_id = id;

	if (option_project != PROJ_KERNEL)
		return;

	add_hook(&match_assign, ASSIGNMENT_HOOK);
	add_hook(&match_return, RETURN_HOOK);
}

--RnlQjJ0d97Da+TV1--
