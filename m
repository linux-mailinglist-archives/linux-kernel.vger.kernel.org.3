Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3494CE06B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 23:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiCDWtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 17:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiCDWtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:49:00 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4171D0D57
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 14:48:11 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id f18so8708115qtb.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 14:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=5emkd5LN3iz45QwA5eikenlMR4B/YLdOVVv/kxARc4U=;
        b=BQJXzgwmnmO72nx2ay7XKV3KU0f1milmJfwfFQFTWJr1NrPt1uHy6Ks0NXfgVyW1ay
         GLwmiTFsG8Ax5LovsNGPaVXKc9sxFLhH6g1SnfoK4k7M0nuY2CusLoGlb+8b745do1iu
         QkZPdIPQs+LIG55flB+pi46y10ZZ145XaDOLfhbKikHxmPMHOWMlcj7BNPV+zVSYDcfV
         u1Y8RDMbUYFxXYvq6kPnRWpOapGlYh9r+FA1f8O27XwkQuiuuSXEtQGEtiuA77JCRtS5
         9FoHYvO36YzbwVVWQZwBoRvN5uVMZFNy8p2pMxfRlcgGh4yFH8VEHHgdZO3a5nCsbS6L
         vFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=5emkd5LN3iz45QwA5eikenlMR4B/YLdOVVv/kxARc4U=;
        b=Nez2LpgSdrVu90pK0M1Wc/BhYkS/FNG7P1kkALg8iUC9Om719qiS13kyXDOD6Hfa1w
         7FTNSis0LZDCG1dpFqYw70bsXCBFCpRLvPwo5tO6rFwNG+m7AwzjVm5RVDMm1dITBfvh
         KGcRfnZE0SXJBXgtKluAvua1NhAcoT/SC3GLCA4bhryjoQOT9Yls/6XqsrGUM4ibffH/
         i0QBMXkqn+fAQ7KNx/OP3WCmX5A+LhbRmyIoI0qNRZpCxMHgJ5ytPo8JDTEU7GMWs2gs
         xGP6ev5hOJrU6qS/COp8SZnegBDdcGObbKy4Yy6WFggwiocHWNBOO3xbqVqL8z92jp6r
         OL3w==
X-Gm-Message-State: AOAM533Pr0bMVznDWevauSbfRK+cf/abQkbLbPoaf6MdEuNH81Xc9mxW
        iSgUaVPZn5bKxxNT/OkSrlvUyLdOp+91oA==
X-Google-Smtp-Source: ABdhPJzGU5wfgg930jiiTt/2mcbEnL96neukBIFhR5li/iZLy7lw07ftq2X9E8tF71sAmeuA1cD/Jg==
X-Received: by 2002:a05:622a:14c8:b0:2de:175c:fa1b with SMTP id u8-20020a05622a14c800b002de175cfa1bmr891329qtx.543.1646434090542;
        Fri, 04 Mar 2022 14:48:10 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z3-20020ac87f83000000b002deae661c08sm4106469qtj.33.2022.03.04.14.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 14:48:10 -0800 (PST)
Date:   Fri, 4 Mar 2022 14:48:08 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Liam Howlett <liam.howlett@oracle.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
In-Reply-To: <20220304190531.6giqbnnaka4xhovx@revolver>
Message-ID: <6038ebc2-bc88-497d-a3f3-5936726fb023@google.com>
References: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com> <20220304184927.vkq6ewn6uqtcesma@revolver> <20220304190531.6giqbnnaka4xhovx@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022, Liam Howlett wrote:
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [220304 13:49]:
> > * Hugh Dickins <hughd@google.com> [220303 23:36]:
> 
> I just thought of something after my initial email
> 
> How does the ->set_policy() requirement on tmpfs play out for the
> mpol_equal() check earlier in that for loop?

It took me a while to page all this back in (and remind myself of
what is case 8) to answer that question!

The answer is that the mpol_equal() check at the top of the loop is on
an existing, unmodified vma; so it's right to assume that any necessary
set_policy() has already been done.

Whereas the mpol_equal() check being removed in this patch, is being
done on a vma which may have just been extended to cover a greater range:
so although the relevant set_policy() may have already been done on a part
of its range, there is now another part which needs the policy applied.

> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thank you, your review is very welcome (but mainly I Cc'ed to alert
you to how I'm probably stepping on your toes a little here - sorry).

Hugh
