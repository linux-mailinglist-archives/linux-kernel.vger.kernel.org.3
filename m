Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467224E3EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbiCVM6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiCVM6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:58:36 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0898D7E5B1;
        Tue, 22 Mar 2022 05:57:00 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b67so13856391qkc.6;
        Tue, 22 Mar 2022 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i2S7GUSm4U+AQin/dmmFLgpcSV/IXmCIEf4kHj0vegw=;
        b=amfkBcqD44VtirdMn+A9VzZR6t0nli76vBiTvadY3X2EAMOAntGpYjPjbqnPh6tIvI
         PV3bj+UTlnOvlIEmeQ0MnC4FCD2OmtUo8DKz6p9z3xPvscMW9nNwDUUAQuL4baUMVect
         KAoZrAXEK0fYMDC7WiRS+TSC8EsxcrT/QG1mrSaJ/g9TelOg/HP4pQcxBCfM9beyfrsG
         Ykvkd1zkhxSxrG3GmkqAXwgll24z5JjLTo3FkgI/d+DKmxKEF3LzgCLHBFdEnzWmmBpk
         2GQHNS1gpMo4oBtLZMfMm4xGn2lER6ZhXPz2N8l5vMHlfgeycdEcUsrDjettVGu1MnsX
         +gGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i2S7GUSm4U+AQin/dmmFLgpcSV/IXmCIEf4kHj0vegw=;
        b=yoDzgk6SfbOlqdmyej7FwlWPI0oryurtbMv2ep7as3I2lC1bkUno+I8QLVb6iBlzZH
         01GjUar6bnVwUJdihdNQoON3s+5p0LYD3JH5oocef1KYqqRkafoQgAuy/FumaIULVzdx
         cv0vHzdjPIoZ9d68nrnePfoNmkMMfE0jjQSmFXOkHQ4gup3AYbOMTLSu+yOLr4RTClEj
         K4nBcmOLxRASfVPUYKfUCrNVVM8XpL7naJ5th3N4Lvu6SQK1lpzR6s/QA1GyFfk34eAG
         BHiJb9P/QD1eT+XlBqi63cTEeIE1HhVeJP3eVqriFsxr27onzErm5Ksq47ftvpiHXEyM
         85Lw==
X-Gm-Message-State: AOAM532Fd3JNmRQPmg/rxrESg77w0EOHk6w68wBS52FWV463/3Q7CmPm
        w4qMpsh3wj/nb29vJOcZQwHQisGtv/c=
X-Google-Smtp-Source: ABdhPJyHrDcm46F8h/4fgwjIMArSK8hAMGmWW49trJwvxRqhUMpMbZulByGyLPkLVFOTCMy/qv7i+A==
X-Received: by 2002:a05:620a:1a0e:b0:67e:8e1f:e2f8 with SMTP id bk14-20020a05620a1a0e00b0067e8e1fe2f8mr5635727qkb.756.1647953819966;
        Tue, 22 Mar 2022 05:56:59 -0700 (PDT)
Received: from vps.qemfd.net (vps.qemfd.net. [173.230.130.29])
        by smtp.gmail.com with ESMTPSA id m4-20020ac85b04000000b002e1dcaed228sm13381979qtw.7.2022.03.22.05.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:56:59 -0700 (PDT)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [192.168.128.2])
        by vps.qemfd.net (Postfix) with ESMTP id E7A5C2B525;
        Tue, 22 Mar 2022 08:56:58 -0400 (EDT)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id E4DB86002D6; Tue, 22 Mar 2022 08:56:58 -0400 (EDT)
Date:   Tue, 22 Mar 2022 08:56:58 -0400
From:   nick black <dankamongmen@gmail.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     "G. Branden Robinson" <g.branden.robinson@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [patch] console_codes.4: ffix
Message-ID: <YjnHmiYL50SqHCW/@schwarzgerat.orthanc>
References: <YeEc2pYvKEckcAmv@schwarzgerat.orthanc>
 <CAN4uE+p-uKzHNYry2YhCMfEFBQ2jUqpDAGx=+eha01w-L4fAjg@mail.gmail.com>
 <20220320160217.gws42lklp6ishzub@localhost.localdomain>
 <fd0b3fea-4b40-ffba-442f-00908a5335a9@gmail.com>
 <Yjg3jXCAsjQVHJAi@schwarzgerat.orthanc>
 <809c40c4-068b-8296-57d9-024e6623362d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <809c40c4-068b-8296-57d9-024e6623362d@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Colomar (man-pages) left as an exercise for the reader:
> Patch applied.
> However, it's weird:  I had to apply the following to your patch before
> applying it with `git am`:
> 
> /^diff --git/s, man4, a/man4,
> /^diff --git/s, man4, b/man4,
> /^--- man4/s, man4, a/man4,
> /^+++ man4/s, man4, b/man4,
> 
> I'm curious, how did you generate the patch?

i bounced this out from ~/Mail/sent, and have no idea how i
originally created it, sorry =\. i'm assuming git email-send?

-- 
nick black -=- https://www.nick-black.com
to make an apple pie from scratch,
you need first invent a universe.
