Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477FB57625E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiGONAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGONAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:00:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECE514D0F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:00:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id mf4so8868172ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RCt/W87cx3ywREUzI1kTfV9kwkUSQBO0wBU2/jyUbH0=;
        b=es/zbpzvr0Yhn7dAz3Sj9TFSWsIr3mLe+mtcXRS9KMk4xF0h6YIpU/e9mdjV6UCj/P
         /l6KHzyklqGHPKxs1EFKVt9iIJFzc0iILaQ7Nq2YT/9N4y6itCMWgn4cnW60ZJH3xiIO
         CM26+s2pE/5Guq7I5H7GQrFbJpGfsofD53VCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RCt/W87cx3ywREUzI1kTfV9kwkUSQBO0wBU2/jyUbH0=;
        b=VKCzno//QT1Pm0jcilBH19REPyKW9gwklj8h16MiHGPlBpQQVv35sRPVj/SVQzWZN4
         zF3esBYI9gERXdu00bvj2rw5Na1+z4fKb/pXVjo5jW/bcNQrRvBYkfwNMV4Mzg0kK+1x
         Lj4mRf5XQhwHmNFq/EtGhoxs/5lB8DZbAmfnGAaJ8jE0TMN1aN+6ZiyU7FBfYlfVUcgP
         /kQ0h5RMPzWq+BBdajHCdlh848lh/Ime7q6RCanKI3wajXU/vBtTzV3bMm636FfKxKsW
         n48G6slVozg2KmRJB5aigLilmqESPiAYPvD5t0HNBRf8mGVn5Iz9ReUfNPM4o/LCJC8a
         1UIg==
X-Gm-Message-State: AJIora/DQo2vTezdHUsNtpw2urCS1rPvpISSjIriX/2LrFksxWxSi4T5
        /Mr3VxbTBtjb1k0PEeEl3S2XqQ==
X-Google-Smtp-Source: AGRyM1sPWUg4KsIlbtWnVBRI4tKDLcSAhYM62zz6aqFnktmMaTWt1ZaBPQKUbdd2QhmBcjQoy+DLAA==
X-Received: by 2002:a17:906:8a4a:b0:72b:5b23:3065 with SMTP id gx10-20020a1709068a4a00b0072b5b233065mr13846534ejc.557.1657890048230;
        Fri, 15 Jul 2022 06:00:48 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:2b0d])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709063cb100b00722fadc4279sm2005816ejh.124.2022.07.15.06.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 06:00:47 -0700 (PDT)
Date:   Fri, 15 Jul 2022 14:00:47 +0100
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
Message-ID: <YtFk/3XA8dsaTu/c@chrisdown.name>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
 <YshL2M8VdIEONDdc@alley>
 <Ys7bb8+/G0iMWfzb@chrisdown.name>
 <20220714154452.GB24338@pathway.suse.cz>
 <20220715124935.GE2737@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220715124935.GE2737@pathway.suse.cz>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for writing this up, this is very helpful.

Ok, I will incorporate the EINVAL return for sysctl in a separate patch first, 
and then add the new sysfs one to the existing changes for v3. :-)
