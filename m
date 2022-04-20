Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991CC50818B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351695AbiDTHAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350625AbiDTHAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:00:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B433526F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YPzpNFwfMxcQ3d+BB5WrKajsMYmCUuQAh/UeGoRBLqQ=; b=MD0Db92tQu7MRh3cWD6F+yor1S
        5hC9Oidrll7q5JVVnscNaZrh7kaeLkAX6RB2hpz+QyfoCKjGbiUFfYLf8WouXQowbe34PWH6Zfm64
        /rDlt6fSJKBtVc3xmVdWPBRVPGVpnvQd+ysLw3oAZSzy1ZwZgTGgjdTxwaz3M3W3+ZwlE+zjqt8UU
        3B/J+zsghV3TF2f/vb1+Pdcl/MDmRLd+qpRtr23tdue1khcvQRa7vsVpwurXoi/eHEqkRECJRCBjN
        x7p22J56IPdw0jYK45aRyFr/Ig+FkzQBMg86k5v70UjSdrPtMXkVfCEzKFB9C/HwbfaBdylBKBlUf
        nDJa83VA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh4HC-0072p3-Mx; Wed, 20 Apr 2022 06:57:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 98F219861A4; Wed, 20 Apr 2022 08:57:20 +0200 (CEST)
Date:   Wed, 20 Apr 2022 08:57:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 2/2] objtool: Fix code relocs vs weak symbols
Message-ID: <20220420065720.GA2731@worktop.programming.kicks-ass.net>
References: <20220419203254.034493341@infradead.org>
 <20220419203807.655552918@infradead.org>
 <20220420021601.kiughdji3avh2uua@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420021601.kiughdji3avh2uua@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 07:16:01PM -0700, Josh Poimboeuf wrote:
> On Tue, Apr 19, 2022 at 10:32:56PM +0200, Peter Zijlstra wrote:
> > +	/* XXX create ? */
> > +	if (symtab_shndx) {
> 
> Not sure what this comment means?

I'm not sure if we will trip the case where the input ELF will not
have/need the extended table, but our output file would need it.

That said, upon thinking about it this morning, it wouldn't be this code
path triggering it I think.

Specifically, we only create section symbols for text sections and
objtool doesn't generate text sections (you've talked me out of that).
So the number of text sections doesn't change, so section index number
shouldn't increase due to all this.
