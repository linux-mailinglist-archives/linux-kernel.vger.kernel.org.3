Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07AB5A22FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbiHZI2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343604AbiHZI2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:28:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C564D51C1;
        Fri, 26 Aug 2022 01:28:02 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso4009719wmc.0;
        Fri, 26 Aug 2022 01:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=GISjr4CEz3TMjLoBvjNME7qQCe5WMZpMgsiNdvZmrbw=;
        b=gWhi1VqSWlLx+IZ4qMs+3/P16Uw3Xloji/bU53od47g9n9gXXMAJg0dEDZs68/m0u8
         FD7GYQ+CgQOSBGTzoWHY2Qs6jOggfYN1NQ26ZWxZTwTarQqKorkTbxmuhFdK26iGJDtF
         tco9TB0LQK+GJ/c8r+QnlFD1kIovdRwwl2YRi/MybydimhkOnlL60OlVCRWdhELF/6TG
         VBXGRCZwPkWoK1VT3tWfcPUASeCVZR1v/yQF4vSu2oyB28lbnUJIwI6mZsxvm6FcgvEC
         tUnNQ7x8JBH6A+EEeNUbtkhbSIc6RycNaPiyBHXNvx1oYadj6gbUqECP+zW9Mu0PCRvQ
         vY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=GISjr4CEz3TMjLoBvjNME7qQCe5WMZpMgsiNdvZmrbw=;
        b=JUvbb5FuzHRATXKes84sqPzUT0sh6ayqu1bbOYg3GP6C/bLlQcg9C6MxDi7b1JvPeC
         WC1qRliLJvF15+lKkT1txDGMpxtuugiBrqZXaPXmWRChJy4m7kgTEl8CicJpF79sn6qj
         fgTQ+3DPx/PbBNQENBDv4sLtcann3h2BTjy2nXKVYYlX8HHz3DTaMyEcadGqZsEJVKUA
         ZScw6GoKC9jaKffuNSyOOyAdsA0KC694/Dv3Mn5noHFX3LzL8XBwKSYly5bzoQxHuKu4
         R6XiEIS0MrU5aS/cmZBkVkkBWKochdRFYK4jrwHWQmpRtn2pYAhvGQC0zoTJ7TLW6B9p
         O5Bg==
X-Gm-Message-State: ACgBeo2CiBNEouXSUkmfryHbUVMItVa22YC6Nus9hkOd8dwfiTKM/Gf7
        NtfspOb5j83bH0FK67LLs9nVm4drbsRDWg==
X-Google-Smtp-Source: AA6agR4m1WLBDmghfU+i5RfBzzpR1HzEleNyc7QRsbB0+quU6VGz33ov+4QK7hLIkbVCvNdlONBbVA==
X-Received: by 2002:a1c:c91a:0:b0:3a6:38bf:2c36 with SMTP id f26-20020a1cc91a000000b003a638bf2c36mr10542000wmb.38.1661502480914;
        Fri, 26 Aug 2022 01:28:00 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d4d83000000b0020fff0ea0a3sm1230571wru.116.2022.08.26.01.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 01:27:59 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 5CD04BE2F83; Fri, 26 Aug 2022 10:27:58 +0200 (CEST)
Date:   Fri, 26 Aug 2022 10:27:58 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: stable: Document alternative for
 referring upstream commit hash
Message-ID: <YwiEDsngUL//ogBL@eldamar.lan>
References: <20220809045543.2049293-1-carnil@debian.org>
 <8735e5a864.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735e5a864.fsf@meer.lwn.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Tue, Aug 09, 2022 at 06:54:59AM -0600, Jonathan Corbet wrote:
> Salvatore Bonaccorso <carnil@debian.org> writes:
> 
> > Additionally to the "commit <sha1> upstream." variant, "[ Upstream
> > commit <sha1> ]" is used as well as alternative to refer to the upstream
> > commit hash.
> >
> > Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> > ---
> >  Documentation/process/stable-kernel-rules.rst | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> So this is a nit but...
> 
> > diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> > index c61865e91f52..2fd8aa593a28 100644
> > --- a/Documentation/process/stable-kernel-rules.rst
> > +++ b/Documentation/process/stable-kernel-rules.rst
> > @@ -97,6 +97,12 @@ text, like this:
> >  
> >      commit <sha1> upstream.
> >  
> > +or alternatively:
> > +
> > +.. code-block:: none
> > +
> > +    [ Upstream commit <sha1> ]
> 
> Can this just be:
> 
>   or alternatively::
> 
>     [ Upstream commit <sha1> ]
> 
> That extra RST markup just clutters things without any advantage.

Btw, after revisiting, I think Greg actually can pick up the first
version of the patch. Changing the above without adding the
code-block:node will reformat the

     [ Upstream commit <sha1> ]

differently when rendering to html.

Greg, so as the patch has not yet been commited, can you pick up the
first version from
https://lore.kernel.org/lkml/20220809045543.2049293-1-carnil@debian.org/
?

Regards,
Salvatore
