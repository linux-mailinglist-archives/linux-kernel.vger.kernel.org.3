Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794CF573AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbiGMP4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbiGMP4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:56:07 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F286250041
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:56:06 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id j3so1777341oif.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=WkSQGMlzkcg7F25RRv5rghI0mHalOBr7A56+aczRN84=;
        b=TokE2vNEcYXOMc500qMsLWmfRFBNAnA2uXvm+HMyhAe7V5c3ZxWMyZwZjtBi0haXR8
         HGp/59n2cy5qMOW13Jyx/nBGhBVCuc6cMJxHpAoFEJJ9MFF04rbMfzejGcBRYpGcHnDF
         uU/p+EDK/T7/nTWm44yWdQkH6kFZhK08PL4dZLmzKRWuJE5MivwpMoBoBnqbLRiCWJJ+
         9O6zXKo+ZRqjSyBM1B1rzvxLRRI5TZ7k3QfmKYp9djPkN3F9qDEdRSE8FJC0YsaPaCBb
         o4Xv5RiCw4ZJycv+SCfQBsaKaSOy8KzJnrn7cuMWTP19XQJ88fmZHW5gvIwV5cuR82X+
         iPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=WkSQGMlzkcg7F25RRv5rghI0mHalOBr7A56+aczRN84=;
        b=Qax+1LpOMXZYTfWakWiGkGyiqow3VPAyAMMK51OGVYeGLBNy8HvTOAFdlY3/FKUxrh
         yB1vEx9oNiZRNyannGaQvw3OgqWMg83kpRIaCAqn9+pdIJgNLXuZwHKfreXMBU0bdyCi
         Akll/+/pwTcY9Vlmp3GTVQF7FXyIgSpRZLzBRvKkLNMN6U//h7AXrD0/f8d/bPBiUBYA
         0UlTvK22Cz7YAavUox7EXD2TW50zTjnic8FBv6ZDYuqoXmzyIPmDonj/GtjVHSdmYqAg
         +86aHCHz//5wetFiynOqH7jgMrCXF7j+U1NVD1niWnNf5fZ+v3d8tkWZTqVJIoU9G/1X
         f4Hw==
X-Gm-Message-State: AJIora93yRrMMvFxQr3hRltrkFxjk2mHrkTzx+/zSSs+vqcY3/IZ8TWp
        9jtine1VjoBCfbAwx2fJ5mdvOA==
X-Google-Smtp-Source: AGRyM1uf0Tdw2UqbBNRwyWQHGpfHBB44kcUu4QCB3PbjhmzP3bihR91dHuYa4cms3heNmXYpoaGk7A==
X-Received: by 2002:a05:6808:19a5:b0:335:cffd:b276 with SMTP id bj37-20020a05680819a500b00335cffdb276mr2134313oib.226.1657727766210;
        Wed, 13 Jul 2022 08:56:06 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q16-20020a9d7c90000000b0061c35e7aceesm5016860otn.42.2022.07.13.08.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:56:05 -0700 (PDT)
Date:   Wed, 13 Jul 2022 08:55:53 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Liam Howlett <liam.howlett@oracle.com>
cc:     David Hildenbrand <david@redhat.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] maple_tree: Fix sparse reported issues
In-Reply-To: <20220713132926.3sl7gs67dyjj7kit@revolver>
Message-ID: <44a478e8-2ccc-e82-bd5a-172778c01529@google.com>
References: <20220712142441.4184969-1-Liam.Howlett@oracle.com> <653cc1da-e45a-9a93-7158-cee3e710ba35@redhat.com> <20220713132926.3sl7gs67dyjj7kit@revolver>
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

On Wed, 13 Jul 2022, Liam Howlett wrote:
> * David Hildenbrand <david@redhat.com> [220713 04:34]:
> > On 12.07.22 16:24, Liam Howlett wrote:
> > > When building with C=1, the maple tree had some rcu type mismatch &
> > > locking mismatches in the destroy functions.  There were cosmetic only
> > > since this happens after the nodes are removed from the tree.
> > > 
> > > Fixes: f8acc5e9581e (Maple Tree: add new data structure)
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > 
> > Sorry to say, but the fixes become hard to follow (what/where/why). :)
> > 
> > I guess it's time for a new series soon. Eventually it makes sense to
> > send the fixes as reply to the individual problematic patches. (instead
> > of fixes to commit ids that are not upstream)
> > 
> > [yes, I'll do more review soon :) ]
> 
> I appreciate the feedback, it's much better than yelling into the void.
> I have one more fix in the works - for __vma_adjust() of all functions
> so that'll be impossible to follow anyways :)  I'll work on a v11 to
> include that last one.

Please do also post the incremental for that "one more fix" once it's
ready: I have been keeping up with what you've been posting so far,
folding them into my debugging here, and believe we have made some but
still not enough progress on the bugs I hit.  Folding in one more fix
will be easy for me, advancing to v11 of a 69-part patchset will be...
dispiriting.

Thanks,
Hugh
