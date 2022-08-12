Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6A859159D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiHLSpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbiHLSpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:45:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A875417051
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:45:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o3-20020a17090a0a0300b001f7649cd317so9150228pjo.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=EsyzVUQW3lhq8PbIpm+iMiCgj6eBjplWp2G/k27ML9c=;
        b=lwmwMFDeg573WZwqyjRAzteMIgokt2V8ryD597LyJwUT2wsXbXpLyCl6o0XVaaPKlu
         VLbf4K+sm2GmB51znjagi/AXR/RsSGRs+ORlfjqVeSXqtbCaV77YQAgm75OEzEq+mgm/
         lAUtJxyL7z4DA+JAESVdWlr40z9dsx1JPDbZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=EsyzVUQW3lhq8PbIpm+iMiCgj6eBjplWp2G/k27ML9c=;
        b=aB0sJSJg0Nc43+VB8VBL1+go0Jco88sGbLdXQambFdRC71f+a1u5fE2SBQucbX3qrF
         ZIwTAtO0J5fdCXfH1k+xIXMJDT381In2N3y/N4GNX4VGGhtMx+Nqw52DiayHpJt6XhUp
         p9ZDhn2FtX4mlWgQr3Vv/+5NThMpDfjj7t4qeJTcJCBJtDaeleui3yHZ36RTIZXZP0UC
         Rtm7Od9SWOWubUBvE8UBt2oX5ZujQtXfYQzXcPlXy7u0DesfaQ2Gaxh/YVC7kF6HNUA3
         zOln+EBeVWr3eQouiHnvFDx2+JOzH2aJnWxDvHUb3wRGoJCWjbQkJogDNdYKMYm1gtZ1
         cnsQ==
X-Gm-Message-State: ACgBeo0ZelhSq7rViBBGKyPYn/RS5AET8W0aqKZoUUo7A04ZQqC5ckZq
        gxIyCFz3kdbVnwny6YIczpGoIQ==
X-Google-Smtp-Source: AA6agR48xHogCuZSvWQIVxaaZq+M/JOYoLiUJolsdt3Y1iss2UZsRE019KovrKanKfS5CEKWVQ6WCQ==
X-Received: by 2002:a17:90b:3805:b0:1f4:ebfe:558b with SMTP id mq5-20020a17090b380500b001f4ebfe558bmr15283844pjb.48.1660329938127;
        Fri, 12 Aug 2022 11:45:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y12-20020a170903010c00b0016db51ca7dfsm2080847plc.15.2022.08.12.11.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 11:45:37 -0700 (PDT)
Date:   Fri, 12 Aug 2022 11:45:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     ira.weiny@intel.com
Cc:     syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        ebiederm@xmission.com, viro@zeniv.linux.org.uk,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec: Test patch for syzkaller crash
Message-ID: <202208121144.E9E5EE9E@keescook>
References: <20220812000919.408614-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812000919.408614-1-ira.weiny@intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 05:09:19PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Kees reported that it looked like the kmap_local_page() conversion in
> fs/exec.c was causing a crash with the syzkaller.[1]
> 
> At first glance it appeared this was due to the lack of pagefaults not
> being disabled as was done by kmap_atomic().
> 
> Unfortunately, after deeper investigation we don't see how this is a
> problem.  The crash does not appear to be happening in the
> memcpy_to_page() call.[2]
> 
> For testing, add back pagefault disable in copy_string_kernel() to see
> if it makes syzkaller happy.  If so more investigation will need to be
> done to understand exactly what is happening.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c6e8e36c6ae4b11bed5643317afb66b6c3cadba8
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/exec.c?id=40d43a7507e1547dd45cb02af2e40d897c591870#n616
> 
> Cc: Kees Cook <keescook@chromium.org>
> Reported-by: syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Thanks for spinning this. As noted in the other thread, I'm going to
wait and see if the crashes return. It looks like it may have been an
unrelated problem that got fix in -next (no crashes for a day now...)

But we'll have this in our back pocket if we need it. :)

-Kees

-- 
Kees Cook
