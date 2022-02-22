Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4811D4BFEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiBVQh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiBVQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:37:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF4624F16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:36:57 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MFgLv8014977;
        Tue, 22 Feb 2022 16:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=SSa5NcsKEe6GUFR1aZMSryoMuLirW2PtI66mgbZfK+Y=;
 b=j59b4xX7AluxV0tQbNvRKQX/9GaiTDy9V/qqd3wijd/Yq9VudS2AJfFzEYPhj/HBniMh
 hz+CT2YgzZe4WTI9Uat+6Qb/gMSTK4yj+SECitpF6Y8y6/11PcSce5e1gmUmWA9Vn+G2
 QjIClBEiCaAthDCkafEdo6yeqrm/oH0HUrSyhwluOa2s3J1Iub4yZec1FfYoXi7d6FuF
 FuvT4Rf74ae9y8E6DvZdG9MXmYT182NqZsPa/+txGnZmuIrh1VRRFOfkBhDC2zO3AV1k
 6bdpXBYAYqaH/sgzcBU38gcFP71RB9a6TTcBVXGYG1P1gS19JvGc0WLCZQa3NwrpHfSb sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect3chpk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 16:36:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21MGUTfU017314;
        Tue, 22 Feb 2022 16:36:32 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by aserp3020.oracle.com with ESMTP id 3eb4816cr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 16:36:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwLuk6BXqSyv1X3s3EEZqWDxFhyfS1M3Qy/hbP4h4qkjtfrurhFGtzLaCBcSWIC2zjC334p/F0hjtNHvhVIL/9RU0hOac7gEajkD7eVMbEfnDvazlj2zk8ELJqcPChSTMzefilLvs+lpO+kkh/urD9+AevESMZ3mepm2zTECjq2v6kFmv/fIKc1G4PrOuQQbybQaidw71bghyvyljyfqfEKH6fF8Cv+IH8a3qndAIm+nDkT92ZsLiERm48OFw82DW8hUVKurcQqMQNZZhyqHbmTk0JkiJeguvmxgEVdD4LW2OZB/eDttYz8zI2c4ifgZfgxhPLU7Yl/M6zDV9xCo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSa5NcsKEe6GUFR1aZMSryoMuLirW2PtI66mgbZfK+Y=;
 b=IiNeoKHHy3rfmfkbGluwWWSe2O1Osat4FO4LF9LViC9V1x4zlLx9kJFJe18Hw0k1O60mv15hc222/YN8OdV61Er700QExwLcwvkQ+graFEyf6+8V6bnng7iRjbjwd6fsoNxwqOs9AymHzwpe+cEsTtUguwX3CnyUhE8SugdRHBt0E2r9SYYr+r5XkeIog3TtyQg7Z10EDvRDZ6331YRaRNjXbDR99QqJBcdU6xgWBclfBoFaa3L3Oxma4jDbTtr/T+QqOkgKpw9alJsTiLZWAoVn8ljyGbrecKbZlutGb36klfIhaJuaCgedF01K2JaWV2ZyE3nZ1J0z3RZMm35+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSa5NcsKEe6GUFR1aZMSryoMuLirW2PtI66mgbZfK+Y=;
 b=nS3Y0cnLrf3mWnLts6GRD02Sp969utOrKKe5TKQD6v4Qyo/ywjNuF8QEGVCbFdjO5ZO8X1DqHi/2sW0qyAui85kfdEqH59C+qAWsNEG7E8fWJs+eKh/8HQAxJnlkvbUbT5NNnvuaAxZZgPJ/5mshaf8pNL2VWZFkfBbBIbXbvLk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4501.namprd10.prod.outlook.com
 (2603:10b6:510:43::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 16:36:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 16:36:30 +0000
Date:   Tue, 22 Feb 2022 19:36:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Schaufler, Casey" <casey.schaufler@intel.com>
Cc:     "Hocko, Michal" <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zhenguo Yao <yaozhenguo1@gmail.com>,
        Liu Yuntao <liuyuntao10@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>
Subject: Re: [PATCH v2] hugetlb: clean up potential spectre issue warnings
Message-ID: <20220222163610.GG3943@kadam>
References: <20220218212946.35441-1-mike.kravetz@oracle.com>
 <YhNQf3LUZzNRD7u0@dhcp22.suse.cz>
 <26565cd7-01b0-197c-6ce9-af92f5bc8563@oracle.com>
 <YhSVGPQ6VIQfBZ9o@dhcp22.suse.cz>
 <MWHPR1101MB2160B81491FFE4411B18F7ECFD3B9@MWHPR1101MB2160.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1101MB2160B81491FFE4411B18F7ECFD3B9@MWHPR1101MB2160.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ea8fbe0-1796-426a-0f85-08d9f6217a77
X-MS-TrafficTypeDiagnostic: PH0PR10MB4501:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4501539FAB80B9E0EFDCFF248E3B9@PH0PR10MB4501.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eeFfVrrKbip/j1QMlb5EKHtxTA9FwjWu1lJqKr4VL+SBBBmtAl8n/tSOqWHt2mFEyneQhwYIH6osNmCADDpqadSHd4BjqpNkBIgbegwKWCvN6ghUJnFY6TzvChTJf5oID+pBFRBTcnK8Zk1FctGcOj4CIuCub1cG43kToMT9l4A8ggyqcOfs5ERfWy9wl0lTxXnM7w5WJgA75f9FPigGz8pLcKBzwNKn9hPM3QbuGcvakPqaJ8whDgWw2s9K/Ret9IgWtLIIBtpHAJfAxfvUeWpaH00lX4nMMYRkE2eUM0w1jinzc2kZZnEzVxvThVgIeO9ltkTbppzxnbjXGerFeM5psSLiLOYfAvEZMP+Y+yBKpqfMXUIS9OR+VjaaAOZWycnX/JZyZiewWv7VZqGH5vwlaM1f25lgBjyApaAuVtqt3s1x5J4C+4e7MYjzGUZ3kWsrUQJGsApkK+8gZ5LYr3bzv0oVyiNSQrGXamFdXgEaFmieOeifVXUBHua61ZudGk/nL5SPB63AGPWE2jTEsXWcomi3A/t+mT4FK5vKPdObw2Vc7A+q+Rg+qhfIKHKDUe9x5eQVUI1eXxqaGx0wMCwu7mYA8ot0rr890ztFdTXtFaM800Dfp85LVeg2nFv8QHBIeBzKrchrGMamwqnoE0ByPEqUHev2uwiCTmt+BVeCUzucjOJcc4exwzZcmQIfAL0/quusLZs9F/sbjyfY1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(186003)(6506007)(26005)(52116002)(2906002)(38100700002)(6666004)(53546011)(38350700002)(44832011)(8676002)(6486002)(66946007)(66556008)(66476007)(6916009)(508600001)(54906003)(316002)(4326008)(8936002)(6512007)(9686003)(1076003)(33716001)(5660300002)(33656002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PaomaWDld97kvYcwd8E4VwkNhosf5CKWWZb2iMpo8WegiTtokDY7mGlMbvpX?=
 =?us-ascii?Q?VPQbaKbW62W95iwM7W5EW7EcXaPfr8SlFeSPS/DnYYm8OnYxG98OHRz3mcSl?=
 =?us-ascii?Q?jaBMX0jld2gTYQA1pchh1aveIhhZuJIqeJ8/+zMu1G9ujwax0j104C+tOKmy?=
 =?us-ascii?Q?fQrrw0GMc7yzJtB4ODE2H9smXtSqh7g6RC/RcDQscjQuFg04kCfO552ZMlP+?=
 =?us-ascii?Q?yEmnBbFu4bNGiL83c6IQn+bwyJhsQnKzJhFqNhH+P+uVFgVbwNIqMdPJ548U?=
 =?us-ascii?Q?DobusEtuInUoJe+oQBvfFnGhZMfvzkxqLvzHBo6mGqgT3wvfGizymEY/GWbq?=
 =?us-ascii?Q?irOE/nd2OuzsSWgNFjKzkzlUXdUqF6o1xM7mM9XPX7gtkAMDXEfAmFIJS6qA?=
 =?us-ascii?Q?UXpO4MZF0SsV5dJPMV0JRswLxuGAshONKTpmy6ZW/WvheXTIIdhIXX11dndS?=
 =?us-ascii?Q?qvThdpj7kJ6e1KK/eaFDm7UNNtB0bg0H0OvLiMeAO5n8qHuIYfoujiRZ8qON?=
 =?us-ascii?Q?Ejrf7mB+xM38t1mjWLO30xqN8MGBqr3x13/2SpZD3QBmZmb1c798NLOUY2oB?=
 =?us-ascii?Q?VKwSwcoW6GHWPxy+6GGF2l4G2cz4rwqtUJgQW65btug566uNXx3JeUJLVbNi?=
 =?us-ascii?Q?kNTIJjUHOcVxkfQGVXYuYxO9n4eRQCJZNjfScd+roiyJZHVKdGSolw8m+HC/?=
 =?us-ascii?Q?ZNhpCRS3BrKMop0j2mXJopJp6uutJy30+w+JxVIqKSYhbiMrr/gDDuPxkc5e?=
 =?us-ascii?Q?MzYJAmgwPVQMUZBWbN5sdpLYEb9YoUg2BG2d+M/WDLkkRgW4GCfonZ9TfE5x?=
 =?us-ascii?Q?9hsz4rHFEO3mTANcTSSb5zf70+TJF70N7VT+vdLUS9uux4H4eVt3qA0S2PtZ?=
 =?us-ascii?Q?CTAVcjcY9dSeThK193dTueRgRUAAnwOx8h6IfsOzMWHYhGJKemrqaLmT1Dos?=
 =?us-ascii?Q?nn/hQ7Ip6cWLha2mT7J5nYK7FvFisd8y9QPJct4oKp3fJ1pBgKkGVrxEcwHK?=
 =?us-ascii?Q?VDVd2eAyOvqTRlAQgfaaFC49eBWh29GQRFVMdynIiN6ENIYVLAX+Ewru12he?=
 =?us-ascii?Q?+zaeivrdKnwEi5Q0ZADI7O9AWB/reOe2SyHzoNJCf1Q040KXsMvl/zsvf9oL?=
 =?us-ascii?Q?J61dcbUWoLm/yqujoHx/t1DwNftaAuEEbyv09LS23AQxQlk9WG6CNV/svHGm?=
 =?us-ascii?Q?/4SOseS9BTJ5sLHTBIJ2lKg23v7GGTpLlwRVBFvmSU8AjkT0wJu24obyH18p?=
 =?us-ascii?Q?u2xiMxfodxVcDVBsh4gQxL9wTfzxsvD2GEJvoWJTHlg7vGLgXz/eL4xHp1sn?=
 =?us-ascii?Q?jj6jrry6fOHQRIQW4jcp6yk6wvc8DGn0F7yeYoDQdmmPboXft7k04xdry55p?=
 =?us-ascii?Q?9k3ebJonNZEcpykwt2iOARnZXA1Grebbv97C+2hrDcW177O0u4Eqtt36otGi?=
 =?us-ascii?Q?80AQOEkr6cIr9UhN+hJl5kwikHz24GtNhJ3oDpPgSODGIXO0CwYzJrPs+Bwx?=
 =?us-ascii?Q?yscwylKItyuHG59BfldZifT2+Ra91ioS7W/PmVezrKQ00kp418MxiKhcp6xh?=
 =?us-ascii?Q?qWAz0jqWfBKbHvXogeGHdf6DEC64tcDdhnHJEWcqrHBBiZm7roj6E3CCr1+X?=
 =?us-ascii?Q?dZvNfcoZ94c9TizZEKy5Ctp28Y0d2XrDbStHfl9Q6xPDTno1r7HsGTGnYClS?=
 =?us-ascii?Q?BUwuTQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea8fbe0-1796-426a-0f85-08d9f6217a77
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 16:36:30.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gO9dCgGE8ocpzgqYAIr987EyBK90Pe1Skey6SgCOn4f6uA8e8A6+sCCLBPkT8YhwpybU/L74GhgIBJ9nx+IMry6Kr4LssqSFE7FIlDOWSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4501
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10266 signatures=677939
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220101
X-Proofpoint-ORIG-GUID: z602e3JNhP4hIfzBTm-Hyikdf-83y1rj
X-Proofpoint-GUID: z602e3JNhP4hIfzBTm-Hyikdf-83y1rj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 04:15:45PM +0000, Schaufler, Casey wrote:
> > -----Original Message-----
> > From: Michal Hocko <mhocko@suse.com>
> > Sent: Monday, February 21, 2022 11:48 PM
> > To: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Baolin Wang
> > <baolin.wang@linux.alibaba.com>; Zhenguo Yao
> > <yaozhenguo1@gmail.com>; Liu Yuntao <liuyuntao10@huawei.com>; Dan
> > Carpenter <dan.carpenter@oracle.com>; Andrew Morton <akpm@linux-
> > foundation.org>
> > Subject: Re: [PATCH v2] hugetlb: clean up potential spectre issue warnings
> > 
> > On Mon 21-02-22 12:24:25, Mike Kravetz wrote:
> > > On 2/21/22 00:42, Michal Hocko wrote:
> > > > On Fri 18-02-22 13:29:46, Mike Kravetz wrote:
> > > > [...]
> > > >> @@ -4161,7 +4162,7 @@ static int __init hugepages_setup(char *s)
> > > >>  			}
> > > >>  			if (tmp >= nr_online_nodes)
> > > >>  				goto invalid;
> > > >> -			node = tmp;
> > > >> +			node = array_index_nospec(tmp, nr_online_nodes);
> > > >>  			p += count + 1;
> > > >>  			/* Parse hugepages */
> > > >>  			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
> > > >> @@ -6889,9 +6890,9 @@ static int __init
> > cmdline_parse_hugetlb_cma(char *p)
> > > >>  			break;
> > > >>
> > > >>  		if (s[count] == ':') {
> > > >> -			nid = tmp;
> > > >> -			if (nid < 0 || nid >= MAX_NUMNODES)
> > > >> +			if (tmp >= MAX_NUMNODES)
> > > >>  				break;
> > > >> +			nid = array_index_nospec(tmp, MAX_NUMNODES);
> > > >>
> > > >>  			s += count + 1;
> > > >>  			tmp = memparse(s, &s);
> > > >
> > > > This is an early boot code, how is this supposed to be used as a side
> > > > channel?
> > >
> > > I do not have an evil hacker mind, but I can not think of a way this one time
> > > use of a user specified index could be an issue.  It does add noise to the
> > > BUILD REGRESSION emails sent to Andrew.
> > 
> > Maybe Smack can be taught to ignore __init and other early boot
> > functions.
> 
> Why is Smack getting called out? The relationship is not obvious.
> 

He meant Smatch.  It's a really common mistake that I did not anticipate
in 2002.

I can probably silence the spectre warnings for __init functions.  TBH,
I don't really understand spectre at all so I mostly ignore those
warnings.  :/

regards,
dan carpenter


