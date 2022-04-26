Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BA95108EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354053AbiDZT2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354004AbiDZT2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:28:12 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873CEDF3;
        Tue, 26 Apr 2022 12:25:01 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 002703F62C;
        Tue, 26 Apr 2022 19:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1651001099;
        bh=ZV4VMgEemFkbKsO/BobT4va3EFuCw9GFALUPwGhS2q0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=SKue6RWYRrNekb15Qc5uEHWG1Vsx8fVmYNJs11V/kH8dF7yn+yUWbt3Wiq9uBMRvK
         ZByWB7RX/ENeMc7jsEReVBQ81ksBcbRbf0ooalfcVo9M+9rUvnuoj99OEmmCA1I39f
         TsMzh4SACZYoyt4dk8jSCcSvkvHe+RA4txV2AGF8ezcfvuOZjzQjYGPu3IDgRZajEQ
         agPb+hVq7SC+WpDw1hODrkCG7PZJ8XaBE0hZcKXns0UcENn4VmEcOEo01xuyMm+OJ9
         s/pzEt1G42hSG6p2gqSIu+Ad5Z+yS11UHqhzAq/qbPC0GPRwwQfxziAXfdSH2AZnVG
         DMake7KkcKKKQ==
Message-ID: <271d9de4-3673-e130-8197-60d8640bca0f@canonical.com>
Date:   Tue, 26 Apr 2022 12:24:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 27/29] Audit: Add record for multiple object contexts
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-28-casey@schaufler-ca.com>
 <f2186f22-5bcd-d962-7e49-c816fc5fbd07@canonical.com>
 <CAHC9VhTXgBTH+7ny-fcMP_HC1ojA1ass38PGHS2tJny0bCGXzA@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <CAHC9VhTXgBTH+7ny-fcMP_HC1ojA1ass38PGHS2tJny0bCGXzA@mail.gmail.com>
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

On 4/26/22 11:57, Paul Moore wrote:
> On Mon, Apr 25, 2022 at 11:38 PM John Johansen
> <john.johansen@canonical.com> wrote:
>> On 4/18/22 07:59, Casey Schaufler wrote:
>>> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
>>> An example of the MAC_OBJ_CONTEXTS (1421) record is:
>>>
>>>     type=MAC_OBJ_CONTEXTS[1421]
>>>     msg=audit(1601152467.009:1050):
>>>     obj_selinux=unconfined_u:object_r:user_home_t:s0
>>>
>>> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
>>> the "obj=" field in other records in the event will be "obj=?".
>>> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
>>> multiple security modules that may make access decisions based
>>> on an object security context.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>  include/linux/audit.h      |  5 +++
>>>  include/uapi/linux/audit.h |  1 +
>>>  kernel/audit.c             | 47 +++++++++++++++++++++++
>>>  kernel/auditsc.c           | 79 ++++++++++++--------------------------
>>>  4 files changed, 77 insertions(+), 55 deletions(-)
> 
> ...
> 
>>> diff --git a/kernel/audit.c b/kernel/audit.c
>>> index 8ed2d717c217..a8c3ec6ba60b 100644
>>> --- a/kernel/audit.c
>>> +++ b/kernel/audit.c
>>> @@ -2226,6 +2226,53 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
>>>       ab->skb = skb_peek(&ab->skb_list);
>>>  }
>>>
>>> +void audit_log_object_context(struct audit_buffer *ab, struct lsmblob *blob)
>>> +{
>>> +     int i;
>>> +     int error;
>>> +     struct lsmcontext context;
>>> +
>>> +     if (!lsm_multiple_contexts()) {
>>> +             error = security_secid_to_secctx(blob, &context, LSMBLOB_FIRST);
>>> +             if (error) {
>>> +                     if (error != -EINVAL)
>>> +                             goto error_path;
>>> +                     return;
>>> +             }
>>> +             audit_log_format(ab, " obj=%s", context.context);
>>> +             security_release_secctx(&context);
>>> +     } else {
>>> +             audit_log_format(ab, " obj=?");
>>> +             error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
>>> +             if (error)
>>> +                     goto error_path;
>>> +
>>> +             for (i = 0; i < LSMBLOB_ENTRIES; i++) {
>>> +                     if (blob->secid[i] == 0)
>>> +                             continue;
>>> +                     error = security_secid_to_secctx(blob, &context, i);
>>> +                     if (error) {
>>> +                             audit_log_format(ab, "%sobj_%s=?",
>>> +                                              i ? " " : "",
>>> +                                              lsm_slot_to_name(i));
>>> +                             if (error != -EINVAL)
>>> +                                     audit_panic("error in audit_log_object_context");
>>> +                     } else {
>>> +                             audit_log_format(ab, "%sobj_%s=%s",
>>> +                                              i ? " " : "",
>>> +                                              lsm_slot_to_name(i),
>>> +                                              context.context);
>>> +                             security_release_secctx(&context);
>>> +                     }
>>> +             }
>>> +
>>> +             audit_buffer_aux_end(ab);
>>> +     }
>>> +     return;
>>> +
>>> +error_path:
>>> +     audit_panic("error in audit_log_object_context");
>>
>> This moves the audit_panic around, so certain operations are not
>> done before the call. I am currently not sure of the implications.
> 
> Short version: It's okay.
> 
> Longer version: The audit_panic() call is either going to panic the
> kernel (NOT the default), do a pr_err(), or essentially be a no-op.
> In the case of the full blown kernel panic we don't really care, the
> system is going to die before there is any chance of this record in
> progress getting logged.  In the case of a pr_err() or no-op the key
> part is making sure we leave the audit_buffer in a consistent state so
> that we preserve whatever information is already present.  In the
> !lsm_multiple_contexts case we simply return without making any
> changes to the audit_buffer so we're good there; in the multiple LSM
> case we always end the aux record properly (using a "?" when
> necessary) if an aux record has been successfully created.
> 
> Feel free to point out a specific scenario that you think looks wrong
> - I may have missed it - but I believe this code to be correct.
> 

mostly I am good, I was worried I was missing something since the old
code made an effort to have the call of audit_panic() at the end.

The current change does result in potential multiple calls to
audit_panic() in a single audit_log_exit(). This doesn't matter in
the case of a full blown kernel panic, but it could result in multiple
pr_err() messages where previously the code would only generate one.

It does simplify the code, and the case should be quite rare so I
am fine with the trade-off.



>>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>>> index 557713954a69..04bf3c04ef3d 100644
>>> --- a/kernel/auditsc.c
>>> +++ b/kernel/auditsc.c
>>> @@ -1420,18 +1409,10 @@ static void show_special(struct audit_context *context, int *call_panic)
>>
>> If pushing audit_panic into audit_log_object_context() is acceptable then this call_panic arg is
>> no longer needed. The same goes for the call_panic arg in audit_log_name(). And call_panic can
>> be dropped from audit_log_exit()
> 
> Good catch.
> 
> I suspect this is a vestige from when audit_log_end() used to do the
> record's skb write to userspace, meaning it was possible that you
> might get some of the records written to userspace before the system
> killed itself.  Now with all of the queuing involved it's less likely
> that this would be the case, and even if it does happen in some cases,
> it's basically a toss up depending on how the system is loaded, the
> scheduler, etc.
> 

