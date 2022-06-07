Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ED95423F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiFHCWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444727AbiFHCLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 22:11:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE90E254441
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:18:24 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so5513134pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0EImpbXnAApSc8BvVL56qbdQpeRig2mR5AXQClUMyjc=;
        b=D+sDw6OfB5boDSeDNM9bqFr0F+tvRj6Ohj2Z1YTWNs+0xdYLLaOMK5kJXF2k+FXvoN
         S1Jx/D6ktM3EJjcmR6k7X2cXEptshfJtA4Ojr3XNwEKFX52bC4dCEHTSLs803Od905Qd
         +7X+bRiPsgncXxvXODceVFz4G8VDzZDv6yt5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0EImpbXnAApSc8BvVL56qbdQpeRig2mR5AXQClUMyjc=;
        b=EvYE+aSovY4SvTLrh/9juYR1fzOne4YvUUmTweG9cMHpcyKoigxXmYl+KzxUwOImGO
         /L3HyNG/YF7em/7vOLvq6kixNsNYzUaabzPCuwKOOUB+DnTiv0C++Qy5xJgGaeSOi8mX
         EYQAmHdm4wmSUZdUH3oKxAzg8ChePhfsMsD4qEteO2K8XD62AuVgZllnBuVNWBhTLBpw
         uViCZU5S5QQP+peqr7NQbz8jFidNvDiSEOodenbTAK8YwCDWAjhJNS20DU3POy07NR3B
         TFexyy0fPLJIn7YI4WFbHUHcdWxRcUtRlIZlJRw6h8O/Qh1OJ6Ol04RFqiAPsJSoJ66I
         00BQ==
X-Gm-Message-State: AOAM532/zPeHpZHXg7s+VWPBntVU/EIDukG8WBJ7vDDi712w3t+j0PhR
        Kf0M1oYbCym5+eo4fZeX/IrxpQ==
X-Google-Smtp-Source: ABdhPJyBmgCZaEYkm6poadEXRpVAz2i5/BGDgN9MhkPQ/Q6rYJplJtUTI/mP0HwnvEwNnezRL45GYQ==
X-Received: by 2002:a17:903:240c:b0:153:c452:f282 with SMTP id e12-20020a170903240c00b00153c452f282mr29733430plo.88.1654629502873;
        Tue, 07 Jun 2022 12:18:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3-20020a056a0002a300b0051be16492basm9177167pfs.195.2022.06.07.12.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 12:18:22 -0700 (PDT)
Date:   Tue, 7 Jun 2022 12:18:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [RESEND PATCH] smack: Replace kzalloc + strncpy with kstrndup
Message-ID: <202206071218.D281DE50@keescook>
References: <20220607093649.928131-1-gongruiqi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607093649.928131-1-gongruiqi1@huawei.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 05:36:49PM +0800, GONG, Ruiqi wrote:
> Simplify the code by using kstrndup instead of kzalloc and strncpy in
> smk_parse_smack(), which meanwhile remove strncpy as [1] suggests.
> 
> [1]: https://github.com/KSPP/linux/issues/90
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
