Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B619496559
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiAUS7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:59:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9268 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229453AbiAUS7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:59:50 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LGwiYW006860;
        Fri, 21 Jan 2022 18:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bcFLzh2ktwG/1rGUa/i3xtVOXL1smOZEz6+Xu8mWhTo=;
 b=iYGSJIUeqPQjn7glvnkqxfXuNcQ+VTkbiFhv7pDVCzNRPWof5eABKhCrohwODI4nVT1N
 NHrCQSYmNAl+AD2+5eqyDCYzy11uZXfem4EuoT9nW5ORhWCIhMl50thrh+9UHwRuW8AT
 LoY/Kxm5prN03Afj5ald/teqEq7xVET2W+F0UFdL9AfcJL7nGSQECWia9r+Nde6PYehd
 wGwe9YAXm7u4KFuYEQPG/jJ0AH/Ygt/Xa7fpk8b8wqqWj+XE0Ga7vjnO0xEIGhQFHbnL
 Mb6VndclpNnQhgimOwEAoGtdJ6SPiWklGJCXXlvqP1JjxEQNhXwWJWlAtJ1d0jI67aQe WQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhybaaxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 18:59:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20LIoEux153184;
        Fri, 21 Jan 2022 18:59:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3020.oracle.com with ESMTP id 3dqj0negth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 18:59:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEEspETsqOkHUTbYxMtrqQosksu1moAbode12JhI29S/dWrTo79XYj644wgthJBEhGRc9R10vCMfDtoth+dCa9GauN3njqukEX4qrhVlONpkvss/A20CSJqxuoA3nxfRSJaSjurhn2ZxOrYTEevpf+Z6vcYPIl6pFwVe1ew/a2H2SCQw93MlCn4tazpCwJdm2bED3FglOrxHCn6riuQwmmgaERXqo4xgJzP/jQ3GgcMhzZ36NekzGL9HMQoqomS+thRP/n28ewY/73XRJKM5WZCvW4A71C8CJ+ICN9sDvGBZE+Ybnn2Ej3Pld0cRUaYe/jSanR+W4zZ61RpnCCZ6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcFLzh2ktwG/1rGUa/i3xtVOXL1smOZEz6+Xu8mWhTo=;
 b=l9giPjJ9CyG+cqSnD7PN5FI1IuF4dafuX8Y3IvgxvCNGcK/xItKGVSQOuA2AS8ZG6V/5CSt/smWGY3owA6ZhwzMnpT25UJtF6Z+Dknqt3c7JaLFKF7BKUYGtBHIemkYeKf0OsQynaRN2YgoZGIyyt7hZU5xcaj5HkhGyNMBsxaSNH++wqv7ISm1OgSICN95bda66oLu32KdNJkxn9/A2S5lCBfStbZ4Cr/Qo9zwDO3GCA+tywZ4qya4YItar1exHQr4Vg4VX/hsScVkaxdjKGUlvWAPUIzwzj/vH7rnleQqwf7grdOjhukNQE+1VP6i0t+PjUM+zL+QvDxQUDnUhGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcFLzh2ktwG/1rGUa/i3xtVOXL1smOZEz6+Xu8mWhTo=;
 b=uXh/Z+QhooXD7rB5ZAJ4CAonYVxg+GsNxUrxVI6AOuSlOaM6YILfx/YEjifW1I8YYzlDbkLSQ50II6fAbNIZSP/lM7uXxtXmyV+yJzFgh5gya30W/tGUUOKCfU4rOOdWmomhac/7iPsLnmuexgyAdCJP3lwv0PA1gkG8GE6W8TU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN6PR10MB2606.namprd10.prod.outlook.com (2603:10b6:805:48::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 21 Jan
 2022 18:59:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%5]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 18:59:18 +0000
Message-ID: <993a94b8-b845-5f28-691e-5fd14f2597ee@oracle.com>
Date:   Fri, 21 Jan 2022 10:59:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 1/3] mm/hwpoison: mf_mutex for soft offline and
 unpoison
Content-Language: en-US
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20211115084006.3728254-1-naoya.horiguchi@linux.dev>
 <20211115084006.3728254-2-naoya.horiguchi@linux.dev>
 <10577ef3-57c4-b1eb-cd0f-40518dfd9ad0@oracle.com>
In-Reply-To: <10577ef3-57c4-b1eb-cd0f-40518dfd9ad0@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:303:6b::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2d98d0a-1c67-4edd-5aad-08d9dd10201f
X-MS-TrafficTypeDiagnostic: SN6PR10MB2606:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB260681320D15204403745E7BE25B9@SN6PR10MB2606.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6h1pLug2RKKtW2hhdrvp99ihEX/xQLHkUWjZIMyOjijnMm8IpI10f2DAiAIkUobtcS29Wox5/T0e7eqgm0uXL7K0eZXalfcFEVd9EKBRuTT4hOH8IrEZmRRP92lklM1UmkqJ0v24oOLltw7UxpFdknF143MIEtl9FL8h/NX9nFP1oqfgJCnQb5zCxuQKOSn3zNnH1xsH7vBguvxegONgz3BNXiMvvUSQoR7b3ySD84xhGbo8ShKR2t7oB/a8o5OmIeUm5GvT2ziIezsYFAWAtByFOcN9+gjP0GnlFi/ofsO0GigtEfHY5MAFOl6cQVYopKUrqVf27fAbS6c3xrRaLL0RVVSWndgVJ9YAriYcpkf98Q3dWm3+OAOOnXsFHmnbQWKhQRprQpx18WbvIi0AaKw2yJLs6YYTlxddj6zWncQ2HVH7joxDoyI2lQeexOdSlJxb3PU0AwfNKArDF3MTCc9+tZTH34O5TzH4eOPiXe2ywSxniZoXJ4qbE7erkwassgyOObjXSl8y22wvSU80/Epan6S5hejISzQIgPpPJa/Ld8p8nW4G/ZRH/qMi0KvNIXbsFBEHKfLGO4yjfu2Q4OziREjzRnFAjQ/XGpNRslO08BZlciA+fpeQVI7HDfjhr6zKsKmS1W0TXXtiBbNj9cvrz4ymDzCfyx1C28E4XPDT/Esvndgx8ihKsWAtNjOvfdYKY9+ugu2RTGGlupvFQXkh3gewnTXTK5xGsr3VA7oy/9rmHU46DR40N1zNWPs6MU8l76cdwdTD8D2HZjd5Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(38100700002)(8936002)(66556008)(6512007)(4326008)(83380400001)(6666004)(53546011)(186003)(6506007)(316002)(44832011)(66476007)(36756003)(66946007)(86362001)(508600001)(2616005)(4744005)(31696002)(8676002)(52116002)(7416002)(5660300002)(26005)(54906003)(38350700002)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clcyWmNXUTkxWnV5THFvajFZVEFzSEltbWRuWFV2Y2N4YW9adGYyTzJGbUtt?=
 =?utf-8?B?dXdzaVQ3UjJXVEozYVRWTnVwV2tCSWw5ZEpaYXIybmZSNlo4TkxFS0wwcWls?=
 =?utf-8?B?czAxUXlNK3N3NDBlOHViS3hPbFNUU21zYzFwalkvdUYrdzFyOHg5SEJ3T0dV?=
 =?utf-8?B?c0lNNlF6SlUyZ3pTT0Z6M1ZnM01aTnV6eTBuWU1CakFLeTl2aVdEaHdOY01K?=
 =?utf-8?B?N2h4THhZd1VmSmNGWkxlY2FjODJvWEE5RjVnb3hEaHhBNm5oUHRPM2tTL24r?=
 =?utf-8?B?MlBLdjVZRzRRS2ZEOEJ3R0hEblVHNDlvN1NHZTcrdzYvV0VGdERJeTlJelJV?=
 =?utf-8?B?OEdBUDdvMVYzYk5USWliT0xWcHpvYkFpcVplakE1UTREdDZMNjJpZ1RSNWdk?=
 =?utf-8?B?NnF5eTh2aWtDcE9qVEszU3ExOHVrdytPV3hCNlZ3dEs4cG40UjNFcmpBd3hu?=
 =?utf-8?B?MlZnZVlJVXJTTUZsV2V1MklaQ1JoUis1bmh0UGlFdzJ0YzZDSGlSMmhFMFVw?=
 =?utf-8?B?bjBweXg0Y094UEFBc2tVdUxNNXEvSkl0NWxQSGpxNzU5aDZodm5aajZOV3pI?=
 =?utf-8?B?RGJZVEs3NVVCdTlpRExPa1duZDVnd1Eya2gwU3EweXlpU2VyUmNDV05CRkFl?=
 =?utf-8?B?d3crWE9odEVmbjhkSkpaUThaL3Vsa2JsbVo2Q1JNajJ1VnRteVB4cUtYdWRw?=
 =?utf-8?B?WVpwN2tBY3NCczNiSXE4VUlUSGRDbUpqQ1ZXeTJ1ZFI5eVdPSElaakp3b0Y0?=
 =?utf-8?B?VktDNlZiWUlSbHZEaXROL25ab2R1aVNyMXVYTjNlRHYva0h6MHFTN3RKeDlz?=
 =?utf-8?B?OWZpN1d3S1MxaThDL09ObnEzWVIrL1VMT2wvcVROTlVXUXRFVHUwV1RZVVYv?=
 =?utf-8?B?VWpzYnl0Y0Y1QWlVa0dkcU5EZURodTh0aGNpNkZJdkNROWtVRnZHVEY0NmdJ?=
 =?utf-8?B?Q00xSFFINWxxRklOb21zbytZZTdXR1VKU0VWeFlTa21McEFWT1grcThKN2tp?=
 =?utf-8?B?eFI5dlU0Y09kdHE5N2hSblBRMUlGK3VOLy9ocTZCR05Hb2hNYXZhc2kyY0dF?=
 =?utf-8?B?V1lrSGVEWkUyY1hQRWhmU2c0aldGcGFkTTU4UmVqWEpjUE5nOXE4MEczdUZo?=
 =?utf-8?B?WmFBK2NmQkhkSEw4a2FLQUl1SzNnTElMRmxDcEhJenFxaGFZL1ZML3hwYmFC?=
 =?utf-8?B?bUg1SjFwM3dJamE5UlBFUnVmaDhDQ1BwVG0zV2JkOW9QN3FBM1RCb3FOYXh4?=
 =?utf-8?B?QlVXeUt3QVpCUkNZdGJLREQrRzFydzdhMW0rMXlyU1plbGh6T0Y1TEpySDF1?=
 =?utf-8?B?d0t6UHBTV3JKOWpLL1dRaWF5ejJ3ZFBuZlBKd0VaSElQbk5iMTVTdFJOU3U1?=
 =?utf-8?B?Y2xIY1FkM3pmVzg2R0JhV2c0b2hFRHM0RHl4T3hweW9LN2VZM09uS3FWdCtS?=
 =?utf-8?B?eXVlVDZ1Nnh5aGNUR3A3cmVqUFhxU2EyeHpOR3owa2xlRXZ6YkdQTGFzS2V4?=
 =?utf-8?B?aDJ0eUh5VTNnc0tMbFVENmVEYk9RdDdLTWZxVU5WL1psSjJPeHhhZ1J4UlJK?=
 =?utf-8?B?cG5mVFFCZjcvOWlaTFV3eWVvWlNtamgwTzE3a2Q3T29WSjVnSDYrM0lydTAy?=
 =?utf-8?B?eDVPcEF4bWZmdlNMTzhwUzh4Y1NBU0UvQTFjNS9xeXlqRDA4QnlKdUdKTHZv?=
 =?utf-8?B?MTY4Z01KSVZxcGk1dFUwL3BVcUVzUmcrVk1CY3RMeDZPYVR3K1pJRmVvVVdV?=
 =?utf-8?B?ZStmVUNKMS83WVE1NkJWdGtVc285NHZtejlFVUhEQnJwUWhMT0ozVTMwOU8v?=
 =?utf-8?B?SFFzcXBHTVJIeWpOR3FFR2l4NitQV1dRYUhqTWpLUitZS1RHbCtWUXpadVJX?=
 =?utf-8?B?dStsSkNmbkhKT3B3SnMrNi8vVld5TEdtdHRvMkJiZEl1OXpIQkZVY2lvOEFJ?=
 =?utf-8?B?V1pGejZmYURPU0hDSlJ0QkJ3ZHE2RWRkTDJVNzVmK2x5QXJyVVhsVFF2RmdP?=
 =?utf-8?B?bnRSUi94Q2toZ3dwLzAyV0tRVVFxRlhHM3JGQllkekYxenFVSkJkMEJONHJl?=
 =?utf-8?B?bzNaTG9ZdS9hRGVvVWdCL21xYzFVK0RDQW9peDRVdXBySjE4U1YrL1c4SkdR?=
 =?utf-8?B?OVlnRHlReS8wOVpuNnBlVzVuZWtlZzE4UHdQUENjV3k0bWg5V0ltVE1OdVQ0?=
 =?utf-8?Q?Qtr4FGstiE1boSurJ3U9uq8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d98d0a-1c67-4edd-5aad-08d9dd10201f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 18:59:18.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3Gnz2B2NX40yH7T8uUNSKCgk4jxyU3fBlz4DwY4UGM0k21c0/B8ftZF+/BvxnwtKLR+Dywp8xGDVd+bXsZAiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2606
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210123
X-Proofpoint-ORIG-GUID: tsv0P3uLVg0P7kCzsIQONpU_jff5zXrQ
X-Proofpoint-GUID: tsv0P3uLVg0P7kCzsIQONpU_jff5zXrQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 16:09, Mike Kravetz wrote:
> On 11/15/21 00:40, Naoya Horiguchi wrote:
>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>
>> Originally mf_mutex is introduced to serialize multiple MCE events, but
>> it is not that useful to allow unpoison to run in parallel with memory_failure()
>> and soft offline.  So apply mf_mutex to soft offline and unpoison.
>> The memory failure handler and soft offline handler get simpler with this.
>>

Sorry for the late question.

It is not directly part of this change, but can we also remove the check in
__soft_offline_page after this comment?

        /*
         * Check PageHWPoison again inside page lock because PageHWPoison
         * is set by memory_failure() outside page lock. Note that
         * memory_failure() also double-checks PageHWPoison inside page lock,
         * so there's no race between soft_offline_page() and memory_failure().
         */

-- 
Mike Kravetz
