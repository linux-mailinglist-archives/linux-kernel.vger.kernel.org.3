Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B96C537967
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiE3KsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiE3KsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:48:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068FB1086
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:48:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e2so14132298wrc.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rfksj/ZARcvf2BVt29RVY9v+/OMfMKx0lm1onWZ/DKc=;
        b=fEU6vLiRdUQSGnWOuHXEn0nZDjncVy6/5FFDGhU0An/VWbrSs3GrMFK28UEFsRPEzd
         yi4ZVLT/4vtgdtENNDvP2AbnVfTZiJXBxDC6o4/vASWkjbC2MI1Fe9xIpDT+YlDjY9AZ
         AAh9K7Mr3Y1ogaR0PhVBFKBxUMntt7iJeRIaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rfksj/ZARcvf2BVt29RVY9v+/OMfMKx0lm1onWZ/DKc=;
        b=wCzKL6nsc6Cpi5GJvqsA4SZbHgvjolBvXVIdEsUNfgDLS/t71E/xnw0zFGBUw37WgS
         ud4QjEIoYXbe87rM9IAjmulWhiCltIvdjG1I6+V+VzmH28HwSzP8rbykPoVpSPC8CwQv
         0eZ0/S8DBloWZizm+mRrkVLwV7GSmlf8o3fMZUkeYaYxJjoxQVPgNsOXQthjjwd5Bvmr
         o3XWus81jmrIH3G7RS6bNrXx+mVaB3Ci4k07KQZIEBZ8EqndEF9XmfS1G+sLnYZYdWK3
         7fJ8cS5b4gy5jTscY5uOG916JIE1Yu4jvj4eOIdfY4XgSc4C3LWQcpAV3oy2U/JxEbCG
         G6lQ==
X-Gm-Message-State: AOAM530oJnKkopY62rCsup+BDD+zdaFAtoOXMqWzfUBqTtohW/9NbrXO
        2/oZegvvj332r9RtG92TyGsPzg==
X-Google-Smtp-Source: ABdhPJyhckKy2uq4PW54yTyB95qL8JFZwbKpvoLAkWdwQYIa/KmGfgBhocR0xp5Md6gbzz8umk/7ug==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id a3-20020a056000188300b00205c0cb33c6mr46490218wri.39.1653907686496;
        Mon, 30 May 2022 03:48:06 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c4f9300b00397342bcfb7sm10818108wmq.46.2022.05.30.03.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 03:48:06 -0700 (PDT)
Date:   Mon, 30 May 2022 11:48:05 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [OFFLIST] Re: [RFC PATCH] printk: console: Allow each console to
 have its own loglevel
Message-ID: <YpSg5dsQTDX/OsvI@chrisdown.name>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
 <YoUR6RlzkCNG7BU0@kroah.com>
 <YoVM+KbdyJm8RSSr@chrisdown.name>
 <YoyjIFI0LTvUHGQr@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YoyjIFI0LTvUHGQr@alley>
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

Petr Mladek writes:
>PS: I still have to look deeper at the patchset. It might take
>    some more days. It seems that nature is not the only one who
>    woke up after the winter.

No worries at all! It took me long enough to send it after all :-)

A question for you: I have some minor, non-logic changes ready for v3. Would 
you prefer I send v3 for you to review when you get time or leave v2 for you to 
review for now? Don't want to interrupt your process if you're part of the way 
through doing v2.

Thanks!

Chris
