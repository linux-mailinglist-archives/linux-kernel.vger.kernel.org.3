Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685E84C4487
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbiBYMWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbiBYMWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:22:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 530001C2D95
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645791730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VHio/1j2ziq08MzsSjFM5LunsRNcq2NGF4pX47OZdHs=;
        b=fS8jEFRTuk3ASOZFPA+nE6QD21rBzAuVBumzkxegbyUBOpTd0jSHKe9wUH63RHCZagx91U
        hdpXrUzLH7Wz+G4ipA57yhqXk9CZFzUKnxgi1+jbGY9Opr7UWsyQ4Uzhe+pRI8z5wC+aPy
        HAVXm8XV60iqKOE9kbrEQJziqkJszX8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-GA-tjV9oOb-1Xi7SYSC70w-1; Fri, 25 Feb 2022 07:22:09 -0500
X-MC-Unique: GA-tjV9oOb-1Xi7SYSC70w-1
Received: by mail-lf1-f72.google.com with SMTP id m18-20020a0565120a9200b004439214844dso963982lfu.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHio/1j2ziq08MzsSjFM5LunsRNcq2NGF4pX47OZdHs=;
        b=HNb4WbD6DWAkhYbNkhZHpL3VVtvAYcfpOabRo6pnJ3fBFD9pyOKNRSsoTig9MfaUwE
         DrF3yGxphagfwEizoh55RY4MqN5Lf8XPXc3AidswXkY5uE9Aorgshd11RqYbjA4WUU1p
         jgW/6fxrLseVkivbXpk1y6p1N17j9b3jKBDFDiZ9Iflj7dDwgG3TOxeAr/lNFtyXMgOw
         miL5GhpLKVXvZYoDDe4ixQqtkfKSIxrj+IkSIrXaCBvtFWazKBsl8ORkdyxt+drIfcFP
         w5oJtDYPbKW5HCyieElm9BRunJHXX7d4l4pcLTMKvjDiPW7ZP+/1ojPuqXNJMlAjlozr
         DPNA==
X-Gm-Message-State: AOAM533RUuuK5OG4VgKAFzSjG8fyxcz6GbpC3DxV3F1wrQqIVD+RFZ3U
        KXOO0l+fDE6WzfPpNqbO//GZOWwDqZ7Ndb1nPMJBMvB0SJFGdtxw/EUDTB+YUd08KpS5RaVD7qs
        ia5Zge2JGCINARo36EMWnSi1EX9zVaxR48yWpH7U=
X-Received: by 2002:a2e:b16e:0:b0:244:d368:57e with SMTP id a14-20020a2eb16e000000b00244d368057emr5187121ljm.251.1645791727722;
        Fri, 25 Feb 2022 04:22:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3HvejCFFVDV/Is5Nh4FGZXaP/OD9uoaM1fdabwy6Q5yZ3jWKafxfzdgQGsMk5Ag8w8Nh80L8EiCcBY327m4E=
X-Received: by 2002:a2e:b16e:0:b0:244:d368:57e with SMTP id
 a14-20020a2eb16e000000b00244d368057emr5187099ljm.251.1645791727486; Fri, 25
 Feb 2022 04:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20220222141303.1392190-1-atomlin@redhat.com> <20220222141303.1392190-10-atomlin@redhat.com>
 <YhieKf9EcS3GQSXG@alley> <f9449aa6-be9d-9021-66e7-fb0272909ee7@csgroup.eu>
 <YhisWkgZCK8dz5fl@alley> <CANfR36gsRw26C3M0hXGGK2w_05pC0rzkhg0-3Q+8tr_XxLiqiw@mail.gmail.com>
In-Reply-To: <CANfR36gsRw26C3M0hXGGK2w_05pC0rzkhg0-3Q+8tr_XxLiqiw@mail.gmail.com>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Fri, 25 Feb 2022 12:21:56 +0000
Message-ID: <CANfR36iKJ6pHU5gm3HKqTPZ=FGsC5qX316UKt2sN0aMFEODA9w@mail.gmail.com>
Subject: Re: [PATCH v8 09/13] module: Move kallsyms support into a separate file
To:     "mcgrof@kernel.org" <mcgrof@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-02-25 10:27 +0000, Aaron Tomlin wrote:
> On Fri 2022-02-25 11:15 +0100, Petr Mladek wrote:
> > rcu_dereference_sched() makes sparse happy. But lockdep complains
> > because the _rcu pointer is not accessed under:
> >
> >     rcu_read_lock_sched();
> >     rcu_read_unlock_sched();
>
> Hi Petr,
>
> >
> > This is not the case here. Note that module_mutex does not
> > disable preemtion.
> >
> > Now, the code is safe. The RCU access makes sure that "mod"
> > can't be freed in the meantime:
> >
> >    + add_kallsyms() is called by the module loaded when the module
> >      is being loaded. It could not get removed in parallel
> >      by definition.
> >
> >    + module_kallsyms_on_each_symbol() takes module_mutex.
> >      It means that the module could not get removed.
>
> Indeed, which is why I did not use rcu_read_lock_sched() and
> rcu_read_unlock_sched() with rcu_dereference_sched(). That being said, I
> should have mentioned this in the commit message.
>
> > IMHO, we have two possibilities here:
> >
> >    + Make sparse and lockdep happy by using rcu_dereference_sched()
> >      and calling the code under rcu_read_lock_sched().
> >
> >    + Cast (struct mod_kallsyms *)mod->kallsyms when accessing
> >      the value.
>
> I prefer the first option.
>
> > I do not have strong preference. I am fine with both.
> >
> > Anyway, such a fix should be done in a separate patch!
>
> Agreed.

Luis,

If I understand correctly, it might be cleaner to resolve the above in two
separate patches for a v9 i.e. a) address the sparse and lockdep feedback
and b) refactor the code, before the latest version [1] is merged into
module-next. I assume the previous iteration will be reverted first?

Please let me know your thoughts

[1]: https://lore.kernel.org/all/20220222141303.1392190-1-atomlin@redhat.com/


Kind regards,

-- 
Aaron Tomlin

