Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59794627D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhK2XL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhK2XLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:11:38 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F41C0698D6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 14:31:16 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so16747179pja.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 14:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9AvBVjsUrHA5ojRZLyc3LkomsSMZcJ46+mIK8nRuC78=;
        b=CjshS9PnnLSdv2AK/suTdsJ4choCpPz/1eqxVn8V5C64WtDEK+OxYTQtzf2KARNDYs
         COUtacor2im7nKgw9GQ3xfaFd0SrSZISdHKBGeAlonlWrKqPYbmrSfjoNR8ILpdMcTw0
         CVW49Qi4Q5EkUat8G30wzGWaufKxPT4Ho9eRItfqBN1waMkAOk/UBxrCpXSg03MQuf0m
         zbRQ0OmIHWSbba4lWZggFAGOxpNwdFACeHn+aNiIsFIpAh7bkLUNhtFU48WC+3IrTRf6
         EEvW+oTZ2uXDmjZG49BDYSKcNcOZoYYJBBO1AbEV9ZBGIFEb7NNyOnkNwWS54JLnGmz7
         9bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9AvBVjsUrHA5ojRZLyc3LkomsSMZcJ46+mIK8nRuC78=;
        b=FbuGR6+O5LXCdxMGChv7KV62cJeF7KKZnY8/d32aMDD5HBQQ9M+4ik+SFtqbFMOkC2
         rMldck+RaVZ5C17luSgXSLM5muPX/YX4E0thLZZYR6CKOoComyoMZn4KscPpHjG1XpBq
         ZaweAyyomUaKB53Hm9ZSrR2u/jQup0fTBIf1zGnyDHuXejfP0lDKNZqlTjtVNdCkNJto
         +drlFk9KC+48xj4RC5uxtbQGnr3GVPR7FC+HIHk/6Af9xnJHq5APuHDaT29KzsYxWMP0
         PovtpJKN8dY1F9x+EBy+1umRJVcj9QlqTzHL8OsQw2l32YcjugP5K92XqggZ2QNNcWW+
         uojQ==
X-Gm-Message-State: AOAM531P2wc/UY29i4NyOP+x+uqp1Fy5bhJcoiVUNJnqiPlFgjkCGsWX
        pF1+YhOjbQdkdXce08HoIs+5PQ==
X-Google-Smtp-Source: ABdhPJzF7uWEEj8d7BByxoVl2ngezip9hrJFXj3YT6xDYrOeUi4flFODdMBcQJRImPXrl/BcTlaGKg==
X-Received: by 2002:a17:90b:4b48:: with SMTP id mi8mr1120100pjb.214.1638225076325;
        Mon, 29 Nov 2021 14:31:16 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id c2sm19188610pfv.112.2021.11.29.14.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:31:15 -0800 (PST)
Date:   Mon, 29 Nov 2021 22:31:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pgonda@google.com
Subject: Re: [PATCH 11/12] KVM: SEV: do not take kvm->lock when destroying
Message-ID: <YaVUsB4qBdhBlL6O@google.com>
References: <20211123005036.2954379-1-pbonzini@redhat.com>
 <20211123005036.2954379-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123005036.2954379-12-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021, Paolo Bonzini wrote:
> Taking the lock is useless since there are no other references,
> and there are already accesses (e.g. to sev->enc_context_owner)
> that do not take it.  So get rid of it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
