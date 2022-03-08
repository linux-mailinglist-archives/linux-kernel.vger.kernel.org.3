Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B77B4D10D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbiCHHVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiCHHVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:21:50 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2107.outbound.protection.outlook.com [40.92.98.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3C033A01
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:20:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MV25DVh6GGp6Nei2CW4c0z3TCI1lhwrwG0cSsJY5HeIVrDgk+84oFJynm1PjUXtuYZeSdZoJ6MSxIIDz+UuKp5N5pdXsoFL1wI8yFRjVz1N8pvLYOvTPGcp8lS0NnBSGwJ2BJHxOb4n43AxZIPtPXR8TkZA0PJbKRrajXN78KGQdidxZrGRLubIIasIirC0QA/3JJzComNfFgtgccWlRvQ+10Z1skiAflfbhx1KUKi2B9PKlNWs3lmTqiz/7vR1+Ms3f61unQU1JSSMDzLF9flU5PtT68wso3GyO6HlTk+iBbRGW4Rky+Y9AymvWlutPnL76RE8nTfJqAboPtNMRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLCRGFu+EUTQwd+fnwhFpLwAGrMADTZA+PYrepvilvc=;
 b=mh9IUuJyfucGB9tovH/BiivvrhPVbAT62oGoFoyBz+8/UN6+oxrKu4QgZcuFTTj27wX0Q3MF96j1/iDFudm0QfdnViMQOuwDbmBD34nv/rKh9uav984T3BXO2QRWxLTXElROUtDOtkSeY7Tp0+CFpswY8cfPN0bJsKNmpPJ/MIvAjc5s6z24zrAE9Rsf/P5n0K76wd/nXdlbc35IDvDmuPG1/uJLt4ge4AebUOvdW24Qb6jWHYePE4F+gbIA3kftBUbNMOooMG6UFYqIDJO/kFg5OMW8BhVI2PF7FsHV5Yw1BxIpuuP9zfgj6hCm7wr7FJDY8LMFADgw2bzL9HrY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by TYCP286MB0654.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:4e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 07:20:49 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d80d:59f5:2572:ab1d]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d80d:59f5:2572:ab1d%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 07:20:49 +0000
From:   Oscar Shiang <oscar0225@livemail.tw>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v11 00/13] extensible prctl task isolation interface and vmstat sync
Date:   Tue,  8 Mar 2022 15:20:04 +0800
Message-ID: <TYCP286MB19138239EF8668D7B7EED00BA1099@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204173537.429902988@fedora.localdomain>
References: <20220204173537.429902988@fedora.localdomain>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [u8VxRjJjwQYsDp7NON0RsuoSMWy6kQAR]
X-ClientProxiedBy: SG2PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:4:7c::34) To TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:11e::14)
X-Microsoft-Original-Message-ID: <20220308072004.4002-1-oscar0225@livemail.tw>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26be3a63-7089-40d5-b720-08da00d42bdb
X-MS-TrafficTypeDiagnostic: TYCP286MB0654:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3Na3vT5QhxcKn1z01vGyI7+ZHFAOTVbPCx50cv0fOKaF5kY5PTBsJ4JqgWNXgTNIa4kUfnySuEb3p8YMDSKcGXj+NkNZVAGoaMltPbEc9MQATvVwGWddwB/Yph6bgmlqn/oGAi2bMeChq2hG1aeWTQezk1u8RnuNtOrOOoLbkdK5MLxzlAChyagnk9avfav1OzhyPOBjbvmtPrvOsFQ28ANSiRtV8eiT3Mgvu9dOWJLM4q1a/6y16yTsXj42cHngr3JL95ZTvUT0qO0liJ81rSJY2Mmh9/IJNX7lHPnGmFIbBpTMo6KhFm7aLyFU6opC9vi+CwqX7HWDt8rb8eHuw1P2egw/BXP4csRlstwOF2xrIi1qvBjwfYFIjsgZ9y8a5GvZusrZ/3wB69+rDduqY71mkmgxqk7F6OUCw5SP+33CfDQcMed0KedY1ZUWn3zFijZ2fykyvh08BHtkSnsrQOGkH7yPsrEIQmi8fAihJOPrKM8+Oge3naERPH8iitZFu4q4qYWQBWt3t+SdWHQlyBTfNYwFz2VJoQgMMkrT4kC55hM9f1BpfL9lg1CabauWibSfBeie2XDZ4bazAuajQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ESpS5hc02O38Pbutrdfl9dyl45Sv7MOFsq1sC5fBQCxSDYUnz85JJ2pCF59?=
 =?us-ascii?Q?90BztYJyFKVKUiBMDoVKeml1HLdouKRPgUy7p9/ajIROW2prBt+bFRxDdSDe?=
 =?us-ascii?Q?k6ZVYbkd7E7zWI2fzEAbwnlRwNKUNNnJNEbAubLnHSX7KfkO+46j86D06j3j?=
 =?us-ascii?Q?EAbebgDTcE7Qw2SqcR33tnmBJoS02mKhYV1jHLrS4JRGl8XftUOOUKt9JOF9?=
 =?us-ascii?Q?oVVscfvpQ+a+Wof/rNtjvoBrqCOr5ZXNacWTotBJozNNoDIO1L+Ev4kAtHsO?=
 =?us-ascii?Q?pHBBMzFT0u6jzihyRuyx+rJRqwQJVXi1uaQLlpOtT+rR4Sh1CyglUctEVgWF?=
 =?us-ascii?Q?Jlyd5J8NIBSVwiWhFuy9TdEYGl/Lk8P2rTtMlgcGVmhUy3jKSbPD1UXGcYPx?=
 =?us-ascii?Q?9ZyxJKvVxmDyTLQm2ox8MDERHn+OCsp13s/tnviot/3WpblyIskv/gsj9QfO?=
 =?us-ascii?Q?Skeb5KcDP8tIGjnZMaWmegvPQl7hhP/1VQPheUW03UcBhx22ly2jkNUdF1rk?=
 =?us-ascii?Q?mIDsCluBCzLh4e/C2O6Nae3EKcprj/ivRt6XPmxJ1PxUeENkEDpzSEpEWswG?=
 =?us-ascii?Q?v8sOAI7zzlR+eHKSPTHg7Qjk/9X9bxOyTYix0FU569IJ4bC+8BwHnClInLwV?=
 =?us-ascii?Q?tdiBdIA56mtbhdG3XZzQEd7peDX6Ivm8QGBkTR6rOvQ6Yf7zsJdzU9pQmrPv?=
 =?us-ascii?Q?rQ1W/o46C8vtev8QDS7Ngt5L8eL903hsB03RopAKJJdtt9IUpmIING8XJSb+?=
 =?us-ascii?Q?A1CLUkixjuNY2UXg88udEKGDS+0D5hYJ3Q8hFC0m5P4ymje3dwnAVqzwT8gw?=
 =?us-ascii?Q?Wle42JuS2PHHMfUh1M+krirTjynIozMNQbQqgfLfAV0HWRSyqVnBaCJkpKbx?=
 =?us-ascii?Q?uZtAKmBJeFPhi+t5F9ZnMll5KdBAYkNbyQdmkhq4d0xzI4nQWa7CKe4xR243?=
 =?us-ascii?Q?MlE2zO1Tfd+I70jJP40ZJw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 26be3a63-7089-40d5-b720-08da00d42bdb
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 07:20:49.8512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB0654
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I also tried to enable task isolation on arm64 with the following changes.

Maybe you can consider these in next version :)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 6623c99f0984..c1257bca1763 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -72,6 +72,7 @@ int arch_dup_task_struct(struct task_struct *dst,
 #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
 #define TIF_SECCOMP		11	/* syscall secure computing */
 #define TIF_SYSCALL_EMU		12	/* syscall emulation active */
+#define TIF_TASK_ISOL		13      /* task isolation work pending */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
@@ -85,6 +86,7 @@ int arch_dup_task_struct(struct task_struct *dst,
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
+#define _TIF_TASK_ISOL		(1 << TIF_TASK_ISOL)
 #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index c1257bca1763..c136850d623c 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -103,7 +103,7 @@ int arch_dup_task_struct(struct task_struct *dst,
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
 				 _TIF_UPROBE | _TIF_MTE_ASYNC_FAULT | \
-				 _TIF_NOTIFY_SIGNAL)
+				 _TIF_NOTIFY_SIGNAL | _TIF_TASK_ISOL)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index c287b9407f28..8308f6dc5d4b 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -20,6 +20,7 @@
 #include <linux/tracehook.h>
 #include <linux/ratelimit.h>
 #include <linux/syscalls.h>
+#include <linux/task_isolation.h>
 
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
@@ -945,6 +946,9 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 
 			if (thread_flags & _TIF_FOREIGN_FPSTATE)
 				fpsimd_restore_current_state();
+
+			if (thread_flags & _TIF_TASK_ISOL)
+				task_isol_exit_to_user_mode();
 		}
 
 		local_daif_mask();

Thanks,
Oscar
