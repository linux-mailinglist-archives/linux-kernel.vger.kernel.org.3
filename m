Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8D52DED7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244944AbiESU6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244928AbiESU6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:58:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03558EC3D8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:58:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y13so11417969eje.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7n9soc+YeiEuDs+/wVe5880ZbNB6SfvRzmD9yZCDg0=;
        b=DBEkcJxwMHgrSW6HcJcRibGMLRAHktxTfe210zz70+cSSKn6ZpUgiva+kk1wpf11Zn
         AEG+Mgw1hd0KW2hE0Q1vG6WOtJs0wkwyzpBg39QhS4doVKGMJsExBp8t3Mh2Q11oNnXz
         Uj83mLI19GvO9WWx9wIiJ6kgKwKQLuX9IR+/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7n9soc+YeiEuDs+/wVe5880ZbNB6SfvRzmD9yZCDg0=;
        b=PXh0koqGFTRNsrj1tkehHhnnVtIC9lBCE46sQX/0xaF3IHeZql0nSUD8qidxeVaadt
         B8ML1YzyauJ2ADyHKkyP6IwDTTnyMM97Tj9zzzjFNSSNYRJWwrXDJcDNFccW9WkCFAwZ
         PM/ZQJn8+BExEtIhNtA6ipXTwXUutVsC57lw1rZhfOc3IEZPMPxwq9vUHtZTy2M2St8i
         SIQR+mTc/7iTRVO06IPRHklQOKEyCXsTZ2zEjAR1JpMhlsdLfZcZmF6TSBLxJ4Br/fbu
         v0yRuCa2TukXu40cHRfJdqTaPPY6g5GBs28CE7qpISr0HJ7VGIGZa2tH0SZxEpKsfngl
         wMXg==
X-Gm-Message-State: AOAM532OiYEpHpan8fZLJfQ1FGQ+LBk3uprEYsVPhgldeeD2LtCg2Mdn
        BqkQQEo69GaEDC0hzPbOdly0j8zjSuT5bIqN9zk=
X-Google-Smtp-Source: ABdhPJz5AkiaoJxGZwErtSZtLfDLHnOFbeYUt+eZFmpa6DnBxoFucatvMNS5lfKH46EZBQfBo6bXWQ==
X-Received: by 2002:a17:907:6daa:b0:6f4:4822:549d with SMTP id sb42-20020a1709076daa00b006f44822549dmr6262834ejc.322.1652993885193;
        Thu, 19 May 2022 13:58:05 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906224400b006f3ef214da7sm2496448ejr.13.2022.05.19.13.58.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 13:58:04 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id j24so8811899wrb.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:58:04 -0700 (PDT)
X-Received: by 2002:a05:6000:2c1:b0:20c:5e37:3ed1 with SMTP id
 o1-20020a05600002c100b0020c5e373ed1mr5575002wry.342.1652993554192; Thu, 19
 May 2022 13:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org> <20220518225355.784371-3-ebiederm@xmission.com>
In-Reply-To: <20220518225355.784371-3-ebiederm@xmission.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 19 May 2022 13:52:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UFK7h0oHGJ23y37ShO+z4vt9ubGE9E4m=jMECgNAAHgA@mail.gmail.com>
Message-ID: <CAD=FV=UFK7h0oHGJ23y37ShO+z4vt9ubGE9E4m=jMECgNAAHgA@mail.gmail.com>
Subject: Re: [PATCH 03/16] kdb: Use real_parent when displaying a list of processes
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 18, 2022 at 3:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> kdb has a bug that when using the ps command to display a list of
> processes, if a process is being debugged the debugger as the parent
> process.
>
> This is silly, and I expect it never comes up in ptractice.  As there
> is very little point in using gdb and kdb simultaneously.  Update the
> code to use real_parent so that it is clear kdb does not want to
> display a debugger as the parent of a process.

So I would tend to defer to Daniel, but I'm not convinced that the
behavior you describe for kdb today _is_ actually silly.

If I was in kdb and I was listing processes, I might actually want to
see that a process's parent was set to gdb. Presumably that would tell
me extra information that might be relevant to my debug session.

Personally, I'd rather add an extra piece of information into the list
showing the real parent if it's not the same as the parent. Then
you're not throwing away information.

-Doug
