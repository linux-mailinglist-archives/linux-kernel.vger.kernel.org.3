Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520E051DB3C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442510AbiEFO7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347628AbiEFO7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:59:30 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F49252E43
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:55:47 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso84160497b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pp55vxmPCAUyGS9+i2Vpi8qxPfkHgsDwJp+6fIOUpY=;
        b=gqcLFW8EQ+zj/9mfBFDf8TzFEi8yeVG/wiBbHRB0MtXZKyJ0I0zCN4kgc1c+FraW06
         WuvUgrZqiUs/OoXieksQoJgXZuA8juePQU3a4zBBZjrTXXN+dFpp0OtFOfgHlaC2nkR9
         VP6R028QlD4ioRpQzVibivh907HHVfmofuXIX15tw5khIXrljY+9lEmJhszJBieGv8Wx
         PNIGCzciu8xBSEoqtmNBiVkzmqKrmN5xXhiRXawgzYmqfGsI1v58D5BgnqwkOKKDyLoz
         YWMdjfsVkMUea2b7TJUfbY0JBm3TxGqmwyNoMe5+uOCWS/K1es7UUzXPgEOQjWPlwMrd
         E9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pp55vxmPCAUyGS9+i2Vpi8qxPfkHgsDwJp+6fIOUpY=;
        b=KSP+Byqy00SHLVMdJ3/FtN3ygoY9JMloW9E6ar1heHcJMQHEDMPeOa53DD/1sDkFoW
         DZI4KB30FqPVhX4Aj851tVNo/pXeByieYjXi/DikpFRZcanEq6tV/RnAePHLG8qqP8N+
         Huhk3y/ev3pNMh29wF65iLsII2FX27ykHIPT72CT+2yf845H0FcKsc3oNzOEwHQHNa0k
         mRuLGJPnPBO9w5n2JshzU40J351X6S+GeCONdeSPH2ZjE95k6kHRtAc0GsxrtD3Dk3OY
         f6v5myQnRJ5DApvd6A16Gt61O0N7G4VOSecsR5YgRNeADFD5rzIstDuCueJh6hadJ1Nr
         1Sow==
X-Gm-Message-State: AOAM532Ow58eC0jUSMXYMGVSR2UgoUFpOuRl8qpnytldmpde/LIiR2tR
        3y5Yl77MTbNhUnioblO4h4Ptr0uRwgPgHFvOL8zQrg==
X-Google-Smtp-Source: ABdhPJz52eG9BPda4INhSRMSdrAVTQhprZ+2WR/4eOPO8OchkeBd5UweFNGKmopmDs+qlSn7x9QvFNBuAu3yV0f9Y08=
X-Received: by 2002:a81:7d46:0:b0:2f8:f29:c9ea with SMTP id
 y67-20020a817d46000000b002f80f29c9eamr2950362ywc.362.1651848946371; Fri, 06
 May 2022 07:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220503073844.4148944-1-elver@google.com> <87r15ae8d7.fsf@jogness.linutronix.de>
 <20220504094636.GA8069@pathway.suse.cz> <YnU113/cOtv7k9tH@alley>
In-Reply-To: <YnU113/cOtv7k9tH@alley>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 May 2022 16:55:10 +0200
Message-ID: <CANpmjNMD3ugyUFDHVqEDCFg6cAQSYpStQUo_ixGsC4DxZC15vg@mail.gmail.com>
Subject: Re: [PATCH -printk] printk, tracing: fix console tracepoint
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2022 at 16:51, Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2022-05-04 11:46:36, Petr Mladek wrote:
> > On Tue 2022-05-03 21:20:44, John Ogness wrote:
> > > On 2022-05-03, Marco Elver <elver@google.com> wrote:
> > > > One notable difference is that by moving tracing into printk_sprint(),
> > > > the 'text' will no longer include the "header" (loglevel and timestamp),
> > > > but only the raw message. Arguably this is less of a problem now that
> > > > the console tracepoint happens on the printk() call and isn't delayed.
> > >
> > > Another slight difference is that messages composed of LOG_CONT pieces
> > > will trigger the tracepoint for each individual piece and _never_ as a
> > > complete line.
> > >
> > > It was never guaranteed that all LOG_CONT pieces make it into the final
> > > printed line anyway, but with this change it will be guaranteed that
> > > they are always handled separately.
> > >
> > > I am OK with this change, but like Steven, I agree the the users of that
> > > tracepoint need to chime in.
> >
> > My feeling is that the feature is not used much. Otherwise people
> > would complain that it was asynchronous and hard to use.
> >
> > I mean that the printk() messages appeared in the trace log
> > asynchronously. So it required some post processing to correctly
> > sort them against other tracing messages. The same result can be
> > achieved by processing printk log buffer, dmesg.log, journalctl.
> >
> > I guess that we will only find the answer when we push the change
> > into linux-next and mainline. I am going to do so.
>
> JFYI, the patch has been committed into printk/linux.git,
> branch rework/kthreads.

Thank you, sounds good.

Thanks,
-- Marco
