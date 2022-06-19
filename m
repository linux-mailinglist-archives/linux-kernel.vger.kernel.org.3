Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5019550B29
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 16:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiFSOYg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Jun 2022 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiFSOYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 10:24:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81C1FDF02
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 07:24:32 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-11-98e9s7oFPYiyl8nRTBgdtA-1; Sun, 19 Jun 2022 15:24:28 +0100
X-MC-Unique: 98e9s7oFPYiyl8nRTBgdtA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Sun, 19 Jun 2022 15:24:26 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Sun, 19 Jun 2022 15:24:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'John Ogness' <john.ogness@linutronix.de>,
        'Petr Mladek' <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: 5.19 printk breaks message ordering
Thread-Topic: 5.19 printk breaks message ordering
Thread-Index: AQHYglWHYY5jQBSQoEy5fw0dudLMr61Tr9rQgAKkOoCAAHL1EA==
Date:   Sun, 19 Jun 2022 14:24:26 +0000
Message-ID: <f7b4b14ab186464488cb52a5c425751a@AcuMS.aculab.com>
References: <YqyANveL50uxupfQ@zx2c4.com> <YqyN20jpRw1SaaTw@alley>
 <a35dc47eb9924d56bb6dca7868c34c94@AcuMS.aculab.com>
 <87edzlrrva.fsf@jogness.linutronix.de>
In-Reply-To: <87edzlrrva.fsf@jogness.linutronix.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ogness
> Sent: 19 June 2022 09:16
> 
> On 2022-06-17, David Laight <David.Laight@ACULAB.COM> wrote:
> > What priority do these kthreads run at?
> 
> 120 (SCHED_OTHER, nice=0)
> 
> > I'd have thought they ought to run at a high priority?
> > That should tend to give kernel messages priority over user ones.
> >
> > Quite how high is another matter.
> > Probably a bit below the RT/FIFO:50 of threaded ISR.
> 
> As a default value, I recommend keeping to the SCHED_OTHER policy as a
> default. Perhaps a nice value of -20? There are quite a few kernel
> threads using that as their default:

That doesn't mean it is a sensible priority :-)

Running at (SCHED_OTHER, nice=0) is almost certainly worse.
There is little guarantee they'll run if the system is busy
and has non-default priority user threads.

I know there is the NIBY style 'my process is more important than yours'
But processes that don't run for very long, or have to run
in order to keep the system working properly, almost certainly
need to be higher priority than the lowest RT one.

I've been fighting system thread priorities on a system that
is doing a lot of real time audio over UDP (ie RTP).
The application threads processing the RTP need to run in preference
to all other application threads (nothing else is that time critical).
Processor affinities don't help - they can only really be used to
move things away from some cpu, and I need to use the idle time.
Running the RTP threads at a RT priority works reasonably well
except that some system threads (like the softint ones napi uses)
get blocked - causing lost packets.
Threaded napi helps - but only if I run the threads under the RT
scheduler.

	David

> 
> # ps -Leo ni,command | grep ^-20 | sort
> -20 [acpi_thermal_pm]
> -20 [ata_sff]
> -20 [blkcg_punt_bio]
> -20 [cfg80211]
> -20 [inet_frag_wq]
> -20 [ipv6_addrconf]
> -20 [kblockd]
> -20 [kworker/0:0H-events_highpri]
> -20 [kworker/0:1H-events_highpri]
> -20 [md]
> -20 [mld]
> -20 [mm_percpu_wq]
> -20 [netns]
> -20 [nfsiod]
> -20 [rcu_gp]
> -20 [rcu_par_gp]
> -20 [rpciod]
> -20 [scsi_tmf_0]
> -20 [scsi_tmf_1]
> -20 [writeback]
> -20 [xprtiod]
> 
> John Ogness

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

