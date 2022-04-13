Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA1E500125
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiDMVY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbiDMVYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:24:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4871B7E5BA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:22:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso3675206pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZYerA/teNMufTz5u0iPno8fx6n3BkVy0K1GMILVmGm0=;
        b=Ve6vCo6zdOl0GExRe4t92l0AMv6Ra5r0eooW5wxLcgL0STztQc4HFF7n8Y/txIRlba
         Mm+rCvei8x8WNI7cMz7tnKpUg9k2macqmF0zvTreGg3Rngv1AszNUH6SGqY1Xst39xdL
         +vrqHhc46olROxCPyEMJgI3sjVVA4UKX9dJT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZYerA/teNMufTz5u0iPno8fx6n3BkVy0K1GMILVmGm0=;
        b=BDLpvVGj1lBch6wbqO8klUKM33imx4QZFHTk9Fdla2PJA2h2aUcj6V7E3Fa4kYsh3K
         RYymN0fn7+Wk6zpWDU79Ja9QqcRyJU4SQaqieDF8jDyfJGPA7K4m6I4CEj1qwOS578d7
         VMz4JrJgfnH3QTd4pjCZgpMWLLztQC1hhGey8MSBCbR7Msg/B7JTAOc7wKPrmzpKcrKq
         GuYVykfoNcSBKdxuTNObXq+2XRO5YolTH+OEh31kvf3U/EwEN8n8VBUoWtU9Utk2vNvK
         VSbKnd/HihpaYvafoLMM27Wp3sH5qeosIDzek47MY5ZXJThmTNqr05wvK4FiQEq+daqI
         8YGg==
X-Gm-Message-State: AOAM530IHBtm0dn9bp3uFXVjSdHd6sg89fQOpUcJ+DGIAwRHqtn8lxZ0
        TgVM+ohVVZQMEEk7+OWCxoA8ng==
X-Google-Smtp-Source: ABdhPJzUWNVeiS95lPTUIZrht0qt/ZgNS3oQAeqQHbhl11+3SubvVYk7wcdbAoae9PBQFjrlw/hHwQ==
X-Received: by 2002:a17:902:e791:b0:151:dbbd:aeae with SMTP id cp17-20020a170902e79100b00151dbbdaeaemr44679245plb.171.1649884944727;
        Wed, 13 Apr 2022 14:22:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v3-20020aa78503000000b00504e93ef182sm20070pfn.31.2022.04.13.14.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:22:24 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:22:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] lkdtm/bugs: Don't expect thread termination without
 CONFIG_UBSAN_TRAP
Message-ID: <202204131421.0E83CACC7@keescook>
References: <363b58690e907c677252467a94fe49444c80ea76.1649704381.git.christophe.leroy@csgroup.eu>
 <202204121440.FEE123D7@keescook>
 <20220413205714.scrrktpq43kzryim@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413205714.scrrktpq43kzryim@meerkat.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 04:57:14PM -0400, Konstantin Ryabitsev wrote:
> On Tue, Apr 12, 2022 at 04:06:20PM -0700, Kees Cook wrote:
> > Also, Konstantin, I note that
> > https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/
> > does not have a .keyring/ed25519 directory. Should it? 
> 
> No, because it's not a "pgpkey". :)
> 
> > I added one
> > locally for at least one other developer, as I use this setting:
> > 
> > [patatt]
> >         keyringsrc = ~/korg/pgpkeys/.keyring
> > 
> > Am I holding this thing wrong? :)
> 
> Nope, but you can also list multiple locations where patatt can look, for
> example:
> 
> [patatt]
>        keyringsrc = ~/korg/pgpkeys/.keyring
>        keyringsrc = ~/.local/share/patatt/public
> 
> In fact, if you take Christophe's patches all the time, you can add a keyring
> ref to your tree. The process is documented here:
> https://github.com/mricon/patatt#managing-the-keyring-large-teams
> 
> This way I'm not managing the keys of your trusted contributors.
> 
> I'll be happy to explain further -- in fact, I'm happy anyone uses it at all!
> :)

I read emails out of order. :) Thanks!

If the expectation is other kernel devs are using ed25519 over gpg,
should there be a central repo for those?

-- 
Kees Cook
