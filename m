Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F42253C130
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 00:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbiFBW73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 18:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiFBW71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 18:59:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D6F1DA77;
        Thu,  2 Jun 2022 15:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=myZAuCtS59zOB4ceDtZuHs2CQEeRbLXKVl+Lui0wcjw=; b=ef/BwSpwHb8VH9+oHumHZAXIEw
        qO5Q6ss080yRYumaDKapV2V+s80qJkaW0/A7Pvh6CB2/TdAuCPAIq41fM1JEcXJGTrG1Z6b7UbYdW
        ciY2erkAfemqDy8TWtn2OnlZcas3i4dOxYyGDDDBCh+ViXhoGE0B+Ao5pTrZGtNaqrYuC9thy9cKD
        nyVJzK5wflo54w2WaChghCxfPve0dd0xjAGelBt6/UyCscBeg41YDpZXstnFMtHIPyjlJyX0MXYkV
        uzls3F9KxygJfkMipzlOsv6tSxXViun9K6v6dmIgOYzVk4kbO5HgZFiQkOASEWCBWIU0dlY2iIPFg
        tA3dMl1A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwtme-0054Wf-K2; Thu, 02 Jun 2022 22:59:16 +0000
Date:   Thu, 2 Jun 2022 15:59:16 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Aaron Tomlin <atomlin@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, Allen Pais <allen.lkml@gmail.com>,
        Joe Perches <joe@perches.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jason Wessel <jason.wessel@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v1] module: Fix prefix for module.sig_enforce module param
Message-ID: <YplAxCvRiNnthK6d@bombadil.infradead.org>
References: <20220322140344.556474-2-atomlin@redhat.com>
 <20220602035653.4167316-1-saravanak@google.com>
 <YpkMelZC+E5hKTw6@bombadil.infradead.org>
 <CAHk-=wit6ttmzdFsbH+YLkMeLucTspYADHnENn4fBXNrit0BUQ@mail.gmail.com>
 <CAGETcx9f5BiojqU6wr29eUrYr9s8k+CGj_t-7RvrTSmDm6WwJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9f5BiojqU6wr29eUrYr9s8k+CGj_t-7RvrTSmDm6WwJw@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 02:47:04PM -0700, Saravana Kannan wrote:
> On Thu, Jun 2, 2022 at 12:41 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Jun 2, 2022 at 12:16 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > Linus want to take this in or should I just queue these up?
> >
> > I'll take it, and remove the unnecessary #ifdef/#endif. The #undef
> > might as well be unconditional - simpler and doesn't hurt.
> 
> Sounds good. I just copy-pasted how it was done elsewhere. Luis was
> mentioning adding a wrapper to go this cleanly and I needed it in
> another instance too. So I'll look into doing that in a future patch.

Virtual hug, or something hippie like that.

  Luis
