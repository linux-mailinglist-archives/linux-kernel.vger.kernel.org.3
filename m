Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3BE5754D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbiGNSVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240602AbiGNSU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:20:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E7F68DFB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:20:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w7so1150903ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iz5pIvIsprRM495K818R3Zbu3cmGxSjRtTtLScpdDXA=;
        b=V97C9moOOlFK6WsvQ9LqYtmnIg7W1Lbr/u4DJJgbM+61lHMEW1A3CYmM/UJts02/Qx
         OryDv5Iq/BFeFS5mWGzqA5BJYcA0oipJ09xlZAUfH9rnszSnTeuVgazpJ+EN+g6bSSYE
         Eo7vtDZQ2KkEeTleDyLtnSBL4tlyvNmyVhGLkTsp7lpfExzxkjgC7bLmtGutBmnhKaJl
         KVQcAxRwfDyRqmOi5sJcZC0mAWec2B1l1D3OKAqlSxhMA/j7Xlf/EgCh1mY6JcpvWnbZ
         t0v2vZahZc3xpWajaM12vV96dHuFxl0ONg0Xhv/m3JokpSatFPnGQaDV67sL8eBmj9j2
         1Unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iz5pIvIsprRM495K818R3Zbu3cmGxSjRtTtLScpdDXA=;
        b=n5vwM8vPvSJ6AiQBuu0EGjnjF9shy9eb1bbMQa5YjcJrD/2spC4uHbMqq1qLJAncsN
         RvDrn+9m3fiTWf2p63l56PmKoc9IAu8Q5Mk+gcHSswdD9LB912tjxhtgIIXREw1ArMAH
         F5GEZ5kYewHInWybfdBho2zd+PfR9QRNZD0vt38EybgS+h3GTsmRqURwHx02uH7RBSnc
         N0gGhFfslqz9akvrwR99zBnrTzpIk1NS9o/1AXJEIine+LcpTXDlBhxplSdI5eIRDEo9
         vjxnB6TncTmqHie3ZyBoP60x8Ds+uluQRvQEuMY2kQd58DghO9Kj+fhVrHAAR5eIoMkl
         gzuw==
X-Gm-Message-State: AJIora/F5fWfCwAPGu/51Wzrzw4suL9tgiK5BrFyqNxCseu9HpHWb/D6
        FRcRx3OiwYcCQzvfY4j+Fpo1SA==
X-Google-Smtp-Source: AGRyM1tqhYb7wHAMII+jpCD7ua029D2FIEZzxlzyyxcFRFR3GfzBs5hY5X7yHhJQ1kfA6giJn73qQA==
X-Received: by 2002:a17:902:d544:b0:16b:d981:5c2e with SMTP id z4-20020a170902d54400b0016bd9815c2emr9229200plf.22.1657822857621;
        Thu, 14 Jul 2022 11:20:57 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b0015e8d4eb231sm1806733plg.123.2022.07.14.11.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:20:57 -0700 (PDT)
Date:   Thu, 14 Jul 2022 18:20:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+760a73552f47a8cd0fd9@syzkaller.appspotmail.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>
Subject: Re: [PATCH 0/3] KVM: x86: Fix fault-related bugs in LTR/LLDT
 emulation
Message-ID: <YtBehUm1x2fgBlNI@google.com>
References: <20220711232750.1092012-1-seanjc@google.com>
 <103BF4B8-2ABE-4CB1-9361-F386D820E554@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <103BF4B8-2ABE-4CB1-9361-F386D820E554@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022, Nadav Amit wrote:
> On Jul 11, 2022, at 4:27 PM, Sean Christopherson <seanjc@google.com> wrote:
> 
> > Patch 1 fixes a bug found by syzkaller where KVM attempts to set the
> > TSS.busy bit during LTR before checking that the new TSS.base is valid.
> > 
> > Patch 2 fixes a bug found by inspection (when reading the APM to verify
> > the non-canonical logic is correct) where KVM doesn't provide the correct
> > error code if the new TSS.base is non-canonical.
> > 
> > Patch 3 makes the "dangling userspace I/O" WARN_ON two separate WARN_ON_ONCE
> > so that a KVM bug doesn't spam the kernel log (keeping the WARN is desirable
> > specifically to detect these types of bugs).
> 
> Hi Sean,
> 
> If/when you find that I screwed up, would you be kind enough to cc me?

Will do!

> Very likely I won’t be able to assist too much in fixing the bugs under my
> current affiliation, but it is always interesting to see the escapees of
> Intel’s validation tools… ;-)
>
> Only if you can.
> 
> Thanks,
> Nadav
> 
> [ p.s. - please use my gmail account for the matter ]

Yep, still got an alias for ya :-)
