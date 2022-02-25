Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD31B4C51A8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbiBYWkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiBYWka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:40:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A343203BEF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:39:58 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PMbGJs027396;
        Fri, 25 Feb 2022 22:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1O3xyKUv4FtQGNH4I0wtWPNQhC27Zof8tVcpw0UEso0=;
 b=c3HJbgfYAsx9m6LBldw3AtCO6AosCbMqrydUsVbOjl+OpJHAya3bAdtaGnG6TYutdmJk
 rzSBVr49TVuuGN/BRr9T8+VncaPayczfVlyLX9VvB/CX09xdeSBoJcgFOAbaQV6G539M
 bg6+MZOUrAd3VXZ6l7zCcwpxkqyzmwwG4DBfc9Pd44siLCFi5RKxJ0ce4ODxS5xrkqxX
 5u9FDvLIF2uRHkKqUvoLcqlFpoe4B0hFRq2sHZS9kLByT6Cs8aIqx0DU8zszajuM88FG
 C4KOPnC0UROZBcLexnC60kog5LzaMhbemGg9gX4KAmmWNHQug4F4I3ZNlVHbMsHE5NU1 Nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eexj8a9cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 22:39:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PMacOm185227;
        Fri, 25 Feb 2022 22:39:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3020.oracle.com with ESMTP id 3eb4858t69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 22:39:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNUmQcfu4YvgHUqXpDNenyI2KJh+wxogbf1sCbUtgh2yj1/5Z3ioEt9MbRRuJKlG0m1d4P1PHw93qHWHW4tBLi53nOB/09e8YZ3k0C1I0WF1qQx0lzGooSYckhX7gg2ev+yU59UvnzveCbV96R+Ja03qrSa2d18Rp5Nz5b+DSEfmSELxwG7QUQrEizspvE3IFK54czI1Nv5ywdNvUq4dyqWlb+UAz5wEtsxMzrmMPJHBKVEEtuCUaKIgI7ztoRPnYhxu0GwkM/j5GDr4hNWVpjweu5TndcGvMTmgMu3DqMCbmlnNsvmgcMIawu8BKwUyjfXXoSVv3rTzBRr8TbgcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1O3xyKUv4FtQGNH4I0wtWPNQhC27Zof8tVcpw0UEso0=;
 b=X1qZyywrE9zcekRPSPOsHnas0ob6hiPP1scFuuIeUty3eWyQn/HINukLbbQZgM9pTtTefgPMeMsKmreOxktyeS8U6cLqUGuRq8VIriso+P52Joj/Ewzzu9+hdagu4GQ3gwtxTeH3Ybpkz1zf8I2WewcVaMo1767G0Z33w2+z5rwIfN0kmVtfjxaSPaAKN82RynZ/AsHzFgG5tdVKmEBDlXl41PL3o3409V9EVqv5w2GRAVvl3QY9BdHQiViSO+7F3A36hzAi3sjq/EWUWQJ4iIAkIBdwIKvi3K0OQUmdsGJQKkeKZTq5fVNW+ZPlKElCsCEk7rXcecjnACroGbuOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1O3xyKUv4FtQGNH4I0wtWPNQhC27Zof8tVcpw0UEso0=;
 b=NrK/Hc897E+Npd608xwvDRhVj7KTYvNePEnHmo/fIFnk1vH0/6QcVovoguX8gkr+EA+ZF7CQNkeQo5L577sumFTg2gqRLEO031gStH//KQZWnYbFtOETFMXhM2fcvO3PKblkYZhZs8IUphoM0bNmDNNpxCZL5s0uoqg77gX0C5U=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BYAPR10MB2759.namprd10.prod.outlook.com (2603:10b6:a02:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 22:39:19 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7%3]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 22:39:19 +0000
Message-ID: <9de1059b-6b48-e2c8-60bc-f29b42b217f7@oracle.com>
Date:   Fri, 25 Feb 2022 17:39:15 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v3 0/1] xen: fix HVM kexec kernel panic
Content-Language: en-US
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        joe.jin@oracle.com
References: <20220224215049.2845-1-dongli.zhang@oracle.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220224215049.2845-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:806:121::22) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f5c8bec-62cc-4055-fd3d-08d9f8afa946
X-MS-TrafficTypeDiagnostic: BYAPR10MB2759:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2759130AA49812FB8AD8C7158A3E9@BYAPR10MB2759.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kf0vNL5JTc403HkjW7G8eaghvFZD0LbemcC2AGfNWzvREmRjtxM6/MZ79ZwpwFaG22JVc4W59qD5Glu+NUwx8THrhpkF61XMQqIHIMwqkEZBCj3j2a6m5yjfgalGWIMKDiZmkmwogBoLuw38uA8Y3VHsEr232/VznBIEBX7hEPXYuBUdivpKqamCc3Qoihcexu7C5DGG11n0oJh8J5Hrkg+1zo+NQVdeMebDT9iombq1OWY6hDXwywLJLdGg3KF+cplaHbK9H/ZtYAnaYT4OUw4ZhShQ58l9W+9lhOHhxtgpWjyYXWJWi/vVhC+6rZ9KCMuMq9zG6mqhwdDyBl8RVzUAcQN2tWlI3S95Sj4dVBVrAzxTzvXUbBU7EALh770Nir9xOfTuilEv57r6uLlBVUsW93mvHxZQUYOVHFbl7U/CFks9nQrMcPA3lBBX4cXT6PXL1Z4L64XefFst6UgxAqqhgqHJ6RhA7BnnSutGQXy2DAo8e7mZ72QXc3i+CYcmvUYZYnEt4Wo3SM1THiJO/9QwOaW1KSdwGkr4wSibviSlKZI+BmF7QOCrUfv5myrhvD4LX9uSUPEDS5YN3qsv4kbVrUagRsihgVMQChydhJCfRlC//4S5HGjCVwizVEczq7y6HzOKzeiA15J8Pj+aD4T90wp8eMwg8rDd0Nz4P4r+zkTKldm8nAFuoTxM/1vQODjTmF5xxt7sJSuHQOIqc/LT4TcB2gX41zRtWfoC+oe8vMD2Y+E67GUURi+8C95iS6Oj7oJFnPoYsPlsGt42XP9yLA0spoaQ51vuyhxbjH1fvrFmnRbA9T2Y9MkfOdwPfXFbVI/uwYM2E8qk6Maz3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(5660300002)(44832011)(66476007)(66946007)(36756003)(316002)(8936002)(4326008)(66556008)(966005)(7416002)(38100700002)(2906002)(6506007)(6666004)(508600001)(6512007)(31686004)(107886003)(83380400001)(31696002)(26005)(186003)(6486002)(86362001)(2616005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rml1ajBzTlNMUElVYlVYTzcwNUZET0thN2VXcGxPbk56TEl0WFBHUUN3VWpy?=
 =?utf-8?B?RmxIYVhMd2dqYVRFWkN2M3gvTEgxeDdsRnpOb1RzRkFEZlFkV1liTUxUeTVJ?=
 =?utf-8?B?NkdBM0NtM3pDVE1rSUVBRFZBZndLa2p5WHdSV0REYTBHM3ltVkZDSW14Z1hu?=
 =?utf-8?B?Nk55NXg4Y05XMld1dWNMbmswUmJUTC90TElHNW1rR1Z4dmdHQUR0a1FCVmlL?=
 =?utf-8?B?ekJjVURobUh5TTFSSlExNWo2TXhSWFN6SGNmZFI5YlZHeFpnQkp5c3M1RlYr?=
 =?utf-8?B?MjJxekZpVnhxOG9MZWI0SXFOQ010cXNYeVNGV3BQbkcxbTdWRU03dlRHM0Nk?=
 =?utf-8?B?dElRVzFLV24yQzllM2IxTjJsWWpWWE54eFFGN3d0WFVHZXlSU01SbjNFZDVi?=
 =?utf-8?B?MGNWeUZvRzlUSlNScUNJSlV0NkpNVEVNVlBmNzJ5VkpIaXI4Y0h4VDI3NVph?=
 =?utf-8?B?MFM3UkZjajBpN2tyM3ZXb25zZVZ2bWhjQktZUjdkRkp4ZDBOTDNmY25iSUJE?=
 =?utf-8?B?WWcxdGtRRGNvRENKODUzeUdRS2RKdHBwOW1GcU9raWk3MkpGUkhlbEtWenVi?=
 =?utf-8?B?Y01kL3JXRm8rYk4vc2ZSSi9kbW1tb2Y4cnYzZW50OFFyTGUrbnA3akhoK3ZZ?=
 =?utf-8?B?K2pMeDRQSnErODBMbmpsNitNdE02ZXE2NU5TS1pVK3g1dUkxVnlqb2dOd3o5?=
 =?utf-8?B?K0h3bWdyUGRlaHhTM2xBR3FOZlRqSVF3S3o5WFVnQ2JQanhWTlNYN1JmWkVt?=
 =?utf-8?B?OFROY1JGWi9ySlJTTzZZR0JZU2JyNGtlRDZYMlp5ck52c1BRNmdoT3ZlM3pr?=
 =?utf-8?B?N2htY2hURVhhenVIQW1uSW5PbU9jSGZxei9TUVhXdWxXdUlPZENqcGw4UXo2?=
 =?utf-8?B?ejR1aFkyMHVCRHJxOVpUdXZ0L0xnYnlwK1BJUlBkcFUvSjlqdVJZLzJheGVl?=
 =?utf-8?B?THpyODRTSnp2RHE2ZnM2L1lRMzhWYjZsQ1NuWjlML1dnb3RrZUhsc292UjNN?=
 =?utf-8?B?NWNEdWJpWWIvdUlNcWlUNGVUZEFGdkU1Vk01c0RXT3RJOGNlNVRMVm5iMVlm?=
 =?utf-8?B?L01Hay9yWklEcHQrd1ZtWTFMbjcyOFFHV3NVUTBhbTRBeWlTZEw3V1FQN0VE?=
 =?utf-8?B?VUhpUEVBOHJqd29rdWpWMkNHdWRxd01wOWszMCtOTTRHeHFYQ0I4RnJQcVZK?=
 =?utf-8?B?RGd4dElwV05ONTk4cllJOEJMZjUyKzJYbzJteWZtb0VJaEFmWUttUUJub01K?=
 =?utf-8?B?bVdkWXJhWG5ZeVZoWGt4KzVVTXNzVkMrL3FrZ2ZUdjg2UFErTjRqV1NsQS83?=
 =?utf-8?B?OGZ0alBGbHVzSGZuckVYazhJZTBpUThkYjJMbE5CSldDM1JzWXhOYzV1dHds?=
 =?utf-8?B?c0RXWjV3Yk9raXBwRU1oTldJUkFCVWtyVGtYU1VBS1luTTNBbzYrMWRXdldY?=
 =?utf-8?B?eWluSldwS1pMaWFucm9VdmxTcGZnYkRHdDZVWjlXa1JhN1pxZkFSS0NHdHdX?=
 =?utf-8?B?MmJpMlpoQjM0T0s4emFhV080cVczRTN3TWh4dDlwU3QzemFSU2NQc282aWJn?=
 =?utf-8?B?dG1tQ0xPVW1McEFmRExHVTNqSk15TFl3cnpXamRvMm4zd0tpdHppMFFNbGNT?=
 =?utf-8?B?V3ZzeDBxU2tlMzlsdm44d1lWSFd4S1BtZSsrc2hwZXVBRTFFMEZpK2ZKU01r?=
 =?utf-8?B?NE41M3FNb3RMd2tLbXIrdlVCZVBMd1lpdVNvWThKUFFCU2xjVzRBTlFmOE5q?=
 =?utf-8?B?RmNiNG9hcFhRc01xY1RFYXNySXZnZGlsYmh3aStTbzNEeXRYb1J0WkVaQkdU?=
 =?utf-8?B?VFlldHY1TTdpRmg1RWZMTk5ES3RZeEZkVEF4NEVudHhqb2lVdmlLS2xnaUFq?=
 =?utf-8?B?Z0VLRjFjb2FxZGE1RlpTWWVHbzR6dzYwSG1DQUVOS3dNWi9ONmgzU08rbzhm?=
 =?utf-8?B?M25kcWxpc2Jpbzd6WTRDVk9pZDBodHZiZkdvN1phSXlTVHdtM2ZEc245Z3J3?=
 =?utf-8?B?MUd3bGh3dXdCZFZORFNZZzBHUlEwdTB5TzNGbkh6ckJ2dmZiYTRtMGkrSmVF?=
 =?utf-8?B?VW1wTysxaDJZSFZTbFh4SGExSW5Jcm9EbHh5MjNEc1NJVkRVcGFZK0NOYTJp?=
 =?utf-8?B?WXFISlJ6MW9WM1JCQVQvdFpYZ0o4aFhnb3R3U0YyYWQ0U1lleUhKRU5uVEZh?=
 =?utf-8?B?VEgxRnVjWDdKYldRMjVvNjBDK2lFMGpKc3BmY090UFhhMWJwNlZEdmIvYk5H?=
 =?utf-8?Q?yao9D02ss+P6h0sIyaSlKiACQcV8QVgpwiIgCOwBSA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5c8bec-62cc-4055-fd3d-08d9f8afa946
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 22:39:19.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4ExZ3wh3B7s3R7Z5gnQo/1rj7nF+/eWHVhO/y2i7RxeNJmm7fkiSwJzqUTmCb5FX50jscRHGPoJ8O2wwXybhKpEr74aLFAQr3P5KHE0kEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2759
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10269 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250123
X-Proofpoint-GUID: x0hkbZMcXLs-sFfnRrCEiRnDvFHgkKZ3
X-Proofpoint-ORIG-GUID: x0hkbZMcXLs-sFfnRrCEiRnDvFHgkKZ3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/24/22 4:50 PM, Dongli Zhang wrote:
> This is the v3 of the patch to fix xen kexec kernel panic issue when the
> kexec is triggered on VCPU >= 32.
>
> PANIC: early exception 0x0e IP 10:ffffffffa96679b6 error 0 cr2 0x20
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.17.0-rc4xen-00054-gf71077a4d84b-dirty #1
> [    0.000000] Hardware name: Xen HVM domU, BIOS 4.4.4OVM 12/15/2020
> [    0.000000] RIP: 0010:pvclock_clocksource_read+0x6/0xb0
> ... ...
> [    0.000000] RSP: 0000:ffffffffaae03e10 EFLAGS: 00010082 ORIG_RAX: 0000000000000000
> [    0.000000] RAX: 0000000000000000 RBX: 0000000000010000 RCX: 0000000000000002
> [    0.000000] RDX: 0000000000000003 RSI: ffffffffaac37515 RDI: 0000000000000020
> [    0.000000] RBP: 0000000000011000 R08: 0000000000000000 R09: 0000000000000001
> [    0.000000] R10: ffffffffaae03df8 R11: ffffffffaae03c68 R12: 0000000040000004
> [    0.000000] R13: ffffffffaae03e50 R14: 0000000000000000 R15: 0000000000000000
> [    0.000000] FS:  0000000000000000(0000) GS:ffffffffab588000(0000) knlGS:0000000000000000
> [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.000000] CR2: 0000000000000020 CR3: 00000000ea410000 CR4: 00000000000406a0
> [    0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    0.000000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    0.000000] Call Trace:
> [    0.000000]  <TASK>
> [    0.000000]  ? xen_clocksource_read+0x24/0x40


This is done to set xen_sched_clock_offset which I think will not be used for a while, until sched_clock is called (and the other two uses are for suspend/resume)


Can we simply defer 'xen_sched_clock_offset = xen_clocksource_read();' until after all vcpu areas are properly set? Or are there other uses of xen_clocksource_read() before ?


-boris


> [    0.000000]  ? xen_init_time_common+0x5/0x49
> [    0.000000]  ? xen_hvm_init_time_ops+0x23/0x45
> [    0.000000]  ? xen_hvm_guest_init+0x221/0x25c
> [    0.000000]  ? 0xffffffffa9600000
> [    0.000000]  ? setup_arch+0x440/0xbd6
> [    0.000000]  ? start_kernel+0x6c/0x695
> [    0.000000]  ? secondary_startup_64_no_verify+0xd5/0xdb
> [    0.000000]  </TASK>
>
>
> Changed since v1:
>    - Add commit message to explain why xen_hvm_init_time_ops() is delayed
>      for any vcpus. (Suggested by Boris Ostrovsky)
>    - Add a comment in xen_hvm_smp_prepare_boot_cpu() referencing the related
>      code in xen_hvm_guest_init(). (suggested by Juergen Gross)
> Changed since v2:
>    - Delay for all VCPUs. (Suggested by Boris Ostrovsky)
>    - Add commit message that why PVM is not supported by this patch
>    - Test if kexec/kdump works with mainline xen (HVM and PVM)
>
>
> I have delayed the xen_hvm_init_time_ops() for all VCPUs. Unfortunately,
> now I am able to reproduce the clock backward as shown below on some old
> versions of xen. I am not able to reproduce on most recent mainline xen.
>
> [    0.359687] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 [0] 24 25 26 27 28 29 30 31
> [    0.359694] pcpu-alloc: [0] 32 33 34 35 36 37 38 39 [0] 40 41 42 43 44 45 46 47
> [    0.359701] pcpu-alloc: [0] 48 49 50 51 52 53 54 55 [0] 56 57 58 59 60 61 62 63
>
> ... clock backward after the clocksource is switched from native to xen...
>
> [    0.000004] Fallback order for Node 0: 0
> [    0.002967] Built 1 zonelists, mobility grouping on.  Total pages: 3527744
> [    0.007129] Policy zone: Normal
> [    0.008937] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.17.0-rc4xen-00054-gf71077a4d84b-dirty root=UUID=2a5975ab-a059-4697-9aee-7a53ddfeea21 ro text console=ttyS0,115200n8 console=tty1 earlyprintk=tty    S0,115200n8 loglevel=7 no_timer_check reboot=s32 splash crashkernel=512M-:192M vt.handoff=1
> [    0.023880] Unknown kernel command line parameters "text splash BOOT_IMAGE=/boot/vmlinuz-5.17.0-rc4xen-00054-gf71077a4d84b-dirty", will be passed to user space.
> [    0.032647] printk: log_buf_len individual max cpu contribution: 4096 bytes
> [    0.036828] printk: log_buf_len total cpu_extra contributions: 258048 bytes
> [    0.041049] printk: log_buf_len min size: 262144 bytes
> [    0.044481] printk: log_buf_len: 524288 bytes
>
>
> Since now I am able to reproduce the clock backward on old xen version,
> please let me know if I should re-use the v2 of this patch, as it has been
> running well in our env well for very long time.
>
> https://lore.kernel.org/all/20211028012543.8776-1-dongli.zhang@oracle.com/
>
>
> BTW, I have tested that 'soft_reset' does not work with mainline xen, even
> when I directly trigger kexec with below commands.
>
> # kexec -l /boot/vmlinuz-5.17.0-rc4xen-00054-gf71077a4d84b-dirty \
>          --initrd=/boot/initrd.img-5.17.0-rc4xen-00054-gf71077a4d84b-dirty \
>          --reuse-cmdline
> # kexec -e
>
>
> Thank you very much!
>
> Dongli Zhang
>
>
