Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51174D3677
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbiCIRSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbiCIRRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:17:52 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E95E4494
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:15:37 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q13so2508215plk.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 09:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=x1nQuY29Y8WhL6J/ZQu5YgDLTjawUkxAqLgbVJua3hY=;
        b=sW6xLDppPgAPFHE5BJhZvgdkYn+WY0Ji7Xmi9c2jOR3aekaQcdWza1bBOoxTKPJbx4
         gDOSeRfJHfPlyPtj7QtPuZpGSH4w02ej9y+1xQcvW18a3w/N9SA+nGUJHGqfG9FT9eF9
         b+4avAihGmhYWOUHYCRCMIMdvFUcaFrg2l6TOXgXBKnLiPBQEX1ZmG+Rv3OIz7RoU5Ln
         WJ6nlgKvmPWLatydS+0fok6yAP0je1KGuIYSHTImr9fRO0x1yMo82WDj9XbhXDipvk/6
         KFbDLXNjvmkAEXlETavF0Sm1/pR1rw3WJWerbEohhaQMkJV6hNTztj1vJ7nJRIAYjgGR
         W4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=x1nQuY29Y8WhL6J/ZQu5YgDLTjawUkxAqLgbVJua3hY=;
        b=IN2HEKA31cl5iqt0bJpBxnfYFW67X7aOMxHy3bab0nBJg4gX6oPz5I1XDhftCK/lgN
         yS3p98GScpEkTkx1o4zY2Ney/R3C3wjWw5C78wbiBVlp4lOOXE8bfEPooyLf9TOEDe83
         rG2qdIDKtHTcey2ks04PDxPg2DskGuWr+/tGNMojLUNMJpnkK4QCoeTlXDjZbmrdieI9
         gu3xY2jaxjn6ScEjET7iaeKzzEyvVPxJtqilM7x4qLoyrAm5hrU/t+2i+IJ3VtkBQh9f
         wtK6Qp2FXK1jJZH4gY5qLGjbW9rtfsxa+mndmL3iBIk7kimqAaxrPQD9zTY6uvdOiXDx
         JjUw==
X-Gm-Message-State: AOAM5300Ycs63ZCJzknG0LRt7AMMqhd1DQGmIri4OHwvQXn1DA0qEBn8
        ZBIz6UwiZJtuwJ0gfAkpwgrfKQ==
X-Google-Smtp-Source: ABdhPJwxEOUetRQoNUGuPyf5nY5FxYlcAtJT5X0k/dNB2OOflWA0QnQ5xKw5OE8/vb7W0vyA7qq6Dg==
X-Received: by 2002:a17:903:3112:b0:151:a940:1574 with SMTP id w18-20020a170903311200b00151a9401574mr660489plc.63.1646846136818;
        Wed, 09 Mar 2022 09:15:36 -0800 (PST)
Received: from [2620:15c:29:204:b5b9:5c22:b3dd:17a2] ([2620:15c:29:204:b5b9:5c22:b3dd:17a2])
        by smtp.gmail.com with ESMTPSA id y16-20020a056a00191000b004e155b2623bsm3934224pfi.178.2022.03.09.09.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 09:15:36 -0800 (PST)
Date:   Wed, 9 Mar 2022 09:15:35 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Matthew Wilcox <willy@infradead.org>
cc:     sxwjean@me.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        longman@redhat.com, guro@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH 2/2] mm: slub: Delete useless parameter of
 alloc_slab_page()
In-Reply-To: <YijHr+kkp2bPE1dA@casper.infradead.org>
Message-ID: <7c116655-a4ce-5f61-2d98-e85c31e11184@google.com>
References: <20220309145052.219138-1-sxwjean@me.com> <20220309145052.219138-3-sxwjean@me.com> <YijHr+kkp2bPE1dA@casper.infradead.org>
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

On Wed, 9 Mar 2022, Matthew Wilcox wrote:

> On Wed, Mar 09, 2022 at 10:50:52PM +0800, sxwjean@me.com wrote:
> > From: Xiongwei Song <sxwjean@gmail.com>
> > 
> > The parameter @s is useless for alloc_slab_page(), let's delete it.
> 
> Perhaps we could add a little more information here.
> 
> It was added in 2014 by 5dfb41750992 ("sl[au]b: charge slabs to kmemcg
> explicitly").  The need for it was removed in 2020 by 1f3147b49d75
> ("mm: slub: call account_slab_page() after slab page initialization").
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 

Acked-by: David Rientjes <rientjes@google.com>
