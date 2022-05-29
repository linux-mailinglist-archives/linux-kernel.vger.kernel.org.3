Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C385371FD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 20:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiE2SDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiE2SDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:03:13 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883E064BCC
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 11:03:11 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id C134E24010A
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 20:03:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1653847389; bh=V+hBGlzYh2FUjbMb+wqYLlGhEtLBNvvtCi7vq1yt04I=;
        h=From:Subject:To:Cc:Date:From;
        b=sJHWaz0X8fP0TCOt/QNTW0Hr3ejb7CPAoEXXdj+x0WAqiZqvYRFy8z4xx2z3KGKaP
         Il1K4E9U5HCRUb1h1ZSLMg39yfICJaTCXDSDJ8UTaKTXYnc36g/6Uz2ko+HcY32rvU
         TsqF77x+RHvXNZaVxDRPhVhZqKwZAGSMvXZW0mLeoUFZzz10/Nb7NtKNgAsVwQaTxu
         v7FudzwQU3ANS/uaLl1OhcT5nnyHwaBGYD7iUuv2G4lKhO/EvS0N4J86sfOvsM7qFE
         u29O/iQIMhmz4bsOESARarRYU+wI5PB9OxV5UteZNup7yE+OFAWIoiLMWEpBUUWr3v
         wmCTfD/3J62xg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LB5xR2qhKz9rxQ;
        Sun, 29 May 2022 20:03:07 +0200 (CEST)
From:   Derek Dolney <z23@posteo.net>
Subject: Re: [PATCH v2] cpu/hotplug: Do not bail-out in DYING/STARTING
 sections
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Donnefort <vdonnefort@google.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        vschneid@redhat.com, kernel-team@android.com
References: <20220523160536.2889162-1-vdonnefort@google.com>
 <20220525165248.GI2578@worktop.programming.kicks-ass.net>
 <Yo85PLANCnCcMgvD@google.com>
 <20220526101536.GP2578@worktop.programming.kicks-ass.net>
Message-ID: <e589b71b-9fa2-0ca1-af2e-0c513b9250cd@posteo.net>
Date:   Sun, 29 May 2022 18:01:14 +0000
MIME-Version: 1.0
In-Reply-To: <20220526101536.GP2578@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI there is also now a patch to fix the driver bug in testing by the
tboot devs at the moment, you could monitor the progress here:

https://sourceforge.net/p/tboot/mailman/message/37659164/

I tested this patch and it works for me.

Derek

On 5/26/22 6:15 AM, Peter Zijlstra wrote:
> On Thu, May 26, 2022 at 09:24:28AM +0100, Vincent Donnefort wrote:
>> On Wed, May 25, 2022 at 06:52:48PM +0200, Peter Zijlstra wrote:
>>> On Mon, May 23, 2022 at 05:05:36PM +0100, Vincent Donnefort wrote:
>>>> The DYING/STARTING callbacks are not expected to fail. However, as reported
>>>> by Derek, drivers such as tboot are still free to return errors within
>>>> those sections. In that case, there's nothing the hotplug machinery can do,
>>>> so let's just proceed and log the failures.
>>>>
>>>
>>> I'm confused. Why isn't this a driver bug?
>>
>> It is a entirely a driver bug which has been reported already. but 453e41085183
>> (cpu/hotplug: Add cpuhp_invoke_callback_range()) changed the behaviour so I
>> thought it would be worth to revert to the original one which is to not break
>> the entire up/down for a single driver error.
> 
> Ah I see. Fair enough I suppose.
> 
