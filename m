Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF475A5B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 07:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiH3FfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 01:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiH3Fe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 01:34:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D866063D4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 22:34:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y127so10312518pfy.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 22:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=dKOrthFlbnjVeVQ0rS6buD4uV0A0EXEatsTMiU6XtaU=;
        b=EneG2w1Rcvj9QqHKY9/WFAkOkqscs399/+OHsJihdU0gM711Fy51V2lIJOUqY1bJL8
         aC1tUuR0gPSudQYrVS1g4BLoHJ+9bwIImBD+YbIyMwb2+pJkDxO+AvmJDJ05wJuC/KQ9
         cpHmRczVotV13YofM7deeawyMFKPJV02RKbBnHT7f3DaaDYAkDObQVUVjhOuLNLU6bK0
         loZ7wI4r3JXwCeFKYjT5klWVyEjFsm+tW+cdIRQV7/LJxRWIYj9G6P9oO+CETCYr0jD/
         pHI4wILpEzZ4gdnbWht/009nPCxmsuSsuN+QOKg0tEcjmdOE3g9t0j0/Ec7TEeFVmqZ0
         KqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dKOrthFlbnjVeVQ0rS6buD4uV0A0EXEatsTMiU6XtaU=;
        b=e6cwt47gJk06WjaBEvomFmw1ZZZke4/Va+0QTgzrs6wb1rQYuiISbW3DwdAXG4s1x0
         04qnzg1rfvqFwyPFPSbIYvKNwP4eDk8GSZ79cyjWHFXmgkpZhtIJKF1NLZgvtb1O+lJo
         RN4e65l/tP/dESJYeGffjKXX0IktnncqPlWCwvAJPjq1FVQxSTMLYo80Mn6+tOwrJHOQ
         +JwbJxmCKlMOhuA3K0oe+XQotQImrtAi4R8VXquccC8tBcRQjllotfyTFRpdhOkOerFl
         xkIw3sp31ocy4YcVbGhyRG6pSkdFMbJStAKkGI4Vun9WB01K/2zHCv2NtO5DEn+jImAZ
         w9jA==
X-Gm-Message-State: ACgBeo16nZnUDRdQSDSFuinb3AV9HNlV43U2r3EYIllX+YwNiLLTrdCq
        tF6WrxBYVeyugyL/A2J3Py2xYA==
X-Google-Smtp-Source: AA6agR7zW+i/d3NgK1mLET1x2R6V+hN2k+oA6fEFb9KkRNj8mpWXIajmR0Fou52TH6/Ak4p1W+Qh8Q==
X-Received: by 2002:a63:fb4f:0:b0:42c:a1:43b4 with SMTP id w15-20020a63fb4f000000b0042c00a143b4mr7543916pgj.140.1661837695263;
        Mon, 29 Aug 2022 22:34:55 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ce8c00b001749acb167csm4784285plg.27.2022.08.29.22.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 22:34:54 -0700 (PDT)
Date:   Tue, 30 Aug 2022 05:34:51 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@redhat.com, lpivarc@redhat.com
Subject: Re: [PATCH] vfio/type1: Unpin zero pages
Message-ID: <Yw2heyQmvPgBe6f9@google.com>
References: <166182871735.3518559.8884121293045337358.stgit@omen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166182871735.3518559.8884121293045337358.stgit@omen>
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022, Alex Williamson wrote:
> There's currently a reference count leak on the zero page.  We increment
> the reference via pin_user_pages_remote(), but the page is later handled
> as an invalid/reserved page, therefore it's not accounted against the
> user and not unpinned by our put_pfn().

Heh, kvm_pfn_to_refcounted_page() all over again.  is_zone_device_page() is the
other known case where a PageReserved page is refcounted.  But as KVM's comment
calls out, KVM's list was built through trial and error.
