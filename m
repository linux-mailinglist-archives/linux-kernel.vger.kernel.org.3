Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2555B586E65
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiHAQQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiHAQQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:16:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A456C15824;
        Mon,  1 Aug 2022 09:16:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso15807941pjo.1;
        Mon, 01 Aug 2022 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DyQ9K8ymMDEzTjm8+aouou/83gQAMkkB40Lq7COAi90=;
        b=bKc+XzrgkCFZiEUbnAS5/FO+43F/9SjycwR/YkYtA5DisTt0Do0fsQg6bF49bGnGd9
         YA0a3vSXT4RPvmr8zpb5WPNfsG11qdnVmP5H+cZ4kmPs3GXxtQb13FmSs/fqFOEBXLQH
         anlVgMx+bTF316hXTuS3rispdu1AK1ZbEhokhVLNBAJzU62ck1eKyaEuoND5XoMx50Ig
         gcveZR6kzZRu20VjweEzzurVLn1Mf5i49vnaK7i1JyiV4ityVX4lsHE7wg3cWc4Q+j6S
         6NvGPsgenWjJdFEmu9Wk4wB66TR//iFiNIsncnefryw8HBT/ThlsXMA7A+daWK3oj587
         7/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DyQ9K8ymMDEzTjm8+aouou/83gQAMkkB40Lq7COAi90=;
        b=OzZWqd2lI4VvFw23u6J5drulM3cLbAL/W2kkoQfT397D1Ziq8C7rnzhpMLQitKZMl9
         7fPqd2SQY+EVTvT1Eqzh5uGgApSR4hpNm27YxAJPkb0ExXj7LGxYYcsCvi9VeQCiIXSL
         s9vZIKzZkuVlrzdKn0p23RSdFgOJj/AosDlZToMrK/0kkeonRVgy+/axqCoUygCmo0pZ
         jHfVGRsWCeztoqqKdsn4kZ0EZU7byhpjBltKC6fhnP5S8TYC1AphL515yfCCCyIqTk0Y
         WsiTvK2edvfkiJo5OEeTTD0bsubNrbH9jE1HjqQ+4Eiyb45+GABz4w6MQ7pw37w7LOLP
         R5uA==
X-Gm-Message-State: ACgBeo1UcaMmAKLx8RZRwkZAy0JZ0DRaZEeQLOxXlx4AL6CX0cA4Ukzz
        3SGG50RuZX69KEuuzemTvDY=
X-Google-Smtp-Source: AA6agR5WQHS2QRnUdDFKIXQxlmyPnqxXuPRAoKSIJNemA2+P+CYErRyt7sfsSAhSbAbcAFNBb+Sz3Q==
X-Received: by 2002:a17:90b:4b81:b0:1ef:cd2c:bf2e with SMTP id lr1-20020a17090b4b8100b001efcd2cbf2emr19492079pjb.137.1659370605031;
        Mon, 01 Aug 2022 09:16:45 -0700 (PDT)
Received: from berlinger (berlinger.seclab.cs.ucsb.edu. [128.111.49.72])
        by smtp.gmail.com with ESMTPSA id q11-20020a170903204b00b0016c27561454sm9671277pla.283.2022.08.01.09.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 09:16:44 -0700 (PDT)
Date:   Mon, 1 Aug 2022 09:16:42 -0700
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        syzbot+c70d87ac1d001f29a058 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH v3] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
Message-ID: <20220801161642.GA1932489@berlinger>
References: <20220728155121.12145-1-code@siddh.me>
 <18258c1d370.6c4bec7a269297.4170944235031209431@siddh.me>
 <Yuepw21SyLbWt9F+@kroah.com>
 <182597c78f6.70a93066293735.4741894763116073008@siddh.me>
 <182597eccd3.14cac6a4293987.1730526835854998440@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <182597eccd3.14cac6a4293987.1730526835854998440@siddh.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 06:30:58PM +0530, Siddh Raman Pant wrote:
> On Mon, 01 Aug 2022 18:28:25 +0530  Siddh Raman Pant <code@siddh.me> wrote:
> > I now tried the 5.10.y branch of stable (which has v5.10.134), but the
> > reproducer isn't triggering the bug for me. 

Are you referring to the reproducer attached to our original report?
https://lore.kernel.org/all/CANX2M5bHye2ZEEhEV6PUj1kYL2KdWYeJtgXw8KZRzwrNpLYz+A@mail.gmail.com/

