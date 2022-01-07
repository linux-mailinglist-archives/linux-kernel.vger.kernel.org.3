Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC63487747
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbiAGMCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:02:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11810 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230064AbiAGMCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:02:10 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2079vhYi011035;
        Fri, 7 Jan 2022 12:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QUsF72ISLyabyUr45Q8c8BHXclRt+FNlaZufWQrFhio=;
 b=evAtdPOnnAM2LzlELDB8a6p8o/6M9SZWRVqtgHp+wFYz7RY/XPv/V+ipABPr0heV/YJK
 uSURMD7Yh72eEPstu+XGRy+xoBQWiNOcx0ib2nl/Vd+dPEZVEcBbgWUgYzMSCa97naxg
 Pa7h66KkQuECWB7L5QR82kf/uJPls6usKxQJCvPiWjFYZX/9LR5wy54Stw6QDvrV6Jkg
 N7sS+4Jq0ywZK4UO5UsXQajKqpI2qw9bXF7QvwbXA8ASFpSSSHojBqejNS2gsLZ+AWks
 v25Wwo4+QhklfA9l0bpW6gowju7fSACfPxXl6It81QsosAbjihr97SFthrQ4CcaCQ6n9 sQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4vb9wtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 12:02:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 207C1shi065732;
        Fri, 7 Jan 2022 12:02:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 3de4vxq88a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 12:02:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbsbUqj+Pvn/Pq9aGaKFFWAcD8SNBvx5e7PySTV3i/Hd++X5ollwTwILoAvwHypYvf9vFFh6YQv8Ni2iCZ73s5aijtgMCMoLKMv0GIhOS3+xG4irAFbt0KSW7SYBmoYnYE/MSL478/2Z/IoTsZATnwtnj1WjIiiFGUZ1InUn73PCBMDqznBLCVuON8HfnFn3ypd7O4XtRK0tfzukrgElP8uwW+xciAx8dL4ngI9DYzIoV0PtPGYUdsH4kHpIdAdfZUmP326kWHlChuu8DlZGe3okHhIhbZsXEsUQPJe8lusc5S88s42/pVZzOJ9uCdqaBZoAYlPyoqRG5J4WG+k6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUsF72ISLyabyUr45Q8c8BHXclRt+FNlaZufWQrFhio=;
 b=Ish3hRgiCWOE400nvJeRgFbDMjdUSXSnYK1p76i/NNAlRPC9M0Xd0Slt7fydrquDtVwwH89wHcz+txGalLA1Ri0QUpCYB+dUY6MQmcXyfPfVF4q2Jt1by9Y8KCBS7q1RZOCAbL5fUM7f10wv6dBezjYs+t7k0VOpGRzdll4fBDZ9kixyFr8CAEKMRecl0RPmbjKmMoE6IApO61byuwMQ/3oyP97Z5oKJnVNe9J7vIAWYuHpWEH6YAIAqceOV5bLep3KrUmjeXZfdZ9NpKuJOYLo5kJPU+0f5hs5Kat1fXTLtiQ7BmadZyvINSMbmYPVwmSQNZIJ488ykBQ+V/b5GCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUsF72ISLyabyUr45Q8c8BHXclRt+FNlaZufWQrFhio=;
 b=DORW9Cd49qDSaMp1SvdhDb8SgUWXl+Z+C+tqDFV6gfCjO2D9od4AEc3E6lzftieQMu/kxvazTC4UoZLGylfATqmrDvQ6go4WeIcxbxXPIBlcb5kuf+tDzGHMg1ogXmoDnoqR4cPk1s8Ta2IpouAL2Ay2OmgJrnZ6dQs47HGEzYE=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO1PR10MB4577.namprd10.prod.outlook.com (2603:10b6:303:97::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 12:02:04 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a%6]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 12:02:04 +0000
Message-ID: <03cb9939-efbb-1ce8-42f5-c167ac5246da@oracle.com>
Date:   Fri, 7 Jan 2022 23:01:55 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [RFC PATCH v2 1/2] kernfs: use kernfs_node specific mutex and
 spinlock.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20220103084544.1109829-1-imran.f.khan@oracle.com>
 <20220103084544.1109829-2-imran.f.khan@oracle.com>
 <YdLH6qQNxa11YmRO@kroah.com>
 <719eb5d2-680c-e596-1446-3ca8f47c3aea@oracle.com>
 <YdP57ij4JxahpdnC@kroah.com> <YddRVH4r6uNHt3xa@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YddRVH4r6uNHt3xa@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY2PR01CA0009.ausprd01.prod.outlook.com
 (2603:10c6:1:14::21) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d7bfaf2-0cd8-41c6-b08f-08d9d1d584f1
X-MS-TrafficTypeDiagnostic: CO1PR10MB4577:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4577B0165C95143735D54C51B04D9@CO1PR10MB4577.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4/hB69yeuEP/11XzkLrP6W9TxKBXmWy3Qhq74e1hqubxwLu1/yBpDwcJKxhJH/RottbqKpcF+Bt3NGotckU+4CgU4Stq0aquySps09rm0y7xQac85ICtpxxvyrI8O32obl1CElKYxWN6Ti/pM/TwFj42fmc4yc5sAPYNP67kQyElhfl5vJdqyyREnmlQllA+20K5s9fLIeMgRqDzNswjN2LJUkomWPfPz7VPO6efpJ4ze2TUC13Ze9Qpel20XyxSuiBt1LSX7YlXElF+UwtGOrLWFNkNj1TM9ovsBJ37TkPWF87o9OMklBWTNgqfRis/q6R5IECrWe3qjvUMPKcMU2AVLuwg0KjmsXl72lzx7+9uHx7cuayVIjAHCeWNNYFJ9x25pvNzR7gwC/Ydvljv5RQGhqjwqh58N/Q34CkhwfJv1vq/vEdTvmd7xZFd5KsgbJRdwS0dJhfoD1a1peTd3bOHR5uXQv0v1mwSqPeiuZSrUy4Qn9mbJpL3rZVrkKtsr6D/A52rNigkUCgnjjFVilHZp+tJT2gkARFaPRK2u5ZM0/deIuuEJDfxdlKVWTIzHmaXSYmqJ9ZZb1dkhL9eavjcadDSNdy+lQ9z6DlCtkh3f3bc+x/W7GGsfiqb5ETHNj+i6j7/Zg/slN1PeQWzPp+ZTPtdmBLDrE6brogPxffYZJcuRKf0Hutnikfw5vTd37A59YXfst8IZoBJ936+Ee4ztPUyOXT7PrADujrSyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(110136005)(86362001)(6506007)(66946007)(8676002)(66556008)(83380400001)(316002)(2616005)(66476007)(53546011)(8936002)(186003)(6666004)(2906002)(4326008)(26005)(31686004)(6486002)(6512007)(38100700002)(5660300002)(36756003)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2h3NW1tWkQ0eURsbjJiZ1J4NXFEQVVqL2RWb05RNWZ6djhPUVRwNXNEL1pU?=
 =?utf-8?B?RWlvbC9ZSndXQ255QlVzd0ZveDdYcEhrRzA2em1rendkTXU4czBTYWxEdE9V?=
 =?utf-8?B?a01oSDlDUmFmZXkveXFnRW5obXdpVUVEc3NDTktTSVZoTXpIb05sQU5MQ1NG?=
 =?utf-8?B?RGpwVzIvSms5SkZqaWJXckkydVV1VGxRMHFkN2l0UDRjZk04a0NTV0FqVGZk?=
 =?utf-8?B?KzBrbGhiY1k3c1h5LzY3amtRUXpKZXQ5a0pTKzl2Qy96ZU1SS2FvSG8wM2VN?=
 =?utf-8?B?c0VtV1pNV2pOSjZWMVdvcFdtRUE0RmtnTlVKalRMNS9tcGczR3A5bnJHVUI0?=
 =?utf-8?B?eXZ2Vkp5S2gyODlwaHdWUjg5TXVDMytRWDNFSHZyNnhOcXRRR2dTMVJMN1VW?=
 =?utf-8?B?UDIrSjUrQm5WOG9rdkhMZ1JqQWM3ZGZIQk90cUlIc2lSMmFEdy9CVlpuTU9t?=
 =?utf-8?B?b1VhQzBIdHB0ZUoyb3VpOWlDRWlnUE5tbW9UWm5WV2FkeWhROC9EVWN0R1J5?=
 =?utf-8?B?Q1hDRHY2eEsrMVdpZWwxck9STmdnV3JxUG5QOXFWVyt1cS90YlcyNXUxSSt5?=
 =?utf-8?B?aXJZNW1uSTVMZFNnTk92UVl6NWdna0lyUHBBOGI5NXJ4aWZaTlVUcVdSRzcw?=
 =?utf-8?B?VVE0cUFMNkY4dEp4YVdZSmY3cGEzQ01KdjB3eDFkTlFKMUN5dGl4N1B4ZjNW?=
 =?utf-8?B?RUxtNitOUmx6aEVNSnk0ZGRDYWc1enhBeENFeTBWckJROU1iRitjSnNXNmhy?=
 =?utf-8?B?NklSRnJmSmljU0RqVzh5emR6VzFJanV0NWNneWtoRExIK3NDTGlIOHNmT0JQ?=
 =?utf-8?B?VUJMT0hsMmdvSHZHc3JHNGhoT0pFUzBzYkJHRGNoL0doNkxzOXVKUFFSamU4?=
 =?utf-8?B?bTJwR3NJZlJXOFBzYnNZR2ZwZXJYUGdpeXZyWDJnVjF6dVJEdk5MMDNrRzBl?=
 =?utf-8?B?MWZMWVloemFEdlpXZTh5cENBT0o4bkR6a1I4ZUV3c2VhR3gvZVBOYTlKZlg4?=
 =?utf-8?B?aFdBNUpzSVJTUjMzM1Y4NlRSc3BNTTdIcGx1ZGpNcUZzMkpQbGdET2FTbEQ0?=
 =?utf-8?B?dHNpS3ZHSWw1UmUxT3p0L21jcW1zWGROUjZRd0RlSkQ0cW1ITjFKRHVnNnY4?=
 =?utf-8?B?YUROTmwxektvZHJPU1RmTHVGOVZFY1gxM2gwZk1YSDBaUGMwQTVSdmJqYjdi?=
 =?utf-8?B?ZlJzenYrQ3pMMko1Tnc1NDZsVUtMV2F2RFRXdk1PUjRoUk5ZZnhjdFljdkQv?=
 =?utf-8?B?ZjhrNWhxamJmblp3ckVuOW9ONlBybG85L1lzUFRxdG9CK3RxNDFNNVViZnRK?=
 =?utf-8?B?eS9oNmZVVGxkcklvMTlqMjFJTldJbDlvY2JCV1diU0JTUHMvRGkvaUIwTmxE?=
 =?utf-8?B?cENnckdMeDNLdk52eFc4S2dGN1lXVklKRkIzSFlkNWJtalVSMGJNV2dDYVZP?=
 =?utf-8?B?NDR3N1ViNk9zNTBoWmNpZWovZmxjWEN6bHVxZHA0MHROV3hiYUthcjJzTEEr?=
 =?utf-8?B?bitEams4ZzE4OEdPN3IxSmNVNlNXR1RMOWJYNVF6ZjdTL1ZyNmlBcm1Wemtq?=
 =?utf-8?B?NWJWQnBxSFhGY0RNWEFKZSthUDhzd0UwUlp6TCsyeXhkSGszQ2ZHbm1aM1dy?=
 =?utf-8?B?d0hlZjl1KzRTTkQ3NVk0eVdBcTFRNTcrY0JKd3ZOSU12b1h3OTh0VUpjTlRV?=
 =?utf-8?B?S3UxZ0FQVnhCMWhEeXhXY2cyaCtWTmpQN0JNcVg2U1p1RGo4MGlvSlFXZ1lU?=
 =?utf-8?B?emRxT2JIaTlvUGdYQ2dMUC9vZURGNXo4aDVhRnJLQnFQTkk4QVRNTnU0akhv?=
 =?utf-8?B?SzdrUGUzbTZNekQxSzJIWTRuNytDWTA1eHI0SmtDdGFqK1Fvd1l3L3NNZVBH?=
 =?utf-8?B?TWdkRXdUNmt5MWo0eUk1QXVTM1RoQnYvMzRmVzE5NzI0WDlFSVFQdGVxWTZW?=
 =?utf-8?B?b0puSHZHVXJkVHRpRlNGZTNOQ050ZStsaGlaVjdRd2xGSHorbzl2RG1ub013?=
 =?utf-8?B?b1krcE44VWZzbzJaa2RCajByaUpKbHFBcENtZ1I2bzBOUC9FZkNsMytRNk9k?=
 =?utf-8?B?OTI2STRQWlc1Vnd3U1pDeklBY2txZGpYdDROd0tHamNNajBiV1ZFdWJZa3ZN?=
 =?utf-8?B?K1dUN1BEamNkaER3K3F1MTYxZXZqYXBVak5zVEliMWFwWDdYa1BNeWsvWEJY?=
 =?utf-8?Q?ND/fYYQYdDlJYz9JZdZBOgA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7bfaf2-0cd8-41c6-b08f-08d9d1d584f1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 12:02:04.2056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvcXTsG12KVdkZyIHp9cDaIihQbPtPNFeVoCI6x2rCfEi/QrGrKHJFQ1UWm9vd8oYckD5V9DFabgMG28TD4thA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4577
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070082
X-Proofpoint-ORIG-GUID: j0XMr7G1sj8jroFUGCGr_Rg7ig50OvRv
X-Proofpoint-GUID: j0XMr7G1sj8jroFUGCGr_Rg7ig50OvRv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On 7/1/22 7:30 am, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jan 04, 2022 at 08:40:30AM +0100, Greg KH wrote:
>>> We are seeing the launch time of some DB workloads adversely getting
>>> affected with this contention.
>>
>> What workloads?  sysfs should NEVER be in the fast-path of any normal
>> operation, including booting.  What benchmark or real-work is having
>> problems here?
> 
> In most systems, this shouldn't matter at all but sysfs and cgroupfs host a
> lot of statistics files which may be read regularly. It is conceivable that
> in large enough systems, the current locking scheme doesn't scale well
> enough. We should definitely measure the overhead and gains tho.
> 
> If this is something necessary, I think one possible solution is using
> hashed locks. I know that it isn't a popular choice but it makes sense given
> the constraints.
> 

Could you please suggest me some current users of hashed locks ? I can
check that code and modify my patches accordingly.

As of now I have not found any standard benchmarks/workloads to show the
impact of this contention. We have some in house DB applications where
the impact can be easily seen.  Of course those applications can be
modified to get the needed data from somewhere else or access sysfs less
frequently but nonetheless I am trying to make the current locking
scheme more scalable.

Thanks
  -- Imran

