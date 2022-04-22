Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA61650BC7A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377926AbiDVQEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349941AbiDVQEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:04:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59E15B3D7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:01:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y14so7638330pfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fvtAej5JGuVNellLLY4vrStrSV2CBZuRCp+5/JoyStg=;
        b=bOdn0jImn1WzfjZlNuqZ0NhMzBD2ETilnRrtGpFJWNkMinZAyvm3Y5DhXSZMK7Gb7Q
         l8Z+XPs33ywbyztRtDR265zlFXOgQI9pw7HM6nwoKJDbteEH0Vd5EUon5g3ClY9b/vlB
         HonsGIi18Lr55450daKO0nITBr8Nf9xv5FEqlK5LP3HebVJ6Y64/EhwSlY0DO2lMapkB
         hhtIj73Uy4tcDLPDhxsY3duBU90/0xmP6g9NaJu1bdFU3+PSykbe5ztWaCSFc8HBeESU
         rc2FnydIYFD3xCQsXVAnkhCXBJkY/qQp9n/v6fNfST4mQ5foZo8rm7wV1105F8RvnL0k
         LWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fvtAej5JGuVNellLLY4vrStrSV2CBZuRCp+5/JoyStg=;
        b=RJS7kXc42yj43cSTgveQR5dZ6qbRZj2MR/t7RAjsXjoynD4qvCWAWBZFBaX5ekCL8e
         xO4eGp6GJ8+IEdQuhQGM/jR4/W8Vwe/8jFnyZSpVCJV1ws8MgY3UAon5Y40XjHTyup4i
         urlvFERndPQnzP7neTUza5XuvHQ5GdEtD52/7A3FxeCDpwR/tIHwXOG783XcsU2KEsIM
         kvE0Jrd+g4aKeR2pXGMm+X/bVz61BDeEZJCMtHvr1QFoykqGiUSzpWlvZojQWPuXFHNo
         cf8jIE4jahROqDz4RR5NOK7vKjIS0pL0GL/Y7dUuGdqadU4AsRL9z2SFN0+zVpSEb8ui
         Yw8g==
X-Gm-Message-State: AOAM533T4sIECViJ0tQcY8kE2CFxgr9+zJ5+ePToZuHa03h+/p/ycpEL
        Bj8CcLaJMYPYxX3m2BPSuisEDw==
X-Google-Smtp-Source: ABdhPJyFRGjHeqwVzOLzk4oMDHyTo0XSFm3q/7QS1+GsVOjKC39tK72dkWebL2ZT8MztbPWRHd/gOA==
X-Received: by 2002:a05:6a00:1a8f:b0:50a:8c2d:2edf with SMTP id e15-20020a056a001a8f00b0050a8c2d2edfmr5629277pfv.82.1650643307893;
        Fri, 22 Apr 2022 09:01:47 -0700 (PDT)
Received: from google.com (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with ESMTPSA id l5-20020a63f305000000b0039daaa10a1fsm2525043pgh.65.2022.04.22.09.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:01:47 -0700 (PDT)
Date:   Fri, 22 Apr 2022 16:01:43 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Li Li <dualli@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: add BINDER_GET_EXTENDED_ERROR ioctl
Message-ID: <YmLRZ4zFuw34nyOE@google.com>
References: <20220421042040.759068-1-cmllamas@google.com>
 <YmLI03OT6st9fcQD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmLI03OT6st9fcQD@kroah.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 05:25:07PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 21, 2022 at 04:20:36AM +0000, Carlos Llamas wrote:
> > Provide a userspace mechanism to pull precise error information upon
> > failed operations. Extending the current error codes returned by the
> > interfaces allows userspace to better determine the course of action.
> > This could be for instance, retrying a failed transaction at a later
> > point and thus offloading the error handling from the driver.
> > 
> > Some of the elements for logging failed transactions and similar are
> > folded into this new logic to avoid duplication. Such is the case for
> > error line numbers, which become irrelevant after assigning individual
> > error messages instead.
> > 
> > This patch also adds BINDER_GET_EXTENDED_ERROR to the binderfs feature
> > list, to help userspace determine if the new ioctl is supported by the
> > driver.
> 
> Hint, when you say "also" in a changelog text, that's a hint that this
> should be more than one patch.  The last thing should be a separate
> change, right?

Yes it should. I now notice I forgot to add the binderfs feature to the
kselftests too, so I'll include that in v2.

> > @@ -2845,22 +2885,20 @@ static void binder_transaction(struct binder_proc *proc,
> >  			/*
> >  			 * return_error is set above
> >  			 */
> > -			return_error_param = -EINVAL;
> > -			return_error_line = __LINE__;
> > +			binder_txn_error(e, &ee, return_error, -EINVAL,
> > +				"cannot find target node");
> 
> You do this a lot, how about making this one commit (first one), and
> then adding the new "back end" to the error stuff in a second commit.
> That would make it much easier to review, first commit does nothing new,
> second one adds the new functionality, and third adds the feature flag.

Yeah, that sounds like the appropiate split. Thanks!

> 
> thanks,
> 
> greg k-h

--
Carlos Llamas
