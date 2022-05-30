Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19A453796C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiE3Kta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbiE3KtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:49:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC063EF
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:49:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 129-20020a1c0287000000b003974edd7c56so4761144wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EAN0BhoPwvEpCpxVonBdpRNCPVz2gJJOPMLYoDosPak=;
        b=FT7KXEMHUz5ZQcgmrHYuzqXRlcvAGq4fEjuuHIeRJwBvSYZPW6589SmjlDPQhJwVN8
         JJiNZ3d8aKlv/iv2I4mOSYPDvxQAKaxfoaiGtAOWhIoYaf45OTC/ULpLtx2xd0QTSK3d
         fDGpZM419JBSeetaxkwNS774sfTxC4hbLShds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EAN0BhoPwvEpCpxVonBdpRNCPVz2gJJOPMLYoDosPak=;
        b=6OghbhwNOx0a6oUEMqKaTJeNhRyeJjoyWDOfmzfiZAAvCX4/7O17ksIc1oxdL/eAvO
         wlnuR2SfLzV1Mrs4TltLi/CG2hl+1/F5Y6qdZS3E8xZJ6F17GmlElqXfy7MRJvk295lR
         aMIyuC7w0e4n/K65VtikQs5pF+q7h90dTPMfEckFtUR+OfPsIrJYBuRQfpZC4ChmTvVB
         F8SRwPxte9umjp9oS7QzAL0eUo7BToEyMbBsGrVoFYVZKa01YZP/O6SFEGM156FuT09r
         aL5U/mioJUFL8wr8unM6Y9IFO9YUKEQOL5MmR/OqmKpbVPbQugjk3XQY4F+CMpYT0wiQ
         4SJw==
X-Gm-Message-State: AOAM532rgM2HPUEM+zibuRuPuGIxjD+Dv6GuXKdRFmQcU+39Zq04CYib
        07ZpaVPe/wESusrXDB8be14e+Q==
X-Google-Smtp-Source: ABdhPJzggafJ96sjAkS4V/yaX5LJ6PKCcQNMjD6dUsC07Cw8J9KzBsfIUavUoU51tw7z1qIusYLRxw==
X-Received: by 2002:a7b:c5cb:0:b0:397:47ae:188f with SMTP id n11-20020a7bc5cb000000b0039747ae188fmr18424968wmk.137.1653907756316;
        Mon, 30 May 2022 03:49:16 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id d17-20020adfe851000000b0020fffbc122asm10078154wrn.99.2022.05.30.03.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 03:49:15 -0700 (PDT)
Date:   Mon, 30 May 2022 11:49:15 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [OFFLIST] Re: [RFC PATCH] printk: console: Allow each console to
 have its own loglevel
Message-ID: <YpShK6Ke8AwVwxDr@chrisdown.name>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
 <YoUR6RlzkCNG7BU0@kroah.com>
 <YoVM+KbdyJm8RSSr@chrisdown.name>
 <YoyjIFI0LTvUHGQr@alley>
 <YpSg5dsQTDX/OsvI@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YpSg5dsQTDX/OsvI@chrisdown.name>
User-Agent: Mutt/2.2.5 (a8c7fba1) (2022-05-16)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(And sending offlist mails on list is why you don't send mails before having 
coffee in the morning :-))
