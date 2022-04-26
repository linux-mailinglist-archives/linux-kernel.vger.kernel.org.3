Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44C150F85C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347806AbiDZJO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347171AbiDZIvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1D95174F57
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650962375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jw4mRm1FwTyP9UJn0J2QYoEfx6c/KUy1MZndEek5Xy4=;
        b=GBWgqXkht6sDNof5EbVCHTfClfAyTFqyszgabT7CrLi7fIg9WYUlx7pGu/75GvO6WhQzhv
        Px8KUa/M04NS+2ORW6TYRBZx9688+4K0qnYlHy3BU1f63xcV/bonaxOjMhvrinO88dqsb5
        EzQO+g1vDa//7XExLw3RILK9/5sa/ew=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-CYwSJY6VMdCvHuicgWTNAg-1; Tue, 26 Apr 2022 04:39:33 -0400
X-MC-Unique: CYwSJY6VMdCvHuicgWTNAg-1
Received: by mail-wm1-f71.google.com with SMTP id d13-20020a05600c3acd00b0038ff865c043so912671wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jw4mRm1FwTyP9UJn0J2QYoEfx6c/KUy1MZndEek5Xy4=;
        b=ruEl+motXCp04DRHUC90IQSvtTRFBprflJc6XkehMfMHBy+yh8umNf9bLrHtQlyp+Z
         uoeyHKeIROFZ9TI3xDeKBODLakhVuVcGf6svQvTLdvkma22ipn3X+DDgeytMA7C1CO29
         dbBqbHB1P4deQI0U9E4NYz5nPbgjKcFn966ZAj0b/cCzprmj1kK696rHH7Nyiog7Z5kA
         2PrjMA/YGqQJ5GYsxYukfQSEq9zZo32l53vR+H0u/IwNKcQ3yJPHpGLauhjQG1wjMFs6
         4YJ6PvU8sFhY98YTYz/08qfsqD4YyhHHu7wkITKOJv7Tl1IKWo4xIkzHGmi1ofP5d+RO
         GI7g==
X-Gm-Message-State: AOAM532nyBdpNW4br0XaBdxhTrFce/oRklLdWUm/8KxRlCBYxG0A+bUo
        pmkZePvE+K0yvYuSaTkswJIS9/jYpgTy82M0fkC4Lg2BQLOahQDkiOJ1bQR95579CbkU9hfLi2g
        FLHK0ONNCL78tAxI6GW0DhJA=
X-Received: by 2002:adf:f2cc:0:b0:20a:cfbb:ac29 with SMTP id d12-20020adff2cc000000b0020acfbbac29mr13112678wrp.263.1650962372645;
        Tue, 26 Apr 2022 01:39:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg+iA38qQD6BfGY7gT19eBuYvIEUVtaGrwCfg2tNslK+9+RXqcvF8J8rAbLA8+jmpLyYCg8A==
X-Received: by 2002:adf:f2cc:0:b0:20a:cfbb:ac29 with SMTP id d12-20020adff2cc000000b0020acfbbac29mr13112659wrp.263.1650962372470;
        Tue, 26 Apr 2022 01:39:32 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id 204-20020a1c02d5000000b003928c42d02asm12839575wmc.23.2022.04.26.01.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 01:39:31 -0700 (PDT)
Date:   Tue, 26 Apr 2022 09:39:30 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, k@ava.usersys.com
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: Re: [PATCH v4 0/2] module: Introduce module unload taint tracking
Message-ID: <20220426083930.hltsfxoe6ax6dspj@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220425090841.3958494-1-atomlin@redhat.com>
 <YmcvZQSiu95MUvxI@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmcvZQSiu95MUvxI@bombadil.infradead.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-04-25 16:31 -0700, Luis Chamberlain wrote:
> This all looks good except with all the work you did to remove
> #ifdef hell, it gets me wondering why not just use a new file for this?
> 
> What does that look like?

Hi Luis,

I thought about it. It is indeed possible. Yet, I do not think it is worth
it, for such a small change; albeit, what do you prefer?


Kind regards,

-- 
Aaron Tomlin

