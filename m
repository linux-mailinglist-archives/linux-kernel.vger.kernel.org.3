Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F1D5B2235
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiIHP0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiIHPZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:25:47 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84D1AE224
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:25:38 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id i9so7208419qka.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=We7YdNWL+dA6SvrcsgfeWC+uhCMnz0P9xITf03yypx8=;
        b=S6yX968R0PSQ5vvRpBoI3D+fVvYOS2cDyrN0vFbrxDCjkYTM5dHtdsB5QuuEQMDJq2
         22GEdoeZIaVJp7gEDf8MrJUeos9pIEq9O0H/oJYSLbL5nEeMrRBtv/Q2pBzb4XiJpbbl
         QmPim36HxFhqnDtEqGqJhdz7fvaCKjnSuNQSBNtVtTsG36qJNDxDCTqXRYsMi1cxNyqs
         gGccXYEMJp2vlMrD8CaQsaNQAkzZWPMl4IF2AGUdYnAmoTooKlLHMCvDyWq/jJLM5EH9
         nza5+wQNU4GaqUYp3IR56KRNjKUXCWo5Vqt3OMBnLhwOLdXz+OSlFpt1+PEm0MoKDBkn
         qKLA==
X-Gm-Message-State: ACgBeo1W+0z+BwS/p95aAvZYY92YjnjE4f2gOSKh8ABwbhq4ltcw8P3O
        Y19upZ5692HdXlHghAJK6i84bV7ReK+L
X-Google-Smtp-Source: AA6agR786+XZqALGz47aUlYlRGU0gUHtl1jtiHS/dbi/BYJRHk2Rm8IwMyj9N3uQYj24nkxsh4cIdA==
X-Received: by 2002:a05:620a:2451:b0:6cb:b4db:a3ad with SMTP id h17-20020a05620a245100b006cbb4dba3admr5003410qkn.216.1662650737962;
        Thu, 08 Sep 2022 08:25:37 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b006bb82221013sm17379003qki.0.2022.09.08.08.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:25:37 -0700 (PDT)
Date:   Thu, 8 Sep 2022 11:25:36 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     agk@redhat.com, mka@chromium.org, dm-devel@redhat.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sarthakkukreti@chromium.org
Subject: Re: dm: verity-loadpin: Only trust verity targets with enforcement
Message-ID: <YxoJcG5MN4OdaulL@redhat.com>
References: <20220907133055.1.Ic8a1dafe960dc0f8302e189642bc88ebb785d274@changeid>
 <166259004596.4128104.7200162640366282166.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166259004596.4128104.7200162640366282166.b4-ty@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07 2022 at  6:34P -0400,
Kees Cook <keescook@chromium.org> wrote:

> On Wed, 7 Sep 2022 13:30:58 -0700, Matthias Kaehlcke wrote:
> > Verity targets can be configured to ignore corrupted data blocks.
> > LoadPin must only trust verity targets that are configured to
> > perform some kind of enforcement when data corruption is detected,
> > like returning an error, restarting the system or triggering a
> > panic.
> > 
> > 
> > [...]
> 
> Applied to for-next/hardening, thanks!
> 
> [1/1] dm: verity-loadpin: Only trust verity targets with enforcement
>       https://git.kernel.org/kees/c/2e1875c05267

Does this mean you're intending to send this upstream?  I prefer to
take all DM changes unless there is an external dependency.

Thanks,
Mike
