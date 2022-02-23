Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC3E4C0A32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbiBWD1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiBWD1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:27:30 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A11C30F42
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:27:04 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so1476881pjw.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hHo8dvg3ISjeopAogIYFlvrWZIJV/AddrIydDcQpt3s=;
        b=hHRgqWRLAGRwwt9P+lsaS5UqV2CgvlBTCAIjtKuJ4qUJatPXBGsKxO9Cp8jwcR9J3X
         9g7TJzANL41E2EKpAg/L1t5M0O8zQ8n/1j7kbiYHK/s+w8mays/5dT3BGl40YRileQTa
         FkYyAZ70fNOxS3x5TZGytLWocSkCm4IP0DU3lUrwIUNaBJAe2HvcEJ4mp+NgNjJy8e1l
         lqzKqqkBk/1JFu8ru2lnmdaj+0Vaw3wK+K7ikmWJFgI7TiwkGy+iDHKZgnUwV3QirWvd
         1IqhurJMpv3NlaocH2tMRStnKVjkpnhIKGhImduW+y5npvhKO4iMG+x2fME3qeP0y+OH
         h6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hHo8dvg3ISjeopAogIYFlvrWZIJV/AddrIydDcQpt3s=;
        b=R7P/DwrMrwk6/VVhPWts7WdLbHEgG30rYLqxJeb4FQ4NNMpSUb7b9qj3Ot+6bcGf3D
         WxuQsMTz+JrbRq0F4RGtdIcBAkxQmbRldZffaWFGVUORgS8Lj+QOF4h+qvStmRSZWmH0
         8rMzOHT1nsiPkU7nH1EzooTRNBChnF8EBqNliDiA5V1v9Rvm/z87J6qLAh4bTS1v9wQb
         HYslwzLI0l1fUFgGDi7kHUA8YLqsXGZ3YXydEWUHKuoD3bk7AWKqV0ri8db2VTn5VWOn
         fph8D9NPPfXgxs1PrOIyvfSKRgsU/NO9LjBrVdMAytcqFt3CH725/ufKCXmFbs3dmve0
         XU8A==
X-Gm-Message-State: AOAM531wV3bSVAjEkfW/gvCondPUcTfpw+Te1o7236Bk9pguhrQVsKX+
        N6eV3txl/ZhZtCQEU6gaOlo=
X-Google-Smtp-Source: ABdhPJwxYlR5dh6SH2rWlwYCUwvH2cZs3/R4XfOmCMBhWE54GrIKCeyF4pSkRKkR/EqIX6lN8qG0Tw==
X-Received: by 2002:a17:90a:b00d:b0:1bc:5d68:e7a8 with SMTP id x13-20020a17090ab00d00b001bc5d68e7a8mr7290589pjq.59.1645586823698;
        Tue, 22 Feb 2022 19:27:03 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id na15sm1081334pjb.17.2022.02.22.19.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 19:27:03 -0800 (PST)
Date:   Wed, 23 Feb 2022 03:26:59 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 2/5] mm/sl[auo]b: Do not export __ksize()
Message-ID: <YhWpg41Jxj2L7oKd@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-3-42.hyeyoo@gmail.com>
 <YhOzuUDZwVx5CO09@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhOzuUDZwVx5CO09@casper.infradead.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 03:46:01PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 21, 2022 at 10:53:33AM +0000, Hyeonggon Yoo wrote:
> > Do not export __ksize(). Only kasan calls __ksize() directly.
> 
> We should probably delete (most of) the kernel-doc comment on __ksize,
> leaving only the note that it's uninstrumented and only called by
> kasan.  Also, we should probably move the declaration of __ksize from
> include/linux/slab.h to mm/slab.h since we don't want to grow new callers.

Seems reasonable. I'll update it in next version!

Thanks.

--
Hyeonggon
