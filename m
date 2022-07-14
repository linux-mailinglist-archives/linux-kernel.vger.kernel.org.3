Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6938E57551E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbiGNSee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbiGNSec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:34:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD6D6BC15
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:34:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bp15so4952187ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqYZBmeUsaJiDrPDnwdrO1TyojMly/IYpZnkKBrChTo=;
        b=Uk8r1h0dDI69+5IH2XRon08rvJXZZD5N4ch9x6PYg/hcWZYK9kXPWJWyrBJI98tCEV
         Rv7nARX9+m9pytkl+411YJMzGJh+QTuXwd3vmuecTfAUch0NUrZEtCux4joYjVnIf14C
         RkrUv7VWkmEXYhQG9OUGIO2d7Wsw0Cb8Deb0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqYZBmeUsaJiDrPDnwdrO1TyojMly/IYpZnkKBrChTo=;
        b=UBWNASN+8fPUJRg1eZxSO7Rax0auUfUe0I0rrrehvShbq0PP4ddDLV1sg0enOo7FLy
         L4OqDhTDxvAhzu6ppbhm2FGdEzXHzOr0HpMCY0f3M/zHHSc7wbPfIjfP90l5PdxgRe6Y
         zQAkUbUawF6+a8zdFqs0sWhzI/zgYWrs+GHEkh3iMAL6DbFE/BYI42vrDgBdG6EIB9pg
         NL4ciyWw6uaWCtbJk3zvBOWr3rxXkooun75HC3VSmB3vbsjaNUEBtjgAGnFkndtWfYCj
         DUgh9RDQLtjkAmfqHFefqBABDWeCsR4biRYiAqJnW3iTiby6EAOEqgynRYgFkO0Rnh53
         Db7w==
X-Gm-Message-State: AJIora+9VxBT2snKSEpeCg+uUSsg1NBACEFiaW8v5lL6ZVYxLMpk0olg
        tHSHYkAxsAfGgOPylo7VKWpbGhPOtmymHcCvXdM=
X-Google-Smtp-Source: AGRyM1s4d+YXYAB+Cvmjy07/ZJUOugrAZaEOnjcAlcOJTyX9XZ/u5jl1obTUFAXJeeoksPHkXRQ9ug==
X-Received: by 2002:a17:907:7242:b0:726:f510:4bfa with SMTP id ds2-20020a170907724200b00726f5104bfamr9850945ejc.219.1657823655074;
        Thu, 14 Jul 2022 11:34:15 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id k16-20020a17090632d000b0072b2cb1e22csm982494ejk.104.2022.07.14.11.34.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 11:34:14 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so3566940wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:34:14 -0700 (PDT)
X-Received: by 2002:a05:600c:2d07:b0:3a3:585:5d96 with SMTP id
 x7-20020a05600c2d0700b003a305855d96mr2740169wmf.38.1657823653896; Thu, 14 Jul
 2022 11:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mtQwDNtprMOXog3Az8av3hjdFWOCVfk8xmaP4vKJO0tdg@mail.gmail.com>
In-Reply-To: <CAH2r5mtQwDNtprMOXog3Az8av3hjdFWOCVfk8xmaP4vKJO0tdg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jul 2022 11:33:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOMyh4mWTAp-o_402EHLsJ4MMY4d7ja+Ec0x0=B=UKAw@mail.gmail.com>
Message-ID: <CAHk-=wjOMyh4mWTAp-o_402EHLsJ4MMY4d7ja+Ec0x0=B=UKAw@mail.gmail.com>
Subject: Re: [GIT PULL] smb3 client fixes
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Jul 13, 2022 at 8:36 PM Steve French <smfrench@gmail.com> wrote:
>
> Three smb3 client fixes:

You don't even point to a git tree..

Please use the whole "git request-pull" thing, and include everything.

              Linus
