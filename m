Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D068752EECD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350667AbiETPLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238626AbiETPLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:11:43 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DEB27FD1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:11:41 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 31so7963896pgp.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wxiN51YttqZ6z8fn+6Jl5O1G3wTtjehvYfZKGeCzivo=;
        b=Y+pGUbnBoLUnlLA1uF2J2yJF+IOMvaOD2i4b6UV4fT0xQqtLbMIAoHur1VUew3lM97
         akpMrzQF+E5fE+Rv5zvFa4gT2QovZe8xXeyQsSU76A/FBvZHOCH54/z0Xjfykd8eT8Ly
         4UFHrZP/vFnjKTzlPZvGamifckr3W6vgMz7OmMfzdIwjQcOPJ5Yh26mKbo7ZfqaudznU
         fKGGORUaU2+g9DICqxTdAXkWu/uZatg6zNr565w7g+o82mErYRZtrU+5E29MA/+sTiBB
         d16zObHt2h0tuaY53fY3OCK10uhnRsnDHDE6vXIzHMeEUsTq/JjytmcXFrCFTzkpBvaB
         frpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wxiN51YttqZ6z8fn+6Jl5O1G3wTtjehvYfZKGeCzivo=;
        b=FB8Jy8FCADwYQQzMWx3OKvilQhrzmsGc865aMOQmSdGakS30w3tSZmBf+297ly7Gwl
         bXSGbUYgK9vlrviZV55Xy0eRCU7ltDuI9SgQjd+YF/BsAZxZC5QjcszOMqal7amr3apN
         7jK2x09oS1RBf5GV9I9QtCE93H7edjnRsb81uvkR4Sj1laegkqQ/X1ECwIof+zMc66ny
         melpLmwLaqN7TYOvT2GalPvagEpkiT1GAzrNif0mcNDglcqfIJKIByG2VE7a5pPJknCn
         TL+gTsQnROLkvY+BgRpRepqj+xyow7r6Dv0xR4L+Un1zox7trN7GLjtlF6hsUdZ6qo4S
         rgFA==
X-Gm-Message-State: AOAM533sWSAW8XzW0GX7g1iWLAgDU5nHoswrRzzgB7tpI6b1rJJREtbY
        WXwADy/n5OaIUtl1RDXVEuZTNXwx2pKvBw==
X-Google-Smtp-Source: ABdhPJwRV1X63bl22cDKl3x/sUYr059BW2U+nCt9VcX4EsGouTekPNDfERRgA6Uw3hIIXVjzsM/HeA==
X-Received: by 2002:a05:6a00:ad2:b0:4f1:2734:a3d9 with SMTP id c18-20020a056a000ad200b004f12734a3d9mr10475427pfl.61.1653059501102;
        Fri, 20 May 2022 08:11:41 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k22-20020a170902761600b001614cd997a8sm5803656pll.236.2022.05.20.08.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 08:11:40 -0700 (PDT)
Message-ID: <f35d7a15-0cbf-1663-15af-eae37a90d0ff@kernel.dk>
Date:   Fri, 20 May 2022 09:11:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] char/mem: only use {read,write}_iter, not the old
 {read,write} functions
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20220520135030.166831-1-Jason@zx2c4.com>
 <YoevH5YFLcBBfsB0@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoevH5YFLcBBfsB0@zeniv-ca.linux.org.uk>
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

On 5/20/22 9:09 AM, Al Viro wrote:
> On Fri, May 20, 2022 at 03:50:30PM +0200, Jason A. Donenfeld wrote:
>> Currently mem.c implements both the {read,write}_iter functions and the
>> {read,write} functions. But with {read,write} going away at some point
>> in the future,
> 
> Not likely to happen, unfortunately.
> 
>> and most kernel code made to prefer {read,write}_iter,
>> there's no point in keeping around the old code.
> 
> Profile and you'll see ;-/

Weren't you working on bits to get us to performance parity there?
What's the status of that?

It really is an unfortunate situation we're currently in with two
methods for either read or write, with one being greatly preferred as we
can pass in non-file associated state (like IOCB_NOWAIT, etc) but the
older variant being a bit faster. It lives us in a bad place, imho.

-- 
Jens Axboe

