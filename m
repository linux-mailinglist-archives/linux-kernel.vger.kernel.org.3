Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEF0557EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiFWPmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiFWPmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:42:31 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91E443AD4;
        Thu, 23 Jun 2022 08:42:30 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w20so34017477lfa.11;
        Thu, 23 Jun 2022 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QkCA8tVKb/PLWufyYNDgakOlZcrvMNkFvlNcb941ot4=;
        b=j8rwaqjhfOXAMDE/XEN+lq0ArzvDA3aYvOzSiFVrqUVdLq20y88AhkZ9gCPam4nKbu
         IIgs8ScdpSu4CH6HJNUTvWQq3Z9MlcuIuG/DtX9L9u5/x9gh4+9lEkC3M9H32X/3XOsN
         1O4agBtasHCy6BqgTDPcWPT7wCTcfam4X269PEkWZ+aeNEEWksnWRuEqY2tEjeJWL/TL
         qzdhWrTPHQh0X6+pywz9iygIGw1wx+8mi8lS2JqXHMSppt6SinCJY56GjEMs5pV8IOxC
         MDhzxgnlXiwRCe/HoL83+s/wdmzHKnCdv1+qy5vh9Tk8xorrY9za6VczmCVTwA7MU0KQ
         q6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QkCA8tVKb/PLWufyYNDgakOlZcrvMNkFvlNcb941ot4=;
        b=8Q4Z/dJHPRIvbIeDxV/pTg96k29EgVFaAk+3HuK/UtcrKeMzqV/tm5FN0OKXz9d3pk
         0pf9/S0VBzLSZeLouxqrGPomhOJLDTJM3K94uySz5q+aDOtnO9zrIvmj8aAl55Z8x2cV
         WjlNwtZLVnSRt2ua9xAAkh9EtaNFzhx/avSGZPJdPczrrNFlYkw+WV/pS/KeiCM+gPrU
         xzohmMsMAmYsRDZ9Ekd9zk+XVXR1O9lK00vjW/wruTliR4x0d58tLkv+Z0Nx5R1q58VA
         kyiqkntxyg0/pIxytzo0EqG69eKapsPIdM5Mil1g5EIZE4C19EN3YDnI8PbVM6dv5TxQ
         aotw==
X-Gm-Message-State: AJIora/JNSJsVBCDMPosR90nekmjyPu/lzpRQZOs8aSdTwZqox7STl0W
        2PaKZNnHc4zZizAf3cQO9XbRatgp9eSrS379
X-Google-Smtp-Source: AGRyM1sOhRl6zUgnTzeFzWpHN5w+k8SDhz7fyqolmeXwdbDOsoMrz74pMrzsB+LZm57/1JiEoGdIJg==
X-Received: by 2002:a05:6512:1523:b0:47f:7940:4a24 with SMTP id bq35-20020a056512152300b0047f79404a24mr6112760lfb.516.1655998948939;
        Thu, 23 Jun 2022 08:42:28 -0700 (PDT)
Received: from sakura.myxoz.lan (2-248-181-228-no2390.tbcn.telia.com. [2.248.181.228])
        by smtp.gmail.com with ESMTPSA id g1-20020a056512118100b0047fac765f39sm198379lfr.219.2022.06.23.08.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 08:42:28 -0700 (PDT)
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Miko Larsson <mikoxyzzz@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Subject: Re: [PATCH 0/2] Kconfig: -O3 enablement
Date:   Thu, 23 Jun 2022 17:42:38 +0200
Message-ID: <2817735.mvXUDI8C0e@sakura.myxoz.lan>
In-Reply-To: <CAK7LNAT3FrpLnhSgfTo5bxk-9cHm6g1ti58wSY6W-fxMx+mUrA@mail.gmail.com>
References: <20220621133526.29662-1-mikoxyzzz@gmail.com> <CAKwvOd=Bmu40+_11GOBTeJBjToUf0LNG_RX0RiLcRLimUUkgcw@mail.gmail.com> <CAK7LNAT3FrpLnhSgfTo5bxk-9cHm6g1ti58wSY6W-fxMx+mUrA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 22 June 2022 03:57:34 CEST Masahiro Yamada wrote:
> If you want to say "use this option carefully",
> EXPERT might be another option.
> 
>     depends on ARC || EXPERT
>

Yeah, this would be a fair compromise, though I think it would be
better to use "visible if" instead of "depends on". I can get a v2 of
the series together if this is desired.

--
~miko


