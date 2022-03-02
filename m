Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CCC4CB23A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiCBWZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiCBWZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:25:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0299E4D04;
        Wed,  2 Mar 2022 14:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v1SczNr2OUEGHMSVwtsfX7qgBkDv42hjsq6+9DG+f3s=; b=K4L+ARRy0jjeoDRYDxLSYJyoA2
        GPcd7AXGzjeySWNoJCkpTkgzq/BcZSkM1VAI+s1hk3pbUirP4FcDNLazxlZp0p4HWddoBCUtU+rPH
        Lk8utauxZusyL/AMGYlqusRpCJXYfAsw4nq5e2ve/M/lF6nsDPie3aQr7uztNZz+PZ7p0/zkpv+Qb
        rV/ZlJaltn6m2SvZxxttuIgux6NkihrWtbzqJ7y3Yr1lTp9RNc5/k7PIlrWe0uR3iuuG18dFicjO+
        slTEuQmb+GxHMszCRSkLstTE1WanMGs0nqATH4zJQhg2N+CTXnQnqQ0V3ljY3M/gQYKO/wraHAmv1
        iobOtIEw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPXOS-004Y56-Lv; Wed, 02 Mar 2022 22:24:24 +0000
Date:   Wed, 2 Mar 2022 14:24:24 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     pmladek@suse.com, christophe.leroy@csgroup.eu, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        atomlin@atomlin.com
Subject: Re: [PATCH v9 10/14] module: kallsyms: Fix suspicious rcu usage
Message-ID: <Yh/umIGw/xHnnd5r@bombadil.infradead.org>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-11-atomlin@redhat.com>
 <20220301165229.5pwxyhxonbw5za3i@ava.usersys.com>
 <20220302170202.lsz2mqmll6gshuwr@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302170202.lsz2mqmll6gshuwr@ava.usersys.com>
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

On Wed, Mar 02, 2022 at 05:02:02PM +0000, Aaron Tomlin wrote:
> On Tue 2022-03-01 16:52 +0000, Aaron Tomlin wrote:
> > Petr,
> > 
> > Any concerns?
> > 
> > Unfortunately, I didn't make enough time to test.
> 
> Petr,
> 
> $ sudo ./test-livepatch.sh
> [sudo] password for atomlin:
> TEST: basic function patching ... ok
> TEST: multiple livepatches ... ok
> TEST: atomic replace livepatch ... ok
> 
>  - dmesg output excerpt

Since you're going to send a v10 can you also add the livepatch
to MAINTAINERS? :) Likewise if you see other files which can use
help in maintenance review, let's go for that.

We're in no rush for the merge window as we'll be skiping the
next merge window. So all this just needs to be thought well
and tested well.

  Luis
