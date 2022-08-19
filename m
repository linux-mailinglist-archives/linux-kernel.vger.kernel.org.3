Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FA759A909
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243124AbiHSXDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239974AbiHSXDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:03:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850AB2ED52
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:03:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s11so7258677edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=eY3PGy+0ZnJYOusZqP/aMVjX0RIvUyfRFC1DMWpFfZg=;
        b=glGObiSPFperSGxZTSrRQtOSI2VugiytakxkMo/TSWxujrcWOKdkyRiEv6nE/LINGk
         krDnH1N19krP5sxNpCGq8r+aEt5vPLQAZTYJj6IGIKa+N4KHdt45fEnDbmgWfNihK7NC
         ozvdvHCx1qpMQl+ckHq+g1duXCyWHZW/7xYN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eY3PGy+0ZnJYOusZqP/aMVjX0RIvUyfRFC1DMWpFfZg=;
        b=MoE1YAptigBRf93Rw3UqWwVMZvaYMmzXhEqLlsYnYm+wGqkAaHn4ciNwSiA5tC21Wc
         X03jZ0p1Gukgpbg7FC4CSYmcU0GYSVVUjJAkArxO1jK94cgHkhpx+nwKsYFTmB9eeB1R
         tl3iEwVUHMRwIOLx8ntrLE7coDpQt1IUAlaid2UY5ebzNycsRPfh+uG76G49YEv/iqyQ
         AtInzOBzx7cCgJDXWpOfz+xGnsc9V99MCW3NZZWL91UMM7OS3Ytcl9jiqWdd30mfEmD7
         EvP5qz5soPn5WDAXQ/2IRVrYn3Zi64QfvR86IL4jEPaczxkOdADU92/EBzcH7QSn5KSG
         GZVA==
X-Gm-Message-State: ACgBeo2y32tnbyq+SQ/6PPaJrat0koLJ1zDK6eIUcv/XUyQ9VeK4i+Mg
        +N42g49JdSyI+ERq5/v+fBRFKBuec5+eWd93hdw=
X-Google-Smtp-Source: AA6agR4t+r6Y9vUoJdhGnWSvYHcwTF+s/zUS7VmkYQi1Yt1xE6v1far3XSb9lxJ6/WmuxctbFVKBFQ==
X-Received: by 2002:a05:6402:440c:b0:43a:1124:e56a with SMTP id y12-20020a056402440c00b0043a1124e56amr7839133eda.134.1660950217796;
        Fri, 19 Aug 2022 16:03:37 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id bj5-20020a170906b04500b007307c4c8a5dsm2905060ejb.58.2022.08.19.16.03.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 16:03:37 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id u14so6686502wrq.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:03:36 -0700 (PDT)
X-Received: by 2002:a5d:6881:0:b0:225:28cb:332f with SMTP id
 h1-20020a5d6881000000b0022528cb332fmr5244944wru.405.1660950216654; Fri, 19
 Aug 2022 16:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220819194336.382740-1-ahalaney@redhat.com> <YwATSglfJEgG6V73@sirena.org.uk>
In-Reply-To: <YwATSglfJEgG6V73@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 19 Aug 2022 16:03:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UWn8a9C3j0Ky9JWqo_2AvOE=ORVP94zHftGQLsxFdXyw@mail.gmail.com>
Message-ID: <CAD=FV=UWn8a9C3j0Ky9JWqo_2AvOE=ORVP94zHftGQLsxFdXyw@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Clean up on enable failure
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, bmasney@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 19, 2022 at 3:48 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Aug 19, 2022 at 02:43:36PM -0500, Andrew Halaney wrote:
>
> > -     if (regulator->uA_load && regulator->enable_count == 1)
> > -             return drms_uA_update(rdev);
> > +     if (regulator->uA_load && regulator->enable_count == 1) {
> > +             ret = drms_uA_update(rdev);
>
> I am vaugely surprised and a bit concerned that drms_uA_update() can
> fail...

In his original email Andrew implied that his system was misconfigured
when he was seeing this error. I presume this isn't common which is
why nobody had noticed this before now, but given that the function
drms_uA_update() does return an error code it seems like we should
handle it properly in the caller.

-Doug
