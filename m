Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B39359FEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbiHXPna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbiHXPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:42:59 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F406F9BB69
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:41:57 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id w13so10286361pgq.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=1prRi8IvFsf3xlNKbjLDKEdeYxVI3zsAKuSEuLmreYg=;
        b=OAjoK2tj6wUtBPSHxqaBNfG3oi6yIn8K7/N3PzSyFG3gG0c8LZGgTtzm0soqlRWKyY
         LSVJ0N1zcfTQvhx7F1dWGBaBwn73cy4etJNHybLblA7AL9rQGlvBxfJe4/wse3DDGm36
         OC5SGWGEw6ONLv07yHzDzBpa72Xf6YehDjMtnRqWZLgfSWg/OkEfDI0UpZD3Lzb32vND
         5bipEsGmBQ5MDyEeU0jJHDxVYMWqgiGRQ9CkU68quZYeCfP/ULLrHaYamT6/M1aVLJmM
         lga0iZy8cXRr1GVB0LSjmCQHqczZ/FA3Jhh4t46iz7kPHw04dIWH4qHa/DQl6wPWNTmk
         I6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1prRi8IvFsf3xlNKbjLDKEdeYxVI3zsAKuSEuLmreYg=;
        b=Eio6NfH+LUpkzv1ioHfgHCFhFA6T2dqBJd9LQR0dnaCBbNewwrrOkdMz+qYXUgQ8IT
         VzokN0wEJCm4k/oWLtOpYrTF48NkTbOxpP23y8OkTfXbyslsRoySnuAsCZIoJvrVO8aA
         PvU5yFVoOzgeF3vi+XLyZZIonXL4KQf9foev2eCzRMPYLdJmpUpCkYCjB4B07N+Is7+S
         MeXhbKhmDSiSFVOZmj4rMRt233dTKpr7OFXzLacHoAKehUWbyqRqoVpquCXRwWzFlI7O
         hFI6Zk5A+9KUr15yLq59bjMCtUzX8I0M4RBvLVkrNpajFfc/AzkxxJN4S3ROMWx1Ivti
         IMXQ==
X-Gm-Message-State: ACgBeo2JQ/aDOwFMa1j9U6QyF5l825yXQjF/E+1qtZz+MP0R1BCO4AzX
        BWBLNuF8SVEl/BUIeZq/oxJjoA==
X-Google-Smtp-Source: AA6agR5z2VCrs4Venit4r8EaiRKC7PZCiqEkQAd35VKK9dqRELEoJxmQSJBIGbpbXDhDEdGwCgDYag==
X-Received: by 2002:a62:e50a:0:b0:537:1eae:1268 with SMTP id n10-20020a62e50a000000b005371eae1268mr5568538pff.16.1661355716394;
        Wed, 24 Aug 2022 08:41:56 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id h16-20020a170902f55000b00172ad292b6bsm4241112plf.116.2022.08.24.08.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 08:41:55 -0700 (PDT)
Date:   Wed, 24 Aug 2022 15:41:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: fix memoryleak in kvm_init()
Message-ID: <YwZGwInBkpgUYRIL@google.com>
References: <20220823063414.59778-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823063414.59778-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022, Miaohe Lin wrote:
> When alloc_cpumask_var_node() fails for a certain cpu, there might be some
> allocated cpumasks for percpu cpu_kick_mask. We should free these cpumasks
> or memoryleak will occur.
> 
> Fixes: baff59ccdc65 ("KVM: Pre-allocate cpumasks for kvm_make_all_cpus_request_except()")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
