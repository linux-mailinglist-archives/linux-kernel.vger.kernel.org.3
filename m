Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9825A84CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiHaRyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiHaRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:53:53 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B0DD3EE3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:53:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 145so14809804pfw.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=TCHXvXXfsYMY/A+ca/BPmy8pA+KX4i6MvCSQqrCuFrY=;
        b=PrQjLxbUTyZbiLFvdw8FQEAo6f5OIhTn3sUnehV/RWerJNYqPFVObhST43ItqCNcpX
         JCaQSfSgFZcFhr5WDeVAiJbOm1J0cV9+a5Bfv5lfPwcB1OdyzY/r2ZxmtVBqOzaK5R6j
         VB5P+l6QjQnA4VotyG9pa0lbCuc4Olc13d/9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=TCHXvXXfsYMY/A+ca/BPmy8pA+KX4i6MvCSQqrCuFrY=;
        b=rClii1FExK/1oVo9jYgcD8QC7J6N0Q623FDWl7XTlTSBbrQ7dOk4GrY/j1mtemUX48
         MWFp37MMEJvL5IhPbtaPS/6SVd5DIbDouP3lsMD1e5ris3NaN5wI47rZZNpoVKpiwR43
         dqtFV+ApMlc0/PjOAvZ0koGrjLdBz8WjvZ2lHtKbFeK2Zhw3sUWPzF2sH9gPOjDWgyJC
         5ohro9GlMZURgKp3F1FzZ7KlLyQu2D3dJArEwm2JPcenJcKTKwp4+LXUVaH3huGWb3YF
         mAVTfXO2lmduLsCZ3Dekt0naN7asEJD047JnEqJjY8YhEQok9q6oJSdr8sGYga9hM7bK
         JqkA==
X-Gm-Message-State: ACgBeo0IggmTYJyXBvMzv2ocHh0sxhPgN4ESdpceQ4hhxmPmauEGe+8Z
        WT5jeMwcsDPQEEsbjrN64+ddEw==
X-Google-Smtp-Source: AA6agR45RigbgSbeDpZKVXLeeXze60AM0/D9DANwBTrmzYApw41B/VxEhGBL/PXNHrNGBxe4p5mVDQ==
X-Received: by 2002:a65:5941:0:b0:41d:a203:c043 with SMTP id g1-20020a655941000000b0041da203c043mr22427221pgu.483.1661968431923;
        Wed, 31 Aug 2022 10:53:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 201-20020a6219d2000000b00537d97ec301sm10307054pfz.214.2022.08.31.10.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:53:51 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:53:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Isabella Basso <isabbasso@riseup.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sander Vanheule <sander@svanheule.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 1/2] testing/selftests: Add tests for the
 is_signed_type() macro
Message-ID: <202208311053.B1C87B1B@keescook>
References: <20220826162116.1050972-1-bvanassche@acm.org>
 <20220826162116.1050972-2-bvanassche@acm.org>
 <74370E0B-AC37-435F-A44C-5DBAA8A38496@riseup.net>
 <3bd708e6-2cee-9177-5453-f6b152ec762c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bd708e6-2cee-9177-5453-f6b152ec762c@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 08:30:54PM -0700, Bart Van Assche wrote:
> On 8/29/22 19:33, Isabella Basso wrote:
> > > +#include <kunit/test.h>
> > > +#include <linux/overflow.h>
> > 
> > Nit: I don’t know if that makes a huge difference but you might include
> > `<linux/compiler.h>` directly to make the final object smaller. Of course, that
> > would ideally be a change happening in 2/2 but that was already merged :).
> 
> Right, that could have been done in patch 2/2 but I think this can also be
> done as a follow-up patch. I'm not sure what Kees prefers?

A follow-up would be easier for me. And perhaps could include Rasmus's
suggestions too?

-- 
Kees Cook
