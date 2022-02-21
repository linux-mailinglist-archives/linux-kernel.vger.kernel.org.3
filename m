Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6905C4BEBC2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiBUUZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:25:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiBUUZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:25:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C3422BFA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 12:24:50 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21LHoqQV004443;
        Mon, 21 Feb 2022 20:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u1KggvKl9y7B/S61ggM4zOVaqqD1SzCqFCTcechxg5o=;
 b=N6+J1hIXMtM2RCEIcwA+5HKRan4NXqE/O3K9dUPhrEWnxLR4xRqkTJfTiVhfs3yXVMd6
 k+sjRZksgz77YBDIiQfCzR3+npIzrO/W6E/agn9/lZEn5mCDMhqXYlgC5NUXnKCLYe6y
 u1POhPSvM0IOZ5oyqZF5xU3xtgRoPyhg65exrEu9ztABAkGpnBMnqKJ5I0SnY9hkHDex
 qkAatJGaIyju6dU4+V/gBoP+taYRD4+5d3DU+9f0QIuCUECU7S0hnaCM2pyFuxYU5U1R
 BiO9LbNKOF5zyGI3qfwyY5yErolNg61oxEVv7zeAOTNCQ0FmYXNohvoTFNYOM6niZVZx oA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eaq52d1da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 20:24:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21LKGnCl185839;
        Mon, 21 Feb 2022 20:24:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3030.oracle.com with ESMTP id 3eapkf1nqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 20:24:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDz8lpA5mkTuSE4ugWwCB3oaUWnMMqGtd8vjCTxdTclT49i9ay1nibtm2OnQZ3cc8SgL8j5sn3ISmHhmfvOqcGqqITE6CcDNdoCr4fOakmVK2VgyX4wHKsva79cvj9eTplqX5eDs4XwuwzCw/TCilzQW4GSm6A9JYyDKL9y2WPKF5fI3A4cFLP+7lPiP0RaA1cI3a/i0Sfh0RSwA8InMGdwRCZYsZElUdh7kODH+5fnsXN20YaUSknwnsf0tIp0RoiZGsFQ2tehtleZzQqTUAt088m1952avt+DqYp2XCjM5W3C7E9uLac5gwTjVv73oMeriUyKxLrfGmKVkgMz9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1KggvKl9y7B/S61ggM4zOVaqqD1SzCqFCTcechxg5o=;
 b=jlsrCwCmRospQQm3U0sKXz0oQQCPNGNphZbNvUwAOruQjRynEeVF1HJKEh2QPrrSDVd9f6yKLMrUHL9hv9yfQKl/fC5A39HauqcSoYw26+2mw7zCjDESH4aWeCS6vbBC9EbNFw3/jUnnrgMQrV9UeNy5Q04MBYvqLLLehtkulPRNCQtKIvVqos1GN5bg9P5JGoy/FA8svFKt6a+/tDCERbdRb4a0j+tAvR/xGI06x118sBpv7la1NDTtVm3OFskDLTevfCpmsAV+jiRC3BFVUBqjlh6N+wID9j01pkLl+L/cZMb2wPndpNrwKz2uY2+CI9sG6npTptvzCU/f36H+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1KggvKl9y7B/S61ggM4zOVaqqD1SzCqFCTcechxg5o=;
 b=vKDhCeCzWsay0pgsKP/ccbOi2rThrh/+g9a7m5TSaQiSWuGNyYeynEPXsxOvGwoJ+M3dqgFYEKrSi3I1c8Ce+LhQtuDd3/QWJSsbXvzR4fE4DqNHTr6zt+rKyNk7PHCdHIHMQ6D11pdBMeS13OPSAn/MUAmNaq8cbPXNRS3Cf+M=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5802.namprd10.prod.outlook.com (2603:10b6:a03:426::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 20:24:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 20:24:29 +0000
Message-ID: <26565cd7-01b0-197c-6ce9-af92f5bc8563@oracle.com>
Date:   Mon, 21 Feb 2022 12:24:25 -0800
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YhNQf3LUZzNRD7u0@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1201CA0005.namprd12.prod.outlook.com
 (2603:10b6:301:4a::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cead66c-6721-4776-1d94-08d9f5782919
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5802:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB58022AD057C5D195675E2390E23A9@SJ0PR10MB5802.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFJMovPwJHIeGpc8tfa6rXZXMPcQIafGGIDyk+PJ+zSt1C29fWDyY/O9U14ktTD0G3/31VeOtGtWAkoy4ihtx3Rv93eF/fbKSW75AhuxD7lxwLKxb+lKEeAX1YTYJ4UE5QZMEwKaIUPBqtoGJpeaYMAaKnzgilY575k8X2UWTAvRE+jdYG+m2LvflZT1oVKBRtrkUyuOZcQ3Q2+ZykR3lh9SNeI9FRrBkjF4FuhmQ+1MhOOT6xRpTfakEB1MIw3wFNjTsCalXLevaugrVz8Jrg5Ecm/46n6Lt4JHJei4MmQXPrbJv09q1ZYDaSeH6hHGxt7r51YpJYqCs1DLjBCELueEzRKEnsGFFpyMFD7WH2XDGQ+JWk2N7Jin/d6K8Qi6XnOZdb77cMPQmblOr9yiHe697JFZRu+eGkKbg0Yyvdhm67mfJLAXfhUngSukHuIi0KxTe408mv3F7VIii7X9Ry+rBrL14L/D63QCQp76hFTKrAc1c3DsgsDUCivPzSCImyPz7nPDy4hzNF0c7PQZ5F7q1rMb0XP+2cKZtDQijlMJP4EWD7U6LWgKiGdlZXdSqsLEJWkOGc52GFfchUDYBkH56EhvMvPH4oL5NF0YAPcEVL8v0CxnD+h17FX3FY6JgLudnknQlO4DyK1ijSw0cokQ1rkheo5Sk7xNz9aTq+H7i72rcBHT0qQfX//MpgMtIW56ndz1mRyUABdkbH4m9zeST9/thCxARL0xeEzKe7wqkV4UEs/+kYgxBm3jwxEWNvSTdBAaHyvKV5FozT3rhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(316002)(44832011)(2906002)(6916009)(86362001)(83380400001)(5660300002)(36756003)(54906003)(31696002)(2616005)(26005)(31686004)(186003)(8936002)(66946007)(8676002)(38350700002)(38100700002)(66556008)(66476007)(6486002)(6666004)(4326008)(508600001)(52116002)(53546011)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1N4SFNqRENpMTZxWTUrSHdtQ3g1WThQQkRPSC9FZUVJejFDblM0dXlxMGd0?=
 =?utf-8?B?cjI2amV1cTFjVUk3amdYWndTVVE2ejdoeEVVbVUrYXpSR1UvZ0RZNmRieDdG?=
 =?utf-8?B?UnN2NFFlanRiOU16ZDNOd281ajFCVStpM01zUEFiaXM3ZzM0MGVGdDkrTjFq?=
 =?utf-8?B?cG4yUlROK21qejZtZWZ1YU9ZSkFuUDg0Y3VkQmZjTDhLQVBCbCtaeDVUWlVK?=
 =?utf-8?B?WmNaM0tXOExaRDhJMjdRUzc4QnRMeGVuQ1Z0dW90NjBmd2cwb0NXRjFEazNY?=
 =?utf-8?B?QWNON3FQUVhYTHRabFlVUGlZclJZZWV0M1JnbHVHTU85MlNPZkMxckUxY1Y0?=
 =?utf-8?B?ckM0dG1kcUZSdTkrOURhSWI1Ulp4RUdrZFdpY0VPUlR2bFFrd2RLc1NLVjN3?=
 =?utf-8?B?ME1yNlcvVjdMU0xubnM0Umw0NTdyUHFleUpSKzdlS2dQZkk0TVhjaWxtamVE?=
 =?utf-8?B?T1JJemEzYjBaSXZDazkySjRTY2lkbXRkRUZGUDA2cHRQS3dCeWV5MDJ1NXFw?=
 =?utf-8?B?emFBMzNiNjljWUF1aVNXVlRlM3Z2bmY0WlBSVnUzd2RWUXdoc2h1UDFzcGF4?=
 =?utf-8?B?dEM4T09uKzlIKzlDZlFPNnFvSC9ieVVqMXJsZ2lzZFVPRXdxWElQMmdMRElB?=
 =?utf-8?B?MkQvZnMxZkxIcFVLWngvY3gyYnFkajNUVHJwWC9Sa1FFcGhHSmhEUHFtL1Ru?=
 =?utf-8?B?dWtnV21NQllwSUVtMXR2VkNzQnNKRzMvZUpwc2Q0aHIxMld5MS8veldUbEF5?=
 =?utf-8?B?emVJRVlXMDRjTnh2RWxKZ2FoMzNHbWJkaUMxUFRySTVXY2JIL1IzeEc1Skwr?=
 =?utf-8?B?YytKaFU3elY2RlU2VTgyc0J6emNQa0VyWXpLSFRYaTJvNUtoT3VzYmpVaVIy?=
 =?utf-8?B?SU9HTlNmV2grRzE1bUxnYWluT3laY2E0SUtlR3hnWW1NNGJKWVk0Q3hoZVRX?=
 =?utf-8?B?WnRjZU4ybHNsSnMvNGlSSHRQdEFTZjJTemhGNzI3UTNLMFQ5eUNpcmtIRTNK?=
 =?utf-8?B?ZDZMRThJd2xYbkljQUwrTGNUSEo2ZzRiQko2VlpCeTNCeWtJeVU0QzR1a25N?=
 =?utf-8?B?RXB6bTgzZ2tiVndEd0tRQ2F6aGlZaFIrc3RGdFFvdGFDUm4vUVRxdHNqYmRX?=
 =?utf-8?B?amIwamtDR1hFbHdIRjRSaXpjK01BN0JrVGJTeERrZEZadDcvZUVFTWRTRlk5?=
 =?utf-8?B?VDVpU1dmNmlDWTNEdW5Bb3h3ZmtiMDVIVUNxZ2h3UGJ4VFNBYkNuYnBxVmhH?=
 =?utf-8?B?czBMdEYxOHYxOWFnaW13dW1OUGFjL0xPTytvSXV4Ulp3TERTMjYyZkU4NVdP?=
 =?utf-8?B?SWxWNXp4TSt2bGtVUHhJSUYydVZicUkyYUd1M25BQUUvam1wT0lOcUhmckta?=
 =?utf-8?B?Vnc3TjErODdtNVdmdU9DRjFCYlJMMDJjQUgwWDVOV3FWWWlzcERWdk5QbmQw?=
 =?utf-8?B?ejg4TmRSZFRDcFFzQjdhTEgxRFRnZ3l3Wk5zbm5UdnBDelJXNWgvWFNxZWxo?=
 =?utf-8?B?dVNpK0dCMGZFWHBURHo3bDJGMTZrRDc5NjVqb3NkLzQ3Ti9oblJTWEZMUWpt?=
 =?utf-8?B?KzcwM3ZMK21DS0puUDVwYmE5VHA1dkNzRUxmbFJrTmxlMVh4dmZlOHNXODdy?=
 =?utf-8?B?Nzg0emRjQnpSdTY4aGN5dnJ0RjNOb2luMzhlb21WL0JiTFo5NDB6anpHT3lk?=
 =?utf-8?B?OXR5WTZoSnFrbDdoZ2xhcDNEZHoxUDhSWGw0QkdrMnp1a3RnUzVhWG0renBF?=
 =?utf-8?B?Y1ByWVNWSWQwMXJXc1FseWtQMzkwM0dNMTJxMitzRW1aNm5hTm5DTmlFUUxK?=
 =?utf-8?B?UHQ5QjBSYmZuNFZGTGVVQllqaFRkRjlKTmtxUjh4SjBnSmExREFJSG90ZEJV?=
 =?utf-8?B?eXdpaGkwWmdscVM3eG0rZUZqdmpQWm1ISEtBRkozeXVZWFNKSEVEa0hRUkxC?=
 =?utf-8?B?aklDZWxxZHdqWTl6VGtNb21HdFBNODFmYUF6Q0NoVWlMK3pRakN3K2szQXFq?=
 =?utf-8?B?UE16SmYyZmYyYWxscjV5WXR0bE9jQzRsTXN6WmFvRC9ndlZCSlZBL1RsVmlz?=
 =?utf-8?B?MW9md1NRU1pRUEhBczVLZHhlNWlVRW9NMDk2cVArZDF6NFg2UUpYTHhkY3VE?=
 =?utf-8?B?bmQ2Q20wRHBnQU4yV0lEdXBZaVhZeWgxQzJrcTBqRUlvQ0FnY1lkQTVQTlRp?=
 =?utf-8?Q?t/VYRciGCo1fhxqla2dHOOA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cead66c-6721-4776-1d94-08d9f5782919
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 20:24:28.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfmzp63Zsta/4QyGbb0h6G8EuTmqTnlTnkbkeRMBUzZAD5b3QDS0A1QKx2Ib1lwINQMwCtqyWYcKuQlfi9eUOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5802
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10265 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210121
X-Proofpoint-GUID: JE9SYh75vLk6Wu0TH6IxPGcCteURnW9Z
X-Proofpoint-ORIG-GUID: JE9SYh75vLk6Wu0TH6IxPGcCteURnW9Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 00:42, Michal Hocko wrote:
> On Fri 18-02-22 13:29:46, Mike Kravetz wrote:
> [...]
>> @@ -4161,7 +4162,7 @@ static int __init hugepages_setup(char *s)
>>  			}
>>  			if (tmp >= nr_online_nodes)
>>  				goto invalid;
>> -			node = tmp;
>> +			node = array_index_nospec(tmp, nr_online_nodes);
>>  			p += count + 1;
>>  			/* Parse hugepages */
>>  			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
>> @@ -6889,9 +6890,9 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
>>  			break;
>>  
>>  		if (s[count] == ':') {
>> -			nid = tmp;
>> -			if (nid < 0 || nid >= MAX_NUMNODES)
>> +			if (tmp >= MAX_NUMNODES)
>>  				break;
>> +			nid = array_index_nospec(tmp, MAX_NUMNODES);
>>  
>>  			s += count + 1;
>>  			tmp = memparse(s, &s);
> 
> This is an early boot code, how is this supposed to be used as a side
> channel?

I do not have an evil hacker mind, but I can not think of a way this one time
use of a user specified index could be an issue.  It does add noise to the
BUILD REGRESSION emails sent to Andrew.

-- 
Mike Kravetz
