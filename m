Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DA14B7B29
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243838AbiBOXZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:25:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiBOXZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:25:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A532A9E9DF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:25:20 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FMYjJH008692;
        Tue, 15 Feb 2022 23:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cRi/8hSjhtri/YziIk/amVafGNBU7VdEkUnOoZ+3lTM=;
 b=jkUjLzCjdgAuhar62wl+9L8VUggwEqfNgmg+uL77Hq7cXijbPcraZffzBOSfc+HHBUZ2
 nsP+4FdeiW8WjNQNutRQbnmpemA0PYzZOtEDTJ9PPPvK5ncjktwJE6OEshiNzuP+6VlY
 W2MOybY6n8QNDgdmVI8sFA+2+QtWLmgNQoxt+CFcFwNGtRCHbC8eX1yg7txTeIjpE8Na
 KBZZ5+krwpl0SEIphpJ0SgSHHjfJ43vQ3g8LYtcqeJYFqrViyQP5HLX1gkAiv8FH/qUN
 fPE1Jjo6S0U9W4URp3b3dwhyrPPNHW/Xzp3FMCqhwuOftV3cHfui0fk/oGb7Qg+7TSgA pA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3dr2f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 23:24:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FNLhOa114457;
        Tue, 15 Feb 2022 23:24:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3030.oracle.com with ESMTP id 3e8ns882na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 23:24:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhR0YututcA70OOZ0x+NRuRmwCecW1hjoYdOAvS1RmnYjaB+FmtCNNHw/ij1uxRcQMmNGN+pu6rWhL+uSpP7zf+jEUIUXtVXQr+MHH5OHY7FBT/FP24MLVGuc8pfxz+d5XKSPaQi/xpcbMkDZlzyXpi12vzV4E90yf76BRQ/TECW9ytiloOJMHf7jSfvH8rnJl/Maub15aqD/htsuc7peZhC19s9em4WXUzmuGxixr4Lia5EQQxO+qsHu/yFN/nDylvRD/o0PVp2rotXP7PzV4tY4fjM+zzH3lImz2KsHpNLcSxRnfBRX0k6vkPdEgc9y5UOImUadc6ksv9PheeMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRi/8hSjhtri/YziIk/amVafGNBU7VdEkUnOoZ+3lTM=;
 b=Y2Nit+TQMaNvFuODQ1iEJtERwc0W9mRq2wl0G3zJDp/AnXIIi5U/15sM33kpyuPVRuDdrwM2OVFZ/Eo2sw4+8fsx2jtjUpo6AUjRumqJ2kH8gnY9h9CbNW9Jl0WodYeQuTih1ucxFpVsow6CFnOfOBKENfK6JO25jZqLEujqqkRGbknJInjp1Gp+c0DMBkgsHs9W4CsZBVFKe3keSgY5BpXJ6CNUELrrw473UJMBtr0WmmgxT5B10EwsdSIwyeB5/T/GslCzAHqBg8B3fa2z1KMYyZzlvbst9GIsUcfiCjpjYCu+OHqM65f79IUaSC04Mtp50z9bfi7Nvg1FAt0q5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRi/8hSjhtri/YziIk/amVafGNBU7VdEkUnOoZ+3lTM=;
 b=vOc+h973RMA1P5uUVZkBgITSthuOC2ZjRRLzFNcBssb191IYYZKY069VcUd3llSolhHCHuyXClwjzaxCAiCdqH4fpkyg63ZqPJy+EYpW6UYPMjKMM0P8OdZnn4I/5i4MD1EF8Yt9M5aBpYt7VJ+u7924DFybsVr0s8p/k9d1qdM=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SJ0PR10MB5801.namprd10.prod.outlook.com (2603:10b6:a03:423::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Tue, 15 Feb
 2022 23:24:54 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::a1f3:1518:4e2e:b69b]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::a1f3:1518:4e2e:b69b%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 23:24:54 +0000
Message-ID: <3ad45074-72c6-8844-ba00-caa95e11ea7c@oracle.com>
Date:   Tue, 15 Feb 2022 15:24:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 0/4] printk: reduce deadlocks during panic
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
References: <20220202171821.179394-1-stephen.s.brennan@oracle.com>
 <YgTZPQEay6T/nhu6@alley> <8f08bb64-ee8a-9555-f4a1-6d55d3c77531@oracle.com>
 <YgpfAsC1EZSbpDOv@alley>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <YgpfAsC1EZSbpDOv@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0027.namprd02.prod.outlook.com
 (2603:10b6:803:2e::13) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddaa81e3-deee-4c8c-c34e-08d9f0da5f1f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5801:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB58011C0F8ED47FFCEC0CA15FDB349@SJ0PR10MB5801.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cU3nO1qQkXxdKQ99rC/N8ZkkWdrqn8Y8QcfSDFYxTTUC1r0II2GlduhS+s4y7FupwuZcEupJ/0kUH+JlKE854OeR2+aFt/omFuxd2/JOSLJq6unud/4mxvkxH5BHoXhduMzMzjKfrTTnehuzYcL4FEYOWVYiJhvuXWJGmVBNhAEllwK5qXcFKLLhDAOH71I0fnQ78JrNzg0ZSbONrjwO/5nhfzglFC8LUJ7HnxRUZsGfuVrq+EVkEdfFt5xwV1+JiDW8FHFCviifYGyt7D9bJO5LhlkFc8a70ZBEfwMdiAWlisz1VXnDQejMOLKBXpgouleibDe+7Ho+JYTg9xvy2WHGlJLgCTFY/0rHs5t8wOJKtHToGqHjxQmGVJ6C+2fnX8bBSMlLlyDL8RRO8eStehwiizQYlKNaTbQRi6KLnLHkIcsEqmoBYYfTE1ScgXAycST/JC1aJ2ZOpax0MHtr8OszNHrE6IA+vAq79QgToAb3pdnKesPwVly2+wKIBJ108XR5q264YPPSC0rJfC9ryYBLu6Fe3SFiLuSYctFZEQUaoIP1tN7+Bou3S003I2HvNjoviYQgJVvSFfrWZiimfj0eBM2JnzURBDqav9Qes5FGYtmHnDsFGV7+k1/Ki+whBnaUz0PKQ/GDtTkvCZZvCi0oJfO0GUddq4gn/3qPnzOcs0YAw/eTX6DW6vhRr26tIqDsy1Q6tv77dBHg9nwUWXAUfExmWJF74fAHL+ure+dPlXNXenbHYY5mmNdyCZHVivv0Tm4Me+uUJvnD/5riIptiYe+1nJcseLGhvEsF8/VQsSOa4eF/rKIf7Z98bf9e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(316002)(86362001)(6512007)(66476007)(83380400001)(8676002)(8936002)(66946007)(26005)(54906003)(66556008)(2616005)(38100700002)(31696002)(186003)(4326008)(6916009)(2906002)(5660300002)(31686004)(966005)(36756003)(6486002)(6666004)(6506007)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QS9IeHlnR0ZHMmlXdGhaSmorbFlLcGRUMmlnZVlpR3BXeXFWSzJyYzlBTWQr?=
 =?utf-8?B?RnpjeEpqSVhLbDRnNVVaRjBCTFFUVk5GWWhIdkpHSWFOV1dBeDNNNjBZbUxl?=
 =?utf-8?B?RUJnSGRGb2k3M1RxWmloaS9WRlB4M1pKTm1la0h3MVlEa2RMUWZUcFRrSWJi?=
 =?utf-8?B?TEZvN0RUcXlqUmtRUDZ0ZmJTNmMwQXVpNURFbHF2OS95WDUrWDNEbnlPWDhQ?=
 =?utf-8?B?UGZtNzNkcjZDMVEwdkQweW1nOEV1aGNSOUJrQ2NjREYyTFRvS3pXVE9YRlI5?=
 =?utf-8?B?amlWZEtFWE00bWtvcEU1UlVVMkhsaVNnTzd2TElRZjNFY1JKVG9LUVpCU3Nw?=
 =?utf-8?B?MVBGTWRXNmFJdDliV21pVTZ4VGt4enFFV2FOMjE0UzFyZU8xL1Z2Yi90S21K?=
 =?utf-8?B?aDNtV0FMaEpycjQ3SVhFSGt2T2pzb2sxWkU5TFZIUUVMZGJsN1oxSC93M2dE?=
 =?utf-8?B?bzZyR1lDZjRTRmFMRGxybWliclJmQURocWlNWG1CYTFSVXhXTGxhd1l5eDR5?=
 =?utf-8?B?eFI1dFowL1oxazhwMmNUdzBSMUlDUS9RaWU4ZFU2WlpEVmFocG5EUGptdDk4?=
 =?utf-8?B?R0wyT0k0WTh5Tm9ObzVjaFU5ZlFsODI1bmZJNktqQjgxSk9EbXE3cUQ3NDVm?=
 =?utf-8?B?MTlNenFhUmduNWNnaHFFRXFpUEU3UldFckdsT3BZV2hxMUlmbmxKZ1h0VnN4?=
 =?utf-8?B?VUhpT1R3MzJ6QlA5UlhjZU1zbkNyTWplTVB2OUY5SFB3SWpVUlFkdnlCYmhv?=
 =?utf-8?B?YXF6TGNKMmNRZU1sMXYzTStPQ3FTZmpFZGptWTE3MGxqaENscGN4YW5VNGwr?=
 =?utf-8?B?dkhjcWN5elJnQTJqOXN4d0dlSko0c1c1eHZLeDFWT3M5VmExMDgwWlYrUm5X?=
 =?utf-8?B?NUdEcUVSZVJxM0FBTTV5aTEzN2dQei9vTXo4akFRQzErZy96Ynl6R0FpVHlE?=
 =?utf-8?B?dTNwaFdRVXRXWDZ4QlBXNWFyTnBMYWhzTzlFOUdHSXMwakZMczVpKzY4R0dP?=
 =?utf-8?B?cXhnTDBYOUFtUHEvdG44SWxRN0NVMEVFeHFzZU9JMjE3R0N1VktnS29Oa2Yw?=
 =?utf-8?B?MmtlNktIOFJZNUJIQS9ESWtXNnhXek5DbHVCUk5Jako0dTJuaENNYmNSdjF3?=
 =?utf-8?B?bzZ1Ryt1SDNQY3BDSW9rRUxIc3FtOW5TRSt1UFluYUYrdGY2eEtIcHowT0pC?=
 =?utf-8?B?Mnd3MDNYRlgrRzhNUnRoTmw3SG16R2U5MUlUblFIUkxUSEExbDBuZWN4bjE4?=
 =?utf-8?B?cWU0Z010RHhNQWx2YXkvM0RKL3R0bUdySnEya051Q0xMRU9TWk1GVXNEelli?=
 =?utf-8?B?Z0JJaXAyUnh2SWs0MnZuNWFaUlNFUEE0TDFsZjZzc0pPdnNPd2kwMFVmRndz?=
 =?utf-8?B?RVAyaU95dUEybnN0K3l5NndycEhhMG0xUFB4cVJ5bjIrL1JzUlZTYlJIWnpi?=
 =?utf-8?B?OGkwaldpVlE4WWFDZ0t4UzNnRDRkQ1ZSMUhwdzNabXdNNkJxZlpzbzNHWHZa?=
 =?utf-8?B?QWpjeUNYSnBoQ2dVSW4vV3BrRHFtYWx6QnhwQ2JORW9mRWxBL3NDUlpYY2V4?=
 =?utf-8?B?RXJXdTRtak5hVDNlS0ovUWF5a0RQVTFLQ3pBMk80bzNQM1JYaTlvNGZ3eUZF?=
 =?utf-8?B?anNGNzZBL1Y2MlhCQlUvblFNMmNEYUs1VTlFME40Ni83djVvWi96dG15aFN4?=
 =?utf-8?B?bFRaWVZndXBQM1A2TE9na3VPMm1QQndtSXRHTGV1NmRUSDhmVlJQdEt0Zm5q?=
 =?utf-8?B?Y1ltUkhnYXA2RDF2ZXJjYy9HNnpnK2VYbHJCUkdSbmFrYmZPQzMzRzduSnE5?=
 =?utf-8?B?NTFKeW9hMWJnRUhycG9RVm9wbHg5a0o1ZjhscFZJbFp0M2dUeTFRc2JMRTFv?=
 =?utf-8?B?YlhWRm9NQ3NoU255aFpGNWkwckFMai8rV2FSUHhPekJiSjVoUk5iZkZ4eFgy?=
 =?utf-8?B?WCs1SVdZSk1mVzZ3eDBLcWwrSEJwK2pXMFRkRzlsNjRqbkdja1dyUEV2Zi9H?=
 =?utf-8?B?K2ZxRmJUeGsvK1QyOXFqLy9MVW0rM0ZQSGRGRkxXV0txc2t2cjYyc0FaK1I4?=
 =?utf-8?B?ZEFHZW9IalA0R1NmOWwvT2w5ZlZ5WUw0YzBpN2h2Z3JOd3RWMklnVEk3SVRV?=
 =?utf-8?B?clRlbkVVVmp5dGJmZzNmeWEzT0c5dHhlR1phSHExaHR6OVNzKzNuNkkxY3hj?=
 =?utf-8?B?RkQ1ajRjQ3J2QThRTlA2N0lpdzkxeU9vSGtCMVhjVVdqcVVseFdlNFcrOFV3?=
 =?utf-8?B?RjZtYWNaMUZGd29iM1dSYU0zTTR3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaa81e3-deee-4c8c-c34e-08d9f0da5f1f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 23:24:54.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDOdAH9cbaUhS5SS7l0XQ5CVfVg4DPU5PaPp5Jrqe27FpPJ5uwJnnxuv/7HyxXTV+eaHYCdDpxxr6Ooy/qBs8tFsa4wQnq1NAh5547Cryhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5801
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10259 signatures=675924
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150134
X-Proofpoint-ORIG-GUID: n2hp-vnP7O0hT7r0jevQW5a19N3HebIr
X-Proofpoint-GUID: n2hp-vnP7O0hT7r0jevQW5a19N3HebIr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 05:54, Petr Mladek wrote:
> On Thu 2022-02-10 12:06:44, Stephen Brennan wrote:
>> On 2/10/22 01:22, Petr Mladek wrote:
>>> On Wed 2022-02-02 09:18:17, Stephen Brennan wrote:
>>>> When a caller writes heavily to the kernel log (e.g. writing to
>>>> /dev/kmsg in a loop) while another panics, there's currently a high
>>>> likelihood of a deadlock (see patch 2 for the full description of this
>>>> deadlock).
>>>>
>>>> The principle fix is to disable the optimistic spin once panic_cpu is
>>>> set, so the panic CPU doesn't spin waiting for a halted CPU to hand over
>>>> the console_sem.
>>>>
>>>> However, this exposed us to a livelock situation, where the panic CPU
>>>> holds the console_sem, and another CPU could fill up the log buffer
>>>> faster than the consoles could drain it, preventing the panic from
>>>> progressing and halting the other CPUs. To avoid this, patch 3 adds a
>>>> mechanism to suppress printk (from non-panic-CPU) during panic, if we
>>>> reach a threshold of dropped messages.
>>>>
>>>> A major goal with all of these patches is to try to decrease the
>>>> likelihood that another CPU is holding the console_sem when we halt it
>>>> in panic(). This reduces the odds of needing to break locks and
>>>> potentially encountering further deadlocks with the console drivers.
>>>>
>>>> To test, I use the following script, kmsg_panic.sh:
>>>>
>>>>       #!/bin/bash
>>>>       date
>>>>       # 991 chars (based on log buffer size):
>>>>       chars="$(printf 'a%.0s' {1..991})"
>>>>       while :; do
>>>>           echo $chars > /dev/kmsg
>>>>       done &
>>>>       echo c > /proc/sysrq-trigger &
>>>>       date
>>>>       exit
>>>>
>>>> I defined a hang as any time the system did not reboot to a login prompt
>>>> on the serial console within 60 seconds. Here are the statistics on
>>>> hangs using this script, before and after the patch.
>>>>
>>>> before:  776 hangs / 1484 trials - 52.3%
>>>> after :    0 hangs /  15k trials -  0.0%
>>>>
>>>> Stephen Brennan (4):
>>>>     printk: Add panic_in_progress helper
>>>>     printk: disable optimistic spin during panic
>>>>     printk: Avoid livelock with heavy printk during panic
>>>>     printk: Drop console_sem during panic
>>>>
>>>>    kernel/printk/printk.c | 55 +++++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 54 insertions(+), 1 deletion(-)
>>>
>>> For the entire patchset:
>>>
>>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>>>
>>> It looks ready for linux-next from my POV. I am going to push it early
>>> next week unless anyone complains in the meantime.
> 
> The patchset is committed in printk/linux.git, branch for-5.18-panic-deadlocks.

Thank you!

> 
>> Thank you Petr! It occurs to me that some of this could be stable-worthy,
>> depending on your feelings on it. Patches 1-3 resolve real bugs on customer
>> systems, and they'd apply back a decent way. 1-2 apply all the way back to
>> 4.14, and 3 would apply with some minor changes. I suppose the question is
>> whether they are simple enough. Patch 4 is useful but I don't have a real
>> reproducer for a bug it fixes, so I wouldn't say it's stable worthy.
> 
> Good question. If you saw these deadlocks on customer systems in
> the real life then it might be worth it.
> 
> I newer saw them. But they hard to debug and report. Also they are
> visible only when CPUs are stopped by NMI. And the default
> smp_send_stop() tries to stop CPUs using normal IRQ first.

Some of our default configurations like to ship with 
crash_kexec_post_notifiers=1, so I see the aggressive 
crash_smp_send_stop() code path a lot internally.

And interestingly, Hyper-V enables crash_kexec_post_notifiers in certain 
cases, without so much as a peep in the kernel log, even if kdump is not 
enabled... So folks running on Azure or otherwise running Hyper-V guests 
would be exposed to this. I actually just saw some patches related to 
this which you reviewed, so I guess you're aware of that :)

https://lore.kernel.org/lkml/YgDZX4PYwhrA1+Ct@MiWiFi-R3L-srv/

As somebody who mainly browses subsystem-focused mailing lists I didn't 
see this at all, as these printk/panic related patches only seem to go 
to LKML. I guess I need to check out the new lore+lei system so I can 
keep track of relevant work.

> 
> Anyway, the patches 1,2,4 are pretty straightforward and should be
> safe. Feel free to send them to stable.

Very reasonable. The customer systems experiencing the issue would be 
resolved by patches 1-2 alone. I did not have a customer experiencing 
any sort of livelock (and it would be a pretty ridiculous situation, 
most printk dies down quickly). I see the value of patch 4 for 
architectures without these NMI so I can send it too.

> 
> 3rd patch is a heuristic. It tries to prevent livelock and the cost
> is a possible loss of information. I am not 100% sure that it will
> do the right thing in all situations. I would wait one or two release
> cycles before we backport it to older stable releases.

Fair enough!

> 
>> Of course we have the logbuf_lock in 5.10 and previous, and if a CPU is
>> halted holding that lock, then printk hangs even before the optimistic
>> spinning. I have patches which reinitialize those locks after the CPUs are
>> halted if necessary. I think they are reasonable for stable - printk is
>> guaranteed to hang without doing this, so in the worst case you trade a hang
>> during a panic, with some other sort of printk log buffer bug during a
>> panic. But in the common case, you eliminate the hang. I can send that patch
>> to linux-stable as well.
> 
> The main problem is that the locks can be safely re-initialized only
> when the other CPUs were stopped using NMI. Otherwise, there is
> a risk of double unlock. Such a patch would need to be arch-dependent.

That's a very good point, thank you for mentioning it.

> 
> Also stable people do not like much solutions that were not used
> in the mainline. So, it might be a waste of time.

True. I may try my hand at it simply because I would much rather see 
work be done for all via -stable rather than in vendor-specific trees.

Thanks,
Stephen

> 
> Best Regards,
> Petr
