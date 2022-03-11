Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60824D64E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349364AbiCKPsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347030AbiCKPsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:48:35 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE83FFE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:47:27 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i66so5328555wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6vhOIIdJvfX6cOrm/Hp75giDPzX5k6IkKRc2Ldr4x1g=;
        b=Bj6+61b8ssmOb5ECuJge2OAspgv/M7zGpi7BjzO4bu1W3koRCvckm1lQtfNmVEYrrZ
         ScnrRgEe1/NzaUSlcRWvEcGQM46tzCw0vFRAi2x3igvX2oGZy29BH6uFGjSH1nsD4Xdk
         lwwpqqu7fpE3SvuVwlmZKl4+Tt8CKYLBYl70mo3T8wTO3QCu3qhmKYt1prHpKvXwDeMY
         tT1Y339mai2MYxrPUMxvRDwzvdcRzGdPcj7+vaYm+2nR4gLa9n4bDL1QjO32mLk/xeFl
         pcqthmf5Yl03svTr/kiL6KL0ihzrFf+eASqmjABAjnKdpOwa5/laN+sS4NhcNE27F9Ib
         8+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6vhOIIdJvfX6cOrm/Hp75giDPzX5k6IkKRc2Ldr4x1g=;
        b=Q9MhJ51lt/Vk+44fLIWKtg+yCwMLo37feMmcZBQeKh2+eYWQ7uZDaI8TNMs6CB8XJj
         XAn/UXg15r/iAM3xIGYwiMhQBzfWCspSjzzEpzq9/5HaInLNYTNxvxRX0JvayJ+6YRbO
         V1LKSun+iESmu870Ss79yOOT4Co1O7SXghcP8htlz/zJLB16OnjdOZmvwLqzWd9rUt6B
         l3ItlA5h3CZGj3S95yzUjw7XCT5LgOV++ekmMDyhH59ahZWDRk+QdT+Z4H1So0FuGeEk
         wl5raZ7ibxnCZ7CwrUA6Td61KChPL+QL4e6kN5zxmAAEe6SB5Z3QcxGvBiDARcWhZoBu
         NyXA==
X-Gm-Message-State: AOAM5328R/ZvwYejD1QAroJYyyAkGgBxgIpe0uj7F7gScbaNeUvcUX3V
        9pXtPT/HkLg7j6bBWC78OIdSAd2wqw6jEF5E
X-Google-Smtp-Source: ABdhPJyNFd+WeXNqTNfnthvORZ2Sgedf9Lvk4w/MuHRm6084TXCr0E0apu6+WCLgKaxk/lm41FdE2g==
X-Received: by 2002:a05:600c:4ecb:b0:389:e765:b4cb with SMTP id g11-20020a05600c4ecb00b00389e765b4cbmr5836985wmq.160.1647013646216;
        Fri, 11 Mar 2022 07:47:26 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c191100b00389a1a68b95sm20113957wmq.27.2022.03.11.07.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:47:25 -0800 (PST)
Date:   Fri, 11 Mar 2022 15:47:23 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>, christophe.leroy@csgroup.eu,
        hch@infradead.org, cl@linux.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com
Subject: Re: [PATCH] kdb: Remove redundant module related references
Message-ID: <20220311154723.ezo3wvgg4puu2zk7@maple.lan>
References: <20220307174741.2889588-1-atomlin@redhat.com>
 <20220308105203.2981099-1-atomlin@redhat.com>
 <20220309120640.uumh46n2l37jaddf@maple.lan>
 <YiporeSIrkFg/YS8@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiporeSIrkFg/YS8@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 01:07:57PM -0800, Luis Chamberlain wrote:
> On Wed, Mar 09, 2022 at 12:06:40PM +0000, Daniel Thompson wrote:
> > On Tue, Mar 08, 2022 at 10:52:03AM +0000, Aaron Tomlin wrote:
> > > Hi Luis, Christoph, Daniel,
> > > 
> > > Is this patch ok or would you rather another iteration of the series?
> > > Either way is fine for me. Thanks.
> > 
> > Another iteration makes more sense to me.
> 
> Iteration yes, but separating the patches no into another series no.
> 
> > The removal of kdb_modules is semantically part of your module clean
> > up patch set and should certainly be included in it.
> > 
> > The removal of the spurious #include's in other kdb files is a
> > good change but it is fully independent of the module rework. AFAICT
> > those fixes are good with or without your changes. This suggests
> > these changes can be separate from the main patch set.
> 
> Small fixes get piled in first on the series. But this is not a fix.
> This effort will not be merged separately too. This won't go into the
> next merge window either, because:
> 
> 1) There is no rush
> 2) It is too late as all this needs proper testing and
>    its too late to claim enough testing
> 
> So given this is all related to the move I see no reason to treat
> this as a separate series. Your review of the v11 would be nice.

The reason to suggest separation was that the changes to the other
files in kernel/debug/ are entirely independent of the module rework
and would usually be landed via a different tree.

On the whole it doesn't really matter much... but landing the
independent parts via the normal route for kgdb code reduces what I
have to remember acking.


Daniel.
