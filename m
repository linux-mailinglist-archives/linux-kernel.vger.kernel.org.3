Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25AD583456
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiG0VAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiG0VAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:00:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C342352FC8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:00:03 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b10so17429348pjq.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pC+k+JLMz84BZy6F2oVSfyP1qBHrvefdj7W+V8ZeWsU=;
        b=QCSvYiWTHEW8LnZtC4VRetkeTAtBz944/1BFNjkLNgd6+tBqqis3s0XD72OSrRBjx7
         J3np0xOeDeY0DLRwzVSkoneIn+n70WVnPBwi1icqDr/Ocz2RW2nCntRynP8XZ9kuR7au
         QNnKAQCot/BTAoIa+1dJhzZDwtuGpXb+rOLR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pC+k+JLMz84BZy6F2oVSfyP1qBHrvefdj7W+V8ZeWsU=;
        b=Ow28nkRh1pi0GAzfHC8CnVwkiHV1Pih1c3p9shKN88JiwQwqeKEUr3Yjy++WT69+K1
         GS4YypDxc9zHY4ktAJmpO6FctdXhmXBE8+OnBz8Kkq47RmwnHP+fgpgCwyk6QGuQm0Mo
         +LXTUMCk+hSLoICsGIyDN7BunftG3YF7/Dm5piK5Gq0w8fpgzi6HV+bzcp3Mam0QVMDo
         UZtALPXMmLZ3WisiUUVgNhHsqHqs1OIWk8ByMMsud9nom9+7wBPBgX3FihHdCstEzYPf
         AZMywDc+8j9ugAQYm6FQKGMI9HoQiR432cpFLw4GRTYgstDmXU1f1a+4dB1vPTgVucBL
         AmBw==
X-Gm-Message-State: AJIora9CRaXqLDq4nKJuIpXgD93ZrSb6g6MFEdebEP5bwdAZ5rZDW7Kg
        5vQh8neSphFPq/luEaYeaSRqCQ==
X-Google-Smtp-Source: AGRyM1uBYNcrK4cuFAWhZlmIKkVT3tjcehniDzl0+rIsD69Z/Gln15IeWX+yX0B6QaXfeATByR/CHA==
X-Received: by 2002:a17:90b:390:b0:1f3:ee2:62a8 with SMTP id ga16-20020a17090b039000b001f30ee262a8mr4321754pjb.148.1658955603316;
        Wed, 27 Jul 2022 14:00:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ce8a00b0016d785ef6d2sm7253562plg.223.2022.07.27.14.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:00:02 -0700 (PDT)
Date:   Wed, 27 Jul 2022 14:00:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     tury <renyu@nfschina.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        yuzhe@nfschina.com
Subject: Re: [PATCH 2/3] lkdtm/perms: Check possible NULL pointer returned by
 kmalloc(),vmalloc()
Message-ID: <202207271359.61F0A0EF@keescook>
References: <20220725081153.20228-1-renyu@nfschina.com>
 <Yt5XZN3CdTprfjwk@kroah.com>
 <bd13881e-6a78-8831-18a8-5b022e8648ce@nfschina.com>
 <Yt6OcTErVYiGYRXq@kroah.com>
 <496e6d21-f4fc-2167-6315-c0335c452a00@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <496e6d21-f4fc-2167-6315-c0335c452a00@nfschina.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 01:43:41PM +0800, tury wrote:
> 在 2022年07月25日 20:37, Greg KH 写道:
> > A: http://en.wikipedia.org/wiki/Top_post
> > Q: Were do I find info about this thing called top-posting?
> > A: Because it messes up the order in which people normally read text.
> > Q: Why is top-posting such a bad thing?
> > A: Top-posting.
> > Q: What is the most annoying thing in e-mail?
> > 
> > A: No.
> > Q: Should I include quotations after my reply?
> > 
> > http://daringfireball.net/2007/07/on_top
> > 
> > On Mon, Jul 25, 2022 at 05:54:15PM +0800, tury wrote:
> > > When there is insufficient memory, the allocation will fail.
> > And have you ever seen that happen here?  The issue is for small
> > allocations, they never will fail.
> > 
> > > the return value is void,so i think it is ok .
> > Why?
> Because the function lkdtm_EXEC_KMALLOC()   declaration is void,and The
> return value is not checked elsewhere.
> Should I add some warning messages?

Memory allocation failures will already be reported by the allocator, so
there is normally no need for an additional message.

-- 
Kees Cook
