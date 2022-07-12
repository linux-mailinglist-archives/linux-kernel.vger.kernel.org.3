Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139B95728C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiGLVpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiGLVpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:45:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7176DA58C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:45:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w185so8588201pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=t91dV4p+lIBUUzn1a9qwdkpkg3zk1bPcQsEAZ+bI0n4=;
        b=LXA1nvp/pnJFnXX58mMxdmCDAp9A/H2P5NRTYlra6mVFwjjWpLS+/8gLrcYP8S9OxC
         yZYKdJtb69SGHYhdeA9x7ZZ/4ogA8Axl0soi3V+9kmSDhzSiylXvVyHUXvC8yBODG7dK
         iE+UI176nucZuGK7HMEQcagi80fmCdfaCr/VXVTZfr669E+rcQR9ZzxQbRGmgufQEiUq
         XL7AY/cVnEmitX2J2X4PMEp1O+NzJbxZ95WqDrsRYZSkz7DTVJqbbW397qLoLNs9XrRc
         pGFYdNPwMbu0C70y9Kbeux5ucWiEovYrYCyxBwsre/oV3WlR0frcL7eSyneGJSUZTxSg
         +kBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=t91dV4p+lIBUUzn1a9qwdkpkg3zk1bPcQsEAZ+bI0n4=;
        b=sjhAvO4TVtaCxLpfGrn+Gi9HYJGW6iLZVRz+IFe0yqtg6rikdN0unAUeLVsoRxuCwY
         gOekHOrSu+jtUYJZhD7K34SYquufPG3MgpiU+HEqVV/t2i1kmrKR19LGANafaYKi5Z0b
         H2b+ROlr0plmw4Nw+ur+fmonTOHNC7NXCbpFCfuVdsHjH7B+HOfXBBh8JTIoqERJr4M3
         8i1aCsqdTP6ZyxgxPMBsvsN5udGvvFN04UfB5Pc+mYwjZpsVxaz7T19jmB+1ps9413fr
         NE9ddvZxuzCZsf1P07HdRivoOvVyOp+ZhOSqyDAb9n7YqYW/zKc6OM4sr6B0kAw6Cimg
         6BGQ==
X-Gm-Message-State: AJIora8pL6ADwDSiFfRSd5rN6znk06axHopdY6CCNOaZvymka2lksOwn
        6mDRA1fHu51WChkXZ8xMrCZHJKdGHA0UQg==
X-Google-Smtp-Source: AGRyM1uIM2IhbbnhU5hU2KB7CAbnkROh4oRWKyYPDKmv+Jr+UhBnD+Z6QhKTiBe+IcHsNlhwCgRASQ==
X-Received: by 2002:a62:1b57:0:b0:52a:d646:de3c with SMTP id b84-20020a621b57000000b0052ad646de3cmr207673pfb.60.1657662345921;
        Tue, 12 Jul 2022 14:45:45 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f54700b0016be4d310b2sm7368109plf.80.2022.07.12.14.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:45:45 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ubizjak@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220712151947.6783-1-ubizjak@gmail.com>
References: <20220712151947.6783-1-ubizjak@gmail.com>
Subject: Re: [PATCH v2] blk-iolatency: Use atomic{,64}_try_cmpxchg
Message-Id: <165766234436.62453.4264335710864400533.b4-ty@kernel.dk>
Date:   Tue, 12 Jul 2022 15:45:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 17:19:47 +0200, Uros Bizjak wrote:
> Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old
> in check_scale_change and atomic64_try_cmpxchg in blkcg_iolatency_done_bio.
> x86 CMPXCHG instruction returns success in ZF flag, so this change saves a
> compare after cmpxchg (and related move instruction in front of cmpxchg).
> 
> No functional change intended.
> 
> [...]

Applied, thanks!

[1/1] blk-iolatency: Use atomic{,64}_try_cmpxchg
      commit: aee8960c2eae12636040dbf0f04e135273b1612d

Best regards,
-- 
Jens Axboe


