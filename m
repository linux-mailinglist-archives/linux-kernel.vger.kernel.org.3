Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D5B5A9F59
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiIASqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiIASp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:45:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EFC273A;
        Thu,  1 Sep 2022 11:45:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y3so36606082ejc.1;
        Thu, 01 Sep 2022 11:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=EI+1N/llj9L85b9NcuYg64P4zBWYxAlSDInm7LZKJiE=;
        b=AOnpLzASJSI5wTZShO7PVB+6AfPc3VOoQ+Dh4ohASVvg2bAjptrWh951uiGYqtwS8+
         Q+ULbBcsPtGcSpNmn+tL4QjZR5Sm81/TF6v/uz96xeYcjOoZASF8NXWk0jRu4GAGki9V
         R9xg93hvODgA+wHeHCjaeO/MvHfRHnQs2ayWw3GlGoXt4m+yJt37julvliDDjiHtKliJ
         3GWPNu+wc8pUD0FhwIbtPBP+koH3/eKL5ccCwJ/YAL6a2P6c9+QeagaA9NMfyt1PxYIX
         sG1A8VciClCYmgkZIcF9gbNDvoKTzuP2bpBwZVtcHa/iQp2nrSHYIH+iQpbd2VssX8nc
         eAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EI+1N/llj9L85b9NcuYg64P4zBWYxAlSDInm7LZKJiE=;
        b=ALeSa76n6MoTRMNYEYPosFzfD6AxE+Uc0lhGMK3Fw0AxS1zYX201kW1DG416Y4IijP
         4tnbQea4/sDaS/YXes5lJ6cxUkJR/PnDfxWgIPaaZeVOuezoLEL69rH3uvZDwWGUQ2XJ
         5Jq7XNH/hErp2tZQtygU3gsLe/+whV8pup7mQuo+BToInCgomVV0hcMUhrOjh5jnwBUD
         oLOggRaNUOIfH1WF4u48qtQTV4+0kj3mvHa7QEypNMzW3ATK6j/BKnxKsTlCGlYDlG1g
         y7aPjfibWMC9XRMn8o+qqMSC5o/faLUaxeTX1AxCwhTmyJ6ArwQ8Xi0aeUn2OYPYh79k
         n0Cg==
X-Gm-Message-State: ACgBeo3+B5iQ63Ypk9GN2/7gLB9/CceBJmld7wvlSLb2q1601T62M3kp
        lqWhsWRO90Ge65YwHWo5wmA=
X-Google-Smtp-Source: AA6agR7C1eNnJDOfnfQVBMk+BdAAEzf0m1yz4gzcFBN0vOhoBtPP59mO1qv9UrCu1Rr4D+ejcMKY9w==
X-Received: by 2002:a17:906:8450:b0:741:5b1b:5c7f with SMTP id e16-20020a170906845000b007415b1b5c7fmr16853312ejy.766.1662057936037;
        Thu, 01 Sep 2022 11:45:36 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090632c800b0074134543f82sm11682ejk.90.2022.09.01.11.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:45:34 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 2233DBE41F1; Thu,  1 Sep 2022 20:45:34 +0200 (CEST)
Date:   Thu, 1 Sep 2022 20:45:34 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Sasha Levin <sashal@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: stable: Document alternative for
 referring upstream commit hash
Message-ID: <YxD9zpYyL08sh2jd@eldamar.lan>
References: <20220809045543.2049293-1-carnil@debian.org>
 <8735e5a864.fsf@meer.lwn.net>
 <YwiEDsngUL//ogBL@eldamar.lan>
 <YxDWzCoQJwWEnKXw@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxDWzCoQJwWEnKXw@kroah.com>
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

Hi Greg,

On Thu, Sep 01, 2022 at 05:59:08PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 26, 2022 at 10:27:58AM +0200, Salvatore Bonaccorso wrote:
> > Hi Jonathan,
> > 
> > On Tue, Aug 09, 2022 at 06:54:59AM -0600, Jonathan Corbet wrote:
> > > Salvatore Bonaccorso <carnil@debian.org> writes:
> > > 
> > > > Additionally to the "commit <sha1> upstream." variant, "[ Upstream
> > > > commit <sha1> ]" is used as well as alternative to refer to the upstream
> > > > commit hash.
> > > >
> > > > Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> > > > ---
> > > >  Documentation/process/stable-kernel-rules.rst | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > 
> > > So this is a nit but...
> > > 
> > > > diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> > > > index c61865e91f52..2fd8aa593a28 100644
> > > > --- a/Documentation/process/stable-kernel-rules.rst
> > > > +++ b/Documentation/process/stable-kernel-rules.rst
> > > > @@ -97,6 +97,12 @@ text, like this:
> > > >  
> > > >      commit <sha1> upstream.
> > > >  
> > > > +or alternatively:
> > > > +
> > > > +.. code-block:: none
> > > > +
> > > > +    [ Upstream commit <sha1> ]
> > > 
> > > Can this just be:
> > > 
> > >   or alternatively::
> > > 
> > >     [ Upstream commit <sha1> ]
> > > 
> > > That extra RST markup just clutters things without any advantage.
> > 
> > Btw, after revisiting, I think Greg actually can pick up the first
> > version of the patch. Changing the above without adding the
> > code-block:node will reformat the
> > 
> >      [ Upstream commit <sha1> ]
> > 
> > differently when rendering to html.
> > 
> > Greg, so as the patch has not yet been commited, can you pick up the
> > first version from
> > https://lore.kernel.org/lkml/20220809045543.2049293-1-carnil@debian.org/
> > ?
> 
> Please resend it as v3 so that our tools don't try to apply v2.

Okay right, make sense! Just sumitted v3 with the original version of
the documentation patch.

https://lore.kernel.org/lkml/20220901184328.4075701-1-carnil@debian.org/

Regards,
Salvatore
