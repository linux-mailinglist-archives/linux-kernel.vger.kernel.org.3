Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B72056A39F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbiGGN1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbiGGN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:26:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28451112;
        Thu,  7 Jul 2022 06:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bVv9WQG89TN8juBsNhKtamqi2Z2/Az5uoVuY81G7GUo=; b=DqNem0BHBG/Pj0KArFjfNORno1
        4HXSgi/mJEhvwepsIyt/Tf9NWOUxQOD3qySP47KqcXtaQAY48vHzI7/BhM4Gn3/L6cZ6KYTWch9F2
        jy8sVyPAp7p2dKyzoxCA0x0J+KR1CxeSoRleqhmut/OFYkNQ/yoAf3yXCDzMntuJAq7GNWuuOgC2f
        MddTPowrGMlGd/mmsE3UPI01Bqkv/mZxXYwxNtdqUijDn577u+QQ/rNL6NGINHZU8Vk2tYgjqZB8y
        /bJq1lSIvDUHRkuub3en7ww+RHFCMsw5qeh8d1V6XKGjD9KJ3Uv8J3+s5xwdwkCtAQlo88w6x6DAO
        OXbdXPkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9RWb-002bGB-Mq; Thu, 07 Jul 2022 13:26:33 +0000
Date:   Thu, 7 Jul 2022 14:26:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     xiubli@redhat.com, idryomov@gmail.com, jlayton@kernel.org,
        marc.dionne@auristor.com, keescook@chromium.org,
        kirill.shutemov@linux.intel.com, william.kucharski@oracle.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cachefs@redhat.com,
        vshankar@redhat.com
Subject: Re: [PATCH v4] netfs: do not unlock and put the folio twice
Message-ID: <YsbfCcNvjMVcT2yx@casper.infradead.org>
References: <20220707045112.10177-1-xiubli@redhat.com>
 <2520851.1657200105@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2520851.1657200105@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 02:21:45PM +0100, David Howells wrote:
> -					 struct folio *folio, void **_fsdata);
> +					 struct folio **_folio, void **_fsdata);

The usual convention is that _foo means "Don't touch".  This should
probably be named "foliop" (ie pointer to a thing that would normally
be called folio).

