Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D744482630
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 01:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiAAAMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 19:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiAAAMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 19:12:50 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914C9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 16:12:49 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n3S0W-00GKYO-HC; Sat, 01 Jan 2022 00:12:24 +0000
Date:   Sat, 1 Jan 2022 00:12:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Richard Weinberger <richard@nod.at>
Cc:     hch <hch@lst.de>, anton ivanov <anton.ivanov@cambridgegreys.com>,
        x86 <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: remove set_fs for UML
Message-ID: <Yc+caOi47BbzlPw6@zeniv-ca.linux.org.uk>
References: <20211215165612.554426-1-hch@lst.de>
 <1202521211.191037.1640120703350.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1202521211.191037.1640120703350.JavaMail.zimbra@nod.at>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:05:03PM +0100, Richard Weinberger wrote:
> Christoph,
> 
> ----- Ursprüngliche Mail -----
> > Von: "hch" <hch@lst.de>
> > An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>
> > CC: "x86" <x86@kernel.org>, "linux-um" <linux-um@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> > Gesendet: Mittwoch, 15. Dezember 2021 17:56:10
> > Betreff: remove set_fs for UML
> 
> > Hi Richard and Anton,
> > 
> > this series removes address space overrides using set_fs for UML.
> > 
> > Diffstat:
> > um/Kconfig                   |    1 -
> > um/include/asm/thread_info.h |    4 ----
> > um/include/asm/uaccess.h     |   21 +++++++++++++++++++--
> > um/kernel/skas/uaccess.c     |   25 -------------------------
> > x86/include/asm/mtrr.h       |    8 +-------
> > x86/kernel/setup.c           |    7 ++++++-
> > x86/um/asm/segment.h         |    8 --------
> >  7 files changed, 26 insertions(+), 48 deletions(-)
> 
> So far UML seems to work with these changes applied. :-)
> I have applied both patches to my UML tree for now, I assume x86 maintainers are fine with
> patch 1/2?

Hmmm...  AFAICS, the right thing to do would be to have __get_kernel_nofault
and __put_kernel_nofault in arch/x86/um/asm/something.  The question is how
to avoid duplicating the x86 implementation of those (along with the asm-goto
fun, etc.)...

But Christoph is right, it's not a new problem.  As far as I'm concerned,
that series looks fine.
