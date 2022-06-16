Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63554E672
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377816AbiFPP51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiFPP5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:57:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EE72FE71
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:57:24 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id e5so1029161wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x+qCp/PIALvKkyHuuSMxH6g0K4aMNeDFtao/lYcSdV0=;
        b=eeXvTyGIvYEENE4EBbgxKRwF1N6RXVfsFOj4hRYxgsG4WHIYQ+ilmz4RReG261USM2
         Jpo+qpjF11Qb7gL/EMJoc3IEJJKeUZq3e81dTO73K+Q96gdPRfldhoCZYgzXdNUCwzPt
         CKVEsD5kx5cmfXV4+nem+euno/6L+i1owLUKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x+qCp/PIALvKkyHuuSMxH6g0K4aMNeDFtao/lYcSdV0=;
        b=nJkWLvgmxG8eAandLyvnA/iItV2zDUqTYVHOAyf53XvYMCj8NnMlLCmNjUYN2hjuJG
         SbvsGgcB0vrRPX5lLe9jSmqiCr4YBGIFopFmkz9UKDUcWOZDSvzSFlLrFNIiWCxdu9Jv
         RB8iAi2xguge7ejH0PxDcRr+B43EyV10w+5WeYVrjps3nRtBfY9fIhp1O7CVOb8jQ8hX
         2h8KPSLtPm7d5O+40GXre0j3Q0XXS1k+038L6CO0NH5STXKmpQeGkO7Q3bSkJCLi9pLp
         BHl9foEd1DVFatw7Mmqnek2NOxAmt3szBUtT/PjnyFa7YbOuVcPTcNNjk1ad/YhDU/0w
         Lo1g==
X-Gm-Message-State: AJIora+mqzslkIg2IIeeHfprF17gzNPbxMt4NjQi+C7VUwtvXnDXu+t0
        pOxF4CEdbRd6JmZUVW/HGrJUmUB34bHs8w==
X-Google-Smtp-Source: AGRyM1viKXSPJjBRIqZFdGDIYYNNfew2vfVZvjdK0FMdXFZK+PXSuSNtORvSK+UxeAhra2kt7RWCvA==
X-Received: by 2002:a05:600c:35c2:b0:39b:fa1f:4f38 with SMTP id r2-20020a05600c35c200b0039bfa1f4f38mr5766130wmq.22.1655395042858;
        Thu, 16 Jun 2022 08:57:22 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:8b4b])
        by smtp.gmail.com with ESMTPSA id h28-20020adfa4dc000000b0020fff0ea0a3sm2241327wrb.116.2022.06.16.08.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:57:22 -0700 (PDT)
Date:   Thu, 16 Jun 2022 16:57:21 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [RFC PATCH v2] printk: console: Allow each console to have its
 own loglevel
Message-ID: <YqtS4W8Pl3YmVEQg@chrisdown.name>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YoeQLxhDeIk4VSmx@chrisdown.name>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just to update on v3: I planned to quickly get it out today but it turns out 
that there's some work needed to add compatibility for John's threaded console 
printing patches for 5.19.

I'll add support for threaded console printing and send v3 when I'm back from 
being away at the beginning of July. In the meantime, any further feedback on 
the general concept is welcome. :-)
