Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AD55107D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348913AbiDZTE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbiDZTE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:04:26 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9689C1569D3;
        Tue, 26 Apr 2022 12:01:17 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8A7883F629;
        Tue, 26 Apr 2022 19:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650999676;
        bh=w1p9FP+i2jm+5oDmUL5vA1N4CjAzmQJWNbk5DTu69ds=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=NsItsbY89kQxBDBoET6MYBrxgU0baZ+mSkngiOVFznbbbj6T6ewVaBxtBuy9Jzv7D
         SEq9M24wA9NFZSJigN6TvcNqIS4VSyhGHDULKP3sibwhaSsALDKvWd8qvDaKqOKVlZ
         CL/jeRIKLbuWVKY14LMtzLN3CdeoXDy7qFyCUceAz8bBMWWGpt3XfgMsNgc4IqP3bB
         lebJMrKllUOAZqRxfJx/S3L0sCGTvwqpSipFTNZ5W9T2+aWy0TDQWlJpIsUnZ2FhR1
         lbGUPwmJ7mseiRTjB8/nw6SF/omK5Hc+ZwUs9tkImrGLjRD9kjHj38fVrdRtgcHcJo
         UfiTBmTd2En6Q==
Message-ID: <508ba368-630e-3a57-d128-a77a0dd16ee4@canonical.com>
Date:   Tue, 26 Apr 2022 12:01:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 25/29] Audit: Allow multiple records in an
 audit_buffer
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-26-casey@schaufler-ca.com>
 <81c9f88f-7e8f-0ca6-56b8-049571af6809@canonical.com>
 <CAHC9VhRX+VSw+-PsCwhHceQ9MpE4E-D-OnaO0CGqar44xc3a1w@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <CAHC9VhRX+VSw+-PsCwhHceQ9MpE4E-D-OnaO0CGqar44xc3a1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 11:12, Paul Moore wrote:
> On Mon, Apr 25, 2022 at 9:06 PM John Johansen
> <john.johansen@canonical.com> wrote:
>> On 4/18/22 07:59, Casey Schaufler wrote:
>>> Replace the single skb pointer in an audit_buffer with
>>> a list of skb pointers. Add the audit_stamp information
>>> to the audit_buffer as there's no guarantee that there
>>> will be an audit_context containing the stamp associated
>>> with the event. At audit_log_end() time create auxiliary
>>> records (none are currently defined) as have been added
>>> to the list.
>>>
>>> Suggested-by: Paul Moore <paul@paul-moore.com>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>
>> I agree with Paul that audit_buffer_aux_new() and
>> audit_buffer_aux_end() belong in this patch
>>
>>
>>> ---
>>>  kernel/audit.c | 62 +++++++++++++++++++++++++++++++-------------------
>>>  1 file changed, 39 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/kernel/audit.c b/kernel/audit.c
>>> index 6b6c089512f7..4d44c05053b0 100644
>>> --- a/kernel/audit.c
>>> +++ b/kernel/audit.c
>>> @@ -197,8 +197,10 @@ static struct audit_ctl_mutex {
>>>   * to place it on a transmit queue.  Multiple audit_buffers can be in
>>>   * use simultaneously. */
>>>  struct audit_buffer {
>>> -     struct sk_buff       *skb;      /* formatted skb ready to send */
>>> +     struct sk_buff       *skb;      /* the skb for audit_log functions */
>>> +     struct sk_buff_head  skb_list;  /* formatted skbs, ready to send */
>>>       struct audit_context *ctx;      /* NULL or associated context */
>>> +     struct audit_stamp   stamp;     /* audit stamp for these records */
>>>       gfp_t                gfp_mask;
>>>  };
>>>
>>> @@ -1765,10 +1767,13 @@ __setup("audit_backlog_limit=", audit_backlog_limit_set);
>>>
>>>  static void audit_buffer_free(struct audit_buffer *ab)
>>>  {
>>> +     struct sk_buff *skb;
>>> +
>>>       if (!ab)
>>>               return;
>>>
>>> -     kfree_skb(ab->skb);
>>> +     while((skb = skb_dequeue(&ab->skb_list)))
>>> +             kfree_skb(skb);
>>
>> we still have and ab->skb can we have a debug check that its freed by walking the queue?
> 
> By definition ab->skb is always going to point at something on the
> list, if it doesn't we are likely to have failures elsewhere.  The
> structure definition is private to kernel/audit.c and the
> allocation/creation is handled by an allocator function which always
> adds the new skb to the list so I think we're okay.
> 
yeah I got that eventually, though it wasn't immediately obvious

> We could add additional checks, but with audit performance already a
> hot topic I would prefer to draw the debug-check line at input coming
> from outside the audit subsystem.
> 
and that is why I asked for a debug check. But its not a hard requirement
just a nice to have because I have been bitten by internal consistency
issues all to often.

