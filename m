Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3FA59796F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242178AbiHQWFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbiHQWE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:04:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800A98E99A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:04:55 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a8so13668270pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=g5Cwtg/e3x0N2ZQ3tPBvhSnRZUcWNMaqqvSxjgijWMA=;
        b=MF7IKc/7fee3VhfyolCugaH8y8eiJN7hrfJamrgXlq6GNKqBY53C6E+fzbMGTRSNsP
         C0kfSdsd/ObpIlb8HK8RPz1VvaodkNu6EVcB+CfdKryWkVUa1KrNiF18VJ5XNfjysf2p
         jV6EUR4Ah1wt9eKr9WS4/Gvp2PPLbQuF8f/84rCVRVCvCyhfUE7NktxTvmb3u973P0qi
         8Bu6c/s70RcoWiGJMl4vqEJvqRBg0PptrtYj0kIQEt98L7EJuxfxWSafkedSJuCWOeeD
         2K0YpaZQsEksViI7uB8YTazha8+9RMNIg5kgQgSAtz23Op2DRaC82BkXJP7OgUs2Wx8g
         2HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=g5Cwtg/e3x0N2ZQ3tPBvhSnRZUcWNMaqqvSxjgijWMA=;
        b=R1QyJDWaFJbLhb2z4nqA8JEQDiaLCKsbbqHFV16pi9bjPLN7jd4Pb2oravwObKOevW
         haoeGg/Tu7+4hi7nw/sOk4+AB9rEgmy5D74MUrSCUSas05yAlsIiQuCMCh2GLsEZ/6z1
         kquJcy9Abb3pLsrJ9zYPIev7qJwgNrYq/rJ8f/RT3subuunV6Yb30rbnoPaY9o6Tr1RG
         KoXab9cOK+mINnbpipE4dYxWWRySyvbpZtdyZ7YHX6GSF7vM79ft3sMWWx2UtPRmois8
         VtQ/WGpPwwANHhkKP+9wS6L62t0I6XQDLEsftla/wD792H4zYP1TMQHZXTXi3UZFEsKb
         8/Qg==
X-Gm-Message-State: ACgBeo2N3gC4WwzY76r6SRbaPabGTq3PDwAbmCvtN1O75PlTdvNMjhoD
        15AJ+jygRYJ1uieIEbxinbWspA==
X-Google-Smtp-Source: AA6agR6+ssGju5LgKRm3GacO50Ewp0qnbLxMglZQ2TkKHmR5FdHOesfIyIbYzW1SRcuufdToeHp08g==
X-Received: by 2002:a17:90a:7bce:b0:1fa:bd3c:71df with SMTP id d14-20020a17090a7bce00b001fabd3c71dfmr3367386pjl.40.1660773894800;
        Wed, 17 Aug 2022 15:04:54 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a070900b001f7a4ea4fd5sm2007757pjl.39.2022.08.17.15.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 15:04:54 -0700 (PDT)
Date:   Wed, 17 Aug 2022 22:04:50 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] binder: fix UAF of ref->proc caused by race condition
Message-ID: <Yv1mAu9Ndk1SoUHr@google.com>
References: <20220801182511.3371447-1-cmllamas@google.com>
 <Yul9sEAtM+4aGbEg@google.com>
 <Yuoj1GVrgtflsYYZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yuoj1GVrgtflsYYZ@kroah.com>
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 09:29:24AM +0200, Greg Kroah-Hartman wrote:
> 
> Thanks, I'll add this when I queue it up after 5.20-rc1 is out.
> 
> greg k-h

Hi Greg,

I think this might have fallen through the cracks, I can't find it in
char-misc or linux-next trees.

--
Carlos Llamas
