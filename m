Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06624CDB80
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbiCDR6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbiCDR6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:58:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD41919296
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646416659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I4ZKVBEqpD+ysA4vir9PME5bQFpz3Ac3BNNdB3Q/6QU=;
        b=LvXliKjpT6pitk/1rd0tE3vM+Z5raSCnRzFyxT5UzrWTU6WaN57DDs6PKjvAjvD4iLLRzM
        xU+DLliYDcut43F59GIFYubDV52jSkldx6/yfOa3HVyJAlw/UG5cGP1FDnY8tHjDAvvjnf
        yhiZC/YB+YWX8cA2PWymiYaHqgq27jg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-VHil7czXMcShmlpO99ebZg-1; Fri, 04 Mar 2022 12:57:38 -0500
X-MC-Unique: VHil7czXMcShmlpO99ebZg-1
Received: by mail-qt1-f199.google.com with SMTP id bb7-20020a05622a1b0700b002e04e16d3easo2434045qtb.16
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 09:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I4ZKVBEqpD+ysA4vir9PME5bQFpz3Ac3BNNdB3Q/6QU=;
        b=SEC1B7j/gDEgF1x4svFOyfSzHJDtOwk1QSoHnDTCfrZi5hqQyhTpzcW9R7/r12Srpb
         5RBMCi9VLFIkZgUljktaqTDUqyLEjek8GPMdSvVZV1qGpz0cqGh2o4/a+/XU0OAhK/96
         9VqU/P30sahtmXy9mqHJ7wQxpVIzM4Uq5aSaeSkd0LlUA2SShTR4GJ3ODzXKRfjyMn70
         fDtFH2W4S2R6LEq4QM9WFkLOa+qLvOUi1Rt46SZa7BCMQYNfqNmr1KRG+HYr8a21/NN0
         tOc7Li+uex+LCRBopfjtNb17EVk46CHC4m23ca6TkmCnIahIh7L1CUmIu/XuUCGgbvIF
         Q6eg==
X-Gm-Message-State: AOAM533q3tAW3eiYArRV/dthzmLOIAcbNc0Kfqf1DE5Ttf1piboC12OC
        SbOsreSPnere3HwLxkGL7b629e78lccJhQvbCAmHBLZaGF9L3A0uy5rttrh/QJY07lnKxENcgOf
        Hp9aueCLFyFUh9O8MxIAFh2KI
X-Received: by 2002:a05:622a:10f:b0:2e0:29ea:5ea1 with SMTP id u15-20020a05622a010f00b002e029ea5ea1mr17369027qtw.670.1646416657963;
        Fri, 04 Mar 2022 09:57:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2slB1WylOTfmCeyNXB6K/C1/iolQ2BjblKShvNG181vdE7kmfpPTvuRDGAo0mjVyyeKLc7g==
X-Received: by 2002:a05:622a:10f:b0:2e0:29ea:5ea1 with SMTP id u15-20020a05622a010f00b002e029ea5ea1mr17369012qtw.670.1646416657727;
        Fri, 04 Mar 2022 09:57:37 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b83-20020a376756000000b005f191ae430fsm2774671qkc.128.2022.03.04.09.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 09:57:37 -0800 (PST)
Date:   Fri, 4 Mar 2022 09:57:33 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 22/39] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <20220304175733.zoik2fqpizygnlq7@treble>
References: <20220303112321.422525803@infradead.org>
 <20220303112826.299051388@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303112826.299051388@infradead.org>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 12:23:43PM +0100, Peter Zijlstra wrote:
> +bool ibt_selftest(void)
> +{
> +	unsigned long ret;
> +
> +	asm ("	lea ibt_selftest_ip(%%rip), %%rax\n\t"
> +	     ANNOTATE_RETPOLINE_SAFE
> +	     "	jmp *%%rax\n\t"
> +	     ASM_REACHABLE
> +	     ANNOTATE_NOENDBR
> +	     "ibt_selftest_ip: nop\n\t"

Maybe pedantic, but I find the annotations to be less surprising if they
come after the label:

	"ibt_selftest_ip:\n\t"
	ASM_REACHABLE
	ANNOTATE_NOENDBR
	"nop\n\t"

-- 
Josh

