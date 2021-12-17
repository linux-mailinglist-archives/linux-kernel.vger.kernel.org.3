Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBDA4794BB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbhLQTXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:23:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58576 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240467AbhLQTX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:23:29 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHGXpfx022569;
        Fri, 17 Dec 2021 19:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mXfL+A6zgLm4BS/AQO87DgZdNs/jv8rFGFxDoWbkGXE=;
 b=mmtXlYthItXWg0QBWXmNgTJQ2x7+RIA8KvaNyfVwfa4ERK6y1EE/rPWzCbzlwEydXsGF
 SVdhGjweZcNXp7+oD0/XNFqOkOamomop1aESHYwIdVmW7JaMVRy3a7FXr7Q9gcRZpq5X
 ZBOY+3U0ZsNSkq4znMqOvhJSlS672vWL+QPLLEEmuFWae6v3GC+5AZAbGet+24ffBZKX
 HMut8g6bRkfQFwwpmE48A5kSz/zIcqYjrmhKDz3lsJhyuGn+U9zO7YVqGbATKdDj4okj
 ePGjK5dN+vmm+JzibRp2hzIeJZRE9uA/YdlRxma6WbdQ3K5j87yjAAz37i6aDAjTqfLO Sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmcpffh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 19:23:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHJGeeC034448;
        Fri, 17 Dec 2021 19:23:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3020.oracle.com with ESMTP id 3cxmrfa60m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 19:23:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAfJocytaOGzI/SWcEFPyos8c8X3Prq0CQ1AIMVds9sGko2BrnvTIBnN1ssOCh64+bg1AIoh96I8+DXoYTpou2b9P5DWVy2MwN/U7nwRVlq8GGQ4oZjazRzOO4W6gVwZBhH8M5gkMuAWs2u2gIvt8fDAtB6nwzAKE4AnhCAhb3+h+2YeqMLbvLajPQonnQtyPWxJtbsiDqHZsR6ig+GPt3Jql79qWegNLZ2sjztD2Sg3CnMye4eknbKgyyo4x4Q1xZU8KCy3EhMvvMiaa/WpQGfq1uAZsjiiM2y4n1pHMhXzhF3yRZES3knEF1WarYsb3WBST3vrjBjpUbpd3biRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXfL+A6zgLm4BS/AQO87DgZdNs/jv8rFGFxDoWbkGXE=;
 b=DdWm0Ky5+wesfKh9sr18obo4F0/glTI0b0qBrqgPvwweFJUkDNZbunx3LYovUQsPwdTXqe8j89N/ZV3Y2zZmjBaDPf4tsrn75NKaHpOn99kJb1aXXoq5SFpa8xp/L0F/eYWYRFU3UpH5oF4bn/LmKh/o8YV5h45KZj1IZ9Zwyj805362QEaU/NXPqn1ciTu4pfc0YZmdsRHDgtkvV/cBO//UtYpTLDWYEPg9PvmLqQKvA2LJteplvH5D71TXmtT6BjqFmSs2Hh/gA/9SSUmOCqoDj17fukVlNAwJMwu7/uGnMcNVguJsmjRs1wEwooAOuwfbrOPDIs6dTzer4acHDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXfL+A6zgLm4BS/AQO87DgZdNs/jv8rFGFxDoWbkGXE=;
 b=ERKnlQ9WmA97pLxaPsyaxgonVUGe7GMBsOvJr1rAlZIiNZLE8UGgpU94TOCzdXJIHuJ4Ad40bIyl7L6Elhzy0NoWNGCq5Tm/nsDE2zo1pCigoJbY2XpKh/ufZX4ZDv0CMJk+wRSayd5MCf/I3NN9N2bOxqCNyo+T0p/S3tE8ozg=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BLAPR10MB5252.namprd10.prod.outlook.com (2603:10b6:208:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Fri, 17 Dec
 2021 19:23:08 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12%4]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 19:23:08 +0000
Message-ID: <9a01e87c-9c03-ea72-4115-0cdeb064d1e3@oracle.com>
Date:   Fri, 17 Dec 2021 14:23:02 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH V4 0/6] xen: Add support of extended regions (safe ranges)
 on Arm
Content-Language: en-US
To:     Oleksandr <olekstysh@gmail.com>
Cc:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Wei Chen <Wei.Chen@arm.com>, Henry Wang <Henry.Wang@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Jiamei Xie <Jiamei.Xie@arm.com>
References: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
 <1428a0be-b80c-f996-1f72-6545dd66c1bf@gmail.com>
 <81c97e6a-f5e3-3f5d-c9ae-a35933cf4e61@oracle.com>
 <4cc296cc-c7d5-1bce-4074-b708a18d9304@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <4cc296cc-c7d5-1bce-4074-b708a18d9304@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0177.namprd05.prod.outlook.com
 (2603:10b6:a03:339::32) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a43832a-8294-4ed1-2abe-08d9c192a869
X-MS-TrafficTypeDiagnostic: BLAPR10MB5252:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5252B724B7D43C76AFE8A57F8A789@BLAPR10MB5252.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /h9nIpcJey4AjLxWVU+x5uh9Cy6gQhYMialXmxnhyzqSqa6YojUwGKCQQlUrfKG5eSHZUA9p77V/ZY+oZxeFCpDZgmVSQLbwezsmj4BHNONDZJTOVtlosAM3j1KBPCp52S0RTKtvmU3+g8/1FXuSsoi/BJ2tbhXOnPBdhVBMWrzUd3A4Ohlu99XNEGYBmbt5eGqDWk0esWa7XYybBIFUhGoMmrppm78IfqXMh5wmXj8P/khWHyfLRWWmVIcbmExeMNSLjVRnx1Jg43SdWlOqM6ii4vHfLEg3UEtLn6ND2JlkmkGBDyqAdEJgwhO6qnez3+8LfFSzAyGIuU6igllu4uZ3NZohMaixZCW9CB7pSox/JUGcn6k2mePDO76cneTneoddH67Ixv9/1wRSfmU8DYIHMua5iWEkKaIG3d2NmTwZm4tyk3gdCkCUknVDcCNJV13uC1AEAJQLb1ODJ+OiCXYWxn5mUrovuC+XrHf35XnVxhPKyLeW/NShnH6aiLx93e46bt5d/Ry5pZnfUEyJXI0p/RrKYhJ6udih0VDyj6gyGNNf1X+vkm6cdI0Deism29WcTsxy1oYAqb3S8o/H19Qtx4RN1XneFNWX73juhToVZ+s8Km5x/muvAIqJbi7nD7Zcr51+Msh3rLlEJogAJWPL5O+hoxXhwI3S01T66NsHA+cTP+RJ7CjsEKb6oz0C/e+zORSqn1uZ5HriOebrbIrgnt5JDc0YqPyksealu7TzK4Ol7Zy5pi2//5gAjIuZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(44832011)(6666004)(2616005)(31696002)(8936002)(54906003)(8676002)(6486002)(86362001)(2906002)(26005)(4326008)(186003)(38100700002)(5660300002)(6916009)(31686004)(66556008)(66476007)(66946007)(508600001)(7416002)(53546011)(36756003)(6512007)(4744005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTRvY1B2cUllZTJiNkNqd210V1dkVjF0VWRERkVmajZoK1NKWnh1ZkJRcE1M?=
 =?utf-8?B?djlPVGkwY3FYK0p6MmxOVXNtVndJTWtWSmxQTjJldEliVUw0TzAwcnlOK1A0?=
 =?utf-8?B?UlRUTzVDWGkzMHEyUHdVUlIvU0hIZ3U3TEpXQlBFZzl0aU5VdGZKZzM3ZEVj?=
 =?utf-8?B?RTRSMGlLZGNMZnBVVmpoaWNRQUU0YnFIYm5ZcUFwdFk4dG9SbFJkRmpHWk1l?=
 =?utf-8?B?NFVBaU56eUhocXNzbDVza0ROOGNZRjZ0SURaajFEbjIybjZldjl2dUliamdG?=
 =?utf-8?B?dno4TlUwaTFBallGa3RSNUpORC9FMkZndXJKRzhucmVVZCtKRjNRNnhoT2FZ?=
 =?utf-8?B?aC9pQStMUVl3WXJwUFhNa0ovV0c2UHR1MGx5R28rdVhYNVM3TFdLMzErVmdt?=
 =?utf-8?B?RXgreGoyNGt4Y2h4L0VlcTY1cHM0UXhDdGdoTEtPRzRkbVdSZGh3ejUySmpS?=
 =?utf-8?B?bGhYS0hzOTZwOWUrM2QzVFF5S0FERCtsbzlocmhpZkpDazZGWTE3QVdDVnNJ?=
 =?utf-8?B?cnprcGEwTDVxVGtmV0hKVHpDVXpLaEI1Q1YvWXFVN0pLbkswNmVTa3I3Tmxv?=
 =?utf-8?B?TG44a2RPQ0JqbEJjcnRKUzhMNnhXM1FLTGxxWlpMNkhXSm02QkhaMGQyVU8x?=
 =?utf-8?B?R05uN1p5UWZKNFhTUjRieWMyMldVWis4OXd6b1YwanNSRkZTcXp2NnVkTWwz?=
 =?utf-8?B?WXFTMk9XZk9VTkwxNjRDTmVXbTBuUE5lYWlOV2hwVURoSmRENGpGL1NGQkJs?=
 =?utf-8?B?TFZnQjRSV3lxREZscnVqa1FFQkM3KzcrbUN6WktGOS9HNnltTURYbWlPM3Nl?=
 =?utf-8?B?cS85RTNzUXYvT2dmdElXaGZiQ0ZIK09pbWhyMTJWMDM5TE01c2RHa21MQnFX?=
 =?utf-8?B?d1d4a3F1RXJDOXBrZUhxajNJRHdIVTQ3UnduTjEzdS91cXVQV1RDK1BoTDJ0?=
 =?utf-8?B?UEhNenM0dllYVW9iQStMdzZkYkhVRGxNNkxpSzUyZE16bFRqQ2R5dlg0MUZm?=
 =?utf-8?B?TjdscnJ2RWdibXMrSmhnL1FQcmJaK29OcG9QSTFkVER3cWNQR3dyMzNSRUYy?=
 =?utf-8?B?aHhuV2lYQmNYQmdKVmt3MnBlNHZoKzFSUnBuM1RxRFNDLzZhbWdRWVRhNVdT?=
 =?utf-8?B?NWl4aDFUVWNwL0p5cXJYM0JPQ01XK1Y4SE50OC94N0diVUNJTjh4elAxbFVm?=
 =?utf-8?B?ZkR5Rm0vcXpXcmxWMEZGVXZWVlQvZllhMTVHVjNjOWpXNEZHcEZsRWxYVXox?=
 =?utf-8?B?c1k5WC9EMjFrcWJUKzBUeVNrUjBvODV2SzZ3MGZqdFVLYmRteng5c1hRQ1JJ?=
 =?utf-8?B?eDRrQXlPOE9iODNjdzRRZWwyMFpEY0ZoenM4S0xOTVV2RW8zaUJCdzNqdVFK?=
 =?utf-8?B?WFdTampESmtoa0h5bHFNZ2ovcEExZTFIMDJiOERLRHJrZVU4enV1U0RCUTlx?=
 =?utf-8?B?S0JOSGtEWDArdXgvSmNmWUlhdUhtaHBmSDhrLzRibUpCbjNGWFV5MFdaRGRa?=
 =?utf-8?B?K0JCR2tMY1lKZ0pYWWdHQTJDbE9xdUsrNCtKdi8vOHpFSGlDcmJOT2k5Nkcw?=
 =?utf-8?B?ZGlqS3ZaMWsvN0NkNXJvRFR0dzVWVldPTnRvMEVtMTRyZnNRNE9MVXRvOUo0?=
 =?utf-8?B?T1Jvam12QW5QTWhRY0ZsSlpkTjlDUHVhNzZwcGVFektQM1B5U05xQmFVWm9z?=
 =?utf-8?B?THJGZExxRWgzdG1YSG5xUEI3SGxtZVRSUDh3MzN1VWtzbG5iTm52WEQ4M2Jh?=
 =?utf-8?B?aVNxMXJoeVpRNHRnT0tvbklFUHZNdjkrMUprNHBSelQ0eXJlcW9nM3BickV5?=
 =?utf-8?B?ZkVLSU5OSEt4UUxVSUJyN3lNMjhvUnY1NFJFMXZoR2lFTG5KOE1uRUZFVmt6?=
 =?utf-8?B?UzBXTVA3VjQ0aFo3MFJIemd0ZTJudElZWVpFRlFmQlRDVXhKeW52NllKUlk4?=
 =?utf-8?B?ZnBCdVJoM3hIYzBaSkZtVFlqbFFjeDFFRWZqVHVaQ0dJcXNDSndKanJpQkZQ?=
 =?utf-8?B?am5sejVXQ1c3ZW1XV2ZGTlErcWFVMmZDU3hTYlQ0aTF4Z3FQZXVKcXpueVFW?=
 =?utf-8?B?SWtQbTVqV1RnRElGQzV0NkFXTW44VWdpa0hmY0graDV1blQ4bTFmZ0ppcUtp?=
 =?utf-8?B?LzdSdTNxQ0ExKzFPTG1Ya0NQVTBxRzdiQkZDekV5THlRRzd2NXFYZlRYZ0NR?=
 =?utf-8?B?UUM0eHU1MDZ1bkRjNUkrVDNST09rWTh2aHBMV1AyVDUyVHhYYXVuVFdPL1RF?=
 =?utf-8?B?Tm1halpBMUxYRjZJVTVwRkhETnZnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a43832a-8294-4ed1-2abe-08d9c192a869
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 19:23:08.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAkp6soNi4anjumKYtlfY1UUtH6v1Woe1k+HEeSlI7zX0QA0mAUAoj8mU4dXiG/pah8I8pU0/+z6Qr8RgwFl1QpEs+7A4pPA8M/cDJIlnfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5252
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10201 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112170110
X-Proofpoint-ORIG-GUID: HAN_Fd2cJPnzTnC7mERx-z50_X9d0FKR
X-Proofpoint-GUID: HAN_Fd2cJPnzTnC7mERx-z50_X9d0FKR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/17/21 2:19 PM, Oleksandr wrote:
>
> On 17.12.21 21:13, Boris Ostrovsky wrote:
>
> Hi Boris
>
>>
>> On 12/16/21 5:02 PM, Oleksandr wrote:
>>>
>>> On 09.12.21 22:05, Oleksandr Tyshchenko wrote:
>>>
>>>
>>> Hello Juergen, Boris
>>>
>>>
>>> May I please ask, are you happy (or otherwise) with current patch series (I assume, especially with commits #3-4)?
>>
>>
>> I think I mentioned last time, in patch 4:
>>
>>
>> +    if (target_resource != &iomem_resource) {
>> +        tmp_res = kzalloc(sizeof(*tmp_res), GFP_KERNEL);
>> +        if (!res) {
>
> Yes, this is already fixed in V4 of patch [1]



So this email did escape. Yes, I realized I was looking at V3 but apparently didn't hit ^C quickly enough ;-)



-boris




