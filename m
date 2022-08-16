Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB808595455
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiHPIAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiHPH7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:59:52 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351C221B0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:17:30 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r22so8333487pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xtfLJFeq7KJmGp5b08D7762+0fkYYHlzw8ndFlIv6/8=;
        b=iEFLln7SUkVgiSVatyIJ0rgtVu1c3eQtPYi/UTba85l3P1mhEQfL7npNy8KT8qnMY6
         RW0hzECh/txbQdv28lgSHHYo68qqPjXnAEDRwj98oajnoaQII0+bSW+5ujZqcaCu3eja
         UGYsjAr3pqxgcYGyLLBP3F8JIJoQ4VavLKVWGlGc6DwtrSyjPGy41PFqu04ViOrTGXKn
         WeyD0eXrXGuaLmwQwWdsHY2KaRPEe885oRPhLOl6jV3yVWdXEJShquAB50lXTtQcCAuJ
         01oAQaTHpiRr6nqa1Ev38S0bOx/LfpMOAQvoHW9QaQ57frYyXXiyt441cbeo3gk6Suw3
         Gqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xtfLJFeq7KJmGp5b08D7762+0fkYYHlzw8ndFlIv6/8=;
        b=eQcOxl67qt1bu/fhwGCIcfovkoQU4mbEIJZ7+VqUMA9KYx8PTfRHpSVuEfNNSDpnxK
         fowB2DOkZ3M2kyiyg/Ulvwc+z6P2/imS/aKAGN4PdE1I0lsdHH/jUK2TKMaXOdVLydI8
         MEm87sc/DfrVmF6LUt2nCIHeK6/Y81Am4sltOo7zrxii/p4iNWxd7B/3oFWBwcprlbFc
         Sa3WUzVQggy22w/Rm5/7HSFWHJka36bay0/+yaeLzv5+wpGZ0RMzheSEfsFaB6azXpWV
         1zaI4fjgrTyFTMflFOheUnhmLGE/e5g3jQwVxUdYL2NfEMZc8Ye0G3fu2+2Y38GbE5bk
         OWVA==
X-Gm-Message-State: ACgBeo0j0pG06RsvTl+CcMJLs0XJqdpUVSWOSvPOBYUs9z9teDlJlI/l
        1JslZZvTZvJIYEGHyPLOQF2cHw==
X-Google-Smtp-Source: AA6agR4BcxNmD1Pm9xD8n8vGEFIQpkjNU1SDTEfllcu3E92rWWZeywA28KmiIeY7uKZa5K3ZqYj55w==
X-Received: by 2002:a05:6a00:810:b0:52e:7dc8:c868 with SMTP id m16-20020a056a00081000b0052e7dc8c868mr19559027pfk.36.1660627049586;
        Mon, 15 Aug 2022 22:17:29 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:2e7e:eaac:df8:6465])
        by smtp.gmail.com with ESMTPSA id z185-20020a6333c2000000b0041aeb36088asm6599182pgz.16.2022.08.15.22.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 22:17:28 -0700 (PDT)
Date:   Mon, 15 Aug 2022 22:17:23 -0700
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
Message-ID: <YvsoYzIhOtX9DOi2@google.com>
References: <20220815211919.2028890-1-isaacmanjarres@google.com>
 <20220816042507.GB1108868@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816042507.GB1108868@roeck-us.net>
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 09:25:07PM -0700, Guenter Roeck wrote:
> > v1 -> v2:
> > - Fixed the logic in __driver_attach() to allow a driver to continue
> >   attempting to match and bind with devices in case of any error, not
> >   just probe deferral.
> > 
> > Guenter,
> > 
> > Can you please give test this patch to make sure it still works for you?
> > 
> 
> Not as well as v1. I still see the clk crash with versatileab, and imx25-pdk
> emulations now stall during boot when trying to boot from usb.
> 
> Guenter
Thanks for trying the patch out. This patch isn't meant to fix the clk
crash that you mentioned on another thread. I had made the following patch for
that: https://lore.kernel.org/lkml/YvqTvuqSll30Rv2k@google.com/. Have
you been able to give that a shot yet? If not can you please test with the
patch in this e-mail and that patch?

Please make sure you do not include this patch as it is known to cause
deadlocks: https://lore.kernel.org/lkml/YvXhJRlHN9OAIA5l@google.com/.

Did you test imx25-pdk emulations with just v1 of this patch previously?

Thanks,
Isaac
