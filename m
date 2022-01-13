Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7394F48DE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 20:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbiAMThT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 14:37:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5418 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234749AbiAMThP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 14:37:15 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DIO312021953;
        Thu, 13 Jan 2022 19:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=RjQjbrMooWMYNPuyeVf5/wmf4tmkATo+wqk4F76rMxs=;
 b=eXwu9qz9/DvaeaW9+88x/0NTE/PySBw0KQYU6/+fTehF41xG2N6ZPC2CKHOBstiFWh2Z
 ypRQF/FsaT5xYwaivhDhRKm3c5maRvNVU5GVDjdMVHQKUSmmkSt6dzZqJD2abCuZtp4R
 Vg/rFZt+ABYFRRe3Q+8ODH2ML265GttWK2cRjGScqOROXkybBKIUrCqQ9bIsTpwd5ikS
 v/2eEl96htol8XUoGXIRY91cPcP7Jupj6pKRyWa7Aggxx9U8L+WY8m0d4+lNghFwkzN0
 VcPxQFDyrPIx4ZQbqMqnqi2FCb4yuP6A8XKWfuciDHgjK4ldE95uZuMnWX+24JNX6Oin kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3djmhw1es4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 19:36:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20DJa81h012257;
        Thu, 13 Jan 2022 19:36:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3020.oracle.com with ESMTP id 3df2e8afbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 19:36:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3jrnLJjERpoDsn3rU57MQyWYkXRNkzm2iwQh2MRaBVAwWYVgVgoYSoCgVF6qJoWc3zd/ZfYSfRwwd0jLYeOft2IfVvFP2MT1OfJK4Ksr16V33oBs5ZF78wzz6izz2Yn+q6b+0bCIyMsM2XXz0KDdSAIY3G2zSxSmvpi1lr0FaL26Ty0o14HNf77IwjHzct9rH1oDOCsTvSTcpPzxLeweUFAKjGkEsJzg8/R7RheJM3x8zK+hTKXssOBU1IGspN58ZzZwk6a9eIa4IhP1nN8I4GjuLT7f8ms27xsEck9iuZBlhUkeeOfMOOgKoLd+8+zky99PSjAZoXJ3IU35Eef+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjQjbrMooWMYNPuyeVf5/wmf4tmkATo+wqk4F76rMxs=;
 b=Chm6XD2wlAIcAYZr70miFozhFXsxTecocMeFrAANVIOQw0hFYzKRd1yqd3+Wy/TotwTudjSt3AbFcL0p2x3fS8R/Zpa986Ba7Z3dZzc59jRNEvvzwRYrQZpZ17+vMW/rnT1Mer+njW2TNwgL8e+kSNwNArOOA5ZCP7W8KbMuGsUnDTUaz3br+AUfwVsh4OdZXmiH2uFThrrokjwtAVQTHd9m4AnQ6Xoo2gu0Wn8vhzFqYFklJ9xu5jbE1/3nagp+K+NBUtfH6rSjLF0Enzkaj2t/BQuDM1BYTXAf2W2lsycQDUogK1fti7zJEzUZgGlI6pobgM9bvbjsiOrfida/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjQjbrMooWMYNPuyeVf5/wmf4tmkATo+wqk4F76rMxs=;
 b=Miy1ZxXihVbpyphK/vfgLH3V3LJi1qIQPjRfRcZuDgqXaYmUas5kmrUYYq9Xl78PzblERQLjB9EqqhsbinW2vZI7r6hMCuOtdrwFbAH/u9fPSWWBM/BwBO/+KiOECWiWnChfZksGydDSGzhqcBKA9G9X20AQ/kxRhlQX4QQifmw=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 19:36:38 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::e430:bb9e:c983:23bf]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::e430:bb9e:c983:23bf%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 19:36:38 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] panic: disable optimistic spin after halting CPUs
In-Reply-To: <YeBjzX7Z6J1cVtjC@alley>
References: <20220113005425.74988-1-stephen.s.brennan@oracle.com>
 <YeBjzX7Z6J1cVtjC@alley>
Date:   Thu, 13 Jan 2022 11:36:35 -0800
Message-ID: <87a6fzxwak.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:40::19) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d833eda9-6425-4013-0459-08d9d6cc0437
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5600:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB56009CC303D1451D7B6E0AEBDB539@SJ0PR10MB5600.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4U/et39NVZRz/N3jm01dQUAFJQwOYiDjrl7YELq62upC4laNNJhPp730Lla46UTGLe0rxkFn1dhuXKf/PRMGoAhipK0Emg2L4YbqXMpsq4dVRqWtx+A09dYaPQEfk25D2ybYJf+EIRoa1BeQmeh9ceNRPFJCY9JIF0hRC6Hk57ewpDp4IAawsZ3u7xLIJinDOLXPCFL+eLKRPzP5cg8poJQ1PfkFX6B2lljLElMX7rfzD5WS37RtBprc8W7uAnzglHB6EqmzA3XhKUmnpvjmssmwMNXonxouSuRRD2Kc8DdORb+2Gj/Mzso991d1zc5OY+Cu8poWHd7FekLMVQL5UW9Q7GRUugWA6rHny1Zvp+m9vGqD6I9tPPn5gPHAR9kjqrcsBnOsHJYUgt8uBFIR1gVuc5lgVOG5myVSjTccuSGjdHpVNmIRGMGMCufm+FyZfmNIxBpKLuBuNBXG3haez2uHtauSXIdSmTOjPVl5Ygz5ExGkwipaufgBG2HaI4D7alce16maw3e2/ybHYX2oYhZ6h5VA35f1Oo4Jj+hvvgmDYSWIXshHMyqdoIX9kHZO2uha4Gh2FZ2mHE0wUDAmznzGse6m6OZnuQGr8EIltTZV3cBlNqKpf8MIiit47YU0FYaP0x0+j4EH+T4N1KO8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(6916009)(8936002)(6512007)(4326008)(86362001)(8676002)(5660300002)(38100700002)(186003)(83380400001)(508600001)(66946007)(54906003)(52116002)(66556008)(316002)(66476007)(6506007)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Np6kcprk2JqHADCgCAYByoz1NoViDLzvdZBkoxpHPf3Cr9SUxWtXSdgQnw6U?=
 =?us-ascii?Q?2KqOsMzb5c3lhbQM6f3FA924IAQ5RNAKvzAIhpzU7LxIkFAL/TAvyKJsyhoX?=
 =?us-ascii?Q?fYTHx69hriaVn1Ao8LJ7Uw9iklrxf4Vp5sikJnYDSRNa6hM0q/jwqQctVqYk?=
 =?us-ascii?Q?qAdOi8qkTHxsk3moDuo7ChRPUiWEC4I3G6ZVymOZ2ZnkaVpQ3FAaKqtOt2gj?=
 =?us-ascii?Q?tmQaVqkR0W7GtCiEisbg/EAoXo13J8g7wCCPacdm+MgeXvh6f9fSZHy2XZLz?=
 =?us-ascii?Q?6jFyPn4IA9Z51XdaeKnixl+Bw62VGbfRdxjZZmvGbdAm9pFSKHvlHgCNqqRE?=
 =?us-ascii?Q?P4abv8YK5hapuzDd6RgGzZbHuiXuwvoCwH4bXHAiSkytMzRIBGSO9PC7Y8os?=
 =?us-ascii?Q?ICEQ16WAvGu+JP5TNwT7HUC7uys6gi0mtEnkvB5ovYOb1IYMzUx47s+gNAFN?=
 =?us-ascii?Q?kdbb/LqT0/abg9WsuMmSQa9qUyg/2gXZKWOYBwVryGnWhH7QhirO9+PUR8Bn?=
 =?us-ascii?Q?iRfLQxvx2Wj+8pA4/v8HdO64ESlfOYXggfZx4/4wzOXl154saIqLKZ5NHIdq?=
 =?us-ascii?Q?FWIkVnLk6k/dx1KVyjl7q4lMa9uizJ97NWOeZBE5KBmz0aJvlNwcrc2fP5Uo?=
 =?us-ascii?Q?qYpsB8BaSSCWplJ7g52JUJbsal4uva5lNk5KsCi/bA9YH868IgWabsjx/WYg?=
 =?us-ascii?Q?0vaOufIXKN0xSHlacbcSlznIteken9enyf1qylrDpOsWewANjDnJh+/5HrXQ?=
 =?us-ascii?Q?bNSyL3hfOeml2qDgghcZJuEMwHGOOsXCbKCzc4IeUScyUf4iddRWOXu+ngsk?=
 =?us-ascii?Q?A5Kb8cHlcpQ+zz2pNosyTGsj79Rw4kJtA2WuAAICJGAOmaxXOFNxv+/TJQ++?=
 =?us-ascii?Q?RUVs9eJ5V0WkVVJHvlzfN2pVWGMQoGPSZ1tp5uUoPqcXyitBMFjcPqYkuRJg?=
 =?us-ascii?Q?Q5zYnCTVa1vfjvSW/U/MNDeHRjkBCvPe48/Lj3Ysn69wHQPa57G/242wLWTG?=
 =?us-ascii?Q?NP/PWNusuh22u8lwF17zt+RaMYajWV3JD0K0GTOKzIDmABDEYS6Wx0uI3zRK?=
 =?us-ascii?Q?qxgrc6XAsObdXqXfHfJ7UoQb2RlZBp2orGRSD9rJA0PiMPLNbgsqMN86ZrD3?=
 =?us-ascii?Q?LOKc+6ItsmuI+PPtYCChU8hcQ4FO8dyXzujRwcdux1zh9F/tmPiOFthwfOm5?=
 =?us-ascii?Q?4nqgPqVr0a+DWxilEkznCBDFQ/wiG2Ho6eZbOA+itTPCYLJUVCDwdH0JoEO/?=
 =?us-ascii?Q?mIDKskWBUsrS7yyCFCYhjvT57hAAIRfcHHgiAKsLqPMgDUW67DRv8kPUjPrC?=
 =?us-ascii?Q?I7FXcGGDilAwONO+K5KuKkIuTpuWTKNQxF5AqnHvaVXhQKwAftZxCaIFG/WT?=
 =?us-ascii?Q?wrnsHeBPbIouHsohXTaXiLrj1RIxqlpwQv+gAX3cLzpawrUUg73wtz7bezh9?=
 =?us-ascii?Q?1QzzSznDbqhzQFUwx8izZb6d7BRJLFL/LEnSFoSWp1Nn7UDQW7jauSRhnFq+?=
 =?us-ascii?Q?OqP+r9hviAsvoZn31xc25eKZ7EVRXvJjsqIfW7iRejszPgrzl6sDXWonT0Q7?=
 =?us-ascii?Q?FoKXlz203vNKJIObGX0pLFyAuRpj3vz8Yio2m/bulK8YUR3e1ThtPKC0VBTE?=
 =?us-ascii?Q?WZWCa4N8Y+AW+fhJ/frpx4D/GsFoMXCxo3sdZGMDH2Macbtibrk4RKPC8vWZ?=
 =?us-ascii?Q?OHT8S51Sdfsn6Q76G3eAkYcR5Be/vOaAUR/l8x3+j75MUjaxpkYTLHnvAkap?=
 =?us-ascii?Q?SR1Cmlk+7Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d833eda9-6425-4013-0459-08d9d6cc0437
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 19:36:38.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HmkG1FRaJNAk2kIb/KAEavY+/cmVCu20vVfEMQucxpyFUCu+Q9Fz2sm3q1PmUgVT2aKqkUAJw+Oxq2paSRlxZtRuzs9/HpY4F4uJXvoTmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5600
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10226 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130122
X-Proofpoint-ORIG-GUID: L3e2HNWR-tniOW3oZMC5wBPacKM4cikM
X-Proofpoint-GUID: L3e2HNWR-tniOW3oZMC5wBPacKM4cikM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

Thanks for taking a look!

Petr Mladek <pmladek@suse.com> writes:
> On Wed 2022-01-12 16:54:25, Stephen Brennan wrote:
>> A CPU executing with console lock spinning enabled might be halted
>> during a panic. Before console_flush_on_panic(), it's possible for
>> console_trylock() to attempt optimistic spinning, deadlocking the panic
>> CPU:
>> 
>> CPU 0 (panic CPU)             CPU 1
>> -----------------             ------
>>                               printk() {
>>                                 vprintk_func() {
>>                                   vprintk_default() {
>>                                     vprintk_emit() {
>>                                       console_unlock() {
>>                                         console_lock_spinning_enable();
>>                                         ... printing to console ...
>> panic() {
>>   crash_smp_send_stop() {
>>     NMI  -------------------> HALT
>>   }
>>   atomic_notifier_call_chain() {
>>     printk() {
>>       ...
>>       console_trylock_spinnning() {
>>         // optimistic spin infinitely
>
> I see.
>
>> This hang during panic can be induced when a kdump kernel is loaded, and
>> crash_kexec_post_notifiers=1 is present on the kernel command line. The
>> following script which concurrently writes to /dev/kmsg, and triggers a
>> panic, can result in this hang:
>> 
>>     #!/bin/bash
>>     date
>>     # 991 chars (based on log buffer size):
>>     chars="$(printf 'a%.0s' {1..991})"
>>     while :; do
>>         echo $chars > /dev/kmsg
>>     done &
>>     echo c > /proc/sysrq-trigger &
>>     date
>>     exit
>> 
>> Below are the hang rates for the above test case, based on v5.16-rc8
>> before and after this patch:
>> 
>> before:  197 hangs / 340 trials - 57.9%
>> after :    0 hangs / 245 trials -  0.0%
>> 
>> Fixes: dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")
>> 
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> Reviewed-by: Junxiao Bi <junxiao.bi@oracle.com>
>> ---
>>  include/linux/console.h |  1 +
>>  kernel/panic.c          |  7 +++++++
>>  kernel/printk/printk.c  | 17 +++++++++++++++++
>>  3 files changed, 25 insertions(+)
>> 
>> diff --git a/include/linux/console.h b/include/linux/console.h
>> index a97f277cfdfa..4eeb46927d96 100644
>> --- a/include/linux/console.h
>> +++ b/include/linux/console.h
>> @@ -179,6 +179,7 @@ extern void console_unlock(void);
>>  extern void console_conditional_schedule(void);
>>  extern void console_unblank(void);
>>  extern void console_flush_on_panic(enum con_flush_mode mode);
>> +extern void console_lock_spinning_disable_on_panic(void);
>>  extern struct tty_driver *console_device(int *);
>>  extern void console_stop(struct console *);
>>  extern void console_start(struct console *);
>> diff --git a/kernel/panic.c b/kernel/panic.c
>> index cefd7d82366f..a9340e580b20 100644
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -265,6 +265,13 @@ void panic(const char *fmt, ...)
>>  		crash_smp_send_stop();
>>  	}
>>  
>> +	/*
>> +	 * Now that we've halted other CPUs, disable optimistic spinning in
>> +	 * printk(). This avoids deadlocking in console_trylock(), until we call
>> +	 * console_flush_on_panic().
>> +	 */
>> +	console_lock_spinning_disable_on_panic();
>
> The proposed implementation causes that the panicing CPU takes over
> console_lock even when the current owner is in the middle of
> call_console_drivers().

I don't think this is true. All that
console_lock_spinning_disable_on_panic() does is clear out the
console_owner and console_owner_lock, signalling that the panicking CPU
should not attempt to spin and wait for the lock.

The only time this matters is when another task already holds
console_sem and is executing presently in call_console_drivers(), as you
said.

With console_owner set to NULL, console_trylock_spinning() will get
spin=false, and thus it will bail out, returning 0. Thus, the panicking
CPU would fail to acquire console_sem, and so in vprintk_emit it will
not end up going into console_unlock(), or doing call_console_drivers().

It would not be until console_flush_on_panic() down below (when there is
no other option than to try to use the console) that the panicking CPU
actually attempts to call the drivers.

>
> It means that calling console drivers from another CPU is not
> completely safe. This is why console_flush_on_panic() is called
> at end when the console is the only way to see the messages.
>
> We should not do this before kmsg_dump() and __crash_kexec()
> that allow to see the messages a "more safe" way.
>
> I suggest to disable the spinning when panic is in progress. I mean
> something like:
>
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1842,6 +1842,10 @@ static int console_trylock_spinning(void)
>  	if (console_trylock())
>  		return 1;
>  
> +	/* Spinning is not safe when the system is stopped */
> +	if (read_atomic(&panic_cpu) != PANIC_CPU_INVALID)
> +		return 0;
> +
>  	printk_safe_enter_irqsave(flags);
>  
>  	raw_spin_lock(&console_owner_lock);

I think this is pretty much equivalent to my fix, since it also results
in the panicking CPU failing to acquire console_sem during
console_trylock_spinning().

I do think this is better than my fix :) since it doesn't clutter up
panic() even more, nor introduce an additional function. It even avoids
resetting the console_owner_lock spinlock.

I'd be happy to do this as a v2, if you'd prefer?

>
> It would be also great when the current owner releases console_lock
> so that the panicing CPU could take over it.
>
> I think about the following. Well, I am not sure if it would help
> in the real life because other CPUs are stopped quite early in panic().
>
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2646,13 +2650,18 @@ void console_unlock(void)
>  
>  	for (;;) {
>  		size_t ext_len = 0;
> -		int handover;
> +		int handover, pcpu;
>  		size_t len;
>  
>  skip:
>  		if (!prb_read_valid(prb, console_seq, &r))
>  			break;
>  
> +		/* Allow the panic_cpu to take over consoles a safe way. */
> +		pcpu = read_atomic(&panic_cpu);
> +		if (pcpu != PANIC_CPU_INVALID && pcpu != smp_processor_id())
> +			break;
> +
>  		if (console_seq != r.info->seq) {
>  			console_dropped += r.info->seq - console_seq;
>  			console_seq = r.info->seq;
>

I suppose this could help reduce the odds of a CPU getting interrupted
during call_console_drivers(), and it might reduce the odds of
console_sem being held by a halted CPU during panic().

However, it occurs to me that there are two cases:

1) a kdump kernel is loaded. In this case, crash_smp_send_stop() is
used, which (at least on x86_64) sends NMIs. In this case,
__crash_kexec() will not return (barring any errors) and we won't ever
really need to get the console_sem.

2) no kdump kernel is loaded. In this case, smp_send_stop() is used,
which (again on x86_64) sends regular IPIs. In this case, we know we can
at least avoid interrupting call_console_drivers(), since that executes
with local IRQ disabled.

So I'm also unsure how much this would help in the real world. But it's
a small change and so it doesn't need to help much in order to be a net
positive :)

Thanks,
Stephen

>
>
> Note that the above code is not even compile tested. panic_cpu is
> local variable in panic.c. If we go this way than I would define
> some helpers:
>
> bool panic_in_progress(void)
> {
> 	return read_atomic(&panic_cpu) != PANIC_CPU_INVALID;
> }
>
> bool panic_in_progress_on_other_cpu(void)
> {
> 	int pcpu = read_atomic(&panic_cpu);
>
> 	if (pcpu == PANIC_CPU_INVALID)
> 		return false;
>
> 	if (pcpu == smp_processor_id())
> 		return false;
>
> 	return true;
> }
>
> Best Regards,
> Petr
