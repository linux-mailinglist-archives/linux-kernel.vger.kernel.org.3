Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D20468FD0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhLFD4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:56:32 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27294 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236787AbhLFD4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:56:31 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B62d8sF016430;
        Mon, 6 Dec 2021 03:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lG9uKQqReqL4oXt/CZswVNRlAwGA9wKIRZCm7eRdBxU=;
 b=jscyWJtPqApq/ticErqVezzoBNdM1gvIjOYqROttH7KQUzqs16zxlBLPDzMhqeN/9fqN
 lvycQW4XMrhsy5Bo7p29SWwXmteyVEKaui1uFqsQFuCqRo8ZTbDkYS5qHr/yYDZ3X72a
 09nB9fF/kE55RhXGd04RD0+IpkmbcxsktoGoaDkHsa5ON3E65q0hz3GVQCoxV4DPPd3z
 sb2YX4wx+4bcJ6bCnG2BNfmJWZBlW9+YrRWNN4OplhGK+weSa9Bhn6Off2ZpigbxsmXR
 JvwJ16CpHbwnxqfzoCCdS2ip3MGON9G1zPIyN0wg1VM9tVBbCKQH17aEyT8wslKTx5Of Gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cr07actc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 03:52:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B63q2DH077862;
        Mon, 6 Dec 2021 03:52:02 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by aserp3020.oracle.com with ESMTP id 3cr052ssde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 03:52:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhygKAH7oYd7TQUlXCX+/JVHJEbzhhWb2CDgJZSdZcZ/FY3fgRJZHtvQQbOoM4vr6JlBJAeMmSQHNx/7fbN341vk0QWieLn8rZOsL6iwY4ftEMhXrO73qqn1nI5ptaGREW1qIWp7MPbkYCW7WAuxKuKxUK+tmFWrBb7V9QjWz4ehYi5+UAMHac1QUxirCXdqG9IffsFGFvW1KMbLcIYGpD9lxRD4m1WgrXy3ShuLpFe2e1FMacpoM6DsI2DHl6RfL9XA6LSGungw0ZVr5YsaoyEwFnyYcUYOHFz3yMafAlXqcde43gY+dLQuE3i+bgxhcS1Hg1rYvWyCzl+URV/yxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG9uKQqReqL4oXt/CZswVNRlAwGA9wKIRZCm7eRdBxU=;
 b=ED8xGroINiX9VSADlD7LNnYDDwqmqdHKerGU3cY0Wo2iOaLT9nx4Lia8bkQJYy5wrFmzlfPUYMZNZluU4BTcTnpjuKYgrU7Z2oSK2SVhNPtcwUapREukWNnqAoTXGdD/zfVBu18mx9SVhOUDtJ0Ma9FIjAOOkk7cld5DnleBL7e2E0tc3QOuTLdV6fquU1/vt6TXW3l5+DE8TkwPaXbl6RSF+FMC9SmyAOXYH0QJGmeh/43SDaE6f8Oqt0rMGcmb1+kisHZs4WJKH0QDjGBCwtY943RfKx3tNEko5ngr0KxMPhIBu+jY5xRtJMEsu7WdW8RxphI2vMjtibYMhv6LwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG9uKQqReqL4oXt/CZswVNRlAwGA9wKIRZCm7eRdBxU=;
 b=ZBsHeG4C7DAbF3wkBr8naGBlhUAIxcycOtp+siHkJZLm1qrxVoEEwLcDhyv8GBEgnpfDwNBW+keOKXxSBTDNahwcYPw3bpeGoFKojwGfdtbvBeN/HE/en8vIdHXjWi4E35InR17H6NOA8UX2i0EO+wJIVqVUBw9/+/zDw1dWfK4=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by CO6PR10MB5473.namprd10.prod.outlook.com (2603:10b6:5:355::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 03:51:57 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%6]) with mapi id 15.20.4755.020; Mon, 6 Dec 2021
 03:51:57 +0000
Message-ID: <b71cfc4d-1035-e6e3-cc85-fcbcdc20f937@oracle.com>
Date:   Sun, 5 Dec 2021 21:51:47 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v16 00/11] support reserving crashkernel above 4G on arm64
 kdump
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211123124646.1995-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::35) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
Received: from [192.168.1.114] (47.220.27.44) by YTXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 03:51:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e8d678b-5ff3-4142-94e4-08d9b86bbfaa
X-MS-TrafficTypeDiagnostic: CO6PR10MB5473:
X-Microsoft-Antispam-PRVS: <CO6PR10MB5473A4E3712FBD12D3B55DFBC76D9@CO6PR10MB5473.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERZcbdUUns8bGqbfjYSaGq0/yaAla5mseXUabDFcSNv42fXhef5QcY9pakW/GrQmRpAWax/1QQAKx7fES/eMNS/vUIw8MH0Z/l9m86eEBp+QDjIgft7a2MpyHZNB/+99rvr7GyJLjcKlYG/lLGLb+SYsc5mgnABrAT+0McWvOFfdJj6iG1QWyrn0wqpeI15Ya3tZ81NI5d68Io1iBYF6+Tc/l7mONjyfw0imEvTgmUE6IxFAcZZD4xkuK5Wrs2DvtOr4SzTtYm3swpCG8CJuUXHS/adNloOSyufS6wCg8rM2R+9+v1omPcO0DhV7bHLoKCBWKlgOa6ZVijAlYGDl3bcpJ/ipoVbn10uPp8qUq9RhpwkaCygos1tY+nbzpo1DnJvZ5+C2j5mEtu1HXdQNwbNw2RwJeXUMyWHwVWv6tBsE22zZMcqnxqSUxYK6j7BIxV3gyl9BhNSMLgWIWVYCh43/qkSKJzx0oO3Ep7w6OBIJjQwQjQF/MB110M8//3rEWN7NsjFyVuad4wnY7HAr2txCDH4te60gMBmHkve48LffDt3mxjTdKT/RnsG1wKGG9ehDsxgM98bZw9279Q4PS+7i9dmHfwEKbnNtFsnf0WfhGhnIlV8zsKiuMNSfHBYB242xYwEszX+8oCahrgJloG2EF7d5COmY75aUTLH+gwhSzD9Vhp6uH/LJ3x4foF3Eml05WzcPXXfSZp0dDeELlfyWXObLyn0lhjPK2Oa7cA0hlckLRkoj0Mt50aQ1QLErC7HF8AI7cgpppIqVxK3S6coW0Tm5/TylDlGdKaiDpfKE79WSlg+nqntBgSIuk0INGd1kv+K1yN57W0N/h6rRZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(31696002)(66556008)(186003)(66476007)(508600001)(53546011)(316002)(8676002)(83380400001)(36756003)(7416002)(54906003)(921005)(66946007)(86362001)(6486002)(956004)(2616005)(16576012)(5660300002)(26005)(2906002)(966005)(31686004)(9686003)(110136005)(8936002)(4326008)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1h1ajRFRHVnNE4yak0yWXozSGk2emo1VVgvZG94L0ljQjdsZUpDOGthQWtV?=
 =?utf-8?B?YlRNSnozRkI5dW1JSHQ0em5FQjIvKzNnUEpVc3Jhc2hZeUZGbTRpTk1iYkRy?=
 =?utf-8?B?V3JlTEVLSTQwUDhOdEIxdG9OWk1tQmx1K0YrbnFhdWdLc1RXdkNMeFpDV3lY?=
 =?utf-8?B?T2MyN1ArMG9KSml2eXRkOGxUcU9HRFZmbWdjYm11VzExelJnaGw3STlsT0Fk?=
 =?utf-8?B?OUttN0ZlSnpqeWU5bGdtTGJyTFFRQzJjYzJXL0xXaW1uU0JjU00ybS90enMw?=
 =?utf-8?B?WWxlUmNsNUU5N2RiazRmVzhSem02NGZ5WTRQM21UK0x2aVlmcFF4ZUthcXZv?=
 =?utf-8?B?RVd6dWdEeDRpRlZQNWpPQ1ZodXlJa1hnL2FJTk9jSWQvUlB1OTJ1eG5uWk9N?=
 =?utf-8?B?WndDalJRYkFIZHJRcy94aGNFOE81bU8rM1huM2tsZ3lDYW5sbXFoTDJmS2Fh?=
 =?utf-8?B?ZjhMSHdNenNMK2txVjVNeG8rcUpMMld4a0MvSld2MVk5VTNFb1cva2tjaE91?=
 =?utf-8?B?VFhKS2wzMVFMNTY0WVlmQSt0Zlpzcnl4TU5sNk1maFhLaGdkWUFuTFJRdjBa?=
 =?utf-8?B?bVVhQnFFTzlGejVlWU9yTkZvNS9lV205eHE0SUNGUlY2RFBYTURKS3dOQzBD?=
 =?utf-8?B?Zi9NMmdKNFhRVnd4RlM5NWVscmhzSG1MMGJ3cWs3Q1hmVlZxWGUrRmV3dWdY?=
 =?utf-8?B?NTllVWFLMXJhb0ZqY2pyOE1XYW1PMXByM2ZrYVE4UUgrNW1kUWJTVm9QR1dY?=
 =?utf-8?B?UnIxTm05ZWFkNjRFSUN1Q0NMNTZGcUR1VFhKWkZKdkNCUVVOWDBEZncvRFNa?=
 =?utf-8?B?L2U5U2xDcktEdTZHMzVWa0p0ZVNqS1lKU0tDUFFUNjRkc2RROWUvZzRHalBQ?=
 =?utf-8?B?Ylg4NVYzTHdVdnB0M3duUGl3Y092ZEZVeVRneTc0dlVLTmlsV3ZxSE8reVBH?=
 =?utf-8?B?WlJRTHA3RXNQWW03bWtvL2RsNjYwL2pUdTRFeFpIcGFxTHNwNy9aaFpBbkFa?=
 =?utf-8?B?VFhnQWs1dVhkbGkzeVJGMTBPTVJLeFIzSHFCYkhEeTc1T0xVR0xTeUtGRlRF?=
 =?utf-8?B?cm9CSk1zMFlwU2lKVTlSTnFyUWczelEwbXFpdysrZ2ZpdnArekdneU1qNTRh?=
 =?utf-8?B?RTAyeXNvQ3N3MFRoSlFCbFBNeTNyU3BBOFRhOE9ZL09zems4VWh2cjNMdTE5?=
 =?utf-8?B?TWhOY3J5WHhRaTVaSjR6Y0x5eWdPaWFUNE5wcDQ2eU1VSlBOcXlhTXRuOW14?=
 =?utf-8?B?dDYwbkZEOEx1NXFjRDR2NXFzaEZTdDlsQ2dQZXNFMVBwK2lORlYzQmFBTUIy?=
 =?utf-8?B?TmJab3FES1cvbC9tN05KWjVZbFU0OGxwSjZ0MnFQUXF0M2dJQWhMbmpUUnBn?=
 =?utf-8?B?Snl6R2FPR05ZQ09RcDFVdlJwNVU3cElaUTZGb1Ntejk2QmV5dUpPd051SkV2?=
 =?utf-8?B?eTl0Y1ZkQ2diT09qdG9qSWxuQ0RHdEJmT2hEa0cvaUc1TTZQdlAwNm9hcmpr?=
 =?utf-8?B?eWtZVU1QZVZKaWN1eTJBa0REUkV4bW9lOUVrSmhzQTJQZEQ0MjFvQUNMVjhX?=
 =?utf-8?B?MURWa05pdnRKbDdMVC9rS3V4ZUhKMlBiTDJNOFIvQkgweVVBYzQ3Qk1SRWxJ?=
 =?utf-8?B?dFNxdi90bFIyYjgwTlpMZzVwdkJ6R3Q1Q3RXOXorZDlnU2hCZTVNcHRaRFdm?=
 =?utf-8?B?dSt4YjdHS0lVOElKUlBET1dIem1lQktVOWpNSXdwNXVFQXlNd0xvUG0rMkYw?=
 =?utf-8?B?OUxIejBBckJpUEdhejdsZUljN3N2S1JzZ1l2MTNDSXUrZ0NHeHpjY2RoYy9s?=
 =?utf-8?B?RnZvRDBROHROZ2ttVUFqWEc0NitoUGNhMzVkY1VlTXptNk0yWFZUUWIyYzFV?=
 =?utf-8?B?RTEyUDdzdTBHN3paUzlKWmdiaWhPYWh5UEMwQVVVOHhzejg4dXhaUXVVclll?=
 =?utf-8?B?QXdZc0ptaHFGMkdDRktsdWRMYzM1VklpcGdhMkdiZ0FtVkR0ZElQQWxkTHk0?=
 =?utf-8?B?SGxWQXhQdkhaeDJva1VSVDBsZkNYdEN6WHVMWnNGZTZmSk1UTThtMkQzdTA1?=
 =?utf-8?B?bWxMcklrbFNFS0JPU1BGRndOMGV6YVE0c0QyM3NlS2lVV3lvUDhRNjdEbW8r?=
 =?utf-8?B?SDYrTlIxamhQcUlVbDlmTHRtVHJzS1U2ZStVckNQcjJIWm5mclc4dTYrMURq?=
 =?utf-8?B?ZTNyMUlCUUl3ZlhDcGVieHo2bnJHcTlBYm4yQzA2ak5SUDNuTzRRK0xnM2pB?=
 =?utf-8?B?OURFM1NubXoydFllNE1pQjI3eVJ3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8d678b-5ff3-4142-94e4-08d9b86bbfaa
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 03:51:56.8617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vaxl4OYfWugzItIrilwrZezQNnNaj9NgJKK706vvUAEuQpk8nwR+j5Km8autoWmHVuEygiXt2itwnYDuz42U/C7F+jJ7mIp9mxVXnStbP8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5473
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060021
X-Proofpoint-ORIG-GUID: DINMpNFpyGKECtDB85pmKdRVNQat0s-O
X-Proofpoint-GUID: DINMpNFpyGKECtDB85pmKdRVNQat0s-O
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/21 6:46 AM, Zhen Lei wrote:
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which
> will fail when there is no enough low memory.
> 2. If reserving crashkernel above 4G, in this case, crash dump
> kernel will boot failure because there is no low memory available
> for allocation.
> 
> To solve these issues, change the behavior of crashkernel=X.
> crashkernel=X tries low allocation in DMA zone and fall back to high
> allocation if it fails.
> 
> We can also use "crashkernel=X,high" to select a high region above
> DMA zone, which also tries to allocate at least 256M low memory in
> DMA zone automatically and "crashkernel=Y,low" can be used to allocate
> specified size low memory.
> 
> When reserving crashkernel in high memory, some low memory is reserved
> for crash dump kernel devices. So there may be two regions reserved for
> crash dump kernel.
> In order to distinct from the high region and make no effect to the use
> of existing kexec-tools, rename the low region as "Crash kernel (low)",
> and pass the low region by reusing DT property
> "linux,usable-memory-range". We made the low memory region as the last
> range of "linux,usable-memory-range" to keep compatibility with existing
> user-space and older kdump kernels.
> 
> Besides, we need to modify kexec-tools:
> arm64: support more than one crash kernel regions(see [1])
> 
> Another update is document about DT property 'linux,usable-memory-range':
> schemas: update 'linux,usable-memory-range' node schema(see [2])
> 
> This patchset contains the following 11 patches:
> 
> 0001-0004 are some x86 cleanups which prepares for making functionsreserve_crashkernel[_low]() generic.
> 0005 makes functions reserve_crashkernel[_low]() generic.
> 0006-0008 reimplements arm64 crashkernel=X.
> 0009-0010 adds memory for devices by DT property linux,usable-memory-range.
> 0011 updates the doc.
> 
> Changes since [v15]
> -  Aggregate the processing of "linux,usable-memory-range" into one function.
>     Only patch 9-10 have been updated.
> 
> Changes since [v14]
> - Recovering the requirement that the CrashKernel memory regions on X86
>    only requires 1 MiB alignment.
> - Combine patches 5 and 6 in v14 into one. The compilation warning fixed
>    by patch 6 was introduced by patch 5 in v14.
> - As with crashk_res, crashk_low_res is also processed by
>    crash_exclude_mem_range() in patch 7.
> - Due to commit b261dba2fdb2 ("arm64: kdump: Remove custom linux,usable-memory-range handling")
>    has removed the architecture-specific code, extend the property "linux,usable-memory-range"
>    in the platform-agnostic FDT core code. See patch 9.
> - Discard the x86 description update in the document, because the description
>    has been updated by commit b1f4c363666c ("Documentation: kdump: update kdump guide").
> - Change "arm64" to "ARM64" in Doc.
> 
> 
> Changes since [v13]
> - Rebased on top of 5.11-rc5.
> - Introduce config CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL.
> Since reserve_crashkernel[_low]() implementations are quite similar on
> other architectures, so have CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL in
> arch/Kconfig and select this by X86 and ARM64.
> - Some minor cleanup.
> 
> Changes since [v12]
> - Rebased on top of 5.10-rc1.
> - Keep CRASH_ALIGN as 16M suggested by Dave.
> - Drop patch "kdump: add threshold for the required memory".
> - Add Tested-by from John.
> 
> Changes since [v11]
> - Rebased on top of 5.9-rc4.
> - Make the function reserve_crashkernel() of x86 generic.
> Suggested by Catalin, make the function reserve_crashkernel() of x86 generic
> and arm64 use the generic version to reimplement crashkernel=X.
> 
> Changes since [v10]
> - Reimplement crashkernel=X suggested by Catalin, Many thanks to Catalin.
> 
> Changes since [v9]
> - Patch 1 add Acked-by from Dave.
> - Update patch 5 according to Dave's comments.
> - Update chosen schema.
> 
> Changes since [v8]
> - Reuse DT property "linux,usable-memory-range".
> Suggested by Rob, reuse DT property "linux,usable-memory-range" to pass the low
> memory region.
> - Fix kdump broken with ZONE_DMA reintroduced.
> - Update chosen schema.
> 
> Changes since [v7]
> - Move x86 CRASH_ALIGN to 2M
> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
> - Update Documentation/devicetree/bindings/chosen.txt.
> Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt
> suggested by Arnd.
> - Add Tested-by from Jhon and pk.
> 
> Changes since [v6]
> - Fix build errors reported by kbuild test robot.
> 
> Changes since [v5]
> - Move reserve_crashkernel_low() into kernel/crash_core.c.
> - Delete crashkernel=X,high.
> - Modify crashkernel=X,low.
> If crashkernel=X,low is specified simultaneously, reserve spcified size low
> memory for crash kdump kernel devices firstly and then reserve memory above 4G.
> In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
> pass to crash dump kernel by DT property "linux,low-memory-range".
> - Update Documentation/admin-guide/kdump/kdump.rst.
> 
> Changes since [v4]
> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
> 
> Changes since [v3]
> - Add memblock_cap_memory_ranges back for multiple ranges.
> - Fix some compiling warnings.
> 
> Changes since [v2]
> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
> patch.
> 
> Changes since [v1]:
> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
> in fdt_enforce_memory_region().
> There are at most two crash kernel regions, for two crash kernel regions
> case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
> and then remove the memory range in the middle.
> 
> [1]: http://lists.infradead.org/pipermail/kexec/2020-June/020737.html
> [2]: https://github.com/robherring/dt-schema/pull/19
> [v1]: https://lkml.org/lkml/2019/4/2/1174
> [v2]: https://lkml.org/lkml/2019/4/9/86
> [v3]: https://lkml.org/lkml/2019/4/9/306
> [v4]: https://lkml.org/lkml/2019/4/15/273
> [v5]: https://lkml.org/lkml/2019/5/6/1360
> [v6]: https://lkml.org/lkml/2019/8/30/142
> [v7]: https://lkml.org/lkml/2019/12/23/411
> [v8]: https://lkml.org/lkml/2020/5/21/213
> [v9]: https://lkml.org/lkml/2020/6/28/73
> [v10]: https://lkml.org/lkml/2020/7/2/1443
> [v11]: https://lkml.org/lkml/2020/8/1/150
> [v12]: https://lkml.org/lkml/2020/9/7/1037
> [v13]: https://lkml.org/lkml/2020/10/31/34
> [v14]: https://lkml.org/lkml/2021/1/30/53
> [v15]: https://lkml.org/lkml/2021/10/19/1405
> 
> Chen Zhou (10):
>    x86: kdump: replace the hard-coded alignment with macro CRASH_ALIGN
>    x86: kdump: make the lower bound of crash kernel reservation
>      consistent
>    x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
>      reserve_crashkernel()
>    x86: kdump: move xen_pv_domain() check and insert_resource() to
>      setup_arch()
>    x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
>    arm64: kdump: introduce some macros for crash kernel reservation
>    arm64: kdump: reimplement crashkernel=X
>    x86, arm64: Add ARCH_WANT_RESERVE_CRASH_KERNEL config
>    of: fdt: Add memory for devices by DT property
>      "linux,usable-memory-range"
>    kdump: update Documentation about crashkernel
> 
> Zhen Lei (1):
>    of: fdt: Aggregate the processing of "linux,usable-memory-range"
> 
>   Documentation/admin-guide/kdump/kdump.rst     |  11 +-
>   .../admin-guide/kernel-parameters.txt         |  11 +-
>   arch/Kconfig                                  |   3 +
>   arch/arm64/Kconfig                            |   1 +
>   arch/arm64/include/asm/kexec.h                |  10 ++
>   arch/arm64/kernel/machine_kexec_file.c        |  12 +-
>   arch/arm64/kernel/setup.c                     |  13 +-
>   arch/arm64/mm/init.c                          |  59 ++-----
>   arch/x86/Kconfig                              |   2 +
>   arch/x86/include/asm/elf.h                    |   3 +
>   arch/x86/include/asm/kexec.h                  |  31 +++-
>   arch/x86/kernel/setup.c                       | 163 ++----------------
>   drivers/of/fdt.c                              |  45 +++--
>   include/linux/crash_core.h                    |   3 +
>   include/linux/kexec.h                         |   2 -
>   kernel/crash_core.c                           | 156 +++++++++++++++++
>   kernel/kexec_core.c                           |  17 --
>   17 files changed, 304 insertions(+), 238 deletions(-)
> 


Hi,

  This series has been in review for over 2 years.

  Can we get this integrated into a build ?


Thank you.

John.
