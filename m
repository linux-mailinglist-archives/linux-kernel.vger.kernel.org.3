Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECC1483BC2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 06:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiADFss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 00:48:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26558 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230181AbiADFsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 00:48:47 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2041htla025098;
        Tue, 4 Jan 2022 05:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3ERzKVZ9EHhIcdqgpXbSqAuja5bf4g+DFPWYlIjKzcI=;
 b=NJOgR51AEM1BVkOK7oOiAB7Gj9liAAGifckoRgWdtNDiXlHNGk3YTlX+XDBFDkAtlTwk
 axVj+jCr9eM3u3mKUbiepMwG1/uTn/ai/BzUQ+R2ZMHvEx0MNL1fb/k1/Ltfx8PY+J4Q
 8CVTH8DDOzAjW7YchS8x5HXQzb28IEYvLLgVBg7UvG6jX9FqlS6kMh1D7ZHPkrrgWXwI
 qmNcoysKBXYq8+CWt/mCDhUiLN6wmWbfa3aqj6+Bxaj5P/JXZukbKFTKCq/ITFAvGBf3
 tD6ZKlB58dZFO5DB1DtXN8Thn8G6rDVzft6trtEEePakLMAnPUrlQlaJqTpmgcLPHyX+ QA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3st1bqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 05:48:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2045jhbA157508;
        Tue, 4 Jan 2022 05:48:43 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by userp3030.oracle.com with ESMTP id 3dac2vy4gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 05:48:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQzqOF37yhOYlMeieOCJ5m/9oFdmm806cQ3fu+wUD5j6dQ5wWsHOBXNifzWKjyfJOPfmJisFID4sMUShTd2irGct1m/1SUctW4GnckuQJ5LhOkymH4iOhfPSF5+fI7aZ991vlri/JMyVOEL4a89c7BVQ1o+Ingm5m6aUFBxvw06V7O70x7QBx37N2TDKWy3/QI9rPQu2LKnK/nCtXuwa7lbxn4BUfQ/X8lUAbAAUJtYLzjM1k9N5msv3TAu0T9kmpKKr3yKcgsbuyotAAhO8ifJPvZyWU/+bH2Etes7CpI4X8qFK9P4UIDK+2cqTJ4t/SKfqMFpZHEM67U/ZFayI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ERzKVZ9EHhIcdqgpXbSqAuja5bf4g+DFPWYlIjKzcI=;
 b=SfvL8qpyAZ7ympEsUe5JjinC+h1JFokRdfD6x8fl/IIOFqmO0bgAAw0OuePbWwo63B0L/OuJAZMxdtUk5pSRFkhpWBcqhL1IvCcfPXTY7G/yIB6LkQNITJSwuePInGUdH7aMusVjEbUkncd3h0SEBIXjBxZ40mPCaP4lqr8YHFYzg3pJ+X9yacPsC46Oo5BZfdMN/j6iVVs52h7Kbvi0PYWbUbOsP7Bngnt0QkD3fkvFeHq+tD8wFOyy/CFDdtsEKfzVyRLa/sluQFBN7khsnrsPdmT3D4vQNy0GILLhb8+BiZMGS0VoFyluqhkfSbimHLgK58xqF5FOwQjunoQCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ERzKVZ9EHhIcdqgpXbSqAuja5bf4g+DFPWYlIjKzcI=;
 b=zxd8kwLN4nhJwqSiB1O93OTR46walHxRcsDGDa8Ln7HSlaPMUTPElEjifnY0Wa8vTATdhpH6bc7CgunmkKoMZUEq1NkEkJUgwgRu6iGadUtZw0OtTdwpn1t7e9IUc0JLzk10ela3synx/XhwceEGDVFWLBbvoN8H0DL8JSigvZk=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR1001MB2205.namprd10.prod.outlook.com (2603:10b6:301:2d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Tue, 4 Jan
 2022 05:48:41 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a%6]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 05:48:41 +0000
Message-ID: <5d4fe1b8-0a70-5fc8-b0ea-48cc709e3c03@oracle.com>
Date:   Tue, 4 Jan 2022 16:48:35 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [RFC PATCH v2 1/2] kernfs: use kernfs_node specific mutex and
 spinlock.
Content-Language: en-US
From:   Imran Khan <imran.f.khan@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
References: <20220103084544.1109829-1-imran.f.khan@oracle.com>
 <20220103084544.1109829-2-imran.f.khan@oracle.com>
 <YdLH6qQNxa11YmRO@kroah.com>
 <719eb5d2-680c-e596-1446-3ca8f47c3aea@oracle.com>
In-Reply-To: <719eb5d2-680c-e596-1446-3ca8f47c3aea@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:806:121::6) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03180095-c46b-4b64-c2dd-08d9cf45dc93
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2205:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2205D38AC7673CF1E4F9C6AEB04A9@MWHPR1001MB2205.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9fVYKlxkOqAQhqIqAzH7mGxGt8URQxAMW1vCZHpKhCAnxLp22d9nw4NKmKx+t/iIPf45svGKPFQ5zizp9AaJiFMXlwAdHfUcsBqn09Q/IDUb+IaiUmu0q0d/T2jLPL2pty8bvJJxeq2Wuc7H8rw/djw2KnJVcCI6IQAgkLcB+zuCr/xrY7GzDRfReQDxDkxBuOGD5A9fdetOduvektl9nK98Ju5gyVVdxwaBw4yPV8CsgxbO1/+6UmJPjcoseaAME3EXNzApKajwSeV8Mb4mOwpDEqPiTHM7qcUKidKDMSrV8jHfbkVOb8KDQH6g4CzFgDHtcy1jNoSmQBr/NIS3sVFW0WTeS/LO3iwnzDlYPZKr8qOkMVQ2EiOg5wIoD7KazPzaqZIz1bkL1RpM6/MLJhvwvxsuZDliSiicTLnuycPs/Xvfs5loduKpf6jHtKJzmnl6fsYlpMIIIFo0tkE98E1k+JSatt1EXmJzmXYPWtfCEg35FiMIF0fKjIHFMgeRqy9qGr6s3uvveEqTn5iA9EcAGhhwILTzIgcVs1YY2m/HN8FxSN1eUT5g7CbSyVT4tJUs/d0mHzkjU+9TMfkNnGFfR45j08oOXgm6Oq5DR5FEXv7PKS11Ac3D+DPEN43UEBWPqD53/PpCOkqBbhNxx/ST/3NjqZX/cZSz8soG1hJasJInwbEYCqnt72Nj1nt6Y1THp3iSYQZuCkdxO3SuRDmAD4Oqk1JyAt0MXwjvnI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(83380400001)(5660300002)(86362001)(316002)(53546011)(6506007)(26005)(186003)(36756003)(8676002)(31696002)(38100700002)(6916009)(31686004)(4326008)(66476007)(2906002)(66946007)(66556008)(6486002)(6512007)(2616005)(8936002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2JVS1Z6RlV5ZGp5eXBJSlBrMnFSdFVzN1FTbGpQTlFIOVhWcGFKdVVVZW5z?=
 =?utf-8?B?Z21ldnhheDNtL0c0RkVXMzl2cnJhOVhoWm9kMEk5SEd5S2FiVVNmTWNXNFRX?=
 =?utf-8?B?K2dOeWFyREZlVzZpZ3VKZExBSDhwNzhFM3dPZlpLMHhWd2ZTV3BQQnhvMlRX?=
 =?utf-8?B?aURJWGIwQXNLY3ZhanJxYlQza2NCem1sc2tmVkRLWTdIU3NwRkVodDZwb0Vo?=
 =?utf-8?B?bk9lZ2V0WWNVd3U3TVp6SEZJK21QUFdNQUZiTlFiVTdPVm9VbHVsVjNvUTlo?=
 =?utf-8?B?WmNYYXlYcUZOcDQwblpZcW5EeWZmVUpCdDZqSW85ZjVhSkxxUUdsZTRSRFVu?=
 =?utf-8?B?NVJuYk1CRWVIYkVlaWpDbE5ZcE5abGpFQVZQQXlrRk1xRG1ZeWd6NGlBZndq?=
 =?utf-8?B?Vk5VYm41aVppZ0YvSnNFWEY3RWRBQU5FVnkrK2VORzdtU1l0TEZYV3hoYVR0?=
 =?utf-8?B?RkhyelNpSkxsOCt1RUhGczFQNk1CL3BiK0lSZ1Y4ZnNlOUh4dmN1Ynhmc3Fi?=
 =?utf-8?B?bW1BOTE2N0dWbXkvNnpBajlzdmZabXZuNUNJS0tjdEkwTjd1QnZwQ3ZCMC96?=
 =?utf-8?B?WWYzU0ZWVkdhNmpqTTI2RHlzb3pqV0tDaWpYeXRTWUF1OEl3RGZNQXFOdkpD?=
 =?utf-8?B?d0VuMndEVjB1S2JlQ0E3aGtVS0ZjTjZyMzdVQS96RkVRRCtSdWNGYi9Ra3N1?=
 =?utf-8?B?NkEvdHFOREF0eVRaS0tnVk9qRU8zdGRHMWJUamI4RWZCbnBDUzR1SGN6L296?=
 =?utf-8?B?MW9xUlRic1RDMU81M3k2UEZ3N0VMUWZnbDBuZXVRN25VL2tqVWY2K2Zmam9h?=
 =?utf-8?B?cTd6SG5TQkNlZWJWUlJQYnFYS1JtTmV5TjVPTVM2ejZncWo4OW1sM2RJbkFM?=
 =?utf-8?B?TW9KeHRXSm9vbVhmaHpxR3g2eUM2RzdUcmFWK3RDNlMwYVJwZEdCVEJ6all4?=
 =?utf-8?B?elVTVWxoY0FCVHlhWUlrb2NvbmRyRXBVL0Zyd2hwNFVjY291VW5haUc5bXll?=
 =?utf-8?B?NGZGTWk0WjYrY1hxNm1YaVE0bWx4VWdUazJqRUxFS0NaMzkwT0FESXJ5NHBj?=
 =?utf-8?B?c1J5Z1FEQ1l5WitlWEtVYnQ3dGg5Qld3U01wMWlUK3EvNUwvZnNTbjJBdnk4?=
 =?utf-8?B?RnM0K25XQmhmekVob0xlQ0YwR2oxY1RwN2dvMHlLUENlbUFnd0prU2JPcUI3?=
 =?utf-8?B?VWtXcjdvYTBON3dNWjFEWTdLNW1vRGE4Ry9hYVJQRytUUDJHb3JNeVpsbThq?=
 =?utf-8?B?L1UwWS8xdGxrMS9qQXkzRnhqQndwQXNZVXBhOTFET3EyeWRpTGIvWFNGUWFm?=
 =?utf-8?B?NkE3SDlYcXZGVHVMeGV4ZnR0Nk9JZkk5eWFPUWx6Tk5acEdiMmJIdDFlLzZJ?=
 =?utf-8?B?cG1MV3VkcTQwWDg0Z0luNk9TbktaUkpwdWsrNUlyQWtjUGI4dGwrd1Zud0Zw?=
 =?utf-8?B?c1hGbVN4eUhCYjJHdmZMWnRiUUc2dGRya05Ic1dnaFpUNndSYjg2VSs3VUgw?=
 =?utf-8?B?ajBscDdPOGZzVnpyang4bk5nYkExMjRPUkFOOU1YSWIvUTFmQW5xSU4yd0RS?=
 =?utf-8?B?Wm9ucURaM2dRQTY5YnJUaTQ4dWU3aW13b2MzNEJEQnVocWxhb3dsQ29ZYmJo?=
 =?utf-8?B?RHZFajhZb2Vna3NVM29oRHZlT2QxcHJrRTc1UFRJQlpQVEhvcVk3ZC9mUG5u?=
 =?utf-8?B?UDdLVW4vbkxHVkxoYUZjOVEwWkQ1MGRzd0RFYi9uRFo1Q3k5YTh5Mk5SOG9U?=
 =?utf-8?B?eEpmaE5tT3FWamRhMkJtc2hOR2xHYXp5TW16WnJ3YUk3U0k3SDhpNVN4WlpJ?=
 =?utf-8?B?bGJnalJtcFVFTDlNaHk0RngwU3FvVWNyeHpyWTR3cXBkYWN5ZlEyOUJjbll3?=
 =?utf-8?B?anlUaytNYlpkeCsvL012d25pT0kyNCsySHVwYUhwdkk2MzhsSXQ0N1NOL2x1?=
 =?utf-8?B?WXloa3N0UjdNVEFPWEdzZTNMMDlLa1RzUDBjTjl4N2VmeHkvMExvbS9YaGF5?=
 =?utf-8?B?YWZsbncwZm5JTnkvNEFUbGN4SG1kbXZQdFA5dGlHMEdudXU2SUt0ZWdMQ0E4?=
 =?utf-8?B?UXUzck4wTnZwaDFETlhVNVpTQ0pmb0phazdub0pNdytPelRBZHBXOWk5ZThP?=
 =?utf-8?B?NVN2NEd2ZHZQK2RvVXRaZzI4NFJXV3RtdHNFb25lYzFrZEtTc2cyWEttVGVa?=
 =?utf-8?Q?NWo4ia9lgfZ8/2lUndvGXDo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03180095-c46b-4b64-c2dd-08d9cf45dc93
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 05:48:41.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWsHeBt8SX1Rk6udV9x0zEBjzCiCYQaCtw7wBuiHp8WG1zGx/MF0vhj84AHqZLGO1XgCes1kETks36v6N/m16Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2205
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=960 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040039
X-Proofpoint-GUID: TwT2Fs5o6KMR8H1aOfV7kBzxhTAOInC7
X-Proofpoint-ORIG-GUID: TwT2Fs5o6KMR8H1aOfV7kBzxhTAOInC7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On 4/1/22 9:16 am, Imran Khan wrote:
> 
> 
> On 3/1/22 8:54 pm, Greg KH wrote:
>> On Mon, Jan 03, 2022 at 07:45:43PM +1100, Imran Khan wrote:
>>> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
>>> index 861c4f0f8a29..5ed4c9ed39af 100644
>>> --- a/include/linux/kernfs.h
>>> +++ b/include/linux/kernfs.h
>>> @@ -164,6 +164,8 @@ struct kernfs_node {
>>>  	unsigned short		flags;
>>>  	umode_t			mode;
>>>  	struct kernfs_iattrs	*iattr;
>>> +	spinlock_t kernfs_open_node_lock;
>>> +	struct mutex kernfs_open_file_mutex;
>>
>> Did you just blow up the memory requirements of a system with lots of
>> kobjects created?
>>> We used to be able to support tens of thousands of scsi devices in a
>> 32bit kernel, with this change, what is the memory difference that just
>> happened?
>>
> Indeed, this patch increases kernfs_node size by 36 bytes ( 28 bytes for
> mutex + 4 bytes for spinlock). From current kernfs_node size of 128
> bytes, this will be a ~25% increase in kobjects memory consumption.
> I can replace the mutex object with a pointer to it, to bring down
> the overall increase in size. Will the size change be acceptable then?
> 

Please ignore my proposal about using pointers to mutex object. It will
reduce the size of kernfs_node object but eventually overall kobject
memory usage will not reduce.

Thanks,
Imran
