Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF52E52556C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357933AbiELTMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357915AbiELTMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:12:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625895BD19
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:12:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id s14so5826628plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iBuQvnCRlxDCi6HbteFyBtMacgx7JHqhY0mAy+23sMU=;
        b=eCRUbpnjk/fEcpD0c1rKjaMp2OZq3E+mjzf19tsay+g+rRiYw2qKYOaRC7HbmpdgaX
         ehjHpMF4T6hPc0gTaNbV8qw4kAzXB/L8oFA4/hquDa1s64JotM1FD6AFCm1I/pPOmxtB
         RGEPn652qs6sOT3UKtTVpM9/i50z58+LYLDgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iBuQvnCRlxDCi6HbteFyBtMacgx7JHqhY0mAy+23sMU=;
        b=Hzh2BGAiRN5+aL5uXXqTiw0amVDGundmZTCbE2rZyZGTywvfClT3ZGeSEhABseK0wH
         bFcIRo+yHOl88cdrLYTjBdGUCHEkXj3Tpe73z1Nbb7c3kZiM1IAMsjcgOBdmyf79RE0K
         J37dffVwdQuEJEtP/4zFsTaL3aBdIcl65VblVFQt7YlOOp87fXNQZ78jxSMHAJL996dJ
         YSZ+ruKMp2xz5n+ly8m4pGysYkjU4BgvQ3flwmU1ckvgJvwTBDphPsCwQmVZa+NIg66r
         kfU6YWbGRS73z+AhvRzN/HhufwWS1FuciLit7svidGt6SLuNirLNqayMXO02a4PLoMBZ
         vquw==
X-Gm-Message-State: AOAM533ZWDX0TD/AgLKPYdYsItxK9IfRzu1dO7P9Zs+3mXeRvUxzlikQ
        8QIVJVHZ8v3zxvLyBLXv9IisWw==
X-Google-Smtp-Source: ABdhPJzFMIlQvWdvZrnNcVEtDlZHk2iMMaueVcjUNOHdSokOi+f+sVhuVAMjnR60zBB8Cf9BXFDI1A==
X-Received: by 2002:a17:902:ea09:b0:15e:b761:3ca2 with SMTP id s9-20020a170902ea0900b0015eb7613ca2mr1120324plg.121.1652382723949;
        Thu, 12 May 2022 12:12:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709028c8f00b0015e8d4eb290sm234854plo.218.2022.05.12.12.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 12:12:03 -0700 (PDT)
Date:   Thu, 12 May 2022 12:12:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC][PATCH] lkdtm/usercopy: Add tests for other memory types
Message-ID: <202205121211.B7EFB5A@keescook>
References: <20220512183613.1069697-1-keescook@chromium.org>
 <Yn1YTZkWVWfXk5Q8@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn1YTZkWVWfXk5Q8@casper.infradead.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 07:56:13PM +0100, Matthew Wilcox wrote:
> On Thu, May 12, 2022 at 11:36:13AM -0700, Kees Cook wrote:
> > +static void lkdtm_USERCOPY_FOLIO(void)
> > +{
> > +	struct folio *folio;
> > +	void *addr;
> > +
> > +	/*
> > +	 * FIXME: Folio checking currently misses 0-order allocations, so
> > +	 * allocate and bump forward to the last page.
> > +	 */
> > +	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 1);
> > +	if (!folio) {
> > +		pr_err("folio_alloc() failed!?\n");
> > +		return;
> > +	}
> > +	addr = page_address(&folio->page);
> 
> Ideally, code shouldn't be using &folio->page.  If it is, we have a
> gap in the folio API.  Fortunately, we have folio_address().

Ah! Perfect, thanks. In trying to find the right alloc/free pair I
missed folio_address() :)

-- 
Kees Cook
