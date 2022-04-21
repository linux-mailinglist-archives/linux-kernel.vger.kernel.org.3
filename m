Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFD150A4AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390300AbiDUPvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiDUPvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F302B1AF2A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650556104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EbjGVR0/QLoZhWC5OzE5Pi5DyxZZzkFTXCc0p/a0RRg=;
        b=EEXscQLN7V3cBssAJIbdLvfOSBKsbrGTsf5K+aRGf752j9xWxGxRpVZRjud/PByrGauboX
        dhpiENKGCTJ/ZIdIdJGCiJeMxhPPvaHnWNRkmTxYUyl74OvTx6liRSAFZD8kRcNMbTYlS1
        9zDTdyXJs5t07PSSHeAw6DiIu0l6Ikw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-7YmyDEfcN3eqbZWuUE6_2w-1; Thu, 21 Apr 2022 11:48:22 -0400
X-MC-Unique: 7YmyDEfcN3eqbZWuUE6_2w-1
Received: by mail-qt1-f197.google.com with SMTP id e6-20020ac86706000000b002f1f8ec1f63so3233237qtp.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EbjGVR0/QLoZhWC5OzE5Pi5DyxZZzkFTXCc0p/a0RRg=;
        b=rjMpsa0Agpq0zl9fBHlzdOiroitnHMqvKXUnT2mkDj9JnyoJ0u2B6ALegNlTz8pVwj
         l00KcN2g41eoLjyjpDN016E/AXe4RcWUw6YnBvMb3nUAdqEsGIxZawqNPuhRFSy1c+7v
         u3gJgbDY0sYl4i0utYt58/mUrLSlZgWXse4DRtbBQCrC+/G59qvL+HLetDHDAVP8Ln2D
         ymjXyj0YIRvV2Vfmb0TJ0Ga6kKkHMo4IgK3YQ+EMbako7QHbnP7/GXW9f7Jf6biRqGRE
         Jw50OXZr9/RV1p2tIzbckgWDaeA7ppr1GUj69bAMmK5hnAI89ISf36Mzfvv6n8NqPnJs
         ASCw==
X-Gm-Message-State: AOAM533hNWyt8fQh9LuMiTyZj72NVkDjhkWvfT2992TCl5a84/6PcB7N
        tBflYYUnFFBynOrayeMybCVum++qbyTP5IkpRDDiPwWyIGCuBAlRPTtVn451FhJY5jiNbnYKW8a
        0OuWDEMg5ECfknHG8ycY+jer5
X-Received: by 2002:ac8:59c8:0:b0:2f3:44dc:cf18 with SMTP id f8-20020ac859c8000000b002f344dccf18mr71368qtf.332.1650556102080;
        Thu, 21 Apr 2022 08:48:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRiVNLlOKbioQXhya2OhXx1mnXX8pZXrgYnj9qslqc4mrJa92CBuKb2j2cjg3iGLGXFXmM6Q==
X-Received: by 2002:ac8:59c8:0:b0:2f3:44dc:cf18 with SMTP id f8-20020ac859c8000000b002f344dccf18mr71356qtf.332.1650556101863;
        Thu, 21 Apr 2022 08:48:21 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85cd0000000b002e1ed82f1e5sm3858736qta.75.2022.04.21.08.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 08:48:21 -0700 (PDT)
Date:   Thu, 21 Apr 2022 08:48:18 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 0/2] objtool: Fix code reloc vs weak symbols
Message-ID: <20220421154818.7dsu24gwm2f5a6vl@treble>
References: <20220419203254.034493341@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220419203254.034493341@infradead.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:32:54PM +0200, Peter Zijlstra wrote:
> Two fun bugs that make can cause other fun fail if you have a fresh enough
> toolchain that strips unused section symbols.
> 
> The symptoms can vary between a faulty unwind to a kernel splat for trying to
> patch the wrong text.
> 
> I found it while playing with text patching and Josh confirmed it very much
> affects ORC data too.

Seems to work ok with testing.

With the XXX comment removed or fixed:

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

