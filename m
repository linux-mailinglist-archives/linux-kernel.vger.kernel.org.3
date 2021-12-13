Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6CE47359E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbhLMUK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:10:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57930 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231971AbhLMUK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639426228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=98410SCY73aKt24LcVMxqvWF7akIYNbHy7o+glUPBM4=;
        b=JQM+2SNRVQLxk0m3dCELXvJupEXT4BC4PtRnn8oShbWOPjXc2XIiMABtayBh5nwnvvq7nP
        Yqdlo/Bn2vI45BbWJNQT4NwxLvEm4QOkI25bdURsJgb5xiXWz4HOeGN232AYgYdOikC1k6
        CBuXcMNCN10I+2ZJ2QMVXs9Nx4FlnMw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511--zjZFenxNt2pgOOrw4bAaQ-1; Mon, 13 Dec 2021 15:10:27 -0500
X-MC-Unique: -zjZFenxNt2pgOOrw4bAaQ-1
Received: by mail-ot1-f69.google.com with SMTP id z16-20020a056830129000b0055c7b3ceaf5so6795762otp.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=98410SCY73aKt24LcVMxqvWF7akIYNbHy7o+glUPBM4=;
        b=Po1QqzNs2otc9CC/6TfWRZdbgeUNOMsQrGFUNYxG8lLiMR56PlLCBJBDWH6SxRQWQ9
         vaib4SjfSzy62Vxfq/ffGSBQjnVHVnvyJMxKWNk2VoKYcjBnsZZYgh16QaCM3AM3r9yd
         Bn4NYkl/wfnHdcbeWA2P4MRLqnPVPyflxtvdFmYfZ2ZJZEYZIbuk+0Z+hplh7/BXLXph
         CfLFp/LWA93Sx5hwTQKYr+Z6z6i13xmH78B33gYjiRrXK6YNQ4WKiYKSfh2LOzg+PQK1
         w/D6XYEHgAjJ6ZxaHNKRaMnkvYIu9BVnfdlJoYEAQ2Rx4NsVy+HlRK9Stw+/EGvpXcbF
         LVAw==
X-Gm-Message-State: AOAM530irOiGfqrSbz5aVbQmrapGeDEdvRsokfehAHoYBfCM0QLp0+g1
        Q4Maez4zqbLcqnU3Rrm9Peo0z+e/1tIV07ksBwUkMo+1VqP4s1YLKqAWr9QNu2y+J931d9HwMGv
        qxmbzqev1j2bgvS/Y4aZ2/AbX
X-Received: by 2002:a4a:d184:: with SMTP id j4mr448485oor.72.1639426226196;
        Mon, 13 Dec 2021 12:10:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdF5hmqnDtiL8k0ufA6KXBZMr+XhxgtNNHlmdJ9hKuUpIpa3M2DrnM0v+LSkj9mIo3zup2qw==
X-Received: by 2002:a4a:d184:: with SMTP id j4mr448461oor.72.1639426225935;
        Mon, 13 Dec 2021 12:10:25 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id h14sm2392996ots.22.2021.12.13.12.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:10:25 -0800 (PST)
Date:   Mon, 13 Dec 2021 12:10:22 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Vernet <void@manifault.com>
Cc:     pmladek@suse.com, linux-doc@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
        corbet@lwn.net, yhs@fb.com, songliubraving@fb.com
Subject: Re: [PATCH] livepatch: Fix leak on klp_init_patch_early failure path
Message-ID: <20211213201022.dhalhtc2bpey55gh@treble>
References: <20211213191734.3238783-1-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213191734.3238783-1-void@manifault.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:17:35AM -0800, David Vernet wrote:
> When enabling a KLP patch with `klp_enable_patch`, we invoke
> `klp_init_patch_early` to initialize the kobjects for the patch itself, as
> well as the `struct klp_object*`'s and `struct klp_func*`'s that comprise
> it. However, there are some paths where we may fail to do an
> early-initialization of an object or its functions if certain conditions
> are not met, such as an object having a `NULL` funcs pointer. In these
> paths, we may currently leak the `struct klp_patch*`'s kobject, as well as
> any of its objects or functions, as we don't free the patch in
> `klp_enable_patch` if `klp_init_patch_early` returns an error code. For
> example, if we added the following object entry to the sample livepatch
> code, it would cause us to leak the vmlinux `klp_object`, and its `struct
> klp_func` which updates `cmdline_proc_show`:
> 
> ```
> static struct klp_object objs[] = {
>         {
>                 .name = "kvm",
>         }, { }
> };
> ```
> 
> Without this change, if we enable `CONFIG_DEBUG_KOBJECT` and try to `kpatch
> load livepatch-sample.ko`, we don't observe the kobjects being released
> (though of course we do observe `insmod` failing to insert the module).
> With the change, we do observe that the `kobject` for the patch and its
> `vmlinux` object are released.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Thanks for reporting the issue and submitting the patch!

The patch description needs a few tweaks.  In the kernel we don't use
Markdown for patch descriptions.

A function can be postfixed with a trailing pair of parentheses, like
klp_enable_patch().

Other symbols can be enclosed with single quotes, like 'struct
klp_object'.

I'd also recommend avoiding the excessive use of "we", in favor of more
imperative-type language.

See Documentation/process/submitting-patches.rst for more details.  It's
also a good idea to look at some kernel commit logs to get a general
idea of the kernel patch description style.

> @@ -1052,10 +1052,7 @@ int klp_enable_patch(struct klp_patch *patch)
>  	}
>  
>  	ret = klp_init_patch_early(patch);
> -	if (ret) {
> -		mutex_unlock(&klp_mutex);
> -		return ret;
> -	}
> +		goto err;
>  
>  	ret = klp_init_patch(patch);
>  	if (ret)

I don't think the fix will be quite that simple.  For example, if
klp_init_patch_early() fails, that means try_module_get() hasn't been
done, so klp_free_patch_finish() will wrongly do a module_put().

-- 
Josh

