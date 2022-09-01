Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20235A99F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiIAOU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiIAOUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:20:20 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F201FCE6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:20:18 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 199so17547859pfz.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Q2Ofo8rL2bQrHNNdviVqLO3SVxDf2pObIlZp4yq3bFQ=;
        b=rKB9mBUWsFPRqwwSv3Nb052gfqCZ5YLhGYJnZFZ6gi05xno2ehdL5MOM5owNgs11n9
         xpJXlLIM9Zvrl+OHU8k3+5IRXwGARNfHezHEcqJYJ4UdWH5/MnEeygV0FHjy6ks521hV
         mkIW3WDG37fTZEVnq+bmcnzErFFZbZXKttAi13jSd5RCb0KhTjkV8ymc4EKkusSxFZMy
         xMLEcsWQXFxaXycu3QlAFbJoknS/3afk8ngd+rr3gLVT9jstDy8sRfqvG+LN/cQ+BIbr
         VyOYFdgb8rzw8HWilIw/xlhAcVKlOSwFt0O66N67RysNwMKkA5SZuP/U/ZeNsR0u44Ok
         lKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Q2Ofo8rL2bQrHNNdviVqLO3SVxDf2pObIlZp4yq3bFQ=;
        b=CDN9ds3sehvqRyyPwdKhWcL5bLc2l+jw1kEO1chIx7lCqxZhNIIWigLnJb9vlGZh4r
         q7mIrN/ij7NUKd9iyIcXhri3z8YxfUvOgm9LdqjRoiSuDzalmHlvuzYFTgJSQGfgFfis
         z+KxnAByyiUNMwRkVdcACIsZRHlU7M4zljn20UzMK32JFFczRzXoATfPKSSBgLWibcPN
         +3PfF58QWnaO4zGOOGJCNpmvtQypDUAzvMUgZggnhp1SVQ6v3C2x2NKSWYsZvtO/lhog
         LVnHbhbcSxhU0BI63u6JFcWiIO1gN8crl77iaHeOiiSToxJwX34DL9W1YgwvgfmvsqKD
         Y0GQ==
X-Gm-Message-State: ACgBeo2JhtAb8cUEvD3BDdMvQjcwWFJy/KOu5KeC+wSAqHcaszzEt0Rp
        JmvjjdXNvnDUoUQmwz/aI7DE+w==
X-Google-Smtp-Source: AA6agR7ibgKpIOWvO7y5u/5wbqEGo3xWz7msRh+zozn2gD7CiFKNZHwNOnJaX2ZpKXEQovR8qI1F4A==
X-Received: by 2002:a63:1e61:0:b0:41c:45d:7d50 with SMTP id p33-20020a631e61000000b0041c045d7d50mr25551190pgm.507.1662042017270;
        Thu, 01 Sep 2022 07:20:17 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b001730a1af0fbsm14062008pln.23.2022.09.01.07.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:20:16 -0700 (PDT)
Date:   Thu, 1 Sep 2022 14:20:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org, like.xu.linux@gmail.com,
        kan.liang@linux.intel.com, wei.w.wang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] KVM: VMX: Support passthrough of architectural LBRs
Message-ID: <YxC/nN7k8gapMhzN@google.com>
References: <20220831223438.413090-1-weijiang.yang@intel.com>
 <20220831223438.413090-8-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831223438.413090-8-weijiang.yang@intel.com>
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

On Wed, Aug 31, 2022, Yang Weijiang wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> MSR_ARCH_LBR_* can be pointed to by records->from, records->to and
> records->info, so list them in is_valid_passthrough_msr.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

As the person sending the patches, these need your SOB.
