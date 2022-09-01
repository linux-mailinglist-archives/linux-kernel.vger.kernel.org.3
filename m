Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BEB5A9C5E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiIAP7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiIAP7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:59:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ADD82FA7;
        Thu,  1 Sep 2022 08:59:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 068C0B82841;
        Thu,  1 Sep 2022 15:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A064C433D6;
        Thu,  1 Sep 2022 15:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662047951;
        bh=TY+3JNGsmVP31B0gqfliPrc5PDpyouCFib5eIBdb/cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kKrIXPXazfWGZURlJasnI78CokOXK89HMELlDMpDsIUhu7ydMIleOAt0l+gFycRgr
         lgFv/N/CqciZRY507JMwhxgcuDDqQlomvw6d1V32QgYQxJSi9Lz2j9l/4IGZd1gVIe
         ZQftD2GqIVkYc9oDWR+BmREgh3CXCg0RIkmgxcLM=
Date:   Thu, 1 Sep 2022 17:59:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Sasha Levin <sashal@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: stable: Document alternative for
 referring upstream commit hash
Message-ID: <YxDWzCoQJwWEnKXw@kroah.com>
References: <20220809045543.2049293-1-carnil@debian.org>
 <8735e5a864.fsf@meer.lwn.net>
 <YwiEDsngUL//ogBL@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwiEDsngUL//ogBL@eldamar.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 10:27:58AM +0200, Salvatore Bonaccorso wrote:
> Hi Jonathan,
> 
> On Tue, Aug 09, 2022 at 06:54:59AM -0600, Jonathan Corbet wrote:
> > Salvatore Bonaccorso <carnil@debian.org> writes:
> > 
> > > Additionally to the "commit <sha1> upstream." variant, "[ Upstream
> > > commit <sha1> ]" is used as well as alternative to refer to the upstream
> > > commit hash.
> > >
> > > Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> > > ---
> > >  Documentation/process/stable-kernel-rules.rst | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > 
> > So this is a nit but...
> > 
> > > diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> > > index c61865e91f52..2fd8aa593a28 100644
> > > --- a/Documentation/process/stable-kernel-rules.rst
> > > +++ b/Documentation/process/stable-kernel-rules.rst
> > > @@ -97,6 +97,12 @@ text, like this:
> > >  
> > >      commit <sha1> upstream.
> > >  
> > > +or alternatively:
> > > +
> > > +.. code-block:: none
> > > +
> > > +    [ Upstream commit <sha1> ]
> > 
> > Can this just be:
> > 
> >   or alternatively::
> > 
> >     [ Upstream commit <sha1> ]
> > 
> > That extra RST markup just clutters things without any advantage.
> 
> Btw, after revisiting, I think Greg actually can pick up the first
> version of the patch. Changing the above without adding the
> code-block:node will reformat the
> 
>      [ Upstream commit <sha1> ]
> 
> differently when rendering to html.
> 
> Greg, so as the patch has not yet been commited, can you pick up the
> first version from
> https://lore.kernel.org/lkml/20220809045543.2049293-1-carnil@debian.org/
> ?

Please resend it as v3 so that our tools don't try to apply v2.

thanks,

greg k-h
