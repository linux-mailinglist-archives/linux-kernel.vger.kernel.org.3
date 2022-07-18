Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3C3577EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiGRJq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiGRJq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:46:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC830DEE5;
        Mon, 18 Jul 2022 02:46:26 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p9so11207889pjd.3;
        Mon, 18 Jul 2022 02:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ctJQ6AM/Pja5lnBjSFmOp+KisKGF44rmZ2m0JhEYL+4=;
        b=JA6RPAAaoE0hcLLuOcByRxWP1D4RciL1PCAzlZaZ3yolVYFJqnGomFFhv5qlsqojXp
         wEID1IYL6jEULP7YMNW08PVhVcKGS0Lf/bD4QRkxby+UP3kNrob5lUPutr1IR6UrCAVw
         F9d2Ed72D/otfGChZ9W1/UdGtJmOdN1UpU2kKiLhwUCpz8NGWZZ1bLitRr0blvcAxLdJ
         7kJsbt94mT4U54brrlxwnItd+6+LSKsGz9JbMlHuUOHDhXusN9s32qStvE7fMPm5fBe3
         u7kK3+SBhktNiuqFgxwmNHjizjYw2ZfvtwrcHVbxjwCRsy2HdMP1LXpbr0j7wx9ULOfN
         WbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ctJQ6AM/Pja5lnBjSFmOp+KisKGF44rmZ2m0JhEYL+4=;
        b=gb6szlkl2ok5Xx2uZL25uAzIGMqiRmo48b8VPzZ7xIF7Kbxx8VF6nZBaHYZGnipm27
         9vViKuhudwB9KqNAAroOQQVS13b2Bd5JHTw3UpKCNExXr16kNl95NXmgIuQxHGgtbULB
         BkrqwxNTkjSvk8O1obFp+yGLmdEJdSsVIfjbtCv1JXFycXSoUjyn0HYG0TW58Ixp9m12
         hS95b4g4ODsF/IroefbEIZ82wj9lDPtLp4H8RoRQ34bPwOpzT69pRfQsucpVPY6SYJaK
         huBPMfoNFUZXoTAuamvVIkyluAtHx0e/kPW5JhlA1BkP5ncTTEwekSnqEiQ4Xs/tePVX
         YQhA==
X-Gm-Message-State: AJIora8r6gcjWFGYxEFgOyuYuRJoElSKdBRJZPUntg6MESi07IzBWEpW
        2QeTFlSxNeb/+XE98EIjiFo=
X-Google-Smtp-Source: AGRyM1vb/qOuRFkQ0DKTrlZnnKSeyMmI0vvWIYM2p/kMT0u5Abjuq4SBCsyxGLpxIamV3rbvI3tdsg==
X-Received: by 2002:a17:902:ea08:b0:16b:fdc3:8b3b with SMTP id s8-20020a170902ea0800b0016bfdc38b3bmr27436238plg.68.1658137586190;
        Mon, 18 Jul 2022 02:46:26 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id b132-20020a621b8a000000b0052a75004c51sm9011478pfb.146.2022.07.18.02.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 02:46:25 -0700 (PDT)
Date:   Mon, 18 Jul 2022 17:46:20 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, dipenp@nvidia.com, andy.shevchenko@gmail.com
Subject: Re: [PATCH v2 5/6] gpiolib: cdev: consolidate edge detector
 configuration flags
Message-ID: <20220718094620.GA96704@sol>
References: <20220714020319.72952-1-warthog618@gmail.com>
 <20220714020319.72952-6-warthog618@gmail.com>
 <CACRpkdZ5O7iNOaJgq5D8hpQDO207DsQkqjRu_m1aZSPy5_qoJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZ5O7iNOaJgq5D8hpQDO207DsQkqjRu_m1aZSPy5_qoJA@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 11:33:48AM +0200, Linus Walleij wrote:
> On Thu, Jul 14, 2022 at 4:04 AM Kent Gibson <warthog618@gmail.com> wrote:
> 
> > Combine the polarity_change flag, struct line eflags, and hte enable
> > flag into a single flag variable.
> >
> > The combination of these flags describes the configuration state
> > of the edge detector, so formalize and clarify that by combining
> > them into a single variable, edflags, in struct line.
> >
> > The edflags is a subset of the GPIO_V2_LINE_FLAGsb relevant to
> 
> What is that "b" at the end of GPIO_V2_LINE_FLAGsb?
> Oh well no big deal. Bart can fix when applying if it is disturbing.
> 

Yeah, typo or something - no idea what that is doing there, but it has
been there since v1. ¯\_(ツ)_/¯
Bart - please do fix that if you don't mind.

Thanks for the review.

Cheers,
Kent.

