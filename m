Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FC357A836
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237671AbiGSUbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiGSUbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:31:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99335071C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:31:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w7so574900plp.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=66lOoODJK8E+OBaGCxybOPnfHghyFR1wn5dp+ysHQ2o=;
        b=Ym9n0ZrSB1bTD6E6GT9WF4NK05xCS/Hs8NQ7w6dcppIMHX1dTKQLcKP1fLlk9SfpiB
         Nf+sueQuI4VabNfv91MRC69FaGhc77IlSGWIyJ/GtOj8TI4QPAE82NwYFaYcXBrnNv+1
         0t/vuk9iV3tZWYIueZF2FxNDwhkRbD+AgWvJmSLsCISZeNRWCHwNOMlXqFEuri9c5MI4
         DSNSPUx85JI2Lbr6WWUMfMStPewa/davVbaRVz3NXZ1n12AdqT8N9o0WLlu2ddCgJiX0
         VS7qnmtlikDjTxYpawPI+ghiJeNAVBwV840QVYjGlOez/ZYxV3VOGi+7ZlDvalmXqvB/
         9onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=66lOoODJK8E+OBaGCxybOPnfHghyFR1wn5dp+ysHQ2o=;
        b=STqnT3u4l6PaYomEo8bDqaXU4JSJ8+KiSKPj7wbgHCwoHnJC5IxZ0FZ4IJp+lxCHE5
         lZcRmJ4ORm9xU0PgFTZjFgzb5upZU1dFeC6TwbgCSnjqQ4OhS92314qZMtWl623YC0W2
         NXrwL8tB/qRMi+FRplA+1kYpTPFD7IiVd7wanee4rRsr4CWvC74NfV7yYZ18t/jgtDBV
         Rx6s4od3vmXEtiEs0KZdxbrgAiSvBoCfeavCXx96IXXOvuWM3Epvd1z3Z3IxGEsItG7+
         Q1aEoKeR0eaUMtyJceGP4G4NzqQcx3nceZV7FJi6FzgoIIKs2dRfcoYoV+kwYAAkFTqq
         2NLQ==
X-Gm-Message-State: AJIora9fcYDDo/7GTfcZj00FzQnaT4Rm+43N++GCIWjnydMq45PAjfwV
        /8UVvevG009eWGN8UctsdrjCuA==
X-Google-Smtp-Source: AGRyM1tspa78Llu6KSQWUFSducFa/Xip5dNasrYOi7hPrQXdasfvrDrRoR+BQPQsrQc87XI3XgJ0EQ==
X-Received: by 2002:a17:902:ccc4:b0:156:5d37:b42f with SMTP id z4-20020a170902ccc400b001565d37b42fmr34886845ple.157.1658262668176;
        Tue, 19 Jul 2022 13:31:08 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b0016a6caacaefsm12258717plg.103.2022.07.19.13.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:31:07 -0700 (PDT)
Date:   Tue, 19 Jul 2022 20:31:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH 08/12] KVM: X86/MMU: Remove the useless idx from struct
 kvm_mmu_pages
Message-ID: <YtcUiJtbWvKpq2B1@google.com>
References: <20220605064342.309219-1-jiangshanlai@gmail.com>
 <20220605064342.309219-9-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605064342.309219-9-jiangshanlai@gmail.com>
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

It's arguably not useless, e.g. it's still used for a sanity check.  Not sure
how to word that though.  Maybe?

  KVM: x86/mmu: Drop no-longer-necessary mmu_page_and_offset.idx

On Sun, Jun 05, 2022, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> The value is only set but never really used.

Please elaborate on why it's no longer truly used.  Something like:

  Drop mmu_page_and_offset.idx, it's no longer strictly necessary now that
  KVM doesn't recurse up the walk to clear unsync information in parents.
  The field is still used for a sanity check, but that sanity check will
  soon be made obsolete by further simplifying the gathering of unsync
  shadow pages
