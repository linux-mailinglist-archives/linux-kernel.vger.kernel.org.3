Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1064B2D27
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiBKSvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:51:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiBKSvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:51:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9C6C57;
        Fri, 11 Feb 2022 10:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=3sNrvDB3rNMyyuKWpwJizMZf6xSVBkluN9d0sFD23FA=; b=VTsSsGV0LASax6uwYMo4HNtxqK
        pUygZ5H+essC12P0fpMnH82eVgGBxLlUfkrph7T2zHphgHJVvZTKA186Er5n/acrph5FuNxXRYrbM
        U0wYp9UfgZzHRinCnI4ybCXlqfxHoOe39gNEVVvT8IxUL1ZjOmCBaZ1En062C3TcURNpRWWW9WCwP
        4QrYk6qN27EflsKV7GQMBaOL/2KuIxfCi/nyPyoPN3wiMnjvmEdM3MiLPnRzFBh31/UCSvOEjy6ua
        ctFPlpM1cQiXkQlJlqpPiOdg5e1BVguuu64lAX3ciY4Vi6NDgtIa9+7raZgw7V+lHlBjJAAJ6b1f4
        TqkpqZlw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIb15-008TU5-4z; Fri, 11 Feb 2022 18:51:35 +0000
Date:   Fri, 11 Feb 2022 10:51:35 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boottime warning from todays linux-next
Message-ID: <YgawN2b1MOF7DN7g@bombadil.infradead.org>
References: <20220210184340.7eba108a@canb.auug.org.au>
 <20220210193302.686fa61a@canb.auug.org.au>
 <20220210214125.2b248790@canb.auug.org.au>
 <20220210222953.6e078d20@canb.auug.org.au>
 <YgWdbYfWgHP2jBmI@bombadil.infradead.org>
 <20220211123336.54eff9de@canb.auug.org.au>
 <YgW+DopXpFNZTj4k@bombadil.infradead.org>
 <20220211184647.0a62dad4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220211184647.0a62dad4@canb.auug.org.au>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 06:46:47PM +1100, Stephen Rothwell wrote:
> Hi Luis,
>=20
> On Thu, 10 Feb 2022 17:38:22 -0800 Luis Chamberlain <mcgrof@kernel.org> w=
rote:
> >
> > On Fri, Feb 11, 2022 at 12:33:36PM +1100, Stephen Rothwell wrote:
> > >=20
> > > Thanks for noticing that.  I have removed the old version from my copy
> > > of mmotm today. =20
> >=20
> > And ... does that fix your boot?
>=20
> Yes, the messages are all gone.

Fantastic, thanks for the confirmation!

OK so now a side independent curiousity remains though. Double sysctl
registration should not happen. But if someone introduces a bug by doing
that, it seems to not crash on x86. But it does cause a crash or a
kernel warning on ppc.

Why?

And I think we should just WARN_ONCE() for this case, and make the
issue clearer so that if it happens again, folks don't go scrambling
as if chickens running around with their heads cut off.

  Luis
