Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010B24B26F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiBKNQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:16:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiBKNQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:16:04 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA55DB7F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:16:02 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h6so15178933wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QCpMm7qsr6O0bxYqGbmSdc7lNGFoKFGgal9SKsG8Ank=;
        b=AFyyYIsqPRbasTtY4anubelYpEioV3Wwu3kIW0EQumk8NKwmjSZ4wFbl1yZwf2BU/r
         t+sukPqbIygmTLsmpCmwLUYbuhMPyD9Zb8GziBiGbpPPAIMJfNI3DRMz8fz0veTNGHus
         gyA2HflAOpkNhpvu3+l6J48nUXfWA/2ZayFSV33FsW/kOiD//SLIDgO+3TLAKfTHUeW1
         0SVgXmnV2tw0asbD01fEO5e2BO3XOOT/G6hdXB1q91o1dUswtGL9+gYr2t1Nu1p9c3Yj
         g9/Fv0fF0fqHGZpN/Ll80x/u9CXOH/20jHd2nNw6oLxdBZw5XT5phqVL2ZM/eogR7eRm
         dxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QCpMm7qsr6O0bxYqGbmSdc7lNGFoKFGgal9SKsG8Ank=;
        b=r20jQhCPcnJ/+/TIXSpf3F9cPhsoFy0FO/elwa83fxAVeXaxUGmUYHE+NK9EOlJTWL
         AtaHRI6KkKBeEBgkfL4hfMYZKMkamtKuc77ulBxLRgINNCvVGJhtouGAsduk835s5LKi
         4Q3xvU/MXkD5Bx5uG2wc2mQWBGd+/4dSp2YHd+aFR0865TDLqo+Z+8UT1luBa6ZhQym9
         Vg67k1RQW+AeeKWBpwI4EXg+usV5NdRcVLIMfGea+gCf9hKomtVyO6+EeYTWHNAVPwCP
         ChXK+ZI8uZCnV3dMRMAeOWRnDkuBzgLVTDdJ/FF4aaZ73E8BKppu/JzO5Y2DZPEpKinT
         VEgg==
X-Gm-Message-State: AOAM533SsFWm6joiC8Yaf4TeZ+ATff0L/Zw8VpCE04Lnu44zc4DIq7zA
        irU7WC+BEjLy3DxYzUrsfz/lBw==
X-Google-Smtp-Source: ABdhPJzuxNwPz6T0r0OlxZfHQ6sud5bMIYd0BoEEx9oUAF6+5PoUxaHp25nyrIxI7EGKoNx1sQmNTQ==
X-Received: by 2002:a5d:61d0:: with SMTP id q16mr1398425wrv.615.1644585360964;
        Fri, 11 Feb 2022 05:16:00 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:922:c67f:c98a:9e8b])
        by smtp.gmail.com with ESMTPSA id n14sm21859177wri.80.2022.02.11.05.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 05:16:00 -0800 (PST)
Date:   Fri, 11 Feb 2022 14:15:54 +0100
From:   Marco Elver <elver@google.com>
To:     Nemanja Rakovic <nemanja.rakovic@syrmia.com>
Cc:     linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, dragan.mladjenovic@syrmia.com
Subject: Re: [PATCH] mips: Enable KCSAN
Message-ID: <YgZhinv9C9CBIEIG@elver.google.com>
References: <20220131101709.17434-1-nemanja.rakovic@syrmia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131101709.17434-1-nemanja.rakovic@syrmia.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
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

On Mon, Jan 31, 2022 at 11:17AM +0100, Nemanja Rakovic wrote:
> This patch enables KCSAN for the 64-bit version. Updated rules
> for the incompatible compilation units (vdso, boot/compressed).
> 
> Signed-off-by: Nemanja Rakovic <nemanja.rakovic@syrmia.com>
[...]
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 5a15d51e8884..a35f78212ea9 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -38,6 +38,7 @@ KBUILD_AFLAGS := $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
>  KCOV_INSTRUMENT		:= n
>  GCOV_PROFILE := n
>  UBSAN_SANITIZE := n
> +KASAN_SANITIZE			:= n
>  

Should this have said KCSAN_SANITIZE? You probably want one for
KASAN_SANITIZE as well, but probably not in this patch, given mips
doesn't support KASAN yet (AFAIK).

Thanks,
-- Marco
