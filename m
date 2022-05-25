Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7495E533CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiEYMeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiEYMeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82A6A6D86D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653482073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dZGXxdZ7tk8tkrHfmyTzdFzGCEzgfGnHH7oqrpOvqY8=;
        b=UOJuFw23RUq7Mo++cCawrPbN/HQgFVB2kknMd0LW9lHcCBJJnnLEKxFYMiSwBXblhcZing
        NyEBIKhgGYhbnpfbgHwr4xXl/7FaCHiulxIQtt8S8C0UMhLkpenPfHQAsx8/tIKI8z/quN
        aB19wXZ+Yj+1XzGoWbHg+lEhcEkogDc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-b6UfAjneObOWEtu-Guopfg-1; Wed, 25 May 2022 08:34:32 -0400
X-MC-Unique: b6UfAjneObOWEtu-Guopfg-1
Received: by mail-wr1-f70.google.com with SMTP id d15-20020adf9b8f000000b00210014d2b41so337779wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dZGXxdZ7tk8tkrHfmyTzdFzGCEzgfGnHH7oqrpOvqY8=;
        b=UAGtPfZriJo7OmSik+c7ff58Uf7EbK0nKQ7X5acx/bsmgKMy8ia1wToWq0/8N463Ai
         PHxax8uapMa6Dv0XULBsFUYQTj/38swQoXKmSjp86rOQJ3sPK3UN4bIAg5kEI1GPrQLQ
         N/5/otp8+cVl544ujtKsFZ/7xpb1CcemM1G9/XSh6m1zkpmADWC+hZydN1yCTvSQEsJT
         cJ+sv8rAIFiDSZ/+YDACndgDlrwizrGb6rhWh84aiNmPy+nM2U6lSQXmc55Mf7Z6eews
         bZ+DOWMZyCgJ+0r9oQJIACumdvE06gl5oYyijZ0YvGdssS/tIetU31YDgNIhuWND3dl2
         qcxQ==
X-Gm-Message-State: AOAM5313pZHhdVg9mHqTjU5P2zrOZqKQ/QaHIm6slbvwOmnOtz/6nh5m
        SAE3g6lt3S1sHayyhlfzHFWYlNrwvBmdCZ5/9neoL22dTecPYaBn7ClvbnofEqYw7FwGXNKu72R
        0dQmD1dL50vU1nUP2e/JZQ06r
X-Received: by 2002:a05:6000:71b:b0:20e:ed96:e976 with SMTP id bs27-20020a056000071b00b0020eed96e976mr21854184wrb.500.1653482071226;
        Wed, 25 May 2022 05:34:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykx3yMTwjG5lBRj3vNlIPcymLsygIlNLZZd+F2+kNfTn+zjPibsb40mx/dpIiFL18gmKhY6g==
X-Received: by 2002:a05:6000:71b:b0:20e:ed96:e976 with SMTP id bs27-20020a056000071b00b0020eed96e976mr21854168wrb.500.1653482070962;
        Wed, 25 May 2022 05:34:30 -0700 (PDT)
Received: from [10.128.38.70] ([141.113.64.80])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c500700b00395f15d993fsm2073759wmr.5.2022.05.25.05.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 05:34:30 -0700 (PDT)
Message-ID: <e5ff5023-c3e7-769b-33b0-2c4b376bc4d2@redhat.com>
Date:   Wed, 25 May 2022 14:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.19-1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <13e61c61-0d4b-5f48-6373-f056bf8b603f@redhat.com>
 <CAHk-=wgV8zqiLi5p-SNZ2zSi95CkkFXqPZJjtneVXeobgAohJg@mail.gmail.com>
 <f39aa9c0-b4e6-1f5d-f556-643442fcbcc5@redhat.com>
 <CAHk-=wgNP+Dziv=4MDEf-wAW-U_0ZNNsL0gMDs7A46+CACgD4w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHk-=wgNP+Dziv=4MDEf-wAW-U_0ZNNsL0gMDs7A46+CACgD4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/24/22 19:17, Linus Torvalds wrote:
> On Mon, May 23, 2022 at 11:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> I did do a "git remote update origin" recently (recent-ish), but
>> AFAIK that does not help.
> 
> Hmm. Did you pass in 'origin' to git request-pull too?
> 
>> I did read somewhere that in cases like this some maintainers
>> create a branch with a merge of their for-next branch [..]
> 
> No, that's only necessary for when the branch has merges and can have
> multiple merge bases as a result - that will make 'git diff' unable to
> find an unambiguous place to start the diff from (see
> Documentation/maintainer/messy-diffstat.rst for the details).
> 
> But your tree doesn't have that issue, and you can also see the old
> commits in your shortlog (and the "messy diffstat" is _only_ about the
> diff, not about the commit list). And you can see the same effect in
> the shortlog, ie I merged your earlier fixes pull request  in commit
> 9be9ed2612b5 ("Merge tag 'platform-drivers-x86-v5.18-4' of
> git://..."), and it already had
> 
>     * tag 'platform-drivers-x86-v5.18-4' of
> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/pla>
>       platform/surface: aggregator: Fix initialization order when
> compiling as builtin module
>       platform/surface: gpe: Add support for Surface Pro 8
>       platform/x86/intel: Fix 'rmmod pmt_telemetry' panic
>       platform/x86: thinkpad_acpi: Correct dual fan probe
>       platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a
> number of laptops
>       platform/x86: thinkpad_acpi: Convert btusb DMI list to quirks
> 
> but notice how your pll request had those commits listed again (ie it
> had, for example:
> 
>   Maximilian Luz (2):
>         platform/surface: gpe: Add support for Surface Pro 8
>         platform/surface: aggregator: Fix initialization order when
> compiling as builtin module
> 
> in there).

Right, that is a result of my standard workflow which goes like this:

1. After v5.18-rc1 fast-forward both my for-next and fixes branches
to v5.18-rc1

2. Merge new patches into for-next

3. If there are fixes cherry-pick them from for-next into my fixes
branch

4. Send a couple of fixes pull-req from the fixes branch to you
during the cycle

5. run:

git tag -s platform-drivers-x86-v5.19-1 for-next
git request-pull v5.18-rc1 git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git platform-drivers-x86-v5.19-1 > pull

Open pull file in editor and use it in my pull-req email.


Which AFAIK is a pretty standard workflow; and AFAIK there is
no way to avoid the double listing of fixes already merged
in both the shortlog and the diffstat in the pullreq.

I welcome any suggestions to improve the above workflow.

> And while merges can confuse the diffstat, the actual commit list
> doesn't care: it does a proper set operation, and having multiple
> merge bases doesn't matter.
> 
> This all is not a huge deal - I figured out what was going on, so it
> wasn't a problem.
> 
> I just mentioned it because that whole "Linus figures it out" does
> take some time and effort, and I'm really really lazy and much prefer
> to just do the pull and look at the result and go "Yeah, looks good"
> and go on to the next one...

I understand and if there is a way to make your life easier I'm
all for it.

Regards,

Hans

