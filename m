Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA8F526C59
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 23:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384684AbiEMVfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 17:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiEMVf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 17:35:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93422BF42
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:35:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id z2so18573625ejj.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hiVPxXcKKvs645f67vw4fyY/1EsP6WHDPNLF6XpOy5w=;
        b=HFmcXKKocCOzY3L6xyzBOyni/8lIT2JdWo0u7Ysyy5wAt6MrKm4qeL6DNirn9aeASA
         ktMiw4dXw+ne9G4D77+hwy/+EGmJ9hzRn/d/z6jmitjPMRfTFg5OMoh3Vd/g97+e1sdo
         YpPUNQ3kaml6Ku+FRklpuChMSC+3BWxpVaqjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hiVPxXcKKvs645f67vw4fyY/1EsP6WHDPNLF6XpOy5w=;
        b=C0EkA3cjhz7q1jYeGeKiUieYOsY8lkU89luRGpQiqgw1ksv71oRJq1ZwCyX625jImE
         i5xlvrynr2eOJ94mHtilj/V35WvbUUCRuFO6NUkBHTA1drscS5tlhmu+kT65xtew23+D
         xKiCpnfrGOQw272WF+lS8OCHPhgAODW9j3Fsub2I6o9pnjKurLbjeqt+NxhamMLDYHtE
         fV2L4zKtq4Ng/vQVXtivoJQaU+3GU2R7aSPXOTyHsqvRereetwpNRSCYodtcXcC1gtce
         cLaIxHhBilncsCtLPdu8sPsc/8RTwkiDYnE/J39Yxcc/oWaMOFd3bmqlU5IJ7Kq4EH4u
         GCLg==
X-Gm-Message-State: AOAM530yCRv2DvULgSim0HU2D8VG2Xc/z/IR0DIn0Xb8KKiBWUxXbM4T
        z3noOVrKJXUz0lhhW4Dw0sUcnLd3+6+aQDRj
X-Google-Smtp-Source: ABdhPJxRWuguKSu7S6x9+DNNXAvQ+nRXb7QUcmOSrL9z5X9ERDJ3teMP/KxkwPo3XIHD9RIHTuoXiQ==
X-Received: by 2002:a17:907:90cf:b0:6f4:346f:f771 with SMTP id gk15-20020a17090790cf00b006f4346ff771mr5926031ejb.574.1652477723951;
        Fri, 13 May 2022 14:35:23 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id zd21-20020a17090698d500b006f3ef214dd0sm1138486ejb.54.2022.05.13.14.35.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 14:35:23 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id p189so5437850wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:35:23 -0700 (PDT)
X-Received: by 2002:a7b:c106:0:b0:394:19aa:4f91 with SMTP id
 w6-20020a7bc106000000b0039419aa4f91mr16898739wmi.68.1652477722759; Fri, 13
 May 2022 14:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220513210710.4124506-1-agruenba@redhat.com>
In-Reply-To: <20220513210710.4124506-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 May 2022 14:35:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjnfgmUuYBrXSjXD167w+87EZyMT79h_iTH84+__wtbw@mail.gmail.com>
Message-ID: <CAHk-=wjjnfgmUuYBrXSjXD167w+87EZyMT79h_iTH84+__wtbw@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fixes
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 2:07 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Would you like to still pull these fixes for v5.18, or should we send them in
> the next merge window?

I've pulled them. Any filesystem corruption issue sounds scary enough
that it doesn't sound very sane to delay fixes.

            Linus
