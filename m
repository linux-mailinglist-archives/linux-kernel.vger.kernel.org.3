Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150C452EFA8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351113AbiETPr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242225AbiETPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:46:55 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921FA5F24A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:46:35 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id v11so8083754pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eGcTsYf8iVYg1xNbI/fjMVaCB61SkbZVpEsdDGyPSy0=;
        b=O3dHH+ATXMsS3gQnUfEVaqgUE+ermYGggTUHL/hAVkMdgfyYYDAjaWikrTtY8Pp6wv
         tKFi8ZueYqcPc4eFrrXc4uCTH493zHH9FnzLoesCAI44fVDbalDN9flwCdDcqONnW48v
         dD7jmZALIj+LdxHUY+y1MjnaUye6KzBB8pON/3JDIWRhmep1YNJP5KWjdSbRKuxIaQO1
         ohVGnAbXYgoT572WMvnwbb6kGCCeKoX6cvVKtnY7FOOBFwIC37HkB4Qyb1WSOBELIj1R
         Ij1iYPfz1nRgXKS53Xmlowq/ZySPq/pt4PV75itOgKk4bZhRXi7Fl9SwL0crKwT2Fop3
         5hjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eGcTsYf8iVYg1xNbI/fjMVaCB61SkbZVpEsdDGyPSy0=;
        b=7/adZuX/dqUoRU3GHzc4ocCkH4p8saOmlBaYgFf0VzQrFyNmuwJOtOD0F/xOIt8Ivt
         Sk0BC9u2B0diVAcqLS/mtYiEJ3IoxYl+tL5nTD76bX/7vU3tvcWf+mSKk9Ms+5pbLcA6
         kbFwylxSVG+g5cbFQoiMj5j4zjB4H70uPs0qrov7ecFgZ/qVPAlyPYIwgJoBn3ab4ga8
         luZGfbVyFHCEOBmGCA9cR3SJ16uLy0ycA9G8ZBvcFbV9WxxG08GhGNzSruvrQMDcKWCQ
         ssM6Twm1PyRcLrsf2K69mEeWcq5tdZ/S7WswWo+rLvc04MbQiaE3BEFYOJGldl8MXBat
         q0gg==
X-Gm-Message-State: AOAM532+vui4aHCIwCChtHrWvyaAiAhS/vsdejvOJG3d7Gn9b3aNWQIz
        ADoHSBQUw2jPaZ+QeOHRX3jXVw==
X-Google-Smtp-Source: ABdhPJyHVDi3GkJibJeCyTDG61Y7KGHWoET2M+t/bVmUBSUfXB+PE2IKO4OB8WgcSATs6LuAkF0mDQ==
X-Received: by 2002:a63:455e:0:b0:3c6:270f:cec4 with SMTP id u30-20020a63455e000000b003c6270fcec4mr8885229pgk.417.1653061594803;
        Fri, 20 May 2022 08:46:34 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y1-20020a1709027c8100b0015e8d4eb263sm5737536pll.173.2022.05.20.08.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 08:46:34 -0700 (PDT)
Message-ID: <af6a9879-db69-00a1-27c7-f319bacb2862@kernel.dk>
Date:   Fri, 20 May 2022 09:46:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] char/mem: only use {read,write}_iter, not the old
 {read,write} functions
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20220520135030.166831-1-Jason@zx2c4.com>
 <YoevH5YFLcBBfsB0@zeniv-ca.linux.org.uk>
 <f35d7a15-0cbf-1663-15af-eae37a90d0ff@kernel.dk>
 <f3878dfd-67f7-9a01-8dcf-7202bf5f3918@kernel.dk>
 <Yoe3ROmrA8sNe3Cb@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yoe3ROmrA8sNe3Cb@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 9:44 AM, Al Viro wrote:
> On Fri, May 20, 2022 at 09:32:34AM -0600, Jens Axboe wrote:
> 
>> Didn't look closer, but I'm assuming this is _mostly_ tied to needing to
>> init 48 bytes of kiocb for each one. There might be ways to embed a
>> sync_kiocb inside the kiocb for the bits we need there, at least that
>> could get us down to 32 bytes.
> 
> My bet would be on iocb_flags() (and kiocb_set_rw_flags()) tests and
> pointer-chasing, actually.

That would be my guess too, around init/setup of the kiocb. But as per
previous email, for some reason it seems _worse_ on bigger reads (1k and
4k vs 32 bytes), which would seem to indicate that it's not necessarily
just the setup but something else too. And hopefully that "something
else" is workable.

> I'd been sick on and off since early November, trying to dig myself
> from under the piles right now.  Christoph's patches in that area are
> somewhere in the pile ;-/

Sorry to hear that, hope you're feeling better.

Do you have a pointer to those patches?

-- 
Jens Axboe

