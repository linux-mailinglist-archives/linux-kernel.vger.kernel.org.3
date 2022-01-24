Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E9F49886E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245009AbiAXSfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:35:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45168 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235396AbiAXSfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:35:21 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20OHvXIB019388;
        Mon, 24 Jan 2022 18:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cPeS8sFguUOnm/0Dl3tfHFOyHBR/JJpW14Igm3EEpEg=;
 b=roSc1gFBYeM3IsNn27qcEVeWMhDMJK5ybvLUw0RKBQ/sl9HdfMQp9qfNW6aesRXxVZ7U
 wspcHvvSnNzYxj5ac5iA2WKt1LE3J9H4LoM684Bcct+AhdP9zIp0Pa03RthTsJht2ssb
 ZO3x+ES2zQtTjOzgG52yvh6GLzEXBksNlihFNmqANAHj9lBMVOY5b1Z1raec+AEFkqsd
 AdHN2dbFDBHXF2FDN1aX9olrU9xUCpY9CmQHCeZrojmPRJdsQiEV3jeo7Pbgj8CS8JdD
 aUjjIwTwjFsjyjF0/yJ0/7tUpmS4Q8wD8GjE7N1T87TxKAp8Mf1Tc7VaS19OY1bxRBtf sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7arjur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 18:35:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20OIGsKS163888;
        Mon, 24 Jan 2022 18:35:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 3dr71w3hca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 18:35:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcddMho1krgZNZRXa9WGprcR1I26//R8mnsohDYcqub5fc1v9FVIOkUNOPXiNhtKLMZiBWk1WMOVp3ZCLETiQSQGB8je3zf8fg+HJy2JT5P6ilT+H8yJZv9k6suv/YIXR+hCcqCsGToc6oNXwMwp4Drd3Rse21lohhx3ayFmyNF+vVZlK5AWogxgbrT9H+0e6A5/G1Q5aKUHAfXcCk+8woWJaqfWu3q559HzJsMlgl26IldMwPybLvg8gbXbG4jEdcl9OhJdoLgDMePOGYEnrAaXLDAqxnHgGWk9MFtJvbWleYRiKTKQjmmqhVCEa094nWwemhTSljEUovN0BTQ7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPeS8sFguUOnm/0Dl3tfHFOyHBR/JJpW14Igm3EEpEg=;
 b=iW8WXNWnrmDDxYGvh+Rr3DDJK6xROfIJGcYSo+B0VPmsYx7SDZBAJjFOPmphxFyT/HfpqN0AmrT7V4BFOTrLocOf8Ukxd9DIa1Dbr+UslK+WLv0IEoSmOhy2CCmIz7jbom7Y6oKgn0Er0ohkoDVVNfJp7ydXuZK5cn9j8vT6G2VIlk69WPWQTqWUmE7cM7gaSe34ySndKL8mFKfF7J/9g/k6/8yHMGVacmsxET1ymCcuXzicwYpGMGPCUWFbJxMx/yMMwfaPaSSXZ4bJsbMMKEa/Rts+AVrGv9NNyXLcvlqyfGRpJAF3JCpks7GIDQZ6UgUZ8tAdAxyJeQbkqdz/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPeS8sFguUOnm/0Dl3tfHFOyHBR/JJpW14Igm3EEpEg=;
 b=A9dGXvL2qPppn4gHZ4jkwuFGUFgV0xzAD7PIfPRjPaPzrc8BUsHhT8P1sZMEATJU3H/60vWVBRkPQa4lDzy+7Zydw9PFVTJZCVwP333mekwoi49Vl2Q4DYroawPD4vMZRg0ryyj8ig/1P0S+w98Qjk/iynO6e5l0sgTFMVBDIQ8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BL3PR10MB5489.namprd10.prod.outlook.com (2603:10b6:208:33c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 18:35:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 18:35:04 +0000
Message-ID: <e3bb7054-c430-232d-7316-bf531218eed8@oracle.com>
Date:   Mon, 24 Jan 2022 10:35:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] fcntl.2: document F_GET_SEALS on tmpfs peculiarity
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>, Aleksa Sarai <cyphar@cyphar.com>
Cc:     Kir Kolyshkin <kolyshkin@gmail.com>, linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220122005251.1441343-1-kolyshkin@gmail.com>
 <20220122090441.ktxh43lpgsd2dxj4@senku>
 <d7ca2658-b63b-7437-9bd0-82bc59c7c981@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <d7ca2658-b63b-7437-9bd0-82bc59c7c981@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0062.namprd15.prod.outlook.com
 (2603:10b6:301:4c::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cc42e74-c776-426b-3e75-08d9df683cd7
X-MS-TrafficTypeDiagnostic: BL3PR10MB5489:EE_
X-Microsoft-Antispam-PRVS: <BL3PR10MB548974754BC2F81BEB3242ECE25E9@BL3PR10MB5489.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brg4yMQkrnFmkA5ouZy5bZFYr+C1RmFo/LSGcmtSEJNquH29Lc3nwp2+32pdaIRvJ98vvJfbb7sYEDRWcij+RiRRL0F/0y8v1OjzGhR5SpMEcnSaijxcHRV3EMBRatrggS2ruHUHIhM3rwODrobmqGVb5QgvVBXNtIaa1DDvFlGbMlr0ggFMZJe8pDR4Lg+oyr3FPqCOyIInxdLunO/5GfMZ5Kaf65VZH/DQfx34LTwQTlr6nVljlCDfZeWgfVI68Uj9T5HbVwyw+fKvdtFVMBH/QULesfK9TJb2apjMgs9SjdEio8RvcusVLf3zC93FV7ZOIo16dqJD5wltHStA+T7nhQ/4s/NKUguVsvBpbmpZOsMziZeJjWgx98tndAMSTYuP6g1hilnENkWRENhoWUtufHHkhosh2OQyOixpSIXbBaIqrgLvVG3aoO4i/2NZvUM64G9aR3NNSZiwMMYDCZqMv5yfVMuDdI6M99xiVuA/GUtq33mlALv2mlUrJmvUdeiEuXcK/ngQQOJqXdaFs/IkYBfsPwVPLuqwM0X/Fi9oWm9OVxNuvyxQ1IVWDaDh5FNivsB+JucStwoDG0G2wkZOLIXvGjiVu6vXoXd6ZRxQuPUnNakIOh13otCva8vRiXPXeRavWVpQYBULu/EEqxv7VI/vlbKxw/ogbs1TXtmZmOGP6LZMUAwsjRPKzPyZ52FZp2h1/QkljaZ0cFFYLoUqSYyXw2VcUNyBXzqCmX0+O/nGk41opixzHUdK43xLb4pmEKMXY+hYKamIlyWZgFjJK/1lW3EYRs7YsDj4DDFX5Hmr1xvgAEsRaVKlYQt3yz/ojPml2hl9PH/FIDTAI5g0wwGHQbyl8AD3zmBzuOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(2616005)(44832011)(66556008)(38100700002)(31686004)(52116002)(966005)(53546011)(26005)(38350700002)(6486002)(31696002)(5660300002)(36756003)(110136005)(4326008)(86362001)(54906003)(66946007)(6506007)(316002)(8676002)(2906002)(6666004)(66476007)(186003)(6512007)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkVpd1lzYmJMYkFhU2lEa2pKZ0VyTWEwWCtMeW83S2Q0T1lleEhXYnY4TVhw?=
 =?utf-8?B?aENNTEpiWUZpRUJESE8zUndzNSttMVgveFl2ajU0V2VzMHUwcHFsalN4ZHZ5?=
 =?utf-8?B?end4NTJsdDRRdGxoNHN1cnlma0dXYTBYazdtZU1hV0pqTzM1eis0dnRLa1Qz?=
 =?utf-8?B?ZXlQdXR3ZjZXR3JZKy9tbVYzdC8zY1JtZ0t0dEd2T3NJS2hWWE1KQTlsQklj?=
 =?utf-8?B?VDg5dS8zT3FiRmVlZzd3Q2VtbkJjMkYwRWdldk53NFFBY2FQTmpPNzRxNDJt?=
 =?utf-8?B?U3piQTFyeUtndGp1MERGZ0FvZG1WWVVZTGJVZjk2N2RsK093SGt2WTB4RkFI?=
 =?utf-8?B?OE5oalNrZEZMTVA2RS9USFJkYnNBc2lTM0RYM01CSklEajdKZ3hCaURVazJD?=
 =?utf-8?B?dGo0WSsvNXZVSkZnM3lML0hmbXlveU1JcmV4MGZ5UEhRN2lDSEpMQys3QmhU?=
 =?utf-8?B?aVBvY2NpVHRzbkFreFYydm55RVhtWmplKzgxcFFmSVd4S2tSQnBVRGZOZEJU?=
 =?utf-8?B?Nm5XQWdFRTIyc3Q1azhVZ21ueWJUdnlJZjh5T0hKNGs1aTVxdXUxaEh2Qk9D?=
 =?utf-8?B?d053bFlMRm1walhucTFPSEJwcm0xYkx6QjFoa0x5UGVpbkk1TzBWMVdLSGEr?=
 =?utf-8?B?Qkc2RDc4TTVoSUVJZGJ1dy9tZDFJOTY5UGtoWWpoeDFnbWJXUmRQYlNlYy9r?=
 =?utf-8?B?c2VWTDA1SC8vbkRWV3lNdXNld0h3UUdNY0Z5M2xONyt1bUQydUw0ekkrMksw?=
 =?utf-8?B?OVFwcWJMSmw0UGtYMGJEUENDVzRoZkNCcVpKUGhTMUZKVXR0aW04dWg1UWJ4?=
 =?utf-8?B?SVRKK1BKdWJ3a1NpMytxYWVGeTFoeWNJeExNTHBxZjF2dnB4WmJnVVFpM05y?=
 =?utf-8?B?S1B6azJqZ09IVEVYS29VN2taMTg1T29UaWs4WGdMY2p4bDJwanl0cjJBNnBw?=
 =?utf-8?B?Zk1oT09xTkM2SHNTaFJmYXR2Y0ZLL21yOHZoUkVWemc3Ly9tcngveGdMSmJP?=
 =?utf-8?B?NU1Wa0kzYjh1T0pjMGkydVAvalpGVzRpenhtNjNVbi9FZXVwVHl1bDBMemlH?=
 =?utf-8?B?dUtmdXNCM2V6T09tNURXb0owb3ordE13Z1FpbUJYWkJtNjI2YW5zRHdkbEJV?=
 =?utf-8?B?MFhhVlp1ZXZiYnNYRGcyZGdRYTZtb3RZTHF3enJNKzEycEtjdVRZWElsMXlI?=
 =?utf-8?B?N3NuK0M2d25Za3hteXQvSHkvNUo1VHVZVXFad095NzdmQUVuaCtxRUxiRDNi?=
 =?utf-8?B?a1pDVnM0UUlHc2k2SStrM0hsVGcvdFNOa3hLZ2NOczJuSE9zU3dIUm5RQjVt?=
 =?utf-8?B?RmJQc3oyaWQrUEJrQmpZT0xZV0djUFhHQytNSEJTcnkya1ZlVjF3RlBNN0xU?=
 =?utf-8?B?TXVhdnZOMU84OHpEbmhJUnRNcnVlK0wvOVVKc3VTWE9JUU4wWHphYi9zeVBQ?=
 =?utf-8?B?K1ByZ2szRU1YcncxaEx1RWtVY1pYY2p3RndsQU00MGNSS2xTT0N3THFzS1NY?=
 =?utf-8?B?SVZIaTdGSEVjWkdjK1A4SnJsOHY1b29reHJueVBQRDdsd0FNZHVvMllRYm1w?=
 =?utf-8?B?UHY2T2Z1WUNpNWxpYkN3VUVYODZjcEVVMUpUV0dYdlpLS1JaZVE0TXR0NnJj?=
 =?utf-8?B?c2FYR1ZhWWhwMzFCaTY4bjZuZWFXcHRVRnFCUnVRUC9WdnpqaVdNZGo2Ym5o?=
 =?utf-8?B?UzhhamVLWjdaTSszNkczemIyR09oRWt0V2xibkV3cW1rY2o5M1dMazZjbGZL?=
 =?utf-8?B?NmVBZTRsbWpwYm4vQndxZXkvTFR5cEdPZG05UjV0Q0lEMEpjTVJ3MXhtQ1Zu?=
 =?utf-8?B?TU93VFJPR3BtZ1JITytNVnc5ZUxOaXdqKzZXNDR3aFIreTllVERuUmlmTmZ3?=
 =?utf-8?B?YmE5M2dsdk1ISFF1VElFcWNvNVZMUlN2UXNoL0MrVnJZNnJyaE1JeEFJMTBB?=
 =?utf-8?B?Rzl4Tm1ySFBpb2FhUFpyN3c0T2VwTTQ4Y3hJZVNuRE9teVk0ZWlGVWVGQjg2?=
 =?utf-8?B?YllBYTV0QWZtR2lCUTNFK3Z0d3NvaXhqT3FVQnd0cmZEaUF2QW1SRmZ5ZGdn?=
 =?utf-8?B?VVNPUDhpMDdYVkUwSVNwVlEyWkpqZUdvKy8wTm1EeVMxNC9sTGFnR0NKbys4?=
 =?utf-8?B?VTFOTXJ0YUZ2cm9LT3hHUDBtWU5tRlpRcHRIcWI1YllDcGQ1bG1sNVZTdjF6?=
 =?utf-8?Q?hdqfcHZH6uAvF+7gjf2SUGs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc42e74-c776-426b-3e75-08d9df683cd7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 18:35:04.1842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yd2mp4yajsSaSsISnO5O+wsfkZq4CRQ9xLUIDq2blghw4KsdVb61e0k5ZBbd6EKJEBYn3lBQD+PKx2F5+wkRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB5489
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240121
X-Proofpoint-GUID: iPGAM3kjrd4foFtIc_P6Mp1B982w-g0t
X-Proofpoint-ORIG-GUID: iPGAM3kjrd4foFtIc_P6Mp1B982w-g0t
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/22 20:18, Hugh Dickins wrote:
> On Sat, 22 Jan 2022, Aleksa Sarai wrote:
> 
>> Adding the maintainers of mm/{shmem,memfd}.c and fs/hugetlbfs/ just in
>> case this was not intended behaviour.
> 
> Kir is correct - thanks - and it is intended behaviour.  Not consciously
> intended to make for a difficult manpage, but the implementation was
> intended to be simple, so tmpfs and hugetlbfs do not internally
> distinguish memfd objects from filesystem files - their filesystem
> files simply start off with F_SEAL_SEAL to rule out any sealing.
> 

Thanks Hugh, I agree.

>> On 2022-01-21, Kir Kolyshkin <kolyshkin@gmail.com> wrote:
>>> Currently, from the description of file sealing it can be deduced that
>>> unless the fd is a memfd, all sealing operations fail with EINVAL.
>>>
>>> Apparently, it's not true for tmpfs or hugetlbfs -- F_GET_SEALS returns
>>> 1 (F_SEAL_SEAL) for an fd opened on these filesystems (probably because
>>> those are used to back memfd files).
>>>
>>> Fix the description to mention that peculiarity. Not knowing this can
>>> result in incorrect code logic (see [1], where the code mistook a
>>> descriptor of a file opened on on tmpfs for a memfd).
>>>
>>> While at it, clarify that fcntl does not actually return EINVAL, but
>>> sets errno to it (as it is usually said elsewhere).
>>>
>>> [1] https://github.com/opencontainers/runc/pull/3342
>>>
>>> Cc: Aleksa Sarai <cyphar@cyphar.com>
>>> Cc: David Herrmann <dh.herrmann@gmail.com>
>>> Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
> 
> Acked-by: Hugh Dickins <hughd@google.com>

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
