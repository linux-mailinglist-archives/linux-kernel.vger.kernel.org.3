Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7004FC81E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 01:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbiDKXfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiDKXfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:35:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEEFB1E0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:33:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so821153pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h4EBQ5KtFlqne/7MW5/+slVo7rGBhDrSQX6gK0Dbmfw=;
        b=OFG0b8pqdu8n5sNFdpHS3laQvJ0s5Iqib3uiDEjYGeKkJW3Rc4FXt81gaRg5aU50eO
         2PGcGQwd1nMQn0L6xNx9SH5wQGgC2FxPGEmxoAX9jLa5CXcAQdo1g4nnE+74K70L0Cbp
         PbE+DJEd8QyEmtxB7UoLeDe8GqziUfcNd8r6VDsd2qeA+dXOqyZ8DtlCeaXSq7GlzR7s
         ZFwVXTJ8vDhx9buZ/RQ7bnpHzl7+D7l0rW0MbV0/++2/WqrljUjimReAo1mP+ueguVvv
         EWiLUHu+C6i/SQb7oHQj8WDimM1Ae7F3e4V6+KyBNG1B0/gcVVdTIX/CSQffp/Uh30uA
         zNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h4EBQ5KtFlqne/7MW5/+slVo7rGBhDrSQX6gK0Dbmfw=;
        b=pBsPHkfa6m6OYXLnRZ7JznUl6tltKNuefIqs6fLiNoZ9Qwkz02AoF7Fn6SJKVTdzIF
         yCmqPKcXQnfs4U72Q8a1WLxueUg5CuRojMhuFLY4YkAGEQ0u0g/BYAlDc1DSctCQZSkZ
         Rffv9JXZL8pyMXh8D6s1eZXpJIy1BUYl2fMh/Cjyz8LLxTFpDwhz6wjXEZyjco4QLFFi
         S38vaK7CYMMArR4s93q+AlLbTKlls/qtEla6/7BH0GVMIYycGV2kr+TjVcwIgSFIb5Bn
         XoTvyrWU82IpHc7B3Ks0M1YE8OZMZEwrKKssVwuuU3IbJuxsw0NypzLNZQrEPdA56V0p
         ysJA==
X-Gm-Message-State: AOAM530qgJ15QKBUUM7iwF9ZGrbev3tEovcAdN2PCVpp6mrs3vkeR9zH
        fEkXa5NeCPVfsR/QQg6IHZlErMI6po7Jtw==
X-Google-Smtp-Source: ABdhPJxUb72VQrc6Q0tLG6gjaQ0T0BQktbFzQoM/KU0RsnoNeCoGqQE3D36+K/Szo0GXCy1VSn3BJw==
X-Received: by 2002:a17:902:e791:b0:151:dbbd:aeae with SMTP id cp17-20020a170902e79100b00151dbbdaeaemr35004697plb.171.1649720004721;
        Mon, 11 Apr 2022 16:33:24 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id my18-20020a17090b4c9200b001c75aeac7fdsm531954pjb.27.2022.04.11.16.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 16:33:24 -0700 (PDT)
Date:   Mon, 11 Apr 2022 23:33:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH v2 7/9] KVM: x86/mmu: Add try_get_mt_mask to x86_ops
Message-ID: <YlS6wG5szNPPEFcs@google.com>
References: <20220321224358.1305530-1-bgardon@google.com>
 <20220321224358.1305530-8-bgardon@google.com>
 <YlSzI9ZfzPQZhPqj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlSzI9ZfzPQZhPqj@google.com>
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

On Mon, Apr 11, 2022, Sean Christopherson wrote:
> And as a bonus, if we use 0/-errno, then we can use KVM_X86_OP_OPTIONAL_RET0()
> and SVM doesn't need to provide an implementation.

Gah, got ahead of myself.  If we go this route, the caller would need to ensure
it initializes mt_mask.  Probabably not worth it, so scratch that idea.  I also
though about overloading the return type, e.g.

	mt_mask = ...
	if (mt_mask < 0)
		return false;

But again, probably not a net positive.
