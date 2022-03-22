Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0444E39EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiCVHz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiCVHzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:55:23 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220374338F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:53:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id yy13so34450870ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AAxWSvxZc3dHAbuVIHS0Ej6XKzk9JLz41VAoFlDO6jw=;
        b=C0uPodIT8HkST7rvrjEAsthafRPgDgdeogyPa1un9cJDZbJa20Jdr8DaXZoQwie8Rp
         ixs06Tox9foTZsYh0W4rZGlhEGSSnf8vzLBth3PHPtfpjbQuwwT32koIj3xMhRkuE35h
         mE9UL6Phgcf5ouszXqr829JHPnvDZRTUYybjYSD/53BKorbjQtcPrFnpZBR0ewkTJHPf
         TChrG8h/DJhGId7IDw1fS/XN/NneBtnb39sgjeNm5wSbv8QEpQ1rDfP/KIYwYPTSHObU
         6AqyTDMaTD6K0p2jV7IDqmIO+bQqhSdnK8Xa8JlOKnyNXwcBWkmSV3st3WKB8oKoxPRM
         hhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AAxWSvxZc3dHAbuVIHS0Ej6XKzk9JLz41VAoFlDO6jw=;
        b=HR678o4wDpQoketq4QpTN0WCHVIR2syJSfmlpdDI3EbXYnNS3gjcxqcSV6JMrDK847
         A579xHLORmC5LYCfYLpbKbJSXslbNKnDORCVkKrGRWgdjounmMXnZfmPlwGqN8tG1Cbd
         yoMMzMgWMegeEFzhEInQfNsXWyqiDPJhFkZs5KI4H4fHtUQ5ie8bd/juq83iYJbmN8sy
         ZVsHQoFrVodY97OppfXZbvI055IbxD+pKPRykas0CM4j3mU301IcflUbKWXxU2wUu7S+
         UQ4P0YVeF/9hjM27lewF+I8NRLgRfA9qOhsKm2WU59hEnXLvFIyJhggM0+REvE5hGAh+
         i9Gg==
X-Gm-Message-State: AOAM530z5MuMONO2IJHRxzdIJEewVRBmDT6Y3SwNLXTKRr/AODA6bA9D
        4Uc2q8bkDJ6qCDjbsou8dSc=
X-Google-Smtp-Source: ABdhPJxhTfnbx2XGatBlTfA7tIzj0wD63Dzv0AJ5fDSXXhpdMy6c64spTxxCKLobqnFlUuWCj4acoA==
X-Received: by 2002:a17:906:69c5:b0:6cf:d164:8b32 with SMTP id g5-20020a17090669c500b006cfd1648b32mr24065603ejs.233.1647935630735;
        Tue, 22 Mar 2022 00:53:50 -0700 (PDT)
Received: from gmail.com (0526ECD0.dsl.pool.telekom.hu. [5.38.236.208])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm7763971eje.183.2022.03.22.00.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:53:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 22 Mar 2022 08:53:46 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] sched/headers: ARM needs asm/paravirt_api_clock.h
Message-ID: <YjmAihCq5jtUVXvq@gmail.com>
References: <20220316204146.14000-1-rdunlap@infradead.org>
 <Yjib7hDFRFEOwaWf@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjib7hDFRFEOwaWf@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nathan Chancellor <nathan@kernel.org> wrote:

> On Wed, Mar 16, 2022 at 01:41:46PM -0700, Randy Dunlap wrote:
> > Add <asm/paravirt_api_clock.h> for arch/arm/.
> > 
> > Fixes this build error:
> > 
> > In file included from ../kernel/sched/core.c:81:
> > ../kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
> >    87 | # include <asm/paravirt_api_clock.h>
> > 
> > Fixes: 4ff8f2ca6ccd ("sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h dependencies")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: patches@armlinux.org.uk
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Applied, thanks!

	Ingo
