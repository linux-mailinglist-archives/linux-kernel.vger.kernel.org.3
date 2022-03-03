Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1A04CB53E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiCCDJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiCCDJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:09:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB432A243
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:08:46 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222LxKVP003862;
        Thu, 3 Mar 2022 03:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0JKAGs3MiNxef5GYhfLD8+bmnlGOpcQDgUTuRCZOkVk=;
 b=XusE4418O5AjnPl6RSRLx2MWuuij592HiHb0iB2zb8omhfXULsQ++1b/tnnrVEgSjlFJ
 rQhiLFbQvT8Dw5+BHPnrxCHwZDC8FbKGHr9RSh/Dy/YdANXn8yCduaL1R6Af9+1FGJB+
 qNOEww3XYNkH9nLKIBSTDesrhcpnI4M6jBTvzHsGFhxaUtNAysZ+lKwyh/GkTqcEnJXF
 wobT+uo/a9U2JcTvtbA0eZsG8yuenAEKI95EIQSxqxbfAr3c10s7Qu6BcU1WJV7dso93
 8Z5C77qYPPtPWL5ZTwGb4N9pIP7G9iR+UxEIpsO+3yU0RpENe23gPNXZtcBLxL1/xkSV vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehh2enhec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 03:08:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2233644T090987;
        Thu, 3 Mar 2022 03:08:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3ef9b295es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 03:08:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQUfFNJgq+r4bL4YenYyxXOEwMsqlAX83ZK052o1N+lKF8WbxUAA/5OXcZUx7kLxrfGiUQmrKDeOLrAgeZskPGEXnG7Dtz0Px4qRCdGNCHqmEMOay0QQKeIKzIAHjyR4CwyMCeZXf5off2/aClgYrIlvh63V3c2gvymFynXtnMlBVrlGJzw1LlmkueMUEnXDNd4Jn4V82cChJ1fdoGSkboHyyvdM8NVO9wRNxvbwD70kLohaIWnla59uT/aHsgEzQ5TMSozjkY5zQthi+ZxwuubTJeNovYFWlFkJbmLXqIoNaYJedZy7yqkbb1NR4V7okmv1CDD1iakNnrtH+nVZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JKAGs3MiNxef5GYhfLD8+bmnlGOpcQDgUTuRCZOkVk=;
 b=g9vZ60U9ynTe6fB6dYOjiy59KGaPYx3vJB2sgsBQpVKkXKfYv67Yjf7jJG7DxRU9jvKsAM7FAQqmLDEMVIFKqo29mi6OLKT1rYr3vFAw2aeWS+zXz3WaHQ6DSQqyiiD4TxjsS3ZT6Va6XqcU5yDHg8R00jXIlGI1jLY4HgXG5FJ2eoQq1lqXp+seRkLIpirMesi7SUl6BllLD9ozfrkTNbwC7C78+NVRUU1Qr1j6UrMtDzhPr6Gn9laMpnBn49+0ZWLohzPu3r6uOQW67J1w5A82bIs3mg4dsVaAKbQzOqPR8qKPQg5H6xQlqbUtYD+Obs/ZsOESbTZKDi1sy7KPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JKAGs3MiNxef5GYhfLD8+bmnlGOpcQDgUTuRCZOkVk=;
 b=VyxphKp39ENkdx0Ia7xDhDBo1KfP/Z849Ltmzom8tn+QM5oadxPwXLSo+Q0Ye9v4k3/1y2qzhYuz1A1YvWXm+mCrN4WiZCXGHLSqltsM8a8wdcfIbUtPmeILokxs6Az/eusvWxyhWgqkjBuIZxqQlhMjyDZAyeaGchTqjL8GxfY=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BLAPR10MB5266.namprd10.prod.outlook.com (2603:10b6:208:331::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 03:08:15 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47%4]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 03:08:15 +0000
Subject: Re: [PATCH v4 2/2] xen: delay xen_hvm_init_time_ops() if kdump is
 boot on vcpu>=32
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, joe.jin@oracle.com
References: <20220302164032.14569-1-dongli.zhang@oracle.com>
 <20220302164032.14569-3-dongli.zhang@oracle.com>
 <bacae45c-9f8e-456b-1036-7f68e1e4374d@oracle.com>
 <0ac50fb6-0aca-e61a-1f38-8badbc8c967a@oracle.com>
 <272a69ec-4cc8-f282-8499-88b24b61f130@oracle.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <a40326c0-bdad-da76-9271-61bd8f3fa436@oracle.com>
Date:   Wed, 2 Mar 2022 19:08:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <272a69ec-4cc8-f282-8499-88b24b61f130@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:8:55::24) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dd4993f-b93a-4d1d-c0a3-08d9fcc30f2b
X-MS-TrafficTypeDiagnostic: BLAPR10MB5266:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5266F505CD7D0F753BEEF1ECF0049@BLAPR10MB5266.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXXVbXnt1iqnTFIJaF6PAe1n1Sluxi1QDWvw4OXG4mW4sV1zO0xNARs0SRI2MD5TDnVoIegdET/t3LfyI1M+s+EMBd1PbCn/CBXu7UJCFH1upYtjRhwfUl1tSAQItRW2G7fb/yygM+X1sjz1/6BKT2HYnFVjy3hvCHXlTCbhmxQNL14M+YNXP8aYzdISXMVazoB7OI8L3+i6K15OWQVNBw1ycU3M/GVlDNe45wlGHbLgfmiFqkYzeUVlsgwjZ4N3Jm37/ta72AduAZVk1ajYLbc82XeFK+5ohCGq7tS9vFcrWZgNmVpkYW/Y890ByiLtfOC3kthZ8iz+sllBI7BvfAxVhIsUzDV5io5wI7FQ0Ed27LNPDHqRYK35XTO7WMhppaklYGSXfdQEY771QjOTSvq0mIDaFw0AGWa/Uh6TItW38a5vmEHM8aW+1hE3ShGRRrg5jbMt2g23oo5ePwPhxZTiR0UtWaIDN1f6YUnU9vYnHPKMdVz0Mj2glViY/Ti/Qpa+V7mPxbmNurq1XGdCcMHUeOnPnCpRlz5PB4VX2/yjoB97Y+AH2NFLrPJZaQEM5yp7vG/wSPpaznQWV52uKaz8qui44C/lxqD9eivnjXGGXy9rb+RXiNWhyPhy4A/0ZlMdEd2GxhIp3H9LH5DFIQnzMrK+quKG4JrZdNWlv+R/2sFTOOHRWfaPNtjGvAj3FZ2QD8FfxyDNg0pjYIaGreeEbgO+jN8z/kh7mzJvQSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(38100700002)(5660300002)(6512007)(86362001)(6506007)(53546011)(186003)(83380400001)(2616005)(316002)(8936002)(8676002)(4326008)(31686004)(6486002)(66476007)(66556008)(107886003)(508600001)(36756003)(6666004)(66946007)(44832011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjhTYVlZQkZVYS9pZjlGdWdtT3R2V01XUm5YQkFNZEVQTGhaMHNEcG1DMC9w?=
 =?utf-8?B?TkFONm1qenVRWHFSNXRmZWsrWElZRW9BamlRM0NSNHQ0eGRkZmlkaEQ5S01I?=
 =?utf-8?B?RTY4QzFWUktzdXJhYnJ0YmNyVlUrdHpVWXdTZkFZQnk3ZXBES3VTM3dvc3JL?=
 =?utf-8?B?ck82aWM4Y1lSejEyUDFNSmpkZHdvWjl1OC8wOGlpcHk0Y1lJZEpXUkhmc1c5?=
 =?utf-8?B?Tk9lYUdFWnlkWnUyazBsRW9Ua1YxSlFFQ1k1dW9laWZQV0RTa0xJaE1wR3ND?=
 =?utf-8?B?Qjk0cTlxQVlLenNhekVCdUhFbWdnNGxKdk9oa0svaHFsUnNSc2dvYWdDRFJV?=
 =?utf-8?B?TmhGSjhzNWVJTzl4TWRRYmVwNXVpcjZMaTh1bEkzbGVTS1NLS0dzajdhNGpl?=
 =?utf-8?B?Um55TDkrYlJybDJwWDlRelZQTDBZNXJOUnZGVXo4cnFRdnJBMEN4OGZUSEsv?=
 =?utf-8?B?b1pwTEM0c3ZLNWp5cTUxZ0FIdmZQVVZ3QWVYZ0RkemVhVWVhQ2IxREJkc3JF?=
 =?utf-8?B?YXpxTUYyWldQK2twUU8yOCtzNHRlRXJCdVp0U2NVaTlVcW1reGh5M0g5eWxQ?=
 =?utf-8?B?dS9kV21FVk0vTGlxajMzNmQvUkVrMFdmNlZvdDJEVW01SHkvenRFa09uODRx?=
 =?utf-8?B?Q2VsYVEvSkppcFJ1WWFoT1pRZVZHeHBPbk56VkU1NUVZSmQ0enB0VVZPQlF5?=
 =?utf-8?B?OHozV05DNnNoWDMwdWluZG1WVm5qejZOZjRtc3ZXVDVhdURUaG9UVFlrVDdn?=
 =?utf-8?B?WWdiVHFobzMwSDc3Q2F3ZTJENEM2ZlhmZS9UOThrZmJkdy8vT0pEdWNTcmx5?=
 =?utf-8?B?aWxLOFp0VHdRUjZYUm42cHVXVFRKdVRXRVI2UnpHWE55UEcxZHY1YkpsYkdq?=
 =?utf-8?B?U1BwTDRDQXVNVTJQcndaekZ5Ri9IWWJISHpycjA1S0Zac240MXorL0pGeGlS?=
 =?utf-8?B?bTBHdmlCc2V1SmdNUXZ6WTZGcjNWNFl0YVRyaWtsYWY2SWh6ZGpaTmF5cEUy?=
 =?utf-8?B?UW5MSDh4WmlyRENlMjBpai84N1lHZ2lzV2x4NE5ZSDRoODVHTmdKWElRNlZI?=
 =?utf-8?B?UTFrWXBZa0ZlU1c0R1ZhSEU0K1pVblFBSFhsb1VJbkZmWDBYRUlheXRDVmEw?=
 =?utf-8?B?TDVXWHFwSXlDMHRmWEs5SW5FdnhFY3FOUmdTbE1QUzlUQ3hTdU15NlB2Mytt?=
 =?utf-8?B?YVNZSHRzcll3ZjEyMGFKMkttdE5ycG9iTlhnRGF4VUJXaVdPeEJpSHUwLzZL?=
 =?utf-8?B?azJCOTB4OG9KMlpZelFzTGxPS2RreDVwcTVwRmVhSzJWUW5uWWFLNE84QTA3?=
 =?utf-8?B?QnUrdXNEY1NuMmhsdmVwWFhNUnNERnFJeFB2N2k4NXU2WUpaQjBDN1AzSjVR?=
 =?utf-8?B?b2xNY3pueGdXMi9Nb1ExVzRhd2FqazQ1akc3SUhjcXRjaFBLbjhKZmZienhv?=
 =?utf-8?B?YVkwOTVRaFVZOEVsZkJjd0lETk0raE1YR1BYNVhybmNERjY4NDdBY00xOXFQ?=
 =?utf-8?B?SUtDWkVNSXRXMTlsZ3UxOGdmRkYzTmF1OUdxbVBpOGtHdnc1UUhXMnpzclZv?=
 =?utf-8?B?UVZ2Q0hocGVJZkI0TUFzaHIwZll3eEJPNmppNHE4VmwrV1FUVmgySWtyV01H?=
 =?utf-8?B?TS9MVERpR0M4K2pTSGVMNm5DaFcrdlRZWUxZSklMUkV0MHo3cUZLeGFFTzJr?=
 =?utf-8?B?RmRnQTYxTUxVVFVFUHI2RUl5V3NxU0s3VkdqdGpXZTZjS2llWmdRVzVsa1hW?=
 =?utf-8?B?RTg5R3hDWlVMb2ZUTnAwUWJhOS93YXg5azFuQmNVaGgrTDhRUllZeDhCSWFB?=
 =?utf-8?B?c1piTHVSY0VidDNsTWF2aVB2UWJzRDNQMjRhWWJKblRwc0JkZjZNamlPQlBH?=
 =?utf-8?B?dXNwcVM5bTNJLzlaS0xoeXBnTWV3REdiMjkxdFB4SzNoZmExOGtBTzJBMXZk?=
 =?utf-8?B?alJ2Zk5kMnJ2ZzYxYllvT3g5VlA5K2tkL0pycytvc0E2Z0ZCMUdRM3VMckRE?=
 =?utf-8?B?cWllSHhGRWEwN3NpS2VIS1lSQVpIQ3ZabmwwcEQ0TmhnUWlkemoyd29DL1A2?=
 =?utf-8?B?dGFBK2JoMU5VWS9DYlNpdW9wMWR5Yk5sb0RtK3FxdCtybVdjcENOV3o4R0VD?=
 =?utf-8?B?TUViTmMyVk5FMnRlYnB0eTRCdk8wSDJzUHdWRVRES2NqbDJlYmZsV1ZGWHEz?=
 =?utf-8?Q?YLJSMCbGyYczwRnpZ8ylwURsCrwqL6OsQjO+/o2YL32K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd4993f-b93a-4d1d-c0a3-08d9fcc30f2b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 03:08:15.4389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbpf01CTvl83xg083UnYxM6arfRYKrx/snxv6Nq2+2pJtSJbsbV6Z9CIR4JcbdivwxSBRavh9pbg3xoZ6Et2Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5266
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030012
X-Proofpoint-ORIG-GUID: RB8ru-RFzQv-fnzFJG3-adb2CHHvpdIW
X-Proofpoint-GUID: RB8ru-RFzQv-fnzFJG3-adb2CHHvpdIW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 3/2/22 6:11 PM, Boris Ostrovsky wrote:
> 
> On 3/2/22 7:31 PM, Dongli Zhang wrote:
>> Hi Boris,
>>
>> On 3/2/22 4:20 PM, Boris Ostrovsky wrote:
>>> On 3/2/22 11:40 AM, Dongli Zhang wrote:
>>>>    void __init xen_hvm_init_time_ops(void)
>>>>    {
>>>> +    static bool hvm_time_initialized;
>>>> +
>>>> +    if (hvm_time_initialized)
>>>> +        return;
>>>> +
>>>>        /*
>>>>         * vector callback is needed otherwise we cannot receive interrupts
>>>>         * on cpu > 0 and at this point we don't know how many cpus are
>>>>         * available.
>>>>         */
>>>>        if (!xen_have_vector_callback)
>>>> -        return;
>>>> +        goto exit;
>>>
>>> Why not just return? Do we expect the value of xen_have_vector_callback to
>>> change?
>> I just want to keep above sync with ....
>>
>>>
>>> -boris
>>>
>>>
>>>>          if (!xen_feature(XENFEAT_hvm_safe_pvclock)) {
>>>>            pr_info("Xen doesn't support pvclock on HVM, disable pv timer");
>>>> +        goto exit;
>>>> +    }
>> ... here.
>>
>> That is, I want the main logic of xen_hvm_init_time_ops() to run for at most
>> once. Both of above two if statements will "go to exit".
> 
> 
> I didn't notice this actually.
> 
> 
> I think both of them should return early, there is no reason to set
> hvm_time_initialized to true when, in fact, we have not initialized anything.
> And to avoid printing the warning twice we can just replace it with pr_info_once().
> 
> 
> I can fix it up when committing so no need to resend. So unless you disagree

Thank you very much for fixing it during committing.

Dongli Zhang
