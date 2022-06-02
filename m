Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E515353BF13
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbiFBTqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbiFBTqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:46:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49108235
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:46:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x62so7574864ede.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 12:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8dK6D+XTwQM6Q2wZRKTjnaTGLe0PvZRBSojaTGRw0o=;
        b=Fw9O5ZQr2akCs4XmkAleh4S1lzR/HnmE+gr+ExVcOzwPxlPBN+cxqks9XAmHum3a9r
         EdR/pADzdNu2xsnplxjkFSOSAh4MgTkZa39ydrHWleBPDB0V3sGb1fyOvp86Qg0iOUmA
         ZL4/cbSunc8oCfQv/NmSPlM9MXREEBXgNEDzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8dK6D+XTwQM6Q2wZRKTjnaTGLe0PvZRBSojaTGRw0o=;
        b=JIM95eeVc6Bxn4rSA8whJWH5nqYtGQnfOrltUGaV3DUoTVeJ1oBv7Vjt80KwvG7tef
         HiFNVHkQv6PbXJd9bFvnsqswb/o5aOsNjYXk9eB2zr/x9lkOH0P4MxKn4Jc/uUPeMofV
         xXbqh0JFB8DlIK6K6exn9/ZrLDaU5VLuDlwlW0MFDhBLfP1hx94rLO9JcWBIXbxpQmxq
         SXawji+qZ2PONSg7I/eTAStTVYNSpfZTzJtq4aaef0lqJISuTgFXKcG+5Qtewst0tb3+
         kE0Ux/gxBWO1SaWJp/wKfONI2Hu1qvbbdi9hzrasg7eDjK8nf3lLEzmuLrtD8pEvrEty
         TlcA==
X-Gm-Message-State: AOAM533ytRGROENGFA53x3SjrlGnno7JFn4NfVVsFwyjGlQnLWHj78jE
        8EOObPeCVbgMQDrtYolVPGxocNn0kUWkIteUSFE=
X-Google-Smtp-Source: ABdhPJwEF2d71LX73zEKn+zqWxBmwsY8aAPI/HXm8wJo9O5pq2By174qSenAooW1X5fAd5605aoOPQ==
X-Received: by 2002:aa7:d14c:0:b0:42d:bbab:43d6 with SMTP id r12-20020aa7d14c000000b0042dbbab43d6mr7241400edo.15.1654199178615;
        Thu, 02 Jun 2022 12:46:18 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id j12-20020a170906254c00b0070759e37183sm2010057ejb.59.2022.06.02.12.46.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 12:46:18 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id x17so7725217wrg.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 12:46:18 -0700 (PDT)
X-Received: by 2002:a5d:6da6:0:b0:20f:bc8a:9400 with SMTP id
 u6-20020a5d6da6000000b0020fbc8a9400mr4890049wrs.274.1654198848176; Thu, 02
 Jun 2022 12:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220322140344.556474-2-atomlin@redhat.com> <20220602035653.4167316-1-saravanak@google.com>
 <YpkMelZC+E5hKTw6@bombadil.infradead.org>
In-Reply-To: <YpkMelZC+E5hKTw6@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jun 2022 12:40:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit6ttmzdFsbH+YLkMeLucTspYADHnENn4fBXNrit0BUQ@mail.gmail.com>
Message-ID: <CAHk-=wit6ttmzdFsbH+YLkMeLucTspYADHnENn4fBXNrit0BUQ@mail.gmail.com>
Subject: Re: [PATCH v1] module: Fix prefix for module.sig_enforce module param
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Aaron Tomlin <atomlin@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, Allen Pais <allen.lkml@gmail.com>,
        Joe Perches <joe@perches.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jason Wessel <jason.wessel@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Android Kernel Team <kernel-team@android.com>
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

On Thu, Jun 2, 2022 at 12:16 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Linus want to take this in or should I just queue these up?

I'll take it, and remove the unnecessary #ifdef/#endif. The #undef
might as well be unconditional - simpler and doesn't hurt.

            Linus
