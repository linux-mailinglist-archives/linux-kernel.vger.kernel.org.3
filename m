Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76275A68C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiH3Qtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiH3Qtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:49:47 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA54C5784
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:49:25 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id T4QUox6DM09yuT4QUoxxpA; Tue, 30 Aug 2022 18:49:23 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 30 Aug 2022 18:49:23 +0200
X-ME-IP: 90.11.190.129
Message-ID: <431dacd9-bda0-7a0b-3280-e27d01030c01@wanadoo.fr>
Date:   Tue, 30 Aug 2022 18:49:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] HID: cp2112: Remove some dead code
Content-Language: en-GB
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
References: <6ee2132c415db2fc90e7fa2106db427a914cc566.1655563907.git.christophe.jaillet@wanadoo.fr>
 <nycvar.YFH.7.76.2208251126010.19850@cbobk.fhfr.pm>
 <CAO-hwJJfncQ3jgtS=HO0atbzrTNOT_rzU66oG2yRTWTSY-L8KA@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAO-hwJJfncQ3jgtS=HO0atbzrTNOT_rzU66oG2yRTWTSY-L8KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 30/08/2022 à 13:56, Benjamin Tissoires a écrit :
> On Thu, Aug 25, 2022 at 11:26 AM Jiri Kosina <jikos@kernel.org> wrote:
>>
>> On Sat, 18 Jun 2022, Christophe JAILLET wrote:
>>
>>> Commit 13de9cca514e ("HID: cp2112: add IRQ chip handling") has introduced
>>> cp2112_allocate_irq() that seems to be unused since 2016.
>>>
>>> Remove it, remove the associated resources and part of the remove()
>>> function that frees the resources allocated in cp2112_allocate_irq().
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>> Compile tested only.
>>>
>>> Maybe the issue is completely elsewhere and the probe() should call
>>> cp2112_allocate_irq() in some cases.
>>
>> Benjamin, could you please take a look? Apparently you were aware of the
>> code being dead due to the __maybe_unused annotation ... :) What was the
>> point?
>>
> 
> Looks like I kept that code around for the CI I am running on HID patches.
> 
> IIRC, I left the code in the tree because it might have been useful to
> others when they need to declare IRQs on the board. So yes, it is
> entirely dead code upstream :/
> 
> I am applying the following 3 patches on the current master tree to be
> able to declare hid-cp2112 as an i2c-hid transport:
> https://gitlab.freedesktop.org/bentiss/gitlab-kernel-ci/-/tree/master/VM
> 
> Those 3 patches can not be upstreamed because platform drivers are a
> dead thing, but I have no other ideas on how I can declare an i2c-hid
> device on top of hid-cp2112.  Given that we don't have DT on x86_64
> vm, I can not rely on that to have my custom sensor (or maybe I can
> but I am not aware of it).
> 
> So unless anybody has a better idea, I won't fight against removing
> that code, but it's more convenient for me to have it.
> 
> Cheers,
> Benjamin
> 

This was just a clean-up patch. I personally don't really care if 
applied or not.

So, from my POV if it helps, it can stay.
On the other side, I guess that it could also easily become another 
patch in your serie.

Do what is best.

CJ


