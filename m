Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442DA469711
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244642AbhLFNfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:35:07 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64590 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244627AbhLFNfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:35:06 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6CCq1H012705;
        Mon, 6 Dec 2021 13:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=yDHSPN7BzIoxXo1oPmsgwoEtjMlOlGOyZuW+dDy5KBU=;
 b=EWSdQi5acr3qWA72/qoORh5H/Xi56h09DiUShgvCLBbMcqsRc3k1iXmqJ6pk96M615Yo
 i9RYoy1h+IPySxxAUusPC5eiY6m7VY4v+CQbLcLWW+VRmzCpxydAr7L5S4mF8yXnCYgM
 6ZASXGOLdcpSNT3Zfb3r6E43meDOt5aUyhQX/Pzw3PKi0XWlZSKR08bBIY7FJBtt/2sC
 geKpEEpEAv7FLPBy+EAbm8J+MLNgng/Cv5VjtJFXwgY05aZavr9YGBNtWnbm2Zjka1s0
 36sOwFmvnvEGezo/lNXqma7RIDI4SM4ymrV3XREY9kONBztvNQ70SKvG+iZNh81OJmfq uA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csdfj9r1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 13:31:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6DR6Fv123349;
        Mon, 6 Dec 2021 13:31:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3030.oracle.com with ESMTP id 3cqwevygj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 13:31:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nn9+GwO+HRzutCOXUmlD6LICA+WWQobH1A7LFlVmAB98xsuaF1YGaupAZw6pov6ci6SJwV2eQTDGbU29qXwuW1we1sHTC81d3vTnHDlFmL92lxYrWCryz4zkLoWKVHNCI6BVfxLn/9c8tx0Sm5MOv4Gou21pR1bgavh4xNLcIfj2xqR1EmuJ43Y3OxZig9+h4jN24vooDx6jHB1pNyyiCmXt54yTG5qSg4eIvOrcDLbEYixl9tjhqyaTwRpidB0CUfDsXxuC73ZEZfF/D1Dv7rbqJQwrwVllc+YNkmHWQ9sayFk0UHgnC4cHExEY8rPbaz4DMSnQNU27UHlPUKbBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDHSPN7BzIoxXo1oPmsgwoEtjMlOlGOyZuW+dDy5KBU=;
 b=F22dXlRzbmWmd+oNo3YZAu96wmjp+l3gnBNDA4HY0cWYU9GuZSth9lRMU/UwN2r61xGA06Zc7gb/PHa5fH3NoPt2O9OU3xLuFxsUMfkOp2k6aoJghdLhgsL0quzlK3w/8LqMzcqXDJjg6mH2MK1W3sbEG7TDCb9iPAT2GHQH4Z6/EfFct3Ui+zo1nLO3Ta9/NNjtNQLg2lepr4CobO/QnGQ7fmXRtkJQ2Q1N7Swo2gtcVEMZ2Hp92bAQ1tNTvIkQuDrbVRou8ps5V5fBP5ZakDWsZdgMwrkuIgZQ6q8V96++7N286fo+nOt8XMg8v276cWhj8HurCVCBT7BfyezQdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDHSPN7BzIoxXo1oPmsgwoEtjMlOlGOyZuW+dDy5KBU=;
 b=JmZ5fZ8bDjavxxy00foELQh8arIxCBrUfTzKW+QVZk0YHc6UXTPjaahiwnFJnuzgQ8UJWQz4OOVUmi7XQBlo3qwzwlON4fIzW45hvZ1YZavHCT+YT8hIKJjnSYhgxEjKNXBJdwXFFFEZyucf81RFHqziK/tlyHPNq2tqmJFXd24=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5725.namprd10.prod.outlook.com
 (2603:10b6:303:18b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.15; Mon, 6 Dec
 2021 13:31:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 13:31:20 +0000
Date:   Mon, 6 Dec 2021 16:31:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: refactor byMinChannel to min_channel
Message-ID: <20211206133100.GA1956@kadam>
References: <20211204004041.3825744-1-alb3rt0.m3rciai@gmail.com>
 <e0fea904-1861-0003-1b04-6d2e966657da@gmail.com>
 <20211204090941.GA3805206@bulldog>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204090941.GA3805206@bulldog>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0063.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0063.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Mon, 6 Dec 2021 13:31:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06077312-da60-4508-71ef-08d9b8bcb0a3
X-MS-TrafficTypeDiagnostic: MW4PR10MB5725:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR10MB572549D505D1B5383ED520718E6D9@MW4PR10MB5725.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lSTKWGTHLG2gQtyJSNJIaK3NWq+IV7shhrRf6bc0lleIUt1GQPn/GRJ9s8AGPkbIpXnfnZ54GXHEVJHBPMHcobsXGbjj2U+ZTf1NPzbr0Zb5m2gyhnxWMQ2dd8n0fum0GjfrrHFMWmnVbPqnSZqcnjTFgOgE+bFBNF1Fy+qrS13RULulmYvlop/kohduYEefgnm6sIBKIjl4MfAkO6Ndxtbqw2YvNxi2LpmJ3ZvPD6Pt3wq3oYqlkXmjN/h3ti2NLDOL5aHIAW861q6xnYCOHwF7rsMnyC7O3RM8CfxOdM7IAxF0eNGhbDvECc7Fhju6Sy5gKcKsebCpiPrItSmbjRJz+4tNV0T+WuKIw/S7veyU1rDzw+ZgGd2TRiLUxQICjAkp2WGYzKYw4Rj2BEy1cr4k1dWSCoqnHQZxpfbLy4IOlbJtZQDjlcJOTEPdLRu/dMrwHcS6XyjSl1DMmo7bNUAhSb5y+aCveTH2/FdCt329ExV3NyUskCuZevqBrM696RbtIQIIeDVHNUGERFLncPEc+QFE9LUvVFQapA8fiUKX5l+IhyLE14FrnuEmhv1cwK7WFvKvgYcTo9rdy4qUmD5oQMadJENduxWCTlAhg2FXazuEMAa2shE33vJ/LN8j5GZUFI0g1KqgnGgUgpMKmkuM1B4jglyM3Xb6lWjDGmyZNkaZlJmWU2lvtSsStyb2W/qfahmG5tn1iUobJZKrnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(7416002)(33716001)(6666004)(86362001)(26005)(6496006)(9576002)(9686003)(38350700002)(316002)(8936002)(956004)(6916009)(186003)(5660300002)(54906003)(1076003)(66556008)(33656002)(508600001)(44832011)(83380400001)(55016003)(66476007)(2906002)(66946007)(38100700002)(4326008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wn3z01ClTqMYiZmg1abkSVAqnhXOT+V2wnoafH4P/t2zb1jpek2czqS9KCsB?=
 =?us-ascii?Q?mNte8FHCkA2cILTJTyzrYBksXMZUjc45lcnfgBBd2vz21fyg2Es6KxieITEx?=
 =?us-ascii?Q?qZHlqoD/6IUFN8BNEskOWLcJBCYb9TQm4C4BO0qIdl6zim2/fWf0BmLjFXKo?=
 =?us-ascii?Q?9N5eVG3em/RlVzXYwYlHYq8FoykYu2rQ7V+mtIs8D1OTRbnjOfPmw5OCoAvS?=
 =?us-ascii?Q?Gk9PcDX39YO7imvgWnTRM/rYn+gaiiAhDzMpuoe0plFysV9iUTL+DeqrXq9a?=
 =?us-ascii?Q?oEqSCixMtVleL4+yVOCysyL1/g8/RygrTloGaiId1D9W/yK+X+fofi4f/qtj?=
 =?us-ascii?Q?O8cJr1t9UBh6eDTUrUv22BlcEUI6wtpdnfU1hVumuP3qeB0bffQvG4hC9p9n?=
 =?us-ascii?Q?+DcwLB2AJfXqF1fEyPTrqvMQfMHfQDV48Y2BUmkmmPAuByIiHZ9ZTlUZEaI1?=
 =?us-ascii?Q?hg7537EDqfUG9WkzxkLhjvHINWnA2xtXNU7MTrWRZXMZf98X4aWpnHpGCJr4?=
 =?us-ascii?Q?K+NcxXLccSPQljoD8+lulGUbBLFsCQLTJ6lWbtvyEJ+2tiHMCCNVy3xO2APR?=
 =?us-ascii?Q?t6cilBibcsKk+5QlnmdzLD+LJRYLD0gM5cfAm0fTWAKfYpiHacL2JL1T/BpR?=
 =?us-ascii?Q?1mYt/iSvvWpuHQGtgIIqbvOyNvsQpC38RzjCf6W3cetWXfqw3m59R73yqMxC?=
 =?us-ascii?Q?kq/5LskZi04WnnHKEHB3XKM29X9CScd9rmh9xcF9WX4qUrQESfx1NIvrObDu?=
 =?us-ascii?Q?8afgOSytzJbOsFTorvnkN0HCHcIHVqgufJbOBu3gpiJQnbpOIX04vWR5RoAQ?=
 =?us-ascii?Q?u90+nh0uKDhdZp5WvQHpKOAdPN0taPlxSFWIutc+jyh9JKylPcPfcOdzY5UI?=
 =?us-ascii?Q?/+HfHO/Fq2TqE+cgWOcFUkIko0cj7Xsk2DoZ1+33acGOycYnSHBaX3w8UBwR?=
 =?us-ascii?Q?Ed1KlwwfpUwuKJJ7ikK0SnCCKVVK9HrBua4jkhNhUHs/lJB9L3KeAglIlimN?=
 =?us-ascii?Q?Y6cRc4Nfv0JIghf9mECs6bSlvoCmccnjWWBxkXJ3ABZvwmNCPy8r2XaAqvax?=
 =?us-ascii?Q?pWiKohj8rr9Eb9kVjq9slNb4ULGnwuatHv+Oe/XQ9/eZ0UjjerxMNHzEXPGQ?=
 =?us-ascii?Q?6MNndTDL1DnsEhKkI0ilsGh6fAEXaeuuFkCC4aq673+88lG3w1c0xa1cE13L?=
 =?us-ascii?Q?ve0Bv5PZCYIj3LeBjOg9KvGV2133uvjfhqgf5uJeUZE8LInm3k20zlkhUAas?=
 =?us-ascii?Q?rdn/cuhESxPfPUuawfnqpSH5CnEWyL/EhYNmAbCQ3nqOi6BJ6ZSG+yBf1JcN?=
 =?us-ascii?Q?N8K1Kxd0Bm5C6UZh6kcoKq3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06077312-da60-4508-71ef-08d9b8bcb0a3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 13:31:20.8748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHZRNIIZMt4r5ghz9osdl/zquhKg9SwA6T5SNGBGJT+GXgJOTP4/UfZ311hU6jUVR6cnty31bWTscMiEizYx69lLQOBUebQdy+ZPr1RXZdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5725
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060083
X-Proofpoint-GUID: 34YC5RrkWiKlYkpJriYW6FvxoJgT2fgR
X-Proofpoint-ORIG-GUID: 34YC5RrkWiKlYkpJriYW6FvxoJgT2fgR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 10:09:41AM +0100, Alberto Merciai wrote:
> On Sat, Dec 04, 2021 at 11:27:43AM +0300, Pavel Skripkin wrote:
> > Looks like this variable is set, but never used. Shouldn't it be just
> > removed?
> > 
> > Same for max_channel (or byMaxChannel).
> 
> To be honest, I would prefer leave them where they are. I'm only
> refactoring the code considering less the logic aspect.
> 

Pavel is right.

You should always be looking for that kind of stuff instead of just
doing a sed script.  And the thing is you're in the best place to think
about how each struct member is used right now because you're modifying
each use to make sure it compiles.  There is a possibility that no one
else will think about it ever again now that checkpatch doesn't
complain.

So in a way, it's better to leave the checkpatch warning as-is until
someone can fix it properly.

> I don't know if these variables will become usefull in a second
> moment.

No.  We do not write code for the future.  No one knows what the future
will hold.  Delete any code which is not currently useful.

regards,
dan carpenter

