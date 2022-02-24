Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3B94C2F29
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiBXPO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbiBXPO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:14:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4DC208337
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:13:57 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OCYSfD023283;
        Thu, 24 Feb 2022 15:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gR8pSvNCwGNNwkrmv+BMX2UJhbsV8TdcYgLFWmWE4HU=;
 b=iHGMgBKuPMVR9Ca8f4+aT7n1sToMyt3+kLp44prok8pnDyrZ0463v6rmNAXGX3E0Vhah
 Jxs0xyV6RbkX8MnAGFJ6QDDFGtHfHva6gMXbHJh9L5Ys0ddA3YHndxA10mOu0Pu7k50q
 YfN0oAR4AxzluKpuCheUnZjG/KkTEm3A2tcQ4YIccLzvv+yiJqjEMuOTC6gizVj1JcKW
 ElVbsI38jOMGign0laRDlYqfkvAVTk/AhlARq6mL1JL3sY40rrxVFxP2K3nR/xY6kxec
 vwWHZVt2AMaNn4tVE2Ag4e0zXXL85jZeUgLkgeEjLcvfebHTRKT9xW+2NK51NVMR6yAe LQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecxfay0ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:13:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OF6X9N180955;
        Thu, 24 Feb 2022 15:13:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by aserp3020.oracle.com with ESMTP id 3eb483qmk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:13:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/k2qRkwzjGwR1bImDtLCuTTlc6QSK4h6uG9P0Rpe3ceGomWZ5P89eZLVDAtLG1pE+fotYwpNgGoWgvqOSdyIKfTEtAWyHV9+qLSfbIjKhtaFVAP2k0ssu1ybMyLnXIOxt82G/5T1HPMAysOmJidKHfJkafKbDos/eFVXuLOE7Ytwo1RVMt/4W8gUkzhEbUcv+AS0ypiM61foq+VhWFZJ0gGH+MpKqsEAfTpdqzPtZyCJE/ROfBi/0hMBxnHx0HyHX9zGEg1Vqs/OmgBwGfMjV85hztQ4YI2w0acc0hhMs/38e1fXwduP6KbZT0v+SgDRk0PC/gcLbbtUzkbYy8Ksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR8pSvNCwGNNwkrmv+BMX2UJhbsV8TdcYgLFWmWE4HU=;
 b=P2+7yTAJMCk6QO3kBBqu2WOyO7JPMIOH6s+CgXjOwV2tQNSmgokzGvkaiAjOMBad6JHA5pyD3RVv725wmrwbjyqxpP5I0PO6oEpAcYyUZX68/sjpkCwcJKhGIbx3P/JPYFHfUFAA3iPL8Yw5i8uIP4LTILXgsugkAJ9t9lAvqspYuREaON37cks/f+wwbCk4YhnpjMPmfVh3nZviB8BCg/skAKu6iQABKimjjLr+oHVFR8LlA268KlK05qkoZfaVhg26jpMa9NPPUW6Lv9K886qTOz9M61F+gRxMCFPa+MqclQgqhpk5Hnl4YKGu/FbwVux5t9QUwhlhDLhv6e1+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gR8pSvNCwGNNwkrmv+BMX2UJhbsV8TdcYgLFWmWE4HU=;
 b=O6hgbOSK3LvxovMn1i/PgVrR7UKQfbRQyPRkiXHWuqz1LS8TZluAiG384damUIwKqgiN8B4ODeR2ATFv3mnBLdFUWEbN5rPRk9xU9dKo8C8w68hsDbLfj+d2KSfpVuoOLf0KLB9Eovq8/CAbY1krwmnyRJSqAX22I6XzBT5W/KM=
Received: from DM6PR10MB3804.namprd10.prod.outlook.com (2603:10b6:5:1f6::28)
 by DM6PR10MB2714.namprd10.prod.outlook.com (2603:10b6:5:b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 15:13:35 +0000
Received: from DM6PR10MB3804.namprd10.prod.outlook.com
 ([fe80::55f0:88:739b:8099]) by DM6PR10MB3804.namprd10.prod.outlook.com
 ([fe80::55f0:88:739b:8099%5]) with mapi id 15.20.5017.022; Thu, 24 Feb 2022
 15:13:35 +0000
Message-ID: <d982c172-e368-8917-679e-fc7426b58983@oracle.com>
Date:   Thu, 24 Feb 2022 10:13:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Ross Philipson <ross.philipson@oracle.com>
Subject: Re: [PATCH 1/2] x86/boot: Fix memremap of setup_indirect structures
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        daniel.kiper@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <1643303056-22272-1-git-send-email-ross.philipson@oracle.com>
 <1643303056-22272-2-git-send-email-ross.philipson@oracle.com>
 <YgabtFd4Nkpgi+oW@zn.tnic> <2e584fc4-163a-0af4-abe0-9c14996918f2@oracle.com>
 <Ygvy8j9E7WPo6dx0@zn.tnic> <6e5763be-3e9c-0199-24ea-e4f5b226d990@oracle.com>
 <YheLYDdG3w6WGhSM@zn.tnic>
Content-Language: en-US
In-Reply-To: <YheLYDdG3w6WGhSM@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:208:329::13) To DM6PR10MB3804.namprd10.prod.outlook.com
 (2603:10b6:5:1f6::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d03028ca-7690-470f-b95f-08d9f7a839f4
X-MS-TrafficTypeDiagnostic: DM6PR10MB2714:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2714E1D520308928AB45BD7EE63D9@DM6PR10MB2714.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YV4C9IAJxsbpgBu2c3tdBoA0evpiYJCEzKnFPTdG6Ity2WHyslh6MXpPpB/rTYiYz/UFsqPBdWYE3E68YxWjQUTeZGYMA46fbl2UxPTDVJu18GAO2JkJFOKAA1uDoYFAAaoMPRT5IqVX342NmrE2CdGpDU/l1YjCJL49YRVB7dh0+TCYr7jH5v8fKELa6wwKIeyQysaGtIFmPN50p/tGVxdKExEWqVOPntgi+3sNBd9ypwJqdup1HuZu7UAVe32i3mFo5kc2pc07yCdfqpYS4ge6CqvnbzHlgk7Nl5KmzI/MO1G8eQPcrvAR2wE2hv3MCN0/7qXYU3LZCSB/5CzNnf1zV6+zttPa/FXH2Bg9IIANLSO2xT+E3yE9qZWF8JOIwusp2R7jR4CXjHUXBIjOw6trN4+XFlDBLzu1YFyk+5aO1PHx6YFCqqn4wrNVtIQTr8ThU1SY47Bvxcp9w6TyZYjDfPOnivt/K6+85D1h2x76J6zHlEYRGoCXiPuxBkmqlvC+MiyjHs5pEBVKSfpO9GKH1klYQaqFDr/cllQt0ynt1etr9XQBaHl3YMyNNzLhjwdZy4o3RNuxb6A5AKV50xYDCs9usCo7eJggUREHZ06O/EeG2lBW09m6mJY6IwA9JNEZWq+JgCQTF58ZXmjv7yUJ1V+K/k4s6hutOikP81UqT0jiGEywOgtO57hSyOKdGHFBpfn5Fximb9O3YAs8Zuz4h2225iAbu3gedzmvR8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3804.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(4326008)(44832011)(38100700002)(83380400001)(8936002)(5660300002)(31686004)(2906002)(66946007)(66476007)(6486002)(53546011)(508600001)(186003)(6666004)(6512007)(8676002)(6506007)(316002)(31696002)(6916009)(2616005)(66556008)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V09JUGNyaEZpcWhQMXFwck9MM2FBd0xpM2R2VUNyUUNrWlBBUnhwaStreDlO?=
 =?utf-8?B?K0pSQWZFL1hjOHNxNDlpNnRaZ1pjSjY0TGs0bEpGSzlnNW81LzZVbUs4VktJ?=
 =?utf-8?B?eGRxSjZlZC9SMVBOTUpqc2RmUDF0ZHNSb3g1Sm4yS2MyOURWZmxtTkpVTHM1?=
 =?utf-8?B?QXV3VVpzb0pneUNBaERabGhJS21Za2dvbkowcGVSWFZxTUxWWUduTXJ4WE1T?=
 =?utf-8?B?RFF5QndVTWprNWkwZFFTWXcya3VsRncvMnQxSkZCMDVxUjFmbGRnS2dMWnVB?=
 =?utf-8?B?cVJrSmxPajlGWU5ySGdvSjVyeHZoa1Rkd3JXNVI4RDJHRGJPWXRGR3RnOW1r?=
 =?utf-8?B?UWpEa3NHbktQUTY5eUdHYm4yQmN0aG84OXFFOW5SZDFXdDk3U21tWVlxNzdY?=
 =?utf-8?B?Z3o3K2M0NTlDZmcvZmpTNm96UUNJazRJUWxhTUZvaGovNjJVS2hFYnZwaVM1?=
 =?utf-8?B?MTZzSFQwYlA1YVYyalZPT0hBSnhIQVU1S2hSN0t6K3A2dDBwNktzZGwwSHds?=
 =?utf-8?B?VUh4RkNZMkh6Q1hrajRhd1VCZ1ViUU1vZFdHMCtGUiszN1N6c29YZXVUYzVO?=
 =?utf-8?B?ZTRyTGJ1MmFPR3l2RWQ1eEJKeUpwR0U3Y2FaRFZJaTl6YTFVeHJhOTM4TUdI?=
 =?utf-8?B?Ykc3cTMwOTlkbHZkenZlV01LTFZZZ2VWRER2MVhObUYrWkpBUitFOGpMUnRk?=
 =?utf-8?B?NDlTRmFieThYWHEyRWpvM0krVitZWndlRnM3TzRBL2d2N2ZwOVJKaStyMVcx?=
 =?utf-8?B?L0NOVDdIK0VZY2o2MjFtbzJEcVd5QjFOZlkzNnpEbzJHSmthdXplRzM5MFND?=
 =?utf-8?B?alR1ZjNwazZyYkh3L3R0alZYYTRLcFd3dVFaaldLVzFRdkF6TVQvRHdNOFIy?=
 =?utf-8?B?aXZWVEt6T2M2S01POTM0VmhaRWQ2OEpvMGJMTE9pMTVrS3BVdlFWdXpqSWxX?=
 =?utf-8?B?NW50YXc2eDZNYlUvYXVCamF1TUlDZjF4WG1DRzh0cHZJSmI2VkVzYUhmdXhD?=
 =?utf-8?B?UXV6R3lXOHcrVFV3TFNEK2NqVUtSS3RuQVFrcDhXcDZHMmcvSVhQeHRvekIy?=
 =?utf-8?B?TVFDMUhNYkE2enRsVVc3SVd1K2s5YUhxcXNiOFhrVExQQWtiWndIc2JkdzRp?=
 =?utf-8?B?YnZyVVRyMmZQSTBldWJGQ2hFcE1tNG4wNkJoSjR0R1ZxOWY5Nk05MytxN1Ew?=
 =?utf-8?B?M0E4VmRMdDZ1aDh1NTdLNmhkKytBYW1scVhkeEhWRzM2T1ltTE0vVndEa21p?=
 =?utf-8?B?Z0YrY0JYY3h5OWgzdG1yU1JkN0lZQTNLdTduakF5ZWdodTY1SDNpVXBOQlR1?=
 =?utf-8?B?ekdyTkZTVHJPNi9VMGNDSkFyN2VTUmdJajR4aEhybXBhNklocU14TkVLZHhR?=
 =?utf-8?B?MnVIaGg0REVnbS9TSk5TSmVpU2NTTWVrdllSSzBpMGozRlZlTU1XbC9TYmxw?=
 =?utf-8?B?dE51ZVBxbFVCL0dXQlptOW02MS81NEh0QlZ6bUlSa2krOFdHNDFjNWdFR1Uw?=
 =?utf-8?B?bld6cjV6c2pHaDJqRnpLUk1zV3laWENOZktESHRrMmtkMURGRUdiTGU5ZlBN?=
 =?utf-8?B?bXlTVkFsVURFaW95YUwyK3ozUjVHQ2xqUHorWUFmVDFqY2EwUU5JTHJMRFpy?=
 =?utf-8?B?SFE2RE0wdzkxelNSeFY5a3FTMnE2VUlaKzE4WU9MWW9UUGpvYm8xajdPa2JQ?=
 =?utf-8?B?WWs1SE1EbW9WUlYwcG5lc0FRRnRhcUhwMmtZbkNHL1pOQ2V4ZmZWMGNxbUp1?=
 =?utf-8?B?NitpOWVmNno3aVhhekxNdmtlWGJNTDVHaTBHVStsVVVJTFZkMkhpWFVUQUl6?=
 =?utf-8?B?MHVFTkFoMU16a2UzTjZ1NGNjQ1hwa3ZScWRDN01QYURvbEN4TFE0N0ZhaklB?=
 =?utf-8?B?NXN4U2I4dlZ0a1Y2VzFKZ0FCWTBXc3hEL1JocVdnSnM2RWhVbWMzZ0FBQjdn?=
 =?utf-8?B?RGgvQVh1dy9LcmtNS2ZsOWZVZk5BWEp5L2lsNWRLa0pwTmJpUjlZZUFvZmVZ?=
 =?utf-8?B?azloaFJGWEZ1RVdQVUVYSnhqbUhLZjVkY0hSbFpnejhNUzYzYXp3SE1FNmdq?=
 =?utf-8?B?WUJVYjJTczc2OW9McTc3ZTNucFQyNU1DZVFlMVcyMEVlRy9uT3pGWjZCTzFa?=
 =?utf-8?B?VDJSa0t4Tit3eE9rM1QwelV3U2NCMFV0bWZDbzRxOWduOFRld2dXQmhNVTV3?=
 =?utf-8?B?a0xzWUhSa2R4Nm04K0hSSUlOOXBsUHVZcFk2SzJaY2RkSjlWaFk4bzZMOUJ2?=
 =?utf-8?B?SW1oQXZodGUwb2huUnB4QkVrTU1kMzZYRWkvTWVnT0ZoY256SUlTdFVOT1lM?=
 =?utf-8?Q?mjk6hvyUcUGuaYXMXH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03028ca-7690-470f-b95f-08d9f7a839f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3804.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 15:13:35.4166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGDQdYlyW5EJuhZhWSUcMNgk5mqGEjQCraZtlcnssOtAKhhNkV7jB+vv3QAQTlCl9wgw5fUniddbJroKOxq2jLzmdcJC+QYwcuW5+7Dqijc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2714
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202240091
X-Proofpoint-GUID: CIVEZFxmaAm_WVM_D4qsRYk-h2fV3yTm
X-Proofpoint-ORIG-GUID: CIVEZFxmaAm_WVM_D4qsRYk-h2fV3yTm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 08:42, Borislav Petkov wrote:
> On Tue, Feb 22, 2022 at 04:01:32PM -0500, Ross Philipson wrote:
>> In the ioremap.c module, the check for NULL is only missing in the
>> functions we updated but the lack of a check was already there before
>> these changes went in.
>>
>> In the setup.c and e820.c modules, the check for NULL is missing in the
>> functions we updated but the lack of a check was already there before
>> these changes went in in those functions. The lack of early_memremap()
>> NULL checks can also be found in other functions in those modules.
> 
> I don't know how to understand this statement: are you saying that,
> because there are other cases where - for whatever reason - the retval
> check is not taking place - you should not do it either?
> 
> Because I can see other places where the return value is checked. I
> mean, if the return value check doesn't matter, why not make this
> function simply void and not bother at all?

Sorry if I am being vague. I will try to clarify.

In the functions I made changes to, some already checked return values
from early_memremap and some didn't prior to my changes. In addition,
there are other places/functions in those files that did not check
return values from early_memremap.

I did a search yesterday and found there are other places where the
return value from early_memremap is not checked in files I did not
touch. In general the handling of return values from early_memremap is
very inconsistent throughout arch/x86.

> 
>> Fixing it in other functions and possibly elsewhere in the arch/x86 code
>> seems to be out of scope for this patch set. We could send separate
>> patches and hunt down other places this check is missing.
> 
> That would be appreciated.

I will submit a follow on patch set that chases down all the places
where early_memremap return values are not checked and fix them. In
addition I will do the same for early_ioremap since it seems to have the
same issues throughout arch/x86.

Thanks
Ross

> 
> Thx.
> 

