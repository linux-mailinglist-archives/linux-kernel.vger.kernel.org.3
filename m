Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D944C042D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbiBVVyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiBVVyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:54:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EC1A1BC0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:54:17 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MJNs26018680;
        Tue, 22 Feb 2022 21:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OTnqeK534BFJGAjkvAoQJCuxA5grTX8iiGyiIgFccCs=;
 b=JRls0f7gbFvFhedsj7OypG8aRrB5E7m4Et5OM1+fKfq5m/m8uEhh4XNIbPxJ6nhx9L+u
 uKyX9iMCIrUUSzJbvYSbHg4l2cj/myFZhNFTD2thETnGjvm7HxjJ3tz+/tGd/z3ukFEO
 2ANREL8iTk4LElg6kmngSVcmFqddPbafgpHAGs2i+mc0ZR84Lh1uhtA+trtSpdKUreGM
 TEF7JK+EnMgOxoOiDIN1Ucb4NSsmPcDWgbsnNHw9IdPeM+cZcLJpcBOt8Qu3YbbBXcHg
 Fg65+S2uanZ/U2ap8mzVyoIAXox0IrmC/xjnEDzCbgVSav2mNaAy5H4PjRCdDN7AWmZ7 xQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx2frp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 21:54:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21MLoTS4139602;
        Tue, 22 Feb 2022 21:54:01 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by aserp3020.oracle.com with ESMTP id 3eb481m52j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 21:54:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyffH+Rord4VLUQH8zQ1XmrAEfhUF3inQBotyFixLUi0ijM2LfIW8eD058bFifbI6GdHQeoucvazfpHrlh4zU2dT8lP9ra8Y2/UQcmIfaOWiJKgjPJvj5BvYxAuZs9pR9uB6vqhDd+qnF+MUPZEDqmK1LVlFDzrJYNp/SeenqMgWgEEYTE2m0LdNP9zh/2kJ5LQiQd30zTQd17Y7SEuZZ46FwWIS04X/EKls6jjBGYMmClz3aCCrC6XlyKcWgVeA8q/H3ycLSk5wT2UH0u2f65vm7+oKx09lzOGvuNDH5vsxN4WCEoUVli+x6PlZFOkF5WBv2NUi4J/dWdqmvXsr9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTnqeK534BFJGAjkvAoQJCuxA5grTX8iiGyiIgFccCs=;
 b=hrS8blbL6zyX8TZ6adwrb9wN4VafuVREPGJV4vwrDZbXI75koeHWmqq9d+SXbjyCpOt+fNt6PZTb6mCVqoM3q0A0uvyvyUqLjfcQRwvOLZmlRAOmRAcoknPUc3Rv+ZhxMEDxvd5wN74cbdqPGuzK1jOc4dYFskFQOzY+7eNof9ORpVcjlDRkn8e987Df3Sl7m08C7kYupRjTv69MMXSRq2j7NiR/GEmmuBdd08lzMw/VVfcK7RoiXS1tknaPuKFwA0FmP+u4DHxTJ/GvZAgnp2RckO76fLhZ49gDAD66tT2OuMEymToQYHdBKMpwp9BBcfhmBiIgj08k+6N1hHr/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTnqeK534BFJGAjkvAoQJCuxA5grTX8iiGyiIgFccCs=;
 b=E4lN67G53Dh/qoqIPoChekd9v1NIj/lHpIHoI7NWTSu9Lio67zU+l1GBbsXeVya7G3mRf3XLemMi4im4ZKwqIzyl4mJCCxkf4YGCcWnd/uSvCkDe5rsaF8Sg/xmBra5NHWS98SfTAu8FJHBnqkAmpdtuNgtwlzuagGQqHyso+rI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO6PR10MB5444.namprd10.prod.outlook.com (2603:10b6:303:13b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 21:53:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%6]) with mapi id 15.20.5017.022; Tue, 22 Feb 2022
 21:53:59 +0000
Message-ID: <4bad1923-354d-3858-0339-82df8c090c3f@oracle.com>
Date:   Tue, 22 Feb 2022 13:53:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] hugetlb: clean up potential spectre issue warnings
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zhenguo Yao <yaozhenguo1@gmail.com>,
        Liu Yuntao <liuyuntao10@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220218212946.35441-1-mike.kravetz@oracle.com>
 <YhNQf3LUZzNRD7u0@dhcp22.suse.cz>
 <26565cd7-01b0-197c-6ce9-af92f5bc8563@oracle.com>
 <YhSVGPQ6VIQfBZ9o@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YhSVGPQ6VIQfBZ9o@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR10CA0006.namprd10.prod.outlook.com (2603:10b6:301::16)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9c6e357-a2fb-40e8-70ad-08d9f64dd4d0
X-MS-TrafficTypeDiagnostic: CO6PR10MB5444:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB54442C8AC13D1D127D2DF95AE23B9@CO6PR10MB5444.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fyFeTdZGIWH/HiaHc40NQhUPJgwkkYPlbmCvIJ7fxLCqT2/RQRk4pHAm9sKANaSBgDNLaM42FEwqSF9S9Fkw5950u/NbxnkLZEnl7JCeRaVXlyakZ10kUDWKLx0c0Pv/QnvnEG1FzQeLcV13cwi2AcpB15n6nKSmwpUTyEB11xVjpyd6D2lP8j/d1EYkoCvvdT33wrHH3CxtbB6h++bTOLsHQGwx7L5aZVjtrF2Dt5CMy9ghLzvwki3MBL9yU5QDLkrEkhcdpVrv9/TZO2sQ7YQuMWvt8Djn9105b6t3/zcUDEMZSlYhvNsboeQOb1RXY72Lyo5OKDxuW9JBeS5GjuwVbQOoY0CUuXNo4MbFlFkjfKHD4SXbY9wtw3xc0vo/GjmKUyiu4W+3PG6etpjHB0uEZ9/IAvItDrToYfQQSNW355nSfjWOu+oOrNlWuB7KMhXtCJubkN1A724v6r0KJt0dPY6PinEqFQZKjO4oCwjYtJ6zqNodzfq6fOxUtlDZOHJlKPwUDAvJQ2ZWT4wvFYSS9jFrxmGuuVrL/ZsDHDBZ4Wx436uXTAMJ0pli4s0r77c/arTKHl93AVbf2s808eDJ2U5COf0+/OGV6P2q+Es6TcvYv56LgTvBXmLL9oJLjlY3l1erFr0qh7Uf2pBNJyla9c/Phko/WSvDZ5uDtcK+8Z7aC6r+nBuWyawAVf0ppf/w26qYsqH4BAsgEPGUGEyOLuy5Oe5+uRSVmGmuUnM6v1Id/xGn0ckHOMYFeOOxe8zZkYS50cFQ/PYoEW15qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(66556008)(26005)(186003)(31696002)(2906002)(86362001)(38100700002)(5660300002)(4326008)(8676002)(38350700002)(83380400001)(44832011)(8936002)(6486002)(54906003)(316002)(6916009)(31686004)(6666004)(6512007)(508600001)(6506007)(52116002)(36756003)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGM1SkF0bWNveThLVnRLU0tLSWZvajg0akVNQ29FMlZ1S01ST2VNek5iOHNh?=
 =?utf-8?B?dThGREpYUGNmNDNZQVJ1ZjJqdjlKU0tWaE4vd1BnVm45YWF6dVN6NWNEQ1J5?=
 =?utf-8?B?MWp6dHFsQmdabmtCNml3V2J0UUphai92NVJBd0dvdVN3WVZnb2FyRVhkL0hL?=
 =?utf-8?B?K0lZbHBPUWFVTmcwQkFHOGd4M2JIQURQMkxHbXZJaWFaTzlhZFEzSytDZ29n?=
 =?utf-8?B?VGFJTnV4S2JlZ2hzbCtmS2IzOS9mK09EU3lqMVk3Mmw5MGVXRjBKR2NITy9r?=
 =?utf-8?B?eExKeHYvWFJsalc4ekdRYzFERVRDaGIzTzRwOGpiWXQxL2tsTWdwT3h1TXpl?=
 =?utf-8?B?aEtXVzR2azNDT2w4QjAya0RSbE5Fa2xZWlpIbFBBMENQc1U5R2xVdFVNNFdQ?=
 =?utf-8?B?SkNPNW9Zb3dUM1JSTnR6QlBwWkhJVUcvZjVEV0pzaldzemlyQjFSZkFCZkFE?=
 =?utf-8?B?Vi8vR09MMGtabHFDT3hHMnFiZTNqbGZtKy9sdGh4QjBLRngrNlR2Q1B3V1JK?=
 =?utf-8?B?OWE2RDBjZDRuZm1PdXFqVlkxRE40Zi9SbEZBRllVQWhWOFZ5cWZuQ2ZONnVv?=
 =?utf-8?B?RE5taGxCYnZIZTlQZ3RDbHA2d1JFN1UyUS9odWd5VlE5S0c1UTZ6Yy9uK0RK?=
 =?utf-8?B?YVRva3EwZDJVTHI0cXE4bW94Y3BZdGhWaEN0TXdBaVBzL3NjaCthcGh0M0Nv?=
 =?utf-8?B?MEhWMFJxMzZoVk9LYjFaVkxGS3gvNk94T1pyZHFPN1RNRzNHbUNkeDJiZTVn?=
 =?utf-8?B?d3E1dExiaEZOZUlrck00NlZEekhlcjVuOE52Z3JRUFdsT3NpYVhQRnh1WFFJ?=
 =?utf-8?B?cXovZGR0R29lN1JUOUxtQnJMQUZMVmFwUzJRM1FJOUt0ZkFKaUxlbEp2bFQx?=
 =?utf-8?B?cUt1STB5QUpseVJRMmJtUGhrTXZxeGpLQkpNU1hwU042WVpPV3ptalRUZjM4?=
 =?utf-8?B?VU9scGcxM2pYaUZ6Y1drQVJvWkthYnlvMW41L1NiYmsyR2NFbStXM1JkYjJ6?=
 =?utf-8?B?SmszandENDQ1bVZBcVFodGE1ZnlPdkV0NTRLRXNNeEpaVEZ5OXR0cjlpRUVO?=
 =?utf-8?B?TkdFUFo5VERMZTUrVUYwcDk1aXVraUlFR3UyTEtXR2VGQlJ2VzZyRGw3OEpR?=
 =?utf-8?B?OE9uQ2NWNEhBSitBR3RnNjZaeGx1MGE0QVRjSXhZKytDNkd4OUNaU2o0Qmdh?=
 =?utf-8?B?MitES2FLRlFjOERJV2ZQUkljRUNvdkpyVVlSd0ZSbTk2M0xIR1E1ZWZod0V0?=
 =?utf-8?B?YVM1U0lMZjdFVFJtMElvV0xrZytTaEFOd0wyT2oyVFVzNHRleDgxbjR0NER3?=
 =?utf-8?B?YUZEaUZ6V2dQZWk5c2pkazFTWndpYkNOSEVCNmx5RFV5ZHRvcXRmQk10QTNY?=
 =?utf-8?B?M3RiQkRWZkxSUUxCMW4wOXN1T0puQ09vR005RnMyZ290Q0U0S08yNEl0YjFB?=
 =?utf-8?B?TjRZTStid1IrcUJrRVhwMjNXSERlOHJkUXBpb01kSGJmWVFkcGU4VHdMRVRm?=
 =?utf-8?B?ZjRQY1NyTjNPWnhPN05OeG15NnhYOWw0eXFrUWoyQXBCeitDdnZhd1ZROG8w?=
 =?utf-8?B?TEpXQ1JPbzlPdWNIZFoxS3hFV0ZHOHBlVG1QYWZDZEg0a2FiUmRMMlZ6aXhl?=
 =?utf-8?B?NEphTXZna2czN3dhZkYzWWczc2J0RmtOQ2hEN2RaS0xtajFXdUpXaXlFUVJN?=
 =?utf-8?B?MHlETFljVzI5L3QxZlB1ejFtcWIwUW5qV1ZDaC9lM1pzdXllWEg5amhVd2lk?=
 =?utf-8?B?WUo4Rm1lcjdYODNjRkJwMEdFV09IdzYxYVIrN3AvLzZpcldLRStXVzB5ZDNm?=
 =?utf-8?B?V0M5OFBWSjB6OW80RXlGZGo0SldxQ1JpdHRHVnBPbHA0MmFVL2xTb0hpWlZo?=
 =?utf-8?B?ZU1MdjN3TWZWd0FqSEljSEt4TFJNWlM3SDJMajhCSDBHZWNrTUtoaDBLRlBD?=
 =?utf-8?B?OEdWQ2UxVkxzWGI1VlRsZ2I5aUNWL0JNeGZSY09ESG4vd1hJRHo2MVU1M2xL?=
 =?utf-8?B?L1pQSzc4Q0JKK0tKaGxORGpJbVh4ZHdXRG1Hd2lrMFJsMGJnRjVpTFBra3dp?=
 =?utf-8?B?U0FaMms3eEEya0F4NEI4TWRrME02VytMbE1uL2hDVk9uZm9la1IycHd3MUVk?=
 =?utf-8?B?d2RVYWZRZmdpNWpmc0hXS2ptbUlxZTRYZmplcUpUK3M5VjZvUFlwTjg3KzZh?=
 =?utf-8?Q?GrTyjsgHChZXEQdWYnVQmio=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c6e357-a2fb-40e8-70ad-08d9f64dd4d0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 21:53:59.6886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IN6+X/7pQGsiopyVdZ1gJy38U2FrdFMH9UQG7Ogi46uMuFN1Nsk65xBWDFhGwsXrgp5YiVAZOgRb9XTcjYcZEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5444
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10266 signatures=677939
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=984 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220134
X-Proofpoint-ORIG-GUID: ER7MS1jsCtuLdk_hRZT0sMpfmXfPerjW
X-Proofpoint-GUID: ER7MS1jsCtuLdk_hRZT0sMpfmXfPerjW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 23:47, Michal Hocko wrote:
> On Mon 21-02-22 12:24:25, Mike Kravetz wrote:
>> On 2/21/22 00:42, Michal Hocko wrote:
>>> On Fri 18-02-22 13:29:46, Mike Kravetz wrote:
>>> [...]
>>>> @@ -4161,7 +4162,7 @@ static int __init hugepages_setup(char *s)
>>>>  			}
>>>>  			if (tmp >= nr_online_nodes)
>>>>  				goto invalid;
>>>> -			node = tmp;
>>>> +			node = array_index_nospec(tmp, nr_online_nodes);
>>>>  			p += count + 1;
>>>>  			/* Parse hugepages */
>>>>  			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
>>>> @@ -6889,9 +6890,9 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
>>>>  			break;
>>>>  
>>>>  		if (s[count] == ':') {
>>>> -			nid = tmp;
>>>> -			if (nid < 0 || nid >= MAX_NUMNODES)
>>>> +			if (tmp >= MAX_NUMNODES)
>>>>  				break;
>>>> +			nid = array_index_nospec(tmp, MAX_NUMNODES);
>>>>  
>>>>  			s += count + 1;
>>>>  			tmp = memparse(s, &s);
>>>
>>> This is an early boot code, how is this supposed to be used as a side
>>> channel?
>>
>> I do not have an evil hacker mind, but I can not think of a way this one time
>> use of a user specified index could be an issue.  It does add noise to the
>> BUILD REGRESSION emails sent to Andrew.
> 
> Maybe Smack can be taught to ignore __init and other early boot
> functions.
> 
> I do not have any strong objections to using array_index_nospec because
> it won't do any harm. Except that it makes a security measure a normal
> comodity so any future changes to array_index_nospec and its users will
> have to consult additional callers. Whether that is something we should
> deeply care about, I don't know.
> 
> At minimum make sure to be explicit that this can hardly be a Spectre
> gadget as it is a _one_ time early boot call. If there is a scenario
> where this could be really abused then it should be mentioned
> explicitly.

How about adding this note to the commit message?

Note: these routines take a user specified value used as an index ONCE
during the boot process.  As a result, they can not be used as a general
method of exploitation.  Code changes are being made to eliminate warnings.

Andrew, would you like me to send a v3?
-- 
Mike Kravetz
