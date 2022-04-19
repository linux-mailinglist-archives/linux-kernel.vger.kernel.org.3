Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AB5506C21
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352098AbiDSMSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbiDSMSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:18:32 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62A32251C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1650370549;
  x=1681906549;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=utopaqBb4cI2AYewOpH/tGbT/7L67tzakrCoD0Kbz+8=;
  b=Rn0hlyNTFvQ0XH45gskmsufI3BhSlZeEX52kj9Wkb2n4yPadPY4m8E4a
   cYhCL0XX+Pw+OcttpJ40Jvw247/8tau/90w2rRIaZzF0Zw3r/MvJeT23z
   I0QXo2DMzSCsEnd5WYa1+zCYgwJeYIBEX6JoE+jGJTLC6wLXjGrk5gsJY
   2l1QBGbIj6SivdfWExKnE3823QDKdj8I/5BIYgmfmHuP5lqqaDui0CAMY
   T/KmS5Bm9Tj1t9lpLFtiwMPHwEBU4dXUm0UbtuntrxFgtqTDzIvapUkIq
   DV3no/0Ki9k1mVm3XjG0W3BrJqHqrAQbLyIt8mi2f0aqlDPG+C80ReS85
   A==;
Content-Type: multipart/mixed;
        boundary="------------8pJBSCqSFBBUBeQ3wWODQNbM"
Message-ID: <c4aa28b2-5550-ed39-3869-556b451ff54b@axis.com>
Date:   Tue, 19 Apr 2022 14:15:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mailbox: forward the hrtimer if not queued and under a
 lock
Content-Language: en-US
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     kernel <kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220331070115.29421-1-bjorn.ardo@axis.com>
 <CABb+yY1zrHYLBjY_EoC7bkTsWcKOhzCjp-5vgvqP0HEAJicdXQ@mail.gmail.com>
From:   Bjorn Ardo <bjorn.ardo@axis.com>
In-Reply-To: <CABb+yY1zrHYLBjY_EoC7bkTsWcKOhzCjp-5vgvqP0HEAJicdXQ@mail.gmail.com>
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail04w.axis.com
 (10.20.40.10)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------8pJBSCqSFBBUBeQ3wWODQNbM
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi,


I can confirm that this is an actual issue found on our system, not just 
a theoretical case.


If I add the following trace-code to the original code:


diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 3e7d4b20ab34..8e9e82e5f4b1 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -57,6 +57,7 @@ static void msg_submit(struct mbox_chan *chan)
         void *data;
         int err = -EBUSY;

+       trace_printk("Entering msg_submit\n");
         spin_lock_irqsave(&chan->lock, flags);

         if (!chan->msg_count || chan->active_req)
@@ -85,9 +86,14 @@ static void msg_submit(struct mbox_chan *chan)
         /* kick start the timer immediately to avoid delays */
         if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
                 /* but only if not already active */
-               if (!hrtimer_active(&chan->mbox->poll_hrt))
+               if (!hrtimer_active(&chan->mbox->poll_hrt)) {
+                       trace_printk("Starting the hr timer from 
submit\n");
hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
+               } else {
+                       trace_printk("Not starting the hr timer from 
submit since it is active\n");
+               }
         }
+       trace_printk("Leaving msg_submit\n");
  }

  static void tx_tick(struct mbox_chan *chan, int r)
@@ -121,6 +127,7 @@ static enum hrtimer_restart txdone_hrtimer(struct 
hrtimer *hrtimer)
         bool txdone, resched = false;
         int i;

+       trace_printk("Entering txdone_hrtimer\n");
         for (i = 0; i < mbox->num_chans; i++) {
                 struct mbox_chan *chan = &mbox->chans[i];

@@ -134,8 +141,10 @@ static enum hrtimer_restart txdone_hrtimer(struct 
hrtimer *hrtimer)

         if (resched) {
                 hrtimer_forward_now(hrtimer, 
ms_to_ktime(mbox->txpoll_period));
+               trace_printk("Leaving txdone_hrtimer with restart\n");
                 return HRTIMER_RESTART;
         }
+       trace_printk("Leaving txdone_hrtimer without restart\n");
         return HRTIMER_NORESTART;
  }

Then I get the following trace output (I have cropped a small portion 
around where the error appears):


        vhost-475-480     [000] d..1.   217.440325: msg_submit: Entering 
msg_submit
        vhost-475-480     [000] d..1.   217.440332: msg_submit: Starting 
the hr timer from submit
        vhost-475-480     [000] d..1.   217.440336: msg_submit: Leaving 
msg_submit
        vhost-475-480     [000] d.h1.   217.440342: txdone_hrtimer: 
Entering txdone_hrtimer
        vhost-475-480     [000] d.h1.   217.440349: txdone_hrtimer: 
Leaving txdone_hrtimer without restart
        vhost-475-480     [000] d..1.   217.440597: msg_submit: Entering 
msg_submit
        vhost-475-480     [000] d..1.   217.440599: msg_submit: Starting 
the hr timer from submit
        vhost-475-480     [000] d..1.   217.440602: msg_submit: Leaving 
msg_submit
           <idle>-0       [001] ..s1.   217.440604: msg_submit: Entering 
msg_submit
        vhost-475-480     [000] d.h1.   217.440606: txdone_hrtimer: 
Entering txdone_hrtimer
        vhost-475-480     [000] d.h1.   217.440608: txdone_hrtimer: 
Leaving txdone_hrtimer without restart
           <idle>-0       [001] ..s1.   217.440609: msg_submit: Not 
starting the hr timer from submit since it is active
           <idle>-0       [001] ..s1.   217.440610: msg_submit: Leaving 
msg_submit


If I break down the log above we first have one case that works as 
intended. That is a message being written and a timer started and the 
message have been read when the timer hits:

        vhost-475-480     [000] d..1.   217.440325: msg_submit: Entering 
msg_submit
        vhost-475-480     [000] d..1.   217.440332: msg_submit: Starting 
the hr timer from submit
        vhost-475-480     [000] d..1.   217.440336: msg_submit: Leaving 
msg_submit
        vhost-475-480     [000] d.h1.   217.440342: txdone_hrtimer: 
Entering txdone_hrtimer
        vhost-475-480     [000] d.h1.   217.440349: txdone_hrtimer: 
Leaving txdone_hrtimer without restart


After this we write a new message and a new timer is started:

        vhost-475-480     [000] d..1.   217.440597: msg_submit: Entering 
msg_submit
        vhost-475-480     [000] d..1.   217.440599: msg_submit: Starting 
the hr timer from submit
        vhost-475-480     [000] d..1.   217.440602: msg_submit: Leaving 
msg_submit


However here comes the race. Now a new message is being written at the 
same time as the hr-timer is handling the first reply (on different CPU's):

           <idle>-0       [001] ..s1.   217.440604: msg_submit: Entering 
msg_submit
        vhost-475-480     [000] d.h1.   217.440606: txdone_hrtimer: 
Entering txdone_hrtimer

And the hr-timer decides not to restart itself:

        vhost-475-480     [000] d.h1.   217.440608: txdone_hrtimer: 
Leaving txdone_hrtimer without restart

And also the new message written decides to not start the timer (even 
thou it requires one), since it has the status of being active during 
the time that the hr-timer callback is running:

           <idle>-0       [001] ..s1.   217.440609: msg_submit: Not 
starting the hr timer from submit since it is active
           <idle>-0       [001] ..s1.   217.440610: msg_submit: Leaving 
msg_submit


So now we end up in a state where we have a message waiting for a reply 
but no timer started that can provide this reply.


Our own mailbox code is attached (it is not upstreamed yet, but it is on 
its way).


Best Regards

Björn

On 4/14/22 16:30, Jassi Brar wrote:
> On Thu, Mar 31, 2022 at 2:01 AM Björn Ardö <bjorn.ardo@axis.com> wrote:
>> This reverts commit c7dacf5b0f32957b24ef29df1207dc2cd8307743,
>> "mailbox: avoid timer start from callback"
>>
>> The previous commit was reverted since it lead to a race that
>> caused the hrtimer to not be started at all. The check for
>> hrtimer_active() in msg_submit() will return true if the
>> callback function txdone_hrtimer() is currently running. This
>> function could return HRTIMER_NORESTART and then the timer
>> will not be restarted, and also msg_submit() will not start
>> the timer. This will lead to a message actually being submitted
>> but no timer will start to check for its compleation.
>>
>> The original fix that added checking hrtimer_active() was added to
>> avoid a warning with hrtimer_forward. Looking in the kernel
>> another solution to avoid this warning is to check hrtimer_is_queued()
>> before calling hrtimer_forward_now() instead. This however requires a
>> lock so the timer is not started by msg_submit() inbetween this check
>> and the hrtimer_forward() call.
>>
> This is a very dense api used by many use-cases, I am not confident
> making any changes without confirming its a real issue with the common
> code. Please share your client code and traces, that will help me get
> a clearer picture.
>
> Thanks.
--------------8pJBSCqSFBBUBeQ3wWODQNbM
Content-Type: text/x-csrc; charset="UTF-8"; name="mailbox-artpec8.c"
Content-Disposition: attachment; filename="mailbox-artpec8.c"
Content-Transfer-Encoding: base64

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKLyogQ29weXJpZ2h0IChDKSAy
MDIwIEF4aXMgQ29tbXVuaWNhdGlvbnMgQUIgKi8KCiNpbmNsdWRlIDxsaW51eC9tYWlsYm94
X2NvbnRyb2xsZXIuaD4KI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgojaW5j
bHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CiNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KI2lu
Y2x1ZGUgPGxpbnV4L2lvcG9sbC5oPgojaW5jbHVkZSA8bGludXgva2VybmVsLmg+CiNpbmNs
dWRlIDxsaW51eC9tb2R1bGUuaD4KI2luY2x1ZGUgPGxpbnV4L2lvLmg+CiNpbmNsdWRlIDxs
aW51eC9vZi5oPgoKI2luY2x1ZGUgPGxpbnV4L3NvYy9heGlzL2FydHBlYy1lbmRwb2ludC5o
PgoKI2RlZmluZSBNQUlMQk9YX01DVUNUTFIJCTB4MDAKI2RlZmluZSBNQUlMQk9YX0lOVEdS
MAkJMHgwOAojZGVmaW5lIE1BSUxCT1hfSU5UQ1IwCQkweDBjCiNkZWZpbmUgTUFJTEJPWF9J
TlRNUjAJCTB4MTAKI2RlZmluZSBNQUlMQk9YX0lOVFNSMAkJMHgxNAojZGVmaW5lIE1BSUxC
T1hfSU5UTVNSMAkJMHgxOAojZGVmaW5lIE1BSUxCT1hfSU5UR1IxCQkweDFDCiNkZWZpbmUg
TUFJTEJPWF9JTlRDUjEJCTB4MjAKI2RlZmluZSBNQUlMQk9YX0lOVE1SMQkJMHgyNAojZGVm
aW5lIE1BSUxCT1hfSU5UU1IxCQkweDI4CiNkZWZpbmUgTUFJTEJPWF9JTlRNU1IxCQkweDJD
CiNkZWZpbmUgTUFJTEJPWF9JU19WRVJTSU9OCTB4NTAKI2RlZmluZSBNQUlMQk9YX0lTU1Io
bikJCSgweDgwICsgKG4pICogNCkKCi8qCiAqIFdlIGhhdmUgMzIgaW50ZXJydXB0cyBhbmQg
dGh1cyAzMiBjaGFubmVscy4gIFdlIGFsc28gaGF2ZSA2NCBnZW5lcmFsLXB1cnBvc2UKICog
SVNTUiByZWdpc3RlcnMsIGFuZCB3ZSB1c2UgdGhlc2UgdG8gc2VuZCAzMi1iaXQgdmFsdWVz
IGJldHdlZW4gdGhlIGhvc3RzIGZvcgogKiBlYWNoIG9mIHRoZSBjaGFubmVscy4gIFRoZSBm
aXJzdCAzMiBJU1NSIHJlZ2lzdGVycyBhcmUgdXNlZCBmb3IgZGF0YSBzZW50CiAqIGZyb20g
Q1BVMSB0byBDUFUwIGFuZCB0aGUgcmVtYWluaW5nIGFyZSB1c2VkIGluIHRoZSBvdGhlciBk
aXJlY3Rpb24uCiAqLwojZGVmaW5lIE1BSUxCT1hfTlVNX0NIQU5TCTMyCgpzdHJ1Y3QgYXJ0
cGVjOF9tYm94IHsKCXZvaWQgX19pb21lbSAqYmFzZTsKCXVuc2lnbmVkIGludCBjcHU7Cglz
dHJ1Y3QgbXV0ZXggbXV0ZXg7CglpbnQgaXJxX2xvdzsKCWludCBpcnFfaGlnaDsKCXN0cnVj
dCBtYm94X2NvbnRyb2xsZXIgY29udHJvbGxlcjsKCXN0cnVjdCBtYm94X2NoYW4gY2hhbnNb
TUFJTEJPWF9OVU1fQ0hBTlNdOwoJY29uc3Qgc3RydWN0IGFydHBlY19lbmRwb2ludF9pbmZv
ICplbmRwb2ludDsKCXUzMiBtc2k7Cn07CgpzdGF0aWMgaXJxcmV0dXJuX3QgYXJ0cGVjOF9t
Ym94X2lycShpbnQgaXJxLCB2b2lkICpwKQp7Cgl1bnNpZ25lZCBpbnQgY3IsIG1zciwgaXNz
cm9mZnNldCA9IDA7CglzdHJ1Y3QgYXJ0cGVjOF9tYm94ICptYm94ID0gcDsKCXUzMiBjbGVh
ciwgaW50czsKCglpZiAobWJveC0+Y3B1ID09IDApIHsKCQltc3IgPSBNQUlMQk9YX0lOVE1T
UjA7CgkJY3IgPSBNQUlMQk9YX0lOVENSMDsKCX0gZWxzZSB7CgkJbXNyID0gTUFJTEJPWF9J
TlRNU1IxOwoJCWNyID0gTUFJTEJPWF9JTlRDUjE7CgkJaXNzcm9mZnNldCA9IDMyOwoJfQoK
CWludHMgPSByZWFkbF9yZWxheGVkKG1ib3gtPmJhc2UgKyBtc3IpOwoJaWYgKCFpbnRzKQoJ
CXJldHVybiBJUlFfTk9ORTsKCgljbGVhciA9IGludHM7Cgl3aGlsZSAoaW50cykgewoJCXVu
c2lnbmVkIGludCBjaGFubnVtID0gX19mZnMoaW50cyk7CgkJc3RydWN0IG1ib3hfY2hhbiAq
Y2hhbiA9ICZtYm94LT5jaGFuc1tjaGFubnVtXTsKCQl1MzIgbXNnOwoKCQlpbnRzICY9IH5C
SVQoY2hhbm51bSk7CgoJCW1zZyA9IHJlYWRsX3JlbGF4ZWQobWJveC0+YmFzZSArIE1BSUxC
T1hfSVNTUihjaGFubnVtICsgaXNzcm9mZnNldCkpOwoJCW1ib3hfY2hhbl9yZWNlaXZlZF9k
YXRhKGNoYW4sICh2b2lkICopKHVuc2lnbmVkIGxvbmcpbXNnKTsKCX0KCgl3cml0ZWxfcmVs
YXhlZChjbGVhciwgbWJveC0+YmFzZSArIGNyKTsKCglyZXR1cm4gSVJRX0hBTkRMRUQ7Cn0K
CnN0YXRpYyBpbnQgYXJ0cGVjOF9tYm94X3NlbmRfZGF0YShzdHJ1Y3QgbWJveF9jaGFuICpj
aGFuLCB2b2lkICpkYXRhKQp7CglzdHJ1Y3QgYXJ0cGVjOF9tYm94ICptYm94ID0gY2hhbi0+
Y29uX3ByaXY7Cgl1bnNpZ25lZCBpbnQgY2hhbm51bSA9IGNoYW4gLSBtYm94LT5jaGFuczsK
CXVuc2lnbmVkIGludCBnciwgaXNzcm9mZnNldCA9IDA7Cgl1MzIgYXJnID0gKHUzMikodW5z
aWduZWQgbG9uZylkYXRhOwoKCWlmIChtYm94LT5jcHUgPT0gMCkgewoJCWdyID0gTUFJTEJP
WF9JTlRHUjE7CgkJaXNzcm9mZnNldCA9IDMyOwoJfSBlbHNlIHsKCQlnciA9IE1BSUxCT1hf
SU5UR1IwOwoJfQoKCXdyaXRlbChhcmcsIG1ib3gtPmJhc2UgKyBNQUlMQk9YX0lTU1IoY2hh
bm51bSArIGlzc3JvZmZzZXQpKTsKCgl3cml0ZWwoQklUKGNoYW5udW0pLCBtYm94LT5iYXNl
ICsgZ3IpOwoKCWlmIChtYm94LT5lbmRwb2ludCkKCQl3cml0ZWwobWJveC0+ZW5kcG9pbnQt
Pm1zaV9kYXRhICsgbWJveC0+bXNpLCBtYm94LT5lbmRwb2ludC0+bXNpKTsKCglyZXR1cm4g
MDsKfQoKc3RhdGljIGJvb2wgYXJ0cGVjOF9tYm94X2xhc3RfdHhfZG9uZShzdHJ1Y3QgbWJv
eF9jaGFuICpjaGFuKQp7CglzdHJ1Y3QgYXJ0cGVjOF9tYm94ICptYm94ID0gY2hhbi0+Y29u
X3ByaXY7Cgl1bnNpZ25lZCBpbnQgc3IgPSBtYm94LT5jcHUgPT0gMCA/IE1BSUxCT1hfSU5U
U1IxIDogTUFJTEJPWF9JTlRTUjA7Cgl1bnNpZ25lZCBpbnQgY2hhbm51bSA9IGNoYW4gLSBt
Ym94LT5jaGFuczsKCglyZXR1cm4gIShyZWFkbF9yZWxheGVkKG1ib3gtPmJhc2UgKyBzcikg
JiBCSVQoY2hhbm51bSkpOwp9CgpzdGF0aWMgaW50IGFydHBlYzhfbWJveF9zdGFydHVwKHN0
cnVjdCBtYm94X2NoYW4gKmNoYW4pCnsKCXN0cnVjdCBhcnRwZWM4X21ib3ggKm1ib3ggPSBj
aGFuLT5jb25fcHJpdjsKCXVuc2lnbmVkIGludCBtciA9IG1ib3gtPmNwdSA9PSAwID8gTUFJ
TEJPWF9JTlRNUjAgOiBNQUlMQk9YX0lOVE1SMTsKCXVuc2lnbmVkIGludCBjaGFubnVtID0g
Y2hhbiAtIG1ib3gtPmNoYW5zOwoJdTMyIHZhbDsKCgltdXRleF9sb2NrKCZtYm94LT5tdXRl
eCk7CgoJLyoKCSAqIFRoZSBoYXJkd2FyZSBtYW51YWwgY2xhaW1zIHRoYXQgd3JpdGluZyAw
IGhhcyBObyBFZmZlY3QsIGJ1dCBpdCBhbHNvCgkgKiBkb2Vzbid0IHByb3ZpZGUgYW55IHdh
eSB0byB1bm1hc2sgaW50ZXJydXB0cywgc28gSSdtIGFzc3VtaW5nIHRoYXQKCSAqIHRoYXQg
aXMgYSB0eXBvLgoJICovCgl2YWwgPSByZWFkbF9yZWxheGVkKG1ib3gtPmJhc2UgKyBtcik7
Cgl2YWwgJj0gfkJJVChjaGFubnVtKTsKCXdyaXRlbF9yZWxheGVkKHZhbCwgbWJveC0+YmFz
ZSArIG1yKTsKCgltdXRleF91bmxvY2soJm1ib3gtPm11dGV4KTsKCglyZXR1cm4gMDsKfQoK
c3RhdGljIHZvaWQgYXJ0cGVjOF9tYm94X3NodXRkb3duKHN0cnVjdCBtYm94X2NoYW4gKmNo
YW4pCnsKCXN0cnVjdCBhcnRwZWM4X21ib3ggKm1ib3ggPSBjaGFuLT5jb25fcHJpdjsKCXVu
c2lnbmVkIGludCBtciA9IG1ib3gtPmNwdSA9PSAwID8gTUFJTEJPWF9JTlRNUjAgOiBNQUlM
Qk9YX0lOVE1SMTsKCXVuc2lnbmVkIGludCBjaGFubnVtID0gY2hhbiAtIG1ib3gtPmNoYW5z
OwoJdTMyIHZhbDsKCgltdXRleF9sb2NrKCZtYm94LT5tdXRleCk7CgoJdmFsID0gcmVhZGxf
cmVsYXhlZChtYm94LT5iYXNlICsgbXIpOwoJdmFsIHw9IEJJVChjaGFubnVtKTsKCXdyaXRl
bF9yZWxheGVkKHZhbCwgbWJveC0+YmFzZSArIG1yKTsKCgltdXRleF91bmxvY2soJm1ib3gt
Pm11dGV4KTsKfQoKc3RhdGljIGNvbnN0IHN0cnVjdCBtYm94X2NoYW5fb3BzIGFydHBlYzhf
bWJveF9vcHMgPSB7Cgkuc2VuZF9kYXRhID0gYXJ0cGVjOF9tYm94X3NlbmRfZGF0YSwKCS5z
dGFydHVwID0gYXJ0cGVjOF9tYm94X3N0YXJ0dXAsCgkuc2h1dGRvd24gPSBhcnRwZWM4X21i
b3hfc2h1dGRvd24sCgkubGFzdF90eF9kb25lID0gYXJ0cGVjOF9tYm94X2xhc3RfdHhfZG9u
ZSwKfTsKCnN0YXRpYyBpbnQgYXJ0cGVjOF9tYm94X3Jlc2V0KHN0cnVjdCBhcnRwZWM4X21i
b3ggKm1ib3gpCnsKCXUzMiB2YWw7CglpbnQgcmV0OwoKCS8qIFdlIGFzc3VtZSB0aGF0IENQ
VTAgc3RhcnRzIHVwIGZpcnN0LCBzbyBpdCBzaG91bGQgZG8gdGhlIG1haW4gcmVzZXQuICov
CglpZiAobWJveC0+Y3B1ICE9IDApIHsKCQl3cml0ZWxfcmVsYXhlZCh+MHVsLCBtYm94LT5i
YXNlICsgTUFJTEJPWF9JTlRNUjEpOwoJCXdyaXRlbF9yZWxheGVkKH4wdWwsIG1ib3gtPmJh
c2UgKyBNQUlMQk9YX0lOVENSMSk7CgkJcmV0dXJuIDA7Cgl9CgoJLyoKCSAqIEl0J3Mgbm90
IGVudGlyZWx5IGNsZWFyIGZyb20gdGhlIGhhcmR3YXJlIG1hbnVhbCwgYnV0IHRoaXMgcmVz
ZXQgbWF5CgkgKiBhbHNvIGNsZWFyIHRoZSBTRU1BUEhPUkUqIHJlZ2lzdGVycyB1c2VkIGJ5
IHRoZSBod3NwaW5sb2NrIGRyaXZlci4KCSAqIFRoaXMgd2lsbCBwcm9iYWJseSBub3QgYmUg
YSBwcm9ibGVtIGluIHByYWN0aWNlIHNpbmNlIGJvdGggZHJpdmVycwoJICogd2lsbCBwcmVz
dW1hYmx5IGJlIHVzZWQgdG9nZXRoZXIgYnkgdGhlIHNhbWUgY2xpZW50cy4KCSAqLwoJd3Jp
dGVsX3JlbGF4ZWQoMSwgbWJveC0+YmFzZSArIE1BSUxCT1hfTUNVQ1RMUik7CglyZXQgPSBy
ZWFkbF9yZWxheGVkX3BvbGxfdGltZW91dChtYm94LT5iYXNlICsgTUFJTEJPWF9NQ1VDVExS
LCB2YWwsCgkJCQkJICF2YWwsIDAsIDEwMCk7CglpZiAocmV0KQoJCXJldHVybiByZXQ7CgoJ
d3JpdGVsX3JlbGF4ZWQofjB1bCwgbWJveC0+YmFzZSArIE1BSUxCT1hfSU5UTVIwKTsKCXdy
aXRlbF9yZWxheGVkKH4wdWwsIG1ib3gtPmJhc2UgKyBNQUlMQk9YX0lOVENSMCk7CgoJcmV0
dXJuIDA7Cn0KCnN0YXRpYyBpbnQgYXJ0cGVjOF9tYm94X3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpCnsKCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7Cglz
dHJ1Y3QgYXJ0cGVjOF9tYm94ICptYm94OwoJc3RydWN0IHJlc291cmNlCSpyZXM7Cgljb25z
dCBzdHJ1Y3QgYXJ0cGVjX2VuZHBvaW50X2luZm8gKmVuZHBvaW50OwoJaW50IHJldDsKCWlu
dCBpOwoKCW1ib3ggPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKm1ib3gpLCBHRlBfS0VS
TkVMKTsKCWlmICghbWJveCkKCQlyZXR1cm4gLUVOT01FTTsKCglvZl9wcm9wZXJ0eV9yZWFk
X3UzMihkZXYtPm9mX25vZGUsICJjcHUiLCAmbWJveC0+Y3B1KTsKCWlmIChtYm94LT5jcHUg
PiAxKQoJCXJldHVybiAtRUlOVkFMOwoKCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShw
ZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7CglpZiAoIXJlcykKCQlyZXR1cm4gLUVOWElPOwoK
CW1ib3gtPmJhc2UgPSBkZXZtX2lvcmVtYXAoZGV2LCByZXMtPnN0YXJ0LCByZXNvdXJjZV9z
aXplKHJlcykpOwoJaWYgKElTX0VSUihtYm94LT5iYXNlKSkKCQlyZXR1cm4gUFRSX0VSUiht
Ym94LT5iYXNlKTsKCgltYm94LT5pcnFfbG93ID0gcGxhdGZvcm1fZ2V0X2lycV9vcHRpb25h
bChwZGV2LCAwKTsKCWlmIChtYm94LT5pcnFfbG93ID09IC1FUFJPQkVfREVGRVIpCgkJcmV0
dXJuIG1ib3gtPmlycV9sb3c7CgoJbWJveC0+aXJxX2hpZ2ggPSBwbGF0Zm9ybV9nZXRfaXJx
X29wdGlvbmFsKHBkZXYsIDEpOwoJaWYgKG1ib3gtPmlycV9oaWdoID09IC1FUFJPQkVfREVG
RVIpCgkJcmV0dXJuIG1ib3gtPmlycV9oaWdoOwoKCS8qIE9ubHkgZW5hYmxlIE1TSSBpZiBw
cmVzZW50ICovCgltYm94LT5lbmRwb2ludCA9IE5VTEw7CgllbmRwb2ludCA9IGFydHBlY19l
bmRwb2ludF9nZXRfaW5mbygmcGRldi0+ZGV2KTsKCWlmIChlbmRwb2ludCkKCQlpZiAoIW9m
X3Byb3BlcnR5X3JlYWRfdTMyKGRldi0+b2Zfbm9kZSwgIm1zaSIsICZtYm94LT5tc2kpKQoJ
CQltYm94LT5lbmRwb2ludCA9IGVuZHBvaW50OwoKCW11dGV4X2luaXQoJm1ib3gtPm11dGV4
KTsKCgltYm94LT5jb250cm9sbGVyLnR4ZG9uZV9pcnEgPSBmYWxzZTsKCW1ib3gtPmNvbnRy
b2xsZXIudHhkb25lX3BvbGwgPSB0cnVlOwoJbWJveC0+Y29udHJvbGxlci50eHBvbGxfcGVy
aW9kID0gMTsKCgltYm94LT5jb250cm9sbGVyLmRldiA9IGRldjsKCW1ib3gtPmNvbnRyb2xs
ZXIubnVtX2NoYW5zID0gQVJSQVlfU0laRShtYm94LT5jaGFucyk7CgltYm94LT5jb250cm9s
bGVyLmNoYW5zID0gbWJveC0+Y2hhbnM7CgltYm94LT5jb250cm9sbGVyLm9wcyA9ICZhcnRw
ZWM4X21ib3hfb3BzOwoKCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKG1ib3gtPmNoYW5z
KTsgaSsrKQoJCW1ib3gtPmNoYW5zW2ldLmNvbl9wcml2ID0gbWJveDsKCglyZXQgPSBhcnRw
ZWM4X21ib3hfcmVzZXQobWJveCk7CglpZiAocmV0KQoJCXJldHVybiByZXQ7CgoJaWYgKG1i
b3gtPmlycV9sb3cgPiAwKSB7CgkJcmV0ID0gZGV2bV9yZXF1ZXN0X2lycShkZXYsIG1ib3gt
PmlycV9sb3csIGFydHBlYzhfbWJveF9pcnEsCgkJCQkgICAgICAgMCwgIm1ib3gtbG93Iiwg
bWJveCk7CgkJaWYgKHJldCkKCQkJcmV0dXJuIHJldDsKCX0KCglpZiAobWJveC0+aXJxX2hp
Z2ggPiAwKSB7CgkJcmV0ID0gZGV2bV9yZXF1ZXN0X2lycShkZXYsIG1ib3gtPmlycV9oaWdo
LCBhcnRwZWM4X21ib3hfaXJxLAoJCQkJICAgICAgIDAsICJtYm94LWhpZ2giLCBtYm94KTsK
CQlpZiAocmV0KQoJCQlyZXR1cm4gcmV0OwoJfQoKCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBk
ZXYsIG1ib3gpOwoKCXJldHVybiBtYm94X2NvbnRyb2xsZXJfcmVnaXN0ZXIoJm1ib3gtPmNv
bnRyb2xsZXIpOwp9CgpzdGF0aWMgaW50IGFydHBlYzhfbWJveF9yZW1vdmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikKewoJc3RydWN0IGFydHBlYzhfbWJveCAqbWJveCA9IHBs
YXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOwoKCW1ib3hfY29udHJvbGxlcl91bnJlZ2lzdGVy
KCZtYm94LT5jb250cm9sbGVyKTsKCglyZXR1cm4gMDsKfQoKc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgYXJ0cGVjOF9tYm94X21hdGNoW10gPSB7Cgl7IC5jb21wYXRpYmxl
ID0gInNhbXN1bmcsYXJ0cGVjOC1tYWlsYm94IiB9LAoJeyAvKiBTZW50aW5lbCAqLyB9Cn07
Ck1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGFydHBlYzhfbWJveF9tYXRjaCk7CgpzdGF0aWMg
c3RydWN0IHBsYXRmb3JtX2RyaXZlciBhcnRwZWM4X21ib3hfZHJpdmVyID0gewoJLnByb2Jl
CT0gYXJ0cGVjOF9tYm94X3Byb2JlLAoJLnJlbW92ZQk9IGFydHBlYzhfbWJveF9yZW1vdmUs
CgkuZHJpdmVyCT0gewoJCS5uYW1lCT0gImFydHBlYzgtbWFpbGJveCIsCgkJLm9mX21hdGNo
X3RhYmxlCT0gYXJ0cGVjOF9tYm94X21hdGNoLAoJfSwKfTsKCm1vZHVsZV9wbGF0Zm9ybV9k
cml2ZXIoYXJ0cGVjOF9tYm94X2RyaXZlcik7CgpNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7
Cg==

--------------8pJBSCqSFBBUBeQ3wWODQNbM--
