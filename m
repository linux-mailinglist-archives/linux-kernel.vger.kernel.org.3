Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBE75AD35D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiIENAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbiIENAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:00:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD1727CD1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:00:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e13so11300585wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=kJi7f6S+gKqA2Sy14qN2pIa8T6Q0eYoj0fHhvmu5wuI=;
        b=on/CTDUcmPLQAHC2qXTDeTgGZgrVME1lc2BHGRyNPtAl3CPT61/uWsOnGmsaNvO0rs
         GGlV6eLipjhZyDVpl/5CoY/d4GyojU21yrWcv0CI3lPVquuykqXqjhjXu0RmkWb8dXfX
         KQR4mRdcDoNM2T+Vb+3YwNvIK7VWjhijxYTcMNMhVXkzdd1ANxbn5hy1NyDD7Zhk4O/c
         OaJ/WHhwW7oBpS4Mlc7zpImzYRhTnBZukWNxzQkdWRT1hnyDRa0JW48xQg/C9piI2GHK
         86zdltH8Qqgi3qY9nFTHiIue0RuvNgNOPb6QQQ34Xkps5yys21SPSOLVlg80Onn6+3ba
         GYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kJi7f6S+gKqA2Sy14qN2pIa8T6Q0eYoj0fHhvmu5wuI=;
        b=ZHTm3zFVC4PWgiXK84gI13cqtNKleE1ffRt2Ilx9s+dnQncGUtkddM2zQz2Nmh9MKI
         lEoKO+95RGap/ArNrE9lnInSHSicLmAXinoj8Kb5pV53TFlfWu6wuibA4a33NOzAcEVh
         mDKAUe7K32Od70z/n8iHlKTDl/gzYBiIY3heUNBKpKYrVKIycjwd5/rrQkGTXONoZh0m
         LYCKCliBGxitZ1psGfEdrjNo0heGGOA9S2zRCYteLmw7mq0sZWpYCEhkZNEDLo4nOcjM
         QpBXQiBu/iqWZ+BiXKkeW11Etnidm7A+3LAzq4SlbHjOYnfsv51uEsC8+XjHU0BvgBA5
         aQjw==
X-Gm-Message-State: ACgBeo1ug3N37GKRW3KdU9DSZXIVLLrUmJP7x1BmgzTwwbPZQm6KcEfB
        V/zWESRmz6QA5FwM0Ym+wM6YQek11MTIwQ==
X-Google-Smtp-Source: AA6agR5uZEnd+71w0ZjN6Rin0OTeBxUWKXSD43Z4beSbzcJ2Qj+BnWqjQeF2LbMTZScfW1B0gsCn9w==
X-Received: by 2002:a05:6000:904:b0:21a:3dca:4297 with SMTP id bz4-20020a056000090400b0021a3dca4297mr24186501wrb.487.1662382831841;
        Mon, 05 Sep 2022 06:00:31 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:b57a:bbdd:c6f3:e092])
        by smtp.gmail.com with ESMTPSA id m11-20020a056000180b00b002287d99b455sm3462322wrh.15.2022.09.05.06.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 06:00:31 -0700 (PDT)
Date:   Mon, 5 Sep 2022 15:00:24 +0200
From:   Marco Elver <elver@google.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v2 2/3] mm, page_owner: Add page_owner_stacks file to
 print out only stacks and their counter
Message-ID: <YxXy6BReRfqsKa34@elver.google.com>
References: <20220905031012.4450-1-osalvador@suse.de>
 <20220905031012.4450-3-osalvador@suse.de>
 <YxXyThZanSl3wboo@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxXyThZanSl3wboo@elver.google.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
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

On Mon, Sep 05, 2022 at 02:57PM +0200, Marco Elver wrote:
[...]
> > +{
> > +	int i = *pos, ret = 0;
> > +	struct stack_record **stacks, *stack;
> > +	static struct stack_record *last = NULL;
> > +	unsigned long stack_table_entries = stack_hash_mask + 1;
> > +
> > +	/* Continue from the last stack if we have one */
> > +	if (last) {
> > +		stack = last->next;
> 
> This is dead code?

Oof, I just noticed that 'last' is static. Please avoid that, because
it'll make this interface really tricky to use safely. I still don't
quite understand why it needs to do this, and a kernel-doc comment would
make this clearer.
