Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCA9493140
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 00:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350219AbiARXOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 18:14:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33990 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350210AbiARXOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 18:14:30 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IKEDKL021247;
        Tue, 18 Jan 2022 23:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=sGzsntSgGqSq8WlSf9LqMkWRPFcOwx1nRLSPS602rR0=;
 b=0iyXJ0DX52ns3j3VbRSDhWVRA6YzOIUDcRjBCSdx2r6WKp86X1VLMhxV3og7nQStUDZ7
 XQFzldmPv49AVBwT8IqP2gVv1tWp0vFViNwSBYnaL8yBWObv8r6XWZ0QtAmv36+QKOgH
 L3G2acxSzXbatPI5xB3b16TXwFwsQbXnHvXJi0wJ+cYnmBNI4VfCxI4lAW4Anyaxab4N
 tAe2SvkBHW6NWjWgrm780C3BMyzIdOGNJ/56246W/awHymXTArI922c9K06IQjnfmBAt
 00X0E4DRxA2gPikG+BZ7bNC4ynWC0gQWyJA/MVl+Uvo/qjoHL9izCXtwOvD5g4fKT0R7 /A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q3gw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 23:13:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IN6rIa141688;
        Tue, 18 Jan 2022 23:13:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3030.oracle.com with ESMTP id 3dkmacqv6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 23:13:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHaqwY1EydKrzDnnc9f4v2O3iJwI83CBeIZ+YefhMxTSTNcddQTEZrGsTkkLiePOh+6HNKQeNwUHpL2Q/yRcvmXiP/SsFn136TXQ7FK9yCrZq+Ly/x0AroLy6TfSPhoTt7gIj8HuU07N/nOGDGi6CJB+7FykvZJYeuFuqqfzSGWKmml7h2yGCFu13pG/H2nAsXJPYeGpVwVsf3ow7OngV58UiUezFPnYuC5SrG4ey98hC0s6pOoGvtuNMws9iB1lncGsSotvOiKyF66QgjF259oTF0Lcwaoippc4s3z6hhS3Ze+7jGQq0ILgQ3ozoyfTF2DiehV3DIxHutAxmW64SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGzsntSgGqSq8WlSf9LqMkWRPFcOwx1nRLSPS602rR0=;
 b=YF3YBT4/8aJM2pGLudRqNA96OY0Eyg0tZcFa/1YGe1HbRx6mM00x6PzSl8qHHAesZ3Ip9zVVatCkiqjaOiG8xtze5FprNTzltEe1b805ifRe9TgnAR+O+aajauSa7K1VT8Zg5CKqLcBWXwIWOksBbJfjHb0MOU4AnXrQljGs2Myit5lu4p0dTkzZTBRzsJgXDyhxbbyXz1OdBfjlIO5KZ2tQkaS/B+Apie1H+qebrCpc38oaemhEGfs4QyAQ9xOqo3ipBpExlBT0xqesnuzORQ+48Y2gGG+sBaejIHJ3ltDDVOsDF5CH5s7tSLCrLtDJ1TmWiuC9FO/3hiwn0+d9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGzsntSgGqSq8WlSf9LqMkWRPFcOwx1nRLSPS602rR0=;
 b=hbAfFP+IJDi62Z8id6SQB0RCV0Jk+aAHB/HaO35gS04tbqBHP7dCgZAmf1MdhilgEuyL2vqy7K1dlXMrcM93qeUOBq11q703QSivRF4VVGjucUdDaLF9pkQq36O2IK6FWyH8usij8H8nJFzpIznX/hBD54ODuDClPS7Y5Aetm48=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BLAPR10MB5122.namprd10.prod.outlook.com (2603:10b6:208:328::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 23:13:56 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::e430:bb9e:c983:23bf]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::e430:bb9e:c983:23bf%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 23:13:56 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] panic: disable optimistic spin after halting CPUs
In-Reply-To: <20220114102427.GA17817@pathway.suse.cz>
References: <20220113005425.74988-1-stephen.s.brennan@oracle.com>
 <YeBjzX7Z6J1cVtjC@alley> <87a6fzxwak.fsf@stepbren-lnx.us.oracle.com>
 <20220114102427.GA17817@pathway.suse.cz>
Date:   Tue, 18 Jan 2022 15:13:51 -0800
Message-ID: <877dawy6vk.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::19) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 130d6b88-b5e4-477d-e3e0-08d9dad83383
X-MS-TrafficTypeDiagnostic: BLAPR10MB5122:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5122AF185B316DC57ED0CFA3DB589@BLAPR10MB5122.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3BDRZofh+z8Qv5yXEOGVh85jM2a9TA49fjHYY67FVmiAlAhnl88iQHkMWYy558iu8EmSFa1BpHj/rMkKARIDMvnQDRNsuQgCKrc/BshA2yiG+mr2q6effFlncSSOpYMBx3235FspuKklyAfhW4jqFVjnMhvh3KYGjU5Pw/HON2JMmuwCyj8bQHFKmsWsZsCfhJbUK6hb3J6YaA8uO7Ymzr9PyowR6vQkahPYeVt3E7x62inuHo4ABjYmNo8VoDMuGagECZ86SohcY5cIPJit5MCEeBHXbYEm6Nqf/9zlf36Vr4OuVyGkznQ4G3rKkIWrxh6ppP9FnQZiOxh95QpWgqFnZqJ89YZmXYtkaR06FZL35XNKLUBkRVVIzs03rRpk0eMNRzIubE1wMbPZ6TreuA6XhXyGJ2x8pfQblu4hT2IBKDw1I3SOGtpzTfFDXTuTMBpII1GEGtUo7Z7E2hT+DOpqEWC0XVhV26QzujsOXZh7XYyumr3TIAXY00URjgS5BHoqUQYWMXQyWjSuiulhBXK0f52jyX/NRirMuk+i1Za0cqJl0uH/mPkTgeUEIkjf2JkGpPRGHleMvF6t1fkBZkna8ePAcCfD4ynRLbIYYDvKnjlqGt0G8COhmKtRzE0DzKmDTAjN2hWT9AQCuYxk80DSkZAu/wH2C3LCAVJxjyVIxuY3IpMBd7G9O3HQTZbBh0t4WkFZj+792s5Bi3L15g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(8936002)(6486002)(6666004)(6916009)(6506007)(52116002)(54906003)(508600001)(38100700002)(8676002)(66556008)(316002)(2906002)(66946007)(38350700002)(86362001)(5660300002)(66476007)(83380400001)(186003)(4326008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kmXKwnuUR/pDIKHlZq1cX0ImPZufqGDApklXK2nNhNZ4V0VNuqBw+yBN5WwF?=
 =?us-ascii?Q?9SgJZONTTl0TkNBSZxToLEWNg3h0SizyXsvqXAEcvgWzXftweM0BYFd8TNgh?=
 =?us-ascii?Q?EPW5naw5mF+/YcfxyKzqGVaCzHql5yEFz81Zrp+dWLNMwaiKHZQonmwWe4i6?=
 =?us-ascii?Q?xM7yT2QB1GuZ/al41ctqwwa2hRPiKYnmfwGGlIqqTCj5WEnOfNGJx6MXy59d?=
 =?us-ascii?Q?4LhjzPdCyngJ64oUM483YcX6QHGM/48AG4VUvcY4Nckq/+baHOm17g9cXFb/?=
 =?us-ascii?Q?i1VIszm9dT9mOhHuyQAuhVzkjFdFiHU0F8U7HABevXVTHpbagULOG8/Kybww?=
 =?us-ascii?Q?+k4QFeeRRlD0FNA9fb5eunUBP2lDkLPSlU4qK87J+tWhZ0fyvHKti4oXKtEE?=
 =?us-ascii?Q?4NM3bo6SskgpbQRhddX2O6ADKSMBwINp35XAPPxcUXbhRb+ktml+nFo0ln/f?=
 =?us-ascii?Q?ZA9KPI7eYO20mb8WKOB49j3kUnASiQf2uyEcAMqxksurMeUzozhz65M8u6EX?=
 =?us-ascii?Q?yAk/tK3xkVHnE6ybu0Op7zKHUWM8+8T8uJpildBaDTcCLokAlA6umvDsXl8b?=
 =?us-ascii?Q?klurADbCuMltng5a/H+S7WyakOjAuD6zVJ/Q/wUuKy6h2L9mzbKYn5HZYLmD?=
 =?us-ascii?Q?vuOXV3QfC6GbCqek6MlsP9eBSqtU+GjkpU1v6YXEZNvHcCklsACjJ1JXyzvW?=
 =?us-ascii?Q?7wXpVT1UvNRQmTglMKWsJtYX2qzidWdN1NSxM3MPh++Jm35ZpztXGF879qbI?=
 =?us-ascii?Q?IVW5DRnNAEmA9YQFyCBxYXnfddXRyawKCLodQxuFJRA/1jdxgcFNDn25vjkK?=
 =?us-ascii?Q?FV3mS4aFnhqcez9sAv2UrLptH65DcPsUBGsdkyal7sd/YVscyAvuRpeKH1gv?=
 =?us-ascii?Q?6BMUg6fLlpSRDVeYdtnVVIjg56/mBdoDRSmFdu9ezcqhOJYmx5wVGSs6OS1v?=
 =?us-ascii?Q?p/URhlcsz/AI+go9+e171HY/ZU7iDdbQdCJa1QdQrHqIaqr8LUyBRfys4j+h?=
 =?us-ascii?Q?lzmm3H5XQXpRUGHiKbJm0bHNX1cCCF190fZeYDWsqTaGE/k3AMqo4FD1/We/?=
 =?us-ascii?Q?avOI8I/4WzeugtvtlPkgDQnMuwEUb0i0zaPfUajCoK2h49A11n9dN6uYv5Mt?=
 =?us-ascii?Q?PpF+zAq8emS4awVe82qrCBKzRdOwXa2sUHQDQ8kbw9k+gh4luBFW6RpsRXts?=
 =?us-ascii?Q?9OMc4tl7+pnNexKNQ3uOw4jIf+f5RPAaP3uIF2wGoo18miByoNepfDHSGg0b?=
 =?us-ascii?Q?0GF1yzaLgxJ7n3kw/WqrxyKHZjN9yK2Ol+6CAe+/nX8MkeIdgEhaT16aCDq4?=
 =?us-ascii?Q?EMtxvk+GkRfZSqt6NAD99IapY0eD4sucRFf01ElIniW7B1gkR03TNbrvKnWe?=
 =?us-ascii?Q?TKVDPcgnyIqxcYilE0T1DVC+KjjGfm3T9v3KyNbzz7EDFJXT7sONN9jDGvwz?=
 =?us-ascii?Q?Drc8p4IuYEhDaF8nWLOZNNoNPwbi+l76f9JPw6DoqoCHvyhYSj9mkWL9H73n?=
 =?us-ascii?Q?ntxfhibv0zsHh+H9iG9NfCyPgEPKXGFGrjjVixKV+5hLZheDxAijZbbICli3?=
 =?us-ascii?Q?qMF6R6SSYvXuwcCNy/SgoixiIoNH2tX+LVy2WqwfrS5Kub/g+BCe3pUC5XdT?=
 =?us-ascii?Q?d57M4cq8LwM84UnjVeR0Yy9RrFM8owHY4DDUFNgTmIl1tl7Us9FXkESEH4KS?=
 =?us-ascii?Q?GVTiYg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130d6b88-b5e4-477d-e3e0-08d9dad83383
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 23:13:56.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLPcw+PQfwrrkr8+yzUKxQ+w2InD/6+vL6mOTtQdwVZlXOOKwJ+Zo9OvPz06FVw0FGHXjpiluEgx+9LQipnGaEHunuOlru9EY5cbrrDSdrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5122
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201180130
X-Proofpoint-GUID: d4vJ8qrwpajDksytJkYw9mp_1Pso2_SN
X-Proofpoint-ORIG-GUID: d4vJ8qrwpajDksytJkYw9mp_1Pso2_SN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek <pmladek@suse.com> writes:
> On Thu 2022-01-13 11:36:35, Stephen Brennan wrote:
>> Petr Mladek <pmladek@suse.com> writes:
>> > On Wed 2022-01-12 16:54:25, Stephen Brennan wrote:
[snip]
>> > I suggest to disable the spinning when panic is in progress. I mean
>> > something like:
>> >
>> > --- a/kernel/printk/printk.c
>> > +++ b/kernel/printk/printk.c
>> > @@ -1842,6 +1842,10 @@ static int console_trylock_spinning(void)
>> >  	if (console_trylock())
>> >  		return 1;
>> >
>> > +	/* Spinning is not safe when the system is stopped */
>> > +	if (read_atomic(&panic_cpu) != PANIC_CPU_INVALID)
>> > +		return 0;
>> > +
>> >  	printk_safe_enter_irqsave(flags);
>> >
>> >  	raw_spin_lock(&console_owner_lock);
>>
>> I think this is pretty much equivalent to my fix, since it also results
>> in the panicking CPU failing to acquire console_sem during
>> console_trylock_spinning().
>
> Yes.
>
>> I do think this is better than my fix :) since it doesn't clutter up
>> panic() even more, nor introduce an additional function. It even avoids
>> resetting the console_owner_lock spinlock.
>
> Yes. I agree.
>
> It also looks slightly more straightforward to me. It might be matter
> of taste. It is just that I misunderstood the effect of your variant
> yesterday ;-)
>
>> I'd be happy to do this as a v2, if you'd prefer?
>
> Yes, please. Go for it.

Hi Petr,

Sorry for the delayed response due to the US holiday weekend.

I switched to your approach, and began running it through my test script
(from the commit message) on QEMU. However, 14% of the time (200/1409) I
found that the system fell into an interesting race condition / loop.

178 void panic(const char *fmt, ...)
179 {
...
187 	/*
188 	 * Disable local interrupts. This will prevent panic_smp_self_stop
189 	 * from deadlocking the first cpu that invokes the panic, since
190 	 * there is nothing to prevent an interrupt handler (that runs
191 	 * after setting panic_cpu) from invoking panic() again.
192 	 */
193 	local_irq_disable();
194 	preempt_disable_notrace();
...
211 	this_cpu = raw_smp_processor_id();
212 	old_cpu  = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
213 
214 	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
215 		panic_smp_self_stop();
...
226 	pr_emerg("Kernel panic - not syncing: %s\n", buf);
...
250 	if (!_crash_kexec_post_notifiers) {  // <- HALT CPUs
...

We disable IRQ and preemption at the beginning of panic(), then set
panic_cpu. This opens a window (between lines 212 and 250) where
printk() spinning is disabled. Then, we go ahead and we use printk()
during this window, at line 226.

If another CPU is adding to the log buffer at the right time (concurrent
with the pr_emerg in line 226), then they can successfully prevent the
panic CPU from making progress. Since spinning is disabled, the other
CPU in vprintk_emit() will never get the console_sem, and will just
leave its buffered contents in the log buffer. And if the other CPU can
add to the log buffer faster than the panic CPU can drain it... then the
panic CPU is stuck forever writing into the console. And I do mean
forever. If a watchdog triggers, it will find panic_cpu already set, and
so it won't be able to do anything!

Thus I'm now testing the following modification:

// in console_trylock_spinning()
if (atomic_read(&panic_cpu) == this_cpu)
    return 0;

This would ensure that the panic CPU won't fall into the spin loop, but
also ensures that other CPUs can't flood the panic CPU with buffered
messages.

I'll test this method and ensure there are no hangs, then send the patch.

>
>> > It would be also great when the current owner releases console_lock
>> > so that the panicing CPU could take over it.
>> >
>> > I think about the following. Well, I am not sure if it would help
>> > in the real life because other CPUs are stopped quite early in panic().
>> >
>> > --- a/kernel/printk/printk.c
>> > +++ b/kernel/printk/printk.c
>> > @@ -2646,13 +2650,18 @@ void console_unlock(void)
>> >
>> >  	for (;;) {
>> >  		size_t ext_len = 0;
>> > -		int handover;
>> > +		int handover, pcpu;
>> >  		size_t len;
>> >
>> >  skip:
>> >  		if (!prb_read_valid(prb, console_seq, &r))
>> >  			break;
>> >
>> > +		/* Allow the panic_cpu to take over consoles a safe way. */
>> > +		pcpu = read_atomic(&panic_cpu);
>> > +		if (pcpu != PANIC_CPU_INVALID && pcpu != smp_processor_id())
>> > +			break;
>> > +
>> >  		if (console_seq != r.info->seq) {
>> >  			console_dropped += r.info->seq - console_seq;
>> >  			console_seq = r.info->seq;
>> >
>>
>> I suppose this could help reduce the odds of a CPU getting interrupted
>> during call_console_drivers(), and it might reduce the odds of
>> console_sem being held by a halted CPU during panic().
>>
>> However, it occurs to me that there are two cases:
>>
>> 1) a kdump kernel is loaded. In this case, crash_smp_send_stop() is
>> used, which (at least on x86_64) sends NMIs. In this case,
>> __crash_kexec() will not return (barring any errors) and we won't ever
>> really need to get the console_sem.
>
> This is likely the more safe case. NMI will make sure that
> the current owner will not mess with the console drivers any longer.
>
>
>> 2) no kdump kernel is loaded. In this case, smp_send_stop() is used,
>> which (again on x86_64) sends regular IPIs. In this case, we know we can
>> at least avoid interrupting call_console_drivers(), since that executes
>> with local IRQ disabled.
>
> This is probably more dangerous case. Regular IPIs will not stop the
> current owner when it is running with IRQ disabled. It means
> the it could still manipulate consoles and race with
> console_flush_on_panic().

On x86_64, smp_send_stop() will send an IPI and try to wait a grace
period for CPUs to stop, and after that grace period, use NMI, so there
is thankfully some protection.

>
> Note that printk() can be called in IRQ disabled context. Also note
> that some architectures do not have NMI. They use normal IRQ even
> in the 1st case.

Yes, this is a very important consideration.

>
>
>> So I'm also unsure how much this would help in the real world. But it's
>> a small change and so it doesn't need to help much in order to be a net
>> positive :)
>
> I agree that it is a corner case. But I think that it is worth it.
>
> Well, we could do this change separately. I could send the patch
> for this part if you would prefer it. But feel free to send it
> yourself.

I'd be glad to write this patch, put it through my VM stress testing,
and then send it. I've already got it setup so it might as well get put
to good use :)

Thanks,
Stephen

>
> Best Regards,
> Petr
