Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3694AE59C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbiBHXsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238260AbiBHXsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:48:40 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0990C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:48:39 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id a39so350347pfx.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 15:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EQW9/+RZogYh703IuTOkdvN8ZBL4saxG1Lh7/q0hvoU=;
        b=FAEKTjopxXcIpR64eAjnUudiMds0fOmTb8dmx4oEdm4vkuH3aUvgu/bcaP4w8DudaQ
         aCmTUVMhuAMQFuR2d4un9QvPCE7H4IJKvLP829fNbzl7BNqhpOe0l/3v5wvR5NWd6onW
         IWwJ7XrnbFuofM8ClCMdocuygG2Mrndj3R7wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EQW9/+RZogYh703IuTOkdvN8ZBL4saxG1Lh7/q0hvoU=;
        b=Pooj9UA5h1sm23nvnamsGOQtcDUXGJY5GtNSDg0OXPsPHe1z9kLA+N2aDjyCn7u5K1
         IvfqpOzTtOeLpREWdXBIFV+5omUan3szXDBwJZWR1e6W/A9AFLEM+256Jc3w9kak7eiW
         YtqKxJF2waWgTisIwLpSjGCd0BmqvIJvnBukQyoa+61G2ukaW1enPvjrvw+hP1GueBw2
         wG6ixRqCA/0KdpGM6lOPosQnsU3MFDT2qRJ1nCyzIu21mzvjNgZy6+wM+MImM4FYMDQ4
         eQzv9UgWwlFGQAamuRU95PsuJ8zUm2uRKHYTqqUIGWfV6Xc6/qPO/otKDWgA6W8TU3KJ
         CkeQ==
X-Gm-Message-State: AOAM533FAqfeuhnCQpyZnUeKP6fmz8C6ky4snh6t6V7OjNrZadKjpur1
        CoK7b+l+sbGwlmGkYlnEObZflQ==
X-Google-Smtp-Source: ABdhPJzMAKazgkQ9W3sC+zrddFZCCMcUN8d+F+2QgDe2A93wwYdv6zu2aMc2VBQfetdRUUkF3EwvVw==
X-Received: by 2002:a63:f709:: with SMTP id x9mr5367873pgh.428.1644364119427;
        Tue, 08 Feb 2022 15:48:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id on14sm3995861pjb.34.2022.02.08.15.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 15:48:39 -0800 (PST)
Date:   Tue, 8 Feb 2022 15:48:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com
Subject: Re: [RFC][PATCH 0/6] x86: Kernel IBT beginnings
Message-ID: <202202081543.5C4EF7F9DE@keescook>
References: <20211122170301.764232470@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122170301.764232470@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 06:03:01PM +0100, Peter Zijlstra wrote:
> It is the very bare beginnings of kernel IBT support. Since I'm lacking any
> sort of actual hardware it even lacks fun things like code to write to the MSRs
> to enable the IBT tracker etc..

Heh. I have hardware to test with -- recent laptops all have the
support. I haven't checked in QEMU can emulate it, though. Bochs seems
to.

> However, it should have most of the ENDBR instructions in the right place -- I
> hope :-) That said; I would *really* like compiler support for this stuff to be
> improved, the amount of fixups done by objtool is obscene.
> 
> The end result still boots on ancient x86-64 hardware, for whatever that's
> worth (when built with the below turd included that is).

Should the below roughly be patch 7?

> 
> Enjoy!
> 
> ---
> 
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 5cdd9bc5c385..1d180bbe7b28 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -142,6 +142,11 @@ objtool_link()
>  		info OBJTOOL ${1}
>  		tools/objtool/objtool ${objtoolcmd} ${objtoolopt} ${1}
>  	fi
> +
> +	if [ "${CONFIG_X86_IBT}" = "y" ]; then
> +		# XXX less ugleh
> +		tools/objtool/objtool check --no-fp --retpoline --uaccess --vmlinux --duplicate --ibt --ibt-fix-direct --ibt-seal ${1}
> +	fi
>  }
>  
>  # Link of vmlinux
> 

Have you had a chance to get this into shape for a v1?

-- 
Kees Cook
