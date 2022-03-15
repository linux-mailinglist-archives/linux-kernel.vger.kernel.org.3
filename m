Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BAF4D92B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 03:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344513AbiCOCpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiCOCpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:45:34 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED4A6312
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:44:19 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id h126so34681650ybc.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALZ59N4CedudtWbHtCRLf08jfAIB9a/GZAp73b58zds=;
        b=UpL/4zD9cMcdYUinMsRQ5W51Z063ckBpCTEOKx9ZI7qJ4o2loHQj+N+GlktPvqh0Ja
         ghSuLpHLhN5tG+3V6+eko7Ag/c5lEDiqz/l42a3V4Ns8sIRtWK9qPdB22VI15xXWhUvN
         8vRMZdnyqqgmQdd6vKylHltxR6N8zpGORDnUp8aFx7MUc8NXy8Roz0bGyqLz8aIiBRFp
         lF6hCF+BWnBe0MkDDdD70LmiaMIAuJZQbF32d43fcWgPNkmL4772vHSTyTRK2242z9oZ
         QGSzcwLYZhvRuMgtB2QYJ5tf4xOofb7GBjJRRX3tLyyDzDY0l8ce19uxTrxTDCyOOLwV
         +Kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALZ59N4CedudtWbHtCRLf08jfAIB9a/GZAp73b58zds=;
        b=ZwBunkMishQTxPsvVf6Kr7JDUnxV7IdkFRWRJkutnMrFa7HhPyBUOKFPy+BeMh2SRX
         b7A+RWxH/BqXrBiLYy/2o6DezY2KViB53OMWLp2z12D2OpkKXgCQn0kDnH8PfxVuXHb9
         Y/VgZLr5380B1w4gv1P2RRONa9YWjcti7vnzb0pi1WBlXjuaDhxMOPTv9l2xk2S60c8a
         bsexCHwsQin0Spxehq+73Ai8oP2cKn3aa5Y+mJDSC9up4+fSPh12BL6WJwGj36DoxGo+
         p+HrSJdOHPA3suo2EfdXGQuT6piAKXHA3CJaa4bdt5NrXDKElE6ZxeKjObWr0H7tGmG3
         AQKA==
X-Gm-Message-State: AOAM5306EqsxIUnJBZQR9BAM8AO3kLCMhVMCCCyRTF7PdKNK9JJQR5VB
        FpB/lXCqmVtFIOLDCZm6Xp4Oe5DEOobo5Ax7q+HGjqwUEbJZpQ==
X-Google-Smtp-Source: ABdhPJwq3u9EREtyVlqR9WZSQcGPNKrtOhv2nA1nBLvFoQ+tpt6dliUmZBjwLkmfl3pKMT2BHDfLLp9EdUVAk33nkAY=
X-Received: by 2002:a25:1bc1:0:b0:623:2a4f:5d04 with SMTP id
 b184-20020a251bc1000000b006232a4f5d04mr20490491ybb.155.1647312258991; Mon, 14
 Mar 2022 19:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220308092047.1008409-1-butterflyhuangxx@gmail.com>
 <YicoOC+WZhNLq+pX@kroah.com> <CAFcO6XMy+rT_cnw2Q7Jzg=byKWQ8tcVU+8ZBCCfTD1-JNy7oLw@mail.gmail.com>
 <Yics6JbQljlQXRED@kroah.com>
In-Reply-To: <Yics6JbQljlQXRED@kroah.com>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Tue, 15 Mar 2022 10:44:09 +0800
Message-ID: <CAFcO6XNLfOTp2M3B876YTt+atNTveuqH7Q3ePk3N-T=KkJkiTQ@mail.gmail.com>
Subject: Re: [PATCH] virt: acrn: fix a memory leak in acrn_dev_ioctl()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Li Fei1 <fei1.li@intel.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg, could you tell me how to test (like this)?

Thank you,

 butt3rflyh4ck.

On Tue, Mar 8, 2022 at 6:16 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 08, 2022 at 06:14:31PM +0800, butt3rflyh4ck wrote:
> > No, not yet. I just code audit.
>
> Please test things like this so that we know it actually is correct.
>
> thanks,
>
> greg k-h



-- 
Active Defense Lab of Venustech
