Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB85B2407
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiIHQ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiIHQzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:55:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1E53889
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:54:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b16so25336880edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=HYkXg+VQoVJj6IeGT/00BbjRESyJ1qTq+hPTwfNkG3M=;
        b=hVzEqYOplJiXNR0qXrqsMYGZoQbw587ASqutE/A55+sAOSlXgJ6GspWw2Ym+KjLXka
         fiaxTttTHvmbRlwxo1yprNkcGenIVm6v2Nx49Qv2Zm4QSy9S8vifjUDjmK3oX8Z98Yo8
         bXcHGCio0UTdcRTGn8wGqD+Uoj25XuP7XM2ccT4/Qbk5b3NKgr+0h4Wa+bgePeLKzxiL
         0STAI6oYqdIVxDXN6v5uRIXR/ozWRqSQ13UusKfeaHj4taFCEbCOxSPG21ZaNBMSR07O
         deGGGFuhD+92QUnaNMRrtxFDvv/JvmWyyGNsKNedGV5QaxIuI7Rzn4JNlNN+3SsVpdbb
         WvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HYkXg+VQoVJj6IeGT/00BbjRESyJ1qTq+hPTwfNkG3M=;
        b=UGg+TH6rDh4zMKcHG6Otmx005keSZA/TvTp+ccV08TUki4jWtylH7v1BR8M6nP7tb1
         pNFk2ScafiwyZ9V4aJ5rtuykqKfZQAMKOpMrK1QbNTSarfYAtWGk2hoc+EsYCBJdUGbS
         oTP3CLJlxfPfZTVwkRg/O1SXijL/Dv7piAsoDecFYi2nLk9znPJlcYheFfH7i0NFJNTM
         7Vh8ffTEX0QBYW0MpiNSpmxbvhZjuANTfKPN7xGsofgAkxUmnrDyuHrwy4iE8jgWcgo1
         CA2YKJ37WHlzhkTH5XkQ+CgZvBtxj90pXtYd4sya/tjq7rj/I2dgbwIRLItefpliw054
         7RoQ==
X-Gm-Message-State: ACgBeo2affbfNBjQTgMcQ7P/h9WkfjUSbO3aoMMxEk21AfW7A6Q/k2ZU
        O1Iz0Zte+DG6iKdK+4aLOF8TRQ==
X-Google-Smtp-Source: AA6agR4SmpRJpS84G3cq6HUzYMumaeFB7osxWETQkEUI/Bqq07vVb7t+xdKEmnn+1JHPpxc05yZ18A==
X-Received: by 2002:a05:6402:d05:b0:425:b5c8:faeb with SMTP id eb5-20020a0564020d0500b00425b5c8faebmr7831185edb.273.1662656066618;
        Thu, 08 Sep 2022 09:54:26 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id eh13-20020a0564020f8d00b0044f0c01196esm3628593edb.65.2022.09.08.09.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:54:26 -0700 (PDT)
Date:   Thu, 8 Sep 2022 18:54:25 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        mchitale@ventanamicro.com
Subject: Re: [PATCH v2 2/4] riscv: Introduce support for defining instructions
Message-ID: <20220908165425.ikiyrmhtbwkmko23@kamzik>
References: <20220831172500.752195-1-ajones@ventanamicro.com>
 <20220831172500.752195-3-ajones@ventanamicro.com>
 <3006889.o7ts2hSHzF@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3006889.o7ts2hSHzF@diego>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 05:49:44PM +0200, Heiko Stübner wrote:
...
> > +#define OPCODE(v)	__ASM_STR(v)
> > +#define FUNC3(v)	__ASM_STR(v)
> > +#define FUNC7(v)	__ASM_STR(v)
> > +#define RD(v)		__ASM_STR(v)
> > +#define RS1(v)		__ASM_STR(v)
> > +#define RS2(v)		__ASM_STR(v)
> 
> you might want some sort of prefix here
> 	RISCV_RS1(v) ?
> 
> While trying to adapt this for the cmo stuff I ran into the issue
> of bpf complaining that "IMM" is already defined there.
> 
> And names above are generic enough that these also
> might conflict with other stuff.
> 

Ah, thanks for the heads up. Indeed, if this gets included in another
header, which gets widely included, then we have a good chance of
bumping into something. It's a pity, but, as you suggest, we probably
need prefixes and __ isn't likely enough alone. I also see __REG is
used elsewhere.

Thanks,
drew

> 
> 
> 
> > +#define __REG(v)	__ASM_STR(x ## v)
> > +#define __RD(v)		__REG(v)
> > +#define __RS1(v)	__REG(v)
> > +#define __RS2(v)	__REG(v)
> > +
> > +#endif /* __ASM_INSN_DEF_H */
> > 
> 
> 
> 
> 
