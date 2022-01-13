Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D0348DAA8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbiAMPX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiAMPX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:23:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDC0C06161C;
        Thu, 13 Jan 2022 07:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IroWz2/lM7Wq0zfZupLorZG/7/LWfldXQbXxbQlA8Zo=; b=zSJUQV9UpMMjJNxsSi4fjJ59PG
        qGNTgLClbYM1tS87UTuQnTvrDdyx/zSJzyMEgLPVIIYA0GUibORV3EDbV5W8vHEPiiq5ZFuyftRck
        0Mm94CgabVsErdZzpLwnM4Fad+C22x4DNDjSZVpSM8GKPCiQMAKOk7RhkpuYLW4Dw+nAPClWkF2GH
        vFRLDlwXW2d+wTk1SuiYjpaBd8+L6+oHLvk86tGBLDuv77YSQ8axhMySRb64DrqUgVkthyxta+jec
        I+qli+DtARmzxaRSUoWAaETLFFov2p3nQtu2H2dwiQ+iKaCY9u3/3xD93d3S5TyOyXd7aJ+CiBGin
        C0QMRylA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n81x3-006NZ6-7T; Thu, 13 Jan 2022 15:23:45 +0000
Date:   Thu, 13 Jan 2022 07:23:45 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vimal Agrawal <avimalin@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Vimal Agrawal <vimal.Agrawal@sophos.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/module.c: heuristic enhancement when
 INSTALL_MOD_STRIP= "--strip-unneeded" is used
Message-ID: <YeBEAavbBh/MnbEF@bombadil.infradead.org>
References: <YcJZWiQ407ZxMM+y@bombadil.infradead.org>
 <20211222132332.7817-1-vimal.agrawal@sophos.com>
 <YcRRQCMZFepB/hzX@infradead.org>
 <CALkUMdRxTm6STT4CncTuvQ9hM_bez+B91TsuenEj71KPxFgMsg@mail.gmail.com>
 <YcVtG26b/sO9k7ox@infradead.org>
 <CALkUMdSY3XCHqhH9dDQ+0VHykv9AiBiqLgoC+cj5P=9Q1jdXrg@mail.gmail.com>
 <Yd2nJZRtc3OjPb0w@bombadil.infradead.org>
 <CALkUMdSc8eNbqptTihwzqhpL9qhGS0xUFr=AFXs3COvpyBoQiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALkUMdSc8eNbqptTihwzqhpL9qhGS0xUFr=AFXs3COvpyBoQiw@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 02:06:48PM +0530, Vimal Agrawal wrote:
> On Tue, Jan 11, 2022 at 9:19 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > Yes but the point here is the heuristic you are adding for
> > when "--strip-unneeded" is used is now *always* being used and
> > we have no way of knowing this. So I'd agree with Christoph that
> > if we want to support this it might make sense to make a kconfig
> > option for enabling "--strip-unneeded" and then another for this
> > heuristic.
> 
> This heuristic is applicable to any case when an address inside a
> module can not be decoded to any known symbol. e.g. 

You mean it is safe for that case too? If so can you add this to the
commit log as well?

> anyone can still
> build with ----strip-all though module load fails with this option.
> but one can add or remove symbols manually or use objcopy or some
> other utility to play with symbols. It does not matter for
> functionality much if symbols are available or not and it is just that
> symbol decodes in traces are not providing help as it displays
> absolute address in such cases.
> 
> There are several options in strip command and we can't have kconfig
> for each such option. 

This is a good point. Pointing out it is safe regardless of the
situation in the commit log I think does this heuristic more justice.

Can you resend with that being clarified? I'll still have to test this.
Can you also use the modules-next tree? I'll still have to test this.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ branch modules-next

  Luis

> All options are supported currently unless the
> module is so broken that it can even be loaded ( e.g. --strip-all
> option).
> 
> Vimal
