Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E4A50D4D1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbiDXT0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238470AbiDXT0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:26:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EAF62A24
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:23:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b12so7666930plg.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=fwqOFLLrsgU55uAqDKEizrE8R/j0TAX1IaPsL9wmeVs=;
        b=nB3yHTvPw9vWCkj0c9Tr7qt++xWK4EkmpAlmiPG+iGtQQYF6rwgsvq+F2XnbwTGmIC
         g5MOwNtNiS0kVYV4I1pOBDpz3s9qebx3ZZtxZ6u8bUTrJkEZyy7IX0rwogkqmyXBsu7p
         JtoKnGGr22DyTTW48qvx8RWAYvn6hQ/YgS4dMif4CXs4XqFApdQJ1+MCTBobjfsGmbul
         rvy7kIQGg20qzZ1MnABDnld/9ANra+nzoAocB3Ij3jVtzbH9qj0/q5rSpad5mZ9D0zsm
         FsJe3N9D0cQcWrNO/7PWnv41yOywbKgyhyezLNL1/AwKQTimJNHzQpqYpgHzNoeqhYiM
         Kwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=fwqOFLLrsgU55uAqDKEizrE8R/j0TAX1IaPsL9wmeVs=;
        b=zfzLD9TVSs/VsJg6USyFb2RBEN9PS62toByGOnVJ6UHgTZQH1EJeTYJCzRfLYtVe8S
         BBzn6TIyTGi1TZ09Gp3Y4jhbMrqIwQfXzhMDYeoCWZEIVXKU02NL1bCxxjqTREjTxa/0
         9i0by2fKbNdD/TceyvshbO4USQcV60GFURLXg8sf/RUXoIfl57EV5jdH3eHCTlC1hmky
         H3GIrrZZU0Aej8cY9He5rvS23Y9aEN4Db0XnD0/kiEl4ub6ggt1BjdZLWKGF35Ry+jVf
         an/zWYfPLIcsOzHZ1dlnigLKUAxQsN1+ouY/pmP8IM6wU/0Bdc1Zjz/FUDsxB2t7pSkR
         bOYw==
X-Gm-Message-State: AOAM530eW2wGuSSMD6hlSFEiLY40KQqRIv18Imhuofl1L8KflywVrety
        oLM5vWULOLRl/V0xo7e8ZqClbmnMQvLhfQ==
X-Google-Smtp-Source: ABdhPJxRQiIY2nukKQxvL0gJS/kitsBeAi2DpnoUgBNNhEOm+iXEXe2LOIBMYji8TKrfxKPLnRj3DA==
X-Received: by 2002:a17:902:9043:b0:14f:aa08:8497 with SMTP id w3-20020a170902904300b0014faa088497mr14731650plz.109.1650828219004;
        Sun, 24 Apr 2022 12:23:39 -0700 (PDT)
Received: from [2620:15c:29:204:d4fc:f95c:4d79:861f] ([2620:15c:29:204:d4fc:f95c:4d79:861f])
        by smtp.gmail.com with ESMTPSA id l4-20020a056a0016c400b004f79504ef9csm9366747pfc.3.2022.04.24.12.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 12:23:38 -0700 (PDT)
Date:   Sun, 24 Apr 2022 12:23:38 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: clean up the code logic in
 queue_pages_pte_range
In-Reply-To: <20220419122234.45083-1-linmiaohe@huawei.com>
Message-ID: <e6d5e06e-426a-19cf-dd93-9b6011a33cb0@google.com>
References: <20220419122234.45083-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022, Miaohe Lin wrote:

> Since commit e5947d23edd8 ("mm: mempolicy: don't have to split pmd for
> huge zero page"), THP is never splited in queue_pages_pmd. Thus 2 is
> never returned now. We can remove such unnecessary ret != 2 check and
> clean up the relevant comment. Minor improvements in readability.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: David Rientjes <rientjes@google.com>
