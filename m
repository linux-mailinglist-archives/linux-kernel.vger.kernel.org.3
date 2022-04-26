Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E335108A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354198AbiDZTLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354063AbiDZTKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:10:52 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E68D3B2BB;
        Tue, 26 Apr 2022 12:07:38 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 82A363FD0A;
        Tue, 26 Apr 2022 19:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1651000056;
        bh=HPxmSK5Le3qsa+l2VTTCM7colhsO1wQuYMTZrz1Rts0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=fp+qrwHvrE1agHdpm/r8T9Eh9E2o+3NHdX1otpm/RkbLBI4gjnphrOdLeRrlSm7SG
         za1js7pN5n9ZzLUfH67vmUVuxs95XN4q3isEXG6K/x/oAbghjkih13QflnB4Xr6UA8
         MgfJLvPJ4OAEBxuKruw3vtRoriPHGlcVePWt9TjrNH40TCFX+a+X6KHvb0qD2hJove
         a+WdFFliafhGMl8WWlBEFqEq56Tg+D6uTp3Ad8FTlz8RKnPrXdTwSOBKTZ2engG2I5
         OgQOZScgbD+xyfT2Q9FQlKEpSlBU7gWNqL55NRRiUlOumLbNa1C1vB80hEyXXpzZgi
         7KEOjgAdRk+lQ==
Message-ID: <4b21a4f0-4b53-2fee-4ea0-c21b95279b1d@canonical.com>
Date:   Tue, 26 Apr 2022 12:07:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 26/29] Audit: Add record for multiple task security
 contexts
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-27-casey@schaufler-ca.com>
 <ad1e85e1-8706-7b93-59cd-99ccef273be4@canonical.com>
 <CAHC9VhS0ht0wWtruDjVvOsy_1LOCswF0kjmd9u8XZXm00jHvOw@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <CAHC9VhS0ht0wWtruDjVvOsy_1LOCswF0kjmd9u8XZXm00jHvOw@mail.gmail.com>
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

On 4/26/22 11:15, Paul Moore wrote:
> On Mon, Apr 25, 2022 at 9:08 PM John Johansen
> <john.johansen@canonical.com> wrote:
>> On 4/18/22 07:59, Casey Schaufler wrote:
>>> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
>>> An example of the MAC_TASK_CONTEXTS (1420) record is:
>>>
>>>     type=MAC_TASK_CONTEXTS[1420]
>>>     msg=audit(1600880931.832:113)
>>>     subj_apparmor=unconfined
>>>     subj_smack=_
>>>
>>> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
>>> the "subj=" field in other records in the event will be "subj=?".
>>> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
>>> multiple security modules that may make access decisions based
>>> on a subject security context.
>>>
>>> Functions are created to manage the skb list in the audit_buffer.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>
>> Besides moving the aux fns, and the whining below
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
> 
> ...
> 
>>> diff --git a/kernel/audit.c b/kernel/audit.c
>>> index 4d44c05053b0..8ed2d717c217 100644
>>> --- a/kernel/audit.c
>>> +++ b/kernel/audit.c
>>> @@ -2185,16 +2238,44 @@ int audit_log_task_context(struct audit_buffer *ab)
>>>       if (!lsmblob_is_set(&blob))
>>>               return 0;
>>>
>>> -     error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
>>> +     if (!lsm_multiple_contexts()) {
>>> +             error = security_secid_to_secctx(&blob, &context,
>>> +                                              LSMBLOB_FIRST);
>>> +             if (error) {
>>> +                     if (error != -EINVAL)
>>> +                             goto error_path;
>>> +                     return 0;
>>> +             }
>>>
>>> -     if (error) {
>>> -             if (error != -EINVAL)
>>> +             audit_log_format(ab, " subj=%s", context.context);
>>> +             security_release_secctx(&context);
>>> +     } else {
>>> +             /* Multiple LSMs provide contexts. Include an aux record. */
>>> +             audit_log_format(ab, " subj=?");
>>
>> just me whining, you sure we can't just drop subj= here
> 
> Have I recently given you my "the audit code is crap" speech? ;)
> 
hehehe, I get it, something about glass houses and stones. the whole newline
mess in path 28/29 that I would dearly love to drop.

> I more or less answered this with my comments on the earlier patch,
> but we need to keep this around for compatibility.  It will get better
> in the future.
> 

