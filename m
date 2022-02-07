Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90A54AC7E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349896AbiBGRqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345530AbiBGRjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:39:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60AEC0401DB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:39:05 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217G4WjU008232;
        Mon, 7 Feb 2022 17:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=AzwNQI+7vs1QXBpf49C7K7rhO+SjHHzMn4yQrgXy+j4=;
 b=q6Iu8tcie17GEtEt+8XBuqwDpP4ShmuUIlehx7lVGadVlxSLCJBJGEA8ZXuk/iyiaXyx
 kaJEgGlL6MrMVnu+OuhJHa0f0e34gxmwKAPDFCeyrnI3ID6hnbmh9YdTPhnq6DxOY9Nj
 HsoCsqGiZRsHsmxz+jXEeldYobQR5x0/8nKYQOhiMOToN/+Hh7W3u6lIfb2SFVCbxAsm
 BqvfvbjW35W+OlD9Ib44itpfNI6VwU4ReFHnkJHB9kmXOjOE6bBtX+/cyJB2KYa30NyF
 XFL2abMmXBU/dVyiyFh6ZUUPB/nct+20Osf6htKv7f/b3kklOTViwy25jpMJsEzf0OM1 4A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1fu2q12n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 17:38:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217Ha1Z6108355;
        Mon, 7 Feb 2022 17:38:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by aserp3030.oracle.com with ESMTP id 3e1f9dqrr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 17:38:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALhtSIHtQYK/Ol2N9coWjhIi/uS1m46eGN9qW9hYVZ+EuwC9H43wqjx5+PKQjhcTKMadBj9chkPc1q2rpICH/3zajPEJc6WsS4FZAwzThQMw6N07FZ8okdam8g1nOwVg8NNB2dN//La+fJogXVJvMcfUMw9WOHnZvW0wqM50yHyIzrOyAqRJteL12ianMRRmcK4c7MCgAELbScS+l5uRq5rE5gznkhkD+grkHbhqiij4snWMSbRQ9U+mDjnzkpMj2xpA5HyoLYBS3nZNLNy1nTlDTH/+aEpG60pyDqnViTwAlRp8IXI++Xe61F/34/dx7d3Gciq+6lQYI/IIor5lmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzwNQI+7vs1QXBpf49C7K7rhO+SjHHzMn4yQrgXy+j4=;
 b=XQkvwYkPJbJ09rJTZRKfgQ1SbbkhRORmvfKg/TfanvIJrKFsR78FaSzTdtF8cf2MSSV6R885pl5zUJFfTzvQIPjsBa6+xUcj5rd2/eP6pvqSn83pd+dP6XDOxjIIBCzXr9mr9oLCL1HBEgQ1xP0Re6ixp6124RRJQyDNKF5rIG7kOd9u2u2fPTiS01f0I7Wnmc840Cc4u/RFSD1MGaBGw6goYioNTPOrVl+cxKsjplmWaH6M8VDVAGB2ZrCIOlzwSAgBFCT0u4+HK62Ac/4wRunGN3lJiYwOM3oc6WcoeURYqQeasPkLXxcWa388o6QF933dY0celXAXUoj5S1mmKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzwNQI+7vs1QXBpf49C7K7rhO+SjHHzMn4yQrgXy+j4=;
 b=ZESI8RwcHtOlv2eHuv95zbiCoCldT2gwV0YAVbSRhG4lksDdhZLCP1b69guh1dvsmBniRcpYKjOWSPAb1IXvR6SKHCqpv7t1rogahmMXFXEE5Fwfaf64c80fgdiVW9gF2QMK+w2HhiEmxZMxD/3D0nH0FgmR+gkzL9xqsRu3Fag=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB3925.namprd10.prod.outlook.com
 (2603:10b6:610:12::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 7 Feb
 2022 17:38:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 17:38:31 +0000
Date:   Mon, 7 Feb 2022 20:38:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        phil@philpotter.co.uk, larry.finger@lwfinger.net,
        julia.lawall@inria.fr, linux-kernel@vger.kernel.org,
        Michael Straube <michael.straube@stud.uni-goettingen.de>,
        martin@kaiser.cx
Subject: Re: [RFC] staging: r8188eu: Sleeping in atomic context (SAC) bugs
Message-ID: <20220207173808.GR1978@kadam>
References: <2111927.Icojqenx9y@leap>
 <20220207092133.GE1951@kadam>
 <23161490.ouqheUzb2q@leap>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23161490.ouqheUzb2q@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0011.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2214caaa-7a97-45ae-c09f-08d9ea60a82d
X-MS-TrafficTypeDiagnostic: CH2PR10MB3925:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB3925B14CC7C701AF0FE6BB4D8E2C9@CH2PR10MB3925.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVAQvPv5GZIGeFvO9MMG4TyBfuBr17m5ePr9RGwvemeiFr8+0i6peeG+mnWnGQs/jWqI+tW+ZQmngzgbKlrQ+00kLqjiNp14ZGzceJqkFd7Ni4e+7qQK6I1s6QLup7O3mmtScvYZ4BvJuDravGoDx9vG1t1Q0fMsh2NPZ8be0SoZPSct7Od0BlAeJkpoY+6lz96x0g0Us+pwV5s2bLRS8szDTjs280I7xnbFq9vXPXqWkXxc5YHyClFuYt2nIiFQTAzpZnAPxqvfxmPsqMDth+6yfzX+f4fKOxcce6x6hSEVY0R5UZq9drqe29rG2vkyFjm8zWT+JJeh1R4e/BqxvlNF9C/Njrf9ehXPz1iSforosSvD59gidkjy/5exz+ShtI4BuQsV4Ni7IyUNeX8flwA2t6N4vNqRLnCYZYg2aYnNfQPiA460gM1JcvGNhM/dkLukcBU/Uc4J0wvew7HeepfMyzhvqUkjNP0CiLuFp8qx4ZWL13Xrvzw2m201WuiSFwPWUwbo2NP+ExV1N8pqSVE/xLUG1+trwJe78NQVY8uPF3O5qoi4Jj3zwDd1F3DuDnOGOc4vYtHM7aGAoXN4m+m/+8QayimY8m7Lv9Ufz91py+jN5eah3ljUs8kjWP6B1+m+u03vX+Sdl96d1ws0i6ZQJWide2yJO7V3nkpby+IyJ/oV3nUFIP/t8I6/Gs/0K15+xPA3R7x1JJzHIEHScg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(1076003)(316002)(2906002)(44832011)(6666004)(5660300002)(86362001)(38100700002)(52116002)(38350700002)(9686003)(33656002)(6916009)(66946007)(4326008)(66556008)(8676002)(8936002)(508600001)(66476007)(6486002)(26005)(186003)(33716001)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Y32VPk8VU2j8s3coLH3fRJHC4Z1LY0WrSSSTlx+2hb+31NYXQA4fT8TS1tO?=
 =?us-ascii?Q?JmlUnfXdIkvb+WcL9vTb2m28OknDYOrI7VEDKkmPby8uVdZJTk78gK2wlf8F?=
 =?us-ascii?Q?JGZF+ZclBgl6o5lT/Awwa72rmRqNxeyYZDzF0wtgAC6OoeWhLUZk0ya1c+zd?=
 =?us-ascii?Q?yqGckj2UWrpBPRCa5s8+CAiETeKjUkaHOSWCQAPHJe49KyitiSo91wxn6HiQ?=
 =?us-ascii?Q?szL5ncwG17riuBg2sTpmjnL7tUfIVFr+fy0vkYMDErsPNc09qwaMuA5LLO9K?=
 =?us-ascii?Q?WWoxSYI6moyKVubS+gNXa+cPBBQJRu3wXgWHyhIbN2Eci+N43Ao9bMexUbYy?=
 =?us-ascii?Q?/QIS34Hra2KAcboa2QMNTFXGsqzUoJTevVNLLU7HZ/ru51wWPzBALiFoBdtm?=
 =?us-ascii?Q?92JMpQBS5dqHKpbZl0QaXwdJNIKBOFrL9JREV9eIsrdzC5NsODchBZEQMzau?=
 =?us-ascii?Q?XAJcylSGM9t3fMOFx5o/6l+wCA8ykPcGk8HDJmNJquczaSd40TmvxjdID/z2?=
 =?us-ascii?Q?SVTFDIa5c+zA4uYQhhIh+yXP4rs/NTMx/QeIYpme1MfBYGwiwbe/O5Xezv+Z?=
 =?us-ascii?Q?CP3U3sEVQEGfP6tt5pncElJwgBAMxiP19b3H+1NFN5xAjtJC1bh3KRl0uDvV?=
 =?us-ascii?Q?BlZQy2E6bHr7W90+FiaciRuOFmfLP/deeLF9zoFwn304tajcU5ZYm/jK2DBl?=
 =?us-ascii?Q?qu3qJXAn4FXXha7syvR2+hc6UGEEr3/2peX6Xtj903jv+6+oYfqxnA82lt8q?=
 =?us-ascii?Q?8gxaONafd8ZL2RBNxkB1BmVhBTtBuX6RC2eUW8dHbFPKBogCWaFSw0ZrNMTn?=
 =?us-ascii?Q?sk1VMEeHW5/5gCoDshqXzQ2IG/E0FsctoyGnJ1IZ59TcqR/8mE2S4eXJQP9h?=
 =?us-ascii?Q?2djWzlYVjPHs3L97DH30sk0jetL86pLeIY0BcEKHKR0NHRZl5q/4GLL5wIh3?=
 =?us-ascii?Q?Cp+l77qydVoPz2SxUZh6OPU61onGjbOT9XTikLVJSgGzKibwiG8qLqOL0Qi4?=
 =?us-ascii?Q?V5dZ9YCw1XBehTAx956jfnCa6eMN6gcX8A7HxSOAfjAPwSgzHrlbCiqUnZbn?=
 =?us-ascii?Q?Z4SwyandViF0YDZyS86sXfRllHBACXL5shRj5etIlbcCsJKZNcyxOn2E1RMj?=
 =?us-ascii?Q?VjQYI4nritKZlx0+DTuOxf43EFDcui9Y+ejLwrEBUbSbVwVDMz4dM1unadtn?=
 =?us-ascii?Q?yBu5d2nxJWwrbZPoWSMP40MGvQi+rHhfuQzn7j9Uj9s5FwBhuIJPCCdrvS15?=
 =?us-ascii?Q?Km5k4rvqUjTY60lilSwFypzzo3mmWE56IgOw3amj/7O1hr8Dts1bxNPtPLEy?=
 =?us-ascii?Q?ZXtwBuffHW1FTfsyclEw4RtOGJ9TTNOzkGT0T5YDUf36HkDfcIyboeROIkKM?=
 =?us-ascii?Q?g0xXpdPuOfFPEC3tqdcfstcRiBgkvNapAiezkRwPoygRm4ADsrqnXzxZYTn9?=
 =?us-ascii?Q?u5zo0BaMIdAC242OiTIdfaF9AFEd7TziFNAMb9i9H/fS/pMdaPBFhcjASFRa?=
 =?us-ascii?Q?o1Kl+il/9TOLt3AyC0djRI9j+ojxbdA0zE38D2x1/pPMWCr9xpviM6Q5sK/L?=
 =?us-ascii?Q?93AsrdkNUyE0xbtkZXzvq9JHrHrwFAAVXXkRF/R15hqWZEjS8Nold0UjhgBO?=
 =?us-ascii?Q?6Ef8RVn3o1gHQBjpGv8zPyH1pVA2w8ZGwKSHvZBwZW/GvkwjtoRKjr6BT2RZ?=
 =?us-ascii?Q?EfaIGg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2214caaa-7a97-45ae-c09f-08d9ea60a82d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 17:38:31.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxYQdh9mI2zVxNavCp98ok5IknNbq/0Ij2xslm4BgbirXA+7Oy5S8qQOLbWBbB86d7VYa1CeGSqpA0d+rs1dmubffRQ80RLKLMmKec1ITU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3925
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=408 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070109
X-Proofpoint-ORIG-GUID: qF-xKP9mjma6m2dDFNdxbsiSiqSvcoTd
X-Proofpoint-GUID: qF-xKP9mjma6m2dDFNdxbsiSiqSvcoTd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 03:18:52PM +0100, Fabio M. De Francesco wrote:
> 1) Leave the code as-is with those msleep(10) and risk to hang the driver (or 
> the whole kernel?).
> 2) Change msleep(10) to mdelay(10). It's a huge amount of time, but we are 
> guaranteed that it is safe.
> 3) Change to mdelay() and try to figure out what's the minimum amount of time 
> that suffice. I forgot to say that those msleep(10) are within "while" loops, 
> therefore they are called an unknown amount of times.

You are talking about the:
rtw_set_802_11_disassociate() <- disables preempt
-> _rtw_pwr_wakeup()

_rtw_pwr_wakeup() calls msleep() on two different paths.

Let's just add it to the TODO list.

The code is a mess, right?  Maybe if we clean it up a bit first the
answer will become obvious.

The first loop is trying to prevent racing with rtw_ps_processor().
Sleeping is not a valid way to prevent race conditions.  Especially
since it just gives up and it's like, "Oh well, three seconds are up.
Let's just race."

I don't really think that sleeping in atomic bugs are likely to lock up
the whole system these days because even the cheapest mobile phones have
something like 64 cores in them.  But imagine it was twenty years and
you had only one core with CONFIG_PREEMPT turned on.  The CPU was in
ips_enter() and it was preempted by this thread, which is totally
possible in theory.  Then this thread took the spinlock and we changed
the msleep to mdelay().  There is now no way for the other thread to
complete ips_enter() because we don't give up the CPU so we just sit for
3 seconds and then timeout.

In other words, changing from msleep to mdelay could make bad code even
worse.  Plus it silences the warning so now the problem is hard to find.

regards,
dan carpenter

