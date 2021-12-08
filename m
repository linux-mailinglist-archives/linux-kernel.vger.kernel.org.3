Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B8346DE0C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbhLHWR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:17:29 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29682 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229604AbhLHWR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:17:28 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8Knshk018513;
        Wed, 8 Dec 2021 22:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=C4wtb89sYtZolt5K1seu5QF/N24RZXwQuPIa2+OsJJ4=;
 b=vqR565E3yNXq5IdY1LmtQ46YHONrQK71rSfFfoWFH7QuBYZm+yvbGC/6PC5ljLYWC3V+
 ciNBETJ1nqVqBBO8298ye6/Aw7ih9zHiBU40CrLBRzy5bCBEhmKLhF0oBGCwT7iraNIu
 cEuL0ir7iz9hX2wxV7vY2Ca1pUJ7RZdD+EPywpIdX29CVAqK8uosNcHHrHbzVJEugo4q
 TizF0ft0Ge66iPxQT7wPU/4N6qgyo6D9jLt/Zgx6+nJxaVKlnqq2Vd8hZ4egk1N1DXJ5
 ocNfXdopBiFfRWs3RvNfoM5W+j0z+Zch6Tx8VdMr80Gv6nf9q9Jpkmif/KCFLG+xV2nG 5Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctu96snqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 22:13:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8MBFLL145279;
        Wed, 8 Dec 2021 22:13:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3030.oracle.com with ESMTP id 3cqwf13xwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 22:13:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0+KoeEkIJXnMSfXvXDFhtn8P2wozht55cz50+IIs1fT9D0fPNMRIyIRMs2wspcXfS3fzOpI4uY4VY09KJTH9/vdFKDdz2KhVHmkbVzQIkLacoVW7EGMHSHqixKXGLeYSMQqebl707+bj6+WspDSSXHdTRPRh+FwHXNEXoBgsfaMW1wV7l5ApiMT+27G29sO+QbCRRb6Dm9cu+B07n7A4sYceVoWuKMVO5WxX7+Ll3i5bLZ/Bp/DQTR2Z4V3PC8UjNmohEiaI3S4Nd7tR8VptJK9+3TFBTcVzd0bIBwpn73aIiTRbjHNJedLBWjzF4S6zNzHfAwWEG5dLCxl7uYOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4wtb89sYtZolt5K1seu5QF/N24RZXwQuPIa2+OsJJ4=;
 b=m2CFu03iOdTzIB44hhDNZQWqr53LXC2kIt0irSmJ/02n26n2J+xhTbS3574Mtf+SZMYg2+EiJDc48/e/MBIa6iVm9RjQGeDDfeUeRRJjl54W2ktIKtJDykFRQ5SABkIawDoCU8A8BqR9HNIH03HNxbWz2pnrNpAmtRmsD5Vpo9QQsk9PCVD7qDjt6P3iwSzCthKHWUWo8jQ0D/hrTyhlz6owiU7bXSGfFnHD/lgX+bou6W5XtPrBz5QRCQfBFO7Kr2Tp+PAEdtN+pjCpdQfNKD4rq7NS3r71Mu+m5f+s6tQuZLdF85JR7AF22oTupQu03gy0nbhCLWjEHEdDGqoUhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4wtb89sYtZolt5K1seu5QF/N24RZXwQuPIa2+OsJJ4=;
 b=j392lW2Grj5g+pWhDmXFWdp3lvG8sL8jtkf4POiFURkC+tqusY0rxKdlStT5waF5Xg0ir0vxwcVu8Svk3M2rLINGi6hZHG4RRlJkqOQEsvSDmbFPq3txDJlz7sR0Yx8F1hpV9nmClrjBFOLU6H4clHJnfr0YC/UzV48l7G9DXos=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5293.namprd10.prod.outlook.com (2603:10b6:5:3a3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Wed, 8 Dec 2021 22:13:30 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 22:13:29 +0000
Message-ID: <a10f709a-e8a0-841e-c0a0-f0b896433f6e@oracle.com>
Date:   Wed, 8 Dec 2021 16:13:27 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <20211129194707.5863-1-michael.christie@oracle.com>
 <20211208153420-mutt-send-email-mst@kernel.org>
From:   michael.christie@oracle.com
In-Reply-To: <20211208153420-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0026.namprd05.prod.outlook.com (2603:10b6:610::39)
 To DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from [20.15.0.7] (73.88.28.6) by CH2PR05CA0026.namprd05.prod.outlook.com (2603:10b6:610::39) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 22:13:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84237b40-9875-4af5-6750-08d9ba97f6bb
X-MS-TrafficTypeDiagnostic: DS7PR10MB5293:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5293D65B33E1ADBA943B4B1AF16F9@DS7PR10MB5293.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXMCfO0eq5hJiy4EgL3biw3J/BqHghQKwLirzlWfnAuvtGnb6BZGant9+e0VfIpmgeVLQaYC5xQH2CZrB0k0WUUTm5N+TXEsj8kV3mifEmcuFiMX5XeOJD7BC4Ev3uT8RkWuI4A75XqzadzW00z6u7tYJgU5XMcK89zTQMSNoXnuuwbDbmit2IrG7Z4gYqjcdAm7AAYhLCtKartJm/0cumu13RO8H933+mDY4rkdUvPahS1c/GPZfFSiic6xBoDQ9ufSpaVlblKhvQDPzcYzjtvS3aueg6cndb5YqudZT5fJKtdZt2RGh2BruW55o8+/OC2y/Dvg2SkT3u2hpNajKbk08vkJ5QjN/tAVWzRqpJmIvngcso0gTzU7NXNupKCqpRK4RXF0z87ZiDw5yZP9Zlg86Tip87otHLYJyHfhyjXoMP/f3HRtL2pR1FYxhlGJxCOauTxIc5B1Hzq9AfzN4/W/m0JLRyr0Qwy/F4p57uHcUJUo09mEG3ew4zv1+94KWZxjBbCsHyf/OfcGIjc5SzkwH6XfE0910oIdnJljhjoUuzlfEI0WN2yK/MSmU8LFgvmNpO/QbEZhrS+ft/jteF3FzZbsj6SJ6ioyfNhIdNdFOiNzscp4aDp7wFJQwiPh/f0l+mFEpqLmjdEgJc0kY8il1DljRpIYjje/6Y2+EGKx6xP42KNzuuvmxFRZba0dZIcM70c6yTCA1Ea94SLgigPhJRgINIK5qeayX08xlQZYzCSD1D6ueY0AlfwaXk0VmhPzX2DTZhdysJBjYGYpwdy/Idv0JMwhynNmoaE3VPwuDVxSobeYWVTQ1woKsdfi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(53546011)(6706004)(8676002)(4326008)(5660300002)(8936002)(316002)(86362001)(31696002)(956004)(2616005)(508600001)(16576012)(26005)(38100700002)(966005)(2906002)(9686003)(6486002)(36756003)(6916009)(66476007)(186003)(83380400001)(66946007)(66556008)(7416002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vmt5YXZUem82cWhnb2VMYUs1bDR4eTNXQnpzc0JYN0liNnE3ZjNKcFhPUXE3?=
 =?utf-8?B?b1p3K2g3dmk2QjhrZUpKTy9CZnByOTZ0cFZkL0JjZ1h2dmFNZVpzNVJ6eDVz?=
 =?utf-8?B?K2tPTHV6OTFRbGlnZk44d2hiYzN0bUMxbjk1ZitqTURzUjhidmxwWjVLcDg2?=
 =?utf-8?B?dld2SWpKL3NzUEFuK2ZMZWRLMk1ZaC8wOVUxNEo5L1Z1OEcwc0lTa2EybHQ3?=
 =?utf-8?B?ZldiUUg3dTdhcU41L0FORU5PdEVWZWpieTk0Nm5vM3FBdWpwWVVVdHZHY01o?=
 =?utf-8?B?citHWEREYXNSZXZ2eXh4T1ZQeGdZaEU2RUFrQ2dSaDlPUWpuTmJvemFMcG9n?=
 =?utf-8?B?SU9BYllyblVjLzJCZVJ5ZDVMTitkaFNEd1dRVFdJbHQxUFJHZUcvSHIySDRp?=
 =?utf-8?B?Z0V6V2dRa0ZMNHM3V0h5THNzMS9sMjNEQkNBemRHZWlVZng5WjQzVHNLK1I4?=
 =?utf-8?B?NGN2WUN6SzM5SzNLZ2JzeGVDdDBOSk5HYnRzakErTEVlNkZFMVFkNS9LMXJn?=
 =?utf-8?B?R0V1MldydTVVbHlSaXdYSkViS0Y2akhYMDFQZ2ltUmVpcUk2REJTUkU1OHZw?=
 =?utf-8?B?OEVaSzBpSDNob0k1V0RNeVNNN1JrVXJGNEY1MmVJRmJTelZuUENSOXdjM0Y4?=
 =?utf-8?B?WlByTkJkQjRnWktzVU1tb0hSVHdiaTlGWVlsTnNGajIrUStWTC8vWFVLTnM5?=
 =?utf-8?B?bXBPYjN2Nllra3l1QkcyVFV4dTV6aUtmZXQraUlSSUE0dFdXQndtcUI4WVhp?=
 =?utf-8?B?VUx2dTFKUS81NmtDU280MkVxUkRnSEFEbTVaQ1JGMit4VllDUm5NYmk1MFZq?=
 =?utf-8?B?ZEFURVMzRy9md3F2Um5ETlVyaHpzdk4vOFVpR3EyUThkdDh2SVRhM0plWitP?=
 =?utf-8?B?L1JvMm84VzFpY0xPY0JLMUJLZ29sNHN5RmZEcy9oYmNKcmQ3MUpEN3ZweHVr?=
 =?utf-8?B?WG1kUFZBZXBtditxejlRdXNpbUl6VEx6OUhpTUpmUmcyajJ4amM2djFjd2Zw?=
 =?utf-8?B?Z21LMmhiMFNOcFpvZ0hGWDVtZldIemJ6WEtJeGFZNTBLSDZGcDh1aDAyb3dK?=
 =?utf-8?B?Z2Q1YkJOUFc2R3Yxd0F3cmo0NWtCQXpLT0xxRVJValFGMTRVOFlhM21mYVNr?=
 =?utf-8?B?cFdYM0hDNkd1SlcvVmp5SnBKYWJ3dUZQSGNHcU91VlNQbXg1UVdUOERHVE0z?=
 =?utf-8?B?M3ByUFE5RkdSOHE3bFlhL1pmZlRSbGtyK1Q4d1RxYVhSY0twZVUvVTkwVFh4?=
 =?utf-8?B?eCtrbGtTYWM5YTRRNnE4SEk3dllxd3c0dmdZeDhSbzBoMTQ2MHp1Rmx3RGY4?=
 =?utf-8?B?UUM0dFo0YW0zSy80bnBwR0lrOWFkdGVCdElzanFET0hmcDJlYjYyUURCcGhm?=
 =?utf-8?B?dE13ZVJqclloZEMzVXBCaDlBMk1qREpTcUwxSEcrdldZRDVCbWZDSXBGNDRT?=
 =?utf-8?B?bS8zTHNhRWVySnZRT0hGNGltekVKTSsxWkNMVmRIQjhWR1dUbUpycHlqdHF0?=
 =?utf-8?B?UGJlR0ZCYm5WcWhhWVREZlpkWFREWVdvcENQZFNUY2ZqV3psZUJ1ZTYxa0VW?=
 =?utf-8?B?Ny85NTFUZW9hSVlyR0dRZGFaTXpDb01EeTdjcUE0OEhnWEhuQlZST3BKcDdQ?=
 =?utf-8?B?SXBqaXRoN3JaSVlEc0U0RHkxb1p2K2NScWdkaFFiaGt5bXBrRUJNOEZKV2xr?=
 =?utf-8?B?YmJZZDRKcFRJNGFMbkxHenBLcDh5Rkc0ekNEY0J0aGxHOGxlOGVxcE9PbDlv?=
 =?utf-8?B?VWdWSWNhTy85ak12M09HbnpEOTNLYUVRdjZLL1dVKzlGcVM2Z25vYmlNVndR?=
 =?utf-8?B?MERDRkhHZHVYVXZ4QkE3RHNWbzNZSmN4M1kreTArelkyUUFraS9MZVZYQzhZ?=
 =?utf-8?B?SDlXOHBOQ1lmSGxpZ3NTSTljWE9IWEhyNDZINlFHdit4TzF3eHU3ejVCVmhW?=
 =?utf-8?B?TEJqTG83S0lySXpZYnhNeC9GRjBlbndCS2lxb1BLTkhhWk1NYW00TXlaV1FK?=
 =?utf-8?B?Qkh6OEdoaGlDUjcwQ1lLU2kzc0xOaVR5eDBHdkZGdmR3dXNyVE1rQ2s1TXli?=
 =?utf-8?B?WXpGbTk1cG1KK1JJeENwUlphTERKblpPQjN4OHlWdUo5UlcvcVppc0ZDTUFq?=
 =?utf-8?B?OWhWSzZZK3ZzSDZXazd2Vy9KeGJueU9vdWduNFhsZHRkb3Mza2wzRks5cFM4?=
 =?utf-8?B?WG5ScFZUY3JLaGZDdmdjc01JUHFOUUdwTWN6cTVvcjVBYnlocEJETVpBUWps?=
 =?utf-8?B?aTRPMGQxalVvNmlCemVKS01jT2xnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84237b40-9875-4af5-6750-08d9ba97f6bb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 22:13:29.5359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwNW4+LqsOATlU0XhgSq5tMQnKequmcsIrDm3A/i/fIvAUCFLCxI9woOKXXruS3OEnlIYjld8DFeXycxMNlsDatqTewhnWsWVFfRBl62s9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5293
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=903 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080122
X-Proofpoint-GUID: 3EHH5hsNclsEDtRnHuvg4N3WhvfbwqqL
X-Proofpoint-ORIG-GUID: 3EHH5hsNclsEDtRnHuvg4N3WhvfbwqqL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 2:34 PM, Michael S. Tsirkin wrote:
> On Mon, Nov 29, 2021 at 01:46:57PM -0600, Mike Christie wrote:
>> The following patches made over Linus's tree, allow the vhost layer to do
>> a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
>> io_uring does a copy_process against its userspace app. This allows the
>> vhost layer's worker threads to inherit cgroups, namespaces, address
>> space, etc and this worker thread will also be accounted for against that
>> owner/parent process's RLIMIT_NPROC limit.
>>
>> If you are not familiar with qemu and vhost here is more detailed
>> problem description:
>>
>> Qemu will create vhost devices in the kernel which perform network, SCSI,
>> etc IO and management operations from worker threads created by the
>> kthread API. Because the kthread API does a copy_process on the kthreadd
>> thread, the vhost layer has to use kthread_use_mm to access the Qemu
>> thread's memory and cgroup_attach_task_all to add itself to the Qemu
>> thread's cgroups.
>>
>> The problem with this approach is that we then have to add new functions/
>> args/functionality for every thing we want to inherit. I started doing
>> that here:
>>
>> https://urldefense.com/v3/__https://lkml.org/lkml/2021/6/23/1233__;!!ACWV5N9M2RV99hQ!ceUHd4m4MTJFOGccB9N5r7WonxVoYYT2XPiYwWt2-Vt1Y-DmQirRN8OqKozFLN1h73N6$ 
>>
>> for the RLIMIT_NPROC check, but it seems it might be easier to just
>> inherit everything from the beginning, becuase I'd need to do something
>> like that patch several times.
> 
> 
> So who's merging this? Me? Did all patches get acked by appropriate
> maintainers?
> 

Not yet.

Jens, The last open review comment was from you for the name change
and additional patch description info.

In this posting, I changed the name from:

kernel_worker/kernel_worker_start

to

user_worker_create/user_worker_start

I didn't do the start/create_user_worker format originally discussed
because a while back Christoph had given me a review comment about trying
to tie everything together into an API. Everything having the user_worker
prefix felt nicer in that it was easy to tell the functions and flags went
together, and so I thought it would handle his comment too.

And patch:

[PATCH V6 07/10] io_uring: switch to user_worker

should better explain the reason for the switch.
