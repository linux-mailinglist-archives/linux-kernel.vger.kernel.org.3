Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76D0549D36
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245016AbiFMTQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244090AbiFMTPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:15:17 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C973856769
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:30:35 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso6664066pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wKqpDyJggm7b0f9UQvkgztMJ+TPUivgjBn1axRErEvQ=;
        b=Qo1PAJdWEUTItUEqm09BhFPEhRGkluSKUjuSCMR8Oh/YdeKgdkNSJFPdNgcZcSYdct
         YgsNaprlJ0qtSX/OnLKZfU923a8Daly/cmvERPvrQ78MjasSbw3FKBYl7hiFlmp8sdqf
         qpLeaDQ9V7ZLqWgZPVbSJhxfaVtpebdqLTGNSfXpEcBwcGQAl57IuVX2/57HYlBKzJcW
         F5jaUrwxHBpehJXWjJWqzqewd9ht+nBf5mJteCtAxWo0vAJzGkggV2K8klQEwt7JvUeT
         jP+gXghpKDbbePakRiXK1e8V5BUdOjyuDasvHi841XNIFjiNjZY+cTTyrFNQnu/WAIAs
         hkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wKqpDyJggm7b0f9UQvkgztMJ+TPUivgjBn1axRErEvQ=;
        b=AtShw++JXP+aQvIatHtFnRqmZPQ6j/Ar+DiYG6zQs4WMRGO0rh5dEVp03MTmNbqX9H
         CfdqybjIQxh2U9z+xPal2jGaH9XCtEIX7qZX0zJAbPuoAx1P/CVgHZ9cZBsNq6j6qeA1
         zB+xj0XlGZlaM9gTFV+CInA80StTWrgILPymgFgUuHkfga/lf184lC3HLbfvLMzVcq3F
         85eiwSZzmMw1O7emcVYHtr8IxONbMhTva3r35cGLlU4L3ucqFX5+BXy1wt/wyGXqslEH
         OJUYqC0D+wAscD37bvQ5EL+0u5iVI3INo35Zl8e4QY3EqXFgMokWrtpqQj+FRqeF/9Yx
         1hvw==
X-Gm-Message-State: AJIora+OGCENNS+AMmaz3CSMOu+S86RF/mF650gQwXRP5R8EhqKC5fsO
        rBKQoCerZGrjmZBls8LfImI=
X-Google-Smtp-Source: AGRyM1s8yGZUU+XxoyDpuDsvvN3kmuzm3vvwQE4B03t8rzFiPLfQ52FnP2QC3qWu6V/HIhy9UmSjlA==
X-Received: by 2002:a17:902:7792:b0:168:d1fd:3013 with SMTP id o18-20020a170902779200b00168d1fd3013mr111116pll.29.1655141434698;
        Mon, 13 Jun 2022 10:30:34 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090301c300b0016196bd15f4sm5397253plh.15.2022.06.13.10.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:30:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Jun 2022 07:30:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/4] kernfs: make ->attr.open RCU protected.
Message-ID: <Yqd0OJupifpplENB@slm.duckdns.org>
References: <20220602063907.136569-1-imran.f.khan@oracle.com>
 <20220602063907.136569-2-imran.f.khan@oracle.com>
 <YqYpTShTDLvAp4vx@slm.duckdns.org>
 <6d1c5a49-fc16-5fc7-e527-8cb91ec0d25c@oracle.com>
 <YqalHuEB6OjjUosV@slm.duckdns.org>
 <c8a8a616-da4c-f2ce-0bb2-e0cba69db24d@oracle.com>
 <Yqaqbas1JaWz25jB@slm.duckdns.org>
 <61868aa1-6c88-ecd2-beb2-67b87673b805@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61868aa1-6c88-ecd2-beb2-67b87673b805@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 01:56:43PM +1000, Imran Khan wrote:
> Agree. I did over think this and went for the safest interface that I could
> think of in each of the use cases. I will remove
> kernfs_check_open_node_protected and use kernfs_deref_open_node_protected in its
> place as well. This will cover all accesses under kernfs_open_file_mutex.
> 
> But we will still need kernfs_deref_open_node for cases where
> !list_empty(&of->list) ensures safe access of ->attr.open and where we can't
> ensure holding of kernfs_open_file_mutex. So we will need 2 deref accessors.
> Right? Just asking this because you mentioned above to come up with one deref
> accessor that can be used in all three use cases
> 
> Please let me if this sounds okay. I can send updated patch-set with these
> changes in place.

Just merge all three into one accessor. You can list both the !list_empty
condition and lock held conditions on the same rcu_dereference_check() call.

Thanks.

-- 
tejun
