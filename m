Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881E4590806
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiHKVZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHKVZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:25:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E2A66A69
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:25:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r4so24493118edi.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Av61MCjlR3mg8Dx2VvdjMo2UWGRPhMNNNMUbh2HIJOc=;
        b=XPy1b7gHNWhW4bPEJfCMKoDTBorrVE5knZYc0pr2Yt2Prz11wJwKGcC5w3T84v8cNx
         ENLBomSnMYVcdYS4Ru0Tv9sMoRNf4sdGGsYnRTuxk54JX8QdudMtFJ4/f4Kme0XbGqaC
         bEvdPalHXbbi+ruOg/Nm3c1K59DoTznTR6sjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Av61MCjlR3mg8Dx2VvdjMo2UWGRPhMNNNMUbh2HIJOc=;
        b=KN+ocKlDi1noGyCeq4XBk6Pp/nVMHcNuzE6lJztWFp6sO+Em+5S/ldIMJna7DBdztC
         eQ5TmI3lv5w+jd8vzrGtlM96FD+Vfaz2O0JabmCxLSIHVMNPj0SeRRLAOTnDnvemrJha
         ds2vpbkzq+y/4WMZAfhjR3PJdjyWRRkcEC+/fYjPNTDT2XgoIqpeppmxo5JK7pevgbjL
         tBEKLclsEWv+idI9S/13GUgz48IPygQeZ0D3zIaX+5ydyYzY4qk4bM/sTaIM5N9lXA3P
         HCtpP/V+aMi1tq86ItEB5MVbdvUkZfvSM0VCHiPtVWthWCItvRZqqh4P2PuSIUYZBfU+
         2tlw==
X-Gm-Message-State: ACgBeo0uSp5/xqgPKw/bkr8d0K/ef8t3jKkF22ULwJW5IjLqrEMGWVDV
        lSYbMHQ9h6uvWxta2SG6ZKYOiKHWNwzIKGeA
X-Google-Smtp-Source: AA6agR5axBe3VJcWKEdnwC/bl3QE2H6qXmQ8RESZFt9/VZqGfsseY0Mx3kN+48AjQYq0QyLMJp1eGA==
X-Received: by 2002:a05:6402:540f:b0:440:d9a4:aebf with SMTP id ev15-20020a056402540f00b00440d9a4aebfmr900815edb.196.1660253148545;
        Thu, 11 Aug 2022 14:25:48 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id ec8-20020a0564020d4800b0043e67f9028esm296827edb.20.2022.08.11.14.25.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 14:25:47 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id j1so22721652wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:25:47 -0700 (PDT)
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr414789wrv.97.1660253146870; Thu, 11 Aug
 2022 14:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220811185102.3253045-1-kuba@kernel.org> <20220811120902.7e82826a@kernel.org>
 <20220811124106.703917f8@kernel.org>
In-Reply-To: <20220811124106.703917f8@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Aug 2022 14:25:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0JE7EkqQajmhdvarwQBHYVOaSS5xqvtYpCrWmsZ6rkA@mail.gmail.com>
Message-ID: <CAHk-=wi0JE7EkqQajmhdvarwQBHYVOaSS5xqvtYpCrWmsZ6rkA@mail.gmail.com>
Subject: Re: [PULL] Networking for 6.0-rc1
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
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

On Thu, Aug 11, 2022 at 12:41 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 11 Aug 2022 12:09:02 -0700 Jakub Kicinski wrote:
> > Let's put this one on hold, sorry. We got a report 2 minutes after
> > sending that one of the BT patches broke mips and csky builds :S
> > I'll try to get hold of Luiz and fix that up quickly.
>
> Can I take that back? I can't repro with the cross compiler
> from kernel.org. I'll follow up with the reported separately.

I've merged this, and don't see any new build issues, so please do
report separately.

               Linus
