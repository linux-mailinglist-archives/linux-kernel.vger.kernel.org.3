Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F8049893E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbiAXSxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:53:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27152 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343854AbiAXSwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:52:12 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20OI6pDn001330;
        Mon, 24 Jan 2022 18:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=O6zFWpEnjHHc5+KK2xj7ohlt/soSli9wkExlPaMQCB8=;
 b=pRq6AgAcUWFFScWfLajKm9ZEG67OxZEe32Kz0jeBN2QDfCbre645Fb4KBKwIRv6Z1Gwv
 PKpGpqb/JvhyhU4+Kod61A037yTAtaZbHi22nEgrRmiCDWFgAZKBk5k8X69slZVQs+AL
 o+nRW8qQ3X6LkzIa/JrpKopQWU8/Ty52yiLaS/rNr/dycA2TO1LcEzsQgJvwSfZCph4D
 IfsdMNrJRVW6XSxnPTXgIjAJymRFEmSiHNcXBJ7fEdjTqrBrSlTimpWyVfrNeXf/Y1W/
 BL421SOeKnZTwpsMPce1K0A054boKOI57JCHVBjw61m2yeJ8Bcwn1SBwZuz/3VVZEXmd ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s0krc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 18:50:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20OIkhMn046589;
        Mon, 24 Jan 2022 18:50:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3020.oracle.com with ESMTP id 3dr9r4kphp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 18:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/pjG5E1NnITtJO+V2H1EK9MRhBx7wo8iFFKh6SbWCOb9IgFpNHtrl9ZlKtsIiGCGlgEqeGRZDOW8d1NamcvS96m3LTaINGx7azljXy1kLJMkMAnnI56Co1mqc763h51KEULrUUJXZomevdgPpP/Aer03Q9P1pqkyUiIZwCj4JNLGxPfXm4b+K2k8/LMhcW2b3/7yeTmjqP103kh4dK3RLHV+wP3+gUhUNjLU3VAFk1yl6SS7zwkRQm1ie0+coPnQor93BygQIunc2bHzLv5Ml+Z/+XCleIxzGMGHw+kmjyeoWCDtmtREXneTc52ZmLMS0wZWuA9/ywADg73rMFgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6zFWpEnjHHc5+KK2xj7ohlt/soSli9wkExlPaMQCB8=;
 b=ECN1oo0t7zJLTv/keX90imjyOATgJ6lbRRPkyi+KdDUpGBpaLGn+KYHEIMHiUFyCxjJXL3sG6Oai/5myV8snGFRiaFLGP4Vwjq+jWQdOn/mqIviI0uZ2vfWWVmNsZHjm0S7XUlhYxDyNnoK11vKyeTqLzD5+eG+GWkMm0u917tPgScPOVVQOivcgkk9WOYcOWXH9sWb8ljXkf726frV7BOisEZhr4n1O0J6G1usDtY9Epe4pe9AH6G6qvo2QWBXTjbU6ozttf3RqDC6ehjT2p9T8JFoDUpR+7NbAExSezpN530tURuJXpo8+GHTXJ8KSU0MsKb8aaDke6qMLPoBDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6zFWpEnjHHc5+KK2xj7ohlt/soSli9wkExlPaMQCB8=;
 b=jJfxZlbi+GU68UXpF+80WuGweuMXOZDdJsK8VPcTknHgvhjfQiUYLCqmIj3CRdiUoryO08iSin6kr13jp8+7runFbXN8RjRdxQitXSI4Y2HuzgsOZiJO8mw0lU9+eFa5ggn9jFZ5CqSTSdcnFxQBImAM36dMql8I6yczAdAFUgg=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BYAPR10MB2837.namprd10.prod.outlook.com (2603:10b6:a03:81::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Mon, 24 Jan
 2022 18:50:35 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 18:50:35 +0000
Message-ID: <4d333527-391f-fe6b-eb2d-123d67242d2c@oracle.com>
Date:   Mon, 24 Jan 2022 11:48:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, surenb@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <YevrGs3WE7ywB+lH@kernel.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <YevrGs3WE7ywB+lH@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:806:126::15) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2632e52e-5645-4845-323d-08d9df6a67d7
X-MS-TrafficTypeDiagnostic: BYAPR10MB2837:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2837044FEE812FDFD150CE55865E9@BYAPR10MB2837.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HibGnMIVcRvmVNa+OF1YJcDfGaRc3BO8WxPOcq4FWikYN2CItjArQyaWTfPrjAFrOypq/bP/ia3JBg1qZSgzR7VThS0CtdDC71d6XLCGozg0i5Uk1MGsdp3ni3fnla+veA1iCicSLUPCZ/JnD9av6oEg0aciK6q6heuSJY5V8N3zRV+QLOTWL8M+Yj5M4XIoNl/XjIpXOAEJ4TAa5kYY9YCq78qHiX3rKHCQ9jngPgXsWJ1jSp1M0JsL25uFL16YfPatr+eKRHOP3Sgr6JX0Sh3/MtNnJBngTG5nfFQPjy5p2N8qHX1EOynZanf7a0wKg7mzjayjRqmEfRBlLXibJ9dDWeSjBU5QYaGNWT97ZO9CmJo9PgrmbiALrlP2MkqECwaIPB2K7I3uY7bpnJUaMAi/GUEM0OavvBqyBUnjFuaq8FJeaogAd1+Bu/WjkXjTqEmXrpsj0izK9u9i6iMsru5KpiaG+UHoHZKq33suIWWRZQePfLdxMwcDr/m0M1vdjh9eHz2kcOj/0VX1Y/sIrmjqyxzFMatGa14D/g5xgeIyJ8dsAveIxfsT+lBsOGhvseGIfhh+yggDRwzxRyD1V4s9v2KIddpZ926dBGPlA9cEQgl9t0uj8dBvKlE3WKXiR6dHIM7ZqjAmiWDxkyL+/WGcJwfKBU/C46iWhePE06TQTYgvrmZ0RBCJjCIfslZTqXnusuGyPGxyWnPfYvyNrOYreinCAxt9jFd26zvitQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(83380400001)(8676002)(8936002)(66946007)(31696002)(6486002)(508600001)(7416002)(4326008)(66476007)(53546011)(2616005)(66556008)(86362001)(316002)(6916009)(36756003)(6666004)(44832011)(186003)(31686004)(6506007)(38100700002)(6512007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1kyekVaemxJNFhBeDczbVNCVmVySVAzV21XTDZ6SndyZ1pBK0YyRjkvbjhM?=
 =?utf-8?B?WlFYK3lWYVgyZktXUS9BZHpxN2grS2NjbE9zRXAzRVllRGFEZmJTVWNoSWhH?=
 =?utf-8?B?US9kcUUwN056Vmt1bEJ0WmxQSHNzN29GdTlobFJSTEJHWk1LdXhuWEhkbDBH?=
 =?utf-8?B?NWxmTWpreFdYOU5BbTZMaWdkSEEvaEtBeTh6WDlWUnA3RTdjd1crMDFHYXcr?=
 =?utf-8?B?R0N3U0ptb2pHSFVVWHpKSXROZEhXOURiL1dFN0p6OHp3ZTVPNUUyMzdnOWgv?=
 =?utf-8?B?TE5RQkVCZGh3d3N4V25wMHlhdXBVaU1uVEttRVdzSEM4UkZnQzRPQ25NZ016?=
 =?utf-8?B?NmsrMXJoelc5bUh2eDhhT2FocjUrZUdLc3ZVWERPSlNFaUZXZlRaK3lhRHRP?=
 =?utf-8?B?aHVsWDdqL05yNmlnaGZBQ1VaWUo1QytQMFFwdUI2Z3hRQ2FhdWZlL2tYSVdv?=
 =?utf-8?B?WnNwWkNkY0xvQ01hMHFnMTVmWVdCT0JpVU5EK1I1bkt2VHVXQlI3dFNReExO?=
 =?utf-8?B?OHdHRWNEU0tpTDhKZHV1ZDdMN216UTg0dituejFwZUk1UXg1Uk41YXhSbmRQ?=
 =?utf-8?B?WFNubGJtSm9TZEtycHFpMG01NHpPV2w4WFl4THhtMStKY2tEaHViMzFoVkdv?=
 =?utf-8?B?U1V2bW1GczdDVUI4QVJxM2VVdWhpaUJjS2ZNNXFVNXNUbGUxNGk3K3NUZWEz?=
 =?utf-8?B?VlpsVkxKMGlGVGI1UG00aVhJclhKMXJDeDVxNzYybzlvNW5reUg4VmtIUEp3?=
 =?utf-8?B?eG5FV01xb0g3d0tUeDF2TWk0UzlrNC9jWXBudzZIL0Q1YkVZWUVyTjBJdHlD?=
 =?utf-8?B?azFqU2lyYVEwTlJtRyt3TEdHRWcxVFVDaFQ5eUhpUDZIMWh4SHFLM1Q1ajk3?=
 =?utf-8?B?WlUxRTRBOVBCKy80Vm5hdFJ3RVJiTmI3a2VwRStPRE5kUDVoR2FtUnc4MUw5?=
 =?utf-8?B?NFZNR3o4eFNmYXgrZUpKY3Ezamt1dDRjZXhQcVVoa3FrdTNTZzFrSSt6bHBN?=
 =?utf-8?B?OHM4NmVvMkUrcmhVY01PUStuUklyWGNQN0tQTWhpYzBGbWNtZXlVQzR4ek1K?=
 =?utf-8?B?Um1iMXZFQnVIUkJOYW1ZVWJyV205OHBYdmI5Z2ZLQ3NTelYxakJCUjlybmdB?=
 =?utf-8?B?Q2Zia1ZUU2Q1bHpjT0NRV2xhWnprelJYNkpNZjVoS1kwUlpONGpibGpZZGhr?=
 =?utf-8?B?QWJiR01XQTNtcXcyNitHbGRoL2F6THk4VjB3QTVQeVUyMUh2b3hWRkpySWtB?=
 =?utf-8?B?NnU3dm5xNGswNUZpN0k4blZYMUh3d2lIdm1GVnNkTjYvVlNYMUprWmV5MzBW?=
 =?utf-8?B?WGhPcitDMTFpNkRKN2Q4UWNVbDluKzk0Q3lQQ1diT1k1d0UyT2xqeU14M0N6?=
 =?utf-8?B?UFhOSlFnUXB4LzRMaHJndHVvVnVNQ1BnVWlGNDZNTlI1ZUxVckZsVytvajUx?=
 =?utf-8?B?Rm9xQWlZZGRJWm5JQVRZNDdDTXB4WXJraHhHVEJNUENtbmlMYktMOEtxbmFP?=
 =?utf-8?B?RnNDd2NTTENENTFsOGVpVnpJcGpEZ2xYQ05zZTY1UGx2RzFLTUh5N04reG5F?=
 =?utf-8?B?UnArc29SeW1LUFNXdUc2TDY1T0ZoaEZPTk4za1BkK2hRSnAxWklYajFybno1?=
 =?utf-8?B?TTNxdEc0dmx2cDlSeExjTjhCTWRENGNSQkxlckg5dUpYc1VhT3o1aXZZMUN4?=
 =?utf-8?B?LzU5cjltTkRtZGZVUXNyYzkxVVdBNFhUWUp4VG41bDlkMHkybkgvZ3IzS1hZ?=
 =?utf-8?B?R3ZCWmVyUzlvOGUzSVR0aUltaHNiU2hwa1c2ZmJkc09IM1VWU3RNODVZc2ZT?=
 =?utf-8?B?aU1XUFJ5M052U0kwZFNaRXVZTkI2RHRLNGhQSWxNWXZtR0E5UnFJL0o0R1dh?=
 =?utf-8?B?TGYzR21lZDZ4Y0lrb1lVclBmUGorQ1JXcU90cmpjVmZEWTdTWEZQR2xUR2hn?=
 =?utf-8?B?d3pHcEYreWhIWm9YdDZvc21lMW9vNGFDdVdxRWJxMnhRVjc1SGdxS2IyeW8w?=
 =?utf-8?B?THJMdHFvaSs0R215dFZkMnNxNnlCb2YzTUJjelJ2SWR3cHRncEZzaTBHNnFs?=
 =?utf-8?B?NzRycHJhR2N3WGhGZjJwaDJJUEtsN3BPWUFCalRNWk82NS9EMWZlZnlVd0tN?=
 =?utf-8?B?MHVEd0hVNUd4T3k0ay9MZkRWc3Nrdi9oaDZyQ0N2dzB3YkFIQU1iODVlVDgy?=
 =?utf-8?Q?ndvMLnhhCdjKi9tQY8oRlxVaYB8TNCmEngFeGrIdPNO5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2632e52e-5645-4845-323d-08d9df6a67d7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 18:50:35.2882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxIRNlCWcbEKJqryoIVJHglDO7kfP+OICDpNtk7qilDrkBtssyM2l6Y0Gcb3v8hd9cR2pRCFxVacG768FL19JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2837
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240123
X-Proofpoint-GUID: 60hpc5CZNMeXG24HjcPzU18vnZOgW2Wt
X-Proofpoint-ORIG-GUID: 60hpc5CZNMeXG24HjcPzU18vnZOgW2Wt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/22 04:31, Mike Rapoport wrote:
> (added linux-api)
> 
> On Tue, Jan 18, 2022 at 02:19:12PM -0700, Khalid Aziz wrote:
>> Page tables in kernel consume some of the memory and as long as
>> number of mappings being maintained is small enough, this space
>> consumed by page tables is not objectionable. When very few memory
>> pages are shared between processes, the number of page table entries
>> (PTEs) to maintain is mostly constrained by the number of pages of
>> memory on the system. As the number of shared pages and the number
>> of times pages are shared goes up, amount of memory consumed by page
>> tables starts to become significant.
>>
>> Some of the field deployments commonly see memory pages shared
>> across 1000s of processes. On x86_64, each page requires a PTE that
>> is only 8 bytes long which is very small compared to the 4K page
>> size. When 2000 processes map the same page in their address space,
>> each one of them requires 8 bytes for its PTE and together that adds
>> up to 8K of memory just to hold the PTEs for one 4K page. On a
>> database server with 300GB SGA, a system carsh was seen with
>> out-of-memory condition when 1500+ clients tried to share this SGA
>> even though the system had 512GB of memory. On this server, in the
>> worst case scenario of all 1500 processes mapping every page from
>> SGA would have required 878GB+ for just the PTEs. If these PTEs
>> could be shared, amount of memory saved is very significant.
>>
>> This is a proposal to implement a mechanism in kernel to allow
>> userspace processes to opt into sharing PTEs. The proposal is to add
>> a new system call - mshare(), which can be used by a process to
>> create a region (we will call it mshare'd region) which can be used
>> by other processes to map same pages using shared PTEs. Other
>> process(es), assuming they have the right permissions, can then make
>> the mashare() system call to map the shared pages into their address
>> space using the shared PTEs.  When a process is done using this
>> mshare'd region, it makes a mshare_unlink() system call to end its
>> access. When the last process accessing mshare'd region calls
>> mshare_unlink(), the mshare'd region is torn down and memory used by
>> it is freed.
>>
>>
>> API Proposal
>> ============
>>
>> The mshare API consists of two system calls - mshare() and mshare_unlink()
>>
>> --
>> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
>>
>> mshare() creates and opens a new, or opens an existing mshare'd
>> region that will be shared at PTE level. "name" refers to shared object
>> name that exists under /sys/fs/mshare. "addr" is the starting address
>> of this shared memory area and length is the size of this area.
>> oflags can be one of:
>>
>> - O_RDONLY opens shared memory area for read only access by everyone
>> - O_RDWR opens shared memory area for read and write access
>> - O_CREAT creates the named shared memory area if it does not exist
>> - O_EXCL If O_CREAT was also specified, and a shared memory area
>>    exists with that name, return an error.
>>
>> mode represents the creation mode for the shared object under
>> /sys/fs/mshare.
>>
>> mshare() returns an error code if it fails, otherwise it returns 0.
> 
> Did you consider returning a file descriptor from mshare() system call?
> Then there would be no need in mshare_unlink() as close(fd) would work.

That is an interesting idea. It could work and eliminates the need for a new system call. It could be confusing though 
for application writers. A close() call with a side-effect of deleting shared mapping would be odd. One of the use cases 
for having files for mshare'd regions is to allow for orphaned mshare'd regions to be cleaned up by calling 
mshare_unlink() with region name. This can require calling mshare_unlink() multiple times in current implementation to 
bring the refcount for mshare'd region to 0 when mshare_unlink() finally cleans up the region. This would be problematic 
with a close() semantics though unless there was another way to force refcount to 0. Right?


>   
>> PTEs are shared at pgdir level and hence it imposes following
>> requirements on the address and size given to the mshare():
>>
>> - Starting address must be aligned to pgdir size (512GB on x86_64)
>> - Size must be a multiple of pgdir size
>> - Any mappings created in this address range at any time become
>>    shared automatically
>> - Shared address range can have unmapped addresses in it. Any access
>>    to unmapped address will result in SIGBUS
>>
>> Mappings within this address range behave as if they were shared
>> between threads, so a write to a MAP_PRIVATE mapping will create a
>> page which is shared between all the sharers. The first process that
>> declares an address range mshare'd can continue to map objects in
>> the shared area. All other processes that want mshare'd access to
>> this memory area can do so by calling mshare(). After this call, the
>> address range given by mshare becomes a shared range in its address
>> space. Anonymous mappings will be shared and not COWed.
>>
>> A file under /sys/fs/mshare can be opened and read from. A read from
>> this file returns two long values - (1) starting address, and (2)
>> size of the mshare'd region.
> 
> Maybe read should return a structure containing some data identifier and
> the data itself, so that it could be extended in the future.

I like that idea. I will work on it.

Thanks!

--
Khalid

>   
>> --
>> int mshare_unlink(char *name)
>>
>> A shared address range created by mshare() can be destroyed using
>> mshare_unlink() which removes the  shared named object. Once all
>> processes have unmapped the shared object, the shared address range
>> references are de-allocated and destroyed.
>>
>> mshare_unlink() returns 0 on success or -1 on error.
> 

