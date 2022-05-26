Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59992535150
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244283AbiEZPVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiEZPVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:21:32 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FF93617D;
        Thu, 26 May 2022 08:21:30 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id v29so1413448qtc.12;
        Thu, 26 May 2022 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NdndBUPQFc2AHNMtWKEIAe8sEfBlN4yBEHOL2yF0WLk=;
        b=BaP6Ox/iakglLzb7/uTjsFBybf7eFxl7EfTomGR4rJ96HxTE96Tfef4TZecgAX1+B9
         TfDGpAjdmlA5a6aRhM5+h0s0+w8+iItTaM9ACnzj8y5HkIH8PpdGqN9L01h8Om9V2oEu
         /A1DO8lM0EXrryz2UH0aW6gpZnPFu1M3AFMjkqgPh7jGRGlz/HCq4r76DHil6OUj2BKY
         hMjjxEeGJYKMK34J7CjiWa+6Ao8Gz6+udnwDvadC7I2Psyby2acHJwOuDoi5coEOYFd2
         jd+ryVq97uTPXGDRYexttQ6p7FqhMCXrXX/+loLMsL23OTRoTWqdxnM4tmUYuZtVGGeQ
         izCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NdndBUPQFc2AHNMtWKEIAe8sEfBlN4yBEHOL2yF0WLk=;
        b=zrs6CSiqt+n9b3aT5Vo4NYXtniorMdDyVxwstNP7jo6fkFTcLcjrlD6dwhb+gLkXjc
         PV07GahK/hU4wuu7RiXZo4nikauUpav0etengEVZrU89TxuiIwW6mS7VhvDl3SmD06o2
         PCEilJG+dFkeMN4/Y1SEg+1pFugtAALhvZNuI2iPIxIMEl+9XYNAljtdBjWanK0nDate
         zDUxzOZty1h7+fU9yz+6If8catson2UPpG+QTvYR8iSYQRqzQiahaePj8zlMQu2m04cy
         jtIyqPqpTupUFDHjYnWf1ZulOHEvHa52jYm/777VWMjUutSjhG8lcCWU8+D2xPT8b2M/
         XH6A==
X-Gm-Message-State: AOAM532McGldPlVDISiUe3KddLbiYCEco0Dr2Z6QE3ad+/H9+o7PxlNR
        +2aKs4vMB+J80w/sroFyzqlEmlzxMOdk
X-Google-Smtp-Source: ABdhPJx7dyl9i+ZXjPdJvsbusb0bzAZmW6ieXYsVlgk/+deIzD/UwTkfCGpKuY+7Tzai8zlJRgC5nQ==
X-Received: by 2002:a05:622a:144d:b0:2fa:bdc5:6d42 with SMTP id v13-20020a05622a144d00b002fabdc56d42mr7726502qtx.152.1653578489742;
        Thu, 26 May 2022 08:21:29 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id n76-20020a37274f000000b0069fc13ce1dasm1251798qkn.11.2022.05.26.08.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 08:21:28 -0700 (PDT)
Date:   Thu, 26 May 2022 11:21:27 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: Re: [PATCH v2 01/28] lib/printbuf: New data structure for printing
 strings
Message-ID: <20220526152127.gw7gb4jnoikop4hl@moria.home.lan>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-2-kent.overstreet@gmail.com>
 <Yo+XZ4YtU9fN/sGE@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo+XZ4YtU9fN/sGE@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 05:06:15PM +0200, Petr Mladek wrote:
> On Thu 2022-05-19 13:23:54, Kent Overstreet wrote:
> > This adds printbufs: a printbuf points to a char * buffer and knows the
> > size of the output buffer as well as the current output position.
> > 
> > Future patches will be adding more features to printbuf, but initially
> > printbufs are targeted at refactoring and improving our existing code in
> > lib/vsprintf.c - so this initial printbuf patch has the features
> > required for that.
> 
> > diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
> > new file mode 100644
> > index 0000000000..40dc07040d
> > --- /dev/null
> > +++ b/include/linux/printbuf.h
> > +static inline void pr_chars(struct printbuf *out, char c, unsigned n)
> > +{
> > +	memset(out->buf + out->pos,
> > +	       c,
> > +	       min(n, printbuf_remaining(out)));
> > +	out->pos += n;
> > +	printbuf_nul_terminate(out);
> > +}
> 
> This function is not later used. Please, do not add API
> that will not have users in the same patchset.
> 
> There are several other cases. I am not going to comment
> all of them.

It is used in this patchset, in lib/vsnprintf.c. You sure about the other cases?

> > +static inline void __pr_char(struct printbuf *out, char c)
> > +{
> > +	if (printbuf_remaining(out))
> > +		out->buf[out->pos] = c;
> > +	out->pos++;
> > +}
> > +
> > +static inline void pr_char(struct printbuf *out, char c)
> > +{
> > +	__pr_char(out, c);
> > +	printbuf_nul_terminate(out);
> > +}
> 
> The "pr_" prefix is a nightmare for me because the same prefix
> is used also for printk() API ;-)
> 
> Could we please use "pb_" instead?

I'm not entirely against that, but I see printbufs as already in this patchset
tightly coupled to vsprintf.c and thus quite related to printk, as well - and
there aren't that many different pr_ things. So I think the shared prefix makes
some sense, I'd like to hear what others think before making that change.
