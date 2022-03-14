Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B9C4D9071
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343707AbiCNXih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiCNXig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:38:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25D8186F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:37:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EKru3S015173;
        Mon, 14 Mar 2022 23:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Sx8/aMjm83VjielJtGlhHtv+nnnu7ze9WKCqHQlY3f0=;
 b=eKRGzcHpDfVDRmQdnO5uDWzo65Jkt8SdFgcDPwl2lVU4HU8JbL5oh5+9dvgAPB0sWsG5
 VGDFzTOrH9l01L5lPdy5vApYUitVlrobbsbeLmDF3wU0PgzPEgjnwAXhp7o+SETaCz6X
 Hbnzd71/myNAM3jat9bguPWHiu00ErFhfTWGQFkUseQePAp2x4g8MO3jVm6BJvFUvEQ5
 SXDZ+JqGWzTcMMpOug6pIebKmbEnCWmkK2QJ/bqr+BF8kKCbQ3dRIPzFg8d1K/gpYlrv
 D1asUnLB5EdkycERXof5WfVJiP49jzk7UEQHcLOg4gg/NYQWbzvtLkNNW+rjgDLO3FIs 7w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rhna1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 23:37:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22ENGNkc096994;
        Mon, 14 Mar 2022 23:37:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3020.oracle.com with ESMTP id 3et6573scw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 23:37:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1n9lAD3JPm3q6vuG7t5SZs+IGqdwyPQgdXtFIRsZ2FcEFN9TH/pDIW0Ua7y1JszJryrKqb0gOglb3wrYqz86+rztlFMKK8HPjiVI1WtCmpvXggG15aYQDrRyAGk51se14zOA7jQ5JjGPEGNGVQYBCWbpoiaJ0NSxq8Hhxc9/NoSJz5Rp9TwUhY0HK78hfi0XqL4LcNXgryYQoGBB+71s0WW6R8AhPsE/zWv3GVNGSAWdXgqcs5B5uW0Bml0p6NJrWPGupIkEJ0hQ8pTAMgZmMiOZNnybszXcbCIotmXskhWVpfQ80DVlISFUYXCb8GNsa+C3t0elCLb2/Hz+gMG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx8/aMjm83VjielJtGlhHtv+nnnu7ze9WKCqHQlY3f0=;
 b=U6+L1wnovZuC7V2TyMJ1VbnqNcGmBbBGl4pfmx3TYGNZZUvrdnCQiD0YD1ew2Jic7GUM7kX04MJ3+SdCAPZSmxcUZp7DY8ejX64es6Ul0KfvCYoNBDtLyKSqI7M/jbGQXj9h73qQgM/0rZ8dawTjG/+6TcBJkJvSV4DTxNsW0f+V6tC1k5Faz7gDjEOwH/Go/4M1caWyz675OhuoE2JX2Mg+gUt5kuK2EvfxPGaoDxfZ8MJPmcpWO7eioEINkCS9GKog2o3uqfHKzK2IYlg9/ffsy4teJ9Gx/ZyFYYuuFKjlFR2Uf5OnlDGqpRD5IGPEfT7Znh40UOLKZ6V1Kb8Hyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sx8/aMjm83VjielJtGlhHtv+nnnu7ze9WKCqHQlY3f0=;
 b=x0rE9+1RAVt9zolAgTWMoTUEMROHETiFR/e5FP+pX/bvXVcZUamL/HW0PyQhylrSLQZ0/EDf914V7vQeM1G6ZyDt4w746MlLNjWbxt4oE523Zy70VEgq4h6IAuS2n30SlIb72Gjpw32uSXvDdhIxRWSVa6nTTWOAHGxBa7IRGD4=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MWHPR1001MB2336.namprd10.prod.outlook.com (2603:10b6:301:2b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 23:37:13 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755%7]) with mapi id 15.20.5061.029; Mon, 14 Mar 2022
 23:37:13 +0000
Message-ID: <63365484-7035-f2bd-5317-2e95d65993f7@oracle.com>
Date:   Mon, 14 Mar 2022 19:37:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] xen/grant-table: remove gnttab_*transfer*() functions
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>
References: <20220311103429.12845-1-jgross@suse.com>
 <20220311103429.12845-2-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220311103429.12845-2-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:3:12b::22) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7254098-7673-4b3c-45ad-08da061390f7
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2336:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2336C87F7EE50E00FBA337478A0F9@MWHPR1001MB2336.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rM1OtZAQJZxJUxl4o/n1FEZOJ4+92aMZ30yTj/Csy2ZGt8MxqniYWR2GMDoRp22x3VbfcStIRtSgBHp8mMtX77Q/+XVh2f+t+80AMrjTlWpTwh/IpHusvhwsTgX4GviIiTbts/C3zyhcMFoxSmphimHY6+6KWrZgliSIVZqP8fa78dsHRkHR8iPaDxeKxqLbo5WTe6puXsg1aXx1HN9Ut4MMUsE0SdjCM+RW+ikXXpFe8p2zKN3snCnnEmE+tco4kFhRTtpXlDFh9UCJKrEwDrKSJl5jKJyV2XAp/3RQ8iT18/bOatnrkyH3VUUe9tpbBqNxJNExz8tL+X3FUX4RtASu50NnaW22gSjeJPXHFaEKggV86JqvcoKqqrYVpyngPACuU35naluIZGOZJ6ZswUBtT4wluLOa2PD4G5pQmoN5jrfwlmNQB8l/8ka9cfoeedttknlamHp427LjuGyCL9NyxYvMtKU95+2FmiGUFDcXF23hRZeiUo2Txyxk6KtGyM2c6gzcYGAtXNfGIAFqCZm+2/Ll7LMLRXKfHthCKrHktWpmqyqaKuQs8s9ywNof36fEGT5flHvBUfpyY1HigMi300JdbZjpvW8gFi+4pOEKINY3gTuuusX7MQkmJL28TaGmSBuDC9h/OXnopxezO4eeIwPxcYedfsbCt7RKzDa8vkE123DLUJr5Smn04mhWFY3JWD2zBM35Yhh7syn4mo0oxjrRzS+IeHM6Q1XM9g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(6512007)(6506007)(86362001)(31696002)(2616005)(26005)(186003)(53546011)(38100700002)(5660300002)(4744005)(316002)(4326008)(44832011)(8676002)(6486002)(66556008)(66946007)(66476007)(8936002)(508600001)(31686004)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDM0bWw5MTVRaXVVVkN2TXVOMERud3kwQmdac3pVNmVOZHhpTU41aHYzNnZH?=
 =?utf-8?B?aW1MMEJYOWFCRUtqdU1wZXp2dnhGbHp5d0xmNFpkN1ExU21yZitrVk0rUjAz?=
 =?utf-8?B?T1lLdE52VWVsVjRCVUVjREE5MUxMLzlVaTFWd0h1M0FSTTJKVTZFTVoxeVNM?=
 =?utf-8?B?SGVScDZmWHJ4QmhWREFMMWlxeUI2ZksvS0lqa3BqTy84UzNQejZjRncvWFN0?=
 =?utf-8?B?OHNPYlNXQXVrNVI1YTBFTWJMdVZIRFpMTnAraTU3bnpuUEU4ajBuSjZoZGs3?=
 =?utf-8?B?QkJqNW5KSDI2WC9oaWgzQndqSnE3VGwxenduTktoS3BGUlpKdnRKSEdjbldl?=
 =?utf-8?B?dkthYmgvdHVOOVMvVndIVGxaQitMMnpyMHp6NVF3WUloSjZXcVNSZEZOcjZX?=
 =?utf-8?B?TUp1Q0ZYOUdqSFpkMGkxMlNjTkJabmZUUm53NlAyWXVBUHJ0VlZuNk1LUTFP?=
 =?utf-8?B?cGVCTHVEK0dNMXYxM1VGWEEyWUViYzRCK0c0MUR2OWx5c2RKbDFkTGVQQXNw?=
 =?utf-8?B?Z3R6a2FCWDRrUlQyZHFwNi9WbWFYYW1BS1hIanpsOE1FekVRenhJQ0NidWoy?=
 =?utf-8?B?MEUrcnR2OVIvbndmdWdxaHE2clo3Q25MektqbUxadHRyUm1ocURtS2JjQ3cz?=
 =?utf-8?B?cnVNNzk0czczSWVrbDRWZjE1b1lIZGE5OU01M2lUc055RVV5WjVXbzQ3YjZO?=
 =?utf-8?B?UCtPbnVQUkh0M0N1TXAxNjRlTTlsVFZsMUZ2WjBYNkRlNmdMd0QvWEtXVmgx?=
 =?utf-8?B?UW10Tkk3U1NCeFpvMnFKNy9KYStqU3A2MXhtMFF3N3RWMmY2dDdnWVZSQlNO?=
 =?utf-8?B?dUdQSityTmtsZll2UXFqQ1ROcVdYWkRyT2tUenlYQWNCZDZCNmY4d2R4NXpK?=
 =?utf-8?B?S1o2S0xlaTl4STVJQjlENkNodWxyMTdpWVlRQUNFaFlpUzB6T0xXMlNIVkZP?=
 =?utf-8?B?VmhYWkkzY3FReDFCellzcnNId01xK1NLZjZHSlREQ0N2T0g3ZmFITXRUaVVi?=
 =?utf-8?B?Q2pFYTBOeGZqOGdsSWhGdnI3d0VMKzFraEdmdUZpNmpBck9JMy9YSXB2K0J3?=
 =?utf-8?B?OVk0dVlRemZHOGE5Y2JMTXZPYWFJemd3SzhaaUdNcUcvRXFURDVGd21uN21i?=
 =?utf-8?B?UjgrcmdBaU9qM0plSHZaSGVNOEM2K3QvL1Y5VGYzSk00MXZKeUxZYkZiOWdY?=
 =?utf-8?B?Tmd6bFYzWjNaSytiVFU4UDNvZXJLSG9LaFJJYUpLNWpqZEdqMTgvMjY4dE5s?=
 =?utf-8?B?bTcxL3ExSm9PKzhSc3JSVFdLdWJyRWN0QU9oYWVNNGg5VEZaN1FsMlp4QVFv?=
 =?utf-8?B?ZGtMU3AvYmdlU0ZaS3lRdDNQTHJtL0ROeTlZWDdnOTVOWUZNRmxKc0ZHRkxC?=
 =?utf-8?B?eDJXNisyQTRoa2k4TmNqNW0wcWM0VjIwTVQ1eDM4cEFwRFlSK05oNmlHYVVt?=
 =?utf-8?B?d1dNWXNYRlVBYzZSVHVaWEdsSC9KMjBwMmRZQWowNE14R3NMQk1QNjJUbElP?=
 =?utf-8?B?Wlk2YTVCV01GVkk3U0NkdmMwaWlFVldSM0trY2ZoUWdWdGxSMXFVdUxrM21G?=
 =?utf-8?B?Nk9UYjZ6WTVHTyszeXBMVlJIcncycllhbDBqeVJWZGJKR09TNlVLSDlvYjhv?=
 =?utf-8?B?Y0FtNEhJaDVkV1g3aFBpV29lRy9oVWVpWU5FTldSaExoazhvZ1ExNDVpdzg5?=
 =?utf-8?B?QzNqa1cyQnRDT2VhTGhMLzVMMTl5Y2R4MS9yczBjTUd3WjB0WTRYblhSZitV?=
 =?utf-8?B?OGtaMXV2Ukh5MTZOOUgzREsxVERUSjAxNS9WLytyWnpVNU5UNVNyekxFT2FV?=
 =?utf-8?B?T0FmaVd4Wnh4MndzeU9ZNUNxQUFsOXk4UVF2OXdJRi9MMUJULzNEUWZ1VzMw?=
 =?utf-8?B?NGpITHI2clc2ajFTdkdpLzhiUnJMdFhvVnBEWWlZcEFFQXk4Y0MwTTNlK3pm?=
 =?utf-8?B?emRFWWFvd3NzYzFUeHJuQlpXVHdCL1E4V1k0dTYwanpTWTcwUlFHb0xnZkdS?=
 =?utf-8?B?cS9CaWVZeEt3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7254098-7673-4b3c-45ad-08da061390f7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 23:37:13.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBNZ5ZKb8iV1nregaX1Jbt8hI11CBw/0/itvd6JcTKnUYZM69uAY2oIcR5IHhtj5qyXZBpIdzPt2bOoK7o1s7F4o5aH8g+QqNLZHY6KXInE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2336
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140132
X-Proofpoint-ORIG-GUID: 3a9BGKFCgKYkn1Q9MJLdoUTO35UXNdXe
X-Proofpoint-GUID: 3a9BGKFCgKYkn1Q9MJLdoUTO35UXNdXe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/11/22 5:34 AM, Juergen Gross wrote:
> All grant table operations related to the "transfer" functionality
> are unused currently. There have been users in the old days of the
> "Xen-o-Linux" kernel, but those didn't make it upstream.
>
> So remove the "transfer" related functions.


Do we need to assert somewhere that transfer flags are not set?


-boris


