Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C8C584555
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiG1SGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiG1SGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:06:37 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA9352E64
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:06:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso6032276pjo.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=QmamTPJn34eKWOCAe6RkQXqcNYOAiS0ZT4CRPFO2XpU=;
        b=PE4+QVfC/OzOHLmqIQGNYjXtmPqO6O5/rEOtyMWuF/0sbAXwtFKVrvWWXf2s2X+Qzt
         6qlqJLpsHo8lDAxOMdZYx7s2o6Q2LgJe3aZ5GSQPk+x2gtOTUQHuCkPtddCoNLCC54nR
         rw/QR1Q8LPYHHvLKZNkbsmYLvdgxXeTWAjnvyac8JtqEhtb/wbg52kuyXGeJjkwQ4fUx
         vf8kjIBnSypJUmampQKez8NNaQm3OmIcNsg4HvNs999ZRH/dRmZD3mdJ3KMD4Mtx3mNJ
         j8gUbLlXnYiHBNFQ8N/d1g3+l485O+B3ybDaw1+wx0mPjXSkSdSL1aOmI69se5eLIr7c
         bKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=QmamTPJn34eKWOCAe6RkQXqcNYOAiS0ZT4CRPFO2XpU=;
        b=x/9gaL5kehtmmNhQJi9wdYP+AHjdqvYrm6fO4WhCXigc8g2oi/GU0Dky9VZhOis0I2
         9I9Aszc1Wq8ArGMZJBBZ6tV3Oh2xCHjXP789TPkaNepj540en2QTOZvYpOPpdov+FxSg
         CRLMwOWKuWAGuNnxkpNHjHGeg3Vje5I5CtRuRSDkDLLMyCzZ0nNxCbBWFnGzf7Sxcj23
         vZyQ+ZLYq/cacnaVvBNpybahrz++P7hnjvCdlCP3s+h1mPIjqC5InYc0KQunb5sO9ohN
         /dYEo/UY2qYu0W0mk7QW6M/b7upK3Gys00daZlCAZE2UzPdVPMcdBXI1Mciv9vUf7tFM
         IKew==
X-Gm-Message-State: ACgBeo26xHNhXGdMuGvATYj8JpOmj+8mXz3UqBJ4t0W9MvjhSZFiOM7Z
        GxUoiyk+/gzoHXc1FToVQT3fGQ==
X-Google-Smtp-Source: AA6agR4XtUr/AoEJ1jnjG0r4xDPHWcY/X53JHyx0yk2bKcIR40Lwmd8emH5wPPk6kJQk1KXgqU34cg==
X-Received: by 2002:a17:903:2308:b0:16c:58a3:638e with SMTP id d8-20020a170903230800b0016c58a3638emr150079plh.100.1659031596580;
        Thu, 28 Jul 2022 11:06:36 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w71-20020a62824a000000b005252defb016sm1058929pfd.122.2022.07.28.11.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 11:06:35 -0700 (PDT)
Date:   Thu, 28 Jul 2022 18:06:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: Possible 5.19 regression for systems with 52-bit physical
 address support
Message-ID: <YuLQJ53QGDzHqFGc@google.com>
References: <20220728134430.ulykdplp6fxgkyiw@amd.com>
 <20220728135320.6u7rmejkuqhy4mhr@amd.com>
 <YuKjsuyM7+Gbr2nw@google.com>
 <20220728160613.uwewpxdqdygmqlqh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728160613.uwewpxdqdygmqlqh@amd.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022, Michael Roth wrote:
> On Thu, Jul 28, 2022 at 02:56:50PM +0000, Sean Christopherson wrote:
> > On Thu, Jul 28, 2022, Michael Roth wrote:
> > Speaking of which, what prevents hardware (firmware?) from configuring the C-bit
> > position to be bit 51 and thus preventing KVM from generating the reserved #NPF?
> 
> I'm not sure if there's a way to change this: the related PPR documents
> the CPUID 0x8000001F as read-only along with the expected value, but
> it's not documented as 'fixed' so maybe there is some way.
> 
> However in this case, just like with Milan the C-bit position actually
> already is 51, but since for guests we rely on the value from
> boot_cpu_data.x86_phys_bits, which is less than 51, any bits in-between
> can be used to generate the RSVD bit in the exit field.

Ya, I forgot to include the "and MAXPHYADDR >= 50" clause. 

> So more problematic would be if boot_cpu_data.x86_phys_bits could be set
> to 51+, in which case we would silently break SEV-ES/SNP in a similar
> manner. That should probably just print an error and disable SEV-ES,
> similar to what should be done if mmio_caching is disabled in KVM
> module.

This is the scenario I'm curious about.  It's mostly a future problem, so I guess
I'm just wondering if there's a plan for making things work if/when this collision
occurs.
