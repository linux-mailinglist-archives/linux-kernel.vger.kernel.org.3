Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E550D5695E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiGFXdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiGFXdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:33:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047A42C135;
        Wed,  6 Jul 2022 16:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+ziVL8l45N1j8hHSl9LgmfhnTA7yOdWor6E4r8/k7yg=; b=UH/OkfVs7Cpj/LrUgT0DHqZLoi
        S7s1dgLIMpSKGh48el+4LoYQfgSeyCS9ZMSXx/0pvWGHVKnMhhXPuCmRFtItIy4LadtG9Z/+2Ybd+
        dmeABV+cOZC2tgvQEFkUbrKC4OBqEgIhMyW7e/51PoY0Lm7pRK0frAfGfTB4xNuMVg0kfYQXuFnrh
        uo0gJMxkwfqXOyI5UlFWAcLrN8uy8lIn/Nsy+Zu1n5XIUUM7R5o+VX/TXotM0SUDJla/6ElxsdvKH
        /CqaunG0R0DfE5gkROjyLtb8vE0CWih8lrUYA8kdoA3XfjomaTg1D3Vkhi6KkvSGmjtPHnLcVdhAu
        SzQF3bEQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9EWU-00ClG8-VB; Wed, 06 Jul 2022 23:33:34 +0000
Date:   Wed, 6 Jul 2022 16:33:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] module: Show the last unloaded module's taint flag(s)
Message-ID: <YsYbzgnO2KL9eFvc@bombadil.infradead.org>
References: <20220627164052.2416485-1-atomlin@redhat.com>
 <20220627164052.2416485-2-atomlin@redhat.com>
 <4ddb64da-58f0-a4af-cf57-a870015a0077@csgroup.eu>
 <20220628074708.fg3ocx3vu7affkxl@ava.usersys.com>
 <20220703142218.65dacvxozppgct6y@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220703142218.65dacvxozppgct6y@ava.usersys.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 03:22:18PM +0100, Aaron Tomlin wrote:
> On Tue 2022-06-28 08:47 +0100, Aaron Tomlin wrote:
> > On Tue 2022-06-28 05:54 +0000, Christophe Leroy wrote:
> > > > -	/* Store the name of the last unloaded module for diagnostic purposes */
> > > >   	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
> > > > +	strcat(last_unloaded_module, module_flags(mod, buf, false));
> > > 
> > > You replace a bounded string copy by an unbounded strict contat.
> > > 
> > > Should you use strlcat() instead ?
> > 
> > Hi Christophe,
> > 
> > Why? If I understand correctly, both the destination and source string are
> > NULL-terminated (see module_flags()). So, strcat() should be sufficient.
> 
> Hi Luis,
> 
> Any thoughts on this? As far as I can tell, the destination string cannot
> be overwritten; albeit, I can use the safer option if you prefer.

Yeah I don't like this as-is, it makes it not so easy to follow, I'll
reply in my review of your patch now.

  Luis
