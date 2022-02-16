Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDB24B91F6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbiBPT6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:58:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbiBPT6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:58:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E905222F23
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645041466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xiLxVyN59oqE7A7718SqSgkuduNadRNJgJwK2/lq92E=;
        b=YLe1zyKjBBq4/N4O04UJRwLjiPZBdNh4E6hg0Sh1QUryLp50qKmtsd4QlKa4D4Lvmcr2Bt
        hChdT0nBIolIhClL7B4EStfUXVIoQl5LwUZrHsfAvVNSpgdZ+JLfLgEt6ndQiAKnzW4E35
        /bzomFteh4+wPaQ3NKJu5TEcp31/ko4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-MbmdJS-8NkiMD8Wg9jPB_w-1; Wed, 16 Feb 2022 14:57:45 -0500
X-MC-Unique: MbmdJS-8NkiMD8Wg9jPB_w-1
Received: by mail-qk1-f200.google.com with SMTP id b19-20020a05620a0cd300b005f1771f5631so831105qkj.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xiLxVyN59oqE7A7718SqSgkuduNadRNJgJwK2/lq92E=;
        b=AnMhuZLVpiqQafV/kNGIg2XfOY2gNaOLOtIFrKzGdrJdmgeUeAuvXos4m0qMcroadO
         weQA+gFX8OPbv13WNYXZ0OQrFSEWuOpOfcpzSehRJV60cWCG7jJQnpkJtWrQERMIQBZV
         Tdd9nKnqkzD9JSvm/3RP+sRRZenDrUjRRvAu0X2iIvaK62NokYBBrNTGk7EKRyWUt58s
         O1CZEtzscA6AMP/NpVaYcEHH1gcgUiQD4VG5AXPutu/se6lt8FfmYq4RtCVS0cb1pnDw
         nhVug9lB4M9q3nFghgjaabNLunDsbMi1hdNnndSbnSCco0hUALagOeDwYQe5wtsGglsS
         wotg==
X-Gm-Message-State: AOAM533R5abx26pKlEYavxOs1VcjSpDFpgGl1gkGX79RmzqSFFDTgv8d
        XITAAMnM847md+WhjrahioIhyx1XplB33IYti6g8CJVWqdz0XG3qza8SQQSzkhAsHOXN1daNhOl
        ToNHWQob6+UOkMpvfE6WOHA+V
X-Received: by 2002:a05:622a:1349:b0:2d4:7253:a515 with SMTP id w9-20020a05622a134900b002d47253a515mr3268817qtk.602.1645041464729;
        Wed, 16 Feb 2022 11:57:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygWGLG5sUSJg9RfvApTNNy6TjsndVIBgztpxG68wFuUHr83ZsEZ3BHwvjzof67oYJOV+7Ieg==
X-Received: by 2002:a05:622a:1349:b0:2d4:7253:a515 with SMTP id w9-20020a05622a134900b002d47253a515mr3268787qtk.602.1645041464385;
        Wed, 16 Feb 2022 11:57:44 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c7sm3530034qtp.61.2022.02.16.11.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 11:57:43 -0800 (PST)
Date:   Wed, 16 Feb 2022 11:57:38 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v10 02/15] livepatch: avoid position-based search if `-z
 unique-symbol` is available
Message-ID: <20220216195738.vhlot4udoqga4ndm@treble>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
 <20220209185752.1226407-3-alexandr.lobakin@intel.com>
 <20220211174130.xxgjoqr2vidotvyw@treble>
 <alpine.LSU.2.21.2202161601010.1475@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2202161601010.1475@pobox.suse.cz>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 04:06:24PM +0100, Miroslav Benes wrote:
> > > +	/*
> > > +	 * If the LD's `-z unique-symbol` flag is available and enabled,
> > > +	 * sympos checks are not relevant.
> > > +	 */
> > > +	if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL))
> > > +		sympos = 0;
> > > +
> > 
> > Similarly, I don't see a need for this.  If the patch is legit then
> > sympos should already be zero.  If not, an error gets reported and the
> > patch fails to load.
> 
> My concern was that if the patch is not legit (that is, sympos is > 0 for 
> some reason), the error would be really cryptic and would not help the 
> user at all. So zeroing sympos seems to be a good idea to me. There is no 
> harm and the change is very small and compact.

But wouldn't a cryptic error be better than no error at all?  A bad
sympos might be indicative of some larger issue, like the wrong symbol
getting patched.

-- 
Josh

