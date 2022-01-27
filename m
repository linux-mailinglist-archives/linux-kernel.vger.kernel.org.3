Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CB249E6EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbiA0QDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:03:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15314 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243413AbiA0QCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:02:55 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RFu4HU012805;
        Thu, 27 Jan 2022 16:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UY3C+XUuCgEkLk9iaJx5KBK15k/OuDcvT2x2oj/S8xE=;
 b=Dcr+k7+ra6PW6Nl6hq3xbCHOlrHU3XZKmjDgkUHJRoVfULvPWqiFP10l55ly6V/OXJJ6
 EWCPqDgr4Q0KKME0Q/zz9snSIaGCsGiyIaoEUoTgfXf2itk8E0XHDQDIa6z94YswMbkQ
 +NtgVU/R0VbwcUb0o9QxkjLeL0jA4+foGSnipTVBOHGU0lE7f81RD7526HhbW2IjIMLI
 hPHQkOx9fzR0SpC90udxlb1UrMEcfo8mYC8s/ugId0OvMdLQg4jJCbjnUbtq9gYtruQe
 HOzRmezvDPvXAQzq0nzUViIV9aaO098XujJFbS5KIgJVB8sGnBjSISayOrvI8yMOFRlx 8w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duwub05ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 16:02:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RG1PPW122769;
        Thu, 27 Jan 2022 16:02:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by aserp3030.oracle.com with ESMTP id 3dr7ym3mew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 16:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LafPAEjdrhn5ZmG58Gbvzsmew2ZtbzXICTbC7rRRLOALzZ5qlVSV5UI18FlLF2sCyoVz4lgnOxZW1/XGx+F3vYiQPcTq61TxKsBllhTyOG7R+Jg17A2/9kr77iSEyB1E4qvltjed2yhZk2ax4VYsghjb33SShc0luuwUrXnAAqs54T/jmw1I4qacS73SmjJ0iH8mzViYNHe2SzB+Oo5ElQbHunlps5nzHNnCLsImAmuvwAymf6eKOQY+cXGKUzDNPu4hJCYtmO3uDYQowV62a22ItowU+ISL4QMuvu+owmZsNaOrc1CAox4cxE0E/87mBbV601UVAH0SIGclosfZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UY3C+XUuCgEkLk9iaJx5KBK15k/OuDcvT2x2oj/S8xE=;
 b=Gm3fo902rJHnWtjGehJGYeI/59w/t0ekRicHwRhDTothQe8cFgdVBSqJvYopynKVKz5WNbSaz/5oNZGjkzMsuao63ChXeV4n70aG16CL8cJfsWYdqjUAz+Re0cpgsK173oDt6fUcdEWin/XUB3gIAu4UwMABLlRTq2kwOU5TKvbQYEggmCC0FbQVY+CNx4bz/Nr/m3Hi8JxQbTDNI7TCWSz+GZ7ZBSQfmm9OtZeeOV2SYot3Y33x47CGWjmGGPiN/kW0AJz2WmjXwVdDJP2N/PGT2fPmLTN/A+zDoAphjhGvBPN8prW6tC3bCxh/0RaKNQezWQl+AIuwXv2jdEUF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY3C+XUuCgEkLk9iaJx5KBK15k/OuDcvT2x2oj/S8xE=;
 b=0UJ/cX21opQ6nSqOwv1EEWxFKTGQURvFHn/0XYPIG3iFIPCRhK9qYZwC5z0uOryJgWn4yPRzh5GA616zGjtmpKquItE1KRCGWBJkSCqreOuR++4yS0n1ZjZXsr6tIQDcCuQWh37vWnD3kTsVTZzIbhrOENKjXnQr1QSYvJ4OcW0=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MWHPR1001MB2174.namprd10.prod.outlook.com (2603:10b6:301:33::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Thu, 27 Jan
 2022 16:02:17 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%5]) with mapi id 15.20.4930.018; Thu, 27 Jan 2022
 16:02:17 +0000
Message-ID: <2fa9246d-eddf-dd4e-17c6-8d6565237afa@oracle.com>
Date:   Thu, 27 Jan 2022 08:02:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/4] panic: Add panic_in_progress helper
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Reichel <sre@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
 <20220126230236.750229-2-stephen.s.brennan@oracle.com>
 <YfKtZUiLWkrUIkwn@alley>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <YfKtZUiLWkrUIkwn@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR18CA0053.namprd18.prod.outlook.com
 (2603:10b6:930:13::29) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b923f02-f97d-4d43-3c0b-08d9e1ae640c
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2174:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB21748DEB4BAACB4907A9F455DB219@MWHPR1001MB2174.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLy3vXm5f2trEWOfLrAhQyNkJGkKpRT3VbfG2/a2ZQBy7C2kfBiPmMhRbvJfBcShWEkiWsSVmJKShnjjcr5z2aoPOrR8haETUBBjJ/nSSyXOaCoBoqrzHf1yagWxKcSViRWBrrfySSpIIJI7EfO/+GDVkfYLt89gHDAt7UdGcixfUYlyXEeJfqtXct9CUqzf+ezQtq+pSwxH5fvrdHTPBQmRqvzj+gzQOLp3no/0G1giJoiJUUHIxZ4qErmxdhrAX6MgxYmUUQnwP2t1wH8ctGhyusq0ba/v2styzBhAAYSzEJB+eXqzjkyfRUujBP3IKgNZ1rZTobFiKh2hJDRdfTa91gEZJ6McrdALE+Bo8gtoofL0Qa52PaCWPyAc7s9xzwxJEOnDgiDTIfohZ765y2peQSv3njV2QqQdMi5kwBi5dqyVOcto3/gsMxMbYEhp9NXkYMzN70fI+2Hkj90MeT3rofdQQRWebgPtkk5RCI2kxLgtClJVS95tvda9psT4itndPD97o6Qs1aovFmmL/T9S5n5ItNWeF0oLtfNn9j/eW1vdfHFIwY391DH/ByFi/AszrVvW5fbTOz9DzKM4UcEBitHP578obTXOVjrAUeEc3YLPYTafnZYjG8/Wan0mQL5NAGgbHr7/jbG1CSwhoM8ogGuXe52g2sCZtUKLw6K+Ahc1+17w59z+CqAOzunmCAMlUV6+xqLEoAxGy2ITh2Ud4HyyyHvBUZMsYyea6Bw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(66556008)(26005)(7416002)(54906003)(8936002)(66946007)(6916009)(31686004)(4326008)(8676002)(31696002)(66476007)(83380400001)(186003)(86362001)(2906002)(5660300002)(53546011)(38100700002)(6512007)(2616005)(36756003)(6506007)(6486002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjJEcWpSUDhkdXZZTEVpMll1UW1CYTNIUTBEUld0MXlaemc4VUhCUlBGUEpt?=
 =?utf-8?B?c2dIK2hQeGpUWUlqU2E0aVNtV2JnUng2bDNvK0d6N3I0N04weGkwaXlzbEZW?=
 =?utf-8?B?ZHZ0QzUwdWhGaFROUlQvcTYrd1JVSUF0NFV4Z2RvVERZTmVrcitqMFhqaXNs?=
 =?utf-8?B?bjAzc0VjTm5rK2JIcVVOTXdFOFIxaVBkNGNlQVpQZTUzbEZLbWVkOWJkL0NW?=
 =?utf-8?B?eWJGOWlhMHpUZzk0SmliNlEveVE0SUJrVWh5SFZrUUFYSjQvVXk3OUI1N0xn?=
 =?utf-8?B?cXFTb25ZTFd5QWhSWjJZTERhVGRPbVZ5VlQzNHRaK2R1NWdsRUFqZHcrWmY4?=
 =?utf-8?B?cmhrc1dueXF2cnBodllwcThSNTRQczhUY2wvaEFaTzh5aG9OOHc4RDMvb0x3?=
 =?utf-8?B?Y1RsSHlzL1Jwd1NZNUxrc0hkV3VEUTIxcXhFNVF6TXZTQWJOMUhCZ0I4QXpV?=
 =?utf-8?B?Ulk1dEQvWHI5ODVvblBGa1VWSjMwTngzQ0VNYkhOLzlaeS85ZTk2ZmVrdTBZ?=
 =?utf-8?B?K05idmtMQVVGTXUvbUVBVlVsZHQ2WjYwMEVYeGpHdHR1ZWFhK0dZVUErNVpH?=
 =?utf-8?B?d1hYaGFheDB1eDZDQ1REeUoxdWlTRmlZWWFyUStoU0tHa1NKS1EvMnoxaEda?=
 =?utf-8?B?T3h2bkoyb1JHcUNLbmZkZmZNVk1iVzBDQ3FnTmcxTHZOKy83Nk5lZjZMa2Nx?=
 =?utf-8?B?a05IeVVkVXNTbVQrOGFQSnZPaExEa2VYVkZaSWZuT3g4MVlxem9OVE03Tk5x?=
 =?utf-8?B?VlJwQmxRcnRIKytGclloSFdGMjVLVDV2Zm1WM0JhcGpnbTdKM2x1SjMxUnRm?=
 =?utf-8?B?Qy9kZk9YdFkyZjFBelNiWVZPSThsditEOFlYaGpkeno0d3NDdlMyT3p1SHhT?=
 =?utf-8?B?cXhYaUkwcXFhaFRYV0NMUFN5OS9qVTVuaHdZeTBWZG9TY2psVmduSDVSNFpK?=
 =?utf-8?B?K3Q0cXhpbGhSQnc5aDFEbHJCeGRzL0hiZ1V1bW9nc3RaM3FIQ24wRXpPWG10?=
 =?utf-8?B?VHlMWStZaFY4TFZTRDFDTlhYbHBwZk50UXFWNU5kb0RlMjV1bzVtWFV0aUVj?=
 =?utf-8?B?WEg4cFJSRXR6VFFvQ2IwYks1YnBzWmRaaXkxV25yKzBOamdoTVNMc2Q3U2hj?=
 =?utf-8?B?QVRralNkR29rSWZzS0NaYkx1NEpyR2djQWppVytsYTNzck1XZ0tmUEhVcENn?=
 =?utf-8?B?a1BpeVFHbGpiSGE0eER3cnVuMGlSdXY3YnV2d2IyVFNzdS9ybnhhK0hmcDJN?=
 =?utf-8?B?b3ZXTnRhdjRQVng4YXNaKzcxSVhTVlVCYlYxamdpa3hpZ3V6QkF5bS9kVURr?=
 =?utf-8?B?WVpOWEcxeFIrU3RpUkx3RjR0c0k1cW5KNzlqQmJTMTExNk5VYXdSRGlDblBX?=
 =?utf-8?B?bG1JWVVHRytXQWI5eC9ydWxkUEJ4WnVZOGorUlpoL1NQQ0hmSlBESlpjTUR6?=
 =?utf-8?B?aFdyalQ5NE9pTFRMWEdyK0JqZDJ0QkJkU1NyVnZ3MXJqU25UWjhpczB2TGFT?=
 =?utf-8?B?eVR1c1l1SjJOVU5RWUZTZGdNb3hIVE1NYnhESFhLUm1TREx3bmk4UFdqeTha?=
 =?utf-8?B?VGVySHVQVEFKcFJFeFM1REFPd1VQaW9JZDFMZEpzS2RDd3RGZVRZZW81NDZ1?=
 =?utf-8?B?TkZ6ZlhnRitTM3pyR3FoOVRSaS9XSDIzQUV2MVdFRzJjOHcwc2RzUUwyNmQ5?=
 =?utf-8?B?allHUHlaUWRReDJYM1hienI0Q1U4R2Y5WWtMbGVYLzdKOEpjbmhncGNEQ0Z0?=
 =?utf-8?B?QWtuV0lMZENYeVo2Rmp4VUxESjdNYjdyYlEyeUoyWVUyZlptWTVVQXhYem1q?=
 =?utf-8?B?L0dtczF0QUlmSmxjN3hya1gvd0JSVVBXWEVyWU43VUduTGsvSzkvNk94a0Zj?=
 =?utf-8?B?Um1sWVJOQUNPeWN1cktZQzluS1JDSFNmUXJNbWozSWNaUitJZnZNTnZPbDBo?=
 =?utf-8?B?TFdkS0ZhdG45eGdLUDlwS1hLL2M1NGNhRGx2dEFxWEkvaUFrWnR5TlZraU9H?=
 =?utf-8?B?OW5tNXRzK04zZ2V5LytMZE50ZjlEaG94bG9QZDFuOVlzUzgwNXBSOUN6Ujdl?=
 =?utf-8?B?M0FPemJ5d0pqSUFidmh1c1NCb1kydGR2ekhMR3l4bFdqNTlqYTR0ejRIeGdZ?=
 =?utf-8?B?L3g5c0VsY1luR3c0MkxLUVBCeldHSFBGclJudXBqRE02RC9wMHRKOTV5VWpk?=
 =?utf-8?B?Wk50cnRmSkFaZUE4V0dqYlR3WXhBSGcvNnZOZGFKVUxNN3dyTWVWQzBldHVh?=
 =?utf-8?B?R2xYTmdYaTZaYlhGTTh6NXI0UE5RPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b923f02-f97d-4d43-3c0b-08d9e1ae640c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 16:02:17.0916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLU8uCo/oLtxpX1TlD4Y/v1FvYcxsF/RbeDQjBn4eY/cGwmFdwmzLdCGadTzZdMpWTZt5JBNrpud7c3prMNtbEW6qQI9QZVlP3U0lwHXdeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2174
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270098
X-Proofpoint-GUID: 1Vo_gIcZgY7_6kfi90GKlNtrKiPNxQY6
X-Proofpoint-ORIG-GUID: 1Vo_gIcZgY7_6kfi90GKlNtrKiPNxQY6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 06:34, Petr Mladek wrote:
> On Wed 2022-01-26 15:02:33, Stephen Brennan wrote:
>> This helper will be used in printk code to avoid deadlocks during
>> panic().
>>
>> Suggested-by: Petr Mladek <pmladek@suse.com>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr

Hi Petr,

Thanks for the review, however over the night I received two kernel test 
robot emails. One indicating a new build error caused by this change on 
m68k arch, and the other adding a new warning on riscv. From what I can 
tell, the issues are circular dependencies in #includes. So it may be 
better to either return to the macro, or move this static inline down to 
kernel/printk/printk.c. I think moving it into kernel/printk/printk.c 
makes most sense given that the macro requires the correct #includes anyway.

Thanks,
Stephen

------------- m68k

    In file included from include/asm-generic/preempt.h:5,
                     from ./arch/m68k/include/generated/asm/preempt.h:1,
                     from include/linux/preempt.h:78,
                     from arch/m68k/include/asm/irqflags.h:6,
                     from include/linux/irqflags.h:16,
                     from arch/m68k/include/asm/atomic.h:6,
                     from include/linux/atomic.h:7,
                     from include/linux/panic.h:7,
                     from include/asm-generic/bug.h:21,
                     from arch/m68k/include/asm/bug.h:32,
                     from include/linux/bug.h:5,
                     from include/linux/page-flags.h:10,
                     from kernel/bounds.c:10:
    include/linux/thread_info.h: In function 'copy_overflow':
 >> include/linux/thread_info.h:214:9: error: implicit declaration of 
function 'WARN' [-Werror=implicit-function-declaration]
      214 |         WARN(1, "Buffer overflow detected (%d < %lu)!\n", 
size, count);
          |         ^~~~
    include/linux/thread_info.h: In function 'check_copy_size':
 >> include/linux/thread_info.h:230:13: error: implicit declaration of 
function 'WARN_ON_ONCE' [-Werror=implicit-function-declaration]
      230 |         if (WARN_ON_ONCE(bytes > INT_MAX))
          |             ^~~~~~~~~~~~
    cc1: some warnings being treated as errors
    make[2]: *** [scripts/Makefile.build:121: kernel/bounds.s] Error 1
    make[2]: Target '__build' not remade because of errors.
    make[1]: *** [Makefile:1191: prepare0] Error 2
    make[1]: Target 'prepare' not remade because of errors.
    make: *** [Makefile:219: __sub-make] Error 2
    make: Target 'prepare' not remade because of errors.

----------------- riscv:

    In file included from arch/riscv/include/asm/atomic.h:19,
                     from include/linux/atomic.h:7,
                     from include/linux/panic.h:7,
                     from include/asm-generic/bug.h:21,
                     from arch/riscv/include/asm/bug.h:83,
                     from include/linux/bug.h:5,
                     from include/linux/page-flags.h:10,
                     from kernel/bounds.c:10:
    arch/riscv/include/asm/atomic.h: In function 'arch_atomic_xchg_relaxed':
 >> arch/riscv/include/asm/cmpxchg.h:35:17: error: implicit declaration 
of function 'BUILD_BUG' [-Werror=implicit-function-declaration]
       35 |                 BUILD_BUG(); 
             \
          |                 ^~~~~~~~~
    arch/riscv/include/asm/atomic.h:249:16: note: in expansion of macro 
'__xchg_relaxed'
      249 |         return __xchg_relaxed(&(v->counter), n, size); 
             \
          |                ^~~~~~~~~~~~~~
    arch/riscv/include/asm/atomic.h:295:9: note: in expansion of macro 
'ATOMIC_OP'
      295 |         ATOMIC_OP(int,   , 4) 
             \
          |         ^~~~~~~~~
    arch/riscv/include/asm/atomic.h:299:1: note: in expansion of macro 
'ATOMIC_OPS'
      299 | ATOMIC_OPS()
          | ^~~~~~~~~~
    cc1: some warnings being treated as errors
    make[2]: *** [scripts/Makefile.build:121: kernel/bounds.s] Error 1
    make[2]: Target '__build' not remade because of errors.
    make[1]: *** [Makefile:1191: prepare0] Error 2
    make[1]: Target 'prepare' not remade because of errors.
    make: *** [Makefile:219: __sub-make] Error 2
    make: Target 'prepare' not remade because of errors.
