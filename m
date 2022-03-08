Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E180A4D1E4F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348712AbiCHRQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348703AbiCHRQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:16:43 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9E9532CD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:15:46 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so3015120pju.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 09:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hkyn/vGlcppYdspp9RKzcQ3UD3ptvOdy4abrHzmJQ4c=;
        b=NaxBH/garo7tXqwcDzW8xg9cwt7C718vSZwUlAT5Uh/PPawICrZPCXg3FOCZztFI/y
         UAb24xDqEzXo2QMZbM9qoaqQG24d0tNiFMmoyjYzUJA9JBT6Ojwvp4zmVAdLqL9juIXz
         XIbTo6UD0t8glSuD6fOgKwtVOFofW8Xbv+LGmBmAUaHbyUU20p6BO0neo1qOaJV+Ag4b
         3XvkKiqmYJN0csaknR9dfI/2PwOi9/6Z52ZKQS3IxXIkzwpkePqFtnOjVM7vrQTp44AU
         t8wd6BVBeQnlaQK7J4Qp3R42JOf4I2eDhqSa1t4XKdgSlGk9nerAui8RBJbR0KlwOPf6
         hcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hkyn/vGlcppYdspp9RKzcQ3UD3ptvOdy4abrHzmJQ4c=;
        b=Q3Joqp9gQfGPq7Ow9MkYr+B0AywEX7OaxqAJzdo2JHlh5tzNn6pTJEhieNAx6vWSQF
         ZjGiZoOu1IeXYNZ0XeZx4//IlhJUZX3ONsEZY+OK5DZ1cEKVIcJP8/2XUIoCU7NH2XpZ
         aTRAWPiD3el2dYl8YA6/fMkYDz7rNyvkcSVQkXH1oUhANcJesE1MYqacr7X8KIf8HnUR
         zHzh8cNsZ2O81IB/V2rMx5JsJ9AzppNUFC+oyof9tlUKTvqf4Fn43Dla/Vm7m8mN2NEg
         EI3QEKgkHJtijdvqOKEnMfuEhL283uV3rpG7o1LR0cbS6HhYomyb8F5d35+cW5oA1c/Z
         fdZg==
X-Gm-Message-State: AOAM531NzGuZBZ/uD/1yh4LA2jse5ki8uWRHughskPBX3RSMfabpBwD2
        Dc+hvOHqCJxk0GfHAnTlb70UQGJIn327CA==
X-Google-Smtp-Source: ABdhPJwRVXiFKAq3QxXoWfu61BFBFCXR1VvO6KSAO/0RCVrRwZN7zWSGikIg/y9dmxbwUgugaoOzbg==
X-Received: by 2002:a17:903:248:b0:14f:139f:191f with SMTP id j8-20020a170903024800b0014f139f191fmr18269276plh.71.1646759745558;
        Tue, 08 Mar 2022 09:15:45 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v23-20020a17090a521700b001bbfc181c93sm3383375pjh.19.2022.03.08.09.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:15:44 -0800 (PST)
Date:   Tue, 8 Mar 2022 17:15:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
Subject: Re: [PATCH v2 07/25] KVM: x86/mmu: remove "bool base_only" arguments
Message-ID: <YiePPQzw2Ak8O/cf@google.com>
References: <20220221162243.683208-1-pbonzini@redhat.com>
 <20220221162243.683208-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221162243.683208-8-pbonzini@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022, Paolo Bonzini wrote:
> The argument is always false now that kvm_mmu_calc_root_page_role has
> been removed.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
