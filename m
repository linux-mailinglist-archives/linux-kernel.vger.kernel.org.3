Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013EE4C3B95
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbiBYCWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbiBYCWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:22:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FC49FCB57
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645755731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iwRliaBz8XVBCbo8ZYm3d/1wV8xOYEP0VEbSvQZXIL0=;
        b=gIebw7ALS+ivLGLueP/vUWmwOE1wB9F11Ho1+mfRfizsqyLDgVA+z/nCUMA1DKjaxK+PxY
        02ekUH+64hiwFqm94pdKfgsHZlBGqqxcQ8nTNcx6QKW/Wko4iLroVlzmrtcJ50pg7gJko3
        LpRaFaxq7FnLjOePq8Kjb6ow3heclAk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-LCiulT48NKeiroXIGhRzOQ-1; Thu, 24 Feb 2022 21:22:10 -0500
X-MC-Unique: LCiulT48NKeiroXIGhRzOQ-1
Received: by mail-qv1-f69.google.com with SMTP id cg14-20020a05621413ce00b0042c2706a4beso4617665qvb.23
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iwRliaBz8XVBCbo8ZYm3d/1wV8xOYEP0VEbSvQZXIL0=;
        b=NxuBXzLOOz9CYeGvAR0+awh9HgK0OkSYSsgv4fnY+O/qWy4tZZhz+p1z0ZjzcnmZqj
         3mqU1e4gJgJerORmDpLl2KMn79oxSgoQGFtau0Cvw0TxD52zYXNVN8KpiJmtO+6DIzDP
         /HrVWyjB0JtZkhlqNE73kj6Z3OVxTpc4BklzUiWes8fKjQloNYAbpRfAXhidp0csnErE
         tj2lvZB57n6Bx+ySsCcEISbjIvEy1HR1zLuWlE23JpVvl1T58w62BA3zeUUziQi6bOGi
         khh0eNasD3AzMR11pUmRnOI/91/XFyNcXlysjbE++/VbnOrKSZEbG9cGNR27V+Nxc/uw
         30yA==
X-Gm-Message-State: AOAM532w+Dd0brTyNeAdmcL3pvcled7Q2M6GaiDc1wlw+3yBjshBGN32
        3OAqWc/Ti9XpFA5O2xrwyU2Qr6OeGyBNWnDi9g73D4Uj6dUWUVEc156zk0Bu93tE4S7S+ocPG8L
        BeOu/4uPVF3QYZN6zTUClS1Ux
X-Received: by 2002:ad4:5ca5:0:b0:421:6335:89 with SMTP id q5-20020ad45ca5000000b0042163350089mr4318931qvh.89.1645755729945;
        Thu, 24 Feb 2022 18:22:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxV6sJA9MH11XO+AqJqJXLGPXYhUrWls90+6cuZfoIbS5FjdCJFhRi1NDRKvi5DNwAqt2NESA==
X-Received: by 2002:ad4:5ca5:0:b0:421:6335:89 with SMTP id q5-20020ad45ca5000000b0042163350089mr4318915qvh.89.1645755729762;
        Thu, 24 Feb 2022 18:22:09 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id s18-20020a05622a179200b002de9529450csm665452qtk.85.2022.02.24.18.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 18:22:09 -0800 (PST)
Date:   Thu, 24 Feb 2022 18:22:05 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 20/39] x86/bugs: Disable Retpoline when IBT
Message-ID: <20220225022205.yfvpfq5qwpcvrxux@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.189353523@infradead.org>
 <202202241710.B35CBB06@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202202241710.B35CBB06@keescook>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 05:11:23PM -0800, Kees Cook wrote:
> On Thu, Feb 24, 2022 at 03:51:58PM +0100, Peter Zijlstra wrote:
> > Retpoline and IBT are mutually exclusive. IBT relies on indirect
> > branches (JMP/CALL *%reg) while retpoline avoids them by design.
> > 
> > Demote to LFENCE on IBT enabled hardware.
> 
> What's the expected perf impact of this?

Should make it faster...

-- 
Josh

