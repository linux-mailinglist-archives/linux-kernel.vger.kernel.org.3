Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880A1515532
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380532AbiD2UMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbiD2UMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:12:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21F998E1B8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651262954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=94a8sGRLCWduCHgjo1sU1o0PAADf7AEfjaAegT1GkVY=;
        b=Rq8/dUQNNisBOWGEat2fqkFY/oiRipkyZza+cDrxY3HSFJhrcW40xkA5WusP+k1twfU+LQ
        IYf251AWw7e6VUizbwUMiLcmjB4nU0g9wqbEqJwehl7tK+ud9wQgAUM8hhlu89j9wRwKHi
        oyGlIBvc4iGg5Ch/bkfmN/agSSbZUTM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-j_JlzSfhOraadi-MQcHVoA-1; Fri, 29 Apr 2022 16:09:10 -0400
X-MC-Unique: j_JlzSfhOraadi-MQcHVoA-1
Received: by mail-qt1-f200.google.com with SMTP id g20-20020ac87d14000000b002f393cf350cso2068306qtb.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=94a8sGRLCWduCHgjo1sU1o0PAADf7AEfjaAegT1GkVY=;
        b=HVel/tIRb4nCyXK62ZVz6WMutDz5f+k725lV49Gujvj85VSbTGTrKSWenc3kT09n4t
         1cCzOotAXZFvnh3jPNrOxqPqCWw8S3+Dw7QWlpRJ7DUQdw2+6i/qACexd63YvGx+WPX6
         lAcjHX6QvreVabjKWL66KKL9+SPMpnRxC+6Qd1+b4UmWe29o0rk5gKgFRZaZSMVXIF8S
         FjfP2ySQLY0vAtPpoiZ2/RpwOYs2eBCw3vVvbMOjD7FzSPuaDIyKvZ+tYH6xj0flfZnG
         Kd+wnGK644TXMQRnxEn+0obvox6iXdHzcHoTTOAEupXlRV2SeZABPFaw8mqIYgUFFWYR
         TevA==
X-Gm-Message-State: AOAM530LVe0+N7ZHrvy1KC6Tx8y4n9XcaDJiOY88CFUN1EUhFmVj2lYm
        I9kmppnR08MgyA5WkxU9myMPY3CqVVVnyshhG9zO0xLQNkVQbU6ueiJf9CKVZU98JBPBZ6FFwlC
        IekMNbyF916I83jVPEREpw6Au
X-Received: by 2002:a05:622a:34c:b0:2f3:94ee:b208 with SMTP id r12-20020a05622a034c00b002f394eeb208mr1033806qtw.132.1651262949998;
        Fri, 29 Apr 2022 13:09:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCVWUepBF/5vP2n4C2hA4tRLUq8hCupOc+/Qlv6mn0fUg0kxKZ2bvjnx8BTfugNgXoVKPi4w==
X-Received: by 2002:a05:622a:34c:b0:2f3:94ee:b208 with SMTP id r12-20020a05622a034c00b002f394eeb208mr1033783qtw.132.1651262949762;
        Fri, 29 Apr 2022 13:09:09 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id y62-20020a376441000000b0069fc13ce1ddsm79116qkb.14.2022.04.29.13.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 13:09:09 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:09:05 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, jthierry@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, masahiroy@kernel.org,
        ycote@redhat.com, herbert@gondor.apana.org.au,
        mark.rutland@arm.com, davem@davemloft.net, ardb@kernel.org,
        maz@kernel.org, tglx@linutronix.de, luc.vanoostenryck@gmail.com
Subject: Re: [RFC PATCH v4 25/37] arm64: bpf: Skip validation of
 ___bpf_prog_run
Message-ID: <20220429200905.yjwxorrkd4u5rdmn@treble>
References: <20220429094355.122389-1-chenzhongjin@huawei.com>
 <20220429094355.122389-26-chenzhongjin@huawei.com>
 <YmvIZG5Ke6vElb/e@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmvIZG5Ke6vElb/e@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:13:40PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 29, 2022 at 05:43:43PM +0800, Chen Zhongjin wrote:
> > There is a jump table encoded in ___bpf_prog_run and objtool-arm64
> > can't deal with it now. Skip validate it for arm64.
> 
> But, but, but, an earlier patch did -fno-jump-tables!

IIRC, -fno-jump-tables is specific to switch statements but this
function has a C-implemented jump table.

-- 
Josh

