Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD7C58936D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiHCUpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbiHCUpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:45:07 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969D25C94E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:45:04 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31f661b3f89so182642767b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbc6TTtXlc6VfBsVBN6Hr/kOw1BsZ/pBPw82z6wXqKA=;
        b=fO2tHm5E31xgxyP5jV7YZutad8Ksce6Uw5qsAclptP3H0tjfYjncfphQKdonwZNos6
         qZeJwsh0Ff5hfhh8808UPJ9O2EXBGdlPEBUkSS/DFe8puDHOLGnVoNy7DS/DdYG39cgc
         BREMvgUsOTB3QhHfilSrPB5KeC+oA8dDlFKPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbc6TTtXlc6VfBsVBN6Hr/kOw1BsZ/pBPw82z6wXqKA=;
        b=nSkTD2VZX2TwCMedmL1SJKLb44dDEmr7dwwXMheYUjXoZZFp8VTpjoPivG0EG2bNYX
         tuMTXDzF5v10yFnFED0z9M5RvtXo8c35cFQ6+aXjDYmdYve3d801Xe83AtKov24LmLVF
         KKcuqESeYWnoXgY2HIVrYlqdV/DleZFwZdThhKqsxd6kkCfnIPfAhKCBXQKItddYVgDV
         iXbdCM+fB5szVnLELYVEdtkWdhiZVDif+sDFBrV6mmMrB+KKMl0PH8C65a2S8Vhi57Kx
         WbeIwtR83Jp2hRLpEKR035xjbGlI0+bmSULHHmpc+uTNARdhP1q0oXY4dRMRckxg1u0r
         1Zog==
X-Gm-Message-State: ACgBeo3q7vc6qWDCuwOE6H66gC78BakQd06543IPltuk12yPUttcs5d+
        XdXrWHKrqoo9qdmt1hf31MQZXwRiO2bz8GVlUKRJFg==
X-Google-Smtp-Source: AA6agR4DWBxQCeBDkeUkSNrGwu0R53bNTNqwoEG4P8nAjMgXO1ikzLAwVFJaxgNYWFjZYGyySNaKuIdRFLzaZE5j1oo=
X-Received: by 2002:a81:55c2:0:b0:31f:645b:9858 with SMTP id
 j185-20020a8155c2000000b0031f645b9858mr26357883ywb.296.1659559503829; Wed, 03
 Aug 2022 13:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220704000225.345536-1-dlunev@chromium.org> <20220704100221.1.I15b3f7a84ba5a97fde9276648e391b54957103ff@changeid>
 <YtB45Lte5UhlEE6y@redhat.com> <CAONX=-dEG121RQ6L-4fPMXrLXb3JeYNVNiPzHXNaRLbwRzb3bw@mail.gmail.com>
 <alpine.LRH.2.02.2207150528170.5197@file01.intranet.prod.int.rdu2.redhat.com>
 <cca5b463-a860-de8d-b7e4-a8d30aef2ff2@gmail.com> <CAONX=-fJHgfGkwR5A1MT+8FHckueehOsUS_LyHkjrgp4Y+vOgw@mail.gmail.com>
 <CAONX=-ft=ewFDui4jmd2fvcNr2EJc90=ZNOueDdp6HaPZmvObQ@mail.gmail.com>
 <Yun4LH+StcuBXRtO@sol.localdomain> <CAONX=-esLr5bGUks_a8wQBky37NnCawh2eOMemYg32HcPA7pmA@mail.gmail.com>
 <Yuq9jhxb+WgO55KJ@gmail.com>
In-Reply-To: <Yuq9jhxb+WgO55KJ@gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Thu, 4 Aug 2022 06:44:53 +1000
Message-ID: <CAONX=-dCrJabyvt2S24kEJi38Pbuzj_4kvugoF_75PWV69bNJw@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 1/1] dm: add message command to disallow device open
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Zdenek Kabelac <zdenek.kabelac@gmail.com>,
        Brian Geffon <bgeffon@google.com>,
        Mike Snitzer <snitzer@kernel.org>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Have you also considered unlinking the device node (/dev/dm-$idx) from the
> filesystem after it has been set up for swap?
Yes, the node can be re-linked with mknod, thus is not a suitable solution.
