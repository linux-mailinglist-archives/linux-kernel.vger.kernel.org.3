Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB3B5A18A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243063AbiHYSRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242989AbiHYSQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:16:45 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F9EBD2B3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:16:14 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id bh13so18583779pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=UaiqgHwN7QwDf4IOEVa86wivukf0FA6pHqglaq9BlgU=;
        b=LUymUsCUVfzt75h61u7VtSSmc5Rkj2HMPqz13ns4u3yoSD7T0QTAvx2wsB858pgjaZ
         8zdSLZRYJl68R8aTWTJVMwyyOwIwoEyK5jLik3m27AGSAeQGw3DLynFmuhngLiLJiUfi
         tn/WVa40JKjlFq9egNclhEg9azAJh09IcEZBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UaiqgHwN7QwDf4IOEVa86wivukf0FA6pHqglaq9BlgU=;
        b=MWJODymNV8z1j6fjbPpIKXwXrlSNtTTah/PwlQeUcMrenNyvLEw1lrdxH2fCPuk/uy
         13ElOnq3k0POgN5ANXdnZoj5CvupH4YUDPYJUC2GSTEYbIGTK6/+DqBk4vpvS/4pY7an
         n2LC/KMccc9JF4pBLAgfqKLDG87MgTC0IymGaTVTchzopDSGeK0weahU+Uy1/16+bkkw
         tGCrbnDI4zKcKXmwjAuIEyxmOfU0N54tXzIGvnJ/YKRP99QQesMgtJRskJM/ihhg5fEY
         Og4vk9FXqOXsvzE965kghToTyX0u7CtkChYi9DuzGc/lYQat/HFgrX/prLqHS0LtoJJu
         aNfA==
X-Gm-Message-State: ACgBeo3qSFno70CEwMaeOCKWRj/WYLsWisIHYfvWUNcem7Ktv0HzxCq6
        kjGklQv0e1JURHldG2AH/PoLG61zncT3RA==
X-Google-Smtp-Source: AA6agR7vXU3/PHLjO46gLQpghsjh4seD/+QIvWck1t+y6lpotqhk+fPvyEJj0b6LgoZ1lGIIRCZGTA==
X-Received: by 2002:a62:1441:0:b0:536:ac1:504b with SMTP id 62-20020a621441000000b005360ac1504bmr304529pfu.71.1661451373900;
        Thu, 25 Aug 2022 11:16:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b00172ea8ff334sm9173730plh.7.2022.08.25.11.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:16:13 -0700 (PDT)
Date:   Thu, 25 Aug 2022 11:16:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Refuse W^X violations
Message-ID: <202208251113.B5AFA6D@keescook>
References: <YwdpwykpV9RB+4tL@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwdpwykpV9RB+4tL@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 02:23:31PM +0200, Peter Zijlstra wrote:
> x86 has STRICT_*_RWX, but not even a warning when someone violates it.

Yes please. I assume this is only kernel pages? Doing this globally is
nice too, but runs into annoying problems[1].

-Kees

[1] https://lore.kernel.org/all/20220701130444.2945106-1-ardb@kernel.org/

-- 
Kees Cook
