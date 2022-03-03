Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CEB4CB331
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiCCAeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiCCAeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:34:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D07925F3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 16:33:32 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222Lx0Qb009253;
        Thu, 3 Mar 2022 00:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bneHbRqEhwaWmn2AAsUC2F8vjj3KwmMr1Ijt7yZsINQ=;
 b=FetpJ9d07hxgnA+7F4yr8oABtIhJqjjksV6Lh+lXgd6YiomAScZiVurJCOE3sXctgCmG
 5Eo+UwoCAxIRFyO8KoovtleBVQInlOcHXsCXmox4Q5MijkHHfE06KEcvUW+wgd9UCQ0j
 hjrlv+Gd2DPtV2EqpB37p1oFvB1x+04+9Jd8HRUa8meqx0O6bw7uD5gy7vjb0gO4M8nf
 9/QmN/vjyyqOdov0YMOiWrm99lycVzlpmXgzjrFiRISRXPmfOzjKbQRa3vDppKT/Eve/
 +ObTnODEhD7BzlODwnZ3jAzh2bXvJbyrbvSSmcdxbQS4HvnVVSPBEKIpEvFFGicTIjrC Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehbk9e0aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 00:32:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2230GIU7113107;
        Thu, 3 Mar 2022 00:31:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by userp3030.oracle.com with ESMTP id 3ef9b21s9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 00:31:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLqG/wDT5iomSPucBdOhILRPILaKr5nrt2vLmSewKISyMXEWV7oBLTKs8F3OZCJ7HdOWzaWyay2JyzfRx8Ny4zneDM/SXKblhV6ZcsLNOJa9CRrGG+/1jww3DaiXk/PqEIO7QsJ7qmtBmtqyqup7EXf1wtcEmhdKBk9qjv20oNaM3u7yAzCQQ/gmIoBbPs22+7QV4Em/TTEtvAmBWvNqMdArocGZhPz8JIUUHEXcjMrBluFnbDnvxVcG9PpGMOQuC7ULTOT9HccutruKtBl16ynaLyPDnafSvpa0hNYdjknooAIxt02RhaZe8H/LZwA/E4hTun8yiBrl3ETbs64f/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bneHbRqEhwaWmn2AAsUC2F8vjj3KwmMr1Ijt7yZsINQ=;
 b=NqVNdp1gaAotCL86aPA6a2uVfIU3V0G0T2dYVFTePGrFw4gpER+nGzOSNUE682V0pSMzpKYNioLOFX7o+0ASlJXK1MpxktARR968wQk7NMPViBaulUrPxlUflDJIncWueqI3XUL3DxCJy2AbU5ONC48P5weKOu9R/T1Myuh/Eu7fotzD8Iptu4nPXsXDdyChClntHonNmkhnO5K6q5mqYvEdEmtEstS+9ZVjzuZmrKx+CSjcby+2taslybxfoXttauqa5vBdUJi0sr+DPmd5Qg2B+3WjUBBfqsEucSCbvdsX0oXmf7ap5vxJqfTkMLO5moopBXwLSj1BILfZ3PZnmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bneHbRqEhwaWmn2AAsUC2F8vjj3KwmMr1Ijt7yZsINQ=;
 b=eVkvMu5dyUuehXSjeonzSb1e4g8W6mjyzbmJaaj/3yXet+UPxXkG/uEWtKQfCgVt3/YUfYOR0/kuVwmMu32LtZvtjLupVmhAp2Bc+wzL2JfZJdRHe5bFpFq+hstqXEh0g9Pt0hPqyrrgglGMYFdcCkA3wY8C+Oyz/lXZ+mYVnkA=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by CY4PR10MB1541.namprd10.prod.outlook.com (2603:10b6:903:26::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 00:31:56 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47%4]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 00:31:55 +0000
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
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <0ac50fb6-0aca-e61a-1f38-8badbc8c967a@oracle.com>
Date:   Wed, 2 Mar 2022 16:31:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <bacae45c-9f8e-456b-1036-7f68e1e4374d@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::31) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a167a91b-32cd-475f-c16e-08d9fcad3855
X-MS-TrafficTypeDiagnostic: CY4PR10MB1541:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB15414B7A19106D114E265186F0049@CY4PR10MB1541.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3myXNqkmDa9+8lYQHagGpjMPUYOE+7DKM2aHMH3H8nGkYyK8PYHp2SYW24l1gYJIQLiWVh87zSMpEs+rdUzEl/q/rDXCbDKCzhmW7fv/8ZzJY0P8jQoqMczDHDdXdp0OjKoDKA3+7n2PmjgyTN91TBGN+BRfxeVzwR5z/uwiOzsae8yA/pJSOQtowI64e2rIMCXFbc2rcrwY0pS/F6wiUTehZI7Y0hzHDU/AyRqi7uiZPCdFFZVDVEWm7Mu4i5uZaQNmjW+hWhJYrsOMxrTY8ok1nt7zMqke46kGj88mu64Hr4mgqzv2uoNYsC9Lc88e3UBgxe+6JXHizSx4BUic2wqfdThAyeWyGiZAQ8v2TJPBfiL+g82UjxfBKk/ltnnchpZhnkpb6XCkRk8YQQvD7pbOhHQ29DToQId9IsXaTeDIjyfXAAEpD48RFwg3L+AriC7c+9Z0zhl+MeFf7N8O/M5jrsQn01WitAkwqEFUVn3XuXrmIfzwtWOSRXeaftBb/F9TprbbzPrRWNW03QsFu3CGpZuxxtXas4Gu4LyeEMNbv4uF8n//OY7LpDTFO+dErlg+0xu5q3K417jv7PaAxKCetNy7OIYYeE6MG8glHL+icZzoU7ZA+KicCV1FWLq6iRuYz5SiV+k3mYQ/LGD6I1n9+dPikX6IehQh5AVkNxZhSzUCANyzoB/wUdxfb5XYOCaLTkmI7ZZEE0arUxEJ8StwDAQgvaTrWZAX39rGI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2906002)(6512007)(38100700002)(53546011)(316002)(86362001)(6506007)(4326008)(8676002)(66556008)(66476007)(66946007)(44832011)(6486002)(5660300002)(31696002)(508600001)(8936002)(83380400001)(186003)(36756003)(2616005)(31686004)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzdZdGh6b2dIUGk0L2EyZmI2RHJmZHAzTE1nQ2RXRFoxMlgvbEFIeFF4R1hV?=
 =?utf-8?B?RzFTaHNLOE1xNlRXUHQyaG9wSmNjWDk5MDZRaWhCSElvVHZpbzRlaUpyNkFS?=
 =?utf-8?B?MFZQMHFKWXd2SjlvU1FoaWVQZGJMVS9KWVNpT3BDSnFOVlFEUEM4UmhZYml5?=
 =?utf-8?B?MzF4N0JHNzUybEd5TnVEc0RwY01IOHdscEZHWFBYTkd0cUQ3TFAvMGtzVC82?=
 =?utf-8?B?MHQ0ZzRITVhsckEveDRCRi9QejduZFlzeFpGVVA3aHNHYWRPTzd1QXlyT1hR?=
 =?utf-8?B?S1NPS2ovYWswRG1LZXVmNHNUVG5SUTBrQWNzNHd0SWNQMWk2S2hrNFhnMEpC?=
 =?utf-8?B?cVpSWW9UYXdTOGgrdkQ4U3NLTkNKY3JEYUdoYnpJWXVjMklEZ0VzV0xwY2xa?=
 =?utf-8?B?Sk9xNm9NdzJjWWIwb0JJREx3WTFsNjNLaTVvU3dxREczRkNBT00xZ2lLd3Bj?=
 =?utf-8?B?TDlrdmNtcDZuUjZmWUlKbkNtZmtzODA5c0czSnRRMzRBN2VOdmRiTFJ1SWNW?=
 =?utf-8?B?UTkzNVhMYm8rSlhhK3VFbllMNmwwTENhZzBTR2s3MDdmQlJqMURCaWpBeWpV?=
 =?utf-8?B?dzM2ZUpMNnNvTy9CU2hPS1hEaXp0ZzlaaXgvaHg3bXJYa3pZTWtlZkwraHlI?=
 =?utf-8?B?QXdsbjR0YXB0aHZ6YVJnSjZuVW55bzVoYms5T29nVkRXa1BNMExDZm5MeU41?=
 =?utf-8?B?UDhNSmxwR1luVTVsbmVsYldyT21VTllwb2VLQmZndUViOHZkOWRZWHZ3ZWFm?=
 =?utf-8?B?NW5hOG11cDIvdk04SkJqMk9vRUFGZ2RkRjJ3M3FOVVNBQjN6NFVQdGdnUGRN?=
 =?utf-8?B?eG5qTHAzNXN5dkl3c0k1aGpISDE1OXprSGpJZExxNW5OS3dpSXNQVmJQa1hr?=
 =?utf-8?B?SjRIRzJKRGQ3ZWRNeXFCa0s3ZG1oQWhOeTlHUlZTU3BMbVR1MWN5V1FNakxZ?=
 =?utf-8?B?QVBtclVMdVExWVJHcXA5TDhrbUVsRzhHOHdPMGVobVA0MllUcm96WThPWEJa?=
 =?utf-8?B?UnEwVUFoc3hSM2dMSFd0cHNKWU1odjJxRlJic0dGWXpneDBkeXpEODBKVU1W?=
 =?utf-8?B?YnlzcjlFVXZiRnVNRlROeW1nRHIydk9UUXNRdHRTN3BPZlpvR1gwdUxxMWIx?=
 =?utf-8?B?alBMNkRiWVEvU0dLYzRIMlhTelg4aVpxbFN5Nys3WGYzUWdyc2x5Q2ZCek1J?=
 =?utf-8?B?TFdmRjdocXVnZDlnRjI3aEFSZndpdmtVdUhITk9NZUVPL0xieE5ka0ExdVZt?=
 =?utf-8?B?cUpiQnk2dldxZUFta055Tkc2emVyS2FZMUEwWG9meXFjeC92WG52UnZlYlQw?=
 =?utf-8?B?RlhvbDhPcklJeGQ1dWRIdGNUZ2VMb3Y4bGNPVit0aGxMbVkzbEkvMXowa01Y?=
 =?utf-8?B?NmltN1hnb1JIcGJzaEVTSEIvUlVxVTM3VExwaVk5VEkzbFIydnowMTdKNjN2?=
 =?utf-8?B?V3Y5Wk9pOG9FWUdRT0F1MDlvUjJ1dmZSZTV4c1gxcHB1bG9JTU1NaTNRRGFm?=
 =?utf-8?B?NldIOUFtK2s2M0YxZHdWZkxxQ001ZHhtMXhKTWFHYzBYYm0rVHNESytEanZu?=
 =?utf-8?B?YTU5Ny9tOTBiRzFtbDVrMHdYWTgzMzZ3YjFwMmN2UElWZExxdUhHWldWSG5r?=
 =?utf-8?B?dHFYL1pqakxremVkVEV4OUR1N3FFSDYwYTFvQlprMUhFZVhBbHByejNMUi9M?=
 =?utf-8?B?dG1wWjBMYWlMU0QvbzhJamRJOG1yM1JlSlJ0VUgxa0NMaUdTeFFDYVBYWXVB?=
 =?utf-8?B?U0JTdm5kM3ppdmJOQWk4OG9EY1hBM0Y1MkkxYTJJbWNyZjhUdmxCQ0pwdTZR?=
 =?utf-8?B?SUJTOU9oWStHZk9lSEd1Zk5Cd3FxU3lwcGxIN202anZQVlhjQzhici90Rk1j?=
 =?utf-8?B?bDI0aUxtRUlDc1BhNFIwc004dHVEVklOMjF0VTQ3T250NEhLeUFYYk5nK2Nn?=
 =?utf-8?B?VkhHUENKRXJDYm90MUR5dks2TnZMZTM2UHkvMG03ZXN5M2ZmVDdUTk55SjZh?=
 =?utf-8?B?cUNtSkJEaGNSa0IwTzBLbWRpYXZ5ejB6czlHRkdhOTFwSnY2aU1QeFIwY2ZJ?=
 =?utf-8?B?MkhFdWhyVDJUem5hR09sZWV2ZFFqNDBNV1lNanlGTktOTzVrRkZnbm5PQXRD?=
 =?utf-8?B?ell1aVM5UTJPeVVSYmVqUU82aEtQL25zNXFJWWM1OFo1SXhxZ2pRMSticy8w?=
 =?utf-8?Q?lACELUOc5FlO9udYys3e6+8eEfvlEtF2MTrj7ego1HRl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a167a91b-32cd-475f-c16e-08d9fcad3855
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 00:31:55.7759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82ogWqIU52jMnOI++7J/NYkGd8BouS7un0/Ay/OEGZzh5QmfGmqFpmS5iKp2gEOwEua1OrCR5qHoC7eJl+drSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1541
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030000
X-Proofpoint-GUID: 7Mx52FzyCmKMcO_eKudYMl6iPTCprjHJ
X-Proofpoint-ORIG-GUID: 7Mx52FzyCmKMcO_eKudYMl6iPTCprjHJ
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

On 3/2/22 4:20 PM, Boris Ostrovsky wrote:
> 
> On 3/2/22 11:40 AM, Dongli Zhang wrote:
>>   void __init xen_hvm_init_time_ops(void)
>>   {
>> +    static bool hvm_time_initialized;
>> +
>> +    if (hvm_time_initialized)
>> +        return;
>> +
>>       /*
>>        * vector callback is needed otherwise we cannot receive interrupts
>>        * on cpu > 0 and at this point we don't know how many cpus are
>>        * available.
>>        */
>>       if (!xen_have_vector_callback)
>> -        return;
>> +        goto exit;
> 
> 
> Why not just return? Do we expect the value of xen_have_vector_callback to change?

I just want to keep above sync with ....

> 
> 
> -boris
> 
> 
>>         if (!xen_feature(XENFEAT_hvm_safe_pvclock)) {
>>           pr_info("Xen doesn't support pvclock on HVM, disable pv timer");
>> +        goto exit;
>> +    }

... here.

That is, I want the main logic of xen_hvm_init_time_ops() to run for at most
once. Both of above two if statements will "go to exit".

Thank you very much!

Dongli Zhang

>> +
>> +    /*
>> +     * Only MAX_VIRT_CPUS 'vcpu_info' are embedded inside 'shared_info'.
>> +     * The __this_cpu_read(xen_vcpu) is still NULL when Xen HVM guest
>> +     * boots on vcpu >= MAX_VIRT_CPUS (e.g., kexec), To access
>> +     * __this_cpu_read(xen_vcpu) via xen_clocksource_read() will panic.
>> +     *
>> +     * The xen_hvm_init_time_ops() should be called again later after
>> +     * __this_cpu_read(xen_vcpu) is available.
>> +     */
>> +    if (!__this_cpu_read(xen_vcpu)) {
>> +        pr_info("Delay xen_init_time_common() as kernel is running on
>> vcpu=%d\n",
>> +            xen_vcpu_nr(0));
>>           return;
>>       }
>>   @@ -577,6 +597,9 @@ void __init xen_hvm_init_time_ops(void)
>>       x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;
>>         x86_platform.set_wallclock = xen_set_wallclock;
>> +
>> +exit:
>> +    hvm_time_initialized = true;
>>   }
>>   #endif
>>   
