Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B36959EB60
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbiHWSs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiHWSsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:48:18 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC5F11B010
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:12:31 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l19so10975052ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oJRG7uz6WGBbtCoGOSmHQY70YgBhBuqvMftRIStyMs0=;
        b=NdGEu09reixZxX3m/TPNxIYeFZ7fr5WNqIF0qIYTfmeK1vx24ssEvai7OW9XAB7KNn
         R9TzKHZLK3CeuHeGzHjOqaD+NYMU6prJ46EAlmE/taiviOKUz4wwlVrHApU2usky32xx
         bvV+2KT+rjw7Zbix0OOybgaCTm4MPw59fQEmXzllwnB+ouyMhjojKx1YI1pcms4nmYuF
         AeX8//PGbdMgfwghAEl154yq6ojmHvjaakHMOFwWtotLye03UoWu8afnTvcSzEW3RAbW
         kc4PHWxpXwNxGRhgsnWIid8EnsmhRnlF6gGyBgOcL3kFt3A/EFZ2KIrXyHbgh3WRCtss
         CJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oJRG7uz6WGBbtCoGOSmHQY70YgBhBuqvMftRIStyMs0=;
        b=rT+eZTuKyHyL7iv+YTdjD8tkzc1vCBpPo+cYVLCWEt9HP4Kw96NF9cupHR4TbenD8x
         fvPinJ8qQLzj3UydBIxxufRY1+EHPWPdObhcoxC4WsWeLz5MVUQZ4gGFoBIV3DFOx/Tn
         NED72GHahsiB3pnzLcJIOkNk47JLuMSehaLihKB1YqEamdfSRV/ZTXRc0X/sds/JW1+v
         wSld28f/pjPkBKRFNfjPc5/ZNojMyNOATTFpD7FHFMwKsI7IT9BcYOoPgVxrrMrfpmUU
         3sLhhK4qKoJ925bERfuMoHHYB41YHK4jomVcqru0JbNZz14xbD48mBqcW1IiVLyFhlN8
         1OsQ==
X-Gm-Message-State: ACgBeo3i1xz7L1xltCH4Jlnl02qad7sF/cNZ0TDUFpOn+d1OhD7bjmtw
        i4kn1tPfIhFV/86FP3wyrZpXr69aTUcMIL3xgkbNFw==
X-Google-Smtp-Source: AA6agR4SxIHfG8HjtHB58neDIxlJ5dnDXtAbRUJyYQemYFIbKyNpGne5qu+VB3chjqUwB3l3YjEBkbSNDj6xY4aGph8=
X-Received: by 2002:a05:651c:31b:b0:261:df26:53ba with SMTP id
 a27-20020a05651c031b00b00261df2653bamr585838ljp.513.1661274749104; Tue, 23
 Aug 2022 10:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220812114438.1574-1-mailhol.vincent@wanadoo.fr> <20220812114438.1574-3-mailhol.vincent@wanadoo.fr>
 <YwT+5GGCOKoTjfQZ@zn.tnic>
In-Reply-To: <YwT+5GGCOKoTjfQZ@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Aug 2022 10:12:17 -0700
Message-ID: <CAKwvOdnc-Js8x4sv0j23crtYP73sRkNexom5ydm=r=8rYgc_5Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to
 evaluate constant expressions
To:     Borislav Petkov <bp@alien8.de>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 9:23 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Aug 12, 2022 at 08:44:38PM +0900, Vincent Mailhol wrote:
> > __ffs(x) is equivalent to (unsigned long)__builtin_ctzl(x)
>
> Are you sure about this?
>
> My gcc documentation says:
>
> "Built-in Function: int __builtin_ctz (unsigned int x)
>
>     Returns the number of trailing 0-bits in x, starting at the least significant bit position. If x is 0, the result is undefined."
>
> Note the undefined part.
>
> Also,
>
> __builtin_ctzl(0): 0x40
> ffs(0): 0x0
>
> I'm using the kernel ffs() version in a small program which is basically
> a wrapper around BSF.

Callers of these need to guard against zero input, as the pre-existing
comment notes:

>> Undefined if no bit exists, so code should check against 0 first.
-- 
Thanks,
~Nick Desaulniers
