Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEAE4CBE81
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiCCNGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiCCNGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:06:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0F651305;
        Thu,  3 Mar 2022 05:06:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58B71B8253F;
        Thu,  3 Mar 2022 13:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8CCC004E1;
        Thu,  3 Mar 2022 13:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646312759;
        bh=rH7GMRdryJ4vXOlSLW4fYujXOBHUP2yNPBkxdY3/pqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKjBjXMyfVBu2K3GUcQCQc1njLV/s3+M4ZWtxKF4NAU5NxrVy9KXWuvtqBcyWdtqV
         RezoeSmnvUU25H5afMgJ3RLNtTTER8TDPcItb9bade2MSwFELbeq4ZuW+iEsFBrFiZ
         LrlNMt5fsW8+bsUFCaAE9Am+UU/TJn5iQDJYZ+Ok=
Date:   Thu, 3 Mar 2022 14:05:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Gow <davidgow@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kbuild@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        llvm@lists.linux.dev, x86@kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 7/7] UAPI: Introduce KUnit userspace compatibility
Message-ID: <YiC9NBjFgGv5T+gF@kroah.com>
References: <20220227184517.504931-1-keescook@chromium.org>
 <20220227184517.504931-8-keescook@chromium.org>
 <CABVgOSn6Oe8Ke=fnuVwgLh2r8HKjBW8pCe44Z35Qo1bVfz9A-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSn6Oe8Ke=fnuVwgLh2r8HKjBW8pCe44Z35Qo1bVfz9A-A@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 04:27:13PM +0800, David Gow wrote:
> On Mon, Feb 28, 2022 at 2:45 AM Kees Cook <keescook@chromium.org> wrote:
> > diff --git a/include/uapi/misc/kunit.h b/include/uapi/misc/kunit.h
> > new file mode 100644
> > index 000000000000..afdffda583ae
> > --- /dev/null
> > +++ b/include/uapi/misc/kunit.h
> > @@ -0,0 +1,181 @@
> > +#ifndef __UAPI_MISC_KUNIT_H__
> > +#define __UAPI_MISC_KUNIT_H__
> > +/*
> > + * This is a light-weight userspace drop-in replacement for the in-kernel

<snip>

Someone forgot a SPDX license line for the new file.  Didn't checkpatch
complain about this?  :(

thanks,

greg k-h
