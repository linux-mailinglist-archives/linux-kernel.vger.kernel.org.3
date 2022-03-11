Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493384D65E2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbiCKQSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiCKQSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:18:46 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD645381B2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:17:40 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j26so13717442wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F+D7g0UiH7i6BYv7YTvvpd9Pn3QTfC53Ap0X4e2fku4=;
        b=rK+gqowJy4Grdf+KN/kwejFB2zVN5g3dGVr1sp7lSd0HWB6Tf5SyvkX9eRI953rLE2
         XkXJ+shb2jKMGXnSP7CH+3CgUVla5SYDLUZw+xwoCG9vQp8p2bTAUg+N2Ry1zOSkIYgy
         zvDKv5Fk7IW8zumshyzHDOoc41OoBkPIxFazFkkQJ0sSuBBtKiLLbz44zgfUmlYfvggc
         4SQnvxzQ+MvdM5P/JEbzHgAKVIu2VtCRaXqwN1Q8F9PF6/SJ5QTvKfw06n8QTJBD4poW
         yqHkBWG09o4SMWnJN8v7+81SSIWcfL6acbphDdEeoKs41GhpH2gF8/IWlvxNCNN1urDK
         8ikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+D7g0UiH7i6BYv7YTvvpd9Pn3QTfC53Ap0X4e2fku4=;
        b=LE4rtLgy9yqQdyPQAiWuVCayq+tU/gW2PDakAyIdwT5SogSh4NXBVJIPLSJc5smD7b
         BSbW+43L1IvnBWj0Cbd0P3410IKkAPRn8OXIZzA9dKA4EOwAKjLJh27FIyOogJtkEbb6
         1m9Ux5xIiKCUwziQgwn7Meh0S1mIjBaECE9DMYngeANWRXMaFhlxUoBQQaFYTe7fuGSZ
         fd1b259gm8ObWr0Zyc4OvQeCfxvh9iJGfsd1eaiuuuSQRdcyZIo37uJ7VBHrbUX8IsJz
         KAfavgy0Ue8FoCFQJONkl4tIZnnhqQoegJZp8dAmf0jjQbZs4ykTSyo52jc9CH8bqb8Q
         Ft4A==
X-Gm-Message-State: AOAM532KjRaUCYQOAvsxG7C+5rE7vfAcOMlPjZAEZgUxh23EihBZnzbn
        aixa8QkIuEDhkak+vCAfaGrBNA==
X-Google-Smtp-Source: ABdhPJytFfUgSFYCoi8WQ/YQvKNfHD2dF4EqSWpcZoldYsbdlLL9yB4eZYdHZJTuMqin/Ma1LrZyKg==
X-Received: by 2002:adf:d1c9:0:b0:1ea:830d:f1b0 with SMTP id b9-20020adfd1c9000000b001ea830df1b0mr8083457wrd.522.1647015459348;
        Fri, 11 Mar 2022 08:17:39 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id z2-20020adfec82000000b0020372dcab56sm6811548wrn.112.2022.03.11.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:17:38 -0800 (PST)
Date:   Fri, 11 Mar 2022 16:17:36 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com, hch@infradead.org
Subject: Re: [PATCH v11 13/14] module: Move kdb module related code out of
 main kdb code
Message-ID: <20220311161736.2i53cjovg3plbiqu@maple.lan>
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102625.3441888-1-atomlin@redhat.com>
 <20220310102625.3441888-2-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310102625.3441888-2-atomlin@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 10:26:24AM +0000, Aaron Tomlin wrote:
> No functional change.
> 
> This patch migrates the kdb 'lsmod' command support out of main
> kdb code into its own file under kernel/module. In addition to
> the above, a minor style warning i.e. missing a blank line after
> declarations, was resolved too. The new file was added to
> MAINTAINERS. Finally we remove linux/module.h as it is entirely
> redundant.
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Likewise w.r.t. to landing this via the modules tree, that's fine:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
