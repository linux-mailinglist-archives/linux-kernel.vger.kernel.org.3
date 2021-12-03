Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED15467DF1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353354AbhLCTTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:19:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55022 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343535AbhLCTTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:19:18 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3IxbPC018009;
        Fri, 3 Dec 2021 19:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=L9wxU1sNDP/o5PS2bALCevAWswxoTtU3MjbvcGSWYAA=;
 b=RXrA7N1axPK9LUPX6yWX+Q/e+ZWfOWzvlwMpo/Dw7jhKyONuEPDkD5O52duOxw7C9oKN
 W7qsc/YuBMDs89nEjvX2K3Tv2CJZAxMjgzaI3XTP14IWfxS/x++xEavyx73xrsaadFLI
 X1qKSpbT9KOZOBon6YCt6B5sEUxHT1mneAnhqclvWOIcJqGWlrBme05qKjmNepIvb0TI
 CBeU+22pDEzJUQBvZtOxCxMiwNDpU/gQpSy8el7qg9XMoK4B1BinWkb/YLDXVfH0rVAC
 Zx2itYI8g48fiaCH0eNUB8iw1ejBXp2TIYO649XvECRxyP8dIAk4C+cMW55MT6dY9k1X YA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cqgwmjyh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 19:15:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B3JAvVl165473;
        Fri, 3 Dec 2021 19:15:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3ck9t6q29f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 19:15:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3GMXcs3Iu4ieFUJzTakU1gyGPLbnhXa0VnyA0s+3Nij9E6lzcAu8N/a1qoahQ07D2b20yZBIu/hdWGwojTS5Wa86Qo3cFNXEttG70c771ToDu2IHBnqLvtyqoObE+EVhOhsqh8WXLVnEkdKUxkusnqkS8wxUQI0POVRmw/Gr+kNaN4E7gsacZ3Z+6jr7wld46OxRrD8ZuTPQECDGJK98ih0nG0pfBvSgWNgvKLe7ktrB0cbD4aS+baGinRsNKnoc3dn9Mrph0a8KeTXXb9EEL75q5kMPPOk40b7jjzDsCoPL3Fh5OIvX/VKcGrmY602/ENfC4OQk3cTkH8c0CIKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9wxU1sNDP/o5PS2bALCevAWswxoTtU3MjbvcGSWYAA=;
 b=aIS3ptnNcE/tZbyQ5eTjdKGCLXVVILXtT4YZN+A1rBCDLANOD249OpbDH7Mxh+yD5/I3yL9G4bS48fm+1CSVk1m+DE7leLPYXjoim53qIk6prKkPq3ecU1w+0qwlPIWSZupmYwCufpx4NbdRrIDS9LMnfMBPkGrNRzmwcXhAS1ixmM8shMtz23Mkryo375fzP1Va+6mf7MZxYFSGIUNaay9uBGeDSkrx9+wYXvMb5pkGxnCyfR99KTVAdP2NygLAsDmmZRN3p5JPP7FG6H2cUQX1HtoGlV07ho1umarNi0AsWj7djOH9LFjVFb6Z1zRWOKiT55Hzu8EzFBQnTALUxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9wxU1sNDP/o5PS2bALCevAWswxoTtU3MjbvcGSWYAA=;
 b=Liii6FQ/pfKNmQIbO8NuRKftb0N7vWl5+Y0LldkVwgRNuuDc4Ai4IHK8gG5dAjiuFqFOZVhkpKicFw3Lchrc5q43k9is+J5KAMZNOSWisjOfVv5rBufoMHOWZIyVovY/RDgfP4sFSMX2uWJFxDA+JsttnMQ1iquZJIBqjpIpzBc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 19:15:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%9]) with mapi id 15.20.4755.016; Fri, 3 Dec 2021
 19:15:39 +0000
Message-ID: <401d58c4-6ba8-b0c8-2ee6-0312fc6be57c@oracle.com>
Date:   Fri, 3 Dec 2021 11:15:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] hugetlb/cgroup: Fix copy/paste array assignment
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
References: <20211203065647.2819707-1-keescook@chromium.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20211203065647.2819707-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Fri, 3 Dec 2021 19:15:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65b6681e-79a9-4a07-6175-08d9b6914b10
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4432:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4432CB44DD107901A9DCE3BEE26A9@SJ0PR10MB4432.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bXhtt9iYm8sX2blRMp6NCRjnx9tIONm/PvNU4Cue5GDL2S9ruF8aLAZFYkRoCoTIvb180QBViatHDtGXRLG9XfS4TBkwYjIfWcP7x5Zf8iZkszSrnJ945TuliGATzJVP7Zg0nPU9h04X4cPVl6X6WHJaHLk34CxhF0/cQgoEQUAJ65agPFhEvH8uZotOWkcq3iGIwFG6G969Jx73rTkX3Xl7AHVC+lGrK0KfGHtAvo+6CslxTx5zqkXnEslaLYpLWa8V8dlua7rZHiuP608IVD+kPAlKoeoHFB+DksE6kURgrYJzkyQ1toM7yCmmFgaivkCAHqU+3ZX5IMbWXtahMjs1fJhbztTxqKyUpecNxgxvkC0o680Ngj+ZoPlLpWpM6ha9rRnlaHuksCASazrHzVlieW4+woCFLPG+rt8wBi84AHFeQyqxLXgpLpEnclrA/9gJ9BBhrBjm790cf9qXLcM31XAChcEFoxdvljCG6/oLpzqbRIQur/PveANVAISG11WcJ7ZKyXO3RaTZQ/R/cwy4YvsLQurGihsiIcWmvrKH4hWsXq3kVD54OPPBXmfLO1AXc/OLcXyNGx0QSbJynxiGTRKsH9CMoDPzzYPYVDGpS2zenwUStEHvkzfVkH/n6jTpyGmSK/MaHnzC4RTa6JK2CBdl+V31+NRID1xNYTgcAKs5CJFRjYgPwXr/q8UsoHrUBPrHF+8E0o7xphgmh3pPC1CsnIDSToS3QweL+1qMT9zfvftcT6HxtRENCs/lGloDwSQmNBW4S11pPNoNwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(26005)(44832011)(5660300002)(186003)(38350700002)(66946007)(4744005)(86362001)(956004)(110136005)(53546011)(16576012)(8936002)(66556008)(66476007)(2616005)(4326008)(6486002)(508600001)(8676002)(316002)(36756003)(2906002)(52116002)(31686004)(31696002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUladEVCK1BBampTeXg3eGEyMzVWZ1RqbWtaenJESnNvUkhFOWx2U0JPUkdJ?=
 =?utf-8?B?clNPcjR6bmE1V3FxWEk3alBNSlFlQlQwbCt4TzFYQkRNV25OMk1CWVc5eHgz?=
 =?utf-8?B?WjVwNzg3NGZLaTd6MTZXNi9VZlBweGRzOXVoYW85L2xvVTIyaUlJYTVHeDM0?=
 =?utf-8?B?akNHdks2LzVYVmlvMzkwQzlVQVU4OUIwVk9BVzg1a2lUTjE3T0ZDOVI5M0xN?=
 =?utf-8?B?dFhvS3prdy9HYm4waHhza2NTWXlhWno4cW8yUnpCcWdPdFc2YkRCcXpKZzd0?=
 =?utf-8?B?NG5reFIyWndaWTgxZ3ZJSjFDZkI3bDFHOXp6OFdJbkVGanRaV0haQ1BISXpj?=
 =?utf-8?B?eDZRMFdNVG5YVDJKajZ6WFN1Z1FiWVZ5MEF0VE11dUt5VmNQdVByWldSV25Q?=
 =?utf-8?B?VW1QM2E5SjJITFl6Yk1aOE83K0tTK3FUQWVmbS8rVjZ3TG9EQkp2eWk0Yldz?=
 =?utf-8?B?c3hJMnlmMHhtTnNRL0hTb3MzQUttMEtIR1kyOXJsaTRHUnYrWE9UQkd3aGIx?=
 =?utf-8?B?SFphK1BjNHZUdkU4QngvRU1oSFpBU1dUQ21ZaEpNYmdNRjB4OG42QmY2ZWFG?=
 =?utf-8?B?YytqUU9lWHVYaGZiUG5FTHduYmk0Z2dJRVNrNnZML25pYkF2WStiMndycWly?=
 =?utf-8?B?WkZyYnV2c2U5MEljbk5lZ0RhZy9pRU9TYkx0YlBCU014YUF3VFZDcE1qcm9r?=
 =?utf-8?B?N2dJaDVxTGpqcnBpM2d6S0JJaE0vZHFraDVxRHhLMjRocFE3bDFPRlc2dzJi?=
 =?utf-8?B?VXY4TTQ2a1BEQkNlOThBdkIxMUFXTkJpcnR0MmlRdEdvaktlMUw1NXpwK1FC?=
 =?utf-8?B?SnBjZTA5S0pDT1I3Q2lBRS9BOEk0WklkRktRTGVRQlpLc1haL3dqanVNWXgz?=
 =?utf-8?B?cUdJQUswU210U2RPMlJxcElQaUw5emZrdFRpWVZ4RnlLNjdYb0greXlMSzFv?=
 =?utf-8?B?bTUxcklaYlk3c2JOeUR5elV5MWNIRmMrYUlHdnB1aEJGVmdzaDJuTk50cVB0?=
 =?utf-8?B?MWpOdFBjT1I1dXM4RzdXTExtY3RybFRqQThiTURoV2x4cnZaMzVLckxDanUy?=
 =?utf-8?B?OCtXbmp0OU41dlJwaHFIUGRBM3YvTWN0OGwvR2pkc2xhQzBEenNwbmlCZzl5?=
 =?utf-8?B?SjIrMkxSYjlzM1JKaEtoNHNtUjRJSWJyQTBhb2p1bVhTYmVwT0I0OUlTWmtI?=
 =?utf-8?B?T2UrK0xuOFB4N2pMTUhmYmhURUF3ZGZHV3o4ZnQ4eVRZa1NOdG5CNURuQ2tr?=
 =?utf-8?B?MXhSeXVWdUJPWmxzYjV4RUpaU3p5YmNsd1VGWVBhZkFZeFgxUXVEU0xzRmto?=
 =?utf-8?B?VmQxcU5DR2lCeUcyb1dOWVpRQkUvQTdPbnVNeUNQZCtsV241WmtPZmxpUjBG?=
 =?utf-8?B?NmFBSnJyTlJHQlpVaGNLK05aRWpyMi8rZVVQc25jNjRidzBEMFRhUzRyYkow?=
 =?utf-8?B?Q3c0djRyQWkvd05sOXg5NmdzQzc1ekpqZVdmWE1GSmNMTTFSdmJMM3k5czZx?=
 =?utf-8?B?aEd0YjFTd2RuTnN0QzM3OWlYWTljK3ZIUzZxc3d6T0lqZHdja2Uyb0dZVFFv?=
 =?utf-8?B?ZkUvS1RhNnEwUE81QisxdjdNNDNFT3l1T1VwSS9aRlJwQ3hQb2ZadE0va0xG?=
 =?utf-8?B?bWZRNW9NK0k5K3JzZHViWlF3UmNiSW9taUpRMWtoREZlOWJYeG53bXBLSW84?=
 =?utf-8?B?MUxIYUE1Rk9TUlpZK1loWVFMRnVBbXY4amFzamdUeXBXeDBRdW5vemx2TFNo?=
 =?utf-8?B?RW5YS1VJMkRFQTRzUHVqRkJrRndmZ0VxZ0IyMG9WUXJyU0RkcEdYbUFZU3RS?=
 =?utf-8?B?ZERkRGJTR2ZsYU5FTVBhOXJVQjdia3RVb0puM1ZGMWN5c2FMQVZuTXl6bm1k?=
 =?utf-8?B?OWtSVkwvQjBKVVo3WDNXWWlrMGtBSElIK01IbWZUMHZxbVJHUldRZWQ1SzJq?=
 =?utf-8?B?QkZZN204eUlzbEpGQ09nY2Y4RUNoN3J1RFM3bmt6dWg4WUY1RWQ0djdnRWFv?=
 =?utf-8?B?Q3VQSU9SYTRpRzU4bWRQN2Nmd0UwaXI1dDVob2lUZnh5ZGRJOGYveUZsWmNC?=
 =?utf-8?B?OFQyTERuSG9iMUFNY0VoVjk4M3VSbXBtZVpTYnNmUnJyVkphMUk2N1V2a2tK?=
 =?utf-8?B?RkRKWXh4Ymt4N2JFQTZwUjZ6TEpBemZFYVJ6Q2pQcWIvK3QwTkJ6UVR4WFlS?=
 =?utf-8?Q?dIkyZw1i8e5EgSgD6PrlLZM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b6681e-79a9-4a07-6175-08d9b6914b10
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 19:15:39.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/Hn4UHQ5K8ZBL7GGBEtcTxuJZdYwTt9ZA++EFxhB1Yfbw5NCb6v25bUeUQOZASxSNIcWwG/Ie+LuQk6lDiLhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10187 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030123
X-Proofpoint-GUID: Q9J-4Y8dLmELFR4iZZrKYMQIr8UyT80M
X-Proofpoint-ORIG-GUID: Q9J-4Y8dLmELFR4iZZrKYMQIr8UyT80M
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 22:56, Kees Cook wrote:
> Fix mismatched array assignment, reported by an -Warray-bounds build:
> 
> mm/hugetlb_cgroup.c: In function '__hugetlb_cgroup_file_legacy_init':
> mm/hugetlb_cgroup.c:850:35: error: array subscript 8 is above array bounds of 'struct cftype[8]' [-Werror=array-bounds ]
>   850 |         cft = &h->cgroup_files_dfl[8];
>       |                ~~~~~~~~~~~~~~~~~~~^~~
> In file included from mm/hugetlb_cgroup.c:23:
> ./include/linux/hugetlb.h:625:23: note: while referencing 'cgroup_files_dfl'
>   625 |         struct cftype cgroup_files_dfl[8];
>       |                       ^~~~~~~~~~~~~~~~
> 
> Fixes: e45f4726bcad ("hugetlb: add hugetlb.*.numa_stat file")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thank you Kees (and Muchun)!

I believe this is just in Andrew's tree and as a result linux-next right now.
Perhaps Andrew can just squash this and ("hugetlb: Fix spelling mistake
"hierarichal" -> "hierarchical"") with the original?

The Fixes hash will change.
-- 
Mike Kravetz
