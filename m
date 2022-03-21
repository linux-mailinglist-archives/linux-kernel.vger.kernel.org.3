Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8966A4E2F23
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbiCURhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbiCURhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:37:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCEDE997B;
        Mon, 21 Mar 2022 10:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xNztFLfAKakM0DGCcou0dwOb3TGczIfFI6hfjoe/2aA=; b=kNIkVF2ASw/Gi/ZX4fijCmOMjc
        LhV1WK/4eHogOl97NTkibv6bwnkLplqbRaxUDmYPDRlKJxyZs1PhMRIxuQN+uSxwRhkzZb66WprtD
        pDVrIbiARITAuKXvkRaUMbH/yGnGOJqiZaGUz6Fs8Tcxk3eTYNUEcBUU7mjZlbxYoHPhCHNsh//RG
        DCU+AcgS6wlgfygL7ZAEPpzWqeX4rNwAXvnUpdfo3T2Yd/OmxWCyOkLoaRgJaQozFsBPkJm6yQMab
        FHhvPj7y/p/Egu+oHh20QIu3qTUlCe6VD4jCq7IUO+oMyrWFyfz0m7q7b6lADUOvhiAOCg7wWLVUT
        VYydh5Uw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWLwY-008dhX-Fw; Mon, 21 Mar 2022 17:35:46 +0000
Date:   Mon, 21 Mar 2022 10:35:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Maninder Singh <maninder1.s@samsung.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "v.narang@samsung.com" <v.narang@samsung.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "avimalin@gmail.com" <avimalin@gmail.com>
Subject: Re: [PATCH v3] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Message-ID: <Yji3cqifyTf2SCxQ@bombadil.infradead.org>
References: <CGME20220315155109epcas5p249963f50d68ee368edb569b1a9e7d63c@epcas5p2.samsung.com>
 <20220315155100.516107-1-maninder1.s@samsung.com>
 <YjDScHjMUbqYV4s4@bombadil.infradead.org>
 <62c74547-deb0-539a-c1cc-64b2ac334c94@csgroup.eu>
 <YjGe961XL8GW7Qeh@bombadil.infradead.org>
 <20220321133942.pbv7vvkn5r62ky5x@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321133942.pbv7vvkn5r62ky5x@ava.usersys.com>
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

On Mon, Mar 21, 2022 at 01:39:42PM +0000, Aaron Tomlin wrote:
> On Wed 2022-03-16 01:25 -0700, Luis Chamberlain wrote:
> > I know this has been quite a bit of churn, but given Aaron's series I
> > really hope we're goint to be in a better place for maintenance for
> > modules long term.
> > 
> > I guess I gotta go automate tests to these things somehow too.
> 
> Hi Luis,
> 
> I can send a v12 now if you'd like?

Sure, yes please, go for it, please be sure to collect all other
Reviewed-by/etc tags.

  Luis
