Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACF35107C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344152AbiDZTBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiDZTBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:01:45 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB47E1816F3;
        Tue, 26 Apr 2022 11:58:36 -0700 (PDT)
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 606693F629;
        Tue, 26 Apr 2022 18:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650999513;
        bh=SijHfl909+3nAhB2Ih9fpMfp4ulzFmQliribD1iJddM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZnMlnIH4hgHybakIbtsTfMBO2NqMUT23MMBmS447Z3ar6smKvH1dxvYSSuRfO6bsT
         PBqxFUVrhVf6lwAezn4+XLeuXoDjP9przo3w56qo7Hm7vr4HigJZOyIvUgfCQaN+Ia
         OvmepiWL+jxrFwjFOMKaoJNcFQWhQv3QkRHvmF1Wei73FAb6G8Xbj6kmkcmb1mBki0
         b/dG1mZRZbUGCMIiKGad0/przYPwnXrcp7C8PgJGZjKQl+arn5W06zX28+WKKiXgg6
         EWTLA9G4f9gvhPFxTE4TGtwcKm0pce+HILOuSXJC5FE/tkoCK5/43RpusJWZ0YeEU3
         Je7MddZgtLhpg==
Message-ID: <26eca0aa-111a-9473-8925-e4b12cadbd79@canonical.com>
Date:   Tue, 26 Apr 2022 11:58:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v35 23/29] Audit: Create audit_stamp structure
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-24-casey@schaufler-ca.com>
 <a1702622-5980-1eb4-1cf8-b6fc6cd98b25@canonical.com>
 <CAHC9VhRzJKAARW1rnUMu0Y6RVo_uq=i=Jzh4LmA9grtQ1W2C1Q@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <CAHC9VhRzJKAARW1rnUMu0Y6RVo_uq=i=Jzh4LmA9grtQ1W2C1Q@mail.gmail.com>
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

On 4/26/22 11:03, Paul Moore wrote:
> On Mon, Apr 25, 2022 at 7:31 PM John Johansen
> <john.johansen@canonical.com> wrote:
>> On 4/18/22 07:59, Casey Schaufler wrote:
>>> Replace the timestamp and serial number pair used in audit records
>>> with a structure containing the two elements.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> Acked-by: Paul Moore <paul@paul-moore.com>
>>> ---
>>>  kernel/audit.c   | 17 +++++++++--------
>>>  kernel/audit.h   | 12 +++++++++---
>>>  kernel/auditsc.c | 22 +++++++++-------------
>>>  3 files changed, 27 insertions(+), 24 deletions(-)
> 
> ...
> 
>>> diff --git a/kernel/audit.h b/kernel/audit.h
>>> index 4af63e7dde17..260dab6e0e15 100644
>>> --- a/kernel/audit.h
>>> +++ b/kernel/audit.h
>>> @@ -108,10 +114,10 @@ struct audit_context {
>>>               AUDIT_CTX_URING,        /* in use by io_uring */
>>>       } context;
>>>       enum audit_state    state, current_state;
>>> +     struct audit_stamp  stamp;      /* event identifier */
>>>       unsigned int        serial;     /* serial number for record */
>>
>> shouldn't we be dropping serial from the audit_context, since we have
>> moved it into the audit_stamp?
> 
> Unless we make some significant changes to audit_log_start() we still
> need to preserve a timestamp in the audit_context so that regularly
> associated audit records can share a common timestamp (which is what
> groups multiple records into a single "event").
> 
sure, but the patch changes things to use ctx->stamp.serial instead of
ctx->serial. Eg. in audit_reset_context() we have

-	ctx->serial = 0;
+	ctx->stamp.serial = 0;

I don't see a reason why we need both ctx->serial and ctx->stamp.serial
