Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A3E518E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiECUSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiECUSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:18:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54A321254;
        Tue,  3 May 2022 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8G1IgSRjljB7m3TLcuv2mglJ8lKom48WHW6y+t8C30A=; b=a0xQ5Px9cKZmn5VfqnS+1U8U31
        Aavv0T2vCXaU6HbVqdNOx0Q+amGaxchEXkgA1g7/+a5SBrei82teCEduBCWV8EakaSxgoM6pqedTX
        G1Aew6/Pm5dUHBEF2v1puzq2LizypyhNVoS99YKYoyfi5iKhmPuRuGZrm+P+CFHmWRiNXi6v5ANQ1
        496kJwKw0e4lbevpmRo9GkTRIQ+zPekl7KIt7sp9x8xWd+rfAEGz9t2ru7kBIu6y+ksTpPh6t8g5p
        ve45eZu71/paO9V2kerEdvjWRAXuPwBfrlQHePteAQqwp+Buu7kjFlMPTJagLQSOPJ40oolTgnUXA
        CmnvFptA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlyvI-007Wqk-Dn; Tue, 03 May 2022 20:15:04 +0000
Date:   Tue, 3 May 2022 13:15:04 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] module: fix [e_shstrndx].sh_size=0 OOB access
Message-ID: <YnGNSNcUbkwLNWNd@bombadil.infradead.org>
References: <YnFC93NVRqOterbV@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnFC93NVRqOterbV@localhost.localdomain>
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

On Tue, May 03, 2022 at 05:57:59PM +0300, Alexey Dobriyan wrote:
> It is trivial to craft a module to trigger OOB access in this line:
> 
> 	if (info->secstrings[strhdr->sh_size - 1] != '\0') {
> 
> BUG: unable to handle page fault for address: ffffc90000aa0fff
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 100000067 P4D 100000067 PUD 100066067 PMD 10436f067 PTE 0
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 7 PID: 1215 Comm: insmod Not tainted 5.18.0-rc5-00007-g9bf578647087-dirty #10
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014
> RIP: 0010:load_module+0x19b/0x2391
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Thanks! Can you resend and Cc stable? This seems like an issue present for
a long time, can you identify the commit which introduced the issue?

  Luis
