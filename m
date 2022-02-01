Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76C4A62F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiBARuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiBARuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:50:11 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DEBC061714;
        Tue,  1 Feb 2022 09:50:11 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y5-20020a17090aca8500b001b8127e3d3aso3287411pjt.3;
        Tue, 01 Feb 2022 09:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=27jSOcr8JOEkHkV5caIK9N1Ysa81axdbBfi5tkVeEec=;
        b=mRUEV8YWQIV5BPWcYP7f9e+5jBfdzMxiHGaCXQTGYL0jyfSHjuGkzj/ZzExwjpPiNO
         u94ZIo68EaVbvcNb1mhN5WtJmQzu20yylfLnr+sszqNueHM1Hk4GRPfSPDS5N1wlaZxl
         NakWB/assQJE2+MQM54lIiteeUvSqWhHyHegAkJyFnxp/6bQmLhA48MjNWpvzmHzrRCP
         uMEwpPufgZcUEPL7Y11PtgpFWOJprCF28GCDGbVXTKRV5kA1rxVUIrdSpFUKrOYdcaqb
         HD8u+CTGqr+zvy7/vaGEpZIzf7FEMOe1nUnB1tmvuqylhtlvCdJOpWJyjXK++CTaeOsC
         WU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=27jSOcr8JOEkHkV5caIK9N1Ysa81axdbBfi5tkVeEec=;
        b=SbH5Z0fzPrDRhUNVr8tB701+aa1llBcVJLqVeQWoe6xdLqFn8RME3NzbEQZ4qIu7YQ
         Jok+7feNGof0QsfgmJj46hUe0k0s/HUQZuEBXKYIyqHKXFRqjgBHktUVxvm/Ki606P1b
         K+H+ZaQPOSGFNr4WFVhIKaW2o1dWKQVu5lqUx3cQaW6ro1razRHUdRMam5LENZ1CtlWt
         FoRhn2hpq1p3KOZKC8yN6+5tfl+zoo7E7yhl8kmHggPcN3FoSnY1caPU4b6cidAwOlcc
         5AqmxOLoNMmGi8u7X9WzYFL8CNz4W/wlJnj56AW3M6tIF3NwzJJaDAZvqPY9ZOAOi0q5
         FOiQ==
X-Gm-Message-State: AOAM5306XfGanIkxm73NWpD0P6b/pIPEzNs+OciBYjNRcgAfSQywUR0w
        uswvnp610mzy3afi9LR58QU=
X-Google-Smtp-Source: ABdhPJyiGWVdCzfldnYK02TK5G5q0Q2TSYvo3LIG8lWKkNFDxiv8/XJ+YKuKfDq9HU+P+LoHrEnKuw==
X-Received: by 2002:a17:902:7791:: with SMTP id o17mr17780278pll.107.1643737810666;
        Tue, 01 Feb 2022 09:50:10 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id b6sm23471311pfl.126.2022.02.01.09.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:50:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 1 Feb 2022 07:50:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Igor Pylypiv <ipylypiv@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changyuan Lyu <changyuanl@google.com>
Subject: Re: [PATCH] Revert "module, async: async_synchronize_full() on
 module init iff async is used"
Message-ID: <Yfly0P4e84373mGF@slm.duckdns.org>
References: <20220127233953.2185045-1-ipylypiv@google.com>
 <YflxP28HlVrrNBU2@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YflxP28HlVrrNBU2@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 07:43:27AM -1000, Tejun Heo wrote:
> That's quite a walk down the memory lane and I agree with your analysis. The
> PF_USED_ASYNC is redundant for correctness with the removal of synchrnous
> loading from iosched path and the WARN_ON guarantees that nothing in kernel
> is creating a similar situation.
> 
> Acked-by: Tejun Heo <tj@kernel.org>

BTW, I can route this through workqueue tree but -mm or going to Linus's
tree directly might be a better option. Any opinions?

Thanks.

-- 
tejun
