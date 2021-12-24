Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF99947EC3B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 07:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343518AbhLXGsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 01:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhLXGsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:48:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B25C061401;
        Thu, 23 Dec 2021 22:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=aNK0QUdexJ+kRgB+i3vf9HVKEuQOqBN6P2TycATdPsk=; b=WhaFslx7HqTY91sXHE9t0kpF03
        F7dmblQhF9onaIX36ER27pRpZ2XU3o+AZQ9AtzZJcTjc2uFFD2kpW3qDeR2g+6UXJ03xCfrwDsPRp
        6FDbgyvG7HW89GpY04paPpc3WWQ4SXYWSgsQvIUUOO7eJGkPqBsBYYHNZmicLZs1jE7EFMik0MrSB
        tq8wbFZzqhS1kN9TF/9PihhK+gwOuvBXZM7XreMIVSEQL1RxrUuEFTUxshlNU+kxhXFn6+MUvRy/S
        bvk+o+rmx9zwqBKV5UPRDGsKHWV86Abg0efutnrAPaEv6G43Mk0pYrRO098LTTmDVLjT4XmBYF8es
        v4fb/Bnw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0eMt-00DoS6-Op; Fri, 24 Dec 2021 06:47:55 +0000
Date:   Thu, 23 Dec 2021 22:47:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vimal Agrawal <avimalin@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Vimal Agrawal <vimal.Agrawal@sophos.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/module.c: heuristic enhancement when
 INSTALL_MOD_STRIP= "--strip-unneeded" is used
Message-ID: <YcVtG26b/sO9k7ox@infradead.org>
References: <YcJZWiQ407ZxMM+y@bombadil.infradead.org>
 <20211222132332.7817-1-vimal.agrawal@sophos.com>
 <YcRRQCMZFepB/hzX@infradead.org>
 <CALkUMdRxTm6STT4CncTuvQ9hM_bez+B91TsuenEj71KPxFgMsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALkUMdRxTm6STT4CncTuvQ9hM_bez+B91TsuenEj71KPxFgMsg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 04:39:15PM +0530, Vimal Agrawal wrote:
> Hi Christoph,
> 
> On Thu, Dec 23, 2021 at 4:06 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > We never build modules with that ёption, so this is completely pointless.
> >
> we use openwrt for build and packaging and it has been using this
> option for long.
> 
> kbuild documentation says the following for INSTALL_MOD_STRIP:
> If this variable is specified, it will cause modules to be stripped
> after they are installed. If INSTALL_MOD_STRIP is ‘1’, then the
> default option –strip-debug will be used. Otherwise, the
> INSTALL_MOD_STRIP value will be used as the option(s) to the strip
> command.
> 
> So if kbuild does not support INSTALL_MOD_STRIP=--strip-unneeded
> option then we should call out what it supports and should not even
> allow what is not supported. We don't know what other options others
> may be using but if we allow it then we should support it and it
> should not behave erratic just because someone is using a
> non-recommended option.

I don't think we can support passing arbitrary linker options and
expects things to work.  If we want to support --strip-unneeded
it needs a good rationale and be added as a direct config option.
