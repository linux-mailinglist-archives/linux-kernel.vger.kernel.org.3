Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C311542309
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444138AbiFHCJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442542AbiFHAz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 20:55:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80CF1271A6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 17:01:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o7so4955289eja.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 17:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BbtiLiOJU0rTXaLM0hDshg4m31VYD4/CJhwA3wxcIfY=;
        b=UEbSN7CqnGLPUgHOCHUnxVgvcwwH5fIjCRkDU1hMHEOw3O6Crn+zFT4cHbt26zWAIE
         8N37tZnKa2IQm97YWALddX+9sX5+eUdSGgLUjTzkUqGjd8eF/munkHc/iMXNVyIQulDr
         RzbvLPuA7QuYsQ2rp6uFK7J90q2o99MR/JxvoP1OAXLS/i1XFkjUHB5dMmTRPvkqrKN1
         GVlnO15zjvzdRH/a9AZT92GfOjEnw3KTd/XmxNJvNtOd6X7CXsn2ckNAviyYg0+ZlzRg
         9Ks+ItmnXrzSqHobsOovoV7ncr9CtW9Vq3iZguF++zTcNjSYE725THejD4ccN1rYOdeo
         eKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BbtiLiOJU0rTXaLM0hDshg4m31VYD4/CJhwA3wxcIfY=;
        b=m1HUVYFMtbKA7CTE29olGccbP7GJ6u9A6aAPZljkPGv9Z7Tcwrkpcr6nkLyP+e/JUF
         b9CUG9PxDhmwIOln52iDX2eJ21qaOqeWkVU0oc18wyNveVqsksVsWztkUy80mz6G0lgo
         39n70J6RX4nztfmPl+XB/ZW5Q4et7iFDAvTDX2AST1x8ZKz0rP5+j1JGRfO7FLOOdO9A
         TMSJanEFN6yX466LI8S8rR8CsVKlighhX0oDsjH+Aa5jWo0fDRoEgG3wkMDHPNcwpbGF
         6gd/npRx1fsUJqCROmEBPx8XFbym1WlkLsJcu7bLMfnxUUryK1EVx975WTnbBGQoo20f
         t1Fw==
X-Gm-Message-State: AOAM532Van2HXw3DHotjacilAEhcnkhkq8GTP9A8MsygNoCQxc+m+V19
        e2J9bsVxDr7QgRWQaZmcx3w=
X-Google-Smtp-Source: ABdhPJy47AJ9g+udmP2NQVg/F+sAWua/3HNM6FM8/NI+MyAJiUqdrDek1YV+kEU4eBlEYg5lhWQe1Q==
X-Received: by 2002:a17:906:99c5:b0:6fe:b069:4ab6 with SMTP id s5-20020a17090699c500b006feb0694ab6mr29042371ejn.436.1654646487635;
        Tue, 07 Jun 2022 17:01:27 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id z11-20020a05640240cb00b0042e17781fc5sm9790817edb.49.2022.06.07.17.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 17:01:26 -0700 (PDT)
Date:   Wed, 8 Jun 2022 02:01:25 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v3 13/21] clear_page: add generic
 clear_user_pages_incoherent()
Message-ID: <20220608000125.na6z3niyv4ty7xn7@mail>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
 <20220606203725.1313715-9-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606203725.1313715-9-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 08:37:17PM +0000, Ankur Arora wrote:
> +static inline void clear_user_pages_incoherent(__incoherent void *page,
> +					       unsigned long vaddr,
> +					       struct page *pg,
> +					       unsigned int npages)
> +{
> +	clear_user_pages((__force void *)page, vaddr, pg, npages);
> +}

Hi,

Please use 'void __incoherent *' and 'void __force *', as it's done
elsewhere for __force and address spaces.

-- Luc
