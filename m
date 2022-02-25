Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED1C4C3E11
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbiBYFxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbiBYFxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:53:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76B1187BB2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:53:15 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21P4gRfQ028590;
        Fri, 25 Feb 2022 05:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lXdkL+Y7olObt0KiApgt769C/ClM0KO4aZeqchaeitY=;
 b=yhlZumgNshx+MDGlVP3IfUhRJ0uz4r85g5Cdr/tfa8441j012nvfshGc5cn0nCs4J5Qn
 Csknb8fxS3n+5QfLwo8Xf+ZCfBBpaTzOL8P2TdsUq2ksYTo01juhDfczFpUoqsud7aNS
 bD9ed1W3CF8+MGOXLac0pqEi6J3TeniP0nIG82gBb4V70ugSyQD4+fagHY5zwxT5VvtH
 mmtdvCLePqz1v/mhB6zpmP1D2olI2MBo/LpdFaIqG2Ula42hQl4nUGBOsC1+kmdswxvP
 ASvh4xbYzXTZD9IyhN8WLrYSBPHojiinaDAIOfCWf/z21+MwyQn5t2hgEqMUYFv7SLWG DA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecvar8vsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:53:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21P5V1Lr026689;
        Fri, 25 Feb 2022 05:53:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3030.oracle.com with ESMTP id 3eapkm958q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGFXX4XPD56jXdjkTnBFaQlXWftNl6fpEK1a7LCFLfgFiFCgYvwg2xPRxEf1WKsOqGD4RIhSZVMVQXw4sHBa3sTDm8ckCEwyOLtkbp0w9tWFPbYu0OWrDs/CLDz6wzEWoGNSo24I3ethiz6hK4hQ3YABYSHvymE7x4Ko15XAi5XwzurPlz0eqJ4eX9/C2p+QpyWDmplY+WbrY9bc2czJOaP6KvVdqb6SDsQG0vPxyMil3OIkp4EZgT3SzkqBFzSgUITLpIaBqEXeiNqjT7zHJJCH1zwWLpqp44zygas13vilwV/Oh1A/Alj9DSi5Z71MG1LWp10E+g+Z3eX8EG7qFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXdkL+Y7olObt0KiApgt769C/ClM0KO4aZeqchaeitY=;
 b=lLgqdjjYuDbsqZXK5IeaY/F+OaowfB14mMIPksEZigPul11xQX6Sp/a2jNGALNEw0IGkESmJ+83LOQTHz71640V0Q7b/JRn8h0s2FcrubCeixKo8Rz4AhTA0lMjEBRp4+FNKTwqhxG/Sn7i5nx0MbLDkyL9wT1haCba1Knrx/EBu3Efxt7cjbn8b4WOehqmiHoNMKvbNZCkUD+skqBtob+9lL59GnNQsGz8bQRMx1AzEg9JBAv4HDSxc7T0gLcoYzuTeyiz6IK/7rt6RpV3etPEcI75D8ObcC3bJhhBW7QFcc1q7X0qTHiUeQd+oKo5v6SD79iR7miEG9o+2EjsZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXdkL+Y7olObt0KiApgt769C/ClM0KO4aZeqchaeitY=;
 b=PQp0jIROzjaSRmap/sOvcJTLxvnM2AxPxnGgJeMn7uokVpF0FK4SC5qCSmkrLPU3ihh8qAR+t4OueAJPvz2YotgZ+bjj0UWlwoykiLYiBwRJ9pbCwk+9/KnygsM8ufMSleYV4Vte3Caui2NlpoCzbvHhZIJuD6mlDz/QrkO80B0=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB2460.namprd10.prod.outlook.com (2603:10b6:5:b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 05:53:06 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 05:53:06 +0000
Message-ID: <23ceb6f7-93b8-f633-09bc-76bccfa0fa10@oracle.com>
Date:   Fri, 25 Feb 2022 16:52:57 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v6 6/7] kernfs: Introduce hashed rw-sem to replace per-fs
 kernfs_rwsem.
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20220214120322.2402628-1-imran.f.khan@oracle.com>
 <20220214120322.2402628-7-imran.f.khan@oracle.com>
 <YgxXh3clQqpxUPba@zeniv-ca.linux.org.uk>
 <bfdef75d-4343-2734-2723-d8546df37c69@oracle.com>
 <Yg8Rq2H1C1ihFqds@zeniv-ca.linux.org.uk>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <Yg8Rq2H1C1ihFqds@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYCP282CA0004.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::16) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c96993b-5534-4500-4316-08d9f8231850
X-MS-TrafficTypeDiagnostic: DM6PR10MB2460:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB24603B4B7688B02AADB221EDB03E9@DM6PR10MB2460.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcWp9InYKVcD9OBJeFQNXOMCYl2xG0oTlFrHuU/Ni35/8/QemU0UNYDdv5U73zM/auKLB2rPcvdtznAp39Lbrk7FTvc5b6QZIoPoouRuF4X1nhmnOO/Yf9ATIL/4s2pCR2e7UkpxAiZpxu+ZY0dJndv3f95+R8B6EtGnbj3VXx3+HhCK5+3QLkfXtqz3/sma4AcrQwdX5oigPhD3HyBQXCc4Ox62mUHc/+Vky+f6ke7m0jGDk/x30PYTkv/C907TT0E4XyjO34Fky83bl7oKsOoEH1k2c/GnX4S16gLyOyGvM7ExEzJDP11WYBJZhpwL1gsF5a91XJNVQR5xN0oMx3A7ZiENhwhoGJgFmSIS0RDngeb4OdZjWgj72SgA7R1dSDnpGIP8McKHHK3RZbbwpy601Nwf50rh8EK7tcwqoZrrK9mlkPNOMzUYbt7U95N1pvtFuEpbz+xHwTWV32YI1KoQX4s2ibU44LNXZTbqfbRBHZOiAaOti/XkSjb2KUpO2+TzABXyErY3cbbW/5wFD2f4gKBq+rG8nolxBokU9IqedhmshGBXUpkDDF/szWjmG091rs7w2/TFN7lbvGVlAT5gYf3fOEyUexi8EuG8NkGI2wqS+YhoOFZM1hkoya7gHbdcWgCX5MS72FfT3Ocue3Cq9uQER9LJUKs9NK4qauGBQBOIUmhyU78Kp2Fag7e6qwI2HW+wW1RO7dMIUhLFq0zSNRk+aZoNDM2VF8L7hRJMleBBSnj4t7G57M29U3wAKgGvLtVicgF9XCM7Sw4baxYD62Am5W3hdBooK4ONthV838yglITJdx/SNA3lk/Uv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6666004)(66556008)(83380400001)(6506007)(36756003)(66476007)(66946007)(508600001)(6486002)(966005)(53546011)(6512007)(38100700002)(31686004)(26005)(186003)(2616005)(2906002)(86362001)(8676002)(8936002)(4326008)(5660300002)(31696002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW04ZGpwbks3M0xhK2dYMEFyRkhrQmVTbEtYdmZHa0YzOWk5M2RjWWRpVHpE?=
 =?utf-8?B?WUVLdGZ1NWYxNklaS084cnpPNUs5VTdpSHVFMEUvcEVnVWwzc3ErOHVCMVVu?=
 =?utf-8?B?VmxVa2IweVFJQmJLTTVzQzllRmRmeFllaTFwZUtKRkJwdnJUeDlSakdhc2lz?=
 =?utf-8?B?Ly9tV0RTc3VqUkQ1eVladHd3eVhXcFhkSWFVMENpWGZVYzRIZlhMTDZpK21R?=
 =?utf-8?B?cElTRjhhTFpSR1pjSG1Sem9McnNhU2p1MVl4TXFlRWdMV2phemp5UVJYdFBU?=
 =?utf-8?B?WHRJdTFvck84YTUxUEVpeVA2dldlZDJPZ1RIZmxpbXEybTk4V01ydCt0QTJ3?=
 =?utf-8?B?ZXVvVnl0N0RXdzZZem5qWHFyU3NKZzBIQVZjek01Sno3ZTZYTDhWK1NySXZF?=
 =?utf-8?B?MWY1eW1YZFJZVzYvcjRlWURXMUZkLzB5azljcE52ZXdQK1FHZEZvYXJoaFlp?=
 =?utf-8?B?MHE1Wjg0NG1kaWVNUmxMZ3dLQS9hNnZMbnlCTTc1VjM1L0NqN3cvV1ptalFr?=
 =?utf-8?B?S0Zqb2hCSVIrVU1nYXB1TktQSTFWMU9LdmFxSGVmMXk3amZxRHhrQ2VqZnVT?=
 =?utf-8?B?eVdmMGVmMGRFNEhRL3AyVjNoYXVZR0FoSTVkYlFXSjgyL09nR2g3NFMrcHp3?=
 =?utf-8?B?K0Z2RWxOcm9zalR2RG5HY2xDUnIvVUw1YjFFRThaaVpYbkdTcTZBR2hFakxm?=
 =?utf-8?B?QlJxdVBVQXg0MkE5aXdaZTVmQkdwUTcyRVJ1UGJKcDNVOEN1bnpsVW9CRXR4?=
 =?utf-8?B?NDZEMVJBbEk0K3QraTVpTTJlUXJzN3N2TnE5NDVmMmZTc0JtRTNWeWR4dXBw?=
 =?utf-8?B?b3V6dFIreCtIOWVaN0w2TnBPMzdtRHliTkFDeWsrVE1qYWN1d1BjcXdxRXpS?=
 =?utf-8?B?MnI0MWEvWmp1bkxNdDE5bWlEYU5sV1BFdnlxUTFRNkNvYVhJcHRTUDVNdjRr?=
 =?utf-8?B?ME9ZbGQyM29vZVhFVWpTMnl2UFMzRlMzNmpWcDd0YjZHM2I2SnptZnR0dWoz?=
 =?utf-8?B?Z2lHaG1adTVvZW5NRFBuY2JqdGNKOTMvVE95VHhiZHpWT3VORndBZlNEQVZS?=
 =?utf-8?B?V1RzYjBLb1d0NDdHZVJ4c280T2xYWTljN0xuN1hYdHJQS2g5bEh0SXozLzVW?=
 =?utf-8?B?d1VVaEdXZWxBTk9aMjhTUk8za2lUZjBTS0tiMm1GV0p1a0JRbUVZRFRNNTBB?=
 =?utf-8?B?MUlQUVZwUFMwQXhmY0pqS3k3SHowS3NrYWJ5aUZRZ1pjOFE4VjIyU084Tkpi?=
 =?utf-8?B?eWpuaUVnWEQxTHN5N2lXbXBjV3lyUDdIUzN2bFVDWHRHaFpBNFVKRlZ3R1ZK?=
 =?utf-8?B?MVlFWW9ZM3E0SnRsTS9tZEh6ckJPamVQTVF5emNOQ2VmWFhjM1drRUFxZzRJ?=
 =?utf-8?B?NStQUzVvK2R1bjAvM1E2c3h2dHlGdGpVeTBrT2N6SWxJSk5tY3E0RUZFcjdQ?=
 =?utf-8?B?aUZyaklnWDA5ZXNFZDI2Y3BmMlV0YmhNTE5ya0RSWXpEOWhJRThRN205QVZK?=
 =?utf-8?B?ci80dktiWThmRGxJOUFtK0l2b1RLKzhpNVg4ZTY4OWtXWGtMR3hXZlJaa2U3?=
 =?utf-8?B?WEI4dHVCVmlVRTh0V2NCQzVLeVJYWFRRQm9zVnBESGtNQlEwZzNvQkpGUC95?=
 =?utf-8?B?aWtjMjhFZ05rYzVrWXh4dmg4MHJ2WHFkMjAraGJvalFzOG16Q3J4SEg5NlRK?=
 =?utf-8?B?emllSmVtWFFFTWZJbktJeitEY29IMnJoRTBndGNrK1NyRDdiak1sckdjcmxi?=
 =?utf-8?B?OGZlUjNTbGhUS05DaWlZRjl2aC9oVXA0OS90a1JEN1h1N3pESm5wYXdDL0Nv?=
 =?utf-8?B?TnQ1aFNOYlZhMkltbmtEMVJzbFpFdzVkNld5eEpHT1FsV1BJaERmRE9qaGtl?=
 =?utf-8?B?SVlOWTkwUUswODArWjFtcGwyelFaWmZWanNyMFU3NlNjdFhSNkMxZzUrcWY5?=
 =?utf-8?B?WFpLelBQVEpZSExZY1VoQmNrNHdVQ1E4UWRNQmhLbFZPTk5BU0k1WExWUExt?=
 =?utf-8?B?ZHh5QUtvTmgzSUVjT2xWcmJNeDNkSnpsRTNyMnBqaDZxYVRXL3kzbWhPbGZa?=
 =?utf-8?B?Q3A1dGUvUUE5aTQxaFE4clg5cU1tS2xkYitUdldpblphbDByOWRIOEZuMk5D?=
 =?utf-8?B?NHg3NGhRU21EVnZJR1dYcW1VcEtYZVh2NmxvcEFTRDhxN3BQS1NTWEtxVE9N?=
 =?utf-8?Q?4kMYIYHKR3+BHmj7IXMZj0w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c96993b-5534-4500-4316-08d9f8231850
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 05:53:06.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIMKlzITKg2uNd3fHVeK6a83YZmb3euPLxoPigQMar+7hsrB3H/yFZuVlZlUfN9tcF+ejDuZmSvl7+Klw0+JWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2460
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250028
X-Proofpoint-GUID: clzK0JDAq02yZNxW6SziGFbNLUs7IPXO
X-Proofpoint-ORIG-GUID: clzK0JDAq02yZNxW6SziGFbNLUs7IPXO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Al,

Thanks for the feedback and suggestions. I have addressed these in v7 of
the patchset at [1].

On 18/2/22 2:25 pm, Al Viro wrote:
> On Wed, Feb 16, 2022 at 03:57:09PM +1100, Imran Khan wrote:
> 
[...]
> 
> Maybe...  TBH, kernfs_remove_ns() calling conventions suck; "move this
> (wherever it is) there under that name", especially combined with
> topology-modifying moves, makes life very unpleasant for callers who
> want to use it safely.  And I'm not at all sure they manage (or care to)
> use it safely...
> 
> There are very few sources of cross-directory moves in the entire system.
> One is cross-directory cgroup rename(2) (already serialized on per-fs basis
> on VFS level), another is device_move().  Which is uncommon (5 callers
> in the entire system, one in drivers/media/usb/pvrusb2/, another in
> drivers/s390/cio, 3 more in net/bluetooth) and AFAICS unsafe wrt e.g.
> kobject_get_path().  Not for kernfs data structures - unsafe use of
> kobject->parent pointers.  I could be wrong - that's just from some grepping
> around, but it looks like a use-after-free race in the best case.
> 
> So changes of kn->parent can be considered a very cold path.  Just make sure
> you pin the damn thing, so it won't disapper away from under you while you
> are grabbing the locks.
> 

Done.

>> I have run my tests with lockdep enabled as well. Could you please let
>> me know if there is something that can be done as proof of correctness.
>> For sanity of patches, my current tests include LTP sysfs tests, CPU
>> hotplugging and cgroup access/creation/removal. I am booting oracle
>> linux as well which involves cgroupfs access(via systemd). If you could
>> suggest some other tests I can execute those as well.
>>
>> Also regarding locking rules, I am not sure where to mention it. If I
>> put accompanying comments, at all the places where I am taking hashed
>> rwsems, to explain why lock corresponding to a node or corresponding to
>> its parent is being taken, will that be enough as description of locking
>> rules.
> 
> A separate text, along the lines of "foo->bar is modified only when we
> are holding this, this and that; any of those is sufficient to stabilize
> it.  Locking order is such-and-such.  Such-and-such predicate is guaranteed
> to be true when you acquire this lock and must be true again by the time
> you drop it.", etc.  Some of that might go into the comments somewhere
> in source (e.g. when it's about data structures dealt with only one
> file, or in the header where the data structures are declared), some -
> in a separate text, perhaps in fs/kernfs/, perhaps in Documentation/filesystems/)
> 
> And, of course, there's the cover letter of series and commit messages.
> 

I have added a document to describe usage and proof of correctness for
hashed locks. This should highlight if I have misunderstood something or
if I have overlooked some scenarios while making these changes. I will
await your feedback regarding this.

Thanks
 -- Imran

[1]:
https://lore.kernel.org/lkml/20220225052116.1243150-1-imran.f.khan@oracle.com/
