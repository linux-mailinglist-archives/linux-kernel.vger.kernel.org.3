Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4924CC589
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiCCTBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiCCTBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:01:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0142719F452;
        Thu,  3 Mar 2022 11:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mYrrOG/s2mjfio75s3dq/dKVQ4hb6AKuIgv4XF18k5o=; b=puVBQooXBZePIB2vmMTSbXd57s
        p17MgatBJCjBKtRJ+UT1TBodIBURDW/LOhzMJ50muFzytAz8XxJ/BrFPLQ4prU8hIxdCLVJ2wCJH9
        TZlwm3rAbg9eJGfQi+uBcbCqS9bstks2nG8cEyx5xEVVy9hZXbSACSKhfmtrS1JMAIGb2Nm7ujVm7
        fEAr2epRFpKIzcV4yR7wr7k0C5+ORqH73Md/qogC3eWDJmwJbhh+WbqhyOkk/cvqdd1G8emGY0Wq+
        IUDmTg9cCbO+gDzXRygN3zXeeV05WeYo1IodMQrwzObhU5ZJHPFZoUt5BlHoU/WrJzCmPcW0I4q74
        EvEhJhzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPqgl-007WTc-Tq; Thu, 03 Mar 2022 19:00:35 +0000
Date:   Thu, 3 Mar 2022 11:00:35 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <YiEQU37pZgjaeT8k@infradead.org>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
 <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
 <YiDEmRf3X0fxSayK@infradead.org>
 <20220303145949.inaz2tecmfuek2hf@maple.lan>
 <YiEAxgVYx552UQFS@infradead.org>
 <5b582422-ef36-009e-7cb7-b85b5022c9aa@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b582422-ef36-009e-7cb7-b85b5022c9aa@csgroup.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 06:16:58PM +0000, Christophe Leroy wrote:
> Well .... The idea at the first place was to get rid of the #ifdef 
> CONFIG_KGDB_KDB in modules.
> 
> Here you propose it the other way round. Why not, in that case that 
> would mean a dedicated file in kernel/module/ as part of the series 
> https://patchwork.kernel.org/project/linux-modules/list/?series=618917&state=*

With the series you can of course move it to a new kernel/module/kdb.c.
But I don't have a tree with the series applied at hand and just want
to show how kdb_lsmod can live outside of kernel/debug easily.
