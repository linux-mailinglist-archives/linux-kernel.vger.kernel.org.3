Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B300508BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379944AbiDTPZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380181AbiDTPYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:24:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567B9457A8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o5T9nq6itiWdeOCklnIj5wtBwKLc6I38VgoBSfyzY8c=; b=A0YpIo9MeVP516pMQlK26uzSI4
        b6ccpDwNfeJzycbPyHdlKqM7v54iE9XINt2FLLDrNbdzQzHdQzgdQHLXE1blgbSD2XUYUizIDqSuO
        oPPuhGFed1f1uqwOnaPn1xuP63GS1V/muFL1TMNI/bfJw/4Rwus5BBwiUgbP05e8LUViW0UnjLSFz
        tUlnXiOImWsGITNi4vHKfFzCvuOENmMOD9d4AvpqGXo8rhYayTNtJsfhowMY7LWBKaTqrgX9Ibob5
        gB0dSFJiS7P3DD3gTAXpDDZYZ+5C2jHF9QUIaWgvPqCs/CpEa27HWWZXIIOgBfm7gZXZ8r32W4aOa
        RLnn0w8g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhC9C-009YRZ-UU; Wed, 20 Apr 2022 15:21:38 +0000
Date:   Wed, 20 Apr 2022 08:21:38 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>,
        Vimal Agrawal <avimalin@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "wedsonaf@google.com" <wedsonaf@google.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "void@manifault.com" <void@manifault.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        Onkarnath <onkarnath.1@samsung.com>
Subject: Re: [PATCH 1/1] kallsyms: add kallsyms_show_value definition in all
 cases
Message-ID: <YmAlAvy6aSeeJKoO@bombadil.infradead.org>
References: <YlaWxh5qYCe40US7@alley>
 <20220413055305.1768223-1-maninder1.s@samsung.com>
 <CGME20220413055318epcas5p3df3cdde54a559d4002a74de9f23289f2@epcms5p5>
 <747830777.1512786.1650256482294@mail-kr5-3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <747830777.1512786.1650256482294@mail-kr5-3>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 10:04:42AM +0530, Maninder Singh wrote:
> > What about splitting kallsyms.c into two source files where one
> > would be always compiled? It would be usable also for the
> > spring function introduced by
> > https://lore.kernel.org/r/20220323164742.2984281-1-maninder1.s@samsung.com
> > 
> > It might be something like kallsyms_full.c and/or kallsyms_tiny.c.
> >
> 
> This patch is not taken by Luis yet in module-tetsing branch.

Please resend that patch, as I'm happy to route it in through
modules-next [0]. I use modules-testing *prior* to pushing to
modules-next, if 0-day does not complain after about a few days
then I push to modules-next and this gets merged to linux-next.

You can send that patch and then this one and include in the subject
something like:

[PATCH modules-next 1/1]

Vimal, I'd like your review of these patches too. And after those
we can see where your change fits / if it is still needed.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next

  Luis
