Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3024F97B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiDHOLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiDHOLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 624562B04C1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649426948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tv2qGn+XVM9ht1l7MnzD3eCbRqvWv86waF5o+uBoIiE=;
        b=TSkKJxEYWYIIVW8ri14v1MzHhmA2M8wV86bREVG7Vgsjp4a2sN1i8A7veGIkhg9OTVHOlE
        FVZALlgP750z+huk/Na+uJX4U5LdBJqrfTJAvHeyyyO3WpgKUb+NQeETijymNOY6pEOA/v
        2Sx3tukhfUKWXMUAKmAophHkqCIEb+U=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-kAnH8rLaNj25xLHNgYGirg-1; Fri, 08 Apr 2022 10:09:07 -0400
X-MC-Unique: kAnH8rLaNj25xLHNgYGirg-1
Received: by mail-qt1-f200.google.com with SMTP id k1-20020ac85fc1000000b002e1c5930386so7846723qta.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 07:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tv2qGn+XVM9ht1l7MnzD3eCbRqvWv86waF5o+uBoIiE=;
        b=ffIOOe0Zebsc4/zPdsXH7oA/EFBB1oWcgKnWX43wnzNtn01bXYltGXXuIFxXmUowNp
         LuWBU+kYNflYIx9Qqwj1VSZhfnhgtM/lWVuHmgNS7rK/DCMs0f5b/Dkxad7+/G+pcijO
         HaTgpaFQVR2HtxuOZmYfq5TYFLBbsYzU3Yod0Z+dDn5SNxquxW2MsD/70GRN3GhwnW9p
         C0E8ekGpOAeCxdzi57l2jqWGvnPIhVPomGAKNS4yzSzNczd2dlDeI4ZsmP7zdncpXk83
         Fcktsy7JdebySO0nz53QOflIYQNkFgZBCLmom2ykQVJU/vbKfS+o11nwpfUw21u2hH16
         AtKw==
X-Gm-Message-State: AOAM530S01I6TOX0UWkFxb/bNWUKIHTC5uJIWCjcUU+ZiT3epyNV7F8g
        jaJ/2ryNMega4MZ2D3A7o+Vy4oRk82fH11KlBg6W8qgl4CAwVv7SGXxz/wVSrtMuIbep4mCnmNc
        Bi8BkRf2wZFC+/fStFumzA3aL
X-Received: by 2002:a05:6214:2625:b0:441:57e5:deb5 with SMTP id gv5-20020a056214262500b0044157e5deb5mr16716725qvb.105.1649426946823;
        Fri, 08 Apr 2022 07:09:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8Th6l7cReFzSBT6Kbp6A2z5m6oqHYj+Jijbhs48eO5dNkMjzZV8Pbq3c7TsWXQjsSOhYctQ==
X-Received: by 2002:a05:6214:2625:b0:441:57e5:deb5 with SMTP id gv5-20020a056214262500b0044157e5deb5mr16716693qvb.105.1649426946460;
        Fri, 08 Apr 2022 07:09:06 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id o66-20020a375a45000000b0069be238e5e3sm863601qkb.48.2022.04.08.07.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 07:09:05 -0700 (PDT)
Date:   Fri, 8 Apr 2022 07:09:03 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        rick.p.edgecombe@intel.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/4] lib/strn*,objtool: Enforce user_access_begin() rules
Message-ID: <20220408140903.g4vs5laat7crxoos@treble>
References: <20220408094552.432447640@infradead.org>
 <20220408094718.262932488@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220408094718.262932488@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 11:45:53AM +0200, Peter Zijlstra wrote:
> Apparently GCC can fail to inline a 'static inline' single caller
> function:
> 
>   lib/strnlen_user.o: warning: objtool: strnlen_user()+0x33: call to do_strnlen_user() with UACCESS enabled
>   lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x33: call to do_strncpy_from_user() with UACCESS enabled
> 
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Presumably because of

ifdef CONFIG_DEBUG_SECTION_MISMATCH
KBUILD_CFLAGS += -fno-inline-functions-called-once
endif

which I've been wanting to remove since its only true purpose seems to
be creating countless __always_inline patches...

-- 
Josh

