Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1D7552C62
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347601AbiFUHw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiFUHw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:52:26 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B109823BCB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:52:25 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id i17so12531444qvo.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g9k1mThYScIf9A8X5kP43MLMYKCbH4t5dz1jSbySjwE=;
        b=l5HiTUmI2JUEzJjhrUuq9RgwOOdemlWj2crpupJB8TUxFRp//h5bJDRus8P+fXp/yK
         N3Euxma5PIExGPbNR8xbsQMDbigXcRNK6Fjv1vIDlvZEZyQ2Ex3EJ5JX3DezkUhjIG42
         KT+z6Xn5dmORbcgX0/3QL6tPBzQKddiImkKnmV47+2gLy7/bP3IazmYyNIunej4Rugvb
         oEmhFkBzHXcphWon9RykZMATfy0qtCxRZ5i+bskVddoHBr5VwLYDBJK03LbbceK46P11
         49tJQgM5o5bkfzANgtgjFCeb4dWxDrNNXynKRg0z+n8u1k4XTpIFHRsH77WOHXMVQFmI
         Yg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g9k1mThYScIf9A8X5kP43MLMYKCbH4t5dz1jSbySjwE=;
        b=NH1rXOVVYty1Z8pC/uQFuyX5/I+AV/4Rnfhf6WAcyMdxNNaGp9hkWi3eNDiIuneeAl
         t6H1r4Qstx8HcyFI+el/kf5/CqUadJpODqYjSrRxSMbBhb7ZO03czIl6ozSAgUsiO+sj
         3Ah5kzK3JBmRAqnVYt+ImzloP1ovmSfz5jTVyeXCdWoB2fiqDCIVfMceIYq0J8RU7TWN
         QBoupo15PpXgh5W3Gnnn04vXBe2TBTRU8RdmI3PDVZxfTPbFUlegDQ3TqwDEf+SLFmFZ
         QxhxdfC1HOBg71VgSJZRzEcjMOffwiyC0Y6iBbmyGg2Zaz4yaSeeBLyb7RyIhN205Cx2
         6hWw==
X-Gm-Message-State: AJIora/zFpPH/wT6WeZ7BkIfRNbWUSjvQ4uWDT7Dgp/TGsekIKnbdX4D
        2gqs5h62HTC2KCNSuiznkQ==
X-Google-Smtp-Source: AGRyM1u23QhEKWlxDri4U4bL6I/zAwKZbFgPfNf8rArvK8DElQyjUq4DyhWWlWvGazGD2PkS+RFFQQ==
X-Received: by 2002:a05:6214:21e6:b0:46e:4f35:b07c with SMTP id p6-20020a05621421e600b0046e4f35b07cmr22241046qvj.12.1655797944888;
        Tue, 21 Jun 2022 00:52:24 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a410600b006a6d3a6d597sm14563997qko.71.2022.06.21.00.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 00:52:24 -0700 (PDT)
Date:   Tue, 21 Jun 2022 03:52:23 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com,
        rostedt@goodmis.org, enozhatsky@chromium.org, willy@infradead.org
Subject: Re: [PATCH v4 13/34] test_printf: Drop requirement that sprintf not
 write past nul
Message-ID: <20220621075223.qpiatsusjbu6zj7a@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-14-kent.overstreet@gmail.com>
 <ef7276bd-c5ce-af98-bd49-051e24528426@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef7276bd-c5ce-af98-bd49-051e24528426@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:19:55AM +0200, Rasmus Villemoes wrote:
> On 20/06/2022 02.42, Kent Overstreet wrote:
> > The current test code checks that sprintf never writes past the
> > terminating nul. This is a rather strange requirement, completely
> > separate from writing past the end of the buffer, which of course we
> > can't do
> 
> And which of course you don't check anymore. So any statement about "all
> tests passing after these patches" is not worth much.
> 
> So NAK in this form, but perhaps if/when my year-old patch gets picked
> up (or you could include it in the series) we can talk about eliminating
> the check for past-nul-before-end-of-buffer writes.

I'm more than happy to pick up your patch, please send it to me.
