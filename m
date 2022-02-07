Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7554AB725
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244462AbiBGIyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349283AbiBGIqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:46:53 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B7DC043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:46:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi6o16cIMVhO9v7PGhcOaUsVN20PnG6MkpNHWthiRx4gXBL3AAW7HkOP9UdZzH7W6wrn7vAXde5cMB3CD7i8Vczbkdl2Y7BWguDDjtFiCKN07HtchWkPsYmLkq6CBSpvJCt9f2pZxogQHeW0YuS7wKySsp5htqaUlwWeuqHPruQbgs8aLPhMvXNZapL+uTFr9hS+V4W/CzVuMLcXWwanIBnZsskX4S4x3N45s+BD7PE4bCvB4PyykM5WnSaEm0IznoPyrM7iQkJqyLhAuXn0TuR0WAIvssv8diTepuWhHFWzN9B/GOishg5UAz1scU0p0McwIDRTZY4sjI5b8RRDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEfq/3Z1dBv84RXpsQPDPQE2z2tIZHT262L+V1iGoV8=;
 b=FKQFFY3pHPBRRDPOFlBvZAxNahr4JHXivTDr2LmIoAFAx7e44ZoRbvf1bujhuZ3pGAx+pu7iqo5Pfa0jJTjaURfnUl8KvZsFVpY6IUleYmtcmjceOZ0jRghfL80qCJH+d+vWtkbN+rcPDyMQiX+MyzZVnvfXNG5tEC4Ju9yORuS/cPi6GKvvhjGb/8LgH8nKHolsrYI5/eU1BhdTodMeC5QJ5bktlyZalRpwIWvlezhucR2EZNUvzNwocCPcJLuSj6IQD2S0c6dgAX9U8/asGDVn3UN7rROcx0RRcGoSAT6Q4wk//pA37zuxxMNwGnQHYpXgW5NjHwZpOCxY01KD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEfq/3Z1dBv84RXpsQPDPQE2z2tIZHT262L+V1iGoV8=;
 b=hGtNNO6rPjONW/nj8O+FyWJSfGE3Gu7WSXq7quxjlW0qGyQohlTTsTXwWPBq6Lg3iA/I4FqoNeyfmHTCgr9Px2kmgSvh4LchlobbTyJbh3Md2B94thAfzlUYBhcigLxfwJx60qtzPlZqKUd/3M/XOmqhEUoJYTZX4xj8WmLkeHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by MWHPR03MB2813.namprd03.prod.outlook.com (2603:10b6:300:11a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 08:46:51 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::fd91:f2c5:8345:cc78]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::fd91:f2c5:8345:cc78%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 08:46:51 +0000
Message-ID: <8798a3cc-6e64-6966-d5ad-fadca79d92ba@synaptics.com>
Date:   Mon, 7 Feb 2022 16:46:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH] arm64: Add read_mostly declaration/definition to irq stack
 ptr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:404:56::21) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10b36d49-414a-4388-a5b0-08d9ea166239
X-MS-TrafficTypeDiagnostic: MWHPR03MB2813:EE_
X-Microsoft-Antispam-PRVS: <MWHPR03MB2813B7996EB3E80636E4843FED2C9@MWHPR03MB2813.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7uBUkLuhLyLJt8XKEK8wvgCOmj3biTDJLHCy1/7/tNV0+KQ+sLAZqBZbWiLFGhYnhg39l0rJ1wbcUZ2fPtb0F3NrAT3iqNOr/WsEkb+8fWm9YQLIFaQz6xMvJ8bxoja0ELlIyczf2Y6Y3gA96ME3ko5BBdaYwQEPqX2cZfNYsUPFpcF0Y57m5dQmznLlhgftlcm/CnyvLDXfEgjuIwUouLr4/kGnQDV6OI4ppTq8RbkmTs3WodwSeM69lSuy1QSDcvSAjzgSqon7P2tkcaJBZV7O/oDK4uG4LlJ7RyOJ8byeRnm1d1Axuc1nzwTX7vXMpPYaZBDM8p3lE/IN9OsHVRn6v1klUGuS9NWXMEUhYVvuv6i5Y9vDkbiF+ecAqWx1UdlrPBzlkeffytTNSAkiSJOQtLt17HHcJPBUyg9B+/QQq+WIIuGWhsgvS7CbQQRi4L77fAGtUYoTulXyFG18ba49jckw7KrnPfPYysFtj+iV32fsJJfVh5a9oFtcUKAE+htCW252r7yJrekQrbkWoZ0n4VuKJRtWEqDWFWXR/zuApFXZ3dRwuwW1UfgnKICvCqbu4CxQXadlmi/Rm4A9qTWvrmQuPs0srkjAvVQsGyoJ9sisXZgzmbThgAiM07pgdmMAgIT77V6+UpihKAbFeKDIDF8zqRjDlG2KMem1GSl76PLq1WA47mm1feM46E+2Im826zWO9tBp73cvU3AeAyF9WdZa5Fvug+SQ2OQMTpzu2yE8aaeSmEOQp1+B7eW6B0Nndhv0KG16p1LLOp7TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(508600001)(36756003)(66476007)(86362001)(31696002)(66556008)(6512007)(6666004)(6506007)(83380400001)(2616005)(26005)(186003)(4326008)(5660300002)(316002)(66946007)(6486002)(38350700002)(38100700002)(110136005)(8676002)(8936002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2lQTGd2ZGwwT3J3RGhvUzU0cUwwNHlUQmw1YzNDc3d1SXF0MXM1dFo1cGFT?=
 =?utf-8?B?WmorbTM3dzlVSDRtN2R4MlJ3TU1WdU1mZnZyei9haVJwY09ZREEvL3ZlWEtC?=
 =?utf-8?B?RmVQRGxUeS81SUpvTFpGNlFIZnliMG1Rdy9ZYnpWVWZzbGQ2aXpnOGhvOVg0?=
 =?utf-8?B?Z0pKeHplMUgxbmxjc095ekI1TWgrNndHY1BCbVd4azRsNFJsZVdKdE5MNTVF?=
 =?utf-8?B?dXdOMHpLelVoSEEzSGI2RUQ1dTJvMXdDcEtVMVFQaTljNzNoRkc4MlUwelZz?=
 =?utf-8?B?V1RjSWYxcDZKSDMvYyt6Z1VCbzBhNmdzMUhlcGhUaERuVWhuWDNzZFB0NTN6?=
 =?utf-8?B?MDlaT283bTd2NGZURVovTFdOSXhOZXJIMk1xNFBwZGxrRUgzRDRJMXQ4OVFO?=
 =?utf-8?B?bDVmRXJWeERpY3h5Nm9qU3ErdERZaVJVejYwM2p6ZEplZUtpc09iNWRwak80?=
 =?utf-8?B?V2JkQktaSUlJbDkyeVlOUUlPZ2Z5aXFIOVRoRUVHanpoZWNTV094OVVjNElE?=
 =?utf-8?B?MFN5WW0xbmJTeFgyNFNrekNoNGZiZ0k2WFpSMHRXZ1Q2djJ3cStFalo4N2Fq?=
 =?utf-8?B?SHFQTERGYUZlY0RyV0JCakQ0bjZMU0Y5TDRYWTNkV3JWaHBwa2JxNGordHFZ?=
 =?utf-8?B?SUJxZ09WZGJQT2pjSzJZaTV2YVBxaVYzL0wwN0VEVlFtVHFYU1Z6SGwwSFJj?=
 =?utf-8?B?b0czbjZXbHlxbVdidDdDSmhsemQ1aXl0U2p0dVlFVnlwd0oyR0N1MVJ1bkVT?=
 =?utf-8?B?VU0wQWE4aHB2U04zS2sxbmFTUWtQMnRBRGU4WHJjek9UWWlVM1lacnYyTzhE?=
 =?utf-8?B?OXpQamNOTGlJZExRMXdOU0ZTNENLZVFLOVNaNmxKSko0NzNJU05FYWdaeDhB?=
 =?utf-8?B?dWNSSW1qZEE5QktFdndVTWhkek1qN1ZtM0t6eTh0VDZPY3prZGduRXJHZ2tq?=
 =?utf-8?B?NGhHK0NlY3B5a3UwRlRiZnZWYjdwZTBwcWxkWSt0d2JLbk9FV0RNZWRqd2Mr?=
 =?utf-8?B?bmJ2SUpPQUdwdmpDRW1aZnQ1ek45Sy9FMHRGTi9PUkcvZEF0NU1HK1I2REVC?=
 =?utf-8?B?QXNoMUNpc3FETEJTbXlsd3FkVTh0NVgrVG55bGk0Z3RudVFqRzU2L0tNbGJ2?=
 =?utf-8?B?SFZJajRwRmlhdEQ0c3JjdDFxbFFmY0w3c21qdXJROVJKNTBnWmlQbmNlbFVy?=
 =?utf-8?B?ZHovelBDZWZZRnFVWkN4Z2NGZmQ1RW8zRXArdTdiZktXZGZyaUZ1UHg3aGJV?=
 =?utf-8?B?RmVFZWhRWTA0bUVLZnN2OXBIOEpJbG9ENnhGcVAxT2xCRURYOEV6aGJuSy9w?=
 =?utf-8?B?NEdlc2w5OUl1MS9IcU9lQ2lkVDRHTVdGSldlbi80UmRyVGVWUGd6S3RkUGZQ?=
 =?utf-8?B?MFZQRVgvSklZRGRnZEtLUVhQdzZCZDM1TVdvVzNFL1RKbTBOMkZPQWQxWlYw?=
 =?utf-8?B?OEZ4dENzR2hHQW9aQ01kYU5TMFlZYjVpam9xQlFrSjFrZEQzRnVPdU1FVXRz?=
 =?utf-8?B?Ukh2ZjluSGw0emhxZWxhU2cxL2lKV0hWVTVtWlJEWlJIMkY2emR0ZUxUV2Rt?=
 =?utf-8?B?dmFVbjhlMFd2UklPdE5XV2ljL24xdWRmTUpZeG40ZE9qajFjY2F5Q0RJWmRW?=
 =?utf-8?B?VW5PVjBYd1JwdjdLSFZJRTJKUzBHcDljNTBnY1hpV1FMSTFTRkcxRHRJSjM5?=
 =?utf-8?B?d051WmRXSzR5QTRHN3UvT2dTL2tVYjA3VG9mY0NZa21ZWUhMcjRjYXY2dk1Q?=
 =?utf-8?B?WGZadlFieUdXNHg0TUNrTkg3eG5xczhNZnpiYVlWQkxYU0VhZzR3eUozOGJr?=
 =?utf-8?B?TXZJd0lQL3VxNXRTUDgybGxWZlVSVXFJQ1ZMRXR3RGo5T0d0TThSNGd1RkRt?=
 =?utf-8?B?MXI1ZWl0TUhWSlNRYyszNzlIc3NRZmd1SmdzSnRvVEZFU3pLMEYwTkRqaGVr?=
 =?utf-8?B?K2FrQ0xmSUFsYjRtbzlLTC9LUVVKZUlCSlM5QTNIamtNVnEyMzFOc2szM2VT?=
 =?utf-8?B?NjZwQktSa1N4cElxamhaTVNLQUxQbTljL20rWmpqZUR2YkpxMlN6aXNlWGg5?=
 =?utf-8?B?TzZTVU1Zb0pDRXBEMXhmdkgzZ1FHNjZZdm13ZW9QUUdqQXRyc1hSSnM2dzdt?=
 =?utf-8?B?c0UyRkhMZVdWSVFOSmoxb3pXMCtLSmZzWTRWUU9DZGtkZ3ZZQnZHLzd2NWdo?=
 =?utf-8?Q?wymYXCZwp8x2v0QQ5OigX8w=3D?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b36d49-414a-4388-a5b0-08d9ea166239
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 08:46:51.0260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRQItADrkUgATxS+9dNJ0UrE6j6WrNc+HULmWj71mbT5whm8Yk9SS3VGwdwRQkSpynEq3VG+yMPn9vs2nHYhkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2813
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "read-mostly" qualifier to irq_stack_ptr and
irq_shadow_call_stack_ptr. This is to prevent the false sharing.

Before the patch, I got below percpu layout with one defconfig:
ffffffc008723050 <mde_ref_count>:
ffffffc008723050:       00 00 00 00
....

ffffffc008723054 <kde_ref_count>:
ffffffc008723054:       00 00 00 00
....

ffffffc008723058 <irq_stack_ptr>:
        ...

ffffffc008723060 <nmi_contexts>:
        ...

ffffffc008723070 <fpsimd_last_state>:

As can be seen, the irq_stack_ptr sits with the heavy read/write percpu
vars such as fpsimd_last_state etc. at the same cacheline.

After the patch:

ffffffc008723000 <irq_stack_ptr>:
        ...

ffffffc008723008 <cpu_number>:
        ...

ffffffc008723010 <arm64_ssbd_callback_required>:
        ...

ffffffc008723018 <bp_hardening_data>:
        ...

Now, the irq_stack_ptr sits with read mostly percpu vars such as
cpu_number etc. at the same cacheline.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/include/asm/stacktrace.h | 2 +-
 arch/arm64/kernel/irq.c             | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index e77cdef9ca29..75c142bfdffe 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -66,7 +66,7 @@ struct stackframe {
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 			   const char *loglvl);
 
-DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
+DECLARE_PER_CPU_READ_MOSTLY(unsigned long *, irq_stack_ptr);
 
 static inline bool on_stack(unsigned long sp, unsigned long size,
 			    unsigned long low, unsigned long high,
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index bda49430c9ea..d2e75e9bb826 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -26,13 +26,12 @@
 /* Only access this in an NMI enter/exit */
 DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
 
-DEFINE_PER_CPU(unsigned long *, irq_stack_ptr);
+DEFINE_PER_CPU_READ_MOSTLY(unsigned long *, irq_stack_ptr);
 
-
-DECLARE_PER_CPU(unsigned long *, irq_shadow_call_stack_ptr);
+DECLARE_PER_CPU_READ_MOSTLY(unsigned long *, irq_shadow_call_stack_ptr);
 
 #ifdef CONFIG_SHADOW_CALL_STACK
-DEFINE_PER_CPU(unsigned long *, irq_shadow_call_stack_ptr);
+DEFINE_PER_CPU_READ_MOSTLY(unsigned long *, irq_shadow_call_stack_ptr);
 #endif
 
 static void init_irq_scs(void)
-- 
2.34.1

