Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A717E5A6F69
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiH3VqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiH3Vp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:45:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4447D1DB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:45:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so6148758pja.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=O2zB1FguvcyswgVT5RXbeo3OSAPmg+2rx/tGaJXYPlc=;
        b=k8VUxkITUHyE3xzYt9E2ojpj0DiW3LR5wF9kEzZE2cV8m5sGSJMWwO3Vn7gn4dxIM2
         pBgZZVcFnJqizUWehRVePGnyib369p7va8pCmE48FloWF9g6JALd4/ntsA/Gsg4UObf6
         2EJXmosQzXtUWuWTv2d2E7vPp0ePj5HoCw2tXhDq8IRJheRdttH7v94myHDTQ68GraY1
         QSdOL/Abu1KUPI5ZL/QYe2RuYv5MG370WL48hkFBZoo3kj0xg7VtrwOR5Sg5KIzk1Zxx
         YuKSwGBP6BWM3aTl3k/DJqWg00Fgyy19BVj7FvdoazaVqs9CpDOvjTn2QKiYNa3W5nOU
         5/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=O2zB1FguvcyswgVT5RXbeo3OSAPmg+2rx/tGaJXYPlc=;
        b=r2O3Ebc2Ebkpwg7fef77m01/u4YzD8uItIlRzxkFJsp6Yok1g6j1eh7HKb1BbxTwG3
         TarDBCApDN9YKRnFrOpZSD4gaojAVXg3EP2VC23FzFdjndENMuISnpenrAZuqxs9U9uS
         xZay4sVnU77a8yZiX10AbS6St1owDIDC+zBRx11jUyY9DnSRFJuntNyLE8/h5s7Mmg10
         T3c6baU3YNP5ueJGxcfTheM0QA8XPMsW81+k7CXEbP2C1F501KnFKxBlDahTMSEZsqJC
         fxvPuQnvj/nvYNed71bzP9xohMObuy2XsYvhanqXyJFDns3kMWFqXv8hvspGfhIey56S
         bjGg==
X-Gm-Message-State: ACgBeo0nvC8sH3ZPB1KJZFq1X0xD2GqqUxo6ZSQOn4esEwMZyAhJb38t
        j900ye3HCuU2IP0Zl7EbDMnCD2cLWKFsSg==
X-Google-Smtp-Source: AA6agR6+XX5WDETC0Bl5GdML4cuTVELroc5YLIwUsDjL0q76bnA+FNwNrJrIryY88PkZZLzMEYIZnA==
X-Received: by 2002:a17:902:8ec6:b0:172:dc2c:306d with SMTP id x6-20020a1709028ec600b00172dc2c306dmr23361589plo.104.1661895954813;
        Tue, 30 Aug 2022 14:45:54 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i63-20020a636d42000000b0041c0c9c0072sm1993019pgc.64.2022.08.30.14.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:45:54 -0700 (PDT)
Date:   Tue, 30 Aug 2022 21:45:51 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, jmattson@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Fix mce_banks memory leak on mci_ctl2_banks
 allocation failure
Message-ID: <Yw6FD867fK2Blf1G@google.com>
References: <20220819182258.588335-1-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819182258.588335-1-vipinsh@google.com>
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

On Fri, Aug 19, 2022, Vipin Sharma wrote:
> If mci_ctl2_banks allocation fails, kvm goes to fail_free_pio_data and
> forgets about freeing mce_banks memory causing memory leak.
> 
> Individually check memory allocation status and free memory in the correct
> order.
> 
> Fixes: 281b52780b57 ("KVM: x86: Add emulation for MSR_IA32_MCx_CTL2 MSRs.")
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---

Pushed to branch `for_paolo/6.1` at:

    https://github.com/sean-jc/linux.git

Unless you hear otherwise, it will make its way to kvm/queue "soon".

Note, the commit IDs are not guaranteed to be stable.
