Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22FD4BE4DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379706AbiBUPzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:55:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379709AbiBUPzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:55:23 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E136A27B09
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:54:59 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l8so13239011pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=8QDSUHipiXOmJpSrau7T5eiJpwUAiawNmt0EEAP4a7A=;
        b=SqyBO1aEgivpPulhfA6Htgmm0yMFE3vz07W2X0+u5ugY2uH1bYj6n6yzq5mhj92imq
         Q6m3cA2Y/BfzsuoNN0h4WkG0/Ry3LQpL9nZwunXn/iEo/8bcUM7e0uCNNaAw5zIoS42W
         Z53B4ZszzY2DQZtibCJzjnmzsP8IbhYzLCjHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=8QDSUHipiXOmJpSrau7T5eiJpwUAiawNmt0EEAP4a7A=;
        b=wMjfvK27+p1Mr5Hc1GB3oq29rmw9lQ8bzMYyygH8/R7KFA/UaB2dVUhxG/HJroynKu
         io/PcrudNcz7a7LDf2adhGAkV7g+TxfTiipxnosYwFktjQEkU+yxQI+cR1GeWpDsYiZn
         jQYJ9Qe2+sk0NS1vq4rIEDf173XFLl2YsxTGUJQ2usmFxVcxA1px6OQwEC/Lw/GHz4qb
         IckDyqNMKpf3XBbeUil8TGMqxx8P9BN8EmwnRQCpOCdwmBck4Dw0u4snf+KN8NkMryEq
         s1AfwfIYcCLDKLLvFUWXxPWRnta+7QCeMu1Xal2yAYPbjKlYAk6LNgqHeSz6PketFOlr
         1ZiA==
X-Gm-Message-State: AOAM533Wv4MjjnajXnqe7XSuwY1UDNp94RlXYr+yoqIyY3SL0CRtJydI
        FJmObe539OWnwyg1aNSpTzzfOg==
X-Google-Smtp-Source: ABdhPJzlMt/i6oQ1efXg/NAN/NMt9+xSj6aPdBxdEY+pLxp2+N87JMW6op+1f4911Qqsr7HKo0V3tA==
X-Received: by 2002:a17:902:7043:b0:14f:47:a455 with SMTP id h3-20020a170902704300b0014f0047a455mr19426956plt.44.1645458899276;
        Mon, 21 Feb 2022 07:54:59 -0800 (PST)
Received: from ?IPv6:::1? ([2600:6c55:6300:7238:34b8:edf8:24ec:9845])
        by smtp.gmail.com with ESMTPSA id me14sm8453105pjb.41.2022.02.21.07.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 07:54:58 -0800 (PST)
Date:   Mon, 21 Feb 2022 07:54:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 15/29] x86: Disable IBT around firmware
User-Agent: K-9 Mail for Android
In-Reply-To: <20220221100615.GK23216@worktop.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org> <20220218171409.456054276@infradead.org> <831051EB-FF09-4B75-98EE-A7C8D0054CFE@chromium.org> <20220221100615.GK23216@worktop.programming.kicks-ass.net>
Message-ID: <4DC4ECA7-902C-4496-8AAA-173D86C7C730@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On February 21, 2022 2:06:15 AM PST, Peter Zijlstra <peterz@infradead=2Eor=
g> wrote:
>
>Could you trim replies so that I can actually find what you write?

Sorry, yes; I was on my phone where the interface is awkward=2E

>On Mon, Feb 21, 2022 at 12:27:20AM -0800, Kees Cook wrote:
>> Please make these both __always_inline so there no risk of them ever ga=
ining ENDBRs and being used by ROP to disable IBT=2E=2E=2E
>
>Either that or mark them __noendbr=2E The below seems to work=2E
>
>Do we have a preference?

Ah yeah, that works for me=2E

A small bike shed: should __noendbr have an alias, like __never_indirect o=
r something, so there is an arch-agnostic way to do this that actually says=
 what it does? (yes, it's in x86-only code now, hence the bike shed=2E=2E=
=2E)

-Kees

--=20
Kees Cook
