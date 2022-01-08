Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A4348832F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 12:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiAHLTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 06:19:43 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14466 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231586AbiAHLTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 06:19:42 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2081v4Q8007475;
        Sat, 8 Jan 2022 11:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=bTRfoXMDkHkTXaX+KwMvkd0uZ82thaJaGDNdNIFRglk=;
 b=xvlfNQOkXNG127SCWujkQzI6VhswxyTZtAdKhpUYl9vMjslfA6knDDbxf00Hnqarw9Fc
 Vn2audcHiDEB4eaU2/IaBAP9m63w1rXmZl+3a7slPd7h/zPFwQ5OorFRSXBNv0KDjMcL
 vdD5u0/CYnLVe748XsptSmdfP/rArgrl8jKTMaoUcVyV8zxF+nIn1O2yGXVAcYr09h1u
 d75Cc5eTY3xzD2cHruyICQtxXgUZ7vmJRCmjcgVBsExiQ2m1tTj33pYZO3T+vB4r91Sj
 gQoqYb9iuJMQwa4PYiIf2YkADlu/X4i49OeLzOrErCVkGI9VByvmsfgvKSnw/NhJFrLs kQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3df1d2rcn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jan 2022 11:19:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 208BFS2E186635;
        Sat, 8 Jan 2022 11:19:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3020.oracle.com with ESMTP id 3df42ghcwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jan 2022 11:19:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMHGAW3j4bbg6+uiTXRKVuRZfMUDinIWvr4hL5rvcDJsze5Qoto1Xe45N6WvGyRwe5BcBb+mYm5oFcWhwqpGpXCP7/hKxmNGbokvi5jPecc6wwDWpaexf4agtTaRh3uBHFO+AeeIkoKjTNq9YuMV+mSZvfdwNnojyL9feSgqA9uHtkfshWevq1DC9lgoO3PtAgtDwNO5GkOSlTod6WvxLIWNfU7hfqTnJL3CJXcEaNG+pQ9uUrgIcX5qw5XXhh5PgjTGJAiTd5fLJFbpTro56u8uYDVdnbnqd7Jqy68OdlVwIN2VkYxqxD9kpQqk+yKXYKTlVuFunubKr36//hQokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTRfoXMDkHkTXaX+KwMvkd0uZ82thaJaGDNdNIFRglk=;
 b=Cy0IQiArb51wiaLrVCZo38qC62aUOAxzBohxe+xKiIzRrHMqN0+aeErUU0+wg1fdSoxZBVNCIrPbf6k2KAq8/a3xo86PlirCnu2x7oMo0u+kOPgm+NJr2rdf+c0AMmpu/bU4FsbYcSFfjmuMnzWzPMfMebCL42KtgKeDNJzAApkc2WcPLrdW//uU8j6P9WYpM9dlX+fmsEDOFBAwjiRchcd99NeFXxOdhA95fdrK3N2f4RhwarJ71x1XzzF7GppVMmS9uL2ibsA9HlpxcmpV7mwT3WrGLRxZY5GQl+ncfpVXUVqDvz2zZ6cko9WTkK/WeMRHFPZlM9ubUydgF1t5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTRfoXMDkHkTXaX+KwMvkd0uZ82thaJaGDNdNIFRglk=;
 b=k6/gZnrPsa3pBIQ7Z/+DGeW3Gc2slMlzabzwcMlD2qn86ni6WxBl40+jrqDbQss+kWeXApX5MMTw9rcStPMnxRshahiyg0UnfTokF3Fqv+TBeoU/6ElbYxSSQdV2FJFtGTxmZ5HaOgxiB0yr9tCOoq+DUry8mzpDoxen6T9rQwI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2319.namprd10.prod.outlook.com
 (2603:10b6:301:34::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Sat, 8 Jan
 2022 11:19:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.011; Sat, 8 Jan 2022
 11:19:35 +0000
Date:   Sat, 8 Jan 2022 14:19:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: pi433: move get version func to where all
 other functions are
Message-ID: <20220108111910.GA1978@kadam>
References: <20220106201430.GA3416@mail.google.com>
 <20220106213325.GA10767@mail.google.com>
 <20220107085343.GP7674@kadam>
 <20220107192438.GB2693@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107192438.GB2693@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::25)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eb54aee-f284-4eae-9237-08d9d298c00b
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2319:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2319C6564DF9901669770DB28E4E9@MWHPR1001MB2319.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7qMKeFvCD5ApuYnDlf6SsWR9toD4s1fSDkN8gDxLXK8WfkiZIaa2cTZxdzoXL3zzDEnHoZIQaXlGTxfNIH4FIQHikhYHXKxwLoO4C+Nh2oy7szAeOewrwSs1XMf+3sZEv9J5Gxn2bi97Jcjj0B7+zhrFRXoj++SY1reTcO6oObwtYwLmrUsBhBMuvXMQH2Z2DJcr7MlP+i/V/kclqd/x/06o2kCX7aKj+82PREP4LO0WDfrNNwhiEw6ZmyZtZx3QFn/1QEYjLN/xxijVE7DJFmEjsAeZ8EuY2IKijwe7FF90tZoD0dEFKGeTHxE1nJlHkUA2I4pKmj8oZOBVLwZcIfiIm/hlymc4Golbz1IXAdVLRSshT07VLfAf7LHVYfIChha44NfGxAh43zxXXVVcRQm8Pe6N5xHJPKRAQFfZWhWDj9tmm3MfgbPGlmbfZLMe0RzhI62ckM8Q69zsLtuCZX/NT/kQ0RR5gcWrdpSN7HvjvteLqe367CwD91bfDQlIQdyGFUUfQptVqoSmaOwgcUKZ5vneDDdRaSLjqCTbC7mId7xp9fcrw+1T9Gjb0htWAlm2/144pKdw50VwZV+uewKUvOzqfojvNg/3VnZCu3/HC37MYIrRfbVSgyF2T0t/kM5lvi0d6fj/iYVnFCAjQsjhW8/PO0Ty/aRcvZw+W5STfGxU169MSjg5gUE0fRmmvKSw3D4YdwM60pydFL6ILD0nyfUdk6CCoH2Vm7uqdo+fZlRshLgfLXAf0dFvxjtkasF2+V8/gkC6OrxSmCMRs7B9cBoKGfXMi3QWWTjgWyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(33716001)(508600001)(6916009)(966005)(66556008)(86362001)(66476007)(6486002)(52116002)(6506007)(4326008)(8676002)(66946007)(38350700002)(83380400001)(8936002)(38100700002)(2906002)(1076003)(33656002)(5660300002)(44832011)(26005)(6512007)(6666004)(9686003)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T8+6hnIBz5MhrK10TAVanOcd90zvDmJ9oKkxbGm8kRA1BhGE7itYEBrGCeNX?=
 =?us-ascii?Q?37dbFsLPu558INI8rjPEs4ihSnQpHUaz6Z9sPY+bpkJH0uQovmgxg1rElDTm?=
 =?us-ascii?Q?rKKvy/d3yikD2YGQZnA5kqWZF9rcU7p+z7gEezq50Uq+H6XQh0lB+yIWl+5V?=
 =?us-ascii?Q?8IELsepcobIsscgKYTNHjS8ZCihytWS+qdA75LGzPxOrucMY79ilYm8Hzkzn?=
 =?us-ascii?Q?DaeXZixdqRX95DawbTQW6+VOCuHHfx0oWqVa/Uw2A97+9loKDGQP0m8wFhyX?=
 =?us-ascii?Q?O3IY4bBeWkUzLzxBlQ4nNiIsLt6ChDfCBhg/06mxhnv8JBN/vIDc/uAfPy2U?=
 =?us-ascii?Q?7Fuc/J7XGl3XMSycvDfOXMQSpVzm7r/WITBiLWAAOlX4mPDvYOtGpoi81W/p?=
 =?us-ascii?Q?DkgfLPsryCh5e9mbx5hOmwATqOxRaEL81wVaPE7N9JjRAjlj4DMLRxwamS+F?=
 =?us-ascii?Q?rHZW4gYIem1qgDKvlpNFLp9IJrxRfC0mYtmD8BqGa1sWVe7W3VwMPdEpoyAC?=
 =?us-ascii?Q?NKToU1enXqVx+SIve0UzdLkiaX8JLe/BbOmR6ZCFuxFvIMc9mixH14HxTHB9?=
 =?us-ascii?Q?aIcR0RnWbKouxB7Iflrim8pPK/Ol1hMqFfxIrJdJrvWemHI8hGKXYizuJHsU?=
 =?us-ascii?Q?PPHB101bzkEFwNM9J7YpfcVEU6LIhbzT/M2EcPu+uf1KAHvWhieLfFqCjdyU?=
 =?us-ascii?Q?th1GN3slLjUbLUpzcTBZF1uglBsHIxBppVv0NqZg0XCU5LXC/LAWerNrWvWe?=
 =?us-ascii?Q?T2xxKZEVj7zg+AUejddoY6dc/QVH/6lTcPYY9E4UrPg10IJ7YeFhVMRD50UL?=
 =?us-ascii?Q?qgFdQRw2YYlNL/x7HWyoAcQGbJZKs+kydY4cHDfC23wGItTgTp4/SHdwdm31?=
 =?us-ascii?Q?ggxbS+mQYoPjMIx0d93PTCFwFdaBEKkWy9r4bV++d36UUYGqFtPVTl7Pyhty?=
 =?us-ascii?Q?RQN4EFdUXIAuGjppqG0neyWvcuT5p3nmF94yfqUypca5lldYArrrRc5xV2xI?=
 =?us-ascii?Q?fQcfMIIN1OaVLSJ0R9UhIh3+NcbmKz+psgH+tmUvl9N1X79fGNN3LDBgrzZv?=
 =?us-ascii?Q?1akKdX2kPXucbpmjENaweeFvID3uXcPlUKhgp4PPP5+qNm6N4ebiwMEb/zpH?=
 =?us-ascii?Q?Fq3rAqLgezS/zpI8GPwKDjdnAP+vjyQGDVS1q88k7jpFtkDXMmnZrVwVGRyh?=
 =?us-ascii?Q?Z8xUvG3Uyjj87KfIUJRWJjo7OSr16GK7XwR4O+fcp0rTA4LULux1WayfdaFn?=
 =?us-ascii?Q?XKeGDppAxtEwfZ2sIWSd7VNy1huO6Y6hmbO7dZ024zDZWolf4zgioFx8ZF3W?=
 =?us-ascii?Q?JOzMq74ZkhFoBxR3n0FVguo3Dyf1l/UgHXar0/VG3KOm78J2UPbmUPXp39Y1?=
 =?us-ascii?Q?PXFswBrIlEZkPRNnC2CxrY2u+SL8zVRz5rRU6FRIp35B6GxRrD+n5H2pyYOs?=
 =?us-ascii?Q?mtye+GdcJHD2sytIspoT3lljjfWmpbtIlYV/seNfnszB0D42D4Hz9UsiFbDw?=
 =?us-ascii?Q?TUrRdiqgzBBmyY4ILfrNIBdHpJ17XTkY2ZOrdBMelHYUS/wqiRavJlD/0J5n?=
 =?us-ascii?Q?9heUklu7AYKL5OYH2IntqZdvRsQ5tnQpAgWfhwg2O4wpXX02g98Su3tVts4e?=
 =?us-ascii?Q?Sau55KcMl2nvp95HcUew3Kg/g5YknHZvzkffeJ4QSRb5ha+uMi76AvE7k6Re?=
 =?us-ascii?Q?6Wu+fA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb54aee-f284-4eae-9237-08d9d298c00b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2022 11:19:35.0356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dj/tdyi0KKiu1B1mZ/xPoPs0FcdXwburv6junqe2XL05c/IOjjToTIXesGGtjpjTgTadigmM3OPANF9ndLtfgjETlOQwH86q8MeimYm4FjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2319
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10220 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201080090
X-Proofpoint-GUID: 98XzIZ-stUx4hwGRiHaTvakUH7qSvB0r
X-Proofpoint-ORIG-GUID: 98XzIZ-stUx4hwGRiHaTvakUH7qSvB0r
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 08:24:38AM +1300, Paulo Miguel Almeida wrote:
> On Fri, Jan 07, 2022 at 11:53:44AM +0300, Dan Carpenter wrote:
> > Just say:
> > 
> > 	retval = rf69_read_reg(spi, REG_VERSION);
> 
> atm rf69_read_reg is a static function in rf69.c.
> 

I would remove be the static.

> I do agree that this is technically possible to write the code
> exactly as you suggested but on the other hand, that would be the only
> exception to the rule when considering all other higher-level functions
> provided in the rf69.c

There may be other functions which will benefit from this later on.  So
instead of "only" a better word is "first".  Some of those high level
functions make sense because they are slightly complicated and have
multiple callers.  But in this case open coding it seems easier to read.

> 
> are you strongly set on the rf69_read_reg approach or would you
> be open to keep the original approach? (rf69_get_version)

I think my approach is best but I don't care.

> 
> > 	if (retval < 0)
> > 		return retval;
> > 
> > Deleting the error handling was a bad style choice.  Also preserve the
> > error code.
> >
> 
> I just want to double-check if this suggestion is taking into
> consideration what was mentioned here:
> https://lore.kernel.org/lkml/20220106210134.GB3416@mail.google.com/ 
> 
> If it is, I'm happy to add it back but I just wanted to confirm it
> first.

Yes.  Keep the error handling.  Your way makes the code more complicated
to read.

regards,
dan carpenter

