Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FA45A6EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiH3VIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiH3VII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:08:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE38E77548
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:08:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso9987364pjd.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=7/3MCSRqTL5jVIZM/cRuVVH10fyxNTwncj+rf5LxHRg=;
        b=rgVMI11fItS8vT6OV7UCLpgcTjeCncWwLtm7rzqNpor4G5YV0JYeLq7hVYf/tG4kBz
         /WKNbDzHzcK8yfqp8OWARMQAKw/4onGA9NEHAQZ5y4FYaFepelSAtCGe05JORT4lNnXm
         nHaHcd+6cVhZN8apJ/3LN+8Qjvwq8b12BXynYyz+vtSEPo4A13cwmXjd/sr+w6pMZHda
         oNrwDx0TRzB/zklk2q6D/cMv6EPt6ZVzON0wu1XJN+UP+VRfhjsruhuSjDVyXHd89W12
         SlnYIDOzKpKvaNdPOA8+ylQBu4uYNogKAE+qGXiXMvorlkJ/XdyBNsRUXyjLpvYj5i+3
         bDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=7/3MCSRqTL5jVIZM/cRuVVH10fyxNTwncj+rf5LxHRg=;
        b=Yao2EF2rE4dirsmtpJChcA79p3dIfAaS6b9dswM6+g+m/Fg33+aB62Tsj7pICvQup+
         ScNxj+Hdz93c2+Gxw6XJjWwmNTcM5a6GSafpi7BkSf3eIvh4oupk8mGXSlcqeXSkxL4B
         9JorHUmPv3exW1Pc6xp8j/a/Tr1eocAWQrU165cQ3Ybzcl9fONs3uhpAjDtCSK3wA4C/
         6CDtHg4HONqNwU47j0OIzuIlC0fmBebPQFlPHg9Lg/6mjDIG9GFST3xwmPXY/ZhMOq+F
         jbzcFo4m5AKtSdnUjVB1+rDsX1k60YjbJnoraGn3wnCj7TywoQf+AtzclfsEBH3AzzqP
         LUTw==
X-Gm-Message-State: ACgBeo3gpQS+CYXuV7dQYc75KAa1tjVqsCxp+X7lv63nZIIMcGROBq2t
        BsAmA9ubSNbvdBrVRwEIQPd2Lg==
X-Google-Smtp-Source: AA6agR7uMuQtSXuKPfdl4DSAoR5OJyC0Fs7X7dIweAypifEG4lofoY/0UKvwJsuM3fbZz1AAHE1Q1g==
X-Received: by 2002:a17:902:e0cd:b0:174:4fdb:3f5a with SMTP id e13-20020a170902e0cd00b001744fdb3f5amr19520144pla.25.1661893687214;
        Tue, 30 Aug 2022 14:08:07 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903244500b0016d9d6d05f7sm7874562pls.273.2022.08.30.14.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:08:06 -0700 (PDT)
Date:   Tue, 30 Aug 2022 21:08:02 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] binder: remove binder_alloc_set_vma()
Message-ID: <Yw58Mm5QrPIFtYak@google.com>
References: <20220829201254.1814484-1-cmllamas@google.com>
 <20220829201254.1814484-5-cmllamas@google.com>
 <20220830185751.gpudzi2pv3jpjoib@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830185751.gpudzi2pv3jpjoib@revolver>
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 06:57:59PM +0000, Liam Howlett wrote:
> * Carlos Llamas <cmllamas@google.com> [220829 16:13]:
> > The mmap_locked asserts here are not needed since this is only called
> > back from the mmap stack in ->mmap() and ->close() which always acquire
> > the lock first. Remove these asserts along with binder_alloc_set_vma()
> > altogether since it's trivial enough to be consumed by callers.
> 
> I agree that it is not called anywhere else today.  I think it's still
> worth while since these asserts do nothing if you don't build with
> lockdep and/or debug_vm enabled.  I was hoping having these here would
> avoid future mistakes a lot like what we have in the mm code's
> find_vma() (mm/mmap.c ~L2297).
> 

Yes, the assert in find_vma() is perfectly fine, we need to check that
callers have taken the lock before looking up a vma. However, the
scenario here is different as these are callbacks for vm_ops->close()
and mmap() so we are guaranteed to have the lock at this point. We don't
really want to duplicate checks for each user of these callbacks such as
the binder driver here.

