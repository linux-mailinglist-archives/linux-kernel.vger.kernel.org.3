Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3EA500806
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbiDNIMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiDNIMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:12:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B67519C08
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p562gwZdESlOTvZY/nqTuWBbEiuD+th1wpA15toB0bM=; b=kAg4Wa6o420+Xcx2dLJY5a4yvh
        qzRe7XLg96YEfU6YukVu283Ivf3AkzHj9VB9+mVGz2LavJQiWOo2elb/qB/iA0i+yijh9PjUZ8gnn
        vGRH1PGx1HxA5uJA/fdm7S3sg5qOKxYtpKPbW+ZkWSr10ScQQEaMHzb7YHFklAY9uhYBEEtJGkzA0
        W6uX7vfFD+ChhLQH/7cVJDZ9hTIKOWu3asmBVob6MaAmMHK/m85NMd9m4PccEeCRDbUnNGFCZ9qnc
        QRE4/cF1RCvfs6SG9OdOKvIo4iEpYEZzI0tXSad56aZELhBQaw+kxzWV73KcFbaNy4a1JPvvqMEbG
        0eoX0wQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neuXz-004x74-SQ; Thu, 14 Apr 2022 08:09:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52DAD3000E3;
        Thu, 14 Apr 2022 10:09:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3785D2C5BC384; Thu, 14 Apr 2022 10:09:46 +0200 (CEST)
Date:   Thu, 14 Apr 2022 10:09:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 14/18] objtool: Add toolchain hacks cmdline option
Message-ID: <YlfWynPt6MGR5BZP@hirez.programming.kicks-ass.net>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <e04ec8f01fcb537675d6bd94ef65103a0a749318.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e04ec8f01fcb537675d6bd94ef65103a0a749318.1649891421.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 04:19:49PM -0700, Josh Poimboeuf wrote:
> Objtool secretly does a few awful hacks to overcome toolchain
> limitations.  Make those hacks explicit (and optional for other arches)
> by associating them with a new '--hacks' cmdline option and
> corresponding CONFIG_HAVE_TOOLCHAIN_HACKS.

Should we either clarify the specific hacks done, or split this in two
options?

  --hack-jump_label
  --hack-noinstr
