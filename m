Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD064FA54F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 08:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbiDIGKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 02:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiDIGKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 02:10:53 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3435046670
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 23:08:46 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id bk12so6459966qkb.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 23:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=6aEcwmX5AHIuIeFqcYJ9jTFQjBEYXnOc4Olxo6nl8Es=;
        b=NqAdYhsFyqCpaZalKL8cZvkb0ebp2WuRLeZVDMBV9dnaLsD0hT6aMMQ1x2Gpg5345G
         +yO4oDYXUKqFAIV1Ac/DSJnN2zXSNk8YNat0v8IReqw/zVBgK8uPe1r4NjZWVWpybJU8
         dxf17wqIuahDlUYc1qEYdIrSo3YAZW/0uhEIvBdge44SZvyrjc/FGu+9F30AUhpazNQM
         UFO3izbcSbwR/kjPjgh+nyLiXzzlrRhudOVIhUrYpHG12yE+zu6lyoM90VBvW0GkHG6I
         ycykZh/XGWDW1qht46NE/BNnl/k2pgdvpjPmGyaU5zqIq52WH9JWnyILe48+6gOEaknW
         tGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=6aEcwmX5AHIuIeFqcYJ9jTFQjBEYXnOc4Olxo6nl8Es=;
        b=cXWX21bswGWH4LP8zBlUoeoYxdX6aPXnne8+zFyoZboy7HEZ1jdfOF2vfYQl+GKbkW
         uspzRuunG0Dw3Z15pG64CO9TD7coKA9WxkxPooPkhgXUcWUiwD2CeZHdC0TRdWdPFkS5
         nkjjFtAICn0ds2yguG6Z18QvYkV6CKXprxdBB7zedlrpVB1QATKhG19wCVi7BwBwAsYN
         6gRH07OUN1N/pKb/AD2oBMaM0vCA1bx6mVSlA5YGwsyKkEP6WeMOiMkx+q8pFCgdu5ox
         ObDm0hFW34FzylQzkvlj4NRCLkjx2xo42xua72Lo5R3rk67CvVZDFYa/uLK/jhagZxlU
         9FMw==
X-Gm-Message-State: AOAM530XQpC9x3hKNstdhW+xPCSBr5myXEJHm6UD+NQRFw+Gv3Pxkmrp
        0WJYDxJl+CyTTGOjwoy7tvdEGw==
X-Google-Smtp-Source: ABdhPJwB4d7Ufi4cN4i+wikQ8L0VsgopVFCWZFF2+UtgD8fK4o0ibgOxwGW6k02yNhdIRgCp/83Ksg==
X-Received: by 2002:a05:620a:d87:b0:67b:311c:ecbd with SMTP id q7-20020a05620a0d8700b0067b311cecbdmr15327968qkl.146.1649484525161;
        Fri, 08 Apr 2022 23:08:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p5-20020a378d05000000b0069beaffd5b3sm1849345qkd.4.2022.04.08.23.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 23:08:44 -0700 (PDT)
Date:   Fri, 8 Apr 2022 23:08:29 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Christoph Hellwig <hch@lst.de>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Mark Hemment <markhemm@googlemail.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Borislav Petkov <bp@alien8.de>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] tmpfs: fix regressions from wider use of ZERO_PAGE
In-Reply-To: <20220409050638.GB17755@lst.de>
Message-ID: <f73cfd56-35d2-53a3-3a59-4ff9495d7d34@google.com>
References: <9a978571-8648-e830-5735-1f4748ce2e30@google.com> <20220409050638.GB17755@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Apr 2022, Christoph Hellwig wrote:
> On Fri, Apr 08, 2022 at 01:38:41PM -0700, Hugh Dickins wrote:
> > +		} else if (iter_is_iovec(to)) {
> > +			/*
> > +			 * Copy to user tends to be so well optimized, but
> > +			 * clear_user() not so much, that it is noticeably
> > +			 * faster to copy the zero page instead of clearing.
> > +			 */
> > +			ret = copy_page_to_iter(ZERO_PAGE(0), offset, nr, to);
> 
> Is the offset and length guaranteed to be less than PAGE_SIZE here?

Almost :) The offset is guaranteed to be less than PAGE_SIZE here, and
the length is guaranteed to be less than or equal to PAGE_SIZE - offset.

> 
> Either way I'd rather do this optimization in iov_iter_zero rather
> than hiding it in tmpfs.

Let's see what others say.  I think we would all prefer clear_user() to be
enhanced, and hack around it neither here in tmpfs nor in iov_iter_zero().
But that careful work won't get done by magic, nor by me.

And iov_iter_zero() has to deal with a wider range of possibilities,
when pulling in cache lines of ZERO_PAGE(0) will be less advantageous,
than in tmpfs doing a large dd - the case I'm aiming not to regress here
(tmpfs has been copying ZERO_PAGE(0) like this for years).

Hugh
