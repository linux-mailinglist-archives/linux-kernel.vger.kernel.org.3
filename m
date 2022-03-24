Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A6C4E6A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355288AbiCXWSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiCXWSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:18:36 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C80B6E7C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:17:02 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b43so3497435ljr.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PM3ucKwhvfkvF2Nl5Hbh/PREqeRskUbQ3y0OZLEytyc=;
        b=DsMNZxOJXP7mmXLU97e9EnCUy90/iZNAwHF33pAquu/Ky4C7i9EEezsfMrPspBOGeu
         d+qotrhHtIPIDuqRCJ6zaV59LioG7x9hmu2wtEAUyzUXS9eNo094xMc9zGu+dRBJm9pz
         teccZ/n03GN1gLCLba/NZyt6nf4q4pzxwDuvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PM3ucKwhvfkvF2Nl5Hbh/PREqeRskUbQ3y0OZLEytyc=;
        b=hrKDpce1YD3CoESa06JVQ1u5iC2yK9isJs5XtVIttry4Isv7MvNY34gKheenTCQkPn
         4A4sN7ZxK2X1VRSRbtnTdVF27fhZ/W4bMlGrDoVF7AG7412IkM2FMw/kk/Oe7NcGFLe6
         ibvn6OPE7ZPzARTfvNa3D2XnmchmHdST9UDopQkS8Aci1qj8u2WrXk8QZeoTsJywa4iK
         HqHQadpns1hmL91u9QGMZEsdoq2gtZxnUQPLxOUDzBkuppXk3IBwhnZejIBIhm2wl1LP
         fsEuhzfZzO87H8ptm4hsY9E1C6RdrXkqopgoAvj5rj4FIFAKsnEeQIo2O61wyi3yeTC2
         CXug==
X-Gm-Message-State: AOAM531LNzM3HRKezIgOGWHVgz5cUjyA5V7KLIvTxiNWZ52k4Wxjr3fp
        Z8DQN6p9L23140TCFe/1Rz4AJNNSzTfv76jvSfs=
X-Google-Smtp-Source: ABdhPJzjBcFtIEyWoKegK+dezovwswQODoymNHxqVcJKOnN4PA2DCY2rkFwbSgKghJJIRzqGXq6pxg==
X-Received: by 2002:a2e:80c2:0:b0:249:808b:590c with SMTP id r2-20020a2e80c2000000b00249808b590cmr5636571ljg.496.1648160220799;
        Thu, 24 Mar 2022 15:17:00 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id n13-20020a056512388d00b0044331f8f1f8sm477549lft.128.2022.03.24.15.16.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 15:16:59 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id w7so10422223lfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:16:59 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr5310974lfb.435.1648160218726; Thu, 24
 Mar 2022 15:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1644862280.git.legion@kernel.org> <877d8kfmdp.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wgBB8iPd0W=MQWnQJukMAPAqgsC0QX2wwiSvcct9zu_RA@mail.gmail.com> <87czib9g38.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87czib9g38.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Mar 2022 15:16:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvvHX8E2DP3WCwnPaOz8ViJDzfjNSBduP98W=L4+PN4A@mail.gmail.com>
Message-ID: <CAHk-=whvvHX8E2DP3WCwnPaOz8ViJDzfjNSBduP98W=L4+PN4A@mail.gmail.com>
Subject: Re: [GIT PULL] ipc: Bind to the ipc namespace at open time.
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 2:49 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I don't see how passing in struct cred does anything helpful.  The
> namespace can not be found in struct cred.

Duh. For some reason I thought we had it there, but yeah, that only
contains the user-namespace.

The rest is in tsk->nsproxy.

So it would have to be squirrelled away in some other way.

> But all of these cleanups I see are moving forward from the current
> point so I don't see why we would not want to merge the code as is
> and then get the tested versions of my cleanups below.

What part of "that code is too ugly to live" did not end up registering.

Maybe it can be cleaned up. But it had better be cleaned up before I pull it.

                Linus
