Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C804049D18B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbiAZSPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:15:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27326 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235901AbiAZSPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:15:48 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QFodkl024352;
        Wed, 26 Jan 2022 18:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=W88DyXe+4TUcvOaMh7auiC5Zk09gyHaJGYfhlkWgrq0=;
 b=sMziExp+CdRi7fQLoQx9+5+JLxVHx9fKFfdCT/obiGArF7DwuEN7mZs8nKue7QU//0Xh
 fwaYeUukgH4ydLPhn8smjYsyejdvwzfzq0xka2H90f6aUawT14DFkQ0akVBjKHIKSBXZ
 e+p2L6+DB0XYcm/cC+V38a5aXHM5WJxwN+KoNC0Xsgeh/iK/OKG3J0mJoo0NY8PS+jtz
 YrPUBidp9FHszwxS9IGgcRkdqoYnfdpNJX6zvn4mlPGZ8rsL6h3qrHw3YFbnXTNhVUM2
 ZRiCFxiu+OZV5PW9sLy+KXt1pM8T4yE61IQXBI334euVYDIbKRYTaXRszA0EjHys56rH Hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s6u54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 18:15:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QI52Zo190340;
        Wed, 26 Jan 2022 18:15:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3030.oracle.com with ESMTP id 3dr721rb0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 18:15:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr/O+McYSCDDjr2wS3Dnw3DGGvxI31+3eRYgRtRJzMJouh0KVd1S+WOYuezHmnyHTexxZz//TMF/lKk8z+hEuRhxFyK8fKUO2/jw06s0HJlIESfR6TnYcEOrvjj+WrTSfWzqq2q/4I+QFFa3AbxJYClHKqgXp3pwIx0e3TrPeeQP0qnFWME/h7AfKZWVLTEj2RqH+e88u3+ZHKEkwxz/KsJLYvohtRKRVC9+AkV8cTJQL+ItX9I4ozbNbaTR+rzkHgyE3ne8H06doJrthitHaTmj3+qDNEtARQ7LDvC3t9ZhKeEqAxxGoQs4x4EEACVmuZ7v+XsGv1rzQHPVbp31bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W88DyXe+4TUcvOaMh7auiC5Zk09gyHaJGYfhlkWgrq0=;
 b=bEjjewLf66aa5Y8deZU/71l4d5VugQ8oVDosez1un+H/zJViy3nkwo+/LTV1fnOq/08WXjHCqiKHP7JPQBuch25SGk/riKrKjq5WIEaB/jV+fG1IBJBLZbp0Ca7P4ohfTLoNzuFQuQkk2yMtTvqRxVTIrnQ49xqs7nOSkDxg9EWCL4S6GzaS8CsJFb5328p4Dz8Ter9ZMiyOm73ubJcQTFaEqkbbj607B76I0rlSqOJibRH/+GC1xdPDTGvKgnjksQ6TC12+hVdj3h7NTMbdb1DXjqZZFeDP6Fp/H/Lf77M7aTEjDkKvLzikYqEAtx+AO1YP8JxIgh0BHhFrphdURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W88DyXe+4TUcvOaMh7auiC5Zk09gyHaJGYfhlkWgrq0=;
 b=WeOJ6j5oiuQP1OOfKOmv/Yy4OhseSmTVrAXx73zaevKpGSn8lCubW3slTv0xSNKz9qekSCChVMn3b0e1U3f0IiVdGaKOUnItKMq0giJ/Df4S+ivRtcMGWBTJBM7MV31pTMZ22J6iGgwah8upqhqDUuP3HWw3fr/5WNd0L4EwKhI=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CO6PR10MB5460.namprd10.prod.outlook.com (2603:10b6:5:35e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 18:15:23 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%5]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 18:15:22 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] printk: disable optimistic spin during panic
In-Reply-To: <YfEdNKWI7GqKr9P/@google.com>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-3-stephen.s.brennan@oracle.com>
 <YfER7tlXZZpX94c9@google.com> <87r18un83x.fsf@jogness.linutronix.de>
 <YfEdNKWI7GqKr9P/@google.com>
Date:   Wed, 26 Jan 2022 10:15:25 -0800
Message-ID: <87tudqwegy.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: CY4PR21CA0012.namprd21.prod.outlook.com
 (2603:10b6:903:dd::22) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3314ce61-bcbe-41cc-d72e-08d9e0f7d17a
X-MS-TrafficTypeDiagnostic: CO6PR10MB5460:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB54603D2CB516AF3F30C9EC6DDB209@CO6PR10MB5460.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eqc1vsSMDYkSaUm1TsWKZQun5idAmCpRxP3S7ls1/9c8BTfB6XhrYHG763FXNW6xSdUUpyv95fobp1xAfgKLhH6lJq8D4nMDeLHhpADNYLN5BCmw49B8PtSQoGYIKN8zzSykGuQrTDbJOH4Z+phTpWX0k2ZvmVaioVSJGMct19HiRNkyIXmsjVDXuQLw9O+3/dSwHwWjFUcnlGn6Vp43hYfMLrqiTf2y12PTCCac+ClB91A4hG2AZsR6epAxSLBIigZOq/GS3LIALR+fqYtaQNEn/B8wk0IR4gnqa/Mkqu7xjtAZSw0KnXxubtLQvIGoHDvEAeyNN2PqS8nBOdycTc9SCPXH5O5StjLUZo6WcL/Ae0EF8VYPeBPx/rFMMA0h7qHP+KNUiBFA1od1vmp3guRvCh5h3emUA2ACwfYCWlTSjyBLlLa7I/Qj/AJ04Lc+adYIB5Phjb3tWuA+smcrQ+0tiRNopC+tRlOf/CYC8zjykOFSvIMx4ej9qUhDy2hgf5EHMBVosmV8Uhz9sfN65VUvfRmKFyv3gAqk2RQ5Ko1reHbKz9j1nlDHdWCz4apMtF39CQW1oPuKsFIKSEIEfDe2+9J42TyWBpg6aPIb+ld/RDGwRdSGNleiS05ypPmQ+kgVIRNlZkQwEG3puEKQsqdlVAvcX7wQ8nl3ksgOUcwAbuFvR6NBDqTe765yQxDgjLe41h6Kpv+dJHkmzRZd5wgiwgFdgk5xesJVGoY1zQriusjKn/IiWpC+HBOTDpLbdfseZcpN8Axj6CslrzICSqnZfsQecUePVuh9YreJmaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(4326008)(52116002)(110136005)(508600001)(54906003)(6512007)(316002)(6506007)(8676002)(83380400001)(38350700002)(2906002)(6486002)(66556008)(26005)(186003)(8936002)(66946007)(66476007)(966005)(86362001)(38100700002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K3uEMxdQvlbcHDhRXaDZXmMtdKv50sYsEGD1EHWiMn1CvGLTOpOl3Gu3FvIe?=
 =?us-ascii?Q?EakfU3SgxD6FdwvUjuV3/drgXyQn1cjj4Ggj+WqAQg5Nbjvoz1a/9ucgKKst?=
 =?us-ascii?Q?LltfVxuAcp6t8CdlbnWGX+Hz58rNaR3mRREjdt2/s/K3Xkk4TbyobEATRb1N?=
 =?us-ascii?Q?fAXCy9YwTtVEoAGc4keG1r9lJPWhTXUq5PHrBb51M+Hw7VZ2zKYlD5YAQu5m?=
 =?us-ascii?Q?2mWHjWuxHml+dzRX9W5eWBMGBuM2Cz6+OkgeX3uOxirNaRQhxf0KvT9uEUX4?=
 =?us-ascii?Q?UaCXn6e3AHDRzi27GwxDC0dR7pvL/03/LzFefcD0KdUsBCpqVPPw58om3V64?=
 =?us-ascii?Q?8RAhWwT5PSRNGcNzWf1Jvx7mi1F/8DAA3sWNlyFSlepBwXV7Q2w7wNnCZi5z?=
 =?us-ascii?Q?pBhnmL+qfo+H16sSDpdtxub68c0n0cf08AY5u0LYA7MgEvnE9ehFxkT0yy6Y?=
 =?us-ascii?Q?jd/V4tuf4mzcyJDT59oQVsM6z15yZ79vUvlcIgVPAZpTnYTBR0uV4zfMxWoS?=
 =?us-ascii?Q?8WcIBR9qjenYkngkdRXjpSrfpiqyPHP88udYK+4WAtMQzIXBJrfKvCgGbX+4?=
 =?us-ascii?Q?sCqq7tSJQXAfibQhqhIyTRIcjYlaadT3HEqffmZYY14P3U+injhcpIKS7Ydi?=
 =?us-ascii?Q?kutpwPDU+CuYab+yY1n2IW5XyqcrDDxKyOn7v2EXnQ7HtWZiS0OmCEDpZTjf?=
 =?us-ascii?Q?WZ0mV1okrBVm0NFN3BBW0Pn2Uv29K/+Sfq3jwsY5o2FfZlCvQQpk5bcN2T97?=
 =?us-ascii?Q?I09uO2/OKk45NdZgCKOb4mjG64DSaonxXqtMoCJZFmA5R+8wJ8MlwumTVQE9?=
 =?us-ascii?Q?rx4PUM97yLzbtQfqtICTNGD4XyJlRiLcfitCs9+EvCSwc5bly2RphlIvxb5n?=
 =?us-ascii?Q?J+I3R8LYpTCagltLimZr0lP9evAcitXkYgpuEMX0eipeCxlz8K2qytiJYPw2?=
 =?us-ascii?Q?LB/PbzK9k7PnBAvDVYv8GU8NIWj3gMXIzlZRIFb4fFC30XaM5ei93NAuoZ5v?=
 =?us-ascii?Q?Auw7nbbkAU6AJfzY9/eQxFUGlKSQOwcoV+OBKVIfa/ThHy3OAuupkXTVEPoV?=
 =?us-ascii?Q?t5IpkONUezLY9mj3vvm0N4hDETxz8O+nQYh6omswocA3nh5VQZqnIzmwgzJM?=
 =?us-ascii?Q?Q6mFcrmuh2YDYRTyEbSAS0afCVAQtaLsCkrDVpVR+Lf+/MYbF3quY2qYuDsr?=
 =?us-ascii?Q?JsI130WJDsOzwQmE6iitJy8mzC3OAtLDRj5D/PpOTt7nM+3BrY5GNOKVjxV8?=
 =?us-ascii?Q?J4sS5N/kP30c/91T+Gn8iE912OB3BI/1Hr60dpa7aqC9Ek28uyD2ogvKAsT9?=
 =?us-ascii?Q?Q333YU/YBHJL703paUD92DFm99cEcZPH5RAhfXSVxg4H8i3gbfRXXFHHrQKq?=
 =?us-ascii?Q?G0t/nEpN2OZCk/8oLp5QYhyC8cohv3K88lefaZmqIf/Pgp102ULkP/nR3YkN?=
 =?us-ascii?Q?Bmk8OYf4oA0Omr/PiYsOXwU2vxWUV555TLA+AZ67e9ZLJwP6U76z7Svp9o0L?=
 =?us-ascii?Q?idp5v4vX6QiZqhR8H7i1O0htgNRf5gxxyRyCrHU85kXCXikfRo/fuPjw0RyP?=
 =?us-ascii?Q?3t59Q1VN9XwvmWcayfQLsRTMKMSwsch1p45XJOveaQf6da26m/LpIgVcxNrM?=
 =?us-ascii?Q?ZezP97VMwM0TVDZyJy16Mq39U5yN/ZOKMPEusnKmV3Iobg4rNj8LKNb91xMo?=
 =?us-ascii?Q?0ZKLPQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3314ce61-bcbe-41cc-d72e-08d9e0f7d17a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 18:15:22.7543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrWKpp9zQ/Oo17tqZ8EFDfqnPgl5isM/ax4dohpfgwJnsDE7cDU0womAVZ4dR8dYUuTNMTepANfyM1Rz+FflrII+tx1NZ0NIdlyrjUFDqE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5460
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=873
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260111
X-Proofpoint-GUID: nBepBwIPE3n1IJs0EEgH6VXq1fYul31c
X-Proofpoint-ORIG-GUID: nBepBwIPE3n1IJs0EEgH6VXq1fYul31c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Senozhatsky <senozhatsky@chromium.org> writes:

> On (22/01/26 10:51), John Ogness wrote:
>> > Is there something that prevents panic CPU from NMI hlt CPU which is
>> > in console_trylock() under raw_spin_lock_irqsave()?
>> >
>> >  CPU0				CPU1
>> > 				console_trylock_spinnning()
>> > 				 console_trylock()
>> > 				  down_trylock()
>> > 				   raw_spin_lock_irqsave(&sem->lock)
>> >
>> >  panic()
>> >   crash_smp_send_stop()
>> >    NMI 			-> 		HALT
>> 
>> This is a good point. I wonder if console_flush_on_panic() should
>> perform a sema_init() before it does console_trylock().
>
> A long time ago there was zap_locks() function in printk, that used
> to re-init console semaphore and logbuf spin_lock, but _only_ in case
> of printk recursion (which was never reliable)
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/kernel/printk/printk.c?h=v4.9.297#n1557
>
> This has been superseded by printk_safe per-CPU buffers so we removed
> that function.
>
> So it could be that may be we want to introduce something similar to
> zap_locks() again.
>
> All reasonable serial consoles drivers should take oops_in_progress into
> consideration in ->write(), so we probably don't care for console_drivers
> spinlocks, etc. but potentially can do a bit better on the printk side.

I see the concern here. If a CPU is halted while holding
console_sem.lock spinlock, then the very next printk would hang, since
each vprintk_emit() does a trylock.

Now in my thousands of iterations of tests, I haven't been lucky enough
to interrupt a CPU in the middle of this critical section. The critical
section itself is incredibly short and so it's hard to do it. Not
impossible, I'd imagine.

We can't fix it in console_flush_on_panic(), because that is called much
later, after we've called the panic notifiers, which definitely
printk(). If we wanted to re-initialize the console_sem, we'd want it
done earlier in panic(), directly after the NMI was sent.

My understanding was that we can't be too cautious regarding the console
drivers. Sure, they _shouldn't_ have any race conditions, but once we're
in panic we're better off avoiding the console drivers unless it's our
last choice. So, is it worth re-initializing the console_sem early in
panic, which forces all the subsequent printk to go out to the consoles?
I don't know.

One alternative is to do __printk_safe_enter() at the beginning of
panic. This effectively guarantees that no printk will hit the console
drivers or even attempt to grab the console_sem. Then, we can do the
kmsg_dump, do a crash_kexec if configured, and only when all options
have been exhausted would we reinitialize the console_sem and flush to
the console. Maybe this is too cautious, but it is an alternative.

Stephen
