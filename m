Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4B74A8F56
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241531AbiBCUrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356596AbiBCUq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:46:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E4BC061182;
        Thu,  3 Feb 2022 12:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GdztUW9x+fNlUtnFtFu79iJaJ/d/JZTADTo3wiUu4gM=; b=x9OlGeOiYglbofGb2DmfMM2Oo9
        hss+jAkhZ0AARNGf568KH2t244lOnXoiaeDkHJh9y88XSCfM4zhuX/O1ioBRmln6FZ8C6LcvxurRn
        9BmgtvJh4O/xQJt5oCpe0LroEeYOhiR9ggMfxD+hCpj6XY8Tq+cFXyn9gzdRRPNndvGBKGm/V++RT
        f56uVTLAp09p4IhpQeRdFSMw/NxMS1bYkXbDtLOdXU1SGwYn5ymmgLTLui08mbPMHtzmJ64zVl0An
        p+vlKFaDtvUUgWMLwJ1bH8t5X1lTR/S94kMYPRbINNXfcsmdzm7HEZBnG/ol/aVX7WM9fYJ3HxNw/
        nqdt8xjQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFiyA-002piX-Io; Thu, 03 Feb 2022 20:44:42 +0000
Date:   Thu, 3 Feb 2022 12:44:42 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "atomlin@redhat.com" <atomlin@redhat.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] modules: Make module_enable_x() independant of
 CONFIG_ARCH_HAS_STRICT_MODULE_RWX
Message-ID: <Yfw+ulJ9mAT2tvvn@bombadil.infradead.org>
References: <203348805c9ac9851d8939d15cb9802ef047b5e2.1643919758.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <203348805c9ac9851d8939d15cb9802ef047b5e2.1643919758.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 08:23:25PM +0000, Christophe Leroy wrote:
> module_enable_x() has nothing to do with CONFIG_ARCH_HAS_STRICT_MODULE_RWX
> allthough by coincidence architectures who need module_enable_x() are
> selection CONFIG_ARCH_HAS_STRICT_MODULE_RWX.
> 
> Enable module_enable_x() for everyone everytime. If an architecture
> already has module text set executable, it's a no-op.
> 
> Only check end boundary if CONFIG_STRICT_MODULE_RWX is set, and
> make sure we entirely get the last page when the boundary is not
> aligned. When CONFIG_STRICT_MODULE_RWX is not selected, it is not
> a big deal to have the start of data as executable.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks!

Both patches look good to me! I can merge this once Aaron's
then your's and then Michal's KEXEC stuff gets merged.

  Luis
