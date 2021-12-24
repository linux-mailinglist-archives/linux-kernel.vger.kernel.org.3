Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA97047EEB9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 13:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352640AbhLXMHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 07:07:43 -0500
Received: from mail-eopbgr80139.outbound.protection.outlook.com ([40.107.8.139]:4839
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352634AbhLXMHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 07:07:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEij943gKmUQersdJfXKrHP2ooDSeEWEu2yd2zEZIfws1+M8Tg7VyFE73uEa7fY+mwfFGkBY2mGta4XGMn6a0C0nykbJFV5wjk2eWYv85vd3SC3HZ6RNS514y2chxvM/+nMoHgGCP/DTW+OaQIfJ4XcfhBxsn4tTpDshknFT+2pWydDQTIujrhKQNCulPubULHP0zWCMhRLfPgEq90yZ/N2wlsvCGq6uEgZb3bfAx4GVkS8dwd62UprhvUlB/Jk2YNcGuzPmUrB6augd6S01IWCrQu7XaOGxysyUfBVY13ItpLus2v0gttqM9j11g5iG+b3zKJQ0V021g0JZmHlRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8ND9Ar2p/yMPpUqsJSo69jwrQwrI+U/D5QKYPEsHaI=;
 b=aHHhqSfzan7ni8wUczhhwwurUvvPLE9+enz5UJNlGyPSgCrCx7HRmrHcaLhWeDOFVfrYmBvyvx7+kYLbc46fYj1tcGb9c94+sHJoRKLS1sRbPnHulkpxxrdI0KeFfTml9BUI3wD6N8oYHQckfFK44O13JHP91g/Q2I6R43deqdr4FPun6ca4ZRs63/yI+ovm0/5U5KM1lVHxTM8/2gZ82EVnVlxu2Dze0tkv4Wa7cLAzCDTgmbwzbANxx4CHjAotJ01N2tbL2KNTcl2qgXzIf9/n0y+oe7ejLt2Z2zVTeCpieyQFqdp7TNAbNA9AtTqkQwj09po/iGhH/rNl8apUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8ND9Ar2p/yMPpUqsJSo69jwrQwrI+U/D5QKYPEsHaI=;
 b=PpKhBRvBQqUEvGzCwI1/ViTgDGfAVDCDq1lUtsOvlzYS6P0hGF2zotEvSHUt7U1nCJzZ4hvAncb6YBrsURqUqNie1BxlEoGFDrYMkNjBMIDJ4zbnqOBxA3GtP0hakbipBm1LH8GvkgaPt5pCchCTcSsgNQyjRunrv2rYjGlk+m0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by AM0PR08MB3233.eurprd08.prod.outlook.com (2603:10a6:208:60::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 12:07:39 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%5]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 12:07:39 +0000
Subject: Re: [PATCH] v9fs: handle async processing of F_SETLK with FL_SLEEP
 flag
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>, kernel@openvz.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>
References: <076a9ce6-ae06-5b3e-f577-d993e55089f1@virtuozzo.com>
 <YcUCvUF10TKg2wDI@codewreck.org>
 <644227dc-4771-3111-aabd-20ac12b69a2d@virtuozzo.com>
 <YcV3XDFw5sMyvTVL@codewreck.org>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <a979a5bc-f2bc-7035-beed-6a3919471d39@virtuozzo.com>
Date:   Fri, 24 Dec 2021 15:07:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YcV3XDFw5sMyvTVL@codewreck.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0101CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::48) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 251a98fd-c4a2-4a65-a309-08d9c6d5fafd
X-MS-TrafficTypeDiagnostic: AM0PR08MB3233:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB323325664F40FEFF8896BAACAA7F9@AM0PR08MB3233.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QA/dqFEChhAb+bomK0VEY4ZzcMnopb5YJkyfYevidVi5q90orxGfDNRRXv3pk8nIILccj8xjpBlF23fzwxrIE1jWc919+cqt0Mgn4vXhiG4JaypSXzyJ9bk1biBOuB/paX2OU2KjHGRjPYwBnEobHnf4EfBDM09QFoG/8uagB6mmTVfZkjJ7SpYCqhoagugcEpslThh7zF0BmJ/OsJcI38K3CU0L865eGXWp64g8ZuT2PqVO6Irmu+evU1UxV3XmHyvwAeM6eqI21Kj+kQ1h9KXHitHDmIvFYoTH1mHZay9e/K8JZDbA0JV+hL9TFF6rqUlCiMTRjQ5AM5Wu3uP42zIgAl37/I8SKhNxmJppF1xtR5uk/d/5Z1vdejqRetmV1oPOKG1BhYbvncjKG3Ax3hG2XNPKZwx8LSs7pWXz4Sz2Yg8p0aQmIfxe5gBYB1Okxb9udhVI0RW1Xjdsy9ONk7vRppBETPsiOPFgeZTg0N8w7KRMkeRdjV3FOQ6ARutVKJRinswIYF4x9aUluQTmV56BHpjIMIPF5vNuNAF82jYHgFHGmPNQMMymXROTn7zRoprzT4Piw4eWvIduvH8xnRht26QXHanjCdl/LeYQIY8FQJmsCSq72F2Y3PMe2Owrph2jKdrHIWC9kSkGY03QH8QXk8MC/BpI1CsNVwgYWIpWzbogALTTDIRPhXYBZyGe0zN4lghbJ5dXJBiJNpVgYewrU3F/7czmz1hnNSMLFepoZkwjCO/wk5TyoXIVUv7nvSNO6x/wRTJE5+7QG+OSWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(6506007)(66946007)(66476007)(66556008)(54906003)(186003)(26005)(2616005)(53546011)(31686004)(31696002)(38350700002)(86362001)(38100700002)(8936002)(52116002)(4326008)(508600001)(316002)(2906002)(8676002)(83380400001)(5660300002)(36756003)(6486002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnhOWFErUk01OXpRSCtKb2NWS1R0cHB0VXErYk1WWjJERkpWbDBDZ0l3THA5?=
 =?utf-8?B?d2F2WklRMXhkZHhyR3VZOEJGVlR3VW1rdEtxWnA0L0hDRks2emVEK3BEUmhj?=
 =?utf-8?B?enQxVi92cXRtMWNiT2VPSVhzcXJUdFFpVGR1TXdFN0R5R1JVSTBzNk9GUFRF?=
 =?utf-8?B?RnIxZW1UK043WWtUbjRQbjJsR3JhUVMzVFhWWU40d290cVlKb3V1clJHeTB6?=
 =?utf-8?B?YUlJMHl5RzJtYlNQcjZUMXpGSXJwaUFkeEV1R3N2RWMyc2lSS2pTVzVYYU0x?=
 =?utf-8?B?Q1h0aHVqSktXNVBPa2tQUUtnMkVUaW9LZk5ENlJrYURvcHpCdGZqNmFOaW50?=
 =?utf-8?B?MVc0eXFtVWttdWhRS3RNL1owZFpjdHlFMFIrbzNwUldLcTQ1TjJDZ0ZORTNm?=
 =?utf-8?B?eVBxUW5oT3NwMjk0aXI1Rmx6anhiUjZZK3Z0NUpRWkZyUVZoZjljZWlTd3pj?=
 =?utf-8?B?b3dCcUNtYmhCNVlvankxSGdYTUJVMmdENW5LN2FVUW5OeG5YZGp3NFY3bjZy?=
 =?utf-8?B?TlkzclhHeWNGem5TcEpRWXV0K0ppeDJCa21GRFpVcHlYa01iVzl3SmNPUWZV?=
 =?utf-8?B?aSt5NjI0V1g3RUtMYVg1UUV4eXg0aFRZRDhoSi95bGpZeG0zeG5KMXJZWVlq?=
 =?utf-8?B?OGwzVklrVXR1U2V5TGRxa0lUdE5rVmVuQmErZjJSanN1S3dFS1ZNaGxOY1M2?=
 =?utf-8?B?cmxsalVQNXN5OGh2NjhvbkFkL0s0RkN5c2lFWUJzZW1aSXJiTHI0YW1ldXox?=
 =?utf-8?B?ZmNFTTVGYzd3YWVRT2dRU0VDaHIwN1RsSVVtNkYvNDlQY0dwakxIdlNjWGpu?=
 =?utf-8?B?UHFkUVNlWmNTRVFHUklBbWtTUjlPc2VabWNGVXhOaUZ3cjN0cTh0WUdjWmFD?=
 =?utf-8?B?c2h3a2lHVXV6MVNGV05XRERobERmaGZWdjRpRFNGNkt0NThReXc4NjhJN2w0?=
 =?utf-8?B?R1p6UWZPUkRsMXpicUhIY01semthMW1yL1Y1a1FydU1YU2RjTTRUYzVyZDBE?=
 =?utf-8?B?aFZNdC8rL0E2Q0JhcjBLL2EvTGhON24weE9QYUhmc0NUR0s1b1NwRUViaEhC?=
 =?utf-8?B?YVpsSk5jZ2ZMeVhHdG5rQUFkOHVPcVhmSkF6U0g0Rk9wVVhMMzFXeUNhNHp3?=
 =?utf-8?B?VmE2UFpFRjYvejVwaGEwZ3Q2OEE3aUpkRGZHYWtpNFdYa09nS3JEUG0veWVo?=
 =?utf-8?B?WHlWeDlSMzZTK25MWFduUzAvQUR5cHFKei9wU2hPc3NYb0VqdFNjb2xoZUJ4?=
 =?utf-8?B?TEd2UVo0TTZINkJLSmVmSldGbDh0N1JkMFNQUHBoNzJkREp5UlZ6aVJGZHht?=
 =?utf-8?B?Q3pYdk5pdFE0ZE1Wb3hqWSthODJ5bytWdUhrRURzYmVzNDdBeFBkeUUrT3FC?=
 =?utf-8?B?NXROZkIxTGpCQVNnd05HbnhNYnRPU2cvczNJWXVQbzlIclgwS2tZbUNQNVVv?=
 =?utf-8?B?dEVqdWN1Q1FoT2NRbFpEQWpjWW0yMjZtUXZnczlhY2ZEc0VJRGlCVzN1c3Vp?=
 =?utf-8?B?ajNIQ01PSlBDQWhheWR0Lzk0TkxZVTVrd0cvWkxBM21BSU1LRmFTblN0TWgv?=
 =?utf-8?B?bTF1ZTJUUmxBVkIrL095VkduZTJIa3FSTllDQVAwN3ZYUHVKbUJsVnlkNXZY?=
 =?utf-8?B?ak0zLzJ2d1FKT1RrQVRua0pha0RQZHgwZi9uQ3VieVQyVzFEQnlncmdsN1d0?=
 =?utf-8?B?dHYvSGpMMGE4cmZXMTJXMnhqZWN5Q0dHenNDVHUyeFJ1VTJDeDFkQ2xxZy9J?=
 =?utf-8?B?c3dXcitZTklqWUVvS0IwSkx0Wlowd2JDak1iNk1NVStRT0luL2lBZzI3RUxL?=
 =?utf-8?B?VHYybW9WTk1jYnNrQzU4RDNkVXJidU5QNXMvVzVkRFVGVnh2a2hTNDRFb1Ey?=
 =?utf-8?B?QWpXdVd6RUJURDhBTzlJd1FGUG45c0Jhejc5REZ0NXlxeGNtNlR2bDkxNXJ2?=
 =?utf-8?B?TUxONjFEK1F6eUpNUlVHZ1h2M2VpaUFkVkI4UFp2UWI1VXdiMmRDVTUyeVRQ?=
 =?utf-8?B?Z1NqbEdKcS9BS0dDemR2Y3NCTTRQeDVwaHlRczNWVkNlbEY0ZlhIcUhsd0NW?=
 =?utf-8?B?WHhONzVpdGpkM1puSTk0ZVI1NGpDZzNZYjd0MS9EcWVybmxtbGZkTFBPWFJI?=
 =?utf-8?B?RmFvdWRST0lvTXZYZGF2VjkvVGQ1b0p4ZnJ1dk42UEZPNksvOHZsR1NXTEtq?=
 =?utf-8?Q?t5tTFgEDVtrTs/dX66zLm2w=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251a98fd-c4a2-4a65-a309-08d9c6d5fafd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 12:07:39.1520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3R6+juAcw6EPi1LrleOyB1bjGY7YWpH9h5JkU3kw7bRdkra1ncS7ZP1pS7HAOLtLT+FQhzBYyrqj93fLPspQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3233
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.12.2021 10:31, Dominique Martinet wrote:
> If that process is made asynchronous, we need a way to run more
> 9p-specific code in that one's lm_grant callback, so we can proceed onto
> the second step which is...
> 
>  - send the lock request to the 9p server and wait for its reply
> (note that the current code is always synchronous here: even if you
> request SETLK without the SLEEP flag you can be made to wait here.
> I have work in the closest to make some requests asynchronous, so
> locking could be made asynchronous when that lands, but my code
> introduced a race somewhere I haven't had the time to fix so this
> improvement will come later)
> 
> What would you suggest with that?

It isn't necessary to make  request asynchronous,
it's enough to avoid blocking locks.
As far as  I understand blocking does not happen for SETLK command,
so it should be enough to chenge first part and call non-blocking 
posix_file_lock() instead of blocking locks_lock_file_wait().

It would be great to make processing of 2nd part asynchronous too,
but I think it looks like over-engineering, because we even are not
100% sure that someone really uses this functionality.

Thank you,
	Vasily Averin
