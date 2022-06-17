Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C358F54F22C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380460AbiFQHrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiFQHrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:47:40 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9137CDEED
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:47:38 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id w29so3400163pgl.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LQLzsTXkveBN/L9q4zlOw39+Gjac4v+4fXhFTmzIAJ4=;
        b=GKtwGn0Ry+az6d3fqrob++js5HqraiUoJ6jsuwbYFvf5rljLHYn8wTXzVWydHwvC9m
         dHx/y4kJrr3y0HynuBudpwG/Z5ZudaXyAqppvGVcI4PVS4tyv+Z/bFQtgP0jz5zmCRyO
         lSlz2ciLyfuoMl78B5xmJyipuZfJXAff1Fk68ydI6rdeq6XNcDkMFRwXs5vTwxRExQut
         4/EJ9fbd3S/1WoZOoXPO6jvZucMnJ4OrmJlRUFSnZci8QOJk7PFHjonx/pgRl9mSYfN+
         R7Jj+pqxYrrRGSIraLJaGUgCmHYqTenYSJHuu/iuANmZhSjkrkODwS54IsOUetojvQck
         JfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LQLzsTXkveBN/L9q4zlOw39+Gjac4v+4fXhFTmzIAJ4=;
        b=lXq87DCCtfHpUkNnlYALzv1B8RdyC0Nk4Ju26bhnGLbrN2NfxL4CJectXqZpcIq5RE
         O92WDkGg/6HnE/OFwQ4o4nqzslVK1JCvt8mIai35iOgE+Qv+lMe+0NPKsowO7XLUAzO0
         uCDi5gQTjqQnBf8TvQqpFygD0EyUaCsUewpT9XC55ZdZu8O9hJgWm/UsUsAUwk84TeWu
         E5Z0pl+r4XK+tgV3fDIlXtMkGs3cDxXqp70uWYElqIHUzOs/HZ42uHu7c+5bMQZTtttY
         70ie8iF9AQll01R+EfpIqWianVQ1BQFc9jlQVlbPT/lkXD+3E+VY23QZVTTjjTdS0Wdd
         aS8Q==
X-Gm-Message-State: AJIora/eoSPEIX3PEycQcYC56FkIz6uKnI//1V7qJ7PjH3cAgcaBDCrc
        tSeA0vZ5p+FdiV0ok5AcoAd/gA==
X-Google-Smtp-Source: AGRyM1u9qQl6xAeo+YSHod19qRwKsnhSpe1/UjRtqPeP94Tx6IKP5/Ae7fk+SXU4tojdPPenVBHV/g==
X-Received: by 2002:a05:6a00:1a91:b0:51c:2fab:7340 with SMTP id e17-20020a056a001a9100b0051c2fab7340mr8725263pfv.74.1655452058081;
        Fri, 17 Jun 2022 00:47:38 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm2934394pfv.193.2022.06.17.00.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 00:47:37 -0700 (PDT)
Date:   Fri, 17 Jun 2022 15:47:34 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: hugetlb: rework hugetlb cmdline parsing
Message-ID: <Yqwxlo7HYFv4jHco@FVFYT0MHHV2J.usts.net>
References: <20220616071827.3480-1-songmuchun@bytedance.com>
 <f175d757-e76c-085d-2001-68ae275475a3@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f175d757-e76c-085d-2001-68ae275475a3@csgroup.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 08:00:58AM +0000, Christophe Leroy wrote:
> 
> 
> Le 16/06/2022 à 09:18, Muchun Song a écrit :
> > I often get lost in the logic interleaved between numerous global
> > variables for parsing cmdline.  It is not easy to be maintained.
> > This patch aims to rework cmdline parsing to simlify the code and
> > make the code more readable.
> 
> This patch is quite big.
> 
> Can you explain in the commit description in more details what are the 
> changes performed by this patch ?
> 
> Otherwise I have absolutely no idea of what to review or what to test.
>

Sorry for the confusing, I'll rework the commit message in v2.

Thanks.
 
