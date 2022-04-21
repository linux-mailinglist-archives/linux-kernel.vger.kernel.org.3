Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDAF50AA33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbiDUUnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392532AbiDUUmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:42:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7524A2710
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0psPi+tRkYnMiK9FJemFMmEK3dwTlFRjOVKnBSUnjHg=; b=ZPL1dAy9LTmrQCQffc+qSQUV/7
        xVewuqER+jKOI2WazzXW4DR73RLDvPeumFDdkpRBe7eUcQjDZqUK2Z/xupv2uooBLXxt08XyGgd/u
        SnptgiKp/+OFCADTlzg8ODuPi21o6CXbYd5si83JG4qoVIVixpOK/a56nnP/iTxKlvWwhtauS2yW7
        eMlLZLh6+X1Wtp3XQco5+BnekDqbYMjrdIiOPI5YY0fp1p3LW3N00vMlMXlVoVrUiQ8MxbfTS1+xm
        kVL8WPSk25edqzgHJ6V1HA5hV1MWMbV0H1xbEZtjKBEvGnk3MsV4+2pmGl6E/dETj2wJt4j5LNHFK
        HHTcivfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhdac-005QtO-Id; Thu, 21 Apr 2022 20:39:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55B539861C1; Thu, 21 Apr 2022 22:39:44 +0200 (CEST)
Date:   Thu, 21 Apr 2022 22:39:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] scripts: Create objdump-func helper script
Message-ID: <20220421203944.GQ2731@worktop.programming.kicks-ass.net>
References: <4d3ab1f17230f0188698cfbc7ba08696fe1abfe9.1650474927.git.jpoimboe@redhat.com>
 <20220421085244.GL2731@worktop.programming.kicks-ass.net>
 <20220421173759.ijvytapqhoqpt22n@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421173759.ijvytapqhoqpt22n@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:37:59AM -0700, Josh Poimboeuf wrote:
> On Thu, Apr 21, 2022 at 10:52:44AM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 20, 2022 at 10:16:36AM -0700, Josh Poimboeuf wrote:
> > 
> > > +${OBJDUMP} -wdr $OBJ | gawk -M -v f=$FUNC '/^$/ { P=0; } $0 ~ "<" f ">:" { P=1; O=strtonum("0x" $1); } { if (P) { o=strtonum("0x" $1); printf("%04x ", o-O); print $0; } }'
> > 
> > Two noteworthy changes:
> > 
> >  - $@ went missing, I've occasionally abused that to add extra argument
> >    to objdump.
> 
> Just to clarify, you'd add the extra arg at the end like this, right?
> 
>   objdump-func <file> <func> -Mintel

Yeah, highly awkward, but it worked ;-)

> >  - you removed the glob after FUNC, I had that so that .cold and
> >    .constprop etc.. variants of the function also show up.
> 
> Sure, I'll match ".whatever" if there's a period, but not other
> substring matches, e.g. "put_page" shouldn't match "put_pages_list".
> 
>   {OBJDUMP} -wdr $@ $OBJ | gawk -M -v f=$FUNC '/^$/ { P=0; } $0 ~ "<" f "(\\..*)?>:" { P=1; O=strtonum("0x" $1); } { if (P) { o=strtonum("0x" $1); printf("%04x ", o-O); print $0; } }'

Ah, good thinking requiring that '.' in there. I just ignored the extra
gunk on the very rare occasion I got it.
