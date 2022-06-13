Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C63854A2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 01:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiFMXmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 19:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbiFMXmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:42:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7EF31DF5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 16:42:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso4392580pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 16:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=bmrcJZovwOahuZ1zD4ESe7f2j1QrpBL8ylumdbuHvxM=;
        b=JpnraQXZnpUfWzMpojVP52aPPWRi1HOd/1ci9yX3oG34IdnyRRtTH7R4p0qPi/umoK
         c2++crrRW/6CTVRFlcca0rJ2mpjmDSkzpqlkaqvCy0ijyX4xrhjcYn0uDteDgQhczafU
         Z7QswHZXgnS+JX5EIrmk7HPkPMOq3+md/E5D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=bmrcJZovwOahuZ1zD4ESe7f2j1QrpBL8ylumdbuHvxM=;
        b=NfVz9dOCBbCX6hedlEeBJA5WXaefUASGqluvpe4cEIyDPYuuYmUN/SBuL/D1FXt9F1
         Xchsm1ZlYJWLoJRa1NbcLj3m1JHlJOHURPPz7ronrDL7jZE3SD+6Ifk5HFZsDzrH9WDe
         3ACW0bhWhDrki1zs9N7lGo/hX8Zp3noHyDpNaJkaHV+Ff1lXOA2NXWrc9HKVN4f4ex9Y
         33wSSSvXC0Yt1YHWio/0EAHdb6Gz7j0x6JyfKFiSHr6+G3krUP37B4bWvGnQci6o5VDI
         yqQFPfXsf1V1WdQeQCiMSyLskhs8HjGhdJSyOfpLblAEtLK4A7xkWFu/IfCSdpCaSEVm
         DNNA==
X-Gm-Message-State: AJIora9ldOkvNBZbUzQg9t6K0qpoB11qfsk/pcXsH1bDyVHSP9tWZHoH
        sum0V9dBihCUiYp9UCUTDcoTeQ==
X-Google-Smtp-Source: AGRyM1vNtmO+ZaBmD09AkfcwSGSZqhC7FRvmhR4OAGa46dyO/rvDxYq3/5shTCS837L83KdspeVQaw==
X-Received: by 2002:a17:903:120b:b0:168:98a9:221f with SMTP id l11-20020a170903120b00b0016898a9221fmr1445911plh.48.1655163728548;
        Mon, 13 Jun 2022 16:42:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b13-20020a6541cd000000b003c25dfd7372sm6225255pgq.26.2022.06.13.16.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 16:42:08 -0700 (PDT)
Date:   Mon, 13 Jun 2022 16:42:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] WARNING in exit_tasks_rcu_finish
Message-ID: <202206131639.DBA0A8D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613233753.GK1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:36:07AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com

Looks like the patch solved the reproducer. :)

> Tested on:
> 
> commit:         6d0c8068 Add linux-next specific files for 20220610
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20220610
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d068eff00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a30d6e3e814e5931
> dashboard link: https://syzkaller.appspot.com/bug?extid=9bb26e7c5e8e4fa7e641
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=147f47c8080000
> 
> Note: testing is done by a robot and is best-effort only.

You can see the dashboard link above for testing details...

-- 
Kees Cook
