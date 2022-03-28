Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7877F4E8BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbiC1Bk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiC1Bk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:40:26 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5CD40930
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:38:46 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id bp39so11180604qtb.6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=eRVimM/CbpiWSNvnFN5TSgMFECx9ETly/qXbNK5IPo0=;
        b=BsK0FQNd3Pe5IfDYDzvgRs8mmoqcuOnHIcdO75fkq7ujs5Z6t5NPmSUSn+TUuHtQlo
         yp+bTJ1lTJ4jkK4o/LSmw2rh8wmKXy1nbweOE0ZYHaUUhfWesMrJ/VdLfm1yRwXiHIRJ
         UWZZoMjAetOqPD9zrwZDPltGe1BGEQoc8yt3yVynCwmofsjuu6n57SWgPoce/P6cRe2u
         0kruZRBBsjOeUwKTbjJ+hyhRHjHuuxVpUp+QnrOpg5DsVSN1+2c0JEFaHiQvW7dBSGQJ
         A+aStgfS+fPICLgIqjl4rBMKuD4Vc7BMiQ9jRYr9moPhnT8tw1Lb+LAEGPgHjSPKBYKs
         0ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=eRVimM/CbpiWSNvnFN5TSgMFECx9ETly/qXbNK5IPo0=;
        b=DOhrqq7G0S80p5WlpkxlButP7OB6PrbEsuOFrDDQQ+8x8OQB8FLzjiWuBDSaGRlUSA
         UrF7GD8/JKHSgVs38/g2onTQZPuqqmbCOk0FJezuTzt5VHYiTSHUniuaIpNllX8sy/9R
         bghNOOFHOo+nroyS5bkG+4+8KQt345wl/SBHeQ6ng4zz+6V6BYNRnbyiicF/a8B0HlDp
         TKrBHDlwkNT4+ICms1M7EGZM2gq0+uFt9wekpdnAzPeQ/2LwEkVA/8xqhpzEiEgbKCex
         vDD6SoDh2jv1lhoDM8367A+yPadVMbuwK0jX4JzJOunuyj75lcLBjB/rrBbwCInDntQA
         hc1w==
X-Gm-Message-State: AOAM531iUTswmwSARt5MG43oLVsEUxB276TkXG+j4jrYxAgqlaUAFozW
        vQP3U88ay/SlmOzXXnWRbQ==
X-Google-Smtp-Source: ABdhPJz8fngwQ/xG+IMm80gH2TCqQ5pMeJXfiv3AGjpMsPQewfjNH2hNRmdG0jkuk8/0IkPXb+Qwrg==
X-Received: by 2002:a05:622a:134b:b0:2eb:843e:47a8 with SMTP id w11-20020a05622a134b00b002eb843e47a8mr1456650qtk.400.1648431525619;
        Sun, 27 Mar 2022 18:38:45 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id u11-20020a05622a14cb00b002e1fd9dce3dsm11795784qtx.60.2022.03.27.18.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 18:38:45 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:5dff:4364:311c:ff])
        by serve.minyard.net (Postfix) with ESMTPSA id C85C61817BD;
        Mon, 28 Mar 2022 01:38:43 +0000 (UTC)
Date:   Sun, 27 Mar 2022 20:38:42 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Chen Guanqiao <chen.chenchacha@foxmail.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ipmi: msghandler: check the users and msgs causing
 the system to block
Message-ID: <20220328013842.GN3457@minyard.net>
Reply-To: minyard@acm.org
References: <tencent_BD6D4CB98B6D7FAA04F63D28F6457F10F40A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_BD6D4CB98B6D7FAA04F63D28F6457F10F40A@qq.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 12:47:41AM +0800, Chen Guanqiao wrote:
> At present, a scenario has been found that there are too many ipmi messages in a
> short period of time, and a large number of users and messages are blocked in
> the ipmi modules, resulting in a large amount of system memory being occupied by
> ipmi, and ipmi communication always fails.
> 
> Frequent calls ipmi and failure of hardware communication will cause this
> exception. And ipmi has no way to detect and perceive this problem, therefore
> it is impossible to located and perceived online.

Hmm.  So you have an application that just keeps sending IPMI messages
and not waiting for responses?  I think the first order of business
would be to fix your applications to not do that.

The ipmi driver will eventually clean things out, but the timeouts are
pretty long.  In the 5 second range per message.

However, as you say, there are no limits on users or messages, and that
is perhaps a problem.  I mean, only root can send IPMI message, and root
can do a lot more harm than that.  But it's probably bad in principle.
Nobody has ever reported this problem before.

Anyway, a better solution for the kernel side of things, I think, would
be to add limits on the number of users and the number of messages per
user.  That's more inline with what other kernel things do.  I know of
nothing else in the kernel that does what you are proposing.

Does that make sense?

-corey

> 
> This patch provides a method to view the current number of users and messages in
> ipmi, and introduce a simple interface to clear the message queue.
> 
> Chen Guanqiao (3):
>   ipmi: Get the number of user through sysfs
>   ipmi: Get the number of message through sysfs
>   ipmi: add a interface to clean message queue in sysfs
> 
>  drivers/char/ipmi/ipmi_msghandler.c | 159 ++++++++++++++++++++++++++++
>  1 file changed, 159 insertions(+)
> 
> -- 
> 2.25.1
> 
