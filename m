Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8143548BCC6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348076AbiALB7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:59:00 -0500
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:11060 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346397AbiALB67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:58:59 -0500
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20C1uJcg003979;
        Tue, 11 Jan 2022 17:58:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=p515RT8lBU1ZtgPSLoySBis4MY1uCL1QkUn/9DNAaDE=;
 b=TdF025hmGcgXdwbz0FLQZ/ROoBWbikcX79gCVA1eFA+ag4wYbr+Sn/wsDlLyL4IUHZ2l
 oVl1FXVpWNM0BZPuUpHLaTlkMNHz0ggmnDVtxQsw3HT5NUI1h637sHXvdT9oAlLo1nFi
 i4v1Sbn3DMQPLFmyusAENv9oQXDIw1hWrB22EmvOyS6ZC98D/j9oOW4CjQqs3W24+Q9s
 x5MYcDHCMP0DMbb3ScHt/t+UZAjDsHfobBUOp+KPy9fkyHQfAzaVhY2essNxO1bbzioD
 nN6K1hdrLP2U9Qtp8uoWcQYChLnQxBNXp97amGqE/aSfM04qzkkB5H9MOV+bnhK9Oht2 eg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dggv39f5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 17:58:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoDkXuFKq9Lb+hLjuMRmJ4qGP+N9P+EE1gRHh23GYVY02o97hxn14ifI/C8WiRj91zl+SYHjABF0PS8K8Ey12NwSJEVWDgadVXcDp0xk6+zyEmst9+mbjy6WZlezjWGdmlNgKdGfAT/R36Sb7qUX5Z6q19HLbaKeiULEjlmleNXwpMQKWMk+Azx1Rk88fbUUbSEOZIKRLM6lCpw+lvYsn5XmowFsp6YfDIM/8k2+aUViDezqiflMdUuPCwGv/zoUky7OYXKigVkqtfZq2roYD2Sw1n/yrtt52mqahd5F0wU5Oqurow2sRzXswQ6dvA53WLkJ/OYSVoZmyWHyZwdNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p515RT8lBU1ZtgPSLoySBis4MY1uCL1QkUn/9DNAaDE=;
 b=YGUJBL46SVVjrSnj4kJ5x7GbubTVPeBDL7vW7Coxxr8QWdztw0UF1r7i1bISU67quNKXnIgya6r/8gpctXMsct161+S6q1HWnqzwZ/iT/c9hmUco+byqNICpUnW6sTh9wdVYUFHSn2gxkDaYzlRTAXfytBBc5c6lybXCchTjI8ZeeTaSarVEt625VCU4zLLlrC7F9lNS06vrfvX0tUO4SPHWb2q3KjZVuLLEQTv/R70WMT5GO16asaZ5MWF1HEKw84R19773KMhV5Qgl71ozRYUFlS0lH7CrCmRApJzdaEQLTtTS8dwyDIHpQUZiu+16xOhWDuBc8VNGIHr6l8+xEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16)
 by MN2PR11MB3647.namprd11.prod.outlook.com (2603:10b6:208:ec::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 12 Jan
 2022 01:58:51 +0000
Received: from CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::dd33:eca5:868e:f800]) by CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::dd33:eca5:868e:f800%7]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 01:58:51 +0000
Subject: Re: [PATCH] platform/x86: ISST: do not hold lock punit_misc_dev_lock
 when register misc
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        MarkGross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220111103122.32362-1-liwei.song@windriver.com>
 <9e5fd9f2-dda7-73ef-00a8-203da3827e9d@redhat.com>
 <8809e11c-191e-036a-9066-90cc316f83b9@windriver.com>
 <49026b58c92f418e6def0ef1bba609bdaecd368c.camel@linux.intel.com>
From:   Liwei Song <liwei.song@windriver.com>
Message-ID: <d7a28f2c-116d-9360-41b2-7bdeed013d46@windriver.com>
Date:   Wed, 12 Jan 2022 09:58:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <49026b58c92f418e6def0ef1bba609bdaecd368c.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2P15301CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::31) To CH0PR11MB5348.namprd11.prod.outlook.com
 (2603:10b6:610:bb::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e321ef2-756d-4ea1-8755-08d9d56f1477
X-MS-TrafficTypeDiagnostic: MN2PR11MB3647:EE_
X-Microsoft-Antispam-PRVS: <MN2PR11MB3647D48F0F3432951C0A544E9E529@MN2PR11MB3647.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivTMRROEgBBn5cniHUbR2UwBVoEYWqIk/uR/MOKVoQnbUwjZl0KLBp5lPoitgfMg/gIseXqvNmk+eW9d2QwqmgEpWsYqhVVeNtoz9zZH1YxBATzaVdVugpuRPwGvRe2L/3fPFMAN/yvGrLZLr2WnUcXTu3Nu58h/w1ayBuJtwb+NxITyrUbfKxaUNHCny0Svy6beZW6EIu4J0rNUsXPcx4fuzjxCL6LfA/gbRth+ceZeCsWp006ve7qdWspTd7VjtX5SC182R5qXRACoS3n++hNKV8B/XJSGP3HVMvYEmKyRJAlxPl8Jqe3hI6R1CpCpiYio+yVbaB0yO0F5JWH3nbLe0JuYbOKaklo0dWAlkJhpmgqFzJe6lQBdKtWkt9MHUESjOn8MRs+JiiJZ/TWZNt8E3IvFeEoRcwAWEa3eIPg6vT4+CicCWEaIZj0MqNNswChRdsjDTzuYaU5uzoE0uiy2c6xaVi92OVD57fmyQtXVDaGRsHu5RdtsAOqA05JWSkJaOBQBR9TB1GQFvh4EouVr8QcGDMbbWo1pYUEIYUOzOhU1CynBcD22zXYnzRc5+QdjbCxbxY62YFZ9xIA31Lm0XXtZuePLGfGrcPGobNnNa2XhQtNNB0TO/esrX/915yFNdh832Q5Xg6nen9rV17Xxo6XPNOc99ApfCOJqDp6r56cyFVDwwMwVPcJDhl0M58ncHjRYmap/GV0fNe+Zqz6nmM94HBIX9efJpnX3BQN74uWzye/C28EdVQpQHvAT/jQdaElTUW2MR0o2fFLwUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5348.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6512007)(2616005)(4326008)(36756003)(31686004)(83380400001)(6666004)(8676002)(53546011)(26005)(6506007)(38100700002)(38350700002)(6486002)(31696002)(66946007)(66476007)(2906002)(66556008)(86362001)(44832011)(8936002)(110136005)(186003)(508600001)(316002)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R01YazM2OXlmOWc1RG9yQkJsNUxMdGlVR0pJOGgvTG1PM0V1Sjd0NUpxVlRv?=
 =?utf-8?B?c2Z4VGhzSERId0o0WEs3THozQ1RVdkg5L3NYdUlqekNyU2YwbG4rWmV1MDFh?=
 =?utf-8?B?SHZucWc2SWxMM1NxZjdXa09wNGJyV0prTER0bVllVml1L3M3VEtZK2ZWYW9E?=
 =?utf-8?B?V3RLL0R3UUFmcUhSTURpMkNXQnFiS0s3TE5NNCs2bDZWdlM2VXh3N3dnWUJY?=
 =?utf-8?B?NHoxeVM0bk96ZDhoL1FucjZSU3VEYnZaUkx6OURKUTZPQ2V6TlM5RWlzRjVw?=
 =?utf-8?B?L0lrdXNHT1EvVFFFQldMTkRuSXJ0a24xYmptZVljTlF1cDZadVZpUnBFQnA3?=
 =?utf-8?B?VkJndFlwMUp1V1V5ck5JZWFCNUhRbVhjMks3bEpXeVc3ZTkvdG9ySVN6UUsr?=
 =?utf-8?B?VU1RaHlVL1lnT1lrZ1dxamMwbHZ0NFRlWVRUVEsxMythMVBFalRUWU5zMFNy?=
 =?utf-8?B?YTd6WFppTkwwYndmZUZDZGJuak1jS0hrbkpBSWwvMGhickIyaUdzbE9Wc1Y0?=
 =?utf-8?B?OFpGSmw3VFBObEhCck5odlhOdVRmU2RjSVdJLzhkRnA0Z1oyd210emZwc083?=
 =?utf-8?B?dDArRUF1ajE1TytxVFFSUVJacnUyNitNMWkrU212S2ZvM1FBdWNwYUZYdkFa?=
 =?utf-8?B?QnozUVI2VnEwRUFMVU9sOUkvS1d6aUF5REFXbExDd2g3WEZoL0psaEZSWURG?=
 =?utf-8?B?SXV0WWI1VzBhdjgwRkdaaERsNWlBdDNWeWRNbkUvdU43MXVSTXFxU1ZTcVNw?=
 =?utf-8?B?UHFOa0VoenVHdU44d0xOVXliMnh4c1Z6Y2FjRjRkSmg0Y0FSZU5jNUdSeWI1?=
 =?utf-8?B?K0JhVGFBMGlVakVManlVNEI3Qzh1ZkY5bnZXaGliU2s0dnVvK0RBQ2JJZGF0?=
 =?utf-8?B?YkdueW1nUjB3bFJLcFNmSk9SNGV3bFBOKyt2ME84WHdvNU8rWmdmRUpQcHB1?=
 =?utf-8?B?L1p0bmdkYzhXV3prRXNJWUk2ZFpacHJrbEt4S0tmaGdNRjJjU1BTUVV4RDNV?=
 =?utf-8?B?NEVKUS80elZZSVVleTYrY00zQml5TVRNTHlLSzVoUGtuSGF1ZnVNcE0xa3lk?=
 =?utf-8?B?UlB4Sy9QTldNeFZnaEt0VmVkRy9TTmVlUTJ4bm02QkpnWm40TGlEZk5Ld0FU?=
 =?utf-8?B?akxFblRLSkVaSi9rQTB3aUdMclNZaitLVW56UXN0bGpKeVJFZjcvanNCUG9Z?=
 =?utf-8?B?SFZhSk0yMmFwNHB4bUZCWGxYci91elZ2Y0ZPQlRMZGllQkZXS04vcUg0bzZh?=
 =?utf-8?B?ZnJjL2pwSWZWUWMyajIzUzAwMEwwK2RvM0xjcE9OQlJPbFhWNFg1NisxdU02?=
 =?utf-8?B?NE5FWlU1SUllMkh2OEdZL1NIRkxzL2p6cnpiMWhOZWI4SUE2eEFNKzZWZ3Rm?=
 =?utf-8?B?YkxxSXkvcUtKSUgrZTNDSy9XdjR3V2Z1ZnFXSGp2RFFrRmNLditXTmlyb1Jr?=
 =?utf-8?B?cWZXNXNMQzNRY0xVSjhGaDBnWERTZzBpNFM1UjAvT1Q3cXdOdzdaSDZOM1lY?=
 =?utf-8?B?ald0WFdQODJENHBaKzYwRHNhWm9XTU9sTGM3QUVmMU1Kem5JSksrZEpOMHJ0?=
 =?utf-8?B?dmREVVltTzg5WnZrSWtOeTZMOVp5RGJSTnZhNjQ0dWRuYTFNQ0xtSGExVjk4?=
 =?utf-8?B?VmdBUFZXYUY4ZUx2RW9IWjErREY2Z2NtT1p3eFpDTnUxNUk1YVRadnYvUTBY?=
 =?utf-8?B?NmkwQVBmK3R6RnhmaG5zNlk2UzZCSytHRGJPM3J0M3VxTlVHZXMzR1E2K2dM?=
 =?utf-8?B?eGVlOWdTODl0TVBOMnlBbzBENXgrNDZqUFRTd1pJTkVDcGltSXlQUmlZamQx?=
 =?utf-8?B?eFBPclVoUUlBbWo4bVZTRmdXSzgza3NqTktldTN1WDhKcElYZXcwS0tocE9H?=
 =?utf-8?B?VWthZjZWcjEzYnhwM0dOcGpzUkZORXkyb3Q3TkdZQUVkVzhDVnh4UWV1TGls?=
 =?utf-8?B?Y2RVMXBSYWx6ZS9hWXNQRXBRMEp4MzZ6THFIU1ZVWEJGZzF4UGwzWTZuUVBI?=
 =?utf-8?B?RVllbWVuNGpNVUJFZ0V5WWlVck50WlRSMFBIM0sxamZScVhodEhha1lJQmNP?=
 =?utf-8?B?d1VxS0t3aTZ1WlZSdVJNMDBTZHNoc2huVEphcWtXalF1ZjBSWWlHeEpFTEhz?=
 =?utf-8?B?SkZZVlJkU29UYWJtSzZERkJGZ0VFdmM3eVB0cDUvcUFmNHUvQzREb0szVG1G?=
 =?utf-8?B?Vkp5TmJyVlNMUHNrRE52U3JjK3hIZ2hEWUo4RjB0VjdqZUpqUXNHVG9mVHpJ?=
 =?utf-8?B?MmRydGhDemlFcE1YTkVBdFhtL3pBPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e321ef2-756d-4ea1-8755-08d9d56f1477
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5348.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 01:58:51.3911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAZAzZCcyGkdiQi5YlS9qLRlf2OrauQh8szBN36eyZOfyD3Pl9/i+W8ojD89p3SG04/LesK2N7VuCwGLrlJQ/8fMmqRN3SNNILx40iGCkgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3647
X-Proofpoint-ORIG-GUID: CAen9eHwZPrjJ8sc-mFtDUPzOZuWOW0s
X-Proofpoint-GUID: CAen9eHwZPrjJ8sc-mFtDUPzOZuWOW0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_13,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201120007
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/22 00:38, Srinivas Pandruvada wrote:
> Hi Song,
> On Tue, 2022-01-11 at 19:57 +0800, Liwei Song wrote:
>>
>> On 1/11/22 18:39, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 1/11/22 11:31, Liwei Song wrote:
>>>> exist the below call sequences may cause deadlock:
>>>>
>>>> isst_if_probe()
>>>>    --> isst_if_cdev_register()
>>>>       --> mutex_lock(&punit_misc_dev_lock)
>>>>    --> misc_register()
>>>>       --> mutex_lock(&misc_mtx)
>>>>
>>>> misc_open()
>>>>    --> mutex_lock(&misc_mtx)
>>>>    --> isst_if_open()
>>>>       --> mutex_lock(&punit_misc_dev_lock)
>>>>
>>>> to fix this do not hold punit_misc_dev_lock when call
>>>> misc_register
>>>> since it has misc_mtx lock for sync.
>>>
>>> I agree that the punit_misc_dev_lock should not be hold during
>>> (un)registration, but this fix looks wrong with unlocking +
>>> relocking it.
>>>
>>> Normally things like this are done by setting up everything which
>>> needs
>>> to be setup before calling misc_register() and in that case the
>>> setup code does not need to lock the punit_misc_dev_lock at all
>>> since
>>> none of the misc_dev callbacks can be called before everything is
>>> setup (and the same in reverse for unregister, unregister the misc-
>>> dev
>>> before doing any teardown, then there is no need for the lock).
>>>
>>> Note the above assumes that the punit_misc_dev_lock is only used
>>> from misc-dev callbacks based on its name, I did not check this is
>>> true.
>>
>> Hi Hans,
>>
>> Thanks for your input, in my case there are two devices on my board
>> will trigger the probe routine(isst_if_probe and isst_if_mbox_probe),
>> both of them will call misc_register(), punit_misc_dev_lock is also
>> used by the probe.
> To check how to get to that scenario:
> I guess you have some application which opens isst device during system
> startup, correct?

Hi Srinivas,

I got this issue by run "intel-speed-select perf-profile get-lock-status"
after the system boot up.

Thanks,
Liwei.


> 
> Thanks,
> Srinivas
> 
>>
>> Thanks,
>> Liwei.
>>
>>
>>> Srinivas, can you take a look please ? And see if you can come up
>>> with a better fix ?
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>>
>>>
>>>> [  256.104522]
>>>> ======================================================
>>>> [  256.113783] WARNING: possible circular locking dependency
>>>> detected
>>>> [  256.120093] 5.16.0-rc6-yocto-standard+ #99 Not tainted
>>>> [  256.125362] --------------------------------------------------
>>>> ----
>>>> [  256.131673] intel-speed-sel/844 is trying to acquire lock:
>>>> [  256.137290] ffffffffc036f0d0 (punit_misc_dev_lock){+.+.}-
>>>> {3:3}, at: isst_if_open+0x18/0x90 [isst_if_common]
>>>> [  256.147171]
>>>> [  256.147171] but task is already holding lock:
>>>> [  256.153135] ffffffff8ee7cb50 (misc_mtx){+.+.}-{3:3}, at:
>>>> misc_open+0x2a/0x170
>>>> [  256.160407]
>>>> [  256.160407] which lock already depends on the new lock.
>>>> [  256.160407]
>>>> [  256.168712]
>>>> [  256.168712] the existing dependency chain (in reverse order)
>>>> is:
>>>> [  256.176327]
>>>> [  256.176327] -> #1 (misc_mtx){+.+.}-{3:3}:
>>>> [  256.181946]        lock_acquire+0x1e6/0x330
>>>> [  256.186265]        __mutex_lock+0x9b/0x9b0
>>>> [  256.190497]        mutex_lock_nested+0x1b/0x20
>>>> [  256.195075]        misc_register+0x32/0x1a0
>>>> [  256.199390]        isst_if_cdev_register+0x65/0x180
>>>> [isst_if_common]
>>>> [  256.205878]        isst_if_probe+0x144/0x16e [isst_if_mmio]
>>>> [  256.209991] hrtimer: interrupt took 10370 ns
>>>> [  256.211582]        local_pci_probe+0x47/0xa0
>>>> [  256.220384]        work_for_cpu_fn+0x17/0x30
>>>> [  256.224790]        process_one_work+0x26a/0x650
>>>> [  256.229456]        worker_thread+0x1dd/0x3b0
>>>> [  256.233861]        kthread+0x191/0x1c0
>>>> [  256.237745]        ret_from_fork+0x1f/0x30
>>>> [  256.241976]
>>>> [  256.241976] -> #0 (punit_misc_dev_lock){+.+.}-{3:3}:
>>>> [  256.248552]        validate_chain+0xbc6/0x1750
>>>> [  256.253131]        __lock_acquire+0x88c/0xc10
>>>> [  256.257618]        lock_acquire+0x1e6/0x330
>>>> [  256.261933]        __mutex_lock+0x9b/0x9b0
>>>> [  256.266165]        mutex_lock_nested+0x1b/0x20
>>>> [  256.270739]        isst_if_open+0x18/0x90 [isst_if_common]
>>>> [  256.276356]        misc_open+0x100/0x170
>>>> [  256.280409]        chrdev_open+0xa5/0x1e0
>>>> [  256.284550]        do_dentry_open+0x23d/0x3c0
>>>> [  256.289039]        vfs_open+0x2f/0x40
>>>> [  256.292836]        path_openat+0x87a/0x940
>>>> [  256.297064]        do_filp_open+0xc5/0x140
>>>> [  256.301295]        do_sys_openat2+0x23d/0x320
>>>> [  256.305782]        do_sys_open+0x59/0x80
>>>> [  256.309836]        __x64_sys_openat+0x20/0x30
>>>> [  256.314324]        do_syscall_64+0x3f/0x90
>>>> [  256.318552]        entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>> [  256.324259]
>>>> [  256.324259] other info that might help us debug this:
>>>> [  256.324259]
>>>> [  256.332394]  Possible unsafe locking scenario:
>>>> [  256.332394]
>>>> [  256.338444]        CPU0                    CPU1
>>>> [  256.343105]        ----                    ----
>>>> [  256.347768]   lock(misc_mtx);
>>>> [  256.350870]                                lock(punit_misc_dev
>>>> _lock);
>>>> [  256.357441]                                lock(misc_mtx);
>>>> [  256.363058]   lock(punit_misc_dev_lock);
>>>> [  256.367110]
>>>> [  256.367110]  *** DEADLOCK ***
>>>> [  256.367110]
>>>> [  256.373162] 1 lock held by intel-speed-sel/844:
>>>> [  256.377824]  #0: ffffffff8ee7cb50 (misc_mtx){+.+.}-{3:3}, at:
>>>> misc_open+0x2a/0x170
>>>> [  256.385531]
>>>> [  256.385531] stack backtrace:
>>>> [  256.390021] CPU: 12 PID: 844 Comm: intel-speed-sel Not tainted
>>>> 5.16.0-rc6-yocto-standard+ #99
>>>> [  256.398678] Hardware name: ACCTON MOROCITY/MOROCITY, BIOS
>>>> IDVLCRB1.86B.0021.D09.2111010103 11/01/2021
>>>> [  256.408028] Call Trace:
>>>> [  256.410605]  <TASK>
>>>> [  256.412837]  dump_stack_lvl+0x5b/0x82
>>>> [  256.416635]  dump_stack+0x10/0x12
>>>> [  256.420085]  print_circular_bug.isra.43+0x261/0x2c0
>>>> [  256.425095]  check_noncircular+0x126/0x140
>>>> [  256.429326]  ? __this_cpu_preempt_check+0x13/0x20
>>>> [  256.434167]  validate_chain+0xbc6/0x1750
>>>> [  256.438223]  ? validate_chain+0xbc6/0x1750
>>>> [  256.442451]  ? validate_chain+0x236/0x1750
>>>> [  256.446687]  __lock_acquire+0x88c/0xc10
>>>> [  256.450658]  lock_acquire+0x1e6/0x330
>>>> [  256.454452]  ? isst_if_open+0x18/0x90 [isst_if_common]
>>>> [  256.459726]  ? __mutex_lock+0x79/0x9b0
>>>> [  256.463610]  ? __mutex_lock+0x79/0x9b0
>>>> [  256.467493]  ? isst_if_open+0x18/0x90 [isst_if_common]
>>>> [  256.472764]  ? isst_if_open+0x18/0x90 [isst_if_common]
>>>> [  256.478038]  __mutex_lock+0x9b/0x9b0
>>>> [  256.481748]  ? isst_if_open+0x18/0x90 [isst_if_common]
>>>> [  256.487021]  ? __mutex_lock+0x102/0x9b0
>>>> [  256.490993]  ? __this_cpu_preempt_check+0x13/0x20
>>>> [  256.495837]  mutex_lock_nested+0x1b/0x20
>>>> [  256.499893]  ? mutex_lock_nested+0x1b/0x20
>>>> [  256.504121]  isst_if_open+0x18/0x90 [isst_if_common]
>>>> [  256.509222]  misc_open+0x100/0x170
>>>> [  256.512759]  chrdev_open+0xa5/0x1e0
>>>> [  256.516386]  ? cdev_put.part.1+0x20/0x20
>>>> [  256.520441]  do_dentry_open+0x23d/0x3c0
>>>> [  256.524414]  vfs_open+0x2f/0x40
>>>> [  256.527689]  path_openat+0x87a/0x940
>>>> [  256.531399]  do_filp_open+0xc5/0x140
>>>> [  256.535112]  ? trace_preempt_on+0x28/0xd0
>>>> [  256.539255]  ? alloc_fd+0x152/0x230
>>>> [  256.542880]  ? preempt_count_sub+0x9b/0x100
>>>> [  256.547200]  ? _raw_spin_unlock+0x2c/0x50
>>>> [  256.551348]  do_sys_openat2+0x23d/0x320
>>>> [  256.555320]  ? do_sys_openat2+0x23d/0x320
>>>> [  256.559467]  do_sys_open+0x59/0x80
>>>> [  256.563003]  __x64_sys_openat+0x20/0x30
>>>> [  256.566972]  do_syscall_64+0x3f/0x90
>>>> [  256.570680]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>> [  256.575866] RIP: 0033:0x7f9be4b97c27
>>>> [  256.579576] Code: 25 00 00 41 00 3d 00 00 41 00 74 37 64 8b 04
>>>> 25 18 00 00 00 85 c0 75 5b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01
>>>> 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 85 00 00 00 48 83 c4 68
>>>> 5d 41 5c c3 0f 1f
>>>> [  256.598474] RSP: 002b:00007ffd8fc01b70 EFLAGS: 00000246
>>>> ORIG_RAX: 0000000000000101
>>>> [  256.606177] RAX: ffffffffffffffda RBX: 00005572f20332b0 RCX:
>>>> 00007f9be4b97c27
>>>> [  256.613443] RDX: 0000000000000000 RSI: 00005572f202936a RDI:
>>>> 00000000ffffff9c
>>>> [  256.620709] RBP: 00005572f202936a R08: 0000000000000008 R09:
>>>> 0000000000000001
>>>> [  256.627974] R10: 0000000000000000 R11: 0000000000000246 R12:
>>>> 0000000000000000
>>>> [  256.635241] R13: 00005572f20332b0 R14: 0000000000000001 R15:
>>>> 0000000000000000
>>>> [  256.642513]  </TASK>
>>>>
>>>> Signed-off-by: Liwei Song <liwei.song@windriver.com>
>>>> ---
>>>>  drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 6
>>>> +++++-
>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git
>>>> a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>>>> b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>>>> index c9a85eb2e860..bcbc0d508ec4 100644
>>>> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>>>> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>>>> @@ -693,10 +693,12 @@ int isst_if_cdev_register(int device_type,
>>>> struct isst_if_cmd_cb *cb)
>>>>  	if (!misc_usage_count) {
>>>>  		int ret;
>>>>  
>>>> +		mutex_unlock(&punit_misc_dev_lock);
>>>>  		misc_device_ret = misc_register(&isst_if_char_driver);
>>>>  		if (misc_device_ret)
>>>> -			goto unlock_exit;
>>>> +			return misc_device_ret;
>>>>  
>>>> +		mutex_lock(&punit_misc_dev_lock);
>>>>  		ret = isst_if_cpu_info_init();
>>>>  		if (ret) {
>>>>  			misc_deregister(&isst_if_char_driver);
>>>> @@ -731,7 +733,9 @@ void isst_if_cdev_unregister(int device_type)
>>>>  	if (device_type == ISST_IF_DEV_MBOX)
>>>>  		isst_delete_hash();
>>>>  	if (!misc_usage_count && !misc_device_ret) {
>>>> +		mutex_unlock(&punit_misc_dev_lock);
>>>>  		misc_deregister(&isst_if_char_driver);
>>>> +		mutex_lock(&punit_misc_dev_lock);
>>>>  		isst_if_cpu_info_exit();
>>>>  	}
>>>>  	mutex_unlock(&punit_misc_dev_lock);
>>>>
> 
