Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9724F0495
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 17:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357398AbiDBPrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 11:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357387AbiDBPrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 11:47:35 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF3B164D22;
        Sat,  2 Apr 2022 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qrD3dLInNfleLqlGuKhkZmbWrdw03gFeC7x6uS63Upw=; b=fgT1s3C0m31iB+jxF8elaB2Ur1
        KV8NTuktgsQyRbCUN1IhPGKFP4jqRt2oYZReQr5NgEyzb3bxttifzIXyv/jqIUxDbN3eBvRyPc2Qq
        7360sHDlk9/k+xfzMUGKTUXq5fx//O8pvJmRA4dpwamuln78K+WBCTBaelhk5WFsYL9cICIMt2bVz
        PH7wr5YRIii8EPyI+/sD+0s0LyDJnlssn1tFVEkS2e0l+/steVQCDS6QzhO3pcNxq1ZZ8qJHGv69I
        L+xyI73E1TF7toXK+lRVsRKx/GjLccZtEsxr0iiC+qwUCTUmdy7DVF0h2DrHVIn8QXNKnqUHFia7C
        B2Ce7yig==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nafwO-001rxq-I0; Sat, 02 Apr 2022 15:45:28 +0000
Date:   Sat, 2 Apr 2022 15:45:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     cgel.zte@gmail.com
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        lv.ruyi@zte.com.cn, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] alpha: add null pointer check
Message-ID: <YkhvmH/eonkrT1M1@zeniv-ca.linux.org.uk>
References: <20220402083436.2413189-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402083436.2413189-1-lv.ruyi@zte.com.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 08:34:36AM +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> kmalloc is a memory allocation function which can return NULL when some
> internal memory errors happen. Add null pointer check to avoid
> dereferencing null pointer.

Why is that fix correct?  The only caller (module_frob_arch_sections())
has no way to tell we'd failed.  _IF_ ignoring the failure is the right
thing to do, the analysis needs to be covered in commit message.
