Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC8F56BDC3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbiGHP4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiGHP4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:56:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A51070E56;
        Fri,  8 Jul 2022 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HoXhP8EOLekBdBcy/x+v3URd54YeRxp4rSwpn2gqPfY=; b=h7dLsvTcMAcpFVOpTTt9EgcXLz
        YG+zs2fKUN8GjB0qd5UWx51u5SUzuUU5NhVd/YRyStMyrJ8iFJ9CW6EAydpZi5JzfBpXKAQSWPzpV
        WsttHDXZTcIDhpLhE9pB43otACAOryZGWgaZph9TUfXscVAVxavNOv08rJcE8UcfxOjF1ZzJEV4hA
        ky43E55V0pjs+vCJUhhqa8+662C/VKmgo1vHBKVQGSA+BTZjtKW89FhRoHgQD2Y2ifblnbe1spt8X
        QlAmqTFb5GZTrUhh9TljDfq5egeb5MDvOlDwVB7R1BNViSbXK4jNmlCDTDBpOd4ythp+2xuYCuk89
        TYin33qg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9qKW-003c8p-CP; Fri, 08 Jul 2022 15:55:44 +0000
Date:   Fri, 8 Jul 2022 16:55:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V4 01/20] rv: Add Runtime Verification (RV) interface
Message-ID: <YshTgMJcVBPuiEUN@casper.infradead.org>
References: <cover.1655368610.git.bristot@kernel.org>
 <60548902dbccaa7ba420e40e46835693e27f643f.1655368610.git.bristot@kernel.org>
 <YsXLDvjHqOxYtckg@geo.homenetwork>
 <YsXMEeqGr2vdJCa7@casper.infradead.org>
 <YshO5tSeNyFpNFc4@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YshO5tSeNyFpNFc4@geo.homenetwork>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 11:36:06PM +0800, Tao Zhou wrote:
> On Wed, Jul 06, 2022 at 06:53:21PM +0100, Matthew Wilcox wrote:
> 
> > On Thu, Jul 07, 2022 at 01:49:02AM +0800, Tao Zhou wrote:
> > > > +struct rv_monitor {
> > > > +	const char		*name;
> > > > +	const char		*description;
> > > > +	bool			enabled;
> > > 
> > > Can the 'bool enabled;' be put at the end like the definition of
> > > structure rv_monitor_def. If '8+8+sizeof(bool)+8+8+8' not the same
> > > as '8+8+8+8+8+sizeof(bool)', I mean is it possible that after the
> > > end of stucture there is a int or char not require to align to 8 as
> > > an example from my nonsense.
> > 
> > That will make no difference at all.  C doesn't allow other variables
> > to "fill in the hole" at the end of the structure like that.  For
> > example, one could legitimately do 'memset(&rvm, sizeof(rvm))',
> > and that would wipe out those other variables as well.
> 
> I mean if it is possible that if @enabled placed at the end of the
> structure rv_monitor will save some bytes.
> If @enabled place in between, the next function pointer which is 8 bytes
> will align to be in x8 address and the size of structure rv_monitor is
> larger than been placed at the end of the structure.
> Or the compiler can do magic that I can not guess.
> 
> Sorry for my late reply. I am not sure about this. But your reply is not
> about what I mean. You say that the size of structure is the same(I doute about this).
> But what my concert is that the other data next to the structure rv_monitor 
> how to align if placing the @enabled at the end.
> 
> Place in between, bytes:
> 8+8+8(padd)+8+8+8=48
> 
> Place at the end, bytes:
> 8+8+8+8+8+sizeof(bool)=?
> 
> ? is small than 48 and the data next to the data structure rv_monitor can use
> the saved byte which is the result of placing @enabled at the end of structure
> to place the data.

You don't need to take my word for it.  You can try it yourself.
