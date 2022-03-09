Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232A54D27CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiCIENW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 23:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiCIENS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 23:13:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6BC15FCA0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 20:12:20 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22948BB6003031;
        Wed, 9 Mar 2022 04:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WG/QYIqh7LAZ7XXh+7lKNhEpdk8ZNrrCnWCpBVo51L8=;
 b=ntt6FrIdr4A/AOeK9hbgA+slC7vT2aT6Eekjc8X+0bcpTTlLOQRmRIok91qLMHAhSMsy
 JZIccHXRIYslVmX0B3HFA8VDFtKfouoNnZSJ6E9bJoEkOOpHrTx1d+9k+n1HqoRhlXY7
 S2cHkYG7JzKL/xAfVW3u6kdqc2X+lmS4YeNeFgpZ9vWYslhhubN1BQhYBbc28BiUW3MS
 TnGWGGhuWOT5AbW7W3Rto/D5wq+Hl3TsP0DsfGT2Bf0BIjQDCloZicpfr9jIDq3Kwnmo
 Uy/y71ivip5U2LfHFC6zKiQYryOlwEta6OL70G+U6RM0DgS58cU1p0D4TVrvhO7zpyoL eA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3em0du0xjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 04:12:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22947B1e166682;
        Wed, 9 Mar 2022 04:12:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 3ekyp2qcma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 04:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRle94Nf957qPfUu8oT7sCZE2iWvx4HeO+CuXjFO9oK1m8O1+bb8fThVDDL9DHEtqQEREW0PvwdtjITm7XpsggxOvDBg5H2ONpEDSnY5BnV1Sn+yy4NXi7LZqlRa0y3+KA3+N6q+Eo4LDbLh06KCY3YrbzBEGdPS52rc5M5EGfO2LFqeLqOTr27APyIJMHbq+FBtSKBl3GDx2hXx7BbsnyXcQvZOXIo3JvKcqG3CvHrJb/NVFIWmBRpXL5Cw8raDJm04Cvf0MXYncETaS7jdOfaGKcXYdJkbTGV0/epl4xczmk2d23T1Ah/EfaDfZ//WvGfX54vdUWrdIx2KYvVLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WG/QYIqh7LAZ7XXh+7lKNhEpdk8ZNrrCnWCpBVo51L8=;
 b=ejNcUbBhfLztUQLL1BtReTNYHW8R7IZwB+taBfOzXHL0p36qIgOUbLwjIpVDap2lmhw4rv+ma4Gwd1ChdnRxfo2RCcouo/3sZaNacfFO7k79Htb/HZas0iTywhgY3mW5kgSYVBkzDqWxacblcspjsv8vgTaIb0tbW1uGZcBXfGa//mEfgFTo1LF4/qL3xCkPoga7wMQOdJaSTCOCLSaqVhTQbtsy7jUXkyruxVa8CZrYJf/mk1HCcJ45bGfgBzBfNbW7J7GIlp2UxiLFzibCopz5Y5XZkv08jEULYrVhzIkIlqGuWq1nSON+01LEfCPbi+EYLcvatZTEuNIxiDWQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG/QYIqh7LAZ7XXh+7lKNhEpdk8ZNrrCnWCpBVo51L8=;
 b=DSVvVfPugDRDDnmZYiOCrJg2D8+oO3sZaiR4PtS8YW2zDPFhtGbmYwnCWdaLMpH1yibXp4q+pSuvYDi3pU66Le0NUi9/qj8Q9Yff3h68dCpEbpZxMK7kyyswwvAec+kfdGV6wH8H1e69nDEEhczR3S1XRYbzUk3k+vIFxRWepP4=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1951.namprd10.prod.outlook.com (2603:10b6:300:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Wed, 9 Mar
 2022 04:12:07 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 04:12:07 +0000
Message-ID: <e77bab80-c2ca-3ba4-862f-9a29268f132e@oracle.com>
Date:   Wed, 9 Mar 2022 15:12:01 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH v7 0/8] kernfs: Introduce interface to access global
 kernfs_open_file_mutex.
Content-Language: en-US
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20220225052116.1243150-1-imran.f.khan@oracle.com>
In-Reply-To: <20220225052116.1243150-1-imran.f.khan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::16) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8aebd33-c463-4c0f-17f5-08da0182f98d
X-MS-TrafficTypeDiagnostic: MWHPR10MB1951:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB195180C4AE396BE9E236E851B00A9@MWHPR10MB1951.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmhams3DvTDnIqDNFTvC9d4Z6u+RGphWihRJRkwkDOZsrxJpWeFNtdpEFC9EvFzDEClajGLS1NuOFNxJ90UE2Snlb/12407iSNERw0ARz2DwamwHOUgWX0J7y0FOKpxy+wo/iABMbjMUbEX0imTi+rspL2gen2cI7YRHXlrwdi4oMPrlvMfcKO77YtopqKnSaYu1VbMfuEZkp+CNewrPdZlQgX1qq3xw/2FS/OBzbRofqhjDzgRyZrvRTgmLl+4p2cvdPr+0+ZGOZ+FEat93kW4ZTYFqtVIRy2fm94WTtgKsiPjRCsM0QEzyfjpkgHRSDttz0mjI97rVrNKd+y9TzwppQZrCI828I1Ar0D3OSqrHIZR+rRJD1VhPo/63VTBv8ogN+5dAF3p2rWFkvbUUi4RpzN/54aFnq953sZ1O5OGIGpAODjb7Xh9loZKCr0nJSWSobDTixT0EwvcZI+7UC5OoX6vNldnHF8qiCLu/Kt9e9eG3e4k3jT1zAE50VUqaV+RQBAPJqXujPaUsZHbEusHULt8TWyhpCPhz/3I+6VDenl/njyB/q2nvwwtmVaL5LNkM0AfsdS5zpNwMQ8e3+VhAgh5gm3wIieSQ06FSe+KKnZVEYgjGsGvIBHDMeX/nWKFq6MzAuXyHxOSs3e1lf7bFIHumPa3EldTBrYjPDlRplw5xl3SSzSO4gj3k7WqvMph1CC2jZuDAcbFG58Y313Qq8h8+4q+vbxymXcFDf/qzh6DbpdxLiXaE19uPt41Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(316002)(26005)(186003)(2616005)(6506007)(53546011)(6512007)(83380400001)(6666004)(31686004)(86362001)(31696002)(8936002)(4326008)(8676002)(36756003)(2906002)(5660300002)(38100700002)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2Fmd29NVzdYWURwOUVHZmxYNnQ3Vmd4Zzh1Z3gwalBZdi9GcUVVREN1WmV1?=
 =?utf-8?B?QkMxU2tzQ1JXMTdDMGMrTGVuNW0yTFlpaEtUN3FzNjdWNDluUzIxK3h2TE9x?=
 =?utf-8?B?cGFtRURrOHV4QUx2S2hpQkF6T05LbytjQVByREFQcCs0UGZBd241QWJxa00z?=
 =?utf-8?B?Y3pVZFk0eHBheFRuNEllNHVYM0NQS0FpM3c3ZHRBTitLakV6ZW1zS0JvL3lE?=
 =?utf-8?B?TUYreW5MT0lVQzBuYzZ1d3JiUUZYRkNMeUhENUx4Uko2Zk45OFdhNDQ3bVRq?=
 =?utf-8?B?VkZPeGJ2SU96RnliaXl1bXJxU0pVTDk0cmZWVERrVEJSdXZaWkoyY0xaRjJt?=
 =?utf-8?B?cnFTR2gzcldSVEZuZTFOWDlvYTBaK28zeW5wNG9Kb1JadGg5UEFnUXFxMmZ1?=
 =?utf-8?B?SkxEdkhBTUJWcWlxUEZicnJiTWlCOEJZT2tLTTA3MWNSQ3NQY3VEK1U2VjZN?=
 =?utf-8?B?UUJocmpUZnBqdnFGVDNuNkpYdEY0K0JOcVA3dnJ6TUsvbHdXYVZmanJTbEls?=
 =?utf-8?B?a0M4Um9uVTJqb3dmeVg1ejlUZW9RR3hxSXZUYkU0OEVHZ2pjdkxkOUNjRWhC?=
 =?utf-8?B?NkcxZHN3SkR3cmxyK2VubTZmeUtUVzJsK2RWY3RFQ2s3dTNJQ2xDdzMvL3NO?=
 =?utf-8?B?enhYcnQvYkNZTlpXY3NSZmlMaUVlYTNlY01OSDZSWGFNazNRYnYvUHdYMWh4?=
 =?utf-8?B?VGpHcExrYVgrajhFcFFSTE8xK1NmSG9EM2lRb2lTSnpFRFpOaW9mQ09rS2h1?=
 =?utf-8?B?TUJCKy83Q1lUb1N3RDN6Rld0RTlNN2srOTZHejZNQWhhajdiWkdmeXgzb2hy?=
 =?utf-8?B?UTI4aVM1NkFZWDdJdXJsRldyTzJNajdJV1QwTWVqUTVSbWg1b2R5S0wvYnFH?=
 =?utf-8?B?UmsxRWRGTkpJOWlZVGxpbEU5eHNZT2l6Tm45ZlF1TW1SNDl3eEFuU0p2RXlL?=
 =?utf-8?B?NEJBME9lUnp2NGlTOGxLSDlIdzA2dnI2REEzMzRNeHB0SURIWW94c3dwdlk1?=
 =?utf-8?B?RUVaUHhwck4xVnFzZ2VlNXI1V3p5Wmd4SlR4V0dvd0ROYit4cTYzb2lweThu?=
 =?utf-8?B?UFFHajc4bEszdE52bmhwK3ZPN213VWRwcHNhcHRaREh0NG53UDAyZ09KNEU3?=
 =?utf-8?B?eEo5SWN0SmR4ZDZjRVFCdFFQZG43UVVkKzFWQ1JubzdYN00xOWU4Vm4xNnJo?=
 =?utf-8?B?M2dQeEVOZVEzOXB0akpXYlFqcmtJd1lNckNPek9sN2plZWYxUktMOUxhQmNR?=
 =?utf-8?B?VVhLVGZBWW5GUzVoSnA4bWJuSktjbWkybm9sN05uSFR3Rjd1RENNUkxVNXlN?=
 =?utf-8?B?cWNzYWlrOTZGYkIySUpJKytlb0NmNXlROGEzd1g4OERYTEVsSWx5Z3N2bFQw?=
 =?utf-8?B?SENKMXlkdmJxQmxzS0s5U1FNaG9rYTR3aCtjTmtDcDk2Y1c0WjRZUW9XdFNG?=
 =?utf-8?B?Qm53RHVzL0lMaFBqaE1zWjhRbGNZWU1uZW5FR3ZGT0dOOENCL3ArUG92Nmhh?=
 =?utf-8?B?R01rc2QvY2NJQnV2R2ZLcVBaNUI1dWVncWcxakZPNXhCZHNZWEY0aU5kSVFB?=
 =?utf-8?B?dFZDbDF1VWxXNFhLajRGdkxQMnJDTFFkbS9uN3d0ekJFUDdrYkFIaC95MHRI?=
 =?utf-8?B?Q1dWZFJyWUpXRUcyTXZlSUpJdUluenVBdkJQdFlHcUtQc3FwclVIbXlJa0NJ?=
 =?utf-8?B?NkJFQ0dEeTFDenQ1NmtJVHR5ZDFXTndQOVlIL01vWnAzQ2RPWlFBKy9rSjhK?=
 =?utf-8?B?Vk92OE5XNVRBWTNZN3lnQmlQakZqVFQycHE1alN0aVlNaW1yUFJ0THRlNVZM?=
 =?utf-8?B?RWg0UzNTVEpNd0dwTVdycjdaZ2wrQUxTMThCQkEwUHlVdlZqeUhEdTFod1Fo?=
 =?utf-8?B?aEIrSnhpN0haL1I3WlFJdXRnc1ZreFAwYXI4bm5iZEY1VjdQRVdyRDRWNVVV?=
 =?utf-8?B?d3BSSnp4Q1A2cnZWMWUxNWtBUUVjL3BRYmhleW9FaDFWV0RtUG0yY2pBRjZP?=
 =?utf-8?B?d2RoSU5QbHFtTzV0OGNMQUhNNXZ0Rm9BRGU5OVFleUVHNFoxMGN1MkQvdDdv?=
 =?utf-8?B?a1I5cTE1N3YvbWZhU0haRW1QcGc5aFNEK2t6M2xrYXE1RndMMnpYM3BqNXZN?=
 =?utf-8?B?ZzVWQ3BWZm1HQmF0cC93c0RIVDk2bHEwMXJlV2hRM1QvV0c1c3FlVk1iMXdM?=
 =?utf-8?Q?3TtIxwMXexI0wakLwmfQf1E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8aebd33-c463-4c0f-17f5-08da0182f98d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 04:12:07.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6ErvKiNdzxwZAm2Vf/0CZ8Ef62LLMETTYvugjoPrMWmKJ7xZeXw9iU1SapDRdOoQqcNIp3JIQHPXU3jGg03nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1951
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090023
X-Proofpoint-ORIG-GUID: rdLzozYe7ayXGeWD9yDzcH-50DWzChMc
X-Proofpoint-GUID: rdLzozYe7ayXGeWD9yDzcH-50DWzChMc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Al and Hello Tejun,

On 25/2/22 4:21 pm, Imran Khan wrote:
> Reduce contention around global locks used in kernfs.
> 
> The current kernfs design makes use of 3 global locks to synchronize
> various operations. There are a few other global locks as well but
> they are used for specific cases and hence don't cause severe contention.
> 
> The above mentioned 3 main global locks used in kernfs are:
> 
> 1. A global mutex, kernfs_open_file_mutex, to protect the list of
> kernfs_open_file instances correspondng to a sysfs attribute.
> 
> 2. A global spinlock, kernfs_open_node_lock, to protect
> kernfs_node->attr.open which points to kernfs_open_node instance
> corresponding to a kernfs_node.
> 
> 3. A global per-fs rw semaphore, root->kernfs_rwsem, to synchronize most
> of the other operations like adding, removing, renaming etc. of a file
> or directory.
> 
[...]
> 
> ------------------------------------------------------------------

Could you please review v7 of this change set and let me know your feedback?

> Changes since v6:
>  - Addressed review comments from Tejun
> 	- Make locking helpers compact and remove unlock_parent from node.
>  
>  - Addressed review comments from Al Viro
> 	- Make multi node lock helpers non-inline
> 	- Account for change of parent while waiting on semaphores during
> 	  rename operation
> 	- Add a document to describe hashed locks introduced in this patch
> 	  and to provide proof of correctness 
>  
>  - Fix for some issues that I observed while preparing lock correctness
>    document
> 	- Lock both parent and target while looking for symlink
> 	- Introduce a per-fs mutex to synchronize lookup and removal of a node
> 	- Avoid locking parent in remove_self, because only the first instance
> 	  does actual removal so other invocations of remove_self don't need
> 	  to lock the parent
>  
>  - Remove refcounting from lock helpers
> 	- Refcounting was present in lock helpers for cases where an execution
> 	  path acquires node's rwsem and then deletes the node. For such cases
> 	  release helpers should not try to acquire semaphore for this already
> 	  freed node. Refcounting was ensuring that release helpers could get
> 	  an still existing node.
> 	  I have modified locking helpers such that helpers that acquire rwsem
> 	  returns its address which can later be used by release helpers.
> 
[...]
> Imran Khan (8):
>   kernfs: Introduce interface to access global kernfs_open_file_mutex.
>   kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
>   kernfs: Introduce interface to access kernfs_open_node_lock.
>   kernfs: Replace global kernfs_open_node_lock with hashed spinlocks.
>   kernfs: Use a per-fs rwsem to protect per-fs list of
>     kernfs_super_info.
>   kernfs: Introduce interface to access per-fs rwsem.
>   kernfs: Replace per-fs rwsem with hashed rwsems.
>   kernfs: Add a document to describe hashed locks used in kernfs.
> 
>  .../filesystems/kernfs-hashed-locks.rst       | 245 +++++++++++++++++
>  fs/kernfs/Makefile                            |   2 +-
>  fs/kernfs/dir.c                               | 212 +++++++++-----
>  fs/kernfs/file.c                              |  66 +++--
>  fs/kernfs/inode.c                             |  48 +++-
>  fs/kernfs/kernfs-internal.c                   | 259 ++++++++++++++++++
>  fs/kernfs/kernfs-internal.h                   | 159 +++++++++++
>  fs/kernfs/mount.c                             |  30 +-
>  fs/kernfs/symlink.c                           |  13 +-
>  include/linux/kernfs.h                        |  71 ++++-
>  10 files changed, 980 insertions(+), 125 deletions(-)
>  create mode 100644 Documentation/filesystems/kernfs-hashed-locks.rst
>  create mode 100644 fs/kernfs/kernfs-internal.c
> 
> 
> base-commit: 196d330d7fb1e7cc0d85641c89ce4602cb36f12e

Thanks,
-- Imran
