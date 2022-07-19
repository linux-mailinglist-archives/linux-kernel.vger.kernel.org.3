Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E192579BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbiGSMbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240645AbiGSM3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:29:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2146E6B761
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:11:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b26so21315257wrc.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DAx+sM+epCk246POloxFqGDCP8DOtMQTBE1kqRIyu/w=;
        b=CQR0ZxHI6uwx0XVJycb6VgAk2WHyoEF7Ew+8LLFztvRueVB/IrNfEBWhKWmUUDjX0y
         NR+v1ivLlT4D4pMnUVvI6XUyvTB1+seMu5Jh2lS9zjyZHrqSPJAioxCdV1KNcFwCc6jZ
         noC5IC8WKWPSWSy9fge5Vvxr0epeMK/yDy3Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DAx+sM+epCk246POloxFqGDCP8DOtMQTBE1kqRIyu/w=;
        b=Z5c7Mx+/jy0J0q62ocyd0ONNcpzuJWaJulgpqGpr6GxTv74QDZy72twnRLFQW+XCXf
         +MMoabpD9xie3LpJO8dXWapdsEsl9SYyM8f1VfsDBxvbkn47c3d9/QGDzjS1VN2XbQYN
         P3PCiGHV9sH1BdpDYvCMAeOb9c9aR9BPwNuXGkazQxklW16O48Kpo+VIo6rOr0XbIzn1
         o6+JwYPe+N4tcfPOeG9yk9uveIm+Zm/FiCT6rLBh/tLleIedh33lLzGVNmn1UiZZVjqE
         eozRROKuyJiB/K7PHlrtEZ972Odbql2vkS1KHFsDWtLv2KgxOXAB2J8HoFb19R4c9GFg
         FHww==
X-Gm-Message-State: AJIora9lt8kFR33aBCrvu+vW09vPc9C4TOppidHWYdV3HMj0cRlyv+pZ
        QoFgel7j4E6kwPIhfaNG95xDpw==
X-Google-Smtp-Source: AGRyM1sj6Fi5WLN+7i3N5uoIBBHwO/qqzwg/EtZAwPLgoK8OS1tiy8b1gwCmkSI2w6ekqSOzus+VWQ==
X-Received: by 2002:a5d:4dce:0:b0:21d:6c49:2383 with SMTP id f14-20020a5d4dce000000b0021d6c492383mr26432082wru.159.1658232686464;
        Tue, 19 Jul 2022 05:11:26 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:d58e])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c3b9e00b003a2ed2a40e4sm21887233wms.17.2022.07.19.05.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 05:11:25 -0700 (PDT)
Date:   Tue, 19 Jul 2022 13:11:25 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: design: was: Re: [RFC PATCH v2] printk: console: Allow each
 console to have its own loglevel
Message-ID: <Ytafbe6jGQ9sW7HG@chrisdown.name>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
 <YshL2M8VdIEONDdc@alley>
 <Ys7bb8+/G0iMWfzb@chrisdown.name>
 <20220714154452.GB24338@pathway.suse.cz>
 <20220715124935.GE2737@pathway.suse.cz>
 <YtFk/3XA8dsaTu/c@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YtFk/3XA8dsaTu/c@chrisdown.name>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>Ok, I will incorporate the EINVAL return for sysctl in a separate 
>patch first, and then add the new sysfs one to the existing changes 
>for v3. :-)

Thinking more about this, I will probably not change the existing kernel.printk 
semantics to return EINVAL, since it could silently(ish) cause regressions for 
existing misconfigured systems on boot. I'll just add the clamps to the new 
controls.
