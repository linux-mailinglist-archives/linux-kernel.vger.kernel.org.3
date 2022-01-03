Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E06482F35
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiACJH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:07:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33324 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232278AbiACJHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:07:25 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2031iAq5018682;
        Mon, 3 Jan 2022 09:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JmT3uO0JeEcz5Opr+oqxgXpnjBVZn7MwqOSQFNXljus=;
 b=HoOIn+ucFXs4pTgMAXq1pWiSqWjnztqmDb9lbBkbh3aoNgXJyabtMP9nQUwcVDH//4DB
 B7W7TL0u1ebVpBqKA86zNRY2V0HGq7fwAiEGW3mlJPTDmDoVhwpEmrMK3dpngYadI0+a
 ZQ4ASQQdLdxav2c8Gkt06+MPCyLfRKlNSn0Qz1MTfitrsgC5yN/uVRY2Ku5ROlwALQWJ
 4EOtXudYMyCLTBODdXqlEkDhaDZlC2F/IwovSdW2XPL6YvEEJJH5KiOsxAqmShIwjVbW
 0cKyQsn2e0DXEpgHOOHbyYCxa3dmn6fWKB5JWkb7P90bvFpYk3xwPs0sKACZV4MoHYpX UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dadr8a89r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 09:07:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20391ASH070454;
        Mon, 3 Jan 2022 09:07:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3020.oracle.com with ESMTP id 3dagdkdxu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 09:07:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gze/S5G71kbq07DaL8PwCnOF2FGtk5CkZBWf8fmY+MM9rsgQadRiGAWYtLzFN9sy7hFvChsGFoz8ZyITthrOfPpFMOMEwHgTBH+hZ31IErhfoHepD/2GfirtYtLK/ITiEUKqKYPfoTaLieU4tDmBnrvpOddrDC7IEmuGD2AROrye1hNDY/s+zyRuBfcvucrJ43BpTfqFaQJDuFJ5yNToz+944ZnRw1oqHxdJaO8a1dqOGYY1hmph2e3QTBkIdS+TcVJ3f/ZL0PitBlDi94bnrVQZN0V9iWLZN0+cuhvNfkAd3ZWtpGF8sLxEMn3Ng7Kwr6MAE3IjEVzPxA/d8yPncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmT3uO0JeEcz5Opr+oqxgXpnjBVZn7MwqOSQFNXljus=;
 b=nwVqx96ZDr0ai94oPFUjd4pUyt2hzAF4HghyIwZlzFPYQ9PYKcNgn+GN/7SgQPye5+5M6A3H0n263peE3CIwRpHMIcZ87IfrsY7Vt3eORyAe8spZ5+hagTm0EenYqRaEZHwqRhw8OC5AwTqRLRiPdN+SKqIsZPvt4ll2ain4Uh9yvV/UBH56KG+u1TDhfAZ5OtlDa5wcnMk464FZ+EH5GulXjQv1WUEWhG7DzF8yLXz64Xb+2u/+wb2bPFBwdl+U7kCZ1M2Hc0Qhz4Fj3b1QgVb1tmc+1QvT89J4TO8RnZFdUk1DaROYDPAjEAmFNEtITRmR3DxXMqvBwlo8ik8BdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmT3uO0JeEcz5Opr+oqxgXpnjBVZn7MwqOSQFNXljus=;
 b=G+KDIpB1zPKFRFqSpDsoyyno2VAdymsrxKIHw7fR/0QgZJJHVOZKrRvjZPWrf5BbYkK4IigoMG4N3BY+aQKFfREhLr7EKg/JBQ0hfhg6se+r6aEIp2+NXW0yugha8Rp9ZuzS8JJ//uhn22V0MovqSSkLGWvs1dmHGPygDZ2pHUA=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1999.namprd10.prod.outlook.com (2603:10b6:300:10a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 09:07:17 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 09:07:17 +0000
Message-ID: <3f340003-2339-85a9-7d3a-51a488dcc720@oracle.com>
Date:   Mon, 3 Jan 2022 20:07:09 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [RFC PATCH] kernfs: use kernfs_node specific mutex and spinlock.
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <20211215150638.390466-1-imran.f.khan@oracle.com>
 <1cbeb70b-6ae5-85fa-8f67-5da17974ed0b@oracle.com>
 <YcWHcZsBGFVDXYTY@kroah.com>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YcWHcZsBGFVDXYTY@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0033.prod.exchangelabs.com (2603:10b6:804:2::43)
 To CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb43c6b4-9aa8-4e6f-17e3-08d9ce9870e5
X-MS-TrafficTypeDiagnostic: MWHPR10MB1999:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1999FF55719CAD5BAF43547AB0499@MWHPR10MB1999.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B80C9e3EI45QfRFIDTegnXMHAEs5oGEIRpp73DGC0mCYzhr8Bb0hvgNymEm+gKXOrLW2XwamJQVOj2G3crWuTs9XdSDbCro18J013CYBDWZUHOqHUlPfuGd2DptKzkxINy40ycnT+kn6cA5sf9uOsP5tY+rX3GSG/aclAh8bGKQcB8Fk1NOdfzXO0dHH5JObPjx6RlhRcoJWCLr6R/L/JGnuv0Bc2OssGDYOJKapH90mIwW5+eribDc0UlgPSfdG5ef0Tuljg1HAVgGRlUNLL647eK/1DxCx/vzOAmw/wbKj6AQ+Xr1GUHIJscnfrMFpUYlGZl8eIta53cyV2ty1DbKtXMxoQZ79OsQmgVO9uNCmLcmtj2X9bZn497zkl8sGgrsgcNYrkDYHP4SDrNwlJzxyO1DbSffQD3/jA6oQWrei8D5IXtfBwsUTrPuzetxv59T6hlQW5RWacuflyjWBswFvaHhs56Fy3rS/NXxgVR12mu6xhPGAX0swBV7kUBwJFI+7r80USEkRhRHdURs8lyGQUsUGG6EXjuAJkjU0zN5EmfwUa8tQUpC0LZhtRR3GT40qnSSSoFe3ZS1VwRcIDrFg213UXsqY/vTWxZd9E1QFbW4sBsvXuHxmswDha+SvrX6wiKMldneaEOcKRMpeiT7KGkqH6s4K5bk4x3HhZ11xBep7EEGZDO9L96NMhmKHDyxz62Fh2JXfmzB52pleVVdzle8uJB4XwL6DQcyh7iFkm097KZtvgG5+HmF7rzmK9jRdW5Dy4uBtb9aeCa3JMgNRTQtghMWG8wLOhHvR4XHKHUzCLE6eTfHRwdbOnJ0ZsI8hqK1qhBdwj5aSvx2lv8U0yoXEf1SUMNQv8k5Mb44=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(31696002)(2906002)(2616005)(5660300002)(6916009)(6486002)(4326008)(86362001)(508600001)(38100700002)(36756003)(66946007)(31686004)(66476007)(66556008)(6666004)(83380400001)(8936002)(6506007)(53546011)(8676002)(966005)(26005)(186003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUdaYUJ0b2dpMURZQUw5ZC8yc21XUUxFblFneFg1UjY4VnhFbG5xREZqZis2?=
 =?utf-8?B?MjhIOXFEOVFrcnFwL0kzTFd1aEJJUWFmSVRJSzdJOWE0WXFncmZhdHg2UWFR?=
 =?utf-8?B?U1dGYWJpVTdXT0xYaHRIV01PMVJBNGpFMTkwaytzNWQ0NEhTZXQvZkZhZ08z?=
 =?utf-8?B?ZEF4cWEzZmpyMHN3S0t2a0FOYS9FYi9IbHAvQVRzeVloQzFEd1FiWkJHRHN5?=
 =?utf-8?B?TDNSRG02d0FqeXQyTnVXU2ZhbTdSOFpZYlFCYjA2djA1MS9TdDBnTGVERzJO?=
 =?utf-8?B?UGlsMVJhc2tjejdaQlhEdUFBTlhVaTVyL1V3citvWmp3N2xnbkEwQUl4REs0?=
 =?utf-8?B?ek5VM3h6U3BWNFE4OTZLSE1HNWdzREFlQjVqaEprNEU1TFhBVmxSNVJrUFBt?=
 =?utf-8?B?dUxXbzRwZCtleTBPdkIwdFpTMndLRGozU0ZqS3lacHRjcGpWRTY4aFEvR1gr?=
 =?utf-8?B?cmlSYUh5Zy96MHpvQ2dURGdqTzhSRFY5NHlCcHgxM3o4Z2h1ZjhHVy93eENz?=
 =?utf-8?B?U2oyN0haS25WNDkvM2YzcTZrcUpVeW9TVUVMNE4wZ0g2SVNBbHhneTlYa2M3?=
 =?utf-8?B?T3l4VFB6b29zalpZWTZtWGs5RitzNXpkdjNpOEZwRUtzaEhBcTJTQURvMVRl?=
 =?utf-8?B?Mjh0b2ZUWERxVEYzbUF0NkhCRGtoNzhpeGl2RCtwRG8xUUlEd0tKNk5TVExv?=
 =?utf-8?B?WC9yV0EwQWUwR2Z6eHREVWV5UGtxVkVkV3hsSUxxWkNkaFJzK0N5OEk5cEtF?=
 =?utf-8?B?VFlXdElxaFp5OW90bExTOW9sQ3N6cWFOWkhNK3B5ako5d093TXdTTE1EbFUy?=
 =?utf-8?B?cFE5Q3NleVRIYkdXY0FFa0hWZnZIQ01CTjdnME56c29KQ0MwVU9JUU15SjEy?=
 =?utf-8?B?WmIrT0liYjNKVW50endJSkV2Q1ZEbTFvWXkvOGUyV0FrR1lBaUR6M0ZTK2E2?=
 =?utf-8?B?cm0yRHlhM1d5T1ZZYXdXc3NOaFEyRWpFZ0NBOW5rZHJjcXR0NXAyY1NaQUdN?=
 =?utf-8?B?VHVHcEpiSlY1S3loZWVZQmVmcjNJUnFJS2VyT3g2enhOODN3Q0FSQ1ozaVB0?=
 =?utf-8?B?Ni9OYU93Q2RNSlA3eUJ4SnRKcFNmeWVXSEJPTGpTTW5nSjhjdUJVN3lJWGRi?=
 =?utf-8?B?bmpSTUYwYUZmbnR5Q3N3N2c0YlQyNGN3V1JpMWgraE1Ba1N3UVhxV0FJL2pK?=
 =?utf-8?B?clkvYVF2ZU0zYVBLZjM2K204OTdqdVRxZUo2bXU4UlNySHFLWDdSQ3B2T0tM?=
 =?utf-8?B?bG95V09ZdG1mYVlUT3RjYlNOenIwaHFZalNFRmtVZm1Vd3JaL0J0cTIyem1U?=
 =?utf-8?B?WDg2UWhPeVUyV0ZaWkxKNXdna1ZhcXVHN28wR09XMUxXbEd2N2ZTcHVkeTBm?=
 =?utf-8?B?MWx5VHhnZFZXY1Zsa2xOQy93bmhNR1Juc1AwWithdk91N25JN0FnNnpVSXJM?=
 =?utf-8?B?N1NHdCtIUEVQQjh2Rkw2SzVHWk5BQy81eGpuOWFzQmppZTl3QmtjWTB1eXJu?=
 =?utf-8?B?TUppMVhrTTlRRkxTaXROS1Q3c1B5Vk0zVjRUNzJzR1I4YVZ4T1gvTVZBMEUz?=
 =?utf-8?B?cUdHdVdEUGhtVVIyQWJDQlpUb1ZKR1JpcjhZa0JqSXhuQy9hRTd3S1R6ZlNM?=
 =?utf-8?B?MFVKT0dTd3gza2x1cE1sRWdjcURDRWVRQzVBQmR2UzdwVWZGeVhnWjYxMERt?=
 =?utf-8?B?TnRpMEp3cGlidTFlQy9qelZtTUgveUNHejRPOWFYU1RaKzNIVWM1V0t1Mkcz?=
 =?utf-8?B?MnB2QmthQS8xV2pwcC9iM21YK1d3ZEVqZU9NbFpvZXNzZFhTamwvLzk1M2lB?=
 =?utf-8?B?eGpBMXNHQzc4YjdqWm9Ib01WNHRHcU84ZGlQRGlPSTREcG9Iekp3WWdqZ3ln?=
 =?utf-8?B?R0M0M1pUWXdPQlNVbWxOTyt1d3k2MTdNamFIYkdnZEo3TmFYUCthK3A5Tkw0?=
 =?utf-8?B?OHhzdlNoNTdLTHdTR2I3cDFqaGY3K2U1RCtpRUgvNzcwN0JiRUtmMEdvTkh0?=
 =?utf-8?B?V0lJS2srK3hJZjQxeTAwYXYyY1BCS1I2bmVNVGIwNVBFTTFSc1BTdTJaVFI1?=
 =?utf-8?B?eTdWSWMwcVRQWTI3RCtUWDRQdXNPRWxrK09ZbVhMWTdUdTNzNy9xVDBkRlV6?=
 =?utf-8?B?YXV3RXB6bS9vZFdxK2Y3a3pRdE5vZk13TFdETHRqVC92cHZBMWRZcXdZQ0NI?=
 =?utf-8?Q?SNhXVhbRIGC3aK0mZm/9r7k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb43c6b4-9aa8-4e6f-17e3-08d9ce9870e5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 09:07:17.5142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKtQksHNECCupJ2yeOZ01fMWHkeU4t0BHglTTRECOoiXj0ySFMihnKUEx8KEic/tGRlRUF4kb0oEe35Kmd78Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1999
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10215 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030061
X-Proofpoint-ORIG-GUID: cuBVhJEvFqjn83jvbgDGzYyInRbpb9dK
X-Proofpoint-GUID: cuBVhJEvFqjn83jvbgDGzYyInRbpb9dK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 24/12/21 7:40 pm, Greg KH wrote:
> On Fri, Dec 24, 2021 at 09:52:51AM +1100, Imran Khan wrote:
>> Hi everyone,
>>
>> On 16/12/21 2:06 am, Imran Khan wrote:
>>> Right now a global mutex (kernfs_open_file_mutex) protects list of
>>> kernfs_open_file instances corresponding to a sysfs attribute, so even
>>> if different tasks are opening or closing different sysfs files they
>>> can contend on osq_lock of this mutex. The contention is more apparent
>>> in large scale systems with few hundred CPUs where most of the CPUs have
>>> running tasks that are opening, accessing or closing sysfs files at any
>>> point of time. Since each list of kernfs_open_file belongs to a
>>> kernfs_open_node instance which in turn corresponds to one kernfs_node,
>>> move global kernfs_open_file_mutex within kernfs_node so that it does
>>> not block access to kernfs_open_file lists corresponding to other
>>> kernfs_node.
>>>
>>> Also since kernfs_node->attr.open points to kernfs_open_node instance
>>> corresponding to the kernfs_node, we can use a kernfs_node specific
>>> spinlock in place of current global spinlock i.e kernfs_open_node_lock.
>>> So make this spinlock local to kernfs_node instance as well.
>>>
>>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
>>> ---
>>> I have kept this patch as RFC, as I am not sure if I have overlooked any
>>> scenario(s) where these global locks are needed.
>>>
>>
>> Could someone please provide some feedback about this change? Also if
>> there is any issues in this change, can I make these locks per-fs as has
>> been done in [1].
>>
>> [1] https://urldefense.com/v3/__https://lore.kernel.org/lkml/YZvV0ESA*zHHqHBU@google.com/__;Kw!!ACWV5N9M2RV99hQ!ZNLlzuX1cVFEAE5Ila2y8AzhvA3xI4HG4q13ZdcaQN__JaPLy6yuzdV0lypeVEIOHA$ 
> 
> Please test this using some tests to verify that sysfs is still working
> properly and that this actually takes less time overall.  In the
> conversations about the last time kernfs was changed, there were lots of
> discussions about proving that it actually mattered.
> 

Thanks for getting back on this.

Yes sysfs and cgroup are working with this change.

I verified the change:

1. Using LTP sysfs tests
2. Doing CPU hotplugging and reading CPU topology info from sysfs in
parallel. I was getting correct topology information or "No such file or
directory error"

If you could suggest me some further tests, I can test with those as well.

As far as overall time taken was concerned, I did not see any
improvement with my test application (I am running 200 instances of it
on a system with 384 CPUs).
The main loop of this application is as follows (One can use any other
sysfs hierarchy as well):


for (int loop = 0; loop <100 ; loop++)
{
  for (int port_num = 1; port_num < 2; port_num++)
  {
    for (int gid_index = 0; gid_index < 254; gid_index++ )
    {
      char ret_buf[64], ret_buf_lo[64];
      char gid_file_path[1024];
      int      ret_len, ret_fd;
      ssize_t  ret_rd;
      unsigned int  i, saved_errno;

      memset(ret_buf, 0, sizeof(ret_buf));
      memset(gid_file_path, 0, sizeof(gid_file_path));

      ret_len = snprintf(gid_file_path, sizeof(gid_file_path),
                         "/sys/class/infiniband/%s/ports/%d/gids/%d",
                         dev_name, port_num, gid_index);

      ret_fd = open(gid_file_path, O_RDONLY | O_CLOEXEC);
      if (ret_fd < 0)
      {
        printf("Failed to open %s\n", gid_file_path);
        continue;
      }

      /* Read the GID */
      ret_rd = read(ret_fd, ret_buf, 40);

      if (ret_rd == -1)
      {
        printf("Failed to read from file %s, errno: %u\n",
                gid_file_path, saved_errno);

        continue;
      }
      close(ret_fd);
    }
  }
}

The patch just moved the contention from osq_lock (corresponding to
kernfs_open_file_mutex) to read-write semaphore (kernfs_rwsem). I have
tried to address the kernfs_rwsem contention in v2 of this patch set at [1].

v2 of the patch set, reduces the test execution time to half (From ~36
secs to ~18 secs)
and contention around kernfs_rwsem lock is reduced to 1/3rd of earlier case.

8.61%     8.55%  showgids   [kernel.kallsyms]          [k] down_read
7.80%     7.75%  showgids [kernel.kallsyms]            [k] up_read

I will await feedback regarding v2 of this patchset.

[1]
https://lore.kernel.org/lkml/20220103084544.1109829-1-imran.f.khan@oracle.com/

> thanks,
> 
> greg k-h
