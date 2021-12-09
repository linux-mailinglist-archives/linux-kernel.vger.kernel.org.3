Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E330C46F7AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhLIXv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:51:28 -0500
Received: from relay035.a.hostedemail.com ([64.99.140.35]:38633 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232760AbhLIXv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:51:28 -0500
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id E837C6082C;
        Thu,  9 Dec 2021 23:47:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 07D282001F;
        Thu,  9 Dec 2021 23:47:49 +0000 (UTC)
Message-ID: <e825dec01f6ffd19fd5487f04280583c673b7f1d.camel@perches.com>
Subject: Re: [PATCH] x86/boot/string: Add missing function declarations
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hardening@vger.kernel.org
Date:   Thu, 09 Dec 2021 15:47:49 -0800
In-Reply-To: <202112091536.2DDF0DF@keescook>
References: <20211119175325.3668419-1-keescook@chromium.org>
         <202112091536.2DDF0DF@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 07D282001F
X-Spam-Status: No, score=-4.86
X-Stat-Signature: ymgujoy4iod5yp57rr3zq4pmgb7u6uq8
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/XrvaolBHOzQqrS/4GCMzj+bty3i2Kj3U=
X-HE-Tag: 1639093669-239949
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-09 at 15:37 -0800, Kees Cook wrote:
> On Fri, Nov 19, 2021 at 09:53:25AM -0800, Kees Cook wrote:
> > Silence "missing function declaration" warnings from string.h when
> > building under W=1.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> Hi, just a quick ping on this little fix.
[]
> > diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
[]
> > @@ -8,8 +8,10 @@
> >  #undef memcmp
> >  
> >  void *memcpy(void *dst, const void *src, size_t len);
> > +void *memmove(void *dst, const void *src, size_t len);
> >  void *memset(void *dst, int c, size_t len);
> >  int memcmp(const void *s1, const void *s2, size_t len);
> > +int bcmp(const void *s1, const void *s2, size_t len);

Unrelated trivia:

Is bcmp still used anywhere in the kernel?

confdata.c is a user-mode program right?

$ git grep -w bcmp
arch/x86/boot/string.c: * Clang may lower `memcmp == 0` to `bcmp == 0`.
arch/x86/boot/string.c:int bcmp(const void *s1, const void *s2, size_t len)
include/linux/string.h:extern int bcmp(const void *,const void *,__kernel_size_t);
lib/Makefile:# Prevent the compiler from calling builtins like memcmp() or bcmp() from this
lib/string.c: * bcmp - returns 0 if and only if the buffers have identical contents.
lib/string.c: * meaning, and architectures may implement their own more efficient bcmp(). So
lib/string.c:int bcmp(const void *a, const void *b, size_t len)
lib/string.c:EXPORT_SYMBOL(bcmp);
scripts/kconfig/confdata.c:     if (bcmp(map1, map2, st1.st_size))


