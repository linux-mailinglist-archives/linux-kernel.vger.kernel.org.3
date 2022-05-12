Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B625B5254E2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357592AbiELSc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351879AbiELScV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:32:21 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB69E63523
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=O8SS8tR6KzBteRzzV4PMFZxsbdP8o7OvOren4W79nuw=;
        b=h7ZNvfc9avhDt9okNYnG1IgGZnDItoaBEkXyNthysrfKmHtpKX7wDWuLH5KG3Iywu8NOqH+7WLZuQ
         MnpkF89PW8JzZGoE9JLyR4KdVe9+bAIYLiQD136jCrzGp1k40JxdtVhEBk+nwb0x05k3DYqZbisrtN
         j7e8ukhv08m6oq7+6e997j5AUB/8ZG9VCcIwetPEOJ79RTTWLJN5BJVTJ8vu0jjAIAoUQDxxRoisSM
         N9jq5+4/VB+uvogOuIBEU7O4qJ6SWpuYQfYfWmyBsnBRbTuI/CKD25yCMVv/UqT9ugfVLoLuE/snxf
         nLO3Tp7gs3zv/RGajEZVV0pxKdWv1hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=O8SS8tR6KzBteRzzV4PMFZxsbdP8o7OvOren4W79nuw=;
        b=F+p45EAMDelLJaqsvbV923D4aMqVja+yHAlwwJJfG5Uvo2AxRvdFs4aw7v7EuZqlp1V4TsAC7Wad2
         dnMPZyUAg==
X-HalOne-Cookie: 9bbbb5e34672ef539628ef080ed8275be782a0a2
X-HalOne-ID: d92e617e-d221-11ec-822c-d0431ea8bb10
Received: from mailproxy3.cst.dirpod3-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id d92e617e-d221-11ec-822c-d0431ea8bb10;
        Thu, 12 May 2022 18:32:16 +0000 (UTC)
Date:   Thu, 12 May 2022 20:32:14 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        linux-staging@lists.linux.dev,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: Re: [PATCH v5 7/7] fbdev: Make registered_fb[] private to fbmem.c
Message-ID: <Yn1SrtRHIjapcIjp@ravnborg.org>
References: <20220511112438.1251024-1-javierm@redhat.com>
 <20220511113230.1252910-1-javierm@redhat.com>
 <YnvrxICnisXU6I1y@ravnborg.org>
 <8c84428c-2740-4046-74c9-298b854944d0@roeck-us.net>
 <48f164af-99d2-9e74-e307-003be0677384@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48f164af-99d2-9e74-e307-003be0677384@redhat.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 07:34:38PM +0200, Javier Martinez Canillas wrote:
> Hello Guenter,
> 
> On 5/11/22 19:17, Guenter Roeck wrote:
> > On 5/11/22 10:00, Sam Ravnborg wrote:
> 
> [snip]
> 
> >>>   struct fb_info *registered_fb[FB_MAX] __read_mostly;
> >>> -EXPORT_SYMBOL(registered_fb);
> >>> -
> >>>   int num_registered_fb __read_mostly;
> >>> +#if IS_ENABLED(CONFIG_FB_OLPC_DCON)
> >>> +EXPORT_SYMBOL(registered_fb);
> >>>   EXPORT_SYMBOL(num_registered_fb);
> >>> +#endif
> >>
> >> It is stuff like this I refer to as "ugly" in the comment above.
> >>
> > 
> > My "solution" for that kind of thing is to use a namespace,
> > such as
> > 
> > EXPORT_SYMBOL_NS(registered_fb, FB_OLPC_DCON);
> > EXPORT_SYMBOL_NS(num_registered_fb, FB_OLPC_DCON);
> >
> 
> Using a namespace in this case is indeed a great idea I think.
> 
> I've used in the past to limit the export of a symbol for within a driver
> that could be scattered across different compilations units, but it never
> occurred to me using it to limit symbols exported by core code.
>  
> > and import it from the offending code. That avoids ifdefs
> > while at the same time limiting the use of the symbols
> > to the expected scope. Of course that could be abused but
> > that abuse would be obvious.
> >
> 
> Agreed. For the next revision, besides using an namespaced export symbol
> as you suggested, I'll include a comment to make clear that it shouldn't
> by any other driver and FB_OLPC_DCON fixed instead.
A very nice compromise, thanks Guenter and Javier.

	Sam
