Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15941531080
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiEWL4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiEWL4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:56:23 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468E9257
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1653306977;
  x=1684842977;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to;
  bh=IgtBYicxiv70wQJQMnHWXJ17Wu2eUDiNi0YinIxUnf8=;
  b=L/eYebx1USjpsKJ+O7Cvgh9nUOIhF8dxUUqNDCXgCrNpPcQwFxqbD+vN
   mmwlboihUJ874z7XJBRczlrzaoc7xhe/sDV/gB8O94Q7BotMu0tv7FBz8
   ad8zty7lmrAnNCLB7Tj5LZuqe7AxdDvWqn8z3UjZJy/M6ybNYnDyJUsFv
   YK0JXXVNJ0Bj5WLimbsEjAGMBj/OegceXnJEzFqkwuv5SBbRQmiO4YRTx
   GE+pjwB8bmb0+Xta6UtvzMHXsItaQDfO18tuQrybpLR/4W5bu4kf5c+nw
   5N5YRTSLzd+P1rTHE6DWPZfhgjDOl6qbqPSlVQWRvLN3wmCjk9a1JmdTz
   A==;
Content-Type: multipart/mixed;
        boundary="------------Pj084NDlDRrU08KkwMN2Zlpt"
Message-ID: <e3abb8c0-a42c-4eea-993e-3c8fcce0ae64@axis.com>
Date:   Mon, 23 May 2022 13:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mailbox: forward the hrtimer if not queued and under a
 lock
Content-Language: en-US
From:   Bjorn Ardo <bjorn.ardo@axis.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     kernel <kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220331070115.29421-1-bjorn.ardo@axis.com>
 <CABb+yY1zrHYLBjY_EoC7bkTsWcKOhzCjp-5vgvqP0HEAJicdXQ@mail.gmail.com>
 <c4aa28b2-5550-ed39-3869-556b451ff54b@axis.com>
 <CABb+yY1BNsdMq7CNOBDk3sn7uvpL4=-fT7eOcbuL-+Yjz+iqHw@mail.gmail.com>
 <487bbd00-d763-0a86-9984-1dfd957fbb38@axis.com>
In-Reply-To: <487bbd00-d763-0a86-9984-1dfd957fbb38@axis.com>
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------Pj084NDlDRrU08KkwMN2Zlpt
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi again,


On 4/20/22 10:28, Bjorn Ardo wrote:
>
>
> Our current solution are using 4 different mailbox channels 
> asynchronously. The code is part of a larger system, but I can put 
> down some time and try and extract the relevant parts if you still 
> think this is a client issue? But with my current understanding of the 
> code, the race between msg_submit() and txdone_hrtimer() is quite 
> clear, and with my proposed patch that removes this race we have be 
> able to run for very long time without any problems (that is several 
> days). Without the fix we get the race after 5-10 min.
>
>
>

I do not know if you have had any time to review my comments yet, but we 
have created some examples to trigger the error.


With the attached testmodule mailbox-loadtest.c I can trigger the error 
by attaching it to the two sides of an mailbox with the following 
devicetree code:

         mboxtest1 {
                 compatible = "mailbox-loadtest";
                 mbox-names = "ping", "pong";
                 mboxes = <&mbox_loop_pri 0 &mbox_loop_pri 1>;
         };

         mboxtest2 {
                 compatible = "mailbox-loadtest";
                 mbox-names = "pong", "ping";
                 mboxes = <&mbox_loop_scd 0 &mbox_loop_scd 1>;
         };


After that I create load on the mailbox by running (or respectively 
system) the following:

while echo 1 > /sys/kernel/debug/mboxtest1/ping ; do
usleep 1
done

while echo 1 > /sys/kernel/debug/mboxtest2/ping ; do
usleep 50000
done

After a few minutes (normally 2-5) I get errors.


Using the patch I sent earlier the errors goes away.


We also have created a mailbox-loopback.c that is a loopback mailbox 
that can be used on the same system (to make testing easier on systems 
that does not have a hardware mailbox), it is also attached. This can be 
probed by the following devicetree code:

         mbox_loop_pri: mailbox_loop_pri {
                 compatible = "mailbox-loopback";
                 #mbox-cells = <1>;
                 side = <0>;
         };
         mbox_loop_scd: mailbox_loop_scd {
                 compatible = "mailbox-loopback";
                 #mbox-cells = <1>;
                 side = <1>;
         };

And with this loopback mailbox we have also been able to reproduce the 
errors without the patch applied.


Best Regards,

Björn


--------------Pj084NDlDRrU08KkwMN2Zlpt
Content-Type: text/x-csrc; charset="UTF-8"; name="mailbox-loadtest.c"
Content-Disposition: attachment; filename="mailbox-loadtest.c"
Content-Transfer-Encoding: base64

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKCi8qIE1vZHVs
ZSB0byB0ZXN0IGEgbWFpbGJveCB3aXRoIGhlYXZ5IGxvYWQgb24gdHdvIGNvbmN1cnJlbnQg
Y2hhbm5lbHMuCiAqIFNlbmRzIHRoZSB2YWx1ZSBvZiB0aGUgdm9pZCBwb2ludGVyIGFzIHRo
ZSBtZXNzYWdlLCBzbyBubyBkZXJlZmVyZW5jaW5nCiAqIG9mIHRoZSBwb2ludGVycyBhcmUg
ZG9uZSBoZXJlLCBvciBjYW4gYmUgZG9uZSBieSB0aGUgbWFpbGJveCBkcml2ZXIuCiAqLwoK
I2luY2x1ZGUgPGxpbnV4L2RlYnVnZnMuaD4KI2luY2x1ZGUgPGxpbnV4L2Vyci5oPgojaW5j
bHVkZSA8bGludXgvZnMuaD4KI2luY2x1ZGUgPGxpbnV4L2lvLmg+CiNpbmNsdWRlIDxsaW51
eC9rZXJuZWwuaD4KI2luY2x1ZGUgPGxpbnV4L21haWxib3hfY2xpZW50Lmg+CiNpbmNsdWRl
IDxsaW51eC9tb2R1bGUuaD4KI2luY2x1ZGUgPGxpbnV4L29mLmg+CiNpbmNsdWRlIDxsaW51
eC9wbGF0Zm9ybV9kZXZpY2UuaD4KI2luY2x1ZGUgPGxpbnV4L3BvbGwuaD4KI2luY2x1ZGUg
PGxpbnV4L3NsYWIuaD4KI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4KI2luY2x1ZGUgPGxp
bnV4L2ludGVycnVwdC5oPgoKc3RydWN0IG1ib3hfbG9hZHRlc3RfZGV2aWNlIHsKCXN0cnVj
dCBkZXZpY2UJCSpkZXY7CglzdHJ1Y3QgZGVudHJ5CQkqcm9vdF9kZWJ1Z2ZzX2RpcjsKCglz
dHJ1Y3QgbWJveF9jbGllbnQgICAgIAlwaW5nX2NsaWVudDsKCXN0cnVjdCBtYm94X2NoYW4J
KnBpbmdfY2hhbm5lbDsKCXN0cnVjdCBjb21wbGV0aW9uCWNvbXBsZXRpb247CglzdHJ1Y3Qg
bXV0ZXgJCXBpbmdfbG9jazsKCXUzMgkJCXBpbmdfcnNwOwoKCXN0cnVjdCBtYm94X2NsaWVu
dAlwb25nX2NsaWVudDsKCXN0cnVjdCBtYm94X2NoYW4JKnBvbmdfY2hhbm5lbDsKCXN0cnVj
dCB0YXNrbGV0X3N0cnVjdAlwb25nX3Rhc2tsZXQ7Cgl1MzIJCQlwb25nX3JzcDsKfTsKCgpz
dGF0aWMgdm9pZCBtYm94X2xvYWR0ZXN0X3JlY2VpdmVfcGluZ19tZXNzYWdlKHN0cnVjdCBt
Ym94X2NsaWVudCAqY2xpZW50LCB2b2lkICptZXNzYWdlKQp7CglzdHJ1Y3QgbWJveF9sb2Fk
dGVzdF9kZXZpY2UgKnRkZXYgPSBjb250YWluZXJfb2YoY2xpZW50LCBzdHJ1Y3QgbWJveF9s
b2FkdGVzdF9kZXZpY2UsIHBpbmdfY2xpZW50KTsKCgl0ZGV2LT5waW5nX3JzcCA9ICh1MzIp
KHVuc2lnbmVkIGxvbmcpbWVzc2FnZTsKCWNvbXBsZXRlKCZ0ZGV2LT5jb21wbGV0aW9uKTsK
fQoKc3RhdGljIHZvaWQgbWJveF9sb2FkdGVzdF9wb25nX3Rhc2tsZXQodW5zaWduZWQgbG9u
ZyBkYXRhKQp7CglzdHJ1Y3QgbWJveF9sb2FkdGVzdF9kZXZpY2UgKnRkZXYgPSAoc3RydWN0
IG1ib3hfbG9hZHRlc3RfZGV2aWNlICopZGF0YTsKCgltYm94X3NlbmRfbWVzc2FnZSh0ZGV2
LT5wb25nX2NoYW5uZWwsICh2b2lkICopKHVuc2lnbmVkIGxvbmcpdGRldi0+cG9uZ19yc3Ap
Owp9CgpzdGF0aWMgdm9pZCBtYm94X2xvYWR0ZXN0X3JlY2VpdmVfcG9uZ19tZXNzYWdlKHN0
cnVjdCBtYm94X2NsaWVudCAqY2xpZW50LCB2b2lkICptZXNzYWdlKQp7CglzdHJ1Y3QgbWJv
eF9sb2FkdGVzdF9kZXZpY2UgKnRkZXYgPSBjb250YWluZXJfb2YoY2xpZW50LCBzdHJ1Y3Qg
bWJveF9sb2FkdGVzdF9kZXZpY2UsIHBvbmdfY2xpZW50KTsKCgl0ZGV2LT5wb25nX3JzcCA9
ICgodTMyKSh1bnNpZ25lZCBsb25nKW1lc3NhZ2UpICsgMTsKCXRhc2tsZXRfaW5pdCgmdGRl
di0+cG9uZ190YXNrbGV0LCBtYm94X2xvYWR0ZXN0X3BvbmdfdGFza2xldCwgKHVuc2lnbmVk
IGxvbmcpdGRldik7Cgl0YXNrbGV0X2hpX3NjaGVkdWxlKCZ0ZGV2LT5wb25nX3Rhc2tsZXQp
Owp9CgpzdGF0aWMgaW50IG1ib3hfbG9hZHRlc3Rfc2VuZF9waW5nX21lc3NhZ2Uoc3RydWN0
IG1ib3hfbG9hZHRlc3RfZGV2aWNlICp0ZGV2LCB1MzIgbWVzc2FnZSkKewoJaW50IGNvbXBs
ZWF0ZWQ7Cgl1MzIgcnNwOwoKCW11dGV4X2xvY2soJnRkZXYtPnBpbmdfbG9jayk7CglyZWlu
aXRfY29tcGxldGlvbigmdGRldi0+Y29tcGxldGlvbik7CgltYm94X3NlbmRfbWVzc2FnZSh0
ZGV2LT5waW5nX2NoYW5uZWwsICh2b2lkICopKHVuc2lnbmVkIGxvbmcpbWVzc2FnZSk7CgoJ
Y29tcGxlYXRlZCA9IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmdGRldi0+Y29tcGxl
dGlvbiwgbXNlY3NfdG9famlmZmllcygyMCkpOwoJcnNwID0gdGRldi0+cGluZ19yc3A7Cglt
dXRleF91bmxvY2soJnRkZXYtPnBpbmdfbG9jayk7CgoJaWYgKCFjb21wbGVhdGVkKSB7CgkJ
ZGV2X2Vycih0ZGV2LT5kZXYsICJUaW1lb3V0XG4iKTsKCQlyZXR1cm4gLUVGQVVMVDsKCX0K
CWlmIChyc3AgIT0gbWVzc2FnZSsxKSB7CgkJZGV2X2Vycih0ZGV2LT5kZXYsICJXcm9uZyBh
bnMgJWkgIT0gJWlcbiIsIHJzcCwgbWVzc2FnZSk7CgkJcmV0dXJuIC1FRkFVTFQ7Cgl9CgoJ
cmV0dXJuIDA7Cn0Kc3RhdGljIHNzaXplX3QgbWJveF9sb2FkdGVzdF9waW5nX3dyaXRlKHN0
cnVjdCBmaWxlICpmaWxwLAoJCQkJICAgICAgIGNvbnN0IGNoYXIgX191c2VyICp1c2VyYnVm
LAoJCQkJICAgICAgIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQp7CglpbnQgcmV0OwoJ
c3RydWN0IG1ib3hfbG9hZHRlc3RfZGV2aWNlICp0ZGV2ID0gZmlscC0+cHJpdmF0ZV9kYXRh
OwoKCXJldCA9IG1ib3hfbG9hZHRlc3Rfc2VuZF9waW5nX21lc3NhZ2UodGRldiwgMHg0Mik7
CglyZXR1cm4gcmV0IDwgMCA/IHJldCA6IGNvdW50Owp9CgpzdGF0aWMgY29uc3Qgc3RydWN0
IGZpbGVfb3BlcmF0aW9ucyBtYm94X2xvYWR0ZXN0X3Bpbmdfb3BzID0gewoJLndyaXRlCT0g
bWJveF9sb2FkdGVzdF9waW5nX3dyaXRlLAoJLm9wZW4JPSBzaW1wbGVfb3BlbiwKfTsKCnN0
YXRpYyBpbnQgbWJveF9sb2FkdGVzdF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQp7CglzdHJ1Y3QgbWJveF9sb2FkdGVzdF9kZXZpY2UgKnRkZXY7CglzdHJ1Y3QgZGV2
aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7CgoJdGRldiA9IGRldm1fa3phbGxv
YygmcGRldi0+ZGV2LCBzaXplb2YoKnRkZXYpLCBHRlBfS0VSTkVMKTsKCWlmICghdGRldikK
CQlyZXR1cm4gLUVOT01FTTsKCglpZiAob2ZfcHJvcGVydHlfbWF0Y2hfc3RyaW5nKG5wLCAi
bWJveC1uYW1lcyIsICJwaW5nIikgPj0gMCkgewoKCQl0ZGV2LT5waW5nX2NsaWVudC5kZXYg
PSAmcGRldi0+ZGV2OwoJCXRkZXYtPnBpbmdfY2xpZW50LnJ4X2NhbGxiYWNrID0gbWJveF9s
b2FkdGVzdF9yZWNlaXZlX3BpbmdfbWVzc2FnZTsKCQl0ZGV2LT5waW5nX2NsaWVudC50eF9k
b25lID0gTlVMTDsKCQl0ZGV2LT5waW5nX2NsaWVudC50eF9ibG9jayA9IGZhbHNlOwoJCXRk
ZXYtPnBpbmdfY2xpZW50Lmtub3dzX3R4ZG9uZSA9IGZhbHNlOwoJCXRkZXYtPnBpbmdfY2xp
ZW50LnR4X3RvdXQgPSA1MDA7CgkJdGRldi0+cGluZ19jaGFubmVsID0gIG1ib3hfcmVxdWVz
dF9jaGFubmVsX2J5bmFtZSgmdGRldi0+cGluZ19jbGllbnQsICJwaW5nIik7CgkJaWYgKElT
X0VSUih0ZGV2LT5waW5nX2NoYW5uZWwpKSB7CgkJCXJldHVybiAtRVBST0JFX0RFRkVSOwoJ
CX0KCQltdXRleF9pbml0KCZ0ZGV2LT5waW5nX2xvY2spOwoKCQlpZiAoZGVidWdmc19pbml0
aWFsaXplZCgpKSB7CgkJCXRkZXYtPnJvb3RfZGVidWdmc19kaXIgPSBkZWJ1Z2ZzX2NyZWF0
ZV9kaXIoZGV2X25hbWUoJnBkZXYtPmRldiksIE5VTEwpOwoJCQlkZWJ1Z2ZzX2NyZWF0ZV9m
aWxlKCJwaW5nIiwgMDYwMCwgdGRldi0+cm9vdF9kZWJ1Z2ZzX2RpciwKCQkJCQkgICAgdGRl
diwgJm1ib3hfbG9hZHRlc3RfcGluZ19vcHMpOwoJCX0KCX0KCglpZiAob2ZfcHJvcGVydHlf
bWF0Y2hfc3RyaW5nKG5wLCAibWJveC1uYW1lcyIsICJwb25nIikgPj0gMCkgewoKCQl0ZGV2
LT5wb25nX2NsaWVudC5kZXYgPSAmcGRldi0+ZGV2OwoJCXRkZXYtPnBvbmdfY2xpZW50LnJ4
X2NhbGxiYWNrID0gbWJveF9sb2FkdGVzdF9yZWNlaXZlX3BvbmdfbWVzc2FnZTsKCQl0ZGV2
LT5wb25nX2NsaWVudC50eF9kb25lID0gTlVMTDsKCQl0ZGV2LT5wb25nX2NsaWVudC50eF9i
bG9jayA9IGZhbHNlOwoJCXRkZXYtPnBvbmdfY2xpZW50Lmtub3dzX3R4ZG9uZSA9IGZhbHNl
OwoJCXRkZXYtPnBvbmdfY2xpZW50LnR4X3RvdXQgPSA1MDA7CgkJdGRldi0+cG9uZ19jaGFu
bmVsID0gIG1ib3hfcmVxdWVzdF9jaGFubmVsX2J5bmFtZSgmdGRldi0+cG9uZ19jbGllbnQs
ICJwb25nIik7CgkJaWYgKElTX0VSUih0ZGV2LT5wb25nX2NoYW5uZWwpKSB7CgkJCXJldHVy
biAtRVBST0JFX0RFRkVSOwoJCX0KCX0KCglpbml0X2NvbXBsZXRpb24oJnRkZXYtPmNvbXBs
ZXRpb24pOwoJdGRldi0+ZGV2ID0gJnBkZXYtPmRldjsKCXBsYXRmb3JtX3NldF9kcnZkYXRh
KHBkZXYsIHRkZXYpOwoJcmV0dXJuIDA7Cn0KCnN0YXRpYyBpbnQgbWJveF9sb2FkdGVzdF9y
ZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKewoJc3RydWN0IG1ib3hfbG9h
ZHRlc3RfZGV2aWNlICp0ZGV2ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7CgoJZGVi
dWdmc19yZW1vdmVfcmVjdXJzaXZlKHRkZXYtPnJvb3RfZGVidWdmc19kaXIpOwoKCWlmICh0
ZGV2LT5waW5nX2NoYW5uZWwpCgkJbWJveF9mcmVlX2NoYW5uZWwodGRldi0+cGluZ19jaGFu
bmVsKTsKCWlmICh0ZGV2LT5wb25nX2NoYW5uZWwpCgkJbWJveF9mcmVlX2NoYW5uZWwodGRl
di0+cG9uZ19jaGFubmVsKTsKCglyZXR1cm4gMDsKfQoKc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgbWJveF9sb2FkdGVzdF9tYXRjaFtdID0gewoJeyAuY29tcGF0aWJsZSA9
ICJtYWlsYm94LWxvYWR0ZXN0IiB9LAoJe30sCn07Ck1PRFVMRV9ERVZJQ0VfVEFCTEUob2Ys
IG1ib3hfbG9hZHRlc3RfbWF0Y2gpOwoKc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIg
bWJveF9sb2FkdGVzdF9kcml2ZXIgPSB7CgkuZHJpdmVyID0gewoJCS5uYW1lID0gIm1haWxi
b3hfbG9hZHRlc3QiLAoJCS5vZl9tYXRjaF90YWJsZSA9IG1ib3hfbG9hZHRlc3RfbWF0Y2gs
Cgl9LAoJLnByb2JlICA9IG1ib3hfbG9hZHRlc3RfcHJvYmUsCgkucmVtb3ZlID0gbWJveF9s
b2FkdGVzdF9yZW1vdmUsCn07Cm1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIobWJveF9sb2FkdGVz
dF9kcml2ZXIpOwoKTU9EVUxFX0RFU0NSSVBUSU9OKCJNYWlsYm94IExvYWQgVGVzdGluZyBG
YWNpbGl0eSIpOwpNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7Cg==
--------------Pj084NDlDRrU08KkwMN2Zlpt
Content-Type: text/x-csrc; charset="UTF-8"; name="mailbox-loopback.c"
Content-Disposition: attachment; filename="mailbox-loopback.c"
Content-Transfer-Encoding: base64

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKCi8qIFRoaXMgaXMgYSBsb29w
YmFjayBtYWlsYm94IHRoYXQgY2FuIGJlIHVzZWQgdG8gdGVzdCBkcml2ZXJzIG9uCiAqIGEg
c2luZ2xlIHN5c3RlbS4gSXQgdXNlcyBhIGdsb2JhbCBtZW1vcnkgc28gb25seSAyIGluc3Rh
bmNlcwogKiAob25lIGZvciBlYWNoIHNpZGUpIGNhbiBiZSBwcm9iZWQuCiAqLwoKCiNpbmNs
dWRlIDxsaW51eC9tYWlsYm94X2NvbnRyb2xsZXIuaD4KI2luY2x1ZGUgPGxpbnV4L3BsYXRm
b3JtX2RldmljZS5oPgojaW5jbHVkZSA8bGludXgvaXJxX3dvcmsuaD4KI2luY2x1ZGUgPGxp
bnV4L2RldmljZS5oPgojaW5jbHVkZSA8bGludXgva2VybmVsLmg+CiNpbmNsdWRlIDxsaW51
eC9tb2R1bGUuaD4KI2luY2x1ZGUgPGxpbnV4L29mLmg+CgoKc3RydWN0IG1ib3hfbG9vcGJh
Y2tfY2hhbiB7CglzdHJ1Y3QgbWJveF9jaGFuCSpzZWxmOwoJc3RydWN0IG1ib3hfY2hhbgkq
b3RoZXI7CglzdHJ1Y3QgaXJxX3dvcmsJCXdvcms7CglzdHJ1Y3QgaHJ0aW1lcgkJdGltZXI7
Cgl1MzIJCQltc2c7Cglib29sCQkJcGVuZGluZzsKfTsKCiNkZWZpbmUgTUFJTEJPWF9OVU1f
Q0hBTlMJMzIKCnN0cnVjdCBtYm94X2xvb3BiYWNrIHsKCXN0cnVjdCBtYm94X2NvbnRyb2xs
ZXIJCWNvbnRyb2xsZXJbMl07Cglib29sCQkJCXByb2JlZFsyXTsKCXN0cnVjdCBtYm94X2xv
b3BiYWNrX2NoYW4JbGNoYW5zWzIqTUFJTEJPWF9OVU1fQ0hBTlNdOwoJc3RydWN0IG1ib3hf
Y2hhbgkJY2hhbnNbMipNQUlMQk9YX05VTV9DSEFOU107Cn07CgovKiBBIGdsb2JhbCBzaGFy
ZWQgbWVtb3J5IGZvciBib3RoIHNpZGVzIG9mIHRoZSBtYWlsYm94ICovCnN0YXRpYyBzdHJ1
Y3QgbWJveF9sb29wYmFjayBtYm94X2xvb3BiYWNrOwoKc3RhdGljIHZvaWQgbWJveF9sb29w
YmFja193b3JrKHN0cnVjdCBpcnFfd29yayAqd29yaykKewoJc3RydWN0IG1ib3hfbG9vcGJh
Y2tfY2hhbiAqbGNoYW4gPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IG1ib3hfbG9vcGJh
Y2tfY2hhbiwgd29yayk7CgoJbWJveF9jaGFuX3JlY2VpdmVkX2RhdGEobGNoYW4tPm90aGVy
LCAodm9pZCAqKSh1bnNpZ25lZCBsb25nKWxjaGFuLT5tc2cpOwoJc21wX3dtYigpOwoJbGNo
YW4tPnBlbmRpbmcgPSBmYWxzZTsKfQoKc3RhdGljIGJvb2wgbWJveF9sb29wYmFja19sYXN0
X3R4X2RvbmUoc3RydWN0IG1ib3hfY2hhbiAqY2hhbikKewoJc3RydWN0IG1ib3hfbG9vcGJh
Y2tfY2hhbiAqbGNoYW4gPSBjaGFuLT5jb25fcHJpdjsKCglyZXR1cm4gIWxjaGFuLT5wZW5k
aW5nOwp9CgpzdGF0aWMgaW50IG1ib3hfbG9vcGJhY2tfc2VuZF9kYXRhKHN0cnVjdCBtYm94
X2NoYW4gKmNoYW4sIHZvaWQgKmRhdGEpCnsKCXN0cnVjdCBtYm94X2xvb3BiYWNrX2NoYW4g
KmxjaGFuID0gY2hhbi0+Y29uX3ByaXY7CgoJbGNoYW4tPm1zZyA9ICh1MzIpKHVuc2lnbmVk
IGxvbmcpZGF0YTsKCWxjaGFuLT5wZW5kaW5nID0gdHJ1ZTsKCXNtcF93bWIoKTsKCgkvKiBT
dGFydCBhIHRpbWVyIHRoYXQgd2lsbCB0cmlnZ2VyIGFuIElSUSBpbiBhIHNob3J0IHdoaWxl
ICovCglocnRpbWVyX3N0YXJ0KCZsY2hhbi0+dGltZXIsIG5zX3RvX2t0aW1lKDEwMDApLCBI
UlRJTUVSX01PREVfUkVMKTsKCXJldHVybiAwOwp9CgpzdGF0aWMgZW51bSBocnRpbWVyX3Jl
c3RhcnQgbWJveF9sb29wYmFja190aW1lcl9jYWxsYmFjayhzdHJ1Y3QgaHJ0aW1lciAqaHJ0
aW1lcikKewoJc3RydWN0IG1ib3hfbG9vcGJhY2tfY2hhbiAqbGNoYW4gPSBjb250YWluZXJf
b2YoaHJ0aW1lciwgc3RydWN0IG1ib3hfbG9vcGJhY2tfY2hhbiwgdGltZXIpOwoKCWlycV93
b3JrX3F1ZXVlKCZsY2hhbi0+d29yayk7CglyZXR1cm4gSFJUSU1FUl9OT1JFU1RBUlQ7Cn0K
CnN0YXRpYyB2b2lkIG1ib3hfbG9vcGJhY2tfc2h1dGRvd24oc3RydWN0IG1ib3hfY2hhbiAq
Y2hhbikKewoJc3RydWN0IG1ib3hfbG9vcGJhY2tfY2hhbiAqbGNoYW4gPSBjaGFuLT5jb25f
cHJpdjsKCglocnRpbWVyX2NhbmNlbCgmbGNoYW4tPnRpbWVyKTsKCWlycV93b3JrX3N5bmMo
JmxjaGFuLT53b3JrKTsKfQoKc3RhdGljIGNvbnN0IHN0cnVjdCBtYm94X2NoYW5fb3BzIG1i
b3hfbG9vcGJhY2tfb3BzID0gewoJLnNlbmRfZGF0YSA9IG1ib3hfbG9vcGJhY2tfc2VuZF9k
YXRhLAoJLnNodXRkb3duID0gbWJveF9sb29wYmFja19zaHV0ZG93biwKCS5sYXN0X3R4X2Rv
bmUgPSBtYm94X2xvb3BiYWNrX2xhc3RfdHhfZG9uZSwKfTsKCnN0YXRpYyBpbnQgbWJveF9s
b29wYmFja19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQp7CglzdHJ1Y3Qg
ZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2OwoJaW50IGk7Cgl1bnNpZ25lZCBpbnQgc2lkZTsK
CgkvKiBDaGVjayBzaWRlIChub3RoaW5nIG9yIGFueXRoaW5nIGJ1dCAxIGlzIHByaW1hcnkg
c2lkZSkgKi8KCW9mX3Byb3BlcnR5X3JlYWRfdTMyKGRldi0+b2Zfbm9kZSwgInNpZGUiLCAm
c2lkZSk7CglpZiAoc2lkZSAhPSAxKQoJCXNpZGUgPSAwOwoKCWlmIChtYm94X2xvb3BiYWNr
LnByb2JlZFtzaWRlXSkKCQlyZXR1cm4gLUVOT01FTTsKCW1ib3hfbG9vcGJhY2sucHJvYmVk
W3NpZGVdID0gdHJ1ZTsKCgltYm94X2xvb3BiYWNrLmNvbnRyb2xsZXJbc2lkZV0uZGV2ID0g
ZGV2OwoJbWJveF9sb29wYmFjay5jb250cm9sbGVyW3NpZGVdLm51bV9jaGFucyA9IE1BSUxC
T1hfTlVNX0NIQU5TOwoJbWJveF9sb29wYmFjay5jb250cm9sbGVyW3NpZGVdLnR4ZG9uZV9p
cnEgPSBmYWxzZTsKCW1ib3hfbG9vcGJhY2suY29udHJvbGxlcltzaWRlXS50eGRvbmVfcG9s
bCA9IHRydWU7CgltYm94X2xvb3BiYWNrLmNvbnRyb2xsZXJbc2lkZV0udHhwb2xsX3Blcmlv
ZCA9IDE7CgltYm94X2xvb3BiYWNrLmNvbnRyb2xsZXJbc2lkZV0uY2hhbnMgPSAmbWJveF9s
b29wYmFjay5jaGFuc1tzaWRlICogTUFJTEJPWF9OVU1fQ0hBTlNdOwoJbWJveF9sb29wYmFj
ay5jb250cm9sbGVyW3NpZGVdLm9wcyA9ICZtYm94X2xvb3BiYWNrX29wczsKCglCVUlMRF9C
VUdfT04oQVJSQVlfU0laRShtYm94X2xvb3BiYWNrLmNoYW5zKSAhPSBBUlJBWV9TSVpFKG1i
b3hfbG9vcGJhY2subGNoYW5zKSk7CgoJZm9yIChpID0gMDsgaSA8IE1BSUxCT1hfTlVNX0NI
QU5TOyBpKyspIHsKCQlpbnQgbWUgPSBpICsgc2lkZSAqIE1BSUxCT1hfTlVNX0NIQU5TOwoJ
CWludCBvdGhlcjsKCgkJaWYgKG1lID49IE1BSUxCT1hfTlVNX0NIQU5TKSB7CgkJCW90aGVy
ID0gbWUgLSBNQUlMQk9YX05VTV9DSEFOUzsKCQl9IGVsc2UgewoJCQlvdGhlciA9IG1lICsg
TUFJTEJPWF9OVU1fQ0hBTlM7CgkJfQoKCQltYm94X2xvb3BiYWNrLmxjaGFuc1ttZV0uc2Vs
ZiA9ICZtYm94X2xvb3BiYWNrLmNoYW5zW21lXTsKCQltYm94X2xvb3BiYWNrLmxjaGFuc1tt
ZV0ub3RoZXIgPSAmbWJveF9sb29wYmFjay5jaGFuc1tvdGhlcl07CgkJaW5pdF9pcnFfd29y
aygmbWJveF9sb29wYmFjay5sY2hhbnNbbWVdLndvcmssIG1ib3hfbG9vcGJhY2tfd29yayk7
CgkJaHJ0aW1lcl9pbml0KCZtYm94X2xvb3BiYWNrLmxjaGFuc1ttZV0udGltZXIsIENMT0NL
X01PTk9UT05JQywgSFJUSU1FUl9NT0RFX1JFTCk7CgkJbWJveF9sb29wYmFjay5sY2hhbnNb
bWVdLnRpbWVyLmZ1bmN0aW9uID0gbWJveF9sb29wYmFja190aW1lcl9jYWxsYmFjazsKCQlt
Ym94X2xvb3BiYWNrLmNoYW5zW21lXS5jb25fcHJpdiA9ICZtYm94X2xvb3BiYWNrLmxjaGFu
c1ttZV07Cgl9CglyZXR1cm4gZGV2bV9tYm94X2NvbnRyb2xsZXJfcmVnaXN0ZXIoZGV2LCAm
bWJveF9sb29wYmFjay5jb250cm9sbGVyW3NpZGVdKTsKfQoKc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgbWJveF9sb29wYmFja19tYXRjaFtdID0gewoJeyAuY29tcGF0aWJs
ZSA9ICJtYWlsYm94LWxvb3BiYWNrIiB9LAoJeyAvKiBzZW50aW5lbCAqLyB9Cn07Ck1PRFVM
RV9ERVZJQ0VfVEFCTEUob2YsIG1ib3hfbG9vcGJhY2tfbWF0Y2gpOwoKc3RhdGljIHN0cnVj
dCBwbGF0Zm9ybV9kcml2ZXIgbWJveF9sb29wYmFja19kcml2ZXIgPSB7CgkucHJvYmUJPSBt
Ym94X2xvb3BiYWNrX3Byb2JlLAoJLmRyaXZlcgk9IHsKCQkubmFtZQk9ICJtYWlsYm94LWxv
b3BiYWNrIiwKCQkub2ZfbWF0Y2hfdGFibGUJPSBtYm94X2xvb3BiYWNrX21hdGNoLAoJfSwK
fTsKCm1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIobWJveF9sb29wYmFja19kcml2ZXIpOwoKTU9E
VUxFX0RFU0NSSVBUSU9OKCJMb29wYmFjayBNYWlsYm94Iik7Ck1PRFVMRV9MSUNFTlNFKCJH
UEwgdjIiKTsK

--------------Pj084NDlDRrU08KkwMN2Zlpt--
